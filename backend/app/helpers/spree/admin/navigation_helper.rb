module Spree
  module Admin
    module NavigationHelper
      # Makes an admin navigation tab (<li> tag) that links to a routing resource under /admin.
      # The arguments should be a list of symbolized controller names that will cause this tab to
      # be highlighted, with the first being the name of the resouce to link (uses URL helpers).
      #
      # Option hash may follow. Valid options are
      #   * :label to override link text, otherwise based on the first resource name (translated)
      #   * :route to override automatically determining the default route
      #   * :match_path as an alternative way to control when the tab is active, /products would
      #     match /admin/products, /admin/products/5/variants etc.  Can be a String or a Regexp.
      #     Controller names are ignored if :match_path is provided.
      #
      # Example:
      #   # Link to /admin/orders, also highlight tab for ProductsController and ShipmentsController
      #   tab :orders, :products, :shipments
      def tab(*args)
        options = { label: args.first.to_s }

        # Return if resource is found and user is not allowed to :admin
        return '' if klass = klass_for(options[:label]) and cannot?(:admin, klass)

        if args.last.is_a?(Hash)
          options = options.merge(args.pop)
        end
        options[:route] ||=  "admin_#{args.first}"

        destination_url = options[:url] || spree.send("#{options[:route]}_path")
        titleized_label = Spree.t(options[:label], default: options[:label], scope: [:admin, :tab]).titleize

        css_classes = ['sidebar-menu-item']

        if options[:icon]
          link = link_to_with_icon(options[:icon], titleized_label, destination_url)
        else
          link = link_to(titleized_label, destination_url)
        end

        selected = if options[:match_path].is_a? Regexp
          request.fullpath =~ options[:match_path]
        elsif options[:match_path]
          request.fullpath.starts_with?("#{spree.admin_path}#{options[:match_path]}")
        else
          args.include?(controller.controller_name.to_sym)
        end
        css_classes << 'selected' if selected

        if options[:css_class]
          css_classes << options[:css_class]
        end
        content_tag('li', link, class: css_classes.join(' '))
      end

      # Single main menu item
      def main_menu_item text, url: nil, icon: nil
        link_to url, :'data-toggle' => "collapse", :'data-parent' => '#sidebar' do
<<<<<<< HEAD
          content_tag(:span, nil, class: "icon icon-#{icon}") +
          content_tag(:span, " #{text}", class: 'text') +
          content_tag(:span, nil, class: "icon icon-chevron-left pull-right")
=======
          content_tag(:span, nil, class: "glyphicon glyphicon-#{icon}") +
          content_tag(:span, " #{text}") +
          content_tag(:span, nil, class: "glyphicon glyphicon-chevron-left pull-right")
>>>>>>> Bootstrap initial refactor
        end
      end

      # Main menu tree menu
      def main_menu_tree text, icon: nil, sub_menu: nil, url: '#'
<<<<<<< HEAD
        content_tag :li, class: 'sidebar-menu-item' do
=======
        content_tag :li do
>>>>>>> Bootstrap initial refactor
          main_menu_item(text, url: url, icon: icon) +
          render(partial: "spree/admin/shared/sub_menu/#{sub_menu}")
        end
      end

      # sidebar are used on order edit, product edit, user overview etc.
      # this link is shown so a user can collapse the sidebar
      def collapse_sidebar_link
        content_tag :div, class: "collapse-sidebar" do
          link_to "javascript:;", class: "js-collapse-sidebar" do
            content_tag(:span, nil, class: "glyphicon glyphicon-chevron-right") +
            content_tag(:span, "Collapse sidebar", class: "text")
          end
        end
      end

      # the per_page_dropdown is used on index pages like orders, products, promotions etc.
      # this method generates the select_tag
      def per_page_dropdown
        # there is a config setting for admin_products_per_page, only for the orders page
        if @products && per_page_default = Spree::Config.admin_products_per_page
          per_page_options = []
          5.times do |amount|
            per_page_options << (amount + 1) * Spree::Config.admin_products_per_page
          end
        else
          per_page_default = 15
          per_page_options = %w{5 15 30 45 60}
        end

        select_tag(:per_page,
          options_for_select(per_page_options, params['per_page'] || per_page_default),
          { id: "js-per-page-select", class: "form-control pull-right" })
      end

      # finds class for a given symbol / string
      #
      # Example :
      # :products returns Spree::Product
      # :my_products returns MyProduct if MyProduct is defined
      # :my_products returns My::Product if My::Product is defined
      # if cannot constantize it returns nil
      # This will allow us to use cancan abilities on tab
      def klass_for(name)
        model_name = name.to_s

        ["Spree::#{model_name.classify}", model_name.classify, model_name.gsub('_', '/').classify].find do |t|
          t.safe_constantize
        end.try(:safe_constantize)
      end

      def link_to_clone(resource, options={})
<<<<<<< HEAD
        options[:data] = { action: 'clone' }
<<<<<<< HEAD
        options[:class] = "btn btn-primary btn-sm"
        link_to_with_icon('clone', Spree.t(:clone), clone_object_url(resource), options)
=======
        options[:class] = "btn btn-default btn-sm"
        link_to_with_icon('export', Spree.t(:clone), clone_object_url(resource), options)
>>>>>>> Bootstrap initial refactor
      end

      def link_to_new(resource)
        options[:data] = { action: 'new' }
        options[:class] = "btn btn-success btn-sm"
=======
        options[:data] = {:action => 'clone'}
        options[:class] = "btn btn-default btn-sm"
        link_to_with_icon('clone', Spree.t(:clone), clone_object_url(resource), options)
      end

      def link_to_new(resource)
        options[:data] = {:action => 'new'}
        options[:class] = "btn btn-default btn-sm"
