Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE4CC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F5110E22F;
	Wed, 15 Jul 2026 20:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="qyL6fItM";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DD710E22F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:46:04 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FKRu8Z1078894
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=GTrFoStJ3Cf6mNZxn/
 jhxVbDFzL6OhcXAEVIvrG+cDs=; b=qyL6fItM4j58dHl2Ham4v8gFQPMkrtgqs9
 2fGh9qb0QtUKgQIDXLDDyoyEvishkWSFJVMniQ/0RlcOsL4YnkjDoAoD7hnELLDa
 EW7NxsaIIW+RvISzr+kHJ+PT2k5IrndCmgaJAhkEL/sRWmYXTtqRK+1ByJf44qQm
 PlyDKYurGoR4/MgLEP2c+tN++ZcL5vpz12stWz21nO38Oowja7pCgaufS/913ZhT
 rXnSPPqekupYGUGb6JbYPJ0Xl0SK2b6Lp82KpvHeyWmsk2aGBhs9pfGSK4lhH4S7
 1OngO4o6jSGhPDhCeGx/NxeGbCA2E3X4bzg9CC4WLnBWIPcEwoHA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fdvddqmg3-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:03 -0700 (PDT)
Received: from twshared19691.04.snb1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 15 Jul 2026 20:46:01 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id DE091423AA00F; Wed, 15 Jul 2026 13:40:08 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Wed, 15 Jul 2026 13:39:55 -0700
Message-ID: <20260715204008.3911275-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Mg41Y-Zdm4-z-YpJKICzBkUyA5sW8fuQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX9A1rV6zAdOuo
 vVKl39H5rds00nVHbRuGczhLoKeGyNJigQOtgmTWzCEk24cXPoeZqhft75Ykv2OgHSvhR+/2WL+
 zmLrLYl0YS1Ooy2btvooJ41w28fb1Ng=
X-Authority-Analysis: v=2.4 cv=TeGmcxQh c=1 sm=1 tr=0 ts=6a57f18b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=99gIKpWpPaVvSUl-0g0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Mg41Y-Zdm4-z-YpJKICzBkUyA5sW8fuQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX0+HXCxQzZnZD
 r7mfco1zg0z5EwPLXXn1HkwpK7tZBKKfz3QbaLzuEuVlb27JpazX2xycLm642GO5wbiKifQF15y
 L4YQd3E91ORGwyRSMA9AjHovCK6eQHuYaAwuMuWy9QLSlxYOvaE+lM736fERTFRYCvCONxmaW1G
 DvcKPaFyarCwHWAbh03caMMIaey5NcMzsUhnfnDz0wchZRoW69gqugQqHR+DHccClu6zFVx/wVS
 NWw92Iig58jiM8B+NfhgrcA0Isom3hPi86oYRXGMK/20ZiJKxlokEykvUV4ItWjanrFb54/f3pz
 6spaoBcKhwM+QiHbLNKvSYI6iIeAJApSTdFeFKqH3Te40dHI0cTWRJwQYkiXZ/qWoMytstp11oP
 aix2adyrpJ3aSTiC1ML3uQpxy1G7NQnM28KFnP7LxCjIG3vl9eeP35cThk0NMQ15EjaJgs3FwDj
 OWVyrv7X5tO4r/fR5cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
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
CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_type=
()
reuses the reserved-encoding fold introduced by the separately-submitted
folding patch rather than duplicating the completer decode.
Patch 2 adds the optional dma_buf_ops::get_pci_tph callback plus the
dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
metadata from an exporter under dmabuf->resv.
Patch 3 implements get_pci_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 4 wires up the mlx5 RDMA driver as a consumer. It also enforces the
dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid for th=
e
mapping it was queried against, and the mkey's TPH fields cannot be
reprogrammed in place. mlx5 therefore records the registration-time tuple
and re-queries after each dma-buf mapping is established under dmabuf->re=
sv;
unchanged tuples continue with the existing mkey, while changed or missin=
g
tuples fail the remap rather than continue with a stale hint. For vfio-pc=
i
BAR dma-bufs this is expected to be a no-op because invalidation is
revoke/quiesce, not movement to a new backing placement, and the
userspace-provided tuple is not changed by the revoke/un-revoke path.

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
  PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
    https://lore.kernel.org/linux-pci/20260715202409.3767494-1-zhipingz@m=
eta.com

Changes since v11:
  Patch 1 (PCI/TPH): add pcie_tph_completer_type() and
  pcie_tph_enabled_req_type(); pcie_tph_completer_type() reuses the
  reserved-encoding fold from the separately-submitted folding patch
  rather than duplicating the completer decode.

  Patch 2 (dma-buf): fix the kernel-doc to reference
  &dma_buf_attach_ops.invalidate_mappings instead of the non-existent
  move_notify callback (reported by Sashiko and Alex Williamson).

  Patch 3 (vfio/pci): hold memory_lock while validating dma-buf ownership
  and publishing TPH metadata, so cleanup cannot disassociate the dma-buf
  from the VFIO device under the SET path. Also use WRITE_ONCE() for
  revoked-state writers to pair with the lockless attach-path READ_ONCE()=
.

  Patch 4 (mlx5): enforce the steering-tag lifetime documented in patch 2
  (addresses the lifecycle gap Sashiko and Alex noted on v11). mlx5 now
  stores the registration-time TPH tuple and re-queries the exporter afte=
r
  each dma-buf mapping is established under dmabuf->resv. If the tuple is
  unchanged, the existing mkey continues to be used. If it changed or
  disappeared, mlx5 unmaps the pages and returns -EFAULT because the
  existing mkey cannot be updated in place (no UMR update mask for TPH
  fields, and rebuilding the mkey would change the rkey/lkey). The export=
er
  query runs under dmabuf->resv, but the ST-index allocation is done
  outside it so no GFP_KERNEL allocation is held under dmabuf->resv. For
  vfio-pci BAR dma-bufs this validation is expected to be a no-op because
  the tuple is stable across revoke/un-revoke.

Previous link:
v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhipingz@=
meta.com/
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

 drivers/dma-buf/dma-buf.c                     |  32 ++++
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
 drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++--
 drivers/infiniband/hw/mlx5/odp.c              |   7 +
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++-
 drivers/pci/tph.c                             |  39 ++++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 117 ++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
 include/linux/dma-buf.h                       |  25 +++
 include/linux/mlx5/driver.h                   |  15 ++
 include/linux/pci-tph.h                       |   8 +
 include/uapi/linux/vfio.h                     |  43 +++++
 14 files changed, 496 insertions(+), 18 deletions(-)

--
2.53.0-Meta
