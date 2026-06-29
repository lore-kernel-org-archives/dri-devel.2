Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C654C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E9610E80E;
	Mon, 29 Jun 2026 10:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qc27SAZ4";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D325C10E05C;
 Mon, 29 Jun 2026 10:50:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A96AA176C;
 Mon, 29 Jun 2026 03:49:55 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A40C73F836;
 Mon, 29 Jun 2026 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782730200; bh=wF6fcioGkP3XO6al5/wvWBbE3VVkjvj+GMCxkCwlGDI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qc27SAZ4DI8FopNeR7UEBCj1+ah3ZipheSF4vsZPYv5BT5XDnkSzNF0PCUgv3KLWI
 wHMiTmPh67LfydGxEP8oN7nihY2sriz0bGLkYXu0yAtdBzvymVw178CW+WKmzp1HVW
 CtUm9pE/vuXhtSd3xJmCyrNSZG5b62krhthZxOWg=
Message-ID: <050f21ea-109c-4247-b6ad-cdef906f6175@arm.com>
Date: Mon, 29 Jun 2026 11:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/iommu: Unroll unsuccessful mapping
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com>
 <20260625134342.1102921-2-krzysztof.karas@intel.com>
 <ce5f27fd-82be-4750-8592-2eeb31a54523@arm.com>
 <xajagmgqwrspthaza4zkxfgubatdg762k6icu6vwv2lzwzarh5@hxzhg7vkuc2g>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <xajagmgqwrspthaza4zkxfgubatdg762k6icu6vwv2lzwzarh5@hxzhg7vkuc2g>
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

On 29/06/2026 11:12 am, Krzysztof Karas wrote:
> Hi Robin,
> 
> thanks for looking at this.
> 
> On 2026-06-25 at 15:29:10 +0100, Robin Murphy wrote:
>> On 25/06/2026 2:43 pm, Krzysztof Karas wrote:
>>> Currently, if iommu maps fewer bytes than requested (iova_len),
>>> it proceeds to free the iova, but never tries to unmap already
>>> touched bytes. This behavior may cause memory hogging down the
>>> line.
>>
>> Huh? iommu_map_sg() has always unmapped internally upon any error - can you
>> clarify how you've seen it returning a short mapping in a non-error case?
> Yes. I applied some debug logging:
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..f166cd31d68f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1515,8 +1515,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>           * implementation - it knows better than we do.
>           */
>          ret = iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
> -       if (ret < 0 || ret < iova_len)
> +       if (ret < 0 || ret < iova_len) {
> +               printk("%s: ret = %zd, iova_len = %lu\n", __func__, ret, iova_len);
>                  goto out_free_iova;
> +       }
>   
>          return __finalise_sg(dev, sg, nents, iova);
>   
> @@ -1525,8 +1527,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   out_restore_sg:
>          __invalidate_sg(sg, nents);
>   out:
> -       if (ret != -ENOMEM && ret != -EREMOTEIO)
> +       if (ret != -ENOMEM && ret != -EREMOTEIO) {
> +               printk("%s: returning -EINVAL\n", __func__);
>                  return -EINVAL;
> +       }
>          return ret;
>   }
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a0..59163ad0bce3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2900,6 +2900,7 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>          return mapped;
>   
>   out_err:
> +       printk("%s: Calling iommu_unmap()\n", __func__);
>          /* undo mappings already done */
>          iommu_unmap(domain, iova, mapped);
> 
> 
> and ran "gem_exec_big" with subtest "single" from igt-gpu-tools
> (./igt-gpu-tools/build/tests/gem_exec_big --run-subtest single)
> on a Tiger Lake platform. I observed:
> 
> [   77.494513] [IGT] gem_exec_big: executing
> [   77.513162] [IGT] gem_exec_big: starting subtest single
> [   77.513739] gem_exec_big (2863): drop_caches: 4
> [   79.912199] i915 0000:00:02.0: Using 39-bit DMA addresses
> [   79.915571] iommu_dma_map_sg: ret = 7138717696, iova_len = 20023619584   <<===

OK, yeah, something weird is happening there... Given that you're 
apparently trying to map over 20GB in a single scatterlist, I suspect we 
might be running into some 32-bit integer overflow somewhere - we've 
certainly hit issues with gigantic individual segments in the past - 
which is then leading to the IOVA calculation and/or field-swizzling in 
iommu_dma_map_sg() itself going wrong, or the merging logic in 
iommu_map_sg(), or perhaps both.

