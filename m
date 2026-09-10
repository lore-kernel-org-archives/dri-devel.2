Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E492C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B35F10F3D4;
	Thu, 10 Sep 2026 09:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SJmbuNz7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC9F10F3D2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:40:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 080D0600C8;
 Thu, 10 Sep 2026 09:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D43B1F00893;
 Thu, 10 Sep 2026 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789033236;
 bh=AblW3HlTcp2X4Z5WQJdWAiSLo3aOKERwFEQ7DNGb/ec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SJmbuNz7WTDohsb9LlJdSIA4T3Iwlqm5d/cnr7NNoZ/cZ92YpeTDFEmUsJqvCGqfR
 za57psQLY6k54BwvjVAhXP1WBxPbf+g7l3M/qeMVZF0nOzBBJreA4Ho88OeX1+5muh
 eg7PDIROLPLmLp6XkzojuhyK6JGe5/tQsM9HOqhOVDyn+JoVrBkc5WQaVTwPJynSN4
 CHS2HBKz4T8oSBcSgvDTxX2u9qDuyyTQ3R2NuhhHs35iK61JoGX2ADifXgCahdnyVf
 NQmBXM0MVMaVvdwyfI3/iTlZIRvb581Lg5t0kWgbTVgPc+Ks4dC33rA9pXS+xCxCAN
 nyOx1jfVXgbSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] phy: phy-mtk-dp: Migrate register offsets to
 SoC specific pdata
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, olteanv@gmail.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, vkoul@kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910092038.48291-5-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
 <20260910092038.48291-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:40:35 +0000
Message-Id: <20260910094036.3D43B1F00893@smtp.kernel.org>
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
- [High] Missing NULL check for `device_get_match_data()` leads to a NULL p=
ointer dereference on manual sysfs bind.
- [High] Overlapping devicetree reg property and hardcoded offset prevents =
successful DT probe.

Pre-existing issues:
- [High] Potential NULL pointer dereference when accessing `dev->platform_d=
ata` prior to validation.
--

commit 6b41d18c7c7f31b8549b66b4262af72e2486491d
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata
   =20
In preparation for adding support for newer SoCs and for adding
more capabilities to this driver in an efficient manner, migrate
all of the hardcoded register offsets to SoC specific pdata and
assign that for both DT and platform probing.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index d241004e28286..20974650d9409 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -170,12 +241,19 @@ static void mtk_dp_phy_legacy_remove_lookup(void *d=
ata)
>  	phy_remove_lookup(phy, "dp", dev_name(dp_phy->dev));
>  }
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data;
> +
>  static int mtk_dp_phy_legacy_probe(struct platform_device *pdev, struct =
mtk_dp_phy *dp_phy)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct phy *phy;
>  	int ret;
> =20
> +	/*
> +	 * If legacy platform driver probe, assume this is MT8195 or compatible
> +	 * with a devicetree that was not migrated to the new, proper bindings.
> +	 */
> +	dp_phy->pdata =3D &mt8195_dp_phy_data;
>  	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;
>  	if (!dp_phy->regmap)
>  		return dev_err_probe(dev, -EINVAL, "No platform data available\n");

[Severity: High]
This isn't a bug introduced by this patch, but can this dereference
dev->platform_data before checking if it is NULL?

If the driver is manually bound via sysfs or a module without platform data
provided, it looks like it would crash immediately here:

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_legacy_probe() {
    ...
	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;
	if (!dp_phy->regmap)
		return dev_err_probe(dev, -EINVAL, "No platform data available\n");
    ...
}

[ ... ]
> @@ -235,6 +313,8 @@ static int mtk_dp_phy_probe(struct platform_device *p=
dev)
>  	if (ret)
>  		return ret;
> =20
> +	dp_phy->pdata =3D device_get_match_data(dev);
> +
>  	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
>  	if (IS_ERR(phy))
>  		return dev_err_probe(dev, PTR_ERR(phy),

[Severity: High]
Could this result in a NULL pointer dereference?

If the driver is manually bound (e.g., via driver_override in sysfs) to a
device that possesses an of_node but does not match any entry in
mtk_dp_phy_of_match, device_get_match_data() will return NULL.

This NULL pointer would later be dereferenced when accessing dp_phy->pdata
in mtk_dp_phy_init().

[ ... ]
> @@ -249,8 +329,15 @@ static int mtk_dp_phy_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data =3D {
> +	.off_dig_glb =3D 0x1000,
> +	.off_dig_lane =3D (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },
> +	.regs_dig_glb =3D mt8195_phy_dig_glb_regs,
> +	.regs_dig_lane =3D mt8195_phy_dig_lane_regs,
> +};
> +

[Severity: High]
Will these hardcoded offsets prevent a successful devicetree probe?

The driver maps its devicetree reg resource using
devm_platform_ioremap_resource() in mtk_dp_phy_probe():

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_probe() {
    ...
	base =3D devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(base))
		return PTR_ERR(base);
    ...
}

If the DT reg maps the specific PHY region, the driver will still add
0x1000 to the mapped base, accessing unmapped physical memory.=20

If the DT reg maps the entire DP controller region to make the offsets work,
devm_platform_ioremap_resource() will fail with -EBUSY because the parent DP
driver already holds the request_mem_region lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910092038.4829=
1-1-angelogioacchino.delregno@collabora.com?part=3D4
