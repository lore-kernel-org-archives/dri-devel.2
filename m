Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC67606D80A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYHDOMsH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DF810F287;
	Mon,  9 Nov 2026 13:10:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21CF10F283;
 Mon,  9 Nov 2026 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794229836; x=1825765836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T7LXLzC0gRylbqBTsZD+y1ZkJOs+qcyQ4bV2Qg0srZE=;
 b=BYHDOMsHkZ3cZB5Qglwav12tgQlrC0K2sePFcZ/27aIWDU/H+Pxod473
 Z+CfcWZV9Nm8pVtqoPG5zz5AHU1S1I+WrkltfnFPx9i3XExfPvVPmFLrR
 tY3fCIWGPRUgzXLraZHqfh/TnB9dPBJVe1mvJ6tHNYxflMUKzdIJlpyZc
 I/6QJn0STWqCGoIZ4zRJifqy6p6Q+OWBxw89XEmiwgY4kIvF/cBQDTdYU
 8BWJRGGcoJK2l4w8dkHNFKC08kmzSi9GJU8sVr7FjL9PbgK+v9nyTdbEu
 yGvCppdDVxwZddpxSXxFsOFRAEAwSSvI4Tsah9iNNUv4vQjgktvPR1SBd Q==;
X-CSE-ConnectionGUID: RRY5JtcDRCaF7BD8HhGhFA==
X-CSE-MsgGUID: qRruxJLITt2+DcgMrxO8Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3039510"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3039510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:10:36 -0800
X-CSE-ConnectionGUID: 5PUYAd50QkGEZoKjws36ng==
X-CSE-MsgGUID: GEPSSIKzSdKrJQUQbEOh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7905762"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.139])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:10:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI/sysfs: Remove resource assignment after BAR resize
Date: Mon,  9 Nov 2026 15:10:08 +0200
Message-ID: <20261109131011.1815-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pci_resize_resource() assigns the resized BAR and the other BARs it
released, or restores the original configuration on failure. Calling
pci_assign_unassigned_bus_resources() after it is redundant. If that
call manages to assign more resources in some scenario, the problem
should be fixed inside pci_resize_resource() instead.

Remove the pci_assign_unassigned_bus_resources() call from
__resource_resize_store().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6669e9ad5bd3..bccd0bd5091b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1731,7 +1731,6 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 				       const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_bus *bus = pdev->bus;
 	unsigned long size;
 	int ret;
 	u16 cmd;
@@ -1768,8 +1767,6 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
 			 n, ERR_PTR(ret));
 
-	pci_assign_unassigned_bus_resources(bus);
-
 	if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
 		pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");
 
-- 
2.47.3

