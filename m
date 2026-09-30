Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E29CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D1410E186;
	Wed, 30 Sep 2026 12:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TRyOJN3G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7FE10E186
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:59:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9993640E24;
 Wed, 30 Sep 2026 12:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524781F00893;
 Wed, 30 Sep 2026 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790773162;
 bh=jLuLHnX+pa/xZ/j8FReYE7VOLBLZDutvywF1tufFYxo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TRyOJN3GgABeK8CcefeBD25zRw25+wFrnugYcG1IyJ2L26NK2E/nqVv3zjTBOPAFs
 8gkmDQX48BeHA73UoWOwFxE1/v5WdwsBwycCDVpK9NX+ERyUFC7aw0NObqSSsmHMu9
 SYw9JFhsyoarqQpEdGaDy8F6UwDa7dpJDqvM0OKZuqlMaPdjeKb8CyAr0zoQej47Zs
 yFf/To3BhI1w7UHL/WcTPVozPnDQNgz1RuJ79yy8dj1+Uhzp+rQd08wd//jCwlUtyT
 Ei7ZSZ+XNJUMJZOYrnc6OrxthnrdfGp/eSpt7vZb4Owl1hGDPL9zk/knIoU9ozSioG
 xzCqfPFn0/7Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] drm/msm/dp: Track PHY power ownership
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-msm-dp-hdr10-v1-3-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-3-dbbf8b2b42bc@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 12:59:21 +0000
Message-Id: <20260930125922.524781F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] msm/dp: TOCTOU race in PHY power ownership tracking causes power a=
nd clock leak
--

commit c9182f8e77cc8634e408d0bae0ac2751df04598b
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Track PHY power ownership

This commit introduces PHY power ownership tracking to prevent underflow
during repeated cleanup operations. It adds boolean flags to track PHY
power and link clock states and uses them to skip redundant enables or
disables.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 59070f399e2d3..f005421630c63 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -1813,6 +1814,9 @@ static void msm_dp_ctrl_link_clk_disable(struct msm=
_dp_ctrl *msm_dp_ctrl)
> =20
>  	ctrl =3D container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_c=
trl);
> =20
> +	if (!ctrl->link_clks_on)
> +		return;
> +

[Severity: High]
Could this lockless check introduce a clock reference leak when executing
concurrently?

If a DP sink device sends an HPD interrupt with a
DP_TEST_LINK_PHY_TEST_PATTERN request at the same time as a userspace
modeset, msm_dp_ctrl_link_clk_enable() might run concurrently from two
threads (one holding plugged_lock, the other holding drm_modeset_lock).

Both could enable the clock and set the flag. Later, the first disable
call un-sets the flag, causing subsequent calls to return here early
and leak the extra clock reference.

>  	clk_bulk_disable_unprepare(ctrl->num_link_clks, ctrl->link_clks);
> =20
>  	ctrl->link_clks_on =3D false;
> @@ -1824,6 +1828,23 @@ static void msm_dp_ctrl_link_clk_disable(struct ms=
m_dp_ctrl *msm_dp_ctrl)
>  		   str_on_off(ctrl->core_clks_on));
>  }
> =20
> +static int msm_dp_ctrl_phy_power_off(struct msm_dp_ctrl_private *ctrl)
> +{
> +	int ret;
> +
> +	if (!ctrl->phy_powered)
> +		return 0;
> +

[Severity: High]
Similarly, does this skip release when the flag was unset by a racing
thread?

If phy_power_on() was called twice due to the same race, the second
power-off call will skip releasing the reference here, permanently
leaking the PHY power reference.

> +	ret =3D phy_power_off(ctrl->phy);
> +	if (ret) {
> +		DRM_ERROR("Failed to power off PHY: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ctrl->phy_powered =3D false;
> +	return 0;
> +}
> +
>  static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private=
 *ctrl,
>  					      struct msm_dp_panel *panel)
>  {
> @@ -1836,7 +1857,11 @@ static int msm_dp_ctrl_enable_mainlink_clocks(stru=
ct msm_dp_ctrl_private *ctrl,
>  	ctrl->phy_opts.dp.ssc =3D drm_dp_max_downspread(dpcd);
> =20
>  	phy_configure(phy, &ctrl->phy_opts);
> -	phy_power_on(phy);
> +	if (!ctrl->phy_powered) {

[Severity: High]
Does this flag need lock protection? The phy_powered state is checked and
modified without locking here.

When msm_dp_irq_hpd_handle() and msm_dp_display_atomic_enable() race,
both threads could see !ctrl->phy_powered as true, calling phy_power_on()
twice and incrementing the PHY core's power_count twice.

> +		ret =3D phy_power_on(phy);
> +		if (!ret)
> +			ctrl->phy_powered =3D true;
> +	}
> =20
>  	dev_pm_opp_set_rate(ctrl->dev, ctrl->link->link_params.rate * 1000);
>  	ret =3D msm_dp_ctrl_link_clk_enable(&ctrl->msm_dp_ctrl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-msm-dp-hdr=
10-v1-0-dbbf8b2b42bc@radxa.com?part=3D3
