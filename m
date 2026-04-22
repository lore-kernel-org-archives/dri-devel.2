Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9245BFA1FEB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E6710EF13;
	Wed, 22 Apr 2026 19:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="H2zqWgVu";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="JCcSbt3U";
	dkim-atps=neutral
X-Greylist: delayed 533 seconds by postgrey-1.36 at gabe;
 Wed, 22 Apr 2026 19:36:37 UTC
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946EE10EF13
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:36:37 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id B08AE1D0020D;
 Wed, 22 Apr 2026 15:27:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 22 Apr 2026 15:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1776886063;
 x=1776972463; bh=ggHJMFIMAYIVtfMm4SfiR6xNegxNgGhsEzHrf1YC/TQ=; b=
 H2zqWgVueVdHhGmA/l+SyejrcQJIuT0lMHQWPHderHUkwn/xcF3Cp84eTGQ2+kxL
 9ClJS3wT30glCIX1XF7Hw9s9/VzKwITM+pfCvJHSQpxf5aYzMYZgRIHqKdMPXSgW
 8bYv89IVb79UbHWFo0LKfep+X8FHZUSAioBYN6cvzzHQURLO4TeV9m/M6nWJF5nw
 8baettDbtFyn8jFTZBNWAVTwMv93ivokyrwZ6SZQ2UDTTrJ6KjDNKxdeShjhec2f
 3w3GKgJvEXf4Jv9Fcpfmfo+ArBZyRLasqCz2qmRQn6TkF3Bu/+8MswTi/qgwL+VY
 /QwEq2CqGn5i0kveGXEopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776886063; x=
 1776972463; bh=ggHJMFIMAYIVtfMm4SfiR6xNegxNgGhsEzHrf1YC/TQ=; b=J
 CcSbt3UXqNDZdMAD+suswr0h55WRx5sH5kDsgz2ZD/mFSD5LMFjnExdX3DJGW57H
 sXQdLhcASd1/XUOpVYj6MATwIgP3lcMTuUfr3kSXvpWEKD7ip9zI9ZqbPFyRY3mo
 nJheiYHwKVoDcjZYqGjtNSI9bxDtL+fQx79a93anFOQkqIzWthsMRtVzFbL1JifQ
 wbsUwHJWTJf3LuUPGugAkrz2x9nYoH5uJMBTKCHWFeGNnGvWI+AYyvyHpy1BqDKp
 wpCw34NR3bkCCJIZrR/BISsN2qnXLSg60po+9MP2qsgspiGpuhzmKLIpyaLdfwAX
 9qGljhxwyc+JDez89jMqQ==
X-ME-Sender: <xms:LyHpaSO4p1kHk-rcqnzezrRe1Kkm-d6OD7Ij4Z8yMuTOIHL9meDRcg>
 <xme:LyHpaUrM4pP9b-SGUaPuwE9GU82tfhZ7_99k0_J_7AUHAFUisqzAVg60y8nMWtkDJ
 qxI0FxGkM8qs0bTfcC1QJWNDwBRSzKKSc4GlIJ5pb3kRTjG-J6SmQE>
X-ME-Received: <xmr:LyHpaR7FygKgFPat_6DK2XSoqf46NHfZF2B0nXadDscvLwZ_-J66Mjj1rFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:LyHpaUEpl0kbj3Zr_QkWClsrz5XH3Tb_GgEKBR7JhjCI0jIr-WH32g>
 <xmx:LyHpab1-w6l48axOOr6APQzH6pTOpV24DSq5gzvVEIlVGn1Zj-gL0A>
 <xmx:LyHpaZoDdUZ7d1egrMVpR02SBwN3wIqZ_DIsOpTJx97x6ZPSSIlwbg>
 <xmx:LyHpaQN4guGLPxrPWNIvZBxwAXksahGHRXiNIZ8zqKvvNnqeT_fw_w>
 <xmx:LyHpaWrLBulWkK53QFC7Xs3L67e0zKDXohnMzX3K4_ecS8-S26PQiG2V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 15:27:42 -0400 (EDT)
Date: Wed, 22 Apr 2026 13:27:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260422132740.5f809bf7@shazbot.org>
In-Reply-To: <20260422162928.GL3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
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

On Wed, 22 Apr 2026 13:29:28 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > In general though, I'm really hoping that someone interested in
> > enabling TPH as an interface through vfio actually decides to take
> > resource targeting and revocation seriously.  There's no validation of
> > the steering tag here relative to what the user has access to and no
> > mechanism to revoke those tags if access changes.  In fact, there's not
> > even a proposed mechanism allowing the user to derive valid steering
> > tags.  Does the user implicitly know the value and the kernel just
> > allows it because... yolo?   
> 
> This is the steering tag that remote devices will send *INTO* the VFIO
> device.
> 
> IMHO it is entirely appropriate that the driver controlling the device
> decide what tags are sent into it and when, so that's the VFIO
> userspace.
> 
> There is no concept of access here since the entire device is captured
> by VFIO.
> 
> If the VFIO device catastrophically malfunctions when receiving
> certain steering tags then it is incompatible with VFIO and we should
> at least block this new API..
> 
> The only requirement is that the device limit the TPH to only the
> function that is perceiving them. If a device is really broken and
> doesn't meet that then it should be blocked off and it is probably not
> safe to be used with VMs at all.

Ok, if the vfio user is only suggesting steering tags for another
driver to use when accessing their own device through the dma-buf, and
the lifecycle is bound to that dma-buf, maybe I'm overreacting on the
security aspect.

I don't know how to qualify the statement in the last paragraph about
"[t]he only requirement is that the device limit the TPH to only the
function that is perceiving them", though.  Is that implicit in being
associated to the dma-buf for the user owned device, or is it a
property of the suggested steering tags, that we're not validating?

Steering tags can induce caching abuse, as interpreted in the
interconnect fabric, but maybe we've already conceded that as
fundamental aspect of TPH in general.

So why does vfio need to be involved in any of the sequence proposed
here?  It seems like it would be a much cleaner design, avoiding
overloading the existing vfio feature and questionable array semantics,
if there were a set-tph ioctl on the resulting dma-buf instead of
making some vfio specific interface bundling creation with tph hints.
Thanks,

Alex
