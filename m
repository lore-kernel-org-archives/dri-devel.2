Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9546C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 12:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E4210E0E6;
	Sun, 12 Jul 2026 12:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PysOQpRV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83FE10E0E6
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:11:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A90796004E;
 Sun, 12 Jul 2026 12:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8A01F000E9;
 Sun, 12 Jul 2026 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783858263;
 bh=q19ItgJwyg0YzkRLdP32Zwx2RCDKHiDKbWWTzdskXds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PysOQpRVzHDoovBkahIzty4BRzIIMA3+l6HaSdYlEob8lbJZnYUbhzGI6ynpX6TPu
 XuE596kmTaU7T5G+2OhBs0S0Ytfl15ovZ/aHdvFmIkTm6fcz/f5ILS6+Qj0wt2N0vP
 yYt5OniCkjeVR0/q+zKohT1Rk2ssBxSLTJ845aZ/flXDxtnTNk3eh1EwI9oqaBIR72
 /eZO0Od+IoCwLY/uwg+P+55qhIwkhpxY42vZAzCx++k84hObDuM8tpn4kO1wdKO6qH
 /9WSAE7IBlQ6ZfOshyt7KkZ3I2EX6QXE3mBWFE9XhHqiuOjkKJgeSsLHWDkUSPxEsR
 vU3+wyQY8rdoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Revert "drm/msm: dsi: fix PLL init in bonded mode"
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-msm-revert-dsi-pll-fix-v1-1-40122689ea25@oss.qualcomm.com>
References: <20260712-msm-revert-dsi-pll-fix-v1-1-40122689ea25@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 12:11:02 +0000
Message-Id: <20260712121103.3E8A01F000E9@smtp.kernel.org>
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
- [High] Forced overwrite of PLL reference counter in PHY enable/disable co=
nflicts with VCO prepare/unprepare, leading to skipped hardware initializat=
ion and PLL lock failures.
- [Medium] Data race when reading `pll_enable_cnt` outside of its protectin=
g spinlock in `dsi_pll_enable_pll_bias`.

Pre-existing issues:
- [High] Dangling pointer in the global `pll_7nm_list` array leads to a Use=
-After-Free if device probe fails.
--

--- Patch [1]: [PATCH] Revert "drm/msm: dsi: fix PLL init in bonded mode" -=
--
commit 04f56183f63de02b770cafb9bbcc705bedd10f12
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Revert "drm/msm: dsi: fix PLL init in bonded mode"

This commit reverts commit 93c97bc8d85d which fixed an issue with DSI
bonded mode but broke non-bonded usecases. The clock divider was being
programmed incorrectly in non-bonded mode, resulting in the wrong display
mode being selected.

Closes: https://lore.kernel.org/r/ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com

> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/=
msm/dsi/phy/dsi_phy_7nm.c
> index 984a66085dfbf..5d805a797abdb 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -426,8 +426,11 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7=
nm *pll)
>  	u32 data;
> =20
>  	spin_lock_irqsave(&pll->pll_enable_lock, flags);
> -	pll->pll_enable_cnt++;
> -	WARN_ON(pll->pll_enable_cnt =3D=3D INT_MAX);
> +	if (pll->pll_enable_cnt++) {
> +		spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
> +		WARN_ON(pll->pll_enable_cnt =3D=3D INT_MAX);

[Severity: Medium]
Can reading pll_enable_cnt outside of pll_enable_lock cause a data race?

If dsi_7nm_phy_enable() or dsi_7nm_phy_disable() concurrently forces
pll_enable_cnt to 1 or 0, this lockless read of pll->pll_enable_cnt in the
WARN_ON statement could result in undefined behavior or spurious warnings.

> +		return;
> +	}
> =20
>  	data =3D readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
>  	data |=3D DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;

[ ... ]

> @@ -873,6 +876,7 @@ static int dsi_pll_7nm_init(struct msm_dsi_phy *phy)
>  	spin_lock_init(&pll_7nm->pll_enable_lock);
> =20
>  	pll_7nm->phy =3D phy;
> +	phy->pll_data =3D pll_7nm;

[Severity: High]
This is a pre-existing issue, but can this lead to a Use-After-Free if the
device probe fails?

In dsi_pll_7nm_init(), the newly allocated pll_7nm is assigned to the
global pll_7nm_list[phy->id] before this section. If pll_7nm_register() or
a subsequent probe operation fails, the devm framework frees the pll_7nm
struct, but the dangling pointer remains in pll_7nm_list.

If another bonded PHY probes successfully, could it assign this dangling
pointer to its pll_7nm->slave and dereference it during
dsi_pll_enable_pll_bias(), causing memory corruption?

> =20
>  	ret =3D pll_7nm_register(pll_7nm, phy->provided_clocks->hws);
>  	if (ret) {

[ ... ]

> @@ -1084,10 +1090,13 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy =
*phy,
>  		glbl_rescode_bot_ctrl =3D 0x3c;
>  	}
> =20
> +	spin_lock_irqsave(&pll->pll_enable_lock, flags);
> +	pll->pll_enable_cnt =3D 1;

[Severity: High]
Does forcing pll_enable_cnt to 1 here conflict with the increment in
dsi_pll_enable_pll_bias()?

During display bringup, dsi_7nm_phy_enable() is called and sets
pll_enable_cnt to 1. When clk_prepare() subsequently calls
dsi_pll_enable_pll_bias(), the condition:

	if (pll->pll_enable_cnt++) {
		spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
		...
		return;
	}

will evaluate to true, causing the function to return early and skip
programming REG_DSI_7nm_PHY_PLL_SYSTEM_MUXES. Will this cause the PLL to
fail to lock and break the display?

>  	/* de-assert digital and pll power down */
>  	data =3D DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
>  	       DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
>  	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
> +	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
> =20
>  	/* Assert PLL core reset */
>  	writel(0x00, base + REG_DSI_7nm_PHY_CMN_PLL_CNTRL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-msm-revert=
-dsi-pll-fix-v1-1-40122689ea25@oss.qualcomm.com?part=3D1
