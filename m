Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD09C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5ED910E169;
	Fri,  4 Sep 2026 10:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SYJWhHJx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACBA10E169;
 Fri,  4 Sep 2026 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=hEI++qg2XaVSpdPRcw3c9ZofFCQ9pwoV4Af+mNZye+g=; b=SYJWhHJxaqvz3o2nQZQv8TL2qv
 eQvdONrf1t1S9SWbwG1H9ElkXSRMDAZTK1nNgNVaqtJ/WwbRlj311rJLHZPN9yCR8nlHjL+NegFc4
 BxcyN8WEZdyzunuv1ROUAjAmsaWMLmr1JB6QdsJ/EfoMYS3UUE90ryOZG6hN3lIGOp9DSp+vqzNQ3
 qC1CHIA188Qco7kv06uvocqtFwgDXsTvjf4Lmz7iTw17F3J014giUIaOlmMNQOh1d8KhMhnG2hcC9
 ygM2+FkQIqvfjOh80IlWi6g3cAN406aZjbq+pLrbLfLK6F3mwqlBuF81OMaVder6a2X6Wn9IYF1Wl
 tSElaZQQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x2QtG-00EpJO-LF; Fri, 04 Sep 2026 12:11:22 +0200
Message-ID: <33fabbd4-d87b-440d-b5f8-3b9be9618d7b@igalia.com>
Date: Fri, 4 Sep 2026 11:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v6 6/9] lib/amdgpu: add amdgpu support to
 igt_dmem_driver
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
 <20260903-dmem_max-v6-6-61dc62970fae@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-6-61dc62970fae@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> This allows dmem cgroups tests to run on top of amdgpu driver, adding
> support to allocate and release VRAM memory.
> 
> This does this by allocating a BO from VRAM domain, which will try to
> place BOs on VRAM, but may fallback to GTT.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   lib/amdgpu/amd_dmem.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   lib/igt_dmem_driver.h |  1 +
>   lib/meson.build       |  1 +
>   3 files changed, 92 insertions(+)
> 
> diff --git a/lib/amdgpu/amd_dmem.c b/lib/amdgpu/amd_dmem.c
> new file mode 100644
> index 000000000000..cb0fed4b870a
> --- /dev/null
> +++ b/lib/amdgpu/amd_dmem.c
> @@ -0,0 +1,90 @@
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
> +#include "lib/amdgpu/amd_memory.h"
> +
> +struct amdgpu_dmem_ctx {
> +	int fd;
> +	amdgpu_device_handle device;
> +};
> +
> +static int amdgpu_dmem_init(void **ctx, int fd)
> +{
> +	struct amdgpu_dmem_ctx *actx;
> +	uint32_t major, minor;
> +	int err;
> +
> +	actx = malloc(sizeof(*actx));
> +	if (!actx)
> +		return -ENOMEM;
> +
> +	err = amdgpu_device_initialize(fd, &major, &minor, &actx->device);
> +	if (err)
> +		goto out;
> +
> +	actx->fd = fd;
> +
> +	*ctx = actx;
> +
> +	return 0;
> +
> +out:
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
> +	free(actx);
> +}
> +
> +static char * amdgpu_dmem_get_region_name(void *ctx)
> +{
> +	struct amdgpu_dmem_ctx *actx = ctx;
> +
> +	return amdgpu_cgroup_region_name(actx->fd);
> +}
> +
> +static int amdgpu_dmem_allocate_vram(void *ctx, size_t len, void **ret_handle)
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
> +	if (ret_handle)
> +		*ret_handle = (void *) handle;

Is there an use case for ret_handle == NULL? Xe backend does not bother 
with the check. This aside, the rest looks good to me:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +
> +	return 0;
> +}
> +
> +static void amdgpu_dmem_free_vram(void *ctx, void *handle)
> +{
> +	amdgpu_bo_free(handle);
> +}
> +
> +const struct igt_dmem_driver amdgpu_dmem_driver = {
> +	.name = "amdgpu",
> +	.get_region_name = amdgpu_dmem_get_region_name,
> +	.init = amdgpu_dmem_init,
> +	.deinit = amdgpu_dmem_deinit,
> +	.allocate_vram = amdgpu_dmem_allocate_vram,
> +	.free_vram = amdgpu_dmem_free_vram,
> +};
> diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
> index e6998387eff9..f2d9d74196db 100644
> --- a/lib/igt_dmem_driver.h
> +++ b/lib/igt_dmem_driver.h
> @@ -30,5 +30,6 @@ struct igt_dmem_driver {
>   };
>   
>   extern const struct igt_dmem_driver xe_dmem_driver;
> +extern const struct igt_dmem_driver amdgpu_dmem_driver;
>   
>   #endif
> diff --git a/lib/meson.build b/lib/meson.build
> index 022408ce6864..e191793f0097 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -205,6 +205,7 @@ if libdrm_amdgpu.found()
>   		'amdgpu/amd_mmd_shared.c',
>   		'amdgpu/amd_jpeg_shared.c',
>   		'amdgpu/amd_utils.c',
> +		'amdgpu/amd_dmem.c',
>   		'amdgpu/amd_vcn_shared.c'
>   	]
>   	if libdrm_amdgpu.version().version_compare('> 2.4.99')
> 

