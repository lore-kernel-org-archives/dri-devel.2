Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24F210F2869
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2383E10EDD6;
	Fri, 27 Mar 2026 19:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CgWQK0F0";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F79310EDD6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:43:42 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4852ef20fe8so2615e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774640621; cv=none;
 d=google.com; s=arc-20240605;
 b=RGbCl42tu3OQmuDFiygnCpPNDssFteSqlw0dXsW67H4GSUjEu62k5xdDlvOuMQNMGO
 jwZGMVlSWbTEDcoK5oqvhAvR9PLHo+9mp53TnhB/gSEcC30L4UbffkOxCHLp20H+hF+x
 PXeulYElzLNbNDR5NK5yZsXFBrUdKNm29+MW1t5Ib0mZ/X9ngCPvwmt901slUojPfRbz
 zW2KnY4lvFpoHeY8Eq9Frnv3rnUpA2sj1LGyOufx/TZFuocD09LjmLc9WYKQGYHY4eIv
 iZCz2VJGxlbuEIKDpywp1cd9LWHEsgNDMUwjvAFoqBBCaTpCyRm82TXKjEKOxYQ/aTYr
 m+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
 fh=zfORdTUU8CSelTCtrkHdOqklbs+TuRda0p+lwwMzGH4=;
 b=GQ7JUZFC86w9qHKD1PCrjaQ/YHTHmJN5vfqSGkg8+ZLVUTtHpztnnbjtJGKLR79NJO
 8/9NnXqga4Q8ewtXmbixZLD5cJj0/7cclDglX2UB7ukZD+My7DJzTdinn8IMPZdoR143
 LYn9Ykes0TGwRI8/GT3GUKub3a2FeLYDBri5+E0g2gzC+wJJlJsPQ8JqYThXSWSR8kIT
 yqbCf/9Upwq5Tih9Z+vh8gQyFL3oEoWRNl3o36MvTn6UlkE6wZqJnpBwH06pyKg+4ZZx
 kJ0Ve6m4zY4yHQ0ICR2Tmdj4Cl+DXCFjVZF8sxyQR5qFKaF89WPEiXUwoQsryQ4nKzIv
 m2IQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774640621; x=1775245421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
 b=CgWQK0F0l+3t327rjv4xWHEGDF7Unadz10QNQwRC5SuzDisU9T6mqd9TfEJbar0PL4
 UX/TK5+FiT18ZQqp8geR2XAi8iI9FAx8b1ALi/X+I7RCltzLDV9CKPTU3Phf9u3Z7NDG
 RUP2UXRP0q2rEWDmifxcz6sasRH8r6WFKcKbrxZPeFq0Vqz/ill6SMi8anTnApvlTzhA
 QBymb+YvOlBVwQ/n5gTLt3Bu2YvcKayoF5bkISO6IazocQ9T3iX5C6ruNPFHSonbJK/A
 QL4UOk4jR/xia92E/4hkFKbAf8mCVaG3md9cbEps+vXpYDQGOj/iASMXyyLWtGnJ9Uxw
 iMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640621; x=1775245421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bp8Rzg51lEDwzJFZ6phUlxNkzebzC2DJpAPYxDIaxlM=;
 b=hMB39dvBgd7kHAC3HfyQWrlfbqH6MaoMprtHZ3Fqy64+wHWOfzvYtL5b2DP2medG71
 J2spk889x8MREQEekycPas+l1r1BnrciKkrbBrAD0K4py6/WBILbyRpYJrxqgGoo/nsZ
 QELgFl83WqI58MyMERkYkW+Fu/obCafVp1E1M7U90aMwWKFSIrMcBqOhxkgcOGSmNo61
 RlLzDLLhzmFo7iOI2leDiW99nTys5aEwk+HfVae7EPb7Jx0tlHBUwoIal4pr60NgS4Dt
 ZIPPchtDnYUUEXvLafF2T8V4w3ibkUbYAW+WMIps1kniHtnupHZK647ywTTZEisqoJiT
 nw+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZijY9Lwe7kJWSJSu8U2jxvS8D/gJu52P0cBslbCfRcmuYr4qv43vsp6RzNbgIATXuTvRdKXnWLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+yroUj3k8Lw5vMeC5AUF0pAlNUeFaFuupuWABnqX77n1SkFip
 QMZi8jwdkNofO7Ii6sC31YK1b0CCM3wTEF8NNgDvKDbKRO/VUUvzu9+8sdc7+XwUSx0n2sDbCIe
 XPuXP/UFX1rNR+9UmuCPujWHuuSl5asdHLEZdXMNJ
