Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CE4C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D94B10EF44;
	Thu, 17 Sep 2026 15:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="LP96fCZF";
	dkim-atps=neutral
Received: from mail-qv2-f39.google.com (mail-qv2-f39.google.com
 [74.125.230.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5910110EF44
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 15:15:44 +0000 (UTC)
Received: by mail-qv2-f39.google.com with SMTP id
 6a1803df08f44-90cdfe60d5fso11561996d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789658143; x=1790262943; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eNGwdDF4ki7ojFW7+l1TCezZJgsNPf4Ld7gCqIxw2+Y=;
 b=LP96fCZFH2SffSnsbAloMRTth3Zs55OFNeyz/vHWnuHkvKIlGxBBYkyVWR9bZ9ebpt
 zmxy/lHZOu4BgvDqZIngBNqMTmm40uglbAas8O5zaRSU2nQ7edRIHegA72myME5gC5Bo
 l9XswlXlsyS5qKUZx3SoWmX5tOBZz1eOER7Ig8vPYIwUCVm5d20I1+l2SrzFmjs8sgc+
 Hh3ulbqM2l8Co9KKOadgUeqeJjOPCg58cf4Xv6GFAxoWB76iAz6C5y3GaBESzwz4D43D
 FAe4lWN662zVqQMccbmYN5vmdvkjBAZT58Ao6sO2M5Nsp4Zc5TfiaSu8wIr9s2niDdcB
 TRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789658143; x=1790262943;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eNGwdDF4ki7ojFW7+l1TCezZJgsNPf4Ld7gCqIxw2+Y=;
 b=HUmLRFZ61136ziqKZaivSKy9EJGImdwSZvALpjiP+CXdy8HnxzkBI4vNbnpLHr8dS2
 nDw4idUPbXr6BlhN3BdLtAlLJRzRMSMCif4gXWU8ZM6zVwTBwHQBa2jCa9U45XnrHN4A
 nEEPInpPHLBpLJGSW/+oQx9lF0jDBeE28Vj38be+PJQv0tKSCkiYJgKEC1bgHxBpLzsI
 CnfUeENWQ+tzjnlC/pCS/T562qRo1udXKRDMQOTMGlNwDgHt82KuQO4PBp43K+vqZxXA
 glT7/S8d8b8Fhdxtcj5TuhHTiYrRf+6OqQD2v9fbnH8xrTGAl+CcYDPEle9999ZIS0zu
 TmUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrtXw7mUIAhaCZ+k1ZNKky1hFk7ReV3BBaUVQvURkYB5dZGGMGIvTBBP0jx8d3CiOP29aIUW4rmHo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lqh8Sn3WQs/2R+4CONV5AwDzfY2BWTbWl5/8rmjVHsRIvgVPKf
 hWATXJZ9QOeAO4l0pA01juioWGvp9bXzNejnls4yGKYdB+9y1wviUn1pYUs9ofMPbfM=
X-Gm-Gg: AYBFou3pvkkLwAJCW3N/l5RyYxD4uZDgeA5UekagVT4OlhrXjiJWfSITd8l0O9Vp6RF
 fHI3pYwXeM+UmlzFQS+C20YDBeRWFPVjnPyEUe7RD/h7tUkvrkQGN3cgt23OSfgw4/wQ9mRisgi
 1Fntme8G7EtdydXY/WW7PX4esZ3tErK0voCg/OTlDBLdIw4uQp5ndM7C/daLu3uPmxf9L2uT7OX
 NMXIzrPz8IhYWMFQ6rKtv1XiYQ0VNesbdtY/Gj2B2skUIDXAMYBbea+g3FYqlX+EsVZSDXcd6vj
 ySoJNQlF39WQCHvmB0b1SFb5KzP8gc5A8tEb/M6oSjgUKePb/zGXXmkGyISRujtwxC45UangwRi
 Jr2XNp8rJEGyoPNFsgD7T9awnI5iintL4HZGJcf2m1zT6qzfRX/0aoOKSoM12J8p6hobSrRRtsu
 3H4z5NB1xkvtI+ZRxS1XMNpaahZvhMqyjEJvQN2a1HWStiQ5I6cIuw4SdG47B6jm7GpfvE2QOl4
 wBvRXJ5lX0gN3lx+afOOeFYyigNcOhb0Ngor2U2Gh4fL5OWZcs2kV67
X-Received: by 2002:a05:6214:5903:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-9123d7b301dmr139360466d6.27.1789658138557; 
 Thu, 17 Sep 2026 08:15:38 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252cb0b52sm26856d6.28.2026.09.17.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 08:15:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x7Dpp-0000000CyZf-0zOc;
 Thu, 17 Sep 2026 12:15:37 -0300
Date: Thu, 17 Sep 2026 12:15:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917151537.GJ3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260917140253.GG3196566@ziepe.ca>
 <7d8118ee06f29b73988108c0892022b3a2626f1d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d8118ee06f29b73988108c0892022b3a2626f1d.camel@linux.intel.com>
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

On Thu, Sep 17, 2026 at 04:16:57PM +0200, Thomas Hellström wrote:
> On Thu, 2026-09-17 at 11:02 -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2026 at 03:56:12PM +0200, Thomas Hellström wrote:
> > 
> > > That is, a flag to tell the topology check that some transactions
> > > *will* take the host-bridge path due to IOVA being used, and that
> > > the
> > > computations including pci_p2pdma_distance() need to check whether
> > > that
> > > is possible (checking whitelist etc.) and return the corresponding
> > > THRU_HOST_BRIDGE mapping type. Translated transactions taking a
> > > short-
> > > cut using the bus-address would then be hidden from the driver.
> > 
> > I imagined it would work by the driver passing in what modes it
> > supports and Intel GPU would simply pass in ATS only.
> > 
> > Even something like mlx has variation, only some operations can opt
> > into ATS, many others are never-ATS.
> > 
> > Driver should not make statements like " *will* take the host-bridge
> > path" since it has no idea.
> 
> Yes, agreed, but anyway DMA-BUF would then, as part of the
> dynamic_attach negotiation have an interface that takes an ATS only
> flag and use it to determine whether P2P is possible at all, and use
> them at mapping time to set up the correct SG list (IOVA or BUS
> address).

Yeah, where I was going with mapping type was to have the core code
"DMA buf PCI bus mapping type" perform the pci p2p operations,
(especially the calc distance that has been open coded in GPU
drivers!!) and I imagined it would take in information from the
exporter and importer about things like ATS capabilities.

There is worse coming here soon people are working on multi-path PCI
and we even already have such systems. Multi-path PCI means you have
to select the best quality path from a NxM matrix of options and then
inform both sides which path you picked.

> Similarly the dma_map_page() needs to know these flags for p2pdma pages
> so that it never sets up a BUS_ADDRESS to an ATS-enabled device that
> didn't explicitly ask for it?

You don't use dma_map_page() with P2P, use the new interface and then
the details are visible and the mapper can do the right logic.

> And this all (and in addition the previous discussion around pcie
> subsystems calls from within dma-buf, and data-types for mapping
> information) makes me think that abstracting fast dma-buf interconnects
> along with our previous discussions is a good thing. Then interconnect
> details and cross-subsystem dependencies can be hidden in the
> interconnect implementations, suitably placed in the tree.

Right exactly, I guess Christain will be more comfortable if we have a
dma-mapping-type-pci.c that has all of this and only PCI drivers use
that code so it makes logical layering sense with the needs of the
embedded non-PCI drivers..

Jason
