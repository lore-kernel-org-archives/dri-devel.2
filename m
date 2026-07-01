Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E9EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7245910E0A3;
	Wed,  1 Jul 2026 17:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bk3Vki9B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54BB10E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:48:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BE2F436BE;
 Wed,  1 Jul 2026 17:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5F1F000E9;
 Wed,  1 Jul 2026 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782928128;
 bh=h8a+K6s/jMjvpVTiFtCO7ELhoRPk3OG5wGdTxkcqIlY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bk3Vki9B8yMu7rZW/KuF+EIRuWjm4guYekapUwPfNWzq5FUzKo4cmrioc1/vn6j3z
 oao6qA0z7Tl4rCdDlnQo0iGZNHMCkBXD3FlanI8IwQK82uKnBBicEIRzPZrQMKNpOI
 gwwS9vqWDVcF7OHHC8TuGlaFAY8G3e63sRodkLqja/9+C8ZuMdhB3NfOnAsAwzZREr
 C7lw8fZXGC2qugFYAL2L3CcsV5dz2tqo5/9FAop5tU32N5wRN6/PANB+0Jkh0AYJjR
 a5dbf0yGVlDkuxFaJDHbhQK3qUgwCx+1JSBKAMO3lyS1gGO0l1/+jHIfbBx2hLYbYZ
 pFbkks+Z0p/Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/nova: use `zerocopy` in fwsec.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260701174056.12604-4-niyudi.honda@gmail.com>
References: <20260701174056.12604-1-niyudi.honda@gmail.com>
 <20260701174056.12604-4-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 17:48:47 +0000
Message-Id: <20260701174848.07E5F1F000E9@smtp.kernel.org>
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
- [High] Firmware structures use native integer types (e.g., `u32`, `u64`, =
`u16`) instead of explicit little-endian types, which causes data corruptio=
n when parsing firmware metadata on big-endian architectures.
--

commit 5588d64059dd57b42b45063f16c1c4ba8ddc35f4
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: use zerocopy in fwsec.rs
   =20
In firmware/fwsec.rs, replace the following transmute traits with
their zerocopy equivalents:

- transmute::FromBytes -> zerocopy::FromBytes
- transmute::AsBytes -> zerocopy::IntoBytes
- add zerocopy::KnownLayout where necessary

Update call sites accordingly.

> diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-c=
ore/firmware/fwsec.rs
> index 95e0dd77746b0..1b75cdc02256c 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec.rs

[ ... ]

>  #[repr(C, packed)]
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes)]
>  struct FalconAppifV1 {
>      id: u32,
>      dmem_base: u32,
>  }

[Severity: High]
This is a pre-existing issue, but will this struct misinterpret the firmware
data on big-endian architectures?

The firmware is little-endian, but these fields use native u32 types. When
read_from_prefix() parses the little-endian bytes directly into native types
on a big-endian host, it will corrupt dmem_base and id.

This causes out-of-bounds calculations when using dmem_base as an offset,
leading to an EINVAL failure during driver initialization.

Since this patch migrates the code to use zerocopy, would it make sense to
update these structures to use zerocopy's endian-aware types (such as
zerocopy::byteorder::little_endian::U32) instead of native integers?

[ ... ]

> -#[derive(Debug)]
> +#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  #[repr(C, packed)]
>  struct FalconAppifDmemmapperV3 {
>      signature: u32,
>      os_code_offset: u32,
>      os_code_size: u32,

[Severity: High]
This is a pre-existing issue, but does this struct also need endian-aware
types for its u32 fields to prevent data corruption during parsing on
big-endian hosts?

[ ... ]

> -#[derive(Debug)]
> +#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  #[repr(C, packed)]
>  struct ReadVbios {
>      ver: u32,
>      hdr: u32,
>      addr: u64,

[Severity: High]
This is a pre-existing issue, but does this struct also need endian-aware
types for its native u32 and u64 fields?

[ ... ]

> -#[derive(Debug)]
> +#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  #[repr(C, packed)]
>  struct FrtsRegion {
>      ver: u32,
>      hdr: u32,
>      addr: u32,

[Severity: High]
This is a pre-existing issue, but will this command structure send corrupted
coordinates to the firmware if written from a big-endian architecture?

It appears to use native u32 types instead of little-endian types.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701174056.1260=
4-1-niyudi.honda@gmail.com?part=3D3
