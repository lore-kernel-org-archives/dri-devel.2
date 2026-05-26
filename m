Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C63CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 15:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A8E10E63D;
	Tue, 26 May 2026 15:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="FmVlewo5";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7095D10E50C
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 15:31:48 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q3Ne8o820802
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=8xtY3pcSYAL6nO+0/P
 AuZZkYPYk7kCame4N5Q1oLZRw=; b=FmVlewo5BTuIcI0YtdRk8UEMRdP+xTC3d+
 W5y7tqXXirgVt7YB053AWMWJcj3z5KCvKK8DoTSv2qxyINk45uSO+qfNe23c+kfl
 XzFKi4flSD/KPCfe/MAR9Z/5K8tLPd4Pkvu/jx4jm6OAI6YDJYyOVtnEe5jxFund
 +03brpjHnGQcmFBX3Ui/5Vmqjfa7nr0iDL43/JI4UkdN+lgM/WDwghKBb2RT5sLx
 dXsPOIl9sw7Iwlwmt03eAnRumxGMnFEW/O/aUosOJ+x10R4E5YgB9Nzco8HCz6PD
 1UHLO6PTdZ9FWJFzTheaQMzzgobdhSHT44QMnL3rBD6czNaf+72Q==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eb9wyxsek-16
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:47 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:31:40 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 5892A35B01D35; Tue, 26 May 2026 07:44:02 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Tue, 26 May 2026 07:43:52 -0700
Message-ID: <20260526144401.1485788-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oRVrY4VVOetrK2Lx2Dd8NLH9IHAe15m-
X-Authority-Analysis: v=2.4 cv=NY7WEWD4 c=1 sm=1 tr=0 ts=6a15bce3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=G5DkcSNjgHGVSvK28kQA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: oRVrY4VVOetrK2Lx2Dd8NLH9IHAe15m-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMyBTYWx0ZWRfX4C+o58z7IE7a
 NugfOW2Y3Z/+MeqqMtBPAIHYjEqAEHyW2ALTB2aM14WiXQ7FP0Dr8Ugo7WDy1atVqAzWlgMmxHn
 HR9fxP523vuKP5n5+lUKDJUNnWUN0Z03PnXzuc1GS/cmVXHrnDiaVa5uB9KImA09NEqKBGtgW7w
 0vulOoECSvSAg2IZPbiYiWIMJh7HpXXzmGc4ChF5x/Ou9pqg480FENhhBHp0/Zv5mN2TndztmWL
 ZP1rZ8n9rhNE+hltJJxniOiXf9OTr7+P3WqkOSPheYLetTjjgMbMjlTql/tcFAefJWingdYXeIp
 vQOKDf6tjSFtMmS8qOqLv7RZKhuB5JoZIiOoq64SMj7RCSwLrvUQpwS7Pf1LjH4/C3oWBAbPGa+
 KAeR1e7WiEoXk/2QE40r2JrX1+dRvty8uTHQJjOG4BP8ch2SgCQYntEpQsPNouVCI0NBahXWo+g
 OaYzVGUf3az6m1MN54A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
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

Patch 1 exposes the enabled TPH requester type through a small PCI/TPH
helper so callers don't reach into pci_dev internals.
Patch 2 adds the optional dma_buf_ops::get_tph callback to the dma-buf
framework so importers can fetch TPH metadata from an exporter.
Patch 3 implements get_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 4 wires up the mlx5 RDMA driver as a consumer.

Previous link:
v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (4):
  PCI/TPH: expose the enabled TPH requester type
  dma-buf: add optional get_tph() callback
  vfio/pci: implement get_tph and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   6 +
 drivers/infiniband/hw/mlx5/mr.c               |  86 +++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  28 +++--
 drivers/pci/tph.c                             |  12 ++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 110 +++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  21 ++++
 include/linux/mlx5/driver.h                   |   7 ++
 include/linux/pci-tph.h                       |   2 +
 include/uapi/linux/vfio.h                     |  37 ++++++
 11 files changed, 311 insertions(+), 13 deletions(-)

--=20
2.53.0-Meta

