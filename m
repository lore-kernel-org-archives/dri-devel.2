Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB3C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE3110E85C;
	Tue,  4 Aug 2026 05:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="euAJBRow";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A728310E85C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:51:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BD9A42E74;
 Tue,  4 Aug 2026 05:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F0E1F00A3A;
 Tue,  4 Aug 2026 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785822668;
 bh=GBGK6NV2vrhYJb7GUat2PgUBxp3wVME4rZw1vauWw2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=euAJBRow0/Jc0S/w5zK6KgCqCST5aoe/tIfH2RCU7KHFKMgzpljOmmpunPiO4WB5I
 03rjnb4kgVrarl2S8iXG67GaRot8Qdw17ox2rOp3muI8iJ2+y/hSgiHo9v3n9iZnn+
 EoTWspqMWhYhzMTgJuJGmhUZvNQ5Wy8p8LJHp7J72KWRQoLvsCMUkXDTatRzTETVc8
 90CKL2KqOAxLgaqEqMKHdCwLiuiQc1lVFoFz1dhcQt9KfrqHI6d6rmCHiu4cTgvuHm
 kb8qFM+5ax93aRowqwTcgFb8D6lBE4uUkfI6StTcTAxUqp7dBHMeuEE2WqeubmBaZZ
 XHsecrFYn68wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] gpu: nova-core: return non-WPR heap size as u64
 from HALs
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260804-blackwell-fixes-v4-3-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
 <20260804-blackwell-fixes-v4-3-ac858b6a1935@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 05:51:07 +0000
Message-Id: <20260804055107.C7F0E1F00A3A@smtp.kernel.org>
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
- [High] Unchecked subtractions during framebuffer layout calculation can u=
nderflow if the hardware reports a small framebuffer size, causing a kernel=
 panic or out-of-bounds memory calculations.
--

--- Patch [3]: [PATCH v4 3/5] gpu: nova-core: return non-WPR heap size as u=
64 from HALs ---
commit cfb0bee1c128905c124d8b00afa2860ab971ac23
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: return non-WPR heap size as u64 from HALs

This patch updates the HALs to return the non-WPR heap size as a u64 to avo=
id
an immediate cast.

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 4a1be29cf5fbd..86d2bdaab7f95 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -271,7 +271,7 @@ pub(crate) fn new(
>          };
> =20
>          let non_wpr_heap =3D {
> -            let non_wpr_heap_size =3D u64::from(hal.non_wpr_heap_size());
> +            let non_wpr_heap_size =3D hal.non_wpr_heap_size();
>              FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)

[Severity: High]
This isn't a bug introduced by this patch, but can this subtraction underfl=
ow if
the hardware reports an unexpectedly small framebuffer size?

Looking at FbLayout::new() in drivers/gpu/nova-core/fb.rs, there are multip=
le
places where sizes are subtracted from addresses without using checked_sub(=
),
such as:

    let base =3D fb.end - NV_PRAMIN_SIZE;
    ...
    let frts_base =3D vga_workspace.start.align_down(FRTS_DOWN_ALIGN) - frt=
s_size;
    ...
    let bootloader_base =3D (frts.start - bootloader_size).align_down(BOOTL=
OADER_DOWN_ALIGN);
    ...
    let elf_addr =3D (boot.start - elf_size).align_down(ELF_DOWN_ALIGN);
    ...
    let wpr2_addr =3D (wpr2_heap.start - u64::from_safe_cast(size_of::<gsp:=
:GspFwWprMeta>()))

Could these calculations trigger a kernel panic (with overflow checks enabl=
ed) or
result in out-of-bounds memory calculations if a small hardware-provided si=
ze is
used during initialization?

>          };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-blackwell-=
fixes-v4-0-ac858b6a1935@nvidia.com?part=3D3
