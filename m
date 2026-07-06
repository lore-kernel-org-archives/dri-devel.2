Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFF5C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E5910EA41;
	Mon,  6 Jul 2026 18:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RutExcAE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1228E10EA41
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:20:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7F9043D06;
 Mon,  6 Jul 2026 18:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889DF1F00A3A;
 Mon,  6 Jul 2026 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783362044;
 bh=NV5Mi/e5qPiiypED7VVlY2zbTNs3bvyTkXB2T+2U2Vg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RutExcAEeTCgGtjJj/zcGYNAKXPtPSFHjRKEGMol6MFUdtkWHsikNPyWQmqwAiwhz
 yVU0YKaPKxSk1iKUvI7I7AHOgFHI5uSNvf49qtIaRj8v/17btDEhI3kUpUqk/KEUFs
 0FYfM8g1EtTck56sZiD+6dvtqlNgMEbi8ybkDI4BxMV9O5f3coAGRBwvDyPbdZKg/z
 QG1WEYiU7oGlXmOXnDBLiheoIwJvfwPWNZm44rXwd0nIUqoM6A+w0LHHJAz+GznABk
 jBhGACw4R1Qs6VO74hOYM/H4X09jyZHixkk/e/1edkv9hdr/hkNq1bqqw4Mtna5AKz
 62IpalqqodGIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dsi: don't re-lock the PHY PLL on every DSI
 command
To: "Kavan Smith" <kavansmith82@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706180753.408753-1-kavansmith82@gmail.com>
References: <20260706180753.408753-1-kavansmith82@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:20:44 +0000
Message-Id: <20260706182044.889DF1F00A3A@smtp.kernel.org>
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
- [High] The conditionally skipped `link_clk_set_rate()` is actually dead c=
ode, introducing a regression that permanently drops the OPP performance st=
ate vote.

Pre-existing issues:
- [High] Missing return value check for `pm_runtime_get_sync()` leads to un=
clocked/unpowered register access.
- [High] Missing error check for `link_clk_enable()` in `msm_dsi_host_xfer_=
prepare` leads to unclocked register access and CCF clock refcount underflo=
w.
- [Medium] Runtime PM usage counter leak in `msm_dsi_host_power_on()` error=
 path.
--

commit 215b342ad464ceca1a10f5f0b7106969f6672459
Author: Kavan Smith <kavansmith82@gmail.com>
Subject: drm/msm/dsi: don't re-lock the PHY PLL on every DSI command

This commit attempts to prevent re-locking the PHY PLL on every DSI command
by skipping the link clock rate update if the link is already up. It does
this by checking if the power is already on during the transfer preparation.

Link: https://lists.freedesktop.org/archives/dri-devel/2018-April/172218.ht=
ml

> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index 982abaaac00d5..a98fc89596ca2 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -2170,7 +2170,17 @@ int msm_dsi_host_xfer_prepare(struct mipi_dsi_host=
 *host,
>  	 * mdp clock need to be enabled to receive dsi interrupt
>  	 */
>  	pm_runtime_get_sync(&msm_host->pdev->dev);

[Severity: High]
This is a pre-existing issue, but does this code need to check the return
value of pm_runtime_get_sync()?

If it fails to resume the device's PM domain, the device remains unpowered =
or
unclocked, and the subsequent register accesses (like dsi_write on
REG_DSI_CTRL) might trigger a synchronous external abort.

Looking at msm_dsi_host_power_on(), it also ignores the return value of
pm_runtime_get_sync() before accessing hardware.

[Severity: Medium]
Also in msm_dsi_host_power_on(), this is a pre-existing issue, but does the
error path permanently leak the runtime PM usage count?

If an initialization step fails, the code jumps to fail_disable_reg:

msm_dsi_host_power_on() {
    ...
    pm_runtime_get_sync(&msm_host->pdev->dev);
    ...
    if (ret)
        goto fail_disable_reg;
    ...
fail_disable_clk:
    pm_runtime_put(&msm_host->pdev->dev);
fail_disable_reg:
    ...
}

Since this bypasses the fail_disable_clk label which contains the
pm_runtime_put() call, this seems to prevent the device from ever suspendin=
g.

> -	cfg_hnd->ops->link_clk_set_rate(msm_host);
> +	/*
> +	 * Don't re-set the link clock rate when the link is already up. The
> +	 * requested byte-clock rate rarely equals the DSI PHY PLL's achievable
> +	 * rate, so clk_set_rate() re-locks the PLL on every command; for a
> +	 * video-mode panel with no internal timing generator that clock glitch
> +	 * makes the panel lose pixel lock mid-scanout (~1s of displaced image =
on
> +	 * each DCS write, e.g. every backlight update). The rate is already set
> +	 * at power-on.
> +	 */
> +	if (!msm_host->power_on)
> +		cfg_hnd->ops->link_clk_set_rate(msm_host);

[Severity: High]
Can the !msm_host->power_on condition ever be true?

msm_dsi_host_xfer_prepare() is exclusively reachable via dsi_host_transfer(=
),
which explicitly checks !msm_host->power_on and returns early:

drivers/gpu/drm/msm/dsi/dsi_host.c:dsi_host_transfer() {
    ...
	if (!msg || !msm_host->power_on)
		return -EINVAL;
    ...
}

Because msm_host->power_on is always true here, the newly added condition is
permanently false, meaning link_clk_set_rate() is never called during DCS
transfers.

Since msm_dsi_host_xfer_restore() unconditionally calls link_clk_disable()
(which explicitly zeroes the OPP performance state vote via
dev_pm_opp_set_rate), won't this permanently drop the OPP performance state
vote on all subsequent commands? The hardware would be left operating at hi=
gh
clock frequencies with a 0 voltage vote.

>  	cfg_hnd->ops->link_clk_enable(msm_host);

[Severity: High]
This is a pre-existing issue, but does this code need to check the return
value of link_clk_enable()?

If enabling the link clocks fails (e.g., clk_prepare_enable() fails interna=
lly),
the clocks remain off and the reference count is not incremented. The driver
would then proceed to access hardware registers unclocked, triggering a
synchronous external abort.

Furthermore, msm_dsi_host_xfer_restore() unconditionally calls
link_clk_disable(). This decrements a clock reference count that was never
successfully incremented, which causes a CCF refcount underflow WARN.

> =20
>  	/* TODO: vote for bus bandwidth */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706180753.4087=
53-1-kavansmith82@gmail.com?part=3D1
