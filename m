Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77916C79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7207B10FA22;
	Fri,  4 Sep 2026 10:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="muKof4HF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E7810FA21;
 Fri,  4 Sep 2026 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=M4gR6n655Akk0eh744erKi4INBzhKNt1ZcIsBSNBN/o=; b=muKof4HFomTg2v8DEK+I9rgMJ6
 H8viJh6mpiWTOaMy2LHCtCrhFTgkB03KoSgmchErFUpv/5wh37iJY5Vs2Zaau48beA2Nl7g8tIxlC
 RU6npqjij22rA1xgJk3J6ythMaYLyRt7Q+sMhW+fg5tU8oBAuVksieimpLkAH6FRT5bivShFxvSQ9
 gmCr00blj59kyYqzwrZtbRx09xtFySHi/ICUyJQ3bAM3anV82lnrw0z5X+ya7Ynm2odPDJvgljQQj
 KE0wLQqsrAwt121/NTz/G7/4YUUlnx7pr6x+wm2jPeSq5ru9SABB0wUe57zdax3EwBLnZw9GR1Lvv
 1DvPNCXg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x2Qkk-00Ep3M-Tx; Fri, 04 Sep 2026 12:02:34 +0200
Message-ID: <c0d3d82c-3b67-45b1-a146-fbacee8934d0@igalia.com>
Date: Fri, 4 Sep 2026 11:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v6 4/9] lib/xe: Introduce dmem driver and implement
 Xe support
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 kernel-dev@igalia.com
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-4-61dc62970fae@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-4-61dc62970fae@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 03/09/2026 23:00, Thadeu Lima de Souza Cascardo wrote:
> In order to be reuse the same dmem tests with multiple drivers, we need to
> abstract a few operations. That includes getting the region name, and
> allocating and releasing VRAM. As there is some initialization also when
> multiple allocations are done, also provide init and deinit functions.
> 
> The Xe implementation was based on the original operations from
> xe_cgroups.c written by Thomas Hellström. However, instead of doing a
> deferred backing, followed by a bind, it does a simple non-deferred GEM
> object creation on the VRAM region.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   lib/igt_dmem_driver.h | 34 ++++++++++++++++++
>   lib/meson.build       |  1 +
>   lib/xe/xe_dmem.c      | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 132 insertions(+)
> 
> diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
> new file mode 100644
> index 000000000000..e6998387eff9
> --- /dev/null
> +++ b/lib/igt_dmem_driver.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Valve Corporation
> + * Authors:
> + *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> + */
> +
> +#ifndef __IGT_DMEM_DRIVER_H__
> +#define __IGT_DMEM_DRIVER_H__
> +
> +#include <stdlib.h>
> +
> +/**
> + * struct igt_dmem_driver - vendor driver to allocate and free device memory
> + *
> + */
> +struct igt_dmem_driver {
> +	/** @name: Driver name */
> +	const char *name;
> +	/** @init: Initialize an opaque context given a DRM device fd */
> +	int (*init)(void **ctx, int fd);
> +	/** @deinit: Release resources associated with context */
> +	void (*deinit)(void *ctx);
> +	/** @get_region_name: Return expected region name at dmem cgroup files */
> +	char * (*get_region_name)(void *ctx);

Nit - mention it returns newly allocated memory caller must free?

But LGTM on the whole:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +	/** @allocate_vram: Allocate @len sized vram and return an opaque @handle */
> +	int (*allocate_vram)(void *ctx, size_t len, void **handle);
> +	/** @free_vram: Free vram associated with @handle */
> +	void (*free_vram)(void *ctx, void *handle);
> +};
> +
> +extern const struct igt_dmem_driver xe_dmem_driver;
> +
> +#endif
> diff --git a/lib/meson.build b/lib/meson.build
> index b7e1be61d844..022408ce6864 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -130,6 +130,7 @@ lib_sources = [
>   	'igt_dsc.c',
>   	'igt_hook.c',
>   	'xe/xe_device.c',
> +	'xe/xe_dmem.c',
>   	'xe/xe_ggtt.c',
>   	'xe/xe_gt.c',
>   	'xe/xe_ioctl.c',
> diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
> new file mode 100644
> index 000000000000..628c905997d4
> --- /dev/null
> +++ b/lib/xe/xe_dmem.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Valve Corporation
> + * Authors:
> + *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> + */
> +
> +#include <errno.h>
> +
> +#include "igt.h"
> +#include "igt_cgroup.h"
> +#include "igt_dmem_driver.h"
> +#include "xe_drm.h"
> +#include "xe/xe_ioctl.h"
> +#include "xe/xe_query.h"
> +
> +struct xe_dmem_ctx {
> +	int fd;
> +	uint64_t vram_region;
> +};
> +
> +static int xe_dmem_init(void **ctx, int fd)
> +{
> +	struct xe_dmem_ctx *xe_ctx;
> +	uint64_t region;
> +
> +	xe_ctx = malloc(sizeof(*xe_ctx));
> +	if (!xe_ctx)
> +		return -ENOMEM;
> +
> +	xe_ctx->vram_region = 0;
> +	/* Find first VRAM region */
> +	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
> +		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
> +			xe_ctx->vram_region = region;
> +			break;
> +		}
> +	}
> +	if (!xe_ctx->vram_region)
> +		goto out;
> +
> +	xe_ctx->fd = fd;
> +
> +	*ctx = xe_ctx;
> +
> +	return 0;
> +
> +out:
> +	free(xe_ctx);
> +
> +	return -ENOMEM;
> +}
> +
> +static void xe_dmem_deinit(void *ctx)
> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +
> +	free(xe_ctx);
> +}
> +
> +static char * xe_dmem_get_region_name(void *ctx)
> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +
> +	return xe_cgroup_region_name(xe_ctx->fd, xe_ctx->vram_region);
> +}
> +
> +static int xe_dmem_allocate_vram(void *ctx, size_t len, void **ret_handle)
> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +	uint32_t handle;
> +	int err;
> +
> +	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region, 0,
> +			     NULL, &handle);
> +	if (err)
> +		return err;
> +
> +	*ret_handle = (void *)(uintptr_t) handle;
> +	return 0;
> +}
> +
> +static void xe_dmem_free_vram(void *ctx, void *handle)
> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +
> +	gem_close(xe_ctx->fd, (uint32_t)(uintptr_t) handle);
> +}
> +
> +const struct igt_dmem_driver xe_dmem_driver = {
> +	.name = "xe",
> +	.get_region_name = xe_dmem_get_region_name,
> +	.init = xe_dmem_init,
> +	.deinit = xe_dmem_deinit,
> +	.allocate_vram = xe_dmem_allocate_vram,
> +	.free_vram = xe_dmem_free_vram,
> +};
> 

