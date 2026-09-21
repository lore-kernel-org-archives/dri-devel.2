Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D82DC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900DF10E03E;
	Mon, 21 Sep 2026 06:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HDh43lt6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4498E10E03E
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789973863; x=1821509863;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=P59r4FNY1nRj1bsYjyaGQcIz1iJ9xQL0uv3I+7eHlhA=;
 b=HDh43lt6bWibuLDvieX+APrNHKE56wuXbADR1MU2rPywCvMa3NyZsBaZ
 f+SakUzjdzvWG4PksN7M8TQ7e68+/JHD0tnypoF8YXbQss4Q1s1+q6h0p
 0gHHNT5KpMiHsS7ja2nN4SmCYaJP2U0WvF7XB3rs4eQsfGxaVnqzlfR6T
 qNnajSaheS3DELCMLVqG0yrjVG0d+Cpvs3mIXwUzYtaFXESELKwgI5apC
 BrdL5X6EzIjwRiPofW2Lks/3KyLX9o2ZIZCd5XTKuF/ocdU64UZCyHAZk
 GTZLOLkH8M0Sq+HSDlUK2ToXMaLwMeVh+I04WyeQv76p3eOp+XUzKJAgq A==;
X-CSE-ConnectionGUID: PSat4RVdSkeXTSXg9Gnlvw==
X-CSE-MsgGUID: uwy3qYm9R1SJIHUbcayv5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90484968"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="90484968"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:57:42 -0700
X-CSE-ConnectionGUID: pgydRxgNSECLINbB4qVCSQ==
X-CSE-MsgGUID: smtR3yD1Rx+3kxBejKlTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3829648"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.155])
 ([10.245.244.155])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:57:37 -0700
Message-ID: <e80dc629b90d5284ace6f84643616f352f25cb57.camel@linux.intel.com>
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson	 <alex@shazbot.org>, Ankit Agrawal
 <ankita@nvidia.com>, Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Joerg Roedel (AMD)"	 <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy	 <robin.murphy@arm.com>, Randy
 Dunlap <rdunlap@infradead.org>, Sumit Semwal	 <sumit.semwal@linaro.org>,
 linux-pci@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,  Tushar Dave
 <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Date: Mon, 21 Sep 2026 08:57:31 +0200
In-Reply-To: <9656f2f9-2e39-4007-b065-3b763b53c6de@amd.com>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
 <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>
 <20260918170524.GH11599@ziepe.ca>
 <9656f2f9-2e39-4007-b065-3b763b53c6de@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Mon, 2026-09-21 at 08:43 +0200, Christian K=C3=B6nig wrote:
> On 9/18/26 19:05, Jason Gunthorpe wrote:
> > On Fri, Sep 18, 2026 at 03:42:28PM +0200, Thomas Hellstr=C3=B6m wrote:
> > >=20
> > > 1) Xe attachment check if pci_p2pdma_distance() returns OK for
> > > the
> > > path. Then Xe always sets up dma-addresses using
> > > dma_map_resource().=20
> >=20
> > Open coding pci_p2pdma_distance() in drivers is a hack. Using
> > dma_map_resource() like this was never "allowed".
> >=20
> > We've fixed things so these hacks are not needed, the drivers need
> > to
> > move over to things like dma_buf_phys_vec_to_sgt() and the hmm
> > helpers
> > to use the DMA API correctly.
>=20
> That is a completely broken approach as well since it limits the
> exported resources to addresses the CPU can reach.

And this would be OK for pcie_p2p, but not for other fast
interconnects, right? Or is this problematic also for pcie_p2p?

Thanks,
Thomas
