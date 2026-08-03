Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB00AC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C67810E776;
	Mon,  3 Aug 2026 18:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TUejm2+D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B80210E780
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:43:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3150641325;
 Mon,  3 Aug 2026 18:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561921F000E9;
 Mon,  3 Aug 2026 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785782596;
 bh=j0VZL6JhnPfBNF4P8887PVTU5xpaUqguwksk7tHuUnY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TUejm2+DBiDfTs7ui2RoxOVMV1Q71q8ZqWS9FXx99iycfuK3nNJV9GxzRwsgFaG4k
 n5Zbjt9XQ02mKQoErWiwcPu3CZjgAQj41JduLTKVvqvQoMLfvfuyE04CCVP88vlx0H
 rNUoXrP0mjjrJqqnJUIcYE+GJrrdQ4+cHHdXkTzVZSeoeT7xtM5dV6VfAIzAt4ppfk
 Z7dVzdhpVnhni17lq91PVUko9IE0sq3XcD4R3V9DKVHvn5lod7bNb3SuDDf67v9pRt
 pV21037Kf9GsYd7VVLKwo46yAHq7MRqymjVjUfE1sKPKZfcH7mhsBYz6+TGDmxNQk4
 +LsrBISRNrYnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/22] drm/bridge: synopsys: dw-dp: Support
 MEDIA_BUS_FMT_FIXED
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-10-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-10-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:43:14 +0000
Message-Id: <20260803184315.561921F000E9@smtp.kernel.org>
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
- [High] dw_dp_bridge_atomic_get_input_bus_fmts blindly propagates unsuppor=
ted formats, breaking bus format negotiation fallback.
--

--- Patch [10]: [PATCH v9 10/22] drm/bridge: synopsys: dw-dp: Support MEDIA=
_BUS_FMT_FIXED ---
commit 536f8f5a7df863a273e0062b67fbc6ca7b57d8a8
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED

Add support for MEDIA_BUS_FMT_FIXED, which is requested for USB-C DP
chains when the last bridge does not implement atomic_get_output_bus_fmts().
This resolves the output format by using the negotiated input format in=20
atomic_check and implements a custom atomic_get_input_bus_fmts hook.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index bde938b0d116d..e60dab0d3b9dd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1823,6 +1827,32 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmt=
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
> +}

[Severity: High]
This is a pre-existing issue, but since we are adding a custom
dw_dp_bridge_atomic_get_input_bus_fmts() hook here, does this code blindly
propagate downstream formats even if they aren't supported by the dw-dp
hardware?

If a downstream bridge proposes an unsupported preferred bus format,
propagating it directly via drm_atomic_helper_bridge_propagate_bus_fmt() ma=
kes
the format negotiation succeed prematurely. It seems this would skip testing
any valid fallback formats.

Later during the modeset, this results in a complete failure (a black scree=
n)
when dw_dp_bridge_atomic_check() checks if the negotiated format is actually
supported:

dw_dp_bridge_atomic_check() {
        ...
        fmt =3D dw_dp_get_output_format(out_bus_format);
        if (!fmt)
                return -EINVAL;
}

Should this new hook check if output_fmt is supported by dw-dp (e.g., verif=
ying
it exists in dw_dp_output_formats) before propagating it, to allow the brid=
ge
chain to properly negotiate a fallback format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D10
