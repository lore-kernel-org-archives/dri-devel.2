Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC6BC55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4846B10F0F7;
	Thu,  6 Aug 2026 07:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IxxpBJPu";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172AF10F0F7
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786002398;
 bh=P0ooqE0uPWiEJhHB6YvjmOEp8WmR+FP9n8dFeBmZRSc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IxxpBJPunytUY82qqvtIABr9WtBkmhRQYkbrHm9QSFllizDfC9I4PVd9UrGDUt8Um
 Nrq0+mPvpJFiADDahdo8clZCZzbqIGLIESsE68RUbqc9WNMNJqSqX5Z4EK0AqWmOgk
 cDYMZzq5MgG059N0qMePBIqvhjU/q6t+LStHw7qzwWstvVI4HLxLUCbJCR6NXRSM1x
 /AWqZa/RmoF7a1xFxwp4Gk49jW4H5KZEWkemREr7vAT40FYZ3zOV1Wje7gb5wV40mC
 7K57/JDNDd/xbq0YvNMRNE6X7TmR/GSxrZT6tWPoJzR2OilBfdVx4WB0v6XmC0pX3q
 753zyugKQAR5A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C8D617E0235;
 Thu, 06 Aug 2026 09:46:37 +0200 (CEST)
Date: Thu, 6 Aug 2026 09:46:31 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Check VMA boundaries for PMD mappings
Message-ID: <20260806094631.5796ef32@fedora-21.home>
In-Reply-To: <20260623181942.1536598-1-lk@c--e.de>
References: <20260623181942.1536598-1-lk@c--e.de>
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

On Tue, 23 Jun 2026 20:19:42 +0200
"Christian A. Ehrhardt" <lk@c--e.de> wrote:

> When checking a different patch[1] sashiko AI pointed out that
> panthor needs the same fix[2]:
> 
> In the ->huge_fault handler do not install a PMD huge page
> mapping if the huge page exceeds the boundaries of the VMA.
> 
> [1] https://lore.kernel.org/lkml/20260622215718.1532689-1-lk@c--e.de/
> [2] https://sashiko.dev/#/patchset/20260622215718.1532689-1-lk%40c--e.de
> 
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Fixes: 68cbf96b1e9b ("drm/panthor: Part ways with drm_gem_shmem_object")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Queued to drm-misc-fixes. Sorry for the delay.

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> NOTE:
> The panthor version is only compile tested because I don't
> have the hardware. However, the code is identical to that
> fixed in [1] and I have a reproducer for that.
> 
> No need for for stable backports. The code is new in 7.1.
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index a1e2eb1ca7bb..54535bae2b0c 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -802,9 +802,13 @@ static vm_fault_t insert_page(struct vm_fault *vmf, unsigned int order, struct p
>  	} else if (order == PMD_ORDER) {
>  		unsigned long pfn = page_to_pfn(page);
>  		unsigned long paddr = pfn << PAGE_SHIFT;
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long start = ALIGN_DOWN(vmf->address, PMD_SIZE);
> +		unsigned long end = start + PMD_SIZE;
> +		bool in_range = vma->vm_start <= start && end <= vma->vm_end;
>  		bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
>  
> -		if (aligned &&
> +		if (aligned && in_range &&
>  		    folio_test_pmd_mappable(page_folio(page))) {
>  			pfn &= PMD_MASK >> PAGE_SHIFT;
>  			return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);

