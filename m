Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B69CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E2610F312;
	Wed, 30 Sep 2026 11:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VSWXjJHV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0FD10F30E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDA0B40592;
 Wed, 30 Sep 2026 11:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E935B1F00893;
 Wed, 30 Sep 2026 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790768641;
 bh=045Gg/9FNTZlrsi+oP8Nxf9edT3+jF24v5WNbYcZjwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VSWXjJHVAsJ34fjRpCgdAAm2s+N2fiEQSsaLA83OWsLq4eONyJuVTUfPjdna+84/m
 q1/1x2A3M5+juV1717SRNgmygTNIXSdte54KjqlagnfyYM5nvdvN6tmbfog6D74Gii
 rtHNCGwAyKdmRpQAOB85aZYiTw8Zv4AvgiTBZj6t3Y3cLYzgx/Cbu8SdkN2WrV56d4
 jjoxNRA8oUhe//pwutrYVjDKzCQE6/dOiGbSntP9Yt7b9G6O3cspwsYwROmB1m7da3
 DTtTpp37fbHkG2hQ4G38CDwinoxY1+ALw5+CQhP61M6Kpz8Nuf7XXpD5Ucku+DcCIg
 rEraZmriCvq5g==
Date: Wed, 30 Sep 2026 14:43:56 +0300
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
Message-ID: <20260930114356.GC3401365@unreal>
References: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
 <20260928-fix-p2p-acs-v4-0-v8-16-404453b9c435@nvidia.com>
 <607e8903-a979-4d78-bf08-447321c03119@amd.com>
 <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
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

On Wed, Sep 30, 2026 at 10:34:56AM +0200, Christian König wrote:
> On 9/30/26 10:18, Leon Romanovsky wrote:
> > On Wed, Sep 30, 2026 at 09:00:57AM +0200, Christian König wrote:
> >> On 9/29/26 19:57, Leon Romanovsky wrote:
> >>> On Tue, Sep 29, 2026 at 03:39:42PM +0200, Christian König wrote:
> >>>> On 9/29/26 15:23, Leon Romanovsky wrote:
> >>>>> On Tue, Sep 29, 2026 at 11:34:05AM +0200, Christian König wrote:
> >>>>>> On 9/28/26 13:19, Leon Romanovsky wrote:
> >>>> ...>>
> >>>>>>> +	return pci_p2pdma_map_type_tlp(provider, attach->dev, tlp_flags);
> >>>>>>
> >>>>>> This function call here *must* be in the exporter and not the DMA-buf framework.
> >>>>>>
> >>>>>> So clear NAK to putting that here.
> >>>>>
> >>>>> "Look, it is easy to complain you don't like how it looks, but this
> >>>>> stuff is hard there are lots of competing concerns, if you have a
> >>>>> better idea now is a good time to present it."
> >>>>> https://lore.kernel.org/all/20260921130858.GO11599@ziepe.ca/#t
> >>>>>
> >>>>> Do you have a viable solution?
> >>>>
> >>>> Ok, that sounds like you haven't understood why I'm rejecting this.
> >>>>
> >>>> By moving the calls to pci_p2pdma functions into DMA-buf you bypass the NAK to expose those functions to drivers from the DMA maintainers.
> >>>
> >>> No, you have misunderstood Hellwig's position. His request was to ensure that only
> >>> subsystems deal with P2P internals. He was perfectly fine with bringing P2P
> >>> complexity into dma-buf, since it is the agreed-upon mechanism for sharing DMA
> >>> regions between devices.
> >>
> >> Thanks for clearing that up, I indeed didn't realized that.
> >>
> >> But that is pretty much against my standpoint that I don't want any P2P complexity in DMA-buf.
> >>
> >>>
> >>> So this is not a NAK bypass; it is a correct implementation of his request.
> >>> He handled P2P-related complexity in the block layer.
> >>>
> >>> Let's add Christoph to the thread so he can correct me if I'm wrong.
> >>>
> >>>>
> >>>> I unfortunately didn't understood that when the dma-buf-mapping.c code was added and just assumed that you just needed a place to put some common code.
> >>>
> >>> That is not correct. Devices A and B share a DMA region via the dma-buf
> >>> mechanism. Where do you expect the code common to dma-buf to be placed?
> >>
> >> In the DMA layer!
> >>
> >>>>
> >>>> So as long as that NAK from the DMA maintainers to expose the pci_p2p functions to drivers stand I will push hard to get that stuff removed again from DMA-buf as well.
> >>>
> >>> Are you seriously suggesting that every dma-buf driver in the world should
> >>> have to reimplement this mess?
> >>
> >> Well I completely agree that this should probably not be replicated into each exporter, but that is the job of the DMA layer and not DMA-buf.
> >>
> >> The purpose of DMA-buf is to exchange DMA addresses between an exporter and one or more importers and handle things like lifetime and synchronization of accesses. 
> >>
> >> What the framework should do is to transport the capabilities of the importer to the exporter, e.g. what physical connections we have etc..
> >>
> >> What the framework can also do is to have additional information from the exporter to the importer regarding addresses and mappings, for example if they are bus, IOVA or some special internal DMA addresses or how to stitch together your PCIe TLP or whatever.
> > 
> > At a minimum, exporters need to pass `p2pdma_provider`.
> 
> No, exactly that is a no-go. The neither the framework nor the importer should see the p2pdma_provider.
> 
> Only fully translated addresses where the DMA access should happen.
> 
> > 
> > If I keep the “dma-buf: Let exporters hand out the P2PDMA provider behind a
> > buffer” patch, I can move the P2P TLP types back into `p2pdma.c` and export
> > only the function that indicates whether ATS is required.
> > 
> > Is it ok?
> 
> What you can do is to forward declare enum pci_p2pdma_map_type and than pass that 1 to 1 from the exporter to the importer.

Unfortunately, neither suggestion applies to RDMA NICs. They need to know,
before mapping addresses, whether to create the memory region with ATS
enabled.

The importer needs a way to obtain device information from the exporter so
that it can configure itself correctly.

Thanks

> 
> Regards,
> Christian.
> 
> > 
> > Thanks
> > 
> > 
> >>
> >> As long as both the exporter and importer agree on what those values mean I have no problem at all with that.
> >>
> >> But how those DMA addresses come to be should *absolutely not* be part of DMA-buf! The complexity of that is seriously not something we should have here.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> What you try to do here is seriously not ok and I will push back hard on that in the future.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>
> >>>>>> Regards,
> >>>>>> Christian.
> >>>>
> >>>>
> >>
> 
