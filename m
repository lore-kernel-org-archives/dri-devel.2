Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D984BCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2605C10EC8D;
	Tue, 23 Jun 2026 20:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UNrxWb+Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCCF10EC8D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:18:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0704760008
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBAE1F000E9;
 Tue, 23 Jun 2026 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782245936;
 bh=Ut7uXlvcifUzY4HGJkrFJuDClWi0OUwJtzEiBCv7iOQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UNrxWb+ZArCrBpSv6yUEm5soBZea5+cwiEPrq6RdW3kRB9XZbLn2AUQTU/uNk/IIt
 K9prHc35guM0c4uAeTTEBPk2ktzLarqmN5GiGBKWysG1AN4vISBfU3q65aiXlq+kjO
 Rv1V5w0ai0pgl34tqDE5jiaefwCyLGpv5CIpYbFNScJwvTQ2nBb0D0zyzfxyp7srBu
 zLHt2stQ/XAKQuGcBM4Y95p+pfimViVECnqz7B6blX42bER1yIf7IPiXHfEEbmcwLZ
 BxWb7qut/acWg3xIoW/IPnJAaD4rEv0rvkwOHujGFYN/dOV598sDcKldFZAH8Rv8Vt
 6gC3UhxDQNmlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] rust: types: implement ForeignOwnable for ARef<T>
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260618132628.3811068-3-phasta@kernel.org>
References: <20260618132628.3811068-2-phasta@kernel.org>
 <20260618132628.3811068-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:18:56 +0000
Message-Id: <20260623201856.8CBAE1F000E9@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotations on small abstraction functions in `=
ForeignOwnable for ARef<T>`.
--

commit 4199b74db0ae4068188998ff9452d6df8acb7816
Author: Danilo Krummrich <dakr@kernel.org>

rust: types: implement ForeignOwnable for ARef<T>

Implement ForeignOwnable for ARef<T>, making it possible for C code to
own an ARef<T>.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs

[ ... ]

> +unsafe impl<T: AlwaysRefCounted + 'static> ForeignOwnable for ARef<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *mut c_void {
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

[Severity: Low]
This isn't a bug, but should into_foreign() and from_foreign() be annotated=
=20
with #[inline]?=20

Since aref.rs is a core abstraction, the Rust coding guidelines suggest add=
ing=20
the inline annotation to small or forwarding functions to help with cross-c=
rate=20
inlining optimizations. Would it make sense to add this to borrow() and=20
borrow_mut() in this block as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618132628.3811=
068-2-phasta@kernel.org?part=3D1
