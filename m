Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3FCDE00E
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECFA10E2A7;
	Thu, 25 Jun 2026 21:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fpHhLR4V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345C810E2A7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 21:14:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74A6660098;
 Thu, 25 Jun 2026 21:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBF1F000E9;
 Thu, 25 Jun 2026 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782422069;
 bh=BoTJbwZbYxHcRkP3NO71NszDxf8Az/KJbAISr4MDPmc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fpHhLR4VtR/H1S6Z4pEbhDSQ1wErm9AYSGLIDdtBf5qc7ZmuQIiDhi4rEk78FoaoP
 4cOv3BjBRJ7ngxyO49UWYVjPVTiNUxzClXT6UXqo3fSFdAwi9u0pjZfx9i9aojKU6B
 GE0NyMYkKTn6RrXC4q/7tuik4PrRJ4XPFEL7oeI8PYa4TLmex9UF97kvNRR16r/2t/
 mZ+w4CqFisAiVLIGE4dyZP8zri00TI1DhTgQ7sJvfB46D2XaJAYIXkRIjqBZRRODlE
 yMdx+kxsuYERLyenIX143pZRL5yYAnmjba8T+BvXqnk3SvLR4jZMhrgKz9o1OFc2em
 ORxceJo4U/+rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] drm/nova: use `zerocopy` in vbios.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260625205146.5047-3-niyudi.honda@usp.br>
References: <20260625205146.5047-1-niyudi.honda@usp.br>
 <20260625205146.5047-3-niyudi.honda@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 21:14:28 +0000
Message-Id: <20260625211428.B2BBF1F000E9@smtp.kernel.org>
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
- [High] VBIOS structures are parsed using native endianness, yielding inco=
rrect values and validation failures on Big Endian architectures.
--

commit dfd6016814a03a8ecf36ea1b92019e446ec39712
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: use zerocopy in vbios.rs

This commit replaces the transmute traits with their zerocopy equivalents
for parsing VBIOS structures. It updates the derive macros and changes the
initialization calls to use zerocopy's read_from_prefix().

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index e6d144587c4ee..a3c0c06f6818d 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs

[ ... ]

> @@ -525,7 +513,7 @@ fn from_id(image: &PciAtBiosImage, token_id: u8) -> R=
esult<Self> {
>  ///
>  /// This header is at the beginning of every image in the set of images =
in the ROM. It contains a
>  /// pointer to the PCI Data Structure which describes the image.
> -#[derive(Debug, Clone, Copy)]
> +#[derive(Debug, Clone, Copy, FromBytes)]
>  #[repr(C)]
>  struct PciRomHeader {
>      /// 00h: Signature (0xAA55)
>      signature: u16,

[Severity: High]
This is a pre-existing issue, but does mapping this byte stream directly in=
to
native integer types break on Big Endian architectures?

Since VBIOS data is typically little-endian, parsing it into native integer
types (like the u16 signature here, or the u16 id in BitHeader) means the
bytes will be interpreted backwards on Big Endian systems. For example, the
signature 0xAA55 would be read as 0x55AA, causing validation to fail entire=
ly.

Additionally, in VbiosIterator::read_more(), the data is read via try_read3=
2()
and converted to a byte stream using .to_ne_bytes(), which scrambles the by=
te
order in 4-byte chunks on Big Endian platforms.

Should these structures be using explicit little-endian types (like __le16)
to ensure correct VBIOS parsing across all architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625205146.5047=
-1-niyudi.honda@usp.br?part=3D2
