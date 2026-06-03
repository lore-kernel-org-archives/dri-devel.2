Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9431CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A0010F721;
	Wed,  3 Jun 2026 01:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="BzFtwZfR";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A1A10F721
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:08:39 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-91587626a3eso92430185a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780448918; x=1781053718; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5b1waI30m43a9rgbDHZrFDb+c/4Zyp2tRTfYwiyzcxw=;
 b=BzFtwZfRQdt5c5l23zCqF6wqlxY7RhDeOrBy8W9XVOudLTaHNOEejBeuyK+j4VepJx
 YbG3h4rbj1AjgdXgp9os40SKlKAwsPe7MfinuAiqrgR61VS6U7Zf1HpI5TDjspnknQJk
 pk3MCp9avylgJ3sPlQoJ+yZimPVsB8EriG8ZTwdPWRv0XLaobnV4TC8HcAWnorZGY71A
 8oFdPR/gKqO3mzgHdia2eozmuFLoe5hFjSd5a8UNDJEQgX05T+R77y0m1MEFJRRLOEDQ
 +ztE8TUEozwpq8JRjC1PCavt+3q9I/04lnHfvGfTizkVq5Z9ilsdipSPASJrP7mJVVlk
 erDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448918; x=1781053718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5b1waI30m43a9rgbDHZrFDb+c/4Zyp2tRTfYwiyzcxw=;
 b=HQosscHy73zRPgWdkOeRJwUwLmbaaKk06203byJGFdLp60NDLudPB+TXOpdzxLKZqo
 FxgBnpt5Jm2pK1M0v6VgCESwRw5yzFHA/d+wnsxOyVUTqelxfkuwLmrAADDv8NJ/GQXj
 WZ2a9fvQZ3tQuzkm9Z+T3c2CVg93OYq08TZLLazwCJrI2qkzk8a9k46d66nfAhtuqn8U
 mkLGNr1wNbvAvM7+POCUFyU+FHBlz5+n0PGfoH2YgzpEI8sbRrUzQn51qasc13nLH1ps
 YJBqEjQ5STOmVweEqit3tT8ahlpEsjEGR4It9vMAKYCwgj4lLAMoEbLesQMRDFAl8Pou
 OybQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/fhliD+x1dq2MMM+gTyPElvF6xhf+Rpe+x6dOTZvflMOb+YS0A8fW2O8Cq87Ibe+nAAaoSHUfx9g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPujd4NK4m8XElW9tDSda+tobDhNyQKAEV0sbypsZuMkiX1ABl
 XgepLKKdNoZIGfv7ccKLURXiXeo5U3Zq7gwCC6Nu0maMs5pQFgFN2zMCxra44DLxEBU=
X-Gm-Gg: Acq92OGzpla45DIyc3dOgYOPKdtJPd4X91hpD0sJQ0eLMCtDBRWRNKUx4YcBEjF76Lg
 +xHE/6Q/ZPQPF/u5m/eYo3VttVEHMWG27BOsgDEh2lb4+Yfad0b1VKJoN2DsxvdjcEELnq247/2
 e1VxpDtSVX+8n6cjcMQQH8sVfuoKkz2X2HxN2HLjBMnIUt93bNwKSyLwgc9nE11zC9BMObwJW0c
 KT0rYrmbbxowGdC18lW1I/BBjfg8KpT61JbSZQYa/7ZG0S2XjebgBa6yXW3ZySyOQdF9vE5PmE2
 GwoYd+zLDx0TCmQkbNcL9cV+mAdNOFk6SxwrJc0G/FXYuApqdOVtoX5yDCkBHxuibVPeQSZnW+6
 B18i1pWUCrXZQGLeOTwYG1Z8xlNC+G3Fyu8+Doo/60Mati4v1CdVJINVs0KhzXJ22ult3AWq4M6
 RZnfa5c0x8urce8o3kaaGIQD/X2FiXwz9KSkkFKgwaFcXJewyeoaXjKHniYZZLUriH83tcARB2H
 V/KDps1w5xh/Lv4
X-Received: by 2002:a05:620a:1722:b0:911:de69:ee21 with SMTP id
 af79cd13be357-9158a656dbdmr268795585a.11.1780448917995; 
 Tue, 02 Jun 2026 18:08:37 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37c50bsm99840585a.24.2026.06.02.18.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 18:08:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wUa60-00000004yEH-2fsG;
 Tue, 02 Jun 2026 22:08:36 -0300
Date: Tue, 2 Jun 2026 22:08:36 -0300
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
Subject: Re: [PATCH v2 01/30] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260603010836.GQ2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>
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

On Tue, Jun 02, 2026 at 06:46:08PM +0800, Guanghui Feng wrote:
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of the
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or PHYS_ADDR_MAX if no translation.
> + */
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return iova;

This doesn't seem right. It needs to return a mapped_length of
something that is not zero..

> -	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (!domain->ops->iova_to_phys_length) {
> +		/* Fallback to legacy iova_to_phys without length info */
> +		if (domain->ops->iova_to_phys) {
> +			phys_addr_t phys = domain->ops->iova_to_phys(domain, iova);
> +			if (phys && mapped_length)
> +				*mapped_length = PAGE_SIZE;
> +			return phys ? phys : PHYS_ADDR_MAX;
> +		}

Follow success oriented flow..

Jason
