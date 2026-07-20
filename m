Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8629BC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A9310E208;
	Mon, 20 Jul 2026 21:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dwnBrBtH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5912010E20C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784584326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzHEt/JUKcSSo+NrPYMNWpznNd/HnyKFTRe4NDoHyE=;
 b=dwnBrBtHoSYUVrh2LHjoQEWMEKK/ANPY1ANLoMmnGRY+YS91Ov8uDTJqNVh7v3ePUBTi/o
 ghiSTVWKI/vxZ4OOeB9ApUvkvvZEXjyZVr5RyKtUjlMfOYCQwPqREt200ONt7pSMxam9XI
 I/njJ27HnfFhrkULr+5vhZvCpTiQ+0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-PGvBqEc6OX6dfgpXMwxmiQ-1; Mon,
 20 Jul 2026 17:52:00 -0400
X-MC-Unique: PGvBqEc6OX6dfgpXMwxmiQ-1
X-Mimecast-MFC-AGG-ID: PGvBqEc6OX6dfgpXMwxmiQ_1784584318
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCF89195E924; Mon, 20 Jul 2026 21:51:57 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.88.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BEC51800764; Mon, 20 Jul 2026 21:51:55 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Leandro Ribeiro" <leandro.ribeiro@collabora.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Pekka Paalanen" <pekka.paalanen@collabora.com>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Stone" <daniels@collabora.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 1/3] drm/nouveau/kms/nv50-: Add .blend_modes to
 nv50_wndw_func
Date: Mon, 20 Jul 2026 17:36:16 -0400
Message-ID: <20260720215058.398210-2-lyude@redhat.com>
In-Reply-To: <20260720215058.398210-1-lyude@redhat.com>
References: <20260720215058.398210-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3iOVh7Z06dg-aE2k-WIQCsJFQ5X2vGY7QSYPbtfHrXo_1784584318
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

At the moment, we currently (incorrectly) only expose a blend property on
the plane if we have a nv50_wndw_func->blend_set function for the given
wndw type. But we need to expose a blend property for all types of planes
that can display color formats with an alpha channel.

Prepare for doing this by introducing a way of looking up the supported
blend modes for a type of wndw by introducing .blend_modes, which describes
all possible blending modes nouveau currently supports for a type of wndw.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")

---
V3:
* Don't forget to specify .blend_modes for base.

 drivers/gpu/drm/nouveau/dispnv50/base.h     |  6 ++++++
 drivers/gpu/drm/nouveau/dispnv50/base507c.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/base827c.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/base907c.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c |  3 +++
 drivers/gpu/drm/nouveau/dispnv50/wndw.h     | 10 ++++++++++
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c |  1 +
 10 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/base.h b/drivers/gpu/drm/nouveau/dispnv50/base.h
index 085bd3aeb40b6..fbfd62d8fc798 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/base.h
@@ -1,5 +1,7 @@
 #ifndef __NV50_KMS_BASE_H__
 #define __NV50_KMS_BASE_H__
+#include <drm/drm_blend.h>
+
 #include "wndw.h"
 
 int base507c_new(struct nouveau_drm *, int, s32, struct nv50_wndw **);
@@ -24,4 +26,8 @@ extern const struct nv50_wndw_func base907c;
 int base917c_new(struct nouveau_drm *, int, s32, struct nv50_wndw **);
 
 int nv50_base_new(struct nouveau_drm *, int head, struct nv50_wndw **);
+
+/* The only blend mode supported by base channels */
+#define BASE_BLEND_MODES BIT(DRM_MODE_BLEND_PIXEL_NONE)
+
 #endif
