Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54701CD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B533111A121;
	Thu,  4 Jun 2026 14:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="CyEMgxch";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B0E11A121
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:16:12 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-91588056619so50795385a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780582572; x=1781187372; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IjXyN1rYbvjp4a1JYQoZrj8n0hmsK/P4C6YKjbOfWXA=;
 b=CyEMgxchF6ILTadpzx1iw2hiP1i11nyUzYW6jQ+EmLBmM/C9bichABWeeobFDXxuKP
 HGk/5WabYz8aORtKgtzu/XRQYf4WlK0/bI6bPSAQDvSPMB5xJEK9JBhLe4TO0vFevI5g
 DGT7JbVP8EMbOmegHAAgPN1mw+BW7d3mmAZ/bkqG3KIMiAAq7wu8x0zY7S+Ldi9IgsbZ
 2uYFcricPWy8PiX0R8LHGXzi/Q977clEUzsRIA/d4c6Qf7tkOHJgUN0noaLxr37lLF9V
 NgQ9Lmqefn14etUFbjlnilpwdrOoE7abBlCCDHfv6x+3ISB262DxscVi5Z+3IJpOTria
 kJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582572; x=1781187372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjXyN1rYbvjp4a1JYQoZrj8n0hmsK/P4C6YKjbOfWXA=;
 b=MFiegeHY22dPPn8DY8lndcTPM1mVI95IkUWOsvND7uVxXbxKUenBioSgiY+JJmwQAB
 eUu2XucZoiaCBPHxxBFUOD/Vlel9b/+hxYfiHDRwfQ5mOZFGCe4LUwiIes/ARHrrM9eN
 b5OV0UruPoWZDXQy3IZmE+FQiCivhwXhBYyhQH2rIi60B6WOc6aOcJaR3eQ4R6kwMGFk
 xYhNQ6GvDjN5maZHx56c3oB8WqT0zobpxrUphR1gkZW22HXjZIllw3SACX9d1SZXlHFf
 6fR1o0vxVzhGG9bznf7KMCT40rQUXwAO1khUUlGJwgwMuxpyzEoLGa71YBK24wAFaYTp
 7D1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ajwPEFnScrUkF5jNTmE3ZY6Htzyg+zfCA1jhGUMr95jMQUmLvpRxkcKWRwJJ8/P4JFvcmI0s3IOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxt/9viAowDBiZozb6wYKMqh4iS6ZJcLHe77sZ91aNCWm9sTPeQ
 g8zXIOTlgdfwoaWdAFa8m6eHz0XtQmuk81TXEBbF+OZilQH5GWXl4JKB0ak8H5PcpVc=
X-Gm-Gg: Acq92OHFniOU/fCaE1XaUb9UTbvO6q9ypUY5CG/dKabqIZn0d9SA9mPN4ax0NNy2vIi
 cQ3xpBwjtUU6USNVc2k1fs9N9+sqUK/IxM4sKxk2a3tYLjvLXJ4svkNS6juFPl5hClR4ho9MpZ9
 mPizX4VoTg5ka7PUwJBt+tx9iSZorQPCEQfe//+DnFI1/wOaMKg1Y4IjYgR7Rkf9dFs1HQ7K8mX
 bywA3kW/cUi8Ornr5q2+sg3IF/wkeOlWAwcXqE1MXqpkiyE9I2oY9/nZVdGbf90hF8yHDEuQE52
 pyRmqrZ/+jceEDwwlH9jw5oDEuovv2FvH3kjO/zjisuYf+pnZeTggAPYJWFRTHJMwCH+SiWAKz1
 qsApS4acVow/abQ3xIwelQK9S7FwzDvFC+fNvOgOkEwY+qfGp1ruYFuhfpeI5xVW8T3Dh+4viLi
 x8LzKaDU5gJBpi6UGcFIw0/DCzZliAC6/g9PqxxesW5wqhNYdldbIENHvV9OmuQYaZTs6qfeWwp
 mWugF10Xbiki8Ye
X-Received: by 2002:a05:620a:7081:b0:915:7b23:4afd with SMTP id
 af79cd13be357-9158a7292d8mr1364770885a.16.1780582571570; 
 Thu, 04 Jun 2026 07:16:11 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3b637esm580303885a.32.2026.06.04.07.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:16:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wV8ri-00000008HMt-1ns6;
 Thu, 04 Jun 2026 11:16:10 -0300
Date: Thu, 4 Jun 2026 11:16:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
 robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
 steven.price@arm.com, suravee.suthikulpanit@amd.com,
 tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
 will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 01/32] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260604141610.GX2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
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

On Wed, Jun 03, 2026 at 11:17:33PM +0800, Guanghui Feng wrote:
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {

This should take in an ending point so the accumulation knows when to
stop, otherwise it is too hard to use.

> -	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +	phys_addr_t phys;
> +
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		if (mapped_length)
> +			*mapped_length = PAGE_SIZE;
>  		return iova;
> +	}
>  
> -	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
> +
> +	/* Fallback to legacy iova_to_phys without length info */
> +	if (!domain->ops->iova_to_phys)
> +		return PHYS_ADDR_MAX;
> +
> +	phys = domain->ops->iova_to_phys(domain, iova);
> +	if (!phys)
> +		return PHYS_ADDR_MAX;

And to properly clean up the callers all the non-iommupt paths should
manually do accumulation here as well.

Basically if you call this function you get a maximal contiguous
physical range as efficiently as possible.

Jason
