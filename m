Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A164DC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014BF10E634;
	Sun, 28 Jun 2026 15:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O769KZl7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E7D10E634
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:06:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05854413BF;
 Sun, 28 Jun 2026 15:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7AA1F000E9;
 Sun, 28 Jun 2026 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659164;
 bh=qo/aONWqLvUYlEo7RGI87OV/hRwIyXf1kGgpP/MmlJ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O769KZl79t4yZPg9nwt3pbk67wEzBJikojj3XWRnGEsEmvv7pxkw3lem85PWmghwR
 L2IbMHnjvaJw2orlKOdWw1Xp9IlX6EUA3sRZbovplChJ88Zbo9YSrqDHStoMgXLbZA
 FszJcwVy/ZOFZrdYZJXqyUgiqXltkqA0PZQkcHdKXHWyUOM+/zm3INk/P+86TSL3C4
 EbXyaG5dM9fQSS94ttzPmDgutQfIhVwuEiIfoq4lbj7f+cfHNiieSheTi+qD8YWZdz
 /+wv4iy6+0ZNlZPrgkjwu64mjNUZYAW8nMa6+4qeKme4fqUY2NxEaHqEUmr4nkfdnu
 jgUirupvICzcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/19] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260628145406.2107056-13-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-13-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:06:04 +0000
Message-Id: <20260628150604.9B7AA1F000E9@smtp.kernel.org>
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
- [High] Using `drm_dev_unplug()` instead of `drm_dev_unregister()` breaks =
normal hardware shutdown for display drivers on module unload.
--

commit f4a9e1c28c30b5e7af0c36efbe74ccb2e5047e20
Author: Danilo Krummrich <dakr@kernel.org>
rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical sections

This commit adds a RegistrationGuard to represent a drm_dev_enter/exit SRCU
protection area. It also changes Registration::drop to use drm_dev_unplug()
instead of drm_dev_unregister() to provide an SRCU barrier.

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 5152a18a8312b..3cda8dceb498d 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
[ ... ]
> @@ -199,8 +199,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
> =20
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

[Severity: High]
Will replacing drm_dev_unregister() with drm_dev_unplug() here break normal
hardware shutdown for display drivers on module unload?

When drm_dev_unplug() is called, it sets dev->unplugged =3D true, which cau=
ses
any subsequent calls to drm_dev_enter() to return false.=20

The standard pattern for DRM driver removal is to unregister the device, wh=
ich
now calls drm_dev_unplug() through this Drop implementation. The driver then
typically calls drm_atomic_helper_shutdown() to gracefully disable the
hardware.

Since dev->unplugged is now true, the KMS disable code paths (which rely on
drm_dev_enter() to prevent accessing hot-unplugged hardware) will immediate=
ly
abort.

Does this cause the shutdown sequence to silently fail and leave the display
hardware enabled, potentially continuing to scan out from freed memory or
trigger IOMMU faults?

>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D12
