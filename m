Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C79C982F7
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC1D10E739;
	Mon, 21 Sep 2026 13:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="h8uMBFCQ";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E063510E6FF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:09:01 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66f943b286fso2487879d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789996141; x=1790600941; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/I4CnabOFJ3V+cBV+khghf4ltJkhcHX6gZAKyxfIiuU=;
 b=h8uMBFCQRT1CbBC4iLlFfTLHsJIGlrWAN2zLHRdjJc9gJrqPdS8YcJ9BnKFwu73kYj
 0wmvMfYRHCfPLyGXY2NC85vPFPxxKt/JF+UtcmL5UeyQhLeDPJu0VgN03I2v3X/aiuEY
 Xh06s3/Fq9DzaVUQ/fCb6XoUvjc8gdQIq9VIkNO5fay41RzHu5nTSJuzHW0s1C9oEh8o
 zm+ipgTvRPmztGWK9Sj+y4Lm3qJHlGxmtzmuhBHvDONAAzJYCPbX/BOLsB8GMTABxoDf
 snnRz0Y0CFKj/xDAtxWYcpVaUquhxzx85rtKFRc4R3J5cneiLInmYsyWbi7neB72r2KY
 O1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789996141; x=1790600941;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/I4CnabOFJ3V+cBV+khghf4ltJkhcHX6gZAKyxfIiuU=;
 b=ebTUWlYF2HKA/bwTfJndqbVOSpMXrXrtr9puOaoxH60l4iFeAByFgR9fQoK0ZOF1nb
 OpV4C8oqQdAIUEOwYt9QAsq594BM69FsrKdLqKq9NNzFLz+oZH3mpAIPhP45Q1scaVF2
 0HV/3/B5fGFz8YQkXyhfCYz4/AIz4iCgOR0DO7yORc1x3daYBBoE2LurBUHphExthGbB
 IcAD1LT0CmFUP5dCK1wg2HaVJBDGK1KwNkeIp0/bsqB+8mAK47TlVXOqPPqm3zvyfufH
 7Aouz2n9S89CA8wfpJ8t5ZWpHYcDwFev8tgJeix8T5JZg0uC8ez3iKsjYMU9Kv0WE8fi
 UrZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByl4HaQvnQhsTrqcVEN+GK9C310lpY1lswZM1rpRDB9x8EeFS1AZMhfx4oWEh9xR6Ww1HEKIJRO5Xc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++koN42Ijh+scICiVCpmP6UohHQZKxd7PepIo0MEfeFR9zMqE1iv
 pnuHwiUb97wfi3MEaVQkZsWG8RCtuVAsOtlIBxcY8rh2slGh9p6Oe+K/gye1f09xO8Q=
X-Gm-Gg: AYBFou0uFpH9u2H6PTZIQnmaq6NzPsl9aeTx+y4tnkDIqnZl/GWfOCXPJ9ldpe9sCVO
 l5CCv+/LpRH+f29DcsPi6LicIychPHfdIINsxHL32nTP7WM0hTgMVjGFYRe8exnwvsxy2yuNsYL
 YXZbDfYpdJyU5JVBZkz+HiauPpjAJZP84DlpgHvCwDqMXgyxJ02mnqARd6rJs7K3vzaGw+VMMod
 qnTJH+MZhs3NfaRnNotnHWXFXfI9MlKXb8M2KVK6nnK4OAT+0w/M3QUsTaXk0relddxswYiFt6+
 Fba1Xij7HF+3dAmD0l23jbjC18PYXtOQxIPW8j7WVo1T8+fofb+uphURyK1eCtoTsQG3/ko6CaN
 3tA4swUn0sOSpmG5jr++ZdPa8CTNa5n18Hzvxm/D//QtUbZ6WANBUnvpVRxR4FG4sC7feB+ejzm
 gK725gnXQwfBGEpCSw6+Ap5u0Ti9uaBzdlVuFg/4ECz/CibHrDWMP/lY3O2oIK7savS/o+zN9vX
 Si3lYRDPNhkn6h/dj6gZ7G/iiWxGehKeIDeza3DG9cmt7LD7uFDEqQI
X-Received: by 2002:a05:690e:11ca:b0:672:a52c:db25 with SMTP id
 956f58d0204a3-672a52ce30bmr1843524d50.109.1789996140490; 
 Mon, 21 Sep 2026 06:09:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91260aa1db7sm67720106d6.44.2026.09.21.06.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:08:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x8dlS-00000006Jlj-41LR;
 Mon, 21 Sep 2026 10:08:58 -0300
