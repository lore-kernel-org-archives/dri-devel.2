Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F33C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2C510F4A6;
	Mon, 14 Sep 2026 22:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="HNh4BAvq";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B88910F4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:10:28 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-90e9e042ee1so44516086d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789423827; x=1790028627; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3XZNUGEs58um27ogp+l/DHH3zgdwh/5Gz7nOI7x+eE=;
 b=HNh4BAvqP+8nPZA8VE40Yjtegg22khQBewXwjKCjm/S3tASPj36X6tDXIIaoKDVy7Y
 KF5W+kkx2camS4oQBayrI+51Y0ZUEQ1tcPqXXg2c/GbLNnbsVCt87tW6s47DZ1gj8oTJ
 vKAzQi4Q+GmDm4VmU+5wI5LdtD9R1Yw3g/Zg/aVZ9Uff8kBAxqSODPFlOvH4qPjaghEx
 F5ejqKUONAoGUk/DaXqhGdmnr79jXt7seGd4DoHTcxspS+sSKaks2VxjJenKAwGP9J8X
 2xGyQtKVmZ+NN8oRGCEZsmBPsEu6GYKyiLof/vJC7LXkdZkcVPZ2Rg5bO5fAF2QCqJuW
 gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789423827; x=1790028627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J3XZNUGEs58um27ogp+l/DHH3zgdwh/5Gz7nOI7x+eE=;
 b=BqHIuR4sw2epCc8LMXCMoM9siBsBxbTCsabv2aYvViOy00MPO1oqoeqLFAIX36n/sR
 L/AT7Yw8k2ywe0toONPyN/BIof/kqiSTb3PKKZX4Wqh0GIf1oV/ux9d6ws49qm1ayzxG
 /9LsVgrXDGDw/3PHKI72c1FvWeVB2pTShwcmt+sB3nGPYU+C1hUCKZlhsD2ZWlWTfLuv
 3xX2e4TNt+8s6e9J34HD2yyukXuvuTFu1Wp53vFWjQtoSS1MNMtZtHSb9+I0zRXsIlgo
 b6SmzINAKQOmDZXphHMyZYHDn6toixVn1UXlgc+mQ4SInlrL1PTR+1sD50Ic/YobK2I4
 poGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSBzqWE8xs3CdjekNc2VTuU77CX3uqeqliEYdGe7e/DH+JhRjFXQYBZg3xXdrPDeSBdRz/LccGs8M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYGRp6BvyXvbpb+mRLBmrXOCi7/TYKt/1cWddmWFkTAMSBREDN
 P+ho2Agl/HQuRyltJGGL++BSdZC+daIFt391xQSuwRrxThnoJXURjc4HpOqs1VvxvwQ=
X-Gm-Gg: AYBFou0O6dkj6CVFJd7GaJHd5c6eDjG4ah5tP8mnu6y89e13689t7pQiRjHRtu4LkWn
 2Go/puV68XrPfLuhghkIn2B0RBWq6hz1dKx3+00T4P+WrpKuRtQzl0jiS1r5T+g2vn5VoMmYYAU
 NL+jPcqPragGD8mWx2dKbQLxtcx3nRGf5h6r+rNUm4/3o4rdWxlZ0KRxmHJKxEM4ni17PNRKHxv
 q9wk6HRF076UEdI0vOUBQSjgsZKZnWr7Nuf5afN7axgcDxBLvXzXHZCt/odPLNnbmivhDVyx7tA
 JyWWRP4ZF1Wkx97dvZzDF5oLEjuDDfMJ0YRM3eAsvFwMMTQIfe6yJota6yr0KHP8aSdGtTEHXCR
 w76b5dFPe1hUaNCFpMetEP5AGgd1qabWKeZ6JHSyUOFoOhSZE4vgPL3d/pLXxXp4Wx/A+JgHm4O
 lRwz7hvuVnnjXugonrrD7xJxo9ROOZmE33/Yas1AEUvLUQ7wQ4m/GVlWE1XHArVPpCVKkfnqUgv
 zSdd8Hia/tY6pXRxycIlqbwzgIzsfJzTJzPttfBwihS34xgNsjV5whyr5jOdPqQr0s=
X-Received: by 2002:a05:6214:2243:b0:90e:9ac5:bfc6 with SMTP id
 6a1803df08f44-9122e52dcdamr78819906d6.24.1789423827222; 
 Mon, 14 Sep 2026 15:10:27 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f45ab7csm105588756d6.15.2026.09.14.15.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 15:10:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x6Esb-00000002Idd-3vnk;
 Mon, 14 Sep 2026 19:10:25 -0300
Date: Mon, 14 Sep 2026 19:10:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v6 17/18] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260914221025.GA3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-17-5ef07ec9ef06@nvidia.com>
 <d3fb7ea0-019f-4311-bf0f-00d25bdebda0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3fb7ea0-019f-4311-bf0f-00d25bdebda0@amd.com>
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

On Mon, Sep 14, 2026 at 04:27:00PM +0200, Christian König wrote:

> > +enum pci_p2pdma_map_type
> > +dma_buf_p2pdma_map_type(struct dma_buf_attachment *attach,
> > +			unsigned int tlp_flags)
> > +{
> > +	struct dma_buf *dmabuf = attach->dmabuf;
> > +	struct p2pdma_provider *provider;
> > +
> > +	if (!dmabuf->ops->p2pdma_provider)
> > +		return PCI_P2PDMA_MAP_NONE;
> > +
> > +	provider = dmabuf->ops->p2pdma_provider(dmabuf);
> > +	if (!provider)
> > +		return PCI_P2PDMA_MAP_NONE;
> > +
> > +	return pci_p2pdma_map_type_tlp(provider, attach->dev, tlp_flags);
> 
> Calling PCI subsystem functions from dma-buf is a hard NO-GO.

This is why I had the mapping type arrangement able to know if a PCI
path was involved so it could activate PCI support for that path. In
an extendable way so other interconnects could also provide their
unique knowledge too.

> I shouldn't have allowed the mapping functions to be added to
> DMA-buf in the first place, all of this belongs either into the DMA
> layer or the exporter.

DMA layer is not the place to form dmabuf's corrupted
scatterlist. This must only be done in dmabuf.

We don't want to open code this common logic in every exporter, it
needs a helper. If you have a better place where to put the thing that
makes the dmabuf unique broken scatterlist, then I'm open :) HCH isn't
going to accept anything like that outside stuff hard wired to dmabuf.

> We should probably have a single callback the exporter provides to
> fill in a structure with PCI specific information for a mapping.

Yeah, that is where I was going.

I'm really sorry I haven't been able to come back to that mapping type
series. Were you feeling positive about that? Maybe Leon or someone
can pick it up from me. I was optimistic about scaling back to just
the maping type negotiation as a first step

Jason
