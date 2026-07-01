Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EBBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB2710E368;
	Wed,  1 Jul 2026 12:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NY3GhXKW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F3E10E368
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:45:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E6A0439D4;
 Wed,  1 Jul 2026 12:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18101F000E9;
 Wed,  1 Jul 2026 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909952;
 bh=1GO6ydZbEiHirUzvJuXmFMdY6V9tQKNrQJlx+7Dg8Wc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NY3GhXKWxKbP8dUQH7uZ1WC/akCdmzTiykRqxN8+IsZByOLjfCgHoiLZKyfE7B8Tu
 NfZ/KEhoZjLUBoiTvhCwmICNbM5c4HVH5Uq7FonSUhnYZ9SPxy6CUo6T9TWjLCf8kT
 QL5RHFDawyt+MwNhSckF9SJQ4WvWM4SR4kuk6pt8qqNdPTBeKhEbk9k6Vch4mJqHF/
 XJzIrOkeWcebnXoVN6X44ft3ga23tW3WAzq+e50EYIC9peEHMMj33MeEzCtmsWxyzL
 qOPs1jiOL48g7NvezIknNOn/+hbSNb3x5BMXR1wm+7/mKtBsZypTiHPJB3eP6fUwST
 OuyFOalOtV1Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] drm/mediatek: mtk_dp: Rework register offsets for
 proper PHY usage
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260701122024.19557-6-angelogioacchino.delregno@collabora.com>
References: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
 <20260701122024.19557-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:45:52 +0000
Message-Id: <20260701124552.A18101F000E9@smtp.kernel.org>
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
- [High] Writes to PHY registers are incorrectly offset by `legacy_regoff` =
(0x2000), corrupting DP IP registers and breaking PHY configuration.
- [Medium] Removed bit shifts from PIXEL_ENCODE_FORMAT enums cause YCbCr co=
lor formats to silently fall back to RGB.
--

commit ef9afa51895ca44a0e35947eba008bc8a9868897
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Rework register offsets for proper PHY usage

This commit subtracts the DP PHY register range from the MediaTek DisplayPo=
rt
IP register range. It prepares the driver for PHY registration from devicet=
ree
by moving the top offset into the driver structure and out of the legacy re=
gmap
configuration.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index f551c4543f4ee..97bce8966a1f3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -424,7 +448,7 @@ static u32 mtk_dp_read(struct mtk_dp *mtk_dp, u32 off=
set)
> =20
>  static int mtk_dp_write(struct mtk_dp *mtk_dp, u32 offset, u32 val)
>  {
> -	int ret =3D regmap_write(mtk_dp->regs, offset, val);
> +	int ret =3D regmap_write(mtk_dp->regs, offset + mtk_dp->legacy_regoff, =
val);
> =20
>  	if (ret)
>  		dev_err(mtk_dp->dev,
> @@ -436,7 +460,7 @@ static int mtk_dp_write(struct mtk_dp *mtk_dp, u32 of=
fset, u32 val)
>  static int mtk_dp_update_bits(struct mtk_dp *mtk_dp, u32 offset,
>  			      u32 val, u32 mask)
>  {
> -	int ret =3D regmap_update_bits(mtk_dp->regs, offset, mask, val);
> +	int ret =3D regmap_update_bits(mtk_dp->regs, offset + mtk_dp->legacy_re=
goff, mask, val);
[ ... ]
> @@ -1401,7 +1425,7 @@ static void mtk_dp_power_enable(struct mtk_dp *mtk_=
dp)
>  			   SW_RST_B_PHYD, SW_RST_B_PHYD);
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
>  			   DP_PWR_STATE_BANDGAP_TPLL, DP_PWR_STATE_MASK);
> -	mtk_dp_write(mtk_dp, MTK_DP_1040,
> +	mtk_dp_write(mtk_dp, DP_PHY_AUX_RX_CTL,
>  		     RG_DPAUX_RX_VALID_DEGLITCH_EN | RG_XTP_GLB_CKDET_EN |
>  		     RG_DPAUX_RX_EN);

[Severity: High]
Does this code inadvertently misdirect PHY register accesses and corrupt
encoder state?

When legacy devicetrees are used, mtk_dp->legacy_regoff is set to 0x2000.
Because the accessor functions like mtk_dp_write() and mtk_dp_update_bits()
now unconditionally add mtk_dp->legacy_regoff, calls using legacy PHY
registers will be offset incorrectly.

For example, when mtk_dp_power_enable() calls mtk_dp_write() with
DP_PHY_AUX_RX_CTL (which is 0x1040), the write will actually go to 0x3040.
This leaves the PHY unconfigured and silently overwrites the DP encoder
register MTK_DP_ENC0_P0_3040 instead.

[ ... ]
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/medi=
atek/mtk_dp_reg.h
> index 8ad7a9cc259eb..616ea6440b08d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
[ ... ]
> @@ -130,34 +106,36 @@
>  #define VIDEO_COLOR_DEPTH_DP_ENC0_P0_8BIT		(3 << 8)
>  #define VIDEO_COLOR_DEPTH_DP_ENC0_P0_6BIT		(4 << 8)
>  #define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_MASK		GENMASK(14, 12)
> -#define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RGB		(0 << 12)
> -#define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422		(1 << 12)
> -#define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR420		(2 << 12)
> +#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RGB		0
> +#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422	1
> +#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR420	2
> +#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YONLY		3
> +#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RAW		4

[Severity: Medium]
Will this change cause YCbCr color formats to silently fall back to RGB?

The bit shifts were removed from these format definitions, but the usage
site in mtk_dp_set_color_format() passes these values directly to
mtk_dp_update_bits() alongside the PIXEL_ENCODE_FORMAT_DP_ENC0_P0_MASK,
which is GENMASK(14, 12).

Because regmap_update_bits() internally applies the mask to the value, an
unshifted value like PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422 (1) combined
with the mask (0x7000) evaluates to 0. This clears the color format bits
entirely and forces the hardware to output in RGB mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122024.1955=
7-1-angelogioacchino.delregno@collabora.com?part=3D5
