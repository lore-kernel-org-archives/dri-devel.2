Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59DB606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdKi9lsl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B48A10E46F;
	Thu,  5 Nov 2026 03:21:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4933610E90E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:21:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5C1A43CF4;
 Thu,  5 Nov 2026 03:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342B21F000C1;
 Thu,  5 Nov 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793848874;
 bh=ahle78czmMQmNJ8RshHP9Py04n+M5+FjBAsg5ZyW7Mo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cdKi9lslvbsbrLrUtAiMrIhGKK6ZWRB15QH8mj/eczCg7fhaOrZvjQWLWvmR63mHu
 O2o812G/+EzeH3SFgaNQNUU/BBVBwY2TmCAO7ScapT67TUCddB9EfxrkcDCItUHdvb
 8OU3+4zeNPyh/KkPqJN25jGaOvMwQqKJYSnABv/M24mFX5mZsCP7DkulT55XwN2DJK
 0eubiN//ImtOmIOUCkzdXo/Mko4j8F87c6CSqeSISrdAwEK4gocW3q9d1/6JKUfaKM
 ZPxsLG2eO4fveniI3hBSWUQgwgVbfGWTUpjr8ckYw4b55kC4eNu8ZFH99lb3/+g6R+
 82EH05Xltnaww==
Message-ID: <sashiko-outbox-198510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block.
 (v4)
To: "Dave Airlie" <airlied@redhat.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Alice
 Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 03:21:13 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpu: nova-core: u64::checked_sub() fails on negative offset in tim=
er_time()
--

commit 8e6e7110b2947fca24843940e52d712c197357df
Author: Dave Airlie <airlied@redhat.com>

gpu: nova-core: add support for GPU timer block. (v4)

This commit adds GPU timer block initialization support for nova-core across
Turing/Ampere/Ada (tu102 HAL) and Hopper/Blackwell (gh100/gb100 HALs) to
compute the system timer offset passed to GSP initialization.

> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 0000000000000..0486df5889647
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
> @@ -0,0 +1,79 @@

[ ... ]

> +    fn timer_time(&self, bar: Bar0<'_>, time_ns: u64) -> Result<u64> {
> +        let mut sec_hi2 =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_=
SEC_TIMER_TIME_1));
> +        let sec_timer_ns: u64;
> +        loop {
> +            let sec_lo =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_S=
EC_TIMER_TIME_0));
> +            let sec_hi =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_S=
EC_TIMER_TIME_1));
> +            if sec_hi =3D=3D sec_hi2 {
> +                sec_timer_ns =3D u64::from(sec_hi) << 32 | u64::from(sec=
_lo);
> +                break;
> +            }
> +            sec_hi2 =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_=
TIMER_TIME_1));
> +        }
> +
> +        // The system and the GPU timer are both free-running with unrel=
ated epochs, so the
> +        // difference can be negative. Both operands are < 2^62, hence t=
his cannot overflow.
> +        let sys_timer_offset_ns =3D time_ns.checked_sub(sec_timer_ns).ok=
_or(EINVAL)?;

[Severity: High]
In Gh100::timer_time(), both time_ns and sec_timer_ns are u64 values. When
the difference is negative (time_ns < sec_timer_ns), u64::checked_sub()
returns None, causing Gh100::timer_time() to return Err(EINVAL) and abort
Gpu::new() -> Timer::init() -> Gh100::init() during probe.

Since the comment notes that the difference can be negative and both operan=
ds
are less than 2^62, should this use wrapping_sub() (or signed subtraction)
instead of checked_sub()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-nova-timer=
-v4-0-45a7c121d4de@redhat.com?part=3D2
