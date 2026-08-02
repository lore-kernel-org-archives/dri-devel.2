Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DFFC55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 06:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A59910E3E3;
	Sun,  2 Aug 2026 06:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IwSU7/oV";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2210C10E3E3
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 06:57:22 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5c2c96286f0so1196237e0c.3
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 23:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785653841; cv=none;
 d=google.com; s=arc-20260327;
 b=dqLB3ZZQvsN3nTrQDdvawfUCGQO2kbWuEmU2HdQvDp4nOSkmJNGL/NwIAu2wEEMOgD
 sZUjndX998XKC2g98PzD1UwnbDB8jlm7B+rLXicmxtrMwW4kQmDD9/ish+lZTKqyAPff
 2NahO92V/IZ1m5MfFzjHlRcdA4gpRQVmSz0i86N2wogLBU4NV2Gbl8m+mh9Lwb2Z1/Sp
 BztET2gPVkYrxrS0I8/F5AH0mWB5C1nPo4RaQxdQOqzWt+kx7if3WVYtheXUCI81zQo2
 6+XYAqSpUx47wYC2X8L9YcA2AqvcYTJV7LNZaKG/Vztr/q7qRZmJ9qKwT3+TX/FnunYu
 F++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wtkW0R9L1WzRthBVOFdrAk5MXzpeymlEQ3IDXCT5EV4=;
 fh=MN8pe/8nMW75gZCd7Cgr6vL24VQcUuKPPjfT0GDZaQs=;
 b=kLQ67ryN8oTp3T8S8W+U91ZltbmgS4whvHDop49SOw31968H2y3CvmnimlAx8ySjuA
 I6d23H6XVXGpM52KbsYEnFNr7OazZpZiM/7wELkmf+1eUvf4TwtnrhnfB8TyuQiMP0S2
 h/mkeq/3m25FbrPZSA6Oq1GrZV5WEGshdmJPWovzfBwX0zgP5otHQKNBPPR8rCJDbYkI
 gBBpkw2jKFKv5hRLvRROOqklSC6SvZ/VooZYh8F+4ivxggADsDH1MOVaM2W5ISR1GfqI
 /7JNUO2sTf+bl/HB3BTXhT9PxrhdWGJZj1Y/JNJzu7s5h45vzJFXRkXnnI5ozhpw1mXi
 ztqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785653841; x=1786258641; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wtkW0R9L1WzRthBVOFdrAk5MXzpeymlEQ3IDXCT5EV4=;
 b=IwSU7/oVt0zCzjwvU06ID9F+w4ZV7oaKiU2nwzZbCP6vEfyRQ2A5gqNLHYxORGVMaz
 q+NBE5AxRoTntkRMAOmc7uwwcyWoHsJIM6zswk/a96vgyoLkSMDXV3JMEYNw2UywteaL
 pSNpcChmxIuEkhGTvGPe+fl9g/9gmYfIj3tBS8WiB7ooM7TxJYkgZ8DEotBMZhMZ1Dse
 jyQ+JfWKRz+JML4CzoIUFPNsCYWUxLcxPlny/7xlK1opjuBxObETjUF1x7O3/XsC8bG+
 Of4DGFzTNgtJXMYSOU2cWEKKgaD5Z35Eb6kC9hWtqWlmp/md7ioyR3ASbBV+tjfDZ3x4
 e67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785653841; x=1786258641;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wtkW0R9L1WzRthBVOFdrAk5MXzpeymlEQ3IDXCT5EV4=;
 b=JxQUULKg8/NsCg4Na4GCXdTovtWOy/K06kUcStuPH9FDprIouJiztJ1b8UeQZZwcWw
 tRW6P1Z0BvD087kSnpXyoaxHbc14oScAzL9KdAyeMkEsBLorgw8AYpbYyP7hvNiv5gy6
 cR4ajIJZUdobsQiwFySa8R11s1FeCClT0VgkHpcZYUMiU2JNMlISSiR5+h3vyd4ATwBq
 Nbsj8Fhz8WzrqjmVUkFdA4q0ykVyMHtUygUnsto2G3frTn2+8jwuU7eKiil6i8ncMDIU
 q8K1PArC98k6pgNB3Tj1LsOBmCQOICYlEMSKr3dgfZstQIhIN7JMa/dlcxt9P6UA3qao
 1KpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGP+PbYArJevVO2FOsY5aDH11SaZ80iys1hbxMO8AEm3TqJOnJsduwxhEnYbZpzM5i1Nnz2cHhw+o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyu0KBVMCjFdjsRrD3bvGkR4Ve+Rpm+3LcpCBinK6QHejrIn1y4
 y3JNATXlnTqd0eXWTm4kipchky6PPFVllxbkJ0XHuBzpA4L7HyhnKozmEJ3wsfSTRK3fAl93qXW
 4tjWJOFq0zgfmij6N18ppGxhm34Bn0YA=
