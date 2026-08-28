Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77949C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF21910F337;
	Fri, 28 Aug 2026 10:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JWldRtxR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0423010E237;
 Fri, 28 Aug 2026 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=EPUkeekr+NdH9Da1Q0+Tpm7Tj1ijd4zYuumEIrswkTg=; b=JWldRtxRG/+1o9zuT5IHIQCWC/
 26iezNR4ue04QKooYxvWP1VNZSefPn1owLWoWH0dpcgSi+gHzIJWz5Jm+rOj5RhxQ5/PCMsYWjdqK
 4B9xt+GRS4KWyaj5x6GkiwyKV3pIu+jY+wqw1kjfcxKA+OAiILfjF/Vjeop+DOsvYwZ02nJ+ei2xQ
 I8cJqmVYba7FbY+hqkmw2jSknThKSyJEcUnYlXyFdSH0ccfd/bvnFQ0cT5Jnjq9UzCKV99R1wYQlL
 e/H68Uk6wPe9xThlbXXlet8Mqq67enO+UxNx78dranHULv6hCa5lScIApmt+aR6Rck6q+V9bnNrA1
 laNW+OTg==;
Received: from 179-125-75-211-dinamico.pombonet.net.br ([179.125.75.211]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wzu8N-00Aoa7-3e; Fri, 28 Aug 2026 12:48:31 +0200
Date: Fri, 28 Aug 2026 07:48:24 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: Re: [PATCH i-g-t v5 4/7] lib/xe: Introduce dmem driver and implement
 Xe support
Message-ID: <apFneOggwhqZWsIJ@quatroqueijos.cascardo.eti.br>
References: <20260723194313.2748143-1-cascardo@igalia.com>
 <20260723194313.2748143-5-cascardo@igalia.com>
 <92009e34-6467-4a78-a3fc-32a39b381f55@ursulin.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92009e34-6467-4a78-a3fc-32a39b381f55@ursulin.net>
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

On Thu, Aug 13, 2026 at 02:13:53PM +0100, Tvrtko Ursulin wrote:
> 
> On 23/07/2026 20:43, Thadeu Lima de Souza Cascardo wrote:
> > In order to be reuse the same dmem tests with multiple drivers, we need to
> > abstract a few operations. That includes getting the region name, and
> > allocating and releasing VRAM. As there is some initialization also when
> > multiple allocations are done, also provide init and deinit functions.
> > 
> > The Xe implementation was based on the original operations from
> > xe_cgroups.c written by Thomas Hellström. However, instead of doing a
> > deferred backing, followed by a bind, it does a simple non-deferred GEM
> > object creation on the VRAM region.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >   lib/igt_dmem_driver.h |  24 ++++++++
> >   lib/meson.build       |   1 +
> >   lib/xe/xe_dmem.c      | 139 ++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 164 insertions(+)
> >   create mode 100644 lib/igt_dmem_driver.h
> >   create mode 100644 lib/xe/xe_dmem.c
> > 
> > diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
> > new file mode 100644
> > index 000000000000..2f4a4673ab16
> > --- /dev/null
> > +++ b/lib/igt_dmem_driver.h
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright 2026 Valve Corporation
> > + * Authors:
> > + *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > + */
> > +
> > +#ifndef __IGT_DMEM_DRIVER_H__
> > +#define __IGT_DMEM_DRIVER_H__
> > +
> > +#include <stdlib.h>
> > +
> > +struct igt_dmem_driver {
> > +	const char *name;
> > +	char * (*get_region_name)(int fd);
> > +	int (*init)(void **ctx, int fd, int max_bo);
> > +	void (*deinit)(void *ctx);
> > +	int (*allocate_vram)(void *ctx, int n_bo, size_t len);
> > +	void (*free_vram)(void *ctx, int n_bo);
> 
> I expect IGT maintainers might ask for kerneldoc for these.
> 

Will do that in the next version, thanks for pointing that out.

> > +};
> > +
> > +extern const struct igt_dmem_driver xe_dmem_driver;
> > +
> > +#endif
> > diff --git a/lib/meson.build b/lib/meson.build
> > index 868220408f8c..012802475de0 100644
> > --- a/lib/meson.build
> > +++ b/lib/meson.build
> > @@ -126,6 +126,7 @@ lib_sources = [
> >   	'igt_msm.c',
> >   	'igt_dsc.c',
> >   	'igt_hook.c',
> > +	'xe/xe_dmem.c',
> >   	'xe/xe_gt.c',
> >   	'xe/xe_ioctl.c',
> >   	'xe/xe_legacy.c',
> > diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
> > new file mode 100644
> > index 000000000000..1dec8cf8b0a1
> > --- /dev/null
> > +++ b/lib/xe/xe_dmem.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright 2026 Valve Corporation
> > + * Authors:
> > + *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > + */
> > +
> > +#include <errno.h>
> > +
> > +#include "igt.h"
> > +#include "igt_cgroup.h"
> > +#include "igt_dmem_driver.h"
> > +#include "xe_drm.h"
> > +#include "xe/xe_ioctl.h"
> > +#include "xe/xe_query.h"
> > +
> > +static char * xe_dmem_get_region_name(int fd)
> > +{
> > +	uint64_t vram_region = 0;
> > +	uint64_t region;
> > +	char *cg_region;
> > +
> > +	/* Find first VRAM region */
> > +	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
> > +		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
> > +			vram_region = region;
> > +			break;
> > +		}
> > +	}
> 
> FWIW it looks like that from here..
> 
> > +	if (!vram_region)
> > +		return NULL;
> > +
> > +	cg_region = xe_cgroup_region_name(fd, vram_region);
> > +
> > +	return cg_region;
> 
> .. to here could be simplified as return xe_cgroup_region_name(...), given
> the helper returns NULL for non-VRAM regions. Or even return straight from
> the above loop instead of the break. Up to you which of the three options
> you prefer, just thinking out loud.
> 

Thanks, I will consider which one of those to use.

> > +}
> > +
> > +struct xe_bo {
> > +	uint32_t handle;
> > +	size_t len;
> > +};
> > +
> > +struct xe_dmem_ctx {
> > +	int fd;
> > +	struct xe_bo *bos;
> > +	uint64_t vram_region;
> > +	int max_bo;
> > +};
> > +
> > +static int xe_dmem_init(void **ctx, int fd, int max_bo)
> > +{
> > +	struct xe_dmem_ctx *xe_ctx;
> > +	uint64_t region;
> > +
> > +	xe_ctx = malloc(sizeof(*xe_ctx));
> > +	if (!xe_ctx)
> > +		return -ENOMEM;
> > +
> > +	xe_ctx->bos = calloc(max_bo, sizeof(xe_ctx->bos[0]));
> > +	if (!xe_ctx->bos)
> > +		goto out;
> > +	memset(xe_ctx->bos, 0, max_bo * sizeof(xe_ctx->bos[0]));
> 
> calloc already zeroes the memory.
> 

Ack.

> > +	xe_ctx->max_bo = max_bo;
> 
> Could the need for max_bo input parameter be avoided if the arrays were
> allocated in chunks and grown? More complex implementation but a simpler
> API.
> 

I will see how that looks like and how it affects the callers. Hopefully,
it makes it more simple and fix one or two of the clunkiness in the
callers. Let me check.

> > +
> > +	xe_ctx->vram_region = 0;
> > +	/* Find first VRAM region */
> > +	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
> > +		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
> > +			xe_ctx->vram_region = region;
> > +			break;
> > +		}
> > +	}
> > +	if (!xe_ctx->vram_region)
> > +		goto out;
> > +
> > +	xe_ctx->fd = fd;
> > +
> > +	*ctx = xe_ctx;
> > +
> > +	return 0;
> > +
> > +out:
> > +	if (xe_ctx->bos)
> > +		free(xe_ctx->bos);
> > +	free(xe_ctx);
> > +
> > +	return -ENOMEM;
> > +}
> > +
> > +static void xe_dmem_deinit(void *ctx)
> > +{
> > +	struct xe_dmem_ctx *xe_ctx = ctx;
> > +
> > +	free(xe_ctx->bos);
> > +	free(xe_ctx);
> 
> Handle cleanup is not desirable?
> 

That is done by free_vram. I will try and do it here too, in case there is
anyone left.

> > +}
> > +
> > +static int xe_dmem_allocate_vram(void *ctx, int n_bo, size_t len)
> 
> Is the last patch in the series the only user of this API? I am thinking
> whether the n_bo input parameter is required and it wouldn't be simpler to
> just return a handle (or null) and grow the internal count. Ie. is there a
> use case for callers to precisely need to control "allocate/free at this
> index"?
> 

