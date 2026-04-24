Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4C1FE51F1
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85EF610F464;
	Fri, 24 Apr 2026 09:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OxJtVPy6";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BC210F45B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:20:19 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso47960095e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022418; x=1777627218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ekUI4nDZMkx0KM6sqy/3fDSyuXgjvFlGE7blQ8tIEs=;
 b=OxJtVPy6jsDVMi+o2qWJyKJWByLUE5lTth6oAWn2utvhlKxprQe/5A7+rohD+WOqdd
 C20q+tVxNEuocktqqCg3Te+gwn67U7FYRdTzf8URN6tvMKCxxN+LAAwSzWvZplo1YRvL
 vhlTSQUtRTJtvKZJ+Wu77MkjQBvl9HBRloAFydlrgBCDSo/B9glSCMcE2mr1SoU14W7p
 61EvvwtvafL9PLXWeKmLYzNmaxyQKtLGsAMlKc5KUszlabnNVAHXZejGLqzGudIrv7DO
 AOatPi6JaaCEALBNksPyu+s6IcrPw9CYYHmNhASV3Aof9oBjnVO3nfrZSIaM1gVSE1dq
 K6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022418; x=1777627218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ekUI4nDZMkx0KM6sqy/3fDSyuXgjvFlGE7blQ8tIEs=;
 b=UC6WQOvGRGKkM5q2tmAgmoa3xK7I8S7PE//e1wcussp+q1Yb1Eq3ESgCevc0cLMBOQ
 i+WnOSFlAdjNJs4WGXIxV93Yl2Uh6+DCCDirsbaY0iPBw9nhkOIA6oTVk3UN6JDPkvyM
 Opk4zGcjxq8ap64KIX23ojap6+kFKJXAe9yHKMzuBe6ZDKP9mUq94rgelbVKAOtbxvL0
 SEjeOD/p4VVLBO8pbZJe/1yyWhG0RAyuxBCGecoHaub9ywb88PD/aVhzLXPEYFVaV0G3
 F9G+k8iq7Yu5BEQcxVnH5GQNypEos0GhSWftQjM3kSgsL472cnLM43W/z0Pr64ND6Tiz
 eJEw==
X-Gm-Message-State: AOJu0YyZ9SMSAu3GZ0muwQC/tElexJKoi6UFCQbJmuxoxuZ+IRSJzrae
 LhBXyL5qhKqkSUK9d7G5b9h/FBhdk9KAUTrf2CuLABW1TTyMC7xkz/Jac5GaF+c9
X-Gm-Gg: AeBDievRyF/KWU4z9IP8Ju0TXzET2Go093rPLAhcQp9lZruoYCkjTgmiXFGEZrCEe5O
 q40bW6FjD0UrxvMJ5eTcYRWsj46n6UVjywHpbbZqx5GZizxUrRBjL9kM4/5R6ROE9uJlEcnu+ov
 ADGsrpT+ZpfrOlF20QdJauDpoW8uL9ttLujDU3IK0IxUH57AE0mQsTuGJPC0iIEaiy5MM3MkUdB
 CAeL57wcsNBmkn+kRlokz16LfJEE9Jo57flYXNqd5iYY4UiS8eX45OONV+s6Ym9uX/1LlSeEeYW
 6+rhI7E970LDu3ZWtiz6Ls6pxwGn4T0FD48vLdEx6EJpDK8UMjAXDzUKpu+1mu1HaJnGx8gbkXZ
 HWuh68/MvMRcDL5YaDY/GLjnANmd72rtq4LWr2+VMv2Lu6ogkY7jRbCc5WGLZIdwup7+bSGsZvW
 FotdMJtxh2VSWPqBZOn9pzO9qX8Q7W18Cv3eExsLkc8ggkPDQ=
X-Received: by 2002:a05:600c:a31a:b0:488:b239:77ec with SMTP id
 5b1f17b1804b1-488fb778db4mr340168305e9.17.1777022417927; 
 Fri, 24 Apr 2026 02:20:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f2:7300:95ce:4290:489c:f518])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm660955235e9.1.2026.04.24.02.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:20:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm/vmwgfx: replace ttm_validate_buffer with separate
 struct
Date: Fri, 24 Apr 2026 11:15:11 +0200
Message-ID: <20260424092012.5694-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424092012.5694-1-christian.koenig@amd.com>
References: <20260424092012.5694-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Finish removing the ttm_exec_buf dependency.

