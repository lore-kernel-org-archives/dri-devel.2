Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A63C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07ED10E0C5;
	Tue,  8 Sep 2026 16:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Psd5Y1GH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AF510E0C5
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788884344; x=1820420344;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=XkR89vXS6/LVy4g7tgwtdkjBkk5zheuK4ErI+75id9I=;
 b=Psd5Y1GHBcZcGenPsF2iRphWPNyaY+uQTLoPjcavUN7ztjo56mDmGpDG
 WBWkEaCfC1AzNYxDOLL+RBQZKKMzX5l4EKp4U/oH5exYDIB6JbXk1zE+w
 dBdrC7ELKqSEhW0njWOgc9TDOvjcqZECVdNPGFHsq6lZQtlg9svNaq31x
 tyTJRMTmIgEhGFvO2OuTd0Nw/Zw5ptp5L3KyneM0EBUnx7xu2dG28y2uL
 B27KfcvUJl3Mp981Yl/LFke5jrwh3k0eySTM+H2v0yk8N5+jUfWkEECvZ
 2dCej5GVXrCghMIM8eH/egA0EewuLFJ/WVUtBAijisPfZUAwB7CkvsNYi A==;
X-CSE-ConnectionGUID: EyPX6QmYSGyDWgDADcXzZw==
X-CSE-MsgGUID: 5ThGB908TaS6msJINn7zTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112070034"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="112070034"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 09:19:03 -0700
X-CSE-ConnectionGUID: D5yt/1GkRQikLRXRa7qCfA==
X-CSE-MsgGUID: IWLiFa21R4Sslneeq+UcYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="269303926"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.140])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 09:18:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, Linus
 Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa
 <asrivats@redhat.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Hui Pu <Hui.Pu@gehealthcare.com>, Ian
 Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
In-Reply-To: <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
Date: Tue, 08 Sep 2026 19:18:53 +0300
Message-ID: <678ddef7e56703d9adffff5c490d4857af515343@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 03 Sep 2026, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Adding a drm_panel does currently not add a panel_bridge wrapping
> it. Usually the panel_bridge creation happens later, when some other driver
> (e.g. the previous bridge or the encoder) calls *_of_get_bridge() and the
> following element in the pipeline is a panel.
>
> This has some drawbacks:
>
>  * the bridge API is currently the best practice to access various
>    components of the pipeline, especially with complex cards where bridges
>    can be combined in different ways on different hardware
>  * the panel_bridge is not created in the context of the driver of the
>    underlying physical device (the panel driver), but of some other driver
>  * that other driver is not aware of whether the returned drm_bridge
>    pointer is a panel_bridge created on the fly, a pre-existing
>    panel_bridge or a non-panel bridge
>  * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
>    but that other driver doesn't know whether this is needed because it
>    doesn't know whether it has created a panel_bridge or not
>
> Other drivers call [a variant of] drm_panel_bridge_add(), which also has
> some of the above drawbacks.
>
> So far the current approach was working mostly because devm and drmm ensure
> the panel bridge would be dealloacted at some later point. However with the
> upcoming implementation of bridge hotplug and dynamic bridge lifetime this
> will get more complicated.
>
> Switch to the new approach: embed a drm_bridge inside every drm_panel,
> which behaves just like the current drm_panel_bridge.

What does this mean for drivers like i915 that use drm_panel *only* for
handling panel followers? We don't need the bridge for anything. It'll
just be excess midlayer baggage.

I'm also concerned about the embedded struct drm_connector being added,
since that can't and will not be a drm_connector that we'll use. All of
our drm_connector are embedded in intel_connector, and all of our
codebase expects this, and we init them ourselves. Having additional
drm_connector (not embedded in intel_connector) added by library code
*will* oops in our driver.

I haven't had the time for an in-depth look, but it feels like this
assumes a certain driver model, instead of providing building blocks for
drivers to use.


BR,
Jani.


