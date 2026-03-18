Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669F710854DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B821510E791;
	Wed, 18 Mar 2026 09:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rO3sszqh";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE4D10E78F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:42:48 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7CECB460;
 Wed, 18 Mar 2026 10:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773826894;
 bh=WQb5z5Rv1EHyhSTn9e9bCCQVFKx/X2enNEZQNsktla8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rO3sszqh8K/nLr1EYOcOJ5N0y0uh4Xvj07I2lvRyRpRxaVw1k1BxKySJUwpoYI28/
 mJ8CbGD+Vsn12oKJNjowHreRLD9BrLo61rsUu68QCjdAy4MlIUizWtRhpeWa5+VsNe
 G4iLyOLynWFLq3UfQdoLMgizQdveVyHy2Iqw7+ns=
Date: Wed, 18 Mar 2026 11:42:45 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "tomi.valkeinen" <tomi.valkeinen@ideasonboard.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH 2/4] drm: rcar-du: Store CMM device pointer instead of
 platform_device
Message-ID: <20260318094245.GB404310@killaraus.ideasonboard.com>
References: <20260317231930.595719-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260317231930.595719-3-laurent.pinchart+renesas@ideasonboard.com>
 <TY3PR01MB1134608A5C98A321E1032FCD4864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134608A5C98A321E1032FCD4864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On Wed, Mar 18, 2026 at 07:13:43AM +0000, Biju Das wrote:
