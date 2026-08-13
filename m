Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30458C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DECC10F323;
	Thu, 13 Aug 2026 13:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="DznBg7uA";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A225310F31E
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:13:56 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so492882f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1786626835; x=1787231635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MPyU5ZJiB+TH6nScuEMS6HFMIAgdMXUb5U4J4ksDT3I=;
 b=DznBg7uAq5foiXSeTmJUhVPJJ2/YvJsk/6LaknGda1XRkqRGJ3uuMqb2ZNHRgzWNsI
 p3j4ndfR3KO/5s3IsTU+fjzGsgP5jikvHCvkeADGEhT0RVq1QcCARU60BlHnIGM8T10M
 ChIz9j2+1mPZnSNdqM+X1rhKfvPSCka7Ap8TYOEiBqtj5KinGwY5T44Kl2gxCsfK2A+4
 BstAD//3usfue/TwNLM+16VJYmw7obHr4HQDxz4zExcANE6EV5tUlVn5w2vF9zxKdlV9
 Nx6ncv2uVk5MrzIXIphJJ1rRM/SwwpKOmY/1HpfUe6rj57Uqb6gDZrlt366i0mhMpVky
 xaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786626835; x=1787231635;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MPyU5ZJiB+TH6nScuEMS6HFMIAgdMXUb5U4J4ksDT3I=;
 b=jZ726f9wiVhZhzfAIJG1VJzZRdtzLeNghC+Ny4/h6q/H+5Nl7Bz+GMidbWInHYXhwv
 c12xluABG5k80L36/xzhzaldnnWZ+uq3pboDn+yIv7JT9MzIBtN0xYILRJ1P/axuaouK
 Lo5nAvgsI1UBPYwTmFmGdmgTMv8jmwS8cSxb5t6pvSslcLQTQRY8enPHckxBByThgkAD
 s8+Mrc4iN6JBkQNUXyZtsE65V6eFkvmio5pHeXk4SSn+Zl6KKByyCLZprIR2q+YObtZs
 8/bFJAnducYiwMZMbOfRb7KXfSCY/g4v3edBTuZ2MesMg5GWyqL3t890nRd3Fq2hQAJh
 /OyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgP5qH9CYq4O7xRk1kxFSc2Ia+lP2Mbh7F8/VVF82a0B13kCeF2QrM7Arij6OxwqSXQrGNvvtoPIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvHa7UQAejP4p277fjAEGjW9QYVlEmgQHe4yQ5fGimQDuo9+tC
 BJ+I/Nurms1HRjtgtWuaAX6sBhrhiYYZZGLewpi+23z1dvEg4Zvr3A7PomFbOJb78MU=
X-Gm-Gg: AR+sD10Pmx5nL1VkG4f0jbSJKiUOwKKrieGn6B5/1HIv2Vj7h9wO9vNrFAl6rFvdMdF
 g2XI8we1u9c9ej1ou5IyapPbjoNyhmg9qyOfskQ6h6K9l4wgI+c3MVZJ14LGrFS7V32t60btGe+
 iaundWfhzz1kXWmoRIcDerJjcpXaSWEuP53Gp5PELX7Qh49NkFDJ07e5OpakBfcI4ryxanVNqfm
 iJaRy9E5r1ufzUABjq0aISA9BQmOjZ5WuPHYQsvC0alM2cSaWlM+N51VoG8qXlVg+qtueqGRGBa
 zej8+lnEbHl/vXGEx81E4M9gIpps4rQSC8ZeXHQ7i6c33O4OqM33AU+kfr/2jBSagYAmKeBHPIh
 PWwBPG9lQrmpK0vJyPS1g064B+cDcVPaKN40LmXypYNhcN3p6ArBHbrTdhtRXKHsgf/R4pgHFMT
 lcWzTqhqps+5ceR5o9rWu2eiSloJJTfhw1of59PgU8C/Bzl1dsVyTQAwf0kE19suAIDyCcGUIY7
 Ra/limJU49Cfec=
X-Received: by 2002:a5d:530e:0:b0:47f:5ec2:d54 with SMTP id
 ffacd0b85a97d-48159ccd3ccmr6423946f8f.5.1786626834819; 
 Thu, 13 Aug 2026 06:13:54 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5c2308sm7097101f8f.33.2026.08.13.06.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 06:13:54 -0700 (PDT)
Message-ID: <92009e34-6467-4a78-a3fc-32a39b381f55@ursulin.net>
Date: Thu, 13 Aug 2026 14:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v5 4/7] lib/xe: Introduce dmem driver and implement
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
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
References: <20260723194313.2748143-1-cascardo@igalia.com>
 <20260723194313.2748143-5-cascardo@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260723194313.2748143-5-cascardo@igalia.com>
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


