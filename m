Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06751FF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFFA10E052;
	Fri, 24 Apr 2026 22:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="SD2MaP7T";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E273C10E052
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 22:55:16 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-899a5db525cso65839356d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1777071316; x=1777676116; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw33gELuGUNq59I/OY2f7G4Yqpl4DyjVQaY1TU/E47I=;
 b=SD2MaP7TRXy7TLVAGNqOrOwHPD6KfpPbklsYbqXdITVOPpgLvYOE0RoimrN1+wThgE
 0N2GqPfdw2ZuMtm7DmEhuG77ChiexNsd+M3M5tWf4aWde84O41VPeAomZJN6WBjkHyy+
 cCXPJS3hPzByaRZiNzlpELD3Y8VS1VR/2dkb7f4dHxrci+2U4D2LMyoRfNXVXhF6Pir0
 RL/jaFlLG6cJ7hqXfUNQUkUKr0Cj5lXurh91AHPUdrMMpWe3SilyllMRuO8C8PTyhhc6
 X/VDPcr2NHQscezZm3tb3dKmUR4Ywz5TvXIwiMTxO5JpvZZXcHU+ot0Ge0JrjwwKsMSH
 L9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777071316; x=1777676116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dw33gELuGUNq59I/OY2f7G4Yqpl4DyjVQaY1TU/E47I=;
 b=B7XrWkn4no2/qAovn+GgoqtqsWZJqKuDaMOWASNgOMd1jrMtCZfcroWvXsvWJM6IVn
 md92jJSi7ubdiriAyfXINXJM0xSL+ZVbscS5Qa6rRztR8iP8V0snwnPu/dZH6/0T21kK
 mezF6GCK2Rd7eXbdas/D2scIr/aDN5SqB8E4DZ+a9AmGYXE4ankUdf83dgjnMVdqWwGn
 RiAIDeUKEMsVjMC6PNz0i35qDJC9OAIdpqBatAMaa0eVsrtiXdmndrT9K9owRP7wGrF/
 EG4+wEnxd+8hRA1MimxwD14EaFFXDtEqD2g5COK8Byk3lePeqCZ3zuR+zrfjQt7q8ZKI
 LjyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vuCLqj3xfnKkf5lDBbjS0Dr4/eSAAFagfK1dCbGftDur3roXGZkRuszHbsmr4I0Jpzjx8DWOo2L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaQPY1dILLIbJmIuO85MicoU65p8l9wjEJLBaQO7L9GenyLNUk
 yHhN7CGC9hcQ4OQXCylZm+1d0TXXTyecjigViQIUJZKdXXktso22otd9xhzOiQc98AU=
X-Gm-Gg: AeBDieuD+aNEZ7bFiECPTh2+RW1LBPWtsi/l4+bEW7Z+lJ3+Si+hpZpgC+jHdMTMZ7n
 dR8M5ilfsmKtS5pOLk1qo5+J50By7FjVU4Mhv61ihONM4sYbQ/CzrgOWMoChX3YncJr5GK6vEUl
 X2g6dLR6/qODzcRRkae4Ee9qUrrdMwi+QqfK2/FPd7M1SujE41iEg8nK3AEMbwDLvzDMhG50Ig0
 71l82WGtk8jbDNjn0Bei8kuwhyow33E5bgcdpZro/RU6lDAVJl/QjOa3tli3MkDWggG0K0va36U
 UQR8sYgoAsd1NAVLmkd+afB9t1y8uF3n4lX4HAwbcZPQKoIxN0iOKOQjbo4JY16b+gJ2NRkRg94
 rHsRypiUHugoAAcZ1YTZHbJo/ncma9l5CmJMzYabwyYzCXIBRWtgA3lZHi5/owo39pLscosVo/o
 RNgP3rK65IW4BfH600KOPAR2w5/w7oleVuta2bRJ2Nwxk3dVKl7w4izBeO4oSp4i7i5O3aLZi7B
 ty/DutRjuHsCEmg
X-Received: by 2002:ad4:5f0e:0:b0:8b2:2474:8f3a with SMTP id
 6a1803df08f44-8b224749034mr37604816d6.25.1777071315667; 
 Fri, 24 Apr 2026 15:55:15 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac78513sm198480506d6.19.2026.04.24.15.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 15:55:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wGPQY-00000004wIG-2XfJ;
 Fri, 24 Apr 2026 19:55:14 -0300
Date: Fri, 24 Apr 2026 19:55:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260424225514.GE804026@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca> <yq5aik9jcpzm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aik9jcpzm.fsf@kernel.org>
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

On Wed, Apr 22, 2026 at 02:48:37PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
> >> >> You reach there when is_swiotlb_force_bounce(dev) is true and
> >> >> DMA_ATTR_CC_SHARED is set. What am I missing?
> >> >>
> >> >
> >> >So a swiotlb_force_bounce will not use swiotlb bouncing if
> >> >DMA_ATTR_CC_SHARED is set ? 
> >> 
> >> Correct. Bouncing does not make sense in this case, as shared memory is
> >> already being mapped.
> >
> > It is a little bit mangled, there are many reasons force_swiotlb can
> > be set, but we loose them as it flows through - swiotlb_init()
> > just has a simple SWIOTLB_FORCE
> >
> > Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
> > selected for CC reasons. For instance if you have the swiotlb force
> > command line parameter I would still expect it bounce shared memory.
> >
> > Arguably I think this arch flow is misdesigned, the
> > is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
> > the correct API to check if the device can DMA to the presented
> > address, and it will trigger swiotlb_map() just the same without
> > creating this gap.
> >
> > Jason
> 
> Something like this?

Yeah that reads pretty sanely.

> static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> 		unsigned long attrs, bool flush)
> {
> 	dma_addr_t dma_addr;
> 
> 	if (is_swiotlb_force_bounce(dev)) {
> 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> 			return DMA_MAPPING_ERROR;
> 
> 		return swiotlb_map(dev, phys, size, dir, attrs);
> 	}
> 
> 	if (attrs & DMA_ATTR_MMIO) {
> 		dma_addr = phys;
> 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> 			goto err_overflow;
> 		goto dma_mapped;

I suspect P2P is probably broken on CC because this doesn't make
sense..

This should flow into the
phys_to_dma_unencrypted/phys_to_dma_encrypted block as well AFAICT, it
shouldn't just assign phys. Assigning phys to dma on a CC system is
always wrong, right?

It is is more like

        /* To be updated, callers should specify MMIO | CC_SHARED instead of
	 * implying it. */
        if (attrs & DMA_ATTR_MMIO)
	   attrs |= DMA_ATTR_CC_SHARED;

        if (attrs & DMA_ATTR_CC_SHARED) {
 		dma_addr = phys_to_dma_unencrypted(dev, phys);
 	} else {
 		dma_addr = phys_to_dma_encrypted(dev, phys);
 	}

        if (!dma_capable()) {
            if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT)
	       fail
        }

> and dma_capable() now does
> static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
> 		bool is_ram, unsigned long attrs)
> {
> ....
> 
> 	/*
> 	 * if phys addr attribute is encrypted but the
> 	 * device is forcing an encrypted dma addr
> 	 */
> 	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> 		return false;

Yeah

And with the above little edits it works for MMIO now too.

Jason
