Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA01AC982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3500610F207;
	Fri, 18 Sep 2026 07:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEoJuA7U";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474F810E032
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:13:27 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso1126926a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789668807; x=1790273607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7khdMbHecw2szquJ6Kapkum4M/lnE/1+tiTkVlutz8k=;
 b=mEoJuA7Ukyq75ytasG/+fMy9TR78U6LKm5KFEfgW4AwM06U0yjGlrtK6KdEEO0rnoC
 53i69/yNe6kZ634UtSDeoRcoVsiVFcs53xvmcuX+A+CvMIEriDkKpRk+sjl7hv2acF2I
 rBhNsqNm8JEluGCjDKnF0Y/ddnvWZvMPguHl/7V10cE1whWpOp6e7JeeDboEC+7PEzWr
 uiJs/d72DyvMTZEwubYM0y4CZwiBnBSaG900CRG6UpqOhg7+S9gcpfNfjzoNduLkerS/
 tWNkURbOiJH4z4zeC/WTlbKUq8sNW2sjYNZyIhEMag9t0gb0rIyOpwWpkcpUbwjaye66
 M+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789668807; x=1790273607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7khdMbHecw2szquJ6Kapkum4M/lnE/1+tiTkVlutz8k=;
 b=ebhms/i9uV1I39XTXHpWrDRDH1LZIxnTidABvb1RyA36PAx/FoYfm89+sw0eZoGw8F
 KOKNXZiJFynAHTXz4wFckugYC1udmv2RS/16HOoR4DZuYwk5vwYT39lCYzjJHskTDfUW
 8CIw/ow7O5KNYBuHGs7Q6vhBQ0VmyemxMY7a0eOzah4+hlLPuBtQUKbETiidAzKeJO9V
 J0YcB3tYWMa0rV9MyksvYuO0illOX1ir03XCP8FK6LxhbKTm9FFpOKuiFHBuRdHiDCRF
 B5O5I4UKIR1e3TR1+CGFrKcqPCicWiXpxoN03LLnGTKlk3kxO2aNLGK9Gx82M0rSumwm
 tzJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnNv9A4MDGdGmuZA2wjr1w2ZG0AJl3s0OeHLb6oiCPb63Dc5ndxWyetJoO/s2A6czObSIXCmPhZt8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnYMzmZhRZRHqy6xGi5yxyaOqbXT4GHrUjRUKjRPw9JrljrcMm
 3ry3fktG/MaeJWKrU7yNLNkqB3haE4+avUvSTdzz8WKOTHh9b0bTZiKY
X-Gm-Gg: AYBFou0OK+RrsbNb4HmAQr4JahLnHUXURJGB8QmCbGfxAW/JDp7V7jDNeFw4ZZ8ai/q
 /RQ1/J4PHeyTsSTBMwoNOZ/8Baf9fl3VT/+gNaP4I4lx8OzSc8k300LvDhymxcUx0BsxTylDYaC
 gU8IV47ng5i/ZTIzTPcvldAhTQjgX5lf3F7Veb1jLPBUUH+cS7OmUd3YAZtMHvD46rF7Q8VtNmk
 ROyCeeacFsfDvYYiFTwhWW+JWPDB9YifPOAtagV0tW2X53u4wfvHXo1DpezKltMPTzkLU41jbE6
 ZbdbbWm4iP/UYAIXeH/EuEz3fycBrunWpBO2M4+XhDncL5k3oxAomVnYSGdHq9C6FlrXYpKtdLf
 T/8vT4ELcz9Sv6bY2bSWETvpm9rfoFaWb+CzvOKzloMVjOpqv1yohxjOW+OiKZP9D90NfuYFuCo
 eP41iK+tWwRe8T/wzAczS+mZSZ2Rjk3Z+htn9yCqZVjKs+1REUYXUzkjQ03PaLkPH8ygC0USqkI
 IArecn0tQ==
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39e54dcd917mr18825a91.6.1789668806508; 
 Thu, 17 Sep 2026 11:13:26 -0700 (PDT)
