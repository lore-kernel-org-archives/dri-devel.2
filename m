Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B948CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E013310EB19;
	Mon, 28 Sep 2026 16:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YiC4PkVm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F44B10EB17
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:22:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4755F6020A;
 Mon, 28 Sep 2026 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD181F00893;
 Mon, 28 Sep 2026 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790612547;
 bh=Q5MpRCgTyniKRzdF9ICN9in07rWUgFaKPM6STdE8jZA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YiC4PkVmGQfMTuBWtLz+SJF4957bZ3Q5QVjzOC9WciNS/zJULMF9OEtRUVt7jnYW9
 kHbiBQkm+MuTvevs/ATg8A+t1V4r9+G1klrVQXtf/gJqHn8oRLNGaDIz2Tt/6b3BZY
 Ss67BnwGSHB/pfLW1zGoSE/ea7n6obyKIsE3QIORwmyTMZPzOEr9q63TdgP3hF2TrX
 P/dtQfF9yzse9b7Rg32hDdcFFls6zjY9fm9MPeIY2Z6m135bf6cZn15dME1mzQJtX2
 wUXWHfLJ0h1JmBb9FOT5VvT/Wqdm1UoqJxGLkvcjyUF/2ntoX+AhmWdUNih/wqCLoZ
 d3ZkSKzms2RrQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 28 Sep 2026 18:22:03 +0200
Subject: [PATCH 3/6] drm/panel: dsi-bpf: Add BPF program build
 infrastructure and helper header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Maxime Ripard <mripard@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10491; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0S4CEFoEPYSCmsmU59aYS4gRg8Rrk0Sq5MBvVQtYuis=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm7phiFNZ/3Sf8gyMxoGWsRbv2JIdhB7Ois/mZFt8W/3
 ZsSbuV2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlMrGZs+NxXmHPwhv/6jDOS
 Kioajp9XXDFW99cMmVWd6Ja65NmhxLwFK2fa8Z6W2ZE+0zpN3l6Ssc5eNbeKoSi3YWULc1uB+96
 ul9u7Rdi2f0hou8AyIfjbhJfX5GY6CkT7NT+vfPLmwLM2PQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Add the BPF-side header panel-bpf-mipi-dsi.h and a standalone
Makefile for building panel BPF programs. The header provides
section name macros (PANEL_BPF_MIPI_DSI_PREPARE, etc.), the
PANEL_BPF_MIPI_DSI_OPS() struct_ops declaration macro, extern
declarations for all the kfuncs, and some convenience macros.

The Makefile follows the same pattern as drivers/hid/bpf/progs/.
It generates vmlinux.h from BTF, bootstraps bpftool and libbpf
from the kernel tools/ directory, then compiles every *.bpf.c
file into a stripped .bpf.o object. The resulting objects are
userspace artifacts loaded at runtime.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/panel/bpf/progs/Makefile           | 93 +++++++++++++++++++++
 .../gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h   | 95 ++++++++++++++++++++++
 include/drm/drm_panel_dsi_bpf.h                    | 50 ------------
 3 files changed, 188 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/panel/bpf/progs/Makefile b/drivers/gpu/drm/panel/bpf/progs/Makefile
