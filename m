Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD1ACC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063CB10E062;
	Thu, 15 Oct 2026 14:23:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 83AC610E9F2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:23:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD211477
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:23:29 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 AA8DA3F871
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792074212; bh=0+iooWQw52Www5HReZBOrQwshBCxR+z0ZhLJfDpMqZM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UstGq1SjMYTJL+Hne0hBXVmsi957xnjKC4xy/lLVQfFE/D9GUt/aq0RhdAW4K9bbf
 BQ8XhMLmbiPkE0X7km7XZzIsbcfuv91vxzb00J4Lj1+p758DTS9qqATN4OHyStjzz2
 zuWaHgHm+BVcQohuyheZK+swFNnodSop5ia1YIbc=
Date: Thu, 15 Oct 2026 15:23:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH v2 1/2] drm/panthor: Fix handling of NO_MMAP BOs
Message-ID: <atDh4XdILkqrvHuL@e142607>
References: <20261013125433.26432-1-akash.goel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013125433.26432-1-akash.goel@arm.com>
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

On Tue, Oct 13, 2026 at 01:54:32PM +0100, Akash Goel wrote:
> The BOs created with DRM_PANTHOR_BO_NO_MMAP flag are not supposed to be
> mmappable by the Userspace. But after the rework to support shrinker,
> it became possible to mmap NO_MMAP BOs. Userspace could second guess
> the file offset range, allocated unconditionally at the BO creation
> time, and create a CPU mapping. There may not be any adverse effect of
> such a CPU mapping though.
> This commit adds a check in the mmap callback of Panthor driver to
> fail the mmap() attempts on BOs created with NO_MMAP flag. The check
> covers private BOs as well as the prime exported BOs that are mmapped
> using prime fd.
> 
> v2:
>  - Fix breakage of mmap() on exported BOs that didn't have
>    BO_MMAP_OFFSET ioctl invoked for them.
> 
> Fixes: 68cbf96b1e9b ("drm/panthor: Part ways with drm_gem_shmem_object")
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Pushed to drm-misc-next.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index c07a44057e42..22b57ab6f929 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -744,6 +744,9 @@ static int panthor_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *v
>  	struct panthor_gem_object *bo = to_panthor_bo(obj);
>  	int ret;
>  
> +	if (bo->flags & DRM_PANTHOR_BO_NO_MMAP)
> +		return -EINVAL;
> +
>  	if (drm_gem_is_imported(obj)) {
>  		/* Reset both vm_ops and vm_private_data, so we don't end up with
>  		 * vm_ops pointing to our implementation if the dma-buf backend
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
