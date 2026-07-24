Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C43C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BF010F2E0;
	Fri, 24 Jul 2026 07:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iEVTmeYk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5369B10F2E1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:04:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E26141ACA;
 Fri, 24 Jul 2026 07:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F01F000E9;
 Fri, 24 Jul 2026 07:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784876649;
 bh=cqug0gSmu0S/YmV9S5gilUBdfTKh6ONdcLQ52WeN0YQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iEVTmeYk2Bdqm234kKGHV7Oio81P9KpX4ycz6zjZvtvRwA/kQvX0cK4t27ai78Ttd
 2UmWi0pK1WyGHUZL0sYYrXTvnLTfdI2pjThaRG3Ejoe9KlAXrTEWwVB3zyFXEoYVxU
 d6urkONnHAC5G/67chgm26DNvHW84YeeQr1HNItYfxL4jZor6HSopmV08xTrDWIReW
 luBwU44ye3a7mBxexr5MUBlx9/Pag/KL3i4lmoID2YRjblKqtjcSR2hd9MJpdwH1yt
 ze+Qii/afXffaynywtEwFn2hMplYeecSrmBCWqHBr9bGGTNGpZdPqLNr9TBwHCNY6i
 5oKTsEs6HMtKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] gpu: nova-core: rename heap size field
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-blackwell-fixes-v3-2-01aa6a54e3fd@nvidia.com>
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-2-01aa6a54e3fd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 07:04:08 +0000
Message-Id: <20260724070409.264F01F000E9@smtp.kernel.org>
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
- [High] Framebuffer layout calculations use raw subtraction on hardware-pr=
ovided values, leading to integer underflow if the hardware reports an insu=
fficient framebuffer size.
--

--- Patch [2]: [PATCH v3 2/5] gpu: nova-core: rename heap size field ---
commit 11d9ee61e9c07ef3fa88364b2849b70d424c5735
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: rename heap size field

This commit renames the heap field to non_wpr_heap in the nova-core driver's
framebuffer layout struct, unifying the naming convention.

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 273cff752fae7..1f7b6a69e4db8 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
[ ... ]
> @@ -251,9 +251,9 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gs=
p_fw: &GspFirmware) -> Resu
>              FbRange(wpr2_addr..frts.end)
>          };
> =20
> -        let heap =3D {
> -            let heap_size =3D u64::from(hal.non_wpr_heap_size());
> -            FbRange(wpr2.start - heap_size..wpr2.start)
> +        let non_wpr_heap =3D {
> +            let non_wpr_heap_size =3D u64::from(hal.non_wpr_heap_size());
> +            FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)

[Severity: High]
This isn't a bug introduced by this patch, but could this subtraction under=
flow
if the hardware reports a framebuffer size smaller than the required compon=
ents?

The layout calculations in FbLayout::new() sequentially subtract required
firmware region sizes from the total hardware-provided vidmem_size. For exa=
mple,
an earlier calculation does fb.end - NV_PRAMIN_SIZE, which would underflow =
if
the reported size is less than 1MB. Similarly, the subtraction
wpr2.start - non_wpr_heap_size here will underflow if the accumulated
allocations exceed the total vidmem_size.

Could this cause a panic in debug builds, or wrap to a very large offset in
release builds, leading to memory corruption or crashes when interacting wi=
th
untrusted or malfunctioning hardware?

>          };
> =20
>          Ok(Self {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-blackwell-=
fixes-v3-0-01aa6a54e3fd@nvidia.com?part=3D2