No intentional functional change, but only compile tested.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c       | 16 ++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c       | 12 +++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      | 14 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c        | 16 ++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c  |  8 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       | 24 +++++++++----------
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c    |  5 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h    | 10 ++++++++
 10 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
index bd96f4d5e090..15b8378f81a1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
@@ -48,17 +48,17 @@ vmw_user_context_base_to_res(struct ttm_base_object *base);
 
 static int vmw_gb_context_create(struct vmw_resource *res);
 static int vmw_gb_context_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf);
+			       struct vmw_validate_buffer *val_buf);
 static int vmw_gb_context_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf);
+				 struct vmw_validate_buffer *val_buf);
 static int vmw_gb_context_destroy(struct vmw_resource *res);
 static int vmw_dx_context_create(struct vmw_resource *res);
 static int vmw_dx_context_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf);
+			       struct vmw_validate_buffer *val_buf);
 static int vmw_dx_context_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf);
+				 struct vmw_validate_buffer *val_buf);
 static int vmw_dx_context_destroy(struct vmw_resource *res);
 
 static const struct vmw_user_resource_conv user_context_conv = {
@@ -339,7 +339,7 @@ static int vmw_gb_context_create(struct vmw_resource *res)
 }
 
 static int vmw_gb_context_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf)
+			       struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct {
@@ -367,7 +367,7 @@ static int vmw_gb_context_bind(struct vmw_resource *res,
 
 static int vmw_gb_context_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf)
+				 struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct ttm_buffer_object *bo = val_buf->bo;
@@ -506,7 +506,7 @@ static int vmw_dx_context_create(struct vmw_resource *res)
 }
 
 static int vmw_dx_context_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf)
+			       struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct {
@@ -576,7 +576,7 @@ void vmw_dx_context_scrub_cotables(struct vmw_resource *ctx,
 
 static int vmw_dx_context_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf)
+				 struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct ttm_buffer_object *bo = val_buf->bo;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index 091f1039a052..19108c9be75b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -122,10 +122,10 @@ const SVGACOTableType vmw_cotable_scrub_order[] = {
 };
 
 static int vmw_cotable_bind(struct vmw_resource *res,
-			    struct ttm_validate_buffer *val_buf);
+			    struct vmw_validate_buffer *val_buf);
 static int vmw_cotable_unbind(struct vmw_resource *res,
 			      bool readback,
-			      struct ttm_validate_buffer *val_buf);
+			      struct vmw_validate_buffer *val_buf);
 static int vmw_cotable_create(struct vmw_resource *res);
 static int vmw_cotable_destroy(struct vmw_resource *res);
 
@@ -214,14 +214,14 @@ static int vmw_cotable_unscrub(struct vmw_resource *res)
  * vmw_cotable_bind - Undo a cotable unscrub operation
  *
  * @res: Pointer to the cotable resource
