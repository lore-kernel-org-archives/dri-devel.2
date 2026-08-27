Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936BBC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BC010EEC6;
	Thu, 27 Aug 2026 07:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R9kQ2a5y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8632910EEC6
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:40:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 363D243D47;
 Thu, 27 Aug 2026 07:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCCD1F000E9;
 Thu, 27 Aug 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787816402;
 bh=BRVVj9KGZ6/sCQDWGpW76yiew9uVktsrh5yPwfFQ4zE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R9kQ2a5y9MxUU+fGouq0ab4VfNNunhNqH/6viKTYGQMHqEUXPrO6vas1FFVS2tU/T
 p7aLEmB4+ahCwfV0Z3VK0b2RTg4e9c+vpA1h+zmFomxM3/c0G1XxmVhd/b54RrgP5N
 suH/aTl5o+XNDAmwaHF5Z17mwPk+aeMhmBF+8BVvbzj8AQGF4qPhGktLOPIWuJJP7+
 lt+WyikIb/TESkBb6AXaVsR1lYznt+1OwZE+U0w+V9H9M2V+RHO1LThi3MGwjRrG/4
 2tfzc8FifG0BeXlfK9pEG/PJ5oJ6jDtRny7w4EtJ5PL2nMvrR6YrF9Hz293Sf7Oxho
 UnetmyId+vIwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/12] rust: bitmap: restrict bitmap length to at
 most i32::MAX
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260827-chid-v8-2-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-2-bc74c77d0214@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:40:01 +0000
Message-Id: <20260827074001.BFCCD1F000E9@smtp.kernel.org>
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
- [Low] Incomplete SAFETY comments for `Bitmap::from_raw` calls in unit tes=
ts.
--

commit f2871aa21f86bcf804086540b9bc1b66aba9457a
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: bitmap: restrict bitmap length to at most i32::MAX

This restricts all Bitmaps (even non-BitmapVec backed ones) to a maximum
size of i32::MAX to simplify operations and match BitmapVec::MAX_LEN. It
adds this requirement to the unsafe preconditions and invariants of Bitmap
functions.

Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc2..df5505ec7a965 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
[ ... ]
> @@ -17,24 +17,59 @@
[ ... ]
>  impl Bitmap {
>      /// Borrows a C bitmap.
>      ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exc=
eeds `i32::MAX`.
> +    ///
>      /// # Safety
>      ///
>      /// * `ptr` holds a non-null address of an initialized array of `uns=
igned long`
>      ///   that is large enough to hold `nbits` bits.
> +    /// * `nbits` must not exceed `i32::MAX`.
>      /// * the array must not be freed for the lifetime of this [`Bitmap`]
>      /// * concurrent access only happens through atomic operations
>      pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a B=
itmap {

[Severity: Low]
Since a new safety precondition is added here, shouldn't the SAFETY comments
on existing callers be updated to explain how this condition is satisfied?

For example, the test code in rust/kernel/bitmap.rs calls from_raw() but
the comments only justify the array length:

rust/kernel/bitmap.rs:tests::bitmap_borrow() {
    ...
    // SAFETY: `fake_c_bitmap` is an array of expected length.
    let b =3D unsafe { Bitmap::from_raw(fake_bitmap.as_ptr(), fake_bitmap_l=
en) };
    ...
}

rust/kernel/bitmap.rs:tests::bitmap_copy() {
    ...
    // SAFETY: `fake_c_bitmap` can be used as one-element array of expected=
 length.
    let b =3D unsafe { Bitmap::from_raw(core::ptr::addr_of!(fake_bitmap), 8=
) };
    ...
}

Should these be updated to also mention that fake_bitmap_len and 8 do not
exceed i32::MAX?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-chid-v8-0-=
bc74c77d0214@nvidia.com?part=3D2
