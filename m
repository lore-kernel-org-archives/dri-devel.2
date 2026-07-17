Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA28C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1A610E437;
	Fri, 17 Jul 2026 12:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNvxM54Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1CE10E43E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:16:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C818C60A59;
 Fri, 17 Jul 2026 12:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECCB1F000E9;
 Fri, 17 Jul 2026 12:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784290576;
 bh=PSyZWAV19wLuuBHHlDVhvWOMxKuoL3tiBcFPCf4Gbhw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mNvxM54ZuPQ2VxiLgtecWdcbcfH0ElHMdlxWivmh8WpjnWBopxAN5nZMyHFf2wiKT
 lyhPNbEXR6B/7WYNHTiXMBFbgSu6b6jXTBfrMrH/PM+67o2nzPU75KE2XHkv4bis9v
 bqjVR/COzE2O5O9Rek/21edUEPpll/0fVZCTjvqi6TIeOFzx2xbjsHs1doDJP65BTJ
 xsKWupt2RnbMD5x2tb7muR+uce+5jTyUtaATuEfiL8h/j8LFeFeHp7mnXo/D9z4iW3
 zgAaMPZIVceuo9QfGq+AHLVDAbAD64FotsWXgS1SRzijDD3HG3HNC1tiQ9ZZZkf6oD
 MXrkdTLNlydfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/rockchip: lvds: propagate bus_flags to the CRTC
 state
To: "Rok Markovic" <rok@kanardia.eu>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260717120005.2087386-2-rok@kanardia.eu>
References: <20260717120005.2087386-1-rok@kanardia.eu>
 <20260717120005.2087386-2-rok@kanardia.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 12:16:15 +0000
Message-Id: <20260717121616.2ECCB1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The newly introduced bus_flags assignment bypasses DRM bridge st=
ate negotiation by reading flags directly from the final connector instead =
of the adjacent bridge.

Pre-existing issues:
- [High] The driver unconditionally overwrites the function pointers and pr=
ivate data of external bridge objects, causing type confusion and completel=
y breaking external bridge support.
--

--- Patch [1]: [PATCH 1/4] drm/rockchip: lvds: propagate bus_flags to the C=
RTC state ---
commit e03a59004874598201254d64c0f6e0e88de3ff1a
Author: Rok Markovic <rok@kanardia.eu>

drm/rockchip: lvds: propagate bus_flags to the CRTC state

This commit updates the Rockchip LVDS encoder's atomic_check function to
propagate bus_flags from the connector's display_info to the CRTC state.
This ensures that the VOP can correctly set the pixel clock polarity based
on the panel's requirements.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/r=
ockchip/rockchip_lvds.c
> index 7a0c4fa29f2f0..150299c12298a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -129,7 +129,15 @@ rockchip_lvds_encoder_atomic_check(struct drm_encode=
r *encoder,
>  				   struct drm_connector_state *conn_state)
>  {
>  	struct rockchip_crtc_state *s =3D to_rockchip_crtc_state(crtc_state);
> -
> +	struct drm_connector *connector =3D conn_state->connector;
> +
> +	/*
> +	 * The VOP derives the pixel clock polarity from this. Without it a
> +	 * panel that declares pixelclk-active =3D <0> is clocked on the wrong
> +	 * edge. panel-lvds fills the connector's bus_flags in from the DT
> +	 * display timing.
> +	 */
> +	s->bus_flags =3D connector->display_info.bus_flags;

[Severity: Medium]
Does this bypass DRM bridge state negotiation by reading flags directly from
the final connector instead of the adjacent bridge?

By reading from connector->display_info.bus_flags in
rockchip_lvds_encoder_atomic_check(), the VOP pixel clock polarity is
configured based on the final sink (e.g., an HDMI monitor) rather than the
LVDS bridge's input requirements.

This causes incorrect pixel clock polarity for external bridge setups, as it
violates DRM bridge chaining contracts which expect the state to be retriev=
ed
via drm_atomic_get_new_bridge_state().

>  	s->output_mode =3D ROCKCHIP_OUT_MODE_P888;
>  	s->output_type =3D DRM_MODE_CONNECTOR_LVDS;

[Severity: High]
This isn't a bug introduced by this patch, but does the driver unconditiona=
lly
overwrite the function pointers and private data of external bridge objects=
 in
rockchip_lvds_bind()?

When a valid external bridge is present, the initialization path overwrites
the bridge data:

rockchip_lvds_bind() {
    ...
    if (lvds->bridge) {
        lvds->bridge->driver_private =3D lvds;
        lvds->bridge->ops =3D DRM_BRIDGE_OP_MODES;
        lvds->bridge->funcs =3D &rockchip_lvds_bridge_funcs;
    ...
}

Does this hijack the external bridge by replacing its callbacks and private
data with LVDS-specific values?

This causes type confusion and prevents external bridges from ever being
enabled, since their callbacks are replaced by the LVDS functions. It also
seems likely to cause panics if the external bridge driver attempts to acce=
ss
its original driver_private data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717120005.2087=
386-1-rok@kanardia.eu?part=3D1
