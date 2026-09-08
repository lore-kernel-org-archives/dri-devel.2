Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9885C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEABE10E15F;
	Tue,  8 Sep 2026 18:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eF+t98oI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ED610E15F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 18:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A9DB43598;
 Tue,  8 Sep 2026 18:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0830E1F00A3A;
 Tue,  8 Sep 2026 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788890755;
 bh=ysKHgdCuuxhDtCixCvpnOhl+V9jnIBHvVWNnrErzFfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eF+t98oIqoCTOGEFhtFVs9min63YXTr6sUCkWwEU2eruuEr8e/sk7gGieQVhTxFcU
 YGSU0330WOJ1kUPd9wdFxc0A6cuONxblwZB3nmzJyFRdm1R/NPelWGdzvWsXzXPVVw
 ErbyXlLFs4rdHKgTPaOvklMyev016AZ/k27JJP3zyuxy244jI3mTXjkhFxUT3BcZz5
 3lPrzqLesbVVCew2IgqXbto5MOpc+PnOf8q35ZkKo4oI9Htoqdl7pkOhMWL8duQcsB
 NGBYvfWgaVj4d9904Ga6Am8O68xKbFMOha3T6yJgn6kS8YIpg27+L/XCb9Vr7y/CCX
 rjNeL3hoIDunQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
To: "Klara Modin" <klarasmodin@gmail.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260908175427.47207-1-klarasmodin@gmail.com>
References: <20260908175427.47207-1-klarasmodin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:05:54 +0000
Message-Id: <20260908180555.0830E1F00A3A@smtp.kernel.org>
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
- [Medium] Incomplete fix: missing `handle_free` field in conditionally com=
piled `shmem.rs`.
--

commit b5b83bb373847c99ca6d286c268d2e0ffab299f0
Author: Klara Modin <klarasmodin@gmail.com>

rust/drm/gem: initialize callbacks with ..pin_init::zeroed()

This commit updates the drm_gem_object_funcs struct initialization in the D=
RM
GEM module to use pin_init::zeroed() instead of explicitly assigning None to
unused callbacks. This fixes a build failure caused by a newly added callba=
ck
field in the C structure.

Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@le=
emhuis.info

> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index e1ebad77ebe2a..c63b0fe5a15e1 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, =
Ctx> {
>          free: Some(Self::free_callback),
>          open: Some(open_callback::<T>),
>          close: Some(close_callback::<T>),
> -        print_info: None,
> -        export: None,
> -        pin: None,
> -        unpin: None,
> -        get_sg_table: None,
> -        vmap: None,
> -        vunmap: None,
> -        mmap: None,
> -        status: None,
>          vm_ops: core::ptr::null_mut(),
> -        evict: None,
> -        rss: None,
> +        ..pin_init::zeroed()
>      };

[Severity: Medium]
Does this commit miss a similar update in rust/kernel/drm/gem/shmem.rs?

The VTABLE initialization in shmem.rs explicitly lists fields without
using pin_init::zeroed(), similar to what was fixed here. When compiling
with CONFIG_RUST_DRM_GEM_SHMEM_HELPER=3Dy, won't this cause a missing
field error for the newly added handle_free callback?

rust/kernel/drm/gem/shmem.rs:
    const VTABLE: bindings::drm_gem_object_funcs =3D bindings::drm_gem_obje=
ct_funcs {
        free: Some(Self::free_callback),
        open: Some(super::open_callback::<T>),
        close: Some(super::close_callback::<T>),
        print_info: Some(bindings::drm_gem_shmem_object_print_info),
        export: None,
        pin: Some(bindings::drm_gem_shmem_object_pin),
        unpin: Some(bindings::drm_gem_shmem_object_unpin),
        get_sg_table: Some(bindings::drm_gem_shmem_object_get_sg_table),
        vmap: Some(bindings::drm_gem_shmem_object_vmap),
        vunmap: Some(bindings::drm_gem_shmem_object_vunmap),
        mmap: Some(bindings::drm_gem_shmem_object_mmap),
        status: None,
        rss: None,
        #[allow(unused_unsafe, reason =3D "Safe since Rust 1.82.0")]
        // SAFETY: drm_gem_shmem_vm_ops is a valid, static const on the C s=
ide.
        vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
        evict: None,
    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908175427.4720=
7-1-klarasmodin@gmail.com?part=3D1
