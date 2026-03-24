Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DB510A62CA
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9432710E990;
	Thu, 26 Mar 2026 13:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="CdOCU4Nn";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08ACF10E53F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 23:52:04 +0000 (UTC)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OLL7XS1433028
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:52:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=GTcNfaIvTV9CCY4TmT
 n6enDItgoZyUnkmTMnvSeTAAU=; b=CdOCU4NndSVgN7zKgckJpgtavyWE3HGGBo
 w0ZNInhRdhfx+BxwqlhVlGDGV4taks4QDuIJG5B5A+TVmUmih4moBce6gRIXlZ9R
 nlH9QI+MQOc0sEbqFwRMi78q6Jcm8EBjfWkMgojEMU4v4knh7rmzpDMOFuTYMM9I
 twBFxtrnbnnCymOojZFLr3UrKRg3mkhv4OTXwdFfcxJICeogrS5eANvzgjjMQkIK
 +q6K0fkL1zMPFCYURkJLNPtbHygVneLNgy7NjiP7l//Pdeo6bjqVxQ8YHTvLizIE
 6f+ZI5WJeroXRgpfiYSwBrWxyM6aZkfBjWmCXPKGF6TuYUXjuuzA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d42eysha9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:52:03 -0700 (PDT)
Received: from twshared22445.03.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Mar 2026 23:51:52 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id B181C1D7CEBE; Tue, 24 Mar 2026 16:46:15 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC v2 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Tue, 24 Mar 2026 16:46:01 -0700
Message-ID: <20260324234615.3731237-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=adxsXBot c=1 sm=1 tr=0 ts=69c323a3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=zJhtDeQ-gK41YlDc0VgA:9
X-Proofpoint-ORIG-GUID: V8wTRy714NZoEybaSzU_UGqpCzW1ix5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NCBTYWx0ZWRfX/DjCby4JusCr
 uKrK3p7fp8uVuiTyY6ijL7jbHM7WDLXEX01Ldb/exR2FjcRUsxi29xGeb8f42tyBJ53uo2m60d3
 uULhj+iPdQKsdbzJUADR3Pfxry2wpyfRsj96xa/JHckUmSL6A63+PM6/bIJe75bj/koTrhELerb
 NzaykG6WIkeCb2YrhndDPVuZ2WlE2SKrk1nn9aSbrDorBvheK2EgE/K0f5N1YMlLUSt1bEHld7D
 pTyZnlKBvhgWHMoG5JkCo+8CLqmlyvejyL/1PMnGuFnAiuRcOabeLoBS7V75jZvI8EC8OelmQrq
 dtVCue6o9PygmoMXXaANOLZiym/zTnckF6OmBQN58SG7sIe1FCOKUeET4OsJYO6sVEU9DEl0FDj
 1pdeOBvYMCI0uHu93dGs2ALtb93YJUgPb8bdknEopzY/AapORU1Glz0EjisghXNc6v7Bhl+NlMA
 gvsWg3K/0FTZbTSqFGw==
X-Proofpoint-GUID: V8wTRy714NZoEybaSzU_UGqpCzW1ix5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Mar 2026 13:17:48 +0000
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

Currently, the steering tag can be used for a CPU on the motherboard; the
ACPI check is in place to query and obtain the supported tph settings. He=
re
we intend to use the tph info to improve RDMA NIC memory access on a vfio=
-based
accelerator device via PCIe peer-to-peer. When an application registers a
RDMA memory region with DMABUF for the RDMA NIC to access the device memo=
ry,
the tph info of the memory region can be retrieved and used to set the
steering tag / process hint (ph). Additional instructions or hints can be
passed to the GPU or accelerator device for advanced memory operations,
such as, read cache selection.

Note this RFC is for the discussion on the direction and is not intended =
to be
a complete implementation. If no objection, we will convert it to a Patch=
 set.

Changes v1 -> v2:
- Encode steering tag and ph in vfio_device_feature_dma_buf flags field
  instead of adding new uapi struct fields, to preserve ABI compatibility
- Fix subject prefixes: "Vfio:" -> "vfio:", "RMDA MLX5:" -> "RDMA/mlx5:"
- Fix raw steering tag vs st_index mismatch: get_tph() now returns a raw
  steering tag, and the mlx5 consumer converts it to an st_index via the
  new mlx5_st_alloc_index_by_tag() API
- Fix @tph doc typo to @steering_tag in dma-buf.h
- Remove unused variable, fix parameter alignment, fix trailing semicolon

Zhiping Zhang (2):
  vfio: add callback to get tph info for dmabuf
  RDMA/mlx5: get tph for p2p access when registering dmabuf mr

 drivers/infiniband/hw/mlx5/mr.c               | 34 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 23 +++++++++----
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 26 ++++++++++++--
 include/linux/dma-buf.h                       | 30 ++++++++++++++++
 include/linux/mlx5/driver.h                   |  7 ++++
 include/uapi/linux/vfio.h                     |  9 +++--
 6 files changed, 118 insertions(+), 11 deletions(-)

--
2.52.0
