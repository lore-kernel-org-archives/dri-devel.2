Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8987EF5A8AD
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B548510E07C;
	Mon, 20 Apr 2026 18:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="lmTLwZTJ";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAE710E07C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:44:40 +0000 (UTC)
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K4G7s93312329
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:44:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=v1B/weXcqQ1lWLTVVV
 0vhTvXO65+/046zoF1VJqryV4=; b=lmTLwZTJjAs6lgOoHWNSrsl3aPUh3AG54U
 dTO4XGquprYR6q/ph4MhY0BSFDVGQkVWURiqlnvll08oow6VhceG+As1lhSU+j3D
 04nQCEfN2Nd+5ZnNAs//DCJFMIomdywVDMzZXujLuNBlYZM5uOMlWNUXrobAz4H5
 ImqMUODQ8YCv7+toj7lYSfAkqLdwgwbD50VP/SZEGkhOImzlaApHtJ7/TUaHSW2J
 RKZ22WLJniIdHy1TFWxJvzWcEMltloQqiGQB3AGpaigUKdQsxWE61Gt2uX+b6h5i
 95+fUbdAIH+J+wpTcNY4hr52T10FTqvgaZJLe7c/unPp5d7+3WNQ==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dmxjgpy51-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:44:40 -0700 (PDT)
Received: from twshared22734.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 20 Apr 2026 18:44:39 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 7C0B6113AA911; Mon, 20 Apr 2026 11:39:20 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Stanislav Fomichev <sdf@meta.com>, Keith Busch <kbusch@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1 0/2] Retrieve TPH from dma-buf for PCIe P2P memory access
Date: Mon, 20 Apr 2026 11:39:14 -0700
Message-ID: <20260420183920.3626389-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AfMH84tEmdkKyeSLuZC4TwCdbis5KHEf
X-Authority-Analysis: v=2.4 cv=WsIb99fv c=1 sm=1 tr=0 ts=69e67418 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=XtSdSgJ7MZthVsN6br0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: AfMH84tEmdkKyeSLuZC4TwCdbis5KHEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4MiBTYWx0ZWRfXx+yFegiV2+to
 17S7zQndNVcXnYIkFZ4VpSgDTNjYrQ7ccHDNBn6yq+o9mKfN0KSPHZWcOVS5Upx0y5R2pOL8tYX
 2pEebFlG5MB0cOE0kt3BTwAYUGcw4pbk51F+wXriCZlQPG5JPJ4OlghEIZvdvQgxMUdItc+9Zmj
 yRjkXeQYWnPbEs6z+sfVbEaSjNrmlrWukCcLPNCIXo2ZCOq3hrJy4jb7rebuecbs18CzDU8tG//
 iuM3gH6Pd8enRLtwX0AJreFR0ghMvNK8tfY3hgdPnPjHScnIJ70csNUK8dKmhkSoI9qtnMiqhku
 1Gn6Fp8tQ6oi3hTEEo5ts0FroQCv0SEt5ehyJQVpTMQG5iIw2TDb97gD4nshie73N7Rojc7KF0A
 TGkKMAWL61PoA5ZLnC0+M9szhuuQoCofnuxvibfs8aq9RZIK17ZgPWcpXzIvsC67OBVHTLUQy/c
 Job1bT0QRBGO18lXJdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
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

Currently, TPH steering tags are derived for CPUs via ACPI. This series
extends the VFIO dma-buf path so a vfio-based accelerator can attach TPH
metadata to an exported dma-buf, and lets mlx5 consume that metadata
when registering a dma-buf MR for PCIe peer-to-peer access.

Patch 1 adds a dma-buf callback to retrieve raw TPH metadata and updates
VFIO_DEVICE_FEATURE_DMA_BUF to carry the optional steering tag and
processing hint in one extra trailing entries[] object without changing
the base uAPI layout. Patch 2 consumes the exported TPH metadata in mlx5
and converts the raw steering tag into an mlx5 steering-tag index.

Previous RFC link:
https://lore.kernel.org/linux-pci/20260324234615.3731237-1-zhipingz@meta.=
com/T/#u

Zhiping Zhang (2):
  vfio: add callback to get tph info for dma-buf
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mr.c               | 38 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 25 +++++---
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 62 ++++++++++++++-----
 include/linux/dma-buf.h                       | 17 +++++
 include/linux/mlx5/driver.h                   |  7 +++
 include/uapi/linux/vfio.h                     | 28 +++++++--
 6 files changed, 151 insertions(+), 26 deletions(-)

--=20
2.52.0

