Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB3FC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E14A10E063;
	Tue,  8 Sep 2026 09:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MCqzN2dw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E6D10E063
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:31:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D62CA4341F;
 Tue,  8 Sep 2026 09:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5E31F00A3D;
 Tue,  8 Sep 2026 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788859867;
 bh=m2MWnb0vwDGTo6Oio/0mTOCEYN7VUOdLLQFifG1JOkI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MCqzN2dwfuZorFHd7V26w3LF4b5BGsxGgXW+OV9Y+IvdnD+sLObTRtkeFh5+LtIJv
 D+PGNK/p25URWICY20VNCVrhP65K5cOlCuRYBt9eTLFwZrIl+Jwi7e+9jatH0sihxL
 ViRMC41MIj3zFwFqWgGgHPpkn3FXU4s4hYAhyPzKr0xLY5Qljhk7wC4WtEIjXJxnOv
 JyFIPgBs2YuX6idBeXmaJyeWJYoS6z7T0pq4bAc+sEPWEkDrxjg723I2hjqQVX78km
 0s/0zK6Y6LoGM2gu8hxt/SBzN8mILoy63xP6kCmehg106pI7SroQ+6rWr/4QYK8/bj
 9W40C0YUSCuyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: don't gate eDP on DP_SINK_COUNT
To: "Vivek Kumar" <vk092kumar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908091708.3123735-1-vk092kumar@gmail.com>
References: <20260908091708.3123735-1-vk092kumar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:31:06 +0000
Message-Id: <20260908093107.8F5E31F00A3D@smtp.kernel.org>
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
- [High] Incomplete fix leaves eDP branch devices gated on sink_count and s=
kips critical initialization.

Pre-existing issues:
- [High] PM runtime usage counter underflow on pm_runtime_resume_and_get fa=
ilure.
--

commit 2e22ab220d8aa377241f1c1461ea7061493df07f
Author: Vivek Kumar <vk092kumar@gmail.com>

    drm/msm/dp: don't gate eDP on DP_SINK_COUNT
   =20
    msm_dp_display_prepare_link(), msm_dp_display_disable(), and
    msm_dp_hpd_unplug_handle() all treat dp->link->sink_count =3D=3D 0 as
    "nothing is connected", and in msm_dp_display_prepare_link() this
    causes probe/enable to fail outright with -ENOTCONN.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index bc646d172abe0..9254f080f0ea6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -634,7 +640,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_=
display_private *dp)
>  		return rc;
>  	}

[Severity: High]
This is a pre-existing issue, but can this early return cause a PM runtime
usage counter underflow?

If pm_runtime_resume_and_get() fails here in msm_dp_display_prepare_link(),=
 it
returns a negative error and drops the reference. This failure propagates b=
ack,
and eventually the DRM core calls msm_dp_display_atomic_post_disable(), whi=
ch
unconditionally executes msm_dp_display_unprepare() and calls
pm_runtime_put_sync(), decrementing a counter that was never incremented.

> -	if (dp->link->sink_count =3D=3D 0)
> +	if (msm_dp_link_no_sink(dp))

[Severity: High]
Does this fix miss the eDP sink count exemption in msm_dp_panel_read_link_c=
aps(),
leaving eDP branch devices gated and causing critical initialization to be
skipped?

When an eDP branch device with a 0 sink_count is connected,
msm_dp_panel_read_link_caps() in dp_panel.c still aborts:

		count =3D drm_dp_read_sink_count(panel->aux);
		if (!count) {
			panel->link->sink_count =3D 0;
			return -ENOTCONN;
		}

Because this failure propagates back to msm_dp_display_process_hpd_high(), =
it
skips EDID reading and PSM link configuration:

	rc =3D msm_dp_panel_read_link_caps(dp->panel, connector);
	if (rc)
		goto end;

Then, earlier in msm_dp_display_prepare_link(), the return value of
msm_dp_hpd_plug_handle() (which calls msm_dp_display_process_hpd_high) is
ignored for eDP:

	if (msm_dp_display->is_edp)
		msm_dp_hpd_plug_handle(dp);

As a result, the driver proceeds to use the display in an uninitialized and
degraded state.

>  		return -ENOTCONN;
> =20
>  	if (!msm_dp_display->power_on) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908091708.3123=
735-1-vk092kumar@gmail.com?part=3D1
