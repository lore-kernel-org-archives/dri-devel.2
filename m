Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89435F8E49D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200D510E97A;
	Fri, 17 Apr 2026 07:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="p7vUccaA";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0590B10E1D7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:18:38 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FLgjRH3451039; Thu, 16 Apr 2026 06:18:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=gniy3uTDgAbZRbr2JvoSRDyzFG9cFS4I3MN/SyLSvY4=; b=p7vUccaANRfh
 uTeB35EDElC5PodjZQnqgRVrRBLLyEHsU8GW85yEenF7szOfkyrXbtuRG3Jkq13r
 JjSlyb/QuyfAQyKSwPcj8vh3c23QLtR3tp/dj1lNelftY1O+bHKpML8dYFbNqar/
 Q7cK0zguBdtJGh/RLaW3GFP2gGGKtfvkMdNRyEeO8gZlKMcwTKkDnv1MAqq7MqZm
 T0FpEv6RpMdR7emzzXsmvxM0lbXeZoOiSX+1Rh0Ol5JpZ74Ph+1dAJtidNROBkOW
 V7VKHltLd59wyuHJ9q0lQgNo9TwG1EfTCfMbiPobkZ+ZAfJJpFtrT7AF00gWwNM3
 JTYdpSPsow==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84tt04h-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 16 Apr 2026 06:18:29 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 16 Apr
 2026 13:18:28 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <kvm@vger.kernel.org>
Subject: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
Date: Thu, 16 Apr 2026 06:17:44 -0700
Message-ID: <20260416131815.2729131-2-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416131815.2729131-1-mattev@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::30]
X-Authority-Analysis: v=2.4 cv=DeknbPtW c=1 sm=1 tr=0 ts=69e0e1a5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=3E3Mp2m-XbClQYvposQA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNiBTYWx0ZWRfX6FrByzlxctLn
 wXqFi+OEBYpJxxVODVtu6SpBggSjDgAiAHLcltsTCM/zsc2q7fMcowKkqBvDg+F3mdxiJjRku4x
 moO+QPW9snLGiEsDNnJy3N4zXUvQ2tVR3cpwKAua53JLjzBoycprZupI/4rVZKfEhcXVUouMnNr
 HNgbDSgN5azCjjyCQJnRB5rYl9X0y8NiIRX0b3nEjUbmGFa0AR9XfM8UxcR8FlamtzUv0FvjYM9
 eFLtMeY0dqRCzbm8yw6J91BscZDm6VBZq8fkoO8Xd/htuaf2ohoC1gG+ySaqyDnehcclWiF15oi
 Kc+upQye6m2ofs5zKo/O7qskgsnANL8dQUhs+RAzsF1KCLZKAXsxkGg523KhhJAYk+kvCQuw5lU
 YiVuU1oPCxsujxrnm3eIAF+VQgc3QX2O7kpDTJH6c8S2iuAkC5KQcvu2nUQ5WYjOzJLsHad0orA
 AMb08PIytGU/JZ7BJEw==
X-Proofpoint-GUID: rldl6TLxiGrFUZss98IienREl0Moymje
X-Proofpoint-ORIG-GUID: rldl6TLxiGrFUZss98IienREl0Moymje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
second/underflowing kref_put() then wait_for_completion() on a
completion that never fires.  Fixed by predicating on revocation
status.

This could happen if PCI_COMMAND_MEMORY is cleared before closing the
device fd (but the scenario is more likely to hit when future commits
add more methods to revoke DMABUFs).

Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
Signed-off-by: Matt Evans <mattev@meta.com>
---

(Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
context, so including in this series.)

drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 281ba7d69567..04478b7415a0 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 
 	down_write(&vdev->memory_lock);
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
+		bool was_revoked;
+
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
 
 		dma_resv_lock(priv->dmabuf->resv, NULL);
 		list_del_init(&priv->dmabufs_elm);
 		priv->vdev = NULL;
+		was_revoked = priv->revoked;
 		priv->revoked = true;
 		dma_buf_invalidate_mappings(priv->dmabuf);
 		dma_resv_wait_timeout(priv->dmabuf->resv,
 				      DMA_RESV_USAGE_BOOKKEEP, false,
 				      MAX_SCHEDULE_TIMEOUT);
 		dma_resv_unlock(priv->dmabuf->resv);
-		kref_put(&priv->kref, vfio_pci_dma_buf_done);
-		wait_for_completion(&priv->comp);
+		if (!was_revoked) {
+			kref_put(&priv->kref, vfio_pci_dma_buf_done);
+			wait_for_completion(&priv->comp);
+		}
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
-- 
2.47.3