I'd agree there definitely appears to be a bug here, but ultimately it's 
that iommu_map_sg() is somehow returning a short mapping when it should 
not, so papering over that in iommu-dma is not the solution.

> [   79.915581] iommu_dma_map_sg: returning -EINVAL
> [   82.680323] [IGT] gem_exec_big: finished subtest single, SUCCESS
> [   82.682692] [IGT] gem_exec_big: exiting, ret=0
> 
> on a first test execution and then subsequent runs would result
> DMA remap failures:

Indeed once the pagetables _have_ got out of sync with the IOVA 
allocator then this is expected behaviour - -EADDRINUSE is generic_pt 
refusing to map over an unexpectedly-present PTE, unlike the old 
intel-iommu code which would have just silently replaced it and 
succeeded, so if you're only seeing these subsequent failures since 
6.19, that's probably a factor too.

Thanks,
Robin.

> [ 1053.077620] [IGT] gem_exec_big: executing
> [ 1053.086272] [IGT] gem_exec_big: starting subtest single
> [ 1055.220807] iommu_dma_map_sg: ret = 10581184512, iova_len = 19171119104
> [ 1055.220821] iommu_dma_map_sg: returning -EINVAL
> [ 1055.343891] iommu_map_sg: Calling iommu_unmap()
> [ 1055.343895] iommu_dma_map_sg: ret = -98, iova_len = 15817768960
> [ 1055.356710] iommu_dma_map_sg: returning -EINVAL
> [ 1055.356807] i915 0000:00:02.0: Failed to DMA remap 3861760 pages
> [ 1055.509975] iommu_map_sg: Calling iommu_unmap()
> [ 1055.509981] iommu_dma_map_sg: ret = -98, iova_len = 19171119104
> [ 1055.509990] iommu_dma_map_sg: returning -EINVAL
> [ 1055.636194] iommu_map_sg: Calling iommu_unmap()
> [ 1055.636198] iommu_dma_map_sg: ret = -98, iova_len = 15817768960
> [ 1055.648844] iommu_dma_map_sg: returning -EINVAL
> [ 1055.648955] i915 0000:00:02.0: Failed to DMA remap 3861760 pages
> [ 1055.800664] iommu_map_sg: Calling iommu_unmap()
> [ 1055.800670] iommu_dma_map_sg: ret = -98, iova_len = 19171119104
> [ 1055.800679] iommu_dma_map_sg: returning -EINVAL
> [ 1055.924869] iommu_map_sg: Calling iommu_unmap()
> [ 1055.924873] iommu_dma_map_sg: ret = -98, iova_len = 15817768960
> [ 1055.937634] iommu_dma_map_sg: returning -EINVAL
> [ 1055.937729] i915 0000:00:02.0: Failed to DMA remap 3861760 pages
> [ 1056.042152] [IGT] gem_exec_big: finished subtest single, FAIL
> [ 1056.042736] [IGT] gem_exec_big: exiting, ret=98
> 
> which would cause the test to fail. Rebooting the machine is the
> only way I could get the test to pass again.
> 
>>
>> Thanks,
>> Robin.
>>
>>> Correct that by unmapping before exiting.
>>>
>>> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 381b60d9e7ce..c4c058ba07ef 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -1515,8 +1515,14 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>>    	 * implementation - it knows better than we do.
>>>    	 */
>>>    	ret = iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
>>> -	if (ret < 0 || ret < iova_len)
>>> +	if (ret < 0 || ret < iova_len) {
>>> +		if (ret > 0) {
>>> +			/* Unmap partially mapped bytes before freeing IOVA */
>>> +			if (iommu_unmap(domain, iova, ret) != ret)
>>> +				ret = -EIO;
>>> +		}
>>>    		goto out_free_iova;
>>> +	}
>>>    	return __finalise_sg(dev, sg, nents, iova);
>>> @@ -1525,7 +1531,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>>    out_restore_sg:
>>>    	__invalidate_sg(sg, nents);
>>>    out:
>>> -	if (ret != -ENOMEM && ret != -EREMOTEIO)
>>> +	if (ret != -ENOMEM && ret != -EREMOTEIO && ret != -EIO)
>>>    		return -EINVAL;
>>>    	return ret;
>>>    }
>>
> 

