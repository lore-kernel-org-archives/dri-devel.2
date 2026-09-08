Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4C2C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBBC10E07E;
	Tue,  8 Sep 2026 00:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="miAXr1Tm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA5310E07E;
 Tue,  8 Sep 2026 00:02:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FC35601FB;
 Tue,  8 Sep 2026 00:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E2A1F00A3D;
 Tue,  8 Sep 2026 00:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788825754;
 bh=Vd5Rj0Guyx6jB3lS5urqg9aZwunfu8CHjaAzhvMfDZw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=miAXr1TmL7A62mYDxmRRucTa/vr/iFsJb2VnChcn+Cle7lr0QKpdje3RcUYMHdxaV
 MhHCyTQA6e+xa2FBTcpLk1PEywNTcQpSnGsz41ns35FFIHH4MmathOqbRhMmYeH0BZ
 /vxRMF+P92Xw/ZFdF/JwWbWuJTKz6g5MSExEHMFgGztiK9i7xXDkt0+4UZmZSqO/Hu
 VC9RspbFl6L/KzdQ37w8dfj/uR35n6amLuZY7+85teBc9mzBtbkuG6du1ZSlAfu33Z
 lGUNYKtHvHMavwgGDYtbIqm2YO2Ru1Jy682cRgXtzbLyfzAw5KgUNnb+ONTob2v8OM
 aiuBm0uUp7yhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260907235524.7807-2-alan.previn.teres.alexis@intel.com>
References: <20260907235524.7807-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 00:02:34 +0000
Message-Id: <20260908000234.A4E2A1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect maximum delay in usleep_range() introduces massive timer=
 slack, defeating exponential backoff and causing extreme latency and spuri=
ous timeouts.
- [Medium] The commit message claims to simplify a `sleep_min` assignment, =
but no such change exists in the code.
- [Low] 64-bit division on 32-bit architectures causes link errors.
--

commit 76cc600b7d97fbc1edcd9a133df8168f9ad41977
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

This patch adds overflow checks for delays in __xe_mmio_wait32() and
introduces caps to the maximum in-loop wait time. It also aims to pick
the correct sleep or delay helper based on the requested wait duration.

> drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums
>=20
> Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
> and pick the correct helper accordingly. Fix sign-overflow and avoid
> growing delays becoming intollerably large by capping the in-loop
> wait time. Simplify sleep_min assignment by removing redundant cast.

[Severity: Medium]
The commit message claims to simplify the sleep_min assignment by removing
a redundant cast, but the variable sleep_min does not exist in the modified
code. Could the commit message be updated to reflect the actual changes?

> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a28..cf2e05aaa4b2f 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c

[ ... ]

> @@ -349,11 +349,23 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, s=
truct xe_reg reg, u32 mask, u
>  		if (ktime_after(ktime_add_us(cur, wait), end))
>  			wait =3D ktime_us_delta(end, cur);
> =20
> -		if (atomic)
> -			udelay(wait);
> -		else
> -			usleep_range(wait, wait << 1);
> -		wait <<=3D 1;
> +#define __XE_MMIO_WAIT_MAX_INLOOP_TIME (100 * USEC_PER_MSEC)
> +		if (atomic) {
> +			if (wait <=3D MAX_UDELAY_MS * USEC_PER_MSEC)
> +				udelay(wait);
> +			else
> +				mdelay(DIV_ROUND_UP(wait, USEC_PER_MSEC));

[Severity: Low]
Wait is defined as an s64 type. Does using DIV_ROUND_UP(wait, USEC_PER_MSEC)
here cause a 64-bit division? On 32-bit architectures, this could lead to an
undefined reference to __divdi3 and break the build.

> +		} else {
> +			usleep_range(wait, __XE_MMIO_WAIT_MAX_INLOOP_TIME);

[Severity: High]
Does hardcoding __XE_MMIO_WAIT_MAX_INLOOP_TIME (100ms) as the maximum bound
for usleep_range() introduce massive timer slack? For example, on the first
iteration where wait is 10us, this allows the scheduler to delay the wakeup
for up to 100ms, completely defeating the intended exponential backoff.
This could cause massive latency spikes for fast MMIO operations in non-ato=
mic
calls to __xe_mmio_wait32().

> +		}
> +		/*
> +		 * As we keep doubling the wait time for every check that fails, cap t=
he
> +		 * in-loop delay-or-sleep to less than 2x 100 miliseconds to prevent f=
rom
> +		 * expanding 'wait' into exponentially longer wait times per loop that
> +		 * end up delaying the next completion check way later than tolerable.
> +		 */
> +		wait =3D wait < __XE_MMIO_WAIT_MAX_INLOOP_TIME >> 1 ?
> +		       wait << 1 : __XE_MMIO_WAIT_MAX_INLOOP_TIME;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907235524.7807=
-2-alan.previn.teres.alexis@intel.com?part=3D1
