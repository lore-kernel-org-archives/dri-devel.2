Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A46F3380F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55A710E428;
	Tue, 17 Mar 2026 08:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WkaUyXTv";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6860210E424
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:26:26 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso46961555e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773735985; x=1774340785;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xf2CUvi8YSfRB4MbEru11u5aBtMS7TuUP2oF3ZpZ3ic=;
 b=WkaUyXTvcGPBlvcWXP+yjKjwqpq5IQGrSNn5fwStULeY4v98OGD3dj7aSZ0dcvtLqr
 7pUewTQ6x0Gh3kZdNnFlh9crtr2PvjSf362yAQu/ZDeaHRCnJ6lIHhRVmNl9q4M4xwVl
 poHWqgAtp4e8xCW65BStNbMkH7IarxVieXMbL+Qg22B7QZkADLl3zVMBWQReIDks/ufh
 HvwDjprsZCheUthm2Kxsqwt5b9Pb9LbvSgK+Fwdbk2n/Yq8+EC747WP9kbqxCNhlRsAu
 h+fWsj3kkQshObPXKNUpQCZ8zMEEnMyo0r1hmK0ZTOGyCevXTBKsTpzzxMIZ5x43OvxM
 SF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773735985; x=1774340785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xf2CUvi8YSfRB4MbEru11u5aBtMS7TuUP2oF3ZpZ3ic=;
 b=j3wdPLOHFZrv0AVpdDa/NfHyopE2aJO+P8mCqQcowmiCR+7oCWtQlI3BknnuzFbqjV
 uYB+Stsa51qpm7Mqc7W2D2+ZPg1daOAlIT8oQqJPGG1dUZxuaw8Kx8diZTR61dSzBF2F
 EwdGqga1j17KuG1k6DBzuesgGoEiDKFTR3U7oyOkiyQ0XlK+boVi7nuGz193GINl6W/p
 5PyPidOaLzjIJV/85km8QsOFpkUmJ+TIsOgfwXUOR7Gr3cJffUV4qh3l0XbN0Vf7j5XA
 7nqyC+rHHmAqJBxZN1ITDcNtOID1p3Ppmsb0Yvnye42SPyOQHI4PnPu9Y5lXWsL28ga1
 6crQ==
X-Gm-Message-State: AOJu0YxvDpepc7X0tJlMk04R23JhlHtAozuP3Sj/T8evQo710SbLg5ER
 TafGZ9zAQzbDbLV3h0ZuzqnF+JP6KiKNq2zZc/Y/6ZgiNOiHczqL5a3/sdvi1hGbDBk=
X-Gm-Gg: ATEYQzzw5i7+MDuqtAqIzmGLZhlM5wYTtT7dHadsjsM/Ok/Z5XrdUku44Mg3pAZUBB3
 cdD81SMpxSIQqpQrxHsYPSVJ4LqsM/JoGaX/hBALl6V1GcT0Gvh+sqGYnPH9gOo7BJK9SjJyVRm
 mw/O1D/0GWtMRBDa87i6QSzXRjhcHrHDJidewtWbrBM3ZHt+fLkAa/2JdhdU4KEabVTn7ruDn1m
 4vPWwTsB07oycima42TxoUKymHRwwIVFUhdDFWHhTK26VEwDQYAohsXYeD5dnmKzYf5KKkbKulV
 OyK7XIkwzTonB2bmXn2dCep3jSFBzMcfPodAqoiUnn/vBm0IuwKrNdHfypXH/EFqllDKRq+hnQC
 3xue/r/7TehtHBruNL7BXCs5OKCkJq5CA4qDJteWM4GN3XRfS+63vsC1RQmcRVZWua3WhPn5hXU
 fBO8iC5nYlzujMIJPf7i7ZoeHtMpxBuM24c+G91IVohqI=
X-Received: by 2002:a05:600c:c8f:b0:485:3c05:24dc with SMTP id
 5b1f17b1804b1-48556710c02mr263331735e9.33.1773735985061; 
 Tue, 17 Mar 2026 01:26:25 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:81f8:c391:4972:647b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea97e8esm52842845e9.5.2026.03.17.01.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 01:26:24 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:26:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, jgg@ziepe.ca,
 leon@kernel.org, 
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com, 
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, 
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 1/2] dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for
 pre-decrypted memory
