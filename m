Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC983606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chM2BVXp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9ADF10E774;
	Thu, 29 Oct 2026 06:34:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F8710E774
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:34:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BA91600DA;
 Thu, 29 Oct 2026 06:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24941F01825;
 Thu, 29 Oct 2026 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793255656;
 bh=YTb82r1SnKg8ltbh5vvd7ezpDkiikDp3aAeHZMwCZSE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=chM2BVXp8/7x1qpmWmU8izO0S0YFKXsTXiGLaSqqjs4dZwyUql/BYX7LGt9ID1GUx
 JzgjB+CcinT0D1mNrywAHSmwyXFsJkiJ9PSzQgwgJ33IDwT6g6uQQjp0Z58eCD6UFK
 XGEKgNWn4R2AX/2EM3KkR1vHW/rwfXCGAGuMbNHEwtp5llqeqSBEXsz8Uvh9rYb8XY
 6GR+SJyQ3ZXxkVdVyJ4zEXtGWfoaSwzvEP1LFXnOT1fuZ3EoTVHiQUfgf0k5e7Okyo
 EsftA9aOI61hdwBigJHodC7r6CAR5lhweOpq/tvMQT2U01ZmaSAMW5SM8ClMe3hG7U
 I3I0tUk+7RKyA==
Message-ID: <sashiko-outbox-188823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/imagination: Make the RISC-V firmware header
 arch-independent
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-prep-meta-fw-arch-independent-v2-3-b9f5d69b7a52@imgtec.com>
References: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
 <20261029-prep-meta-fw-arch-independent-v2-3-b9f5d69b7a52@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:34:15 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/imagination: leftover pvr_rogue_riscv_internal.h after header r=
ename
--

commit aa862385062c21d7cdb9dd94ddf176fd3c9475ba
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Make the RISC-V firmware header arch-independent

This commit introduces drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h
with architecture-independent PVR_RISCV* definitions and updates
drivers/gpu/drm/imagination/pvr_fw_riscv.c to use them instead of the
ROGUE_RISCV* definitions from pvr_rogue_riscv_internal.h.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm=
/imagination/pvr_fw_riscv.c
> index 0d4dd45520a9c..2b24c40bc20f9 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
> @@ -6,10 +6,10 @@
>  #include "pvr_fw_info.h"
>  #include "pvr_fw_mips.h"
>  #include "pvr_gem.h"
> +#define PVR_FW_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
> +#include "pvr_fw_riscv_internal.h"
> +#undef PVR_FW_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
>  #include "pvr_rogue_cr_defs.h"
> -#define PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
> -#include "pvr_rogue_riscv_internal.h"
> -#undef PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
>  #include "pvr_vm.h"

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h b/driver=
s/gpu/drm/imagination/pvr_fw_riscv_internal.h
> new file mode 100644
> index 0000000000000..abcbb4ef06fe1
> --- /dev/null
> +++ b/drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/* Copyright (c) 2024 Imagination Technologies Ltd. */
> +
> +#ifndef PVR_FW_RISCV_INTERNAL_H
> +#define PVR_FW_RISCV_INTERNAL_H

[Severity: Low]
The commit message states that this patch renames both the header file and
its contents, and drivers/gpu/drm/imagination/pvr_fw_riscv.c (the sole user
of pvr_rogue_riscv_internal.h) is updated to include
pvr_fw_riscv_internal.h instead.

However, drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h is added as a
new file while drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h
(guarded by PVR_ROGUE_RISCV_INTERNAL_H) is left behind in the tree with no
remaining users.

Should drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h be removed in
this commit as part of the rename?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-prep-meta-=
fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com?part=3D3
