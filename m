Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999DC54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1EB10E2B6;
	Tue, 28 Jul 2026 09:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2YDITI6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F9F10E2B6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:39:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D2F6435A3;
 Tue, 28 Jul 2026 09:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8821F000E9;
 Tue, 28 Jul 2026 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785231592;
 bh=Pfm1YSqXl/y4S7ktsEbpmpKGSGkqgPgTeITtq44LOcs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X2YDITI6iTo9SHhr+OqlGttJ+jHyz4Wb+lyBhS9FhKhFoZvy0ZmZ+nS5gmyxqkrDl
 hoGEj/ISgH9EsFmTcL6NLNs8MWkm9xVwR0yXYHPPLsX7ESPbL86sTBJOSuuuzO8pVV
 TdEumx99YHiXWh56qR6VSQnERTnu05yn2MrQk4CZR/6xxX3TUeSUx6B9mbiBnNnTiS
 J9v+VmCAzotmzYjqiyXOaKZyxF+8UrLCHJD7Yy3C9mIH88rfnJyZYvPHBSpxqBuXO8
 RtaItkaoQKQNxnylkxaGVo2CGpop+jQ26f0kD5na738qJdjt1+TngH8c18drzxXbUx
 7aBwP2L9jG8Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] clk: mediatek: Add mt8173-mfgtop driver
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260728091804.382753-3-wenst@chromium.org>
References: <20260728091804.382753-1-wenst@chromium.org>
 <20260728091804.382753-3-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:39:51 +0000
Message-Id: <20260728093951.AA8821F000E9@smtp.kernel.org>
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
- [High] Use-After-Free risk due to devm allocation of genpd combined with =
potentially failing pm_genpd_remove().
- [High] AB-BA deadlock between CCF prepare_lock and genpd_lock during runt=
ime PM power on.
- [Low] Selecting PM_GENERIC_DOMAINS_OF without inheriting its dependencies=
 causes Kconfig unmet dependency warnings.
--

--- Patch [2]: [PATCH v4 2/5] clk: mediatek: Add mt8173-mfgtop driver ---
commit e32a50e33bf9163d53ebe0a01a272a288c9edb39
Author: Chen-Yu Tsai <wenst@chromium.org>

clk: mediatek: Add mt8173-mfgtop driver

This commit introduces the mt8173-mfgtop driver to manage the MFG (GPU)
block's glue layer on the MT8173. It exposes the clock gates as a clock
controller and the power sequencing bits as a power domain.

> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 2c09fd729bab0..8eea3766a9108 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig

[ ... ]

> @@ -537,6 +537,16 @@ config COMMON_CLK_MT8173_IMGSYS
>  	help
>  	  This driver supports MediaTek MT8173 imgsys clocks.
> =20
> +config COMMON_CLK_MT8173_MFGTOP
> +	tristate "Clock and power driver for MediaTek MT8173 mfgtop"
> +	depends on COMMON_CLK_MT8173
> +	depends on PM
> +	default COMMON_CLK_MT8173
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_OF

[Severity: Low]
Does this select create an unmet dependency warning?

When building with COMPILE_TEST=3Dy on architectures without OF enabled,
PM_GENERIC_DOMAINS_OF is forced on without its OF dependency being met.
Should this select be made conditional, or should the config depend on OF?

> +	help
> +	  This driver supports MediaTek MT8173 mfgtop clocks and power domain.

[ ... ]

> diff --git a/drivers/clk/mediatek/clk-mt8173-mfgtop.c b/drivers/clk/media=
tek/clk-mt8173-mfgtop.c
> new file mode 100644
> index 0000000000000..5669ca9954dc0
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8173-mfgtop.c

[ ... ]

> +static int clk_mt8173_mfgtop_power_on(struct generic_pm_domain *domain)
> +{
> +	struct mt8173_mfgtop_data *data =3D container_of(domain, struct mt8173_=
mfgtop_data, genpd);
> +	int ret;
> +
> +	/* drives internal power management */
> +	ret =3D clk_prepare_enable(data->clk_26m);

[Severity: High]
Can this cause an AB-BA deadlock between the CCF prepare_lock and the
genpd_lock?

Because runtime PM is enabled before clock registration in probe, CCF will
manage runtime PM for clk_26m. Calling clk_prepare_enable() here acquires
the prepare_lock and then triggers a runtime PM resume, acquiring the
genpd_lock for mfg_async.

Concurrently, the provider (mtk-scpsys) holds the genpd_lock during its
power_on callback and calls clk_prepare_enable(), creating the reverse lock
order. Would moving devm_pm_runtime_enable() after clock registration avoid
this inversion?

> +	if (ret)
> +		return ret;

[ ... ]

> +static void clk_mt8173_mfgtop_remove(struct platform_device *pdev)
> +{
> +	struct mt8173_mfgtop_data *data =3D platform_get_drvdata(pdev);
> +	struct device_node *node =3D pdev->dev.of_node;
> +
> +	of_genpd_remove_subdomain(&data->parent_pd, &data->child_pd);
> +	of_genpd_del_provider(node);
> +	pm_genpd_remove(&data->genpd);

[Severity: High]
Could this lead to a use-after-free if the driver is unbound via sysfs?

The genpd structure is embedded within a devm-allocated data struct. If
pm_genpd_remove() fails and returns -EBUSY (e.g., if consumers are still
attached), the domain remains linked in the global gpd_list.

Because the error is ignored, devres will proceed to free the data
structure, leaving a dangling pointer in the global list.

> +	of_clk_del_provider(node);
> +	clk_put(data->clk_26m);
> +	mtk_clk_unregister_gates(mfg_clks, ARRAY_SIZE(mfg_clks), data->clk_data=
);
> +	of_node_put(data->parent_pd.np);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728091804.3827=
53-1-wenst@chromium.org?part=3D2
