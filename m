Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A634ECA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CE610EF8B;
	Tue, 29 Sep 2026 16:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UgOOF+lF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C6110E19B;
 Tue, 29 Sep 2026 16:18:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34F286022B;
 Tue, 29 Sep 2026 16:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DB61F000FF;
 Tue, 29 Sep 2026 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790698722;
 bh=C6yYJSyNP3cicnnh+7sXpC4MTWaIKNoFvsKNDlZ44Jc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UgOOF+lFF7hOsVmbSiVkWy7BDeeBTE+k9H2SlFJ6IxDX2nSoSDoYXo8OC04E1m0aR
 yqfym2DM+LmpmNJBZ3IxC1UkXlRColXfw2P+ndmox0Mhr91LR5xhZCnXPSXKbhL1nW
 QN1YIPTCw1gUTH/dsMns9MREI7vJMKgWrW7uaNc2I0i/xlXVMXZQH+2mkzxEK1lEs/
 UaB+q+VE/fu/hTbH0aiO0T7LZ6dhyV4T/XK5oTK0W0RMAlFC60Z31xFOJQQZ8U4qdB
 N8zE9K4vDX8UrLwHyQ46smfL3G+TsmZ2XBqxhh45UrsCF9DB+mtdOaG4Hqany3VuSH
 wiXox98lniq0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260929161125.1973918-2-alan.previn.teres.alexis@intel.com>
References: <20260929161125.1973918-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 16:18:42 +0000
Message-Id: <20260929161842.A9DB61F000FF@smtp.kernel.org>
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
- [Low] drm/xe: commit message describes dropped design changes
- [Low] drm/xe: preprocessor macro defined inside function body
--

commit 7206a8140e2444dbf990387d48807b42ec0fbee5
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums
   =20
This patch bounds the maximum in-loop wait time in __xe_mmio_wait32 to
100ms to avoid excessively large delays. It also caps udelay usage to
MAX_UDELAY_MS for atomic contexts.

>     Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
>     and pick the correct helper according to the wait time and atomic.
>     Implement a similar helper to replace DIV_ROUND_UP for 32-bit CPUs.

[Severity: Low]
Does the commit message need an update here? The text claims to pick the
correct helper according to the wait time and implement a similar helper
to replace DIV_ROUND_UP, but the actual diff only modifies the sleeping
logic and caps the wait times.

It seems the DIV_ROUND_UP redesign was dropped but the description was not
fully updated to reflect this.

> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a28..5a03698729ce5 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
> @@ -350,10 +350,11 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, s=
truct xe_reg reg, u32 mask, u
>  			wait =3D ktime_us_delta(end, cur);
> =20
>  		if (atomic)
> -			udelay(wait);
> +			udelay(min_t(s64, wait, (MAX_UDELAY_MS * 1000)));
>  		else
>  			usleep_range(wait, wait << 1);

[Severity: Medium]
This isn't a bug introduced by this patch, but __xe_mmio_wait32 is called
with wait values that can reach 100,000 microseconds (100ms) due to the
backoff limit. According to the kernel timer guidelines, usleep_range
should only be used for delays under 20ms, while msleep is recommended
for larger delays to avoid using high-overhead hrtimers. Could we switch
to msleep for the longer iterations?

> -		wait <<=3D 1;
> +#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)

[Severity: Low]
Is it intended to define this preprocessor macro inside the function body?
Macros do not have block scope in C, so placing it here can be stylistically
misleading and will likely trigger checkpatch warnings. Could this be moved
outside the function body?

> +		wait =3D min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
>  	}
> =20
>  	if (ret !=3D 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929161125.1973=
918-2-alan.previn.teres.alexis@intel.com?part=3D1
