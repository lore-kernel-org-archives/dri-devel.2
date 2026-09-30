Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2190CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F5710F45C;
	Wed, 30 Sep 2026 14:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fe1wpSXw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A16A10F454
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790780245; x=1822316245;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=wUHTytPpnQVSApb4W8DvkwIiRdt0oP5qZjOJ1Tjzzxs=;
 b=fe1wpSXwdscWD2jSLqJCqhS9JbqncDsYLR2O8C4FzgSRYo7Df1dOCILk
 gO4hePSyWPY05EZWF5pAC/J6MzBPvKPPQIPslFcRo9qJLPzv8L7XScwoo
 o/j4j81gFGWSoI360h8EZhF/EBYnNwpYrnnOQiYwxMVfIGoU8sR6GiZTD
 2R/OGM08EkudynDHh3nbe6EKPm53YZSdloCr/rZt70W0X70379YTz6sj6
 f0OJPZH4zSyIffvxSjSB23b9cUaoZFJELzVvpLK2+PQM3ZxzMvkVClt14
 p6rzX9cn5ytPvFYZ3OntLsfZs8t/S82bltbhSlOlh2cH78H5w7vQw8w5n w==;
X-CSE-ConnectionGUID: qVqXOBvmQcKVru3mlSpjPA==
X-CSE-MsgGUID: qdKMYkcFRmC+XJBrdLPZzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="113308969"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="113308969"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 07:57:18 -0700
X-CSE-ConnectionGUID: MoaUWdcRTyCvNbkHxMtwPQ==
X-CSE-MsgGUID: LExUr19JRxOw7wezsue2tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="303650280"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.155])
 ([10.245.245.155])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 07:57:12 -0700
Message-ID: <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
 <logang@deltatee.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>, "Joerg Roedel
 (AMD)" <joro@8bytes.org>, Will Deacon	 <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, 	linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org,  Chaitanya Kulkarni	 <kch@nvidia.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe	 <axboe@kernel.dk>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal	 <ankita@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Sumit Semwal	
 <sumit.semwal@linaro.org>
Date: Wed, 30 Sep 2026 16:57:04 +0200
In-Reply-To: <20260930143237.GI3401365@unreal>
References: <20260928-fix-p2p-acs-v4-0-v8-16-404453b9c435@nvidia.com>
 <607e8903-a979-4d78-bf08-447321c03119@amd.com>
 <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
 <20260930114356.GC3401365@unreal>
 <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
 <20260930143237.GI3401365@unreal>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
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

On Wed, 2026-09-30 at 17:32 +0300, Leon Romanovsky wrote:
> On Wed, Sep 30, 2026 at 01:52:39PM +0200, Christian K=C3=B6nig wrote:
> > On 9/30/26 13:43, Leon Romanovsky wrote:
> > > On Wed, Sep 30, 2026 at 10:34:56AM +0200, Christian K=C3=B6nig wrote:
> > > > On 9/30/26 10:18, Leon Romanovsky wrote:
> > ...
> > > > >=20
> > > > > At a minimum, exporters need to pass `p2pdma_provider`.
> > > >=20
> > > > No, exactly that is a no-go. The neither the framework nor the
> > > > importer should see the p2pdma_provider.
> > > >=20
> > > > Only fully translated addresses where the DMA access should
> > > > happen.
> > > >=20
> > > > >=20
> > > > > If I keep the =E2=80=9Cdma-buf: Let exporters hand out the P2PDMA
> > > > > provider behind a
> > > > > buffer=E2=80=9D patch, I can move the P2P TLP types back into
> > > > > `p2pdma.c` and export
> > > > > only the function that indicates whether ATS is required.
> > > > >=20
> > > > > Is it ok?
> > > >=20
> > > > What you can do is to forward declare enum pci_p2pdma_map_type
> > > > and than pass that 1 to 1 from the exporter to the importer.
> > >=20
> > > Unfortunately, neither suggestion applies to RDMA NICs. They need
> > > to know,
> > > before mapping addresses, whether to create the memory region
> > > with ATS
> > > enabled.
> >=20
> > The design principle here is that the final location and access
> > path of the data isn't determined when the buffer is created.
> >=20
> > The importer first need to attach before it can query such
> > information from the exporter.
>=20
> In attach yes, this is why importer digs in dma_buf ops to get
> p2pdma_provide, however it is before addresses are known.
>=20
> > > The importer needs a way to obtain device information from the
> > > exporter so
> > > that it can configure itself correctly.
> >=20
> > That won't work with DMA-buf then, the exporter is completely
> > opaque to the importer and that is for really good reasons.
> >=20
> > Why in the world does the importer needs to know the information
> > from the exporter before the mapping is created?
> >=20
> > It is the exporter who decides how data is accessed by the importer
> > and not the other way around.
>=20
> There are several reasons:
>=20
> 1. This is how DMA-BUF MRs are built in RDMA. In mlx5, they rely on
> the ODP
> =C2=A0=C2=A0 mechanism, which requires an MKEY to be created first. See c=
ommit
> =C2=A0=C2=A0 90da7dc8206a (=E2=80=9CRDMA/mlx5: Support dma-buf based user=
space memory
> region=E2=80=9D).
> 2. P2P routing is a property of devices, not memory. It is known and
> remains
> =C2=A0=C2=A0 stable.
> 3. See the VFIO TPH ST discussion, where the requirement to obtain
> the
> =C2=A0=C2=A0 exporter=E2=80=99s P2P information in the importer was raise=
d again.
>=20
> Thanks


Returning again to Jason's series. Let's say we'd add just the mapping
type infrastructure, converted users of pcie_p2pdma only to use that
and then we'd have access to per-mapping-type data.=C2=A0This could actuall=
y
be done as a prereq for this series and merged separately. It's a
couple of patches only.

Jason's match() and finish() callbacks could compute the interesting
routes at attach time,  perhaps even condesed to whether IOVA is used
and whether ATS translated packages have a direct route (which is what
mlx5 care about AFAICT). This information is kept outside core dma-buf
and would be specific to the pcie_p2p mapping type (interconnect) only
rather than having functions and callbacks bloating the core dma-buf
structures.

Then exactly where the cross-subsystem match() and finish()
implementations should live I figure remain up for discussion and
guidance by Christoph?

Thanks,
Thomas



