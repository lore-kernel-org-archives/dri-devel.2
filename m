Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9960A3831
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B3B10E104;
	Thu, 12 Nov 2026 22:59:23 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B67112366
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:11 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso1591162d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524350; x=1795129150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zNF9YXON1GVhSmp92ZjW6spQZHVtZO/rRYWbrwvCykw=;
 b=U8fs5ZR10kZ4d0VaGbqeV8zogGatBfwwGCPSLhkww7VQNyq7t7tfatUa7G1PwBibUm
 66YNDxystszOG/DgCNmzZf8NOJkd/rg5BonPod4RyLIUDdrqStqhJnEkIyULYAGv+ZjS
 TAy5HRlTU+pqbsdPccly6RnuBAIjZE7l2dND4vNNveTOUKruGN+bcipkg9CwwuVzl8qz
 qJrO5U5i9anNqjoKb6f+8MTpWdwj62f943RQ4zEf4zgRaCI729S/H5dOOWm8TGO+fj66
 zb9i4XtBel8cQoD5AHaHNZshJk0oE3jx+0E2tow3/8c4IpQPuoKU7TAr3onsUPmjLTxB
 4eOg==
X-Gm-Message-State: APuU4Z/5NcvbE4VcRQ1ax4VV7re1RlQCSiuFH+n+S2NoTyShPeYMlROm
 Z454praUwxCZchTIm4tH/rqdRdeqR6LyTRtBNVIQsCfEpO+c/gidBy2W
X-Gm-Gg: AYBFou39/mmLbLxAAdyxEIRqoyOzghwgV2/+mWQY7Xnu6mn2jfcp4EkLyY/3H2l4GX8
 hLdkia+YGP3kLy9BYeBOfAoVCaS67V1MUB/uApgdXPWUPko01QkwpUMnkUssxF4LZzQ0DRzqQtq
 0odUS+/Q5FTLLb0BSBdGvDmBDBLcbuub5e+SrRT4D7DOvEjNjsxYxD7J5qKoSkiutLs/X8hSR57
 ppspAa02iJkjFgdNTz6i0Bg+fwov5tyDbzsBlcrjrFyTl8mEA1UtSld/sM9HB2uzjsey4XCVU2T
 J8tSfaC+02vEZlbS6lTxxtEWQa+aqQYT5fgHgwlpCbvqe/qI0IKKAlv592fzz3i8CB5IGDf8SbT
 1cas3mPy0xRUL49A4SbbDbzGUXsY4v0hGIwyN+sdMbOQYvI9AT+o7kNcpwDqb4vnCHgQQ/zOTD/
 ACmEMN3SAWM3OHugMy1z40aKrTa8RjeK7t8VMl7t2jpYtQd8ueH/+5JvAFBdfmjOGuk4E1aVeKR
 hjPk98CN0PtUm6jtctgXUVIKiej82ADfYm4RRCxe+glkytusTYwUp/o5oYWpMxgn/lLm9FPwPOZ
 nX/yCt5LKovICp4pa+lf2wRWfu9S0F8+xE+DEAqJ1QMTyZ0E0xWnijGCnGGLOsgl1nkpyTgEmss
 3b7MMAn+9a2zJ3z3SovS5OWUhpLw37mDF/kPM6EUgKHXQatWOi8nwvzrlHj8Lf6AcjltXY4Tf2e
 QE+4MCVUVwJqyfWJLu9IrFGDeS
X-Received: by 2002:a05:690e:144a:b0:679:9310:6581 with SMTP id
 956f58d0204a3-67c78cb7797mr2809652d50.23.1794524350323; 
 Thu, 12 Nov 2026 14:59:10 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:09 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:52 -0500
Subject: [PATCH RFC 02/13] drm/gma500: Publish the Cedarview SGX as an
 auxiliary device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-2-c69b84bac011@telaak.dev>
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

The GMA3600/3650 (Cedarview) GPU is a PowerVR SGX545 behind the same PCI
function and register BAR as the display engine gma500 drives. gma500
uses the SGX for nothing but an MMU it sets up at probe and fills when it
pins framebuffers; no gma500 code reads through that MMU. So give the SGX
to a driver of its own: publish an auxiliary device, "gma500_gfx.sgx",
carrying the mapped SGX register window, which SGX core it is, and a hook
that routes the SGX's interrupt to that driver.

