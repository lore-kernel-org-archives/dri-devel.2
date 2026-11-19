Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B9606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3BM/itH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155F5112121;
	Thu, 19 Nov 2026 01:38:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701D411210A;
 Thu, 19 Nov 2026 01:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5478D470A6;
 Thu, 19 Nov 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795052327;
 b=EDjMITMXs3yH9YzPVR8PL0E8u0T4WEZpG5YCCny8/9EnDvirmZxnWimuuQngsVsWoKtq
 KJztLh56yEkYUlgPIdpTdhVsMJ9XvqH1uc5NXaCwfRs4+ZPJV+CpqpzJH9vzZQnB9CQwP
 hyHf1MUmC4ZyPkYy4x65hfIPb2W92Ey03j/LPujQe/7PSwaznGHTww/B9Nbep957FKvz1
 PgKR/4zqW89TgOLfWNc050lvH+4uy/sTmn0WTmjBg+SH77sbwsj//rpxdHuot/P+LMQdv
 uLmL/HINjfOP0vO6fPqmTHjvmeq9r8UHfZH+snO/Ueb/SqplQnfdFkS+ADGzzDxjDHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795052327;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=J067H1Ipyt4hys73NJvFPKP/LuFNnnSPrBgTMOHIEWw=;
 b=xvv3jVboOAF7gxPMX46zatrNcKpsfQtf0e/l7d0KMRoi6A7ECFWViKseiJ9OTT3NH1Ei
 F7xN2QswrNU2D0fKmCXoKRXuTxKUDEwhWv4cihO1M+glidHdkrZJThnXGQL8VdMHJ5bdZ
 ZC1az2vxleFfso2c9KgmHeWKvcYNPDzDLHyjVzxTMf3SAxNOXxyb2sosjDY80Nd0VSJvK
 B4w3vKuZBtRd4yFveitWvKJVGaD2oRl0VxR9iyHd7c8ztbY/Kn6iQOSl3o1VZsAnjlJqO
 gfxG041j4NGHdBrhp1BI3YuD6HHlYSEXNvCBx/RrPKdRhI4AJFRUIJqEf2M5ulx9vqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DC11F1F000D0;
 Thu, 19 Nov 2026 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795052327;
 bh=J067H1Ipyt4hys73NJvFPKP/LuFNnnSPrBgTMOHIEWw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=V3BM/itHzfyUcFJ844/H3eWnHqn8FNSQfMRceNqE2qY3p7RzthH9lYRXVPQTyGpHc
 LbkgQKvhGEQxO7LEaMv0jmJTwiB8fi3tDyNIc+zlTzEkAKOso+1OkY1Gyg1gbXOo+2
 /XNDujyHgRFwuXF7xMuC4dPc4N4lRbNago37MfwAddp4fDc7XRe9Xt9AMGfzvWLzVw
 GOhwO2MtNPZ+0L9W+g62llSEv/ojRjxVa27SUr0gPbnAkg+V/GkhjQVgU2dnoz8kMX
 OkjCkzYHu1q1Tfa5HNLFeMZD3OR2cNFp0jGrSUYqmq2UrG0xte3PoTQ2FnV0/qYiAU
 enKieykcQfmZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 545834B068;
 Thu, 19 Nov 2026 01:38:38 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 19 Nov 2026 11:38:24 +1000
Subject: [PATCH 1/2] drm/nouveau: add option to leave GSP-capable GPUs to
 other drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-nova-nouveau-gsp-v1-1-4cde2bc41132@redhat.com>
