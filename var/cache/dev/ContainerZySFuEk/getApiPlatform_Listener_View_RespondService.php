<?php

use Symfony\Component\DependencyInjection\Argument\RewindableGenerator;
use Symfony\Component\DependencyInjection\Exception\RuntimeException;

// This file has been auto-generated by the Symfony Dependency Injection Component for internal use.
// Returns the private 'api_platform.listener.view.respond' shared service.

include_once $this->targetDirs[3].'\\vendor\\api-platform\\core\\src\\EventListener\\RespondListener.php';

return $this->privates['api_platform.listener.view.respond'] = new \ApiPlatform\Core\EventListener\RespondListener();
