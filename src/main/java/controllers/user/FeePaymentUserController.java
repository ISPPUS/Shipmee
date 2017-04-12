package controllers.user;


import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.FeePayment;
import domain.RouteOffer;
import domain.form.FeePaymentForm;
import services.FeePaymentService;
import services.RouteService;
import services.form.FeePaymentFormService;

@Controller
@RequestMapping("/feepayment/user")
public class FeePaymentUserController extends AbstractController {
	
	// Services ---------------------------------------------------------------
	
	@Autowired
	private FeePaymentService feePaymentService;
	
	@Autowired
	private FeePaymentFormService feePaymentFormService;
	
	@Autowired
	private RouteService routeService;
	
	// Constructors -----------------------------------------------------------
	
	public FeePaymentUserController() {
		super();
	}

	// Listing ----------------------------------------------------------------
	
	/*@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView result;
		Collection<Vehicle> vehicles;
		
		vehicles = feePaymentService.findAllNotDeletedByUser();
		
		result = new ModelAndView("vehicle/list");
		result.addObject("vehicles", vehicles);

		return result;
	}*/

	// Creation ---------------------------------------------------------------

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create(@RequestParam int type, @RequestParam int id,
			@RequestParam (required=false) Integer sizePriceId, @RequestParam (required=false) Double amount,
			@RequestParam (required=false) String description) {
		
		ModelAndView result;
		FeePaymentForm feePaymentForm;

		feePaymentForm = feePaymentFormService.create(type, id, sizePriceId, 0, description);
		result = createEditModelAndView(feePaymentForm);

		return result;
	}

	// Edition ----------------------------------------------------------------

	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid FeePaymentForm feePaymentForm, BindingResult binding) {
		ModelAndView result;
		RouteOffer routeOffer;
		FeePayment feePayment = null;

		if (binding.hasErrors()) {
			result = createEditModelAndView(feePaymentForm);
		} else {
			try {
				
				/**
				 * Type == 1 -> Contract a route
				 * Type == 2 -> Create a routeOffer
				 * Type == 3 -> Accept a shipmentOffer
				 */
				switch (feePaymentForm.getType()) {
				case 1:
					
					routeOffer = routeService.contractRoute(feePaymentForm.getId(), feePaymentForm.getSizePriceId());
					feePaymentForm.setOfferId(routeOffer.getId());
					feePayment = feePaymentFormService.reconstruct(feePaymentForm);

					break;

				default:
					break;
				}
				
				feePaymentService.save(feePayment);
				
				result = new ModelAndView("redirect:list.do");
			} catch (Throwable oops) {
				result = createEditModelAndView(feePaymentForm, "feePayment.commit.error");				
			}
		}

		return result;
	}
	
	// Ancillary methods ------------------------------------------------------
	
	protected ModelAndView createEditModelAndView(FeePaymentForm feePaymentForm) {
		ModelAndView result;

		result = createEditModelAndView(feePaymentForm, null);
		
		return result;
	}	
	
	protected ModelAndView createEditModelAndView(FeePaymentForm feePaymentForm, String message) {
		ModelAndView result;
						
		result = new ModelAndView("feepayment/create");
		result.addObject("feePaymentForm", feePaymentForm);
		result.addObject("message", message);

		return result;
	}

}
