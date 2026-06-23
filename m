Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27ECDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F4810ECB0;
	Tue, 23 Jun 2026 20:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OzueR+O0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9D610ECB0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:49:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 651BF419C4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D271F000E9;
 Tue, 23 Jun 2026 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247779;
 bh=/NY1iqQOfEVDCtmV/1idlY1rpO3vIV+qUHDD2ECE1iE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OzueR+O08BjF0k+j+wsA0PUstthR3UsKLG1YFrnnuHhCE/ijpMMv8DlNaJgC3av4Y
 Ew/UtRaszcrulzNPaPYY6oCCMJVDUWdAuYKQV6sDdu5a57lWQJnwZLzmOAWwb0dqg7
 DQhIJv7bLP4F/KuOTLsfR03OsTxRWpTP1HFz0qSqLaGKv8wEPbKvCW0bXP4MUfS5EG
 lVp79+fiDOTh5qsIQR9jYR566tt/nd5mfV5vi/wWgpcJ8QxerUXeKvZr3dehJYcwM+
 NxOtrp6VsZCad5R7fL3McjDYcj1Pmt0DtR+cqSfUZDlbTZ7GiI0Tb1Ek7M2RJmAD4t
 2OleSQmhzIt3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] rust: types: implement ForeignOwnable for ARef<T>
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260622135654.334961-3-phasta@kernel.org>
References: <20260622135654.334961-2-phasta@kernel.org>
 <20260622135654.334961-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:49:38 +0000
Message-Id: <20260623204939.19D271F000E9@smtp.kernel.org>
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
- [Low] Small functions in the `ForeignOwnable` trait implementation for `A=
Ref<T>` are missing `#[inline]` annotations.
--

commit 5f304b2260799e0fe0be8848ec9e82f882fdc711
Author: Danilo Krummrich <dakr@kernel.org>

rust: types: implement ForeignOwnable for ARef<T>

This commit implements ForeignOwnable for ARef<T>, making it possible for
C code to own an ARef<T>. Since ARef represents shared ownership,
BorrowedMut is &T rather than &mut T, matching the semantics of the
underlying reference-counted type.

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
This isn't a bug, but according to the Rust subsystem guidelines, should th=
is
small forwarding function in the abstraction be annotated with #[inline]?

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

[Severity: Low]
This isn't a bug, but should from_foreign() also be annotated with #[inline]
since it is a small forwarding function?

> +
> +    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements of this method ensure that th=
e object remains alive and
> +        // immutable for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }

[Severity: Low]
This isn't a bug, but should borrow() also be annotated with #[inline]?

> +
> +    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements for `borrow_mut` are a supers=
et of the safety
> +        // requirements for `borrow`.
> +        unsafe { <Self as ForeignOwnable>::borrow(ptr) }
> +    }

[Severity: Low]
This isn't a bug, but should borrow_mut() also be annotated with #[inline]?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622135654.3349=
61-2-phasta@kernel.org?part=3D1
