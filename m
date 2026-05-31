Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24846CD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 23:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1013210E6F7;
	Sun, 31 May 2026 23:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZeLE+Stj";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2756610E6F7
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 23:51:51 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-91550eca866so129234885a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 16:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780271511; x=1780876311; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jT2+faPEqgvyyrZj7GkiI+MQEalHKPFUv4mZyF5by/U=;
 b=ZeLE+StjbA7jvbr3S5fd3jInPRk7pqsl3HFHGFWnOZbFecvE0YE1iGAF1JqeH33a7N
 KnQaFEzJj3VIcWFNTo9Up7Yeup4xeee5QihNqMiWygTem0zaISJLtGIJ6eaQgVAeqOoC
 hF9sZdfTvTvdcDZXb1MbK3mKR0nk44Wp2jH4H+883ZkWoXaIELo+VmRgAWvy2a3rThPK
 C1pRWRe/GeSfUsnm4LeNQcbEGIjXqXI1KFw+dY/i4aldUbfz2tYCey6d3zI9+9mkIPSi
 HWeiTG+arLDOOVOCCjkWYkEodH7LlUjgVqrZQ5MSjt5GOOO9KDLRyXlgDeRgk2mGwjz1
 oJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780271511; x=1780876311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jT2+faPEqgvyyrZj7GkiI+MQEalHKPFUv4mZyF5by/U=;
 b=TOaRwcLSMVlzasx27nL9idImtg9RiIDBdksgy0vjRwOUTDBSQhyogMhwXzZulKXtQd
 92cIjkvd5rpYW5p2hkXYdWHgacKcUzfVqFXI0KkqBoaBPoLUjeCDbUXEoP84rC+alJbw
 tvl4bVldQ6lx52HNkCM4WDUHsmltfp7EhrGJLqdMsVbaOXY1+cT8siKzU67hH3f3UPmC
 RKG/Lz0zuarxKyjzvwQEmygzm8nrwqa05dmXSgBMrLX/eJabkt8HWWVpztEg6PtjIL3N
 IM0YqAXKWrCyxPYqAYOppALmU+Lw6qSd2caF0CE2Nljs4RreKlzLLnR+ql2x+OVpMX8u
 V8Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fnmX6eAi07MabJdRd9rKA5sHloFwafsg7+PGonA6khZPHlg4CcYpNGC9XDPJrh4fuXUSRh9WSPrY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFjBAkdXIT2RYkbkViHQQ+qwRLcsfseW3MznoLOtXpRbgeEbFX
 0I0ck/mU/zqoQGYrQHj98Q1bfcjEBCGN0eJCYkCVq1qiixYPLV8f5x3Qk6Wx/4oB7Oc=
X-Gm-Gg: Acq92OE++y6gJdFcHmzpZGl2hemIe4H13rNd6gYOewna/XLQ7uog+gQQhlTon3/GX41
 3DTNf3jE/yazxuGEdyp7tPyLlM8Wag8xfktbiri4m/GP63pib3J9vOA+1VRnEE7VthS6m2DBue4
 o3ZkV+RY4NeT7viNh5Vgl0SkefbSAkrENu+49QQx49a/nJpLpDH1MQFdhpqVfEfh+urKJ8rJT0q
 8tS8n93AlCqricMjCJD0VpCpvzDaKRrf57MxDo2YsQpnm3OdGG2Giutvlc1AqqIz8LgU8kMgrfX
 +IhGUmT8Kw5Qm8Uyg1saEl7TvRCSajE6GEZ9lI2Zlx9/xge56tw7v/hwUqi3Zadjic0VBONXXxs
 bAZQX8byZ6Gvrbqi7+lJ0jzHUlVnB4hkAlQWB0L8fihRBJE8uvFj9PFQHkTXHOTsX+iWOjRLzu0
 CHLjubh6BY34Y0QiMnmMvJ4g1NLAiObdr8I0GrIzRcKlF8FbR0fQTSqVQqqu5MKgQuuslCPTl66
 r4aNgMHVaf3kGuy
X-Received: by 2002:a05:620a:439b:b0:913:7bc8:79b9 with SMTP id
 af79cd13be357-9153d9b617bmr1323643185a.22.1780271510817; 
 Sun, 31 May 2026 16:51:50 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91532473bb9sm854276585a.11.2026.05.31.16.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 16:51:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wTpwa-00000001LoH-3dmS;
 Sun, 31 May 2026 20:51:48 -0300
Date: Sun, 31 May 2026 20:51:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260531235148.GV2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
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

On Sun, May 31, 2026 at 05:36:29PM +0800, Guanghui Feng wrote:
> Add iova_to_phys_length callback to struct iommu_domain_ops alongside
> the existing iova_to_phys. The new callback returns both the physical
> address and the PTE mapping page size in a single page table walk.
> 
> Add iommu_iova_to_phys_length() core function that:
> - Checks ops->iova_to_phys_length first (preferred path)
> - Falls back to ops->iova_to_phys for unmigrated drivers
> 
> This enables callers like VFIO to efficiently traverse IOVA space
> by actual mapping granularity instead of fixed PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>  drivers/iommu/iommu.c | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/iommu.h |  9 +++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a0..43323229a1df 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
>  
> -phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of the
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or 0 if no translation.
> + */

When introducing the new function I would like to fix this 0 error as
well, it should return PHYS_MAX for error

> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return iova;
>  
>  	if (domain->type == IOMMU_DOMAIN_BLOCKED)
>  		return 0;

Any domain that doesn't have an op should fail, blocked is one example

>  
> -	return domain->ops->iova_to_phys(domain, iova);
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova,
> +							mapped_length);
> +
> +	/* Fallback to legacy iova_to_phys without length info */
> +	if (domain->ops->iova_to_phys)
> +		return domain->ops->iova_to_phys(domain, iova);

If it falls back it should return something sensible for the length.

I suggest you approach the patch plan a little differently, the first
patches should implement the new function and an iommput
implementation

Arrange things so the normal iova_to_phys calls the new function if it
is available and discards the length.

Then convert callers that can take advantage of it. Have the fallback
path also compute the length by iterating internally.

Finally one patch per driver implementing the new op, this could even
be a second series.

Don't remove iova_to_phys(), it is fine for things that don't need the
length.

Jason