X-Gm-Gg: AR+sD11oltJ08YyRHgghaDCUFnyRIejbYykVmd0whPYv5NH2hzesW2NpoB0zfYRL9+h
 FnK4pbqvEbxLZYmqrvSxHsJCxY5XmhKVMJaMWvP9Lzle01iKpuv/tqPdVKH27C1RZhVJK14lNXr
 b3jY1TGL/aBiHypsIrgPhsWpLr7x8y/TPju6dTG/6W0EPK+JVlAHWxok+4wxP2q/3Ea/CWW5GSG
 L25yD9PecFNIwkGdD+qrouKroiqrz6v2qJOcG6IwyXT6xw0auVu+t0j/laFnU/00bs55eSZWn5x
 RTJB8KsE+UJUXxMIgq07fNuuufK09DqQSScjAKPs7XmjVqfcQW3A1LJ/cWjEx4vXhRp6U57Hjhw
 =
X-Received: by 2002:a05:6102:3ec1:b0:740:177:f357 with SMTP id
 ada2fe7eead31-75b21b5cddamr4703145137.6.1785653840583; Sat, 01 Aug 2026
 23:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
 <20260723-exynos-dsim-fixes-v3-2-0c31ae1dbecc@disroot.org>
In-Reply-To: <20260723-exynos-dsim-fixes-v3-2-0c31ae1dbecc@disroot.org>
From: Inki Dae <daeinki@gmail.com>
Date: Sun, 2 Aug 2026 15:56:43 +0900
X-Gm-Features: AUfX_mw50HwgZ9Tzu4pmNQbb3I4THHxFrSfTGd-5rpmu4ySRW8DCN5G-vjpsyfk
Message-ID: <CAAQKjZMP+iQAZUGG0LtbXJWivOjVXCLB=uaqmYkenvmNK=S_vQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: samsung-dsim: use DSIM interrupt to
 wait for PLL stability
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

HI,

