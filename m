Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7BAC88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E269F10E337;
	Wed, 16 Sep 2026 00:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TGqRepPB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D7E10E337
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789518150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8TLCNDcpOzZL9oZqO6JuLChee84UynQwHLk6zmnhaI=;
 b=TGqRepPBsSk25rufsREH0LAlR3EPIuX9IV3x4fjOJT8qCFon8OroaG4DuGwkhKaswqHsAM
 DEX6eC1ASAdeuAMzXfKV8ihRfNiM6hFAraOUqyPU2oJy2pACijW9XDkISi0fNUdUyBUnTy
 YzI2Q/xOBKSOY03mf2IaLRFSwFM+Eoo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-iG9UQfvBPaaD0mdm0-COIQ-1; Tue,
 15 Sep 2026 20:22:26 -0400
X-MC-Unique: iG9UQfvBPaaD0mdm0-COIQ-1
X-Mimecast-MFC-AGG-ID: iG9UQfvBPaaD0mdm0-COIQ_1789518144
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D08D51862D4E; Wed, 16 Sep 2026 00:22:23 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56B103003EFB; Wed, 16 Sep 2026 00:22:21 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>,
 "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Hongling Zeng" <zenghongling@kylinos.cn>,
 "Mel Henning" <mhenning@darkrefraction.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
Date: Tue, 15 Sep 2026 20:09:51 -0400
Message-ID: <20260916001603.22394-2-lyude@redhat.com>
In-Reply-To: <20260916001603.22394-1-lyude@redhat.com>
References: <20260916001603.22394-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 2zhlGnc1QGZVziueBXgCPHvwDycdh4jkPS7uwV6DXlQ_1789518144
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

OpenRM's runtime PM handling looks a bit different then nouveau's, one part
in particular that differs from us: OpenRM actually consults GSP to ask
whether the GPU should be allowed to enter Gc6 and/or GcOff before runtime
suspending the GPU. In the event the card isn't ready, runtime suspend is
simply delayed for a few seconds before retrying.

Implement the command used for querying GSP about this,
NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE, and check to ensure that
the GPU is ready for runtime suspend in nouveau_pmops_runtime_suspend()
using this query. If the GPU can't be runtime suspended, update the last
busy counter of the device and then return -EBUSY from
nouveau_pmops_runtime_suspend() - essentially delaying the runtime suspend
process by whatever autosuspend_delay_ms is set to.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Remove accidental return of bitmask from nvkm_udevice_gcx_ready()
* Use gsp variable in nvkm_udevice_gcx_ready() more.
* Remove unused GSP_GCX_ENTRY defines
V3:
* Fix error checking

 drivers/gpu/drm/nouveau/include/nvif/cl0080.h | 10 +++++
 drivers/gpu/drm/nouveau/include/nvif/device.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         | 13 +++++++
 drivers/gpu/drm/nouveau/nvif/device.c         | 13 +++++++
 .../gpu/drm/nouveau/nvkm/engine/device/user.c | 39 +++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/priv.h    |  1 +
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 26 +++++++++++++
 .../nvkm/subdev/gsp/rm/r535/nvrm/gsp.h        |  7 ++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  1 +
 9 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/cl0080.h b/drivers/gpu/drm/nouveau/include/nvif/cl0080.h
index ea8267e0d8da2..9e639df1da467 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/cl0080.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/cl0080.h
@@ -4,6 +4,7 @@
 
 #define NV_DEVICE_V0_INFO                                                  0x00
 #define NV_DEVICE_V0_TIME                                                  0x01
