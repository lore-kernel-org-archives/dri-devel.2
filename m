Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EEFCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C421610F73C;
	Wed,  3 Jun 2026 01:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="TPYsWr33";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3EB10F73C
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:13:33 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-5176fc0cc72so11481511cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780449212; x=1781054012; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2cdnAPJ/txGMdC+542Rqoyln86KAovKwsF9QsCq4AEY=;
 b=TPYsWr332VbteTPNqRnGT4SvX8XV6WHJkECwsmePfx/n5OZ9hyCHjIwDkO5xm7cFzk
 kBCnGKW/uzAiodBTm7efoq8PHHAGzOfs0Qm9+jW+dL0hz3R7EtiQuTeGjNec2xDRFe03
 0fhJ/u5tAQ5QMkLVxMvQsItWReraAs2m1uvoMK3QO8JhqYQohvHJ1qkGKosB/wLTltSq
 zDlprBB/XYtKYyThHiU0vUP0O5wtEBHjJ2ri/vwXIyx1KetSRtOPOsIqwCltBSLk8oWr
 9DLfF7PIPP2aSn0W387zeGU2kFq++Y34p7UViJjO3esvMuAghg65xL5YYZ31bQRo3pwz
 VhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780449212; x=1781054012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cdnAPJ/txGMdC+542Rqoyln86KAovKwsF9QsCq4AEY=;
 b=VYhbiEsInuWfOxhgbdQEfPy8vyZzpJhDsnbEgKwHavh/XMyGXjrQNtmtLQwyJLTXyS
 3vtiRFLMFNFrbJTuqlPWUgC8TlvNvvJzSMn/9tAOvNb7ihC1RwwytgjPzRmWol+KgITl
 33kn60yXU80Fiu9J6GUDRSFRBACRACOjPDl4PA3feoVbY6h3CBn15LebTa+vcPfdO3jb
 O/F/6dEuoRm4cIZU2JQT5vgB6fvP2CYUjYhrnpNVvMX7z7drvZATDAmJcG/ePbLfyygi
 0mC6gZClcnGl7fi5vkA6XEhGGDY8Xmfk6Np5GmPUVuZ27dHWbs9aiGSz43AW5CcLolRX
 6opA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ci9LEekOZXvapSALqfMfL9FnLIkLn1FqqpJ9OLf+RX2tIQCmr8fFR7asU/8lfsBRYtD4b4J6GYkY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywsxfwlu7TCmXAHAAhwUusxyY69K4E5JA4acqvzOQPZyFisqT3L
 RW3vuy9EhQyD+IN46gsHhyNgqActzhw98LX1U7s78OrELOAGF6M2ti1iwDcMHO7N6rU=
X-Gm-Gg: Acq92OEDXAkBqapW46KsTIUDwepGWd2nPzIXC+lmBYVH8iIhJjTwLG238o6nKvQ6lHd
 fw/LFuYmMLzY4eupyD8ePcWI3O+qzVyY6/jmhMdtjFoauDd7g+W1BHzAmHwbQF0VrEh5Azr71GM
 lAxHbseyBe0018LnUZFpBIMf2KoJIrG/6AKeuPqolSn7g5zMFj8KwKJkvbkRdW/imEey2uqI5rQ
 pNz23Eq7Am9RurEAeM68X2WFx7Eqz8l7OVxsjJfMva2UjO1muBWcBp5uBOAcDmeUOdxDJpi9E6Z
 /QgkCmWbAIhBKudOQjUY03E6+9oEYzxmF+UqyWPx0twNgs1/NFzCJa0ztlLF7MMaoC6IiYUSZaV
 IM6O0P6q9Dl8q2VictgGOcQUjhaNKd8AHFMBR1IWyMPPvZCQ0XZP7zhJ7ouOGc3MhNG1flCe74r
 xRvbfaoZ3DekdEADtB8Y+CztJSje8oon/3X3q/BI+/G7/aGspYAZkFWKxr07GS38oanalZvY+6Z
 crd5GVPBMIaSVI7
X-Received: by 2002:a05:622a:5b90:b0:517:7590:228e with SMTP id
 d75a77b69052e-517784827b9mr21839501cf.0.1780449212162; 
 Tue, 02 Jun 2026 18:13:32 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c54177sm13497781cf.12.2026.06.02.18.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 18:13:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wUaAk-00000004yZP-2Ic0;
 Tue, 02 Jun 2026 22:13:30 -0300
Date: Tue, 2 Jun 2026 22:13:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org,
 robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
 steven.price@arm.com, suravee.suthikulpanit@amd.com,
 tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
 will@kernel.org, xlpang@linux.alibaba.com,
 alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 10/30] iommu/ipmmu-vmsa: implement iova_to_phys_length
Message-ID: <20260603011330.GS2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>
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

On Tue, Jun 02, 2026 at 06:46:17PM +0800, Guanghui Feng wrote:
> Migrate IPMMU-VMSA to implement iova_to_phys_length, passing through
> mapped_length from io-pgtable.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9386b752dea2..a1b659ddbdb5 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -699,14 +699,18 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
>  	ipmmu_flush_iotlb_all(io_domain);
>  }
>  
> -static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
> -				      dma_addr_t iova)
> +static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
> +				      dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  
> +	if (mapped_length)
> +		*mapped_length = 0;

Why?

Jason
