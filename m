Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3346CCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEA610E318;
	Thu,  4 Jun 2026 14:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yd9UYLIL";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A921410E2FA
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:27:08 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-91574384cc2so89778385a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780583228; x=1781188028; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHKibgV+RCLusPgB3KbLwXXB/tqYgf/ZSAW8CwOeGIc=;
 b=Yd9UYLILHN9f/wc9pDnJwHXKBuU6i6ZkzIwCxvf2j5c16E+EB6yq7q/hdzdwiQYm+b
 VnA9F3CuokjXgEVqcxyPO5FXguXGmnyuwm/nD4Ikr5kyxnoY0uMLHTUsToud97oASUV1
 1V95kgvWp8QxDl07BYBdeJNeOIZrDo5YxlTTKquJRcdhDJ7zMyz0AoSDLHRjkjlNJXBZ
 8ZeuzrrEFWMID3G+OCiY15trF20zErDu8DmndPxzfK05PyOjxtoOh6WoNR1Dghsy/DC5
 Wr7vFIXQlSa2+nh/TB73DZdxVU84OO+dU7fR+OrEOvN8pSWiHiY0Sm7YYN2qiMdgxBfq
 F6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780583228; x=1781188028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHKibgV+RCLusPgB3KbLwXXB/tqYgf/ZSAW8CwOeGIc=;
 b=mFz/z02rzavzri9fdrkBywpmhIEAzIDMCXFKtBlCnjsnx8czvqCL3HOUkgkSQ4BMus
 e2sGVXEHr3TavtGg4u4YwAaP+1AI34xBEmnlKeizmggsRKB26snbRDnm9av938h9IwuS
 oidnn4QN2QexZPggAkwy08CQFxi0fe0I22UgcvJZm4cKQ3vcQcLuVpdd0q710+1kmbmV
 3uu3ogvrFJSkxsfKdNaK2R5sxdTcOLjEKuouY8OwV8yFL+kT/s6LHYtDCWDIVEyY8icG
 XaJi/znZl/olIeoGH4IREXJoMJ3X2KbhGMczhN8tQpIZTylV5LYZYcSftMTcbbVuU9vt
 ir7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WRZJUoLFdgcAkhJJVI4kvsTLFzOkGMtr28eWDiITuWlfuuteBYYMydZV1cea8OWCCiQZF1b4MKh0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3+cPoFd12jvRNRmkdlmLwMhXXjmPONcg2q+2vXJ6YhOjNqsSn
 f7TGLSUiI+CMbbF2npBqm7XVuFizX6W4X5skoGdVBKUzjFJHUD72c8n/nEN7RNDwyP0=
X-Gm-Gg: Acq92OFZdm9L8+wd78XAvGdDBViDuLxtyyVQengLWJwOYFiqtj/4AdC+bEyIIU1kWh1
 n2Wk52aisB4utmhV4DoSCxcBDmW1ch79o3+QWdddA0dNwyKPGA2vwu/fzmLDu/WNgS5b0NBnEYp
 GoNfGBuuXL9k5FOyer7iAOUGGHTaPVN/8kuenGEttBUahXusUtBg3d9DntYSTGWvl4WjZKxll8E
 YP8Sm6HXcQLvqdOsKLEN2qkvHAF060XzoR05i172pCt869FaiBX1bxaig1gR8IRbUpgYnrqZ/fL
 jM+ZAIH18JC736p93k7YKEUloyJ+ZfUt9hSfejm8KO10fqfhbldumCfJ8VwmqEYTO3aM/wigCpr
 cB++CJoSOCZHzZIsjn4p1/uEtvECsCgbg3oI30D5HaWd+FBPks2oCGx0gp4c0qkLs0ihYg5moJD
 NEXb7H/xp4cjckxeXcN6iLqYj2tqM2rDKWoUgCgz7jj5xZ1h7DtTUmSx6gcbznDCPYi7ttJ2wmU
 al/Y438nrxT4tjKtq+svCN2KQU=
X-Received: by 2002:a05:620a:6cc2:b0:90f:b39e:ec8 with SMTP id
 af79cd13be357-9158a6998c8mr1313811585a.17.1780583227568; 
 Thu, 04 Jun 2026 07:27:07 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3e0d55sm600410185a.43.2026.06.04.07.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:27:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wV92I-00000008IGV-29F2;
 Thu, 04 Jun 2026 11:27:06 -0300
Date: Thu, 4 Jun 2026 11:27:06 -0300
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
Subject: Re: [PATCH v3 23/32] vfio: use iova_to_phys_length for efficient unmap
Message-ID: <20260604142706.GZ2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
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

On Wed, Jun 03, 2026 at 11:17:55PM +0800, Guanghui Feng wrote:
> Use iommu_iova_to_phys_length() to get PTE page size, allowing
> traversal by actual mapping granularity instead of PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba54de3..115d88d7003e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1177,25 +1177,42 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova = dma->iova + pos;
>  
> -		phys = iommu_iova_to_phys(domain->domain, iova);
> -		if (WARN_ON(!phys)) {
> +		/* Single page table walk returns both phys and PTE size */
> +		phys = iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
> +		if (WARN_ON(phys == PHYS_ADDR_MAX)) {
>  			pos += PAGE_SIZE;
>  			continue;
>  		}
> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize = PAGE_SIZE;
>  
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * mapped_length already accounts for contiguous entries
> +		 * from iova, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
> -			next = iommu_iova_to_phys(domain->domain, iova + len);
> +		len = min_t(size_t, pgsize, dma->size - pos);
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;
> +
> +			next = iommu_iova_to_phys_length(domain->domain,
> +							  iova + len,
> +							  &next_pgsize);

vfio should not be calling it twice, the core code needs to give the
best length as efficiently as it can. not open coding this in callers.

I think I've said this three times now

Jason
