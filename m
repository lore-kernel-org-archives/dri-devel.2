Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F89AC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A8A10E17E;
	Tue,  7 Jul 2026 14:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DqCm9TTS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9207F10E17E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:31:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF74660018;
 Tue,  7 Jul 2026 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED6D1F000E9;
 Tue,  7 Jul 2026 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434701;
 bh=sXLtoFh+CUx/tyfknuCX6sDSL7lW5AVQhCz46fBe5Z8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DqCm9TTSRnjxgTDqvZLTzlbf+jBcUzL1dbxvpHlLC55R01QgjDSm6re/6WyQYSbY8
 7sPl7sjWOOCqHzNdvZJPl3QKzuwSu0G6dz4O3HFu9U4q0U8H2A8SLra8KN2ETroNVE
 sGKhiGuDnb9yW3K5QoDoiykk7uS2lQi5XPIMAqHzCBhPh5gHkbfZst050xznKivXIe
 /fOZSsJGtEmw/7AJpyESlVekLUhO2L9UeBdzHZgPY2jPUAd2HUj5DbdT+mgfw5gdlG
 CiICXWYkdyeW8KznU8TW4P0HI0sLp0Xh0LFrn0TwDgpKg1I1srqpOpAzRhDSMzVEZa
 rwC7hqPxbTMnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] phy: phy-mtk-dp: Add support for digital and
 analog calibration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, olteanv@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260707141931.191172-9-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:31:40 +0000
Message-Id: <20260707143140.BED6D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The DP PHY is published and exposed to concurrent consumers before=
 its calibration data is initialized in the legacy probe path.
- [Medium] Unconditional `dev_err` logs an error for missing optional NVMEM=
 cells and probe deferrals in `mtk_dp_phy_get_one_cal_para`.

Pre-existing issues:
- [High] Dereferencing `dev->platform_data` without checking for NULL in `m=
tk_dp_phy_legacy_probe`.
--

--- Patch [8]: [PATCH v2 08/12] phy: phy-mtk-dp: Add support for digital an=
d analog calibration ---
commit 0db0b57c522a5f7eb7d179aeee49708015901046
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Add support for digital and analog calibration

This commit adds support for reading DP PHY calibration values from eFuse
via nvmem. If the values are present, they are applied; otherwise, the
driver relies on default calibration data. Analog calibration writing
support is also introduced.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

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
Will this unconditionally log a hard error if the NVMEM cells are absent
or if the provider returns -EPROBE_DEFER?

Since nvmem_cell_read_u8() returns -ENOENT when optional cells are missing
in the device tree, could this cause spurious error messages in the kernel
log on normal boots? It might also spam the logs during standard probe
deferrals.

[ ... ]

> @@ -444,6 +671,8 @@ static int mtk_dp_phy_legacy_probe(struct platform_de=
vice *pdev, struct mtk_dp_p
>  	if (ret)
>  		return ret;
> =20
> +	mtk_dp_phy_get_default_cal_data(dp_phy);
> +
>  	return 0;
>  }

[Severity: High]
Is it safe to publish the PHY to consumers before the calibration defaults
are initialized?=20

Earlier in mtk_dp_phy_legacy_probe(), phy_create_lookup() exposes the PHY.
If a consumer driver probes concurrently and acquires the PHY right after
that lookup registration, could it call phy_init() while the analog
parameter registers are still zero-initialized by devm_kzalloc(), rather
than having these defaults?

[Severity: High]
This is a pre-existing issue, but can dev->platform_data be NULL earlier
in mtk_dp_phy_legacy_probe()?

Looking at the start of the function:

	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;
	if (!dp_phy->regmap)
		return dev_err_probe(dev, -EINVAL, "No platform data available\n");

If the driver is bound to a device without platform data (e.g. manually
via sysfs bind), it looks like dereferencing dev->platform_data to read
the regmap will cause a kernel panic before it reaches the NULL check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D8