There is also the dmem_max branch, which was the original user of the API.
Specifically, the case where we want to trigger eviction by allocating one
extra BO required a revision of the API or the initialization site, at
least. Perhaps just doing the dynamic allocation will fix all. IIRC, there
is no sparse allocation, so we could skip n_bo entirely.

> > +{
> > +	struct xe_dmem_ctx *xe_ctx = ctx;
> > +	uint32_t handle;
> > +	int err;
> > +
> > +	if (n_bo >= xe_ctx->max_bo)
> > +		return -ENOMEM;
> 
> If the max_bo approach remains, I'd be tempted to igt_assert here since it
> is a test writer error to hit it.
> 
> Also, return error if a valid handle is already at the requested index?
> 
> > +
> > +	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region, 0,
> > +			     NULL, &handle);
> > +	if (err)
> > +		goto out;
> > +
> > +	xe_ctx->bos[n_bo].handle = handle;
> > +	xe_ctx->bos[n_bo].len = len;
> > +
> > +out:
> > +	return err;
> > +}
> > +
> > +static void xe_dmem_free_vram(void *ctx, int n_bo)
> > +{
> > +	struct xe_dmem_ctx *xe_ctx = ctx;
> > +	size_t len;
> > +	if (n_bo >= xe_ctx->max_bo)
> > +		return;
> 
> Same assert or not comment as above.
> 
> > +	len = xe_ctx->bos[n_bo].len;
> > +	if (len) {
> > +		gem_close(xe_ctx->fd, xe_ctx->bos[n_bo].handle);
> > +		xe_ctx->bos[n_bo].len = 0;
> > +	}
> 
> It looks like the len local is superflous and handle also needs clearing.

Right. I think when we used the VM API, it was needed, and not anymore.

> 
> > +}
> > +
> > +const struct igt_dmem_driver xe_dmem_driver = {
> > +	.name = "xe",
> > +	.get_region_name = xe_dmem_get_region_name,
> > +	.init = xe_dmem_init,
> > +	.deinit = xe_dmem_deinit,
> > +	.allocate_vram = xe_dmem_allocate_vram,
> > +	.free_vram = xe_dmem_free_vram,
> > +};
> 
> Regards,
> 
> Tvrtko
> 

Thanks.
Cascardo.
