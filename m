Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB85C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E51010E101;
	Sun,  9 Aug 2026 08:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DmhWotkp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657FE10E101
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:48:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2F4A40D9F;
 Sun,  9 Aug 2026 08:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3431F00A3A;
 Sun,  9 Aug 2026 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786265331;
 bh=9n0AOzYsq+T3EC64PHwI/c6cuYDYmPBylv1uhEToX7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DmhWotkpzVQlqcZHjNqgubrgpNkp1vcv7zMi6FlVdomVZYUM2DjjwuPHdu8e+bu5U
 KAi4cgYp18+xN8icvSd0GPa0/ahZbSP9OstIwLQkpri5OfRgGwa6zZKNk9jfoZUvOE
 DcHclezrIVQnVJGUyCsnKJ0t16zYYHICnPKzxa5v2QBXSa1OkAlfWhHHYRkjkDUEUf
 W1C58xkgaFWup+PVvt8IG8UdnCfw2FN2ikyebnVfVQhCmlF8J2cvtsHIlVjJPsWS8j
 pw69RjDTQqIU4b2n0pqh+VAFa1rwU773Nvw1DV7rtYPRlGorly52l6VogysNm5TN7M
 4WaChUyt4K/rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/bridge: samsung-dsim: use DSIM interrupt to
 wait for PLL stability
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-exynos-dsim-fixes-v4-2-ca67c51e61b7@disroot.org>
References: <20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org>
 <20260809-exynos-dsim-fixes-v4-2-ca67c51e61b7@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 08:48:50 +0000
Message-Id: <20260809084851.6C3431F00A3A@smtp.kernel.org>
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

New issues:
- [High] An early return in the interrupt handler permanently drops the new=
ly added `DSIM_INT_PLL_STABLE` interrupt on platforms that do not wait for =
a reset completion.
- [High] The jiffy-based timeout for waiting on the PLL stabilization compl=
etion can expire prematurely, leading to spurious initialization failures.

Pre-existing issues:
- [High] `devm_clk_bulk_get()` overwrites a statically allocated global clo=
ck data array, breaking multi-instance platforms.
- [High] The return value of `samsung_dsim_enable_clock()` is ignored in `s=
amsung_dsim_init()`, causing silent hardware initialization failures.
--

--- Patch [2]: [PATCH v4 2/3] drm/bridge: samsung-dsim: use DSIM interrupt =
to wait for PLL stability ---
commit 2d251655e36dcc7e05ab4e2b1dc184bbb561aeb9
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability

This commit transitions the PLL stabilization wait in the samsung-dsim driv=
er
from a busy loop to an interrupt-driven completion. It calculates a dynamic
timeout and updates the IRQ handler to complete the wait when the PLL is
stable.

Link: https://lore.kernel.org/r/CAAQKjZMLMbwDVZRb5+Xb_5yz3AEP4uuzFJMuuZy9NF=
Du13VU5w@mail.gmail.com

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
[ ... ]
> @@ -849,19 +854,33 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
>  	if (dsi->swap_dn_dp_data)
>  		reg |=3D DSIM_PLL_DPDNSWAP_DAT;
> =20
> +	/*
> +	 * The PLL_TIMER value is the product of the timeout delay and the APB
> +	 * bus clock rate. Calculate the timeout delay on-the-fly here.
> +	 * It is assumed that the bus clock is the first clock in the provided
> +	 * bulk clock data.
> +	 */
> +	timeout_us =3D 100;
> +	bus_clk_mhz =3D clk_get_rate(dsi->driver_data->clk_data[0].clk) / HZ_PE=
R_MHZ;

[Severity: High]
This is a pre-existing issue, but does using dsi->driver_data->clk_data here
expose a data race on multi-instance setups? In samsung_dsim_probe(),
devm_clk_bulk_get() writes the acquired clock pointers directly into the
shared global static array referenced by driver_data. On multi-instance
platforms, a second instance overwrites the clocks of the first, and unbind=
ing
either instance causes clk_bulk_put() to free the other instance's clocks,
leading to a double-free on the second unbind.