+#define NV_DEVICE_V0_GCX_READY						   0x02
 
 struct nv_device_info_v0 {
 	__u8  version;
@@ -55,6 +56,15 @@ struct nv_device_time_v0 {
 	__u64 time;
 };
 
+#define NV_DEVICE_GC6_READY	BIT(0)
+#define NV_DEVICE_GCOFF_READY	BIT(1)
+
+struct nv_device_gcx_ready_v0 {
+	__u8 version;
+	__u8 pad01[6];
+	__u8 ready;
+};
+
 #define NV_DEVICE_INFO_UNIT                               (0xffffffffULL << 32)
 #define NV_DEVICE_INFO(n)                          ((n) | (0x00000000ULL << 32))
 #define NV_DEVICE_HOST(n)                          ((n) | (0x00000001ULL << 32))
diff --git a/drivers/gpu/drm/nouveau/include/nvif/device.h b/drivers/gpu/drm/nouveau/include/nvif/device.h
index 7877a2a79da9b..ce2fadcb05d9e 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/device.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/device.h
@@ -22,4 +22,5 @@ int  nvif_device_ctor(struct nvif_client *, const char *name, struct nvif_device
 void nvif_device_dtor(struct nvif_device *);
 int  nvif_device_map(struct nvif_device *);
 u64  nvif_device_time(struct nvif_device *);
+int  nvif_device_gcx_ready(struct nvif_device *);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index b0f9fb10a74dd..c2e2f430deded 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1157,6 +1157,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nouveau_drm *drm = pci_get_drvdata(pdev);
+	struct nvif_device *nvif = &drm->client.device;
 	int ret;
 
 	if (!nouveau_pmops_runtime()) {
@@ -1164,6 +1165,18 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	// Check if the GPU itself is ready for runtime suspend, otherwise mark as busy and check
+	// again in a bit.
+	ret = nvif_device_gcx_ready(nvif);
+	if (ret < 0) {
+		NV_ERROR(drm, "Failed to query GCX readiness (returned %d)\n", ret);
+		return -EBUSY;
+	} else if (!(ret & NV_DEVICE_GCOFF_READY)) {
+		NV_DEBUG(drm, "GPU isn't ready for suspend yet, delaying...\n");
+		pm_runtime_mark_last_busy(dev);
+		return -EBUSY;
+	}
+
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm, true);
 	pci_save_state(pdev);
diff --git a/drivers/gpu/drm/nouveau/nvif/device.c b/drivers/gpu/drm/nouveau/nvif/device.c
index 24880931039f6..1be9fbe6cb703 100644
--- a/drivers/gpu/drm/nouveau/nvif/device.c
+++ b/drivers/gpu/drm/nouveau/nvif/device.c
@@ -38,6 +38,19 @@ nvif_device_time(struct nvif_device *device)
 	return device->user.func->time(&device->user);
 }
 
+int
+nvif_device_gcx_ready(struct nvif_device *device)
+{
+	struct nv_device_gcx_ready_v0 args = {};
+	int ret;
+
+	ret = nvif_object_mthd(&device->object, NV_DEVICE_V0_GCX_READY, &args, sizeof(args));
+	if (ret)
+		return ret;
+
+	return args.ready;
+}
+
 int
 nvif_device_map(struct nvif_device *device)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
index 23d11d8221cb6..c47d6daa9e5aa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
@@ -27,6 +27,8 @@
 
 #include <core/client.h>
 #include <subdev/fb.h>
+#include <subdev/gsp.h>
+#include <subdev/gsp/priv.h>
 #include <subdev/instmem.h>
 #include <subdev/timer.h>
 
@@ -189,6 +191,41 @@ nvkm_udevice_time(struct nvkm_udevice *udev, void *data, u32 size)
 	return ret;
 }
 
