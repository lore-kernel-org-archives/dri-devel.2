Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F199CC61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164C610F3C1;
	Fri, 28 Aug 2026 14:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fr2CRQfu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F7510F3C1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:04:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B48C60200;
 Fri, 28 Aug 2026 14:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAE1F00A3A;
 Fri, 28 Aug 2026 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925891;
 bh=BEf7wsmWGyjenIb5dVc/Hd41acSlqCKQek2mD9YF+6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fr2CRQfurqqiCNqIcuSDQwpRQGwS2JdQ+mp2F+gah+FXcTH19fHXsFzsqQP4j3i66
 sNhQmiPOiqY9s7nQRbZyoLniHnm/6mXtwgn4cPKu6BZOerLV/25RPiztz84yrSloDJ
 b2ogDKPObTvlc9B/DO501n0eD/5MSOJeKGlnbfC9wmxD8P8Gxh/FhdOudZWCx5fTLJ
 hojEvulsRR7U1HUnulRjSTyBJ4rTBHhNGMemDnzJCSi5BmHTgU0KIwGu32CKQFHhkP
 DLGC3aBAgKRdlctj+5Cy0mwDheddQrLzUXECfu0oCy3EOQmm6TFcR7NNS8xB7Dh+5/
 qqSFf5yRuE0XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: mfd@lists.linux.dev, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, linux-clk@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, lee@kernel.org,
 olteanv@gmail.com, vkoul@kernel.org, robh@kernel.org
In-Reply-To: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134837eucas1p18f352f4ffb04ca5e55386ed3423f5d1a@eucas1p1.samsung.com>
 <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:04:49 +0000
Message-Id: <20260828140450.66CAE1F00A3A@smtp.kernel.org>
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
- [High] Missing cleanup on the clk_set_rate error path in probe leaves a d=
angling clock provider.
- [High] Clock operations incorrectly modify analog PHY state without synch=
ronization, risking state corruption and power leaks.
- [Medium] Hardware PHY resources are left powered on if starfive_hdmi_phy_=
power_on() fails.
--

commit 7c46f9e86f09391b8c542e940da1457e36661874
Author: Michal Wilczynski <m.wilczynski@samsung.com>

phy: starfive: Add jh7110-inno-hdmi-phy driver

This commit adds the HDMI PHY driver for the StarFive JH7110. It provides
the variable pixel clock from the Pre-PLL and the PHY operations for the
Post-PLL and analog blocks.

> diff --git a/drivers/phy/starfive/phy-jh7110-inno-hdmi.c b/drivers/phy/st=
arfive/phy-jh7110-inno-hdmi.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-inno-hdmi.c
[ ... ]
> +static int starfive_hdmi_phy_clk_set_rate(struct clk_hw *hw, unsigned lo=
ng rate,
> +					  unsigned long parent_rate)
> +{
[ ... ]
> +	if (inno->pixclock =3D=3D rate && inno->tmdsclock =3D=3D cfg->tmdsclock)
> +		return 0;
> +
> +	inno_update_bits(inno, STF_INNO_BIAS_CONTROL,
> +			 STF_INNO_BIAS_ENABLE, STF_INNO_BIAS_ENABLE);
> +	inno_write(inno, STF_INNO_RX_CONTROL, STF_INNO_RX_ENABLE);

[Severity: High]
Does this incorrectly modify analog PHY state during clock operations?

Since clk_set_rate() is unconditionally called during starfive_hdmi_phy_pro=
be(),
these analog blocks are powered on immediately at boot, which could cause a
permanent power leak until the power_off callback happens to be called.

Furthermore, do these state modifications race with the PHY callbacks? The
common clock framework callbacks execute under the CCF prepare_lock, while =
PHY
callbacks execute under the phy->mutex lock. A concurrent clk_set_rate() and
starfive_hdmi_phy_power_on() could race on hardware registers and shared dr=
iver
state like inno->pixclock.

[ ... ]
> +static int starfive_hdmi_phy_power_on(struct phy *phy)
> +{
[ ... ]
> +	inno_write(inno, STF_INNO_POST_PLL_DIV_1, reg_1aa_value);
> +
> +	/* Wait for post PLL lock */
> +	ret =3D inno_poll(inno, STF_INNO_POST_PLL_LOCK_STATUS, v,
> +			v & STF_INNO_POST_PLL_LOCK, 1000, 100000);
> +	if (ret) {
> +		dev_err(inno->dev, "Post-PLL locking failed\n");
> +		return ret;
> +	}

[Severity: Medium]
Are the hardware PHY resources left powered on if the Post-PLL lock times o=
ut?

If inno_poll() fails, the function returns immediately. The PHY core framew=
ork
does not automatically call the power_off callback if the power_on callback
fails, because the power_count remains 0.

Does this error path need to explicitly undo the register writes that enabl=
ed
the BIAS, RX, and Post-PLL blocks earlier in this function?

[ ... ]
> +static int starfive_hdmi_phy_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	ret =3D clk_set_rate(inno->phyclk, 297000000);
> +	if (ret) {
> +		dev_err(dev, "Failed to set default rate: %d\n", ret);
> +		goto err_disable_refoclk;
> +	}
[ ... ]
> +err_del_clk_provider:
> +	of_clk_del_provider(dev->of_node);
> +err_disable_refoclk:
> +	clk_disable_unprepare(inno->refoclk);
> +	return ret;
> +}

[Severity: High]
Does this error path leave a dangling clock provider in the global list?

If clk_set_rate() fails, the code jumps to err_disable_refoclk, bypassing
the required of_clk_del_provider() cleanup. The devres framework will then
unregister and free inno->phyclk, but the device node will remain in the
system-wide of_clk_providers list pointing to freed memory. Any subsequent
clock lookup could trigger a use-after-free crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D13
