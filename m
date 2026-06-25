Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0B6CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5022F10E244;
	Thu, 25 Jun 2026 19:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGr98NzT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB8410E244
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:16:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21FAC40885;
 Thu, 25 Jun 2026 19:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B591F000E9;
 Thu, 25 Jun 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782414999;
 bh=edI3rj3HNxRZfpLUeK16z4yykcz4oiMW1qXxcKyGqXc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WGr98NzThXwcQhfirzWhpkLkfcNCXjBGctJ7QSOnPzabncvao3hG/p6YbRBUr2hQ+
 iDbLGbNiY+zSnapUqDsKnhuiwIVdvmJp84SeXAANmPPRMGX4eHhautSvVHg7dZ47wS
 Q2E6UdSaWj6MweuueyO8e+pPPj3PT4X0IKJoZ/5LjTZTA7pGGC/+a/7Ckrl3bMXUpL
 Sxm68zzLS6hMqEgG6aB2XV2W9xoX6WwWq7/Vf5XrBxI+qvcpGIuOEwkhKKQ23XuTzv
 3mVRUgQKZz7mrelQvNmMjCwKdXXp2G37gDG/6gESDtRMpKl7wjAEnqTWdw/M22RiDg
 VtsV0KW6cxPNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] drm/nova: use `zerocopy` in vbios.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260625190553.7245-3-niyudi.honda@usp.br>
References: <20260625190553.7245-1-niyudi.honda@usp.br>
 <20260625190553.7245-3-niyudi.honda@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:16:38 +0000
Message-Id: <20260625191638.B8B591F000E9@smtp.kernel.org>
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
- [High] VBIOS byte stream reconstruction from MMIO uses `to_ne_bytes()` an=
d struct parsing uses native integer types, corrupting VBIOS reading on big=
-endian architectures.
--

commit 1cc33aae3ba2ca65527c5d72b5ee976f3c73ac92
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: use `zerocopy` in vbios.rs
   =20
This commit replaces the `transmute::FromBytes` trait with its `zerocopy`
equivalent for various VBIOS structures in vbios.rs. It also updates the
call sites accordingly to use the new trait methods.

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index e6d144587c4ee..a3c0c06f6818d 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs

[ ... ]

> @@ -359,7 +356,7 @@ pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {
>  }
> =20
>  /// PCI Data Structure as defined in PCI Firmware Specification
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  #[repr(C)]
>  struct PcirStruct {
>      /// PCI Data Structure signature ("PCIR" or "NPDS")
>      signature: [u8; 4],
>      /// PCI Vendor ID (e.g., 0x10DE for NVIDIA)
>      vendor_id: u16,

[Severity: High]
This is a pre-existing issue, but since the VBIOS structures map directly to
little-endian VBIOS data, does using native integer types like u16 cause
the parsing to fail on big-endian architectures?

Also, since VbiosIterator::read_more() converts MMIO 32-bit words back into=
 a
byte stream using word.to_ne_bytes():

    word.to_ne_bytes()
        .iter()
        .try_for_each(|&b| self.data.push(b, GFP_KERNEL))?;

doesn't this byte-swap the little-endian hardware register data on big-endi=
an
systems?

Should explicit little-endian types (e.g.,
zerocopy::byteorder::little_endian::U16) and word.to_le_bytes() be used to
ensure the correct byte order is maintained?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625190553.7245=
-1-niyudi.honda@usp.br?part=3D2