2026=EB=85=84 7=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:04, K=
austabh Chakraborty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Stabilizing PLL needs to be waited for. This is done using a loop,
> checking the PLL_STABLE bit in the status register.
>
> DSIM fires an interrupt when the PLL is stabilized. Rely on this
> functionality for stabilization wait, getting rid of the implicit loop.
>
> This has been tested on a Galaxy J6 (Exynos 7870). Unfortunately, since
> testing on all supported devices is less feasible, introduce a stop-gap
> measure where the timeout has a gracious lower bound of 100
> microseconds. This will (hopefully) prevent regressions due to timeout
> on other devices.
>
> Suggested-by: Inki Dae <inki.dae@samsung.com>
> Link: https://lore.kernel.org/r/CAAQKjZMLMbwDVZRb5+Xb_5yz3AEP4uuzFJMuuZy9=
NFDu13VU5w@mail.gmail.com
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 41 +++++++++++++++++++++++------=
------
>  include/drm/bridge/samsung-dsim.h     |  1 +
>  2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index da753ff6eed4..866cff205e71 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -17,6 +17,7 @@
>  #include <linux/export.h>
>  #include <linux/irq.h>
>  #include <linux/media-bus-format.h>
> +#include <linux/minmax.h>
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -788,7 +789,7 @@ static unsigned long samsung_dsim_set_pll(struct sams=
ung_dsim *dsi,
>  {
>         const struct samsung_dsim_driver_data *driver_data =3D dsi->drive=
r_data;
>         unsigned long fin, fout;
> -       int timeout;
> +       unsigned int timeout;

The value assigned to `timeout` below, `reg_values[PLL_TIMER] / fin`,
is an `unsigned long`. It compiles thanks to `__careful_cmp()` in
`max()`, but the result is silently narrowed to `unsigned int`. Please
make this `unsigned long timeout` instead.

>         u8 p, s;
>         u16 m;
>         u32 reg;
> @@ -849,19 +850,26 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
>         if (dsi->swap_dn_dp_data)
>                 reg |=3D DSIM_PLL_DPDNSWAP_DAT;
>
> +       /*
> +        * The PLL_TIMER value is the product of the timeout delay and th=
e APB
> +        * bus clock rate. Calcutate the timeout delay on-the-fly here.

Typo: "Calcutate" -> "Calculate".

> +        * It is assumed that the bus clock is the first clock in the pro=
vided
> +        * bulk clock data.
> +        */
> +       timeout =3D 100;
> +       fin =3D clk_get_rate(dsi->driver_data->clk_data[0].clk) / HZ_PER_=
MHZ;

`fin` is used earlier in this function as the PLL reference clock in
Hz, and is printed by dev_dbg(). Overwriting it here with a completely
unrelated value -  the APB bus clock in MHz - is confusing when
debugging. Please use a separate variable:

unsigned long bus_clk_mhz;
...
bus_clk_mhz =3D clk_get_rate(driver_data->clk_data[0].clk) / HZ_PER_MHZ;


> +       if (fin)
> +               timeout =3D max(dsi->driver_data->reg_values[PLL_TIMER] /=
 fin,
> +                             timeout);

Also, there is already a `driver_data` local at the top of the
function which the rest of the function uses. Only the newly added
code dereferences `dsi->driver_data->` directly, which is
inconsistent.

> +
> +       reinit_completion(&dsi->pll_stabilized);
>         samsung_dsim_write(dsi, DSIM_PLLCTRL_REG, reg);
>
> -       timeout =3D 3000;
> -       do {
> -               if (timeout-- =3D=3D 0) {
> -                       dev_err(dsi->dev, "PLL failed to stabilize\n");
> -                       return 0;
> -               }
> -               if (driver_data->has_legacy_status_reg)
> -                       reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
> -               else
> -                       reg =3D samsung_dsim_read(dsi, DSIM_LINK_STATUS_R=
EG);
> -       } while ((reg & BIT(driver_data->pll_stable_bit)) =3D=3D 0);
> +       if (wait_for_completion_timeout(&dsi->pll_stabilized,
> +                                       usecs_to_jiffies(timeout))) {
> +               dev_err(dsi->dev, "PLL failed to stabilize\n");
> +               return 0;
> +       }

This is the main problem: the condition is inverted.

ait_for_completion_timeout() returns 0 on timeout, and the number of
remaining jiffies (> 0) on completion. As written, this reports an
error and returns 0 exactly when the PLL *did* stabilize, and silently
succeeds when it timed out.

Since samsung_dsim_set_pll() returning 0 makes its caller
samsung_dsim_enable_clock() bail out with -EFAULT, the display would
fail to come up entirely the moment a PLL_STABLE interrupt actually
arrives.

    if (!wait_for_completion_timeout(&dsi->pll_stabilized,
                                   usecs_to_jiffies(timeout))) {

The reason this still passed testing is the second issue below: the
PLL_STABLE interrupt never fires in the first place. The two bugs are
masking each other.

One more thing - this removes the only user of
driver_data->pll_stable_bit. The field declaration in the header and
all seven driver_data initialisers are now dead. Please drop them in
the same series. (has_legacy_status_reg is still used by
samsung_dsim_init_link(), so that one should stay.)

>
>         dsi->hs_clock =3D fout;
>
> @@ -1596,8 +1604,12 @@ static irqreturn_t samsung_dsim_irq(int irq, void =
*dev_id)
>                 return IRQ_HANDLED;
>         }
>
> -       if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY |
> -                       DSIM_INT_PLL_STABLE)))
> +       if (status & DSIM_INT_PLL_STABLE) {
> +               complete(&dsi->pll_stabilized);
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY)))
>                 return IRQ_HANDLED;

