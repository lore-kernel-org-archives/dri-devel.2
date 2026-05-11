Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29F6CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCEF10E8CF;
	Mon, 11 May 2026 20:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="PwYyRk+0";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAAEvCIe";
	dkim-atps=neutral
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F2310E25E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:10:02 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id CAD7C1D000F5;
 Mon, 11 May 2026 16:10:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 16:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778530200;
 x=1778616600; bh=w/jJechNkW7E0LVurksiul+ndqwmLEWiu+OGwNv1unw=; b=
 PwYyRk+0iVOdVXuz/8VHbIiLHEoKNhjSddEyaXI4WLxNed4oJB+5Hd6boIDLmO/X
 /ycckExDBc6GCMDrMGJeYACRebp/v3WoNnPNeQ5YCUHH6lShumpHk/31H/VbuO+W
 P+tiJDfPWC7vRhvDF3o6CdrHXJ070qqFnVGGub7+/4N/ylteHzNSEyguRiLuT5C7
 6xH8iee41Z1whvGDzQMnPoMPL+lBQbuuhFBjEnJ1iDGEerCARugWByAkPHE50KFZ
 yGQBgoJlr+2+LZUAo40GUHNB+vTO182BLawsAfKorM0uE6dL8hVwyJd6F7A6jMZ3
 3Y+D0PRD2GzL/JrNxHZ6fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778530200; x=
 1778616600; bh=w/jJechNkW7E0LVurksiul+ndqwmLEWiu+OGwNv1unw=; b=P
 AAEvCIe5WxftUxxaUKTnozoCRpp35QY7xXcr9srqzj2fGvDq3qzi14hsAmIyuPK1
 OB+HAzH49lwtmxPRVw0eirS8y2facxpbs8ZxjndVz4bDlikMLOrxERUxO03Q9YMq
 ZzrhKiGZuVqu7YMAFWykSQWwEqHdBUvGhZ+PsKRMDsQGH3yb5jQU53+BdA/TFo4B
 gt10A6T4pRem/APPpn0c3AUN3Ln6XFI1q8esHyXy1JeajIarBpHPa9xBFqZk1pwd
 MbCXCGNqd48pdPubwcMH5rLlxj14kksudMP1JHs8ODcSWrQ89ZkfSbBT6fp0q726
 qianrAnEfxsHjPzWeU+YA==
X-ME-Sender: <xms:mDcCanwZoBgY94pR6CgGx1aXMsUsiHtVgpAYsgsjUY0a_uGZ4HtnkA>
 <xme:mDcCator06ysxCDdBhVrXNTBxhoyxhyZoO9b2GFGS4wZWwKaIsc8Wqt4rHWFDwOQm
 JBc4Bv_-irhL3bMl7h2ZcrzFCEYdoU_3mpqToMXfyNF2JpvrSiIeqU>
X-ME-Received: <xmr:mDcCatVAs0PIpPycMEDa0aLxKAAYaat1b7iYqOm0xFH4xtZQgPIYVu-zc50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelkeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
 vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
 pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
 grthhtvghvsehmvghtrgdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghmrg
 hsthhrohesfhgsrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhg
 segrmhgurdgtohhmpdhrtghpthhtohepmhhnghihrggurghmsegrmhgriihonhdruggvpd
 hrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegs
 jhhorhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhmihhtrdhsvghmfigrlh
 eslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:mDcCakqPSRoKzyPGGXProFqYhH4qYKpgflb8Spsx6bK2Yvak4Gd4uQ>
 <xmx:mDcCahGgEJbSVtbnpYLanu5mqQCGZRveGu3g79YLyppoXoJCZIjPIw>
 <xmx:mDcCamshnuz0U_drzHUfOKcWk73kxV1nW7PxZm4wDep0feme0jrxgA>
 <xmx:mDcCakRquOgmfyzbwC0uVpaxobRtcOQaDFkpxWtGwg4yfJK0yK_Dww>
 <xmx:mDcCam7wLKey_JuLtJOlx4ChD12laJy6R95rvUhqAlL9MfIcaz87pHbT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 16:09:58 -0400 (EDT)
Date: Mon, 11 May 2026 14:09:57 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Pranjal
 Shrivastava <praan@google.com>, Alistair Popple <apopple@nvidia.com>, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <20260511140957.25eb5d9d@shazbot.org>
In-Reply-To: <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com>
 <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
 <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
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

On Mon, 11 May 2026 16:30:39 +0100
Matt Evans <mattev@meta.com> wrote:

> Hi Alex, Leon,
> 
> On 27/04/2026 15:36, Alex Williamson wrote:
> > 
> > On Sun, 26 Apr 2026 13:52:15 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> >> On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:  
> >>> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:  
> >>>> A new field is reserved in vfio_device_feature_dma_buf.flags to
> >>>> request CPU-facing memory type attributes for mmap()s of the buffer.
> >>>> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> >>>> PTEs for the DMABUF's BAR region.
> >>>>
> >>>> Signed-off-by: Matt Evans <mattev@meta.com>
> >>>> ---
> >>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
> >>>>   drivers/vfio/pci/vfio_pci_priv.h   |  1 +
> >>>>   include/uapi/linux/vfio.h          | 12 +++++++++---
> >>>>   3 files changed, 23 insertions(+), 5 deletions(-)  
> >>>
> >>> Nice and simple
> >>>
> >>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >>>      
> >>>> @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
> >>>>   struct vfio_device_feature_dma_buf {
> >>>>   	__u32	region_index;
> >>>>   	__u32	open_flags;
> >>>> -	__u32   flags;
> >>>> -	__u32   nr_ranges;
> >>>> +	__u32	flags;
> >>>> +	/* Flags sub-field reserved for attribute enum */
> >>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
> >>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
> >>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
> >>>> +	__u32	nr_ranges;  
> >>
> >> Alex,
> >>
> >> The TPH proposal extends the flags field in a similar way, but I suggested
> >> a different approach to conserve bits. At the moment, we spend three bits
> >> on a single feature, which feels wasteful.
> >>
> >> What do you think?
> >> https://lore.kernel.org/all/20260409120415.GF86584@unreal/  
> > 
> > I already proposed a very different interface for TPH that decouples
> > the dma-buf creation from setting the TPH values:
> > 
> > https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/
> > 
> > This is overall less intrusive than the TPH change proposed, but it
> > could still make sense to align this as an operation on the dma-buf,
> > that can be probed as a separate feature.  Thanks,  
> 
> I'll add a VFIO_DEVICE_FEATURE_DMA_BUF_ATTRS in a v2 instead to get in 
> line with the TPH work, no worries.
> 
> For the benefit of future hackers, how would you describe the criteria 
> for adding flags to this existing field?  What hypothetical feature 
> characteristics would be appropriate?  (Maybe it's that these attrs & 
> TPH add scalar fields in several bits rather than a simple boolean.) 
> Two of us have independently added something that's turned out to be 
> inapproriate so some guidance would be good.

I think the question of how we actually expand an arbitrary grab bag of
"ATTRS" is the central question in whether we should implement the
interface.  If we follow the direction I suggested for TPH, maybe this
is just a VFIO_DEVICE_FEATURE_DMA_BUF_WC, where it supports only PROBE
and SET, with SET taking only the dma-buf fd to implement the one-way
promotion from UC -> WC.

If we support a generic SET ATTRS feature, we really need to map out how
flag bits are indicated as supported and how a user untangles failures
from trying to set various attributes.  If we end up with a feature
indicating each ATTR is available, we might as well have just
implemented a feature for each attribute.  Thanks,

Alex
