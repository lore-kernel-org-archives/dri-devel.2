Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B43C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7F810EA31;
	Tue, 25 Aug 2026 12:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OSqOS3M3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C5F10EA2B;
 Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85B1E4132B;
 Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE741F00A3E;
 Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787661185;
 bh=H882hufEUda6hIjGaEaY6wiOhJya9sHR9+qDrXgm9/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OSqOS3M39B1qooUvmlFIiyzByHO9Ko1qgCTEiQfvh3vdnEJ7LJV3UcY/kYfz7/6nH
 z3gnAhHysQvA1QMVfY55kWONbT5Y8w7sKfFbwqOCdN7wyxtrxKLl4wXRNRU6IpJjy0
 MuMWGeRsQl3dG2LcVnRcBpAX6WDAUuPofw8q7Igvk0yRYxWOPOKt3in55gSPZSczT9
 1sj1khaxzj1Nk1CyQi3ZptK3DDBj2fI5xOzQsP3w7VLsHbw6OcPCBAv+yx6r8x7uNz
 1u3ne28R7uID1NMvA+aMrWqhT2QNCqic8+Gzr08WyfuRW/w5D5OKQuaIplPa2PKKJy
 IKy8AmLZBP04w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] rust: hrtimer: use the expiry injecting callback
 variant
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260825-expires-v2-v1-3-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-3-90411c6217c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:33:04 +0000
Message-Id: <20260825123305.2DE741F00A3E@smtp.kernel.org>
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
- [High] Safe Rust code can trigger a kernel WARN_ON_ONCE (and panic) by re=
turning a zero interval in `HrTimerRestart::Forward`.
- [Low] Missing `#[inline]` attribute on small abstraction functions.
--

--- Patch [3]: [PATCH 3/6] rust: hrtimer: use the expiry injecting callback=
 variant ---
commit 237e017d8140a6e80f2fd3f4c1d9d1b8d7532ab6
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: hrtimer: use the expiry injecting callback variant
   =20
A timer callback could modify the expiry of its timer with
HrTimerCallbackContext::forward(). This switches the abstraction to the exp=
iry
injecting callback variant provided by hrtimer_setup_ext(). The callback
receives the expiry by value, snapshotted under the timer base lock, and
requests a restart by returning HrTimerRestart::Forward { now, interval }.

Link: https://lore.kernel.org/r/87h5kp88uy.fsf@kernel.org

> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 2d7f1131a8131..e6570a6162035 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs

[ ... ]

> @@ -847,19 +847,62 @@ unsafe fn start(this: *const Self, expires: <Self::=
TimerMode as HrTimerMode>::Ex

[ ... ]

> +impl<T: HasHrTimer<T>> HrTimerRestart<T> {
> +    /// Request that the timer be forwarded past the current time by `in=
terval`
> +    /// and restarted.
> +    pub fn forward_now(interval: Delta) -> Self {

[Severity: Low]
This isn't a bug, but should this function be annotated with #[inline]?

The Rust subsystem coding guidelines mandate that small abstraction functio=
ns
should have this annotation.

> +        Self::Forward {
> +            now: HrTimerInstant::<T>::now(),
> +            interval,
> +        }
> +    }
> +
> +    /// Convert to the C representation, filling `fwd` with the forward
> +    /// request.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `fwd` must be valid for writing a `bindings::hrtimer_forward_arg=
s`.
> +    pub(crate) unsafe fn into_c(

[Severity: Low]
This isn't a bug, but should this small conversion function also be annotat=
ed
with #[inline]?

> +        self,
> +        fwd: *mut bindings::hrtimer_forward_args,
> +    ) -> bindings::hrtimer_restart {
> +        match self {
> +            Self::NoRestart =3D> bindings::hrtimer_restart_HRTIMER_NORES=
TART,
> +            Self::Forward { now, interval } =3D> {
> +                // SAFETY: By our safety contract, `fwd` is valid for wr=
iting.
> +                unsafe {
> +                    *fwd =3D bindings::hrtimer_forward_args {
> +                        now: now.as_nanos(),
> +                        interval: interval.as_nanos(),
> +                    }
> +                };

[Severity: High]
Does this code allow safe Rust to trigger a kernel panic?

If a safe Rust module constructs HrTimerRestart::Forward with a zero interv=
al
(e.g., via HrTimerRestart::forward_now(Delta::ZERO)) and returns it from the
timer callback, the zero interval is blindly copied into fwd.interval here.

The C side execution in __run_hrtimer() will then trigger a WARN_ON_ONCE:

kernel/time/hrtimer.c:__run_hrtimer() {
    /* An expiry injecting callback requesting a restart must forward. */
    if (fn_ext && restart =3D=3D HRTIMER_RESTART && WARN_ON_ONCE(!fwd.inter=
val))
        restart =3D HRTIMER_NORESTART;
    ...
}

If the kernel is configured with panic_on_warn, this could lead to a kernel
panic.

Should there be a check to validate that the interval is non-zero before
passing it to C, or should it be enforced when creating
HrTimerRestart::Forward?

> +                bindings::hrtimer_restart_HRTIMER_RESTART
> +            }
> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-expires-v2=
-v1-0-90411c6217c7@kernel.org?part=3D3
