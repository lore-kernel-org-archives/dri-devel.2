Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B7606A682
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMFL/0Ej
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F9D10E2C3;
	Sat, 21 Nov 2026 07:41:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6399710E2ED
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AD6D44F0B;
 Sat, 21 Nov 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795246866;
 b=RWfWAQfrYyWsdAQan56l94WugDpcxvtlRbfWSIqPJwxMnSvLhy3jzlCl/ucPsQVWzDan
 qCXe3v5QjG1yF8P5aFaOu3iH4x42D0eIiZficb6ocqFohufgo8Al8AeZJzJpa7u7MM1Dm
 UAqK6T9M+LPrWBHToeQ17KGs4qN7khiWN0YFqP8Vg9lbVP/WvzWm7P9aN5Fo6jRc6eRA4
 /vmuH3GWED65+qTChSki3gSoUKJYHLBH6R3J2iMNMKvaKPVEtp3ebkHzyc2kQthnlMfsi
 lJmsELugYGSEMZ//RDU32gwpt/g/prKFtJAxl2N4/NeFJ7V93MgMEt9AzSLIoi1DOeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795246866;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=FuEqkaJbijoHfO5kZ4c3Ea8x3lze+19mWnFDMr9NUiY=;
 b=cbGdKka6xWlH9lPaA2beNirqW8cboIeqjmQqLvftCx6b4qCbJPgG6ZK63P6aiMOTXhpM
 wNfj7Q6WCv6l5nJLTGZAUIfjrNWor2BuWOGc+1/QZG86yh+GTewOD6UawWFC1eAiBzqQ3
 AqbEuwfXr8Vhc9GxlmlAwz3ob19LWEaaJPSz92qjTwLgG4qFxIq0s4XJSSVg1uWJKSpBZ
 UXvertdhucJtcTn8SjqLJ9NzeoOJulAW6umMtoibqiIi3rB3giKAhk85jiqbr33kUnumu
 q0nT2fVFLmGv/zyojBHvcFyPwr/Xmk35l7Qy0dObkCjXrA3OqmFnxPXr3B9dGXsRdzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EB1871F000EC;
 Sat, 21 Nov 2026 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795246866;
 bh=FuEqkaJbijoHfO5kZ4c3Ea8x3lze+19mWnFDMr9NUiY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=aMFL/0EjRaguQsysKMvEozyAsrrPlYtiAv1nnCa7dGdHKKVyBADSr0eISLD6tyqgr
 CTIAx9m4U2mvlXo8kDEltRp9ZHqW3JVdnd69m+rwxORzltIjbD+l5yyN+AablTcEeo
 LH3m+a0uUcP2sQcowSF3mcOrrO/8w5b0Iu8Q8iANzyKHA3PN7QkoYJteqIEwBDuBn1
 onriS5FmXd3knjf1JQ+qlUxhceqwFCXug/KRnkxyTTYeQuV29rJ7XqHLOwwSuMwjjc
 eJocHOhN+l11Lc0AGpLDf+bnAAUQFI+zabXBA9d3iS8GYLAtGHYVopnkxhyuRuvhl7
 qwKI9Fi6tRwwA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8E6234BB74;
 Sat, 21 Nov 2026 07:40:51 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:40:50 +0800
Subject: [PATCH v3 11/17] drm/spacemit: add Saturn DPU DRM device driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-k3-display-v3-11-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
In-Reply-To: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795246844; l=10267;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=1LLB7ck/Lz0FSwwHejBfJ5Pj0yWwrzMJKJvxXMU6xuA=;
 b=9pYbXeciEjnf32sOqi+9dGMRyDmcoK6SIxZwf0R30SQFjCQ44DnEjZEP5Q3MK2L0pESnh8HS8
 VQAgAs+DSTCA/BuZ4Du4RHS6JCsQfxQVPZdJOwc2ssrrYZhsc9m1nVH
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: codykang.hk@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cody Kang <codykang@vsit.ai>

