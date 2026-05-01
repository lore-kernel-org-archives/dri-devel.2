Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A379CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 21:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF4D10F634;
	Fri,  1 May 2026 21:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iw4zNM9C";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6190710F634
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 21:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777672749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/w4qNCZg0K61tLxc2dmtZAH4YsoauH0iGhCHk3w+L3w=;
 b=iw4zNM9Cxp4z6ENEg93g3UUjQ/jSKokzox0T+rLkrj+jpKEicHqd5Cxz9xjRC0QlNsPuz0
 yhgPY6T0bSVSa0aYSKhtATxEz0qPtd6oJ2T6t66UE15TpdlqU+BV2RKB4uw+8HY3FIrYB4
 gHjenjbmjYGb8hVV6LFF3lBHgYEQdHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-EOEI6xEhPveiyKAC_70A7w-1; Fri,
 01 May 2026 17:59:07 -0400
X-MC-Unique: EOEI6xEhPveiyKAC_70A7w-1
X-Mimecast-MFC-AGG-ID: EOEI6xEhPveiyKAC_70A7w_1777672745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6533D1800473; Fri,  1 May 2026 21:59:04 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D382130001A1; Fri,  1 May 2026 21:59:01 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Timur Tabi <ttabi@nvidia.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>, James Jones <jajones@nvidia.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, stable@vger.kernel.org,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Ben Skeggs" <bskeggs@nvidia.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] drm/nouveau/kms/nvd9-: Use contiguous memory for CRC notifier
 context
Date: Fri,  1 May 2026 17:58:55 -0400
Message-ID: <20260501215856.840898-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: z06neyeqOJEU3tzsSBgk-6tKxd-FnObw0OsvAazwGDI_1777672745
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

It looks like CRC read back has been slightly broken for a while now, in
particular on GPUs using GSP. On my test machines, it's worked normally
when attempting to use it from fbcon. After gnome-shell gets started
however, attempting to read /sys/kernel/debug/dri/$CARD/$CRTC/crc/data just
returns -EINVAL.

It turns out what's been happening is that since we've been using
nvif_mem_ctor_map() to both allocate and map the CRC notifier region - we
haven't actually asked for a contiguous allocation, and simply ask for
whatever type of memory allocation nouveau can find first. This doesn't
work because the CRC engine on nvidia GPUs doesn't support non-contiguous
allocations, which also causes us to fail setting up the kmsCrcNtfyCtxDma
object on pre-blackwell platforms since we don't have a single memory
address we can point nvif_object_ctor() to. Instead, ctx->mem.addr gets set
to ~0ULL.

It does however, seem to work when fbcon is running. The only reason I can
think of this is that before we start up a display environment, there is
pretty much nothing allocated in our VRAM that wasn't allocated by nouveau
itself - making it dramatically more likely that we end up finding a
contiguous allocation by default.

So, fix this by manually requesting a contiguous allocation when we
allocate our context notifiers.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
Cc: Lyude Paul <lyude@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: James Jones <jajones@nvidia.com>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.9+
---
 drivers/gpu/drm/nouveau/dispnv50/crc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
index deb6af40ef328..5817f39934a8b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
@@ -10,6 +10,7 @@
 #include <nvif/class.h>
 #include <nvif/cl0002.h>
 #include <nvif/timer.h>
+#include <nvif/if900b.h>
 
 #include <nvhw/class/cl907d.h>
 
@@ -499,16 +500,24 @@ nv50_crc_raster_type(enum nv50_crc_source source)
  * notifier needs it's own handle
  */
 static inline int
-nv50_crc_ctx_init(struct nv50_head *head, struct nvif_mmu *mmu,
+nv50_crc_ctx_init(struct drm_device *dev, struct nv50_head *head, struct nvif_mmu *mmu,
 		  struct nv50_crc_notifier_ctx *ctx, size_t len, int idx)
 {
-	struct nv50_core *core = nv50_disp(head->base.base.dev)->core;
+	struct nv50_core *core = nv50_disp(dev)->core;
 	int ret;
 
-	ret = nvif_mem_ctor_map(mmu, "kmsCrcNtfy", NVIF_MEM_VRAM, len, &ctx->mem);
+	/* The display engine requires a contiguous region of memory for the CRC notifier context */
+	ret = nvif_mem_ctor(mmu, "kmsCrcNtfy", mmu->mem, NVIF_MEM_VRAM | NVIF_MEM_MAPPABLE, 0, len,
+			    &(struct gf100_mem_v0) {
+				.contig = true,
+			    }, sizeof(struct gf100_mem_v0), &ctx->mem);
 	if (ret)
 		return ret;
 
+	ret = nvif_object_map(&ctx->mem.object, NULL, 0);
+	if (ret)
+		goto fail_fini;
+
 	/* No CTXDMAs on Blackwell. */
 	if (core->chan.base.user.oclass >= GB202_DISP_CORE_CHANNEL_DMA)
 		return 0;
@@ -576,7 +585,7 @@ int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str)
 
 	if (source) {
 		for (i = 0; i < ARRAY_SIZE(head->crc.ctx); i++) {
-			ret = nv50_crc_ctx_init(head, mmu, &crc->ctx[i],
+			ret = nv50_crc_ctx_init(dev, head, mmu, &crc->ctx[i],
 						func->notifier_len, i);
 			if (ret)
 				goto out_ctx_fini;

base-commit: 29d6da40d0b8bf3bbc3dcd1d2198434a0e1f71b0
-- 
2.54.0

