Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBB2F9D0E9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD09710E62B;
	Tue, 14 Apr 2026 16:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P+CTp9l3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E419A10E629
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A84CC44477;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F3CFC4AF0D;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776184280;
 bh=ZM2pWoeOuo+RG4s6jFjQePRcse27xHjB7V24etmkYmU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=P+CTp9l39ZoNB3R5OzORxl9YEzVfDLqEjN+vjAHMdcttu4HcslQHZ1+rnfx2HPjZT
 nkML5lv8NSAhtA+v0A5NCj3ChCx3FiRRSD5wkLCC/YuDXQ8J79yAuc2HkxIr87ByKb
 q12LWkfagQ5X2uvdAKavph82ON35tpO3ZIkFtenp1l70opxuqmPAn9COXi/5x2F9bd
 TuI77JKICfIoJ8P6LzAsgoD6RW3DcV3QIoyKVCzuhpMSNeYi3VMp5R7c2cI+ub21Wr
 pw5pBXpQvA7tPt+c5KWaCR6BcNTeS808l8eWBsburUlMHamUeDB/6NKzPhCuvlBE4G
 qHzx+UFUfcYQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4AF9D0E9;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
From: Ekansh Gupta via B4 Relay
 <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Date: Tue, 14 Apr 2026 22:01:16 +0530
Subject: [PATCH 2/3] gpu: host1x: Migrate to generic context device bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-computebus-v1-2-4d904d40926a@oss.qualcomm.com>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
In-Reply-To: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bharath Kumar <quic_bkumar@quicinc.com>, 
 Chenna Kesava Raju <quic_chennak@quicinc.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776184278; l=4839;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=DQ1olxxNHseU94rnbtsHQ4+BWgV7NjVl53Fj2nX92ag=;
 b=LNNS8pXQotH116K8rf8Vjr5wHJV7xKAjMrOpuqvSIYb2fF05W7RU2RHTSCAtKIlqBJ/gG+DKE
 ePcI9NgORtfD6ngTYZwsvy+E+hgJBXDVF5vXGtcMu8cja0X8Cx7XpLm
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Endpoint-Received: by B4 Relay for ekansh.gupta@oss.qualcomm.com/20260223
 with auth_id=647
X-Original-From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
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
Reply-To: ekansh.gupta@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Replace the host1x-specific context device bus with the generic
context_device_bus_type. This eliminates driver-specific bus
infrastructure in favor of shared code in the driver core.

The host1x driver creates synthetic context bank devices to represent
IOMMU contexts for memory isolation. These devices were previously
registered on a host1x-specific bus ("host1x-context"), but this
functionality is now provided by the generic "context-device" bus.

The IOMMU subsystem is updated to recognize the generic bus instead
of the host1x-specific one, allowing proper IOMMU operations on
context devices.

This change maintains functional equivalence - context devices still
work the same way, just on a different bus. The device names remain
"host1x-ctx.N" to preserve any userspace dependencies.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/gpu/host1x/Kconfig       |  5 +----
 drivers/gpu/host1x/Makefile      |  1 -
 drivers/gpu/host1x/context.c     |  2 +-
 drivers/gpu/host1x/context.h     |  3 +--
 drivers/gpu/host1x/context_bus.c | 26 --------------------------
 drivers/iommu/iommu.c            |  6 +++---
 6 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
index e6c78ae2003a..e3e3896f4d71 100644
--- a/drivers/gpu/host1x/Kconfig
+++ b/drivers/gpu/host1x/Kconfig
@@ -1,13 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config TEGRA_HOST1X_CONTEXT_BUS
-	bool
-
 config TEGRA_HOST1X
 	tristate "NVIDIA Tegra host1x driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	select DMA_SHARED_BUFFER
-	select TEGRA_HOST1X_CONTEXT_BUS
+	select CONTEXT_DEVICE_BUS
 	select IOMMU_IOVA
 	help
 	  Driver for the NVIDIA Tegra host1x hardware.
diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index fead483af0b4..2ccd9a5f1c65 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -23,4 +23,3 @@ host1x-$(CONFIG_IOMMU_API) += \
 	context.o
 
 obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
-obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index d50d41c20561..6411c17cc060 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -54,7 +54,7 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 		ctx->dev.dma_mask = &ctx->dma_mask;
 		ctx->dev.coherent_dma_mask = ctx->dma_mask;
 		dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
-		ctx->dev.bus = &host1x_context_device_bus_type;
+		ctx->dev.bus = &context_device_bus_type;
 		ctx->dev.parent = host1x->dev;
 		ctx->dev.release = host1x_memory_context_release;
 
diff --git a/drivers/gpu/host1x/context.h b/drivers/gpu/host1x/context.h
index 3e03bc1d3bac..87ae522fafc7 100644
--- a/drivers/gpu/host1x/context.h
+++ b/drivers/gpu/host1x/context.h
@@ -8,13 +8,12 @@
 #ifndef __HOST1X_CONTEXT_H
 #define __HOST1X_CONTEXT_H
 
+#include <linux/context_bus.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 
 struct host1x;
 
-extern struct bus_type host1x_context_device_bus_type;
-
 struct host1x_memory_context_list {
 	struct mutex lock;
 	struct host1x_memory_context *devs;
diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
deleted file mode 100644
index 7cd0e1a5edd1..000000000000
--- a/drivers/gpu/host1x/context_bus.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2021, NVIDIA Corporation.
- */
-
-#include <linux/device.h>
-#include <linux/of.h>
-
-const struct bus_type host1x_context_device_bus_type = {
-	.name = "host1x-context",
-};
-EXPORT_SYMBOL_GPL(host1x_context_device_bus_type);
-
-static int __init host1x_context_device_bus_init(void)
-{
-	int err;
-
-	err = bus_register(&host1x_context_device_bus_type);
-	if (err < 0) {
-		pr_err("bus type registration failed: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-postcore_initcall(host1x_context_device_bus_init);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..f01a13e2e634 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -16,7 +16,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/host1x_context_bus.h>
+#include <linux/context_bus.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
@@ -173,8 +173,8 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_FSL_MC_BUS
 	&fsl_mc_bus_type,
 #endif
-#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
-	&host1x_context_device_bus_type,
+#ifdef CONFIG_CONTEXT_DEVICE_BUS
+	&context_device_bus_type,
 #endif
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,

-- 
2.34.1


