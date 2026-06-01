Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B87CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59E911369C;
	Mon,  1 Jun 2026 17:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="IbDWnaux";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6976C11368B
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 17:52:54 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-914bfa75911so1114509485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780336373; x=1780941173; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ajzqlQYEAeycmyed8yu6upDmFOo140vP8s+rqI6MeM4=;
 b=IbDWnauxWGhGRO1Gca/kSKbye6PEt7VIFxZAimgXu+WsksadBHPmmRkZA/kwQ0MLHI
 Kxzv91wqDJm5bhutLJ/KW11lBtGps1Y54Pp+1YFxgwoCJywKMpvQtAbPIJdpvb5DxtBA
 t1CF+1/D7bu1trs2QDcWIK1koYb5RmeopJA92WTFFKQy1D/6Y3wdhdxXmjKU+munqXTt
 Teq+As2NE9vbsdcv+gKqhqLbgfl8xJy60p5Z+gbA0JC7ouODqNsiZZNPQDjWvgiFJ9gh
 qKrBa7WDZHUD0dX1BeOPPUcC1IAeS9kE5rZ96CsqrmqQq2Dvk6cgaxZ4NJDulpY47xAB
 yuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780336373; x=1780941173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajzqlQYEAeycmyed8yu6upDmFOo140vP8s+rqI6MeM4=;
 b=XtQsqCGBRyD7tN8TgJwPGZQOYBj35FBYCtz7dEd7HAmmb6piTBN/9EbUbEbn2CWl3k
 91pbHQBW8gHBVCF1wczZYzRYyd0ye5Q2o/Rb8o3ek5nPhk50QzkFSxvYB2InwKjbmjSu
 Nfjb5aFpJhY1upf+YLLcKFeJW6Cda+V/UsFlFE0ULirBwcwCKsfLdbpc43zVF90fTWT1
 gswGqA+T3KDjvj282MpNIb6FVedz7aiuhloF2ShWlo6m8ZYpx3HI61xqgQjzUHHZcxE9
 JC4kZ8q9jLFb3z3XeW8DwO1qCLEMvtKqprN9Q9p7bE9Zy3YzlB1vngeJYbyV9/V5Pyb9
 WUXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/SPqmSTm7OSVrHsq1Y/RTcBnuUxvr/CwEP4FxqXGZDbnAxfbbJFrYHy7Qe4OOSJ2t3yQ2DXW2TAg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPKKBRz0leWEHc+nLhzsjYF+8+LsApFE2pyrxvNgIJW2HYc1qw
 sCh4WJBTHgKVJu8oTwJ9/UtLHrV4ZhNg5jgea0vEB39leyS5qeSzD+7zsSly7Xe6AXI=
X-Gm-Gg: Acq92OHIL4aWDg2Pr5RVc9jQIFKlFZCE9t9w8ytFwqhfefeRxCPHun/unKSS6UuOp4W
 STP7ckfZNdnelVvAAIZaY4eZGZzRqtkUQ8Y05moJ3gzgQwmmwQPK5zxiJmdDtvcjLrzVMw9Xwum
 Q4LRhMCaQFlSHg+XZCr73lUwn4D6z//h2/njsAtJPlqR9UlTlMIiqXm8V31R/EC7r0em+GWT014
 3rRc5LyB1Gn6vkXIEsoMeg/Wi36ayOWP3WIMusyD0SB4DdpuVzt7mmdy4nkpiWx7Bkg+Qk3dHEg
 69HlrBG2OOwPe3ez0lZ+7twViZmxWFqkmww1vZU69PmFukvhFU0WlfvuhqadlbSIQP6ROJ4Z/fw
 zxVU0p811VIUO84QvzAVpFMNGJ6PN1G8u0RkAHd3SkhKtWZVkO2XUHcLEz9Bb7WgsG/yS07XR1d
 rIKlnuT0FujTZjDNOokl+up1cfGBZdWzEXAQu4r3zr/LjbDz5R5yxe41bgY8JKFklDghx/SlNH9
 WVP6YpzYRBEIWHg
X-Received: by 2002:a05:620a:2202:b0:915:4c9b:4120 with SMTP id
 af79cd13be357-91578006ac3mr63386685a.37.1780336373342; 
 Mon, 01 Jun 2026 10:52:53 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153265126asm1064337685a.45.2026.06.01.10.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 10:52:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU6om-000000027gs-1lLx;
 Mon, 01 Jun 2026 14:52:52 -0300
Date: Mon, 1 Jun 2026 14:52:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com,
 stable@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260601175252.GD2487554@ziepe.ca>
References: <20260528191658.2506362-1-xuehaohu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528191658.2506362-1-xuehaohu@google.com>
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

On Thu, May 28, 2026 at 07:16:58PM +0000, David Hu wrote:
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..1aabc0ee70bb 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
>  {
>  	unsigned int len, nents;
> -	int i;
> +	unsigned int i;
>  
>  	nents = DIV_ROUND_UP(length, UINT_MAX);
>  	for (i = 0; i < nents; i++) {
> @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  				  struct phys_vec *phys_vec, size_t nr_ranges,
>  				  size_t size)
>  {
> -	unsigned int nents = 0;
> +	size_t nents = 0;
>  	size_t i;
>  
>  	if (!state || !dma_use_iova(state)) {
> @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  		nents = DIV_ROUND_UP(size, UINT_MAX);
>  	}
>  
> +	if (WARN_ON_ONCE(nents > UINT_MAX))
> +		return 0;

The WARN seems a bit much, but if you have it then it should be
arranged so the caller ultimately fails.

But otherwise I think correcting the types is a good idea

Jason
