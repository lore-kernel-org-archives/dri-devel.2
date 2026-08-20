Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E812C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F91810F148;
	Thu, 20 Aug 2026 17:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="M/XzHRre";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DC06310F148
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:44:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74B511477;
 Thu, 20 Aug 2026 10:44:44 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F9C43F763;
 Thu, 20 Aug 2026 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787247888; bh=ZM9sg/RSerJOWxKjiA4PYnkNJoiYGKpyXA8LruZG+VE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M/XzHRrezBOqpp2QoYljfNsuWLo6QApmQ7ZiAInG4n0QLnmZo37eyq/egMLz0msZl
 NvS4zWlQ6NbWJC9JfVE+ouSxZwRdwNEuLGzeRKFCn8VoThkR+KDSRosyApkLL+ioKC
 dsNRj5IMAfcmFGkEgCzp4TzBgmXrt7Iu8sLowYm8=
Date: Thu, 20 Aug 2026 18:44:43 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Marc Zyngier <maz@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Pirko <jiri@resnulli.us>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/4] irqchip/gic-v3-its: Zero shared pages after
 conversion
Message-ID: <aoc9CyxGPHPKFH1N@arm.com>
References: <20260820150034.88729-1-steven.price@arm.com>
 <20260820150034.88729-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820150034.88729-2-steven.price@arm.com>
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

On Thu, Aug 20, 2026 at 04:00:30PM +0100, Steven Price wrote:
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 6f5811aae59c..a055837832bc 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -213,16 +213,18 @@ static gfp_t gfp_flags_quirk;
>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>  					 unsigned int order)
>  {
> +	bool want_zero = gfp & __GFP_ZERO;
>  	struct page *page;
>  	int ret = 0;
>  
> -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> +	page = alloc_pages_node(node, (gfp & ~__GFP_ZERO) | gfp_flags_quirk,
> +				order);

I don't think pKVM does any scrubbing on set_memory_decrypted(), so it
potentially exposes confidential guest data before it reaches
clear_pages() below.

>  
>  	if (!page)
>  		return NULL;
>  
>  	ret = set_memory_decrypted((unsigned long)page_address(page),
> -				   1 << order);
> +				   BIT(order));
>  	/*
>  	 * If set_memory_decrypted() fails then we don't know what state the
>  	 * page is in, so we can't free it. Instead we leak it.
> @@ -231,6 +233,9 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>  	if (ret)
>  		return NULL;
>  
> +	if (want_zero)
> +		clear_pages(page_address(page), BIT(order));
> +
>  	return page;
>  }
>  
> -- 
> 2.43.0

-- 
Catalin
