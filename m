Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2F8F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC0C10F05F;
	Thu, 23 Apr 2026 10:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WrYXLoZJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F144C10F05F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:18:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D351643B25;
 Thu, 23 Apr 2026 10:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637FBC2BCB7;
 Thu, 23 Apr 2026 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939513;
 bh=StPuSNT3v9mUG9yIL0C0LyNvbckUDHCbg1QnqVjfuSU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WrYXLoZJb8QbkgkrnSHYLpMKxev+4bSQ6hcw/kfzKkTe3JJgtZtPgJGLhm+/6GT6N
 EE1YQ3WTG+aeigoZXgyAhEaH7QSqZkNrtCS7hhZnSLL7lq92ggA8q9InVhhU9WlBb9
 jKtl7gtxDPVUgt/1chwKLaqJVYIiLYuJMqUy8pbYQoga0QQMZqEq9uKATGjKWZaJ+k
 y/txJUQRuUg+RV72MeeRO+5CVcpzPxqV0sg2QioKYl33I71Z0C/a6TOwHahlUE5fsQ
 CmsgtKQyeyEisKIsVogiaL3P+MYesuUTpNtAxVa+u5TphcOzqXgUZKBbhUPZ1eMeS9
 yM4DSDQ8q6+JQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:14 +0200
Subject: [PATCH v2 01/28] drm/atomic: Fix unused but set warning in state
 iterator macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-1-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11733; i=mripard@kernel.org;
 h=from:subject:message-id; bh=StPuSNT3v9mUG9yIL0C0LyNvbckUDHCbg1QnqVjfuSU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP74I3/FOteK9mqz1qt/cNZyzzwm6yr4wmF+ndsxCU
 vht4KP3HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAieW2M9cUTN0voHfo5uXj6
 UTGuPRqxdzgX8d8ScysXuJEXx6lY7be2IaLQ93X0KZFrx59serxcgLFWxPbTzhXssfNcPjlozvd
 ap8Vf6yjY2eQTn2ib8DNu0iSHzisL6iUmxj26UaMtpHCglgsA
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_atomic.h | 64 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index f03cd199aee7..b9e7281cfc97 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -946,13 +946,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @connector: &struct drm_connector iteration cursor
@@ -968,12 +970,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @connector: &struct drm_connector iteration cursor
@@ -989,13 +992,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @crtc: &struct drm_crtc iteration cursor
@@ -1012,14 +1015,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @crtc: &struct drm_crtc iteration cursor
@@ -1035,11 +1038,12 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @crtc: &struct drm_crtc iteration cursor
@@ -1120,12 +1124,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
@@ -1142,12 +1148,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
@@ -1159,11 +1168,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @plane: &struct drm_plane iteration cursor
@@ -1178,11 +1189,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
  * @plane: &struct drm_plane iteration cursor
  * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
@@ -1216,12 +1230,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
@@ -1235,11 +1252,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
  * @__state: &struct drm_atomic_state pointer
@@ -1254,11 +1273,12 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
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
2.53.0

