Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F60CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF5B10F8A6;
	Mon,  8 Jun 2026 18:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RS+/AHdT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798BD10F8A6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:43:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51C444197A;
 Mon,  8 Jun 2026 18:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF6C1F00893;
 Mon,  8 Jun 2026 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780944209;
 bh=n2iiPZKHLCgxYq6Uds/OV3e9PRufcFCIkSZxGZRCBS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RS+/AHdTUOLyWfmZddYwPYTAJnfahI6OUI6N6T/CsViEUJIJMktuu3lPTPzWxI9wQ
 8EFIVxdHYYbXcdevsCvriVn8FV0P01jqW5KrSE/vy8xyOpXOxMoMytNBGA5DyLpcDu
 mCO/HI/dPajpbWnjVRiFVOVA0D74Hdqe62eoOZBqwT5dmUConlFUcZYBqam7M9I2SI
 hAoWNyXzsuNu/EWuN0jU2/dS2bQ/lpy1d0UQ+mo6QGlmMkxO5kqPe1T+3uViAC82an
 bdloPm6wZ/2tPcR3CEYBzySayb3p7a2yU+bhCvdZW2etzxcss/Ry7xxhZTKTu1KtDG
 KFN3nRolLc6nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/4] rust: drm: gem: shmem: Add DmaResvGuard helper
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260608183057.2001376-2-lyude@redhat.com>
References: <20260608183057.2001376-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:43:28 +0000
Message-Id: <20260608184329.0BF6C1F00893@smtp.kernel.org>
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
- [Low] Incorrect use of `#[inline(always)]` instead of `#[inline]` for abs=
traction methods.
--

commit 35068fc880d5bd0d2870750a321a6b8155d32ae4
Author: Lyude Paul <lyude@redhat.com>

rust: drm: gem: shmem: Add DmaResvGuard helper

This commit adds a temporary DmaResvGuard helper type for managing the
dma_resv lock on GEM shmem objects. It implements a drop handler to
automatically release the lock.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index 34af402899a0e..79ebd746e9611 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -235,3 +241,32 @@ impl<T: DriverObject, C: DeviceContext> driver::Allo=
cImpl for Object<T, C> {
>          dumb_map_offset: None,
>      };
>  }
> +
> +/// Private helper-type for holding the `dma_resv` object for a GEM shme=
m object.
> +///
> +/// When this is dropped, the `dma_resv` lock is dropped as well.
> +///
> +// TODO: This should be replace with a WwMutex equivalent once we have s=
uch bindings in the kernel.
> +struct DmaResvGuard<'a, T: DriverObject, C: DeviceContext =3D Registered=
>(
> +    &'a Object<T, C>,
> +    NotThreadSafe,
> +);
> +
> +impl<'a, T: DriverObject, C: DeviceContext> DmaResvGuard<'a, T, C> {
> +    #[inline(always)]

[Severity: Low]
This isn't a bug, but should this use #[inline] instead of #[inline(always)=
]?

According to the Rust subsystem guidelines, #[inline(always)] should be
reserved for functions using build_assert!() that depend on function
parameters. For small abstraction functions that simply forward to binding
calls like this one, #[inline] is the correct annotation.

> +    #[expect(unused)]
> +    fn new(obj: &'a Object<T, C>) -> Self {
> +        // SAFETY: This lock is initialized throughout the lifetime of `=
object`.
> +        unsafe { bindings::dma_resv_lock(obj.raw_dma_resv(), ptr::null_m=
ut()) };
> +
> +        Self(obj, NotThreadSafe)
> +    }
> +}
> +
> +impl<'a, T: DriverObject, C: DeviceContext> Drop for DmaResvGuard<'a, T,=
 C> {
> +    #[inline(always)]

[Severity: Low]
This isn't a bug, but could this drop method also use #[inline] instead of
#[inline(always)] for the same reason mentioned above?

> +    fn drop(&mut self) {
> +        // SAFETY: We are releasing the lock grabbed during the creation=
 of this object.
> +        unsafe { bindings::dma_resv_unlock(self.0.raw_dma_resv()) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608183057.2001=
376-1-lyude@redhat.com?part=3D1