Each chip's psb_ops says whether its SGX has a driver of its own, and as
which core. On such a chip gma500 hands the SGX over for good: it doesn't
reset it or program its BIF at probe, creates no SGX MMU and maps nothing
into one, masks the SGX's events at interrupt (re)install until a
handler is registered, and passes the SGX's interrupt to the registered
handler. Teardown clears the handler itself, whatever the SGX driver did.

The interrupt reaches the SGX driver through a callback on the auxiliary
device, not an exported symbol: an exported gma500 symbol would make
that driver depend on gma500, and the same driver runs the Intel Atom
CE5300, where the SGX is a PCI function of its own and there is no
gma500.

The auxiliary device's parent is the GPU's PCI device, so runtime PM on
the SGX side would keep gma500, and with it the graphics power island,
awake; gma500 holds a runtime-PM reference for its whole life today.

Only Cedarview's psb_ops names an SGX. Poulsbo and Oaktrail leave it NULL
and are unchanged until an SGX driver has run on them.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 MAINTAINERS                         |   1 +
 drivers/gpu/drm/gma500/Kconfig      |   1 +
 drivers/gpu/drm/gma500/Makefile     |   3 +-
 drivers/gpu/drm/gma500/cdv_device.c |   5 ++
 drivers/gpu/drm/gma500/gem.c        |  12 +++--
 drivers/gpu/drm/gma500/psb_drv.c    |  42 +++++++++------
 drivers/gpu/drm/gma500/psb_drv.h    |  26 +++++++++
 drivers/gpu/drm/gma500/psb_irq.c    |  32 +++++++----
 drivers/gpu/drm/gma500/sgx_aux.c    | 102 ++++++++++++++++++++++++++++++++++++
 include/drm/gma500_sgx.h            |  52 ++++++++++++++++++
 10 files changed, 246 insertions(+), 30 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4f4e4877..e1b0a4245 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9036,6 +9036,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/gma500/
+F:	include/drm/gma500_sgx.h
 
 DRM DRIVERS FOR HISILICON HIBMC
 M:	Yongbang Shi <shiyongbang@huawei.com>
diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index dc4c56638..bece965b2 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -4,6 +4,7 @@ config DRM_GMA500
 	depends on DRM && PCI && X86 && HAS_IOPORT
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
+	select AUXILIARY_BUS
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select I2C
 	select I2C_ALGOBIT
diff --git a/drivers/gpu/drm/gma500/Makefile b/drivers/gpu/drm/gma500/Makefile
index 58fed80c7..a933940e2 100644
--- a/drivers/gpu/drm/gma500/Makefile
+++ b/drivers/gpu/drm/gma500/Makefile
@@ -34,7 +34,8 @@ gma500_gfx-y += \
 	  psb_intel_lvds.o \
 	  psb_intel_modes.o \
 	  psb_intel_sdvo.o \
-	  psb_irq.o
+	  psb_irq.o \
+	  sgx_aux.o
 
 gma500_gfx-$(CONFIG_ACPI) +=  opregion.o
 gma500_gfx-$(CONFIG_DRM_FBDEV_EMULATION) +=  fbdev.o
diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index fd6ea8998..f0a835366 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -563,6 +563,10 @@ static int cdv_chip_setup(struct drm_device *dev)
 
 /* CDV is much like Poulsbo but has MID like SGX offsets and PM */
 
+static const struct gma_sgx_info cdv_sgx_info = {
+	.core = 545,
+};
+
 const struct psb_ops cdv_chip_ops = {
 	.name = "GMA3600/3650",
 	.pipes = 2,
@@ -572,6 +576,7 @@ const struct psb_ops cdv_chip_ops = {
 	.sdvo_mask = (1 << 0),
 	.cursor_needs_phys = 0,
 	.sgx_offset = MRST_SGX_OFFSET,
+	.sgx = &cdv_sgx_info,
 	.chip_setup = cdv_chip_setup,
 	.errata = cdv_errata,
 
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 2708e8c68..4a4ecfb7b 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -54,9 +54,10 @@ int psb_gem_pin(struct psb_gem_object *pobj)
 	set_pages_array_wc(pages, npages);
 
 	psb_gtt_insert_pages(dev_priv, &pobj->resource, pages);
-	psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu), pages,
-			     (gpu_base + pobj->offset), npages, 0, 0,
-			     PSB_MMU_CACHED_MEMORY);
+	if (dev_priv->mmu)
+		psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu), pages,
+				     (gpu_base + pobj->offset), npages, 0, 0,
+				     PSB_MMU_CACHED_MEMORY);
 
 	pobj->pages = pages;
 
