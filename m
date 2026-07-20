Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E893DC44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1055E10E129;
	Mon, 20 Jul 2026 06:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Emfb7rjF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FDA10E129
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:24:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55AF2601D9;
 Mon, 20 Jul 2026 06:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E079D1F000E9;
 Mon, 20 Jul 2026 06:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528646;
 bh=Dw88WAHGnKlXcLPhwXesdlYgqAD86XsK5pb3uX9zR4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Emfb7rjF6TtaxWJwc3n/VX+eib9CycPm069J9DmtGEn9o5jZ7V+Qorxkydz4I7Fqf
 KaLLJIgwjyzjI/gWStFvoaTAbvZASf7dMa/62IQO+vDmjtsV7L4Bzuf6g9btnpkPmd
 iWNe1XcOqU62SgZ1PVyJEUVExdSCo47XPLiKGWLypb1uLyfKvdqE58QzwEDCslLQ8G
 YAF8N/rK3xMhsZ0d1b/WSCoNlFUwjxYgJNS6bC1rFEVzNsPlFO7cZ2riKTIAaZvzyo
 T53cIPj6AEoKCfTehAQicRkfgXw7otkyKfrwuSZj1jiWomHV+5X/xe4hLp/oVbq2bl
 ektzUILSa0eig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-10-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-10-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:24:05 +0000
Message-Id: <20260720062405.E079D1F000E9@smtp.kernel.org>
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
- [High] Secondary stream panels fail to have their `hw_revision` initializ=
ed, silently breaking controller-specific hardware workarounds in MST setup=
s.
- [High] Stream-specific panels are incorrectly passed to mainlink APIs, co=
rrupting shared link state and misconfiguring the link based on leaf monito=
r capabilities instead of the MST hub.
--

--- Patch [10]: [PATCH v8 10/15] drm/msm/dp: allow dp_ctrl stream APIs to u=
se any panel passed to it ---
commit 07d3f4b80ae5875a958a8aceb22c9ffab07db108
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it

With MST, multiple sinks share a single DP controller, so a cached
panel in msm_dp_ctrl_private can no longer represent the per-stream
sink. Drop the cache and pass panel explicitly to all stream-related
dp_ctrl APIs.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index ae79cbec26d19..207643fa73063 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -219,7 +219,7 @@ void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctr=
l)
> =20
>  	if (!ctrl->hw_revision) {
>  		ctrl->hw_revision =3D msm_dp_read_ahb(ctrl, REG_DP_HW_VERSION);
> -		ctrl->panel->hw_revision =3D ctrl->hw_revision;
> +		panel->hw_revision =3D ctrl->hw_revision;
>  	}
>  }

[Severity: High]
Does this leave the hw_revision uninitialized for secondary stream panels i=
n an
MST setup?

Since ctrl->hw_revision is populated during the host initialization for the
primary panel, any subsequent stream panels passed to this function will by=
pass
the assignment. Could this silently break hardware workarounds that depend =
on
panel->hw_revision being set correctly?

[ ... ]

> @@ -414,10 +414,11 @@ static void msm_dp_ctrl_config_ctrl_streams(struct =
msm_dp_ctrl_private *ctrl,
>  	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>  }
> =20
> -static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctr=
l)
> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctr=
l,
> +					 struct msm_dp_panel *panel)
>  {
>  	u32 config =3D 0;
> -	const u8 *dpcd =3D ctrl->panel->dpcd;
> +	const u8 *dpcd =3D panel->dpcd;
> =20
>  	/* Default-> LSCLK DIV: 1/4 LCLK  */
>  	config |=3D (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);

[Severity: High]
Can the direct write to REG_DP_CONFIGURATION_CTRL at the end of this functi=
on
erase stream-specific configurations established by previously enabled stre=
ams?

Since msm_dp_ctrl_config_ctrl_link() is called on every stream enable from
msm_dp_ctrl_on_stream(), it seems this might overwrite the shared register =
and
corrupt the state of active streams.

[ ... ]

> @@ -1810,11 +1821,12 @@ static void msm_dp_ctrl_link_clk_disable(struct m=
sm_dp_ctrl *msm_dp_ctrl)
>  		   str_on_off(ctrl->core_clks_on));
>  }
> =20
> -static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private=
 *ctrl)
> +static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private=
 *ctrl,
> +					      struct msm_dp_panel *panel)
>  {
>  	int ret =3D 0;
>  	struct phy *phy =3D ctrl->phy;
> -	const u8 *dpcd =3D ctrl->panel->dpcd;
> +	const u8 *dpcd =3D panel->dpcd;
> =20
>  	ctrl->phy_opts.dp.lanes =3D ctrl->link->link_params.num_lanes;
>  	ctrl->phy_opts.dp.link_rate =3D ctrl->link->link_params.rate / 100;

[Severity: High]
Is it correct to use the stream-specific (leaf) DPCD to configure shared
mainlink properties here and in msm_dp_ctrl_link_train()?

This appears to misconfigure the link based on leaf monitor capabilities in=
stead
of the MST hub. If a leaf monitor doesn't support features like enhanced
framing or downspread, but the hub does, could this break the link to the h=
ub?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D10
