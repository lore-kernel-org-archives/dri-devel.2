Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F160A380B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LeTNfj5g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF9B10E5B5;
	Fri, 23 Oct 2026 06:40:12 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F1D10E57A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:39:54 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so2962655e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737593; x=1793342393; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CxhFfAhW586ZAihTRjE9O09NR9LN2oJPMQfSaVxcH9Q=;
 b=LeTNfj5gYpdWiASZX4tjtZKxIt5wnhYy5IyeAY9IQHIsYvIqkxkHpHpI2iE7bllPbQ
 HnSbsf5Ps/SJruZkSmeTm+TPUp+TephEp/P2EdqS/4I+A5b69V2ccjOsF3oBUwGt6fGc
 vKg9E+q3MEvY7ZnwXbfPbEqmko96/BX9Leti+wGtueEo1zLB0HYE9EAF/+JmAT+CzpA5
 HxOompkuOD49TEC7oTZvVJMWaRqhGsG28shyIMuYDD3ZG6IDdPZxDMTKEPexn1tGVNa5
 SXm3cdzCUtc+bo9y1y8bNn/VARBE3D/8E4FLVudWszAI+5lLMurgppNNRhoJPhq4yaBq
 v80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737593; x=1793342393;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CxhFfAhW586ZAihTRjE9O09NR9LN2oJPMQfSaVxcH9Q=;
 b=0OZeiK73eSxCcw4Bgdt41VVu/q+k+4WQrNd7I8KdqYQTmmTaXp5RYCSzGAsy8CZM5k
 PaFU08NSaCxPa3e0+Xfa22cepPLvqlydWNlGT465RZdCtM7yMuC3HDFjRBUUebLkCTNA
 wl9LzDJf00i2os26het7KMHaH5Bq5dStEGS2ajoCoYe4TwXHLFhLwNwFiMkbaXEW4oUB
 X8VCImGR4kAAJAVdiBkEnuCGfLsqxk86nkF2G0sBbRL+mj67r2DcIQrVZTP853ZCDB8S
 HOCiG/Z55aOfgiisD5+fYyOagHYXTz4BynJQHTWEreAf3gUvH8z3kZ2x2a6gBS5L/FT1
 iHkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk4YXzOyfqi/C66nxYaLMNwe5de+CUgObwI2e8e6vsJEn0dxgk5DvyauY1NK89K6evq8QVIW3bzOY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLObhs9+DTZ+s74eISUrISYO8sepLS+DSxkJGvUQceswfhyJ71O
 iF4ax1+GSs3AOgQGeIwaMdkYxQcSo/VbLm/mSKwkX4Ap2RKsxZxzGoT9
X-Gm-Gg: AYBFou0JjYa+fMwy8XbsCrecHIloT2xBItilnrn0OoxFb4UzjWN7XjZrBHse6zsSLE8
 T/DheggWf3V0Y7+TAh8TOon8RFIAR3A5s2Hk1kXz8KIBuG8qCq4rZIHPjoxyPE8vhA/UgqCP/oI
 XNMqDda4oOfgBfBoJzHEZJ3xtdgoq5UqLT285qatdsSpxFGCv2nVYpPeQDLDbwcPRDaKwfuV3Wd
 LJbn61huo4r6BDGDzkTqfDQ5/faz2bndoovjo938qFrnZF6J6iSX++0Cm5KqMdqnjygDha1rTaD
 y69NqKccU8k1AWAttd2sZiWLrHzKNiOS1o922Q3O3bYp7CVH9gdProu2SN2huxlYyE1Oc49AtT9
 HO2IObt2U5Pigab5tVo2JzfBG8gS8m/kRhHytub60eQyi4TfbMv2K6M9hdmo2YENIuThjgOnmOq
 SfyDQPkh3wSUkdYRvmdNg1vsYFhsiwcJfkQ/EBJhRMYxjmvnyVrPJk8p2VvxNTVoFM3S/Ocxkxa
 9UUHt8/qDDirGdHm/vQfRv7Xwz8uw1MTO7LXLoPVuxoO+zAGS7l8XkLVmp7XbPW+aZtV4MorQkO
 GL0YtcUKTKkbZpdjGIzJgxVxjptAqKUUaBVwZUmy1ACeRKFDErl4FcEkuLlwZ7H5Za68zcwrkRC
 ILsFiJP1NMyllbDK0DRDVodny
X-Received: by 2002:a05:600c:8b5b:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4a211c50dd5mr19339445e9.1.1792737592585; 
 Thu, 22 Oct 2026 23:39:52 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:51 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:30 +0200
Subject: [PATCH v3 05/16] accel/thames: Add driver for the C7x DSPs in TI SoCs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-5-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some SoCs from Texas Instruments contain DSPs that can be used for
general compute tasks. This driver initially supports the C7x cores in
the J722S SoC.

It provides a DRM accel uAPI to userspace for submitting jobs to the DSP
cores and managing the input, output and intermediate memory.

This commit attaches to each DSP core that remoteproc has booted, boots
a core left offline, performs a handshake to make sure that the
firmware is recognized and reads its capabilities.

Communication with the firmware is made via shared memory and a mailbox
doorbell, and an unrecognized firmware at handshake is left alone in
case the user wants to run a different firmware on that core.

Suspend and resume is supported, by powering each core off and on resp.
and redoing the handshake.

The DSP nodes are bound by the K3 DSP remoteproc driver, so this driver
cannot bind to them. It registers one platform device of its own for
the accelerator, finds the DSP nodes by their compatible, attaches to
each core's remoteproc and links its device to each core's, so the
accelerator suspends before the cores and unbinds when they do. One
DRM device serves both cores because a Job may run on either.

The handshake is a block the firmware writes at boot: its ABI version,
the IPC address it was linked for, the L2 size, the DRU's channel count,
queue depth, channel stride, first Kernel channel and capabilities, the
ASID width, the hardware ID it was built for, its timestamp rate and
the transfer table pool's size. The driver refuses a core whose ABI
major differs, whose IPC address is not the device tree's, or whose
hardware ID is not the SoC k3-socinfo identified, and leaves it running.
To tell this boot's handshake from one a previous firmware left in the
memory, the kernel writes a random challenge into the Ring and waits up
to 5 s for the firmware to echo it.

The driver holds the power domains of each core's two timers, which the
firmware drives with no power request of its own, and links its device
to each core's so that it suspends before the DSP and unbinds first.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Move to shared memory IPC.
- Attach to a core remoteproc has booted instead of booting it.
- Discover caps and let userspace query them.
- Add the uAPI header here, moved from the BO patch.
- Group and sort the includes, end the Makefile with a newline (Jani
  Nikula); the driver's own headers stay quoted, as every accel driver
  does.
