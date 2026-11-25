Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FA606A333
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CIfTQ+qT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9096910FD5B;
	Wed, 25 Nov 2026 15:56:07 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AAC10FD5B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:56:01 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-55c5b6584ceso44443321cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795622160; x=1796226960; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
 b=CIfTQ+qTqxCqL9Lh+B85DZ+JCaYPTPRnqVyQBv1uklC0zxAIPJ1/EvjCxAt7A0gBCa
 PpN2wx9Qi9LwOehuVVESJs9sFeUWBGnYDIMwZ2u44TRpK+muqFYuAFvszFKqGt6RCZxE
 1Nzl4GwMmLIy4pVoDtYVlPjikX6FOXf3bvy7CR30G7iy6AChchJrcJIrLqjhXw+V/KgA
 uGrosfUorlV2lbiYiq9ERWU8hTjD7YnLFyZLeKY7841uyulZEQE2iTUUlLtdhgOAm59C
 /Ua/OoGvh/dGSO10cN0+b2ZihS2s1cafwNRDmmb1u5rg9snQl4zfqalLFI5D0CpaWqnc
 pTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795622160; x=1796226960;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
 b=o3bOFz0dyC/X1CLSfVmpB6NMgMsSnXstXmD3+cGol3l32WSxo1y6DmEZghxGnxsCXK
 x/ABY+EOwIcpxAnHyW0GEgQJp5uPQvo9HvulJhdp1CwFHDjK5K8b9EXEUO1Dmj+m4p/f
 RLpgw9bEkQ/oUfPg3l6/UfoOMZlqD96zLO3FShHEQH9Gr82ZVvQOs7s2OqGukB8B8Hmn
 ds6pO712nm/8tlb+6UyfEFMVfs13TGaLAAGlKgiIlaHJpHcDe19KF1p2Q8V/QwZgt+ys
 PIBxw2aorkkPpSjpTl7ldO/2wFReq3XOJ4EI9wc2kOgyS3ciqUARVfRlwZWYmnCt9RJa
 k6wQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF7hbiJDhp+ORE9W3DFB9/a1FFYON1v+17v6FGNXm0a4F0CDWQ9vTPRPzdGK+KFq+ZmdaCemiGhX2o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84MpxFP40IRWa8LMMCLqbLw0uR2chYM0ZKVH7w6JbQQGRCIcE1
 PoYY4hQHI04poJyVdzAh6n8081Q46AIYB+0QoIA7ATHlJ7xt4ihhoGkCRXaXrZnpFS4=
X-Gm-Gg: AZFdTZfUKVJxZpvt+LgWgMeUgaB6r0uuK/gDlWO8x2+7MRNW25OrSjkw5tA5yzfMq3l
 6lfj2nS+jLWCdEbjn2WwFmQao2LnDs3PU+4WBex9LxGexZlnwpqleOcT66yhXyTV4B0HLbCQ6j2
 jp1NvjzGUgbtLscuiYvoQa6zAhLj4Oo+T7JQcmVUWeHWq3jO1I5xXjH2dqQIxTeko23fcjsd/bk
 +IX0n7TW6RKc2Gu7ZeLB+ros2kOGHKBUjU0k10o3c9A2V/s1/3XfnX4wPVqfpz9BDEeDVl97XV4
 9/Tbq/mar78HN6qs6t0WkzJUdAT0IG9GSr1ualET8j/JHEjz9ywzMPKY/MqbgUzrImUO4li65g2
 1dUeioZo8kxRu7ZvGWYxx8B9o5NdL1rVE7xBSRxbUSHgzwrEaqdYvMrMT6lX/3GIIIbwJJZ1Ck2
 gZoqpNOPJv3pXJhOIbSPXtMya+SnOKxuRmLKmXphFFYFFRNNFLS4CD8B6/ZTb124XfAAmt5EFXk
 l0OQHpoVztOI6eYeON8Bbtva+HSBrZhUZ/8LWyfazQf+ReWPd1RF+nF7gVNaVYnrsf1KbVGi8Dm
 ATyCo3RqgsuoRh3yUaJHYDeVHMA=
