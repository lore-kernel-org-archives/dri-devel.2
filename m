Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD6BC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D8810E173;
	Tue,  8 Sep 2026 19:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VO7jlDy+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC5410E173;
 Tue,  8 Sep 2026 19:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF651411AC;
 Tue,  8 Sep 2026 19:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CACF1F00A3A;
 Tue,  8 Sep 2026 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788894236;
 bh=dOVQt+//uDMAwnBHMdJZw5zWtzrfpSFQ5qnsg1LYOmw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VO7jlDy+i280nscd4vNKi0pd+sRnUtOtMvNKDOLTAmwJRqZAptMrJyba4l5ToE9RX
 0PA9w4ykxPfJDoUISHz4UzOxcYZ489PUk7bkmQdiFxkScfhJ9Bw9ATTXFA+YvD0NDK
 YZmSthmcnKCCJUJM3kCyhirOOolrNUPNSC5zcVckmD6LfqQk3cz6G/+kjoZVOp/RQY
 pse/G591WAoRcLwojdLnFTJgTYM9fYJGFW9ew6tTfatUUZ3cMSXSP/DK2IcDqHKNqb
 Z9jeOZ8N+MxT/zBy0dxZRkwCB7QgPWicMAvIuNySWcoaMC1MR63Xj0yd7QnpZ361sd
 MFZZwMZI5yVGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260908185609.359565-2-alan.previn.teres.alexis@intel.com>
References: <20260908185609.359565-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:03:56 +0000
Message-Id: <20260908190356.7CACF1F00A3A@smtp.kernel.org>
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
- [Medium] The custom helper `__div_round_up64` silently truncates 64-bit d=
ivisors to 32 bits, creating a mathematically unsound helper.
- [Low] Inverted architecture check for 64-bit division causes a `__divdi3`=
 link error on 32-bit builds, and needlessly uses a custom fallback on 64-b=
it builds.
--

commit 2d4751e6d3870228fa27b4fdbbb10070a48ae9ce
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

This commit fixes xe_mmio_wait32() to honor delay and sleep maximums by
checking for overflow in udelay and usleep_range. It also adds a custom
64-bit division helper and caps the in-loop wait time to prevent
intolerably large delays.

> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a28..1ae382f009de5 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
[ ... ]
> +static inline s64 __div_round_up64(s64 dividend, s64 divisor)
> +{
> +	u64 abs_dividend =3D abs(dividend);
> +	u64 abs_divisor =3D abs(divisor);
> +	u64 result =3D abs_dividend + abs_divisor - 1;
> +
> +	do_div(result, abs_divisor);

[Severity: Medium]
Does passing a 64-bit divisor to do_div() cause silent truncation here?

The do_div() macro is strictly designed for 32-bit divisors and will
silently truncate the 64-bit abs_divisor parameter. While the current caller
in __xe_mmio_wait32() only passes USEC_PER_MSEC (which fits in 32 bits),
creating a generic helper that accepts an s64 divisor is structurally
unsafe.

Could this use DIV64_U64_ROUND_UP() from linux/math64.h instead?

> +	/* dont check for negative values as local caller only uses positive nu=
mbers */
> +	return (s64)result;
> +}
[ ... ]
> @@ -349,11 +375,25 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, s=
truct xe_reg reg, u32 mask, u
[ ... ]
> -		if (atomic)
> -			udelay(wait);
> -		else
> -			usleep_range(wait, wait << 1);
> -		wait <<=3D 1;
> +#define __XE_MMIO_WAIT_MAX_INLOOP_100MS (100 * USEC_PER_MSEC)
> +		if (atomic) {
> +			if (wait <=3D MAX_UDELAY_MS * USEC_PER_MSEC)
> +				udelay(wait);
> +			else if (BITS_PER_LONG =3D=3D 32)
> +				mdelay(DIV_ROUND_UP(wait, USEC_PER_MSEC));

[Severity: Low]
Does this architecture check invert the intended 64-bit division logic?

When BITS_PER_LONG =3D=3D 32, this branch executes the native 64-bit divisi=
on
DIV_ROUND_UP(wait, USEC_PER_MSEC). This causes a __divdi3 unresolved symbol
link error on 32-bit builds, which appears to be the exact build break this
helper was intended to avoid.

> +			else
> +				mdelay(__div_round_up64(wait, USEC_PER_MSEC));

Consequently, 64-bit builds will take this else branch and needlessly use
the custom division helper instead of the native division macro.

> +		} else {
> +			usleep_range(wait, wait + (wait >> 2)); /* range till wait + 25% */
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908185609.3595=
65-2-alan.previn.teres.alexis@intel.com?part=3D1
