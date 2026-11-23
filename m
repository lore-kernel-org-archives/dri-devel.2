Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963F606A338
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gC4FdWUQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA7C10E53A;
	Mon, 23 Nov 2026 16:57:24 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AD210E53A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:57:18 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-9496400270fso334159485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795453038; x=1796057838; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
 b=gC4FdWUQIkp8XkC2othmWWiR4p4NdW04zySqz727AbSirFysjTBiiOcNfgvyd2epdr
 oSGSRMxzVzpnc5QvF/nLjYu+K18jJzgX4dDGfokGgHPfxCGD3+CJuLgvpuHwAl/VMYqy
 VbUWspgRs7fIb4Wvq2mACbx3B+BZakc+GWKZ8sRqQ0FXXZ6Vh83Xlab+5FUyA2SzAAYs
 IPt8otyg1z3oqSzYMh/c5i267qZwlIXxZgHpT3otg3qNCsEipx0yqGamGqGVt6hS1rIW
 gmwCRCHqtm033xpEbZzEuf+o0PoJrTxs+EV93bQ9nBKdsv+S2ZuoPco8WR4HjtBCdSBN
 nkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453038; x=1796057838;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
 b=OtCC0qAeW/m+do51INv5vHUMaL93LTzk0Vgwuh7Lrfc05ubVoydFKBa3o6ojmA46z3
 zvzHmi1MnsVJwtQC1XIjbkW7ZLzYNhtSDIG4fd/cyN2qBNqZTr3Y7AuxTz2flDrvEOFg
 I06u81jApJeA6sGLOtM3q74xT+zqO0dQ+eBxjSW29y5UpvD55ZIuX+asLUxF+nOONS/A
 Zn9QjFEPEJaGGM24ioNjeqOauzjNVAJDudfh/wZHooVTApa6hio/RNdvB4lxNFsXgZXF
 i+5L/u8cXgDNvppFottfQq9A4c/1aFGIQKwGjWB2z8/TnFrlbPHDD0R63lICAnQ0sO6Z
 /CtA==
X-Forwarded-Encrypted: i=1;
 AL+hErFUfjCekoHoLKvcT2xhYR+KKHk1D0Hmn9EwJS8tiHqkHy1U6opSp85eITgrmuGFak24HvOZzy3Gb50=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+fJB7HU3kCXvQ4FjqP0PHAxlKpXT95bWEVs7lFXTQ1cEn9VWDG
 TNLYEIEteDU/76eD6A/o0rmReqL3+9KKVM3AB8iiMGkvJlqBwhDkZh59a56teP59prY=
X-Gm-Gg: AZFdTZfVTgmwl32jEiOkzt1bveAqCMSIFo80XOLpir9unLBNWyMq9w7ej4sD91XIZVF
 dnGesNcKx/AQXae7ciKosbNcQgNQ/sJZD7QUQJRLJ4m3RAAndzrPdEoWhKZIlry9vPdgwUhDCjP
 SDIvRVw1i+9qBoSLNWGXkY5QSV2Zh3wLdwE2bZMWG7cPQjK62mSkXkFXwpnNcpXq8ytwk8+Jd8U
 PJRxkCbeavV5DLAjqPHXPWAxDD6TdCv84PNeCycUZ79kiXvgBXe15kpUIgaHsdmK1gVnpsuK5iY
 a2j2YoWbBIxSyTKxpyWjTQFhMZXDWgK2f+eBGCVr2nNTMLeITpLaTjsiTmCWkUw3/pkcUZ1B7BH
 Hnleb+RtzxdN4667FWaSWjY1RmRV9un62/iyZmShlY57R4ikD1RBrZpdeaN4VNZJCotSh2nd0R8
 x0XOTLhlYVOe831+svVeWG3T8wgxP3RSeGDR1GFuQWvNVE5cnXRvzj+Jjkz6n9H2hUBxrLAEmri
 icz2p1piZvFC/UKLmTofxUXD9vYVK4MOhNClOg9zmeeAM764Dp8SOSX/f7ngXsmpBJPVqmJ5kpV
 TJeA3FE0HYqn3COeetZdKfSmUECVDwvomTkxkPHyQYi78OlUYgOjQMD618OHVdkcy4y/6TTShyt
 KFg/Vl3+irjR6NEnV330hwM4d
X-Received: by 2002:a05:620a:270d:b0:949:8109:8bcd with SMTP id
 af79cd13be357-949bab6d24dmr1950593985a.77.1795453037117; 
 Mon, 23 Nov 2026 08:57:17 -0800 (PST)
Received: from ziepe.ca
 (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.142.59]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb031601sm844162485a.6.2026.11.23.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:57:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVXLw-00000000woc-0Jy7;
 Mon, 23 Nov 2026 12:57:16 -0400
Date: Mon, 23 Nov 2026 12:57:16 -0400
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
Message-ID: <20261123165716.GM179082@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
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

On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian König wrote:
> On 11/20/26 06:55, Alistair Popple wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > The SGT (Scatter Gather Table) DMA mapping type represents the existing
> > sg_table/scatterlist based DMA mapping. For now it continues to use a
> > sg_table for map/unmap, but this will allow a future patch series to
> > convert to using a different data structure for importers without having
> > to convert all at once.
> 
> I strongly think we shouldn't have an SGT mapping type in the new DMA-buf mapping API.
> 
> Instead we should have something like either an array or an xarray
> of DMA addresses.

My plan was always to get there, but I don't think it is reasonable to
start there? There are too many places all over the place that are
just hardwired to do SGT right now.

Part of the design of this series was to allow the conversion away
from SGT to be done incrementally without breaking compatibility.

So it is effectively this:

> The framework should then either connect the SGT directly if both
> importer and export are using the "classic" interface 

And this:

> or convert
> from DMA-addr array to SGT and back if either of them are using this
> new interface.

Is something I imagined as a followup series.

As this is actually quite complicated and needs discussion exactly
what it will look like.

Jason
