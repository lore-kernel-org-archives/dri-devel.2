Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311D1C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6052A89F35;
	Sun,  9 Aug 2026 09:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JuQHd5BQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEAC89F35
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:14:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F57F42BB7;
 Sun,  9 Aug 2026 09:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B161F000E9;
 Sun,  9 Aug 2026 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786266875;
 bh=DaPEiC5BXE8OUeycQRq6xrlEJHCXli1koNObLFUZjyE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JuQHd5BQ5B5xeRX7ZBcM5MmRoF98rYnpBgsfyiwpyiZFZLiUSr8ek5v9Hy6L/tC0b
 wbI66eZ6GPXsxA0VTABrPXgDuFIYG43W7yf3lDY6OJD4oATcwAuK+CuNc8u5lMmHPi
 gz784QmPhXzf069tDB9iftIN5Mb5hjONXJXZD/7DcO8mnDrvq3Xk8O/w5HQ8bqF6/5
 cZ0/JLT+0EnvVv4G9Whp0It8xcoMgLv6iPuwCsHPj4MoeYMx9P1RZQ+s75kwKc5xXO
 NAjuzj2UYdqi4kT4vQUvdukb4PaWGzN48IOWyvQZ9G9SYQa1wG4LSkxXcKcQYgOf/W
 rl+ywT/80TebQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] drm/bridge: samsung-dsim: use DSIM interrupt to
 wait for PLL stability
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-exynos-dsim-fixes-v5-2-6e63dc6c238f@disroot.org>
References: <20260809-exynos-dsim-fixes-v5-0-6e63dc6c238f@disroot.org>
 <20260809-exynos-dsim-fixes-v5-2-6e63dc6c238f@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:14:34 +0000
Message-Id: <20260809091435.52B161F000E9@smtp.kernel.org>
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
- [High] Using `wait_for_completion_timeout()` with a short, sub-jiffy time=
out leads to premature expiration and spurious display initialization failu=
res.
- [High] An early return in the interrupt handler causes `DSIM_INT_PLL_STAB=
LE` events to be silently discarded if they coalesce with `DSIM_INT_SW_RST_=
RELEASE`.
--

--- Patch [2]: [PATCH v5 2/3] drm/bridge: samsung-dsim: use DSIM interrupt =
to wait for PLL stability ---
commit 9e7e8160e685bf48c532c28ad86a19b0799f53ce
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability

This commit replaces a busy-wait polling loop for checking PLL stability
with an interrupt-driven completion mechanism.

Link: https://lore.kernel.org/r/CAAQKjZMLMbwDVZRb5+Xb_5yz3AEP4uuzFJMuuZy9NF=
Du13VU5w@mail.gmail.com

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 6260c091c3df8..216a7cc9d5c55 100644
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
Does this code risk premature timeout expiration?

When timeout_us is 100, usecs_to_jiffies(100) translates to 1 jiffy on
standard kernel configurations (e.g., HZ=3D1000 or lower). Passing a 1-jiffy
timeout to wait_for_completion_timeout() only guarantees waiting until the
next timer tick, which can expire almost immediately depending on tick
alignment.

This might cause spurious failures to initialize the display PLL, since the
robust 3000-iteration polling loop has been replaced with a single register
read after this wait.

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
> =20
>  	dsi->hs_clock =3D fout;
> =20
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
> =20
> -	if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY |
> -			DSIM_INT_PLL_STABLE)))
> +	if (status & DSIM_INT_PLL_STABLE)
> +		complete(&dsi->pll_stabilized);

[Severity: High]
Can DSIM_INT_PLL_STABLE events be silently discarded here if they coalesce
with DSIM_INT_SW_RST_RELEASE?

If both DSIM_INT_SW_RST_RELEASE and DSIM_INT_PLL_STABLE are set
simultaneously in status (which may happen if reset and PLL initialization
run concurrently on platforms where wait_for_reset is false), the code insi=
de
the if (status & DSIM_INT_SW_RST_RELEASE) block executes and returns
IRQ_HANDLED early.

Since the interrupts are already cleared in hardware by the
samsung_dsim_write(dsi, DSIM_INTSRC_REG, status) call earlier in this funct=
ion,
complete(&dsi->pll_stabilized) would be skipped entirely, potentially causi=
ng
the waiter to time out.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-exynos-dsi=
m-fixes-v5-0-6e63dc6c238f@disroot.org?part=3D2
