Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCFAC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B6410E0B5;
	Mon, 28 Sep 2026 11:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OV6a/ktM";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D2DEB10E0B5;
 Mon, 28 Sep 2026 11:26:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F4B153B;
 Mon, 28 Sep 2026 04:26:14 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7B53F763;
 Mon, 28 Sep 2026 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790594778; bh=7/AMTqVC3MySC6YP56SSfAfMueyYBMWAxyiEfjrQuIg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OV6a/ktMgcixkd4gu++FtkOypRSqjrAqTH8439eWB8VGMp/uqTVjAFRVl2AqtfC9P
 nvet8kZ2FD5ur9efuc4sG2wsl0gjGRmaOiKn/xml0z/SqtTtSQgy4sr4VYgc5QDdh1
 KOFj0rvczbAJLTpEaSNlKUBIol0mJct1+irn8cUc=
Message-ID: <47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com>
Date: Mon, 28 Sep 2026 12:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] iommu: export iommu_get_dma_domain()
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 freedreno@lists.freedesktop.org, iommu@lists.linux.dev,
 Dmitry Baryshkov <lumag@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 Bryan O'Donoghue <bod.linux@nxsw.ie>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
 <20260928053901.7270-2-liujianfeng1994@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260928053901.7270-2-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 28/09/2026 6:38 am, Jianfeng Liu wrote:
> drm/msm needs to recover the physical address behind a DMA address of
> imported dma-bufs: with CONFIG_DMABUF_DEBUG=y the attachment sg_table
> it hands to importers carries no struct page, and msm has to translate
> sg_dma_address() back to a physical address through the attaching
> device's DMA-API domain to map such buffers into its own pagetables
> (see the follow-up drm/msm patch).
> 
> Export the helper so modularized drivers can use it.

NAK. Read the comment - this is an internal helper for iommu-dma 
(currently the only IOMMU_DOMAIN_DMA implementation) and is definitely 
not for random drivers to abuse. In fact it should really move to 
iommu-priv.h now that we have that.

If you want to do sketchy things with your device's DMA domain then use 
the public iommu_get_domain_for_dev() interface like everyone else.

Thanks,
Robin.

> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: iommu@lists.linux.dev
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9af..330f9a79248bd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2327,6 +2327,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>   {
>   	return dev->iommu_group->default_domain;
>   }
> +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);
>   
>   static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
>   					  struct iommu_attach_handle *handle)

