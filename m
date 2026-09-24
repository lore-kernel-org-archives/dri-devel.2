Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917BAC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94D710F633;
	Thu, 24 Sep 2026 15:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h/+dGqOQ";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B3110F633
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1790263319;
 bh=9hpaLa2+INWP3vqHDGtmMPxWwc0UhU3YYJ+m/heD+BQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h/+dGqOQsvDc0m1fW2WiasHQtkIf2OZqIsbjtBan7Ob1yTA1Hr+jcFWq4y2lKO7jR
 7uo+NLC8fiSEB/NVGNgaUv9kUdSwtqic0KuvHHblfUAHBTBljNo4XSnKZn3rbT7ndo
 kabiTc07/Qo/2tXOQaHiA8nE2Y32Z6ir03fcoT72P4Q8gIrTkGMqjNp7W5LmtL28ic
 14wECNTO33knq4rTY1SZAchbFoY0xhhoKxIyoMWXFw/1hMbKIZB+t2YVwWCfCOLBDw
 9DlkcwryRb6Y3q5XGXsPIBhGVbZWPlKsDC9d+Y3L2bqdmoC6bKY54tIBk/kxQzury0
 oj2rIF/Lo0E1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHck6FZRz4w9T;
 Fri, 25 Sep 2026 01:21:58 +1000 (AEST)
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
Subject: [PATCH v7 2/9] vfio/pci: Un-revoke DMABUFs in
 LOW_POWER_ENTRY_WITH_WAKEUP resume
Date: Thu, 24 Sep 2026 16:21:45 +0100
Message-ID: <20260924152159.49702-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924152159.49702-1-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
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

VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP correctly revokes
DMABUFs on entry and, when paired with a
VFIO_DEVICE_FEATURE_LOW_POWER_EXIT, vfio_pci_runtime_pm_exit()
correctly un-revokes them.

However, when vfio_pci_core_runtime_resume() signals the eventfd on
resume, the bare __vfio_pci_runtime_pm_exit() is used (which does not
un-revoke).  Add vfio_pci_dma_buf_move(false) to the resume path,
making it similar to vfio_pci_runtime_pm_exit().

This also reorders the eventfd signal after the un-revoke and
__vfio_pci_runtime_pm_exit() to guarantee that woken threads observe
the new state.

Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1f6066107831..e170cdc7ac92 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -527,8 +527,14 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 	 */
 	down_write(&vdev->memory_lock);
 	if (vdev->pm_wake_eventfd_ctx) {
-		eventfd_signal(vdev->pm_wake_eventfd_ctx);
+		struct eventfd_ctx *ctx = vdev->pm_wake_eventfd_ctx;
+
+		vdev->pm_wake_eventfd_ctx = NULL;
 		__vfio_pci_runtime_pm_exit(vdev);
+		if (__vfio_pci_memory_enabled(vdev))
+			vfio_pci_dma_buf_move(vdev, false);
+		eventfd_signal(ctx);
+		eventfd_ctx_put(ctx);
 	}
 	up_write(&vdev->memory_lock);
 
-- 
2.50.1 (Apple Git-155)

