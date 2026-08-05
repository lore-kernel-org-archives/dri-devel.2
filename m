Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB143C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E5710E16D;
	Wed,  5 Aug 2026 15:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QAwHmdIo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6C010E16D
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:22:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D447060A5C;
 Wed,  5 Aug 2026 15:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFE91F000E9;
 Wed,  5 Aug 2026 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785943355;
 bh=P686AMhcfvMLgxJjxck77HMZ4+Y1vm3+FAEkU+Ysp48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QAwHmdIonddC9NkVRCrM+vrsqx3GPc0X0zULxspdOK2IteM1pS6MHmB806Prp9r4Z
 ii96mAyF3OLEhqOlbxlGwofTbAuHnsTBRw45UlSZtBU+RgqFCWbaCC/aICyHNCeTU8
 BXp07dBifs1oLvSLZMZGc7j0xeJFitntod2pJVst/EQ014i++9oNPbP0RxrRQvNMUR
 oNZ8WlLnHoah5H0t2yOCrna1vAckQflfwTN7FZ2nitQdgpu+bHT389Lp5fE2NccWy6
 lxLtnwOQmDlGpiDK6M/KE1QLIS7BaAHC8Rwnb7FOdloc03BhY/lWNwbGq7/OHjScYg
 OPVMB50DnB/7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] rust: types: implement ForeignOwnable for ARef<T>
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260805145949.938505-4-phasta@kernel.org>
References: <20260805145949.938505-2-phasta@kernel.org>
 <20260805145949.938505-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:22:34 +0000
Message-Id: <20260805152235.4AFE91F000E9@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotations on small forwarding methods within =
an abstraction.
--

--- Patch [2]: [PATCH v9 2/5] rust: types: implement ForeignOwnable for ARe=
f<T> ---
commit 46a32182bbc01f0e36763ebdf80c949f544fec26
Author: Danilo Krummrich <dakr@kernel.org>

rust: types: implement ForeignOwnable for ARef<T>

Implement ForeignOwnable for ARef<T>, making it possible for C code to
own an ARef<T>. Since ARef represents shared ownership, BorrowedMut is
&T rather than &mut T, matching the semantics of the underlying type.

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
> +        ARef::into_raw(self).as_ptr().cast()
> +    }

[Severity: Low]
This isn't a bug, but according to the Rust subsystem guidelines, small or
forwarding functions within abstractions should be annotated with #[inline].
Would it be appropriate to add the #[inline] attribute to into_foreign() he=
re?

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
Could from_foreign() also benefit from an #[inline] annotation, given it is=
=20
a small forwarding function?

> +
> +    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements of this method ensure that th=
e object remains alive and
> +        // immutable for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }

[Severity: Low]
Similarly, should borrow() be annotated with #[inline] to match the subsyst=
em
guidelines?

> +
> +    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements for `borrow_mut` are a supers=
et of the safety
> +        // requirements for `borrow`.
> +        unsafe { <Self as ForeignOwnable>::borrow(ptr) }
> +    }

[Severity: Low]
This function also appears to be a short forwarding wrapper. Is it missing =
the=20
#[inline] attribute as well?

> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805145949.9385=
05-2-phasta@kernel.org?part=3D2