+static int
+nvkm_udevice_gcx_ready(struct nvkm_udevice *udev, void *data, u32 size)
+{
+	struct nvkm_object *object = &udev->object;
+	struct nvkm_device *device = udev->device;
+	struct nvkm_gsp *gsp = device->gsp;
+	union {
+		struct nv_device_gcx_ready_v0 v0;
+	} *args = data;
+	int ret = -ENOSYS;
+
+	/* XXX: We don't know any way of performing this check outside of GSP, so just assume
+	 * things are ready for non-GSP clients.
+	 */
+	if (!gsp) {
+		args->v0.ready = NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
+		return 0;
+	}
+
+	nvif_ioctl(object, "device gcx ready size %d\n", size);
+	ret = nvif_unpack(ret, &data, &size, args->v0, 0, 0, false);
+	if (!ret) {
+		nvif_ioctl(object, "device gcx ready vers %d\n", args->v0.version);
+
+		ret = r535_gsp_gcx_ready(gsp);
+		if (ret < 0)
+			return ret;
+
+		args->v0.ready = ret;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int
 nvkm_udevice_mthd(struct nvkm_object *object, u32 mthd, void *data, u32 size)
 {
@@ -199,6 +236,8 @@ nvkm_udevice_mthd(struct nvkm_object *object, u32 mthd, void *data, u32 size)
 		return nvkm_udevice_info(udev, data, size);
 	case NV_DEVICE_V0_TIME:
 		return nvkm_udevice_time(udev, data, size);
+	case NV_DEVICE_V0_GCX_READY:
+		return nvkm_udevice_gcx_ready(udev, data, size);
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
index 71b7203bef507..b07797813b049 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
@@ -93,6 +93,7 @@ void r535_gsp_dtor(struct nvkm_gsp *);
 int r535_gsp_oneinit(struct nvkm_gsp *);
 int r535_gsp_init(struct nvkm_gsp *);
 int r535_gsp_fini(struct nvkm_gsp *, enum nvkm_suspend_state suspend);
+int r535_gsp_gcx_ready(struct nvkm_gsp *gsp);
 
 int nvkm_gsp_new_(const struct nvkm_gsp_fwif *, struct nvkm_device *, enum nvkm_subdev_type, int,
 		  struct nvkm_gsp **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index 94925f1590ea4..09b17b85dc1ac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -30,6 +30,7 @@
 #include <engine/fifo/chan.h>
 #include <engine/sec2.h>
 #include <nvif/log.h>
+#include <nvif/cl0080.h>
 
 #include <nvfw/fw.h>
 
@@ -1721,6 +1722,31 @@ r535_gsp_sr_data_size(struct nvkm_gsp *gsp)
 	return meta->gspFwWprEnd - meta->gspFwWprStart;
 }
 
+int
+r535_gsp_gcx_ready(struct nvkm_gsp *gsp)
+{
+	NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS *ctrl;
+	int ret = 0;
+
+	ctrl = nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.subdevice,
+				   NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE,
+				   sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	if (ctrl->bIsGC6Satisfied)
+		ret |= NV_DEVICE_GC6_READY;
+	if (ctrl->bIsGCOFFSatisfied)
+		ret |= NV_DEVICE_GCOFF_READY;
+
+	nvkm_debug(&gsp->subdev,
+		   "GCX ready status: GC6=%s GCOFF=%s\n",
+		   str_yes_no(ctrl->bIsGC6Satisfied), str_yes_no(ctrl->bIsGCOFFSatisfied));
+
+	nvkm_gsp_rm_ctrl_done(&gsp->internal.client.object, ctrl);
+	return ret;
+}
+
 int
 r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
index b6683a5bf870c..fd1170037c030 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
@@ -782,6 +782,13 @@ typedef struct NV2080_CTRL_INTERNAL_INTR_GET_KERNEL_TABLE_PARAMS {
 
 #define GSP_FW_HEAP_PARAM_CLIENT_ALLOC_SIZE      ((48 << 10) * 2048)   // Support 2048 channels
 
+#define NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE (0x2080a7d7)
+
+typedef struct NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS {
+    NvBool bIsGC6Satisfied;
+    NvBool bIsGCOFFSatisfied;
+} NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS;
+
 typedef union rpc_message_rpc_union_field_v03_00
 {
     NvU32      spare;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index e9ac47d86b69a..3de7871e22934 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -174,6 +174,7 @@ int r535_gr_chan_new(struct nvkm_gr *, struct nvkm_chan *, const struct nvkm_ocl
 int r535_gr_promote_ctx(struct r535_gr *, bool golden, struct nvkm_vmm *,
 			struct nvkm_memory **pctxbuf_mem, struct nvkm_vma **pctxbuf_vma,
 			struct nvkm_gsp_object *chan);
+int r535_gsp_gcx_ready(struct nvkm_gsp *gsp);
 extern const struct nvkm_rm_api_engine r535_nvdec;
 extern const struct nvkm_rm_api_engine r535_nvenc;
 extern const struct nvkm_rm_api_engine r535_nvjpg;
-- 
2.55.0

