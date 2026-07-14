Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B3EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51C610EE4C;
	Tue, 14 Jul 2026 21:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQbMoVyK";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF9710EE4C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:16:24 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso12035055e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063782; x=1784668582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/JfNZMwe7UcSWwn7yW5ZC5TyJgrCXJvF4n/jhuqx5Y=;
 b=fQbMoVyKT2JB0yMGebhkj7GE1buFTIQ0XUGTS+HaD7yArW8St/RVl5QEIXMKUrLbC5
 +dZbwz4xq9yL9KS+4wLGuuK2KlDbG7lUny8yhHkhcla/F6rxxfwdb0S/3u5lNu9qTmMT
 bzz1AuAvPByDhI+dQzPIPBwombZWEc8l4571SxNXPBsOBopeB1xYnY4zsbmUUq1udey0
 sqDaukL8Ye3pmEyGE+4GE3lLMqeuEr+TOpjoFHrcj8cyAdDMZ9aRHrJ/rSgrztxIvBfG
 yOQD3gXDl5CeNSar65owp0aC94PaLmA1nBl5cipSiyVvQAS8mMGikonmpJvW4R6zuVqd
 t9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063782; x=1784668582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/JfNZMwe7UcSWwn7yW5ZC5TyJgrCXJvF4n/jhuqx5Y=;
 b=ksUuXzKQ8SJlZnZmMPYy6oD1R8RB7mjRjP5VZzZS1N5nZZ3HFBtiQ1GI/YNWYJ3toH
 swUEkpy6C7/feDcckm1OG0Y9nNCDgr1vtThIQv9j4sW/DzCxHQLnh5HfW579XxQb+/IZ
 G3ucQ+/FzdIIbTLr4oiYZOg5xyopZmWMvHIS+c15PTHxCs1aM2skxPFgXs3BhlI3zkLQ
 kyqZxrCXz3Rplhuu18aCC6ManGUFMQerjGJsL+lBenX2e3Q71mQF1VfKcNJZZRkqRGqw
 YLTnLSlRAtzCOQQBGfz0PiN4tqWFRiqTSDV+Dq8eA6CB300YnVu6dHzbdIOXfZgDvkSl
 z/PA==
X-Gm-Message-State: AOJu0Yy9z7dsh9A583FdxlOiKqOE0eC/t0vBBvk6V96Ml0eG6glwf9Kp
 IYW2DxS26U3xP9jtKG69Y4+UkDBtJb8Oyfmg0uaf5X0/a5zl/t4iVvXc
X-Gm-Gg: AfdE7ckg+aLYn+ulIwCUMTXWDPaDSXqnfyDXvGjF9qU9BKJtGNGtygTg2v4sMh/rdd+
 GVdIw0pXLCcXswu4Sil/M2Rxouz5ettsxFuwr+QrWuABLN32OqWJ/PcDTR5BbvejIgRIXue8I8S
 +CuMJ+Mqfs48ry95KKGm1IdkiyhS3146PFxZe4Br3qChGT1Y9yjq/Q8/3FboI32uUJhA6aS2+CM
 ZnyhjNseHcKzKwBrahDYcE+YaZvDB9caKvrYAORrwoB4YccLJ657GMtkZ2HP7IUZJIc9yftQOZr
 YiXDOBKdsbQw9vOD1aPBWpsNmEwNOIQ09OSCYchNh/IPmdUf1HEW4Jx9pWiv6PDPTAW87fkaZQf
 c0IouSRluxa7nd/3Oc+jE+rTH3CCT2SL43arrEv5t8gfcv/KU6ekYP3yinwCo0EYVIk6jqGJM7A
 ycS7QOF0zRUMbeDXlCTRW9
X-Received: by 2002:a05:600c:528d:b0:493:b4cf:d37f with SMTP id
 5b1f17b1804b1-493f87e5e0dmr167320825e9.16.1784063781883; 
 Tue, 14 Jul 2026 14:16:21 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:16:21 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 4/6] drm/nouveau: expose RUSD telemetry via sysfs
Date: Wed, 15 Jul 2026 01:14:27 +0400
Message-ID: <20260714211429.238355-5-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
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

