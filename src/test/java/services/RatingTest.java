package services;


import javax.transaction.Transactional;
import javax.validation.ConstraintViolationException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.util.Assert;

import domain.Rating;
import domain.User;
import utilities.AbstractTest;
import utilities.UtilTest;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/junit.xml" })
@Transactional
@TransactionConfiguration(defaultRollback = true)
public class RatingTest extends AbstractTest {
	
	// Service to test --------------------------------------------------------

	@Autowired
	private RatingService ratingService;

	// Supporting services ----------------------------------------------------
	
	@Autowired
	private UserService userService;
	
	// Test cases -------------------------------------------------------------
	
	
	/**
	 * @Test Create a rating
	 * @result The rating is registered and persisted into database
	 */
	@Test
	public void positiveCreateRating() {
		authenticate("user1");
		Pageable pageable = new PageRequest(1 - 1, 10);
		Rating rating;
		User principal = userService.findByPrincipal();
		User userConcerning = userService.findOne(UtilTest.getIdFromBeanName("user2"));
		
		Page<Rating> numberOfRatingsBefore = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		rating = ratingService.create(userConcerning.getId());
		rating.setComment("test");
		rating.setValue(0);
		rating = ratingService.save(rating);
		rating = ratingService.findOne(rating.getId());
		
		Page<Rating> numberOfRatings = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		Assert.isTrue(rating.getAuthor().equals(principal));
		Assert.isTrue(numberOfRatingsBefore.getNumberOfElements()+1 == numberOfRatings.getNumberOfElements());
		Assert.isTrue(rating.getComment().contains("test"));

		unauthenticate();
	}
	
	/**
	 * @Test Create a rating
	 * @result The rating is registered and persisted into database
	 */
	@Test
	public void positiveCreateRating2() {
		authenticate("user1");
		Rating rating;
		User principal = userService.findByPrincipal();
		User userConcerning = userService.findOne(UtilTest.getIdFromBeanName("user2"));
		
		int numberOfRatingsBefore = ratingService.countRatingCreatedByUserId(principal);
		
		rating = ratingService.create(userConcerning.getId());
		rating.setComment("test");
		rating.setValue(0);
		rating = ratingService.save(rating);
		rating = ratingService.findOne(rating.getId());
		
		int numberOfRatings = ratingService.countRatingCreatedByUserId(principal);
		
		Assert.isTrue(numberOfRatingsBefore+1 == numberOfRatings);

		unauthenticate();
	}
	
	/**
	 * @Test Create a rating
	 * @result The rating is not registered because don't have value and comment
	 */
	@Test(expected = ConstraintViolationException.class)
	public void negativeCreateRating() {
		authenticate("user1");
		Pageable pageable = new PageRequest(1 - 1, 10);
		Rating rating;
		User principal = userService.findByPrincipal();
		User userConcerning = userService.findOne(UtilTest.getIdFromBeanName("user2"));
		
		Page<Rating> numberOfRatingsBefore = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		rating = ratingService.create(userConcerning.getId());
		rating = ratingService.save(rating);
		
		Page<Rating> numberOfRatings = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		Assert.isTrue(rating.getAuthor().equals(principal));
		Assert.isTrue(numberOfRatingsBefore.getNumberOfElements()+1 == numberOfRatings.getNumberOfElements());

		unauthenticate();
	}
	
	
	/**
	 * @Test Create a rating
	 * @result The rating is not registered because his value is 10
	 */
	@Test(expected = IllegalArgumentException.class)
	public void negativeCreateRating2() {
		authenticate("user1");
		Pageable pageable = new PageRequest(1 - 1, 10);
		Rating rating;
		User principal = userService.findByPrincipal();
		User userConcerning = userService.findOne(UtilTest.getIdFromBeanName("user1"));
		
		Page<Rating> numberOfRatingsBefore = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		rating = ratingService.create(userConcerning.getId());
		rating.setComment("test");
		rating.setValue(10);
		rating = ratingService.save(rating);
		
		Page<Rating> numberOfRatings = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		Assert.isTrue(rating.getAuthor().equals(principal));
		Assert.isTrue(numberOfRatingsBefore.getNumberOfElements()+1 == numberOfRatings.getNumberOfElements());

		unauthenticate();
	}
	
	/**
	 * @Test Create a rating
	 * @result The rating is not registered because is addressed to the same user
	 */
	@Test(expected = IllegalArgumentException.class)
	public void negativeCreateRating3() {
		authenticate("user1");
		Pageable pageable = new PageRequest(1 - 1, 10);
		Rating rating;
		User principal = userService.findByPrincipal();
		User userConcerning = userService.findOne(UtilTest.getIdFromBeanName("user1"));
		
		Page<Rating> numberOfRatingsBefore = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		rating = ratingService.create(userConcerning.getId());
		rating.setComment("test");
		rating.setValue(0);
		rating = ratingService.save(rating);
		
		Page<Rating> numberOfRatings = ratingService.findAllByAuthorOrUser(principal.getId(), userConcerning.getId(), pageable);
		
		Assert.isTrue(rating.getAuthor().equals(principal));
		Assert.isTrue(numberOfRatingsBefore.getNumberOfElements()+1 == numberOfRatings.getNumberOfElements());

		unauthenticate();
	}
	
}
	