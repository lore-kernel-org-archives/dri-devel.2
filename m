Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34779CD98F0
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC6110E170;
	Thu, 18 Jun 2026 23:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LceKL+IF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C6710E170
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 23:21:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4263601E1;
 Thu, 18 Jun 2026 23:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CF61F000E9;
 Thu, 18 Jun 2026 23:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781824893;
 bh=derquLN5jNRne0CrSyAnT9o6sybtRIsU5R1UtyQ0nEQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LceKL+IFj9xUK+F1OKEQmTrYLNDjGFC6nLEQsbTApaBo9InkN8qUVs72wmB/maNA0
 dB+A00J6AunugsLYZu99iLy4qlNgD9l9hkdvzNJJFA9P8GOk4/DDQuyHaLZJmni5db
 Ks1Vc/8K36t3hYP8ifoD349mYiH/MfohHtFD5zfA6BHsn4ZS9TxdABrsZBCdsHkrD0
 qh48RdcIm4kF/7GD/bD4PXr6GMbApFjC04hbFcyb/52ibJ2UVNkM6DQXgQsLuGiHG0
 DkQC6WoxSBjmYT32wBibLtUBLI7Q/nITXiORd5tvpWmC/1+kdcA1A2sSkI6aGBEN/Q
 +dwILOoHUDgEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] rust: devres: add DevresLt for ForLt-aware
 device resource access
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260618230834.812007-6-dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 23:21:32 +0000
Message-Id: <20260618232133.58CF61F000E9@smtp.kernel.org>
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
- [High] `DevresGuard` implements `Deref` exposing the inner lifetime `'a` =
tied to `DevresLt` rather than the guard's lifetime (`'guard`), causing an =
API soundness issue that can lead to Use-After-Free.
- [Low] Missing `#[inline]` annotations on small forwarding abstraction fun=
ctions.
--

commit 20febe7248eef3fe1ba711b99c2b480ed7284b88
Author: Danilo Krummrich <dakr@kernel.org>

rust: devres: add DevresLt for ForLt-aware device resource access

This commit introduces DevresLt, a wrapper around Devres that provides
lifetime-aware access to device resources. It adds accessors that correctly
shorten the stored static lifetime to the caller's borrow lifetime, prevent=
ing
unsound static lifetimes from being exposed.

> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 11ce500e9b76f..e11deff3e1be5 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
[ ... ]
> @@ -365,6 +367,104 @@ fn drop(&mut self) {
>      }
>  }
> =20
> +/// Guard returned by [`DevresLt::try_access`].
> +///
> +/// Dereferences to `F::Of<'a>`, shortening the lifetime of the stored d=
ata to the guard's borrow
> +/// lifetime.
> +pub struct DevresGuard<'a, F: CovariantForLt>(RevocableGuard<'a, F::Of<'=
static>>);
> +
> +impl<'a, F: CovariantForLt> core::ops::Deref for DevresGuard<'a, F> {
> +    type Target =3D F::Of<'a>;
> +
> +    fn deref(&self) -> &Self::Target {

[Severity: Low]
This isn't a bug, but shouldn't this trivial forwarding function be annotat=
ed
with #[inline]?

[Severity: High]
Could implementing Deref here expose the outer lifetime 'a instead of the
guard's lifetime, potentially leading to a use-after-free?

Because F::Of<'a> is exposed with its outer 'a lifetime, a caller can
trivially extract references with lifetime 'a from it.

When DevresGuard is dropped, the internal RCU guard is released, ending the
RCU read-side critical section. However, the extracted 'a reference is still
valid from the compiler's perspective because it is tied to DevresLt.

If the device is concurrently unbound, devres will revoke and drop the
internal data. Accessing the extracted 'a reference afterwards results in a
use-after-free.

Would it be safer to remove Deref and provide an explicit get method that
yields &'guard F::Of<'guard>?

> +        F::cast_ref(&*self.0)
> +    }
> +}
[ ... ]
> +    /// Return a reference of the [`Device`] this [`DevresLt`] instance =
has been created with.
> +    pub fn device(&self) -> &Device {

[Severity: Low]
This isn't a bug, but should this small forwarding function have an
#[inline] annotation as per the Rust subsystem guidelines?

This also applies to other trivial forwarding methods added in this commit,
such as access_with, try_access_with, and access.

> +        self.0.device()
> +    }
[ ... ]
> +    /// [`DevresLt`] accessor for [`Revocable::try_access`].
> +    pub fn try_access(&self) -> Option<DevresGuard<'_, F>> {

[Severity: High]
Is there a risk that tying the guard to the borrow lifetime of &self allows
references to outlive the RCU read-side critical section?

This method borrows &self for lifetime 'a and returns Option<DevresGuard<'a,
F>>. Combined with the Deref implementation, this exposes the longer lifeti=
me
'a to the caller, bypassing the RCU lock's guard lifetime.

[Severity: Low]
This isn't a bug, but would it be appropriate to add an #[inline] annotation
to this forwarding function?

> +        self.0.data().try_access().map(DevresGuard)
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618230834.8120=
07-1-dakr@kernel.org?part=3D5