> On 17 March 2026 23:19, Laurent Pinchart wrote:
> > 
> > The DU driver stores the CMM devices as pointers to struct platform_device, and passes them to the API
> > exposed by the CMM driver.
> > This is similar to how the VSP is handled, except that the VSP uses struct device pointers. Replace
> > the CMM platform_device pointers with device pointers for consistency.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c    | 26 +++++++++----------
> >  drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h    | 18 ++++++-------
> >  .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  2 +-
> >  drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h |  2 +-  drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> > |  6 ++---
> >  5 files changed, 27 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
> > index 93ba115d654f..5bced9d778e8 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
> > @@ -59,7 +59,7 @@ static void rcar_cmm_lut_write(struct rcar_cmm *rcmm,
> > 
> >  /*
> >   * rcar_cmm_setup() - Configure the CMM unit
> > - * @pdev: The platform device associated with the CMM instance
> > + * @dev: The device associated with the CMM instance
> >   * @config: The CMM unit configuration
> >   *
> >   * Configure the CMM unit with the given configuration. Currently enabling, @@ -73,10 +73,10 @@
> > static void rcar_cmm_lut_write(struct rcar_cmm *rcmm,
> >   * TODO: Add support for LUT double buffer operations to avoid updating the
> >   * LUT table entries while a frame is being displayed.
> >   */
> > -int rcar_cmm_setup(struct platform_device *pdev,
> > +int rcar_cmm_setup(struct device *dev,
> >  		   const struct rcar_cmm_config *config)  {
> > -	struct rcar_cmm *rcmm = platform_get_drvdata(pdev);
> > +	struct rcar_cmm *rcmm = dev_get_drvdata(dev);
> > 
> >  	/* Disable LUT if no table is provided. */
> >  	if (!config->lut.table) {
> > @@ -102,7 +102,7 @@ EXPORT_SYMBOL_GPL(rcar_cmm_setup);
> > 
> >  /*
> >   * rcar_cmm_enable() - Enable the CMM unit
> > - * @pdev: The platform device associated with the CMM instance
> > + * @dev: The device associated with the CMM instance
> >   *
> >   * When the output of the corresponding DU channel is routed to the CMM unit,
> >   * the unit shall be enabled before the DU channel is started, and remain @@ -113,11 +113,11 @@
> > EXPORT_SYMBOL_GPL(rcar_cmm_setup);
> >   * It is an error to attempt to enable an already enabled CMM unit, or to
> >   * attempt to disable a disabled unit.
> >   */
> > -int rcar_cmm_enable(struct platform_device *pdev)
> > +int rcar_cmm_enable(struct device *dev)
> >  {
> >  	int ret;
> > 
> > -	ret = pm_runtime_resume_and_get(&pdev->dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> >  	if (ret < 0)
> >  		return ret;
> > 
> > @@ -127,7 +127,7 @@ EXPORT_SYMBOL_GPL(rcar_cmm_enable);
> > 
> >  /*
> >   * rcar_cmm_disable() - Disable the CMM unit
> > - * @pdev: The platform device associated with the CMM instance
> > + * @dev: The device associated with the CMM instance
> >   *
> >   * See rcar_cmm_enable() for usage information.
> >   *
> > @@ -135,27 +135,27 @@ EXPORT_SYMBOL_GPL(rcar_cmm_enable);
> >   * state shall thus be restored with rcar_cmm_setup() when re-enabling the CMM
> >   * unit after the next rcar_cmm_enable() call.
> >   */
> > -void rcar_cmm_disable(struct platform_device *pdev)
> > +void rcar_cmm_disable(struct device *dev)
> >  {
> > -	struct rcar_cmm *rcmm = platform_get_drvdata(pdev);
> > +	struct rcar_cmm *rcmm = dev_get_drvdata(dev);
> > 
> >  	rcar_cmm_write(rcmm, CM2_LUT_CTRL, 0);
> >  	rcmm->lut.enabled = false;
> > 
> > -	pm_runtime_put(&pdev->dev);
> > +	pm_runtime_put(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(rcar_cmm_disable);
> > 
> >  /*
> >   * rcar_cmm_init() - Initialize the CMM unit
> > - * @pdev: The platform device associated with the CMM instance
> > + * @dev: The device associated with the CMM instance
> >   *
> >   * Return: 0 on success, -EPROBE_DEFER if the CMM is not available yet,
> >   *         -ENODEV if the DRM_RCAR_CMM config option is disabled
> >   */
> > -int rcar_cmm_init(struct platform_device *pdev)
> > +int rcar_cmm_init(struct device *dev)
> >  {
> > -	struct rcar_cmm *rcmm = platform_get_drvdata(pdev);
> > +	struct rcar_cmm *rcmm = dev_get_drvdata(dev);
> > 
> >  	if (!rcmm)
> >  		return -EPROBE_DEFER;
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h
> > index 628072acc98b..1454605b8100 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h
> > @@ -10,8 +10,8 @@
> > 
> >  #define CM2_LUT_SIZE		256
> > 
> > +struct device;
> >  struct drm_color_lut;
> > -struct platform_device;
> > 
> >  /**
> >   * struct rcar_cmm_config - CMM configuration @@ -26,29 +26,29 @@ struct rcar_cmm_config {  };
> > 
> >  #if IS_ENABLED(CONFIG_DRM_RCAR_CMM)
> > -int rcar_cmm_init(struct platform_device *pdev);
> > +int rcar_cmm_init(struct device *pdev);
> > 
> > -int rcar_cmm_enable(struct platform_device *pdev); -void rcar_cmm_disable(struct platform_device
> > *pdev);
> > +int rcar_cmm_enable(struct device *pdev); void rcar_cmm_disable(struct
> > +device *pdev);
> > 
> > -int rcar_cmm_setup(struct platform_device *pdev,
> > +int rcar_cmm_setup(struct device *pdev,
> 
> struct device *dev for consistency and same for below.

Oops. Will fix in v2.

> >  		   const struct rcar_cmm_config *config);  #else -static inline int rcar_cmm_init(struct
> > platform_device *pdev)
> > +static inline int rcar_cmm_init(struct device *pdev)
> >  {
> >  	return -ENODEV;
> >  }
> > 
> > -static inline int rcar_cmm_enable(struct platform_device *pdev)
> > +static inline int rcar_cmm_enable(struct device *pdev)
> >  {
> >  	return 0;
> >  }
> > 
> > -static inline void rcar_cmm_disable(struct platform_device *pdev)
> > +static inline void rcar_cmm_disable(struct device *pdev)
> >  {
> >  }
> > 
> > -static inline int rcar_cmm_setup(struct platform_device *pdev,
> > +static inline int rcar_cmm_setup(struct device *pdev,
> >  				 const struct rcar_cmm_config *config)  {
> >  	return 0;
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-
> > du/rcar_du_crtc.h
> > index d0f38a8b3561..07a40b305be8 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> > @@ -65,7 +65,7 @@ struct rcar_du_crtc {
> >  	unsigned int vblank_count;
> > 
> >  	struct rcar_du_group *group;
> > -	struct platform_device *cmm;
> > +	struct device *cmm;
> >  	struct rcar_du_vsp *vsp;
> >  	unsigned int vsp_pipe;
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/renesas/rcar-
> > du/rcar_du_drv.h
> > index 5cfa2bb7ad93..9e160dede4e6 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
> > @@ -106,7 +106,7 @@ struct rcar_du_device {
> >  	unsigned int num_crtcs;
> > 
> >  	struct rcar_du_group groups[RCAR_DU_MAX_GROUPS];
> > -	struct platform_device *cmms[RCAR_DU_MAX_CRTCS];
> > +	struct device *cmms[RCAR_DU_MAX_CRTCS];
> >  	struct rcar_du_vsp vsps[RCAR_DU_MAX_VSPS];
> >  	struct drm_bridge *lvds[RCAR_DU_MAX_LVDS];
> >  	struct drm_bridge *dsi[RCAR_DU_MAX_DSI]; diff --git a/drivers/gpu/drm/renesas/rcar-
> > du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> > index 60e6f43b8ab2..f38e45d38ad2 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> > @@ -806,13 +806,13 @@ static int rcar_du_cmm_init(struct rcar_du_device *rcdu)
> >  		 * -ENODEV is used to report that the CMM config option is
> >  		 * disabled: return 0 and let the DU continue probing.
> >  		 */
> > -		ret = rcar_cmm_init(pdev);
> > +		ret = rcar_cmm_init(&pdev->dev);
> >  		if (ret) {
> >  			platform_device_put(pdev);
> >  			return ret == -ENODEV ? 0 : ret;
> >  		}
> > 
> > -		rcdu->cmms[i] = pdev;
> > +		rcdu->cmms[i] = &pdev->dev;
> > 
> >  		/*
> >  		 * Enforce suspend/resume ordering by making the CMM a provider @@ -835,7 +835,7 @@ static
> > void rcar_du_modeset_cleanup(struct drm_device *dev, void *res)
> >  	unsigned int i;
> > 
> >  	for (i = 0; i < ARRAY_SIZE(rcdu->cmms); ++i)
> > -		platform_device_put(rcdu->cmms[i]);
> > +		put_device(rcdu->cmms[i]);
> >  }
> > 
> >  int rcar_du_modeset_init(struct rcar_du_device *rcdu)

-- 
Regards,

Laurent Pinchart
