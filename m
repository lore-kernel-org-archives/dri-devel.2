Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3871FC5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BD210E55B;
	Sun,  9 Aug 2026 13:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EGf0SEnq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A646D10E140
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:15:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A7FD44FFD;
 Sun,  9 Aug 2026 13:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB25C32781;
 Sun,  9 Aug 2026 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786281321;
 bh=qMsxM5axpV7P6hhBK4F4CHtK+A7GtEelcHxaDNxNjSU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EGf0SEnqH4/h6PdAEUV9mdr6tBqiXjwzszIfbfkZDEy5UqyTMZm0LYQOkgOLhICmm
 8P4t6SHGD5tMRfK1VlI4yydYUONUnm6AQ71vQLiC6m1GweQoADIErFqnc1nW8m7k1G
 8jQcpQoMm/ncIhf7kZrtUFOv/o9xP1/MG+8b5HOsUNxbRzuiuxfCU81uWVArRIxFX4
 Z8aNmKVlrK2GuC+k8Wwomp2h98hPH8/DcbpkuqhMn1Vtx417Z8E+HnnD1RJFBdQkWu
 m5AdUr2DU9bbUpVQaxFk8P5YaTM7sjGnXvdc60IgMasXg9dGvCy+rf9t/BU4hM45dF
 n/iHU3W+wz41w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE6DC5AD68;
 Sun,  9 Aug 2026 13:15:21 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Date: Sun, 09 Aug 2026 21:14:20 +0800
Subject: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
In-Reply-To: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
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
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786281298; l=7518;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=ziE0ziryEHAUMYSlN9Gu5ST0aqg2d2Chbg5AsNuPMzc=;
 b=/SA8B2bPhJsTzYmolp/ZAoetmXKK1CJAVos6ruEnQuTtbXdLP3uvT2iIf52cRFK86vJ12NNPy
 0Txwjfjnz9VC+VP7VcTjN4McwLiq49FyPX11yq59XNVFiwWs5EKnNW3
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
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
Reply-To: codykang.hk@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Cody Kang <codykang.hk@gmail.com>

Add the DRM device for the SpacemiT K3 Saturn display processing unit
and hook the driver up to the build. The SoC has two DPU instances;
each drives one CRTC that scans out a single primary plane in linear
RGB at up to 3840x2160@60 and feeds a downstream DP/eDP controller
over an OF-graph endpoint. Buffers use drm_gem_shmem_helper. The
AFBC/compressed decode path is not exposed and writeback is not
implemented.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>

---
v2:
- check for an ERR_PTR component match before
  component_master_add_with_match() (Sashiko)
- add a comment explaining why commit_tail waits for flip_done before
  commit_hw_done (Sashiko)
---
 drivers/gpu/drm/Kconfig                 |   1 +
 drivers/gpu/drm/Makefile                |   1 +
 drivers/gpu/drm/spacemit/Kconfig        |  18 ++++
 drivers/gpu/drm/spacemit/Makefile       |  12 +++
 drivers/gpu/drm/spacemit/spacemit_drm.c | 140 ++++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f6..81081562a6da2 100644
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
index e97faabcd7830..4a105520ee912 100644
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
index 0000000000000..51e38dabfdba5
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
index 0000000000000..b3b148000cf7b
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
index 0000000000000..12b2fe8b6fc99
--- /dev/null
+++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
@@ -0,0 +1,140 @@
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
+	/*
+	 * Flip first, hw_done second: the cmdlist engine reads the old
+	 * state's DMA buffers until the frame boundary, and hw_done both
+	 * releases the next commit to start programming and lets the old
+	 * state (with those buffers) be torn down.
+	 */
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
+	if (IS_ERR(match))
+		return PTR_ERR(match);
+
+	return component_master_add_with_match(dev, &spacemit_drm_master_ops,
+					       match);
+}

-- 
2.43.0


