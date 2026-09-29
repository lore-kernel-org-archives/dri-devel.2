Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ECBCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B4C10ECE8;
	Tue, 29 Sep 2026 05:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PaJ7tFi2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7F710ECE7;
 Tue, 29 Sep 2026 05:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 179EA4140A;
 Tue, 29 Sep 2026 05:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B803C1F00893;
 Tue, 29 Sep 2026 05:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790661000;
 bh=bHzWgpQPYDk6Urubyeg4ovjwuLE/LRJd0sXkAdG0+Vo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PaJ7tFi2/LbCqGrdE4qs6N1XMJ6mxbI7uOijTHSjhRWmBbmTPu4mw4o64Wh//pv4P
 6lSg2xrudw2yZYGid51iHkn9UuB13LzykOIiFfaYZjfre08KHtGmIAZHVkUuqB+wre
 5idggtyLo7MXqlbvg33+85544Cq6Z/voCUjyzP05SDAvicTUsQYF07AvqTudk1A/BK
 px3o04wXSrdpL+euGf5+Z1XrAZBEH4wkT7x0LINyyxwMWXYubo7AvwDhBpWnI04ovQ
 yoMkwmsgNn/pc5Rn3t/aNoze+p0mhz8EOk/PzAclgVoxqITqcpGuWSDvHNUoGJxYM1
 WYuntYodHqHnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260929054444.1933871-2-alan.previn.teres.alexis@intel.com>
References: <20260929054444.1933871-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:49:59 +0000
Message-Id: <20260929054959.B803C1F00893@smtp.kernel.org>
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
- [Medium] drm/xe: udelay capped at 5us due to MAX_UDELAY_MS unit mismatch
- [Medium] drm/xe: commit message claims DIV_ROUND_UP helper but code is mi=
ssing
--

commit cceb24ccd008b44c48532606a8d174234bb68933
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

This commit modifies __xe_mmio_wait32() to cap delay values to avoid
intolerably large waits. It picks the appropriate sleep or delay helpers
based on atomic context and wait duration.

>     Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
>     and pick the correct helper according to the wait time and atomic.
>     Implement a similar helper to replace DIV_ROUND_UP for 32-bit CPUs.

[Severity: Medium]
The commit message explicitly states "Implement a similar helper to replace
DIV_ROUND_UP for 32-bit CPUs", but the patch does not contain any such
implementation in __xe_mmio_wait32() or elsewhere.

Was this code intended to be included, or is the commit message outdated fr=
om
previous iterations of this patch?

> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a28..c7c37e59dab05 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
> @@ -350,10 +350,11 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, s=
truct xe_reg reg, u32 mask, u
>  			wait =3D ktime_us_delta(end, cur);
> =20
>  		if (atomic)
> -			udelay(wait);
> +			udelay(min_t(s64, wait, MAX_UDELAY_MS));

[Severity: Medium]
Is there a unit mismatch here in __xe_mmio_wait32() between wait and
MAX_UDELAY_MS?

The wait variable is calculated in microseconds, but MAX_UDELAY_MS is a
constant representing milliseconds. By using min_t() with MAX_UDELAY_MS
directly, the udelay() argument appears to be incorrectly capped at a few
microseconds instead of the intended millisecond equivalent (e.g.,
MAX_UDELAY_MS * 1000).

If the wait grows beyond a few microseconds, could this unit mismatch
completely defeat the exponential backoff for atomic MMIO waits, causing the
CPU to poll the MMIO bus indefinitely at small intervals instead of backing
off?

>  		else
>  			usleep_range(wait, wait << 1);
> -		wait <<=3D 1;
> +#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
> +		wait =3D min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929054444.1933=
871-2-alan.previn.teres.alexis@intel.com?part=3D1
