Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B482CF8FA62
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241BF10E830;
	Tue, 21 Apr 2026 11:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="JsseHArN";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5AF10E830
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:53:37 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so5227925e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776772415; x=1777377215;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qNffUEYXS7MvbYQg9u+kJhedqyXiIXCWwUXLFzfDV6w=;
 b=JsseHArNXYkUPhAbOc+Lcp3PAMObg+3g++kHcg/9bbOJ99g6xpy/s27p5xKr+xdyl5
 LWJUKax8Ylgh3eJoo+Htf2d7MnzdEXwZUi28myL7ejIRL63kWjRD4B2T69L4aCkpRrHc
 V/O22vSkh9VY3P2joPLwPmLjnDysig6qR9C6xGjxDgSn4gJkIu2cdo7QWICUkHEkfL1P
 epVql3iO6FnXiDUVZYhnOt+SRZbjLpXwVPNsJLeeuzAAkfCe6Xva4NGZXi0pf9YwM92x
 cbs53cPnp6PPgd5xUR5IBkpdUyK589KNBdPZoCf2Oc4QUAg5z1/8Y0Be4GPXxYmmFZ2r
 makA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776772415; x=1777377215;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNffUEYXS7MvbYQg9u+kJhedqyXiIXCWwUXLFzfDV6w=;
 b=rc1dxlZEB6sdhZrFdksCBtGkztlC7hm6gIRAqGx58JiusFh6SieQY8OccKCrCrblb7
 bde+TYDfmuWE0S36ORqSfiZGSS2auqO4rI9tbBwFmD88qgQ7DcLVXYP+bGuVo2y+Iax/
 JIUX4wjlUct2fifJ4ceRg85BWUROT1pwVDZ5kQkHOpCeUW7k9JMkk/XkOMjNd0YNxp2+
 8gYBForKYG+cL/Nzx/yfET2YBGujcsfKUz5+guV3ZJMhWbXTyBcJ5TPj3tLJUJwlw9iQ
 avb4+Tl+eCKvrER4vYtG8q5KaklGKLZ01RJHgyVPwKfQDUkFAYVvlaAAmEkQc6qtsn0r
 DC4w==
X-Gm-Message-State: AOJu0YyDcCQuEfcwzfsZEi9lWeCXaSKGF8mE2ssFjYIgOP9iiNNkbX03
 a49zxckD7ufNr0v2lMWUAQju0UIy5bdG5fRYMrCPuf1/9xi/BKzAVOryrD5EspwxJU0=
X-Gm-Gg: AeBDietC3Y+8M7IOYEjpzqNA3RysBFQw73eoLxqE73Cw+ad8/Ddjqs28Ak2Tlyg33YN
 rXYrFlUGzMTnagVAxL5y6NkjWb5q2QC1HkKCfhgTYfHJd7ll7RJGd7Hcegr4z01mOCSN0DxtzIG
 4BSPV1tdY+MAtsOQuGX2Ufdfe21jljaC0RrIijBIvhu9zmphv2O2j3NyRaV0+lPdwMzxBAKRNR5
 6aRSuvxIMycAXg/6Qclxdm1NhoMH4CRzj0fr/oem6pH763R2Dq4iUSbYEYG56aT7aLakayZ/1P8
 V7rx1cQ6SBpb9UYxlsAWaCYFI8IxoZ69pcUqzIPZN89Mm7CmeLPxBhGix057WohuHhTrvzU/VDF
 TQFzn0bf4I+fnmaiqHPAhXoTa+2LdhjJl1v+cjxzLgB6ysFJF3yqnb6OJ49YHH6YQd9RLhkksZL
 gLxmkRI1KD1/Fa2Gp+cUX43oiQXl4BDo7/R52jv4Boc5A5KYddprLHT/OX
X-Received: by 2002:a05:600c:c0c8:b0:488:a824:fe04 with SMTP id
 5b1f17b1804b1-488fb787bfdmr196331065e9.26.1776772415404; 
 Tue, 21 Apr 2026 04:53:35 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489e124f6c7sm34968855e9.29.2026.04.21.04.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 04:53:34 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:53:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, 
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, suzuki.poulose@arm.com, steven.price@arm.com, 
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5awly0d504.fsf@kernel.org>
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