Message-ID: <lufy3ppgiy7637iravgzabajj67chmqvg22qc3fd2yqe2p33ws@b54vibhehth2>
References: <20260316125857.617836-1-jiri@resnulli.us>
 <20260316125857.617836-2-jiri@resnulli.us>
 <15fcfa5e-c4b9-4b56-8f84-20dd5f66d643@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15fcfa5e-c4b9-4b56-8f84-20dd5f66d643@arm.com>
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

Mon, Mar 16, 2026 at 07:25:55PM +0100, robin.murphy@arm.com wrote:
>On 2026-03-16 12:58 pm, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Current CC designs don't place a vIOMMU in front of untrusted devices.
>> Instead, the DMA API forces all untrusted device DMA through swiotlb
>> bounce buffers (is_swiotlb_force_bounce()) which copies data into
>> decrypted memory on behalf of the device.
>> 
>> When a caller has already arranged for the memory to be decrypted
>> via set_memory_decrypted(), the DMA API needs to know so it can map
>> directly using the unencrypted physical address rather than bounce
>> buffering. Following the pattern of DMA_ATTR_MMIO, add
>> DMA_ATTR_CC_DECRYPTED for this purpose. Like the MMIO case, only the
>> caller knows what kind of memory it has and must inform the DMA API
>> for it to work correctly.
>
>Echoing Jason's point, if the intent of this is to indicate shared memory,
>please call it DMA_ATTR_CC_SHARED. Yes, some of the existing APIs are badly
>named because they conflated intent with implementation details; that is no
>reason to keep wilfully making the same mistake.
>
>At least with Arm CCA, the architecture enforces *confidentiality* pretty
>much orthogonally to encryption - if your threat model excludes physical
>attacks against DRAM, you can still have Realms isolated from each other (and
>of course other execution states) without even implementing the memory
>encryption feature; conversely if you do have it, then even all the
>shared/host memory may still be physically encrypted, it just has its own
>context (key) distinct from the Realm ones. Similarly, while it's not a
>"true" CoCo environment, pKVM has a similar notion of shared vs. private
>which can benefit from piggy-backing off much of the CoCo infrastructure in
>places like the DMA layer, but has nothing whatsoever to do with actual
>encryption.
>
>Furthermore, "shared" is just shorter and more readable, even before I invoke
>the previous discussion of why it should be "unencrypted" rather than
>"decrypted" anyway ;)

Okay, fair points. I'll rename it to shared for "v5". Thanks!


