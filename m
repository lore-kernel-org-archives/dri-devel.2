Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E9C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B5910E6BB;
	Thu, 17 Sep 2026 09:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nS0LDMf8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B129210E6B6;
 Thu, 17 Sep 2026 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789638222; x=1821174222;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hT90yr46vIWAseLBHlTX1615zlQ9HOhd6Q0hde9I/lA=;
 b=nS0LDMf8OJPmawkSChx7Ws146ydt9mNc5r+8SVH/KEQYDsSWWbqNMl2p
 FPT8hu8ATesVJg3eFHTz3tbtFpINLHb4zdVrH0T1qBYQKz8zrUJPnrUgK
 c2tlSUuKIIF1EVhAIAzGhUIWMRXAfAPQP/OpFD8M4XiqAKy56FcnkGO1/
 hBhsn95cl7KqBiylP5XuZnaT2S2MiabjVMbuxoAGX74EzxTcVdkwYY73B
 QdO7SCRcyjkQ183ucdpq/qaotZwJt3OXtkWH4dTYV7WX4MHm5mRNRluFO
 dGX6YvsT21J8f4oytVpC8VdDb44nbPDdoVqc3yLLOY3KrKELvZ1mwQtqs Q==;
X-CSE-ConnectionGUID: KOeQiZecTemRVjC+XqOCyQ==
X-CSE-MsgGUID: LhA8nMDOQBSsXe61G4rpag==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115578462"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="115578462"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:43:41 -0700
X-CSE-ConnectionGUID: 2bmIONC0TQ6AyF05DrV3dw==
X-CSE-MsgGUID: jGm6IRlUSxiQTbAr72Vkrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="275634918"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:43:38 -0700
Date: Thu, 17 Sep 2026 11:43:36 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: Re: [PATCH i-g-t v6 4/9] lib/xe: Introduce dmem driver and implement
 Xe support
Message-ID: <20260917094336.o7fg5tcidio3tsb6@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-4-61dc62970fae@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-dmem_max-v6-4-61dc62970fae@igalia.com>
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

Hi Thadeu,
On 2026-09-03 at 19:00:26 -0300, Thadeu Lima de Souza Cascardo wrote:
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
>  lib/igt_dmem_driver.h | 34 ++++++++++++++++++
>  lib/meson.build       |  1 +
>  lib/xe/xe_dmem.c      | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
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

Please drop this include from header, and if needed move to .c lib.

Regards,
Kamil

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
>  	'igt_dsc.c',
>  	'igt_hook.c',
>  	'xe/xe_device.c',
> +	'xe/xe_dmem.c',
>  	'xe/xe_ggtt.c',
>  	'xe/xe_gt.c',
>  	'xe/xe_ioctl.c',
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
> -- 
> 2.47.3
> 