Tue, Apr 21, 2026 at 11:42:03AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> Mon, Apr 20, 2026 at 08:34:06AM +0200, aneesh.kumar@kernel.org wrote:
>>>Jiri Pirko <jiri@resnulli.us> writes:
>>>
>>>> From: Jiri Pirko <jiri@nvidia.com>
>>>>
>>>> Current CC designs don't place a vIOMMU in front of untrusted devices.
>>>> Instead, the DMA API forces all untrusted device DMA through swiotlb
>>>> bounce buffers (is_swiotlb_force_bounce()) which copies data into
>>>> shared memory on behalf of the device.
>>>>
>>>> When a caller has already arranged for the memory to be shared
>>>> via set_memory_decrypted(), the DMA API needs to know so it can map
>>>> directly using the unencrypted physical address rather than bounce
>>>> buffering. Following the pattern of DMA_ATTR_MMIO, add
>>>> DMA_ATTR_CC_SHARED for this purpose. Like the MMIO case, only the
>>>> caller knows what kind of memory it has and must inform the DMA API
>>>> for it to work correctly.
>>>>
>>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>> ---
>>>> v4->v5:
>>>> - rebased on top od dma-mapping-for-next
>>>> - s/decrypted/shared/
>>>> v3->v4:
>>>> - added some sanity checks to dma_map_phys and dma_unmap_phys
>>>> - enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
>>>> v1->v2:
>>>> - rebased on top of recent dma-mapping-fixes
>>>> ---
>>>>  include/linux/dma-mapping.h | 10 ++++++++++
>>>>  include/trace/events/dma.h  |  3 ++-
>>>>  kernel/dma/direct.h         | 14 +++++++++++---
>>>>  kernel/dma/mapping.c        | 13 +++++++++++--
>>>>  4 files changed, 34 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>>>> index 677c51ab7510..db8ab24a54f4 100644
>>>> --- a/include/linux/dma-mapping.h
>>>> +++ b/include/linux/dma-mapping.h
>>>> @@ -92,6 +92,16 @@
>>>>   * flushing.
>>>>   */
>>>>  #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
>>>> +/*
>>>> + * DMA_ATTR_CC_SHARED: Indicates the DMA mapping is shared (decrypted) for
>>>> + * confidential computing guests. For normal system memory the caller must have
>>>> + * called set_memory_decrypted(), and pgprot_decrypted must be used when
>>>> + * creating CPU PTEs for the mapping. The same shared semantic may be passed
>>>> + * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
>>>> + * DMA_ATTR_MMIO to indicate shared MMIO. Unless DMA_ATTR_MMIO is provided
>>>> + * a struct page is required.
>>>> + */
>>>> +#define DMA_ATTR_CC_SHARED	(1UL << 13)
>>>>  
>>>>  /*
>>>>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>>>> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
>>>> index 63597b004424..31c9ddf72c9d 100644
>>>> --- a/include/trace/events/dma.h
>>>> +++ b/include/trace/events/dma.h
>>>> @@ -34,7 +34,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>>>>  		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
>>>>  		{ DMA_ATTR_MMIO, "MMIO" }, \
>>>>  		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
>>>> -		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
>>>> +		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
>>>> +		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
>>>>  
>>>>  DECLARE_EVENT_CLASS(dma_map,
>>>>  	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
>>>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>>>> index b86ff65496fc..7140c208c123 100644
>>>> --- a/kernel/dma/direct.h
>>>> +++ b/kernel/dma/direct.h
>>>> @@ -89,16 +89,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>>>  	dma_addr_t dma_addr;
>>>>  
>>>>  	if (is_swiotlb_force_bounce(dev)) {
>>>> -		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>>> -			return DMA_MAPPING_ERROR;
>>>> +		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>>>> +			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>>> +				return DMA_MAPPING_ERROR;
>>>>  
>>>> -		return swiotlb_map(dev, phys, size, dir, attrs);
>>>> +			return swiotlb_map(dev, phys, size, dir, attrs);
>>>> +		}
>>>> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
>>>> +		return DMA_MAPPING_ERROR;
>>>>  	}
>>>>
>>>
>>>What is this check for? If we are requesting a DMA mapping with
>>>DMA_ATTR_CC_SHARED, shouldn’t it be allowed? If not, how would we reach
>>
>> This is defensive. Only allows to map with DMA_ATTR_CC_SHARED set to
>> dev dev that does not support CC natively. This can be of course lifted,
>> if you have a case.
>>
>>
>>>the conditional below where we convert the physical address to a DMA
>>>address using phys_to_dma_unencrypted()?. Also, how is this supposed to
>>>interact with is_swiotlb_force_bounce()?”
>>
>> You reach there when is_swiotlb_force_bounce(dev) is true and
>> DMA_ATTR_CC_SHARED is set. What am I missing?
>>
>
>So a swiotlb_force_bounce will not use swiotlb bouncing if
>DMA_ATTR_CC_SHARED is set ? 

Correct. Bouncing does not make sense in this case, as shared memory is
already being mapped.


>
>>
>>
>>>
>>>>  
>>>>  	if (attrs & DMA_ATTR_MMIO) {
>>>>  		dma_addr = phys;
>>>>  		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>>>>  			goto err_overflow;
>>>> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
>>>> +		dma_addr = phys_to_dma_unencrypted(dev, phys);
>>>> +		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>>>> +			goto err_overflow;
>>>>  	} else {
>>>>  		dma_addr = phys_to_dma(dev, phys);
>>>>  		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>>>
>
>-aneesh