Add a "rusd" attribute group under the DRM device
(/sys/class/drm/cardN/device/rusd/) exposing every GSP-polled RUSD
telemetry value as its own world-readable file: temperatures, the full
set of power readings, clocks, GPU/memory/engine utilization, current
pstate, clock throttle reasons, ECC error counts, memory row-remap
state and PCIe link counters.

The data that fits hwmon (temperature, power) is already published
there, this interface is for the rest, which has no hwmon channel type,
and for tools that want a complete, self-contained view. Each file reads
one decoded value through nvkm_gsp_rusd_read(). nvkm owns the units and
conversions, so the show() is a thin wrapper.

The group is created only on GSP-RM boards whose firmware provides RUSD
(r570+); all files appear when RUSD is active, and a section that is
unsupported on the board (e.g. ECC on a consumer part) or has not been
polled yet reads -ENODATA rather than being raced out of existence at
probe time. Because reads are demand-driven, GSP only polls a value's
group while its files are being read.

Files are documented in Documentation/ABI/testing/sysfs-driver-nouveau.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../ABI/testing/sysfs-driver-nouveau          | 152 +++++++++++
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/nouveau/Kbuild                |   1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   3 +
 drivers/gpu/drm/nouveau/nouveau_drv.h         |   1 +
 drivers/gpu/drm/nouveau/nouveau_sysfs.c       | 250 ++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_sysfs.h       |  10 +
 7 files changed, 418 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-nouveau
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.h

