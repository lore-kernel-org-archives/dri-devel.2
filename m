Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E528C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65D889C7F;
	Mon,  6 Jul 2026 14:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="JpM7Vscn";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BDA89C7F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:45:48 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92e622cc874so160245385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783349148; x=1783953948; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RchAVTABW35/nVIIB7DpmvWo5jCT1UuX99uA5TkjSRU=;
 b=JpM7VscnyE7MbuFdvFiFCau01Fdu6KeOO+29+UFW1OCGkVa/1hhT4S2h2ggzBlYqqT
 uXE3sU1Tug6Kve9xmUUVp6HiYDfhVLbNKcNCBuurvaEr8NQ6MQj9fjVnwPq6q5x3gu6T
 RDqAzcOqXm2dFhTRJx9JSkOB0d6pQFf76Da6RllgpNwkARJfBLo4//Oxz+z9vX9QGoEK
 PsnZzd0Yi/Q8nknO3CsPxLDFzVL69McvJGB1V2WEmmQ6pk0eh3EDkUEdTA4R0X/AWOiJ
 aqM+DHsp0Ztov01X00Kdp4cBwR2i113PexNV3LN8ZVHZ6ffV7R2ro+Aq05v/2+sFv34q
 qZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783349148; x=1783953948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RchAVTABW35/nVIIB7DpmvWo5jCT1UuX99uA5TkjSRU=;
 b=AXVVp10hoh2HudpLL1Y+1CGLG30Hz6jq54OtmkUq+//gPclMxXIFYGntpIFlRKDD2m
 8FaoKGG/diSka+7xNJEiwbHt/cS2LkgbY5/va+S6otO69+/Hu2qpq7Pt7yezDVleyRYo
 ayzpT7Nk49yMohINZopy/luTuNEfkWPh1GeZngXLjLqsKthuyAeOHEJMk5lCnqH/n03P
 TGd2DctOI/RDCcXmQwnFZF8py5E3gNNXQ8N9aT+uH4FF3gIYdn3INU6Lzwlglysqwvat
 xcr/WxM9hgrzVuYOMnOW7TgenG6jaFqoD5ROIWuWJ1XLG337BXAxu77lAyK6bFE3ssWj
 ADUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhJWZoJTUwQuMVIhjPftxEoC84Eb9I60lsEy++DykQD8H+FpHLoPuX2v2oes7mzxvKqs4jteTwVkc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFKZNCHJZZEvzRuCKnuu4mX2FOcm2YP0CunKu0lRu9aVYWKqHQ
 ugVP+X80VwvOLOSk0Io3+uttJR5WrBONNVe4d84JNwH65DM3wrB5vvqLsf5K/GAr2WY=
X-Gm-Gg: AfdE7cm/ZV4Bd74mXqrZpt3SpuNSA2fLa+ZSA2Myb/l6NpkS9cG78QpTjZbwOOqXi9V
 lxt+HF+lgH/vfDjxmsve9pjN1ispp4gZ3OCUXIwNlDX7z438kweVQbE98gXzveGyUHfGs/AbUq7
 t9PiP7jXA5puvyFzVma1QZKfBTnHYJoMmZ8P6Mo0lI1ljTdm70e73ybAaEwJuXPOVvi02SyxdYF
 q5efwSyDDNPzLflDEuMARGQ2bP+QB2ge1eQ8EDT56a4GJGVFbVvnQ6I+c5xGi2+8pkysthPzcJ6
 E1jK9rWA2dwZT4ymz1dkjPdVlfWym3uqnslZGSpy6eeTJKEkhU43/Jxg55PVmIzQ6i0UeqcLZWa
 k+L6zpdo4HWPcbg5fBcb2eWQzANXb832REpREZt4L1D+km06i9r5RFjBXKgkh
X-Received: by 2002:a05:620a:8390:b0:92e:8fa8:829b with SMTP id
 af79cd13be357-92ebb4ef994mr126892085a.24.1783349147658; 
 Mon, 06 Jul 2026 07:45:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ba4209sm1003534685a.12.2026.07.06.07.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:45:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wgkZu-00000000UJc-23xW;
 Mon, 06 Jul 2026 11:45:46 -0300
Date: Mon, 6 Jul 2026 11:45:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260706144546.GE107792@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
 <20260703203502.GC1978949@ziepe.ca>
 <a381d265-e7a4-4fe7-9421-3553706d41c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a381d265-e7a4-4fe7-9421-3553706d41c1@arm.com>
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

On Mon, Jul 06, 2026 at 02:08:14PM +0100, Robin Murphy wrote:

> modern use-cases anyway, and is being replaced, so limitations of a "legacy"
> API that don't have any meaningful impact to its existing users are hardly
> something to panic about. If DRM does want to be able to *reliably* map
> massive amounts of RAM then it can adopt the new IOMMU API, for this and all
> the other reasons that that new API was promised to be "better".

Yes the new API does solve these issues, and it avoids padding
destroying the iova contiguity.

> > So I wouldn't be quite so dismissive that this is not something a real
> > user can hit.
> 
> I'm not being dismissive - clearly it can be hit. My point is that anyone
> who *does* hit it can only expect it to fail (as indeed this particular IGT
> test seems to), because it has never worked.

Today you can allocate memory from hugetlbfs and map it through
RDMA. The user can set 1G hugetlbfs page size and allocate 16G of
memory, and RDMA map it. Databases and HPC, for example, love to do
work loads like this.

So there is an unlucky hugetlbfs FD that has an internal memory layout
that will build a scatterlist that cannot be mapped by the iommu.

The user's application that normally works will fail randomly and
infrequently for no fault of their own. This isn't "can only expect it
to fail".

> So yes, limiting any individual segment to <=2GB would end up avoiding both
> those conditions, but it would also impact plenty of cases that *do*
> currently work fine, e.g. 1GB+3GB+3GB. The limitation is really that you
> can't have two consecutive segments where the first starts exactly on a 4GB
> boundary and the sum of both their sizes >=4GB.

Yeah, but that's hard to express.

My feeling was supporting >2GB without a split is not really so
important. You are (righly) arguing these huge sizes are usually rare.
Places like RDMA where they are not rare people already added
re-assembly logic to join SGLs so HW optimizations for >= 4G mappings
can be used, so smaller splitting doesn't really matter.

> > API wise I expect any arbitary input to sg_alloc_table_from_pages() to
> > result in a scatterlist that iommu_dma_map_sg() will map. This
> > patch highlights there are cornere cases where that isn't true, it
> > should be fixed..
> 
> Technically sg_alloc_table_from_pages() carries no such assumption,
> only

There are lots of callers that just do sg_alloc_table_from_pages()
then dma_map_sg(). Callers can use this simplified API when they don't
need any segmentation logic in the DMA API.

> sg_alloc_table_from_pages_segment() (or __sg_alloc_table_from_pages()) with
> the correct dma_seg_boundary value for the given device. 

_segment is the segment size, not boundary. The sg_alloc_table
functions don't support the seg_boundary limitation.

So, how about instead of failing we just don't do any padding? Ie
ignore dma_seg_boundary, and hope the device is modern and doesn't
need it?

Alternatively, can we request to disable dma_seg_boundary somehow in
the driver and stick with the WARN_ON?

Jason
