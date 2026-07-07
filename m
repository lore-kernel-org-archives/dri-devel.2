Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BDDC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46AA10EDA3;
	Tue,  7 Jul 2026 14:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iV9s10U/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A1010EDA3
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:33:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8FA060018;
 Tue,  7 Jul 2026 14:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D977E1F000E9;
 Tue,  7 Jul 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434817;
 bh=AlxPMQrsqVhCEj9Pg9ZvOqNkVUHqUdIxpTTtVw0F45E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iV9s10U/wvFtMcM2as83miqm3h9Hp4yRdamO3bmQzXNql/LUUFZAQPLpypnIJtYxd
 Hs/6o76KCR4bGOG84YLP/ZYXFHaEySocoUUxZBquuXzbv8yH9MShkusWvsJMpKA0T4
 r0ZNP0bYVyGPvyi++uVcDt9VJjnOAyF8TLpLEfgyozpf0e9lhb9nFxlTJNymmAqxD/
 5Ju8qCdnU4U5UcX+6dgCRfVPevGAc9jl9ylJUGc/154Q136vWbGwClVUaOASgub1xS
 RU7w6MPJE5y83N1TX/expkL3tj6nRRF7IXPFAjxrK2/+wgwQlq5vE4rKiAy+5HaplF
 gQtPvSoYNACwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] phy: phy-mtk-dp: Support setting volt swing
 and preemphasis values
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: vkoul@kernel.org, robh@kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260707141931.191172-8-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:33:36 +0000
Message-Id: <20260707143336.D977E1F000E9@smtp.kernel.org>
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
- [High] Analog PHY driving parameters are written to the wrong register of=
fsets, misaligning signal driving settings.
- [Low] Compilation error due to undeclared variable `ret` in `mtk_dp_phy_p=
robe`.
--

--- Patch [7]: [PATCH v2 07/12] phy: phy-mtk-dp: Support setting volt swing=
 and preemphasis values ---
commit 83b16a974d2259d5e6f2e7cfa570e7b31e4ec7e5
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Support setting volt swing and preemphasis values

This commit adds support for setting voltage swing and preemphasis values
in the DP PHY .configure() callback by honoring the set_voltages request.
It also ensures proper hardware cleanup by resetting both values in the
.reset() callback.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 2f3ec3fa384df..270825f130a95 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -101,6 +106,7 @@ enum mtk_dp_phya_ana_glb_regidx {
>  };
> =20
>  enum mtk_dp_phyd_dig_lane_regidx {
> +	DP_PHYD_LAN_DRIVING_FORCE,
>  	DP_PHYD_LAN_DRIVING_PARAM_0,
>  	DP_PHYD_LAN_MAX
>  };

[Severity: High]
Are the analog PHY driving parameters being written to the wrong register
offsets, misaligning the signal driving settings?

The base offset for initializing the analog PHY driving parameters appears =
to
have shifted from PARAM_3 (0x1138) to PARAM_0 (0x112c), but the
driving_params array still contains the 6 default values meant for PARAM_3
through PARAM_8:

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_init() {
    ...
	const u32 reg =3D pdata->regs_dig_lane[DP_PHYD_LAN_DRIVING_PARAM_0];
	static const u32 driving_params[] =3D {
		DRIVING_PARAM_3_DEFAULT,
		DRIVING_PARAM_4_DEFAULT,
		DRIVING_PARAM_5_DEFAULT,
		DRIVING_PARAM_6_DEFAULT,
		DRIVING_PARAM_7_DEFAULT,
		DRIVING_PARAM_8_DEFAULT
	};
    ...
	for (i =3D 0; i < MTK_DP_PHY_MAX_LANES; i++) {
		ret =3D regmap_bulk_write(dp_phy->regmap,
					pdata->off_dig_lane[i] + reg,
					driving_params,
					ARRAY_SIZE(driving_params));
    ...
}

Writing the defaults for params 3-8 into params 0-5 would leave params 6-8
uninitialized and corrupt the settings for params 0-5, which could lead to
incorrect link training.

[Severity: Low]
Is there a missing declaration for the variable ret in mtk_dp_phy_probe()?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_probe() {
    ...
	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
	if (IS_ERR(provider))
		return PTR_ERR(provider);

	ret =3D devm_pm_runtime_enable(dev);
	if (ret)
		return ret;

	return 0;
}

This causes a compilation error because ret is used without being declared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D7