X-Gm-Gg: ATEYQzzB2dm9rILBuqVkdRsi0c7e53dx6UDUKUU8YpW0Ge6Db5SVJ3mQt9r+cnIiiVa
 iNheIbzjNJB6zwwVG7a5LGVnwgHthmM8c1Cm6SpoqWjiFy3NbvjZpB80scOTpPdA2IMlPAQuv5s
 961DZNS8UehBohMTwzVIk4kHyLGQgUwoMfzAJwc3Jl5ySF3ePKxBEItkYin14RKXgoRj8OXpTMF
 tMLICh9P36hpcKJau3YswPWaGGHRfuBO5Fj+j/iCfCiXAWe8fVt1Uno5Nd3x6s2lCVMLTBMU1Vx
 dK8GteX3S2l4xu550KjEr24I44Drk45hhGFNaxOFstOAJPYmEbvBMqpk/V614+nF4Hld
X-Received: by 2002:a05:600c:474a:b0:47e:de1d:ce99 with SMTP id
 5b1f17b1804b1-4872fb2db92mr169905e9.12.1774640620548; Fri, 27 Mar 2026
 12:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3@eucas1p2.samsung.com>
 <20260325192352.437608-1-jiri@resnulli.us>
 <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
 <20260327121021.GB246076@ziepe.ca>
In-Reply-To: <20260327121021.GB246076@ziepe.ca>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 27 Mar 2026 12:43:28 -0700
X-Gm-Features: AQROBzCEcKgPP9gV3lvkFItmqoWSRLzeH8nf-BLcIkZAnZ3bjMQA_OWXnQtSUH4
Message-ID: <CABdmKX0HYg_HQAb44QGcO-frCTu+0h=uqS70CTcYtRs-Y=y21g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jiri Pirko <jiri@resnulli.us>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 christian.koenig@amd.com, robin.murphy@arm.com, leon@kernel.org, 
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com, 
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, 
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 27, 2026 at 5:10=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Mar 27, 2026 at 10:38:10AM +0100, Marek Szyprowski wrote:
> > On 25.03.2026 20:23, Jiri Pirko wrote:
> > > From: Jiri Pirko <jiri@nvidia.com>
> > >
> > > Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel T=
DX,
> > > run with private/encrypted memory which creates a challenge
> > > for devices that do not support DMA to it (no TDISP support).
> > >
> > > For kernel-only DMA operations, swiotlb bounce buffering provides a
> > > transparent solution by copying data through shared memory.
> > > However, the only way to get this memory into userspace is via the DM=
A
> > > API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> > > the use of the memory to a single DMA device, and is incompatible wit=
h
> > > pin_user_pages().
> > >
> > > These limitations are particularly problematic for the RDMA subsystem
> > > which makes heavy use of pin_user_pages() and expects flexible memory
> > > usage between many different DMA devices.
> > >
> > > This patch series enables userspace to explicitly request shared
> > > (decrypted) memory allocations from new dma-buf system_cc_shared heap=
.
> > > Userspace can mmap this memory and pass the dma-buf fd to other
> > > existing importers such as RDMA or DRM devices to access the
> > > memory. The DMA API is improved to allow the dma heap exporter to DMA
> > > map the shared memory to each importing device.
> > >
> > > Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0=
d
> >
> > I would like to merge this to dma-mapping-next, but I feel a bit
> > uncomfortable with my lack of knowledge about CoCo and friends. Could
> > those who know a bit more about it provide some Reviewed-by tags?
>
> I'm confident in the CC stuff, I was hoping to see someone from dmabuf
> heap land ack that the uAPI design is OK.. TJ?
>
> Jason

Hi, yes LGTM. From a uAPI perspective it's just another dma-buf heap.
