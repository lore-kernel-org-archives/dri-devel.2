Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3DDFDEE3F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D2C10E38A;
	Thu, 23 Apr 2026 19:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="gdx1ISCQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUvdr8y6";
	dkim-atps=neutral
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAD310E38A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 19:20:18 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 517CD140016D;
 Thu, 23 Apr 2026 15:20:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1776972018;
 x=1777058418; bh=zgX8pUM+ByGW1BJ4PzJmLl3HUKg2UKXk7RpMYuVX26w=; b=
 gdx1ISCQg+TSBOVzJw59r+B2kL6yGJACfaN4o+jfw1+LVBJo8M4CLyvxMZqpWhIx
 8fpOYl9DQkAlFfIqSSi144Ul6oti8nQ6hSCVKDwxC+s/lBtdHrv7lReF2ZngadSN
 Od1QCcLnTHuxXOT44WWZfQzQACQhujzMpDPuxVnmfq8rkKaOQ+ikX7We+iSqzRzO
 lrBOtjeU4I9U3WCOUqUbHutFZXTRaEeWJ9839dNT5HYMu8eu7IaaETPPNEntcAqf
 63YieUjaDu3Uo65EwCqgbc3T4uzS9avWCXOdukTXE1yhHm8iyNTcNLelKZkXBko7
 FtdcikH0aPB8qC7aZQPDxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776972018; x=
 1777058418; bh=zgX8pUM+ByGW1BJ4PzJmLl3HUKg2UKXk7RpMYuVX26w=; b=Z
 Uvdr8y6kuGVNdu3c0ZQYsoJsU40DdAh5s3HryOIhEf7x0mApZTi4iFdEyC/sOHH+
 7uxNgxnxV0i/uJwA9+WLgOk7+eKspnp5ZmPGowwF76c5XZwyVTXpJCuE6G9SI9pI
 JCXmyMKupSQ7GgZl01RmGH4oa/94yXKLCW9Jopu44qiDXX7TzAG9eJuKBK3KwBOp
 53Gh7vFoSv8P9lglzIdViXCpVS4wYjSOwwFvMBAmTuraMIYTfxi5YM5DohZxfUsS
 zagp3HpVZ+gSqBaYoQKpsSWl2Gh7GpamX+WRzFOIOfxUOSimzBmOvbZCFSowXc1n
 s/AaHraDRy7mAx+OBWdZQ==
X-ME-Sender: <xms:8nDqaSocVBUsGX6Dqv_G5w1rlJmoZL84errVQL3TlmWj8TRDyuK1aw>
 <xme:8nDqaV0BVjnH0Hj5F-hlKcd8X682cxE0tqu2brwkqUO7P9eoU9sbW3qd158Z-qwg3
 dcfVuqBvxksctosoEesiDf4wm47d41NEex_UAhQcNeIFqWc4Db3og>
X-ME-Received: <xmr:8nDqaamq_rWSOK6CdZLMRBlb5SJREhMRV-lT_9V1GmTwxSd5W0bWC35lALQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
 ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
 htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
 ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepii
 hhihhpihhnghiisehmvghtrgdrtghomhdprhgtphhtthhopehsughfsehmvghtrgdrtgho
 mhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
 gvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlh
 drohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8nDqaRa_rMoY3-Gu0IG6in9WxOQrtHLSZfodCQRs-3oWG0hGYNOALQ>
 <xmx:8nDqac-z_p1atCzPwxluejmtD6AzXG34JJfqwXlRQXFPUayD4aMd4w>
 <xmx:8nDqaREJs6AGZct-AGSAW1QRMET9_rt_kBglLTDnxIKI0-7uxp8MxQ>
 <xmx:8nDqaWezx6LiHdIh6_5BLrSXwi94wLwltOZ7z-ABrrvRs79Kw8U4iQ>
 <xmx:8nDqaSlZyN88SxHutEDRqgWwDrmlZGWMI7VKYXHLfjociova4Iy6orlE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 15:20:17 -0400 (EDT)
Date: Thu, 23 Apr 2026 13:20:16 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423132016.4a25e074@shazbot.org>
In-Reply-To: <20260423142828.GQ3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
 <20260423142828.GQ3611611@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 23 Apr 2026 11:28:28 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Apr 22, 2026 at 01:27:40PM -0600, Alex Williamson wrote:
> 
> > So why does vfio need to be involved in any of the sequence proposed
> > here?  It seems like it would be a much cleaner design, avoiding
> > overloading the existing vfio feature and questionable array semantics,
> > if there were a set-tph ioctl on the resulting dma-buf instead of
> > making some vfio specific interface bundling creation with tph
> > hints.  
> 
> Realistically only VFIO dmabufs will have this property that user
> space can set any TPH.
> 
> Other in-kernel drivers should accept some kind of hint from userspace
> when creating their dmabuf that makes sense for their device, not a
> raw TPH value. Like a GPU might accept a hint that specifies which
> dielet or something like that.
> 
> So I don't see a generality here from that perspective. The generality
> is that exporting drivers that can use TPH now have the option to tell
> the importing driver to send them.

Ok, if dma_buf_ops.get_tph serves the common case of the driver
presenting TPH values and vfio's case of the driver being only a
conduit of user specified TPH values is unique, let's work on the vfio
uAPI.

Why do we need to bundle dma-buf creation and TPH setting into a single
ioctl?  That's what the proposal here does and it results in a really
ugly extension with an off-by-one baked into it.

My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
processing hint.  It would fdget() the dmabuf fd, validate it's a
dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
find the matching vfio_pci_dma_buf via priv under memory_lock, and
stuff the provided TPH values into the object.  It would be left to the
user to sequence setting the TPH values on the dmabuf before the dmabuf
is consumed by the importer.

Is that a more reasonable uAPI?  Thanks,

Alex
