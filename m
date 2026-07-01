Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1512FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4E810EDC8;
	Wed,  1 Jul 2026 06:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gbplk+Vg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D5310EDC8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:51:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53C48412D9;
 Wed,  1 Jul 2026 06:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4751F00A3D;
 Wed,  1 Jul 2026 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782888705;
 bh=T5/H3qvyA0XBwexK+YYaYKHciwIayJUlbQWsWcpgL5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gbplk+VgKjQ9pkZBFRXRp8Oj2AmdVcOJEzJqGiZz0isT3W2NpYud9BTekj4gZDeSC
 /UimOR2TocAeQK5FlGXcpaunzC5u7hgiMBsItp2sPcz2CcIkoJ02VKBtfS6c0GpDXE
 Q+xMPp/zeETBZXGFgRxUcN5zDy79xGeg2Lh6/hSKmQUjvEcwXjvcqnOqG7MtZ2aPDC
 oVjZDm1wMXI39hNtUX+IKYcjaX9yPKYnlTIirN4GUoPs6w3A60LsBgt4RP7igGgwGJ
 LgwnkjJhbIWA292ms9luNflFQhGWnXhDUHDUWjKx+If8bU6bWM2NcZmRAHgaUXUp8D
 bJ9n2oqoJ9t9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/tidss: Fix synclost issue while disabling layer
 due to erratum i2097
To: "Yashas D" <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701063337.2165966-1-y-d@ti.com>
References: <20260701063337.2165966-1-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:51:44 +0000
Message-Id: <20260701065145.0D4751F00A3D@smtp.kernel.org>
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
- [Medium] The workaround for erratum i2097 incorrectly moves disabled laye=
rs to (-1, -1) on-screen instead of a non-visible off-screen area, causing =
a visual glitch.
--

commit 80e2da1fc464e6c124d0362e7f424161a94f05ab
Author: Yashas D <y-d@ti.com>

drm/tidss: Fix synclost issue while disabling layer due to erratum i2097

A gap beyond a frame duration for disabling the layer in overlay manager
and go bit setting on the corresponding video port may lead to SYNC_LOST.
Fix by moving the layer to the non-visible area and deferring the ENABLE=3D0
write, immediately before the GO bit, guaranteeing both occur within the
same frame window.

Link: https://www.ti.com/lit/pdf/sprz530 # i2097

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 58d5eb033bdbb..02a3cf50e0ceb 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -38,6 +38,8 @@
>  #include "tidss_dispc_regs.h"
>  #include "tidss_scale_coefs.h"
> =20
> +#define OVR_LAYER_MAX_POS(mask)		FIELD_MAX(mask)
> +
>  static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] =3D {
>  	[DSS_REVISION_OFF] =3D                    0x00,

[ ... ]

> @@ -1503,6 +1565,53 @@ void dispc_ovr_enable_layer(struct dispc_device *d=
ispc,
>  	if (dispc->feat->subrev =3D=3D DISPC_K2G)
>  		return;
> =20
> +	if (dispc->errata.i2097 && !enable) {
> +		/*
> +		 * WA for erratum i2097:
> +		 *
> +		 * Do not write ENABLE=3D0 directly. Instead move the layer to
> +		 * the non-visible area so it contributes no pixels.
> +		 *
> +		 * Position register layout differs per SoC:
> +		 *   J721E : DISPC_OVR_ATTRIBUTES2, X[13:0],  Y[29:16] (14-bit)
> +		 *   Others: DISPC_OVR_ATTRIBUTES,  X[17:6],  Y[30:19] (12-bit)
> +		 */
> +		switch (dispc->feat->subrev) {
> +		case DISPC_J721E:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSY_MASK);
> +			break;
> +		default:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSX_MASK);

[Severity: Medium]
Will this move the disabled layer to position (-1, -1) rather than a
non-visible off-screen area?

If the hardware interprets the POSX and POSY register bitfields as signed
integers (two's complement), setting the coordinates using OVR_LAYER_MAX_POS
which evaluates to FIELD_MAX(mask) (an all-ones bit pattern) will result
in -1.

This could cause a visual glitch where the disabled layer flashes at the
top-left corner of the screen instead of being hidden.

Does OVR_LAYER_MAX_POS in dispc_ovr_enable_layer() need to avoid setting the
sign bit to properly move the layer off-screen during normal KMS operations?

> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSY_MASK);
> +			break;
> +		}
> +
> +		dispc->pending_disable_layers[hw_videoport] |=3D BIT(layer);
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701063337.2165=
966-1-y-d@ti.com?part=3D1
