Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300A3CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DDFE10E249;
	Thu, 15 Oct 2026 12:46:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 09A8E10E257
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:46:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F2C514BF;
 Thu, 15 Oct 2026 05:46:44 -0700 (PDT)
Received: from [10.0.129.161] (e122027.cambridge.arm.com [10.0.129.161])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F353F871;
 Thu, 15 Oct 2026 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792068407; bh=MHqyqJ8nqxk2HWmhAAjqDD5cSOnfGjNnSG/JTJGDnto=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=s/ceTRPteRytnM2VUlFFpd3ajLmbf9y71fozwOhnWfl9d1peZZwdbWODz+wWdP4qQ
 IsiWzcmjk6b++lz8Gk76n+ZMIcTIA/P93lvj6klWQqIKiF+NyWLat507CUEhxpQF//
 2Pt7jMrBcWUHXPyquAQ/APtA0UAWKt4FRZYyy41g=
Message-ID: <2dffbbec-2702-45f3-a37e-c4c42553eca9@arm.com>
Date: Thu, 15 Oct 2026 13:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panthor: Fix handling of NO_MMAP BOs
To: Akash Goel <akash.goel@arm.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20261013125433.26432-1-akash.goel@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261013125433.26432-1-akash.goel@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/10/2026 13:54, Akash Goel wrote:
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

Reviewed-by: Steven Price <steven.price@arm.com>

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

