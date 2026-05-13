Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19255CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3155210EFCD;
	Wed, 13 May 2026 18:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="ugb+w/Mo";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="n2G7CcIS";
	dkim-atps=neutral
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048CE10EFCD
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:27:40 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6D3E81D000F8;
 Wed, 13 May 2026 14:27:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 13 May 2026 14:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778696859;
 x=1778783259; bh=GbnJfjRBStiaKRZLT02VZB1354Hvx0h1gpT2X0Kvpt8=; b=
 ugb+w/MoCK+Cq76KPvoo+wISMQpprZXQdAk3i/dgnuTYPy3OkQxSs2xFN6MRw/2M
 fDw9YGXrGE8B01bJVgCgLHzhFpTS9QOlHoYqM1QXCwm5Ze24EjpAfIyORs0VLEP4
 mAHdBht7lRSDkgaBknw9fbXkWGZtyTihrXg3zxxJ6wcAkA9WtgD8rL4RHsztZCem
 Rsxp0gY2tcehmxqWfqGaEuHH8QEHjlwpdWYUb28t+YnVjVjYCnoQuau211sb/ygZ
 I95d/csNuJeEVJXsyrlmmxuRwmuye0dKesPtXphaf5+z0313rMwrNSpg8geNRX14
 IdFuFN4voLZy26kzty7deA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778696859; x=
 1778783259; bh=GbnJfjRBStiaKRZLT02VZB1354Hvx0h1gpT2X0Kvpt8=; b=n
 2G7CcIS5liB/toFj6ghq8YrTIMXPZsGeuHApr+SOQDFQ+h80ntmkyU1vu11TQNLn
 6wo9Q8HJEQ7Xzj7yJhmuAlljUcYGbn1ZezzqASVdULb7eLOe6oeVILfbZ9MADbUo
 EnidDJ5bsv5WM7nS3HZhDa718Y3QOKKrbnwxZ8vxkEXdP7EUYNtpJz+eZ1JGeviv
 XrO56AcRztohEmu280ftsqZfsYn3MafnOxfO9OJ0xrtZmznCXEXL2LV75UZmcvhr
 WOm87c/YFr2Pz+hejCT1jQ5DAP1BiDOyaEsM9kbjr7ehmOjDogiVLb/CMZGADjxj
 vfKEqakOKsuLjRz9Whymw==
X-ME-Sender: <xms:msIEal5CeibmOq0PCnIL7PBxOf49fDLoRWOFLCziKHN4tUjlg4e91g>
 <xme:msIEahSgyT-T0RaMchXzdGGmG9Nnviw6xPgZRT_fMv-Z-_FvnqINtRkrOnrtwe2r8
 Gg_stuv7xKsBNCtzPXLcvmlz-zgn1uIgMhjfiXvzmIhvDUAhkT-sA>
X-ME-Received: <xmr:msIEaofZhrS0KQe9p0LVgEjp526ztDG3_O4dGSYXPnrqfZYiGdNhbLpPN64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehfeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
 veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddtpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehmrghtthgvvhesmhgvthgrrdgtohhmpdhrtghpth
 htoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgsehnvhhiughi
 rgdrtghomhdprhgtphhtthhopegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhope
 gthhhrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehmnhhg
 higruggrmhesrghmrgiiohhnrdguvgdprhgtphhtthhopegumhgrthhlrggtkhesghhooh
 hglhgvrdgtohhmpdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepshhumhhithdrshgvmhifrghlsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:msIEahR_qV9UuC2kZahvYM7vpuJVR17VDHGmXFC5xtuw5qvCJ9mP1w>
 <xmx:msIEahM1kYu8s--pXaSCxNbdlLG627KP8nKF3hwZrIMOKTzPH27PNg>
 <xmx:msIEakVfFRSlf7afEpvKFjWU9Ww9TuD8S5Dnnyz94-O7VniPJ7ybwg>
 <xmx:msIEahacB-lTAHRQfaLsechQRlclOtlcemlNYlBo-ddzPeUvY2P0vA>
 <xmx:m8IEagDolmbmx2QFR4KKx1ySonJwF1ARYPlv-gqKIIpCvhBQ7hOrbT3j>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 14:27:37 -0400 (EDT)
Date: Wed, 13 May 2026 12:27:34 -0600
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
Message-ID: <20260513122734.44ce8a68@shazbot.org>
In-Reply-To: <4af0c788-22cc-4fb1-9276-ab35439fb7c8@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com>
 <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
 <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
 <20260511140957.25eb5d9d@shazbot.org>
 <4af0c788-22cc-4fb1-9276-ab35439fb7c8@meta.com>
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

On Tue, 12 May 2026 18:51:40 +0100
Matt Evans <mattev@meta.com> wrote:
> On 11/05/2026 21:09, Alex Williamson wrote:
> > I think the question of how we actually expand an arbitrary grab bag of
> > "ATTRS" is the central question in whether we should implement the
> > interface.   
> 
> > If we follow the direction I suggested for TPH, maybe this
> > is just a VFIO_DEVICE_FEATURE_DMA_BUF_WC, where it supports only PROBE
> > and SET, with SET taking only the dma-buf fd to implement the one-way
> > promotion from UC -> WC.
> > 
> > If we support a generic SET ATTRS feature, we really need to map out how
> > flag bits are indicated as supported and how a user untangles failures
> > from trying to set various attributes.  If we end up with a feature
> > indicating each ATTR is available, we might as well have just
> > implemented a feature for each attribute.  Thanks,  
> 
> Agreed, that's key.  Alhough, the aim of this patch is for attrs to be a 
> memory type enum rather than a bag of possibly-concurrent and 
> possibly-conflicting boolean flags.  Maybe 'memory attributes' would be 
> a better feature name.
> 
> I'm not sure about the feature-per-attribute.  Say we do a 
> VFIO_DEVICE_FEATURE_DMA_BUF_WC and then later support a second, 
> VFIO_DEVICE_FEATURE_DMA_BUF_UC_WEAK (like, say, Arm Device-nGRE).  Then 
> we have to specify that these two VFIO feature types actually 
> interact/override somehow.  I doubt we'll end up with a dozen but it's a 
> bit tiresome having a few features that interact.
> 
> At least if it's a single DMA_BUF_MEMATTR feature taking an enum, we 
> just encode the N different (mutually-exclusive!) valid states and done. 
>   I don't feel having a new feature for each keeps things simpler.
> 
> Discovery of support for a specific future attribute is OK with a single 
> ATTR too; we can take an enum attribute argument to a GET and -ENOTSUPP 
> for any we don't like.
> 
> (We could also add orthogonal DMABUF flags (can't think of a good 
> example...) but I'd suggest _those_ as semantically-grouped different 
> features, with the same issues of specifying conflicting cases versus 
> existing features.)

I think the GET behavior you're proposing is a bit counter-intuitive, if
not abusive of the interface, but I do agree that if the feature is
SET'ing a single value and not a group of independent flags, that we
can probably rely more on a try-and-fail model rather than advertising
each supported value as a separate feature.

For example, the user has some list of compatible attributes ordered
from most to least desirable, they try each in order until one works,
or none work and they decide whether that's ok.

For GET, if we implement it, I think it should report the current
attribute, mirroring SET.  We could almost get away without implementing
it, but I do worry about the case of nvgrace-gpu, where it might be
interesting for the user to see that the default attribute could be WB
rather than UC.

Where does the user derive the enum value?  Are we defining our own or
is it a system header defined enum?  I'm curious if/how we're going to
handle architecture specific attributes.  Thanks,

Alex
