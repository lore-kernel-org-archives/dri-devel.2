Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ED2C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B118C10E4E4;
	Wed, 16 Sep 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TCnaNcT8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D0610E4A4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789598156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYC0BP4K9FPDVhgapKIGAX8eRJhVJN+Yrga/9RRK1Gs=;
 b=TCnaNcT8ZqzIaXluro98Q8E4qtaFpMKoonvoQDzrr+wJfYp3qqKNETRcc/e9uVz8h+J7CI
 szaWfIBsBr5iVfCa4zqtN6zFO0Z/GhKhU0LhWiYTqvmNRzdiV7QE400VPvjFSE88ZCH8+T
 RJztkV3mzcUuLrz7oZOhf61aKxtSERA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-NMdxwETeOKKnMMOfB7GJPQ-1; Wed,
 16 Sep 2026 18:35:51 -0400
X-MC-Unique: NMdxwETeOKKnMMOfB7GJPQ-1
X-Mimecast-MFC-AGG-ID: NMdxwETeOKKnMMOfB7GJPQ_1789598149
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 642FB180056E; Wed, 16 Sep 2026 22:35:49 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.64.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B661180056E; Wed, 16 Sep 2026 22:35:47 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Dave Airlie" <airlied@redhat.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Mel Henning" <mhenning@darkrefraction.com>,
 "Hongling Zeng" <zenghongling@kylinos.cn>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v4 4/5] drm/nouveau/gsp/r570: Start saving comptag backing
 stores
Date: Wed, 16 Sep 2026 18:25:08 -0400
Message-ID: <20260916223358.507351-5-lyude@redhat.com>
In-Reply-To: <20260916223358.507351-1-lyude@redhat.com>
References: <20260916223358.507351-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hMDsKoh0qhoEZKKZyg2uNJtTMUW4QUULLbDydGMwrg8_1789598149
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

One of the portions of OpenRM's fbsr process that we never implemented is
the saving and restoring of comptag backing stores. This isn't strictly
necessary for fbsr to work (as long as we don't specify bEnteringGcOff =
1), but implementing it brings us much closer to matching OpenRM's fbsr
process - which means we can rely on things being well tested on Nvidia's
side.

Now that we have the required driver workarounds in place and fetch the
required information from GSP's memsys on driver load, let's implement
support for this by fetching the required space for the compbit backing
stores and adding it to the amount of memory that we allocate for fbsr.

With this, we should be able to safely enable bEnteringGcOff in fbsr.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Fix object mismatch in r570_fb_get_compbit_store_size() (rm_ctrl_done
  and rm_ctrl_rd() were using different objects by mistake)
* Fix GSP object mismatchs
* Don't return the size of the compbit store directly from
  r570_fb_get_compbit_store_size(), this makes it impossible for us to
  return errors since it's a u64.

 .../nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 27 ++++++++++++++++++-
 .../nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h       | 23 ++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index fe618a94461dc..d3684bc4cf187 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -26,6 +26,23 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool suspend)
 	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 }
 
+static int
+r570_fb_get_compbit_store_size(struct nvkm_gsp *gsp, u64 *size)
+{
+	NV0080_CTRL_FB_GET_COMPBIT_STORE_INFO_PARAMS *ctrl;
+
+	ctrl = nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.object,
+				   NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO,
+				   sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	*size = ctrl->Size;
+
+	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.object, ctrl);
+	return 0;
+}
+
 static int
 r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool enable)
 {
@@ -135,7 +152,7 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
 	struct nvkm_device *device = subdev->device;
 	struct nvkm_instmem *imem = device->imem;
 	struct nvkm_instobj *iobj;
-	u64 size;
+	u64 size, compbit_store_size;
 	int ret;
 
 	/* Stop channel scheduling. */
@@ -152,6 +169,12 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
 			return ret;
 	}
 
+	ret = r570_fb_get_compbit_store_size(gsp, &compbit_store_size);
+	if (ret < 0)
+		return ret;
+	nvkm_debug(&gsp->subdev, "fbsr: Compbit backing store size: 0x%llx bytes\n",
+		   compbit_store_size);
+
 	/* Save BAR2 allocations to system memory. */
 	list_for_each_entry(iobj, &imem->list, head) {
 		if (iobj->preserve) {
@@ -174,6 +197,8 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
 	size  = gsp->fb.heap.size;
 	size += gsp->fb.rsvd_size;
 	size += gsp->fb.bios.vga_workspace.size;
+	size += compbit_store_size;
+
 	nvkm_debug(subdev, "fbsr: size: 0x%llx bytes\n", size);
 
 	ret = nvkm_gsp_sg(device, size, &gsp->sr.fbsr);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h
index 9050a8274b273..cb3e448415b42 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h
@@ -16,6 +16,29 @@ typedef struct NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS {
     NV_DECLARE_ALIGNED(NvU64 sysmemAddrOfSuspendResumeData, 8);
 } NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS;
 
+#define NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO (0x801306) /* finn: Evaluated from "(FINN_NV01_DEVICE_0_FB_INTERFACE_ID << 8) | NV0080_CTRL_FB_GET_COMPBIT_STORE_INFO_PARAMS_MESSAGE_ID" */
+
+typedef struct NV0080_CTRL_FB_GET_COMPBIT_STORE_INFO_PARAMS {
+    NV_DECLARE_ALIGNED(NvU64 Size, 8);
+    NV_DECLARE_ALIGNED(NvU64 Address, 8);
+    NvU32 AddressSpace;
+    NvU32 MaxCompbitLine;
+    NvU32 comptagsPerCacheLine;
+    NvU32 cacheLineSize;
+    NvU32 cacheLineSizePerSlice;
+    NvU32 cacheLineFetchAlignment;
+    NV_DECLARE_ALIGNED(NvU64 backingStoreBase, 8);
+    NvU32 gobsPerComptagPerSlice;
+    NvU32 backingStoreCbcBase;
+    NvU32 comptaglineAllocationPolicy;
+    NV_DECLARE_ALIGNED(NvU64 privRegionStartOffset, 8);
+    NvU32 cbcCoveragePerSlice;
+} NV0080_CTRL_FB_GET_COMPBIT_STORE_INFO_PARAMS;
+
+#define NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO_ADDRESS_SPACE_UNKNOWN 0 // ADDR_UNKNOWN
+#define NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO_ADDRESS_SPACE_SYSMEM  1 // ADDR_SYSMEM
+#define NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO_ADDRESS_SPACE_FBMEM   2 // ADDR_FBMEM
+
 #define NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE (0x20800a6f) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID << 8) | NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS_MESSAGE_ID" */
 
 typedef struct NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS {
-- 
2.55.0

