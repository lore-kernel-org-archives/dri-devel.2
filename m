Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB47606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E58311239D;
	Thu, 12 Nov 2026 22:59:44 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A26E1123DB
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:30 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8b394e2af9cso3469837b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524369; x=1795129169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W48jJQThRT2+vSxcBvF3bRGYkPdfTZRen2x+cqAGp90=;
 b=gQwjkRFYX1zK4XzfXxIKaN+YWe07pCJJY8fRgU6RGqHGlhwvRwSiR6J7QAJ0xaYbcv
 bSwF7t4XjwRngTv/CVj+XtdN63mfzZ6tS8+JWubdycB/0Jn6HM+YUtoF4InnaT/OzNNh
 A6hIzAw/W2WyWp+cMmDxKFmL6f6pT5iinnYN14hyhujkhmKiFnZaGsD8B+yQUdbVfbDM
 aQH85yNyttv/rhyhi+YLHiGL15GpSUD21rcQdEUj+8lD3+Pi3t1BTXwW3absCb7/YIu2
 MCBOFEcB4xCzh8a7WxIAJzPCXPlNxJ7fXgs3S3kZe+sTEkN24/XxQAWoFlTxmEdyiavC
 xlsg==
X-Gm-Message-State: APuU4Z91YYXQKT/aMIKEwhTVb5PLZJIWnybJa0qTB4GoevpG72RBNmtt
 aWqkE1def8ADUBfIZyjt00mz7WCKtdu9uGrZ/LkvHIvrRruMjuDLqrJS
X-Gm-Gg: AYBFou3sDWQnFEIYqrd89lTAuSwI/k2uUomFEsao5N13l0uT7OB79Kxbnru2zaUSfoT
 0ZTT/UmPYFoXFexbU0Q0wPvlbN1A59QQ4WBUtOQnOYWJookJEwr1DIK/iIA+5YAonML86xLKyLa
 HRdgB38IbaQJiKzlG6Dn/a5D2gdE620Rb4jFTOcuVGc14MI4vt4kzdfsWBkKrj0V2lup/z2TudX
 rNS3ltvpBB8nTDJ0C5rv61J+Htjr7/ctJkDt5Z/9mcOwKIi3L5RzENB5Yn17RykuyP283c1I5gL
 I6giHA9CtDhSisVwKmO9hRneWhvV6fcMSJuTWz8EDHWDgdsBY3eV0WgZ1UKt2cVJ2+bp7wC/1Tn
 udru7eLdGYxNYFYyAnOyjL0bvV4vgHdm1YDPsfsMw4xY6z7Z25RNXpOdFRVMclWCqAvxn7suyRa
 /GxYtGgqXUDebVYOQco3ukLNPOrFgi67BaLkFleA801KtR35q+OhOsyMmBoDZ2AiK4raWeWOFNT
 8W7emxv4tm+wnZAqUzDii8aQ46SJ19wihmSjUMZPNvHbXJz7ZpACF3urkCfxFFvTjsHw1JWrWuj
 MzPmfutTNOWgPz0K6ySIQOXGtnHk1nyg7nE0zNjOhm3c9RxPoVtBYV+uzUJMhAZgFNBhlwsX0CN
 dlkxZhMWBBNAhJBU2py4T8ftLBwHHEt5zg6Sp+y7ARGmlNcOQbXUCPHthnADyBtGst6M36l9TZy
 HtUXNOlUXvuBfZleBDTdViGnPTGPA=
X-Received: by 2002:a05:690c:f95:b0:8b3:3854:c28d with SMTP id
 00721157ae682-8b4aa23fdb0mr5592477b3.17.1794524368532; 
 Thu, 12 Nov 2026 14:59:28 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:28 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:59:02 -0500
Subject: [PATCH RFC 12/13] drm/powervr_sgx: Add the DRM driver, power
 management and debugging
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-12-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tie the parts together and build them.

- The DRM driver: the ioctls of the uAPI patch, render node only, on the
  SGX545 of the Intel Atom CE5300 (a PCI function, 8086:089b) and of
  Cedarview (GMA3600/3650, the auxiliary device gma500 publishes).
- The OMAP3630's SGX530 through the img,powervr-sgx device tree binding
  (DRM_POWERVR_SGX_OF), for bring-up only. It has one memory context,
  so the driver refuses it unless powervr_sgx.allow_unisolated=1 is set,
  and with it set clients aren't isolated from the firmware or from each
  other. It isn't for general use.
- Runtime PM: the microkernel powers off when the GPU is idle. System
  sleep drains the GPU, powers the microkernel off and starts it again
  after resume.
- fdinfo: each file's render-job time and its objects' memory.
- debugfs status and control blocks, and a devcoredump when a job hangs.
- The doorbell, the fault check, the reset and debugfs run under
  drm_dev_enter(), because behind gma500 the register mapping goes away
  with the auxiliary device at unbind.
- The Kconfig entry, which builds the driver.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/Kconfig                      |   1 +
 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/powervr_sgx/Kconfig          |  49 ++++
 drivers/gpu/drm/powervr_sgx/Makefile         |  34 +++
 drivers/gpu/drm/powervr_sgx/pvrsgx_aux.c     |  83 ++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.c |  78 ++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.h |  13 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_drv.c     | 378 +++++++++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_drv.h     |  52 ++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_dump.c    | 227 ++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_dump.h    |  16 ++
 drivers/gpu/drm/powervr_sgx/pvrsgx_of.c      | 119 +++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_pm.c      | 138 ++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_pm.h      |  30 +++
 14 files changed, 1219 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b..35217ddf8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -320,6 +320,7 @@ source "drivers/gpu/drm/hisilicon/Kconfig"
 source "drivers/gpu/drm/hyperv/Kconfig"
 source "drivers/gpu/drm/i915/Kconfig"
 source "drivers/gpu/drm/imagination/Kconfig"
+source "drivers/gpu/drm/powervr_sgx/Kconfig"
 source "drivers/gpu/drm/imx/Kconfig"
 source "drivers/gpu/drm/ingenic/Kconfig"
 source "drivers/gpu/drm/kmb/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a..d4e275b6f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -237,6 +237,7 @@ obj-y			+= solomon/
 obj-$(CONFIG_DRM_SPRD) += sprd/
 obj-$(CONFIG_DRM_LOONGSON) += loongson/
 obj-$(CONFIG_DRM_POWERVR) += imagination/
+obj-$(CONFIG_DRM_POWERVR_SGX) += powervr_sgx/
 obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon/
 
 # Ensure drm headers are self-contained and pass kernel-doc
