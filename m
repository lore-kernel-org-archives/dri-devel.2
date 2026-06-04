Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD99ACD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C9611A2EB;
	Thu,  4 Jun 2026 20:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GPAk5dbP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9012211A2EB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:23:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0395060145
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AB11F00893;
 Thu,  4 Jun 2026 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604613;
 bh=9ZapocUyvwmCbzJ737qw9fhwPN1lL/Oo/9fxm6AZ+P0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GPAk5dbPrq8ympgdca6zln4OqRcmI5Xbl+0YDE1nhgIC2yccsUuTPOIwRGobeS5+R
 OdSnuWcbdDSC9L2ZWGPRuH+2g86BJrL3Ak8ny3XB6tdUqmjSmJrUTzZTOKz2zXrmFH
 fEaxdqc0qDLTReJH5zjb8+zVMko0T/7dYepDhun5UYMkc5rVaTdouhY4hTTuEB3KjC
 GtZjW0PvnDtMA8nfZqICEMvvNDIU3BIsmSzfssts+P3c7m5WMDleXWDAdXTWWr53Z2
 M0LsqF/IJwavLv7uWdthMbKnNQuHicRknVEozvm6lLmDOZHujND5pJLchzMioWBxhj
 38lvsIGPrv9BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/10] rust: implement `ForeignOwnable` for `Owned`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 ojeda@kernel.org
In-Reply-To: <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:23:33 +0000
Message-Id: <20260604202333.77AB11F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `FOREIGN_ALIGN` is incorrectly set to `align_of::<Owned<T>>()` ins=
tead of `align_of::<T>()`, violating the `ForeignOwnable` safety contract a=
nd risking pointer corruption when used with `XArray`.
- [Low] Missing `// INVARIANT:` comment when constructing `Owned<T>` in `fr=
om_foreign()`.
--

commit 65031e6cc93134c76e2f6b85f3d269f18d531a88
Author: Andreas Hindborg <a.hindborg@kernel.org>
rust: implement ForeignOwnable for Owned

This commit implements the ForeignOwnable trait for Owned<T>. This enables
the use of Owned<T> in collections like XArray.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index 456e239e906ef..5eacdf327d121 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
[ ... ]
> @@ -185,3 +188,46 @@ fn drop(&mut self) {
>          unsafe { T::release(self.ptr.as_mut()) };
>      }
>  }
> +
> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
> +// pointer satisfy alignment requirements of `T`.
> +unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<Owned<T>>();

[Severity: High]
Does this alignment calculation break the ForeignOwnable contract if T has a
smaller alignment than Owned<T>?

The ForeignOwnable trait guarantees that pointers returned by into_foreign()
will have a minimum alignment of FOREIGN_ALIGN. However, into_foreign()
returns a raw pointer to the underlying T, while FOREIGN_ALIGN is hardcoded
to the alignment of Owned<T> (which evaluates to the alignment of NonNull<T=
>,
typically 8 bytes).

If T is a type with a smaller alignment requirement (such as 1 or 4 bytes),
into_foreign() might return a pointer that is not 8-byte aligned, yet
FOREIGN_ALIGN will falsely claim it is. XArray relies on this alignment
to use the lower bits for internal tagging. Could this lead to pointer
corruption when inserting an Owned<T> holding an underaligned T into an
XArray?

> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D Pin<&'a mut T>;
> +
> +    #[inline]
> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {
> +        let ptr =3D self.ptr.as_ptr().cast();
> +        core::mem::forget(self);
> +        ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
> +        Self {

[Severity: Low]
This isn't a bug, but is this missing an invariant comment for the Owned<T>
struct construction?

According to the Rust subsystem guidelines, when a struct with an
Invariants documentation section is constructed, the code should have an
// INVARIANT: comment explaining why the invariants are satisfied. The
from_foreign() implementation constructs Self { ptr: ... } without this
mandatory comment explaining how reconstructing the struct maintains the
ownership and pinning invariants.

> +            // SAFETY: By function safety contract, `ptr` came from
> +            // `into_foreign` and cannot be null.
> +            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
> +        }
> +    }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D3