diff --git a/Documentation/ABI/testing/sysfs-driver-nouveau b/Documentation/ABI/testing/sysfs-driver-nouveau
new file mode 100644
index 000000000000..947474b9955d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-nouveau
@@ -0,0 +1,152 @@
+What:		/sys/class/drm/card<n>/device/rusd/
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		GPU telemetry read from NVIDIA GSP-RM's "RM User Shared Data"
+		(RUSD) buffer. Present only on GSP-RM boards whose firmware
+		supports RUSD (r570 and later); absent otherwise. Each file is
+		a single value, world-readable. GSP polls a value's data group
+		only while files in that group are being read, so the first read
+		after an idle period, and reads of a section not supported on the
+		board, return -ENODATA; a subsequent read returns data once the
+		group has been polled. All files are read-only.
+
+What:		/sys/class/drm/card<n>/device/rusd/temp_gpu
+What:		/sys/class/drm/card<n>/device/rusd/temp_hbm
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		GPU core and HBM/VRAM temperatures, in millidegrees Celsius.
+		temp_hbm is meaningful only on boards with on-package memory
+		temperature sensing.
+
+What:		/sys/class/drm/card<n>/device/rusd/power_gpu
+What:		/sys/class/drm/card<n>/device/rusd/power_gpu_average
+What:		/sys/class/drm/card<n>/device/rusd/power_board
+What:		/sys/class/drm/card<n>/device/rusd/power_board_average
+What:		/sys/class/drm/card<n>/device/rusd/power_vram_average
+What:		/sys/class/drm/card<n>/device/rusd/power_cpu
+What:		/sys/class/drm/card<n>/device/rusd/power_cap
+What:		/sys/class/drm/card<n>/device/rusd/power_limit_requested
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Power readings, in microwatts. power_gpu / power_board /
+		power_cpu are instantaneous GPU, board (module) and CPU power;
+		the *_average variants are time-averaged. power_cap is the
+		enforced power limit and power_limit_requested the requested one
+		(read-only; RUSD does not set limits). Board/module and CPU
+		values are absent on form factors that do not report them (e.g.
+		module power on Ampere/Hopper add-in boards).
+
+What:		/sys/class/drm/card<n>/device/rusd/clock_graphics
+What:		/sys/class/drm/card<n>/device/rusd/clock_memory
+What:		/sys/class/drm/card<n>/device/rusd/clock_video
+What:		/sys/class/drm/card<n>/device/rusd/clock_sm
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Target clock frequencies of the graphics, memory, video and SM
+		domains, in MHz. A domain a board does not implement reads 0.
+
+What:		/sys/class/drm/card<n>/device/rusd/util_gpu
+What:		/sys/class/drm/card<n>/device/rusd/util_memory
+What:		/sys/class/drm/card<n>/device/rusd/util_nvenc
+What:		/sys/class/drm/card<n>/device/rusd/util_nvdec
+What:		/sys/class/drm/card<n>/device/rusd/util_nvjpg
+What:		/sys/class/drm/card<n>/device/rusd/util_nvofa
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Utilization of the GPU, the memory controller and the NVENC,
+		NVDEC, NVJPG and NVOFA engines, as a percentage (0-100). These
+		are device-global, not per-process.
+
+What:		/sys/class/drm/card<n>/device/rusd/util_nvenc_period
+What:		/sys/class/drm/card<n>/device/rusd/util_nvdec_period
+What:		/sys/class/drm/card<n>/device/rusd/util_nvjpg_period
+What:		/sys/class/drm/card<n>/device/rusd/util_nvofa_period
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Sampling period, in microseconds, over which the matching
+		engine utilization above was measured.
+
+What:		/sys/class/drm/card<n>/device/rusd/pstate
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Current performance state (P-state) index; lower is higher
+		performance (P0 is maximum).
+
+What:		/sys/class/drm/card<n>/device/rusd/throttle_status
+What:		/sys/class/drm/card<n>/device/rusd/throttle_gpu_idle
+What:		/sys/class/drm/card<n>/device/rusd/throttle_app_clock
+What:		/sys/class/drm/card<n>/device/rusd/throttle_sw_power_cap
+What:		/sys/class/drm/card<n>/device/rusd/throttle_hw_slowdown
+What:		/sys/class/drm/card<n>/device/rusd/throttle_sync_boost
+What:		/sys/class/drm/card<n>/device/rusd/throttle_sw_thermal
+What:		/sys/class/drm/card<n>/device/rusd/throttle_hw_thermal
+What:		/sys/class/drm/card<n>/device/rusd/throttle_hw_power_brake
+What:		/sys/class/drm/card<n>/device/rusd/throttle_display_clock
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Clock throttling reasons. throttle_status is the raw bitmask of
+		all active reasons; the remaining files each read 0 or 1 for one
+		reason (GPU idle, application clock setting, software power cap,
+		hardware slowdown, sync boost, software/hardware thermal
+		slowdown, hardware power brake, and display clock setting).
+
+What:		/sys/class/drm/card<n>/device/rusd/ecc_total_ce_volatile
+What:		/sys/class/drm/card<n>/device/rusd/ecc_total_ce_aggregate
+What:		/sys/class/drm/card<n>/device/rusd/ecc_total_ue_volatile
+What:		/sys/class/drm/card<n>/device/rusd/ecc_total_ue_aggregate
+What:		/sys/class/drm/card<n>/device/rusd/ecc_dram_ce_volatile
+What:		/sys/class/drm/card<n>/device/rusd/ecc_dram_ce_aggregate
+What:		/sys/class/drm/card<n>/device/rusd/ecc_dram_ue_volatile
+What:		/sys/class/drm/card<n>/device/rusd/ecc_dram_ue_aggregate
+What:		/sys/class/drm/card<n>/device/rusd/ecc_sram_ce_volatile
+What:		/sys/class/drm/card<n>/device/rusd/ecc_sram_ce_aggregate
+What:		/sys/class/drm/card<n>/device/rusd/ecc_sram_ue_volatile
+What:		/sys/class/drm/card<n>/device/rusd/ecc_sram_ue_aggregate
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		ECC error counts for total, DRAM and SRAM, split into
+		correctable (ce) and uncorrectable (ue) errors, each as a
+		volatile (since boot) and an aggregate (lifetime) count.
+		Present only on boards with ECC.
+
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_histogram_max
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_histogram_high
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_histogram_partial
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_histogram_low
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_histogram_none
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_correctable
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_uncorrectable
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_pending
+What:		/sys/class/drm/card<n>/device/rusd/rowremap_failure
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		Memory row-remapping state. The histogram_* files count memory
+		banks by remap-resource availability (max/high/partial/low/none);
+		rowremap_correctable and rowremap_uncorrectable count remapped
+		rows; rowremap_pending and rowremap_failure read 0 or 1. Present
+		only on boards with row remapping (datacenter parts).
+
+What:		/sys/class/drm/card<n>/device/rusd/pcie_gen
+What:		/sys/class/drm/card<n>/device/rusd/pcie_linecode_errors
+What:		/sys/class/drm/card<n>/device/rusd/pcie_crc_errors
+What:		/sys/class/drm/card<n>/device/rusd/pcie_naks_received
+What:		/sys/class/drm/card<n>/device/rusd/pcie_failed_l0s_exits
+What:		/sys/class/drm/card<n>/device/rusd/pcie_correctable_errors
+What:		/sys/class/drm/card<n>/device/rusd/pcie_nonfatal_errors
+What:		/sys/class/drm/card<n>/device/rusd/pcie_fatal_errors
+What:		/sys/class/drm/card<n>/device/rusd/pcie_unsupported_requests
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		PCIe link telemetry. pcie_gen is a packed gen/width bitfield;
+		the remaining files are link error and event counters.
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d15..8ae43f0e83c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8289,6 +8289,7 @@ Q:	https://gitlab.freedesktop.org/drm/nouveau/-/merge_requests
 B:	https://gitlab.freedesktop.org/drm/nouveau/-/issues
 C:	irc://irc.oftc.net/nouveau
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/ABI/testing/sysfs-driver-nouveau
 F:	drivers/gpu/drm/nouveau/
 F:	include/uapi/drm/nouveau_drm.h
 
diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
index 385d24530d1e..00d81133533d 100644
--- a/drivers/gpu/drm/nouveau/Kbuild
+++ b/drivers/gpu/drm/nouveau/Kbuild
@@ -26,6 +26,7 @@ nouveau-$(CONFIG_COMPAT) += nouveau_ioc32.o
 nouveau-$(CONFIG_LEDS_CLASS) += nouveau_led.o
 nouveau-y += nouveau_nvif.o
 nouveau-$(CONFIG_NOUVEAU_PLATFORM_DRIVER) += nouveau_platform.o
+nouveau-y += nouveau_sysfs.o
 nouveau-y += nouveau_vga.o
 
 # DRM - memory management
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index e16f59b00f6f..49f73f295664 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -60,6 +60,7 @@
 #include "nouveau_vga.h"
 #include "nouveau_led.h"
 #include "nouveau_hwmon.h"
+#include "nouveau_sysfs.h"
 #include "nouveau_acpi.h"
 #include "nouveau_bios.h"
 #include "nouveau_ioctl.h"
@@ -591,6 +592,7 @@ nouveau_drm_device_fini(struct nouveau_drm *drm)
 	nouveau_dmem_fini(drm);
 	nouveau_svm_fini(drm);
 	nouveau_hwmon_fini(dev);
+	nouveau_sysfs_fini(drm);
 	nouveau_debugfs_fini(drm);
 
 	if (dev->mode_config.num_crtc)
@@ -675,6 +677,7 @@ nouveau_drm_device_init(struct nouveau_drm *drm)
 	}
 
 	nouveau_debugfs_init(drm);
