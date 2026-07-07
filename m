Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8D3C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19AAF10EE3D;
	Tue,  7 Jul 2026 16:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VCiVWpHf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E8C10EE3D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FFA043435;
 Tue,  7 Jul 2026 16:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22321F000E9;
 Tue,  7 Jul 2026 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440237;
 bh=1RK/+oLFm7CJC0cfU5xLjI11OdM/Hz5v5vnIbkPsQ8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VCiVWpHfEEkeVSx1TtM+RZuZeidryVWyFhtWrLRrIHyhYG+OdwFTuNkFb4gJ8P0Tl
 QpxM2nmG0DczhMzBUuZZ2NAfW9AU8GbrY+t/XKHCNRSDSOp4649o2piw9AUoaRDlA9
 MGiWMq0O4eqQrgVc7LxmxIRs/MFeg45wA3ggVO3AV5oboOp3wo62Kx+GtRtyyKB0MO
 x6aaG5Bv77BMRFHbBZ1baWiuDwRxns4+FqFSb/mydjS+gMNu5NiE2/owiD54ui02Gi
 EkhO5OO3tF+UPvGhegpMbH13ESQN12/KcP1/3dQJC3gMAdfVNAEm1WFresNLMZr1oU
 ezUxu7YRIkefQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/12] phy: phy-mtk-dp: Add support for digital and
 analog calibration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, olteanv@gmail.com, linux-phy@lists.infradead.org
In-Reply-To: <20260707154245.198361-9-angelogioacchino.delregno@collabora.com>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:03:56 +0000
Message-Id: <20260707160356.D22321F000E9@smtp.kernel.org>
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
- [Medium] Unconditional `dev_err` logging in `mtk_dp_phy_get_one_cal_para(=
)` causes log spam for expected fallback cases (missing eFuses) and probe d=
eferrals.

Pre-existing issues:
- [High] Unconditional dereference of `dev->platform_data` in legacy probe =
before validating it is non-NULL.
--

--- Patch [8]: [PATCH v3 08/12] phy: phy-mtk-dp: Add support for digital an=
d analog calibration ---
commit 637b7b00f751ea110c4b395e4e951eecc2ab535e
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Add support for digital and analog calibration

Add support for reading the calibration values from eFuse: if
present, write those - otherwise, rely on the defaults from
SoC-specific data. This also adds support for writing the calibration
values for the analog part of the PHY.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index c87e9fa710a40..f59a415b401c5 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -422,6 +541,111 @@ static const struct phy_ops mtk_dp_phy_dev_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static void mtk_dp_phy_get_default_cal_data(struct mtk_dp_phy *dp_phy)
[ ... ]
> +static int mtk_dp_phy_get_one_cal_para(struct device *dev, const char *n=
ame, u8 max_val)
> +{
> +	u8 buf_byte;
> +	u16 buf;
> +	int ret;
> +
> +	/*
> +	 * All of the calibrations are always max 8 bits long, but some may
> +	 * be split between two different 8-bits cells: handle this corner
> +	 * case by retrying reading as u16.
> +	 */
> +	ret =3D nvmem_cell_read_u8(dev, name, &buf_byte);
> +	if (ret)
> +		ret =3D nvmem_cell_read_u16(dev, name, &buf);
> +	else
> +		buf =3D buf_byte;
> +
> +	if (ret) {
> +		dev_err(dev, "Cannot get calibration data for %s: %d\n", name, ret);
> +		return ret;
> +	};

[Severity: Medium]
Will this unconditionally log an error when calibration data is intentional=
ly
omitted or when the nvmem provider returns -EPROBE_DEFER?

If the calibration data is missing, nvmem_cell_read_u8() returns -ENOENT,
which is later handled gracefully by the caller by falling back to defaults.
However, printing dev_err() here will cause log spam and false-positive
errors in dmesg. Could this be silenced for -ENOENT and -EPROBE_DEFER cases?

> +
> +	if (buf =3D=3D 0) {
[ ... ]
> @@ -453,6 +677,13 @@ static int mtk_dp_phy_legacy_probe(struct platform_d=
evice *pdev, struct mtk_dp_p
>  				     "Failed to create DP PHY\n");
> =20
>  	phy_set_drvdata(phy, dp_phy);

[Severity: High]
This is a pre-existing issue, but earlier in mtk_dp_phy_legacy_probe(),
does the code unconditionally dereference dev->platform_data before checking
if it is NULL?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_legacy_probe() {
    ...
	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;
	if (!dp_phy->regmap)
		return dev_err_probe(dev, -EINVAL, "No platform data available\n");
    ...
}

If the platform device is instantiated without platform data,
*(struct regmap **)NULL results in an immediate kernel panic, making the
subsequent check dead code.

> +
> +	/*
> +	 * Set default calibration data before exposing the PHY.
> +	 * For legacy probe, mtk_dp will set calibrations from eFuse, if found.
> +	 */
> +	mtk_dp_phy_get_default_cal_data(dp_phy);
> +
>  	ret =3D phy_create_lookup(phy, "dp", dev_name(dev));
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707154245.1983=
61-1-angelogioacchino.delregno@collabora.com?part=3D8
