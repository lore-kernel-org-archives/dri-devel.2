Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251C5C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB1710E1F1;
	Mon, 20 Jul 2026 20:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LwKR647X";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EE410E1EB
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784580971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkFbcmN22+jwJHxujtPfv4GRpg6PFI3N28PCo7GA/48=;
 b=LwKR647XHIHd7ZFoBKDH3DxN+EuyHBCwpfv17by1E/WRTKeusKb7hMHSwOqJUITFhq7cYH
 fXQnoLfx+QhPhsiUDGKGQuwCjZjX43WJSbiIvjN3jmJt9JxpAv6o6jmRTZx+ifVVinfZdm
 t2wGmbL/S6tl65BUWFmmH7KPYRYI2bU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519--4j-v273McKzSOej8fnPQw-1; Mon,
 20 Jul 2026 16:56:07 -0400
X-MC-Unique: -4j-v273McKzSOej8fnPQw-1
X-Mimecast-MFC-AGG-ID: -4j-v273McKzSOej8fnPQw_1784580965
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A4BC195DE34; Mon, 20 Jul 2026 20:56:05 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.88.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E5AE1955F78; Mon, 20 Jul 2026 20:56:02 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Leandro Ribeiro" <leandro.ribeiro@collabora.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Kees Cook" <kees@kernel.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Simona Vetter" <simona@ffwll.ch>,
 "Pekka Paalanen" <pekka.paalanen@collabora.com>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Stone" <daniels@collabora.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 2/3] drm/nouveau/kms/nv50-: Introduce
 nv50_wndw_default_state()
Date: Mon, 20 Jul 2026 16:43:56 -0400
Message-ID: <20260720205541.257781-3-lyude@redhat.com>
In-Reply-To: <20260720205541.257781-1-lyude@redhat.com>
References: <20260720205541.257781-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: IvduzJpm3nJDNB5aX8SHH_KFYFy8JYQWSinnnhgyWNc_1784580965
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

While we don't currently read-in the hardware state of planes, now that
we're about to start exposing blend properties for all planes that can
support alpha channels: We need to make sure that the initial atomic state
for a wndw always starts off with a supported value in pixel_blend_mode.

The easiest way to do this is to introduce a nv50_wndw_default_state()
function, and use it in nv50_display_read_hw_state() - and use that
function to enforce a valid value for pixel_blend_mode during driver
startup.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |  4 ++++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv50/wndw.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 364227f5456f1..2c66e480b5116 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2768,6 +2768,7 @@ nv50_display_read_hw_state(struct nouveau_drm *drm)
 {
 	struct drm_device *dev = drm->dev;
 	struct drm_encoder *encoder;
+	struct drm_plane *plane;
 	struct drm_modeset_acquire_ctx ctx;
 	struct nv50_disp *disp = nv50_disp(dev);
 	int ret;
@@ -2781,6 +2782,9 @@ nv50_display_read_hw_state(struct nouveau_drm *drm)
 		nv50_display_read_hw_or_state(dev, disp, nouveau_encoder(encoder));
 	}
 
+	drm_for_each_plane(plane, dev)
+		nv50_wndw_default_state(nv50_wndw(plane));
+
 	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
 }
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 2635458d52acc..0f331f47bded8 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -848,6 +848,28 @@ static const u64 nv50_cursor_format_modifiers[] = {
 	DRM_FORMAT_MOD_INVALID,
 };
 
+/*
+ * Setup defaults for the atomic wndw state
+ */
+void
+nv50_wndw_default_state(struct nv50_wndw *wndw)
+{
+	struct nv50_wndw_atom *armw = nv50_wndw_atom(wndw->plane.state);
+	const unsigned int blend_modes = wndw->func->blend_modes;
+
+	drm_modeset_lock_assert_held(&wndw->plane.mutex);
+
+	/* Ensure the plane's atomic state didn't default to a pixel_blend_mode we don't support */
+	if (blend_modes && (!(armw->state.pixel_blend_mode & blend_modes))) {
+		if (blend_modes & BIT(DRM_MODE_BLEND_COVERAGE))
+			armw->state.pixel_blend_mode = DRM_MODE_BLEND_COVERAGE;
+		else if (blend_modes & BIT(DRM_MODE_BLEND_PREMULTI))
+			armw->state.pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+		else if (blend_modes & BIT(DRM_MODE_BLEND_PIXEL_NONE))
+			armw->state.pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
+	}
+}
+
 int
 nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_device *dev,
 	       enum drm_plane_type type, const char *name, int index,
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
index 81af5c3369d4c..13f06b7b67611 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
@@ -46,6 +46,7 @@ void nv50_wndw_flush_clr(struct nv50_wndw *, u32 *interlock, bool flush,
 			 struct nv50_wndw_atom *);
 void nv50_wndw_ntfy_enable(struct nv50_wndw *, struct nv50_wndw_atom *);
 int nv50_wndw_wait_armed(struct nv50_wndw *, struct nv50_wndw_atom *);
+void nv50_wndw_default_state(struct nv50_wndw *wndw);
 
 struct nv50_wndw_func {
 	int (*acquire)(struct nv50_wndw *, struct nv50_wndw_atom *asyw,
-- 
2.55.0