- Every /** block is kernel-doc or a plain comment (Randy Dunlap).
- Depend on TI_K3_DSP_REMOTEPROC with no COMPILE_TEST (Andrew Davis).
---
 MAINTAINERS                          |   8 +
 drivers/accel/Kconfig                |   1 +
 drivers/accel/Makefile               |   3 +-
 drivers/accel/thames/Kconfig         |  23 ++
 drivers/accel/thames/Makefile        |   7 +
 drivers/accel/thames/thames_core.c   | 624 +++++++++++++++++++++++++++++++++++
 drivers/accel/thames/thames_core.h   |  87 +++++
 drivers/accel/thames/thames_device.h |  58 ++++
 drivers/accel/thames/thames_drv.c    | 360 ++++++++++++++++++++
 drivers/accel/thames/thames_drv.h    |  32 ++
 include/uapi/drm/thames_accel.h      | 200 +++++++++++
 11 files changed, 1402 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6e67..c63ab2d77b01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8019,6 +8019,14 @@ F:	Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
 F:	drivers/accel/rocket/
 F:	include/uapi/drm/rocket_accel.h
 
+DRM ACCEL DRIVER FOR TI C7x DSPS
+M:	Tomeu Vizoso <tomeu@tomeuvizoso.net>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/accel/thames/
+F:	include/uapi/drm/thames_accel.h
+
 DRM COMPUTE ACCELERATORS DRIVERS AND FRAMEWORK
 M:	Oded Gabbay <ogabbay@kernel.org>
 L:	dri-devel@lists.freedesktop.org
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index bdf48ccafcf2..cb49c71cd4e4 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -30,5 +30,6 @@ source "drivers/accel/habanalabs/Kconfig"
 source "drivers/accel/ivpu/Kconfig"
 source "drivers/accel/qaic/Kconfig"
 source "drivers/accel/rocket/Kconfig"
+source "drivers/accel/thames/Kconfig"
 
 endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..6e1db1b381f5 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
-obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
+obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
+obj-$(CONFIG_DRM_ACCEL_THAMES)		+= thames/
diff --git a/drivers/accel/thames/Kconfig b/drivers/accel/thames/Kconfig
new file mode 100644
index 000000000000..c621002d8efa
--- /dev/null
+++ b/drivers/accel/thames/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_ACCEL_THAMES
+	tristate "Thames (support for TI C7x DSP accelerators)"
+	depends on DRM_ACCEL
+	depends on TI_K3_DSP_REMOTEPROC
+	depends on REMOTEPROC
+	depends on MAILBOX
+	help
+	  Choose this option if you have a Texas Instruments J722S and want to
+	  use its C7x DSP cores as compute accelerators.
+
+	  The C7x DSP cores can be used for general-purpose compute acceleration
+	  and are exposed through the DRM accel subsystem.
+
+	  The interface exposed to userspace is described in
+	  include/uapi/drm/thames_accel.h and is used by the Thames userspace
+	  driver in Mesa3D.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called thames.
diff --git a/drivers/accel/thames/Makefile b/drivers/accel/thames/Makefile
new file mode 100644
index 000000000000..175247b31cb2
--- /dev/null
+++ b/drivers/accel/thames/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_ACCEL_THAMES) := thames.o
+
+thames-y := \
+	thames_core.o \
+	thames_drv.o
diff --git a/drivers/accel/thames/thames_core.c b/drivers/accel/thames/thames_core.c
new file mode 100644
index 000000000000..d74c74b8f8eb
--- /dev/null
+++ b/drivers/accel/thames/thames_core.c
@@ -0,0 +1,624 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ktime.h>
+#include <linux/mailbox_client.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/random.h>
+#include <linux/remoteproc.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+#include <drm/thames_accel.h>
+
+#include "thames_abi.h"
+#include "thames_core.h"
+#include "thames_device.h"
+
+#define THAMES_RESTART_TIMEOUT_MS	5000
+
+/*
+ * The IPC memory is the core's first memory-region, which remoteproc allocates
+ * from only for virtio rings and carveouts this firmware does not have.
+ */
+#define THAMES_IPC_MEMORY_REGION	0
+
+static_assert(THAMES_HW_J722S_C7524 == DRM_THAMES_HW_J722S_C7524);
+
+static const struct soc_device_attribute thames_socs[] = {
+	{ .family = "J722S", .data = (void *)(uintptr_t)THAMES_HW_J722S_C7524 },
+	{ }
+};
+
+static int thames_core_read_window(struct thames_core *core, const char *name,
+				   struct resource *window)
+{
+	int index, err;
+
+	index = of_property_match_string(core->of_node, "reg-names", name);
+	if (index < 0) {
+		dev_err(core->dev, "Missing '%s' reg entry on the DSP node\n", name);
+		return index;
+	}
+
+	err = of_address_to_resource(core->of_node, index, window);
+	if (err) {
+		dev_err(core->dev, "Failed to read the '%s' window: %d\n", name, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int thames_core_read_windows(struct thames_core *core)
+{
+	int err;
+
+	err = thames_core_read_window(core, "l2sram", &core->l2sram);
+	if (err)
+		return err;
+
+	err = thames_core_read_window(core, "l2aux", &core->l2aux);
+	if (err)
+		return err;
+
+	return thames_core_read_window(core, "dru", &core->dru);
+}
+
+/*
+ * Copied once, so a firmware rewriting its handshake cannot change a value
+ * after the check.
+ */
+static int thames_core_read_caps(struct thames_core *core, struct thames_handshake *handshake,
+				 struct thames_caps *caps)
+{
+	struct thames_device *tdev = core->tdev;
+	u64 l2_window = resource_size(&core->l2sram);
+	u64 dru_window = resource_size(&core->dru);
+	u64 dru_kernel_offset, dru_kernel_size;
+	u32 dru_kernel_channel_first;
+	size_t pool_offset = offsetof(struct thames_ipc, transfer_table_pool);
+	int i;
+
+	caps->l2_size = READ_ONCE(handshake->l2_size);
+	caps->dru_channel_count = READ_ONCE(handshake->dru_channel_count);
+	caps->dru_queue_depth = READ_ONCE(handshake->dru_queue_depth);
+	caps->asid_bits = READ_ONCE(handshake->asid_bits);
+	caps->dru_channel_stride = READ_ONCE(handshake->dru_channel_stride);
+	caps->timestamp_hz = READ_ONCE(handshake->timestamp_hz);
+	caps->transfer_table_pool_size = READ_ONCE(handshake->transfer_table_pool_size);
+	caps->dru_capabilities = READ_ONCE(handshake->dru_capabilities);
+	dru_kernel_channel_first = READ_ONCE(handshake->dru_kernel_channel_first);
+	for (i = 0; i < THAMES_NUM_WINDOWS; i++)
+		caps->window_sizes[i] = resource_size(thames_core_window(core, i));
+
+	if (!caps->l2_size || caps->l2_size > l2_window) {
+		dev_err(core->dev, "Firmware L2 size 0x%x does not fit the 0x%llx-byte L2 window\n",
+			caps->l2_size, l2_window);
+		return -EINVAL;
+	}
+
+	if (!caps->dru_channel_count || !caps->dru_queue_depth ||
+	    (u64)caps->dru_channel_count * caps->dru_queue_depth > U16_MAX) {
+		dev_err(core->dev,
+			"Firmware DRU of %u channels of depth %u is empty or exceeds a group's count of %u transfers\n",
+			caps->dru_channel_count, caps->dru_queue_depth, U16_MAX);
+		return -EINVAL;
+	}
+
+	if (!caps->dru_channel_stride || !caps->timestamp_hz) {
+		dev_err(core->dev, "Firmware DRU channel stride %u or timestamp clock %u Hz is zero\n",
+			caps->dru_channel_stride, caps->timestamp_hz);
+		return -EINVAL;
+	}
+
+	if (!caps->transfer_table_pool_size ||
+	    !IS_ALIGNED(caps->transfer_table_pool_size, THAMES_ABI_LINE_SIZE) ||
+	    pool_offset + caps->transfer_table_pool_size > core->ipc_size) {
+		dev_err(core->dev,
+			"Firmware transfer table pool of 0x%x bytes at 0x%zx is empty, not whole lines, or past the 0x%zx-byte IPC memory\n",
+			caps->transfer_table_pool_size, pool_offset, core->ipc_size);
+		return -EINVAL;
+	}
+
+	dru_kernel_offset = (u64)dru_kernel_channel_first * caps->dru_channel_stride;
+	dru_kernel_size = (u64)caps->dru_channel_count * caps->dru_channel_stride;
+	if (caps->dru_channel_count > THAMES_MAX_DRU_CHANNELS ||
+	    !IS_ALIGNED(dru_kernel_offset, SZ_4K) || dru_kernel_size > SZ_4K ||
+	    dru_kernel_offset + SZ_4K > dru_window) {
+		dev_err(core->dev,
+			"Firmware DRU of %u channels from channel %u, 0x%x bytes apart, is not one page of its own in the 0x%llx-byte DRU window, or exceeds the driver's %d channels\n",
+			caps->dru_channel_count, dru_kernel_channel_first,
+			caps->dru_channel_stride, dru_window, THAMES_MAX_DRU_CHANNELS);
+		return -EINVAL;
+	}
+	caps->window_sizes[THAMES_WINDOW_DRU] = round_up(dru_kernel_size, SZ_4K);
+
+	if (!caps->asid_bits || caps->asid_bits > 16) {
+		dev_err(core->dev, "Firmware ASID width %u is not 1 to 16 bits\n",
+			caps->asid_bits);
+		return -EINVAL;
+	}
+
+	if (tdev->num_cores && memcmp(caps, &tdev->caps, sizeof(*caps))) {
+		dev_err(core->dev, "Capabilities or window sizes differ from the first core's\n");
+		return -EINVAL;
+	}
+
+	core->dru_kernel_channel_first = dru_kernel_channel_first;
+
+	return 0;
+}
+
+/*
+ * remoteproc never frees this memory, so it outlives every stop and start of
+ * the core and every reload of the driver.
+ */
+static int thames_core_map_ipc(struct thames_core *core)
+{
+	struct resource res;
+	int err;
+
+	err = of_reserved_mem_region_to_resource(core->of_node, THAMES_IPC_MEMORY_REGION, &res);
+	if (err) {
+		dev_err(core->dev, "No shared block as memory-region %d of %pOF: %d\n",
+			THAMES_IPC_MEMORY_REGION, core->of_node, err);
+		return err;
+	}
+
+	if (resource_size(&res) < sizeof(struct thames_ipc)) {
+		dev_err(core->dev, "The shared block %pR is smaller than the layout's 0x%zx bytes\n",
+			&res, sizeof(struct thames_ipc));
+		return -EINVAL;
+	}
+
+	core->ipc = memremap(res.start, resource_size(&res), MEMREMAP_WC);
+	if (!core->ipc) {
+		dev_err(core->dev, "Failed to map the shared block %pR\n", &res);
+		return -ENOMEM;
+	}
+
+	core->ipc_address = res.start;
+	core->ipc_size = resource_size(&res);
+
+	return 0;
+}
+
+static void thames_core_unmap_ipc(struct thames_core *core)
+{
+	memunmap(core->ipc);
+	core->ipc = NULL;
+}
+
+static int thames_core_check_abi(struct thames_core *core, u32 abi)
+{
+	if (THAMES_ABI_VERSION_MAJOR(abi) == THAMES_ABI_MAJOR)
+		return 0;
+
+	dev_err(core->dev, THAMES_CORE_FMT
+		" runs firmware of ABI %u.%u.%u, the driver's is %u.%u.%u: majors differ; refusing the core, left running\n",
+		THAMES_CORE_ARG(core), THAMES_ABI_VERSION_MAJOR(abi),
+		THAMES_ABI_VERSION_MINOR(abi), THAMES_ABI_VERSION_PATCH(abi),
+		THAMES_ABI_MAJOR, THAMES_ABI_MINOR, THAMES_ABI_PATCH);
+	return -ENODEV;
+}
+
+static u64 thames_core_challenge_echo(struct thames_core *core)
+{
+	return READ_ONCE(core->ipc->handshake.challenge_echo);
+}
+
+/* The IPC memory may still hold the handshake of a firmware before this boot. */
+static int thames_core_wait_handshake(struct thames_core *core)
+{
+	u64 challenge, found, echo;
+	ktime_t start;
+	u32 abi;
+	int err;
+
+	do {
+		challenge = get_random_u64();
+	} while (!challenge);
+
+	found = thames_core_challenge_echo(core);
+	WRITE_ONCE(core->ipc->ring.challenge, challenge);
+	/* Order the challenge before the doorbell. */
+	wmb();
+
+	/*
+	 * A doorbell rung before the firmware listens is lost; its loop reads
+	 * the challenge on its first pass all the same.
+	 */
+	mbox_send_message(core->mbox_chan, (void *)(uintptr_t)THAMES_DOORBELL);
+
+	start = ktime_get();
+	err = read_poll_timeout(thames_core_challenge_echo, echo, echo == challenge,
+				10 * USEC_PER_MSEC, THAMES_RESTART_TIMEOUT_MS * USEC_PER_MSEC,
+				false, core);
+	dev_dbg(core->dev, THAMES_CORE_FMT
+		" challenge %#llx, echo %#llx before the wait, %#llx after %lld ms\n",
+		THAMES_CORE_ARG(core), challenge, found, echo, ktime_ms_delta(ktime_get(), start));
+	if (err) {
+		abi = READ_ONCE(core->ipc->handshake.abi_version);
+		if (abi && thames_core_check_abi(core, abi))
+			return -ENODEV;
+
+		dev_err(core->dev, THAMES_CORE_FMT
+			" did not answer the challenge within %u ms; refusing the core, left running\n",
+			THAMES_CORE_ARG(core), THAMES_RESTART_TIMEOUT_MS);
+		return err;
+	}
+
+	/* Read the handshake after the echo that says it is written. */
+	rmb();
+	return 0;
+}
+
+static int thames_core_read_handshake(struct thames_core *core, struct thames_caps *caps)
+{
+	struct thames_handshake *handshake = &core->ipc->handshake;
+	const struct soc_device_attribute *soc;
+	u64 ipc_address;
+	int err;
+
+	err = thames_core_check_abi(core, READ_ONCE(handshake->abi_version));
+	if (err)
+		return err;
+
+	ipc_address = READ_ONCE(handshake->ipc_address);
+	if (ipc_address != core->ipc_address) {
+		dev_err(core->dev, THAMES_CORE_FMT
+			" runs firmware linked for a shared block at %#llx, the device tree reserves it at %pa; refusing the core, left running\n",
+			THAMES_CORE_ARG(core), ipc_address, &core->ipc_address);
+		return -ENODEV;
+	}
+
+	caps->hardware_id = READ_ONCE(handshake->hardware_id);
+	soc = soc_device_match(thames_socs);
+	if (!soc) {
+		dev_err(core->dev, THAMES_CORE_FMT
+			" runs firmware for hardware ID %u, and k3-socinfo identified no SoC the driver knows; refusing the core, left running\n",
+			THAMES_CORE_ARG(core), caps->hardware_id);
+		return -ENODEV;
+	}
+
+	if (caps->hardware_id != (uintptr_t)soc->data) {
+		dev_err(core->dev, THAMES_CORE_FMT
+			" runs firmware for hardware ID %u, the %s SoC's is %u; refusing the core, left running\n",
+			THAMES_CORE_ARG(core), caps->hardware_id, soc->family,
+			(u32)(uintptr_t)soc->data);
+		return -ENODEV;
+	}
+
+	return thames_core_read_caps(core, handshake, caps);
+}
+
+static void thames_mbox_rx(struct mbox_client *cl, void *mssg)
+{
+	struct thames_core *core = container_of(cl, struct thames_core, mbox_client);
+
+	dev_dbg(core->dev, "Doorbell on " THAMES_CORE_FMT ": 0x%x\n", THAMES_CORE_ARG(core),
+		(u32)(uintptr_t)mssg);
+}
+
+/* Embedded in struct thames_core: nothing to free. */
+static void thames_core_mbox_dev_release(struct device *dev)
+{
+}
+
+/*
+ * A device of the driver's own carrying the DSP node, so the mailbox core finds
+ * the node's mboxes without borrowing the K3 driver's device.
+ */
+static int thames_core_request_doorbell(struct thames_core *core)
+{
+	struct mbox_client *cl = &core->mbox_client;
+	struct device *mbox_dev = &core->mbox_dev;
+	int err;
+
+	device_initialize(mbox_dev);
+	mbox_dev->parent = core->tdev->ddev.dev;
+	mbox_dev->release = thames_core_mbox_dev_release;
+	device_set_node(mbox_dev, of_fwnode_handle(core->of_node));
+	dev_set_name(mbox_dev, "thames-mbox.%u", core->index);
+
+	err = device_add(mbox_dev);
+	if (err) {
+		put_device(mbox_dev);
+		return err;
+	}
+
+	cl->dev = mbox_dev;
+	cl->rx_callback = thames_mbox_rx;
+	cl->tx_block = false;
+	cl->knows_txdone = false;
+
+	core->mbox_chan = mbox_request_channel(cl, 1);
+	if (IS_ERR(core->mbox_chan)) {
+		err = PTR_ERR(core->mbox_chan);
+		core->mbox_chan = NULL;
+		device_del(mbox_dev);
+		put_device(mbox_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void thames_core_free_doorbell(struct thames_core *core)
+{
+	mbox_free_channel(core->mbox_chan);
+	core->mbox_chan = NULL;
+	device_del(&core->mbox_dev);
+	put_device(&core->mbox_dev);
+}
+
+static int thames_core_rproc_boot(struct thames_core *core)
+{
+	int err;
+
+	WRITE_ONCE(core->rproc_caller, current);
+	err = rproc_boot(core->rproc);
+	WRITE_ONCE(core->rproc_caller, NULL);
+
+	return err;
+}
+
+static int thames_core_rproc_shutdown(struct thames_core *core)
+{
+	int err;
+
+	WRITE_ONCE(core->rproc_caller, current);
+	err = rproc_shutdown(core->rproc);
+	WRITE_ONCE(core->rproc_caller, NULL);
+
+	return err;
+}
+
+/*
+ * The firmware drives these timers with no power request and the device tree
+ * reserves them for it, so the driver holds their power domains on.
+ */
+static int thames_core_get_timers(struct thames_core *core)
+{
+	const struct dev_pm_domain_attach_data data = {
+		.pd_flags = PD_FLAG_NO_DEV_LINK,
+	};
+	struct dev_pm_domain_list *pds = NULL;
+	int err, i;
+
+	err = dev_pm_domain_attach_list(core->dev, &data, &pds);
+	if (err < 0) {
+		if (err != -EPROBE_DEFER)
+			dev_err(core->dev, THAMES_CORE_FMT ": failed to attach the timers' power domains: %d\n",
+				THAMES_CORE_ARG(core), err);
+		return err;
+	}
+	if (!pds)
+		return 0;
+
+	for (i = 0; i < pds->num_pds; i++) {
+		err = pm_runtime_resume_and_get(pds->pd_devs[i]);
+		if (err) {
+			dev_err(core->dev, THAMES_CORE_FMT ": failed to power the timers' domain %s: %d\n",
+				THAMES_CORE_ARG(core), dev_name(pds->pd_devs[i]), err);
+			goto err_put;
+		}
+	}
+
+	core->timer_pds = pds;
+	return 0;
+
+err_put:
+	while (i--)
+		pm_runtime_put(pds->pd_devs[i]);
+	dev_pm_domain_detach_list(pds);
+	return err;
+}
+
+static void thames_core_put_timers(struct thames_core *core)
+{
+	struct dev_pm_domain_list *pds = core->timer_pds;
+	int i;
+
+	if (!pds)
+		return;
+
+	for (i = 0; i < pds->num_pds; i++)
+		pm_runtime_put(pds->pd_devs[i]);
+	dev_pm_domain_detach_list(pds);
+	core->timer_pds = NULL;
+}
+
+int thames_core_init(struct thames_core *core)
+{
+	struct thames_caps caps = {};
+	struct rproc *rproc;
+	int err;
+
+	/* Without a phandle the lookup would defer forever. */
+	if (!core->of_node->phandle) {
+		dev_err(core->tdev->ddev.dev, "%pOF has no phandle to find its remoteproc by\n",
+			core->of_node);
+		return -EINVAL;
+	}
+
+	rproc = rproc_get_by_phandle(core->of_node->phandle);
+	if (!rproc)
+		return dev_err_probe(core->tdev->ddev.dev, -EPROBE_DEFER,
+				     "%pOF: no remoteproc registered for it yet\n", core->of_node);
+
+	/*
+	 * remoteproc's own boot is still to come: booting the core here as well
+	 * would leave two power counts, and a reset or a suspend could not stop
+	 * it.
+	 */
+	if (rproc->state == RPROC_OFFLINE && rproc->auto_boot) {
+		rproc_put(rproc);
+		return dev_err_probe(core->tdev->ddev.dev, -EPROBE_DEFER,
+				     "%pOF: remoteproc has not booted it yet (auto-boot pending)\n",
+				     core->of_node);
+	}
+
+	core->rproc = rproc;
+	core->dev = rproc->dev.parent;
+	snprintf(core->name, sizeof(core->name), "DSP core %s (index %u)", dev_name(core->dev),
+		 core->index);
+
+	/*
+	 * The PM core then suspends this driver before the DSP, and an unbind
+	 * of the K3 driver unbinds this one first.
+	 */
+	if (!device_link_add(core->tdev->ddev.dev, core->dev, DL_FLAG_AUTOPROBE_CONSUMER)) {
+		dev_err(core->tdev->ddev.dev, "Failed to link to %s\n", dev_name(core->dev));
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	err = thames_core_read_windows(core);
+	if (err)
+		goto err_put;
+
+	err = thames_core_get_timers(core);
+	if (err)
+		goto err_put;
+
+	err = thames_core_map_ipc(core);
+	if (err)
+		goto err_timers;
+
+	err = thames_core_request_doorbell(core);
+	if (err)
+		goto err_unmap;
+
+	if (rproc->state == RPROC_OFFLINE) {
+		err = rproc_boot(rproc);
+		if (err)
+			goto err_doorbell;
+	}
+
+	err = thames_core_wait_handshake(core);
+	if (err)
+		goto err_doorbell;
+
+	err = thames_core_read_handshake(core, &caps);
+	if (err)
+		goto err_doorbell;
+
+	if (!core->tdev->num_cores)
+		core->tdev->caps = caps;
+
+	return 0;
+
+err_doorbell:
+	thames_core_free_doorbell(core);
+err_unmap:
+	thames_core_unmap_ipc(core);
+err_timers:
+	thames_core_put_timers(core);
+err_put:
+	rproc_put(rproc);
+	core->rproc = NULL;
+	return err;
+}
+
+void thames_core_fini(struct thames_core *core)
+{
+	if (core->mbox_chan)
+		thames_core_free_doorbell(core);
+	/*
+	 * Drop only our reference and keep the boot count: the core runs on
+	 * for the next load to reattach to; only a reset or a suspend, which
+	 * idle it first, stop it.
+	 */
+	rproc_put(core->rproc);
+	core->rproc = NULL;
+	thames_core_unmap_ipc(core);
+	thames_core_put_timers(core);
+	of_node_put(core->of_node);
+	core->of_node = NULL;
+}
+
+/*
+ * rproc_shutdown() reaches the system firmware because the core has one power
+ * count, remoteproc's auto-boot or this driver's boot: the probe defers while
+ * an auto-boot is pending.
+ */
+int thames_core_suspend(struct thames_core *core)
+{
+	struct rproc *rproc = core->rproc;
+	int err;
+
+	if (core->suspended)
+		return 0;
+
+	err = thames_core_rproc_shutdown(core);
+	if (!err && rproc->state != RPROC_OFFLINE) {
+		dev_err(core->dev, THAMES_CORE_FMT
+			" is kept running by another power count; refusing the suspend\n",
+			THAMES_CORE_ARG(core));
+		thames_core_rproc_boot(core);
+		err = -EBUSY;
+	}
+	if (err) {
+		return err;
+	}
+
+	core->suspended = true;
+	return 0;
+}
+
+/*
+ * The firmware empties the Ring at boot and moves its head to the tail it
+ * finds.
+ */
+int thames_core_resume(struct thames_core *core)
+{
+	struct thames_caps caps = {};
+	u32 head, tail;
+	int err = 0;
+
+	if (!core->suspended)
+		goto restart;
+
+	err = thames_core_rproc_boot(core);
+	if (err)
+		goto offline;
+
+	core->suspended = false;
+
+	err = thames_core_wait_handshake(core);
+	if (err)
+		goto offline;
+
+	err = thames_core_read_handshake(core, &caps);
+	if (err)
+		goto offline;
+
+	head = READ_ONCE(core->ipc->ring.head);
+	tail = READ_ONCE(core->ipc->ring.tail);
+	if (head != tail) {
+		dev_err(core->dev, "Ring on " THAMES_CORE_FMT
+			" is not empty after its boot (tail %u, head %u)\n",
+			THAMES_CORE_ARG(core), tail, head);
+		err = -EIO;
+		goto offline;
+	}
+	core->ring_tail = head;
+
+	goto restart;
+
+offline:
+restart:
+	return err;
+}
diff --git a/drivers/accel/thames/thames_core.h b/drivers/accel/thames/thames_core.h
new file mode 100644
index 000000000000..590c5716f7f5
--- /dev/null
+++ b/drivers/accel/thames/thames_core.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#ifndef __THAMES_CORE_H__
+#define __THAMES_CORE_H__
+
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex_types.h>
+#include <linux/remoteproc.h>
+
+
+#include "thames_abi.h"
+
+enum thames_window {
+	THAMES_WINDOW_L2SRAM,
+	THAMES_WINDOW_L2AUX,
+	THAMES_WINDOW_DRU,
+	THAMES_NUM_WINDOWS,
+};
+
+#define THAMES_MAX_DRU_CHANNELS	16
+
+#define THAMES_DOORBELL		1u
+
+struct thames_core {
+	struct device_node *of_node;
+	struct rproc *rproc;
+	struct device *dev;
+	struct thames_device *tdev;
+	unsigned int index;
+	char name[64];
+
+	struct thames_ipc *ipc;
+	phys_addr_t ipc_address;
+	size_t ipc_size;
+	u32 dru_kernel_channel_first;
+
+	struct dev_pm_domain_list *timer_pds;
+
+	struct device mbox_dev;
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+
+	u32 ring_tail;
+	/*
+	 * @rproc_caller is the task inside the driver's own rproc_boot() or
+	 * rproc_shutdown(), whose subdevice callbacks then do nothing.
+	 */
+	struct task_struct *rproc_caller;
+
+	bool suspended;
+
+	struct resource l2sram;
+	struct resource l2aux;
+	struct resource dru;
+};
+
+static inline const struct resource *thames_core_window(const struct thames_core *core,
+							enum thames_window window)
+{
+	switch (window) {
+	case THAMES_WINDOW_L2SRAM:
+		return &core->l2sram;
+	case THAMES_WINDOW_L2AUX:
+		return &core->l2aux;
+	case THAMES_WINDOW_DRU:
+		return &core->dru;
+	default:
+		return NULL;
+	}
+}
+
+/*
+ * The index counts attached cores only, so a core left out shifts the ones
+ * after it.
+ */
+#define THAMES_CORE_FMT "%s"
+#define THAMES_CORE_ARG(core) ((core)->name)
+
+int thames_core_init(struct thames_core *core);
+void thames_core_fini(struct thames_core *core);
+int thames_core_suspend(struct thames_core *core);
+int thames_core_resume(struct thames_core *core);
+
+#endif
diff --git a/drivers/accel/thames/thames_device.h b/drivers/accel/thames/thames_device.h
new file mode 100644
index 000000000000..f1cf79f2c2e4
--- /dev/null
+++ b/drivers/accel/thames/thames_device.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#ifndef __THAMES_DEVICE_H__
+#define __THAMES_DEVICE_H__
+
+#include <linux/atomic.h>
+#include <linux/bitmap.h>
+#include <linux/clk.h>
+#include <linux/container_of.h>
+#include <linux/idr.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_device.h>
+
+#include "thames_core.h"
+
+/* No holes: two cores' caps compare with memcmp(). */
+struct thames_caps {
+	u32 l2_size;
+	u32 dru_channel_count;
+	u32 dru_queue_depth;
+	u32 asid_bits;
+	u32 hardware_id;
+	u32 dru_channel_stride;
+	u32 timestamp_hz;
+	u32 transfer_table_pool_size;
+	u64 dru_capabilities;
+	u64 window_sizes[THAMES_NUM_WINDOWS];
+};
+
+#define THAMES_MAX_CORES	2
+
+struct thames_device {
+	struct drm_device ddev;
+
+	struct thames_core cores[THAMES_MAX_CORES];
+	unsigned int num_cores;
+
+	struct thames_caps caps;
+
+};
+
+#define to_thames_device(drm_dev) \
+	((struct thames_device *)(container_of((drm_dev), struct thames_device, ddev)))
+
+/*
+ * Each core's page tables map that core's window at the first core's physical
+ * address, so a Kernel names one address on either core.
+ */
+static inline u64 thames_window_va(const struct thames_device *tdev, enum thames_window i)
+{
+	return thames_core_window(&tdev->cores[0], i)->start;
+}
+
+#endif /* __THAMES_DEVICE_H__ */
diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/thames_drv.c
new file mode 100644
index 000000000000..de93bc87756c
--- /dev/null
+++ b/drivers/accel/thames/thames_drv.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timekeeping.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_accel.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_managed.h>
+#include <drm/thames_accel.h>
+
+#include "thames_core.h"
+#include "thames_drv.h"
+
+static struct platform_device *drm_dev;
+static struct thames_device *tdev;
+
+static const struct of_device_id thames_dsp_of_match[] = {
+	{ .compatible = "ti,am62a-c7xv-dsp" },
+	{}
+};
+
+static int thames_open(struct drm_device *dev, struct drm_file *file)
+{
+	struct thames_device *tdev = to_thames_device(dev);
+	struct thames_file_priv *thames_priv;
+	int ret, idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
+
+	thames_priv = kzalloc_obj(*thames_priv, GFP_KERNEL);
+	if (!thames_priv) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	thames_priv->tdev = tdev;
+	kref_init(&thames_priv->refcount);
+
+	file->driver_priv = thames_priv;
+
+	drm_dev_exit(idx);
+	return 0;
+
+err_exit:
+	drm_dev_exit(idx);
+	return ret;
+}
+
+static void thames_file_priv_release(struct kref *kref)
+{
+	struct thames_file_priv *priv = container_of(kref, struct thames_file_priv, refcount);
+
+	kfree(priv);
+}
+
+void thames_file_priv_put(struct thames_file_priv *priv)
+{
+	kref_put(&priv->refcount, thames_file_priv_release);
+}
+
+/* Jobs already on a Ring keep the Context until the Fence passes them. */
+static void thames_postclose(struct drm_device *dev, struct drm_file *file)
+{
+	struct thames_file_priv *thames_priv = file->driver_priv;
+
+	thames_file_priv_put(thames_priv);
+}
+
+#define THAMES_DRIVER_MAJOR 1
+#define THAMES_DRIVER_MINOR 0
+
+static int thames_query_copy_out(struct drm_thames_dev_query *args, const void *data,
+				 size_t size)
+{
+	u32 copied = min_t(size_t, args->size, size);
+
+	if (copy_to_user(u64_to_user_ptr(args->pointer), data, copied))
+		return -EFAULT;
+
+	args->size = copied;
+
+	return 0;
+}
+
+static int thames_query_caps(struct drm_device *dev, struct drm_thames_dev_query *args)
+{
+	struct thames_device *tdev = to_thames_device(dev);
+	const struct thames_caps *reported = &tdev->caps;
+	struct drm_thames_caps caps = {
+		.l2_size = reported->l2_size,
+		.dru_channel_count = reported->dru_channel_count,
+		.dru_queue_depth = reported->dru_queue_depth,
+		.l2_main_dsp_va = thames_window_va(tdev, THAMES_WINDOW_L2SRAM),
+		.l2_aux.dsp_va = thames_window_va(tdev, THAMES_WINDOW_L2AUX),
+		.l2_aux.size = reported->window_sizes[THAMES_WINDOW_L2AUX],
+		.dru_realtime_dsp_va = thames_window_va(tdev, THAMES_WINDOW_DRU),
+		.user_region.dsp_va = THAMES_USER_REGION_BASE,
+		.user_region.size = THAMES_USER_REGION_SIZE,
+		.hardware_id = reported->hardware_id,
+		.dru_capabilities = reported->dru_capabilities,
+	};
+
+	return thames_query_copy_out(args, &caps, sizeof(caps));
+}
+
+static int thames_ioctl_dev_query(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct drm_thames_dev_query *args = data;
+
+	switch (args->type) {
+	case DRM_THAMES_DEV_QUERY_CAPS:
+		if (!args->pointer) {
+			args->size = sizeof(struct drm_thames_caps);
+			return 0;
+		}
+		return thames_query_caps(dev, args);
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * BO_PREP is not entered: it may wait as long as the client asks and touches
+ * only the CPU caches.
+ */
+#define THAMES_IOCTL_ENTERED(func)						\
+static int thames_ioctl_##func##_entered(struct drm_device *dev, void *data,	\
+					 struct drm_file *file)			\
+{										\
+	int ret, idx;								\
+										\
+	if (!drm_dev_enter(dev, &idx))						\
+		return -ENODEV;							\
+										\
+	ret = thames_ioctl_##func(dev, data, file);				\
+	drm_dev_exit(idx);							\
+										\
+	return ret;								\
+}
+
+THAMES_IOCTL_ENTERED(dev_query)
+
+static const struct drm_ioctl_desc thames_drm_driver_ioctls[] = {
+#define THAMES_IOCTL(n, func) DRM_IOCTL_DEF_DRV(THAMES_##n, thames_ioctl_##func, 0)
+	THAMES_IOCTL(DEV_QUERY, dev_query_entered),
+};
+
+DEFINE_DRM_ACCEL_FOPS(thames_accel_driver_fops);
+
+static const struct drm_driver thames_drm_driver = {
+	.driver_features = DRIVER_COMPUTE_ACCEL | DRIVER_GEM | DRIVER_SYNCOBJ |
+			   DRIVER_SYNCOBJ_TIMELINE,
+	.open = thames_open,
+	.postclose = thames_postclose,
+	.ioctls = thames_drm_driver_ioctls,
+	.num_ioctls = ARRAY_SIZE(thames_drm_driver_ioctls),
+	.fops = &thames_accel_driver_fops,
+	.name = "thames",
+	.desc = "thames DRM",
+	.major = THAMES_DRIVER_MAJOR,
+	.minor = THAMES_DRIVER_MINOR,
+};
+
+static struct thames_device *thames_device_init(struct platform_device *pdev,
+						const struct drm_driver *thames_drm_driver)
+{
+	struct device *dev = &pdev->dev;
+	struct thames_device *tdev;
+	int err;
+
+	tdev = devm_drm_dev_alloc(dev, thames_drm_driver, struct thames_device, ddev);
+	if (IS_ERR(tdev))
+		return tdev;
+
+	dev_set_drvdata(dev, tdev);
+
+	dma_set_max_seg_size(dev, UINT_MAX);
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	if (err)
+		return ERR_PTR(err);
+
+
+	return tdev;
+}
+
+static void thames_device_fini(struct thames_device *tdev)
+{
+	WARN_ON(tdev->num_cores > 0);
+}
+
+static int thames_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	unsigned int core = 0;
+	int err;
+
+	tdev = thames_device_init(pdev, &thames_drm_driver);
+	if (IS_ERR(tdev)) {
+		err = PTR_ERR(tdev);
+		tdev = NULL;
+		return err;
+	}
+
+	for_each_matching_node(np, thames_dsp_of_match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		if (core >= THAMES_MAX_CORES) {
+			of_node_put(np);
+			break;
+		}
+
+		tdev->cores[core].tdev = tdev;
+		tdev->cores[core].index = core;
+		tdev->cores[core].of_node = of_node_get(np);
+
+		err = thames_core_init(&tdev->cores[core]);
+		if (err == -EPROBE_DEFER) {
+			of_node_put(np);
+			of_node_put(np);
+			goto err_fini_cores;
+		}
+		if (err) {
+			dev_warn(&pdev->dev, "Leaving out the core at %pOF: %d\n", np, err);
+			of_node_put(np);
+			memset(&tdev->cores[core], 0, sizeof(tdev->cores[core]));
+			continue;
+		}
+
+		tdev->num_cores++;
+		core++;
+	}
+
+	if (!tdev->num_cores) {
+		dev_err(&pdev->dev, "No DSP core attached\n");
+		err = -ENODEV;
+		goto err_fini_dev;
+	}
+
+	err = drm_dev_register(&tdev->ddev, 0);
+	if (err)
+		goto err_fini_cores;
+
+	return 0;
+
+err_fini_cores:
+	while (core--)
+		thames_core_fini(&tdev->cores[core]);
+	tdev->num_cores = 0;
+err_fini_dev:
+	thames_device_fini(tdev);
+	tdev = NULL;
+	return err;
+}
+
+static void thames_platform_remove(struct platform_device *pdev)
+{
+	unsigned int core;
+
+	if (!tdev)
+		return;
+
+	drm_dev_unplug(&tdev->ddev);
+
+	for (core = 0; core < tdev->num_cores; core++)
+		thames_core_fini(&tdev->cores[core]);
+	tdev->num_cores = 0;
+
+	thames_device_fini(tdev);
+	tdev = NULL;
+}
+
+static int thames_pm_suspend(struct device *dev)
+{
+	struct thames_device *tdev = dev_get_drvdata(dev);
+	unsigned int core;
+	int err;
+
+	for (core = 0; core < tdev->num_cores; core++) {
+		err = thames_core_suspend(&tdev->cores[core]);
+		if (err)
+			goto err_resume;
+	}
+
+	return 0;
+
+err_resume:
+	while (core--)
+		thames_core_resume(&tdev->cores[core]);
+	return err;
+}
+
+static int thames_pm_resume(struct device *dev)
+{
+	struct thames_device *tdev = dev_get_drvdata(dev);
+	unsigned int core;
+	int err, ret = 0;
+
+	for (core = 0; core < tdev->num_cores; core++) {
+		err = thames_core_resume(&tdev->cores[core]);
+		if (err && !ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(thames_pm_ops, thames_pm_suspend, thames_pm_resume);
+
+static struct platform_driver thames_platform_driver = {
+	.probe = thames_platform_probe,
+	.remove = thames_platform_remove,
+	.driver = {
+		.name = "thames",
+		.pm = pm_sleep_ptr(&thames_pm_ops),
+	},
+};
+
+static int __init thames_register(void)
+{
+	int ret;
+
+	drm_dev = platform_device_register_simple("thames", -1, NULL, 0);
+	if (IS_ERR(drm_dev))
+		return PTR_ERR(drm_dev);
+
+	ret = platform_driver_register(&thames_platform_driver);
+	if (ret)
+		platform_device_unregister(drm_dev);
+
+	return ret;
+}
+
+static void __exit thames_unregister(void)
+{
+	platform_driver_unregister(&thames_platform_driver);
+
+	platform_device_unregister(drm_dev);
+}
+
+module_init(thames_register);
+module_exit(thames_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DRM driver for Texas Instruments' C7x accelerator cores");
+MODULE_AUTHOR("Tomeu Vizoso");
diff --git a/drivers/accel/thames/thames_drv.h b/drivers/accel/thames/thames_drv.h
new file mode 100644
index 000000000000..2678abc2e2de
--- /dev/null
+++ b/drivers/accel/thames/thames_drv.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#ifndef __THAMES_DRV_H__
+#define __THAMES_DRV_H__
+
+#include <linux/io-pgtable.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/xarray.h>
+
+#include <drm/drm_mm.h>
+
+#include "thames_device.h"
+
+struct drm_gem_dma_object;
+
+struct thames_file_priv {
+	struct thames_device *tdev;
+
+	/*
+	 * A binding holds no reference: a buffer can outlive its file through
+	 * an mmap or an export.
+	 */
+	struct kref refcount;
+
+};
+
+void thames_file_priv_put(struct thames_file_priv *priv);
+
+#endif
diff --git a/include/uapi/drm/thames_accel.h b/include/uapi/drm/thames_accel.h
new file mode 100644
index 000000000000..af427a29b585
--- /dev/null
+++ b/include/uapi/drm/thames_accel.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+#ifndef _THAMES_DRM_H_
+#define _THAMES_DRM_H_
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/**
+ * DOC: Terms
+ *
+ * Context: one client's address space on the DSP, a page table and the
+ * buffers bound in it; a fault belongs to a Context, isolation is between
+ * Contexts.
+ *
+ * Kernel: the compiled program a Job runs on a DSP core; never the Linux
+ * kernel, which is "the kernel driver" here.
+ *
+ * Job: an object a client creates once and submits any number of times:
+ * one Kernel with its parameters and its transfers.
+ *
+ * Ring: a core's queue of submitted Jobs, one entry each, run in order.
+ *
+ * Fence: a submitted Job's completion as the host sees it, a sequence
+ * number the firmware writes and a sync object on the host.
+ *
+ * DRU: the Data Routing Unit, the DMA engine a Job's transfers program;
+ * it addresses physical memory, not a Context.
+ *
+ * Dispatch: the Job type that runs a Kernel with its transfers; the only
+ * type today.
+ */
+
+/**
+ * DOC: IOCTL IDs
+ *
+ * enum drm_thames_ioctl_id - IOCTL IDs
+ *
+ * Place new ioctls at the end, don't re-order, don't replace or remove entries.
+ *
+ * These IDs are not meant to be used directly. Use the DRM_IOCTL_THAMES_xxx
+ * definitions instead.
+ */
+enum drm_thames_ioctl_id {
+	/** @DRM_THAMES_DEV_QUERY: Query the device's capabilities. */
+	DRM_THAMES_DEV_QUERY,
+
+};
+
+/**
+ * DOC: IOCTL arguments
+ */
+
+/**
+ * struct drm_thames_range - A range of the Context's address space.
+ */
+struct drm_thames_range {
+	/** @dsp_va: Start of the range. */
+	__u64 dsp_va;
+
+	/** @size: Size of the range in bytes. */
+	__u64 size;
+};
+
+/**
+ * enum drm_thames_dev_query_type - Query type
+ *
+ * Place new types at the end, don't re-order, don't remove or replace.
+ */
+enum drm_thames_dev_query_type {
+	/** @DRM_THAMES_DEV_QUERY_CAPS: The capability query, &drm_thames_caps. */
+	DRM_THAMES_DEV_QUERY_CAPS = 0,
+
+};
+
+/**
+ * enum drm_thames_hardware_id - &drm_thames_caps.hardware_id
+ */
+enum drm_thames_hardware_id {
+	/** @DRM_THAMES_HW_J722S_C7524: The C7524 cores of the J722S. */
+	DRM_THAMES_HW_J722S_C7524 = 1,
+};
+
+/**
+ * struct drm_thames_caps - The capability query
+ *
+ * Each window sits at one address whatever core runs the Job and reaches that
+ * core's own memory.
+ */
+struct drm_thames_caps {
+	/** @l2_size: Size in bytes of each core's L2 SRAM. */
+	__u32 l2_size;
+
+	/** @dru_channel_count: DRU channels a Job's transfers may name, from 0. */
+	__u32 dru_channel_count;
+
+	/**
+	 * @dru_queue_depth: Transfers one channel queues; no channel's
+	 * transfers in one transfer group may exceed it.
+	 */
+	__u32 dru_queue_depth;
+
+	/**
+	 * @max_transfers: The most transfers one Job may carry; 0 when the
+	 * kernel driver accepts no transfers.
+	 */
+	__u32 max_transfers;
+
+	/**
+	 * @l2_main_dsp_va: Where the L2 main aperture starts in a Context's
+	 * address space.  A Kernel is compiled against this address.
+	 */
+	__u64 l2_main_dsp_va;
+
+	/** @l2_aux: Where the L2 auxiliary aperture sits in a Context. */
+	struct drm_thames_range l2_aux;
+
+	/**
+	 * @dru_realtime_dsp_va: Where the DRU's real-time page starts in a
+	 * Context: the software triggers and the status counts of the Kernels'
+	 * channels, the only DRU page a Kernel reaches.  Channel n's registers
+	 * start at n times the channel stride into it, 0x100 on the J722S.
+	 */
+	__u64 dru_realtime_dsp_va;
+
+	/**
+	 * @user_region: Where the kernel driver maps the Context's user stack
+	 * and save page.
+	 */
+	struct drm_thames_range user_region;
+
+	/**
+	 * @hardware_id: The SoC and core the firmware was built for, one of
+	 * &enum drm_thames_hardware_id.  Userspace keys the facts of the
+	 * hardware the query does not carry on it.
+	 */
+	__u32 hardware_id;
+
+	/**
+	 * @transfer_types: The transfer record types the kernel driver accepts,
+	 * bit n for type n; 0 when it accepts none.
+	 */
+	__u32 transfer_types;
+
+	/**
+	 * @dru_capabilities: The DRU's DRU_CAPABILITIES register as the
+	 * firmware read it: the record types and formats the hardware supports.
+	 * Zero when the firmware does not report it.
+	 */
+	__u64 dru_capabilities;
+};
+
+/**
+ * struct drm_thames_dev_query - Arguments passed to DRM_IOCTL_THAMES_DEV_QUERY
+ */
+struct drm_thames_dev_query {
+	/** @type: One of &enum drm_thames_dev_query_type. */
+	__u32 type;
+
+	/**
+	 * @size: Size of the structure at @pointer.
+	 *
+	 * With @pointer NULL the driver writes the structure's size here and
+	 * copies nothing.  Otherwise it copies min(@size, its own size) bytes
+	 * and writes the count copied.
+	 */
+	__u32 size;
+
+	/** @pointer: User pointer to the query type's structure. */
+	__u64 pointer;
+};
+
+/**
+ * DRM_IOCTL_THAMES() - Build a thames IOCTL number
+ * @__access: Access type. Must be R, W or RW.
+ * @__id: One of the DRM_THAMES_xxx id.
+ * @__type: Suffix of the type being passed to the IOCTL.
+ *
+ * Don't use this macro directly, use the DRM_IOCTL_THAMES_xxx
+ * values instead.
+ *
+ * Return: An IOCTL number to be passed to ioctl() from userspace.
+ */
+#define DRM_IOCTL_THAMES(__access, __id, __type) \
+	DRM_IO ## __access(DRM_COMMAND_BASE + DRM_THAMES_ ## __id, \
+			   struct drm_thames_ ## __type)
+
+enum {
+	DRM_IOCTL_THAMES_DEV_QUERY =
+		DRM_IOCTL_THAMES(WR, DEV_QUERY, dev_query),
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _THAMES_DRM_H_ */

-- 
2.54.0

