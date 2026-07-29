Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA02C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F037710EB6C;
	Wed, 29 Jul 2026 09:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wt6nWPLx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D592110EB70
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:56:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1156600B1;
 Wed, 29 Jul 2026 09:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CC91F000E9;
 Wed, 29 Jul 2026 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785319004;
 bh=1KGT6cTMTzmvzS7YsWYKykFEG86ah6U86GDtjt8cglY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wt6nWPLxXxYmam8h7M4avTSxpaguMCUHckhmp5ZUajuTjsbeGT9FXN7K599Gsv+Dt
 cVW7SnzQ4WMdwncTNTfPRhefWdJlv5GKqw4JgHqzEnLwqB3G8uvb5e3lfKsLFnJPNS
 r1r0Ev1e8xfPaitbs8WQM7L6URBKs+gOiRaexSLgBkNOD84iyWdHHTGsC2eUQcEwOm
 JAAnHwnREuXpHzG8SV2fBy3pXtUJMxKL7/FYzkmP1t5AgEpidO1jTGimsA0SgYjSX2
 /UXoLctWo9esTkszxu/UyITG13SqLNOJDkgbLlfq/t511gElOnGkAx5VSmfjv97NGe
 cExuw0rDFjhrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] rust: types: implement ForeignOwnable for ARef<T>
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260729094542.302965-4-phasta@kernel.org>
References: <20260729094542.302965-2-phasta@kernel.org>
 <20260729094542.302965-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 09:56:43 +0000
Message-Id: <20260729095644.53CC91F000E9@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotations on small functions in an abstractio=
n. The `into_foreign`, `from_foreign`, `borrow`, and `borrow_mut` methods i=
n the `ForeignOwnable` trait implementation for `ARef<T>` are small, forwar=
ding-style wrappers but lack the required `#[inline]` attribute.
--

--- Patch [2]: [PATCH v7 2/5] rust: types: implement ForeignOwnable for ARe=
f<T> ---
commit 8f27d3e39cb5663e64788b9670c36ec543c46826
Author: Danilo Krummrich <dakr@kernel.org>

rust: types: implement ForeignOwnable for ARef<T>

Implement ForeignOwnable for ARef<T>, making it possible for C code to
own an ARef<T>. Since ARef represents shared ownership, BorrowedMut yields
a shared reference.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index b721b2e00b986..5407666136595 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> +// SAFETY: `into_foreign` returns a pointer from `NonNull::as_ptr`, so i=
t's non-null. The
> +// `ARef` invariant guarantees that `ptr` points to a valid `T`, so it's=
 aligned to `T`.
> +unsafe impl<T: AlwaysRefCounted + 'static> ForeignOwnable for ARef<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *mut c_void {

[Severity: Low]
This isn't a bug, but should the small methods implemented here
(into_foreign, from_foreign, borrow, and borrow_mut) include #[inline]
annotations?

The Rust subsystem guidelines note that small functions or forwarding metho=
ds
in abstractions need to be annotated with #[inline] to allow optimal inlini=
ng
across crate boundaries.

> +        ARef::into_raw(self).as_ptr().cast()
> +    }
> +
> +    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        let ptr =3D unsafe { NonNull::new_unchecked(ptr.cast()) };
> +
> +        // SAFETY: `ptr` came from `into_foreign`, which consumed an `AR=
ef` without decrementing
> +        // the refcount, so we can transfer the ownership to the new `AR=
ef`.
> +        unsafe { ARef::from_raw(ptr) }
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements of this method ensure that th=
e object remains alive and
> +        // immutable for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements for `borrow_mut` are a supers=
et of the safety
> +        // requirements for `borrow`.
> +        unsafe { <Self as ForeignOwnable>::borrow(ptr) }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729094542.3029=
65-2-phasta@kernel.org?part=3D2
