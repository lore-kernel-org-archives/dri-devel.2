Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018DBC982C5
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CFA10EA55;
	Tue, 15 Sep 2026 14:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d58SBV+z";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E4310EC62
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:13:53 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A05EC51;
 Tue, 15 Sep 2026 16:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1789481531;
 bh=VwYX7+21Q6De7JiLO6GO0IkLDvBD4x2o36xthk8KzP8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d58SBV+zM70pd9V7uhm8znVcwQYR7QNumEMzaw619dzX6fRdW57GyzGUygAlSAnb4
 vgwaWFPJCxcwqcCIWN9pd3VEF6HrcTtHXGHX3Xzyl1TZKVXyFrklCMfi+W06vPUjG/
 NDs8iTKtKpSLS14w0MOdYOpQH5XHSbomKF3kfeg4=
Date: Tue, 15 Sep 2026 17:13:50 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 04/33] drm/atomic: Add drm_private_obj name
Message-ID: <20260915141350.GA3859154@killaraus.ideasonboard.com>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
 <20260907-drm-state-readout-v5-4-5fa1ac7a5148@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260907-drm-state-readout-v5-4-5fa1ac7a5148@kernel.org>
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

Hi Maxime,

Thank you for the patch.

On Mon, Sep 07, 2026 at 03:23:40PM +0200, Maxime Ripard wrote:
> drm_private_obj does not carry a human-readable name, which makes
> debug messages hard to interpret when multiple private objects are
> registered on the same device.
> 
> Add a name field to drm_private_obj, passed through
> drm_atomic_private_obj_init() and freed in
> drm_atomic_private_obj_fini(). Update the existing callers to pass a
> name.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 1 +
>  drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c | 8 ++++++++
>  drivers/gpu/drm/display/drm_dp_mst_topology.c           | 2 +-
>  drivers/gpu/drm/display/drm_dp_tunnel.c                 | 1 +
>  drivers/gpu/drm/drm_atomic.c                            | 4 ++++
>  drivers/gpu/drm/drm_bridge.c                            | 3 ++-
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c               | 1 +
>  drivers/gpu/drm/ingenic/ingenic-ipu.c                   | 1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                 | 1 +
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                | 1 +
>  drivers/gpu/drm/omapdrm/omap_drv.c                      | 1 +
>  drivers/gpu/drm/tegra/hub.c                             | 1 +
>  drivers/gpu/drm/vc4/vc4_kms.c                           | 3 +++
>  include/drm/drm_atomic.h                                | 7 ++++++-
>  include/drm/drm_bridge.h                                | 2 ++
>  15 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a9d3ce8b173a..1d481c9437d7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2249,10 +2249,11 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>  	/* indicates support for immediate flip */
>  	adev_to_drm(adev)->mode_config.async_page_flip = true;
>  
>  	drm_atomic_private_obj_init(adev_to_drm(adev),
>  				    &adev->dm.atomic_obj,
> +				    "amdgpu_dc_state",

I'll let individual driver maintainers comment no the names.

>  				    &dm_atomic_state_funcs);
>  
>  	r = amdgpu_display_modeset_create_props(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> index 77b3f361091f..8a3c9fcf3844 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> @@ -64,10 +64,11 @@ static const struct drm_private_state_funcs komeda_layer_obj_funcs = {
>  
>  static int komeda_layer_obj_add(struct komeda_kms_dev *kms,
>  				struct komeda_layer *layer)
>  {
>  	drm_atomic_private_obj_init(&kms->base, &layer->base.obj,
> +				    "komeda_layer",
>  				    &komeda_layer_obj_funcs);
>  	return 0;
>  }
>  
>  static struct drm_private_state *
> @@ -117,10 +118,11 @@ static const struct drm_private_state_funcs komeda_scaler_obj_funcs = {
>  static int komeda_scaler_obj_add(struct komeda_kms_dev *kms,
>  				 struct komeda_scaler *scaler)
>  {
>  	drm_atomic_private_obj_init(&kms->base,
>  				    &scaler->base.obj,
> +				    "komeda_scaler",
>  				    &komeda_scaler_obj_funcs);
>  	return 0;
>  }
>  
>  static struct drm_private_state *
> @@ -169,10 +171,11 @@ static const struct drm_private_state_funcs komeda_compiz_obj_funcs = {
>  
>  static int komeda_compiz_obj_add(struct komeda_kms_dev *kms,
>  				 struct komeda_compiz *compiz)
>  {
>  	drm_atomic_private_obj_init(&kms->base, &compiz->base.obj,
> +				    "komeda_compiz",
>  				    &komeda_compiz_obj_funcs);
>  
>  	return 0;
>  }
>  
> @@ -223,10 +226,11 @@ static const struct drm_private_state_funcs komeda_splitter_obj_funcs = {
>  static int komeda_splitter_obj_add(struct komeda_kms_dev *kms,
>  				   struct komeda_splitter *splitter)
>  {
>  	drm_atomic_private_obj_init(&kms->base,
>  				    &splitter->base.obj,
> +				    "komeda_splitter",
>  				    &komeda_splitter_obj_funcs);
>  
>  	return 0;
>  }
>  
> @@ -276,10 +280,11 @@ static const struct drm_private_state_funcs komeda_merger_obj_funcs = {
>  static int komeda_merger_obj_add(struct komeda_kms_dev *kms,
>  				 struct komeda_merger *merger)
>  {
>  	drm_atomic_private_obj_init(&kms->base,
>  				    &merger->base.obj,
> +				    "komeda_merger",
>  				    &komeda_merger_obj_funcs);
>  
>  	return 0;
>  }
>  
> @@ -329,10 +334,11 @@ static const struct drm_private_state_funcs komeda_improc_obj_funcs = {
>  
>  static int komeda_improc_obj_add(struct komeda_kms_dev *kms,
>  				 struct komeda_improc *improc)
>  {
>  	drm_atomic_private_obj_init(&kms->base, &improc->base.obj,
> +				    "komeda_improc",
>  				    &komeda_improc_obj_funcs);
>  
>  	return 0;
>  }
>  
> @@ -382,10 +388,11 @@ static const struct drm_private_state_funcs komeda_timing_ctrlr_obj_funcs = {
>  
>  static int komeda_timing_ctrlr_obj_add(struct komeda_kms_dev *kms,
>  				       struct komeda_timing_ctrlr *ctrlr)
>  {
>  	drm_atomic_private_obj_init(&kms->base, &ctrlr->base.obj,
> +				    "komeda_timing_ctrlr",
>  				    &komeda_timing_ctrlr_obj_funcs);
>  
>  	return 0;
>  }
>  
> @@ -436,10 +443,11 @@ static const struct drm_private_state_funcs komeda_pipeline_obj_funcs = {
>  
>  static int komeda_pipeline_obj_add(struct komeda_kms_dev *kms,
>  				   struct komeda_pipeline *pipe)
>  {
>  	drm_atomic_private_obj_init(&kms->base, &pipe->obj,
> +				    "komeda_pipeline",
>  				    &komeda_pipeline_obj_funcs);
>  
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 7ce9e212770a..d3ed80d9fce3 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -5766,11 +5766,11 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	mgr->aux = aux;
>  	mgr->max_dpcd_transaction_bytes = max_dpcd_transaction_bytes;
>  	mgr->max_payloads = max_payloads;
>  	mgr->conn_base_id = conn_base_id;
>  
> -	drm_atomic_private_obj_init(dev, &mgr->base,
> +	drm_atomic_private_obj_init(dev, &mgr->base, "drm_dp_mst_topology",
>  				    &drm_dp_mst_topology_state_funcs);
>  
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_init);
> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
> index d29ad4116e64..391d643793eb 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -1730,10 +1730,11 @@ static bool init_group(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_tunnel_group
>  	group->mgr = mgr;
>  	group->available_bw = -1;
>  	INIT_LIST_HEAD(&group->tunnels);
>  
>  	drm_atomic_private_obj_init(mgr->dev, &group->base,
> +				    group->name,
>  				    &tunnel_group_funcs);
>  
>  	return true;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 596b0de44f00..04da72b4aa70 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1006,10 +1006,11 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
>  
>  /**
>   * drm_atomic_private_obj_init - initialize private object
>   * @dev: DRM device this object will be attached to
>   * @obj: private object
> + * @name: human-readable name for debug messages
>   * @funcs: pointer to the struct of function pointers that identify the object
>   * type
>   *
>   * Initialize the private object, which can be embedded into any
>   * driver private object that needs its own atomic state.
> @@ -1017,18 +1018,20 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
>   * RETURNS:
>   * Zero on success, error code on failure
>   */
>  int drm_atomic_private_obj_init(struct drm_device *dev,
>  				struct drm_private_obj *obj,
> +				const char *name,
>  				const struct drm_private_state_funcs *funcs)
>  {
>  	struct drm_private_state *state;
>  	memset(obj, 0, sizeof(*obj));
>  
>  	drm_modeset_lock_init(&obj->lock);
>  
>  	obj->dev = dev;
> +	obj->name = kstrdup(name, GFP_KERNEL);
>  	obj->funcs = funcs;
>  	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
>  
>  	state = obj->funcs->atomic_create_state(obj);
>  	if (IS_ERR(state))

You seem to be leaking obj->name in the error path. Actually, unless
callers of drm_atomic_private_obj_init() are required to call
drm_atomic_private_obj_fini() on failure (which wouldn't be a great
API), the function is already failing to remove the object from the
privobj_list, and leaks the object lock.

A quick grep shows that the komeda driver seems to call
drm_atomic_private_obj_fini() on private objects that failed to
initialized, because it iterates over the privobj_list. Other drivers
may implement different patterns. It may be safer to make
drm_atomic_private_obj_fini() idempotent.

> @@ -1049,10 +1052,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_init);
>  void
>  drm_atomic_private_obj_fini(struct drm_private_obj *obj)
>  {
>  	list_del(&obj->head);
>  	obj->funcs->atomic_destroy_state(obj, obj->state);
> +	kfree(obj->name);
>  	drm_modeset_lock_fini(&obj->lock);
>  }
>  EXPORT_SYMBOL(drm_atomic_private_obj_fini);
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 83f1809a5d37..27bb9963c234 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -419,10 +419,11 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
>  
>  	bridge = container + offset;
>  	INIT_LIST_HEAD(&bridge->list);
>  	bridge->container = container;
>  	bridge->funcs = funcs;
> +	bridge->name = devm_kasprintf(dev, GFP_KERNEL, "bridge-%s", dev_name(dev));
>  	kref_init(&bridge->refcount);
>  
>  	err = devm_add_action_or_reset(dev, drm_bridge_put_void, bridge);
>  	if (err)
>  		return ERR_PTR(err);
> @@ -622,11 +623,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		ret = bridge->funcs->attach(bridge, encoder, flags);
>  		if (ret < 0)
>  			goto err_reset_bridge;
>  	}
>  
> -	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,

As far as I can see, bridge->name is used here only. We could avoid the
permanent allocation by constructing the name string on-demand here, but
I suppose the runtime overhead would be worse than the small saving in
permanent memory consumption.

>  				    &drm_bridge_priv_state_funcs);
>  
>  	return 0;
>  
>  err_reset_bridge:
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 625ec76cf04d..05ee0ccb121d 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1400,10 +1400,11 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
>  		dev_err(dev, "Unable to register clock notifier\n");
>  		goto err_devclk_disable;
>  	}
>  
>  	drm_atomic_private_obj_init(drm, &priv->private_obj,
> +				    "ingenic_drm",
>  				    &ingenic_drm_private_state_funcs);
>  
>  	ret = drmm_add_action_or_reset(drm, ingenic_drm_atomic_private_obj_fini,
>  				       &priv->private_obj);
>  	if (ret)
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index bf24882e8d9f..795f6db5ce59 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -900,10 +900,11 @@ static int ingenic_ipu_bind(struct device *dev, struct device *master, void *d)
>  		dev_err(dev, "Unable to prepare clock\n");
>  		return err;
>  	}
>  
>  	drm_atomic_private_obj_init(drm, &ipu->private_obj,
> +				    "ingenic_ipu_state",
>  				    &ingenic_ipu_private_state_funcs);
>  
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index da3556eb6ecc..fb3a0c847a9e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1153,10 +1153,11 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
>  
>  	dev->mode_config.cursor_width = 512;
>  	dev->mode_config.cursor_height = 512;
>  
>  	drm_atomic_private_obj_init(dpu_kms->dev, &dpu_kms->global_state,
> +				    "dpu_kms_global_state",
>  				    &dpu_kms_global_state_funcs);
>  
>  	atomic_set(&dpu_kms->bandwidth_ref, 0);
>  
>  	rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 3934cd060b27..b53f59f25fb0 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -710,10 +710,11 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
>  	int ret;
>  
>  	mdp5_kms->dev = dev;
>  
>  	drm_atomic_private_obj_init(mdp5_kms->dev, &mdp5_kms->glob_state,
> +				    "mdp5_global_state",
>  				    &mdp5_global_state_funcs);
>  
>  	/* we need to set a default rate before enabling.  Set a safe
>  	 * rate first, then figure out hw revision, and then set a
>  	 * more optimal rate:
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 92d6a1f9c0a1..9738acbf6fae 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -298,10 +298,11 @@ static const struct drm_private_state_funcs omap_global_state_funcs = {
>  static int omap_global_obj_init(struct drm_device *dev)
>  {
>  	struct omap_drm_private *priv = dev->dev_private;
>  
>  	drm_atomic_private_obj_init(dev, &priv->glob_obj,
> +				    "omap_global",
>  				    &omap_global_state_funcs);
>  	return 0;
>  }
>  
>  static void omap_global_obj_fini(struct omap_drm_private *priv)
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index bd442bfd4540..b38fd353a648 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -956,10 +956,11 @@ static int tegra_display_hub_init(struct host1x_client *client)
>  	struct tegra_display_hub *hub = to_tegra_display_hub(client);
>  	struct drm_device *drm = dev_get_drvdata(client->host);
>  	struct tegra_drm *tegra = drm->dev_private;
>  
>  	drm_atomic_private_obj_init(drm, &hub->base,
> +				    "tegra_display_hub",
>  				    &tegra_display_hub_state_funcs);
>  
>  	tegra->hub = hub;
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index b17e73bce384..5f64cf1fcc9e 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -115,10 +115,11 @@ static void vc4_ctm_obj_fini(struct drm_device *dev, void *unused)
>  static int vc4_ctm_obj_init(struct vc4_dev *vc4)
>  {
>  	drm_modeset_lock_init(&vc4->ctm_state_lock);
>  
>  	drm_atomic_private_obj_init(&vc4->base, &vc4->ctm_manager,
> +				    "vc4_ctm",
>  				    &vc4_ctm_state_funcs);
>  
>  	return drmm_add_action_or_reset(&vc4->base, vc4_ctm_obj_fini, NULL);
>  }
>  
> @@ -755,10 +756,11 @@ static void vc4_load_tracker_obj_fini(struct drm_device *dev, void *unused)
>  }
>  
>  static int vc4_load_tracker_obj_init(struct vc4_dev *vc4)
>  {
>  	drm_atomic_private_obj_init(&vc4->base, &vc4->load_tracker,
> +				    "vc4_load_tracker",
>  				    &vc4_load_tracker_state_funcs);
>  
>  	return drmm_add_action_or_reset(&vc4->base, vc4_load_tracker_obj_fini, NULL);
>  }
>  
> @@ -846,10 +848,11 @@ static void vc4_hvs_channels_obj_fini(struct drm_device *dev, void *unused)
>  }
>  
>  static int vc4_hvs_channels_obj_init(struct vc4_dev *vc4)
>  {
>  	drm_atomic_private_obj_init(&vc4->base, &vc4->hvs_channels,
> +				    "vc4_hvs_channels",
>  				    &vc4_hvs_state_funcs);
>  
>  	return drmm_add_action_or_reset(&vc4->base, vc4_hvs_channels_obj_fini, NULL);
>  }
>  
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index def18b60a106..47b2fe2b039e 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -357,10 +357,15 @@ struct drm_private_obj {
>  	/**
>  	 * @dev: parent DRM device
>  	 */
>  	struct drm_device *dev;
>  
> +	/**
> +	 * @name: human-readable name for debug messages
> +	 */
> +	const char *name;
> +
>  	/**
>  	 * @head: List entry used to attach a private object to a &drm_device
>  	 * (queued to &drm_mode_config.privobj_list).
>  	 */
>  	struct list_head head;
> @@ -738,11 +743,11 @@ drm_atomic_get_new_colorop_state(struct drm_atomic_commit *state,
>  struct drm_connector_state * __must_check
>  drm_atomic_get_connector_state(struct drm_atomic_commit *state,
>  			       struct drm_connector *connector);
>  
>  int drm_atomic_private_obj_init(struct drm_device *dev,
> -				struct drm_private_obj *obj,
> +				struct drm_private_obj *obj, const char *name,
>  				const struct drm_private_state_funcs *funcs);
>  void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
>  
>  struct drm_private_state * __must_check
>  drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 58fff047f43b..389dcab3c3f3 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -994,10 +994,12 @@ enum drm_bridge_ops {
>  struct drm_bridge {
>  	/** @base: inherit from &drm_private_object */
>  	struct drm_private_obj base;
>  	/** @dev: DRM device this bridge belongs to */
>  	struct drm_device *dev;
> +	/** @name: human-readable name for debug messages */
> +	const char *name;
>  	/** @encoder: encoder to which this bridge is connected */
>  	struct drm_encoder *encoder;
>  	/** @chain_node: used to form a bridge chain */
>  	struct list_head chain_node;
>  	/** @of_node: device node pointer to the bridge */

-- 
Regards,

Laurent Pinchart
