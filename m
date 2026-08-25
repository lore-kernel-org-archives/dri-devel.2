Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56671C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8BB10EA2C;
	Tue, 25 Aug 2026 12:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c6OwFiUy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D80510EA2A;
 Tue, 25 Aug 2026 12:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6DA4601E9;
 Tue, 25 Aug 2026 12:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435571F000E9;
 Tue, 25 Aug 2026 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787661009;
 bh=Ws4R+1haOE0UdYuSK2jWzuSxPnpsAiaQbbHW8KRpibc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c6OwFiUywUUg7AC05ERB6tBkDNg5WHCnnpgHOlprB2te+NWj20uU/NmCWNhNiVdyT
 ctJMxXY5cu2n5m0AQlhTpJb/tm/RPfeksvCMwePEnNwtgsXOxwI3q26AnWZ1Ew95W2
 atR+062UQJW4QsRblegvVxbmWlh4pyAuA88Jmj62uuuGwXGSlJeLM5zY42OrFqzJYX
 J2s+1MILWlCXMiP9UsIjK40hoA9jKOsTrR1xkHLDa+u90nMttkjDUeQyy6lYcW7FY4
 OJtg98lsCeQft/CpDT3datuYdGOt1i3D+hjFu9ZarpyRSSj9u6rw5f0OL9BogS5HCi
 1XAuOQHiydpbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] rust: hrtimer: Make HrTimer repr(transparent)
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260825-expires-v2-v1-6-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-6-90411c6217c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:30:08 +0000
Message-Id: <20260825123009.435571F000E9@smtp.kernel.org>
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
- [Medium] The patch adds an inline comment and commit message justifying a=
 layout change based on `HrTimerCallbackContext`, a type that was completel=
y removed earlier in the patch series, resulting in a stale and confusing s=
oundness rationale.

Pre-existing issues:
- [High] The callback implementations for `Pin<&mut T>` and `Pin<Box<T>>` c=
reate a mutable reference (`&mut T`) while `cancel()` can concurrently acce=
ss `T.timer` via a raw pointer, causing Undefined Behavior due to aliasing =
violations.
--

--- Patch [6]: [PATCH 6/6] rust: hrtimer: Make HrTimer repr(transparent) ---
commit ed14b61ad275b0efb05d77ed06f7d0d89b06560d
Author: FUJITA Tomonori <fujita.tomonori@gmail.com>

rust: hrtimer: Make HrTimer repr(transparent)

This commit changes the representation of HrTimer from repr(C) to
repr(transparent). This prevents adding multiple fields to the struct
and helps enforce soundness regarding shared and mutable references.

Link: https://msgid.link/20260813134834.1562995-5-tomo@flapping.org

> HrTimerCallbackContext acquires a &HrTimer<T> from a
> NonNull<HrTimer<T>> while a &mut HrTimer<T> can exist at the same
> time. This is sound only because HrTimer's sole field is

[Severity: Medium]
Is this justification accurate? The HrTimerCallbackContext type appears
to have been removed earlier in this patch series. Should the commit
message be updated to reflect the current design?

> Opaque<bindings::hrtimer>, which puts every byte behind an UnsafeCell.

[Severity: High]
This is a pre-existing issue, but does relying on Opaque and UnsafeCell
to justify aliasing with a mutable reference risk undefined behavior?

The commit message notes that a mutable reference to HrTimer can exist
at the same time as other accesses. While UnsafeCell relaxes aliasing
for shared references, creating an exclusive mutable reference asserts
exclusive access to the entire memory footprint.

When RawHrTimerCallback::run executes for pinned mutable references or
boxed timers, it creates an exclusive mutable reference. Concurrently, a
user thread might call cancel, which reads the timer memory via a raw
pointer. This concurrent read would invalidate the uniqueness tag of the
active mutable reference, which could cause the compiler to misoptimize.

> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 2a9abc9f5d8c8..ab7c568b88553 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -427,8 +427,12 @@
>  /// # Invariants
>  ///
>  /// * `self.timer` is initialized by `bindings::hrtimer_setup_ext`.
> +// `repr(transparent)` is not merely about layout. `HrTimerCallbackConte=
xt` acquires a
> +// `&HrTimer<T>` while a `&mut HrTimer<T>` may exist, which is sound onl=
y because every byte of
> +// this type sits inside `Opaque`. Being transparent rejects a second fi=
eld at compile time,
> +// but it does not enforce that the remaining field stays `Opaque`.

[Severity: Medium]
Is this comment still accurate? As mentioned regarding the commit message,
the HrTimerCallbackContext type seems to no longer exist in the tree.
Should this inline documentation be updated to use a current example?

>  #[pin_data]
> -#[repr(C)]
> +#[repr(transparent)]
>  pub struct HrTimer<T> {

[ ... ]

> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtim=
er/pin_mut.rs
> index 04f9d8cbddcd2..2bba3c41d6e9a 100644
> --- a/rust/kernel/time/hrtimer/pin_mut.rs
> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
> @@ -91,7 +91,7 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
>          expires: bindings::ktime_t,
>          fwd: *mut bindings::hrtimer_forward_args,
>      ) -> bindings::hrtimer_restart {
> -        // `HrTimer` is `repr(C)`
> +        // `HrTimer` is `repr(transparent)`
>          let timer_ptr =3D ptr.cast::<HrTimer<T>>();

[Severity: High]
This isn't a bug introduced by this patch, but does the rest of this callba=
ck
function violate aliasing rules?

A bit further down in RawHrTimerCallback::run for pinned mutable references
and boxed timers, the code creates an exclusive mutable reference from the
pointer. If a user thread concurrently calls cancel while the timer is
running, that cancellation reads the timer base via a parent raw pointer.

Because creating the mutable reference asserts exclusive access to the whole
memory footprint, the concurrent read from cancel would invalidate that
reference and could lead to undefined behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-expires-v2=
-v1-0-90411c6217c7@kernel.org?part=3D6
