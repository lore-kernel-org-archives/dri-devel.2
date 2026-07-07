Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA42C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA63310ED52;
	Tue,  7 Jul 2026 14:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BosXBH9r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365E110ED52
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:27:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEFF26138A;
 Tue,  7 Jul 2026 14:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03021F00AC4;
 Tue,  7 Jul 2026 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434434;
 bh=9ejetAl8MzDSoFJYgSbHLvtbPxpoS6PlRJW41QuvIVs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BosXBH9rxDr4wDdzAsIV/yyFwkLkT8dXAnXvl3sUysQ1HPPsxjVNQOsIuvaunYhQF
 j5FYwA/BVxVTU9wn3cmScF4NKsbDF/VG09DmkdhmnikWggql1pv8XBSXhLxzewdkYD
 OQ5MMrq1t9zeATktAKdhwFdB/6nPRfJHOYYqE+SEqS9mVJ0cVPgQdZEPECZFG6toSS
 MYWaNf6n1SeAUYfSSKfEIGKAB+qVFR9SDmvaCws1KpNBtBzwQIlTcMD1L+ewrHw79F
 nIxjSQsLRfv1l1OqA6yBL0OHiDNVLIvb3g/HErKa6p8ZkmCz/SpfSx41db8XSvolgV
 RtZfq7lTtOyGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] phy: phy-mtk-dp: Rename regs to regmap in
 struct mtk_dp_phy
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, neil.armstrong@linaro.org, robh@kernel.org
In-Reply-To: <20260707141931.191172-3-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:27:13 +0000
Message-Id: <20260707142713.D03021F00AC4@smtp.kernel.org>
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
- [High] Missing NULL check for `dev->platform_data` before dereferencing i=
t in `mtk_dp_phy_probe`.
--

--- Patch [2]: [PATCH v2 02/12] phy: phy-mtk-dp: Rename regs to regmap in s=
truct mtk_dp_phy ---
commit b41d4072a9780ff4f56cf8b17085088b1f2777ae
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Rename regs to regmap in struct mtk_dp_phy

This commit renames the regs member of struct mtk_dp_phy to regmap to
improve readability and align with common kernel driver naming conventions.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index d7024a1443358..bf7b3a95e72d2 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -176,7 +176,7 @@ static int mtk_dp_phy_probe(struct platform_device *p=
dev)

[Severity: High]
This is a pre-existing issue, but does mtk_dp_phy_probe() lack a NULL check=
=20
for dev->platform_data before dereferencing it?

If the platform device is probed without platform_data (for example, if=20
manually bound via the sysfs bind interface to a generic platform device=20
lacking this data), dev->platform_data will be NULL.

Looking at the code in mtk_dp_phy_probe():

    regs =3D *(struct regmap **)dev->platform_data;
    if (!regs)
        return dev_err_probe(dev, -EINVAL, ...

Dereferencing dev->platform_data to assign regs before checking if=20
platform_data itself is valid will cause a kernel oops.

>  	if (!dp_phy)
>  		return -ENOMEM;
> =20
> -	dp_phy->regs =3D regs;
> +	dp_phy->regmap =3D regs;
>  	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
>  	if (IS_ERR(phy))
>  		return dev_err_probe(dev, PTR_ERR(phy),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D2
