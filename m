Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2472C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1378A10E023;
	Thu,  2 Jul 2026 18:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="uL02NEkR";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBBF10E023
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:16:04 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662GoDSO3664291
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 11:16:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=7n6uaqb1WzaAlWb9XQ
 OtXCQaeFqSCgmHchwojpRfK4c=; b=uL02NEkRqXyolFsKbYFBqmT3tp37VGXV+d
 bBqI9naNP6F3hsSbMqdpZ/ozQcwozsrUZPN0K4oyZ4+X3ojhGVYkThXRcdfoKrEf
 fBdkFINeMipIKffiAFFIRYJXT/XHl0q6LMHqeQJ6TDi2QxVbgAS3pGIyEStCiUrT
 CvQ4yavXzW6e09CR7AbCKONNdV71vxdQOQkeaJT0F0nJAjKCJx0DWC8hRNOqykFh
 xAXdlvNOADy+sdKVMya3JOHKy0tIA1BwjC5XSlpFQRaiFidbbq2a065969iVhcrt
 yJn/bhX/+IQU1yyKaCXt+xymSMZeaybiRnl00yU6O1xGNy2+3NBg==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f55rea91d-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 11:16:03 -0700 (PDT)
Received: from twshared1653.04.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 2 Jul 2026 18:16:00 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 0589440EEE780; Thu,  2 Jul 2026 11:10:25 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Thu, 2 Jul 2026 11:10:13 -0700
Message-ID: <20260702181025.2694961-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfX5oRF+a1AK+le
 x4o1ViLT//6zlHYK9UOJYCd3GoVcSu8MJZP3RFYb0eLhuSZ0V1NPc5rpctDx7ArZrzLJUNcxv7Z
 gQp5AYaIv/mEKJZrCaZMm2+HmkHFvqz+IVvXPIfPrEx3boa+6MZRC83pwBTA8+wJWO5MekniCS0
 4wjOJpua3nT3cJaX0Kyzxunp8nW7MHGE0rZqFdFnzueoR48m9DSKmKbkoWFUyIdvGIDTKknB5y5
 FUu/xSp3uLLxqy4f9S9bLEw14iDvnu5OTJN3ydyjiQk81+Hkv8KPZ9SrDsLKC4XZHV/Vuak6xwG
 /uL6HoSBYfVCg5qjPry61Tte5/+T18r/MPCEMX1F1tYCPPsfVDCVkRO5dQ39lM5B9U29v9NvCel
 RGkEmOCVhvXkKyWMsOs4IqYwxfbE5SqPuWG/L2IhJjxjZfW1vItePSjVDSzlgACxdr+usm1OXGR
 GJ1ICW+sMR26DmFkaoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfX3CI0UBbVtY7i
 828lRVYb6r1nnL7e0mhRNpld3AIkfLVVLN30yfd2AH7VPem6EYiVP2iWco8NNAMf7u9EX+8o0kX
 Bf/MRtBHyvr5T12DtRtyrwDaXVfJo4M=
X-Authority-Analysis: v=2.4 cv=H6rrBeYi c=1 sm=1 tr=0 ts=6a46aae3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=VFUPkbdMgoccpq6KJQIA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: tTpN8nhvq6gJxj494y1mvYTE9O5p0Nfu
X-Proofpoint-ORIG-GUID: tTpN8nhvq6gJxj494y1mvYTE9O5p0Nfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
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
entity that can configure a meaningful value for a given dma-buf. The
kernel-visible participants are still in-tree: vfio-pci exports the
dma-buf and mlx5 imports it.

On the effect: the endpoint's PCIe ingress block uses the ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_pci_tph callback itself is optional, but workloads that
depend on the endpoint's in-flight operation need it because fallback
does not produce the same result.

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
configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
P2P workload only produces results consistent with the endpoint's
ST-selected in-flight operation. For example, with userspace
configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
ST=3DF0h PH=3D2 HV=3D1":
(TLP Captures)
08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
E0200000 -> AddrH=3D000020E0h
00080006 -> AddrL=3D06000800h
90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-

The dma-buf get_pci_tph interface has also been exercised by a second,
independent importer: a different vendor's NIC whose driver is not yet
upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyzer
confirmed the ST it placed on outbound P2P TLPs matches the value
configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result as
with mlx5. Two unrelated importer drivers exercising the callback
end-to-end shows the interface is not tied to a single consumer. That
importer change is out-of-tree and not part of this series. For that
second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D0,
an analyzer capture shows:
(TLP Captures)
08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
00170000 -> AddrH=3D00001700h
00200006 -> AddrL=3D06002000h
10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-

Depends on (submitted separately):
  net/mlx5: free mlx5_st_idx_data on final dealloc
    https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@=
meta.com

Changes since v10:
  Patch 2 (dma-buf): Per Christian K=C3=B6nig, document that the ST/PH
  returned by dma_buf_get_pci_tph() is only valid until the exporter
  invalidates the current mapping and must be re-queried afterwards;
  note added to the wrapper kernel-doc and referenced from the callback
  kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tph(=
)
  to the central dma-buf locking convention.

  Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
  comment to note that @revoked is additionally protected by memory_lock,
  and describe the READ_ONCE() rationale in the commit log. No behavior
  change.

Previous link:
v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhipingz@=
meta.com/
v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipingz@m=
eta.com/
v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipingz@m=
eta.com/
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

 drivers/dma-buf/dma-buf.c                     |  32 +++++
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mr.c               | 116 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
 drivers/pci/tph.c                             |  45 +++++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 102 ++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  25 ++++
 include/linux/mlx5/driver.h                   |  15 +++
 include/linux/pci-tph.h                       |   8 ++
 include/uapi/linux/vfio.h                     |  43 +++++++
 12 files changed, 435 insertions(+), 16 deletions(-)


--
2.53.0-Meta
