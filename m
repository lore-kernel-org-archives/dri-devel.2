Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8046AC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F8410EE7B;
	Wed, 22 Jul 2026 19:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ULtpBGnO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38FB10EE7B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:13:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D5C160051;
 Wed, 22 Jul 2026 19:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3091F000E9;
 Wed, 22 Jul 2026 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784747599;
 bh=eOHk9sXcDuwWFABO9WvB8oYIAFEb0qoakUkuJj30BEY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ULtpBGnOyAJWb1n9Hnk19DwCU2HSn2cDPk2WwwdIF40V8ALEPBnBPEySdFmxD5OUB
 7SOjVjVH9T7scsFp5i2wbHF9fTlWtZ2x+s2UuGlc/Lmiu8jKfv1g3sigV0zJRQSrhk
 vBw/h1RnJwsWh/wBqQgLvivKEAf0/VbZTlUe4ULF5gY6pkfPKBhCk5wV15zCyOJhQf
 812GlorB2K6H2wE2EHAnHEBH1ygcY2h3a+bqu4dg+7Eg6VS4FcEZdSDk0R/hcH1Hxf
 6igQP9yI5QuNeJsDBzRwVOySzJB1PchOBNt6/NEFUaCyfmvmduhonndQVDJ6xLvCd9
 IfPaykx1Qk1yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/bridge: samsung-dsim: use DSIM interrupt to
 wait for PLL stability
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-exynos-dsim-fixes-v3-2-0c31ae1dbecc@disroot.org>
References: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
 <20260723-exynos-dsim-fixes-v3-2-0c31ae1dbecc@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 19:13:18 +0000
Message-Id: <20260722191318.CD3091F000E9@smtp.kernel.org>
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
- [High] The return value of wait_for_completion_timeout() is evaluated inc=
orrectly, treating a timeout as success and success as an error.
- [High] The DSIM_INT_PLL_STABLE interrupt is permanently masked in DSIM_IN=
TMSK_REG and will never fire.
- [Medium] Using `wait_for_completion_timeout` with a 1-jiffy timeout can e=
xpire prematurely, violating hardware timing requirements.

Pre-existing issues:
- [High] Global static clk_bulk_data structures are shared among driver ins=
tances, leading to pointer overwrites and potential Use-After-Free.
--

--- Patch [2]: [PATCH v3 2/3] drm/bridge: samsung-dsim: use DSIM interrupt =
to wait for PLL stability ---
commit ab2f26b528640a4bd75a69b30c4182a9e493647b
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability

Stabilizing PLL needs to be waited for. This is done using a loop,
checking the PLL_STABLE bit in the status register. DSIM fires an
interrupt when the PLL is stabilized. Rely on this functionality for
stabilization wait, getting rid of the implicit loop.

Link: https://lore.kernel.org/r/CAAQKjZMLMbwDVZRb5+Xb_5yz3AEP4uuzFJMuuZy9NF=
Du13VU5w@mail.gmail.com

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c

[ ... ]

> @@ -849,19 +850,26 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
>  	if (dsi->swap_dn_dp_data)
>  		reg |=3D DSIM_PLL_DPDNSWAP_DAT;
> =20
> +	/*
> +	 * The PLL_TIMER value is the product of the timeout delay and the APB
> +	 * bus clock rate. Calcutate the timeout delay on-the-fly here.
> +	 * It is assumed that the bus clock is the first clock in the provided
> +	 * bulk clock data.
> +	 */
> +	timeout =3D 100;
> +	fin =3D clk_get_rate(dsi->driver_data->clk_data[0].clk) / HZ_PER_MHZ;

[Severity: High]
This is a pre-existing issue, but does accessing the global static
clk_bulk_data structures here risk a use-after-free or pointer overwrite
in multi-DSI systems?

The driver defines global static arrays that dsi->driver_data->clk_data poi=
nts
to, and devm_clk_bulk_get() modifies this shared array in-place, overwriting
the .clk pointers. In multi-DSI systems, a second instance's probe will
overwrite the clock pointers belonging to the first. If an instance is unbo=
und,
the pointers become dangling.

Could this dereference of the potentially overwritten or dangling clock poi=
nter
cause issues during PLL setup?

> +	if (fin)
> +		timeout =3D max(dsi->driver_data->reg_values[PLL_TIMER] / fin,
> +			      timeout);
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
> -		if (driver_data->has_legacy_status_reg)
> -			reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
> -		else
> -			reg =3D samsung_dsim_read(dsi, DSIM_LINK_STATUS_REG);
> -	} while ((reg & BIT(driver_data->pll_stable_bit)) =3D=3D 0);
> +	if (wait_for_completion_timeout(&dsi->pll_stabilized,
> +					usecs_to_jiffies(timeout))) {

[Severity: Medium]
Since the timeout is dynamically calculated with a lower bound of 100
microseconds, usecs_to_jiffies(100) will evaluate to 1 jiffy on most
systems.

Does a 1-jiffy timeout mean 'timeout on the next timer tick', which could
happen almost immediately depending on timer alignment?

Could this cause the wait to expire prematurely before the hardware PLL
has actually stabilized, leading to regressions?

[Severity: High]
Does this code incorrectly handle the return value of
wait_for_completion_timeout()?

wait_for_completion_timeout() returns 0 if the wait timed out, and > 0 if
it was successful. Evaluating the return value directly in the if condition
treats > 0 as true, causing a successful wait to erroneously execute the
error path and return 0 (failure).

Conversely, if it times out, it returns 0, evaluating to false, and
incorrectly returns success.

> +		dev_err(dsi->dev, "PLL failed to stabilize\n");
> +		return 0;
> +	}
> =20
>  	dsi->hs_clock =3D fout;

[ ... ]

> @@ -1596,8 +1604,12 @@ static irqreturn_t samsung_dsim_irq(int irq, void =
*dev_id)
>  		return IRQ_HANDLED;
>  	}
> =20
> -	if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY |
> -			DSIM_INT_PLL_STABLE)))
> +	if (status & DSIM_INT_PLL_STABLE) {
> +		complete(&dsi->pll_stabilized);
> +		return IRQ_HANDLED;
> +	}

[Severity: High]
Will the DSIM_INT_PLL_STABLE interrupt ever fire?

Looking earlier in samsung_dsim_irq(), when DSIM_INT_SW_RST_RELEASE is
handled, the hardware interrupt mask is rewritten using:

    unsigned long mask =3D ~(DSIM_INT_RX_DONE |
                           DSIM_INT_SFR_FIFO_EMPTY |
                           DSIM_INT_SFR_HDR_FIFO_EMPTY |
                           DSIM_INT_RX_ECC_ERR |
                           DSIM_INT_SW_RST_RELEASE);
    samsung_dsim_write(dsi, DSIM_INTMSK_REG, mask);

Since DSIM_INT_PLL_STABLE is omitted from this unmasking list, its bit
remains 1 due to the bitwise NOT, which actively masks (disables) it in the
hardware.

Because the interrupt is permanently masked in DSIM_INTMSK_REG, will the wa=
it
for completion always time out?

> +
> +	if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY)))
>  		return IRQ_HANDLED;
> =20
>  	if (samsung_dsim_transfer_finish(dsi))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-exynos-dsi=
m-fixes-v3-0-0c31ae1dbecc@disroot.org?part=3D2
