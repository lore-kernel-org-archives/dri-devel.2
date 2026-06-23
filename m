Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C2CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C051410E495;
	Tue, 23 Jun 2026 06:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C3GJODnX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632DF10E495
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782197188;
 bh=S1W9nvysVTlhGlyxf8bcbMXagzfiYnWQcaO4x3GB/Ts=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C3GJODnXnIJLeUfyht55qPWHoxgHOXlpiGvC0bkfGT9aUg/NOJ1CAfjwnRrLfCmtu
 p+B5mKtpmiV9NqtPAIV0No64c4iXU9TPO4SjkAo7+XbbrNow7vb16EPZ9KjN7r7RE1
 fZ4j55hc2KQmf5WjbrruYSw8nFo7ebqSikvqhvovC/nkSH8r1cMLjo0uW2C5yYpPfn
 h+4sE7TI+5OR/0zxMaeGsiu53hPi8IXQ4lMFvbaHdX1hW2UycB3JCiAJ7hZylif9NA
 kXuyzxlOtPrPydxmUATT55DNasfq4kUTkR2jTNUbTQkV1am1ofCWWvZZZugEYuIHO1
 MhdZM2pA5m5UA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 77B6F17E0180;
 Tue, 23 Jun 2026 08:46:28 +0200 (CEST)
Date: Tue, 23 Jun 2026 08:46:25 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: dri-devel@lists.freedesktop.org, Pedro Demarchi Gomes
 <pedrodemargomes@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] drm/shmem_helper: Check VMA boundaries for PMD mappings
Message-ID: <20260623084625.53f685fb@fedora-2.home>
In-Reply-To: <20260622215718.1532689-1-lk@c--e.de>
References: <20260622215718.1532689-1-lk@c--e.de>
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

On Mon, 22 Jun 2026 23:57:17 +0200
"Christian A. Ehrhardt" <lk@c--e.de> wrote:

> In the ->huge_fault handler do not install a PMD huge page
> mapping if the huge page exceeds the boundaries of the VMA.
> 
> All other ->huge_fault handlers have similar checks and the
> resulting mapping will trigger a VM_BUG_ON_VMA() if it ever
> reaches copy_pmd_range().
> 
> Cc: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: stable@vger.kernel.org
> Fixes: fc3bbf34e643 ("drm/shmem-helper: Fix huge page mapping in fault handler")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index c989459eb215..00807039f8d7 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -597,9 +597,13 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  	} else if (order == PMD_ORDER) {
>  		unsigned long paddr = pfn << PAGE_SHIFT;
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long start = ALIGN_DOWN(vmf->address, PMD_SIZE);
> +		unsigned long end = start + PMD_SIZE;
> +		bool in_range = vma->vm_start <= start && end <= vma->vm_end;
>  		bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
>  
> -		if (aligned &&
> +		if (aligned && in_range &&
>  		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
>  			vm_fault_t ret;
>  

