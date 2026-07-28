Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA656C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3885610E3BC;
	Tue, 28 Jul 2026 10:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="athHbg1e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E601010E3BC
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:41:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41CF460A9B;
 Tue, 28 Jul 2026 10:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12AD1F000E9;
 Tue, 28 Jul 2026 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785235286;
 bh=lmqv3Ag+coJBuV/bNY5vExYtyMvGeioTtTVX/L10dkk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=athHbg1eoMro0Yi/lHJn8CRVqiqrdAW+vhWTLZ3TAq0ZCi6OFp7/1WbOiGxYv6VCg
 uk7mxEY4iKYwvSIYpJqfHl8YTZDnmDq30AZL8HDwJHYmD2aJd77Kp4oQtyRe+r6o/+
 wbjr35l1mLt1s2Y3/4Qb4zsrYHGEyXqK+ZBVGqr9P/tPTKj5DK7UxCeOZG1P6n7PtF
 JMTMEczWfKtocwSgrpt2VIBJK+19xozWCzpB0xzLMuJfriuCHE0GySpo+Wxv3bA7R1
 2/YwIAqSVu5syeX/qFo0cQjwGsqBlkXH6BbuMXA0oqzeA2D4zmNOAhYA7zrK0oOfmi
 D1UnzoGSgG6NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/14] drm/msm/dp: simplify link and clock disable
 sequence
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-12-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-12-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:41:25 +0000
Message-Id: <20260728104125.C12AD1F000E9@smtp.kernel.org>
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
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race condition on `dp->link-=
>sink_count` leading to mismatched hardware state.
--

--- Patch [12]: [PATCH v9 12/14] drm/msm/dp: simplify link and clock disabl=
e sequence ---
commit 68b08e6a0d7bd864688b398d6052cc9412efcc7c
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: simplify link and clock disable sequence

This commit moves common disable steps out of the sink_count check to make
the flow easier to follow.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6e392a99438f8..9b9e96b683c71 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> +	/* dongle is still connected but sinks are disconnected */
> +	if (dp->link->sink_count =3D=3D 0)
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	if (dp->link->sink_count =3D=3D 0)

[Severity: High]
Can this introduce a race condition if sink_count changes between these two
checks?

Looking at msm_dp_display_disable(), the sink_count is now evaluated twice.
If a user plugs or unplugs a monitor exactly when this disable sequence
is occurring, the HPD event thread might locklessly update sink_count:

CPU1 (msm_dp_display_disable)
    if (dp->link->sink_count =3D=3D 0) // evaluates to true
        msm_dp_link_psm_config(...);

CPU2 (HPD IRQ thread)
    msm_dp_link_process_request()
        dp->link->sink_count =3D 1; // updated locklessly

CPU1
    msm_dp_ctrl_off_link(...);
    if (dp->link->sink_count =3D=3D 0) // now evaluates to false
    else
        msm_dp_display_host_phy_exit(dp);

If this state diverges, the driver might completely disable the PHY while
a dongle is still connected and in PSM mode, preventing the hardware from
detecting subsequent dongle disconnects.

Would it be safer to cache the initial sink_count in a local variable to
ensure consistent state transitions throughout the function?

> +		/* re-init the PHY so that we can listen to Dongle disconnect */
>  		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	} else {
> -		/*
> -		 * unplugged interrupt
> -		 * dongle unplugged out of DUT
> -		 */
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +	else
>  		msm_dp_display_host_phy_exit(dp);
> -	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D12
