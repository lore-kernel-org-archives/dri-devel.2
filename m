Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF73CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC66310FE48;
	Fri,  9 Oct 2026 03:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V0X3Y28f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3DF10FE48
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD7A341AB3;
 Fri,  9 Oct 2026 03:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8521F000FF;
 Fri,  9 Oct 2026 03:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791516937;
 bh=vn9xLqecG/iJznrV55TfoGAVffj2F69FusTLuIK7Xls=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V0X3Y28fW+NHoq3RweDwuh2RQ5ci7ttmF+8NvGWIsHuWWtRy7Kpz4wLs5AQ0eTGA1
 QvzMAicJlOVtP7pw+XgWOiuHYkKLc9OFISe4qAuFIzuAH4z6MY+Jvl7AQoi+eMEunJ
 kqugpYApkOO4g8lTgOSGyECrmSsUWokow2TE1RzQ7qM6iZ9KG/v0tMCQWqf1FmXGKI
 G6KvqWM2YF2Rd0eeaFxt5oV6NIchiT1pxEIptWcLcQa2gGNdY2+0UILZwhZARpmPon
 AXPRHNs3wG8PdipIJgsOjSsjj0iKKDz3A2Ajt7B+DTIaSg0JVK/q5G9Yo8d70OVPRq
 ymBSzpvFZPj2Q==
Message-ID: <sashiko-outbox-164777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/20] drm/msm/dp: Unwind resources when enabling a
 stream fails
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:35:36 +0000
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
- [High] pm: pm_runtime reference leak in msm_dp_bridge_detect()
- [Medium] drm/msm/dp: dead code in stream enable abort path due to sink_co=
unt invariant
--

commit aeec7eb4a5527629640011cba89d7bbaaf90341c
Author: Xilin Wu <sophon@radxa.com>
Subject: drm/msm/dp: Unwind resources when enabling a stream fails

This patch introduces resource unwinding for stream enable failures by trac=
king
the stream PM reference and mainlink startup status. It unifies the rollback
paths and propagates errors from PHY initialization.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 787efbcb6c124..b076d44b5118c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -988,6 +1014,7 @@ enum drm_connector_status msm_dp_bridge_detect(struc=
t drm_bridge *bridge,
> =20
>  		put =3D true;
>  	}
> +unlock:
>  	mutex_unlock(&priv->plugged_lock);
> =20
>  	if (put)
>  		pm_runtime_put_sync(&dp->pdev->dev);

[Severity: High]
Does msm_dp_bridge_detect() leak a PM runtime reference here?

msm_dp_bridge_detect() unconditionally calls pm_runtime_resume_and_get()
earlier in the function. If the display is already connected (priv->plugged
is true), the exit path skips setting put =3D true.=20

As a result, pm_runtime_put_sync() is never called, which leaks the PM
reference. Since userspace can poll the detect callback repeatedly
(e.g., via DRM_IOCTL_MODE_GETCONNECTOR), could this leak the PM reference
indefinitely and permanently prevent the device from suspending?

[ ... ]

> @@ -1460,6 +1493,52 @@ void msm_dp_display_atomic_pre_enable(struct msm_d=
p *msm_dp_display,
>  	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp-=
>panel);
>  }
> =20
> +static void msm_dp_display_abort_enable_locked(struct msm_dp_display_pri=
vate *dp)
> +{
> +	bool keep_aux;
> +	int ret;
> +
> +	lockdep_assert_held(&dp->plugged_lock);
> +
> +	keep_aux =3D !dp->msm_dp_display.is_edp && dp->plugged &&
> +		msm_dp_aux_is_link_connected(dp->aux);
> +
> +	if (dp->stream_link_attempted) {
> +		/* The AUX peer is the remaining dongle, not its absent sink. */
> +		if (keep_aux && !dp->link->sink_count && dp->phy_initialized)
> +			msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);

[Severity: Medium]
Is this Power Save Mode (PSM) configuration block unreachable?

The condition !dp->link->sink_count is evaluated inside the
if (dp->stream_link_attempted) block. However, dp->stream_link_attempted
is only set to true in msm_dp_display_prepare_link_locked() if
dp->link->sink_count is non-zero.=20

Because both msm_dp_display_prepare_link_locked() and=20
msm_dp_display_abort_enable_locked() execute sequentially within the same=20
plugged_lock critical section in msm_dp_display_atomic_enable(), concurrent
HPD events cannot modify sink_count.

Doesn't this mean the inner check !dp->link->sink_count will always evaluate
to false, rendering this fallback dead code?

> +
> +		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> +		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +		dp->stream_link_attempted =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D9
