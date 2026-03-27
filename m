Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC110ED64A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B677810EDD7;
	Fri, 27 Mar 2026 12:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="iXqPy2T2";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602E010EDD7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:10:24 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cfdac74050so255765985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1774613423; x=1775218223; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mfIjIsS8DDjImfR7uqLq3DxooHT40pwlydrjxj52iHU=;
 b=iXqPy2T2LBmMXkrkJrVprU1gy+mvUANbs68zTirdWYWzvTNY+zSXYRU3N8JtGcgULx
 O9zuuXnfUfulgLIt0Zq2EIbBx7KyQHIKfiN3oACpYaGxR7jpl7SXt/t7TMX1PtSPB1PF
 WAFcM4QG2+vuo3hdS6dNiKtbdBtmht7hP/8oWMXjOFnwCSOUObEgL5kbiEx++7QoTSHj
 4jC/NVJJp1zQ7WmDfy+NpzUePEPp+6sixkcOL1YIBs5LnyehvaQwVuPifPUU5MJAhR0y
 sgrOfTg6eEXOYhuBThG3dmKAX/7hduJMc8ceAk2Ay4/zY6G0ibX3ZhDoxwp0VIohxOLb
 kPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774613423; x=1775218223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfIjIsS8DDjImfR7uqLq3DxooHT40pwlydrjxj52iHU=;
 b=qu2fSOAT3zMHykMoe+rYcN0amvc/y9vitCLz/rQu/09jnVMT+b9Lda0V0NGaM7HujD
 KRI08SYeeR2Z0Gwzpp9uSQsZDtbSGdKB6Lsu0xWhGiQt1SN+7IK54LgxMUF1CgbcsnAd
 6r92QS6dWgjF9NEIj7YSCwEk+hFPrt5bj5sNq5pVm2XKxrFQoSsVXHu6N5yM8qTb7aFw
 STL386WfbDevDgtQGS+qbNBu8dtHzBfYlPZC6MEWYDUOfiUQapHf734iuVUyV6bLMxDO
 OoVk2S26wtfQ5I9xMEk3eMrzdNFcx095qgm0rDVf5PfYF1XsN+8oC1qlyynBTr7Z0Eia
 LAnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWf2mMvjWiazAQKXNwi71D3+RBJpxRPQsmzhZ1W5lC8p5YPkM41uzwpkTLF9Rx2qGqMDU9FcX8r1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgnmFQhjO8ra3Fg8ftRq1hFCF6+P3IrXOjGetfbY7JE8BeT4mH
 koRQUyqp0dauyPBPsjirgrHtH1YHQ8WSTPb0JbB34rqfNPTRIi4NY4YB5HzXwqN9a+k=
X-Gm-Gg: ATEYQzxy1QkgELQekK+jSeHmD/ne0TDRonaH9Ovvhcfh+Eze40VheXQw0WazbOA4ZvX
 UaIrExORftAKH24Dp6fM1RiJdR52qEHLxEHI1lpJfcaXGXZNpmszP1ls3+ASmulfvasHhZ6vkdw
 kOLSt/BDg2QIJ7nq8eh/X8c2VnLP39oqz9vaFtUNpI7XssXsIB+7nCmvZGYca3+i4tYLAHwRiqC
 jzvmmBj4+5vPRziLUibEOZd/YZMtnMkV0xBFE7q2f+HZtkjxgagfl4lLrIGf+vJvSLGMInwGArN
 d8JT4BllJwQQAiQTOpnB6ITl51kM/453058PI0X0zr1v53ERWEXNgeZZFITxkJ8Vlwvt/veKuOj
 XnhCe68I6gctE0d1anEB08x8HD7ZUOe0joVH9jEJjSmkBFCf0iuepyEYXJu6vEB6i4rsijVZPPJ
 Hp3eWAZQHMjOOTEBxTi6HbYkyaIwQfbCI1XZUVpEFP9b5xl9XrSFCKxDv96lurFAoYJZOe+g==
X-Received: by 2002:a05:620a:4589:b0:8cd:6175:9b17 with SMTP id
 af79cd13be357-8d01c5bf3ffmr259778785a.3.1774613423032; 
 Fri, 27 Mar 2026 05:10:23 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e3c3a0dsm507700285a.13.2026.03.27.05.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 05:10:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w6617-00000001CcJ-1QAP;
 Fri, 27 Mar 2026 09:10:21 -0300
Date: Fri, 27 Mar 2026 09:10:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
Message-ID: <20260327121021.GB246076@ziepe.ca>
References: <CGME20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3@eucas1p2.samsung.com>
 <20260325192352.437608-1-jiri@resnulli.us>
 <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
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

On Fri, Mar 27, 2026 at 10:38:10AM +0100, Marek Szyprowski wrote:
> On 25.03.2026 20:23, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> > run with private/encrypted memory which creates a challenge
> > for devices that do not support DMA to it (no TDISP support).
> >
> > For kernel-only DMA operations, swiotlb bounce buffering provides a
> > transparent solution by copying data through shared memory.
> > However, the only way to get this memory into userspace is via the DMA
> > API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> > the use of the memory to a single DMA device, and is incompatible with
> > pin_user_pages().
> >
> > These limitations are particularly problematic for the RDMA subsystem
> > which makes heavy use of pin_user_pages() and expects flexible memory
> > usage between many different DMA devices.
> >
> > This patch series enables userspace to explicitly request shared
> > (decrypted) memory allocations from new dma-buf system_cc_shared heap.
> > Userspace can mmap this memory and pass the dma-buf fd to other
> > existing importers such as RDMA or DRM devices to access the
> > memory. The DMA API is improved to allow the dma heap exporter to DMA
> > map the shared memory to each importing device.
> >
> > Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d
> 
> I would like to merge this to dma-mapping-next, but I feel a bit 
> uncomfortable with my lack of knowledge about CoCo and friends. Could 
> those who know a bit more about it provide some Reviewed-by tags?

I'm confident in the CC stuff, I was hoping to see someone from dmabuf
heap land ack that the uAPI design is OK.. TJ?

Jason
