Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A9C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBB810E86F;
	Tue, 28 Jul 2026 10:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jourrM+A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC2C10E86F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CDFC60A9E;
 Tue, 28 Jul 2026 10:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68E11F000E9;
 Tue, 28 Jul 2026 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785234945;
 bh=KEQudQSAnrTfZmtTLSDVgumn5WIt5xXx3suYSyWj+lg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jourrM+AVqPr1dHjECpQMhH2+On68b1J3o4c/V7cQ3w0hRIUe3yl3df2vNt3S1HNA
 gOFdqzvE8UNydcWv34+RBW1WFJQmyqi7k0wj4Ue1uTYEVnCZfgqyH0/2fqOvxQnRem
 G0cjwPGbnXupUPqjArvgULBGbAYtA9UrLCu5X47ZCCdaxL4Bfo2Kfcn8Ya5RWEJ4M4
 KS/cq1+n0sYJwgLtyBF0RedIOc57rhNMEMRaqT28UOKOWm6gP0OWN6792srPMBzRgG
 JEYz10ItguBmMxwigWhZsmKQ6a0+5HjKgFqmwLFsovvtS4kUwNWiAbhyAZe07RymYJ
 f/iZWrUzH09fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/14] drm/msm/dp: move the pixel clock control to
 its own API
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-7-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-7-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:35:45 +0000
Message-Id: <20260728103545.B68E11F000E9@smtp.kernel.org>
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
- [High] The refactoring introduces a WARN_ON_ONCE for reachable states and=
 error paths, potentially causing a kernel panic (if panic_on_warn is enabl=
ed).
- [Low] The patch missed replacing duplicated pixel clock disablement logic=
 in msm_dp_ctrl_off_link_stream with the new helper, and the helpers have a=
symmetric signatures.
--

--- Patch [7]: [PATCH v9 07/14] drm/msm/dp: move the pixel clock control to=
 its own API ---
commit c980fe633e423ad69174b99f07ed497b0b4f6cf2
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: move the pixel clock control to its own API

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index f343bd6c2b81a..068d4f8b673f6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2176,6 +2176,41 @@ static bool msm_dp_ctrl_send_phy_test_pattern(stru=
ct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
> =20
> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, un=
signed long pixel_rate)
> +{
> +	int ret;
> +
> +	ret =3D clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	if (ret) {
> +		DRM_ERROR("Failed to set pixel clock rate. ret=3D%d\n", ret);
> +		return ret;
> +	}
> +
> +	if (WARN_ON_ONCE(ctrl->stream_clks_on))
> +		return 0;

[Severity: High]
Is it safe to replace the debug log with a WARN_ON_ONCE() here?

If an atomic commit enables the display, and msm_dp_ctrl_on_stream() succee=
ds
in enabling clocks but fails later (e.g., msm_dp_ctrl_wait4video_ready() ti=
mes
out), it can return an error without disabling the pixel clock.

When the caller msm_dp_display_enable() propagates the error, dp->power_on
remains false.  The teardown path msm_dp_display_disable() will then return
early because power_on is false, leaving the clock enabled.

If userspace attempts to enable the display again, msm_dp_ctrl_on_pixel_clk=
()
would be called with stream_clks_on =3D=3D true, triggering this WARN_ON_ON=
CE().

This could also be triggered if an external DP sink sends a PHY test pattern
request before the display is enabled, via
msm_dp_ctrl_process_phy_test_request().

Since this state is reachable from hardware errors or untrusted external DP
sinks, could this cause a denial of service if panic_on_warn is enabled?

> +
> +	ret =3D clk_prepare_enable(ctrl->pixel_clk);
> +	if (ret) {
> +		DRM_ERROR("Failed to start pixel clocks. ret=3D%d\n", ret);
> +		return ret;
> +	}
> +	ctrl->stream_clks_on =3D true;
> +
> +	return ret;
> +}
> +
> +static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +
> +	ctrl =3D container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_c=
trl);
> +
> +	if (ctrl->stream_clks_on) {
> +		clk_disable_unprepare(ctrl->pixel_clk);
> +		ctrl->stream_clks_on =3D false;
> +	}
> +}

[Severity: Low]
Is this API signature asymmetry intentional?

msm_dp_ctrl_on_pixel_clk() takes a struct msm_dp_ctrl_private *, but this
function takes a struct msm_dp_ctrl *.

Also, it looks like msm_dp_ctrl_off_link_stream() in this same file was mis=
sed
in the refactoring and still contains the duplicated pixel clock disablement
logic.  Should it be updated to use this new helper?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D7
