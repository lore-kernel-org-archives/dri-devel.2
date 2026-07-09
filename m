Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97980C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E375510F51E;
	Thu,  9 Jul 2026 11:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hQ/iIIEx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9D310F51E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:56:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C01540266;
 Thu,  9 Jul 2026 11:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD871F000E9;
 Thu,  9 Jul 2026 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598174;
 bh=g2JA8bSYp870WSG3rBuZfD9QcY1pOJxtnPU3niKAy+Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hQ/iIIExcbxwa1O7MBXKTdw7I2cHP5MMN4lCBD/JkPW32VREOl1+0zn8XzZDLinc6
 +qXFKwqVwQOq50BUJ9AYfp6Z70LxDZxqvVMAzBENKKaeyVEvXmozKImnz3dqRn+N1l
 bAnzKfpRDIS3yvFiw0oaTDGJ6hIhYJEf35qpVDfeGb+Jzp6dsqB2uN1J9bsLHMrcnJ
 rlZcljfFMbVdJojBd+aXnQt4js0X6wJ1GUYPPtsK2J7XhYXRX6tLUGUeAwSghU4ers
 OD8V8qIMx45xgGsGzEzmcsJeeWKyNIfUCXbclYRGZ/XYoW89yWLbPa3Np97cAFfIHv
 5X6fPyaxrGIZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] drm/mediatek: mtk_dp: Clarify XTAL freq and
 Debounce registers
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260709100617.42583-12-angelogioacchino.delregno@collabora.com>
References: <20260709100617.42583-1-angelogioacchino.delregno@collabora.com>
 <20260709100617.42583-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:56:14 +0000
Message-Id: <20260709115614.9BD871F000E9@smtp.kernel.org>
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
- [Medium] Undocumented functional hardware configuration change fixing a p=
re-existing double-shift bug
- [Low] Unused legacy macros left in the header file
--

--- Patch [11]: [PATCH v2 11/11] drm/mediatek: mtk_dp: Clarify XTAL freq an=
d Debounce registers ---
commit 6c2235134edb8d6bc77df71eedc7aaac802ae5fa
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Clarify XTAL freq and Debounce registers

This commit updates the construction of crystal frequency and transmitter
interrupt debounce register values to use FIELD_PREP_CONST() with new
mask definitions. The commit message states the only purpose is to increase
human readability.

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
[ ... ]
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
Is the commit message description accurate regarding the "only purpose of
increasing human readability"?

This patch appears to introduce a functional hardware configuration change.

In the previous code, HPD_INT_THD_DP_TRANS_P0_LOWER_500US and
HPD_INT_THD_DP_TRANS_P0_UPPER_1100US were defined with shifts of 4 and 6,
and then shifted again by 4 in mtk_dp_initialize_hpd_detect_settings().

This resulted in the value being completely masked out by
HPD_INT_THD_DP_TRANS_P0_MASK, writing 0 to the register.

The new FIELD_PREP_CONST implementation correctly constructs the value 0xA0
and writes it to the hardware.

Since this silently fixes a pre-existing double-shift bug and alters the
actual hardware behavior, should this functional change be explicitly
documented or split into a dedicated fix patch?

> +
> +	/* Connection and Disconnection thresholds: 1.5ms + (5 x 0.1) ms =3D 2m=
s */
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
> +			   FIELD_PREP_CONST(HPD_DISC_THD_DP_TRANS_P0_MASK, 5) |
> +			   FIELD_PREP_CONST(HPD_CONN_THD_DP_TRANS_P0_MASK, 5),
>  			   HPD_DISC_THD_DP_TRANS_P0_MASK |
>  			   HPD_CONN_THD_DP_TRANS_P0_MASK);
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3430,
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
Should these old _500US and _1100US macros be removed?

They appear to be unused dead code now that the configuration in
mtk_dp_initialize_hpd_detect_settings() has been updated to use the new
masks with FIELD_PREP_CONST.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709100617.4258=
3-1-angelogioacchino.delregno@collabora.com?part=3D11
