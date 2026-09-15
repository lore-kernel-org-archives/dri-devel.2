Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0870C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3369510E59E;
	Tue, 15 Sep 2026 21:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="V2NKh7l3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7DE10E59E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789506463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kl861zy6Ub7DyVuYiyHgFrMcT8bEUnJjQS5VfDpwScM=;
 b=V2NKh7l3V4A275RzCWs1nWXVSTMmsSskmya4Nc1C4CTuNRzuqRq6Q2DOeQerAWvKbkmEhe
 0ttLC9qusln6u9O/ObONua2OfVreOLrV2+ni0ns6cZZFFyR+rXfLDp60ijpM1tSVQj5Sq3
 9GH4qtFIY7UP++Ljxx8pKrCMOqAHx3A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-IppXZmEzPiyLKP715-27bg-1; Tue,
 15 Sep 2026 17:07:38 -0400
X-MC-Unique: IppXZmEzPiyLKP715-27bg-1
X-Mimecast-MFC-AGG-ID: IppXZmEzPiyLKP715-27bg_1789506456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24A041956042; Tue, 15 Sep 2026 21:07:36 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.179])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E60D21800446; Tue, 15 Sep 2026 21:07:33 +0000 (UTC)
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
Subject: [PATCH v2 3/5] drm/nouveau/gsp/r570: Add comp mode workaround from
 issue #3172217
Date: Tue, 15 Sep 2026 14:51:50 -0400
Message-ID: <20260915210647.695187-4-lyude@redhat.com>
In-Reply-To: <20260915210647.695187-1-lyude@redhat.com>
References: <20260915210647.695187-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: tjtjG6w5Y94i3eHP29LXfho0bIo2Xp7mzwfral07AIA_1789506456
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

One of the things that OpenRM does right before initiating fbsr is apply a
special workaround (nvidia issue #3172217) which temporarily disables raw
compression mode on the GPU. It is later re-enabled after resuming with
fbsr completes.

Since we don't currently save the compbit backing with fbsr, this shouldn't
currently make any functional difference in the suspend/resume process. But
it will be required for implementing support for saving and restoring
compbit backings from the GPU.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Fix gsp object mismatch in r570_memsys_enable_raw_comp_mode()
* Clarify debug message a bit in r570_memsys_enable_raw_comp_mode()

 .../nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 48 +++++++++++++++++++
 .../nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h       |  6 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index af5aa5065c3dd..569732320f3dd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -26,6 +26,35 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool suspend)
 	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 }
 
+static int
+r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool enable)
+{
+	NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS *ctrl;
+	int ret;
+
+	ctrl = nvkm_gsp_rm_ctrl_get(&gsp->internal.device.object,
+				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE,
+				    sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	ctrl->bRawMode = enable;
+
+	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.object, ctrl);
+	if (!ret)
+		nvkm_debug(&gsp->subdev, "memsys: Raw compression mode %s\n",
+			   str_enabled_disabled(enable));
+
+	return ret;
+}
+
+static bool
+r570_need_raw_comp_war(struct nvkm_gsp *gsp, struct nvkm_device *device)
+{
+	return (device->card_type == GA100 || device->card_type == AD100) &&
+	    gsp->memsys.use_raw_mode_comptagline_alloc;
+}
+
 static void
 r570_fbsr_resume(struct nvkm_gsp *gsp)
 {
@@ -33,6 +62,7 @@ r570_fbsr_resume(struct nvkm_gsp *gsp)
 	struct nvkm_instmem *imem = device->imem;
 	struct nvkm_instobj *iobj;
 	struct nvkm_vmm *vmm;
+	int ret;
 
 	/* Restore BAR2 page tables via BAR0 window, and re-enable BAR2. */
 	list_for_each_entry(iobj, &imem->boot, head) {
@@ -59,6 +89,13 @@ r570_fbsr_resume(struct nvkm_gsp *gsp)
 
 	/* Finish cleaning up. */
 	r535_fbsr_resume(gsp);
+
+	/* Re-enable raw mode if it was previously disabled */
+	if (r570_need_raw_comp_war(gsp, device)) {
+		ret = r570_memsys_enable_raw_comp_mode(gsp, true);
+		if (ret)
+			nvkm_error(&gsp->subdev, "Failed to re-enable raw comp mode\n");
+	}
 }
 
 static int
@@ -104,6 +141,17 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
 	/* Stop channel scheduling. */
 	r570_fbsr_suspend_channels(gsp, true);
 
+	/* Temporarily disable raw mode to prevent FBSR restore operations from corrupting
+	 * compressed surfaces. Required for ampere and ada.
+	 *
+	 * Nvidia bug #3172217
+	 */
+	if (r570_need_raw_comp_war(gsp, device)) {
+		ret = r570_memsys_enable_raw_comp_mode(gsp, false);
+		if (ret)
+			return ret;
+	}
+
 	/* Save BAR2 allocations to system memory. */
 	list_for_each_entry(iobj, &imem->list, head) {
 		if (iobj->preserve) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h
index 8af432375f7a2..9050a8274b273 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h
@@ -16,4 +16,10 @@ typedef struct NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS {
     NV_DECLARE_ALIGNED(NvU64 sysmemAddrOfSuspendResumeData, 8);
 } NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS;
 
+#define NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE (0x20800a6f) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID << 8) | NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS_MESSAGE_ID" */
+
+typedef struct NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS {
+    NvBool bRawMode;
+} NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS;
+
 #endif
-- 
2.55.0

