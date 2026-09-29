Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1567ACA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6650110EEB6;
	Tue, 29 Sep 2026 13:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HA1PeOBV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4648910EEB6
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:20:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D733D41886;
 Tue, 29 Sep 2026 13:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911491F000FF;
 Tue, 29 Sep 2026 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790688029;
 bh=K3Jv4wXis8a7twDoD7CMl2OCAUe9Bm61pdjA4FePadI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HA1PeOBVzW0JD+OW33aELwcT7oHs0CYhSAC7BHY42M5H8Y5wttFxXDjUyowkWU5aj
 cEfXON4TYIEH6T9JkNnj+doZZuZeV3ics1WEgLO0ZyFaF9Wt0VaK+apaL3r4ubNx2A
 QdSPjeYA5kEvH+rbmYNdyNb3VaI6aAi4V648WXnqLkq+6uAzB3MLSvEwmNgQSMAzoA
 OxkSx/KUu6nwdszABhSKvS904flT59d2vMJ15SHkh6nTHuDQBy3Hu331srBHRCIH7t
 hOPK5rDI90auVAwkwhC8t+j4hFMP5AmqQ/kkaBT7ZKrcu2zx601oWdfOl0zNe4lziN
 n9DmK3iezdSvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: hold one runtime PM reference per plugged
 state
To: "Joonhoe Kim" <26rote@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929130627.959-1-26rote@gmail.com>
References: <20260929130627.959-1-26rote@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:20:29 +0000
Message-Id: <20260929132029.911491F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: dropping plugged PM ref in detect() breaks PHY init on=
 replug
--

commit c051f74425731ad4ec4c7067fd0c9ebc38bc16ab
Author: Joonhoe Kim <26rote@gmail.com>

drm/msm/dp: hold one runtime PM reference per plugged state

This commit modifies the DP runtime PM handling to take exactly one referen=
ce
for the plugged state, avoiding leaks where multiple HPD events or detect()
calls accumulate references and prevent the controller from suspending.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6abe30bdff120..4e47b659c71df 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -960,6 +969,12 @@ enum drm_connector_status msm_dp_bridge_detect(struc=
t drm_bridge *bridge,
>  		}
> =20
>  		pm_runtime_put_sync(&dp->pdev->dev);
> +		/* the sink is gone: drop the plugged state's reference too */
> +		if (was_plugged)
> +			pm_runtime_put_sync(&dp->pdev->dev);

[Severity: High]
Does dropping the plugged state PM reference here allow the controller to
suspend while the PHY software state still thinks it is initialized?

If msm_dp_bridge_detect() fails during a physical unplug (for example,
failing to read DPCD caps), it sets priv->plugged to false and jumps here to
drop both its own PM reference and the plugged state's PM reference.

The hardware unplug interrupt would then trigger msm_dp_hpd_unplug_handle(),
which has an early return:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_hpd_unplug_handle() {
    ...
    guard(mutex)(&dp->plugged_lock);
    if (!dp->plugged)
        return 0;
}

Because detect() already cleared dp->plugged, this early return skips teari=
ng
down the PHY state with msm_dp_display_host_phy_exit().

Then, on the next plug, msm_dp_display_host_phy_init() will silently skip
PHY initialization because dp->phy_initialized was never reset to false:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_host_phy_init() {
    ...
    if (!dp->phy_initialized) {
        msm_dp_ctrl_phy_init(dp->ctrl);
        dp->phy_initialized =3D true;
        return true;
    }
    return false;
}

Can this sequence leave the hardware PHY uninitialized on replug, causing
link training to fail and the display to remain broken until reboot?

> +	} else if (was_plugged) {
> +		/* the plugged state already holds its reference */
> +		pm_runtime_put_sync(&dp->pdev->dev);
>  	}
> =20
>  	return status;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929130627.959-=
1-26rote@gmail.com?part=3D1