diff --git a/drivers/gpu/drm/nouveau/dispnv50/base507c.c b/drivers/gpu/drm/nouveau/dispnv50/base507c.c
index a431f6c5f6fa9..41b648ab3c5e5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base507c.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/base507c.c
@@ -297,6 +297,7 @@ base507c = {
 	.image_set = base507c_image_set,
 	.image_clr = base507c_image_clr,
 	.update = base507c_update,
+	.blend_modes = BASE_BLEND_MODES,
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/dispnv50/base827c.c b/drivers/gpu/drm/nouveau/dispnv50/base827c.c
index 4545cc5f3a14b..6c290324b4f3e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base827c.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/base827c.c
@@ -93,6 +93,7 @@ base827c = {
 	.image_set = base827c_image_set,
 	.image_clr = base507c_image_clr,
 	.update = base507c_update,
+	.blend_modes = BASE_BLEND_MODES,
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/dispnv50/base907c.c b/drivers/gpu/drm/nouveau/dispnv50/base907c.c
index 4a2d5a259e15b..a94d8350224b6 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base907c.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/base907c.c
@@ -205,6 +205,7 @@ base907c = {
 	.image_set = base907c_image_set,
 	.image_clr = base507c_image_clr,
 	.update = base507c_update,
+	.blend_modes = BASE_BLEND_MODES,
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
index 1a889139cb053..5f2ff40388e7f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
@@ -29,6 +29,7 @@
 #include <nvhw/class/cl507a.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_fourcc.h>
 
 bool
@@ -164,6 +165,8 @@ curs507a_wndw = {
 	.acquire = curs507a_acquire,
 	.release = curs507a_release,
 	.prepare = curs507a_prepare,
+	// TODO: Cursors also support premulti, but we haven't hooked it up anywhere yet.
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
index 90d100514bef2..81af5c3369d4c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
@@ -1,6 +1,8 @@
 #ifndef __NV50_KMS_WNDW_H__
 #define __NV50_KMS_WNDW_H__
 #define nv50_wndw(p) container_of((p), struct nv50_wndw, plane)
+#include <drm/drm_blend.h>
+
 #include "disp.h"
 #include "atom.h"
 #include "lut.h"
@@ -74,6 +76,7 @@ struct nv50_wndw_func {
 	int (*image_clr)(struct nv50_wndw *);
 	int (*scale_set)(struct nv50_wndw *, struct nv50_wndw_atom *);
 	int (*blend_set)(struct nv50_wndw *, struct nv50_wndw_atom *);
+	unsigned int blend_modes;
 
 	int (*update)(struct nv50_wndw *, u32 *interlock);
 };
@@ -139,4 +142,11 @@ int wndwca7e_new(struct nouveau_drm *, enum drm_plane_type, int, s32,
 
 int nv50_wndw_new(struct nouveau_drm *, enum drm_plane_type, int index,
 		  struct nv50_wndw **);
+
+/* A set of blend modes supported by all wndws */
+#define WNDW_BLEND_MODES               \
+	  BIT(DRM_MODE_BLEND_COVERAGE) \
+	| BIT(DRM_MODE_BLEND_PREMULTI) \
+	| BIT(DRM_MODE_BLEND_PIXEL_NONE)
+
 #endif
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c b/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
index 554c4f91f8bec..7ab4d532118ee 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c
@@ -343,6 +343,7 @@ wndwc37e = {
 	.image_set = wndwc37e_image_set,
 	.image_clr = wndwc37e_image_clr,
 	.blend_set = wndwc37e_blend_set,
+	.blend_modes = WNDW_BLEND_MODES,
 	.update = wndwc37e_update,
 };
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c b/drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c
index d1ca51aae58cd..e220f43b5bca7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c
@@ -231,6 +231,7 @@ wndwc57e = {
 	.image_set = wndwc57e_image_set,
 	.image_clr = wndwc37e_image_clr,
 	.blend_set = wndwc37e_blend_set,
+	.blend_modes = WNDW_BLEND_MODES,
 	.update = wndwc37e_update,
 };
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c b/drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c
index 52af293c98f4a..580cf7abd8193 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c
@@ -95,6 +95,7 @@ wndwc67e = {
 	.image_set = wndwc67e_image_set,
 	.image_clr = wndwc37e_image_clr,
 	.blend_set = wndwc37e_blend_set,
+	.blend_modes = WNDW_BLEND_MODES,
 	.update = wndwc37e_update,
 };
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c b/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c
index 2cec8cfbd5461..d65ec438b434f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c
@@ -231,6 +231,7 @@ wndwca7e = {
 	.image_set = wndwca7e_image_set,
 	.image_clr = wndwca7e_image_clr,
 	.blend_set = wndwc37e_blend_set,
+	.blend_modes = WNDW_BLEND_MODES,
 	.update = wndwc37e_update,
 };
 
-- 
2.55.0

