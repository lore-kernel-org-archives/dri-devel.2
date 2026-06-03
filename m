Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D66CD6E6C
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB04510FFE0;
	Wed,  3 Jun 2026 15:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eaSxOcKA";
	dkim-atps=neutral
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4B810FFD4
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499936; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=dO5/NXjjcnDrdXukdKiHb5r/uOc5W1brW08Se5tUIbo=;
 b=eaSxOcKA3PqLuXe0Qa6TKHRgybqSrwVrq2IXbs0bME5izat309Jnj8TIiR9ik3aYSxzRHnL+dXo/vUVJOhSPlr+4AmH9nn2FdAbFn1iMPEBdQiE0wSWCsXFlWCgVjW0OAqkkGE3vcrza3Tk5Owi0U/Fr40Xc/wgNj4Gel+ev598=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR3v_1780499931; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR3v_1780499931 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:51 +0800
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
Subject: [PATCH v3 13/32] iommu/fsl_pamu: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:45 +0800
Message-ID: <20260603151804.1963871-14-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for FSL PAMU IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/fsl_pamu_domain.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 9664ef9840d2..60abd497dc63 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -169,12 +169,30 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
+static phys_addr_t fsl_pamu_iova_to_phys_length(struct iommu_domain *domain,
+						dma_addr_t iova,
+						size_t *mapped_length)
 {
+
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
-		return 0;
+		return PHYS_ADDR_MAX;
+
+	/*
+	 * PAMU configures exactly one Primary PAACE entry per LIODN with the
+	 * Multi-Window (MW) bit cleared and ATM = PAACE_ATM_WINDOW_XLATE,
+	 * WBAL/TWBAL = 0. That is, every LIODN is backed by a single hardware
+	 * mapping window of fixed size (1ULL << 36, i.e. 64GB, see
+	 * pamu_config_ppaace()) performing an identity translation. The driver
+	 * does not split this window into SPAACE sub-windows, so the entire
+	 * aperture is one PAACE "PTE" entry. Return that single entry's size
+	 * as mapped_length, matching the iova_to_phys_length contract that
+	 * mapped_length reports the full size of the mapping entry which
+	 * covers iova (not the remaining bytes from iova to its end).
+	 */
+	if (mapped_length)
+		*mapped_length = 1ULL << 36;
+
 	return iova;
 }
 
@@ -435,7 +453,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
-		.iova_to_phys	= fsl_pamu_iova_to_phys,
+		.iova_to_phys_length	= fsl_pamu_iova_to_phys_length,
 		.free		= fsl_pamu_domain_free,
 	}
 };
-- 
2.43.7

