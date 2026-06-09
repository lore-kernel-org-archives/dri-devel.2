Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D5ECD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45ED610E21B;
	Tue,  9 Jun 2026 10:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LB1eAqCR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB9F10E21B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:06:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DAED60172;
 Tue,  9 Jun 2026 10:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935F1F00893;
 Tue,  9 Jun 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999617;
 bh=QS/AIzhKttWZKwXT8ZFqczduykdKk99XHrGxXnswGas=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LB1eAqCR5lzD7bzNp4d3ghA51n9igdck6H5FLTNSG3x95/QTlqELR3xqGOAmBqOjG
 v0pQe1NtEQq0gGtRO3AArvQRSSAfvFw41GDm+64t1ogX6SqW2hAuGzlSOpfzFHY6KH
 rO8yV+plC0/0arLpE9zGMK9kVy3tq3D7UtMkhsn5KQzIi8hXvc5j9GoeLvHzBxrwDZ
 m22WCS+Iz3tqTejk+8+QW3gYrAcm/dnN1uRTruLa+8ZNsdPfWSFPmyUGLsvePJ9Xr0
 NYAnqz+xOiWCcuDz2kNlyHDor2mEKiUaIY8VnSPjJGGea1GcpdJLur6dQZ24rPbfuQ
 Un7foWRnN48oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/15] drm/msm/dp: drop deprecated .mode_set() and
 use .atomic_enable
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-2-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-2-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:06:57 +0000
Message-Id: <20260609100657.8935F1F00893@smtp.kernel.org>
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
- [High] Moving mode setup to `.atomic_enable` causes the upstream DPU enco=
der to read stale wide-bus configuration data during its own enablement.

Pre-existing issues:
- [High] Mode validation callback incorrectly evaluates wide bus availabili=
ty based on the state of the currently active mode rather than the candidat=
e mode.
--

commit 1b0de5b490fbc6b7e19b00f71948fa7d36954fe7
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable

The bridge .mode_set() callback is deprecated. Remove it and move all
mode setup logic to .atomic_enable(), where the adjusted_mode is
available from the atomic CRTC state.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index bce165bac106b..57eafd4724627 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1309,7 +1325,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp =
*msm_dp_display)
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
> +	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this function
check the currently active mode's format rather than the candidate mode's
format?

During mode validation in msm_dp_display_mode_valid(), the driver calls
msm_dp_wide_bus_available() to adjust pixel clock limits. Since this reads
the active mode's YUV420 state, wouldn't it incorrectly assume wide bus is
unavailable for a candidate RGB mode if the currently active mode happens
to be YUV420?

This might cause valid high-resolution RGB modes to be rejected because
their clock exceeds DP_MAX_PIXEL_CLK_KHZ. Additionally, isn't this reading
a state field that could be locklessly mutated by concurrent atomic commits?

>  		return false;
> =20
>  	return dp->wide_bus_supported;

[ ... ]

> @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge =
*drm_bridge,
>  	if (msm_dp_display->link->sink_count =3D=3D 0)
>  		return;
> =20
> -	rc =3D msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> +	rc =3D msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_d=
isplay->panel);

[Severity: High]
By moving the mode setup here into the bridge's .atomic_enable callback,
could this cause the upstream DPU encoder to read stale wide-bus
configuration data?

The DRM atomic helper sequence executes the encoder's .atomic_enable hook
before the bridge's .atomic_enable hook. In the encoder's enable sequence:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_virt_atomic_enable()
    dpu_enc->wide_bus_en =3D dpu_encoder_is_widebus_enabled(drm_enc);

This calls down to msm_dp_wide_bus_available(), which checks the
out_fmt_is_yuv_420 flag.

Since the bridge hasn't updated its mode state yet via
msm_dp_display_set_mode(), won't the encoder read the stale value from the
previous modeset?

This seems like it could incorrectly enable or disable wide bus support
when switching between RGB and YUV420 modes, potentially leading to a
hardware configuration mismatch and display corruption.

>  	if (rc) {
>  		DRM_ERROR("Failed to perform a mode set, rc=3D%d\n", rc);
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D2
