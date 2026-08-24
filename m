Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07AEC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DADB10E736;
	Mon, 24 Aug 2026 11:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M3B6rrpy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC42110E736
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:25:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AC23600AD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52091F000E9;
 Mon, 24 Aug 2026 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570706;
 bh=VIdaYXsFwC4fR7G0J2HjX1xXHf7oy9BGqGAvnj+mRnQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M3B6rrpyrN6USt8mEzgiEfQ6/lnfFldbwrlcPtrtOMzOMtavtjP6bicGYuDVegXqa
 7t2t4pUOZxABSkDqgCwUL7wel3Kmff51lugwAY4rY4qArCw57tLNj2mjClFON+/F4w
 E2wGYfbfdEaLpSgbmj8DjNzS7iyoNEpAfoCvFDnHmYaDqXdG05bSw7vhH8gg4yMvWh
 18ygOgbC3/IhkINz2xa7302oO5TgAKFu+mxYmPLws5ya78wYCkSXJscxitulMZX+bL
 YGNcqmJbLSx4gVXXDbcayJ4q6PlpcFLBT3KJ2Hj3Abd2dEBHuH7NmJu33wMPeB7oH9
 Op74q7EXrX+0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:25:06 +0000
Message-Id: <20260824112506.A52091F000E9@smtp.kernel.org>
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
- [Low] Mismatched and incorrect SAFETY comments in the `ARef::into_raw` do=
ctest, alongside an unsound `RefCounted` trait implementation.
--

--- Patch [6]: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `=
ARef` example ---
commit 1891eeeba9b2ed0af7d99f9518dcd85941d2518c
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add missing SAFETY documentation for ARef example

This commit updates the rustdoc example for ARef to replace the "TODO"
SAFETY comments with explanations for the RefCounted trait implementation
and ARef::from_raw call.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
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

[Severity: Low]
Are the SAFETY comments for the trait implementation and from_raw call swap=
ped
here?

This comment justifies the caller requirement of ARef::from_raw (owning an
increment), rather than the trait's own safety requirement (that increments=
 keep
the object alive).

Additionally, does this explanation overlook the fact that the stack-alloca=
ted
variable data will eventually go out of scope and be freed?

If a developer copies this pattern and calls ARef::clone(), could it extend=
 the
pointer's lifetime beyond the stack frame without keeping the underlying ob=
ject
alive?

> @@ -150,7 +152,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };

[Severity: Low]
Does this comment justify the object's lifetime (which is the responsibilit=
y of
the RefCounted trait implementation) instead of addressing the specific saf=
ety
requirement of ARef::from_raw?

The from_raw method requires the caller to own a reference count increment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D6