X-Received: by 2002:ac8:5d89:0:b0:536:5696:e8c8 with SMTP id
 d75a77b69052e-55d769e4561mr347501161cf.28.1795622160509; 
 Wed, 25 Nov 2026 07:56:00 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882bf70sm160274901cf.11.2026.11.25.07.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 07:55:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xWFLj-00000001uyg-0aUM;
 Wed, 25 Nov 2026 11:55:59 -0400
Date: Wed, 25 Nov 2026 11:55:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
 treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
 Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261125155559.GL246011@ziepe.ca>
References: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> The low level API which talks for example to the IOMMU driver for
> creating the information how to access the buffer is simply not the
> task at hand for that framework. The stuff we already handle is more
> than complicated enough.

No matter what name you give it we need something in the middle that
can see the phys_addr_t and the iommu_domain..

If you don't want DMABUF to be that thing, then I'm not sure what you
have in mind.

> > If I drop the type/placement negotiation for now and focus on SGT removal I can
> > simplify things a lot. Plan would be something like:
> > 
> > 1) Introduce a new C data type (dma_phys_list?) for exporters to pass physical
> >    location info and context for mapping.
> 
> Something like this maybe?
> 
> struct {
> 	u32	mapping_type;
> 	u32	num_entries;
> 	union {
> 		dma_addr_t	*dma_addr;
> 		u64		*generic_64bit_addr;
> 		...
> 	};
> }
> ....

"phsyical location info" means phys_addr_t and related, not
dma_addr_t. Step #3 has it as the *input* to dma_phys_list_to_sgt().

The flow today has the exporter get a phys_addr_t (ie a struct page),
build a scatterlist and directly invoke the DMA API.

The primary issue here is the exporter *direct* call to the DMA API!

We cannot disconnect this from the DMA API, ie to use an iommu domain
or ualink, if exporting drivers are hardwiring calls into it.

Fundamentally the need is for the driver to get the phys_addr list,
exactly like today, and then pass it to an op which formats that into
the right data structure for the importer. Be it dma_addr[],
iommu_domain, or some ualink_addr[] - or whatever.

This is the main issue here, disconnecting the exporters from being
hardwired to the DMA API.

That's what Alistair is explaining. This sequence:

> > 2) Introduce two new dma_buf_ops - map_dma_phys_list() and unmap_dma_phys_list()
> >    - which are replacements for {un}map_dma_buf that converted exporters use to
> >    return a dma_phys_list instead of returning a sg_table.
> >
> > 3) Move dma_buf_phys_vec_to_sgt() somewhere other than drivers/dma-buf and
> >    rename it dma_phys_list_to_sgt().

> > 4) Update dma_buf_{un}map_sgt() to call the new map_dma_phys_list() ops and
> >    dma_phys_list_to_sgt() to create an sg_table for unconverted importers
> >    importing from a converted exporter.

Effectively converts all the exporters to produce a phys_addr_t, and
then moves the DMA mapping action into one single place in common
code.

With one single place we can figure out how to replace it with a call
that does an iommu_domain:

> > 5) Add dma_buf_iommu_map() taking a IOMMU domain/iova/offset/size to be called
> >    from iommufd for mapping an attachment into an IOMMU domain.

But that relies on iommu_map having access to the dma_phys_list *which
is true physical*

> I think a whole bunch of other drivers would be really happy to use
> that interface as well, yes.

Right, that is clear now, that it is not just iommufd that wants a
dma_buf_iommu_map()

But I don't understand at all how you imagine to implement
dma_buf_iommu_map() if you don't want this in the DMABUF core code.

> That totally sounds like a plan to me.

I'm confused if you agreed to what Alistair said :(

Jason
