Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20DACA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A9810E9D8;
	Mon, 28 Sep 2026 11:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HnBsHf91";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F8210E9B1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:20:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D931D601FF;
 Mon, 28 Sep 2026 11:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0565B1F00893;
 Mon, 28 Sep 2026 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790594449;
 bh=rNJnFz5otNEyms2hJ74+ipAqrvtIGcYlpdIUlMpL6vI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HnBsHf9152s1jxNlk7JVn3m+4dA0IEpp+ePz9/Oe6wu39RIQAch4OI72TA43y8UY2
 +xReyPM4msNJRyq0OzeanpBLXt8jvX0DnK8yA+WjfU3JM+lFbF/In8lgosXLlk9rye
 7X6+NitvXG38+sJRlhrf6tQtyVvotmKG9x6FRKiSicQPsOS1g65Y9D2wv4G0eDkYpK
 o2i+aRkJPHuS+OIORz47kPLkg9Vpu3MOw4zNviZS9M8hQk2I0pgNVZMjU5IxqZ8OER
 s2xw4o8FTsQqQG6spUw8temI4YAgxjWLjO2iuNrLqWLftHwCSdTwSgbaYOOMua3GaI
 YsnGm9I2x9JDw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v8 20/23] PCI/P2PDMA: Let a client declare that it selects ATS
 per mapping
Date: Mon, 28 Sep 2026 14:19:24 +0300
Message-ID: <20260928-fix-p2p-acs-v4-0-v8-20-404453b9c435@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
References: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
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

From: Leon Romanovsky <leonro@nvidia.com>

The PCIe ATS Enable bit covers the whole device, so P2PDMA cannot tell
from it whether a client will translate a given address. Most devices
translate any address once ATS is enabled, but some choose ATS per DMA
mapping and can still use bus addresses for the rest.

Add pcim_p2pdma_set_ats_per_mapping() so the driver of such a device can
declare that before P2PDMA starts treating clients with ATS enabled as
translating everything. Keep it in the device's P2PDMA state, which
already ends with the driver binding.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c       | 27 +++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1f4bf0125a5c..ae676509f9f3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -26,6 +26,7 @@
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
+	bool ats_per_mapping;
 	struct xarray map_types;
 	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
 };
@@ -1568,6 +1569,32 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
+/**
+ * pcim_p2pdma_set_ats_per_mapping - Declare per-mapping ATS for a client
+ * @pdev: PCI device that initiates peer-to-peer DMA
+ *
+ * Declare that @pdev issues Translated Requests only for the DMA mappings its
+ * driver sets up to use ATS, rather than for any address once ATS is enabled.
+ * P2PDMA then takes the Address Type of this client's Requests from the TLP
+ * flags its callers pass.
+ */
+void pcim_p2pdma_set_ats_per_mapping(struct pci_dev *pdev)
+{
+	struct pci_p2pdma *p2p;
+
+	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
+	if (!p2p)
+		/*
+		 * ats_per_mapping is a performance optimization,
+		 * if pcim_p2pdma_init() didn't set pdev->p2pdma pointer
+		 * for some reason, let's simply use ATS global settings.
+		 */
+		return;
+
+	p2p->ats_per_mapping = true;
+}
+EXPORT_SYMBOL_GPL(pcim_p2pdma_set_ats_per_mapping);
+
 /**
  * pci_p2pdma_map_type_tlp - Determine the mapping type for P2PDMA transfers
  * @provider: P2PDMA provider structure
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 36045b1b730c..543a09426a11 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -109,6 +109,7 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length);
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
+void pcim_p2pdma_set_ats_per_mapping(struct pci_dev *pdev);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -166,6 +167,9 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
+static inline void pcim_p2pdma_set_ats_per_mapping(struct pci_dev *pdev)
+{
+}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {

-- 
2.55.0

