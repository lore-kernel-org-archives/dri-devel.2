Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960B3C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A9410F3AB;
	Thu, 10 Sep 2026 09:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lT3a2dFt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D25110F3A9
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:07:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E492600C8;
 Thu, 10 Sep 2026 09:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91C91F000FF;
 Thu, 10 Sep 2026 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031265;
 bh=HEZ4O89SFMpSqaF6EY7PB2n0cJpPIFqJZS3vY+lr37M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lT3a2dFtdXbSbKsfOcs01VMdMmESojaLc4tHsQpiSyJvsglq4796Q/cXTCvqqi/R7
 y868MGnNPJIvvZF9gYBrZNbConG01nE/QViomj6w5jJEsPiHefGDUWdpYpNYuK9B4z
 yFfejeh/yFHvlLMo9X4x6BrqfRcr5KTCUWr7kz5cuyLFoT+EvFQFYRLIwf0eS9mHD0
 SoA1Izxp416WNVgqhsMhpO7eNI4MKtyjDc/b1ygqfOx12VlducEeVFsIDuhqQxZBSD
 hRRA8/0nzcRjU6qUU47Fx6CK37rfncuKvUKgmnYlBcdIdO6xzXC8X+KmlBlxjtqcZl
 qaWTGZr/rxlWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for
 `ARef` example
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, gary@garyguo.net,
 linux-pci@vger.kernel.org
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-5-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:07:44 +0000
Message-Id: <20260910090744.E91C91F000FF@smtp.kernel.org>
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
- [Medium] The newly added SAFETY comments justify an unsound implementatio=
n of `RefCounted` by pushing the trait's liveness invariants onto the calle=
r.
--

commit 368d99cfa43beab2cba1151e1e06c503881e1ab5
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add missing SAFETY documentation for `ARef` example

This commit replaces a TODO comment with a detailed SAFETY comment in the
rustdoc example for ARef, explaining why the dummy RefCounted implementation
and subsequent ARef creation are considered safe.

Link: https://github.com/Rust-for-Linux/linux/issues/351

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 215e7eb139fac..ae76bd9b6c1c9 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -147,7 +147,10 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references, and
> +    /// // `dec_ref` never frees the underlying object, so a decrement c=
annot invalidate it. The
> +    /// // object instead lives as long as the `Empty` value itself, so =
creators of `ARef<Empty>`
> +    /// // must guarantee that the value outlives every `ARef` derived f=
rom it (as done below).

[Severity: Medium]
Does this pattern violate the safety contract of the RefCounted trait?

The documentation teaches an approach where creators of ARef<Empty> must
guarantee that the value outlives every ARef derived from it. Since ARef<T>
provides a safe Clone method and does not carry a lifetime parameter, it is
impossible for the creator to enforce this guarantee if the ARef is cloned
and sent to another thread.

If a developer copies this reasoning to implement RefCounted for a type
where inc_ref does not actually maintain liveness, could a cloned ARef
outlive the underlying object and cause a use-after-free vulnerability in
safe Rust?

>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -155,7 +158,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: As the refcount operations of `Empty` are no-ops, we =
can treat `ptr` as owning
> +    /// // an increment on the refcount. `data` outlives the created `AR=
ef`, upholding the
> +    /// // liveness guarantee required by the `RefCounted` implementatio=
n above.

[Severity: Medium]
Since the liveness guarantee mentioned in the RefCounted implementation abo=
ve
cannot be statically enforced by the caller during safe ARef clones, does
this initialization rely on an unsound guarantee?

>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>      ///

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D5
