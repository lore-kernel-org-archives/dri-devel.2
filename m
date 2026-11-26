Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070D606A324
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a0GtJXzd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B2910E465;
	Thu, 26 Nov 2026 22:30:08 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8086D10E465
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 22:30:02 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-921342fae7eso76144436d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795732201; cv=none;
 d=google.com; s=arc-20260327;
 b=RLSk86BjzqnMRezcFHbQS1/NUmSsK9LK83PRDaI9zgn+A5Tp2P4CNvPbnm1doM8hOD
 TGMQm1/b8o8NWolAyckHG5MNKbTeY02JgaLk5drPwI+QVNAYvrMlYdwG8l1fhe9C9e8Y
 1rLjKeeWzC0nP3XTNM9/KXMf7OysIkXnyqxbA02AWbvqhtrKmEsRkIToU0t+DqgUulvH
 VlNJ1yJCt6qCX1Thn+K9cqwdloZOKrLrH5iZmN3F7L/3SoXXF3wS5YVw7Y71HnsyevS7
 9ncHUZ3A1G4r9hJAB48JbW4hsf6mzUZHown1OaAvHAYgZkr7g5N327tc6nmf9niDBkJh
 JxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
 fh=V9lmwj/QHy4oZ01g07S9dKtamdQA8z3QFvLbjNTD1Fs=;
 b=AZBg2bMVM7kN5ghatMNnLTEPBJ5TEVD+2O13v+1QytTJbdzFitWeA1mDnbkTHOEL4R
 IfPZs7E0EmyyCgFugS4y9zQVe+FA73YTQBSSyENjZDumglHXyTlLik1oo0GFKnOl1rH5
 RzmSLz6ywh1/14vqWE2bIeHrnFTeWfPwtR+JSiPxS9ol4imcxFlsDgzhZHWSOw1mCVo8
 f0ZwX8bOHjlIM4d5vJf78pksVAofVWoqnOlsMuP3ACAk5Uulcn2UruskFOH4JNcF1t2q
 1e85YlHp74NUqLdf+CqCFutHmJB1bjUbped/ABVx/W4ZIcivftz4G9y1uihMhc1LsXc5
 Arxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795732201; x=1796337001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
 b=a0GtJXzdyzJHnlHUn3u5bupAChx/F4lNEHU5YVmtVM6hd9EfdDIwIQwxFwyn8e2bwr
 +38n3RlU5+yOd01s46O6Y5jQTgvuOzI6Y7h9BQ8bFwtGwLSxEk9zX31bmwpLcaifLaMv
 Nf3aKmJAOs5c1AI457STvo8L9h/XWtjFWBJOD6TCRvFa2u3omgYCYR1qNY4C20jUCqkz
 Vya5SsR5AirwiJCLwXooUuzo4eMg4jfHVpPwa7GW5x4+y6L9kFXml+a1XK6RZBJ93jNH
 Gi601/wIi/f5yWRlohR1i5O7Z7FCaUijGptSJ3tWZ1Jj0f7yrzAfblDjV9MR68sH9VgH
 5MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795732201; x=1796337001;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
 b=rvU8zLXnu+Els0h9TPKYJElc45Qps/EOEDrtTINHLzEhR2rdzVhnIB5YxpWHalticO
 iPvxWEQTV/rhLMVrMkYNHoVFjX3sgwZi7aTN3OoEZFDMpNHczlUcPVcenICZTZnGhn1a
 D4aaGwGW+E09mMWLozjkiVhaZBoGD+dzCWyBWC5XFA8DLIMMi88qEos+HJoc6HPpV2zh
 b/ttLzL0b4pEu2pNCIfcmvWFvXtczSJLHoZJcKeROhN8bQmrq6OGPsKQcJ2FlsPOoxl4
 ymoKA+7UeRp5zsyEGc1O2LYw7kBXc5MjIAzZzRFbUwpRvMbjGka/rymiN/hJg7fCNCQq
 MyUA==
X-Forwarded-Encrypted: i=1;
 AL+hErHSAF3OaV/tqnu2yl69ZhJ8Xqez9Vl6ZGeSK1Bzgi9rabcJKfMWvr2VBB4UznbYlVI7UU0K7+h8LNw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gKwe5dvvfJl04BYaTDanrkAcbMuFXVl1C7IUbbANk8lhWrVcV
 2uFZJfUNjI8++/9q8w44lNFOitAhPR5VA2BmOQnZG/S+33CbwXXZMVUz5hDxJug4afQsxRaZxya
 CTmMqDUpJvuKIMAn9HdLbd8/Z91SVDHo=
