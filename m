Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8652C5DF6D
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB5F10E31F;
	Sun, 16 Aug 2026 15:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eiTgSfvc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D80710E31F
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 15:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1A2540ADE;
 Sun, 16 Aug 2026 15:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A531F000E9;
 Sun, 16 Aug 2026 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786893577;
 bh=LIeyVlA0fSu4DtIkV7z3UXIm7mJ/AsPqYTSRD/W3Ocs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eiTgSfvcO3ZtcmbTVJqNIEtlxWDJkUtPO76xI6EBYa+vmjYBzBKzuKd+gxqaqgfEZ
 gNVSqJZ7KQZ6mjgGvFgMYkZXu8C2RnoSlwUzPV6Ba1DlyLaSOKzN6pRcf9uNY48Rlu
 fciq/3ENlnogoC7hNDzobvitzXMq2JoqahtIAtrpKtglk69T5CSNeiO8hXF7vyanl1
 S6pCZgIab0JXvsfEyCl+dK2a//Nztf4iHo8pELxUvePyZn2oY/5U+XZC0jfKYuMYOO
 UH7PdOMO8+78V411wFMxpVNjpNADmgt9v+mPaBLJoT4+z+TEwtk68EdevpZu5Ox6ZD
 ctjlrkoiWjT2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fpga: Add dma-buf interface for FPGA programming
To: "Aravind Thokala" <aravind.thokala@amd.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260816150734.2092802-2-aravind.thokala@amd.com>
References: <20260816150734.2092802-1-aravind.thokala@amd.com>
 <20260816150734.2092802-2-aravind.thokala@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 15:19:37 +0000
Message-Id: <20260816151937.98A531F000E9@smtp.kernel.org>
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
- [Critical] Passing a DMA-mapped dma-buf scatterlist to the FPGA manager c=
ore causes double-mapping or CPU access of device memory, triggering kernel=
 panics.
- [High] The FPGA_IOCTL_LOAD_DMA_BUF ioctl lacks a firmware size parameter,=
 causing the full page-aligned dma-buf capacity to be pushed into the FPGA =
port, corrupting configuration.
--

--- Patch [1]: [PATCH 1/2] fpga: Add dma-buf interface for FPGA programming=
 ---
commit 9a25ee19d33999a56fc7670a1a9dbec98cb947aa
Author: Aravind Thokala <aravind.thokala@amd.com>

fpga: Add dma-buf interface for FPGA programming

This commit adds a module that allows userspace to pass a pre-allocated DMA
buffer directly to the FPGA manager via ioctl. It creates a miscdevice for
each FPGA manager that registers dma-buf support to map and load the image
without an extra memory copy.

> diff --git a/drivers/fpga/fpga-dmabuf.c b/drivers/fpga/fpga-dmabuf.c
> new file mode 100644
> index 0000000000000..0e92eb1346981
> --- /dev/null
> +++ b/drivers/fpga/fpga-dmabuf.c

[ ... ]

> +static int fpga_dmabuf_load(struct fpga_manager *mgr, int buffd)
> +{
> +	struct fpga_image_info *info;
> +	struct dma_buf_attachment *attach;
> +	struct dma_buf *dmabuf;
> +	struct sg_table *sgt;
> +	int ret;

[ ... ]

> +	sgt =3D dma_buf_map_attachment_unlocked(attach, DMA_TO_DEVICE);
> +	if (IS_ERR(sgt)) {
> +		ret =3D PTR_ERR(sgt);
> +		goto err_detach;
> +	}
> +
> +	info->sgt =3D sgt;
> +
> +	ret =3D fpga_mgr_lock(mgr);
> +	if (ret)
> +		goto err_unmap;
> +
> +	ret =3D fpga_mgr_load(mgr, info);

[Severity: Critical]
Does passing a DMA-mapped sg_table into fpga_mgr_load() cause issues with t=
he
underlying FPGA manager drivers?

Hardware drivers typically expect an unmapped CPU sg_table and will call
dma_map_sgtable() on it. Calling dma_map_sgtable() on an already mapped
sg_table can overwrite DMA addresses and corrupt the DMA state.

Additionally, the core manager may fall back to CPU PIO to read the image
header via sg_miter (which internally uses kmap). If the dma-buf is backed
by P2P device memory, this could dereference invalid struct pages and cause
a kernel panic. It also bypasses cache coherency since
dma_buf_begin_cpu_access() is never called.

[ ... ]

> diff --git a/include/uapi/linux/fpga.h b/include/uapi/linux/fpga.h
> new file mode 100644
> index 0000000000000..868650c66526b
> --- /dev/null
> +++ b/include/uapi/linux/fpga.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * FPGA userspace API
> + *
> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
> + */
> +#ifndef _UAPI_LINUX_FPGA_H
> +#define _UAPI_LINUX_FPGA_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define FPGA_IOCTL_LOAD_DMA_BUF	_IOW('J', 1, __s32)

[Severity: High]
Since this IOCTL only takes a file descriptor (__s32), how does userspace
supply the exact payload size of the firmware?

In fpga_dmabuf_load(), the info struct is zero-allocated, leaving
info->data_size as 0. When fpga_mgr_buf_load_sg() evaluates the scatterlist,
if data_size is 0, it loops over the entire mapped capacity of the sg_table.

Because dma-bufs are typically page-aligned, will this result in writing
padding bytes at the end of the buffer directly into the FPGA configuration
port, potentially corrupting the hardware state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816150734.2092=
802-1-aravind.thokala@amd.com?part=3D1