On 23/07/2026 20:43, Thadeu Lima de Souza Cascardo wrote:
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
>   lib/igt_dmem_driver.h |  24 ++++++++
>   lib/meson.build       |   1 +
>   lib/xe/xe_dmem.c      | 139 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 164 insertions(+)
>   create mode 100644 lib/igt_dmem_driver.h
>   create mode 100644 lib/xe/xe_dmem.c
> 
> diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
> new file mode 100644
> index 000000000000..2f4a4673ab16
> --- /dev/null
> +++ b/lib/igt_dmem_driver.h
> @@ -0,0 +1,24 @@
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
> +struct igt_dmem_driver {
> +	const char *name;
> +	char * (*get_region_name)(int fd);
> +	int (*init)(void **ctx, int fd, int max_bo);
> +	void (*deinit)(void *ctx);
> +	int (*allocate_vram)(void *ctx, int n_bo, size_t len);
> +	void (*free_vram)(void *ctx, int n_bo);

I expect IGT maintainers might ask for kerneldoc for these.

> +};
> +
> +extern const struct igt_dmem_driver xe_dmem_driver;
> +
> +#endif
> diff --git a/lib/meson.build b/lib/meson.build
> index 868220408f8c..012802475de0 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -126,6 +126,7 @@ lib_sources = [
>   	'igt_msm.c',
>   	'igt_dsc.c',
>   	'igt_hook.c',
> +	'xe/xe_dmem.c',
>   	'xe/xe_gt.c',
>   	'xe/xe_ioctl.c',
>   	'xe/xe_legacy.c',
> diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
> new file mode 100644
> index 000000000000..1dec8cf8b0a1
> --- /dev/null
> +++ b/lib/xe/xe_dmem.c
> @@ -0,0 +1,139 @@
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
> +static char * xe_dmem_get_region_name(int fd)
> +{
> +	uint64_t vram_region = 0;
> +	uint64_t region;
> +	char *cg_region;
> +
> +	/* Find first VRAM region */
> +	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
> +		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
> +			vram_region = region;
> +			break;
> +		}
> +	}

FWIW it looks like that from here..

> +	if (!vram_region)
> +		return NULL;
> +
> +	cg_region = xe_cgroup_region_name(fd, vram_region);
> +
> +	return cg_region;

.. to here could be simplified as return xe_cgroup_region_name(...), 
given the helper returns NULL for non-VRAM regions. Or even return 
straight from the above loop instead of the break. Up to you which of 
the three options you prefer, just thinking out loud.

> +}
> +
> +struct xe_bo {
> +	uint32_t handle;
> +	size_t len;
> +};
> +
> +struct xe_dmem_ctx {
> +	int fd;
> +	struct xe_bo *bos;
> +	uint64_t vram_region;
> +	int max_bo;
> +};
> +
> +static int xe_dmem_init(void **ctx, int fd, int max_bo)
> +{
> +	struct xe_dmem_ctx *xe_ctx;
> +	uint64_t region;
> +
> +	xe_ctx = malloc(sizeof(*xe_ctx));
> +	if (!xe_ctx)
> +		return -ENOMEM;
> +
> +	xe_ctx->bos = calloc(max_bo, sizeof(xe_ctx->bos[0]));
> +	if (!xe_ctx->bos)
> +		goto out;
> +	memset(xe_ctx->bos, 0, max_bo * sizeof(xe_ctx->bos[0]));

calloc already zeroes the memory.

> +	xe_ctx->max_bo = max_bo;

Could the need for max_bo input parameter be avoided if the arrays were 
allocated in chunks and grown? More complex implementation but a simpler 
API.

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
> +	if (xe_ctx->bos)
> +		free(xe_ctx->bos);
> +	free(xe_ctx);
> +
> +	return -ENOMEM;
> +}
> +
> +static void xe_dmem_deinit(void *ctx)
> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +
> +	free(xe_ctx->bos);
> +	free(xe_ctx);

Handle cleanup is not desirable?

> +}
> +
> +static int xe_dmem_allocate_vram(void *ctx, int n_bo, size_t len)

Is the last patch in the series the only user of this API? I am thinking 
whether the n_bo input parameter is required and it wouldn't be simpler 
to just return a handle (or null) and grow the internal count. Ie. is 
there a use case for callers to precisely need to control "allocate/free 
at this index"?

> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +	uint32_t handle;
> +	int err;
> +
> +	if (n_bo >= xe_ctx->max_bo)
> +		return -ENOMEM;

If the max_bo approach remains, I'd be tempted to igt_assert here since 
it is a test writer error to hit it.

Also, return error if a valid handle is already at the requested index?

> +
> +	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region, 0,
> +			     NULL, &handle);
> +	if (err)
> +		goto out;
> +
> +	xe_ctx->bos[n_bo].handle = handle;
> +	xe_ctx->bos[n_bo].len = len;
> +
> +out:
> +	return err;
> +}
> +
> +static void xe_dmem_free_vram(void *ctx, int n_bo)
> +{
> +	struct xe_dmem_ctx *xe_ctx = ctx;
> +	size_t len;
> +	if (n_bo >= xe_ctx->max_bo)
> +		return;

Same assert or not comment as above.

> +	len = xe_ctx->bos[n_bo].len;
> +	if (len) {
> +		gem_close(xe_ctx->fd, xe_ctx->bos[n_bo].handle);
> +		xe_ctx->bos[n_bo].len = 0;
> +	}

It looks like the len local is superflous and handle also needs clearing.

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

Regards,

Tvrtko

