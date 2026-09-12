Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF855C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF37D10E444;
	Sat, 12 Sep 2026 07:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dJxVzv5Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5628710E444
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:28:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63566600D4;
 Sat, 12 Sep 2026 07:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8CF1F00898;
 Sat, 12 Sep 2026 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789198105;
 bh=MK/8zOg/Zm86eJ60iTVpAmEKztPSKszuOKRCamG9wZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dJxVzv5Zrc4tl3t+r8W0v6cAFBP1vkFNG9amkkSJ+WaiY+wRESRu1spsikW1NjThL
 wEbGKHNaxjRhBABxvLejFUsLKgAdQ/AhA1KjTRQvQuZXFHRvnYK0dIqJ7SLKZNq2vW
 Tf+9nH1Q33spvBGt2MsT+RkU5Yr1pMEpO0zHRy0wy1/Ixtz4tNfJZiuYGAYv/MlJVG
 ElGyLenawbrMltsNv8rszlLVV04C67MN/nr59fM3jnZ+BOGqbpM9TksAfsqK4cIQiY
 zOyJ2yflb1f3VrMMR87nj+umsY6bOchzZlsPoGi9nxn8wrnwIRv7zmVJYMui56s9Xh
 F2MsFpCjv+FUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] gpu: nova-core: build the debugfs guard before
 registering the driver
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260912071842.622696-2-vladazaharova2018@gmail.com>
References: <20260912071842.622696-1-vladazaharova2018@gmail.com>
 <20260912071842.622696-2-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:28:24 +0000
Message-Id: <20260912072824.CA8CF1F00898@smtp.kernel.org>
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

Pre-existing issues:
- [High] The `NovaCore` struct fields are dropped in the wrong order, causi=
ng the auxiliary device to be unregistered after the GPU and BAR are destro=
yed.
--

commit 10c5ae1aadef16818d89098db4af7d31890aea8c
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: build the debugfs guard before registering the driver

This commit reorders the initialization in try_pin_init! so that the debugfs
guard is built before the driver registration. This ensures that if
initialization fails, the debugfs directory is properly cleaned up instead =
of
persisting across module reloads. The drop order for the module remains
unchanged.

> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> index 1133c6ce5c554..11fe1d2858a9c 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -47,7 +47,8 @@ fn drop(&mut self) {
>  #[pin_data]
>  struct NovaCoreModule {
>      // Fields are dropped in declaration order, so `_driver` is dropped =
first,
> -    // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
> +    // then `_debugfs_guard` clears `DEBUGFS_ROOT`. They are initialized=
 the
> +    // other way round, see `init()`.
>      #[pin]
>      _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
>      _debugfs_guard: DebugfsRootGuard,

[Severity: High]
This isn't a bug introduced by this patch, but since this change discusses
drop orders, does the struct declaration order of NovaCore in
drivers/gpu/nova-core/driver.rs cause the auxiliary device to be unregister=
ed
after the GPU and BAR are destroyed?

drivers/gpu/nova-core/driver.rs:
#[pin_data]
pub(crate) struct NovaCore<'bound> {
    #[pin]
    pub(crate) gpu: Gpu<'bound>,
    bar: pci::Bar<'bound, BAR0_SIZE>,
    #[allow(clippy::type_complexity)]
    _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
}

In Rust, struct fields are dropped in declaration order (first to last). In
NovaCore, gpu and bar are declared before _reg. Therefore, the GPU is dropp=
ed
and the MMIO region is unmapped before the auxiliary device registration
(_reg) is dropped.

When _reg is subsequently dropped, it synchronously unregisters the child
device and invokes the child driver's (e.g., nova-drm) remove callback. If
the child driver attempts to access the GPU or MMIO BAR during its teardown
(e.g., to disable the display or flush buffers), will it access destroyed
resources or unmapped memory, leading to a UAF and kernel oops?

This deterministic crash would trigger whenever the NovaCore device is
unbound or the module is unloaded.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912071842.6226=
96-1-vladazaharova2018@gmail.com?part=3D1
