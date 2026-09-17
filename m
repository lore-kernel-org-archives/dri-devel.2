Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFAEC982D1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A65010E49A;
	Thu, 17 Sep 2026 13:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d7ylsmcw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185AF10E49A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789653381; x=1821189381;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=p/8Kga/2mO8x1WfxwkvXVFVTUy+Bdkv/hHhIK3GIj6E=;
 b=d7ylsmcw/3EK28a0jKlpW5rf1Gb2rN6FNb8h/IZh41sdLaqh5J9bW9Sr
 /6C8Eu5eT/sgruG3zuuG54dSklOcoyaT+WWLNiUF/Zg0xxspS6fawANgL
 nSzT4zZfv7ZfZj6+zlidbXqnJw2mEk5u+JKG5XGSCEDxrEBw1mt6+abYX
 donI/TGgxFjkSU7sUFM83xMnAmtb0laKYqXzp/N31n7rwq5EgHJn5kutA
 EuyAA7dScw/5G9d2BfApevVrZ9BRKwDa7juy4tfhRkpSV+jJgqsBPQX1B
 BNQJw2fC/j0Q9QJ8EOi+Ch9DbhUj4744g9utY4eC36nQVPy14R/K9nnbd A==;
X-CSE-ConnectionGUID: onju/WfoTzW3G58PVotavA==
X-CSE-MsgGUID: iu7Td5VrQLiAysRYFRvcBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90094745"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90094745"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:56:20 -0700
X-CSE-ConnectionGUID: 74emaZPGQ3emVLcB420q1g==
X-CSE-MsgGUID: 30OjFD+9QE+gA++0uliwDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270121022"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.63])
 ([10.245.245.63])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:56:14 -0700