> +	if (bus_clk_mhz)
> +		timeout_us =3D max(driver_data->reg_values[PLL_TIMER] / bus_clk_mhz,
> +				 timeout_us);
> +
> +	reinit_completion(&dsi->pll_stabilized);
>  	samsung_dsim_write(dsi, DSIM_PLLCTRL_REG, reg);
> =20
> -	timeout =3D 3000;
> -	do {
> -		if (timeout-- =3D=3D 0) {
> -			dev_err(dsi->dev, "PLL failed to stabilize\n");
> -			return 0;
> -		}
> +	if (!wait_for_completion_timeout(&dsi->pll_stabilized,
> +					 usecs_to_jiffies(timeout_us))) {

[Severity: High]
Could this jiffy-based timeout expire prematurely and lead to spurious
initialization failures? The dynamically calculated timeout_us is around
100-300us, which evaluates to 1 jiffy via usecs_to_jiffies(). A call to
wait_for_completion_timeout(..., 1) sleeps until the next timer tick, which
can happen in less than 1us. If the timeout expires prematurely, the fallba=
ck
code checks the status register exactly once, and if the PLL hasn't stabili=
zed
in that narrow window, it aborts.

>  		if (driver_data->has_legacy_status_reg)
>  			reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
>  		else
>  			reg =3D samsung_dsim_read(dsi, DSIM_LINK_STATUS_REG);
> -	} while ((reg & BIT(driver_data->pll_stable_bit)) =3D=3D 0);
> +
> +		if (!(reg & BIT(driver_data->pll_stable_bit))) {
> +			dev_err(dsi->dev, "PLL failed to stabilize\n");
> +			return 0;
> +		}
> +	}
[ ... ]
> @@ -1586,7 +1605,8 @@ static irqreturn_t samsung_dsim_irq(int irq, void *=
dev_id)
>  	samsung_dsim_write(dsi, DSIM_INTSRC_REG, status);
> =20
>  	if (status & DSIM_INT_SW_RST_RELEASE) {
> -		unsigned long mask =3D ~(DSIM_INT_RX_DONE |
> +		unsigned long mask =3D ~(DSIM_INT_PLL_STABLE |
> +				       DSIM_INT_RX_DONE |
>  				       DSIM_INT_SFR_FIFO_EMPTY |
>  				       DSIM_INT_SFR_HDR_FIFO_EMPTY |
>  				       DSIM_INT_RX_ECC_ERR |
> @@ -1596,8 +1616,10 @@ static irqreturn_t samsung_dsim_irq(int irq, void =
*dev_id)
>  		return IRQ_HANDLED;
>  	}

[Severity: High]
Does this unconditional early return drop the newly added DSIM_INT_PLL_STAB=
LE
interrupt? On platforms where wait_for_reset is false, samsung_dsim_init()
triggers a software reset and immediately enables the clock without waiting.
Both the DSIM_INT_SW_RST_RELEASE and DSIM_INT_PLL_STABLE interrupts can fire
concurrently. If coalesced, the handler clears both hardware interrupts,
processes the reset, and executes this early return in samsung_dsim_irq(),
skipping the DSIM_INT_PLL_STABLE check entirely.

[ ... ]
> @@ -1635,9 +1657,9 @@ static int samsung_dsim_init(struct samsung_dsim *d=
si)
>  	if (driver_data->reg_values[RESET_TYPE] =3D=3D DSIM_FUNCRST)
>  		samsung_dsim_enable_lane(dsi, BIT(dsi->lanes) - 1);
> =20
> -	samsung_dsim_enable_clock(dsi);
>  	if (driver_data->wait_for_reset)
>  		samsung_dsim_wait_for_reset(dsi);
> +	samsung_dsim_enable_clock(dsi);

[Severity: High]
This is a pre-existing issue, but should the return value of
samsung_dsim_enable_clock() be checked here? If samsung_dsim_set_pll() fails
and returns 0, the ignored -EFAULT allows the driver to continue
initialization with a broken clock state, computing a byte_clock of 0, writ=
ing
0s to PHY timing registers, and leaving the hardware in an unusable state.

>  	samsung_dsim_set_phy_ctrl(dsi);
>  	samsung_dsim_init_link(dsi);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-exynos-dsi=
m-fixes-v4-0-ca67c51e61b7@disroot.org?part=3D2
