Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120DEC88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3EEC10F3B2;
	Thu, 10 Sep 2026 09:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K11VrlCE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E25010E167
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:14:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC7C2600D4;
 Thu, 10 Sep 2026 09:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127391F000FF;
 Thu, 10 Sep 2026 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031650;
 bh=KhOVk1R5yXBKmAaNEaPrgmZGENdKNLdVkyMUu2iD1KU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K11VrlCE8BQN63nv3O/Ws441J6fq81fvDeTymdvmKw620tX0LFKwCI/gX66RJZ/h3
 agusq07+S4uEmfE18sAuhSy/zGYNqX7Qt8QW+tV+WguMZXOc3ZPt8xJ0licpkJy6rU
 yyJ2pDb7+ocCLiTgu87ebWsCoDV1X/wTAkjNvQuubY7XBSoH7xjL3ktBnG7sECPtg2
 TpE9yTIILOao3L+X53MdaP9AjhCFSSCVPls4Ml69a2Ya5zbopUqcuZ+J6Q3BkgoMTi
 EZXyHyk6ai3QvvSYhWn2gYAPETtYDDNQrskeAtYCF99VmKexUm8ltXn16/ntg0hvzt
 ahCQUz9m+Sh7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-4-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:14:09 +0000
Message-Id: <20260910091410.127391F000FF@smtp.kernel.org>
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
- [Medium] The `ForeignOwnable` implementation for `ARef<T>` unnecessarily =
requires `T: AlwaysRefCounted` instead of `T: RefCounted`.
- [Low] Conditional compilation failure in `fwctl.rs` and `serdev.rs` due t=
o incomplete `AlwaysRefCounted` refactoring.
--

commit 6b87875ccf108a75e9bf33ac87bec77ac53590b0
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename `AlwaysRefCounted` to `RefCounted`.

There are types where it may both be reference counted in some cases and
owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.

[ ... ]

[Severity: Low]
The tree-wide refactoring seems to have missed `rust/kernel/fwctl.rs` and
`rust/kernel/serdev.rs`, which still attempt to implement methods on
`AlwaysRefCounted`.

For example, in `rust/kernel/fwctl.rs`:

unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
    #[inline]
    fn inc_ref(&self) {
        // SAFETY: `self` holds a live reference.
        unsafe { bindings::fwctl_get(self.as_raw()) };
    }
    ...

Since `AlwaysRefCounted` is now an empty marker trait, will this cause
compilation failures when `CONFIG_FWCTL` or `CONFIG_SERIAL_DEV_BUS` are
enabled?

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 9983ee0852486..215e7eb139fac 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> @@ -188,15 +201,15 @@ fn drop(&mut self) {
> =20
>  impl<T, U> PartialEq<ARef<U>> for ARef<T>
>  where
> -    T: AlwaysRefCounted + PartialEq<U>,
> -    U: AlwaysRefCounted,
> +    T: RefCounted + PartialEq<U>,
> +    U: RefCounted,
>  {
>      #[inline]
>      fn eq(&self, other: &ARef<U>) -> bool {
>          T::eq(&**self, &**other)
>      }
>  }
> -impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
> +impl<T: RefCounted + Eq> Eq for ARef<T> {}
> =20
>  // SAFETY: `into_foreign` returns a pointer from `NonNull::as_ptr`, so i=
t's non-null. The
>  // `ARef` invariant guarantees that `ptr` points to a valid `T`, so it's=
 aligned to `T`.

[Severity: Medium]
This trait bound appears to have been missed during the conversion. Just be=
low
this context in `aref.rs` is:

unsafe impl<T: AlwaysRefCounted> ForeignOwnable for ARef<T> {

Does this unnecessarily limit the FFI usability of `ARef<T>` for types that
are `RefCounted` but not `AlwaysRefCounted`? Should this be updated to
`T: RefCounted` instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D4
