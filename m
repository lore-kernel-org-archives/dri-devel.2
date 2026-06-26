Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE996C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE3210F5E0;
	Fri, 26 Jun 2026 13:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CHzc+nO9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9B610F5E0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E1C141336;
 Fri, 26 Jun 2026 13:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711011F000E9;
 Fri, 26 Jun 2026 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482245;
 bh=3+BzTQtJ+9XFMimx5iKdcp/aIAeajQ8Zs9F6fctwc5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CHzc+nO9Z+JMN0ZwtoSkuNiC43GwlagP2RZ0UdpHYRn9q7+USfPXXmnPqUJBopR5Q
 WkftQMJ05lC1voxNHjsAtNDehnr21dIUX1rjI+Z3+c5yTYN4hqUbJ/Ff53BKKmQrzE
 RHLRaorkeGuxFFk/PcCKfBPoUlW0NnqHR/+ssoRhsjyzYnYt7lldCU7vWs3R2t9M5j
 neJTVUVlrJu2j03LBDgrrt1orU0kWhRmNHBx79Vh6LsSwzBgsuprMFwHDRIqPAqIHg
 X5wCR4f4dcnreF6bk5bqSxmXZS/K138M4kN3Xl+2+ONvVyMLXgrIQavEXQcrw1E8XE
 YYzUKOwgBQYHw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:02 +0200
Subject: [PATCH v3 01/30] drm/atomic: Fix unused but set warning in state
 iterator macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-1-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11794; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6N237CrnovlFcNU8ELkAYIQVnQL5VznxZwusSI42vPg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2rYYOm//H/N7HwCKg/ii5U8/7/+2rD076rKqo7ngnN
 tv1rffWjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRtGbGhu5t12Y+bi/esNV/
 QsFfR3v9l243vHdNV336WG96YU7Fp6uvrslO1/6SK+OTzPyfL3BVNmN9oXuvZo+sv840huTFOa+
 WMq3L5MpfIhx1Nndn+Oflx/7aLq5RffT67JrqzD+NkzKn31sGAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

A number of state iterator macros trigger a compiler warning if an
iterator parameter isn't used in the code block.

Add a similar workaround than in most other macros.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_atomic.h | 64 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 88087910ab1a..1d05d5d7162e 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -949,13 +949,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = 0;								\
 	     (__i) < (__state)->num_connector;					\
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
-			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
-			     (old_connector_state) = (__state)->connectors[__i].old_state,	\
-			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
+			      (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_connector_state) = (__state)->connectors[__i].old_state,	\
+			      (void)(old_connector_state) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_connector_state) = (__state)->connectors[__i].new_state,	\
+			      (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_old_connector_in_state - iterate over all connectors in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @connector: &struct drm_connector iteration cursor
@@ -971,12 +973,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = 0;								\
 	     (__i) < (__state)->num_connector;					\
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
-			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
-			     (old_connector_state) = (__state)->connectors[__i].old_state, 1))
+			      (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_connector_state) = (__state)->connectors[__i].old_state, \
+			      (void)(old_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_new_connector_in_state - iterate over all connectors in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @connector: &struct drm_connector iteration cursor
@@ -992,13 +995,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = 0;								\
 	     (__i) < (__state)->num_connector;					\
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
-			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
-			     (new_connector_state) = (__state)->connectors[__i].new_state, \
-			     (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
+			      (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_connector_state) = (__state)->connectors[__i].new_state, \
+			      (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @crtc: &struct drm_crtc iteration cursor
@@ -1015,14 +1018,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i) < (__state)->dev->mode_config.num_crtc;		\
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
 			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
-			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
-			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
-			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
-			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
+			      (old_crtc_state) = (__state)->crtcs[__i].old_state, \
+			      (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_crtc_state) = (__state)->crtcs[__i].new_state, \
+			      (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_old_crtc_in_state - iterate over all CRTCs in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @crtc: &struct drm_crtc iteration cursor
@@ -1038,11 +1041,12 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i) < (__state)->dev->mode_config.num_crtc;		\
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
 			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
-			     (old_crtc_state) = (__state)->crtcs[__i].old_state, 1))
+			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
+			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_new_crtc_in_state - iterate over all CRTCs in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @crtc: &struct drm_crtc iteration cursor
@@ -1124,12 +1128,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i) < (__state)->dev->mode_config.num_total_plane;	\
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
 			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