@@ -93,8 +94,9 @@ void psb_gem_unpin(struct psb_gem_object *pobj)
 
 	npages = obj->size / PAGE_SIZE;
 
-	psb_mmu_remove_pages(psb_mmu_get_default_pd(dev_priv->mmu),
-			     (gpu_base + pobj->offset), npages, 0, 0);
+	if (dev_priv->mmu)
+		psb_mmu_remove_pages(psb_mmu_get_default_pd(dev_priv->mmu),
+				     (gpu_base + pobj->offset), npages, 0, 0);
 	psb_gtt_remove_pages(dev_priv, &pobj->resource);
 
 	/* Reset caching flags */
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index d17cb5b4a..c29cc64cc 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -145,6 +145,10 @@ static int psb_do_init(struct drm_device *dev)
 
 	spin_lock_init(&dev_priv->irqmask_lock);
 
+	/* The SGX's own driver sets it up. */
+	if (gma_sgx_external(dev_priv))
+		return 0;
+
 	PSB_WSGX32(0x00000000, PSB_CR_BIF_BANK0);
 	PSB_WSGX32(0x00000000, PSB_CR_BIF_BANK1);
 	PSB_RSGX32(PSB_CR_BIF_BANK1);
@@ -172,6 +176,7 @@ static void psb_driver_unload(struct drm_device *dev)
 	gma_backlight_exit(dev);
 	psb_modeset_cleanup(dev);
 
+	gma_sgx_aux_fini(dev);
 	gma_irq_uninstall(dev);
 
 	if (dev_priv->ops->chip_teardown)
@@ -337,29 +342,34 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 
 	ret = -ENOMEM;
 
-	dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, NULL);
-	if (!dev_priv->mmu)
-		goto out_err;
+	/* No SGX MMU where the SGX has a driver of its own. */
+	if (!gma_sgx_external(dev_priv)) {
+		dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, NULL);
+		if (!dev_priv->mmu)
+			goto out_err;
 
-	dev_priv->pf_pd = psb_mmu_alloc_pd(dev_priv->mmu, 1, 0);
-	if (!dev_priv->pf_pd)
-		goto out_err;
+		dev_priv->pf_pd = psb_mmu_alloc_pd(dev_priv->mmu, 1, 0);
+		if (!dev_priv->pf_pd)
+			goto out_err;
+	}
 
 	ret = psb_do_init(dev);
 	if (ret)
 		return ret;
 
-	/* Add stolen memory to SGX MMU */
-	ret = psb_mmu_insert_pfn_sequence(psb_mmu_get_default_pd(dev_priv->mmu),
-					  dev_priv->stolen_base >> PAGE_SHIFT,
-					  pg->gatt_start,
-					  pg->stolen_size >> PAGE_SHIFT, 0);
+	if (!gma_sgx_external(dev_priv)) {
+		/* Add stolen memory to SGX MMU */
+		ret = psb_mmu_insert_pfn_sequence(psb_mmu_get_default_pd(dev_priv->mmu),
+						  dev_priv->stolen_base >> PAGE_SHIFT,
+						  pg->gatt_start,
+						  pg->stolen_size >> PAGE_SHIFT, 0);
 
-	psb_mmu_set_pd_context(psb_mmu_get_default_pd(dev_priv->mmu), 0);
-	psb_mmu_set_pd_context(dev_priv->pf_pd, 1);
+		psb_mmu_set_pd_context(psb_mmu_get_default_pd(dev_priv->mmu), 0);
+		psb_mmu_set_pd_context(dev_priv->pf_pd, 1);
 
-	PSB_WSGX32(0x20000000, PSB_CR_PDS_EXEC_BASE);
-	PSB_WSGX32(0x30000000, PSB_CR_BIF_3D_REQ_BASE);
+		PSB_WSGX32(0x20000000, PSB_CR_PDS_EXEC_BASE);
+		PSB_WSGX32(0x30000000, PSB_CR_BIF_3D_REQ_BASE);
+	}
 
 	acpi_video_register();
 
@@ -383,6 +393,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	spin_unlock_irqrestore(&dev_priv->irqmask_lock, irqflags);
 
 	gma_irq_install(dev);