Message-ID: <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson	 <alex@shazbot.org>, Ankit Agrawal
 <ankita@nvidia.com>, Jason Gunthorpe	 <jgg@ziepe.ca>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>, "Joerg Roedel
 (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Randy Dunlap	 <rdunlap@infradead.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, iommu@lists.linux.dev, Tushar Dave
 <tdave@nvidia.com>, 	linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Date: Thu, 17 Sep 2026 15:56:12 +0200
In-Reply-To: <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
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

Hi

On Mon, 2026-09-14 at 14:22 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> mlx5_umem_needs_ats() enables ATS for any dma-buf whose caller asked
> for
> Relaxed Ordering, on the assumption that a switch in the path has CR,
> RR
> and DT all set. It also enables it for a buffer already mapped with
> the
> peer's bus addresses, which are not translatable at all.
>=20
> P2PDMA has read the ACS controls, so ask it through
> dma_buf_p2pdma_map_type(): enable ATS only where the path is not
> routed
> directly as it stands, but would be for a Translated Request whose
> Completions carry Relaxed Ordering. Exporters that name no provider
> keep
> the old assumption, since their ACS settings remain hidden.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> =C2=A0drivers/infiniband/hw/mlx5/mlx5_ib.h | 36 ++-----------------------=
-
> ------
> =C2=A0drivers/infiniband/hw/mlx5/mr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40
> ++++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 42 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index e9ddf2e97a76..ab32742b2180 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1646,40 +1646,8 @@ static inline bool rt_supported(int ts_cap)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ts_cap =3D=3D
> MLX5_TIMESTAMP_FORMAT_CAP_FREE_RUNNING_AND_REAL_TIME;
> =C2=A0}
> =C2=A0
> -/*
> - * PCI Peer to Peer is a trainwreck. If no switch is present then
> things
> - * sometimes work, depending on the pci_distance_p2p logic for
> excluding broken
> - * root complexes. However if a switch is present in the path, then
> things get
> - * really ugly depending on how the switch is setup. This table
> assumes that the
> - * root complex is strict and is validating that all req/reps are
> matches
> - * perfectly - so any scenario where it sees only half the
> transaction is a
> - * failure.
> - *
> - * CR/RR/DT=C2=A0 ATS RO P2P
> - * 00X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0 X=C2=A0 OK
> - * 010=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0 X=C2=A0 fails (=
request is routed to root but root never
> sees comp)
> - * 011=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 X=C2=A0 fails (=
request is routed to root but root never
> sees comp)
> - * 011=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0 X=C2=A0 OK
> - * 10X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0 1=C2=A0 OK
> - * 101=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0 0=C2=A0 fails (=
completion is routed to root but root
> didn't see req)
> - * 110=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X=C2=A0=C2=A0 0=C2=A0 SLOW
> - * 111=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 0=C2=A0 SLOW
> - * 111=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0 0=C2=A0 fails (=
completion is routed to root but root
> didn't see req)
> - * 111=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0 1=C2=A0 OK
> - *
> - * Unfortunately we cannot reliably know if a switch is present or
> what the
> - * CR/RR/DT ACS settings are, as in a VM that is all hidden. Assume
> that
> - * CR/RR/DT is 111 if the ATS cap is enabled and follow the last
> three rows.
> - *
> - * For now assume if the umem is a dma_buf then it is P2P.
> - */
> -static inline bool mlx5_umem_needs_ats(struct mlx5_ib_dev *dev,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ib_umem *umem, int
> access_flags)
> -{
> -	if (!MLX5_CAP_GEN(dev->mdev, ats) || !umem->is_dmabuf)
> -		return false;
> -	return access_flags & IB_ACCESS_RELAXED_ORDERING;
> -}
> +bool mlx5_umem_needs_ats(struct mlx5_ib_dev *dev, struct ib_umem
> *umem,
> +			 int access_flags);
> =C2=A0
> =C2=A0int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
> =C2=A0		=C2=A0 unsigned int index, const union ib_gid *gid,
> diff --git a/drivers/infiniband/hw/mlx5/mr.c
> b/drivers/infiniband/hw/mlx5/mr.c
> index 00e13028762a..286f372e5b0c 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -38,6 +38,7 @@
> =C2=A0#include <linux/export.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/dma-buf.h>
> +#include <linux/dma-buf-mapping.h>
> =C2=A0#include <linux/dma-resv.h>
> =C2=A0#include <rdma/frmr_pools.h>
> =C2=A0#include <rdma/ib_umem_odp.h>
> @@ -47,6 +48,45 @@
> =C2=A0#include "data_direct.h"
> =C2=A0#include "dmah.h"
> =C2=A0
> +MODULE_IMPORT_NS("DMA_BUF");
> +
> +bool mlx5_umem_needs_ats(struct mlx5_ib_dev *dev, struct ib_umem
> *umem,
> +			 int access_flags)
> +{
> +	struct dma_buf_attachment *attach;
> +
> +	if (!MLX5_CAP_GEN(dev->mdev, ats) || !umem->is_dmabuf)
> +		return false;
> +
> +	/*
> +	 * The Completer decides whether its Completions carry
> Relaxed
> +	 * Ordering, and only a Request that asked for it can expect
> them to.
> +	 */
> +	if (!(access_flags & IB_ACCESS_RELAXED_ORDERING))
> +		return false;
> +
> +	attach =3D to_ib_umem_dmabuf(umem)->attach;
> +	switch (dma_buf_p2pdma_map_type(attach, 0)) {
> +	case PCI_P2PDMA_MAP_NONE:
> +		/* Nothing is known about the route, so fall back to
> the bet. */
> +		return true;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		/*
> +		 * The path is routed directly already and is
> programmed with
> +		 * the peer's bus addresses. Those are not
> translatable, so
> +		 * ATS would be wrong as well as pointless.
> +		 */
> +		return false;
> +	default:
> +		break;
> +	}
> +
> +	return dma_buf_p2pdma_map_type(attach,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_P2PDMA_TLP_TRANSLATED |
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> PCI_P2PDMA_TLP_RELAXED_CPL) =3D=3D
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_P2PDMA_MAP_BUS_ADDR;
> +}
> +

It looks like this works well when the device can choose whether to
enable ATS per transaction.=20

However, at least for the Intel GPUs, ATS enablement is based on the
PCIe-side enable bit.

This means that if p2pdma tells the dma-mapping layer to give an Xe
device a bus address rather than an IOVA, things break, while
pci_p2pdma_distance says everything is OK.

It looks like the infrastructure and solution added in this series is
targeted at fixing this on the device side by conditionally enabling
ATS. However I think we need to look also at having the computed
routing assume untranslated transactions using IOVA rather than bus
address.

That is, a flag to tell the topology check that some transactions
*will* take the host-bridge path due to IOVA being used, and that the
computations including pci_p2pdma_distance() need to check whether that
is possible (checking whitelist etc.) and return the corresponding
THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
cut using the bus-address would then be hidden from the driver.

Whether that is best done as a parameter to these functions or perhaps
as a flag in the PCI device, I'm not sure.

Thanks,
Thomas




> =C2=A0static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> =C2=A0{
> =C2=A0	if (MLX5_CAP_GEN(dev->mdev,
> umr_extended_translation_offset))
