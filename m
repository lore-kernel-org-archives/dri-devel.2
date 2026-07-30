Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F7BC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8DB10EF30;
	Thu, 30 Jul 2026 14:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="gnBooMdG";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B481810EF30;
 Thu, 30 Jul 2026 14:04:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E886B1684;
 Thu, 30 Jul 2026 07:04:03 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69B7E3F86F;
 Thu, 30 Jul 2026 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785420248; bh=wEU1Ew4XH/BxvQaEmhMOgNm0b65x54eBGoQ8x1ETvAQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gnBooMdG89T+9Oh2JkkYmYNkVq1+jO56kBBuLD5UloWmaPg9y4rn8D4yEQV4IuTtr
 prm9WKmIgQcNfCkrLMQUcX9c0Qdgmn4NaCU59/t+HD8htKHcw3DfirjTPqQWRKrRZq
 U2RyLUSRIWmo4yexq2wfYliZgv32Gn2pjGTJnpCs=
Message-ID: <7b486023-21af-4237-9b57-a0077003293d@arm.com>
Date: Thu, 30 Jul 2026 15:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dma-mapping: reset DMA ops before detaching from
 the IOMMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-2-b12fa067804e@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260730-fix-qcom-smmu-v1-2-b12fa067804e@oss.qualcomm.com>
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

On 30/07/2026 2:29 pm, Dmitry Baryshkov wrote:
> arm_iommu_attach_device() installs the IOMMU-aware dma_map_ops only
> after iommu_attach_device() has run, so a driver that builds its page
> tables during attach (msm_iommu via io-pgtable) maps them while the
> device still has the direct DMA ops: the resulting dma_handle equals the
> physical address.
> 
> arm_iommu_detach_device() does the reverse in the wrong order. It calls
> iommu_detach_device() first and clears the DMA ops afterwards. When
> detaching frees those page tables (msm_iommu_identity_attach() ->
> free_io_pgtable_ops()), the freeing dma_unmap now goes through the still
> installed IOMMU ops,

Hang on, that sounds majorly wrong...

> which treat the stored physical address as an IOVA.
> iommu_unmap() warns "region not mapped" and __free_iova() indexes an
> unallocated bitmap extension, dereferencing NULL:
> 
>    __bitmap_clear from arm_iommu_unmap_phys
>    arm_iommu_unmap_phys from dma_unmap_phys

*this* dma_unmap is for the IOMMU device itself - the client device's 
ops should be irrelevant, and the IOMMU device should never be trying to 
translate itself through its own ops either.

 From a quick look, the real issue appears to be that the assignment of 
priv->dev in msm_iommu_attach_dev() and subsequent use in 
msm_iommu_domain_config() is completely bogus.

Thanks,
Robin.

>    dma_unmap_phys from __arm_v7s_free_table
>    __arm_v7s_free_table from arm_v7s_free_pgtable
>    arm_v7s_free_pgtable from msm_iommu_identity_attach
>    msm_iommu_identity_attach from __iommu_attach_device
>    __iommu_attach_device from iommu_detach_device
>    iommu_detach_device from arm_iommu_detach_device
>    arm_iommu_detach_device from arch_teardown_dma_ops
>    arch_teardown_dma_ops from device_unbind_cleanup
> 
> This is reached on apq8064 (ifc6410) when the adreno GPU probe fails and
> its DMA ops are torn down.
> 
> Reset the DMA ops before iommu_detach_device() so page-table teardown
> runs with the same direct ops that mapped them at attach time.
> 
> Fixes: 78fc30b4bb35 ("iommu/msm: Implement an IDENTITY domain")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Assisted-by: Claude:claude-opus-5
> ---
>   arch/arm/mm/dma-mapping.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f9bc53b60f99..a467e0d01a5b 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1642,10 +1642,13 @@ void arm_iommu_detach_device(struct device *dev)
>   		return;
>   	}
>   
> +	/* Reset DMA ops before detach so page-table teardown uses the same
> +	 * direct ops that mapped them at attach time.
> +	 */
> +	set_dma_ops(dev, NULL);
>   	iommu_detach_device(mapping->domain, dev);
>   	kref_put(&mapping->kref, release_iommu_mapping);
>   	to_dma_iommu_mapping(dev) = NULL;
> -	set_dma_ops(dev, NULL);
>   
>   	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
>   }
> 