Date: Mon, 21 Sep 2026 10:08:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260921130858.GO11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
 <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>
 <20260918170524.GH11599@ziepe.ca>
 <9656f2f9-2e39-4007-b065-3b763b53c6de@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9656f2f9-2e39-4007-b065-3b763b53c6de@amd.com>
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

On Mon, Sep 21, 2026 at 08:43:49AM +0200, Christian König wrote:
> On 9/18/26 19:05, Jason Gunthorpe wrote:
> > On Fri, Sep 18, 2026 at 03:42:28PM +0200, Thomas Hellström wrote:
> >>
> >> 1) Xe attachment check if pci_p2pdma_distance() returns OK for the
> >> path. Then Xe always sets up dma-addresses using dma_map_resource(). 
> > 
> > Open coding pci_p2pdma_distance() in drivers is a hack. Using
> > dma_map_resource() like this was never "allowed".
> > 
> > We've fixed things so these hacks are not needed, the drivers need to
> > move over to things like dma_buf_phys_vec_to_sgt() and the hmm helpers
> > to use the DMA API correctly.
> 
> That is a completely broken approach as well since it limits the
> exported resources to addresses the CPU can reach.

Yes, of course it does. The DMA API only works on phy_addr_t. If you
have a struct p2pdma_provider * then you have a phys_addr_t for it.

If the exporter knows it is working with a MMIO mapping on a PCI
device it gets to acquire a p2pdma_provider and use the helper.

None of this is suposed to solve your "resources the CPU cannot reach"
problem, that has nothing to do with DMA API or P2P. It is not broken
just because it doesn't solve every problem.

> Christoph Hellwig is right that drivers should never use that stuff
> directly, not even through that dma_buf_phys_vec_to_sgt() function.

Hellwig's point was that the subsystem needs a mapping helper that
goes from the subsystem address representation to the HW
representation and hides these details from the drivers.

Look at what he built in nvme around biovec.

The dma_buf_phys_vec_to_sgt() is the dmabuf version of the same idea,
the subystem provides the mapping helper. We can try to do better, but
better is not making the exporters touch the mapping algorithm.

Ultimately I want to see something in lib/ handle this with a
non-scatterlist datastructure, but there is a huge gulf between where
dmabuf is now and it being able to work with a non-scatterlist
datastructure.

Look, it is easy to complain you don't like how it looks, but this
stuff is hard there are lots of competing concerns, if you have a
better idea now is a good time to present it. Maybe if you look
closely you will appreciate how much work has gone into even getting
things this far.

> >> It seems to me that a pci-device settable flag "ATS always enabled"
> >> should be enough to fix both issues?
> > 
> > It should be be per-mapping to support the NIC workflow that isn't a
> > global operation.
> 
> I just realized what you guys are doing and I'm not sure if the
> Linux PCI subsystem should support such hacks at all.

I don't know how to respond to that. It is spec complaint, it is
shipping in enormous volumes, of course Linux needs to support the HW
that exists.

> Basically from the point of view of the TA the NIC has ATS enabled
> all the time, but has a per request option to use translated
> addresses directly without previously translating and caching them
> using ATS, correct?

Yep. Very few devices in the world can use ATS for every single
operation. Many have this split operating model. Some even only use
ATS for DMA flows that are faultable.

Mostly the OS can't tell what the device is doing and doesn't
care. The P2P routing is the main issue and we have hacked around it
in our systems till now. Leon is trying to fix it. Thomas needs it
fixed too for Xe. So what's the issue here?

DMABUF needs to learn how to do interconnect specific behaviors. PCI
is an interconnect, it has lots and lots of crazy rules. An
importer/exporter that chooses to use PCI for their DMA should have a
way to exchange PCI specific information.

So should UALink and all the other zoo of options we have now. It
cannot be completely generic and meet everyones needs.

Can we focus on that instead of arguing if the PCI craziness should
exist or not?

> If yes than that is extremely questionable behavior, I'm not sure if
> that is covered by the PCIe spec.

Spec doesn't say anything about when a device has to translated vs
untranslated. The ATS flags only say translated is allowed to be used.

> ATS is meant to be an optimization which moves the TLB from the root
> complex (TA) into the devices at the cost of TLB invalidation
> complexity. But what you do here is abusing that functionality as
> far as I can see.

ATS is for alot more than that, and there is no abuse here.

Jason
