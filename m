Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B0ACDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 23:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5A310F3D0;
	Thu, 25 Jun 2026 23:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="abOD6wTY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC3910F3C2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782429360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xl3px75Nvxza7EusKK6+TYAla9vsm3zzqhoL4GNe8rU=;
 b=abOD6wTYVA7W6bZOgquLAkXlL64BUdK9QHM8XtCrZttfv8MXqQwhVJOKVWpmygPB6gyzTX
 MbT2NOGBPvGTfo7tqFTfer+vTsKjHCT0z4wfL8pLk3y0aE3SadypQMnFZEHQ4ldN3glkJF
 QSwrEtWbGn9WiAajGkirlpKD+XUcUqI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-l5U9TBKqNyGGF88jnBKy8w-1; Thu,
 25 Jun 2026 19:15:56 -0400
X-MC-Unique: l5U9TBKqNyGGF88jnBKy8w-1
X-Mimecast-MFC-AGG-ID: l5U9TBKqNyGGF88jnBKy8w_1782429354
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B449419540F1; Thu, 25 Jun 2026 23:15:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.18])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E51F30A8; Thu, 25 Jun 2026 23:15:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
 Kees Cook <kees@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Timur Tabi <ttabi@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mel Henning <mhenning@darkrefraction.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 1/2] Revert "nouveau/gsp: fix suspend/resume regression on
 r570 firmware"
Date: Thu, 25 Jun 2026 19:10:54 -0400
Message-ID: <20260625231252.89684-2-lyude@redhat.com>
In-Reply-To: <20260625231252.89684-1-lyude@redhat.com>
References: <20260625231252.89684-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: AByjsmvrYcupIqIP8iGsjqPsyvenBYvQRgxHBdWP7wA_1782429354
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

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.

It turns out this looked like the right fix on some systems, but it's not -
as this causes runtime PM to actually fail on many a laptop.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 firmware")
Cc: <stable@vger.kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Ben Skeggs <bskeggs@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mel Henning <mhenning@darkrefraction.com>
Cc: <stable@vger.kernel.org> # v6.19+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
index 700cea5def357..035b575722db7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c
@@ -208,7 +208,7 @@ r535_fbsr_resume(struct nvkm_gsp *gsp)
 }
 
 static int
-r535_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
+r535_fbsr_suspend(struct nvkm_gsp *gsp)
 {
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index f544afa12b6bb..4a3b771ded255 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1749,7 +1749,7 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 		sr->sysmemAddrOfSuspendResumeData = gsp->sr.radix3.lvl0.addr;
 		sr->sizeOfSuspendResumeData = len;
 
-		ret = rm->api->fbsr->suspend(gsp, suspend == NVKM_RUNTIME_SUSPEND);
+		ret = rm->api->fbsr->suspend(gsp);
 		if (ret) {
 			nvkm_gsp_mem_dtor(&gsp->sr.meta);
 			nvkm_gsp_radix3_dtor(gsp, &gsp->sr.radix3);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index 8ef8b4f655883..2945d5b4e5707 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -62,7 +62,7 @@ r570_fbsr_resume(struct nvkm_gsp *gsp)
 }
 
 static int
-r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtime)
+r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size)
 {
 	NV2080_CTRL_INTERNAL_FBSR_INIT_PARAMS *ctrl;
 	struct nvkm_gsp_object memlist;
@@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtim
 	ctrl->hClient = gsp->internal.client.object.handle;
 	ctrl->hSysMem = memlist.handle;
 	ctrl->sysmemAddrOfSuspendResumeData = gsp->sr.meta.addr;
-	ctrl->bEnteringGcoffState = runtime ? 1 : 0;
+	ctrl->bEnteringGcoffState = 1;
 
 	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 	if (ret)
@@ -92,7 +92,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size, bool runtim
 }
 
 static int
-r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
+r570_fbsr_suspend(struct nvkm_gsp *gsp)
 {
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
@@ -133,7 +133,7 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
 		return ret;
 
 	/* Initialise FBSR on RM. */
-	ret = r570_fbsr_init(gsp, &gsp->sr.fbsr, size, runtime);
+	ret = r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
 	if (ret) {
 		nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
 		return ret;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index a9af94adf9efc..0fb0e67406c67 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -78,7 +78,7 @@ struct nvkm_rm_api {
 	} *device;
 
 	const struct nvkm_rm_api_fbsr {
-		int (*suspend)(struct nvkm_gsp *, bool runtime);
+		int (*suspend)(struct nvkm_gsp *);
 		void (*resume)(struct nvkm_gsp *);
 	} *fbsr;
 
-- 
2.54.0

