Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40054C56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E8B10F26F;
	Thu,  6 Aug 2026 17:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dTXyvhgy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2238C10F26F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:33:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1521413C8;
 Thu,  6 Aug 2026 17:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401D21F000E9;
 Thu,  6 Aug 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786037609;
 bh=7jpt+YYle2i3ytz3HquKvnqOm99pkDhpVR/2TkX5Ex8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dTXyvhgyVbBqBpKV+iGNxw3np1QamIQbeZrQUSh6iBqvFDysCZhwRY3PvnmdNPGfm
 3WZV4SPm6F9DetLw0auOwJBiXZVq/Z/xLrjtO3x798TJ5c+Xjp6GFOk3BMP+hJIOPe
 7fDdr54x3c46u4Yqq+9bZd3hPLljhoHJpEARdm5mWzUC9Ui38igv/xRmW1DOlPvhGf
 boVX3kUo3LgwLw+GYFOXY37QAXsgHoY690N15KoT75SS4G5B7Za/d0KDeka0R1Gbyx
 /DAiuNx4K0MnsxT2ydxf3NkQPUPX9wKIlBn4cbQPelUVlV/yoYfdN6tkrpYETvxJWn
 7sRpDnWXGqOwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/21] drm/bridge: synopsys: dw-dp: Support
 MEDIA_BUS_FMT_FIXED
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-9-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-9-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:33:28 +0000
Message-Id: <20260806173329.401D21F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The DW DP bridge accepts explicitly negotiated output bus formats =
without verifying if the resulting bit-per-pixel (BPP) exceeds the DP link =
bandwidth.
--

--- Patch [9]: [PATCH v11 09/21] drm/bridge: synopsys: dw-dp: Support MEDIA=
_BUS_FMT_FIXED ---
commit 8f5ee9653fefa35534059addf0b8fba75d680cad
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED

This commit adds support for MEDIA_BUS_FMT_FIXED for USB-C DP chains where
the final bridge does not implement atomic_get_output_bus_fmts(). It updates
atomic_check to resolve the output format from the negotiated input format,
and adds a custom .atomic_get_input_bus_fmts hook to advertise all
bandwidth-validated formats when FIXED is used.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index d35dcd4a413f7..b9864a17c01d0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1830,6 +1834,32 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmt=
s(struct drm_bridge *bridge,
>  	return output_fmts;
>  }
> =20
> +static u32 *
> +dw_dp_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> +				       struct drm_bridge_state *bridge_state,
> +				       struct drm_crtc_state *crtc_state,
> +				       struct drm_connector_state *conn_state,
> +				       u32 output_fmt,
> +				       unsigned int *num_input_fmts)
> +{
> +	/*
> +	 * MEDIA_BUS_FMT_FIXED means the downstream bridge does not constrain
> +	 * the bus format. In that case, advertise all formats supported by the
> +	 * DP link so the upstream encoder can negotiate the best match.
> +	 */
> +	if (output_fmt =3D=3D MEDIA_BUS_FMT_FIXED)
> +		return dw_dp_bridge_atomic_get_output_bus_fmts(bridge,
> +							       bridge_state,
> +							       crtc_state,
> +							       conn_state,
> +							       num_input_fmts);
> +
> +	return drm_atomic_helper_bridge_propagate_bus_fmt(bridge, bridge_state,
> +							 crtc_state, conn_state,
> +							 output_fmt,
> +							 num_input_fmts);

[Severity: High]
This is a pre-existing issue, but does propagating the downstream format
unconditionally bypass bandwidth checks?

When output_fmt is not MEDIA_BUS_FMT_FIXED, it is propagated directly. Then
later in dw_dp_bridge_atomic_check(), the corresponding BPP is assigned
to the state:

    fmt =3D dw_dp_get_output_format(out_bus_format);
    if (!fmt)
        return -EINVAL;
   =20
    ...
    state->bpp =3D fmt->bpp;

It appears the format's BPP is assigned without validating it against the DP
link capabilities. If a downstream display requests an explicit, high-BPP
format (e.g., 36-bpp RGB) that exceeds the link's maximum bandwidth for the
selected resolution, could this cause the driver to accept an unsupported
configuration?

If the atomic check succeeds but the hardware lacks the bandwidth, would th=
is
result in a failure to transmit the video stream, causing a blank screen or
link training failure?=20

Should the explicitly negotiated format be validated against link bandwidth
limits here or in atomic_check?

> +}
> +
>  static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(stru=
ct drm_bridge *bridge)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D9
