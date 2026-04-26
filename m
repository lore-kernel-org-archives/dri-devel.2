Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02014FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C5210E1BF;
	Sun, 26 Apr 2026 13:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="glE7GLfE";
	dkim-atps=neutral
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDF510E1BF
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 13:05:34 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-612d8a59cc0so2935884137.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1777208732; x=1777813532; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mZgLj8cyLE1pTCqai3ecepNuqq+WdEKm5C7L8MuPHFc=;
 b=glE7GLfEQ52gYj5ZOU6FhLmz1BtJn0HFG3bLAGnk3XDBQOiAPl0nn/d3RnsiBrfUAE
 AcCJpeGdZVumX+np3MEsYzlqxWIIcpEFitA7ENrGEQIZ+0ugcEHQwlxb6mw579dyW7LC
 MB/uV8Ojr9TWiZ/ALqEBsv11cnu00OdonXVKNCcp/Q+/hId65k9gVnj2Oa0HltvSynGY
 mB+t8u29uQ8z61q3kp1+78u9Mn/Az95CdxSQ94qS5TURzEoYbzIF+1g1k8nqYi0rxqKq
 tDGSnDmkU0qMfu9/6Nkucpm0FzZoMumy2k4OEZhYns+1Jm4ZnrNnPAc5LZiKExEtBW0w
 47vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777208732; x=1777813532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZgLj8cyLE1pTCqai3ecepNuqq+WdEKm5C7L8MuPHFc=;
 b=KyPEg/bq83avWSAUpBo/9ah/97ZjweuhxOel991RriNbM4F+KtvAvUY48RQGQ7SSsb
 6u1rqrZUwcFJj17BN21OW3o1u2HFVoQ73WagmMvHHZUb4fNG9+XSvk2xrRLLR6UiNHrG
 y9DmKa2MIucXmOPY96JmTOot1E0Jkx786en2NFmOlBGo1iDrdWotwkuEZkFWIkqmO/gj
 XY5V15cJdJq6vBJwF2SkAfQH91kf5ypu4s51fbrW+v50yMszSLEYu0dQfMQD/qnYUC+R
 PQECyLO0vf64Hwf3yvlLrZR+zvZy3/SE1zcsTLxQy7trrivHWpN7sS4HhcPlBVDCdRS1
 yCbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6DC7XjNsEo3Ob3kCdQUIRKN09052/At1NDb8Zp0Fe6/muHpzzYTPsZYbMhQqVr1lVA3yUMJcpWcY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLjcQxEQOW95vybSeQm3HKQjeG887xbz3ImUXdcPOATH5OcA6k
 GwZ94ShO9T55QTojQUr7hLE8qFnvH6ZUPo6eqThh4YFGB86hfHQikuUWAKnTfPkMtKk=
X-Gm-Gg: AeBDiesQ5Ri1Hwucyy6iVOcPM1B3w939wOyChHTQSt4xEYkR1OTatiszN/pB02pCbzf
 EmXTaUo6H5G8ON+3c79cb8UT5N7sASAVmMl0i//7b304LeoO98PVX5mgkSKxoh+RWOyb66iCuPp
 SUAOZKYMnmiuO6HeavlnC5oawzvOq/0rgkubWwARp3A+B+45hRm05/Rpx6fqGY3XpCfRdMYwhuf
 KdtBCQBvlzIcdH9jVv9wdTjSzKrejz0MWzPLou3uqsKTvp90AExn0ArPscByT0o3E3GwBiWaT/R
 Rju6V62CcRyIp8v/u8XOm+D6zzZxXtQmza+LqowFespfEKTqWD4EqflfXhy774cKLcyIeylFxoF
 W7HyQ9WCfkoRz8CdHwk4MjL5Vxuj55wfE6OCfXCvoA7nt5FvZosf13SyDk7dUsjD6JCjFaAEJbe
 YU9WerbXfH/Au5UVad0iGQ5I1t04ICA/QU/cv/u7rNtC5DwSHhFv0x0oFeTNCgAD2CDcIZrdgp7
 HUjE/vQt6kK9CVB9mYx17cdRmA=
X-Received: by 2002:a05:6102:5e94:b0:610:1239:f6d7 with SMTP id
 ada2fe7eead31-616f772efecmr18253527137.18.1777208732488; 
 Sun, 26 Apr 2026 06:05:32 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae7df88sm249063966d6.35.2026.04.26.06.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:05:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wGzAx-0000000Egs5-0CBA;
 Sun, 26 Apr 2026 10:05:31 -0300
Date: Sun, 26 Apr 2026 10:05:31 -0300
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
Message-ID: <20260426130531.GF804026@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca> <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424225514.GE804026@ziepe.ca>
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

> > static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> > 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> > 		unsigned long attrs, bool flush)
> > {
> > 	dma_addr_t dma_addr;
> > 
> > 	if (is_swiotlb_force_bounce(dev)) {
> > 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> > 			return DMA_MAPPING_ERROR;
> > 
> > 		return swiotlb_map(dev, phys, size, dir, attrs);
> > 	}
> > 
> > 	if (attrs & DMA_ATTR_MMIO) {
> > 		dma_addr = phys;
> > 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> > 			goto err_overflow;
> > 		goto dma_mapped;
> 
> I suspect P2P is probably broken on CC because this doesn't make
> sense..

Actually, I suppose it is fully broken because it will jump to swiotlb
and then should fail.

> This should flow into the
> phys_to_dma_unencrypted/phys_to_dma_encrypted block as well AFAICT, it
> shouldn't just assign phys. Assigning phys to dma on a CC system is
> always wrong, right?
> 
> It is is more like
> 
>         /* To be updated, callers should specify MMIO | CC_SHARED instead of
> 	   * implying it. */
>         if (attrs & DMA_ATTR_MMIO)
> 	   attrs |= DMA_ATTR_CC_SHARED;

So no need for this if, we can go directly to marking the MMIO callers
with DMA_ATTR_CC_SHARED once this is fixed for mmio:

>         if (attrs & DMA_ATTR_CC_SHARED) {
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
>  	} else {
>  		dma_addr = phys_to_dma_encrypted(dev, phys);
>  	}

Jasn
