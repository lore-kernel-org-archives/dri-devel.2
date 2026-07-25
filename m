Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CBBC54F4C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A814710E2FB;
	Mon, 27 Jul 2026 07:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qt271UWY";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BEA10F4D3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:18:50 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca7d1dc4554so538600a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949530; x=1785554330; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62YcKoWbwf7Xh2pmJjiLRuJIzfIQtFYxUsfYj2T/BQY=;
 b=Qt271UWYGEVk9NMmEkWf/PhcukfLC6koUWkS9KMG4GY8WSiz1ewy9a1sV3DcKCIbDa
 C16nY9tA+ML2KjrF44OdlUAtt4UVEJ0CJrmK7E8HQETN+hT3uI4eg/LupGt6PB91kjGk
 PePnl4NeJGCMKAjogvfVD63M3ZzO3rJg/TKOqe1IVSqYz4imnr5LhrlzDI3cZpq5aNbP
 ohL9KWdw6lULsyVU8lT5/01Lp9jEie3E1qcxtKvi5xEpHTpd6hXa4zO7VjFIxDkkIxZM
 1y6W8nxVE5fdFJ4OcduV29St5CO04C0Iz8sPNn0s+npS1RAdF+x/6KV1zaJucreJz7x/
 1b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949530; x=1785554330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=62YcKoWbwf7Xh2pmJjiLRuJIzfIQtFYxUsfYj2T/BQY=;
 b=ARh6YGPkCBVPkP1uAsCZ2KBDa44AsRsKgLlMXb7t1Cg12NqZXSrRDuVoFqVM1658wb
 r2c3QC2KYmTzUeBEIhtek2zdkcOEnASVjv8ZnbF5O1J6m5MkaC6I0GfAVuqwwyuS1vjK
 cx985y6Dc0yYRFR11C/S3j3E+QYIxwYzKbHWNUfBU+jx63oAGHaHuUGnQ09nyRKxXi2V
 y48yskKcGMKfAJjUUS/3ebdqmPp3n6sTjvWsRNqpvkUyonXDojipXjVoRqsMiC58Co9K
 a2jQuvSNfxSrK5QkoLOqs76PUfs7gV1mrYcz5mtrHFEcioxttW8Q8oKGT5MzLf0lS4Pl
 UxRQ==
X-Gm-Message-State: AOJu0YzB+5M4TUoxQkVMRTve0jfkrIKEcjOPXc692PuYC3nlEDwK9PFn
 U2VXN9zQ/NQIiw6i4189o/kQHyf7S5pkAUnki/I1DyMgM06VP3JWFzLF
X-Gm-Gg: AR+sD13a4vu/BTW+Hb8xcPDHihDHFOtgb/KNQ48KS24csjoNqz3atrre+UO54pWbgyB
 SeqE1kbAGp5gLvdtkFvBzH5/UpKyomB7Cz9d2GXQIOo55wycB+2qCGJB7mLKySQv2S+il/loC/Z
 ODTT9VIHs4pJrOwZDm0AGw2QQWcoR+UyWCjSG9MfZ4rikbw2eIPm5+/K3IlrdcE9jfyACrpKW1W
 bCbZpPr+2nJLf+KsT2y3VqPjVnYTKRuKqId2zMTLHKcuLg7vaHI/Rosp6hAWAngCCXblElp1hhZ
 44C+xcAl7hn18hcx9C3LSucxoTeMkrTO/VL2EO8ZiDztJ/rDZBmCmqFxnOYcW7eBQZ1DrKlTgvb
 U2b1u3lqMNFqnzHKDMmSXTaMZuYC3M248+qjY5x13HtWMHuszL4zzroM=
X-Received: by 2002:a05:6a00:4291:b0:84e:1a34:2470 with SMTP id
 d2e1a72fcca58-84e5949a18bmr638140b3a.30.1784949529988; 
 Fri, 24 Jul 2026 20:18:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:18:48 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:43 -0400
Subject: [PATCH 11/17] drm/spacemit: add Saturn DPU DRM device driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-11-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Add the DRM device for the SpacemiT K3 Saturn display processing unit
and hook the driver up to the build. The SoC has two DPU instances;
each drives one CRTC that scans out a single primary plane in linear
RGB at up to 3840x2160@60 and feeds a downstream DP/eDP controller
over an OF-graph endpoint. Buffers use drm_gem_shmem_helper. The
AFBC/compressed decode path is not exposed and writeback is not
implemented.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 drivers/gpu/drm/Kconfig                 |   1 +
 drivers/gpu/drm/Makefile                |   1 +
 drivers/gpu/drm/spacemit/Kconfig        |  18 +++++
 drivers/gpu/drm/spacemit/Makefile       |  12 +++
 drivers/gpu/drm/spacemit/spacemit_drm.c | 132 ++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f..81081562a6da 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -341,6 +341,7 @@ source "drivers/gpu/drm/renesas/Kconfig"
 source "drivers/gpu/drm/rockchip/Kconfig"
 source "drivers/gpu/drm/sitronix/Kconfig"
 source "drivers/gpu/drm/solomon/Kconfig"
+source "drivers/gpu/drm/spacemit/Kconfig"
 source "drivers/gpu/drm/sprd/Kconfig"
 source "drivers/gpu/drm/sti/Kconfig"
 source "drivers/gpu/drm/stm/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..4a105520ee91 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -204,6 +204,7 @@ obj-$(CONFIG_DRM_MSM) += msm/
 obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-$(CONFIG_DRM_STM) += stm/
 obj-$(CONFIG_DRM_STI) += sti/