>
> Do this by copying and adapting the code from bridge/panel.c, using
> function names that are more suitable within drm_panel.c and doing the
> minimal adaptation needed.
>
> Currently drm_bridge and drm_panel have independent refcounted
> allocation. As they now become a single struct, just change
> drm_panel_get/put() to get/put the bridge. As a result, the refcount for a
> drm_bridge embedded in a drm_panel is:
>
>   bridge.refcount == number of drm_bridge_get() calls
>                    + number of drm_panel_get() calls
>                    - number of drm_bridge_put() calls
>                    - number of drm_panel_put() calls
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> ---
>
> This patch is new in v2, and replaces "drm/bridge: panel: add a
> panel_bridge to every panel" which was based on a different approach.
> ---
>  drivers/gpu/drm/drm_panel.c | 258 +++++++++++++++++++++++++++++++++++++++++---
>  include/drm/drm_panel.h     |  33 ++++--
>  2 files changed, 266 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f8f6082e637f..9b86195f9f66 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -22,15 +22,19 @@
>   */
>  
>  #include <linux/backlight.h>
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> +#include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
>  
>  static DEFINE_MUTEX(panel_lock);
>  static LIST_HEAD(panel_list);
> @@ -46,6 +50,18 @@ static LIST_HEAD(panel_list);
>   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
>   */
>  
> +static inline struct drm_panel *
> +drm_bridge_to_panel(const struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct drm_panel, bridge);
> +}
> +
> +static inline struct drm_panel *
> +drm_connector_to_panel(const struct drm_connector *connector)
> +{
> +	return container_of(connector, struct drm_panel, connector);
> +}
> +
>  /**
>   * drm_panel_init - initialize a panel
>   * @panel: DRM panel
> @@ -86,6 +102,7 @@ void drm_panel_add(struct drm_panel *panel)
>  	mutex_lock(&panel_lock);
>  	list_add_tail(&panel->list, &panel_list);
>  	mutex_unlock(&panel_lock);
> +	drm_bridge_add(&panel->bridge);
>  }
>  EXPORT_SYMBOL(drm_panel_add);
>  
> @@ -97,6 +114,7 @@ EXPORT_SYMBOL(drm_panel_add);
>   */
>  void drm_panel_remove(struct drm_panel *panel)
>  {
> +	drm_bridge_remove(&panel->bridge);
>  	mutex_lock(&panel_lock);
>  	list_del_init(&panel->list);
>  	mutex_unlock(&panel_lock);
> @@ -370,13 +388,198 @@ int drm_panel_get_modes(struct drm_panel *panel,
>  }
>  EXPORT_SYMBOL(drm_panel_get_modes);
>  
> -static void __drm_panel_free(struct kref *kref)
> +static int drm_panel_bridge_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_panel *drm_panel = drm_connector_to_panel(connector);
> +
> +	return drm_panel_get_modes(drm_panel, connector);
> +}
> +
> +/**
> + * drm_bridge_set_connector_orientation - Set the connector panel
> + * orientation from the bridge that can be transformed to drm_panel.
> + *
> + * @bridge: The drm_bridge for a drm_panel.
> + * @connector: The connector to be set panel orientation.
> + *
> + * Returns 0 on success, negative errno on failure.
> + */
> +int drm_bridge_set_connector_orientation(const struct drm_bridge *bridge,
> +					 struct drm_connector *connector)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +
> +	return drm_connector_set_orientation_from_panel(connector, panel);
> +}
> +EXPORT_SYMBOL(drm_bridge_set_connector_orientation);
> +
> +static const struct drm_connector_helper_funcs
> +drm_panel_bridge_connector_helper_funcs = {
> +	.get_modes = drm_panel_bridge_connector_get_modes,
> +};
> +
> +static const struct drm_connector_funcs drm_panel_bridge_connector_funcs = {
> +	.reset = drm_atomic_helper_connector_reset,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static int drm_panel_bridge_attach(struct drm_bridge *bridge,
> +				   struct drm_encoder *encoder,
> +				   enum drm_bridge_attach_flags flags)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +	struct drm_connector *connector = &panel->connector;
> +	int ret;
> +
> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> +		return 0;
> +
> +	drm_connector_helper_add(connector,
> +				 &drm_panel_bridge_connector_helper_funcs);
> +
> +	ret = drm_connector_init(bridge->dev, connector,
> +				 &drm_panel_bridge_connector_funcs,
> +				 panel->connector_type);
> +	if (ret) {
> +		DRM_ERROR("Failed to initialize connector\n");
> +		return ret;
> +	}
> +
> +	drm_bridge_set_connector_orientation(bridge, connector);
> +
> +	drm_connector_attach_encoder(connector, encoder);
> +
> +	if (bridge->dev->registered) {
> +		if (connector->funcs->reset)
> +			connector->funcs->reset(connector);
> +		drm_connector_register(connector);
> +	}
> +
> +	return 0;
> +}
> +
> +static void drm_panel_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +	struct drm_connector *connector = &panel->connector;
> +
> +	/* Cleanup the connector if we know it was initialized */
> +	if (connector->dev)
> +		drm_connector_cleanup(connector);
> +}
> +
> +static void drm_panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +					       struct drm_atomic_commit *atomic_commit)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_crtc_state;
> +
> +	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_commit, encoder);
> +	if (!crtc)
> +		return;
> +
> +	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_commit, crtc);
> +	if (old_crtc_state && old_crtc_state->self_refresh_active)
> +		return;
> +
> +	drm_panel_prepare(panel);
> +}
> +
> +static void drm_panel_bridge_atomic_enable(struct drm_bridge *bridge,
> +					   struct drm_atomic_commit *atomic_commit)
>  {
> -	struct drm_panel *panel = container_of(kref, struct drm_panel, refcount);
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_crtc_state;
>  
> -	kfree(panel->container);
> +	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_commit, encoder);
> +	if (!crtc)
> +		return;
> +
> +	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_commit, crtc);
> +	if (old_crtc_state && old_crtc_state->self_refresh_active)
> +		return;
> +
> +	drm_panel_enable(panel);
> +}
> +
> +static void drm_panel_bridge_atomic_disable(struct drm_bridge *bridge,
> +					    struct drm_atomic_commit *atomic_commit)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *new_crtc_state;
> +
> +	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_commit, encoder);
> +	if (!crtc)
> +		return;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_commit, crtc);
> +	if (new_crtc_state && new_crtc_state->self_refresh_active)
> +		return;
> +
> +	drm_panel_disable(panel);
>  }
>  
> +static void drm_panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
> +						 struct drm_atomic_commit *atomic_commit)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *new_crtc_state;
> +
> +	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_commit, encoder);
> +	if (!crtc)
> +		return;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_commit, crtc);
> +	if (new_crtc_state && new_crtc_state->self_refresh_active)
> +		return;
> +
> +	drm_panel_unprepare(panel);
> +}
> +
> +static int drm_panel_bridge_get_modes(struct drm_bridge *bridge,
> +				      struct drm_connector *connector)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +
> +	return drm_panel_get_modes(panel, connector);
> +}
> +
> +static void drm_panel_bridge_debugfs_init(struct drm_bridge *bridge,
> +					  struct dentry *root)
> +{
> +	struct drm_panel *panel = drm_bridge_to_panel(bridge);
> +
> +	root = debugfs_create_dir("panel", root);
> +	if (panel->funcs->debugfs_init)
> +		panel->funcs->debugfs_init(panel, root);
> +}
> +
> +static const struct drm_bridge_funcs drm_panel_bridge_funcs = {
> +	.attach = drm_panel_bridge_attach,
> +	.detach = drm_panel_bridge_detach,
> +	.atomic_pre_enable = drm_panel_bridge_atomic_pre_enable,
> +	.atomic_enable = drm_panel_bridge_atomic_enable,
> +	.atomic_disable = drm_panel_bridge_atomic_disable,
> +	.atomic_post_disable = drm_panel_bridge_atomic_post_disable,
> +	.get_modes = drm_panel_bridge_get_modes,
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
> +	.debugfs_init = drm_panel_bridge_debugfs_init,
> +};
> +
>  /**
>   * drm_panel_get - Acquire a panel reference
>   * @panel: DRM panel
> @@ -387,10 +590,8 @@ static void __drm_panel_free(struct kref *kref)
>   */
>  struct drm_panel *drm_panel_get(struct drm_panel *panel)
>  {
> -	if (!panel)
> -		return panel;
> -
> -	kref_get(&panel->refcount);
> +	if (panel)
> +		drm_bridge_get(&panel->bridge);
>  
>  	return panel;
>  }
> @@ -406,7 +607,7 @@ EXPORT_SYMBOL(drm_panel_get);
>  void drm_panel_put(struct drm_panel *panel)
>  {
>  	if (panel)
> -		kref_put(&panel->refcount, __drm_panel_free);
> +		drm_bridge_put(&panel->bridge);
>  }
>  EXPORT_SYMBOL(drm_panel_put);
>  
> @@ -429,8 +630,22 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
>  			     const struct drm_panel_funcs *funcs,
>  			     int connector_type)
>  {
> -	void *container;
> +	/*
> +	 * Struct embedding and offsets:
> +	 *
> +	 *    |--------------- user container struct ------------|
> +	 *    :    |---------- struct drm_panel ------------|
> +	 *    :    :    |----- struct drm_bridge ------|
> +	 *    A    B    C
> +	 *
> +	 * B - A = offset (passed as argument)
> +	 * C - B = panel_bridge_offset
> +	 * C - A = alloc_bridge_offset
> +	 */
> +	const size_t panel_bridge_offset = offsetof(struct drm_panel, bridge);
> +	const size_t alloc_bridge_offset = offset + panel_bridge_offset;
>  	struct drm_panel *panel;
> +	void *container;
>  	int err;
>  
>  	if (!funcs) {
> @@ -438,14 +653,16 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	container = kzalloc(size, GFP_KERNEL);
> -	if (!container)
> -		return ERR_PTR(-ENOMEM);
> +	container = __devm_drm_bridge_alloc(dev, size, alloc_bridge_offset,
> +					    &drm_panel_bridge_funcs);
> +	if (IS_ERR(container))
> +		return container;
>  
>  	panel = container + offset;
> -	panel->container = container;
>  	panel->funcs = funcs;
> -	kref_init(&panel->refcount);
> +	panel->bridge.of_node = dev->of_node;
> +
> +	drm_panel_get(panel);
>  
>  	err = devm_add_action_or_reset(dev, drm_panel_put_void, panel);
>  	if (err)
> @@ -457,6 +674,19 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
>  }
>  EXPORT_SYMBOL(__devm_drm_panel_alloc);
>  
> +/**
> + * drm_bridge_is_panel - Tell if a drm_bridge is a panel.
> + *
> + * @bridge: The drm_bridge to be checked.
> + *
> + * Returns true if the bridge is a panel, or false otherwise.
> + */
> +bool drm_bridge_is_panel(const struct drm_bridge *bridge)
> +{
> +	return bridge->funcs == &drm_panel_bridge_funcs;
> +}
> +EXPORT_SYMBOL(drm_bridge_is_panel);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_panel - look up and reference a panel by device tree node
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 08949d41d743..7fe2f3160b2a 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -30,6 +30,8 @@
>  #include <linux/mutex.h>
>  #include <linux/kref.h>
>  
> +#include <drm/drm_bridge.h>
> +
>  struct backlight_device;
>  struct dentry;
>  struct device_node;
> @@ -228,6 +230,22 @@ struct drm_panel {
>  	 */
>  	const struct drm_panel_funcs *funcs;
>  
> +	/**
> +	 * @bridge:
> +	 *
> +	 * Bridge to access the panel features through the drm_bridge API.
> +	 */
> +	struct drm_bridge bridge;
> +
> +	/**
> +	 * @connector:
> +	 *
> +	 * Connector instantiated by the bridge (only for legacy code not
> +	 * yet using the drm_bridge_connector and
> +	 * DRM_BRIDGE_ATTACH_NO_CONNECTOR).
> +	 */
> +	struct drm_connector connector;
> +
>  	/**
>  	 * @connector_type:
>  	 *
> @@ -281,17 +299,6 @@ struct drm_panel {
>  	 * If true then the panel has been enabled.
>  	 */
>  	bool enabled;
> -
> -	/**
> -	 * @container: Pointer to the private driver struct embedding this
> -	 * @struct drm_panel.
> -	 */
> -	void *container;
> -
> -	/**
> -	 * @refcount: reference count of users referencing this panel.
> -	 */
> -	struct kref refcount;
>  };
>  
>  void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
> @@ -327,6 +334,10 @@ void drm_panel_add(struct drm_panel *panel);
>  void drm_panel_remove(struct drm_panel *panel);
>  int devm_drm_panel_add(struct device *dev, struct drm_panel *panel);
>  
> +bool drm_bridge_is_panel(const struct drm_bridge *bridge);
> +int drm_bridge_set_connector_orientation(const struct drm_bridge *bridge,
> +					 struct drm_connector *connector);
> +
>  void drm_panel_prepare(struct drm_panel *panel);
>  void drm_panel_unprepare(struct drm_panel *panel);

-- 
Jani Nikula, Intel
