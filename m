Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FEEF9D0DA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB41410E628;
	Tue, 14 Apr 2026 16:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sl23EOQO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46D610E628
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 97DF043C16;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB9AC2BCB5;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776184280;
 bh=Xcje/jed8ZwOn7gRcR4WUVa/XkNJGc5sFLasaQZsHEo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Sl23EOQOrOUSm+TNf/WDDX6GJXmyjo1lPHEAT2oe79CFibRS8Al27zKKghKKgz5sS
 jb2Dk9Fj0VLuMBnKB+h3nMed+ZqCj5buBgv1R3fbASvUAhqVvTsy1E5XxsUVpEkMQ7
 O+9+a+gF4Dxf/PhWz4Tuwv1aJo0bDQDxrcfKV+oQyugQltQYmfPE2EU+3WptXIWmE6
 rK53tfASjizMPyrovDO6BY8C3RFTqFHbcktC5jpXvct6jh1dsnZVpnTUPjo7Bmz5N0
 h1dX63c6DcVK+V8mY7Hl/+qKq/bzhUjXJXjDoqZYM1dr98LX9/7RuzswlOChPoyXzU
 JrROHtlfrym9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5D462F9D0E7;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
From: Ekansh Gupta via B4 Relay
 <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Date: Tue, 14 Apr 2026 22:01:15 +0530
Subject: [PATCH 1/3] drivers: base: Add generic context device bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776184278; l=3013;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=GiaW9KX6EnyHl15uXUaLI85Eugyx6gIsQQrGnKwyVVk=;
 b=g7ZvTKbHA9UTo3rRc56oQRClDN77YoCoOIyf0Ch0pvK4S/d5lszMPmM5fNmU56g6YpXEOAu9x
 J6BS+tcG340ACkYknZbhTqxrn/ex62ByFElTbD0dzk54v75d4aqeryz
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

Introduce a new generic bus type for synthetic context bank devices
that require IOMMU context isolation. This bus provides a shared
infrastructure for accelerator and GPU drivers that create virtual
devices representing IOMMU context banks.

Currently, drivers like host1x implement their own bus types for
context devices. This generic implementation allows multiple drivers
to share the same bus infrastructure, simplifying the IOMMU subsystem
integration and reducing code duplication.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/base/Kconfig        |  3 +++
 drivers/base/Makefile       |  1 +
 drivers/base/context_bus.c  | 24 ++++++++++++++++++++++++
 include/linux/context_bus.h | 15 +++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f7d385cbd3ba..479bc4bb442b 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -4,6 +4,9 @@ menu "Generic Driver Options"
 config AUXILIARY_BUS
 	bool
 
+config CONTEXT_DEVICE_BUS
+	bool
+
 config UEVENT_HELPER
 	bool "Support for uevent helper"
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..ab9a0b2dc73b 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -8,6 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   swnode.o faux.o
 obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
+obj-$(CONFIG_CONTEXT_DEVICE_BUS) += context_bus.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/drivers/base/context_bus.c b/drivers/base/context_bus.c
new file mode 100644
index 000000000000..6ddb6c27bf69
--- /dev/null
+++ b/drivers/base/context_bus.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+#include <linux/context_bus.h>
+#include <linux/init.h>
+
+const struct bus_type context_device_bus_type = {
+	.name = "context-device",
+};
+EXPORT_SYMBOL_GPL(context_device_bus_type);
+
+static int __init context_device_bus_init(void)
+{
+	int err;
+
+	err = bus_register(&context_device_bus_type);
+	if (err < 0) {
+		pr_err("context-device bus registration failed: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+postcore_initcall(context_device_bus_init);
diff --git a/include/linux/context_bus.h b/include/linux/context_bus.h
new file mode 100644
index 000000000000..0cd44cb5b147
--- /dev/null
+++ b/include/linux/context_bus.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __LINUX_CONTEXT_BUS_H
+#define __LINUX_CONTEXT_BUS_H
+
+#include <linux/device.h>
+
+#ifdef CONFIG_CONTEXT_DEVICE_BUS
+extern const struct bus_type context_device_bus_type;
+#endif
+
+#endif /* __LINUX_CONTEXT_BUS_H */

-- 
2.34.1


