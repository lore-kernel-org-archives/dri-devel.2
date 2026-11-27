Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E92606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GnfGF1Q1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A12010E501;
	Fri, 27 Nov 2026 12:58:03 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDDC10E583
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:57:56 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-55dc111ae86so15898201cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795784275; x=1796389075; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
 b=GnfGF1Q1YoLVuVibHwheewiZKr6/C6qK9uXodI7fXBp8T07O2W1RqbbWfEa92Iascn
 4UrYcU2yF/PRMiZie98BPe3fLG+VL2AgTllB94Sh1poYuJFWdA4wZnnTq7b6nG/8qzRW
 LhreyYEe0bobFzCGzrn3di9uznjmos3LuCWVCuiSCjhOZ3uTyf+ubgtzOwmHDKWMqnC2
 WqBYf6GmLQRU2vE8ce8aZybU32LJKaqIBh98MwX56/li2JL3Ijt9SMFTgiQrxYGU03dX
 uQ+rnZ3uXPB3iYVdHSN9rCIygPaNPpjJRCrUrc1YYLaXp+g1Pin6GzsWEmcipd6pM0VJ
 jzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784276; x=1796389076;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
 b=sSQdz8Zdnwzo/kmiUJPnZqaEcZ95HjYgkWqYLHp4BEf6MkL1Tmsp/IW5gh8gM/tNSE
 8fLi+42KrTy6RWYFPS+cAwDnKNrKxqM04rcWNMCBSNMO83UA1ymXZ7AwMcnXn5UFCqrp
 IqzLGoFih4R+mwzI/PMFjQZAve96+sjAp5i3nIOtWAe049NxYAPQV7gjHvK6mKLyNnkv
 nmd9FBAYcne+mGZ3YUCV1c9JhnrW2ziOBhbwx2faBz8joMJfyqUqOrwXfnTeAgc/B/lc
 i6SP+SwVdrZGfGk97W+QhtxRBwgstVohEjmR3A9uX7QsM0cIA1BHug2rhjy9VznLCdeO
 1MQw==
X-Forwarded-Encrypted: i=1;
 AL+hErFO6ckZjBRgSkpzV8Fbg/NWqBmGDGo5TQPPbBZRJlv6s+2P3ijo89VatCpYaJmFvwaWrbUqOocZJnM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LBBVCxsGjVyJoQktBVf/NAGEzYSHJKVryye9Olm6RGqJ4dXOi
 XXdIhkGJDFfXfWifo6Pzzpea7b7d4SqxhMztSoRB/rdkz9K3AKx9zz4dSOZegjSMYz0=
X-Gm-Gg: AZFdTZe6tUbEaUxges9VvPkCIAjHsAPPMujEvEXFQe2C1IHDiTQmf7vWFWr2PuzWTP5
 /HXr5KxN+GLQQDUz28LsPza2ygRTPRyiGGxcwCE+gKZ1X1G2/k3T31mZ0+rrVLPtIqlN/C6lVs7
 OXTBd+cRnw3Wq9WegDi89XQatLD6gPNxRyMmiER32pYXDmQ+M0rD+j7LRX36HSLbj1iKvKC4drC
 2LZtG1rLdt+b8ou3BEHt/Fd3z8vIEnZxy9KPNmSCA6HG6NZonSAZXrgsnNB9lgDcUmyq0rSihh7
 GZ4vsrAU4YN1pjbD8xrUA7qOz2+RYJbahrJ2+6p97GgwizosXY2xyrMbhgZKKur2w7baYJycJ9S
 HTp6xuAfnFhKVXgMW4YkeFBNKRTvuvM/pa1/V3Yb7rBSL5bUtl06W8GJnIJu7WGdXx7jR3gIHqT
 h78/XWoECFGkQwtBMDU+a5qIlYs7FL0TgNCTZjye2NICwIts0OJkkInkAftwu8vbDKLYJ2YGdAg
 4/fe3DbIPnY7q6BlH2ZcX94kPbEmQIhPrIEpfE6cKU4NX2Ih0gysFh1Hah3xVAfYeijAvo7KXFj
 +NO41A==
X-Received: by 2002:a05:622a:48d:b0:55d:3689:913 with SMTP id
 d75a77b69052e-55d76aad14fmr455567241cf.77.1795784275571; 
 Fri, 27 Nov 2026 04:57:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55dbeae112bsm55627651cf.8.2026.11.27.04.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:57:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xWvWT-00000006hYF-3LIW;
 Fri, 27 Nov 2026 08:57:53 -0400
Date: Fri, 27 Nov 2026 08:57:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>,
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
Message-ID: <20261127125753.GS246011@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
 <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>
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

On Fri, Nov 27, 2026 at 09:04:15AM +0100, Christian König wrote:

> If we somehow prevent the CPU physical address from being casted to
> a struct page and/or used with vmf_insert_pfn/page/dma_map_page
> etc.. then there is not much of a problem with passing around
> physical addresses.

I already offered that in v1 of the series using limits on
EXPORT_SYMBOL and you NAK'd it too.

> > If we need to shared object backings and have clearly typed and
> > negotiated on what the backing contains then we should allow it.
> > However I mostly agree on the mapping thing, I'd want drivers to
> > negotiate and natively support whatever backings they can rather than
> > having an intermediate trying to handle the conversions Not saying the
> 
> Yes, exactly that's my concern as well. We need to avoid this middle
> layer trap.

You avoid middle layers by having reasonable subsystem helpers for
things to use to build their stuff, especially to encapsulate common
patterns. These helpers are part of the subsystem, or in a related
subysstem helper library.

In Linux terms middle layer almost always means something wrapping a
function pointer callback into a driver and enforcing specific actions
on top of that. The recommended counter is to have the driver perform
the actions with helpers and not wrapper the ops. It particularly came
from the block world where they stuck something like SCSI after the
block ops but before the driver.

It is hard to see that DMABUF is anywhere close to a middle layer.

This is also why we don't understand your remarks about
dma_buf_phys_vec_to_sgt(). Of course it belongs in dmabuf, it produces
the dmabuf spec'd mangled scatterlist that only dmabuf uses. Where
else would you put this code?

> > code doing the conversions can't be a helper, bit it shouldn't ever be
> > autoamtic or outside driver control.

I think you do want it automatic, if an exporter is new and makes,
say, a dma_addr_t[] and the importer is old and wants a sgt, why
should we be open coding anything in every driver to deal with this?

You can argue if it is automatic because the driver called a very
general helper or automatic because the helper is wrapping a callback,
but that should be a fairly minor quibble not a huge thread full of
NAKs.

Ultimately DMABUF has a fairly simple flow:
 1) Allow importer/exporter to negotiate what kind of interconnect
    they want to use (PCI, ualink, etc)
 2) Give the exporter enough information about the interconect path to
    make a placement decision
 3) Describe the exporter's buffer so any mappings/translation/etc can
    be setup for the importer
 4) Program the importers HW.

Many of these have very common patterns, like PCI GPUs always make the
same kind of VRAM placement decision in #2 based on P2P support. This
should all be in helpers under the dmabuf umbrella and not open coded.

Jason