References: <20261119-nova-nouveau-gsp-v1-0-4cde2bc41132@redhat.com>
In-Reply-To: <20261119-nova-nouveau-gsp-v1-0-4cde2bc41132@redhat.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8567; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=dB5GifNeSDXgxZcLfO6q1mzq1gCWPBoE6fWDut9Ef/A=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq/lMcSmexeaDEa1HhdYoj6sgGcSIZskQfxrRUt
 1uZTxeNlhOJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCav5THAAKCRAMdPNZecSG
 vglFD/4nel/N7ZGLwolyMIZGScNX71Xu1MVv6GjdzQIdp09iUU+M/9ToBsX2Kci4iP5XVKXlzp3
 yUD+PjY83295KbammngjqTPdiHi97OsLAJeEMWxyCY5eBOKaGvV3Mjd2PupmTwx/UDuuZ/a1mES
 L+hfYPtmv+7IGaQSdNPsicAtgUvgZ8UAdQ09/0bXYbEBoStWEon99GXSZLrnWQiDVFal8edtDLa
 bKJc7AEYvdlZEbOuOteEj9RfvUffpAKMWecKsptPhfK76ZsxRi4ioapTxm1SGBOWN8cmqLf/Ny3
 ZkfRgCtZv2NVHhhgdwmIX8dPhWgHiB48oegEn0DQUSd7maGIkTSKyJf5UBhOrZkeaZlxiDk6PZt
 21QlbJYzFWImS9PYEkxklAWyn6uqqoSwoKieatq9miV5BzlwvaL7m2TbLTXFsM9Pb5dxJWGqAqv
 UXRejJzTz5CLhOc8DO2i6SIC4Dny2aLmq0s7D7gRoFMhSejm9uwxVT9vaEP7/QMbLWRRw6Spaw9
 AGug2Exhre+ze56KIF3mQsaQT2Q9OMz7RYsCRDWMdMn3rlG2rC/uSgDHc3fRrCg2w23dsATj56M
 I5/wqW4bz1Sukxe8Ag8IIYbNFNI3mnmPaEI2Dz4TRJdI9XpoKsnCUb3hmyeMBWIUFjX38iXBYcC
 gc/d49VS8nCntzg==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

nouveau currently binds to every NVIDIA GPU it encounters. The
nova-core driver is being written for GSP-capable (Turing and later)
GPUs, so the two drivers compete for the same devices, with whichever
registers first winning.

Add the DRM_NOUVEAU_BIND_GSP Kconfig option (default y) and a bind_gsp
module parameter, defaulting to the Kconfig value and able to override
it in both directions, controlling whether nouveau claims GSP-capable
GPUs.

When binding is disabled, the GPU is rejected in nvkm_device_ctor(),
right after the chipset has been identified and before any subdevs are
constructed; constructing subdevs would already load GSP firmware for
a GPU that is not going to be used. Pre-Turing GPUs are always bound,
as no other driver claims them, and Tegra platform devices are
unaffected since nova-core only handles PCI devices.

Distributions that want nova-core to be the default driver for
GSP-capable GPUs can set CONFIG_DRM_NOUVEAU_BIND_GSP=n; the
nouveau.bind_gsp=0 kernel command line parameter switches it at boot
time.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/Kconfig                    | 17 +++++++++++++++++
 drivers/gpu/drm/nouveau/include/nvkm/core/pci.h    |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  9 ++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 16 +++++++++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c   |  4 ++--
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  5 ++++-
 7 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 3b5757aed9c8..863cc235838b 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -120,3 +120,20 @@ config DRM_NOUVEAU_SIL164
 	help
 	  Support for sil164 and similar single-link (or dual-link
 	  when used in pairs) TMDS transmitters.
+
+config DRM_NOUVEAU_BIND_GSP
+	bool "Make nouveau the default driver for GSP-capable GPUs"
+	depends on DRM_NOUVEAU
+	default y
+	help
+	  Make nouveau bind to all NVIDIA GPUs by default, as it always
+	  has.
+
+	  If another NVIDIA driver, such as nova-core, should claim the
+	  GSP-capable (Turing and later) GPUs instead, say N here; nouveau
+	  then leaves those GPUs to other drivers and continues to bind to
+	  older GPUs itself. nouveau can also be prevented from binding to
+	  GSP-capable GPUs at boot with nouveau.bind_gsp=0 on the kernel
+	  command line.
+
+	  If unsure, say Y.
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h
index 7444c4d59e09..075fe192b26f 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h
@@ -10,5 +10,5 @@ struct nvkm_device_pci {
 };
 
 int nvkm_device_pci_new(struct pci_dev *, const char *cfg, const char *dbg,
-			struct nvkm_device **);
+			bool bind_gsp, struct nvkm_device **);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5e1336615cf6..582eb0c91b10 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -112,6 +112,11 @@ MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1
 static int nouveau_runtime_pm = -1;
 module_param_named(runpm, nouveau_runtime_pm, int, 0400);
 
+MODULE_PARM_DESC(bind_gsp, "bind to GSP-capable (Turing and later) GPUs "
+		 "(0 = leave them to other drivers, e.g. nova)");
+static bool nouveau_bind_gsp = IS_ENABLED(CONFIG_DRM_NOUVEAU_BIND_GSP);
+module_param_named(bind_gsp, nouveau_bind_gsp, bool, 0400);
+
 static const struct drm_driver driver_legacy_kms;
 static const struct drm_driver driver_atomic_kms;
 
