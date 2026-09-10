Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AACC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347C110F447;
	Thu, 10 Sep 2026 11:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ra4n7vOl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED93F10F447
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:32:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D39D54199D;
 Thu, 10 Sep 2026 11:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EE31F000FF;
 Thu, 10 Sep 2026 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789039946;
 bh=mewnXaBKzi2RuajAdR+1gFX2UcD8vJrlfBBh0mRM42E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ra4n7vOl0p6AbaxDDTzha13CuM7FIoHC/LtcZWhlEZa3wjszkfLr9DgxKlCPXomjr
 EAacQV1plKqvRzGJZDjID8gASAiPZgNBga6H67V9izFK5wOx8pISTAm3C/Pk3Shorb
 N9RX7Q7UmObdzlwxXhaYViVa3ILf7rYS9cst/BpbxlfD0Fhe7hTQ/dSSX7vVEympXe
 Z4rzdinSgRHzE+M3wS3EyaHpU/hWIXIFUBzIiQfwYNxaZjRLk+lPJlD8on5WgVncUm
 EHpGKv3jl9epUY3zUhPzUuEC0+7s+V3zFm3q/ho/qMua8JQ9YqD02sD9LC0Hx2VWSe
 Oq3wMMCdxpqCg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Matt Evans <matt@ozlabs.org>
Subject: [PATCH v5 01/18] PCI/P2PDMA: Document pdev->p2pdma lifetime rules
Date: Thu, 10 Sep 2026 14:31:56 +0300
Message-ID: <20260910-fix-p2p-acs-v4-0-v5-1-856087f63c0d@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910-fix-p2p-acs-v4-0-v5-0-856087f63c0d@nvidia.com>
References: <20260910-fix-p2p-acs-v4-0-v5-0-856087f63c0d@nvidia.com>
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

pdev->p2pdma is normally accessed through provider-owned references, but
pci_p2pmem_find_many() and the p2pmem sysfs attributes may race with driver
unbind.

Document initialization, teardown, and how the release grace period
protects both the P2PDMA state and its optional allocation pool.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4e4d2df17a45..d8c9d605b828 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,29 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+/*
+ * Lifetime and RCU usage
+ *
+ * Within one driver bind, pdev->p2pdma is set exactly once,
+ * by pcim_p2pdma_init(), and cleared exactly once, by the pci_p2pdma_release()
+ * devres action that the same function installs. It is never changed and follow
+ * same lifetime as parent pdev.
+ *
+ * Most exported entry points reach pdev->p2pdma through a struct pci_dev or a
+ * struct p2pdma_provider owned by the provider driver, and
+ * pcim_p2pdma_provider() requires callers to drop those references before the
+ * driver's remove() completes. Those cannot run concurrently with
+ * pci_p2pdma_release(), and their rcu_dereference() calls are simply how an
+ * __rcu pointer is read.
+ *
+ * pci_p2pmem_find_many() and the p2pmem sysfs attributes are the exceptions.
+ * The first walks every PCI device, so it can reach a provider whose driver is
+ * unbinding: pci_get_device() pins the struct pci_dev, not the driver. The
+ * second is reachable from userspace until sysfs_remove_group() runs at the end
+ * of the release. pci_has_p2pmem() must dereference the object to determine
+ * whether it owns a gen_pool, so even a device without a pool must remain alive
+ * until that RCU reader exits.
+ */
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;

-- 
2.55.0

