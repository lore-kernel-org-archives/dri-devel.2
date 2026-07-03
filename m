Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79193C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23BD10F6B1;
	Fri,  3 Jul 2026 07:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DlC0pGvW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B628010F6B1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:42:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 792D740AC7
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A271F000E9;
 Fri,  3 Jul 2026 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783064577;
 bh=qkoXPKBPYWdapWPZ/goqYU38v4vdkVLM3a5PowizMjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DlC0pGvWfak+7cWB54covaAoboFgY8Mre1ZqMK9sQaHcKDTetsBiJx3YRvIoyjrQN
 L1oNN49irRN8oVQ+IaWFfIJzGGJmhFsp03ntnthlnzwlXTi4YknAEw0ZshCY/KHOQU
 PpCabjN81Ifmo71tmWrPY49ZWeNBq5q0b2cARdzbpY5vtcGYDlxn9uzgnG4HNeV2KO
 KmcHfc7vIIquKaS78+5ouN40VYmbjN6acCu2jvpMmQnkfvnoZE4Z4xSI6sHbw0/JoF
 OETp1o9E4EvuF5xexvWNAXOCQwqQEwUnwtEPrAZ8Hb83TMNZ9/bNe1C8rwu744uP9D
 VOOSy0nUcsINg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] rust: types: implement ForeignOwnable for ARef<T>
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260703073141.3962604-3-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 07:42:56 +0000
Message-Id: <20260703074257.32A271F000E9@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotations on small trait methods in `ForeignO=
wnable` for `ARef<T>`.
--

commit 51b0cb5da3a412f66a80b1925a746644ac0ed5c1
Author: Danilo Krummrich <dakr@kernel.org>
Subject: rust: types: implement ForeignOwnable for ARef<T>

This commit implements the ForeignOwnable trait for ARef<T>. It allows C
code to take ownership of ARef instances and defines BorrowedMut as a
shared reference, matching the semantics of the underlying reference-counted
type.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index b721b2e00b986..5407666136595 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs

[ ... ]

> @@ -188,6 +193,41 @@ fn eq(&self, other: &ARef<U>) -> bool {
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

[Severity: Low]
This isn't a bug, but the Rust subsystem coding guidelines require functions
in abstractions that are small or just forwarding to binding calls to be
annotated with #[inline].=20

Would it be appropriate to add the #[inline] annotation to into_foreign(),
as well as from_foreign(), borrow(), and borrow_mut() below, to ensure
optimal cross-crate inlining?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703073141.3962=
604-2-phasta@kernel.org?part=3D1
