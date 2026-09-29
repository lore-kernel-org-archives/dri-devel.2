Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D466BCA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D6B10E561;
	Tue, 29 Sep 2026 17:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PQN90cqc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8AC10E561
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 17:57:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6B2C6022B;
 Tue, 29 Sep 2026 17:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFC01F000FF;
 Tue, 29 Sep 2026 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790704661;
 bh=3HvTE8+cSoJwWwxo6vkUyclywLOze8+WpQiHGU+uuRQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PQN90cqcxteejXyuZpnLvZH2PoBfUr/APs8rGswcPDY2HErYAJofq8jDOw/P6BVu9
 AzUa7oG2XttoacL4mKXDwa593ePi7D9LGfG7IA1wePosTQEsdkKLk6nVlltOQ3SGm3
 5hhYFy8Q40pjdRQPAQQyd46qSqEcdPnB7BOCU4ruFcLX+VJdcxuDWQSrEpEc5QZ9/Y
 eVXntJovR7re/o+fin3yNQOmxfoMQlrnB/d1dUeQLgaTHupYfGZ/zgJofYwAgqOC46
 JTAHpD2hKzDuCZLfnIs/S6NqgVKANpWQp6JZA7VANx5whRPFGKPjfIWZCeHoQVyTxE
 TRH4Q42+4XfmQ==
Date: Tue, 29 Sep 2026 20:57:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260929175737.GK563127@unreal>
References: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
 <20260928-fix-p2p-acs-v4-0-v8-16-404453b9c435@nvidia.com>
 <607e8903-a979-4d78-bf08-447321c03119@amd.com>
 <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
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

On Tue, Sep 29, 2026 at 03:39:42PM +0200, Christian König wrote:
> On 9/29/26 15:23, Leon Romanovsky wrote:
> > On Tue, Sep 29, 2026 at 11:34:05AM +0200, Christian König wrote:
> >> On 9/28/26 13:19, Leon Romanovsky wrote:
> ...>>
> >>> +	return pci_p2pdma_map_type_tlp(provider, attach->dev, tlp_flags);
> >>
> >> This function call here *must* be in the exporter and not the DMA-buf framework.
> >>
> >> So clear NAK to putting that here.
> > 
> > "Look, it is easy to complain you don't like how it looks, but this
> > stuff is hard there are lots of competing concerns, if you have a
> > better idea now is a good time to present it."
> > https://lore.kernel.org/all/20260921130858.GO11599@ziepe.ca/#t
> > 
> > Do you have a viable solution?
> 
> Ok, that sounds like you haven't understood why I'm rejecting this.
> 
> By moving the calls to pci_p2pdma functions into DMA-buf you bypass the NAK to expose those functions to drivers from the DMA maintainers.

No, you have misunderstood Hellwig's position. His request was to ensure that only
subsystems deal with P2P internals. He was perfectly fine with bringing P2P
complexity into dma-buf, since it is the agreed-upon mechanism for sharing DMA
regions between devices.

So this is not a NAK bypass; it is a correct implementation of his request.
He handled P2P-related complexity in the block layer.

Let's add Christoph to the thread so he can correct me if I'm wrong.

> 
> I unfortunately didn't understood that when the dma-buf-mapping.c code was added and just assumed that you just needed a place to put some common code.

That is not correct. Devices A and B share a DMA region via the dma-buf
mechanism. Where do you expect the code common to dma-buf to be placed?

> 
> So as long as that NAK from the DMA maintainers to expose the pci_p2p functions to drivers stand I will push hard to get that stuff removed again from DMA-buf as well.

Are you seriously suggesting that every dma-buf driver in the world should
have to reimplement this mess?

Thanks

> 
> What you try to do here is seriously not ok and I will push back hard on that in the future.
> 
> Regards,
> Christian.
> 
> > 
> > Thanks
> > 
> >>
> >> Regards,
> >> Christian.
> 
> 