X-Gm-Gg: AZFdTZcD9aJ03IPVgPTD2M6+7TVP5RwjtoFO4CZi55jDb1Cpo/Qo+ZHJHc1XMCxg6Kt
 k62pHwzOIidehpjv6DcLKbfBvd3mePs2OUrvGUJkL0KyQvzQcmVw8UQ584j1iSkNpaWVYPWhnmA
 S43nx49BMrQYZxfGnM/9yLMGd9dVfOUWWD5Iva+COkvTFOSSQbyRIwpBV+9klxKVhmsy8a1aZsm
 3pYFxjYmrW+oZcQI7DhcvGjxrwq7Xfn1OquSmp1kIPk8/ScdLsD4VXeUpg5VZoYLSKzSv/3Lw0Z
 D1gB8PD1RgVjlWcdDI1AtHE5nz1dfDrRx5R7s9IZ7GFgj8E/a1q3bQaAX4bpZoYuuyd5X5Pgj5f
 mopF8Svx920/R07XX364Xehr3TsgR2sXjnj9VlXaRjZrcSo58etT9T7Qna6D49KFm18dQohZnf0
 kbA7TLsRZWavwQTjHyTbp7KQ==
X-Received: by 2002:ad4:5d61:0:b0:91e:8bb3:82 with SMTP id
 6a1803df08f44-92134988818mr432424486d6.4.1795732201165; 
 Thu, 26 Nov 2026 14:30:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
In-Reply-To: <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 27 Nov 2026 08:29:49 +1000
X-Gm-Features: Aa3M54rvnH00v1NCtGrc73zPMs4ZrSy5Ip3saymlbe4-GLTg5bt7TBC0zEJEFjg
Message-ID: <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, 
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, treding@nvidia.com,
 jhubbard@nvidia.com, 
 chaitanyak@nvidia.com, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 at 03:26, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/24/26 07:23, Alistair Popple wrote:
> > On 2026-11-24 at 05:37 +1100, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote...
> >> On 11/23/26 17:57, Jason Gunthorpe wrote:
> >>> On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian K=C3=B6nig wrote:
> >>>> On 11/20/26 06:55, Alistair Popple wrote:
> >>>>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>>>>
> >>>>> The SGT (Scatter Gather Table) DMA mapping type represents the exis=
ting
> >>>>> sg_table/scatterlist based DMA mapping. For now it continues to use=
 a
> >>>>> sg_table for map/unmap, but this will allow a future patch series t=
o
> >>>>> convert to using a different data structure for importers without h=
aving
> >>>>> to convert all at once.
> >>>>
> >>>> I strongly think we shouldn't have an SGT mapping type in the new DM=
A-buf mapping API.
> >>>>
> >>>> Instead we should have something like either an array or an xarray
> >>>> of DMA addresses.
> >>>
> >>> My plan was always to get there, but I don't think it is reasonable t=
o
> >>> start there? There are too many places all over the place that are
> >>> just hardwired to do SGT right now.
> >
> > Right. There are around 70 drivers upstream that make use of the sg_tab=
le handed
> > down via a dma-buf import, so I don't think it's tractable to convert t=
hem all
> > in one go. So obviously we will need some way of phasing this in to giv=
e time
> > for each driver change to be implemented, reviewed, etc.
>
> My suggestion is not to convert all drivers in one go, but rather to come=
 up with some sane representation of the DMA addresses instead of using an =
SGT in the new interface.
>
> > Obviously some of those will share a common structure/helper and conver=
sions
> > will be similar, so that is an over-estimate. But based on an initial p=
oke
> > around there are plenty of drivers that bake the sg_table more deeply i=
nto their
> > data structures.
> >
> >>> Part of the design of this series was to allow the conversion away
> >>> from SGT to be done incrementally without breaking compatibility.
> >>
> >> Do you know the joke from the hitchhikers guide to the galaxy where th=
e dolphins are happy for exactly the same reasons?
> >>
> >> I'm pushing against this plan for exactly the same reason because I th=
ink it will make the conversation away from SGT even more problematic than =
it already is.
> >>
> >>> So it is effectively this:
> >>>
> >>>> The framework should then either connect the SGT directly if both
> >>>> importer and export are using the "classic" interface
> >>
> >> Yeah but that should not be a separate mapping type, it's rather that =
we just convert back and forth from DMA addresses to SGT for compatibility =
reasons.
> >
> > Right, I think this is actually fairly close to my plan, which is to pr=
ovide a type
> > for each address class an exporter can produce - either a CPU physical =
address
> > or some device context + P2P/MMIO address but in future could be some o=
ther
> > interconnect type.
> >
> > The core then negotiates compatible types and adds converters between t=
hem,
>
> I have strong objections to that plan and would potentially NAK it.
>
> DMA-buf should *NEVER* accept CPU physical addresses nor provide conversi=
on between different address types.
>
> Keep in mind that DMA-buf is solely a container for DMA addresses, nothin=
g else and it should not provide any mapping functionality whatsoever.

Is that because it's called dma-buf, if we just called it's shared-buf
would that alleviate things? I just feel like there are use-cases
where it containing CPU physical addresses might be what is optimal
for a certain scenario, and re-creating a whole parallel
infrastructure that ends up being 'I-can't-believe-it's-not-dma-buf'
would end up being bad.

If we need to shared object backings and have clearly typed and
negotiated on what the backing contains then we should allow it.
However I mostly agree on the mapping thing, I'd want drivers to
negotiate and natively support whatever backings they can rather than
having an intermediate trying to handle the conversions Not saying the
code doing the conversions can't be a helper, bit it shouldn't ever be
autoamtic or outside driver control.

Dave.
