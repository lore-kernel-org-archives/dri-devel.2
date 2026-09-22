Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46279C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D4E10E49B;
	Tue, 22 Sep 2026 11:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aj800mXp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9C010E49B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790076505;
 bh=gG+ucN6t1rCdtKjxiavG2+5yDMmJ3sKVxpjLLrrXgqM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aj800mXp4OG5xKwwBejtWRqdVC/JtuhdYhbm5/YCZYq5pVm8m+qXqJD+VcVrMAZdn
 Maa0rSeZMpZMtK8gfnzzyhKPl0S2vzw7/0UA5KlyqZG3Q4p3g8V87h12uAfh97RT/M
 RHA84nXnW1f5nT1jqVtxePeILaEmAb0NcV4giWNWlCs2kn33QuygTtpOmFGBrpkaCo
 RLnyhjoruygWnxXHDuK5F7ikUZNYQkQUaJXXIjlXBswI5OTKXJN095hiaoiKS3tbaI
 lNv8KzSNQylXabwtv4r5FiItc9NJQ8L73gmF1vK1tNLdfbuH6Vb6SdwnuY5fXUk5xB
 P/uiptrl3/Gww==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DB04B17E0515;
 Tue, 22 Sep 2026 13:28:24 +0200 (CEST)
Date: Tue, 22 Sep 2026 13:28:14 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix handling of NO_MMAP BOs
Message-ID: <20260922132814.3ca8914b@fedora-21.home>
In-Reply-To: <20260922100743.447700-1-akash.goel@arm.com>
References: <20260922100743.447700-1-akash.goel@arm.com>
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

On Tue, 22 Sep 2026 11:07:43 +0100
Akash Goel <akash.goel@arm.com> wrote:

> The BOs created with DRM_PANTHOR_BO_NO_MMAP flag are not supposed to be
> mmappable by the Userspace. But after the rework to support shrinker,
> it became possible to mmap NO_MMAP BOs. Userspace could second guess
> the file offset range, allocated unconditionally at the BO creation
> time, and create a CPU mapping. There may not be any adverse effect of
> such a CPU mapping though.
> This commit removes the unconditional allocation of file offset range
> when a user/kernel BO is created. For user BOs, allocation of file
> offset range would be done from BO_MMAP_OFFSET ioctl handler which has
> a check for NO_MMAP flag. For kernel BOs, there is no need to allocate
> file offset range.
> 
> Fixes: 68cbf96b1e9b ("drm/panthor: Part ways with drm_gem_shmem_object")
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index c07a44057e42..5cfe66537e87 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1021,10 +1021,6 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
>  	mapping_set_gfp_mask(bo->base.filp->f_mapping,
>  			     GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>  
> -	ret = drm_gem_create_mmap_offset(&bo->base);
> -	if (ret)
> -		goto err_put;
> -
>  	if (exclusive_vm) {
>  		bo->exclusive_vm_root_gem = panthor_vm_root_gem(exclusive_vm);
>  		drm_gem_object_get(bo->exclusive_vm_root_gem);

