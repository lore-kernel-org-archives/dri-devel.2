Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD57CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A45410E278;
	Sat, 20 Jun 2026 19:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VGP9rGdO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79A810E278
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81CD2438BF;
 Sat, 20 Jun 2026 19:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6231F000E9;
 Sat, 20 Jun 2026 19:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982231;
 bh=k7dBDpJiMnE/AHinCThs+v6qbUScqsMSL5i+SnWe5gs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VGP9rGdOoGbKbLWIUXUSVwC6K/adbPxauH3RPNVOWEYm2YL7GgZmztWuRHI/4KOpW
 xQfp+oX6CgoIj86ne1C+nWaNIa99ufQ/PoB1WoBh0jzRCE9bdgQfvcqoR6vTSCxa4M
 rf7YqG5HPLa8T7BaSJy+6SXa8SrfqF69nRuNjJJTFaPR1mcnsrmEyg/uZbdfbYohZC
 T9rf2v7et/3PQfuMK8RVvIv79DohXzTWFudEyJEHfUpShidzPH9VnTABo2sQDOzEAF
 CNKfC/tYckCL22pusgQAcRDu6LqWd8qPAvLbsDJ491S4SdkZVyeilzFRXnEpfQyj1X
 5tsB5+Y48pKyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/16] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org
In-Reply-To: <20260620184924.2247517-11-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-11-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:03:50 +0000
Message-Id: <20260620190351.3F6231F000E9@smtp.kernel.org>
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
- [High] RegistrationGuard fails to protect driver unbind/teardown from con=
current IOCTLs because drm_dev_unplug() runs too late.
--

commit b8b80ca9bb704803d61dd7a9db3bfa5325217fcc
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical sections

This commit introduces RegistrationGuard, which uses drm_dev_enter() and
drm_dev_exit() to represent an SRCU critical section ensuring the parent bus
device remains bound. It updates Registration::drop() to use
drm_dev_unplug() instead of drm_dev_unregister() to provide the necessary
SRCU barrier.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index d429b4655449f..c32cc0f0eba03 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs

[ ... ]

> +/// A guard proving the DRM device is registered and the parent bus devi=
ce is bound.
> +///
> +/// The guard dereferences to [`Device<T, Registered>`], providing acces=
s to the DRM device with
> +/// the guarantee that the parent bus device is bound for the entire dur=
ation of the critical
> +/// section.
> +///
> +/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` =
SRCU critical section.
> +///
> +/// # Invariants
> +///
> +/// - `idx` is the SRCU read lock index returned by a successful `drm_de=
v_enter()` call.
> +/// - The parent bus device of `dev` is bound for the lifetime of this g=
uard.
> +#[must_use]
> +pub struct RegistrationGuard<'a, T: drm::Driver> {

[Severity: High]
Does this invariant hold true during the entire driver unbind lifecycle?

Since drm_dev_unplug() is what prevents new drm_dev_enter() critical
sections, the safety of this guard relies on exactly when drm_dev_unplug()
is called.

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 5152a18a8312b..3cda8dceb498d 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs

[ ... ]

>  impl<T: Driver> Drop for Registration<T> {
>      fn drop(&mut self) {
> +        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensu=
re that existing
> +        // `drm_dev_enter()` critical sections complete before unregistr=
ation proceeds. This
> +        // is required for the safety of `RegistrationGuard`, which reli=
es on the SRCU barrier in
> +        // `drm_dev_unplug()` to guarantee that the parent device is sti=
ll bound within the
> +        // critical section.
> +        //
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The =
existence of this
> -        // `Registration` also guarantees the this `drm::Device` is actu=
ally registered.
> -        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +        // `Registration` also guarantees that this `drm::Device` is act=
ually registered.
> +        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
>      }
>  }

[Severity: High]
Does placing drm_dev_unplug() in the Drop implementation of Registration
leave a window where concurrent IOCTLs can access hardware during driver
unbind?

In the driver model, Registration is stored in the driver's private data,
which is dropped during devres teardown or via post_unbind_callback. This
happens strictly after the driver core invokes the driver's unbind() or
remove() callback.

Since the unbind() callback is the documented place for drivers to perform
graceful teardown and hardware I/O, does this mean drm_dev_enter() will
still return true during and immediately after unbind()?

If so, concurrent IOCTLs could successfully acquire RegistrationGuard and
attempt to access the hardware while it is actively being torn down, which
seems to violate the safety invariant and risk a hardware hang or
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D10
