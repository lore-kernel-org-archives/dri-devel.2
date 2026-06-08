Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC28CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE9110F92F;
	Mon,  8 Jun 2026 19:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="V5+gsl5o";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BB910F92F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:38:26 +0000 (UTC)
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586qL6T2367444
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 12:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=GpbMo9gtfKL47mk0VI
 Sk+78sZkwE32Yl7fOmdsvzQGI=; b=V5+gsl5oXlc7hyX8cvbHY1I319o33tLee4
 meh133iSW/CmnQkxGtoJ0ht5e/mlKTrc/x02y5eMK6KNdvEU6sPnVzozhRMC0NEB
 O4kjH/6bgaN1rimyiYPZzjuX3ppy2SkpK3eWIe2xkBg24j+LeYBzuWWqeHi+0kKW
 oXvxqlWT9VIQ3JOokqd1g7aUbT3cvFFCN6tpHOhG+AjnRrXv9ORfcJExyLW3l/LZ
 JLcw+mcgskkb/XdWvioc9akOUJ6Vm38dR9uzIxgTRlR1xlhB9sC8QWbx6nS915Gh
 iq1lhXis9p7faAIfvKqPUgeglhsTNHyUoqeelY3HpJWA/8fmPOgg==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en85k71f0-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:38:25 -0700 (PDT)
Received: from twshared25638.33.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 19:38:10 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id EFE5E3CC1012A; Mon,  8 Jun 2026 11:56:46 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v6 0/5] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Mon, 8 Jun 2026 11:56:37 -0700
Message-ID: <20260608185646.4085127-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B5nGN9K5xUbAYDHhbU_FLLRdqIFQn3-t
X-Proofpoint-ORIG-GUID: B5nGN9K5xUbAYDHhbU_FLLRdqIFQn3-t
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=6a271a31 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=hqgnMBnoZRKjftXIFiYA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3OCBTYWx0ZWRfXyu2n+mhGnncT
 bBsroDCblMq5tPQS0FBzaQZvzXLk+RKbH+TbS+jXKrxZpod3lurJNm8znGpaF4EBuRIxrhZFvxK
 IBi7ziAXSB/H+31IQvkaEcVz3jPuZqeDU5lRp7F9p9bWFQ30MITQTdB/Mg9DzYAM2sBmLX7jYV7
 NKOg+uEnWni26aWW1zsiqmdAF7lPPit71Um67BzRMua7KfVgMeq46v+ln53zJeZSQcYAQI6XGx9
 iT1XcYxbIARZRcAaufQed+wRsnCodCsY1Xr2qLuMmkHBbe4/oyVjSmkMZrHImz8L/JAI9uaA1TU
 9uPGcnftVk/auaSpQQTMbe1QhRWtVGFGOIul+M+cLrfUj2xROZoB4YkWgC2swZ/mrsXo4L5hUHb
 QUlTcLOLZLsd3BBdA5do1WBYP4ner6UI/RxCe2W/nodIWPNK4MNppezGy94NAX9y4WMvqbocYZe
 Xzgi0QtqjJ6jF/kVNVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
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

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the
exporter's steering tag when performing peer-to-peer DMA into a
VFIO-owned device.

There is no separate in-tree vendor kernel driver for the target device:
vfio-pci is the in-tree driver and the targeted device is managed
from userspace via VFIO passthrough. That is why the ST has to flow
through a uAPI: userspace owns the device and its ST table, so it is the
entity that can publish a meaningful value for a given dma-buf. The
kernel-visible participants are still in-tree: vfio-pci exports the
dma-buf and mlx5 imports it.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_tph callback itself is optional for workloads that depend
on the endpoint's in-flight operation that fallback does not produce
the same result.

The dma-buf hook is intentionally generic and discoverable rather than
a private side channel. The exporter owns the completing address
space for the dma-buf and decides whether it can provide a meaningful
ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
and importers merely request the namespace they support and place the
returned value on generated TLPs. Exporters that cannot derive a
meaningful tuple simply return -EOPNOTSUPP.

Patch 1 is a pre-existing fix split out from the series:
mlx5_st_dealloc_index() removed the xarray entry but never freed the
backing struct, so repeated alloc/dealloc cycles leaked memory.
Patch 2 exposes the enabled TPH requester type through a small PCI/TPH
helper, plus a pcie_tph_supported() helper so consumers don't reach
into pci_dev internals (and so callers in CONFIG_PCIE_TPH=3Dn builds
get a clean -EOPNOTSUPP path).
Patch 3 adds the optional dma_buf_ops::get_tph callback to the dma-buf
framework so importers can fetch TPH metadata from an exporter.
Patch 4 implements get_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 5 wires up the mlx5 RDMA driver as a consumer.

Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
Functional validation on the target topology: PCIe analyzer captures
on the P2P TLPs confirm the ST emitted by mlx5 matches the value
published through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
P2P workload only produces results consistent with the endpoint's
ST-selected in-flight operation. For example, with userspace
publishing 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
ST=3DF0h PH=3D2 HV=3D1":
(TLP Captures)
08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8               =
                                                                         =
              =20
F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h                                 =
                                                                         =
        =20
E0200000 -> AddrH=3D000020E0h                                            =
                                                                         =
      =20
00080006 -> AddrL=3D06000800h                                            =
                                                                         =
      =20
90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV- =20

Previous link:
v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (5):
  net/mlx5: free mlx5_st_idx_data on final dealloc
  PCI/TPH: expose the enabled TPH requester type and capability helpers
  dma-buf: add optional get_tph() callback
  vfio/pci: implement get_tph and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/core/frmr_pools.c          |  20 ++-
 drivers/infiniband/hw/mlx5/mr.c               | 124 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  50 +++++--
 drivers/pci/tph.c                             |  25 ++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  92 ++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  31 +++++
 include/linux/mlx5/driver.h                   |  12 ++
 include/linux/pci-tph.h                       |   7 +
 include/rdma/frmr_pools.h                     |   5 +-
 include/uapi/linux/vfio.h                     |  45 +++++++
 12 files changed, 406 insertions(+), 20 deletions(-)

--=20
2.53.0-Meta
