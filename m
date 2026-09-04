Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D379C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93D610F951;
	Fri,  4 Sep 2026 08:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AU0OtRZH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E102C10F951
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:27:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC3A340516;
 Fri,  4 Sep 2026 08:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7EA1F00A3D;
 Fri,  4 Sep 2026 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788510465;
 bh=LedSBcjMTN5DXWgZJlvx5zzjDnpXz/AyClnEQVyrKsQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AU0OtRZHC2cMA6mMDFn+85rlIuEACq5hidEe4IL1M5xYAbZm2sRhisC+FIwmFC6rb
 sNwJQ1GQTTuNAIZOvfPNt+UxmFYgoltBT2cIOXB5OvBLf4J+Cdm79f4arItT5epqms
 v4hQNydsjXRh9oTVM1Tw9j2WkKlAlT3fODDgSDJ7Xbj274S2b388f3NdooLnLZ+i5j
 wLgDfMc9Wysha6dkqSe39TNeETcLRRx22rz4RQc8XEgMZVpGJxDRu0pwAMDROlLyvS
 03bzaNkVipY/bJBm3CJuPo1m1EB2rVTwvUVGZh7YLCyfCx+GPn95aZkOO4Pudkqhlk
 VCF05iu+W2YdQ==
Date: Fri, 4 Sep 2026 10:27:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6 04/13] drm/imx: dc-crtc: Disable at boot
Message-ID: <app-rzrdgsxVozsI@houat>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-4-26643e3f6cb7@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wy243kauhdd524wa"
Content-Disposition: inline
In-Reply-To: <20260904-imx8-dc-prefetch-v6-4-26643e3f6cb7@nxp.com>
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


--wy243kauhdd524wa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 04/13] drm/imx: dc-crtc: Disable at boot
MIME-Version: 1.0

Hi,

On Fri, Sep 04, 2026 at 03:54:54PM +0800, Liu Ying wrote:
> CRTC(s) could still be running after the DRM device is unplugged by
> calling drm_dev_unplug(), because the CRTC disablement logic is
> protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
> Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
> driver's runtime PM) and pixel clock use count could be inbalanced
> after removing and re-installing the driver module.  To fix this,
> add a helper dc_crtc_disable_at_boot() and call it to properly
> disable all CRTCs before advertising DRM device to user-space by
> calling drm_dev_register().
>=20
> Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Just as a heads-up, the readout series I'm working on is probably going
to help you deal with it:
https://lore.kernel.org/r/20260629-drm-state-readout-v4-0-5966657980ed@kern=
el.org

> ---
> v6:
> - Rebase onto the latest drm-misc-next and resolve conflicts.
>=20
> v3:
> - Collect Frank's R-b tag.
> ---
>  drivers/gpu/drm/imx/dc/dc-crtc.c | 55 +++++++++++++++++++++++++++++++++-=
------
>  drivers/gpu/drm/imx/dc/dc-drv.c  |  5 ++++
>  drivers/gpu/drm/imx/dc/dc-drv.h  |  3 +++
>  3 files changed, 54 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index 0d64186a9901..1a537cf88daf 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> @@ -293,23 +293,29 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  	dc_crtc_queue_state_event(new_crtc_state);
>  }
> =20
> -static void
> -dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *=
state)
> +static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
>  {
> -	struct drm_crtc_state *new_crtc_state =3D
> -				drm_atomic_get_new_crtc_state(state, crtc);
> -	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
>  	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> -	int idx;
> -
> -	if (!drm_dev_enter(crtc->dev, &idx))
> -		goto out;
> =20
>  	enable_irq(dc_crtc->irq_dec_seqcomplete);
>  	dc_fg_disable(dc_crtc->fg);
>  	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
>  	disable_irq(dc_crtc->irq_dec_seqcomplete);
> +}
> =20
> +static void
> +dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *=
state)
> +{
> +	struct drm_crtc_state *new_crtc_state =3D
> +				drm_atomic_get_new_crtc_state(state, crtc);
> +	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	int idx;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		goto out;
> +
> +	__dc_crtc_disable_fg(crtc);
>  	dc_fg_disable_clock(dc_crtc->fg);
> =20
>  	/* request pixel engine power-off as plane is off too */
> @@ -331,6 +337,37 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  }
> =20
> +void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> +{
> +	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dc_crtc->de->dev);
> +	if (ret < 0) {
> +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> +			    ret);
> +		return;
> +	}
> +
> +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> +		goto out;
> +	}
> +
> +	dc_crtc_dbg(crtc, "disabling at boot\n");
> +	__dc_crtc_disable_fg(crtc);
> +	dc_fg_disable_clock(dc_crtc->fg);
> +
> +	if (!dc_drm->pe_clk_axi_disabled) {
> +		clk_disable_unprepare(dc_drm->pe->clk_axi);
> +		dc_drm->pe_clk_axi_disabled =3D true;
> +	}
> +
> +out:
> +	pm_runtime_put(dc_crtc->de->dev);

I'm not sure you actually need the pe_clk_axi_disabled flag. If you make
it handled by runtime_pm, then you can also use pm_runtime_set_active to
flag the device as active already when you probe, and the runtime_pm
will know when to enable / disable things properly.
Maxime

--wy243kauhdd524wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCapqA+QAKCRAnX84Zoj2+
duSpAX9/lPUosVP3e92nkRmARUvvaRauY+9r1CBAC06KGtjmDHpcDkZOKDyT+Kz3
64qtJ58Bf1EQs0TiJNXxRlb0mDxPB8srlEh+Z6JveAlmcLRxMxN/FTHYf8xzSR9e
1OJFSvgUcQ==
=/qep
-----END PGP SIGNATURE-----

--wy243kauhdd524wa--
