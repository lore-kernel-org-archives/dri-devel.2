Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1ADCD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 16:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB2A10E227;
	Sat, 20 Jun 2026 16:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CgOyefAk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8AF10E227
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 16:19:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48A7C40726
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 16:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D751F00A3E;
 Sat, 20 Jun 2026 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781972354;
 bh=MefocXZ0laAnKNhGsBZX7iEaIPnuHfkZRPbJ8S6wO1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CgOyefAkmRnWQYYEwQrdGzsebRuONaxg2uyr7V71r5OuUckB0h5NDx6D0MqjhmFIe
 Jo35hrOcEsKZ2DJS07Ox9Z8cBtzd73vPvzmJU4ziLDnw7c/EmWP3EkiMHHJi6ynW/p
 oSwRrcrRlekto3fdncX061TQoiCOA3e53Z+WPpqNDyD8/ykFy85TR+QtrN6B51ydtd
 KsSLmzWyvoonRieweg3sWdBJhXJSy2QVXwDKzYjmaJ7WVcBeo1lxqj1oqHVhXFNs+1
 i/adAhavzNXY0jXckktpsK7G42pjxq9pxQ5Yi/b0/NM4L4/ov1JPGth6mHF18vynzP
 lCsrAd8sGNuJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] drm/amd/display: use HDMI RGB deep color for PCONs
To: "Stephen via B4 Relay" <devnull+stevester.codes.gmail.com@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260620-ch7218-rfc-v1-b4-v1-3-3412debf44b6@gmail.com>
References: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
 <20260620-ch7218-rfc-v1-b4-v1-3-3412debf44b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 16:19:13 +0000
Message-Id: <20260620161914.01D751F00A3E@smtp.kernel.org>
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
- [High] Missing DP-to-HDMI PCON capability check for deep color configurat=
ion causes atomic check failures.
- [Medium] PCON detection logic fails to correctly identify HDMI ports on M=
ST hubs, excluding them from deep color support.
--

commit 2c95bd6347ca4e92cbbbdffd678f070e97b84a9d
Author: Stephen <stevester.codes@gmail.com>

drm/amd/display: use HDMI RGB deep color for PCONs

This commit updates the DRM AMD display driver to support HDMI RGB deep col=
or=20
for PCON connectors. It derives the candidate bpc from edid_hdmi_rgb444_dc_=
modes=20
when an RGB output is routed through a recognized DP-to-HDMI converter.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f8c13bad4ac23..02ffc1563e699 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -6582,22 +6582,44 @@ static void update_stream_scaling_settings(struct=
 drm_device *dev,
> =20
>  static enum dc_color_depth
>  convert_color_depth_from_display_info(const struct drm_connector *connec=
tor,
> -				      bool is_y420, int requested_bpc)
> +				      enum dc_pixel_encoding pixel_encoding,
> +				      int requested_bpc)
>  {
> +	const struct drm_display_info *info =3D &connector->display_info;
> +	bool is_hdmi_pcon =3D false;
>  	u8 bpc;
> =20
> -	if (is_y420) {
> +	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_WRITEBACK) {
> +		const struct amdgpu_dm_connector *aconnector =3D
> +			to_amdgpu_dm_connector(connector);
> +
> +		is_hdmi_pcon =3D aconnector->dc_link &&
> +			aconnector->dc_link->dpcd_caps.dongle_type =3D=3D
> +			DISPLAY_DONGLE_DP_HDMI_CONVERTER;

[Severity: Medium]
For MST leaf connectors, aconnector->dc_link represents the primary link
to the MST hub rather than the downstream leaf port.

Since the root link typically identifies as a branch device, will this
evaluate to false for MST setups and exclude HDMI sinks connected via
MST hubs from deep color support?

> +	}
> +
> +	if (pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR420) {
>  		bpc =3D 8;
> =20
>  		/* Cap display bpc based on HDMI 2.0 HF-VSDB */
> -		if (connector->display_info.hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_=
48)
> +		if (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48)
> +			bpc =3D 16;
> +		else if (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_36)
> +			bpc =3D 12;
> +		else if (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_30)
> +			bpc =3D 10;
> +	} else if (pixel_encoding =3D=3D PIXEL_ENCODING_RGB && is_hdmi_pcon) {
> +		bpc =3D 8;
> +
> +		/* The downstream sink is HDMI even though DRM exposes DP. */
> +		if (info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_48)
>  			bpc =3D 16;
> -		else if (connector->display_info.hdmi.y420_dc_modes & DRM_EDID_YCBCR42=
0_DC_36)
> +		else if (info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_36)
>  			bpc =3D 12;
> -		else if (connector->display_info.hdmi.y420_dc_modes & DRM_EDID_YCBCR42=
0_DC_30)
> +		else if (info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_30)
>  			bpc =3D 10;

[Severity: High]
This logic sets the bpc based on the downstream HDMI sink's capabilities, b=
ut
does it also need to be constrained by the PCON's maximum bpc limit?

If a sink supports 12 bpc but the PCON only supports 8 bpc, will skipping a
check against aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_max_bpc
cause dp_active_dongle_validate_timing() to fail and reject the atomic comm=
it?

>  	} else {
> -		bpc =3D (uint8_t)connector->display_info.bpc;
> +		bpc =3D (uint8_t)info->bpc;
>  		/* Assume 8 bpc by default if no bpc is specified. */
>  		bpc =3D bpc ? bpc : 8;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-ch7218-rfc=
-v1-b4-v1-1-3412debf44b6@gmail.com?part=3D3
