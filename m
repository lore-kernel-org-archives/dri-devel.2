Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78728CDE009
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F5B10E24B;
	Thu, 25 Jun 2026 19:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OaePTnd2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8484310E247
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:14:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B494360098;
 Thu, 25 Jun 2026 19:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C4A1F000E9;
 Thu, 25 Jun 2026 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782414866;
 bh=A9lgQxuWQNVFlAnIINX704uNJLif889+SUlDAHA75ME=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OaePTnd2eQRDiep6kyRrkoKfQuVN6005NPOKHqKkCGhvssFXwf81/aWFQ/LwdAU2g
 Qx5jV/FOQrp0GtpG0JDxPrXoilFu9gWOIk9oJ/HdukykTOe6TDH9Dw/bQfYj+AlGQu
 4NjothfBOpdMOX0Q52AwVOdQRsQyo3F0UcpDzPJ5t6CuJABwlsueYrxtaq0HjMqTUn
 xbd2oQ/oaxpdlt5jZZADprxpUki8AwJQHrpk5typocIwQs1vH+Lb7uLQPz9XrSGlPp
 OZDOb+aYhBfwkadUOU+311CeUFiUu75Ch1imMR5x53BuYh3GmAvRGfO7fFaAQ8biBN
 0Ubu6qjRWhHLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/nova: use `zerocopy` in booter.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260625190553.7245-4-niyudi.honda@usp.br>
References: <20260625190553.7245-1-niyudi.honda@usp.br>
 <20260625190553.7245-4-niyudi.honda@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:14:25 +0000
Message-Id: <20260625191426.10C4A1F000E9@smtp.kernel.org>
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
- [High] Firmware parsing uses native endianness for multi-byte fields, cau=
sing corruption on big-endian architectures.
--

commit c535dd221b00c3e53bf9b453add3e6be0eec80f6
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: use zerocopy in booter.rs

This commit replaces transmute::FromBytes with zerocopy::FromBytes
for firmware header parsing in firmware/booter.rs, and updates call sites
accordingly.

> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index d9313ac361af3..0cda2c50fbbe9 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs

[ ... ]

> @@ -53,7 +52,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], off=
set: usize) -> Result<S>
>  /// Such firmwares have an application-specific payload that needs to be=
 patched with a given
>  /// signature.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct HsHeaderV2 {
>      /// Offset to the start of the signatures.
>      sig_prod_offset: u32,

[Severity: High]
This is a pre-existing issue, but do these hardware firmware structures
need to use explicit little-endian types instead of native u32?

Since frombytes_at constructs instances directly from byte slices,
reading raw little-endian bytes into native u32 fields will result in
incorrect offsets and sizes on big-endian architectures. This affects
the HsHeaderV2 struct in drivers/gpu/nova-core/firmware/booter.rs.

[ ... ]

> @@ -145,6 +141,7 @@ fn signatures_iter(&'a self) -> Result<impl Iterator<=
Item =3D BooterSignature<'a>>
> =20
>  /// Signature parameters, as defined in the firmware.
>  #[repr(C)]
> +#[derive(FromBytes)]
>  struct HsSignatureParams {
>      /// Fuse version to use.
>      fuse_ver: u32,

[Severity: High]
This is a pre-existing issue, but does the HsSignatureParams struct in
drivers/gpu/nova-core/firmware/booter.rs also suffer from the same
endianness problem by using native u32 for firmware fields?

[ ... ]

> @@ -171,14 +165,14 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
>  /// Header for code and data load offsets.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct HsLoadHeaderV2 {
>      // Offset at which the code starts.
>      os_code_offset: u32,

[Severity: High]
This is a pre-existing issue, but does the HsLoadHeaderV2 struct in
drivers/gpu/nova-core/firmware/booter.rs need explicit endianness types
here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625190553.7245=
-1-niyudi.honda@usp.br?part=3D3
