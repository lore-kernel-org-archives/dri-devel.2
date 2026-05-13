Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47208CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE6310EF44;
	Wed, 13 May 2026 15:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CYQg+dBS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906BF10EF13;
 Wed, 13 May 2026 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778686006; x=1810222006;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cmuvuwQ96Oi2R63v/Ip5h+yUoy+F9BELqPW7NSZX3KU=;
 b=CYQg+dBSOjHATTWfAoOEQRV0FliSuifI2eSsc+5OplpP4MLK01CvaBJE
 5gHz5CmPT6cQDJMafeCcsAQNE1gy9FEBvheSiIHAuV6ZaS584ei4SjEOV
 4fRG9l0X9ZIZ0cy9hE24EmEd0vU+9pxmkE7eeXiy1JGi8Lm06HPYcZ4he
 gJ5QxSQW3NPJ9kMbz1OmMbDhsRBUSPwDav4iX7tFyGZHbexVoHb7h4b+D
 iABE3gk83vz9RJLgzUCvQcxsaT5Fgf6EIj0QsXva0RsbrDYhB9qBM3/cs
 aH9dH7tYHeLQfx/2kxolIfPa4vr7IlxlLxgfeh33pzsS23UDA6TOPfTfk A==;
X-CSE-ConnectionGUID: DMZlQ0HTTqu4MxaM7tDJIw==
X-CSE-MsgGUID: RTFbszVGQvmn63WFadXQyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90719091"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; d="scan'208";a="90719091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:26:25 -0700
X-CSE-ConnectionGUID: i9vxTfIzSdu2NJIfu9GnQg==
X-CSE-MsgGUID: d2Eg+FiCRlWUT3bF4DRNzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="276218566"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:26:22 -0700
Date: Wed, 13 May 2026 17:26:18 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: Re: [PATCH i-g-t 5/8] igt_dmem_driver: add amdgpu support
Message-ID: <20260513152618.2uuosi3cnrwl2gvc@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260512215156.4083082-1-cascardo@igalia.com>
 <20260512215156.4083082-6-cascardo@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512215156.4083082-6-cascardo@igalia.com>
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
On 2026-05-12 at 18:51:52 -0300, Thadeu Lima de Souza Cascardo wrote:
> Allocate a BO from VRAM domain. That will try to place BOs on VRAM, but may
> fallback to GTT. That can still be tracked with dmem.current.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  lib/amdgpu/amd_dmem.c    | 94 ++++++++++++++++++++++++++++++++++++++++

Why amd_dmem.c? Why this all cannot reside in core_cgroups.c?

+cc Vitaly
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

>  lib/igt_dmem_driver.h    |  1 +
>  lib/meson.build          |  1 +
>  tests/drv_dmem_cgroups.c |  6 ++-
>  4 files changed, 100 insertions(+), 2 deletions(-)
>  create mode 100644 lib/amdgpu/amd_dmem.c
> 
> diff --git a/lib/amdgpu/amd_dmem.c b/lib/amdgpu/amd_dmem.c
> new file mode 100644
> index 000000000000..1c0825af43b6
> --- /dev/null
> +++ b/lib/amdgpu/amd_dmem.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Valve Corporation
> + * Authors:
> + *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> + */
> +
> +#include "igt_dmem_driver.h"
> +
> +#include <errno.h>

Please make system includes first, then follow with igt ones, so:

#include <errno.h>

#include "igt.h"
#include "igt_cgroup.h"
#include "igt_dmem_driver.h"
#include "lib/amdgpu/amd_memory.h"

Regards,
Kamil