>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - added some sanity checks to dma_map_phys and dma_unmap_phys
>> - enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
>> v1->v2:
>> - rebased on top of recent dma-mapping-fixes
>> ---
>>   include/linux/dma-mapping.h | 10 ++++++++++
>>   include/trace/events/dma.h  |  3 ++-
>>   kernel/dma/direct.h         | 14 +++++++++++---
>>   kernel/dma/mapping.c        | 13 +++++++++++--
>>   4 files changed, 34 insertions(+), 6 deletions(-)
>> 
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 29973baa0581..476964d2b22f 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -85,6 +85,16 @@
>>    * a cacheline must have this attribute for this to be considered safe.
>>    */
>>   #define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
>> +/*
>> + * DMA_ATTR_CC_DECRYPTED: Indicates the DMA mapping is decrypted (shared) for
>> + * confidential computing guests. For normal system memory the caller must have
>> + * called set_memory_decrypted(), and pgprot_decrypted must be used when
>> + * creating CPU PTEs for the mapping. The same decrypted semantic may be passed
>> + * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
>
>That being "the vIOMMU" that you said doesn't exist, and which is explicitly
>not supported?...

Yeah, I wanted to draw the full picture. I can put a not like "(when it
is going to be introduced)" or something like that to be clear.


>
>> + * DMA_ATTR_MMIO to indicate decrypted MMIO. Unless DMA_ATTR_MMIO is provided
>> + * a struct page is required.
>> + */
>> +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
>>   /*
>>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
>> index 33e99e792f1a..b8082d5177c4 100644
>> --- a/include/trace/events/dma.h
>> +++ b/include/trace/events/dma.h
>> @@ -32,7 +32,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>>   		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
>>   		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
>>   		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
>> -		{ DMA_ATTR_MMIO, "MMIO" })
>> +		{ DMA_ATTR_MMIO, "MMIO" }, \
>> +		{ DMA_ATTR_CC_DECRYPTED, "CC_DECRYPTED" })
>>   DECLARE_EVENT_CLASS(dma_map,
>>   	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index e89f175e9c2d..c047a9d0fda3 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -84,16 +84,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>   	dma_addr_t dma_addr;
>>   	if (is_swiotlb_force_bounce(dev)) {
>> -		if (attrs & DMA_ATTR_MMIO)
>> -			return DMA_MAPPING_ERROR;
>> +		if (!(attrs & DMA_ATTR_CC_DECRYPTED)) {
>> +			if (attrs & DMA_ATTR_MMIO)
>> +				return DMA_MAPPING_ERROR;
>> -		return swiotlb_map(dev, phys, size, dir, attrs);
>> +			return swiotlb_map(dev, phys, size, dir, attrs);
>> +		}
>> +	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
>> +		return DMA_MAPPING_ERROR;
>>   	}
>>   	if (attrs & DMA_ATTR_MMIO) {
>>   		dma_addr = phys;
>>   		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>>   			goto err_overflow;
>> +	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
>> +		dma_addr = phys_to_dma_unencrypted(dev, phys);
>> +		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>> +			goto err_overflow;
>>   	} else {
>>   		dma_addr = phys_to_dma(dev, phys);
>>   		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 3928a509c44c..abb0c88b188b 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -157,6 +157,7 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>>   {
>>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>>   	bool is_mmio = attrs & DMA_ATTR_MMIO;
>> +	bool is_cc_decrypted = attrs & DMA_ATTR_CC_DECRYPTED;
>>   	dma_addr_t addr = DMA_MAPPING_ERROR;
>>   	BUG_ON(!valid_dma_direction(dir));
>> @@ -165,8 +166,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>>   		return DMA_MAPPING_ERROR;
>>   	if (dma_map_direct(dev, ops) ||
>> -	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
>> +	    (!is_mmio && !is_cc_decrypted &&
>> +	     arch_dma_map_phys_direct(dev, phys + size)))
>>   		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
>> +	else if (is_cc_decrypted)
>> +		return DMA_MAPPING_ERROR;
>>   	else if (use_dma_iommu(dev))
>
>...although, why *shouldn't* this be allowed with a vIOMMU? (Especially given
>that a vIOMMU for untrusted devices can be emulated by the host VMM without
>the CoCo hypervisor having to care at all - again, at least on Arm and other
>architectures where IOMMUs are regular driver model devices)

Well, when iommu path is able to consume the attr, this restriction
should be lifted. This is basically a sanity check for the
dma_map_phys() caller.


>
>>   		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
>>   	else if (ops->map_phys)
>
>Or indeed any other non-direct ops? Obviously all the legacy architectures
>like Alpha are never going to see this or care, but I could imagine Xen and
>possibly PowerPC might.

Same here.


>
>Thanks,
>Robin.
>
>> @@ -203,11 +207,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
>>   {
>>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>>   	bool is_mmio = attrs & DMA_ATTR_MMIO;
>> +	bool is_cc_decrypted = attrs & DMA_ATTR_CC_DECRYPTED;
>>   	BUG_ON(!valid_dma_direction(dir));
>> +
>>   	if (dma_map_direct(dev, ops) ||
>> -	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
>> +	    (!is_mmio && !is_cc_decrypted &&
>> +	     arch_dma_unmap_phys_direct(dev, addr + size)))
>>   		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
>> +	else if (is_cc_decrypted)
>> +		return;
>>   	else if (use_dma_iommu(dev))
>>   		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
>>   	else if (ops->unmap_phys)
>
