Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBE2CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9367610E921;
	Sat,  3 Oct 2026 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Np70/OiC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0139710E921
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E33AF60D9B;
 Sat,  3 Oct 2026 17:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722451F0089E;
 Sat,  3 Oct 2026 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050179;
 bh=65MYVtRr+AsHYBhw14zpuag7QigfoC/MqBgFcjUMWZk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Np70/OiCdHlSyPnXDucl2wF+PKHeI8/smbYcInkALjnkLuwWFhxY3jYhUgOSfzRYb
 Eo68dzk6GrzJC/zEeZ46R3voTDvmbfZTlOW6pWsaqrsQ5hvSqSqew8eS5SwMTmtkuX
 bwFgPdG+6L7bFzuEvqWXOQ+sNyz8FelK0HXB1tlxRPhnisgoGyfC6onic2CLL40738
 QonGhFAjYQLX9Y+r85eIcCjxCkS5DjWxlpZP4gHlatv17cLB16sFNpMidjwmyszk+K
 i2F8iAJU7+byfCZJ3vldZObhxNsEODj9OSWr7RtmXM85BXgCGoCB/YzeZWz3OHZpBk
 6WSaIm00jrntw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2 2/2] drm/amd: fix HDMI signal type for EDID
 overrides
To: =?utf-8?b?Sm9oYW5uZXMgV8O8bGxlcg==?= <johanneswueller@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003161525.23600-3-johanneswueller@gmail.com>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
 <20261003161525.23600-3-johanneswueller@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:19 +0000
Message-Id: <20261003175619.722451F0089E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] amdgpu: missing EDID override check in rgb_output_is_limited_ran=
ge()
--

commit 8529835fe6f32deeb33be0fa62706033cd8f1243
Author: Johannes W=C3=BCller <johanneswueller@gmail.com>

    drm/amd: fix HDMI signal type for EDID overrides

This commit updates AMD display code to trust the physical connector type
over the EDID for HDMI capabilities when an EDID override is active. This
fixes cases where the overriding EDID does not advertise HDMI capabilities.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index ad3383169d83f..2bce57b060374 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -2134,7 +2134,14 @@ VISIBLE_IF_KUNIT void create_eml_sink(struct amdgp=
u_dm_connector *aconnector)
>  		return;
>  	}
> =20
> -	if (connector->display_info.is_hdmi)
> +	/*
> +	 * If an EDID override is active, it may not advertise HDMI capability
> +	 * even though the physical connector is HDMI. Trust the connector type.
> +	 */
> +	if (connector->display_info.is_hdmi ||
> +	    (connector->edid_overridden &&
> +	     (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
> +	      connector->connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIB)))

[Severity: Medium]
Does this same logic need to be applied to rgb_output_is_limited_range()
in the same file?

Looking at rgb_output_is_limited_range(), it relies directly on
display_info.is_hdmi to determine the default RGB range:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c:rgb_output_is_l=
imited_range()
{
	switch (connector_state->hdmi.broadcast_rgb) {
	...
	default:
		return connector_state->connector->display_info.is_hdmi &&
		       dc_crtc_timing->vic > 1;
}

If a user supplies an EDID override without HDMI capabilities for a physical
HDMI connector, display_info.is_hdmi evaluates to false here. This causes
the function to incorrectly default to Full Range RGB instead of Limited
Range RGB for standard TV formats (VIC > 1). This results in incorrect
color range output (crushed blacks and clipped whites).

Could this override check also be added to rgb_output_is_limited_range()
so TV formats correctly output limited range RGB?

>  		init_params.sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;
> =20
>  	aconnector->drm_edid =3D drm_edid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003161525.2360=
0-1-johanneswueller@gmail.com?part=3D2