+	if (dev_priv->ops->sgx)
+		gma_sgx_aux_init(dev);
 
 	dev->max_vblank_count = 0xffffff; /* only 24 bits of frame count */
 
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index db197b865..dbc5827aa 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -8,10 +8,12 @@
 #ifndef _PSB_DRV_H_
 #define _PSB_DRV_H_
 
+#include <linux/interrupt.h>
 #include <linux/kref.h>
 #include <linux/mm_types.h>
 
 #include <drm/drm_device.h>
+#include <drm/gma500_sgx.h>
 
 #include "gtt.h"
 #include "intel_bios.h"
@@ -407,6 +409,11 @@ struct drm_psb_private {
 
 	/* Register base */
 	uint8_t __iomem *sgx_reg;
+
+	/* The SGX's own driver, if one is bound (sgx_aux.c) */
+	struct gma500_sgx_device *sgx_adev;
+	gma500_sgx_irq_handler_t sgx_handler;
+	void *sgx_data;
 	uint8_t __iomem *vdc_reg;
 	uint8_t __iomem *aux_reg; /* Auxillary vdc pipe regs */
 	uint16_t lpc_gpio_base;
@@ -541,12 +548,18 @@ static inline struct drm_psb_private *to_drm_psb_private(struct drm_device *dev)
 	return container_of(dev, struct drm_psb_private, dev);
 }
 
