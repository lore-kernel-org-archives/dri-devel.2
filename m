Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB6CF557F4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64E110E486;
	Mon, 20 Apr 2026 09:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fCiwiy+h";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F0310E486
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:29:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so19077655e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776677362; x=1777282162;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IEZHN3EejXoq9qbRm7mjl8x1VVtWAaecGDOSe23Ifhk=;
 b=fCiwiy+hxgJz3PYB/pYn25iNhFUcv5FLTWMplt+TkL3qJzAkvJT1dWjPV3LnmZBfQW
 3seXgLNMqvsryBS7RI1UfJJ5lJtkLg8PINIFkGZi3LTZ4JKP2IL4qf2pTCgdQnJjL5Gj
 F23TziKcK8TiePuGeJE37sLZTL3K6UHPG4VTWSrHJC1ahTsEN0wF/pHUNl7tegqu9YmN
 lYa4WKLGxsRue47i4Ehoyx1Ims+Hw1j5Zh0hKyIis10hHih0Ish7sbevLLwbIdVlybRn
 c9lyRu9ubnZPy54Qowm3EN3Azy/S2OIGnfgm6AOkjo4knlvfOproCkCMIXTTKCPmI9He
 OS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776677362; x=1777282162;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEZHN3EejXoq9qbRm7mjl8x1VVtWAaecGDOSe23Ifhk=;
 b=IzwqFK6gJ28uQK+N04atCYdiNJbWhtL4cwPbjtQ3OWM+B3MkXIuFpRlX2cRyqCMLks
 nBLZbrobbVQTOhCXvw44BSE6JpQQH/V1wYda0H4SjhJxszajvc+AE8AU72vL7qqS0jRe
 cAyEYJ7srngHHTiMwIZhahVDAmkAf4FvNQtGt43zBftJQVeftWtQx7KbO1kUjqRvdzs3
 jYImz53eGqDsWAXPZ9CCLuzocRvDGAgwo8lhDZp42L2+ZGjdylPM6zYHyxTvLUX+dGnf
 FQ/Cy0Ix3JeaVRtXilFIBu7vHZZZRUKQF119oYEI45VQtpVCQFrDUt5ZCCSKPEHEwVJ1
 nnbQ==
X-Gm-Message-State: AOJu0YyjckH75gKnsYf+Nl5E8Gw+UHnukxOYjoEzDKyVk8oFpja+wHpe
 pyuTyIL3HDmdtlxUSQ+yDYOOn9SjdFgXBB7dx3RqbwgX8w2j0aVmT/6Eq2IpSzEWbuA=
X-Gm-Gg: AeBDietYLS3XlBKtk1TpCGKvxPrZEFrkgh4+It+D9jxbpRlXOylqikVbMzJZbR7unL1
 ImmXxrd3KSrohHtkw4UriW+kSYbxD/2S/yigTVpRsnYp1fE/GeVRE4OSPNKPk8+369xNH4ev+7G
 DVNwW4EQFJK53CLwyLyMqu7HcZjCDzsyHRlAfbUM97Umwj0oGwMqtUAThDtzHG/mq8v3EuPhp+Q
 j8tEBrEnMew1+6rHlyxadBJqxooFK7ZR6L10qy2PbLutZq1rv4gcI/qseo4t8/qXNgZTwyteild
 hGpvepgYIE2qm1xNG0VSZtwsD5TzOfnOntnQ6JppwBYjkzbDCK3P6jUAkKfRiuw148Ki+qaU/Uc
 HxP2pwUl+cUJvql1V7iE8iEu5yX13QLiwvQ23zfLvh4npCu9l6vRPwN3IaE2T6LUbujOpiF4V+N
 55+tJDOyIaivyS/min1IpsVB1h08qnUhfPr999F32v8MTHzg==
X-Received: by 2002:a05:600c:a102:b0:488:ba19:da25 with SMTP id
 5b1f17b1804b1-488fb759f0fmr143513465e9.12.1776677361344; 
 Mon, 20 Apr 2026 02:29:21 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75af76sm85639205e9.13.2026.04.20.02.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 02:29:20 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:29:17 +0200
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
Message-ID: <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5atst6ywbl.fsf@kernel.org>
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

