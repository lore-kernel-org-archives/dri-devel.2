Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4377ACDB46B
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479CE10E32D;
	Tue, 23 Jun 2026 02:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ncWmLQvF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30ADB10E32D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 02:22:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E3316001D;
 Tue, 23 Jun 2026 02:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C8F1F000E9;
 Tue, 23 Jun 2026 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782181372;
 bh=Xr9gf42xjz5beWtVv1UnoWTtk9uMf2o6/TKWnqPn7bY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ncWmLQvFND4oVBMPOQTO0Y0lgUTCfii0FdVClFyqLtAWusEVjZLpXY6wguQApY8bU
 xjopJ69nQIiiqPVQmpoi1dhfYd41VTbFyTK0cr7y4AmTx6p+lfhTdK7BQRg2WPc+S1
 z0QBb9mETF1TUzsBlR1hKFpKJi+d7zNAQ0Cz4Vv9ReoNVI/s1Z4PLydtLLgPS+b0xV
 Pph0Oj88UX2ahoMgvRU7PT89R11vtu5iMKkm3XUTIDiv6L2HG+0S93poQDBG35/BRd
 1GR84Hdwj4iocetlqx/y5Nu3fciin2tmeBdckvIa3K87JO7r7BjhhLd/sL5Yzr2s+k
 bTMHMUS4FzbwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/bridge: analogix_dp: Fix PE/VS value shift
 mismatch during link training
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623020811.307341-1-damon.ding@rock-chips.com>
References: <20260623020811.307341-1-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 02:22:51 +0000
Message-Id: <20260623022251.E5C8F1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch activates a dormant logic bug that causes Clock Recovery=
 to instantly fail if the DP sink requests maximum pre-emphasis.
- [High] The clock recovery loop counter `cr_loop` accumulates across diffe=
rent requested levels instead of tracking consecutive identical requests.
--

commit 2ce38552c8226840ef5d2e4d8187e099b547ef5a
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Fix PE/VS value shift mismatch during link training

This commit fixes a missing bit-shift for voltage swing and pre-emphasis
values during DP link training. It shifts the raw values returned by the
drm_dp_get_adjust_request_* functions so they can be properly used with
the DPCD_*_SET macros.

Link: https://lore.kernel.org/all/CAAMcf8D-d+5n=3DH44KeKBSqWY42m+o32W+mO-r1=
5VqWNyYhJL7Q@mail.gmail.com/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8cf6b73bceac0..5006ac181b2d7 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -355,7 +357,9 @@ static int analogix_dp_process_clock_recovery(struct =
analogix_dp_device *dp)
>  	for (lane =3D 0; lane < lane_count; lane++) {
>  		training_lane =3D analogix_dp_get_lane_link_training(dp, lane);
>  		voltage_swing =3D drm_dp_get_adjust_request_voltage(link_status, lane);
> +		voltage_swing >>=3D DP_TRAIN_VOLTAGE_SWING_SHIFT;
>  		pre_emphasis =3D drm_dp_get_adjust_request_pre_emphasis(link_status, l=
ane);
> +		pre_emphasis >>=3D DP_TRAIN_PRE_EMPHASIS_SHIFT;
> =20
>  		if (DPCD_VOLTAGE_SWING_GET(training_lane) =3D=3D voltage_swing &&
>  		    DPCD_PRE_EMPHASIS_GET(training_lane) =3D=3D pre_emphasis)

[Severity: High]
This is a pre-existing issue, but does this lack of reset cause premature l=
ink
training failures?

In analogix_dp_process_clock_recovery(), cr_loop[lane] is incremented when
the requested levels match the applied levels. However, if the DP sink
requests a new level, the counter is not reset to 0.

It appears to accumulate counts across different levels during the entire
clock recovery phase. If the sink steps through multiple levels and hits
the MAX_CR_LOOP limit in total (e.g., 2 loops at level 1, 2 loops at level =
2,
1 loop at level 3), could it incorrectly trigger the abort condition below?

[Severity: High]
This isn't a bug introduced by this patch, but does fixing the shift logic
activate a dormant bug right below this check?

Immediately after the snippet above in analogix_dp_process_clock_recovery(),
the code checks:

		if (dp->link_train.cr_loop[lane] =3D=3D MAX_CR_LOOP ||
		    voltage_swing =3D=3D VOLTAGE_LEVEL_3 ||
		    pre_emphasis =3D=3D PRE_EMPHASIS_LEVEL_3) {
			dev_err(dp->dev, "CR Max reached (%d,%d,%d)\n", ...);
			analogix_dp_reduce_link_rate(dp);
			return -EIO;
		}

Before this patch, pre_emphasis evaluated to 24, which bypassed this abort.
Now that the value is properly shifted, if the sink legitimately requests
PRE_EMPHASIS_LEVEL_3 (which evaluates to 3), won't the driver immediately
return -EIO and abort clock recovery instead of applying the maximum level
and setting the MAX_PRE_EMPHASIS_REACHED bit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623020811.3073=
41-1-damon.ding@rock-chips.com?part=3D1
