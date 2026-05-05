Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2EFCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF1810E443;
	Tue,  5 May 2026 14:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="fXU0z364";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzG99EHP";
	dkim-atps=neutral
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68FB10E443
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:51:02 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id D4E38EC017D;
 Tue,  5 May 2026 10:51:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 05 May 2026 10:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777992661;
 x=1778079061; bh=gkDZbs2uaJHENXDOI2poVxNdOMle19rKsTDPE0HZKMA=; b=
 fXU0z364wpLxyhGw1FFiSVfRZctUjUqsgLbmFjICajIPr/x7ipnqLrG7lm/uwzCs
 It+jQB1lwqEQtgrzHP8jfg3I3uIDBO3sY/ZR8gR17sz87ibQ1L+XhXAktc6nsYdS
 +lYs81EzRvnPPpBDod4WMiSn02jKh9DV535B5wgFtMCtvfg5OLarzxgwvgTh2EYz
 w33bcZs14dAks0R79+a09NR42Y3q4pk5E6HVnlgkUt4JwPOD2XyY3JYSH5Xf6wKx
 URxS6lk/1jgaPF+CNpUClihp4ywhhmFymKpKHt5BhMi8gQZssgs6KDnfLfWeEl/f
 PAMLNlxxmAvIlCR4Ic6T/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777992661; x=
 1778079061; bh=gkDZbs2uaJHENXDOI2poVxNdOMle19rKsTDPE0HZKMA=; b=A
 zG99EHPhenxS4yZZfFG60g7VrVmcxsv1fMbNLEBVDpJTlSiAWHsDj27R4bTeL2Rf
 PX2yLeUoWkWs12dsYqHCZNoS8DrwUQLkreK6GaWsAouQZAT5axnzUci8BPfxuhAQ
 2/E2wQ5aemdhY4QwuKF3nmnmYLUt+5hZACCjl3dOsw/nxOwSl8SPGL+XdSZnVdJ7
 Xne2EChYhTFlyH7MQfTSbB27vCvXZqWIuufsaSvRCP5MXc7xfEgR7UGw/OmQPD46
 UbVQlOWobvrcYf9u8MbyMvJa5K1StuDEz1mEo5DsGCJRxsj/2wuGkc4nWuiupBXD
 +UU1wFaArRJEZivAvq7HA==
X-ME-Sender: <xms:1QP6adOsYjVujziS2XbXhHbegIg0FLeI-rQ73vipHvb_2LUmfieotA>
 <xme:1QP6aeURQAKx3onP5Z7kUGP2n_XAlfpZmBNsnYsIyglcDUWYhJZrkh8uZXQDp3Z42
 eD4zNXyXnCoBRpAvt6QVkuQK3UiDdQ5hFlB6rsK-8QzUgoeHyaJ>
X-ME-Received: <xmr:1QP6aYQV4xWIBaqkM6kEOqlTHpYN41HaxgTUpQI5ca3mj-jAMvIeoUoyk7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
 vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
 pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
 gvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgsehnvhhiughirgdrtgho
 mhdprhgtphhtthhopehmrghtthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtoheprghmrg
 hsthhrohesfhgsrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhg
 segrmhgurdgtohhmpdhrtghpthhtohepmhhnghihrggurghmsegrmhgriihonhdruggvpd
 hrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegs
 jhhorhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhmihhtrdhsvghmfigrlh
 eslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:1QP6ac1XEGUg9AUVJlQ0-SZQrvWT5ZvR-QbEsKC7sMztsJMLBvciyQ>
 <xmx:1QP6adixnXdwv19vs0-AxX5Vue1jOu8ROretV_FjnrNHOaC2quRPVw>
 <xmx:1QP6aSZ9G6mwiUoZVYIItZS1tGQKri9Z_gVMeoDrzZ-MJzHFmg_rYQ>
 <xmx:1QP6aeN65oRxR3evY_-F0Q7K6P2zlzr49_AlYTFK649DON_Wa5r3Rg>
 <xmx:1QP6aT3lKtiqvfZtVlBsud0gtvkXfV8SYs66edwWzbncxNiYnjc3l2Kt>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 10:50:59 -0400 (EDT)
Date: Tue, 5 May 2026 08:50:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>, Alex
 Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Pranjal
 Shrivastava <praan@google.com>, Alistair Popple <apopple@nvidia.com>, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <20260505085058.74c34290@shazbot.org>
In-Reply-To: <20260505104911.GB11063@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-5-mattev@meta.com>
 <20260501161915.75525c15@shazbot.org> <afhNeYS174EW7RYp@nvidia.com>
 <20260505104911.GB11063@unreal>
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

On Tue, 5 May 2026 13:49:11 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Mon, May 04, 2026 at 04:40:41AM -0300, Jason Gunthorpe wrote:
> > On Fri, May 01, 2026 at 04:19:15PM -0600, Alex Williamson wrote:
> >   
> > > Exporting dma-bufs from vfio-pci is a feature, but mmap of MMIO BARs is
> > > a legacy requirement.  That legacy requirement now depends on
> > > PCI_P2PDMA, which depends on 64BIT and ZONE_DEVICE.  
> > 
> > That should be split up now, Leon missed it when he added the new
> > APIs that didn't require ZONE_DEVICE..  
> 
> Sorry, what did I miss here?  
> VFIO_DMABUF is an optional feature and is enabled only when P2P support is  
> available. It does not affect legacy systems where P2P cannot be enabled.

If we look at the long term view of moving exclusively to cdev/iommufd,
where VFIO_DMABUF becomes the mechanism for implementing P2P DMA
mappings, VFIO_DMABUF may be optional, but it's highly desirable for
legacy compatibility.  There's an argument though that providing P2P
compatibility on platforms that support PCI_P2PDMA is probably
sufficient.

However, in providing mmap of dmabufs as a feature, this series is
wiring all mmaps through dmabufs and therefore that dependency becomes
fundamental to the use of vfio-pci.  Thus the discussion whether the
noted config requirements could be lifted.  Thanks,

Alex

PS - Please also weigh in on the dmabuf underflow[1]

[1]https://lore.kernel.org/all/20260501131236.278ac431@shazbot.org/
