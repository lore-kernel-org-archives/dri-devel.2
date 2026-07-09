Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B09C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2E310EA3C;
	Thu,  9 Jul 2026 10:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dsM4Ej0Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEBF10EA3C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:42:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 226A3601D9;
 Thu,  9 Jul 2026 10:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F2C1F000E9;
 Thu,  9 Jul 2026 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783593750;
 bh=+dgR4rJQSnbnutQZ8qvfq9w6PhvECejCMiZqrfMb6no=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dsM4Ej0Q8ceY+XID9zup4NKbc4ENvAZpuIvMaNpAnSC6dOdUwWtpa+af46t7H/sM1
 bhcxF3LkE4BlVxgIabXnnX7Er7VKwSdsJfVs7oARIrGXcYzaN6k4EbTYK3xbZGvs/4
 Wy/hwVdt1LVsWiVn4yQruHzKV9nf8aaFmoCXhOl+WYAww+E/ZIYMhbMBk8DfIE3FVk
 on6+afPbzOf+X3Dy7YpuXzBjBjccP3xm0N79StWB25xgZg8LWh9UWo9RPxuQQzvznP
 HjvkOej99/T7wljpSR63OmeY1GKUY2wPri4ZXuwBp/x3/9dRfYvMPyrxLqB16Fe1wr
 V29ORFbGe1Hzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/11] drm/mediatek: mtk_dp: Clarify XTAL freq and
 Debounce registers
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260709103431.46616-12-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:42:29 +0000
Message-Id: <20260709104230.81F2C1F000E9@smtp.kernel.org>
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
- [Medium] The patch silently fixes a register programming bug, changing th=
e programmed HPD interrupt debounce thresholds, despite the commit message =
claiming 'the only purpose of increasing human readability'.
- [Low] Unused legacy macros were left in the header file after their usage=
 was removed.
--

--- Patch [11]: [PATCH v3 11/11] drm/mediatek: mtk_dp: Clarify XTAL freq an=
d Debounce registers ---
commit a0d0ec4a08e7bb60a4d55891bd6e55ba3b2ab740
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Clarify XTAL freq and Debounce registers

This patch refactors the initialization of the crystal frequency and
transmitter interrupt debounce registers in the MediaTek DP driver to
use FIELD_PREP_CONST for better readability.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 868d918a0b161..4403a25784d4e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

> @@ -1260,28 +1266,29 @@ static void mtk_dp_initialize_aux_hpd_detect_sett=
ings(struct mtk_dp *mtk_dp)
> =20
>  static void mtk_dp_initialize_hpd_detect_settings(struct mtk_dp *mtk_dp)
>  {
> -	u32 val;
> -
>  	/* Mask AUX TOP interrupt, as this uses transmitter for HPD */
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_IRQ_MASK,
>  			   AUX_TOP_IRQ_MSK, AUX_TOP_IRQ_MSK);
> =20
> -	/* Debounce threshold */
> +	/* Set Hotplug debounce threshold time: xtal_period * deb_thd */
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
>  			   8, HPD_DEB_THD_DP_TRANS_P0_MASK);
> =20
> -	val =3D (HPD_INT_THD_DP_TRANS_P0_LOWER_500US |
> -	       HPD_INT_THD_DP_TRANS_P0_UPPER_1100US) << 4;
> -	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
> -			   val, HPD_INT_THD_DP_TRANS_P0_MASK);
> -
>  	/*
> -	 * Connect threshold 1.5ms + 5 x 0.1ms =3D 2ms
> -	 * Disconnect threshold 1.5ms + 5 x 0.1ms =3D 2ms
> +	 * Set interrupt debounce threshold time
> +	 * VAL  |  0     1     2     3  INT_THD
> +	 * Low  | 100   300   500   700 uS
> +	 * High | 700   900  1100  1300 uS
>  	 */
> -	val =3D (5 << 8) | (5 << 12);
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
> -			   val,
> +			   FIELD_PREP_CONST(HPD_INT_LOW_THD_DP_TRANS_P0_MASK, 2) |
> +			   FIELD_PREP_CONST(HPD_INT_HIGH_THD_DP_TRANS_P0_MASK, 2),
> +			   HPD_INT_THD_DP_TRANS_P0_MASK);

[Severity: Medium]
The commit message states the patch has "the only purpose of increasing hum=
an
readability", but does this actually fix a bug in the old code?

The original code calculated the values with an extra shift:

val =3D (HPD_INT_THD_DP_TRANS_P0_LOWER_500US |
       HPD_INT_THD_DP_TRANS_P0_UPPER_1100US) << 4;

Since those macros were already shifted by 4 and 6, the extra shift by 4
resulted in val =3D 0xA00. When updated with the 0xF0 mask, this effectively
wrote 0 to the register. The new code correctly programs 0xA0.

Could the commit message be updated to mention this functional change?

> +
> +	/* Connection and Disconnection thresholds: 1.5ms + (5 x 0.1) ms =3D 2m=
s */
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,

[ ... ]

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/medi=
atek/mtk_dp_reg.h
> index 9caf743f4fe61..ce47b99dddc43 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> @@ -253,6 +253,8 @@
>  #define MTK_DP_TRANS_P0_3410				0x1410
>  #define HPD_DEB_THD_DP_TRANS_P0_MASK				GENMASK(3, 0)
>  #define HPD_INT_THD_DP_TRANS_P0_MASK				GENMASK(7, 4)
> +#define HPD_INT_HIGH_THD_DP_TRANS_P0_MASK			GENMASK(7, 6)
> +#define HPD_INT_LOW_THD_DP_TRANS_P0_MASK			GENMASK(5, 4)
>  #define HPD_INT_THD_DP_TRANS_P0_LOWER_500US			(2 << 4)
>  #define HPD_INT_THD_DP_TRANS_P0_UPPER_1100US			(2 << 6)

[Severity: Low]
This isn't a bug, but are these legacy macros still needed?

The code no longer uses HPD_INT_THD_DP_TRANS_P0_LOWER_500US or
HPD_INT_THD_DP_TRANS_P0_UPPER_1100US after this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D11
