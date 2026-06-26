Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA99CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8D210F5A1;
	Fri, 26 Jun 2026 12:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AygZIf6a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB48510E378
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:02:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C72660098
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A799F1F000E9;
 Fri, 26 Jun 2026 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475359;
 bh=CLl+B7C+bN3r7S8yLnEe5nbMmmPmdYMtzvPCA9H3rhs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AygZIf6a5UL9r/vtV5RFYu6+K/wCq2Lm/RXw6ZAcnzB704Nj1pOUhCJQp2JaxbQEL
 IEkGk1Muuv723CwLDvmd2b1B+VE85nsrlZBR94pIpI3JAv/prVfj7Tq1ZFoUrnmJ4c
 cNU91tj0rLUnmZ/iK4AZJk9XMLYx+yuXSsBUCQCI71XYbQRSbExr8ylHIKM7LMJbJa
 RxWheAKBKd9bz9uBKpMrJBvNlpKPcNhu/5xFWJSSqeWsJeerVQzU1MdD3/NPMetxsm
 4gGNVB0mqFEWz7j7nfnPDs3D9/+jGEIWKIxyxJ8bsO2uIJ2wXp6ZH/Lkznb0RYcFVk
 vOsrz2ge0Fh8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260626-unique-ref-v19-6-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-6-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:02:38 +0000
Message-Id: <20260626120238.A799F1F000E9@smtp.kernel.org>
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
- [Medium] The newly added SAFETY comments in the rustdoc example incorrect=
ly justify an unsound trait implementation that violates the safety invaria=
nts of `RefCounted`.
--

commit 8c6c2bf519778f423165d5e3c916d3965bebb093
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add missing SAFETY documentation for ARef example

This commit replaces TODO safety comments in the rustdoc example for
ARef::into_raw with explanations of why the unsafe operations are permitted.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index ea5a16b8163a6..f26ca39b84d0d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> @@ -142,7 +142,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}

[Severity: Medium]
Does this explanation violate the safety invariants of the RefCounted trait?

The RefCounted trait strictly requires that increments to the reference cou=
nt
keep the object alive, and that all instances are reference-counted.

By using a no-op inc_ref and dec_ref, this example demonstrates an
unsound implementation of the trait, which might lead developers to
introduce use-after-free bugs if they copy this pattern into production
code.

>      /// }
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };

[Severity: Medium]
Is it safe to rely on stack-variable lifetimes here to bypass the normal
reference counting expectations?

ARef::from_raw and the RefCounted trait expect the object's lifetime to be
handled inherently via reference counting. Relying on keeping a stack
variable around longer than the ARef bypasses ARef::from_raw safety
preconditions.

Could this documentation lead others to incorrectly apply ARef to stack
variables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D6
