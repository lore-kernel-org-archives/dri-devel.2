Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA940C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2393E10E85E;
	Tue,  4 Aug 2026 05:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZYVIzRCV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A9810E85E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:54:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D97F860A59;
 Tue,  4 Aug 2026 05:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445401F000E9;
 Tue,  4 Aug 2026 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785822881;
 bh=erOfPAyaIjQl0UKni/j0u12NlCY1unbKCZmNTKd0YhI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZYVIzRCV0LxASK4qPJ6cFUJO9yksQioKTAPPW+zXvVhuQ9Tf5uTx8o+H8rub6lRFD
 4U94UnVWtzQsb3me6S9F0WeugL0aw9J/PNRUB9f2NGEr9EfH0EQlg1QmobgMImSzt/
 5na/HyNYWwNv0mpGUO96uGQkXY/BTiTmT2R7pQV2JXSdDJn7NxrCdiJoyCZhB5fvaa
 590ouPMM8peX+NthgZtbF4v1oDG+4m2guEKnH026aOSlp9RhAVAPof3IpZFHHGBLSw
 vUxESy+YEQEuKVQ9+dxRF8Bcaa758C0kMieugD8vqpGK5X+SrULgoCYd/zWgp8alrB
 neRz2dimx2Q1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260804-blackwell-fixes-v4-1-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
 <20260804-blackwell-fixes-v4-1-ac858b6a1935@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 05:54:40 +0000
Message-Id: <20260804055441.445401F000E9@smtp.kernel.org>
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
- [Medium] The r570-specific 2 MiB alignment for the FRTS vidmem offset is =
incorrectly skipped if the PMU reserved size is zero.
--

--- Patch [1]: [PATCH v4 1/5] gpu: nova-core: correct FRTS vidmem offset ca=
lculation ---
commit 8aa662faea789e52a898638a43d6d0e165669003
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: correct FRTS vidmem offset calculation

This commit changes the calculation of the FRTS vidmem offset to use a
per-architecture reserved size plus the PMU reserved size, rather than
relying on coincidental matching with the non-wpr heap size.

> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index ba4544210e40f..a81b510282829 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -251,20 +251,31 @@ struct FspCotMessage {
>  }
> =20
>  impl FspCotMessage {
> +    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. =
It is measured backwards
> +    /// from the end of the framebuffer.
> +    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -=
> Result<u64> {
> +        let mut offset =3D u64::from(hal.fb_end_reserved_size());
> +
> +        if fb_layout.pmu_reserved_size !=3D 0 {
> +            offset =3D (offset + u64::from(fb_layout.pmu_reserved_size))
> +                // The 2 MiB alignment is r570-specific.
> +                .align_up(Alignment::new::<SZ_2M>())
> +                .ok_or(EINVAL)?;
> +        }

[Severity: Medium]
If fb_layout.pmu_reserved_size happens to be 0, this bypasses the 2 MiB
alignment entirely.=20

For platforms like GB100 or GB202 where hal.fb_end_reserved_size() is=20
SZ_2M + SZ_128K (which is unaligned), wouldn't this result in an unaligned
FRTS offset and potentially cause FSP boot failures?=20

Should the 2 MiB alignment step be performed unconditionally even when the=
=20
PMU reservation size is 0?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-blackwell-=
fixes-v4-0-ac858b6a1935@nvidia.com?part=3D1
