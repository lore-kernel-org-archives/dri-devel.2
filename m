Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B4AC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1FE10E680;
	Mon, 20 Jul 2026 06:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ihq4izIM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B025810E680
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:26:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 990CE416E1;
 Mon, 20 Jul 2026 06:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532251F000E9;
 Mon, 20 Jul 2026 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528781;
 bh=WTvL+OAIHmbW2eMjkzhtj3/UUPbfnuU+M1AumbqBQqc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ihq4izIMbiYOz1I5Mi9J1P5HGxLhXH+akcvCfmGHNAfknFGaiIXdL5hgg8pnKbqer
 k+39f2WuGJJV9N6bcN4djL7b8RRddEdHSkINqXdXvklaKaRIiArH1LrM5AItSWgWH8
 Bb6zkvLeZF18juC3P6HR4Jen0NOfStMghqtyX1RBpRz1+csI7rtOPjj6ws8JRCIJjY
 Vkpl7jyCWYZgNiu8JSadhjHdVUsQdOsmzaCFigB++YVu6ywQgi1mzZlxUgYxLVEpxO
 btyiyHm02ii+miv/Os6NUT8YuipaP+uYfyvu0aLKuduZKiHaZpAqNMe+ASJq+uJSiT
 hYh4TblWKv6kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/15] drm/msm/dp: split dp_ctrl_off() into stream
 and link parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-11-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-11-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:26:20 +0000
Message-Id: <20260720062621.532251F000E9@smtp.kernel.org>
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

New issues:
- [High] Hardware power-down sequence violation leading to potential DP con=
troller underflows.

Pre-existing issues:
- [High] TOCTOU race condition and lockless access to hardware clock state.
--

--- Patch [11]: [PATCH v8 11/15] drm/msm/dp: split dp_ctrl_off() into strea=
m and link parts ---
commit b7bbbd3dcfb3d3e5bbed08959f3a0e241b42ce06
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: split dp_ctrl_off() into stream and link parts
   =20
Split dp_ctrl_off() into stream and link parts so that for MST
cases we can control the link and pixel parts separately.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 207643fa73063..fc3fbc40b118d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -2241,7 +2241,8 @@ static int msm_dp_ctrl_process_phy_test_request(str=
uct msm_dp_ctrl_private *ctrl
>  	 * running. Add the global reset just before disabling the
>  	 * link clocks and core clocks.
>  	 */
> -	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
> +	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
> +	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);

[Severity: High]
Does this reverse the hardware power-down sequence?

In the original msm_dp_ctrl_off() implementation, the pixel stream clock was
disabled after msm_dp_ctrl_mainlink_disable() and msm_dp_ctrl_reset() had
stopped the hardware.

By calling msm_dp_ctrl_off_pixel_clk() before msm_dp_ctrl_off_link() here,
could we be killing the pixel stream while the DP mainlink is still enabled
and attempting to transport video data? This seems like it could starve the=
 DP
controller's stream FIFO and lead to underflows or hardware lockups.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 8694f366623d8..1ecd700a474fe 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -727,15 +727,16 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp)
> =20
>  		/* set dongle to D3 (power off) mode */
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> -		msm_dp_ctrl_off(dp->ctrl, dp->panel);
> -		/* re-init the PHY so that we can listen to Dongle disconnect */
> +		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> +		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);

[Severity: High]
This is a pre-existing issue, but could this concurrent execution lead to a
race condition resulting in unbalanced clock disables?

The KMS atomic disable path in msm_dp_display_disable() runs in process
context holding DRM modeset locks. However, the HPD notification path
triggering msm_dp_ctrl_process_phy_test_request() is executed without
modeset locks.

Since msm_dp_ctrl_off_pixel_clk() accesses ctrl->stream_clks_on without
synchronization:

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_off_pixel_clk() {
    if (ctrl->stream_clks_on) {
        clk_disable_unprepare(ctrl->pixel_clk);
        ctrl->stream_clks_on =3D false;
    }
}

Would an untrusted external DP sink sending concurrent PHY test requests
during a KMS atomic commit cause both paths to evaluate the flag as true?
This might result in double execution of clk_disable_unprepare() and
corruption of the clock reference counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D11
