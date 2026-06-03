Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528FDCD6E6E
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5587D11200E;
	Wed,  3 Jun 2026 15:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XQWSXUqS";
	dkim-atps=neutral
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B734A10FFE1
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499929; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=p4rS05BvfO7tKKbX+DS2TrSOXcVnNjfP3PbV2BH3iGY=;
 b=XQWSXUqSPzKwm8OQ/jHiVvaurfML3HQgeKTVEhHl64dSjCpKBKVnWBmjCvFfmb8crvkoCZ+CuYiUsV9fqA0sMWjH03txts/P45b9TiyqhZTOMfBQXZ/QJFtbtj94eTnbcA5bvGSMTdw+7Z6AiRQR3oblNUmAumw25ZaBwe5eFSo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR2o_1780499927; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR2o_1780499927 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:47 +0800
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
Subject: [PATCH v3 09/32] iommu/apple-dart: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:41 +0800
Message-ID: <20260603151804.1963871-10-guanghuifeng@linux.alibaba.com>
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

Migrate Apple DART to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/apple-dart.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 17bdadb6b504..fdc533ba72da 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -528,16 +528,17 @@ static int apple_dart_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t apple_dart_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
 
+
 	if (!ops)
-		return 0;
+		return PHYS_ADDR_MAX;
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys_length(ops, iova, mapped_length);
 }
 
 static int apple_dart_map_pages(struct iommu_domain *domain, unsigned long iova,
@@ -1018,7 +1019,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
 		.iotlb_sync	= apple_dart_iotlb_sync,
 		.iotlb_sync_map	= apple_dart_iotlb_sync_map,
-		.iova_to_phys	= apple_dart_iova_to_phys,
+		.iova_to_phys_length = apple_dart_iova_to_phys_length,
 		.free		= apple_dart_domain_free,
 	}
 };
-- 
2.43.7

