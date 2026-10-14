Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA71CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BE810FC00;
	Wed, 14 Oct 2026 08:34:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E458210FC00
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4239560213;
 Wed, 14 Oct 2026 08:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12D51F000FF;
 Wed, 14 Oct 2026 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791966887;
 bh=g/A4ed/3QPIKe4S9VB4gI6vDlsl4j9J8jt6fuk/31j4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L101eVtUXOWsV/CSblrUcKEhXkqPmo/R1nfjzmI47uGg1mnzv1o6odOghy7YBtT+R
 QjKigACg17T2DN6vrrtGFIXtx5XdS2tSugXxs0WmWfUlwQk8vKUlwwQskxiReXw92P
 ZREkVO6Cm6uiRrvXeFn1zqvSko5FydK7YH0oj9dwVf0PeK4A1k+gv4RYz0OcK0LnEC
 N72QHATxLaAYl8X2ZrN1ChQTfLGn/INkmoHZJR9tDqy623Ql2QoxNtl2Rw302cC/Ss
 BXe9nxGcG+o8rffFtXoOh17SZEcUqPV0cQiOwdY0Zt1aF8bntIa1h+JdGo6jsCpjAB
 yCM3/r5oZJlJA==
Message-ID: <sashiko-outbox-171019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/imagination: Simplify MIPS PTE definitions
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-b4-simplify-mips-pte-defs-v1-4-b4ad7bb68e22@imgtec.com>
References: <20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com>
 <20261014-b4-simplify-mips-pte-defs-v1-4-b4ad7bb68e22@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:34:46 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm: PTE state consistency violation in get_mips_pte_flags() for =
write-only mappings
- [Low] drm/imagination: Broken macro reference in PVR_MIPSFW_TLB_GET_PA
--

commit a6fd7c6870a5757f18024650beba88d0d531dd3a
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Simplify MIPS PTE definitions

This commit simplifies the MIPS PTE format definitions by using BIT() and
GENMASK() macros. It also removes some unused definitions that add no value.

> diff --git a/drivers/gpu/drm/imagination/pvr_mips_internal.h b/drivers/gp=
u/drm/imagination/pvr_mips_internal.h
> index 732730d64bf54..2b25a69003b31 100644
> --- a/drivers/gpu/drm/imagination/pvr_mips_internal.h
> +++ b/drivers/gpu/drm/imagination/pvr_mips_internal.h
[ ... ]
> -/* Mask used for the MIPS Page Table in case of physical bus on more tha=
n 32 bit. */
> -#define PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT (0x3FFFFFC0)
[ ... ]
> +#define PVR_MIPSFW_ENTRYLO_PFN_ABOVE_32BIT GENMASK_U32(29, 6)

[Severity: Low]
Could this deletion break compilation for PVR_MIPSFW_TLB_GET_PA()?

While the macro PVR_MIPSFW_TLB_GET_PA() isn't used in this patch, it still
references the deleted PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT constant in
drivers/gpu/drm/imagination/pvr_mips_internal.h:

#define PVR_MIPSFW_TLB_GET_PA(entry_lo) (((u64)(entry_lo) & \
					  PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT) << 6)

Leaving a broken macro with an undeclared identifier could cause an immedia=
te
compilation failure if any future code attempts to use it.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/=
imagination/pvr_vm_mips.c
> index 40495b1486a26..7f49314bc6be4 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
[ ... ]
> @@ -145,15 +147,15 @@ get_mips_pte_flags(bool read, bool write, u32 cache=
_policy)
>  	u32 flags =3D 0;
> =20
>  	if (read && write) /* Read/write. */
> -		flags |=3D PVR_MIPSFW_ENTRYLO_DIRTY_EN;
> +		flags |=3D PVR_MIPSFW_ENTRYLO_DIRTY;
>  	else if (write)    /* Write only. */
> -		flags |=3D PVR_MIPSFW_ENTRYLO_READ_INHIBIT_EN;
> +		flags |=3D PVR_MIPSFW_ENTRYLO_READ_INHIBIT;

[Severity: Medium]
Will this construct a non-writable mapping for write-only pages?

For MIPS hardware, the DIRTY bit functions as the hardware write-enable bit,
and a writable PTE must have this bit set; otherwise, any store operation
triggers a TLB Modified exception.

In this write-only branch in get_mips_pte_flags(), the code sets
PVR_MIPSFW_ENTRYLO_READ_INHIBIT but fails to set PVR_MIPSFW_ENTRYLO_DIRTY.
This will cause firmware writes to these pages to trap and crash the
firmware. Should this branch also set the DIRTY bit?

>  	else
>  		WARN_ON(!read);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-simplif=
y-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com?part=3D4