-			      (old_plane_state) = (__state)->planes[__i].old_state,\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (old_plane_state) = (__state)->planes[__i].old_state, \
+			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state_reverse - iterate over all planes in an atomic
  * update in reverse order
  * @__state: &struct drm_atomic_commit pointer
@@ -1146,12 +1152,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1);	\
 	     (__i) >= 0;						\
 	     (__i)--)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (old_plane_state) = (__state)->planes[__i].old_state,\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_plane_state) = (__state)->planes[__i].old_state, \
+			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_new_plane_in_state_reverse - other than only tracking new state,
  * it's the same as for_each_oldnew_plane_in_state_reverse
  * @__state: &struct drm_atomic_commit pointer
@@ -1163,11 +1172,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1);	\
 	     (__i) >= 0;						\
 	     (__i)--)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_old_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @plane: &struct drm_plane iteration cursor
@@ -1182,11 +1193,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = 0;							\
 	     (__i) < (__state)->dev->mode_config.num_total_plane;	\
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_plane_state) = (__state)->planes[__i].old_state, \
+			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
+
 /**
  * for_each_new_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_commit pointer
  * @plane: &struct drm_plane iteration cursor
  * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
@@ -1220,12 +1234,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
  */
 #define for_each_oldnew_private_obj_in_state(__state, obj, old_obj_state, new_obj_state, __i) \
 	for ((__i) = 0; \
 	     (__i) < (__state)->num_private_objs && \
 		     ((obj) = (__state)->private_objs[__i].ptr, \
+		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
 		      (old_obj_state) = (__state)->private_objs[__i].old_state,	\
-		      (new_obj_state) = (__state)->private_objs[__i].new_state, 1); \
+		      (void)(old_obj_state) /* Only to avoid unused-but-set-variable warning */, \
+		      (new_obj_state) = (__state)->private_objs[__i].new_state, \
+		      (void)(new_obj_state) /* Only to avoid unused-but-set-variable warning */, 1); \
 	     (__i)++)
 
 /**
  * for_each_old_private_obj_in_state - iterate over all private objects in an atomic update
  * @__state: &struct drm_atomic_commit pointer
@@ -1239,11 +1256,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
  */
 #define for_each_old_private_obj_in_state(__state, obj, old_obj_state, __i) \
 	for ((__i) = 0; \
 	     (__i) < (__state)->num_private_objs && \
 		     ((obj) = (__state)->private_objs[__i].ptr, \
-		      (old_obj_state) = (__state)->private_objs[__i].old_state, 1); \
+		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
+		      (old_obj_state) = (__state)->private_objs[__i].old_state, \
+		      (void)(old_obj_state) /* Only to avoid unused-but-set-variable warning */, 1); \
 	     (__i)++)
 
 /**
  * for_each_new_private_obj_in_state - iterate over all private objects in an atomic update
  * @__state: &struct drm_atomic_commit pointer
@@ -1258,11 +1277,12 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 #define for_each_new_private_obj_in_state(__state, obj, new_obj_state, __i) \
 	for ((__i) = 0; \
 	     (__i) < (__state)->num_private_objs && \
 		     ((obj) = (__state)->private_objs[__i].ptr, \
 		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
-		      (new_obj_state) = (__state)->private_objs[__i].new_state, 1); \
+		      (new_obj_state) = (__state)->private_objs[__i].new_state, \
+		      (void)(new_obj_state) /* Only to avoid unused-but-set-variable warning */, 1); \
 	     (__i)++)
 
 /**
  * drm_atomic_crtc_needs_modeset - compute combined modeset need
  * @state: &drm_crtc_state for the CRTC

-- 
2.54.0