Mon, Apr 20, 2026 at 08:34:06AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Current CC designs don't place a vIOMMU in front of untrusted devices.
>> Instead, the DMA API forces all untrusted device DMA through swiotlb
>> bounce buffers (is_swiotlb_force_bounce()) which copies data into
>> shared memory on behalf of the device.
>>
>> When a caller has already arranged for the memory to be shared
>> via set_memory_decrypted(), the DMA API needs to know so it can map
>> directly using the unencrypted physical address rather than bounce
>> buffering. Following the pattern of DMA_ATTR_MMIO, add
>> DMA_ATTR_CC_SHARED for this purpose. Like the MMIO case, only the
>> caller knows what kind of memory it has and must inform the DMA API
>> for it to work correctly.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v4->v5:
>> - rebased on top od dma-mapping-for-next
>> - s/decrypted/shared/
>> v3->v4:
>> - added some sanity checks to dma_map_phys and dma_unmap_phys
>> - enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
>> v1->v2:
>> - rebased on top of recent dma-mapping-fixes
>> ---
>>  include/linux/dma-mapping.h | 10 ++++++++++
>>  include/trace/events/dma.h  |  3 ++-
>>  kernel/dma/direct.h         | 14 +++++++++++---
>>  kernel/dma/mapping.c        | 13 +++++++++++--
>>  4 files changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 677c51ab7510..db8ab24a54f4 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -92,6 +92,16 @@
>>   * flushing.
>>   */
>>  #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
>> +/*
>> + * DMA_ATTR_CC_SHARED: Indicates the DMA mapping is shared (decrypted) for
>> + * confidential computing guests. For normal system memory the caller must have
>> + * called set_memory_decrypted(), and pgprot_decrypted must be used when
>> + * creating CPU PTEs for the mapping. The same shared semantic may be passed
>> + * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
>> + * DMA_ATTR_MMIO to indicate shared MMIO. Unless DMA_ATTR_MMIO is provided
>> + * a struct page is required.
>> + */
>> +#define DMA_ATTR_CC_SHARED	(1UL << 13)
>>  
>>  /*
>>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
>> index 63597b004424..31c9ddf72c9d 100644
>> --- a/include/trace/events/dma.h
>> +++ b/include/trace/events/dma.h
>> @@ -34,7 +34,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>>  		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
>>  		{ DMA_ATTR_MMIO, "MMIO" }, \
>>  		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
>> -		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
>> +		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
>> +		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
>>  
>>  DECLARE_EVENT_CLASS(dma_map,
>>  	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index b86ff65496fc..7140c208c123 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -89,16 +89,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  	dma_addr_t dma_addr;
>>  
>>  	if (is_swiotlb_force_bounce(dev)) {
>> -		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> -			return DMA_MAPPING_ERROR;
>> +		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>> +			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> +				return DMA_MAPPING_ERROR;
>>  
>> -		return swiotlb_map(dev, phys, size, dir, attrs);
>> +			return swiotlb_map(dev, phys, size, dir, attrs);
>> +		}
>> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> +		return DMA_MAPPING_ERROR;
>>  	}
>>
>
>What is this check for? If we are requesting a DMA mapping with
>DMA_ATTR_CC_SHARED, shouldn’t it be allowed? If not, how would we reach

This is defensive. Only allows to map with DMA_ATTR_CC_SHARED set to
dev dev that does not support CC natively. This can be of course lifted,
if you have a case.


>the conditional below where we convert the physical address to a DMA
>address using phys_to_dma_unencrypted()?. Also, how is this supposed to
>interact with is_swiotlb_force_bounce()?”

You reach there when is_swiotlb_force_bounce(dev) is true and
DMA_ATTR_CC_SHARED is set. What am I missing?



>
>>  
>>  	if (attrs & DMA_ATTR_MMIO) {
>>  		dma_addr = phys;
>>  		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>>  			goto err_overflow;
>> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> +		dma_addr = phys_to_dma_unencrypted(dev, phys);
>> +		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>> +			goto err_overflow;
>>  	} else {
>>  		dma_addr = phys_to_dma(dev, phys);
>>  		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>
>-aneesh
