Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F2CD6E6F
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8955810FFE1;
	Wed,  3 Jun 2026 15:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="awewpfsc";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057EC10FFE1
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499939; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=BNZF/SaFZFt3zbn7FrmeyBMohohJiu4c3VZtwUCcXEg=;
 b=awewpfscssXT+IGRO/8VdG7D6VvIjJuM7DJdOFRI4rJV5+ESk4E6W1ZRFzsDsFRhGvfOG45zsu/53qcU6MlUtSK/aUIMHvf0NksCEyk9xMRuEJVSYuwEDpCUSTij6ha5Hp3rVhw9QCal1K+Zi89XkYIU0qfjKlm4GtLqlglgRNw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR51_1780499936; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR51_1780499936 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:56 +0800
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
Subject: [PATCH v3 18/32] iommu/s390: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:50 +0800
Message-ID: <20260603151804.1963871-19-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for s390 IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/s390-iommu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..6cfcc55ef59f 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -986,22 +986,23 @@ static unsigned long *get_rto_from_iova(struct s390_domain *domain,
 	}
 }
 
-static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t s390_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t iova,
+						  size_t *mapped_length)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	unsigned long *rto, *sto, *pto;
 	unsigned long ste, pte, rte;
 	unsigned int rtx, sx, px;
-	phys_addr_t phys = 0;
+	phys_addr_t phys = PHYS_ADDR_MAX;
 
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	rto = get_rto_from_iova(s390_domain, iova);
 	if (!rto)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	rtx = calc_rtx(iova);
 	sx = calc_sx(iova);
@@ -1014,8 +1015,11 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 		if (reg_entry_isvalid(ste)) {
 			pto = get_st_pto(ste);
 			pte = READ_ONCE(pto[px]);
-			if (pt_entry_isvalid(pte))
+			if (pt_entry_isvalid(pte)) {
 				phys = pte & ZPCI_PTE_ADDR_MASK;
+				if (mapped_length)
+					*mapped_length = SZ_4K;
+			}
 		}
 	}
 
@@ -1183,7 +1187,7 @@ static struct iommu_domain blocking_domain = {
 		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
 		.iotlb_sync      = s390_iommu_iotlb_sync, \
 		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
-		.iova_to_phys	= s390_iommu_iova_to_phys, \
+		.iova_to_phys_length	= s390_iommu_iova_to_phys_length, \
 		.free		= s390_domain_free, \
 	}
 
-- 
2.43.7

