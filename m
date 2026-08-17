Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC6FC5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC5E10E956;
	Mon, 17 Aug 2026 21:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TwHlR4nh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6E110E956;
 Mon, 17 Aug 2026 21:15:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B48E0435A8;
 Mon, 17 Aug 2026 21:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3551F000E9;
 Mon, 17 Aug 2026 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787001348;
 bh=gFpnFAZY88hh6G8cS1ekK4LYfaNjOVz8BXzuyS3FOYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TwHlR4nhED3uxqkuey+gPHcblhJgUuHoSmyOGZ92XvncpsdNFBOUNaUHG9kxq//UW
 w5c8HnOX1oxIGJStESHKWc5YYujDdV1wsYG42qpWh9Xgz393p/Do8lFW3fHuVBQK0r
 jBtGQ+ZDF9DNuvpjxPIlFTqNncjo7CA9zqIgOGcFXKVg9crz2xiHyFlxmeB4YAY7gG
 dwIpDJPWzzLy9/FqKBVd2WJCixHjn29PK+qMefn9c2RPEelNWLjDnUbr6V82Uk4EZz
 qrgs/erbIjqLMy2nn0UbU5H+iinl6gD9v5/gV+NubsWXrISK/NKPs1RECHtA3ssve0
 p3E3u3E+7ZgHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] drm/vc4: Use drm_timeout_rel_to_jiffies()
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260817-drm-timeout-helpers-v2-6-73052b669f49@igalia.com>
References: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
 <20260817-drm-timeout-helpers-v2-6-73052b669f49@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:15:48 +0000
Message-Id: <20260817211548.6A3551F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Incomplete Fix / Unhandled 32-bit Overflow in `vc4_wait_for_seqno`
--

--- Patch [6]: [PATCH v2 6/6] drm/vc4: Use drm_timeout_rel_to_jiffies() ---
commit 4c26550a287cbb245dc4be4698ea36a63eca121d
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Use drm_timeout_rel_to_jiffies()

This patch updates vc4_wait_bo_ioctl() to use drm_timeout_rel_to_jiffies()
instead of usecs_to_jiffies(). This prevents long timeout values from
wrapping around into much shorter timeouts due to unsigned int narrowing.

> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index e231c906709c1..781aeb8967b15 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -970,7 +971,7 @@ vc4_wait_bo_ioctl(struct drm_device *dev, void *data,
>  	int ret;
>  	struct drm_vc4_wait_bo *args =3D data;
>  	unsigned long timeout_jiffies =3D
> -		usecs_to_jiffies(div_u64(args->timeout_ns, 1000));
> +		drm_timeout_rel_to_jiffies(args->timeout_ns);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
vc4_wait_for_seqno() also appears to need a similar fix.

Could this lead to immediate early expiration on 32-bit systems for large
timeout values?

It calculates timeout_expire using nsecs_to_jiffies() without clamping to
MAX_JIFFY_OFFSET:

drivers/gpu/drm/vc4/vc4_gem.c:vc4_wait_for_seqno() {
    ...
	if (timeout_ns =3D=3D 0)
		return -ETIME;

	timeout_expire =3D jiffies + nsecs_to_jiffies(timeout_ns);
    ...
}

If the resulting jiffies offset exceeds MAX_JIFFY_OFFSET, adding it to jiff=
ies
would result in a value that time_after_eq() evaluates as being in the past,
causing the wait loop to exit immediately with -ETIME.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-drm-timeou=
t-helpers-v2-0-73052b669f49@igalia.com?part=3D6