diff --git a/drivers/gpu/drm/powervr_sgx/Kconfig b/drivers/gpu/drm/powervr_sgx/Kconfig
new file mode 100644
index 000000000..dbbba1d68
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/Kconfig
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2026 Joseph Telaak
+
+config DRM_POWERVR_SGX
+	tristate "PowerVR SGX5xx (SGX545: Intel CE5300, Cedarview)"
+	depends on DRM && PCI && MMU && (X86 || ARM || COMPILE_TEST)
+	select DRM_EXEC
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_GPUVM
+	select DRM_SCHED
+	select CRC32
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  Render-only DRM driver for PowerVR SGX5xx GPUs. It supports the
+	  SGX545 of the Intel Atom CE5300 media processors, where the GPU is
+	  its own PCI function (8086:089b), and of Cedarview (GMA3600/3650,
+	  with DRM_POWERVR_SGX_GMA500). The GPU runs a microkernel loaded
+	  with request_firmware().
+
+	  Not compatible with the out-of-tree PowerVR services driver
+	  (SGX545_CE): bind one or the other.
+
+	  If M is selected the module will be called powervr_sgx.
+
+config DRM_POWERVR_SGX_GMA500
+	bool "Cedarview SGX545, behind gma500"
+	depends on DRM_POWERVR_SGX && DRM_GMA500
+	select AUXILIARY_BUS
+	help
+	  Bind to the SGX545 of the Atom D2000/N2000 (Cedarview) GPU. There
+	  the SGX shares a PCI function with the display, which gma500
+	  drives; gma500 publishes the SGX as an auxiliary device, hands it
+	  the register mapping and forwards its interrupt.
+
+	  Say Y if this kernel runs on a Cedarview machine.
+
+config DRM_POWERVR_SGX_OF
+	bool "SGX on device tree SoCs (TI OMAP3630 SGX530)"
+	depends on DRM_POWERVR_SGX && OF
+	help
+	  Bind to an SGX described by the img,powervr-sgx device tree
+	  binding. Only parts whose GPU node sits in a ti-sysc module, which
+	  clocks and powers it, are handled: the OMAP3630's SGX530. Its
+	  clients aren't isolated from the firmware or from each other, so
+	  the driver runs it only with powervr_sgx.allow_unisolated=1, for
+	  bring-up. Dma-buf import isn't supported on ARM yet.
+
+	  Say N unless this kernel is for such an SoC.
diff --git a/drivers/gpu/drm/powervr_sgx/Makefile b/drivers/gpu/drm/powervr_sgx/Makefile
new file mode 100644
index 000000000..b441281ca
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/Makefile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2026 Joseph Telaak
+
+CFLAGS_pvrsgx_trace.o := -I$(src)
+
+powervr_sgx-y := \
+	pvrsgx_ccb.o \
+	pvrsgx_core.o \
+	pvrsgx_device.o \
+	pvrsgx_drv.o \
+	pvrsgx_dump.o \
+	pvrsgx_fw.o \
+	pvrsgx_gem.o \
+	pvrsgx_job.o \
+	pvrsgx_kobj.o \
+	pvrsgx_mmu.o \
+	pvrsgx_pds.o \
+	pvrsgx_prime.o \
+	pvrsgx_render.o \
+	pvrsgx_transfer.o \
+	pvrsgx_trace.o \
+	pvrsgx_usse.o \
+	pvrsgx_validate.o \
+	pvrsgx_vm.o \
+	pvrsgx_cmd_checks.o \
+	pvrsgx_cmd.o \
+	pvrsgx_cmd_defs.o
+
+powervr_sgx-$(CONFIG_DEBUG_FS) += pvrsgx_debugfs.o
+powervr_sgx-$(CONFIG_PM) += pvrsgx_pm.o
+powervr_sgx-$(CONFIG_DRM_POWERVR_SGX_GMA500) += pvrsgx_aux.o
+powervr_sgx-$(CONFIG_DRM_POWERVR_SGX_OF) += pvrsgx_of.o
+
+obj-$(CONFIG_DRM_POWERVR_SGX) += powervr_sgx.o
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_aux.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_aux.c
new file mode 100644
index 000000000..61648497d
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_aux.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The SGX545 of a Cedarview GPU (GMA3600/3650). It shares the PCI function and
+ * register BAR with the display engine, which gma500 drives; gma500 publishes
+ * the SGX as the auxiliary device "gma500_gfx.sgx" with its register window mapped
+ * and hands over its interrupt; it never touches the SGX itself
+ * (include/drm/gma500_sgx.h).
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+
+#include <drm/gma500_sgx.h>
+
+#include "pvrsgx_device.h"
+#include "pvrsgx_pm.h"
+#include "pvrsgx_drv.h"
+
+static int pvrsgx_aux_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
+{
+	struct gma500_sgx_device *gma = to_gma500_sgx_device(adev);
+	struct device *dev = &adev->dev;
+	struct pvrsgx_device *sdev;
+	int err;
+
+	if (!gma->regs || gma->regs_len < PVRSGX_REGS_MIN || !dev_is_pci(dev->parent)) {
+		dev_err(dev, "unexpected SGX register window (%pa bytes); not touching it\n",
+			&gma->regs_len);
+		return -ENODEV;
+	}
+
+	sdev = pvrsgx_alloc(dev);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+	/* The SGX does DMA as the GPU's PCI function: no device of its own. */
+	drm_dev_set_dma_dev(&sdev->base, dev->parent);
+	sdev->gma_sgx = gma;
+	sdev->family = pvrsgx_core_family_get(gma->core);
+	sdev->regs = gma->regs;
+	sdev->irq = to_pci_dev(dev->parent)->irq;
+	auxiliary_set_drvdata(adev, sdev);
+
+	/* The graphics island is up only while gma500 is. */
+	err = pm_runtime_resume_and_get(dev->parent);
+	if (err)
+		return err;
+	err = pvrsgx_probe_common(sdev);
+	pm_runtime_put(dev->parent);
+	return err;
+}
+
+static void pvrsgx_aux_remove(struct auxiliary_device *adev)
+{
+	pvrsgx_remove_common(auxiliary_get_drvdata(adev));
+}
+
+static const struct auxiliary_device_id pvrsgx_aux_ids[] = {
+	{ .name = "gma500_gfx.sgx" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, pvrsgx_aux_ids);
+
+static struct auxiliary_driver pvrsgx_aux_driver = {
+	.name = "sgx",
+	.probe = pvrsgx_aux_probe,
+	.remove = pvrsgx_aux_remove,
+	.id_table = pvrsgx_aux_ids,
+	.driver.pm = pm_ptr(&pvrsgx_pm_ops),
+};
+
+int pvrsgx_aux_register(void)
+{
+	return auxiliary_driver_register(&pvrsgx_aux_driver);
+}
+
+void pvrsgx_aux_unregister(void)
+{
+	auxiliary_driver_unregister(&pvrsgx_aux_driver);
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.c
new file mode 100644
index 000000000..99f1b7a8c
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+#include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_print.h>
+
+#include <linux/debugfs.h>
+#include <linux/ktime.h>
+#include <linux/pm_runtime.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
+#include "pvrsgx_debugfs.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_dump.h"
+#include "pvrsgx_fw.h"
+
+/*
+ * The registers only while the device is still bound and already awake:
+ * reading never resumes the GPU, and a suspend can't start under the read.
+ */
+static int status_show(struct seq_file *m, void *unused)
+{
+	struct drm_debugfs_entry *entry = m->private;
+	struct pvrsgx_device *sdev = to_pvrsgx_device(entry->dev);
+	struct seq_buf sb;
+	char *buf = kmalloc(SZ_4K, GFP_KERNEL);
+	int idx, awake;
+
+	if (!buf)
+		return -ENOMEM;
+	if (!drm_dev_enter(entry->dev, &idx)) {
+		kfree(buf);
+		return -ENODEV;
+	}
+	/* -EINVAL: runtime PM is off and the device always on. */
+	awake = pm_runtime_get_if_active(sdev->base.dev);
+	seq_buf_init(&sb, buf, SZ_4K);
+	pvrsgx_dump_status(&sb, sdev, awake > 0 || awake == -EINVAL);
+	if (awake > 0)
+		pm_runtime_put(sdev->base.dev);
+	drm_dev_exit(idx);
+	seq_puts(m, seq_buf_str(&sb));
+	kfree(buf);
+	return 0;
+}
+
+/* The microkernel's control blocks, raw, with a timestamp: memory only, so safe to poll. */
+static int ctlblk_show(struct seq_file *m, void *unused)
+{
+	struct drm_debugfs_entry *entry = m->private;
+	struct pvrsgx_device *sdev = to_pvrsgx_device(entry->dev);
+	struct seq_buf sb;
+	char *buf = kmalloc(SZ_2K, GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+	seq_buf_init(&sb, buf, SZ_2K);
+	seq_buf_printf(&sb, "t %lld gen %u\n", ktime_get_ns(), READ_ONCE(sdev->fw_gen));
+	pvrsgx_fw_dump(&sb, sdev, PVRSGX_FW_TA3DCTL, "ta3dctl");
+	pvrsgx_fw_dump(&sb, sdev, PVRSGX_FW_HOSTCTL, "hostctl");
+	seq_puts(m, seq_buf_str(&sb));
+	kfree(buf);
+	return 0;
+}
+
+static const struct drm_debugfs_info pvrsgx_debugfs_list[] = {
+	{ "status", status_show, 0 },
+	{ "ctlblk", ctlblk_show, 0 },
+};
+
+void pvrsgx_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_add_files(minor->dev, pvrsgx_debugfs_list, ARRAY_SIZE(pvrsgx_debugfs_list));
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.h
new file mode 100644
index 000000000..9bdc9a43c
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_DEBUGFS_H
+#define PVRSGX_DEBUGFS_H
+
+struct drm_minor;
+
+#if defined(CONFIG_DEBUG_FS)
+void pvrsgx_debugfs_init(struct drm_minor *minor);
+#endif
+
+#endif /* PVRSGX_DEBUGFS_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.c
new file mode 100644
index 000000000..fe996a17f
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_prime.h>
+#include <drm/drm_print.h>
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_debugfs.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_drv.h"
+#include "pvrsgx_pm.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_gem.h"
+#include "pvrsgx_job.h"
+#include "pvrsgx_prime.h"
+#include "pvrsgx_render.h"
+#include "pvrsgx_validate.h"
+#include "pvrsgx_vm.h"
+
+/* Elements are copied at min(stride, obj_size); a longer input tail must be zero. */
+void *pvrsgx_obj_array_get(const struct drm_powervr_sgx_obj_array *in, u32 obj_size,
+			   u32 max_count)
+{
+	u8 __user *src = u64_to_user_ptr(in->array);
+	u8 *out;
+
+	if (!in->count)
+		return NULL;
+	if (!in->stride || in->count > max_count)
+		return ERR_PTR(-EINVAL);
+
+	out = kvcalloc(in->count, obj_size, GFP_KERNEL);
+	if (!out)
+		return ERR_PTR(-ENOMEM);
+	for (u32 i = 0; i < in->count; i++) {
+		int err = copy_struct_from_user(out + (size_t)i * obj_size, obj_size,
+						src + (size_t)i * in->stride, in->stride);
+
+		if (err) {
+			kvfree(out);
+			/* -E2BIG: a larger struct this kernel doesn't know. */
+			return ERR_PTR(err);
+		}
+	}
+	return out;
+}
+
+int pvrsgx_obj_array_put(const struct drm_powervr_sgx_obj_array *out, const void *src,
+			 u32 obj_size, u32 count)
+{
+	u8 __user *dst = u64_to_user_ptr(out->array);
+	u32 n = min(out->count, count), len = min(out->stride, obj_size);
+
+	if (!out->stride)
+		return -EINVAL;
+	for (u32 i = 0; i < n; i++) {
+		if (copy_to_user(dst + (size_t)i * out->stride,
+				 (const u8 *)src + (size_t)i * obj_size, len))
+			return -EFAULT;
+		if (out->stride > len &&
+		    clear_user(dst + (size_t)i * out->stride + len, out->stride - len))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+/* Copy a fixed-size query result: min of both sizes out, the kernel's size back. */
+static int query_put(void __user *ptr, u32 *size, const void *val, u32 len)
+{
+	if (ptr && copy_to_user(ptr, val, min(*size, len)))
+		return -EFAULT;
+	*size = ptr ? min(*size, len) : len;
+	return 0;
+}
+
+static int pvrsgx_ioctl_dev_query(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_dev_query_args *args = data;
+	struct pvrsgx_device *sdev = to_pvrsgx_device(drm);
+	void __user *ptr = u64_to_user_ptr(args->pointer);
+
+	switch (args->type) {
+	case DRM_POWERVR_SGX_DEV_QUERY_GPU_INFO_GET: {
+		struct drm_powervr_sgx_dev_query_gpu_info info = {
+			.core_id = sdev->core_id,
+			.core_revision = sdev->core_rev,
+			.fw_interface_version = sdev->fw.interface,
+		};
+
+		return query_put(ptr, &args->size, &info, sizeof(info));
+	}
+	case DRM_POWERVR_SGX_DEV_QUERY_LIMITS_GET: {
+		/*
+		 * Render-target limits are not documented: these are the sizes
+		 * known to work, to be raised when larger targets are tested.
+		 */
+		struct drm_powervr_sgx_dev_query_limits lim = {
+			.rt_max_width = 2048,
+			.rt_max_height = 2048,
+			.rt_max_samples = sdev->family->cmds->max_samples,
+			.pb_min_pages = 0x100,
+			.pb_default_pages = PVRSGX_PB_DEFAULT_PAGES,
+			.pb_max_pages = pvrsgx_heaps(sdev)->pb_max_pages,
+			.max_ta_kicks = PVRSGX_MAX_TA_KICKS,
+			.va_bits = sdev->family->va_bits,
+			.caps = DRM_POWERVR_SGX_CAP_BACKWARD_BLITS,
+			.max_layers = 1,
+		};
+
+		return query_put(ptr, &args->size, &lim, sizeof(lim));
+	}
+	case DRM_POWERVR_SGX_DEV_QUERY_QUIRKS_GET: {
+		struct drm_powervr_sgx_dev_query_quirks q = {};
+		int err;
+
+		if (ptr) {
+			err = copy_struct_from_user(&q, sizeof(q), ptr, args->size);
+			if (err)
+				return err;
+			if (q._padding_c)
+				return -EINVAL;
+		}
+		/* No erratum that reaches userspace is known for these cores. */
+		q.count = 0;
+		q.musthave_count = 0;
+		return query_put(ptr, &args->size, &q, sizeof(q));
+	}
+	case DRM_POWERVR_SGX_DEV_QUERY_HEAP_INFO_GET:
+		return pvrsgx_query_heap_info(sdev, ptr, &args->size);
+	case DRM_POWERVR_SGX_DEV_QUERY_COMMANDS_GET: {
+		const struct pvrsgx_cmd_def *render = pvrsgx_cmd_def(sdev, PVRSGX_CMD_RENDER);
+		const struct pvrsgx_cmd_def *kick = pvrsgx_cmd_def(sdev, PVRSGX_CMD_TA_KICK);
+		const struct pvrsgx_cmd_def *xfer = pvrsgx_cmd_def(sdev, PVRSGX_CMD_TRANSFER);
+		struct drm_powervr_sgx_dev_query_commands c = {
+			.job_types = BIT(DRM_POWERVR_SGX_JOB_TYPE_NULL),
+		};
+
+		/* A render needs its kicks too; an unsupported command is refused. */
+		if (render && render->supported && kick && kick->supported)
+			c.job_types |= BIT(DRM_POWERVR_SGX_JOB_TYPE_RENDER);
+		if (xfer && xfer->supported)
+			c.job_types |= BIT(DRM_POWERVR_SGX_JOB_TYPE_TRANSFER);
+		c.render_exts = render ? pvrsgx_cmd_ext_mask(render) : 0;
+		c.ta_kick_exts = kick ? pvrsgx_cmd_ext_mask(kick) : 0;
+		c.transfer_exts = xfer ? pvrsgx_cmd_ext_mask(xfer) : 0;
+		return query_put(ptr, &args->size, &c, sizeof(c));
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pvrsgx_open(struct drm_device *drm, struct drm_file *file)
+{
+	struct pvrsgx_file *sfile = kzalloc_obj(*sfile);
+
+	if (!sfile)
+		return -ENOMEM;
+	sfile->usage = pvrsgx_usage_new();
+	if (!sfile->usage) {
+		kfree(sfile);
+		return -ENOMEM;
+	}
+	sfile->sdev = to_pvrsgx_device(drm);
+	xa_init_flags(&sfile->vms, XA_FLAGS_ALLOC1);
+	xa_init_flags(&sfile->contexts, XA_FLAGS_ALLOC1);
+	xa_init_flags(&sfile->rtds, XA_FLAGS_ALLOC1);
+	file->driver_priv = sfile;
+	return 0;
+}
+
+static void pvrsgx_postclose(struct drm_device *drm, struct drm_file *file)
+{
+	struct pvrsgx_file *sfile = to_pvrsgx_file(file);
+
+	pvrsgx_rtds_destroy_all(sfile);
+	pvrsgx_context_destroy_all(sfile);
+	pvrsgx_vm_destroy_all(sfile);
+	xa_destroy(&sfile->rtds);
+	xa_destroy(&sfile->contexts);
+	xa_destroy(&sfile->vms);
+	pvrsgx_usage_put(sfile->usage);
+	kfree(sfile);
+	file->driver_priv = NULL;
+}
+
+#define IOCTL(n, f) DRM_IOCTL_DEF_DRV(POWERVR_SGX_##n, f, DRM_RENDER_ALLOW)
+
+static const struct drm_ioctl_desc pvrsgx_ioctls[] = {
+	IOCTL(DEV_QUERY, pvrsgx_ioctl_dev_query),
+	IOCTL(CREATE_BO, pvrsgx_ioctl_create_bo),
+	IOCTL(GET_BO_MMAP_OFFSET, pvrsgx_ioctl_get_bo_mmap_offset),
+	IOCTL(CREATE_VM_CONTEXT, pvrsgx_ioctl_create_vm_context),
+	IOCTL(DESTROY_VM_CONTEXT, pvrsgx_ioctl_destroy_vm_context),
+	IOCTL(VM_BIND, pvrsgx_ioctl_vm_bind),
+	IOCTL(CREATE_CONTEXT, pvrsgx_ioctl_create_context),
+	IOCTL(DESTROY_CONTEXT, pvrsgx_ioctl_destroy_context),
+	IOCTL(GET_CONTEXT_STATE, pvrsgx_ioctl_get_context_state),
+	IOCTL(CREATE_RT_DATASET, pvrsgx_ioctl_create_rt_dataset),
+	IOCTL(DESTROY_RT_DATASET, pvrsgx_ioctl_destroy_rt_dataset),
+	IOCTL(SUBMIT_JOBS, pvrsgx_ioctl_submit_jobs),
+	IOCTL(UPLOAD_CODE, pvrsgx_ioctl_upload_code),
+};
+
+/* drm-usage-stats.rst: the file's render time and its objects' memory. */
+static void pvrsgx_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct pvrsgx_file *sfile = to_pvrsgx_file(file);
+
+	drm_printf(p, "drm-engine-render:\t%llu ns\n",
+		   (u64)atomic64_read(&sfile->usage->render_ns));
+	drm_show_memory_stats(p, file);
+}
+
+static const struct file_operations pvrsgx_fops = {
+	.owner = THIS_MODULE,
+	DRM_GEM_FOPS,
+	.show_fdinfo = drm_show_fdinfo,
+};
+
+static const struct drm_driver pvrsgx_drm_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_RENDER | DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE,
+	.open = pvrsgx_open,
+	.postclose = pvrsgx_postclose,
+	.ioctls = pvrsgx_ioctls,
+	.num_ioctls = ARRAY_SIZE(pvrsgx_ioctls),
+	.fops = &pvrsgx_fops,
+	.show_fdinfo = pvrsgx_show_fdinfo,
+#if defined(CONFIG_DEBUG_FS)
+	.debugfs_init = pvrsgx_debugfs_init,
+#endif
+	.gem_create_object = pvrsgx_gem_create_object,
+	.gem_prime_import_sg_table = pvrsgx_prime_import_sg_table,
+
+	.name = PVRSGX_DRIVER_NAME,
+	.desc = PVRSGX_DRIVER_DESC,
+	.major = PVRSGX_DRIVER_MAJOR,
+	.minor = PVRSGX_DRIVER_MINOR,
+};
+
+struct pvrsgx_device *pvrsgx_alloc(struct device *dev)
+{
+	return devm_drm_dev_alloc(dev, &pvrsgx_drm_driver, struct pvrsgx_device, base);
+}
+
+/* What both buses do once the registers are mapped and the interrupt source known. */
+int pvrsgx_probe_common(struct pvrsgx_device *sdev)
+{
+	int err;
+
+	err = pvrsgx_device_init(sdev);
+	if (err)
+		return err;
+
+	/* Runtime PM is set up before userspace can reach the device. */
+	pvrsgx_power_init(sdev);
+	err = drm_dev_register(&sdev->base, 0);
+	if (err) {
+		pvrsgx_power_fini(sdev);
+		pvrsgx_device_unplug(sdev);
+	}
+	return err;
+}
+
+void pvrsgx_remove_common(struct pvrsgx_device *sdev)
+{
+	/* No new ioctl, and the running ones done, before the hardware goes. */
+	drm_dev_unplug(&sdev->base);
+	pvrsgx_power_fini(sdev);
+	pvrsgx_device_unplug(sdev);
+}
+
+static int pvrsgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct pvrsgx_device *sdev;
+	int err;
+
+	err = pcim_enable_device(pdev);
+	if (err)
+		return err;
+	pci_set_master(pdev);
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+	/* The GPU's MMU maps page by page: any segment length will do. */
+	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
+
+	sdev = pvrsgx_alloc(&pdev->dev);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+	sdev->pdev = pdev;
+	sdev->family = pvrsgx_core_family_get(id->driver_data);
+	sdev->irq = pdev->irq;
+	pci_set_drvdata(pdev, sdev);
+
+	if (pci_resource_len(pdev, 0) < PVRSGX_REGS_MIN)
+		return -ENODEV;
+	sdev->regs = pcim_iomap_region(pdev, 0, PVRSGX_DRIVER_NAME);
+	if (IS_ERR(sdev->regs))
+		return PTR_ERR(sdev->regs);
+
+	return pvrsgx_probe_common(sdev);
+}
+
+static void pvrsgx_remove(struct pci_dev *pdev)
+{
+	pvrsgx_remove_common(pci_get_drvdata(pdev));
+}
+
+static void pvrsgx_shutdown(struct pci_dev *pdev)
+{
+	struct pvrsgx_device *sdev = pci_get_drvdata(pdev);
+
+	/* Leave the GPU quiet for whatever runs next. */
+	pvrsgx_fw_stop(sdev);
+}
+
+static const struct pci_device_id pvrsgx_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x089b), 545 },	/* CE5300 family: SGX545 */
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, pvrsgx_pci_ids);
+
+static struct pci_driver pvrsgx_pci_driver = {
+	.name = PVRSGX_DRIVER_NAME,
+	.id_table = pvrsgx_pci_ids,
+	.probe = pvrsgx_probe,
+	.remove = pvrsgx_remove,
+	.shutdown = pvrsgx_shutdown,
+	.driver.pm = pm_ptr(&pvrsgx_pm_ops),
+};
+
+static int __init pvrsgx_init(void)
+{
+	int err = pci_register_driver(&pvrsgx_pci_driver);
+
+	if (err)
+		return err;
+	err = pvrsgx_aux_register();
+	if (err)
+		goto err_pci;
+	err = pvrsgx_of_register();
+	if (err)
+		goto err_aux;
+	return 0;
+
+err_aux:
+	pvrsgx_aux_unregister();
+err_pci:
+	pci_unregister_driver(&pvrsgx_pci_driver);
+	return err;
+}
+module_init(pvrsgx_init);
+
+static void __exit pvrsgx_exit(void)
+{
+	pvrsgx_of_unregister();
+	pvrsgx_aux_unregister();
+	pci_unregister_driver(&pvrsgx_pci_driver);
+}
+module_exit(pvrsgx_exit);
+
+MODULE_AUTHOR("Joseph Telaak <joseph@telaak.dev>");
+MODULE_DESCRIPTION("PowerVR SGX5xx DRM driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.h
new file mode 100644
index 000000000..a6acc5234
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_DRV_H
+#define PVRSGX_DRV_H
+
+#include <linux/types.h>
+
+#define PVRSGX_DRIVER_NAME	"powervr_sgx"
+#define PVRSGX_DRIVER_DESC	"PowerVR SGX5xx"
+#define PVRSGX_DRIVER_MAJOR	1
+#define PVRSGX_DRIVER_MINOR	0
+
+#define PVRSGX_BO_FLAGS_MASK		(DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS | \
+					 DRM_POWERVR_SGX_BO_CODE)
+#define PVRSGX_SYNC_OP_FLAGS_MASK	(DRM_POWERVR_SGX_SYNC_OP_FLAG_HANDLE_TYPE_MASK | \
+					 DRM_POWERVR_SGX_SYNC_OP_FLAG_SIGNAL)
+
+/* The registers this driver touches all lie below this offset. */
+#define PVRSGX_REGS_MIN			0x4000
+
+struct device;
+struct dev_pm_ops;
+struct drm_powervr_sgx_obj_array;
+struct pvrsgx_device;
+
+struct pvrsgx_device *pvrsgx_alloc(struct device *dev);
+int pvrsgx_probe_common(struct pvrsgx_device *sdev);
+void pvrsgx_remove_common(struct pvrsgx_device *sdev);
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
+int pvrsgx_aux_register(void);
+void pvrsgx_aux_unregister(void);
+#else
+static inline int pvrsgx_aux_register(void) { return 0; }
+static inline void pvrsgx_aux_unregister(void) { }
+#endif
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_OF)
+int pvrsgx_of_register(void);
+void pvrsgx_of_unregister(void);
+#else
+static inline int pvrsgx_of_register(void) { return 0; }
+static inline void pvrsgx_of_unregister(void) { }
+#endif
+
+void *pvrsgx_obj_array_get(const struct drm_powervr_sgx_obj_array *in, u32 obj_size,
+			   u32 max_count);
+int pvrsgx_obj_array_put(const struct drm_powervr_sgx_obj_array *out, const void *src,
+			 u32 obj_size, u32 count);
+
+#endif /* PVRSGX_DRV_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_dump.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_dump.c
new file mode 100644
index 000000000..e37d48432
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_dump.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Device state as text: debugfs "status", and the devcoredump taken when a
+ * job hangs (/sys/class/devcoredump/devcd<N>/data; write to it to free it).
+ */
+
+#include <drm/drm_print.h>
+
+#include <linux/bitfield.h>
+#include <linux/devcoredump.h>
+#include <linux/seq_buf.h>
+#include <linux/vmalloc.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_ccb.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_dump.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_kobj.h"
+#include "pvrsgx_job.h"
+#include "pvrsgx_mmu.h"
+#include "pvrsgx_render.h"
+#include "pvrsgx_vm.h"
+
+/* Registers safe to read while the clocks are on. */
+static void dump_regs(struct seq_buf *sb, struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+	u32 edm = pvrsgx_dirlist_edm(sdev), lists = sdev->family->num_dir_lists;
+	const struct {
+		const char *name;
+		u32 reg;
+	} regs[] = {
+		{ "CLKGATECTL", SGX_CR_CLKGATECTL },
+		{ "CLKGATECTL2", cr->clkgatectl2 },
+		{ "CLKGATESTATUS", cr->clkgatestatus },
+		{ "CORE_ID", cr->core_id },
+		{ "CORE_REVISION", cr->core_revision },
+		{ "SOFT_RESET", SGX_CR_SOFT_RESET },
+		{ "EVENT_STATUS", SGX_CR_EVENT_STATUS },
+		{ "EVENT_STATUS2", SGX_CR_EVENT_STATUS2 },
+		{ "EVENT_HOST_ENABLE", SGX_CR_EVENT_HOST_ENABLE },
+		{ "EVENT_HOST_ENABLE2", SGX_CR_EVENT_HOST_ENABLE2 },
+		{ "BIF_CTRL", SGX_CR_BIF_CTRL },
+		{ "BIF_INT_STAT", SGX_CR_BIF_INT_STAT },
+		{ "BIF_FAULT", SGX_CR_BIF_FAULT },
+		{ "BIF_BANK0", cr->bif_bank0 },
+		{ "BIF_DIR_LIST_BASE0", SGX_CR_BIF_DIR_LIST_BASE0 },
+		{ "BIF_DIR_LIST_BASE1", lists > 1 ? SGX_CR_BIF_DIR_LIST_BASE1 : 0 },
+		{ "BIF_DIR_LIST_BASE2", lists > 2 ? SGX_CR_BIF_DIR_LIST_BASE1 + 4 : 0 },
+		{ NULL, edm ? sgx_cr_bif_dir_list_base(edm) : 0 },
+		{ "EDM_TASK_REG0", cr->edm_task_reg0 },
+		{ "EDM_TASK_REG1", cr->edm_task_reg1 },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(regs); i++) {
+		char name[24];
+
+		/* 0 is a register this core lacks; only CLKGATECTL, the first, sits there. */
+		if (i && !regs[i].reg)
+			continue;
+		if (regs[i].name)
+			strscpy(name, regs[i].name);
+		else
+			snprintf(name, sizeof(name), "BIF_DIR_LIST_BASE%u", edm);
+		seq_buf_printf(sb, "%-20s 0x%04x 0x%08x\n", name, regs[i].reg,
+			       sgx_rd(sdev, regs[i].reg));
+	}
+}
+
+void pvrsgx_dump_status(struct seq_buf *sb, struct pvrsgx_device *sdev, bool regs)
+{
+	u32 *ctl = sdev->fw.cpu[PVRSGX_FW_CCBCTL];
+	struct pvrsgx_kobj_counts kc;
+
+	seq_buf_printf(sb, "firmware running: %d lost: %d resets: %u irqs: %d\n", sdev->fw_running,
+		       sdev->lost, sdev->reset_count, atomic_read(&sdev->irq_count));
+	seq_buf_printf(sb, "kernel PD 0x%08x idle PD 0x%08x\n",
+		       pvrsgx_mmu_pd_addr(sdev->kernel_mmu),
+		       pvrsgx_mmu_pd_addr(pvrsgx_idle_mmu(sdev)));
+	seq_buf_printf(sb, "ccb wo %u ro %u issued %llu consumed %llu\n", READ_ONCE(ctl[0]),
+		       READ_ONCE(ctl[1]), sdev->ccb_issued, pvrsgx_ccb_consumed(sdev));
+	seq_buf_printf(sb, "hostctl init 0x%x power 0x%x uk-lockups %u ",
+		       pvrsgx_fw_hostctl(sdev, HOSTCTL_INIT_STATUS),
+		       pvrsgx_fw_hostctl(sdev, HOSTCTL_POWER_STATUS),
+		       pvrsgx_fw_hostctl(sdev, HOSTCTL_UK_LOCKUPS));
+	seq_buf_printf(sb, "int 0x%x/0x%x assert 0x%x\n",
+		       pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_FLAGS),
+		       pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_CLEAR),
+		       pvrsgx_fw_hostctl(sdev, HOSTCTL_ASSERT_FAIL));
+	seq_buf_printf(sb, "powered: %d\n", READ_ONCE(sdev->powered));
+	if (pvrsgx_kobj_pending(sdev, &kc))
+		seq_buf_printf(sb, "kobjs graveyard %u (%llu pages) unmapped %u (%llu pages)\n",
+			       kc.graveyard, kc.graveyard_pages, kc.unmapped, kc.unmapped_pages);
+	seq_buf_printf(sb, "client unmaps waiting for the invalidate %u\n",
+		       pvrsgx_ccb_inval_pending(sdev));
+	/* After a failed start the clocks are still on; after a stop they are not. */
+	if (!regs || !READ_ONCE(sdev->powered))
+		return;
+	dump_regs(sb, sdev);
+}
+
+#define COREDUMP_BYTES	SZ_128K
+
+static void dump_lookup(struct seq_buf *sb, const char *name, struct pvrsgx_mmu *mmu, u32 addr)
+{
+	u32 pde, pte;
+
+	if (!mmu)
+		return;
+	if (pvrsgx_mmu_lookup(mmu, addr, &pde, &pte))
+		seq_buf_printf(sb, "  %s directory 0x%08x: pde 0x%08x pte 0x%08x\n", name,
+			       pvrsgx_mmu_pd_addr(mmu), pde, pte);
+	else
+		seq_buf_printf(sb, "  %s directory 0x%08x: busy\n", name, pvrsgx_mmu_pd_addr(mmu));
+}
+
+/*
+ * What the BIF was set to, and how each directory the job could have used
+ * translates the faulting address. After a start, so every register is safe
+ * to read.
+ */
+static void dump_bif(struct seq_buf *sb, struct pvrsgx_device *sdev, struct pvrsgx_job *bad)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+	u32 stat = sgx_rd(sdev, SGX_CR_BIF_INT_STAT);
+	u32 addr = sgx_rd(sdev, SGX_CR_BIF_FAULT) & cr->bif_fault_addr;
+
+	if (cr->bif_bank0)
+		seq_buf_printf(sb, "BIF: bank set 0x%08x bank0 0x%08x mem req 0x%08x\n",
+			       sgx_rd(sdev, cr->bif_bank_set), sgx_rd(sdev, cr->bif_bank0),
+			       sgx_rd(sdev, SGX_CR_BIF_MEM_REQ_STAT));
+	else
+		seq_buf_printf(sb, "BIF: mem req 0x%08x\n", sgx_rd(sdev, SGX_CR_BIF_MEM_REQ_STAT));
+	for (unsigned int i = 0; i < sdev->family->num_dir_lists; i++)
+		seq_buf_printf(sb, "  dir list %2u: 0x%08x\n", i,
+			       sgx_rd(sdev, sgx_cr_bif_dir_list_base(i)));
+	for (unsigned int i = 0; i < 16; i++)
+		seq_buf_printf(sb, "  use code base %2u: 0x%08x\n", i,
+			       sgx_rd(sdev, cr->use_code_base0 + 4 * i));
+	seq_buf_printf(sb, "  pds exec base: 0x%08x\n", sgx_rd(sdev, cr->pds_exec_base));
+	if (!(stat & cr->bif_int_stat_fault_req))
+		return;
+	seq_buf_printf(sb, "fault at 0x%08x: requestor 0x%04x type %u\n", addr,
+		       field_get(cr->bif_int_stat_fault_req, stat),
+		       field_get(cr->bif_int_stat_fault_type, stat));
+	dump_lookup(sb, "job's", bad->ctx->vm->mmu, addr);
+	dump_lookup(sb, "firmware's", sdev->kernel_mmu, addr);
+	if (!pvrsgx_core_single_context(sdev->family))
+		dump_lookup(sb, "idle", sdev->idle_mmu, addr);
+}
+
+/*
+ * Called from the timeout handler with the scheduler stopped, before the
+ * restart: what the microkernel and the hung job left behind.
+ */
+void pvrsgx_coredump(struct pvrsgx_device *sdev, struct pvrsgx_job *bad)
+{
+	static const char *const types[] = {
+		[DRM_POWERVR_SGX_JOB_TYPE_RENDER] = "render",
+		[DRM_POWERVR_SGX_JOB_TYPE_TRANSFER] = "transfer",
+		[DRM_POWERVR_SGX_JOB_TYPE_NULL] = "null",
+	};
+	unsigned long flags;
+	struct seq_buf sb;
+	char *buf;
+
+	/* The timeout handler signals fences: no reclaim, so a dump can be lost but never waits. */
+	buf = __vmalloc(COREDUMP_BYTES, GFP_NOWAIT | __GFP_NOWARN);
+	if (!buf)
+		return;
+	seq_buf_init(&sb, buf, COREDUMP_BYTES);
+	seq_buf_printf(&sb, "powervr_sgx hang: %s job, ccb %llu, reset %u\n",
+		       bad->type < ARRAY_SIZE(types) ? types[bad->type] : "?", bad->ccb_seq,
+		       sdev->reset_count + 1);
+	pvrsgx_dump_status(&sb, sdev, true);
+	if (sdev->fw_running)
+		dump_bif(&sb, sdev, bad);
+	pvrsgx_fw_dump(&sb, sdev, PVRSGX_FW_HOSTCTL, "hostctl");
+	pvrsgx_fw_dump(&sb, sdev, PVRSGX_FW_TA3DCTL, "ta3dctl");
+	pvrsgx_fw_dump(&sb, sdev, PVRSGX_FW_CCBCTL, "ccbctl");
+	pvrsgx_fw_dump(&sb, sdev, PVRSGX_FW_CCB, "ccb");
+	pvrsgx_job_dump(&sb, bad);
+	if (seq_buf_has_overflowed(&sb))
+		drm_warn(&sdev->base, "coredump truncated\n");
+	/* devcoredump registers a device, which allocates: from a worker. */
+	spin_lock_irqsave(&sdev->fence_lock, flags);
+	if (!sdev->coredump) {
+		sdev->coredump = buf;
+		sdev->coredump_len = seq_buf_used(&sb);
+		buf = NULL;
+	}
+	spin_unlock_irqrestore(&sdev->fence_lock, flags);
+	vfree(buf);
+	queue_work(system_dfl_wq, &sdev->coredump_work);
+}
+
+static void coredump_work_fn(struct work_struct *work)
+{
+	struct pvrsgx_device *sdev = container_of(work, struct pvrsgx_device, coredump_work);
+	unsigned long flags;
+	size_t len;
+	void *buf;
+
+	spin_lock_irqsave(&sdev->fence_lock, flags);
+	buf = sdev->coredump;
+	len = sdev->coredump_len;
+	sdev->coredump = NULL;
+	spin_unlock_irqrestore(&sdev->fence_lock, flags);
+	if (buf)
+		dev_coredumpv(sdev->base.dev, buf, len, GFP_KERNEL);
+}
+
+void pvrsgx_coredump_init(struct pvrsgx_device *sdev)
+{
+	INIT_WORK(&sdev->coredump_work, coredump_work_fn);
+}
+
+void pvrsgx_coredump_fini(struct pvrsgx_device *sdev)
+{
+	cancel_work_sync(&sdev->coredump_work);
+	vfree(sdev->coredump);
+	sdev->coredump = NULL;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_dump.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_dump.h
new file mode 100644
index 000000000..f47db524f
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_dump.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_DUMP_H
+#define PVRSGX_DUMP_H
+
+struct pvrsgx_device;
+struct pvrsgx_job;
+struct seq_buf;
+
+void pvrsgx_dump_status(struct seq_buf *sb, struct pvrsgx_device *sdev, bool regs);
+void pvrsgx_coredump(struct pvrsgx_device *sdev, struct pvrsgx_job *bad);
+void pvrsgx_coredump_init(struct pvrsgx_device *sdev);
+void pvrsgx_coredump_fini(struct pvrsgx_device *sdev);
+
+#endif /* PVRSGX_DUMP_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_of.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_of.c
new file mode 100644
index 000000000..e347a3699
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_of.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * An SGX on a device tree SoC (Documentation/devicetree/bindings/gpu/
+ * img,powervr-sgx.yaml). On TI parts the GPU node has no clocks or power
+ * domain of its own: its ti-sysc parent module enables both, and applies the
+ * SGX interrupt quirk, when the GPU device is runtime-resumed. Every register
+ * access happens with the parent held awake.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+
+#include "pvrsgx_device.h"
+#include "pvrsgx_drv.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_pm.h"
+
+static int pvrsgx_of_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pvrsgx_device *sdev;
+	struct resource *res, win;
+	int err, irq;
+
+	/* Clocks and resets on the GPU node itself (non-TI parts) aren't handled yet. */
+	if (of_property_present(dev->of_node, "clocks") ||
+	    of_property_present(dev->of_node, "resets")) {
+		dev_err(dev, "GPU node with its own clocks or resets; not touching it\n");
+		return -ENODEV;
+	}
+	if (!dev->parent || !pm_runtime_enabled(dev->parent)) {
+		dev_err(dev, "no runtime-PM parent to clock the GPU; not touching it\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res || resource_size(res) < PVRSGX_REGS_MIN)
+		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+	dma_set_max_seg_size(dev, UINT_MAX);
+
+	sdev = pvrsgx_alloc(dev);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+	sdev->family = pvrsgx_core_family_get((uintptr_t)device_get_match_data(dev));
+	sdev->irq = irq;
+	platform_set_drvdata(pdev, sdev);
+
+	/* Map only the registers: nothing past them is named (OMAP3 maps 32 MiB). */
+	win = DEFINE_RES_MEM_NAMED(res->start, PVRSGX_REGS_MIN, PVRSGX_DRIVER_NAME);
+	sdev->regs = devm_ioremap_resource(dev, &win);
+	if (IS_ERR(sdev->regs))
+		return PTR_ERR(sdev->regs);
+
+	/* The module is clocked only while its parent is awake. */
+	err = pm_runtime_resume_and_get(dev->parent);
+	if (err)
+		return err;
+	err = pvrsgx_probe_common(sdev);
+	pm_runtime_put(dev->parent);
+	return err;
+}
+
+static void pvrsgx_of_remove(struct platform_device *pdev)
+{
+	pvrsgx_remove_common(platform_get_drvdata(pdev));
+}
+
+static void pvrsgx_of_shutdown(struct platform_device *pdev)
+{
+	struct pvrsgx_device *sdev = platform_get_drvdata(pdev);
+
+	/* Only a powered core can be stopped. */
+	if (sdev && pm_runtime_get_if_active(&pdev->dev) > 0) {
+		pvrsgx_fw_stop(sdev);
+		pm_runtime_put_noidle(&pdev->dev);
+	}
+}
+
+static const struct of_device_id pvrsgx_of_ids[] = {
+	{ .compatible = "img,powervr-sgx530", .data = (void *)530 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pvrsgx_of_ids);
+
+static struct platform_driver pvrsgx_of_driver = {
+	.probe = pvrsgx_of_probe,
+	.remove = pvrsgx_of_remove,
+	.shutdown = pvrsgx_of_shutdown,
+	.driver = {
+		.name = PVRSGX_DRIVER_NAME,
+		.of_match_table = pvrsgx_of_ids,
+		.pm = pm_ptr(&pvrsgx_pm_ops),
+	},
+};
+
+int pvrsgx_of_register(void)
+{
+	return platform_driver_register(&pvrsgx_of_driver);
+}
+
+void pvrsgx_of_unregister(void)
+{
+	platform_driver_unregister(&pvrsgx_of_driver);
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.c
new file mode 100644
index 000000000..24c93a91b
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+#include <drm/drm_print.h>
+
+#include <linux/pm_runtime.h>
+
+#include "pvrsgx_device.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_job.h"
+#include "pvrsgx_pm.h"
+
+/*
+ * Runtime PM. The SGX function has no PCI PM capability, so the PCI core keeps
+ * it in D0: suspend is the microkernel's power-off (pvrsgx_fw_stop), resume
+ * the same full start a reset does. A job on the GPU holds a reference from
+ * run_job until it leaves the active list.
+ */
+#define AUTOSUSPEND_MS	500
+
+int pvrsgx_power_get(struct pvrsgx_device *sdev)
+{
+	return pm_runtime_resume_and_get(sdev->base.dev);
+}
+
+void pvrsgx_power_put(struct pvrsgx_device *sdev, u32 n)
+{
+	if (!n)
+		return;
+	pm_runtime_mark_last_busy(sdev->base.dev);
+	while (n--)
+		pm_runtime_put_autosuspend(sdev->base.dev);
+}
+
+/*
+ * After probe. The PCI core holds a reference over probe and forbids runtime
+ * PM by default; an auxiliary device starts with runtime PM disabled, and its
+ * parent (gma500, which powers the graphics island) stays up while it runs.
+ */
+void pvrsgx_power_init(struct pvrsgx_device *sdev)
+{
+	struct device *dev = sdev->base.dev;
+
+	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	if (sdev->pdev) {
+		pm_runtime_put_autosuspend(dev);
+		pm_runtime_allow(dev);
+	} else {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+		/*
+		 * A single-context core is still in bring-up: its power-off and
+		 * the state loss of a suspend are untested, so it stays awake.
+		 */
+		if (pvrsgx_core_single_context(sdev->family)) {
+			pm_runtime_get_noresume(dev);
+			sdev->pm_pinned = true;
+		}
+	}
+}
+
+/* Before remove: undo pvrsgx_power_init, with the device awake. */
+void pvrsgx_power_fini(struct pvrsgx_device *sdev)
+{
+	struct device *dev = sdev->base.dev;
+
+	if (sdev->pdev) {
+		pm_runtime_forbid(dev);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	} else {
+		pm_runtime_get_sync(dev);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_put_noidle(dev);
+		if (sdev->pm_pinned) {
+			pm_runtime_put_noidle(dev);
+			sdev->pm_pinned = false;
+		}
+	}
+}
+
+static int pvrsgx_runtime_suspend(struct device *dev)
+{
+	struct pvrsgx_device *sdev = dev_get_drvdata(dev);
+
+	if (!sdev->lost)
+		pvrsgx_fw_stop(sdev);
+	return 0;
+}
+
+static int pvrsgx_runtime_resume(struct device *dev)
+{
+	struct pvrsgx_device *sdev = dev_get_drvdata(dev);
+
+	/* A failed start loses the device: run_job then fails every job with -EIO. */
+	if (!sdev->lost && pvrsgx_fw_start(sdev)) {
+		drm_err(&sdev->base, "microkernel did not start on resume: device lost\n");
+		sdev->lost = true;
+	}
+	return 0;
+}
+
+/*
+ * System sleep. The core loses power, so the microkernel has to stop first and
+ * start again after: drain the GPU, then the runtime suspend and resume above.
+ * Behind gma500 this runs before its suspend and after its resume, with the
+ * graphics island up.
+ */
+static int pvrsgx_suspend(struct device *dev)
+{
+	struct pvrsgx_device *sdev = dev_get_drvdata(dev);
+	int err = pvrsgx_job_quiesce(sdev);
+
+	if (err)
+		return err;
+	err = pm_runtime_force_suspend(dev);
+	if (err)
+		pvrsgx_job_unquiesce(sdev);
+	return err;
+}
+
+static int pvrsgx_resume(struct device *dev)
+{
+	struct pvrsgx_device *sdev = dev_get_drvdata(dev);
+	int err = pm_runtime_force_resume(dev);
+
+	pvrsgx_job_unquiesce(sdev);
+	return err;
+}
+
+const struct dev_pm_ops pvrsgx_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pvrsgx_suspend, pvrsgx_resume)
+	RUNTIME_PM_OPS(pvrsgx_runtime_suspend, pvrsgx_runtime_resume, NULL)
+};
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.h
new file mode 100644
index 000000000..62d6ebaa1
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_PM_H
+#define PVRSGX_PM_H
+
+#include <linux/kconfig.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+
+struct pvrsgx_device;
+
+/* Referenced through pm_ptr(), so declared either way. */
+extern const struct dev_pm_ops pvrsgx_pm_ops;
+
+#if IS_ENABLED(CONFIG_PM)
+
+int pvrsgx_power_get(struct pvrsgx_device *sdev);
+void pvrsgx_power_put(struct pvrsgx_device *sdev, u32 n);
+void pvrsgx_power_init(struct pvrsgx_device *sdev);
+void pvrsgx_power_fini(struct pvrsgx_device *sdev);
+#else
+/* Without runtime PM the GPU stays on from probe to remove. */
+static inline int pvrsgx_power_get(struct pvrsgx_device *sdev) { return 0; }
+static inline void pvrsgx_power_put(struct pvrsgx_device *sdev, u32 n) { }
+static inline void pvrsgx_power_init(struct pvrsgx_device *sdev) { }
+static inline void pvrsgx_power_fini(struct pvrsgx_device *sdev) { }
+#endif
+
+#endif /* PVRSGX_PM_H */

-- 
2.50.1