+obj-$(CONFIG_DRM_SPACEMIT) += spacemit/
 obj-y 			+= imx/
 obj-$(CONFIG_DRM_INGENIC) += ingenic/
 obj-$(CONFIG_DRM_LOGICVC) += logicvc/
diff --git a/drivers/gpu/drm/spacemit/Kconfig b/drivers/gpu/drm/spacemit/Kconfig
new file mode 100644
index 000000000000..51e38dabfdba
--- /dev/null
+++ b/drivers/gpu/drm/spacemit/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DRM_SPACEMIT
+	tristate "DRM support for SpacemiT display controllers"
+	depends on DRM && OF && MMU
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select DRM_CLIENT_SELECTION
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	select REGMAP_MMIO
+	select VIDEOMODE_HELPERS
+	help
+	  Choose this option if you have a SpacemiT SoC with the Saturn
+	  display processing unit, such as the K3. The DPU scans out
+	  framebuffers through its private display MMU and feeds a
+	  DisplayPort or embedded DisplayPort controller.
+
+	  If M is selected the module will be called spacemit-drm.
diff --git a/drivers/gpu/drm/spacemit/Makefile b/drivers/gpu/drm/spacemit/Makefile
new file mode 100644
index 000000000000..b3b148000cf7
--- /dev/null
+++ b/drivers/gpu/drm/spacemit/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+spacemit-drm-y := spacemit_drm.o \
+		  spacemit_crtc.o \
+		  spacemit_cmdlist.o \
+		  spacemit_planes.o \
+		  spacemit_dmmu.o \
+		  dpu/dpu_saturn.o \
+		  dpu/dpu_saturn_hee.o \
+		  dpu/saturn_fbcmem.o
+
+obj-$(CONFIG_DRM_SPACEMIT) += spacemit-drm.o
diff --git a/drivers/gpu/drm/spacemit/spacemit_drm.c b/drivers/gpu/drm/spacemit/spacemit_drm.c
new file mode 100644
index 000000000000..9fb6a7661b48
--- /dev/null
+++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
+ *
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_of.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <linux/component.h>
+#include <linux/of_graph.h>
+
+#include "spacemit_drm.h"
+#include "spacemit_crtc.h"
+
+#define DRIVER_NAME	"spacemit"
+#define DRIVER_DESC	"SpacemiT SoC DRM driver"
+#define DRIVER_MAJOR	1
+#define DRIVER_MINOR	0
+
+static void spacemit_drm_atomic_commit_tail(struct drm_atomic_commit *old_state)
+{
+	struct drm_device *dev = old_state->dev;
+
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+
+	drm_atomic_helper_wait_for_flip_done(dev, old_state);
+
+	drm_atomic_helper_commit_hw_done(old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+}
+
+static const struct drm_mode_config_helper_funcs spacemit_drm_mode_config_helper = {
+	.atomic_commit_tail = spacemit_drm_atomic_commit_tail,
+};
+
+static const struct drm_mode_config_funcs spacemit_drm_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+int spacemit_drm_mode_config_init(struct drm_device *drm)
+{
+	int ret;
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	drm->mode_config.min_width = 1;
+	drm->mode_config.min_height = 1;
+	/* K3 user manual: each DPU scans out at most 3840x2160@60 */
+	drm->mode_config.max_width = 3840;
+	drm->mode_config.max_height = 2160;
+
+	drm->mode_config.funcs = &spacemit_drm_mode_config_funcs;
+	drm->mode_config.helper_private = &spacemit_drm_mode_config_helper;
+
+	return 0;
+}
+
+DEFINE_DRM_GEM_FOPS(spacemit_drm_fops);
+
+struct drm_driver spacemit_drm_drv = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops = &spacemit_drm_fops,
+
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+
+	.name		= DRIVER_NAME,
+	.desc		= DRIVER_DESC,
+	.major		= DRIVER_MAJOR,
+	.minor		= DRIVER_MINOR,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+int spacemit_drm_of_component_probe(struct device *dev)
+{
+	struct device_node *ports, *port, *ep;
+	struct device_node *remote;
+	struct component_match *match = NULL;
+
+	if (!dev->of_node)
+		return -EINVAL;
+
+	/* The DPU is the drm root: its OF graph names the DP/eDP components. */
+	ports = of_get_child_by_name(dev->of_node, "ports");
+	if (!ports) {
+		dev_err(dev, "missing 'ports' child node\n");
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(ports, port) {
+		if (!of_node_name_eq(port, "port"))
+			continue;
+		for_each_child_of_node(port, ep) {
+			if (!of_node_name_eq(ep, "endpoint"))
+				continue;
+			remote = of_graph_get_remote_port_parent(ep);
+			if (!remote)
+				continue;
+			if (of_device_is_available(remote))
+				drm_of_component_match_add(dev, &match,
+							   compare_of, remote);
+			of_node_put(remote);
+		}
+	}
+	of_node_put(ports);
+
+	if (!match) {
+		dev_err(dev, "no downstream component available\n");
+		return -ENODEV;
+	}
+
+	return component_master_add_with_match(dev, &spacemit_drm_master_ops,
+					       match);
+}

-- 
2.43.0