@@ -881,7 +886,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	/* We need to check that the chipset is supported before booting
 	 * fbdev off the hardware, as there's no way to put it back.
 	 */
-	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug, &device);
+	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug,
+				  nouveau_bind_gsp, &device);
 	if (ret)
 		return ret;
 
@@ -1460,6 +1466,7 @@ static void nouveau_display_options(void)
 	DRM_DEBUG_DRIVER("... runpm        : %d\n", nouveau_runtime_pm);
 	DRM_DEBUG_DRIVER("... vram_pushbuf : %d\n", nouveau_vram_pushbuf);
 	DRM_DEBUG_DRIVER("... hdmimhz      : %d\n", nouveau_hdmimhz);
+	DRM_DEBUG_DRIVER("... bind_gsp      : %d\n", nouveau_bind_gsp);
 }
 
 static const struct dev_pm_ops nouveau_pm_ops = {
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index a2ed8c4fe52a..a027860fa869 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -3143,7 +3143,7 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
 		 const struct nvkm_device_quirk *quirk,
 		 struct device *dev, enum nvkm_device_type type, u64 handle,
 		 const char *name, const char *cfg, const char *dbg,
-		 struct nvkm_device *device)
+		 bool bind_gsp, struct nvkm_device *device)
 {
 	struct nvkm_subdev *subdev;
 	u64 mmio_base, mmio_size;
@@ -3381,6 +3381,20 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
 		goto done;
 	}
 
+	/* Unless nouveau is the default NVIDIA driver, leave GSP-capable
+	 * (Turing and later) PCI GPUs to other drivers, such as nova-core.
+	 * Older GPUs are always bound.
+	 *
+	 * Reject before subdevs are constructed, as that would already load
+	 * GSP firmware for GPUs that are not going to be used.
+	 */
+	if (device->func->pci && device->card_type >= TU100 && !bind_gsp) {
+		nvdev_info(device, "leaving GSP-capable GPU to other drivers "
+			   "(bind_gsp=0)\n");
+		ret = -ENODEV;
+		goto done;
+	}
+
 	/* read strapping information */
 	strap = nvkm_rd32(device, 0x101000);
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
index 248623b91e29..1477a2fff51f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
@@ -1650,7 +1650,7 @@ nvkm_device_pci_func = {
 
 int
 nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
-		    struct nvkm_device **pdevice)
+		    bool bind_gsp, struct nvkm_device **pdevice)
 {
 	const struct nvkm_device_quirk *quirk = NULL;
 	const struct nvkm_device_pci_device *pcid;
@@ -1703,7 +1703,7 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
 				    pci_dev->bus->number << 16 |
 				    PCI_SLOT(pci_dev->devfn) << 8 |
 				    PCI_FUNC(pci_dev->devfn), name,
-			       cfg, dbg, &pdev->device);
+			       cfg, dbg, bind_gsp, &pdev->device);
 
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h
index d0c40f034244..a462051d2977 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h
@@ -54,7 +54,7 @@ int  nvkm_device_ctor(const struct nvkm_device_func *,
 		      const struct nvkm_device_quirk *,
 		      struct device *, enum nvkm_device_type, u64 handle,
 		      const char *name, const char *cfg, const char *dbg,
-		      struct nvkm_device *);
+		      bool bind_gsp, struct nvkm_device *);
 int  nvkm_device_init(struct nvkm_device *);
 int  nvkm_device_fini(struct nvkm_device *, enum nvkm_suspend_state suspend);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 3c8d0878891a..1e69662f91cd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -329,9 +329,12 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra_func *func,
 
 	tdev->gpu_speedo = tegra_sku_info.gpu_speedo_value;
 	tdev->gpu_speedo_id = tegra_sku_info.gpu_speedo_id;
+	/* Platform devices are always bound, regardless of the bind_gsp
+	 * policy for PCI devices.
+	 */
 	ret = nvkm_device_ctor(&nvkm_device_tegra_func, NULL, &pdev->dev,
 			       NVKM_DEVICE_TEGRA, pdev->id, NULL,
-			       cfg, dbg, &tdev->device);
+			       cfg, dbg, true, &tdev->device);
 	if (ret)
 		goto powerdown;
 

-- 
2.56.1


