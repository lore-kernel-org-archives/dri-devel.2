Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797ECCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3AE10F01B;
	Wed, 17 Jun 2026 15:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iCAZvlQ8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C6E10F008
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781708788;
 bh=E0oT6eCyZM4NVfKkZgPcky76Hvvth3FscTvPO3D6NpY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iCAZvlQ8kxuasMtXeV1ib0KE+uxtxh+o51QQAeDeUuzyu0utCk9Flvko7T6at/IL+
 3oRC/u8Cqe7hBqjcB7HnQv6j13M2DwBJRO884FGEhlzB8M17E0o/rO6GlcoMYQ64dp
 Uv24vEk5dLLRXf8WqgnPd0rcPjeKaXlLvzL28jdzkLZpeDuBUzKSYe4Fh96dDEvKxU
 LO7lhe9FfaG1h0cNRpBa+cymIhaV2tOc25cM3Ug7yDI0AKOKN7yPAZyVv1/MI6wBIB
 zVSnO1LKIZLjrHmYc5sXTB4FSIcmI/7RE09DIQ9lv0NK93WH5cpAYZxwXLZRGaYoXM
 jgwQnFarQHVJQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CC8BF17E0432;
 Wed, 17 Jun 2026 17:06:27 +0200 (CEST)
Date: Wed, 17 Jun 2026 17:06:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
Message-ID: <20260617170624.344e6924@fedora-2.home>
In-Reply-To: <20260617-panfrost-perfcnt-timestamp-fix-v1-1-f215f44b55c0@collabora.com>
References: <20260617-panfrost-perfcnt-timestamp-fix-v1-1-f215f44b55c0@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 17 Jun 2026 16:29:46 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> If we don't do that, we end up with invalid timestamps in the
> block headers.
> 
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Found while reworking the userside of the perfcnt logic.
> Up until now, we were not using the GPU timestamps in the dumps,
> but this is going to change, so we need that fix in, and
> backported to all stable releases, ideally.
> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index 7020c0192e18..63861b4c7d95 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -15,6 +15,7 @@
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
>  #include "panfrost_gem.h"
> +#include "panfrost_gpu.h"
>  #include "panfrost_issues.h"
>  #include "panfrost_job.h"
>  #include "panfrost_mmu.h"
> @@ -166,6 +167,7 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
>  
> +	panfrost_cycle_counter_get(pfdev);

As shashiko pointed out, the reset logic messes up with the
cycle_counter refcounting. Adrian, I believe this is something we can
address as part of the perfcnt fixes series you're working on (pre/post
reset hooks for perfcnt so we can release/reacquire resources properly).

>  	perfcnt->user = user;
>  
>  	return 0;
> @@ -207,6 +209,7 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
>  	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping = NULL;
> +	panfrost_cycle_counter_put(pfdev);
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
>  
>  	return 0;
> 
> ---
> base-commit: 7caf2a2351d4053075670ff3e26a6815da0a9e1e
> change-id: 20260617-panfrost-perfcnt-timestamp-fix-51e04002f494
> 
> Best regards,