- * @val_buf: Pointer to a struct ttm_validate_buffer prepared by the caller
+ * @val_buf: Pointer to a struct vmw_validate_buffer prepared by the caller
  * for convenience / fencing.
  *
  * This function issues commands to (re)bind the cotable to
  * its backing mob, which needs to be validated and reserved at this point.
  */
 static int vmw_cotable_bind(struct vmw_resource *res,
-			    struct ttm_validate_buffer *val_buf)
+			    struct vmw_validate_buffer *val_buf)
 {
 	/*
 	 * The create() callback may have changed @res->backup without
@@ -313,14 +313,14 @@ int vmw_cotable_scrub(struct vmw_resource *res, bool readback)
  *
  * @res: Pointer to the cotable resource.
  * @readback: Whether to read back cotable data to the backup buffer.
- * @val_buf: Pointer to a struct ttm_validate_buffer prepared by the caller
+ * @val_buf: Pointer to a struct vmw_validate_buffer prepared by the caller
  * for convenience / fencing.
  *
  * Unbinds the cotable from the device and fences the backup buffer.
  */
 static int vmw_cotable_unbind(struct vmw_resource *res,
 			      bool readback,
-			      struct ttm_validate_buffer *val_buf)
+			      struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_cotable *vcotbl = vmw_cotable(res);
 	struct vmw_private *dev_priv = res->dev_priv;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 57465f69c687..622b924472bf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -19,7 +19,6 @@
 #include <drm/drm_print.h>
 #include <drm/drm_rect.h>
 
-#include <drm/ttm/ttm_execbuf_util.h>
 #include <drm/ttm/ttm_tt.h>
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_bo.h>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 1a518ab81b28..79e53e39644d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -130,10 +130,9 @@ static void vmw_resource_release(struct kref *kref)
 		BUG_ON(ret);
 		if (vmw_resource_mob_attached(res) &&
 		    res->func->unbind != NULL) {
-			struct ttm_validate_buffer val_buf;
+			struct vmw_validate_buffer val_buf;
 
 			val_buf.bo = bo;
-			val_buf.num_shared = 0;
 			res->func->unbind(res, false, &val_buf);
 		}
 		res->guest_memory_size = false;
@@ -370,7 +369,7 @@ static int vmw_resource_buf_alloc(struct vmw_resource *res,
  * should be retried once resources have been freed up.
  */
 static int vmw_resource_do_validate(struct vmw_resource *res,
-				    struct ttm_validate_buffer *val_buf,
+				    struct vmw_validate_buffer *val_buf,
 				    bool dirtying)
 {
 	int ret = 0;
@@ -613,14 +612,13 @@ int vmw_resource_reserve(struct vmw_resource *res, bool interruptible,
 static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
 				 struct vmw_resource *res, bool interruptible)
 {
-	struct ttm_validate_buffer val_buf;
+	struct vmw_validate_buffer val_buf;
 	const struct vmw_res_func *func = res->func;
 	int ret;
 
 	BUG_ON(!func->may_evict);
 
 	val_buf.bo = NULL;
-	val_buf.num_shared = 0;
 	ret = vmw_resource_check_buffer(ticket, res, interruptible, &val_buf.bo);
 	if (unlikely(ret != 0))
 		return ret;
@@ -667,14 +665,13 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr,
 	struct vmw_resource *evict_res;
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct list_head *lru_list = &dev_priv->res_lru[res->func->res_type];
-	struct ttm_validate_buffer val_buf;
+	struct vmw_validate_buffer val_buf;
 	unsigned err_count = 0;
 
 	if (!res->func->create)
 		return 0;
 
 	val_buf.bo = NULL;
-	val_buf.num_shared = 0;
 	if (res->guest_memory_bo)
 		val_buf.bo = &res->guest_memory_bo->tbo;
 	do {
@@ -741,9 +738,8 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr,
  */
 void vmw_resource_unbind_list(struct vmw_bo *vbo)
 {
-	struct ttm_validate_buffer val_buf = {
+	struct vmw_validate_buffer val_buf = {
 		.bo = &vbo->tbo,
-		.num_shared = 0
 	};
 
 	dma_resv_assert_held(vbo->tbo.base.resv);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
index aa7cbd396bea..ac2ea9d688c1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
@@ -93,10 +93,10 @@ struct vmw_res_func {
 	int (*create) (struct vmw_resource *res);
 	int (*destroy) (struct vmw_resource *res);
 	int (*bind) (struct vmw_resource *res,
-		     struct ttm_validate_buffer *val_buf);
+		     struct vmw_validate_buffer *val_buf);
 	int (*unbind) (struct vmw_resource *res,
 		       bool readback,
-		       struct ttm_validate_buffer *val_buf);
+		       struct vmw_validate_buffer *val_buf);
 	void (*commit_notify)(struct vmw_resource *res,
 			      enum vmw_cmdbuf_res_state state);
 	int (*dirty_alloc)(struct vmw_resource *res);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index eca4e3e97eb4..dc6bce2d3283 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -60,18 +60,18 @@ vmw_user_shader_base_to_res(struct ttm_base_object *base);
 
 static int vmw_gb_shader_create(struct vmw_resource *res);
 static int vmw_gb_shader_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf);
+			       struct vmw_validate_buffer *val_buf);
 static int vmw_gb_shader_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf);
+				 struct vmw_validate_buffer *val_buf);
 static int vmw_gb_shader_destroy(struct vmw_resource *res);
 
 static int vmw_dx_shader_create(struct vmw_resource *res);
 static int vmw_dx_shader_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf);
+			       struct vmw_validate_buffer *val_buf);
 static int vmw_dx_shader_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf);
