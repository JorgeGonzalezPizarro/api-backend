<?php

use Symfony\Component\DependencyInjection\Argument\RewindableGenerator;
use Symfony\Component\DependencyInjection\Exception\RuntimeException;

// This file has been auto-generated by the Symfony Dependency Injection Component for internal use.
// Returns the private 'api_platform.validator' shared service.

include_once $this->targetDirs[3].'\\vendor\\api-platform\\core\\src\\Validator\\ValidatorInterface.php';
include_once $this->targetDirs[3].'\\vendor\\api-platform\\core\\src\\Bridge\\Symfony\\Validator\\Validator.php';

return $this->privates['api_platform.validator'] = new \ApiPlatform\Core\Bridge\Symfony\Validator\Validator(($this->services['validator'] ?? $this->getValidatorService()), $this);
