Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39098CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923F310E8FB;
	Tue, 16 Jun 2026 08:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dGy7UEWl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297F710E8FB
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8351A600AB
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8091F000E9;
 Tue, 16 Jun 2026 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781599126;
 bh=ZYJ/oxQPMFdgfK/jnhuShXR38yn6lpL/adwbvwew+EQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dGy7UEWlHittSLrct3r038EUuchoEFBiu7mCxbUxJcEmdNXJuiH8nuExcaPq8dySm
 lAtol9EZOkzBCtmgG+NgEPoRzoKe3ezN/v/WExF4vOcJgMOoYrYdok3ZmA62A0i7OI
 uWY7Ns8FylkN/6vzvagJxEAgCg3J2FuwU/t9y8fqCZ+zbr5x/c/AcCoDqswjSGoKsd
 bJAbRiL/9djIGR3otpLgMtiak3FCNPaEtnn+TMXhsnyFg4GkyyeTwOaKYdXS2iMwVC
 ZR4avIpwrz/S8NFtQ1lgHqZlxQs8pCXqeWcIfrVAcs4wnjbt5e3SNUK51AvSISV5ZQ
 32ouv321A1SQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] rust: types: implement ForeignOwnable for ARef<T>
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260616082819.2943886-3-phasta@kernel.org>
References: <20260616082819.2943886-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 08:38:45 +0000
Message-Id: <20260616083846.0C8091F000E9@smtp.kernel.org>
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
- [Low] Missing `#[inline]` attributes on small forwarding functions in abs=
traction crate.
--

commit a8487c7d01286e697fa7028c9540c62f1483807e
Author: Danilo Krummrich <dakr@kernel.org>

rust: types: implement ForeignOwnable for ARef<T>

Implement ForeignOwnable for ARef<T>, making it possible for C code to
own an ARef<T>.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 9989f56d06052..82907383c44b5 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> @@ -183,6 +187,41 @@ fn eq(&self, other: &ARef<U>) -> bool {
>  }
>  impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
> =20
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
> +        ARef::into_raw(self).as_ptr().cast()
> +    }

[Severity: Low]
This isn't a bug, but should into_foreign(), from_foreign(), borrow(),
and borrow_mut() be annotated with #[inline]?

The Rust subsystem guidelines suggest that small or forwarding functions
in kernel abstractions should use the #[inline] attribute.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616082819.2943=
886-2-phasta@kernel.org?part=3D1
