Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937F7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D2410EFA3;
	Wed,  1 Jul 2026 21:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HQvde2K6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6362C10EFA3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 21:15:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81B75600AF;
 Wed,  1 Jul 2026 21:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110651F000E9;
 Wed,  1 Jul 2026 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782940517;
 bh=ST5XJ3qWoqmoFi2Pnu/be6GaGojp4wfpLlZ4lIOZGEA=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=HQvde2K6xIG4LDeLWg1opVnBNcOByUfAUML5CkvgpbeOXkd6QuA7qjtTXu8+5Q1fg
 eJQth6EWn5+/7UADpEFS2icad+ZmPZlpGfeug+wikYLqcpys5oSKAKD48T7TawM62O
 CMZjbLgWOL2Yf21DSV1ajWzvE7OcDPhWWHXZ209DKfoJT4ieRfPCnVFXMtDy9t7feY
 fhPDjKqZuOku4of0ERbySgBg1SYHXWaccC1rYi/HAatyMwcg0bPP7sR4Y5vo7zqW2N
 nciM6RZrdV8psIIcdQQ1tp2jjZ1dUDnqatqYgbfKZYdAEpr31cFkgqlM3h0XwpZmtx
 fa0OWKI3I03uA==
Date: Wed, 1 Jul 2026 16:15:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/10] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <20260701211515.GA351212@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701171245.90111-2-matt@ozlabs.org>
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

On Wed, Jul 01, 2026 at 06:12:13PM +0100, Matt Evans wrote:
> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
> 
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c898542af8d..a5a1baebc34e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -226,6 +226,17 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
>  	.folio_free = p2pdma_folio_free,
>  };
>  
> +static void pci_p2pdma_release_pool(struct pci_dev *pdev,
> +				    struct pci_p2pdma *p2pdma)
> +{
> +	if (!p2pdma->pool)
> +		return;
> +
> +	synchronize_rcu();
> +	gen_pool_destroy(p2pdma->pool);
> +	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> +}
> +
>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev = data;
> @@ -237,15 +248,8 @@ static void pci_p2pdma_release(void *data)
>  
>  	/* Flush and disable pci_alloc_p2p_mem() */
>  	pdev->p2pdma = NULL;
> -	if (p2pdma->pool)
> -		synchronize_rcu();
> +	pci_p2pdma_release_pool(pdev, p2pdma);
>  	xa_destroy(&p2pdma->map_types);
> -
> -	if (!p2pdma->pool)
> -		return;
> -
> -	gen_pool_destroy(p2pdma->pool);
> -	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>  }
>  
>  /**
> @@ -932,8 +936,8 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
>  	struct pci_p2pdma *p2pdma;
>  
>  	/*
> -	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
> -	 * ensure pdev->p2pdma is non-NULL for the duration of the
> +	 * Pairs with synchronize_rcu() in pci_p2pdma_release_pool()
> +	 * to ensure pdev->p2pdma is non-NULL for the duration of the
>  	 * read-lock.
>  	 */
>  	rcu_read_lock();
> -- 
> 2.50.1 (Apple Git-155)
> 
