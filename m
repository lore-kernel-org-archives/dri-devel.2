Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD93C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A29F10FC6D;
	Tue, 15 Sep 2026 15:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vi7apQxc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B0C10FC52
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:46:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FA93600C8;
 Tue, 15 Sep 2026 15:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D171F000FF;
 Tue, 15 Sep 2026 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789487177;
 bh=mjVSAPDqPKP4DItjJf1WRLNRKD0I+SD0o8c0mchPH3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vi7apQxczYynDIBLO65dXI6QHAkCcrqLXH7OW3PXQzj8b4GDy1gviRnGjulpMMVVn
 AZ/9GNPdOqaM2D1vtzBdQbmYT29IYJwGKXADhSbIctOOK965blDkGfZ4RS4GQ7h2nL
 FB06xbZC/q2U2zsS7irF4MgdsSTw/+1pfPBjVI3fxFTWCPo8eRnMeOSjkDcHpcoX3n
 zb/4U5V1bcEK6yM4NpezS9bCd5pPyVzCJKXfR/sKo6CGCT9b2zvyQBzg8dmzLKPL4N
 cHwuEg5FDmZqYwFcQfkj153q2TE/rhTDkp7T1/l2qXOUizc1gAFPA+Zlutrtjhn78e
 lIkvx1zC3teKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/20] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: vkoul@kernel.org, robh@kernel.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, lee@kernel.org, mfd@lists.linux.dev,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, neil.armstrong@linaro.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-18-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153246eucas1p289987fd8757c89ff865c99b6465708a8@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-18-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:46:16 +0000
Message-Id: <20260915154616.B1D171F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] clk: starfive: Unsafe hardware access in .set_rate causes CPU stal=
l during probe
- [Medium] clk: starfive: Pre-PLL is unconditionally powered on in .set_rat=
e causing a power leak
- [Medium] clk: starfive: Resource lifecycle inversion with refoclk and dev=
res clock provider
- [Medium] clk: starfive: Data race on cached clock state variables between=
 CCF and PHY frameworks
--

commit 5469b7909aa9bb8690ee9fbfe18ef57f4c2d5820
Author: Michal Wilczynski <m.wilczynski@samsung.com>

phy: starfive: Add jh7110-inno-hdmi-phy driver

Add the HDMI PHY driver for the StarFive JH7110.

> diff --git a/drivers/phy/starfive/phy-jh7110-inno-hdmi.c b/drivers/phy/st=
arfive/phy-jh7110-inno-hdmi.c
> new file mode 100644
> index 0000000000000..2575cb5ed624a
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-inno-hdmi.c
> @@ -0,0 +1,579 @@

[ ... ]

> +static int starfive_hdmi_phy_clk_set_rate(struct clk_hw *hw, unsigned lo=
ng rate,
> +					  unsigned long parent_rate)
> +{
> +	struct starfive_hdmi_phy *inno =3D to_starfive_hdmi_phy(hw);
> +	const struct inno_hdmi_phy_pre_pll_config *cfg;
> +
> +	/*
> +	 * The JH7110 only drives 8bpc, so the TMDS clock always matches the
> +	 * pixel clock.
> +	 */
> +	cfg =3D inno_hdmi_phy_pre_pll_lookup(&inno->pre_pll, rate, rate);
> +	if (IS_ERR(cfg))
> +		return PTR_ERR(cfg);
> +
> +	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
> +		__func__, rate, cfg->tmdsclock);
> +
> +	if (inno->pixclock =3D=3D rate && inno->tmdsclock =3D=3D cfg->tmdsclock)
> +		return 0;
> +
> +	inno_update_bits(inno, STF_INNO_BIAS_CONTROL,
> +			 STF_INNO_BIAS_ENABLE, STF_INNO_BIAS_ENABLE);

[Severity: High]
Does this execute an unclocked hardware access if the clock is gated?

The commit message notes that accessing the PHY registers while the HDMI
controller's system clock is gated wedges the CPU. Because
starfive_hdmi_phy_probe() unconditionally calls clk_set_rate() before the
sibling HDMI bridge driver has bound and enabled the shared system clock, t=
he
hardware is gated.

Could a clk_hw_is_prepared(hw) check be added here similarly to how it was
used in .recalc_rate?

> +	inno_write(inno, STF_INNO_RX_CONTROL, STF_INNO_RX_ENABLE);
> +
> +	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, true);
> +	inno_hdmi_phy_pre_pll_configure(&inno->pre_pll, cfg);
> +	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, false);

[Severity: Medium]
Will the Pre-PLL remain powered on indefinitely if the clock isn't prepared?

Since .set_rate turns the Pre-PLL on, and the driver omits the .is_prepared
callback in starfive_hdmi_phy_clk_ops, the CCF relies on the software prepa=
re
count (which is 0). When clk_disable_unused() runs, it skips unprepared clo=
cks
with a 0 count, meaning .unprepare() won't be invoked to turn the PLL off.

> +
> +	inno->pixclock =3D rate;
> +	inno->tmdsclock =3D cfg->tmdsclock;

[Severity: Medium]
Could there be a data race on inno->pixclock and inno->tmdsclock between the
CCF and PHY frameworks?

