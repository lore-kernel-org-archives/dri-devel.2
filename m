Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ACDCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC22E10E21C;
	Mon, 15 Jun 2026 07:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="M/2nyfue";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D935A10E21C
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:12:30 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6I9Pg1209664
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:12:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=Ayneepun5JdCwbIVUT
 ZacIqVWJayBLsojD7m7T4gaX0=; b=M/2nyfueyeMQs1gyBCaoAbGAit3AYiLovt
 YHYCU0Be7sLyGyo7KhKPQcn0mI0wbex0YsDHGv6OWYRee4SL7zKDU5WhQcEUitxS
 YW71OFHqZlc/t5JV0Ytrq15MOWCdTnrUnye8wvfQcXRT8HIYbep6atHtmgbfxElh
 Cse0rBtBo/tYaFacUB6x7H/yC0VjiUqZWmWOvqoZgvKh+fe8qye7h+g8mPcXUtyR
 dNYdjrcyrqKs7z+5EuvVWdUY1oHNIEaRMlnCBdmXPioHatXvJQwIPe3/pgqp8IlR
 fzMPDsJBH6Xjx5JGTDGosMAyjD7MJbtkpaB8LYaluwb1k5q+tW3A==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4esrsh3md2-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:12:29 -0700 (PDT)
Received: from twshared59693.31.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 07:12:25 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id CC56C3EE344B9; Sun, 14 Jun 2026 23:59:12 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v8 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Sun, 14 Jun 2026 23:58:57 -0700
Message-ID: <20260615065912.2177918-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AMQbODc0McO9Yz6fYYiSVfnTqY315jWX
X-Authority-Analysis: v=2.4 cv=DOO/JSNb c=1 sm=1 tr=0 ts=6a2fa5dd cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8
 a=IrN9ioZU3SVRGu70jE0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX1wDIJczunYOt
 zVq4LaG4XY7Sow5nyqXiHQJwM16P9dyrVGupj0B/gXPc5SzopEnVQGG9jTqpGCAm2rx+2dfVgl0
 rJbMyKZQeAugVEbJhUl6L0c4EttO3Js=
X-Proofpoint-GUID: AMQbODc0McO9Yz6fYYiSVfnTqY315jWX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX/yPoCwXnZ/sM
 aJAbSXfM0rtSJAnioq5zXGFVT/XdSj0+W/geAGywAXzhe1bQZjJI56WT3EJlbAty7IrwE53v2K3
 W+P3EJHf5TrGjPSGwbfHYg86VwNibBkRANNX1Ax1Ca04w9lLqpaB6SJhEQcPlSss7XRH7Q3n984
 dVHzidtDrVTUjzCA8SK/wKfIve4hzWH+pWsbBtnUOcpUf0UKKs0BRmgmWebjjypPKnQb3LgYCKx
 ottNYY8mVxUkRXcmEEaHQMBsDLCxzt4hu87rx5rYaxUTQ+pazVzS2wlVz4NUhBFkwZVj/fgZSCx
 dgkrTHlAiRur8q0Ue7FTtGAL6nu0W126K7UFJynRM8nzQTXje6jgAGdf4ogVF8N/3oeM5BCv2MG
 EEEdiD+CXvyDz6WzSIfmKMqKiGId8p0yZj3jfMdc4N9Amvf4oIiXcRijEN2wF011jW2djqPrjl2
 hZ5tbqfscwTpckbsCBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
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

On the effect: the endpoint's PCIe ingress block uses the ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_pci_tph callback itself is optional for workloads that depend
on the endpoint's in-flight operation that fallback does not produce
the same result.

The dma-buf hook is intentionally generic and discoverable rather than
a private side channel. The exporter owns the completing address
space for the dma-buf and decides whether it can provide a meaningful
ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
and importers merely request the namespace they support and place the
returned value on generated TLPs. Exporters that cannot derive a
meaningful tuple simply return -EOPNOTSUPP.

Patch 1 adds small PCI/TPH type helpers so drivers can query the enabled
TPH requester mode and the device's TPH Completer Supported field
without reaching into pci_dev internals (and so callers in
CONFIG_PCIE_TPH=3Dn builds get a clean fallback).
Patch 2 adds the optional dma_buf_ops::get_pci_tph callback plus the
dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
metadata from an exporter under dmabuf->resv.
Patch 3 implements get_pci_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 4 wires up the mlx5 RDMA driver as a consumer.

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
08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
E0200000 -> AddrH=3D000020E0h
00080006 -> AddrL=3D06000800h
90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-

Depends on (submitted separately):
  net/mlx5: free mlx5_st_idx_data on final dealloc
    https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@=
meta.com
  RDMA/mlx5: Fix TPH extraction in FRMR pool key (Michael Guralnik)
    https://lore.kernel.org/linux-rdma/20260610000145.820592-3-michaelgur=
@nvidia.com/

Previous link:
v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipingz@m=
eta.com/
v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz@m=
eta.com/
v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (4):
  PCI/TPH: Add requester/completer type helpers
  dma-buf: add optional get_pci_tph() callback
  vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/dma-buf/dma-buf.c                     |  25 ++++
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mr.c               | 105 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
 drivers/pci/tph.c                             |  45 ++++++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  97 +++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  16 +++
 include/linux/mlx5/driver.h                   |  12 ++
 include/linux/pci-tph.h                       |   8 ++
 include/uapi/linux/vfio.h                     |  37 ++++++
 12 files changed, 399 insertions(+), 11 deletions(-)

--
2.53.0-Meta