+/* An SGX that gma500 publishes for a driver of its own (sgx_aux.c) */
+struct gma_sgx_info {
+	unsigned int core;	/* SGX core number: 545 for an SGX545 */
+};
+
 /* Operations for each board type */
 struct psb_ops {
 	const char *name;
 	int pipes;		/* Number of output pipes */
 	int crtcs;		/* Number of CRTCs */
 	int sgx_offset;		/* Base offset of SGX device */
+	const struct gma_sgx_info *sgx;	/* SGX for a driver of its own, or NULL */
 	int hdmi_mask;		/* Mask of HDMI CRTCs */
 	int lvds_mask;		/* Mask of LVDS CRTCs */
 	int sdvo_mask;		/* Mask of SDVO CRTCs */
@@ -719,10 +732,23 @@ static inline void REGISTER_WRITE8(struct drm_device *dev,
 #define PSB_WVDC32(_val, _offs)		iowrite32(_val, dev_priv->vdc_reg + (_offs))
 #define PSB_RVDC32(_offs)		ioread32(dev_priv->vdc_reg + (_offs))
 
+/*
+ * The chip's SGX has a driver of its own (psb_ops.sgx): gma500 never sets it
+ * up, maps nothing in its MMU and writes none of its registers.
+ */
+static inline bool gma_sgx_external(struct drm_psb_private *dev_priv)
+{
+	return dev_priv->ops->sgx;
+}
+
 #define PSB_RSGX32(_offs)		ioread32(dev_priv->sgx_reg + (_offs))
 #define PSB_WSGX32(_val, _offs)		iowrite32(_val, dev_priv->sgx_reg + (_offs))
 
 #define PSB_WMSVDX32(_val, _offs)	iowrite32(_val, dev_priv->msvdx_reg + (_offs))
 #define PSB_RMSVDX32(_offs)		ioread32(dev_priv->msvdx_reg + (_offs))
 
+/* sgx_aux.c */
+void gma_sgx_aux_init(struct drm_device *dev);
+void gma_sgx_aux_fini(struct drm_device *dev);
+
 #endif
diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index c224c7ff3..426efc126 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -224,10 +224,19 @@ static irqreturn_t gma_irq_handler(int irq, void *arg)
 	}
 
 	if (sgx_int) {
-		sgx_stat_1 = PSB_RSGX32(PSB_CR_EVENT_STATUS);
-		sgx_stat_2 = PSB_RSGX32(PSB_CR_EVENT_STATUS2);
-		gma_sgx_interrupt(dev, sgx_stat_1, sgx_stat_2);
-		handled = 1;
+		if (gma_sgx_external(dev_priv)) {
+			gma500_sgx_irq_handler_t sgx_handler;
+
+			/* Pairs with the release in gma_sgx_set_irq_handler(). */
+			sgx_handler = smp_load_acquire(&dev_priv->sgx_handler);
+			if (sgx_handler && sgx_handler(dev_priv->sgx_data) != IRQ_NONE)
+				handled = 1;
+		} else {
+			sgx_stat_1 = PSB_RSGX32(PSB_CR_EVENT_STATUS);
+			sgx_stat_2 = PSB_RSGX32(PSB_CR_EVENT_STATUS2);
+			gma_sgx_interrupt(dev, sgx_stat_1, sgx_stat_2);
+			handled = 1;
+		}
 	}
 
 	/* Note: this bit has other meanings on some devices, so we will
@@ -257,8 +266,11 @@ void gma_irq_preinstall(struct drm_device *dev)
 	PSB_WVDC32(0xFFFFFFFF, PSB_HWSTAM);
 	PSB_WVDC32(0x00000000, PSB_INT_MASK_R);
 	PSB_WVDC32(0x00000000, PSB_INT_ENABLE_R);
-	PSB_WSGX32(0x00000000, PSB_CR_EVENT_HOST_ENABLE);
-	PSB_RSGX32(PSB_CR_EVENT_HOST_ENABLE);
+	/* An SGX driver of its own enables what it needs; until one binds, mask it. */
+	if (!gma_sgx_external(dev_priv) || !READ_ONCE(dev_priv->sgx_handler)) {
+		PSB_WSGX32(0x00000000, PSB_CR_EVENT_HOST_ENABLE);
+		PSB_RSGX32(PSB_CR_EVENT_HOST_ENABLE);
+	}
 
 	if (dev->vblank[0].enabled)
 		dev_priv->vdc_irq_mask |= _PSB_VSYNC_PIPEA_FLAG;
@@ -284,9 +296,11 @@ void gma_irq_postinstall(struct drm_device *dev)
 	spin_lock_irqsave(&dev_priv->irqmask_lock, irqflags);
 
 	/* Enable 2D and MMU fault interrupts */
-	PSB_WSGX32(_PSB_CE2_BIF_REQUESTER_FAULT, PSB_CR_EVENT_HOST_ENABLE2);
-	PSB_WSGX32(_PSB_CE_TWOD_COMPLETE, PSB_CR_EVENT_HOST_ENABLE);
-	PSB_RSGX32(PSB_CR_EVENT_HOST_ENABLE); /* Post */
+	if (!gma_sgx_external(dev_priv)) {
+		PSB_WSGX32(_PSB_CE2_BIF_REQUESTER_FAULT, PSB_CR_EVENT_HOST_ENABLE2);
+		PSB_WSGX32(_PSB_CE_TWOD_COMPLETE, PSB_CR_EVENT_HOST_ENABLE);
+		PSB_RSGX32(PSB_CR_EVENT_HOST_ENABLE); /* Post */
+	}
 
 	/* This register is safe even if display island is off */
 	PSB_WVDC32(dev_priv->vdc_irq_mask, PSB_INT_ENABLE_R);
diff --git a/drivers/gpu/drm/gma500/sgx_aux.c b/drivers/gpu/drm/gma500/sgx_aux.c
new file mode 100644
index 000000000..671cb6c33
--- /dev/null
+++ b/drivers/gpu/drm/gma500/sgx_aux.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The SGX of a GMA500-family GPU, published as an auxiliary device for a
+ * driver of its own on the chips whose psb_ops name it (Cedarview). gma500
+ * keeps the PCI function and the interrupt line, hands the SGX's interrupt
+ * over, and never sets the SGX up or touches its registers on those chips.
+ *
+ * Copyright © 2026 Joseph Telaak
+ */
+
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <drm/drm_print.h>
+#include <drm/gma500_sgx.h>
+
+#include "psb_drv.h"
+
+struct gma_sgx_aux {
+	struct gma500_sgx_device sgx;
+	struct drm_psb_private *dev_priv;
+};
+
+static int gma_sgx_set_irq_handler(struct gma500_sgx_device *sgx,
+				   gma500_sgx_irq_handler_t handler, void *data)
+{
+	struct gma_sgx_aux *aux = container_of(sgx, struct gma_sgx_aux, sgx);
+	struct drm_psb_private *dev_priv = aux->dev_priv;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->dev.dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev_priv->irqmask_lock, flags);
+	if (handler && dev_priv->sgx_handler) {
+		spin_unlock_irqrestore(&dev_priv->irqmask_lock, flags);
+		return -EBUSY;
+	}
+	dev_priv->sgx_data = data;
+	/* The data reaches the interrupt handler before the handler does. */
+	smp_store_release(&dev_priv->sgx_handler, handler);
+	spin_unlock_irqrestore(&dev_priv->irqmask_lock, flags);
+
+	/* No handler call still running on another CPU once this returns. */
+	if (!handler && dev_priv->irq_enabled)
+		synchronize_irq(pdev->irq);
+	return 0;
+}
+
+static void gma_sgx_aux_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(container_of(to_gma500_sgx_device(adev), struct gma_sgx_aux, sgx));
+}
+
+void gma_sgx_aux_init(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
+	struct gma_sgx_aux *aux;
+	int ret;
+
+	aux = kzalloc_obj(*aux);
+	if (!aux) {
+		drm_warn(dev, "SGX auxiliary device not published (-ENOMEM)\n");
+		return;
+	}
+	aux->dev_priv = dev_priv;
+	aux->sgx.regs = dev_priv->sgx_reg;
+	aux->sgx.regs_len = PSB_SGX_SIZE;
+	aux->sgx.core = dev_priv->ops->sgx->core;
+	aux->sgx.set_irq_handler = gma_sgx_set_irq_handler;
+	aux->sgx.adev.name = "sgx";
+	aux->sgx.adev.id = pci_dev_id(to_pci_dev(dev->dev));
+	aux->sgx.adev.dev.parent = dev->dev;
+	aux->sgx.adev.dev.release = gma_sgx_aux_release;
+
+	ret = auxiliary_device_init(&aux->sgx.adev);
+	if (ret) {
+		kfree(aux);
+		drm_warn(dev, "SGX auxiliary device not published (%d)\n", ret);
+		return;
+	}
+	ret = auxiliary_device_add(&aux->sgx.adev);
+	if (ret) {
+		auxiliary_device_uninit(&aux->sgx.adev);
+		drm_warn(dev, "SGX auxiliary device not published (%d)\n", ret);
+		return;
+	}
+	dev_priv->sgx_adev = &aux->sgx;
+}
+
+void gma_sgx_aux_fini(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
+
+	if (!dev_priv->sgx_adev)
+		return;
+	/* Unbinding the SGX driver hands the interrupt back; make sure of it. */
+	auxiliary_device_delete(&dev_priv->sgx_adev->adev);
+	gma_sgx_set_irq_handler(dev_priv->sgx_adev, NULL, NULL);
+	auxiliary_device_uninit(&dev_priv->sgx_adev->adev);
+	dev_priv->sgx_adev = NULL;
+}
diff --git a/include/drm/gma500_sgx.h b/include/drm/gma500_sgx.h
new file mode 100644
index 000000000..00a034f1a
--- /dev/null
+++ b/include/drm/gma500_sgx.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef __DRM_GMA500_SGX_H__
+#define __DRM_GMA500_SGX_H__
+
+#include <linux/auxiliary_bus.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+
+/* The SGX's interrupt handler: hard interrupt context. */
+typedef irqreturn_t (*gma500_sgx_irq_handler_t)(void *data);
+
+/**
+ * struct gma500_sgx_device - The PowerVR SGX inside a GMA500-family GPU
+ *
+ * gma500 owns the PCI function, its register BAR and its interrupt. On parts
+ * whose SGX has a driver of its own (&psb_ops.sgx), it publishes this auxiliary
+ * device, named "gma500_gfx.sgx", whose parent is the GPU's PCI device. The SGX
+ * driver uses the parent for DMA and runtime PM: holding the auxiliary device
+ * awake keeps gma500, and so the graphics power island, awake.
+ */
+struct gma500_sgx_device {
+	/** @adev: The auxiliary device. */
+	struct auxiliary_device adev;
+
+	/** @regs: The SGX's register window, mapped by gma500. */
+	void __iomem *regs;
+
+	/** @regs_len: Length of @regs in bytes. */
+	resource_size_t regs_len;
+
+	/** @core: Which SGX core this is, by number: 545 for an SGX545. */
+	unsigned int core;
+
+	/**
+	 * @set_irq_handler: Route the SGX's interrupts to @handler, which runs in
+	 * hard interrupt context with @data; with a NULL @handler they are
+	 * ignored. gma500 never touches an SGX it publishes, handler or not.
+	 * Returns -EBUSY if another handler is set.
+	 */
+	int (*set_irq_handler)(struct gma500_sgx_device *sgx,
+			       gma500_sgx_irq_handler_t handler, void *data);
+};
+
+static inline struct gma500_sgx_device *
+to_gma500_sgx_device(struct auxiliary_device *adev)
+{
+	return container_of(adev, struct gma500_sgx_device, adev);
+}
+
+#endif /* __DRM_GMA500_SGX_H__ */

-- 
2.50.1