+				 struct vmw_validate_buffer *val_buf);
 static void vmw_dx_shader_commit_notify(struct vmw_resource *res,
 					enum vmw_cmdbuf_res_state state);
 static bool vmw_shader_id_ok(u32 user_key, SVGA3dShaderType shader_type);
@@ -243,7 +243,7 @@ static int vmw_gb_shader_create(struct vmw_resource *res)
 }
 
 static int vmw_gb_shader_bind(struct vmw_resource *res,
-			      struct ttm_validate_buffer *val_buf)
+			      struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct {
@@ -271,7 +271,7 @@ static int vmw_gb_shader_bind(struct vmw_resource *res,
 
 static int vmw_gb_shader_unbind(struct vmw_resource *res,
 				bool readback,
-				struct ttm_validate_buffer *val_buf)
+				struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct {
@@ -443,7 +443,7 @@ static int vmw_dx_shader_create(struct vmw_resource *res)
  *
  */
 static int vmw_dx_shader_bind(struct vmw_resource *res,
-			      struct ttm_validate_buffer *val_buf)
+			      struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct ttm_buffer_object *bo = val_buf->bo;
@@ -505,7 +505,7 @@ static int vmw_dx_shader_scrub(struct vmw_resource *res)
  */
 static int vmw_dx_shader_unbind(struct vmw_resource *res,
 				bool readback,
-				struct ttm_validate_buffer *val_buf)
+				struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct vmw_fence_obj *fence;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
index 52c6cfa163da..e66479cc14f7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
@@ -55,9 +55,9 @@ struct vmw_dx_streamoutput {
 
 static int vmw_dx_streamoutput_create(struct vmw_resource *res);
 static int vmw_dx_streamoutput_bind(struct vmw_resource *res,
-				    struct ttm_validate_buffer *val_buf);
+				    struct vmw_validate_buffer *val_buf);
 static int vmw_dx_streamoutput_unbind(struct vmw_resource *res, bool readback,
-				      struct ttm_validate_buffer *val_buf);
+				      struct vmw_validate_buffer *val_buf);
 static void vmw_dx_streamoutput_commit_notify(struct vmw_resource *res,
 					      enum vmw_cmdbuf_res_state state);
 
@@ -136,7 +136,7 @@ static int vmw_dx_streamoutput_create(struct vmw_resource *res)
 }
 
 static int vmw_dx_streamoutput_bind(struct vmw_resource *res,
-				    struct ttm_validate_buffer *val_buf)
+				    struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct ttm_buffer_object *bo = val_buf->bo;
@@ -191,7 +191,7 @@ static int vmw_dx_streamoutput_scrub(struct vmw_resource *res)
 }
 
 static int vmw_dx_streamoutput_unbind(struct vmw_resource *res, bool readback,
-				      struct ttm_validate_buffer *val_buf)
+				      struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct vmw_fence_obj *fence;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index b2d3927b5567..aa76e426e3fa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -63,18 +63,18 @@ static void vmw_user_surface_free(struct vmw_resource *res);
 static struct vmw_resource *
 vmw_user_surface_base_to_res(struct ttm_base_object *base);
 static int vmw_legacy_srf_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf);
+			       struct vmw_validate_buffer *val_buf);
 static int vmw_legacy_srf_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf);
+				 struct vmw_validate_buffer *val_buf);
 static int vmw_legacy_srf_create(struct vmw_resource *res);
 static int vmw_legacy_srf_destroy(struct vmw_resource *res);
 static int vmw_gb_surface_create(struct vmw_resource *res);
 static int vmw_gb_surface_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf);
+			       struct vmw_validate_buffer *val_buf);
 static int vmw_gb_surface_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf);
