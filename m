Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmO74CP3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0096D10E05E;
	Fri, 30 Oct 2026 17:38:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CA310E3AF;
 Fri, 30 Oct 2026 17:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 673BE43ED5;
 Fri, 30 Oct 2026 17:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF591F000C1;
 Fri, 30 Oct 2026 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793381927;
 bh=udmFjoOsxM4mdeL62v0g8SSAzeWF8y/AuyOsRoGgE5k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YmO74CP3RNtkEBugm+ioCvqKSFO/q8mKpuNCjAYLxgQsojxAkyt5Yv1hLKpvMP3sP
 sb0R9urt9aUhqgevlNMFFBhT2NhUhatUcfPejDUgyhDhCgiyrWiJBfWRIGGra3W2kN
 hefNQhATxm0nbIokzPN8Hf/1C71JK9+1cPr63LtL5sh/japE33+bTvsunWqeRxN4Vn
 5Ibl6L9DnV7/XToXmUJs3b90t9wFE+DY4wbpeWsUsAthLj3B+yCbUBzAfRXB+/9/fu
 2dAhKtrHD2XKxZHXr+4MGao+7E3NuXQekjBJ+7UKK6QrW9ljfobWmm7cWGTN8GVgeW
 ljDfAlA0Gx6WA==
Message-ID: <sashiko-outbox-191350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/xe/pcode: Fix pcode_try_request polling delays
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030173038.681250-2-alan.previn.teres.alexis@intel.com>
References: <20261030173038.681250-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:38:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/xe/pcode: duplicate left shift of wait in pcode_try_request()
- [High] drm/xe/pcode: uncapped wait added to slept in pcode_try_request()
--

commit b0181a87e207629275e050ae1f5d781e540c4b82
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/pcode: Fix pcode_try_request polling delays

This commit clamps the atomic udelay() argument in pcode_try_request() to
MAX_UDELAY_MS * 1000 and adds a 100 ms upper bound to the exponential
backoff wait interval.

> diff --git a/drivers/gpu/drm/xe/xe_pcode.c b/drivers/gpu/drm/xe/xe_pcode.c
> index 266deecbb100a..25d1a354ee369 100644
> --- a/drivers/gpu/drm/xe/xe_pcode.c
> +++ b/drivers/gpu/drm/xe/xe_pcode.c
> @@ -146,6 +146,7 @@ int xe_pcode_read(struct xe_tile *tile, u32 mbox, u32=
 *val0, u32 *val1)
>  	return err;
>  }
> =20
> +#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
>  static int pcode_try_request(struct xe_tile *tile, u32 mbox,
>  			     u32 request, u32 reply_mask, u32 reply,
>  			     int *status, bool atomic, int timeout_us, bool locked)
> @@ -165,10 +166,11 @@ static int pcode_try_request(struct xe_tile *tile, =
u32 mbox,
>  			return 0;
> =20
>  		if (atomic)
> -			udelay(wait);
> +			udelay(min_t(int, wait, (MAX_UDELAY_MS * 1000)));
>  		else
>  			usleep_range(wait, wait << 1);
>  		wait <<=3D 1;
> +		wait =3D min_t(int, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);

[Severity: High]
Should the existing wait <<=3D 1 statement above be removed? Leaving both
shifts in pcode_try_request() shifts wait left twice on every iteration,
quadrupling wait at each step (10 -> 40 -> 160 -> 640 -> 2560 us) instead
of doubling it.

Because the loop header accumulates elapsed time via slept +=3D wait after
the loop body finishes:

drivers/gpu/drm/xe/xe_pcode.c:pcode_try_request() {
	for (slept =3D 0; slept < timeout_us; slept +=3D wait) {

slept also advances by 4x the delay just performed, causing
xe_pcode_ready() and xe_pcode_request() to time out with -ETIMEDOUT before
timeout_us has actually elapsed.

[Severity: High]
When atomic is true, udelay() is clamped to MAX_UDELAY_MS * 1000 (for
example, 5000 us on x86 or 2000 us on arm64), but wait continues to grow
up to __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100000 us) and is added directly
to slept in the loop header:

drivers/gpu/drm/xe/xe_pcode.c:pcode_try_request() {
	for (slept =3D 0; slept < timeout_us; slept +=3D wait) {

When xe_pcode_request() retries with preemption disabled:

drivers/gpu/drm/xe/xe_pcode.c:xe_pcode_request() {
	preempt_disable();
	ret =3D pcode_try_request(tile, mbox, request, reply_mask, reply, &status,
				true, 50 * 1000, true);
	preempt_enable();

won't slept accumulate the unclamped wait value once wait exceeds
MAX_UDELAY_MS * 1000, causing the 50 ms atomic retry to return -ETIMEDOUT
after only a fraction of the intended 50 ms delay?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030173038.6812=
50-2-alan.previn.teres.alexis@intel.com?part=3D1