>>>>>>> Backend on Bootstrap
        link_to_with_icon('plus', Spree.t(:new), edit_object_url(resource))
      end

      def link_to_edit(resource, options={})
        url = options[:url] || edit_object_url(resource)
<<<<<<< HEAD
        options[:data] = { action: 'edit' }
        options[:class] = "btn btn-primary btn-sm"
        link_to_with_icon('edit', Spree.t(:edit), url, options)
      end

      def link_to_edit_url(url, options={})
        options[:data] = { action: 'edit' }
        options[:class] = "btn btn-primary btn-sm"
        link_to_with_icon('edit', Spree.t(:edit), url, options)
=======
        options[:data] = {:action => 'edit'}
        options[:class] = "btn btn-default btn-sm"
        link_to_with_icon('pencil', Spree.t(:edit), url, options)
      end

      def link_to_edit_url(url, options={})
        options[:data] = {:action => 'edit'}
        options[:class] = "btn btn-default btn-sm"
        link_to_with_icon('pencil', Spree.t(:edit), url, options)
>>>>>>> Backend on Bootstrap
      end

      def link_to_delete(resource, options={})
        url = options[:url] || object_url(resource)
        name = options[:name] || Spree.t(:delete)
<<<<<<< HEAD
        options[:class] = "btn btn-danger btn-sm delete-resource"
        options[:data] = { confirm: Spree.t(:are_you_sure), action: 'remove' }
        link_to_with_icon 'trash', name, url, options
      end

      def link_to_with_icon(icon_name, text, url, options = {})
        options[:class] = (options[:class].to_s + " icon-link with-tip action-#{icon_name}").strip
=======
        options[:class] = "btn btn-default btn-sm delete-resource"
        options[:data] = { :confirm => Spree.t(:are_you_sure), :action => 'remove' }
        link_to_with_icon 'remove', name, url, options
      end

      def link_to_with_icon(icon_name, text, url, options = {})
        options[:class] = (options[:class].to_s + " icon_link with-tip").strip
>>>>>>> Backend on Bootstrap
        options[:class] += ' no-text' if options[:no_text]
        options[:title] = text if options[:no_text]
        text = options[:no_text] ? '' : raw("<span class='text'>#{text}</span>")
        options.delete(:no_text)
        if icon_name
<<<<<<< HEAD
<<<<<<< HEAD
          icon = content_tag(:span, '', class: "icon icon-#{icon_name}")
=======
          icon = content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}")
>>>>>>> Backend on Bootstrap
=======
          icon = content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}")
>>>>>>> Bootstrap initial refactor
          text.insert(0, icon + ' ')
        end
        link_to(text.html_safe, url, options)
      end

      def icon(icon_name)
        icon_name ? content_tag(:i, '', class: icon_name) : ''
      end

      def button(text, icon_name = nil, button_type = 'submit', options={})
        if icon_name
<<<<<<< HEAD
<<<<<<< HEAD
          icon = content_tag(:span, '', class: "icon icon-#{icon_name}")
=======
          icon = content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}")
>>>>>>> Bootstrap initial refactor
          text.insert(0, icon + ' ')
        end
        button_tag(text.html_safe, options.merge(type: button_type, class: "btn btn-primary #{options[:class]}"))
=======
          icon = content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}")
          text.insert(0, icon + ' ')
        end
        button_tag(text.html_safe, options.merge(:type => button_type, :class => "btn btn-primary #{options[:class]}"))
>>>>>>> Backend on Bootstrap
      end

      def button_link_to(text, url, html_options = {})
        if (html_options[:method] &&
            html_options[:method].to_s.downcase != 'get' &&
            !html_options[:remote])
          form_tag(url, method: html_options.delete(:method)) do
            button(text, html_options.delete(:icon), nil, html_options)
          end
        else
          if html_options['data-update'].nil? && html_options[:remote]
            object_name, action = url.split('/')[-2..-1]
            html_options['data-update'] = [action, object_name.singularize].join('_')
          end

          html_options.delete('data-update') unless html_options['data-update']

          html_options[:class]  = html_options[:class] ? "btn #{html_options[:class]}" : "btn btn-default"

          if html_options[:icon]
<<<<<<< HEAD
<<<<<<< HEAD
            icon = content_tag(:span, '', class: "icon icon-#{html_options[:icon]}")
=======
            icon = content_tag(:span, '', class: "glyphicon glyphicon-#{html_options[:icon]}")
>>>>>>> Backend on Bootstrap
=======
            icon = content_tag(:span, '', class: "glyphicon glyphicon-#{html_options[:icon]}")
>>>>>>> Bootstrap initial refactor
            text.insert(0, icon + ' ')
          end

          link_to(text.html_safe, url, html_options)
        end
      end

      def configurations_menu_item(link_text, url, description = '')
        %(<tr>
          <td>#{link_to(link_text, url)}</td>
          <td>#{description}</td>
        </tr>
        ).html_safe
      end

      def configurations_sidebar_menu_item(link_text, url, options = {})
        is_active = url.ends_with?(controller.controller_name) ||
                    url.ends_with?("#{controller.controller_name}/edit") ||
                    url.ends_with?("#{controller.controller_name.singularize}/edit")
        options.merge!(class: is_active ? 'active' : nil)
        content_tag(:li, options) do
          link_to(link_text, url)
        end
      end

      def main_part_classes
        if cookies['sidebar-minimized'] == 'true'
          return 'col-sm-12 col-md-12 sidebar-collapsed'
        else
          return 'col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2'
        end
      end

      def wrapper_classes
        if cookies['sidebar-minimized'] == 'true'
          return 'sidebar-minimized'
        end
      end
    end
  end
end