The CCF callbacks (such as .set_rate and .recalc_rate) read and write
inno->pixclock and inno->tmdsclock under the CCF core's prepare_lock.
Concurrently, the PHY framework operations (such as .power_off calling
starfive_hdmi_phy_power_down()) write to these exact same variables under t=
he
PHY framework's internal phy->mutex.

If userspace triggers a sysfs clock summary read (triggering .recalc_rate)
concurrently with a DRM display modeset or power down sequence, could
.recalc_rate overwrite the 0 set by power_down with stale hardware values?
This might prevent a subsequent set_rate from applying the correct settings.

> +
> +	return 0;
> +}
> +
> +static const struct clk_ops starfive_hdmi_phy_clk_ops =3D {
> +	.prepare =3D starfive_hdmi_phy_clk_prepare,
> +	.unprepare =3D starfive_hdmi_phy_clk_unprepare,
> +	.recalc_rate =3D starfive_hdmi_phy_clk_recalc_rate,
> +	.determine_rate =3D starfive_hdmi_phy_clk_determine_rate,
> +	.set_rate =3D starfive_hdmi_phy_clk_set_rate,
> +};

[Severity: Medium]
The omission of the .is_prepared callback here is what causes
clk_disable_unused() to assume the clock is already physically disabled,
leading to the power leak mentioned in .set_rate.

> +
> +static void starfive_hdmi_phy_power_down(struct starfive_hdmi_phy *inno)
> +{
> +	inno_write(inno, STF_INNO_TMDS_CONTROL, 0x00);
> +	inno_write(inno, STF_INNO_SERIALIER_CONTROL, 0x00);
> +	inno_write(inno, STF_INNO_LDO_CONTROL, 0x00);
> +	inno_update_bits(inno, STF_INNO_BIAS_CONTROL,
> +			 STF_INNO_BIAS_ENABLE, 0x00);
> +	inno_write(inno, STF_INNO_RX_CONTROL, 0x00);
> +
> +	/* Power down Post-PLL */
> +	inno_update_bits(inno, STF_INNO_POST_PLL_DIV_1,
> +			 STF_INNO_POST_PLL_POWER_DOWN,
> +			 STF_INNO_POST_PLL_POWER_DOWN);
> +
> +	inno->tmdsclock =3D 0;
> +	inno->pixclock =3D 0;

[Severity: Medium]
This is where the concurrent writes from the PHY framework happen, as noted
in the previous comment about the data race with the CCF callbacks.

> +}

[ ... ]

> +static int starfive_hdmi_phy_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	ret =3D of_clk_add_provider(dev->of_node, of_clk_src_simple_get, inno->=
phyclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to add clock provider: %d\n", ret);
> +		goto err_disable_refoclk;
> +	}
> +
> +	ret =3D clk_set_rate(inno->phyclk, 297000000);

[Severity: High]
This unconditionally triggers a rate change during probe, which leads to the
unsafe hardware access in .set_rate described earlier, since the sibling br=
idge
driver is not guaranteed to have enabled the shared system clock yet.

> +	if (ret) {
> +		dev_err(dev, "Failed to set default rate: %d\n", ret);
> +		goto err_del_clk_provider;
> +	}
> +
> +	/* Create and register the PHY provider */
> +	inno->phy =3D devm_phy_create(inno->dev, NULL, &starfive_hdmi_phy_ops);
> +	if (IS_ERR(inno->phy)) {
> +		ret =3D PTR_ERR(inno->phy);
> +		dev_err(inno->dev, "failed to create HDMI PHY: %d\n", ret);
> +		goto err_del_clk_provider;
> +	}
> +
> +	phy_set_drvdata(inno->phy, inno);
> +
> +	phy_provider =3D devm_of_phy_provider_register(inno->dev,
> +						     of_phy_simple_xlate);
> +	ret =3D PTR_ERR_OR_ZERO(phy_provider);
> +	if (ret)
> +		goto err_del_clk_provider;
> +
> +	return 0;
> +
> +err_del_clk_provider:
> +	of_clk_del_provider(dev->of_node);
> +err_disable_refoclk:
> +	clk_disable_unprepare(inno->refoclk);
> +	return ret;

[Severity: Medium]
Is it safe to manually disable the reference clock here before devres
unregisters the clock and PHY providers?

The clock and PHY providers are registered using devm_clk_register() and
devm_of_phy_provider_register(). Disabling refoclk manually here (and in
remove) creates a window where operations could execute with a disabled par=
ent
clock if a consumer triggers a clock or PHY operation before devres cleans =
up
the providers.

Would it be better to bind the refoclk enable state to devres via
devm_clk_get_enabled() or devm_add_action_or_reset()?

> +}
> +
> +static void starfive_hdmi_phy_remove(struct platform_device *pdev)
> +{
> +	struct starfive_hdmi_phy *inno =3D platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(pdev->dev.of_node);
> +	clk_disable_unprepare(inno->refoclk);

[Severity: Medium]
As in the probe error path, manually disabling the reference clock before
devres unregisters the providers creates a use-after-disable window.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D18
