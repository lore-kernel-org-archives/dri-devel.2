Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49DAC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E526F10EF53;
	Wed,  5 Aug 2026 16:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQsP2bWB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869B310EF53
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:50:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AC7641618;
 Wed,  5 Aug 2026 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6741F00A3A;
 Wed,  5 Aug 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948645;
 bh=MoasSD73pAI5Xdm0WX/ZbP8bYG7kfU/musfgvZMBGJA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NQsP2bWBFzgjdfTfQch0/gVnYIpUiBFENaRzqfkizRpeuucyL0ZzxXEapxPm+fQjI
 fMv/TLd7y2yrl/RuwJvIlXku5rdqe+uCA2BUghzkymu7yQNAFkDx3CUeuoGzoKJZbI
 MYektPRDjPlTCb7QaL0Cb/ylEj1i5ll8G2iZBL9mnLPjXjiHmfzCs4jN4bLV+0bQ03
 SQ/Gq+Ib+A8zCwrLEuRCt4yCoOxK5O7ousOm2MBrMa5TGVr2DRlGpAsKVzYYsLr1zQ
 o+6n/NCq1oUK97pyLb7ZD/NXjOFQOnnmiTQntKlGXkKOpCAbzf5rGZ7AcT/xaXtTFp
 dCOejhLdRL3AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/16] rust: io: add static `cast()` method for views
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260805-typed_register-v2-1-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-1-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:50:44 +0000
Message-Id: <20260805165044.BA6741F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Soundness hole: `KnownSize` is an unsealed safe trait, but its con=
stants and methods are relied upon for memory safety in unsafe projections.
--

--- Patch [1]: [PATCH v2 01/16] rust: io: add static `cast()` method for vi=
ews ---
commit 5783172643ee35d4a1864537f0c76cc527b2cad9
Author: Gary Guo <gary@garyguo.net>

rust: io: add static `cast()` method for views

This commit adds a compile-time checked cast() method for I/O views in the
Rust subsystem. It uses minimum size and alignment information to statically
verify that the target type is of the same or smaller size and properly
aligned, allowing conversion without runtime checks.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index a38c20ba3d23e..adfc555de7d0d 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +    #[inline]
> +    fn cast<U>(self) -> <Self::Backend as IoBackend>::View<'a, U>
> +    where
> +        Self::Target: FromBytes + IntoBytes,
> +        U: FromBytes + IntoBytes,
> +    {
> +        let view =3D self.as_view();
> +        let ptr =3D Self::Backend::as_ptr(view);
> +
> +        const_assert!(size_of::<U>() <=3D Self::Target::MIN_SIZE);
> +        const_assert!(align_of::<U>() <=3D Self::Target::MIN_ALIGN.as_us=
ize());
> +
> +        // SAFETY: We have checked bounds and alignment, so this is a va=
lid projection.
> +        unsafe { Self::Backend::project_view(view, ptr.cast()) }
           ^^^^^^

[Severity: High]
This is a pre-existing issue, but does relying on KnownSize constants for
memory safety create a soundness hole?

KnownSize is an unsealed safe trait that provides the constants and methods
relied upon for these safety guarantees. Because it is a safe trait, safe
code could provide an incorrect implementation for a custom dynamically siz=
ed
type (DST), specifying an excessively large MIN_SIZE or size().

If this happens, the bounds checks in cast() or try_cast() would pass based
on bogus values from the safe trait. The unsafe project_view() projection
would then proceed, potentially creating an out-of-bounds pointer projection
and leading to memory corruption.

Since implementing a safe trait shouldn't be able to trigger undefined
behavior in safe code, should KnownSize be marked unsafe or sealed to preve=
nt
unsound implementations?

> +    }
> +
>      /// Try to convert into a different typed I/O view.
>      ///
>      /// A runtime check is performed to ensure that the target type is o=
f same or smaller size to

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D1
