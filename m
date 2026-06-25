Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB8CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D2810F22F;
	Thu, 25 Jun 2026 10:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RVE0n8zz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A450010F22F
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:26:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 882C740123
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB9D1F000E9;
 Thu, 25 Jun 2026 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782383202;
 bh=cVmAAd3PPJq+H5j2lwVJ5eWd7apr2rFjOH/tjr/magY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RVE0n8zzQYvrnahGprbeXBj4vqVi7dGCx3/kREU6vmKA0lLKNaZJ6L8dI+Mlvynjh
 oA9LaoYWR4WSpBqPJLwum/2JyDStsfijANrPIzNxW2uUrO5rdpCL9mTK+dqVyZ4M6t
 VD9cKrt0IDJfuMnRfPNYKAFTIA3r1St2+xoU5tY4Ud7Bhd1JqatfOekp/NkRsFEfd5
 G2UtbKbJ1jjZ+gCBa1RukIz/797vn9tASwR8tqHAQidVwa4v3dsa7xZnbOI45A3Clc
 N7gk9pX4FdZ/Y6fyDJopTudxL67RHSXW6Z8EZLSOIjrJWpFFEI9SugjeYtFLiX9OU6
 JOaKVLY2GOU4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 7/8] rust: Add `OwnableRefCounted`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260625-unique-ref-v18-7-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-7-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:26:41 +0000
Message-Id: <20260625102641.EDB9D1F000E9@smtp.kernel.org>
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
- [High] The `OwnableRefCounted` trait is a safe trait but its default `int=
o_shared` method contains an `unsafe` block relying on unenforced invariant=
s, violating Rust's soundness rules.
- [Low] Incorrect documentation link for `ARef<Self>` in `aref.rs`.
--

commit b7dc8070575155be9312b255a20879f2e905b00f
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add `OwnableRefCounted`
   =20
Types implementing one of these traits can safely convert between an
`ARef<T>` and an `Owned<T>`.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index e79936c00002c..bb4223c0f725a 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs

[ ... ]

> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`]=
 if that is the case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying ob=
ject.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Sel=
f>>;
> +
> +    /// Converts the [`Owned`] into an [`ARef`].
> +    #[inline]
> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
> +        // SAFETY: `Owned::into_raw` returns a pointer to a valid `Self`=
, and the `Owned` owned the
> +        // reference count that we now transfer to the new `ARef`.
> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }
> +    }
> +}

[Severity: High]
Does this trait need to be marked unsafe?

The OwnableRefCounted trait is currently safe to implement, but the default
into_shared() method contains an unsafe block that assumes the Owned<Self>
implicitly holds a reference count of 1.

If a developer implements this safe trait for a type whose Owned<Self>
does not account for one RefCounted increment, calling into_shared() will
pass a pointer to ARef::from_raw() without a corresponding reference
increment.

When the resulting ARef is dropped, it will blindly call dec_ref(), which
could lead to a reference count underflow, double-free, or use-after-free.

Should OwnableRefCounted be an unsafe trait so that implementers are
required to guarantee the reference count invariant?

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index d0865aeb9371b..77eb390139079 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs

[ ... ]

> @@ -35,7 +39,10 @@
>  /// Note: Implementing this trait allows types to be wrapped in an [`ARe=
f<Self>`]. It requires an
>  /// internal reference count and provides only shared references. If uni=
que references are required
>  /// [`Ownable`](crate::types::Ownable) should be implemented which allow=
s types to be wrapped in an
> -/// [`Owned<Self>`](crate::types::Owned).
> +/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
> +/// [`OwnableRefCounted`] allows to convert between unique and
> +/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
> +/// [`ARef<Self>`](crate::types::Owned)).

[Severity: Low]
This isn't a bug, but there appears to be a copy-paste typo in the rustdoc
link.

The documentation for ARef<Self> points to crate::types::Owned instead
of ARef.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D7
