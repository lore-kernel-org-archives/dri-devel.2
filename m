Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B79CC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5A710E84E;
	Mon, 28 Sep 2026 12:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KJiDs8xD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D142510E84E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790599481; x=1822135481;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZXNlI+RAX+nTm0DvvNRSw2dlsVY/sr/atGTezTTinoY=;
 b=KJiDs8xDJPEjb9oGMBn9jCsVPTYFalvEsCjsybq6zcDSYhjBJf4AQK9E
 b2HQjicrqIrSd/c7G6ZwXY9DBboJe7zjT+7tP1273EfMfNT+GOs4AZzRd
 5kJimaiaHFcAxsBjpoXQ9MMlCDtHFYslLGaLGoFgPV4XXrEBXZrw0pHXH
 rzJilWIESiEbLKDum4D1cpxdjQsDErsu+ENbEM78zEW7T/b3jH4oUcvFk
 KdVLKAevI0GM2EU2lAEYeXhJWO1E7JPDgZWl1khiWGIGU3wMlYW99lS1V
 V8kKB3T4jTX+F+lOi5r0vTKCkrp1VOhaJ/Q1s5H/B9oph59uc8auhmX5T A==;
X-CSE-ConnectionGUID: oVmELy2vTPaCrbmwp5XF2w==
X-CSE-MsgGUID: 2QYnSHsbSDu9MMrLaaUJVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101465251"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="101465251"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 05:44:40 -0700
X-CSE-ConnectionGUID: fFRMilzCTkWSkFZj16NO1w==
X-CSE-MsgGUID: h6+JZbPHRayLtVxz/h87ig==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.73])
 ([10.245.244.73])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 05:44:35 -0700
Message-ID: <417b4032fd106c6730558759fd02e67e2fdc1c82.camel@linux.intel.com>
Subject: Re: [PATCH v8 20/23] PCI/P2PDMA: Let a client declare that it
 selects ATS per mapping
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,  Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, iommu@lists.linux.dev, Tushar Dave
 <tdave@nvidia.com>, 	linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,  Chaitanya Kulkarni	
 <kch@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens
 Axboe	 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, Ankit Agrawal
 <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan	
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Sumit
 Semwal	 <sumit.semwal@linaro.org>
Date: Mon, 28 Sep 2026 14:44:32 +0200
In-Reply-To: <20260928-fix-p2p-acs-v4-0-v8-20-404453b9c435@nvidia.com>
References: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
 <20260928-fix-p2p-acs-v4-0-v8-20-404453b9c435@nvidia.com>
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

On Mon, 2026-09-28 at 14:19 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The PCIe ATS Enable bit covers the whole device, so P2PDMA cannot
> tell
> from it whether a client will translate a given address. Most devices
> translate any address once ATS is enabled, but some choose ATS per
> DMA
> mapping and can still use bus addresses for the rest.
>=20
> Add pcim_p2pdma_set_ats_per_mapping() so the driver of such a device
> can
> declare that before P2PDMA starts treating clients with ATS enabled
> as
> translating everything. Keep it in the device's P2PDMA state, which
> already ends with the driver binding.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/pci/p2pdma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 +++++=
++++++++++++++++++++++
> =C2=A0include/linux/pci-p2pdma.h |=C2=A0 4 ++++
> =C2=A02 files changed, 31 insertions(+)
>=20
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 1f4bf0125a5c..ae676509f9f3 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -26,6 +26,7 @@
> =C2=A0struct pci_p2pdma {
> =C2=A0	struct gen_pool *pool;
> =C2=A0	bool p2pmem_published;
> +	bool ats_per_mapping;
> =C2=A0	struct xarray map_types;
> =C2=A0	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
> =C2=A0};
> @@ -1568,6 +1569,32 @@ void pci_p2pmem_publish(struct pci_dev *pdev,
> bool publish)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
> =C2=A0
> +/**
> + * pcim_p2pdma_set_ats_per_mapping - Declare per-mapping ATS for a
> client
> + * @pdev: PCI device that initiates peer-to-peer DMA
> + *
> + * Declare that @pdev issues Translated Requests only for the DMA
> mappings its
> + * driver sets up to use ATS, rather than for any address once ATS
> is enabled.
> + * P2PDMA then takes the Address Type of this client's Requests from
> the TLP
> + * flags its callers pass.
> + */
> +void pcim_p2pdma_set_ats_per_mapping(struct pci_dev *pdev)
> +{
> +	struct pci_p2pdma *p2p;
> +
> +	p2p =3D rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (!p2p)
> +		/*
> +		 * ats_per_mapping is a performance optimization,
> +		 * if pcim_p2pdma_init() didn't set pdev->p2pdma
> pointer
> +		 * for some reason, let's simply use ATS global
> settings.
> +		 */
> +		return;
> +
> +	p2p->ats_per_mapping =3D true;
> +}
> +EXPORT_SYMBOL_GPL(pcim_p2pdma_set_ats_per_mapping);
> +
> =C2=A0/**
> =C2=A0 * pci_p2pdma_map_type_tlp - Determine the mapping type for P2PDMA
> transfers
> =C2=A0 * @provider: P2PDMA provider structure
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 36045b1b730c..543a09426a11 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -109,6 +109,7 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct
> pci_dev *pdev,
> =C2=A0					 unsigned int *nents, u32
> length);
> =C2=A0void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist
> *sgl);
> =C2=A0void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +void pcim_p2pdma_set_ats_per_mapping(struct pci_dev *pdev);
> =C2=A0int pci_p2pdma_enable_store(const char *page, struct pci_dev
> **p2p_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 bool *use_p2pdma);
> =C2=A0ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -166,6 +167,9 @@ static inline void pci_p2pmem_free_sgl(struct
> pci_dev *pdev,
> =C2=A0static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool
> publish)
> =C2=A0{
> =C2=A0}
> +static inline void pcim_p2pdma_set_ats_per_mapping(struct pci_dev
> *pdev)
> +{
> +}
> =C2=A0static inline int pci_p2pdma_enable_store(const char *page,
> =C2=A0		struct pci_dev **p2p_dev, bool *use_p2pdma)
> =C2=A0{