+	nouveau_sysfs_init(drm);
 	nouveau_hwmon_init(dev);
 	nouveau_svm_init(drm);
 	nouveau_dmem_init(drm);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 1c2523e2f92e..a3e343085cc1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -296,6 +296,7 @@ struct nouveau_drm {
 	/* power management */
 	struct nouveau_hwmon *hwmon;
 	struct nouveau_debugfs *debugfs;
+	bool rusd_sysfs;
 
 	/* led management */
 	struct nouveau_led *led;
diff --git a/drivers/gpu/drm/nouveau/nouveau_sysfs.c b/drivers/gpu/drm/nouveau/nouveau_sysfs.c
new file mode 100644
index 000000000000..f3d9462deaba
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nouveau_sysfs.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (c) 2026 Valve Corp.
+ *
+ * Expose the GPU's RM User Shared Data (RUSD) telemetry, polled by GSP-RM,
+ * as world-readable sysfs files under the DRM device's "rusd" group. Each
+ * file is one decoded value; nvkm owns the units and conversions. A section
+ * that is not supported on this board, or has not been polled yet, reads
+ * -ENODATA. See Documentation/ABI/testing/sysfs-driver-nouveau for units.
+ */
+#include <linux/device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/sysfs.h>
+
+#include "nouveau_drv.h"
+#include "nouveau_sysfs.h"
+
+#include <nvkm/subdev/gsp.h>
+
+static ssize_t
+rusd_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nouveau_drm *drm = dev_get_drvdata(dev);
+	int item = to_sensor_dev_attr(attr)->index;
+	s64 val;
+	int ret;
+
+	ret = nvkm_gsp_rusd_read(drm->nvkm->gsp, item, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%lld\n", val);
+}
+
+/* One read-only file per RUSD item; nvkm owns units and conversions. */
+static SENSOR_DEVICE_ATTR(temp_gpu, 0444, rusd_show, NULL, NVKM_GSP_RUSD_TEMP_GPU);
+static SENSOR_DEVICE_ATTR(temp_hbm, 0444, rusd_show, NULL, NVKM_GSP_RUSD_TEMP_HBM);
+static SENSOR_DEVICE_ATTR(power_gpu, 0444, rusd_show, NULL, NVKM_GSP_RUSD_POWER_GPU);
+static SENSOR_DEVICE_ATTR(power_gpu_average, 0444, rusd_show, NULL, NVKM_GSP_RUSD_POWER_GPU_AVG);
+static SENSOR_DEVICE_ATTR(power_board, 0444, rusd_show, NULL, NVKM_GSP_RUSD_POWER_BOARD);
+static SENSOR_DEVICE_ATTR(power_board_average, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_POWER_BOARD_AVG);
+static SENSOR_DEVICE_ATTR(power_vram_average, 0444, rusd_show, NULL, NVKM_GSP_RUSD_POWER_VRAM_AVG);
+static SENSOR_DEVICE_ATTR(power_cap, 0444, rusd_show, NULL, NVKM_GSP_RUSD_POWER_CAP);
+static SENSOR_DEVICE_ATTR(power_cpu, 0444, rusd_show, NULL, NVKM_GSP_RUSD_POWER_CPU);
+static SENSOR_DEVICE_ATTR(power_limit_requested, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_POWER_LIMIT_REQUESTED);
+static SENSOR_DEVICE_ATTR(clock_graphics, 0444, rusd_show, NULL, NVKM_GSP_RUSD_CLOCK_GRAPHICS);
+static SENSOR_DEVICE_ATTR(clock_memory, 0444, rusd_show, NULL, NVKM_GSP_RUSD_CLOCK_MEMORY);
+static SENSOR_DEVICE_ATTR(clock_video, 0444, rusd_show, NULL, NVKM_GSP_RUSD_CLOCK_VIDEO);
+static SENSOR_DEVICE_ATTR(clock_sm, 0444, rusd_show, NULL, NVKM_GSP_RUSD_CLOCK_SM);
+static SENSOR_DEVICE_ATTR(util_gpu, 0444, rusd_show, NULL, NVKM_GSP_RUSD_UTIL_GPU);
+static SENSOR_DEVICE_ATTR(util_memory, 0444, rusd_show, NULL, NVKM_GSP_RUSD_UTIL_MEMORY);
+static SENSOR_DEVICE_ATTR(util_nvenc, 0444, rusd_show, NULL, NVKM_GSP_RUSD_UTIL_NVENC);
+static SENSOR_DEVICE_ATTR(util_nvdec, 0444, rusd_show, NULL, NVKM_GSP_RUSD_UTIL_NVDEC);
+static SENSOR_DEVICE_ATTR(util_nvjpg, 0444, rusd_show, NULL, NVKM_GSP_RUSD_UTIL_NVJPG);
+static SENSOR_DEVICE_ATTR(util_nvofa, 0444, rusd_show, NULL, NVKM_GSP_RUSD_UTIL_NVOFA);
+static SENSOR_DEVICE_ATTR(util_nvenc_period, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_UTIL_NVENC_PERIOD);
+static SENSOR_DEVICE_ATTR(util_nvdec_period, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_UTIL_NVDEC_PERIOD);
+static SENSOR_DEVICE_ATTR(util_nvjpg_period, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_UTIL_NVJPG_PERIOD);
+static SENSOR_DEVICE_ATTR(util_nvofa_period, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_UTIL_NVOFA_PERIOD);
+static SENSOR_DEVICE_ATTR(pstate, 0444, rusd_show, NULL, NVKM_GSP_RUSD_PSTATE);
+static SENSOR_DEVICE_ATTR(throttle_status, 0444, rusd_show, NULL, NVKM_GSP_RUSD_THROTTLE_MASK);
+static SENSOR_DEVICE_ATTR(throttle_gpu_idle, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_GPU_IDLE);
+static SENSOR_DEVICE_ATTR(throttle_app_clock, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_APP_CLOCK);
+static SENSOR_DEVICE_ATTR(throttle_sw_power_cap, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_SW_POWER_CAP);
+static SENSOR_DEVICE_ATTR(throttle_hw_slowdown, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_HW_SLOWDOWN);
+static SENSOR_DEVICE_ATTR(throttle_sync_boost, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_SYNC_BOOST);
+static SENSOR_DEVICE_ATTR(throttle_sw_thermal, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_SW_THERMAL);
+static SENSOR_DEVICE_ATTR(throttle_hw_thermal, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_HW_THERMAL);
+static SENSOR_DEVICE_ATTR(throttle_hw_power_brake, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_HW_POWER_BRAKE);
+static SENSOR_DEVICE_ATTR(throttle_display_clock, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_THROTTLE_DISPLAY_CLOCK);
+static SENSOR_DEVICE_ATTR(ecc_total_ce_volatile, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_TOTAL_CE_VOL);
+static SENSOR_DEVICE_ATTR(ecc_total_ce_aggregate, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_TOTAL_CE_AGG);
+static SENSOR_DEVICE_ATTR(ecc_total_ue_volatile, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_TOTAL_UE_VOL);
+static SENSOR_DEVICE_ATTR(ecc_total_ue_aggregate, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_TOTAL_UE_AGG);
+static SENSOR_DEVICE_ATTR(ecc_dram_ce_volatile, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_DRAM_CE_VOL);
+static SENSOR_DEVICE_ATTR(ecc_dram_ce_aggregate, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_DRAM_CE_AGG);
+static SENSOR_DEVICE_ATTR(ecc_dram_ue_volatile, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_DRAM_UE_VOL);
+static SENSOR_DEVICE_ATTR(ecc_dram_ue_aggregate, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_DRAM_UE_AGG);
+static SENSOR_DEVICE_ATTR(ecc_sram_ce_volatile, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_SRAM_CE_VOL);
+static SENSOR_DEVICE_ATTR(ecc_sram_ce_aggregate, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_SRAM_CE_AGG);
+static SENSOR_DEVICE_ATTR(ecc_sram_ue_volatile, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_SRAM_UE_VOL);
+static SENSOR_DEVICE_ATTR(ecc_sram_ue_aggregate, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ECC_SRAM_UE_AGG);
+static SENSOR_DEVICE_ATTR(rowremap_histogram_max, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_HIST_MAX);
+static SENSOR_DEVICE_ATTR(rowremap_histogram_high, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_HIST_HIGH);
+static SENSOR_DEVICE_ATTR(rowremap_histogram_partial, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_HIST_PARTIAL);
+static SENSOR_DEVICE_ATTR(rowremap_histogram_low, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_HIST_LOW);
+static SENSOR_DEVICE_ATTR(rowremap_histogram_none, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_HIST_NONE);
+static SENSOR_DEVICE_ATTR(rowremap_correctable, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_CORRECTABLE);
+static SENSOR_DEVICE_ATTR(rowremap_uncorrectable, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_ROWREMAP_UNCORRECTABLE);
+static SENSOR_DEVICE_ATTR(rowremap_pending, 0444, rusd_show, NULL, NVKM_GSP_RUSD_ROWREMAP_PENDING);
+static SENSOR_DEVICE_ATTR(rowremap_failure, 0444, rusd_show, NULL, NVKM_GSP_RUSD_ROWREMAP_FAILURE);
+static SENSOR_DEVICE_ATTR(pcie_gen, 0444, rusd_show, NULL, NVKM_GSP_RUSD_PCIE_GEN);
+static SENSOR_DEVICE_ATTR(pcie_linecode_errors, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_LINECODE_ERRORS);
+static SENSOR_DEVICE_ATTR(pcie_crc_errors, 0444, rusd_show, NULL, NVKM_GSP_RUSD_PCIE_CRC_ERRORS);
+static SENSOR_DEVICE_ATTR(pcie_naks_received, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_NAKS_RECEIVED);
+static SENSOR_DEVICE_ATTR(pcie_failed_l0s_exits, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_FAILED_L0S_EXITS);
+static SENSOR_DEVICE_ATTR(pcie_correctable_errors, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_CORRECTABLE_ERRORS);
+static SENSOR_DEVICE_ATTR(pcie_nonfatal_errors, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_NONFATAL_ERRORS);
+static SENSOR_DEVICE_ATTR(pcie_fatal_errors, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_FATAL_ERRORS);
+static SENSOR_DEVICE_ATTR(pcie_unsupported_requests, 0444, rusd_show, NULL,
+			  NVKM_GSP_RUSD_PCIE_UNSUPPORTED_REQUESTS);
+
+static struct attribute *rusd_attrs[] = {
+	&sensor_dev_attr_temp_gpu.dev_attr.attr,
+	&sensor_dev_attr_temp_hbm.dev_attr.attr,
+	&sensor_dev_attr_power_gpu.dev_attr.attr,
+	&sensor_dev_attr_power_gpu_average.dev_attr.attr,
+	&sensor_dev_attr_power_board.dev_attr.attr,
+	&sensor_dev_attr_power_board_average.dev_attr.attr,
+	&sensor_dev_attr_power_vram_average.dev_attr.attr,
+	&sensor_dev_attr_power_cap.dev_attr.attr,
+	&sensor_dev_attr_power_cpu.dev_attr.attr,
+	&sensor_dev_attr_power_limit_requested.dev_attr.attr,
+	&sensor_dev_attr_clock_graphics.dev_attr.attr,
+	&sensor_dev_attr_clock_memory.dev_attr.attr,
+	&sensor_dev_attr_clock_video.dev_attr.attr,
+	&sensor_dev_attr_clock_sm.dev_attr.attr,
+	&sensor_dev_attr_util_gpu.dev_attr.attr,
+	&sensor_dev_attr_util_memory.dev_attr.attr,
+	&sensor_dev_attr_util_nvenc.dev_attr.attr,
+	&sensor_dev_attr_util_nvdec.dev_attr.attr,
+	&sensor_dev_attr_util_nvjpg.dev_attr.attr,
+	&sensor_dev_attr_util_nvofa.dev_attr.attr,
+	&sensor_dev_attr_util_nvenc_period.dev_attr.attr,
+	&sensor_dev_attr_util_nvdec_period.dev_attr.attr,
+	&sensor_dev_attr_util_nvjpg_period.dev_attr.attr,
+	&sensor_dev_attr_util_nvofa_period.dev_attr.attr,
+	&sensor_dev_attr_pstate.dev_attr.attr,
+	&sensor_dev_attr_throttle_status.dev_attr.attr,
+	&sensor_dev_attr_throttle_gpu_idle.dev_attr.attr,
+	&sensor_dev_attr_throttle_app_clock.dev_attr.attr,
+	&sensor_dev_attr_throttle_sw_power_cap.dev_attr.attr,
+	&sensor_dev_attr_throttle_hw_slowdown.dev_attr.attr,
+	&sensor_dev_attr_throttle_sync_boost.dev_attr.attr,
+	&sensor_dev_attr_throttle_sw_thermal.dev_attr.attr,
+	&sensor_dev_attr_throttle_hw_thermal.dev_attr.attr,
+	&sensor_dev_attr_throttle_hw_power_brake.dev_attr.attr,
+	&sensor_dev_attr_throttle_display_clock.dev_attr.attr,
+	&sensor_dev_attr_ecc_total_ce_volatile.dev_attr.attr,
+	&sensor_dev_attr_ecc_total_ce_aggregate.dev_attr.attr,
+	&sensor_dev_attr_ecc_total_ue_volatile.dev_attr.attr,
+	&sensor_dev_attr_ecc_total_ue_aggregate.dev_attr.attr,
+	&sensor_dev_attr_ecc_dram_ce_volatile.dev_attr.attr,
+	&sensor_dev_attr_ecc_dram_ce_aggregate.dev_attr.attr,
+	&sensor_dev_attr_ecc_dram_ue_volatile.dev_attr.attr,
+	&sensor_dev_attr_ecc_dram_ue_aggregate.dev_attr.attr,
+	&sensor_dev_attr_ecc_sram_ce_volatile.dev_attr.attr,
+	&sensor_dev_attr_ecc_sram_ce_aggregate.dev_attr.attr,
+	&sensor_dev_attr_ecc_sram_ue_volatile.dev_attr.attr,
+	&sensor_dev_attr_ecc_sram_ue_aggregate.dev_attr.attr,
+	&sensor_dev_attr_rowremap_histogram_max.dev_attr.attr,
+	&sensor_dev_attr_rowremap_histogram_high.dev_attr.attr,
+	&sensor_dev_attr_rowremap_histogram_partial.dev_attr.attr,
+	&sensor_dev_attr_rowremap_histogram_low.dev_attr.attr,
+	&sensor_dev_attr_rowremap_histogram_none.dev_attr.attr,
+	&sensor_dev_attr_rowremap_correctable.dev_attr.attr,
+	&sensor_dev_attr_rowremap_uncorrectable.dev_attr.attr,
+	&sensor_dev_attr_rowremap_pending.dev_attr.attr,
+	&sensor_dev_attr_rowremap_failure.dev_attr.attr,
+	&sensor_dev_attr_pcie_gen.dev_attr.attr,
+	&sensor_dev_attr_pcie_linecode_errors.dev_attr.attr,
+	&sensor_dev_attr_pcie_crc_errors.dev_attr.attr,
+	&sensor_dev_attr_pcie_naks_received.dev_attr.attr,
+	&sensor_dev_attr_pcie_failed_l0s_exits.dev_attr.attr,
+	&sensor_dev_attr_pcie_correctable_errors.dev_attr.attr,
+	&sensor_dev_attr_pcie_nonfatal_errors.dev_attr.attr,
+	&sensor_dev_attr_pcie_fatal_errors.dev_attr.attr,
+	&sensor_dev_attr_pcie_unsupported_requests.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group rusd_group = {
+	.name = "rusd",
+	.attrs = rusd_attrs,
+};
+
+int
+nouveau_sysfs_init(struct nouveau_drm *drm)
+{
+	int ret;
+
+	/*
+	 * Only GPUs running GSP with RUSD registered (r570+) get the group. On
+	 * everything else there is nothing to expose. All files appear when RUSD
+	 * is active. Sections unsupported on a given GPU read -ENODATA.
+	 *
+	 * The group is NOT devm-managed on drm->dev->dev: that device's devres
+	 * outlives nouveau's remove path (which frees the drm and nvkm/gsp
+	 * objects the files read), so it is torn down explicitly in
+	 * nouveau_sysfs_fini() before those objects go away.
+	 */
+	if (!nvkm_gsp_rusd(drm->nvkm->gsp))
+		return 0;
+
+	ret = device_add_group(drm->dev->dev, &rusd_group);
+	if (ret)
+		return ret;
+
+	drm->rusd_sysfs = true;
+	return 0;
+}
+
+void
+nouveau_sysfs_fini(struct nouveau_drm *drm)
+{
+	if (drm->rusd_sysfs) {
+		device_remove_group(drm->dev->dev, &rusd_group);
+		drm->rusd_sysfs = false;
+	}
+}
diff --git a/drivers/gpu/drm/nouveau/nouveau_sysfs.h b/drivers/gpu/drm/nouveau/nouveau_sysfs.h
new file mode 100644
index 000000000000..4acd1ea7d3f4
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nouveau_sysfs.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: MIT */
+#ifndef __NOUVEAU_SYSFS_H__
+#define __NOUVEAU_SYSFS_H__
+
+struct nouveau_drm;
+
+int nouveau_sysfs_init(struct nouveau_drm *drm);
+void nouveau_sysfs_fini(struct nouveau_drm *drm);
+
+#endif
-- 
2.55.0