Add the DRM device for the SpacemiT K3 Saturn display processing unit
and hook the driver up to the build. The SoC has two DPU instances;
each drives one CRTC that scans out a single primary plane in linear
RGB at up to 3840x2160@60 and feeds a downstream DP/eDP controller
over an OF-graph endpoint. Buffers use drm_gem_shmem_helper. The
AFBC/compressed decode path is not exposed and writeback is not
implemented.

The write-combining mapping of the scanout buffers is from Sarah Emery
<sarah.emery@canonical.com>.

Signed-off-by: Cody Kang <codykang@vsit.ai>

---
v3:
- map scanout buffers write-combining (Sarah Emery); build the sg table
  when a dumb buffer is created, so the zeroes it was cleared with are
  written back before anything is drawn
- bound framebuffers by what the RDMA registers can address instead of
  by the largest mode (Icenowy Zheng)
- stop the component match loop on the first error; depend on PM
- add a GEM object wrapper carrying the display MMU table (Thomas
  Zimmermann)
v2:
- check for an ERR_PTR component match before
  component_master_add_with_match() (Sashiko)
- add a comment explaining why commit_tail waits for flip_done before
  commit_hw_done (Sashiko)
---
 drivers/gpu/drm/Kconfig                 |   1 +
 drivers/gpu/drm/Makefile                |   1 +
 drivers/gpu/drm/spacemit/Kconfig        |  18 +++
 drivers/gpu/drm/spacemit/Makefile       |  12 ++
 drivers/gpu/drm/spacemit/spacemit_drm.c | 204 ++++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c65..76abdfb25dc44 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -345,6 +345,7 @@ source "drivers/gpu/drm/renesas/Kconfig"
 source "drivers/gpu/drm/rockchip/Kconfig"
 source "drivers/gpu/drm/sitronix/Kconfig"
 source "drivers/gpu/drm/solomon/Kconfig"