Two problems here.

First, DSIM_INT_PLL_STABLE is masked in INTMSK, so this interrupt can
never be delivered. The only place that writes INTMSK is the
SW_RST_RELEASE path just above:

        unsigned long mask =3D ~(DSIM_INT_RX_DONE |
                               DSIM_INT_SFR_FIFO_EMPTY |
                               DSIM_INT_SFR_HDR_FIFO_EMPTY |
                               DSIM_INT_RX_ECC_ERR |
                               DSIM_INT_SW_RST_RELEASE);
        samsung_dsim_write(dsi, DSIM_INTMSK_REG, mask);

DSIM_INT_PLL_STABLE is not in that list, so it stays masked. And
Exynos 7870 has wait_for_reset =3D 1, so samsung_dsim_init() runs:

        samsung_dsim_wait_for_reset()   <- runs this handler, programs INTM=
SK
        samsung_dsim_enable_clock()     <- calls samsung_dsim_set_pll()

meaning PLL_STABLE is guaranteed to be masked by the time set_pll()
runs. As a result this patch performs no PLL stabilization wait at
all, and instead sleeps for the full timeout on every enable. Because
of usecs_to_jiffies() resolution, 100us rounds up to at least one
jiffy - 4ms at HZ=3D250, 10ms at HZ=3D100. That is a new latency
regression compared to the old polling loop.

Please add DSIM_INT_PLL_STABLE to the INTMSK list. It would also be
safer to program INTMSK explicitly right after reset, so that SoCs
with wait_for_reset =3D 0 (which never reach this handler path) are
covered too.

Second, the early return swallows concurrent events. `status` can have
several bits set at once, and everything has already been cleared
write-1-to-clear in INTSRC above. If PLL_STABLE and SFR_FIFO_EMPTY are
raised together, the samsung_dsim_transfer_finish() handling is lost
permanently and that transfer stalls until its own timeout. The
pre-patch code handled all three bits in one condition and fell
through, so it did not have this problem.

Please make the handling non-exclusive:

        if (status & DSIM_INT_PLL_STABLE)
                complete(&dsi->pll_stabilized);

        if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY)))
                return IRQ_HANDLED;

Thanks,
Inki Dae

>
>         if (samsung_dsim_transfer_finish(dsi))
> @@ -2148,6 +2160,7 @@ int samsung_dsim_probe(struct platform_device *pdev=
)
>                 return PTR_ERR(dsi);
>
>         init_completion(&dsi->completed);
> +       init_completion(&dsi->pll_stabilized);
>         spin_lock_init(&dsi->transfer_lock);
>         INIT_LIST_HEAD(&dsi->transfer_list);
>
> diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsu=
ng-dsim.h
> index 03005e474704..e3433da21ad0 100644
> --- a/include/drm/bridge/samsung-dsim.h
> +++ b/include/drm/bridge/samsung-dsim.h
> @@ -123,6 +123,7 @@ struct samsung_dsim {
>         int state;
>         struct drm_property *brightness;
>         struct completion completed;
> +       struct completion pll_stabilized;
>
>         spinlock_t transfer_lock; /* protects transfer_list */
>         struct list_head transfer_list;
>
> --
> 2.54.0
>
>