Received: from om2 ([67.161.167.155]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm17209186eec.0.2026.09.17.11.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:13:25 -0700 (PDT)
From: Claire DuSoleil <claire.m.dusoleil@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Claire DuSoleil <claire.m.dusoleil@gmail.com>
Subject: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
Date: Thu, 17 Sep 2026 11:13:12 -0700
Message-ID: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

Importing a client's GPU buffer via the generic
DRM_IOCTL_PRIME_FD_TO_HANDLE ioctl succeeds for surface-backed dma-bufs,
but releasing the resulting handle via the equally-generic
DRM_IOCTL_GEM_CLOSE fails with -EINVAL.

vmw_prime_fd_to_handle() imports through ttm_prime_fd_to_handle(), which
files the handle in the driver's private ttm_object table (tdev->idr).
DRM_IOCTL_GEM_CLOSE only ever looks in the standard per-file GEM handle
table (file_priv->object_idr) -- there is no per-driver override for it
anywhere in struct drm_driver -- so it can never find a handle from the
private table and always returns -EINVAL.

This breaks any generic userspace that assumes PRIME_FD_TO_HANDLE and
GEM_CLOSE operate as a matched pair on the same table -- true for every
other driver, but not this one. Wayland compositors that validate a
client's dmabuf with a driver-agnostic import-then-close probe (e.g.
Hyprland's linux-dmabuf-v1 create_immed validation) treat the close
failure as "the buffer is invalid" and kill the client, even though the
buffer is fine.

ttm_prime_fd_to_handle() cannot simply be replaced with the generic
drm_gem_prime_fd_to_handle() path: vmw_prime_dmabuf_ops leaves .attach
and .map_dma_buf stubbed with -ENOSYS (surface storage lives host-side),
so the generic import path can never succeed for these buffers at all --
ttm_prime_fd_to_handle() is the only mechanism capable of importing a
surface-backed dma-buf.

Fix this by wrapping the private handle in a minimal, non-TTM-backed GEM
object registered in the standard per-file handle table, so ordinary
GEM_CLOSE finds it and releases the real reference through it.

Existing userspace (Mesa's own SVGA winsys, vmw_drm_surface_from_handle()
in vmw_screen_dri.c) also calls this ioctl for real rendering imports,
then feeds the returned value back into DRM_VMW_REF_SURFACE and
DRM_VMW_UNREF_SURFACE as a raw ttm handle -- so vmw_prime_fd_to_handle()
must keep returning something that still works as a raw ttm handle for
those two ioctls, and for every execbuf command that references a
surface by handle. vmw_prime_resolve_handle() is added to transparently
redirect a bridge handle back to the real ttm handle, and called from
every function that consumes a raw surface handle from userspace:
vmw_surface_handle_reference(), vmw_surface_destroy_ioctl(), and
vmw_user_resource_lookup_handle() -- the shared choke point behind
every execbuf command-validation call site, plus vmw_present_ioctl(),
vmw_user_object_lookup(), and vmw_dumb_create(). This keeps all of that
existing usage unaffected.

The bridge takes its own reference directly on the underlying
ttm_base_object (ttm_base_object_lookup_for_ref()/ttm_base_object_unref()),
independent of the tfile-scoped ttm_ref_object entry that
REF_SURFACE/UNREF_SURFACE manipulate, so its lifetime does not depend on
how many times userspace opens and closes its own references to the
same handle. The transient ttm_ref_object entry that
ttm_prime_fd_to_handle() itself creates is deliberately left in place
on success, matching stock behavior: vmw_surface_handle_reference()
forces require_exist=true for render clients, and ttm_ref_object_add()
with require_existed=true only reuses a pre-existing entry rather than
creating one, so removing it here would make every subsequent
DRM_VMW_REF_SURFACE call from a render client (both Mesa and this
validation pattern connect via the render node) fail with -EPERM.

Before this change, every object filed in file_priv->object_idr was
guaranteed to be a real struct vmw_bo, so vmw_user_bo_lookup() casts
the GEM object behind a looked-up handle straight to struct vmw_bo via
an unchecked container_of() (to_vmw_bo()). This is no longer true once
a bridge object can occupy a slot in the same table: passing a bridge
handle to any of vmw_user_bo_lookup()'s ten call sites (buffer/context/
shader binding, DRM_IOCTL_PRIME_HANDLE_TO_FD's small-handle branch,
etc.) would reinterpret a small vmw_prime_import_bridge allocation as
the much larger struct vmw_bo, causing an out-of-bounds read on every
subsequent field access. Fixed by rejecting a non-vmw_bo handle in
vmw_user_bo_lookup() itself: reject any handle whose gobj->funcs isn't
&vmw_gem_object_funcs, the same driver-established GEM object type tag
already used at both of struct vmw_bo's own creation sites, so this
introduces no new tagging mechanism and cannot reject a legitimate
vmw_bo.

