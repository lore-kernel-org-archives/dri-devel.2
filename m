Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDA0C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C21410E212;
	Wed, 15 Jul 2026 17:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="LJVXNCur";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E7C10E212
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1784137677;
 bh=jXukzocMroSC/LDV4VxS0sy9cbxF94ekgzm+m21Hqr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LJVXNCurWVpFtvsQH4f8xEcT5wtlQr/+uPhxAD93C7qZBZ4wnr2GCtJ8g+s5+x5/D
 quT4YDUfYXU7Uxcs8fM0uemAAVEfrkwLIHrOfDFU63wHWiuqWca/xHKplc4ST59hHv
 DKX7T+45HBMVf2gzCniHIA8ddIg0RjgrQOMjQj/h+bodXVJOKh7n8kmpBrihWVo3Rb
 zaqMOgaq3QTXHvYnlvYL+YMUSHIZbEWNNTjO0lAHI+Q3pJAfsRLl/j1m/fkYuMf7sd
 eUx79FR3qFQ1N15c4bh93M64AX9Y2PwjFwOsrYWjPtL7whB3Q9KqQxFAa9tsuYCbnp
 8fG5eLLX+1O6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kCw3B9Bz4wCB;
 Thu, 16 Jul 2026 03:47:56 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Date: Wed, 15 Jul 2026 18:47:24 +0100
Message-ID: <20260715174737.15287-2-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
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

Preparing for a refactor in a subsequent patch, split the pool-related
release code into a new pci_p2pdma_release_pool() function.

This allows future compile-time selection of a null implementation for
pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
P2P-related files.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..498bca257419 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -226,6 +226,17 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
 	.folio_free = p2pdma_folio_free,
 };
 
+static void pci_p2pdma_release_pool(struct pci_dev *pdev,
+				    struct pci_p2pdma *p2pdma)
+{
+	if (!p2pdma->pool)
+		return;
+
+	synchronize_rcu();
+	gen_pool_destroy(p2pdma->pool);
+	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
+}
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -237,15 +248,8 @@ static void pci_p2pdma_release(void *data)
 
 	/* Flush and disable pci_alloc_p2p_mem() */
 	pdev->p2pdma = NULL;
-	if (p2pdma->pool)
-		synchronize_rcu();
+	pci_p2pdma_release_pool(pdev, p2pdma);
 	xa_destroy(&p2pdma->map_types);
-
-	if (!p2pdma->pool)
-		return;
-
-	gen_pool_destroy(p2pdma->pool);
-	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 }
 
 /**
@@ -946,8 +950,8 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 	struct pci_p2pdma *p2pdma;
 
 	/*
-	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
-	 * ensure pdev->p2pdma is non-NULL for the duration of the
+	 * Pairs with synchronize_rcu() in pci_p2pdma_release_pool()
+	 * to ensure pdev->p2pdma is non-NULL for the duration of the
 	 * read-lock.
 	 */
 	rcu_read_lock();
-- 
2.50.1 (Apple Git-155)

