Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDD7CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7A710FFE8;
	Wed,  3 Jun 2026 15:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yCqaIobt";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82B210FFD9
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499930; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=M5zQjIPVfFmKstwwMGABYtO3/c5KzR7s9T/A9BdluRs=;
 b=yCqaIobteWxWpR5vVYWr78f/MFpxE4a7kmm8tIt7ZaQ2XAdg4xyDgMgppoLWtFDP18d2/xDwmdudzBil09hMRcUZs6BrE3iMVavuu6bV+TspBMt7AMqj3oHpxyo6/AcThEm40ugKTfMEkBZPGtJ91T414abeLPKvQZJQdxKzErc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR30_1780499928; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR30_1780499928 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:48 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
Subject: [PATCH v3 10/32] iommu/ipmmu-vmsa: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:42 +0800
Message-ID: <20260603151804.1963871-11-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Migrate IPMMU-VMSA to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/ipmmu-vmsa.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..6e2e5922ab1b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -699,14 +699,16 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
 	ipmmu_flush_iotlb_all(io_domain);
 }
 
-static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
-				      dma_addr_t iova)
+static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
+				      dma_addr_t iova, size_t *mapped_length)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+
 	/* TODO: Is locking needed ? */
 
-	return domain->iop->iova_to_phys(domain->iop, iova);
+	return domain->iop->iova_to_phys_length(domain->iop, iova,
+						mapped_length);
 }
 
 static int ipmmu_init_platform_device(struct device *dev,
@@ -892,7 +894,7 @@ static const struct iommu_ops ipmmu_ops = {
 		.unmap_pages	= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
 		.iotlb_sync	= ipmmu_iotlb_sync,
-		.iova_to_phys	= ipmmu_iova_to_phys,
+		.iova_to_phys_length = ipmmu_iova_to_phys_length,
 		.free		= ipmmu_domain_free,
 	}
 };
-- 
2.43.7