+source "drivers/gpu/drm/spacemit/Kconfig"
 source "drivers/gpu/drm/sprd/Kconfig"
 source "drivers/gpu/drm/sti/Kconfig"
 source "drivers/gpu/drm/stm/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923a..d0ef32d224382 100644
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
index 0000000000000..8326a7b98151a
--- /dev/null
+++ b/drivers/gpu/drm/spacemit/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DRM_SPACEMIT
+	tristate "DRM support for SpacemiT display controllers"
+	depends on DRM && OF && MMU
+	depends on PM
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select DRM_CLIENT_SELECTION
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	select REGMAP_MMIO
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
index 0000000000000..eb3cb5e302556
--- /dev/null
+++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
+ *
+ */
+
+#include <linux/component.h>
+#include <linux/of_graph.h>
+#include <linux/slab.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_dumb_buffers.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_of.h>
+
+#include "spacemit_crtc.h"
+#include "spacemit_dmmu.h"
+#include "spacemit_drm.h"
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
+	/*
+	 * Enables before planes, and planes on active CRTCs only: the DPU is
+	 * powered from atomic_enable to atomic_disable.
+	 */
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+
+	/*
+	 * Flip first, hw_done second: each channel has two command lists
+	 * written alternately, and the engine may re-read the previous one
+	 * until the next CFG_RDY has been consumed. Holding the next commit
+	 * back until this one's vblank keeps it from rewriting a list still
+	 * in use.
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
+	/*
+	 * Framebuffer bounds come from the RDMA register widths: a 16-bit
+	 * byte stride (16383 pixels at 32 bpp) and 16-bit image dimensions.
+	 * The 3840x2160 output limit is enforced per CRTC in mode_valid.
+	 */
+	drm->mode_config.max_width = SPACEMIT_DPU_MAX_FB_WIDTH;
+	drm->mode_config.max_height = SPACEMIT_DPU_MAX_FB_HEIGHT;
+
+	drm->mode_config.funcs = &spacemit_drm_mode_config_funcs;
+	drm->mode_config.helper_private = &spacemit_drm_mode_config_helper;
+
+	return 0;
+}
+
+static void spacemit_gem_free(struct drm_gem_object *obj)
+{
+	spacemit_dmmu_release(obj);
+	drm_gem_shmem_free(to_drm_gem_shmem_obj(obj));
+}
+
+/* drm_gem_shmem_funcs with a free that also drops the DMMU table. */
+static const struct drm_gem_object_funcs spacemit_gem_funcs = {
+	.free = spacemit_gem_free,
+	.print_info = drm_gem_shmem_object_print_info,
+	.pin = drm_gem_shmem_object_pin,
+	.unpin = drm_gem_shmem_object_unpin,
+	.get_sg_table = drm_gem_shmem_object_get_sg_table,
+	.vmap = drm_gem_shmem_object_vmap,
+	.vunmap = drm_gem_shmem_object_vunmap,
+	.mmap = drm_gem_shmem_object_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
+};
+
+static struct drm_gem_object *spacemit_gem_create_object(struct drm_device *drm,
+							 size_t size)
+{
+	struct spacemit_gem_object *sgem;
+
+	sgem = kzalloc_obj(*sgem);
+	if (!sgem)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&sgem->tbl_lock);
+	sgem->base.map_wc = true;
+	sgem->base.base.funcs = &spacemit_gem_funcs;
+
+	return &sgem->base.base;
+}
+
+/*
+ * A new buffer's pages are cleared through the cached linear map, while
+ * everything drawn afterwards goes through a write-combining mapping. Build
+ * the sg table now: mapping it writes the cached zeroes back before anything
+ * is drawn. Left to the first scanout, they would land on top of the picture.
+ */
+static int spacemit_gem_dumb_create(struct drm_file *file,
+				    struct drm_device *drm,
+				    struct drm_mode_create_dumb *args)
+{
+	struct drm_gem_shmem_object *shmem;
+	struct sg_table *sgt;
+	int ret;
+
+	ret = drm_mode_size_dumb(drm, args, 0, 0);
+	if (ret)
+		return ret;
+
+	shmem = drm_gem_shmem_create(drm, args->size);
+	if (IS_ERR(shmem))
+		return PTR_ERR(shmem);
+
+	sgt = drm_gem_shmem_get_pages_sgt(shmem);
+	if (IS_ERR(sgt))
+		ret = PTR_ERR(sgt);
+	else
+		ret = drm_gem_handle_create(file, &shmem->base, &args->handle);
+
+	/* On success the handle holds the reference. */
+	drm_gem_object_put(&shmem->base);
+
+	return ret;
+}
+
+DEFINE_DRM_GEM_FOPS(spacemit_drm_fops);
+
+const struct drm_driver spacemit_drm_drv = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops = &spacemit_drm_fops,
+
+	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
+	.dumb_create = spacemit_gem_dumb_create,
+	.gem_create_object = spacemit_gem_create_object,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+
+	.name		= DRIVER_NAME,
+	.desc		= DRIVER_DESC,
+	.major		= DRIVER_MAJOR,
+	.minor		= DRIVER_MINOR,
+};
+
+int spacemit_drm_of_component_probe(struct device *dev)
+{
+	struct component_match *match = NULL;
+	struct device_node *remote, *ep;
+
+	/* The DPU is the drm root: its OF graph names the DP/eDP components. */
+	for_each_endpoint_of_node(dev->of_node, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote)
+			continue;
+		if (of_device_is_available(remote))
+			drm_of_component_match_add(dev, &match,
+						   component_compare_of,
+						   remote);
+		of_node_put(remote);
+		if (IS_ERR(match)) {
+			of_node_put(ep);
+			return PTR_ERR(match);
+		}
+	}
+
+	if (!match)
+		return dev_err_probe(dev, -ENODEV,
+				     "no downstream component available\n");
+
+	return component_master_add_with_match(dev, &spacemit_drm_master_ops,
+					       match);
+}

-- 
2.43.0