new file mode 100644
index 000000000000..74190ee618ab
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/progs/Makefile
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0
+OUTPUT := .output
+abs_out := $(abspath $(OUTPUT))
+
+CLANG ?= clang
+LLC ?= llc
+LLVM_STRIP ?= llvm-strip
+
+TOOLS_PATH := $(abspath ../../../../../../tools)
+BPFTOOL_SRC := $(TOOLS_PATH)/bpf/bpftool
+BPFTOOL_OUTPUT := $(abs_out)/bpftool
+DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+LIBBPF_SRC := $(TOOLS_PATH)/lib/bpf
+LIBBPF_OUTPUT := $(abs_out)/libbpf
+LIBBPF_DESTDIR := $(LIBBPF_OUTPUT)
+LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)/include
+BPFOBJ := $(LIBBPF_OUTPUT)/libbpf.a
+
+INCLUDES := -I$(OUTPUT) -I$(LIBBPF_INCLUDE) -I$(TOOLS_PATH)/include/uapi
+CFLAGS := -g -Wall
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../../../../vmlinux				\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q = @
+msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
+MAKEFLAGS += --no-print-directory
+submake_extras := feature_display=0
+endif
+
+.DELETE_ON_ERROR:
+
+.PHONY: all clean
+
+SOURCES = $(wildcard *.bpf.c)
+TARGETS = $(SOURCES:.bpf.c=.bpf.o)
+
+all: $(TARGETS)
+
+clean:
+	$(call msg,CLEAN)
+	$(Q)rm -rf $(OUTPUT) $(TARGETS)
+
+%.bpf.o: %.bpf.c vmlinux.h $(BPFOBJ) | $(OUTPUT)
+	$(call msg,BPF,$@)
+	$(Q)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(INCLUDES)		\
+		     -Wno-microsoft-anon-tag					\
+		     -fms-extensions						\
+		     -c $(filter %.c,$^) -o $@ &&				\
+	$(LLVM_STRIP) -g $@
+
+vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(OUTPUT) $(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
+	$(call msg,MKDIR,$@)
+	$(Q)mkdir -p $@
+
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
+		    OUTPUT=$(abspath $(dir $@))/ prefix=		       \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(abspath $@) install_headers
+
+ifeq ($(CROSS_COMPILE),)
+$(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
+		    OUTPUT=$(BPFTOOL_OUTPUT)/				       \
+		    LIBBPF_BOOTSTRAP_OUTPUT=$(LIBBPF_OUTPUT)/		       \
+		    LIBBPF_BOOTSTRAP_DESTDIR=$(LIBBPF_DESTDIR)/ bootstrap
+else
+$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
+		    OUTPUT=$(BPFTOOL_OUTPUT)/ bootstrap
+endif
diff --git a/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h b/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
new file mode 100644
index 000000000000..e2b03afef2c8
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ____PANEL_BPF_MIPI_DSI_BPF__H
+#define ____PANEL_BPF_MIPI_DSI_BPF__H
+
+#define PANEL_BPF_MIPI_DSI_PREPARE	"struct_ops.s/panel_prepare"
+#define PANEL_BPF_MIPI_DSI_UNPREPARE	"struct_ops.s/panel_unprepare"
+#define PANEL_BPF_MIPI_DSI_ENABLE	"struct_ops.s/panel_enable"
+#define PANEL_BPF_MIPI_DSI_DISABLE	"struct_ops.s/panel_disable"
+
+#define PANEL_BPF_MIPI_DSI_OPS(name) SEC(".struct_ops") \
+	struct drm_panel_dsi_bpf_ops name
+
+/* Mode flags — kernel #defines not exported through BTF */
+#define MIPI_DSI_MODE_VIDEO		(1 << 0)
+#define MIPI_DSI_MODE_VIDEO_BURST	(1 << 1)
+#define MIPI_DSI_MODE_VIDEO_SYNC_PULSE	(1 << 2)
+#define MIPI_DSI_MODE_NO_EOT_PACKET	(1 << 9)
+#define MIPI_DSI_CLOCK_NON_CONTINUOUS	(1 << 10)
+#define MIPI_DSI_MODE_LPM		(1 << 11)
+
+extern int panel_bpf_mipi_dsi_regulator_enable_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+							enum panel_bpf_mipi_dsi_supply supply,
+							__u32 settle_ms) __ksym;
+extern int panel_bpf_mipi_dsi_regulator_disable(struct panel_bpf_mipi_dsi_ctx *ctx,
+						enum panel_bpf_mipi_dsi_supply supply) __ksym;
+extern void panel_bpf_mipi_dsi_gpio_cycle_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+						   enum panel_bpf_mipi_dsi_gpio gpio,
+						   __u32 assert_ms,
+						   __u32 settle_ms) __ksym;
+extern void panel_bpf_mipi_dsi_gpio_enable(struct panel_bpf_mipi_dsi_ctx *ctx,
+					   enum panel_bpf_mipi_dsi_gpio gpio) __ksym;
+extern void panel_bpf_mipi_dsi_gpio_disable(struct panel_bpf_mipi_dsi_ctx *ctx,
+					   enum panel_bpf_mipi_dsi_gpio gpio) __ksym;
+extern int panel_bpf_mipi_dsi_dcs_write_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+						  __u8 cmd, const __u8 *data,
+						  __u32 data__sz,
+						  __u32 settle_ms) __ksym;
+extern int panel_bpf_mipi_dsi_generic_write_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+						     const __u8 *data,
+						     __u32 data__sz,
+						     __u32 settle_ms) __ksym;
+extern int panel_bpf_mipi_dsi_dcs_read(struct panel_bpf_mipi_dsi_ctx *ctx,
+				       __u8 cmd, __u8 *data,
+				       __u32 data__sz) __ksym;
+
+/*
+ * Convenience macros
+ *
+ * These wrap the _and_wait kfuncs with settle_ms = 0 for the common
+ * case where no post-operation delay is needed.
+ */
+
+/* Enable a supply without a post-enable delay. */
+#define panel_bpf_mipi_dsi_regulator_enable(ctx, supply)			\
+	panel_bpf_mipi_dsi_regulator_enable_and_wait((ctx), (supply), 0)
+
+/* Send a DCS command without a post-send delay. */
+#define panel_bpf_mipi_dsi_dcs_write(ctx, cmd, data, data__sz)		\
+	panel_bpf_mipi_dsi_dcs_write_and_wait((ctx), (cmd), (data), (data__sz), 0)
+
+/* Send a generic DSI write without a post-send delay. */
+#define panel_bpf_mipi_dsi_generic_write(ctx, data, data__sz)		\
+	panel_bpf_mipi_dsi_generic_write_and_wait((ctx), (data), (data__sz), 0)
+
+/* Send a DCS command with a single byte payload. */
+#define panel_bpf_mipi_dsi_dcs_write_byte(ctx, cmd, val)		\
+	do {								\
+		const __u8 _v = (val);					\
+		panel_bpf_mipi_dsi_dcs_write((ctx), (cmd), &_v, 1);	\
+	} while (0)
+
+/*
+ * Standard DCS command helpers
+ *
+ * exit_sleep_mode and enter_sleep_mode include the 120ms delay
+ * required by the MIPI DCS specification before the next command.
+ */
+
+/* Send MIPI_DCS_EXIT_SLEEP_MODE with a 120ms settling delay. */
+#define panel_bpf_mipi_dsi_exit_sleep_mode(ctx)				\
+	panel_bpf_mipi_dsi_dcs_write_and_wait((ctx), MIPI_DCS_EXIT_SLEEP_MODE, NULL, 0, 120)
+
+/* Send MIPI_DCS_ENTER_SLEEP_MODE with a 120ms settling delay. */
+#define panel_bpf_mipi_dsi_enter_sleep_mode(ctx)			\
+	panel_bpf_mipi_dsi_dcs_write_and_wait((ctx), MIPI_DCS_ENTER_SLEEP_MODE, NULL, 0, 120)
+
+/* Send MIPI_DCS_SET_DISPLAY_ON. */
+#define panel_bpf_mipi_dsi_set_display_on(ctx)				\
+	panel_bpf_mipi_dsi_dcs_write((ctx), MIPI_DCS_SET_DISPLAY_ON, NULL, 0)
+
+/* Send MIPI_DCS_SET_DISPLAY_OFF. */
+#define panel_bpf_mipi_dsi_set_display_off(ctx)				\
+	panel_bpf_mipi_dsi_dcs_write((ctx), MIPI_DCS_SET_DISPLAY_OFF, NULL, 0)
+
+#endif /* ____PANEL_BPF_MIPI_DSI_BPF__H */
diff --git a/include/drm/drm_panel_dsi_bpf.h b/include/drm/drm_panel_dsi_bpf.h
deleted file mode 100644
index 02d4707fd0a0..000000000000
--- a/include/drm/drm_panel_dsi_bpf.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DRM_PANEL_DSI_BPF_H__
-#define __DRM_PANEL_DSI_BPF_H__
-
-#include <linux/bpf.h>
-
-struct mipi_dsi_device;
-struct drm_panel;
-
-#define DSI_BPF_PANEL_ID_LEN	64
-
-/**
- * struct dsi_bpf_ctx - Context passed to BPF panel programs
- * @panel: The drm_panel this callback operates on (private)
- */
-struct dsi_bpf_ctx {
-	struct drm_panel *panel;
-};
-
-/**
- * struct drm_panel_dsi_bpf_ops - BPF struct_ops for MIPI-DSI panels
- * @panel_id: Device identifier for matching. On DT systems this holds
- *	the panel's compatible string. Firmware-agnostic to allow future
- *	ACPI support. Written before load, immutable after.
- * @panel_prepare: Called to power on the panel and send init commands.
- *	Must enable regulators, toggle GPIOs, and send the DSI init
- *	sequence. Sleepable.
- * @panel_unprepare: Called to power off the panel. Must send shutdown
- *	commands, assert reset, and disable regulators. Sleepable.
- * @panel_enable: Optional. Called after video stream starts, for panels
- *	that need post-video-start DSI commands. Sleepable.
- * @panel_disable: Optional. Called before video stream stops. Sleepable.
- * @set_brightness: Optional. Called to set backlight brightness via DSI
- *	commands. Sleepable.
- */
-struct drm_panel_dsi_bpf_ops {
-	char			panel_id[DSI_BPF_PANEL_ID_LEN];
-
-	/* private: internal bookkeeping */
-	struct drm_panel	*panel;
-
-	/* public: */
-	int (*panel_prepare)(struct dsi_bpf_ctx *ctx);
-	int (*panel_unprepare)(struct dsi_bpf_ctx *ctx);
-	int (*panel_enable)(struct dsi_bpf_ctx *ctx);
-	int (*panel_disable)(struct dsi_bpf_ctx *ctx);
-	int (*set_brightness)(struct dsi_bpf_ctx *ctx, u32 brightness);
-};
-
-#endif /* __DRM_PANEL_DSI_BPF_H__ */

-- 
2.55.0