+				 struct vmw_validate_buffer *val_buf);
 static int vmw_gb_surface_destroy(struct vmw_resource *res);
 static int
 vmw_gb_surface_define_internal(struct drm_device *dev,
@@ -443,7 +443,7 @@ static int vmw_legacy_srf_create(struct vmw_resource *res)
  *
  * @res:            Pointer to a struct vmw_res embedded in a struct
  *                  vmw_surface.
- * @val_buf:        Pointer to a struct ttm_validate_buffer containing
+ * @val_buf:        Pointer to a struct vmw_validate_buffer containing
  *                  information about the backup buffer.
  * @bind:           Boolean wether to DMA to the surface.
  *
@@ -455,7 +455,7 @@ static int vmw_legacy_srf_create(struct vmw_resource *res)
  * will also be returned reserved iff @bind is true.
  */
 static int vmw_legacy_srf_dma(struct vmw_resource *res,
-			      struct ttm_validate_buffer *val_buf,
+			      struct vmw_validate_buffer *val_buf,
 			      bool bind)
 {
 	SVGAGuestPtr ptr;
@@ -497,14 +497,14 @@ static int vmw_legacy_srf_dma(struct vmw_resource *res,
  *
  * @res:            Pointer to a struct vmw_res embedded in a struct
  *                  vmw_surface.
- * @val_buf:        Pointer to a struct ttm_validate_buffer containing
+ * @val_buf:        Pointer to a struct vmw_validate_buffer containing
  *                  information about the backup buffer.
  *
  * This function will copy backup data to the surface if the
  * backup buffer is dirty.
  */
 static int vmw_legacy_srf_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf)
+			       struct vmw_validate_buffer *val_buf)
 {
 	if (!res->guest_memory_dirty)
 		return 0;
@@ -520,14 +520,14 @@ static int vmw_legacy_srf_bind(struct vmw_resource *res,
  * @res:            Pointer to a struct vmw_res embedded in a struct
  *                  vmw_surface.
  * @readback:       Readback - only true if dirty
- * @val_buf:        Pointer to a struct ttm_validate_buffer containing
+ * @val_buf:        Pointer to a struct vmw_validate_buffer containing
  *                  information about the backup buffer.
  *
  * This function will copy backup data from the surface.
  */
 static int vmw_legacy_srf_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf)
+				 struct vmw_validate_buffer *val_buf)
 {
 	if (unlikely(readback))
 		return vmw_legacy_srf_dma(res, val_buf, false);
@@ -1254,7 +1254,7 @@ static int vmw_gb_surface_create(struct vmw_resource *res)
 
 
 static int vmw_gb_surface_bind(struct vmw_resource *res,
-			       struct ttm_validate_buffer *val_buf)
+			       struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct {
@@ -1300,7 +1300,7 @@ static int vmw_gb_surface_bind(struct vmw_resource *res,
 
 static int vmw_gb_surface_unbind(struct vmw_resource *res,
 				 bool readback,
-				 struct ttm_validate_buffer *val_buf)
+				 struct vmw_validate_buffer *val_buf)
 {
 	struct vmw_private *dev_priv = res->dev_priv;
 	struct ttm_buffer_object *bo = val_buf->bo;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index 1f2d16a5e6a3..98aa8deed98b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -43,7 +43,7 @@
  * large numbers and space conservation is desired.
  */
 struct vmw_validation_bo_node {
-	struct ttm_validate_buffer base;
+	struct vmw_validate_buffer base;
 	struct vmwgfx_hash_item hash;
 	unsigned int coherent_count;
 };
@@ -250,7 +250,7 @@ int vmw_validation_add_bo(struct vmw_validation_context *ctx,
 
 	bo_node = vmw_validation_find_bo_dup(ctx, vbo);
 	if (!bo_node) {
-		struct ttm_validate_buffer *val_buf;
+		struct vmw_validate_buffer *val_buf;
 
 		bo_node = vmw_validation_mem_alloc(ctx, sizeof(*bo_node));
 		if (!bo_node)
@@ -264,7 +264,6 @@ int vmw_validation_add_bo(struct vmw_validation_context *ctx,
 		val_buf = &bo_node->base;
 		vmw_bo_reference(vbo);
 		val_buf->bo = &vbo->tbo;
-		val_buf->num_shared = 0;
 		list_add_tail(&val_buf->head, &ctx->bo_list);
 	}
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 55a7d8b68d5c..f68cc1fd1eb4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -65,6 +65,16 @@ struct vmw_validation_context {
 	u8 *page_address;
 };
 
+/**
+ * struct vmw_validate_buffer - Linked list of TTM BOs for validation
+ * @head: linked list node
+ * @bo: The TTM BO
+ */
+struct vmw_validate_buffer {
+	struct list_head head;
+	struct ttm_buffer_object *bo;
+};
+
 struct vmw_bo;
 struct vmw_resource;
 struct vmw_fence_obj;
-- 
2.43.0

