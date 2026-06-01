Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F0CCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1F711368A;
	Mon,  1 Jun 2026 17:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="VvmpDGgm";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07E3113687
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 17:47:36 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8cceaa6f75bso53866536d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780336056; x=1780940856; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yZ9wJintER1aMQNJJDa24+/EucywMy/j2tmrZTRhl8o=;
 b=VvmpDGgmWP6B/z+fGSAW8Zk4PD7Lb3BPpbr2RQIKxXDSXXX8hmiThTVHUQ6qOT17D/
 JDPhliZvtd0QBXx2h2m+LkWTFedGQwfI0V2uoYnpl3SWBVSxWrSCPoTVBMW6jgCUansS
 5UKpxwUGHfllEg2nW3SXV+hlQnuiU7EFPQp3a+GGD0Sc35i52v0rlTi2HMoSYDT04gMl
 gr89k7hjwbS0jxnT98cOOQ/uciUkhrBlM8nuvaV8QI1FytQT80vtWgd7t1/5+hvDPR/4
 3JPjC+WYGPh+VIN9kOaYPMhW8IoDTfiFznCUeSA3sNbP4kAbif1YDEp5MI0hd+RTNlk7
 uWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780336056; x=1780940856;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yZ9wJintER1aMQNJJDa24+/EucywMy/j2tmrZTRhl8o=;
 b=QkPb5AEC45+glMLpxBu7G3lf9IZfHe+JfSl1OIh5h/ydAsw2GpnoJcctLEF/B67SDl
 q3TYw5OIvN5uzwB+f+ykosTE/0AQEAgieNVYEr+nYd/4gkmE8I9QgTZR4q9ayno3bvqG
 gfQZ9lLDvVeB853NWOw61oFj99oKkgWK3locuhF++RbkcsflVQW/anl1Y1UpWytkcNjd
 HRcAxgBlc/OWNBGqdwSVvVzHjRBBgAt+rZLC1StidXTxiJgvZJ7pm4sTGQrhhx6n9AYW
 p5qbRgZ42eZKyOF6nzrbd+Mb7QaOwHORL5/+6cFGqlmxavSX6zWMlz1BSakzP8oIgqjH
 +oCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+0HMbFozYLoc6PpZmeUkJxSuADUfcBNcrweJpdq3Q+5bwaeqcGvhxarYpkqTCRCjADfcnKM8t+Yo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ+O5/K0KGzz//HVJvRU3kVE5ft3D5P8xf6DfOz5d9NM4auD7j
 aOgURJfRTnizFt7o6n5ZPbQ2jxkLV6nM24YDEfBKI7qL5xq4tp0P7yrbRe6kCel83Ho=
X-Gm-Gg: Acq92OGUbkaemlsBF8Y3DEqWvMJDy69CAB/9Hnx0gtXjyXXcA82o4SU3IU4S9H0kfSh
 NZV95R2Oy2WAHr+bhHRvrhdrazhKsD8+XmJbbghIdD96fp6Z43ZtlKO9jF9x0wCdx3THaMdjWp7
 v+TkZz0N6fCbSeOFxiZiznJo7RsZe0Z9UzaEQqd5RFgCEWlCf/ciXajsw9RqFL0PXJpjfc59YEd
 UP80Bhms6Rkq6WdHt81ADvm0964PuTwN/O9UsSbSxnYttZYf/Tz547HpP2U/ivRjSQxWFR4qpYk
 g/ZVy0LuUfr77ciZ3rF5mW1J51WZQ032L/DgIvbzBqCIbQk28rcstnMgP/CRjMWajXRXCz9nA2n
 tu3V0QxqMXyBHyLPnJWEwwvdIbYvFl3OGT7Xp9spR5AdfbVL2k/Y9Oi4p9zrwbILho/tqE83pVB
 4x7ZyiO87N/dQhWd+3ExXHgX6EwRstZrE7qEylnDX+Vf7qhkOcL6TQYY2nz52Pa0DPiREyka2Il
 x34tQj+tY/nR7fd
X-Received: by 2002:ad4:4eec:0:b0:8ac:b258:71d1 with SMTP id
 6a1803df08f44-8ccefb29374mr211892386d6.3.1780336055817; 
 Mon, 01 Jun 2026 10:47:35 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea25f64bsm96664256d6.47.2026.06.01.10.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 10:47:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU6je-000000027Jd-2qcE;
 Mon, 01 Jun 2026 14:47:34 -0300
Date: Mon, 1 Jun 2026 14:47:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601174734.GB2487554@ziepe.ca>
References: <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
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

On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
> >> When you have a complete open source driver stack which utilizes
> >> VFIO passthrough as the interface to communicate with the kernel
> >> drivers then we can eventually talk about that.
> > 
> > That decision is not up to dmabuf
> 
> Yes it is. This is the DMA-buf API which is added here.

It is a DMA-buf kernel API that is added, I think it is overreaching
to try to veto a VFIO uAPI that calls it..

> > - what VFIO subsystem requires to
> > accept a new UAPI is up to the VFIO maintainers.
> 
> As far as I can see vfio-pci is used as a stub driver to avoid
> opening up the real driver.

Yeah, that's probably true.

Frankly, I'd rather they use VFIO like this than to upstream another
driver for proprietary custom built HW which nobody except Meta even
has, let alone can use.

> Upstreaming an API changes only makes sense if others can use it and
> this here is something completely special to this particular use
> case, without all components involved nobody else can use it.

It is not 'nobody else can use it', if it was true VFIO wouldn't be
leaning toward the uAPI being OK.

This exposes a PCI SIG defined TPH capability in a reasonable simple
VFIO uAPI that can be re-used by any other device that happens to
support TPH on inbound MMIO. The uAPI has sensible general semantics
based around the PCI spec.

Anyone can repeat the demonstration Meta outlined in their cover
letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
analyzer and you will see the PCI SIG defined TPH bits set the way the
VFIO uAPI says they should be set.

There is nothing uniquely tied to Meta's device here, or unusable by
someone else's devices. Arguably this is actually a mlx5 feature to
allow VFIO to control its TPH generation HW.

For a long time the general kernel has had a philosophy that as long
as these niche features are generally implemented and *in theory*
usable by anyone who wants it is OK. Every knows the initial userspace
implementations of *alot* of stuff starts locked up in proprietary
software owned by database, and now cloud, companies. Yes, some
subystems are stricter, that's OK too.

> So as far as I can see that here is a no-go. But at the end of the
> day it's Linus who needs to say if that's ok or not, that's why I
> put him on CC.

Well, based on what I heard when I argued for fwctl, and the
discussion with sched_ext, I don't think implementing functionality a
standards body defined in a logical way is going to raise concerns..

Jason