Tested on a VMware Workstation guest, kernel 7.2.3-arch1-3 and, after a
later kernel update, 7.2.5-3-omarchy: a standalone
PRIME_FD_TO_HANDLE/GEM_CLOSE reproducer confirms the fix, real Hyprland
now compositing GPU-rendered clients that previously died on their
first frame, and the kernel log stays clean across driver init and
normal use, with no rejections logged from the new vmw_user_bo_lookup()
check. All seven changed files were also confirmed byte-for-byte
identical to drm-misc-next, and this patch applies to it directly with
no fuzz.

Signed-off-by: Claire DuSoleil <claire.m.dusoleil@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       |  13 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h      |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c  |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c    |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c    | 147 ++++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c  |  13 +-
 7 files changed, 178 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c..9d87f19 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -651,6 +651,19 @@ int vmw_user_bo_lookup(struct drm_file *filp,
 		return -ESRCH;
 	}
 
+	/*
+	 * A handle in the standard GEM table is not necessarily a real
+	 * vmw_bo -- it may be a prime-import bridge object (see
+	 * vmwgfx_prime.c). to_vmw_bo() below is an unchecked container_of;
+	 * calling it on anything else corrupts an out-of-bounds pointer.
+	 */
+	if (gobj->funcs != &vmw_gem_object_funcs) {
+		drm_gem_object_put(gobj);
+		DRM_ERROR("Handle 0x%08lx is not a vmwgfx buffer object.\n",
+			  (unsigned long)handle);
+		return -ESRCH;
+	}
+
 	*out = to_vmw_bo(gobj);
 
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8a..bf8a453 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -788,6 +788,7 @@ extern int vmw_resource_reserve(struct vmw_resource *res, bool interruptible,
 extern bool vmw_resource_needs_backup(const struct vmw_resource *res);
 extern int vmw_user_resource_lookup_handle(
 	struct vmw_private *dev_priv,
+	struct drm_file *file_priv,
 	struct ttm_object_file *tfile,
 	uint32_t handle,
 	const struct vmw_user_resource_conv *converter,
@@ -1105,6 +1106,8 @@ extern int vmw_prime_handle_to_fd(struct drm_device *dev,
 				  struct drm_file *file_priv,
 				  uint32_t handle, uint32_t flags,
 				  int *prime_fd);
+extern uint32_t vmw_prime_resolve_handle(struct drm_file *file_priv,
+					 uint32_t handle);
 struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
 						 struct dma_buf_attachment *attach,
 						 struct sg_table *table);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6..7383319 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -648,7 +648,8 @@ vmw_cmd_res_check(struct vmw_private *dev_priv,
 			return ret;
 
 		ret = vmw_user_resource_lookup_handle
-			(dev_priv, sw_context->fp->tfile, *id_loc, converter, &res);
+			(dev_priv, sw_context->filp, sw_context->fp->tfile, *id_loc,
+			 converter, &res);
 		if (ret != 0) {
 			VMW_DEBUG_USER("Could not find/use resource 0x%08x.\n",
 				       (unsigned int) *id_loc);
@@ -4073,7 +4074,7 @@ static int vmw_execbuf_tie_context(struct vmw_private *dev_priv,
 		return ret;
 
 	ret = vmw_user_resource_lookup_handle
-		(dev_priv, sw_context->fp->tfile, handle,
+		(dev_priv, sw_context->filp, sw_context->fp->tfile, handle,
 		 user_context_converter, &res);
 	if (ret != 0) {
 		VMW_DEBUG_USER("Could not find or user DX context 0x%08x.\n",
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
index d962ef2..1494a8d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
@@ -220,7 +220,7 @@ int vmw_present_ioctl(struct drm_device *dev, void *data,
 	}
 	vfb = vmw_framebuffer_to_vfb(fb);
 
-	ret = vmw_user_resource_lookup_handle(dev_priv, tfile, arg->sid,
+	ret = vmw_user_resource_lookup_handle(dev_priv, file_priv, tfile, arg->sid,
 					      user_surface_converter,
 					      &res);
 	if (ret)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
index 598b90a..5315251 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
@@ -35,6 +35,7 @@
 #include "vmwgfx_bo.h"
 #include "ttm_object.h"
 #include <linux/dma-buf.h>
+#include <linux/slab.h>
 
 /*
  * DMA-BUF attach- and mapping methods. No need to implement
@@ -72,15 +73,157 @@ const struct dma_buf_ops vmw_prime_dmabuf_ops =  {
 	.release = NULL,
 };
 
+/*
+ * A surface-backed dma-buf can only be imported through
+ * ttm_prime_fd_to_handle() -- vmw_prime_dmabuf_ops leaves .attach and
+ * .map_dma_buf unimplemented above, so the generic PRIME import path
+ * (drm_gem_prime_fd_to_handle() -> dma_buf_attach()) can never reach it and
+ * fails with -ENOSYS before it starts. ttm_prime_fd_to_handle() works
+ * because it bypasses dma-buf attach/map entirely and reads dma_buf->priv
+ * directly, but the handle it returns lives in the private ttm_object
+ * table (tdev->idr), not file_priv->object_idr, so the generic
+ * DRM_IOCTL_GEM_CLOSE (drm_gem_handle_delete(), which only ever looks in
+ * file_priv->object_idr) can never find it and fails with -EINVAL.
+ *
+ * Bridge the two tables: wrap the real ttm_base_object in a minimal,
+ * non-TTM-backed GEM object and hand back a handle from the standard
+ * table instead, so ordinary GEM_CLOSE succeeds.
+ *
+ * Existing userspace (Mesa's own SVGA winsys, in vmw_drm_surface_from_handle())
+ * calls this exact ioctl for real rendering imports too, then feeds the
+ * returned value straight back into DRM_VMW_REF_SURFACE / DRM_VMW_UNREF_SURFACE
+ * as a raw ttm handle -- it is not just a probe-only code path. So the value
+ * returned here must keep working as a raw ttm handle for those two ioctls
+ * and for every execbuf command that references a surface by handle
+ * (vmw_user_resource_lookup_handle(), the single choke point all of those
+ * funnel through). vmw_prime_resolve_handle() below is called from all three
+ * of those places to transparently redirect a bridge handle back to the real
+ * ttm handle, so existing userspace keeps working unmodified.
+ *
+ * The bridge's own hold on the object is a *separate*, independent
+ * ttm_base_object reference (taken via ttm_base_object_lookup_for_ref(),
+ * released via ttm_base_object_unref()), not a claim on the tfile-scoped
+ * ttm_ref_object entry that REF_SURFACE/UNREF_SURFACE manipulate. That
+ * entry is created transiently by ttm_prime_fd_to_handle() below and is
+ * deliberately left alone on success -- see the comment at the end of
+ * vmw_prime_fd_to_handle() for why it cannot simply be dropped here
+ * (vmw_surface_handle_reference()'s require_exist path depends on it
+ * still existing). This bridge's own reference exists alongside it,
+ * purely so this bridge's lifetime never depends on how many times
+ * userspace itself opens and closes references to the same ttm handle:
+ * without it, if userspace fully released the ttm handle through its own
+ * REF/UNREF_SURFACE calls while this GEM handle was still open, this
+ * bridge's eventual .free() would unref a handle number that may by then
+ * have been recycled for a completely unrelated object.
+ */
+struct vmw_prime_import_bridge {
+	struct drm_gem_object    base;
+	struct ttm_base_object  *base_obj;
+	uint32_t                 ttm_handle;
+};
+
+static void vmw_prime_import_bridge_free(struct drm_gem_object *obj)
+{
+	struct vmw_prime_import_bridge *bridge =
+		container_of(obj, struct vmw_prime_import_bridge, base);
+
+	ttm_base_object_unref(&bridge->base_obj);
+	drm_gem_object_release(obj);
+	kfree(bridge);
+}
+
+static const struct drm_gem_object_funcs vmw_prime_import_bridge_funcs = {
+	.free = vmw_prime_import_bridge_free,
+};
+
+/**
+ * vmw_prime_resolve_handle - Translate a possible prime-import bridge GEM
+ * handle back to the real ttm handle it wraps.
+ *
+ * @file_priv: The caller's drm file, whose own GEM handle table is checked.
+ * @handle: A handle as supplied by userspace -- either an ordinary raw ttm
+ * handle (the common case, unchanged from historical behavior), or a
+ * bridge handle returned by vmw_prime_fd_to_handle() above.
+ *
+ * Returns the real ttm handle to use. If @handle does not name one of this
+ * file's own prime-import bridge objects, @handle is returned unchanged.
+ */
+uint32_t vmw_prime_resolve_handle(struct drm_file *file_priv, uint32_t handle)
+{
+	struct drm_gem_object *gobj = drm_gem_object_lookup(file_priv, handle);
+	uint32_t real_handle = handle;
+
+	if (gobj) {
+		if (gobj->funcs == &vmw_prime_import_bridge_funcs) {
+			struct vmw_prime_import_bridge *bridge =
+				container_of(gobj, struct vmw_prime_import_bridge, base);
+			real_handle = bridge->ttm_handle;
+		}
+		drm_gem_object_put(gobj);
+	}
+
+	return real_handle;
+}
+
 int vmw_prime_fd_to_handle(struct drm_device *dev,
 			   struct drm_file *file_priv,
 			   int fd, u32 *handle)
 {
+	struct vmw_private *dev_priv = vmw_priv(dev);
 	struct ttm_object_file *tfile = vmw_fpriv(file_priv)->tfile;
-	int ret = ttm_prime_fd_to_handle(tfile, fd, handle);
+	struct vmw_prime_import_bridge *bridge;
+	struct ttm_base_object *base_obj;
+	uint32_t ttm_handle;
+	int ret = ttm_prime_fd_to_handle(tfile, fd, &ttm_handle);
 
 	if (ret)
-		ret = drm_gem_prime_fd_to_handle(dev, file_priv, fd, handle);
+		return drm_gem_prime_fd_to_handle(dev, file_priv, fd, handle);
+
+	/*
+	 * Take our own independent reference before dropping the transient
+	 * one ttm_prime_fd_to_handle() just created, so the object can never
+	 * be dropped to zero in between.
+	 */
+	base_obj = ttm_base_object_lookup_for_ref(dev_priv->tdev, ttm_handle);
+	if (!base_obj) {
+		ttm_ref_object_base_unref(tfile, ttm_handle);
+		return -EINVAL;
+	}
+
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge) {
+		ttm_base_object_unref(&base_obj);
+		ttm_ref_object_base_unref(tfile, ttm_handle);
+		return -ENOMEM;
+	}
+
+	drm_gem_private_object_init(dev, &bridge->base, PAGE_SIZE);
+	bridge->base.funcs = &vmw_prime_import_bridge_funcs;
+	bridge->base_obj   = base_obj;
+	bridge->ttm_handle = ttm_handle;
+
+	ret = drm_gem_handle_create(file_priv, &bridge->base, handle);
+	drm_gem_object_put(&bridge->base);
+
+	/*
+	 * On success, deliberately leave the transient ttm_ref_object entry
+	 * ttm_prime_fd_to_handle() created in place -- do not touch it.
+	 * vmw_surface_handle_reference()'s DRM_VMW_REF_SURFACE path forces
+	 * require_exist=true for render clients (drm_is_render_client()),
+	 * which is exactly what Mesa and this bridge's own callers are, and
+	 * ttm_ref_object_add() with require_existed=true returns -EPERM
+	 * unless a ref-object entry for this (tfile, ttm_handle) pair
+	 * already exists -- it will not create a new one. This entry is
+	 * that pre-existing one. Stock vmw_prime_fd_to_handle() never
+	 * touched it either, for the same reason. Our own independent
+	 * base_obj reference above is what makes GEM_CLOSE work; it does
+	 * not replace this entry, it exists alongside it.
+	 *
+	 * On failure, nothing else will ever be able to reach this handle to
+	 * release it, so clean it up here to avoid leaking it.
+	 */
+	if (ret)
+		ttm_ref_object_base_unref(tfile, ttm_handle);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index e3a187a..7ba4dbf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -255,6 +255,7 @@ int vmw_resource_init(struct vmw_private *dev_priv, struct vmw_resource *res,
  * type, -EINVAL will be returned.
  */
 int vmw_user_resource_lookup_handle(struct vmw_private *dev_priv,
+				    struct drm_file *file_priv,
 				    struct ttm_object_file *tfile,
 				    uint32_t handle,
 				    const struct vmw_user_resource_conv
@@ -265,6 +266,7 @@ int vmw_user_resource_lookup_handle(struct vmw_private *dev_priv,
 	struct vmw_resource *res;
 	int ret = -EINVAL;
 
+	handle = vmw_prime_resolve_handle(file_priv, handle);
 	base = ttm_base_object_lookup(tfile, handle);
 	if (unlikely(!base))
 		return -EINVAL;
@@ -300,7 +302,7 @@ int vmw_user_object_lookup(struct vmw_private *dev_priv,
 
 	WARN_ON(uo->surface || uo->buffer);
 
-	ret = vmw_user_resource_lookup_handle(dev_priv, tfile, handle,
+	ret = vmw_user_resource_lookup_handle(dev_priv, filp, tfile, handle,
 					      user_surface_converter,
 					      &res);
 	if (!ret) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd05637..5aabb36 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -689,8 +689,9 @@ int vmw_surface_destroy_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_vmw_surface_arg *arg = (struct drm_vmw_surface_arg *)data;
 	struct ttm_object_file *tfile = vmw_fpriv(file_priv)->tfile;
+	uint32_t sid = vmw_prime_resolve_handle(file_priv, arg->sid);
 
-	return ttm_ref_object_base_unref(tfile, arg->sid);
+	return ttm_ref_object_base_unref(tfile, sid);
 }
 
 /**
@@ -999,7 +1000,13 @@ vmw_surface_handle_reference(struct vmw_private *dev_priv,
 								&handle,
 								base_p);
 	} else {
-		handle = u_handle;
+		/*
+		 * u_handle may be a raw ttm handle (the historical case), or
+		 * a prime-import bridge GEM handle returned by an earlier
+		 * generic PRIME_FD_TO_HANDLE call (see vmwgfx_prime.c) --
+		 * resolve it back to the real ttm handle either way.
+		 */
+		handle = vmw_prime_resolve_handle(file_priv, u_handle);
 	}
 
 	ret = -EINVAL;
@@ -2321,7 +2328,7 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	args->size = arg.rep.buffer_size;
 	args->pitch = vmw_surface_calculate_pitch(desc, &drm_size);
 
-	ret = vmw_user_resource_lookup_handle(dev_priv, tfile, arg.rep.handle,
+	ret = vmw_user_resource_lookup_handle(dev_priv, file_priv, tfile, arg.rep.handle,
 					      user_surface_converter,
 					      &res);
 	if (ret) {
