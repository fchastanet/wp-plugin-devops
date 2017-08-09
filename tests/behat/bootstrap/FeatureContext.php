<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\MinkExtension\Context\RawMinkContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawMinkContext implements Context
{
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

    /**
     * @Given I am on Google
     */
    public function iAmOnGoogle()
    {
        $this->visitPath( '/' );
    }

    /**
     * @When I search for :arg1
     */
    public function iSearchFor($arg1)
    {
        throw new PendingException();
    }

    /**
     * @Then The first heading should contain :arg1
     */
    public function theFirstHeadingShouldContain($arg1)
    {
        throw new PendingException();
    }
}