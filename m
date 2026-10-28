Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D6606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoeniJd9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A1D10E618;
	Wed, 28 Oct 2026 13:36:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E14D10E618
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:36:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E50D6600C8;
 Wed, 28 Oct 2026 13:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD51F01825;
 Wed, 28 Oct 2026 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793194573;
 bh=tqnNgeIvZqP+AUctqvCLMUyeAmSu95507ajLQrIszAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KoeniJd9KomGARtzUiFOmdxypCt6tU+f7fBsJzJ+QIOzla6gQURYLOic0wq/yfQeL
 kM1DF+QuFwsLJdhuH4YhHJg7st7hGztzZQqucW5rxo0qPATuoRh6YEeRftNJLNixe1
 cmezjzP+AjhnbN7fmgonShXye+ts27RKE7ddvscPTeYfecjPitXS6AqkTKHVNJctPx
 /EouoBbLGt6HOx3qB2xIpXe25GBOncAsD4DLCjRmybAZZQb1gDVMeztWRsvA44ldRU
 UUrLlA72hTY54T2d3GHFsz8EIYRYiao0bD6S8PI19P4AT7SooYZVi24mkayYl5v3oH
 Kw5Nxu+U2u1pA==
Message-ID: <sashiko-outbox-187930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/imagination: Update RISC-V firmware header
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261028-prep-meta-fw-arch-independent-v1-3-73e116f02172@imgtec.com>
References: <20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com>
 <20261028-prep-meta-fw-arch-independent-v1-3-73e116f02172@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:36:13 +0000
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

commit eeabb2d4154441b38cbf731b40c5f4e3c830252e
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Update RISC-V firmware header

This commit introduces pvr_fw_riscv_internal.h with arch-independent
definitions and updates pvr_fw_riscv.c to include it in place of
pvr_rogue_riscv_internal.h.

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
The commit message notes that the header file is being renamed to
pvr_fw_riscv_internal.h, and drivers/gpu/drm/imagination/pvr_fw_riscv.c
(the only user of pvr_rogue_riscv_internal.h) is updated to include the new
header instead.

However, drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h is added as a
new file while drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h is
left in the tree (and is not removed by subsequent patches in the series,
commits 00700f5214fc and 350cb613ac62).

Should drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h be deleted as
part of this rename so it is not left behind as unused code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-prep-meta-=
fw-arch-independent-v1-0-73e116f02172@imgtec.com?part=3D3
