Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC87CD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 23:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD60112C95;
	Sun, 31 May 2026 23:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="BCC7OLER";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBD6112C95
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 23:58:37 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-91562bf6c12so19208985a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780271917; x=1780876717; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hTfGHM2qB3g/FLyvX8FCIrm9+eNCgSr89Naia4gruos=;
 b=BCC7OLERDmR6ifwfBkep2tJfoAKFnIE2C1/7sTAecM5/5arv3f7kSi8YR90WRLBQYt
 npsFSO4HLshWjPnngU8hAxSx9+eXB17MLyrTO1kdjQTEtehwRwFeHXhupcxuZQrjkC8R
 0s/+NHdLBCY+yvUWP5FdI8vgB/QHDNpBnhQOVgzCz7SQVZ7fZpfBxc4OKF9EhuoAvO8q
 /5/srQF0aNFhb8e0KDFEgPe3XAW1ewHxovQKEGLM/sD2BPscSytoCucQXw+0CCPCijiQ
 YVY8JzD6NkydmRhGNPl8x/fN3ltbJp82etwWLhF0gbgeYj+U158Qk5VgX/4s1znu88Wb
 dwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780271917; x=1780876717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTfGHM2qB3g/FLyvX8FCIrm9+eNCgSr89Naia4gruos=;
 b=Ha0zJM6YcD2ufcfpnFoME3+n5k2B60r11ZaHIUp0vGqqWyrBVDLMcu+qHxahX9kJTG
 mhbDTctbUPXMDHmDIRpw/mGfx5ARnj6vh/VdbstjU3ggWAqf6jDA0icBruO6lk0WhaeF
 dNfrOC+uSefrEp7lDMsaX/6bP9SbITwWPde9hJ4cNL50PDFbpeAJrqrazu8VtSLOLX0Q
 ucWGwBK0DWDcZCtACX9xNyjoDjd0nVV6N50KSiO/LKEKmVxuqk2sE8BQ+NuHHGSBWKk9
 0O2krARjwgNOBA0qTRKNUPeNpRsK1QYCvML1UgSapfTLhnQIkuSLwOxu7Syb7Nhu7htO
 1GOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AwQ72JFO/i0Jpld9K/c2mmmPdQhk4SFOE4LsubZxn1cpO0Y6IIYsZHUyIdhthWJssAHyndxibk3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzyor3QmVZkpUEP1vrz3Yj9emLLEVMGEFVUYAtBpxgwlAcDy8z0
 lqgoLGSVvChGnZc9zZiFUpmKyCPPgR1J4P+uc9uYOl10c7iuOS47n2E6Rvbue3hRyvA=
X-Gm-Gg: Acq92OFb4f0UCewdPozfIy9FjE2Ro1a0kb6/XQuf3LEc547gG0L7U+pxlkDUj17JhMq
 vlQqIYPM7VDveGIFWvpLUGtLPREhewRC2ah2J/gmzJOd7pCA5oGRze1KQrGhROdJKau7+R+K71n
 o1iXcQ8HHWErY+UlP42YhqU5DkVien/Qc6DGiGKJz61ktUYioRjwS2tS4Es35On3YduAasYN2ch
 gYxm5f0VZwIFRRkBUB+CkcPUD7ks61yDuJNZR19YDgpZMj9eNpdDwOz3bHVgMa/pWlSM1wQ9QIU
 zoRCuF4ifuLbzM70/aetBZAvJQ9lu0cPm50Db5odOpwjYACFljhCf99ZJUc4H68+Sdvq0J09VLG
 XeWQ5JwLUYujm8x0oprIVQAyBnwTGOjRoMNXApGXdjkT1H16b11hi3jx9ZiGyX8fagFlV8RsBzZ
 d3mbbM0MSv8K/VfJlzDbQ9Tr4nBD9tmk2p3UEaNQGYiK8nvrDI8j//o34DW2LFx0Rlt+LuQmLH6
 M3/E8WKFmd8HOml
X-Received: by 2002:a05:620a:bc8:b0:8cd:97de:bb52 with SMTP id
 af79cd13be357-9153d9703b8mr1495082185a.22.1780271916895; 
 Sun, 31 May 2026 16:58:36 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153262e2a6sm837284285a.40.2026.05.31.16.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 16:58:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wTq39-00000001Lt5-3GHA;
 Sun, 31 May 2026 20:58:35 -0300
Date: Sun, 31 May 2026 20:58:35 -0300
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
Subject: Re: [PATCH 7/9] vfio/iommufd: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260531235835.GX2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
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

On Sun, May 31, 2026 at 05:36:35PM +0800, Guanghui Feng wrote:
>  		/*
> -		 * This is pretty slow, it would be nice to get the page size
> -		 * back from the driver, or have the driver directly fill the
> -		 * batch.
> +		 * Use iova_to_phys_length to get both the physical address
> +		 * and the PTE page size in a single page table walk, allowing
> +		 * us to skip ahead by the contiguous region size instead of
> +		 * walking the page tables for every PAGE_SIZE step.
>  		 */
> -		phys = iommu_iova_to_phys(domain, iova) - page_offset;
> -		if (!batch_add_pfn(batch, PHYS_PFN(phys)))
> -			return;
> -		iova += PAGE_SIZE - page_offset;
> +		phys = iommu_iova_to_phys_length(domain, iova, &pgsize) -
> +		       page_offset;
> +		if (!pgsize || pgsize < PAGE_SIZE)
> +			pgsize = PAGE_SIZE;

It is actually a bug if it returns something < PAGE_SIZE, it should
WARN_ON and try to continue.

> @@ -1177,25 +1177,41 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova = dma->iova + pos;
>  
> -		phys = iommu_iova_to_phys(domain->domain, iova);
> +		/* Single page table walk returns both phys and PTE size */
> +		phys = iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
>  		if (WARN_ON(!phys)) {
>  			pos += PAGE_SIZE;
>  			continue;
>  		}
> +		if (!pgsize || pgsize < PAGE_SIZE)
> +			pgsize = PAGE_SIZE;
>  
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * Calculate remaining contiguous bytes within this PTE from
> +		 * our position, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
> -			next = iommu_iova_to_phys(domain->domain, iova + len);
> +		len = pgsize - (iova & (pgsize - 1));
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;

Things should be arranged so the iommu_iova_to_phys_length() always
returns the best length, either because it called into iommupt to get
it or because it accumulated internally on an old driver.

Probably to make this work well the API should include the last
address to reach so it can stop iterating at the right point.

Jason
