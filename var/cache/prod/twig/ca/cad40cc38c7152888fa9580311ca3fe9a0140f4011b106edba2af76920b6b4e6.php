<?php

/* @Framework/Form/container_attributes.html.php */
class __TwigTemplate_2dce4e5277de686fb80f3621a6b97f3b69af23ab63d0552da075a480862e2567 extends Twig_Template
{
    private $source;

    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<?php echo \$view['form']->block(\$form, 'widget_container_attributes') ?>
";
    }

    public function getTemplateName()
    {
        return "@Framework/Form/container_attributes.html.php";
    }

    public function getDebugInfo()
    {
        return array (  23 => 1,);
    }

    public function getSourceContext()
    {
        return new Twig_Source("", "@Framework/Form/container_attributes.html.php", "C:\\xampp\\htdocs\\api-backend\\vendor\\symfony\\framework-bundle\\Resources\\views\\Form\\container_attributes.html.php");
    }
}