> +
> +#include "igt.h"
> +#include "igt_cgroup.h"
> +#include "lib/amdgpu/amd_memory.h"
> +
> +struct amdgpu_dmem_ctx {
> +	int fd;
> +	amdgpu_device_handle device;
> +	amdgpu_bo_handle *handles;
> +};
> +
> +static int amdgpu_dmem_init(void **ctx, int fd, int max_bo)
> +{
> +	struct amdgpu_dmem_ctx *actx;
> +	uint32_t major, minor;
> +	int err = -ENOMEM;
> +
> +	actx = malloc(sizeof(*actx));
> +	if (!actx)
> +		return -ENOMEM;
> +
> +	actx->handles = calloc(max_bo, sizeof(actx->handles[0]));
> +	if (!actx->handles)
> +		goto out;
> +
> +	err = amdgpu_device_initialize(fd, &major, &minor, &actx->device);
> +	if (err)
> +		goto out;
> +
> +	*ctx = actx;
> +
> +	return 0;
> +
> +out:
> +	if (actx->handles)
> +		free(actx->handles);
> +	free(actx);
> +
> +	return err;
> +}
> +
> +static void amdgpu_dmem_deinit(void *ctx)
> +{
> +	struct amdgpu_dmem_ctx *actx = ctx;
> +
> +	amdgpu_device_deinitialize(actx->device);
> +	free(actx->handles);
> +	free(actx);
> +}
> +
> +static int amdgpu_dmem_allocate_vram(void *ctx, int n_bo, size_t len)
> +{
> +	struct amdgpu_dmem_ctx *actx = ctx;
> +	amdgpu_bo_handle handle;
> +	int err;
> +
> +	err = amdgpu_bo_alloc_wrap(actx->device, len, 4096,
> +				   AMDGPU_GEM_DOMAIN_VRAM, 0, &handle);
> +	if (err)
> +		return err;
> +
> +	actx->handles[n_bo] = handle;
> +
> +	return 0;
> +}
> +
> +static void amdgpu_dmem_free_vram(void *ctx, int n_bo, size_t len)
> +{
> +	struct amdgpu_dmem_ctx *actx = ctx;
> +	int i;
> +	for (i = 0; i < n_bo; i++) {
> +		if (actx->handles[i])
> +			amdgpu_bo_free(actx->handles[i]);
> +	}
> +}
> +
> +const struct igt_dmem_driver amdgpu_dmem_driver = {
> +	.name = "amdgpu",
> +	.get_region_name = amdgpu_cgroup_region_name,
> +	.init = amdgpu_dmem_init,
> +	.deinit = amdgpu_dmem_deinit,
> +	.allocate_vram = amdgpu_dmem_allocate_vram,
> +	.free_vram = amdgpu_dmem_free_vram,
> +};
> diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
> index 869356fbf2c2..d43e5140d4f6 100644
> --- a/lib/igt_dmem_driver.h
> +++ b/lib/igt_dmem_driver.h
> @@ -20,5 +20,6 @@ struct igt_dmem_driver {
>  };
>  
>  extern const struct igt_dmem_driver xe_dmem_driver;
> +extern const struct igt_dmem_driver amdgpu_dmem_driver;
>  
>  #endif
> diff --git a/lib/meson.build b/lib/meson.build
> index 269f3b9f0af8..dd02d087875b 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -188,6 +188,7 @@ if libdrm_amdgpu.found()
>  		'amdgpu/amd_mmd_shared.c',
>  		'amdgpu/amd_jpeg_shared.c',
>  		'amdgpu/amd_utils.c',
> +		'amdgpu/amd_dmem.c',
>  		'amdgpu/amd_vcn_shared.c'
>  	]
>  	if libdrm_amdgpu.version().version_compare('> 2.4.99')
> diff --git a/tests/drv_dmem_cgroups.c b/tests/drv_dmem_cgroups.c
> index 6f4f779f3c2c..0e26b7e2bb9a 100644
> --- a/tests/drv_dmem_cgroups.c
> +++ b/tests/drv_dmem_cgroups.c
> @@ -116,8 +116,9 @@ static int fill_vram(const struct igt_dmem_driver *drv, void *ctx, int fd, int m
>  			break;
>  	}
>  
> -	igt_assert_f(err == -ENOMEM || err == -ENOSPC,
> -		     "Expected -ENOMEM or -ENOSPC, got %d (%s)\n",
> +	/* amdgpu will fallback to GTT if it cannot allocate on VRAM */
> +	igt_assert_f(err == -ENOMEM || err == -ENOSPC || err == 0,
> +		     "Expected -ENOMEM,-ENOSPC or success, got %d (%s)\n",
>  		     err, strerror(-err));
>  
>  	return n_bo;
> @@ -236,6 +237,7 @@ static const struct {
>  	const struct igt_dmem_driver *driver;
>  } drivers[] = {
>  	{ DRIVER_XE, &xe_dmem_driver },
> +	{ DRIVER_AMDGPU, &amdgpu_dmem_driver },
>  	{ },
>  };
>  
> -- 
> 2.47.3
> 
