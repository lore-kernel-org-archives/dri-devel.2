Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0FCCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B1F10F976;
	Fri, 29 May 2026 06:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="U5pRf1Xi";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CE110F976;
 Fri, 29 May 2026 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780036497; x=1780641297; i=natalie.vock@gmx.de;
 bh=NkaMmbGMJxjXt+E81VmxSSX1SUlKpKOFjiOB794YmZQ=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=U5pRf1XimVEP1g+ICAgLRnJzK337oErP4jxwGVxy9ng2HADot/HR3rG9AMqM8Mf6
 eqlf6Yt2+W7V7jgpnAAmkJWq4ejaT0E40MoEYnlV2Bf7E2DWFnsJOFTl9HC7p+98n
 GXMHCpCwOBxqgQbHdqS0bxFMFq/tquz7pJUF3Tm3dJpEpXbwzcUqw0hyxy0tV4MDU
 Xv5KhQsjKWV6HBvvUMV0AGSFmJ3lx3IfNU1ctjs5W2IQD/OU3x6/4y7LKThb1fvFs
 J0gkGTzlprt7OvEo0vRi3TmZJ4ri0bHtNxwiPoDxb4NtizTywUg/DiuvJJv615qK5
 qjMtxVJ193JIZO6zFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1wxEHG2yFS-00iTEa; Fri, 29
 May 2026 08:34:56 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 29 May 2026 08:34:39 +0200
Subject: [PATCH 2/3] drm/amdgpu: Implement explicit sync for PRT unmaps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260529-prt-explicit-sync-v1-2-9f1c60955cab@gmx.de>
References: <20260529-prt-explicit-sync-v1-0-9f1c60955cab@gmx.de>
In-Reply-To: <20260529-prt-explicit-sync-v1-0-9f1c60955cab@gmx.de>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Provags-ID: V03:K1:Pkce3sXXdVR19v1LKucw5Yi8Iy0THjDbuvkRNlYnHXTELbfbro2
 BZqZF/9y+BxgJYRHAeazRmeVkyeBam3BAualMfnpBj1Up5M0b5cI8aGSF8LY/l1rsbp4zkW
 YN2Cz+k8r1+/ZHN/OLAC6e8MUfQZIpoAYTTkTP2ZJ5zSp9ccT4Uf9AbQyE1rW2jeYwShs6T
 NL9IxXZNcwLrVByu93gvQ==
UI-OutboundReport: notjunk:1;M01:P0:PgCDzXb8EfY=;pQRngNfrhIe2Ty6wTkXv931Ry4F
 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
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

In certain cases, it is possible to skip syncing with every submission
in the whole VM before unmapping pagetables. The important condition is
that no memory must be released to the system while the GPU still has a
chance to access it.

This is true for VM-always-valid buffers since the resv is shared with
the VM's root PD and thus there will always be synchronization before
unmapping, but also for PRT pages which do not point to any real memory
location at all. Bypass implicit sync for unmapping for these buffers if
userspace requests it. Userspace can request this via a new VM ioctl
flag.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 49 ++++++++++++++++++++++++++++=
+----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++++
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_gem.c
index e95aaa5167538..a8d1cf3d0d5fc 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -813,12 +813,13 @@ amdgpu_gem_va_update_vm(struct amdgpu_vm_update_ctx =
*ctx,
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp)
 {
-	const uint32_t valid_flags =3D AMDGPU_VM_DELAY_UPDATE |
+	const uint32_t valid_flags =3D
+		AMDGPU_VM_EXPLICIT_SYNC | AMDGPU_VM_DELAY_UPDATE |
 		AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
 		AMDGPU_VM_PAGE_EXECUTABLE | AMDGPU_VM_MTYPE_MASK |
 		AMDGPU_VM_PAGE_NOALLOC;
-	const uint32_t prt_flags =3D AMDGPU_VM_DELAY_UPDATE |
-		AMDGPU_VM_PAGE_PRT;
+	const uint32_t prt_flags =3D AMDGPU_VM_EXPLICIT_SYNC |
+				   AMDGPU_VM_DELAY_UPDATE | AMDGPU_VM_PAGE_PRT;
=20
 	struct drm_amdgpu_gem_va *args =3D data;
 	struct drm_gem_object *gobj;
@@ -896,6 +897,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *=
data,
 	}
=20
 	amdgpu_vm_update_ctx_init(&update_ctx, adev, &fpriv->vm);
+	update_ctx.explicit_sync_unmap =3D args->flags & AMDGPU_VM_EXPLICIT_SYNC=
;
=20
 	/* Add input syncobj fences (if any) for synchronization. */
 	r =3D amdgpu_gem_add_input_fence(filp, &update_ctx,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index c9fb29abb0e66..9ba9db970f0fe 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -382,6 +382,37 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base =
*base,
 	spin_unlock(&vm->stats_lock);
 }
=20
+/**
+ * amdgpu_vm_update_ctx_add_freed_mapping - mark a mapping as freed
+ * @ctx: context for updating the VM
+ * @bo_va: BO/VA pair the mapping corresponds to
+ * @mapping: The mapping to free
+ *
+ * Adds the mapping to the context's freed list, as well as doing some bo=
okkeeping
+ * about the mappings being freed.
+ */
+void amdgpu_vm_update_ctx_add_freed_mapping(struct amdgpu_vm_update_ctx *=
ctx,
+					    struct amdgpu_bo_va *bo_va,
+					    struct amdgpu_bo_va_mapping *mapping)
+{
+	struct amdgpu_bo *bo =3D bo_va->base.bo;
+
+	/* When unmapping buffers, we must make sure there is no way to free the
+	 * buffer's underlying memory before the GPU is absolutely guaranteed to
+	 * be done accessing it.
+	 *
+	 * With explicit syncing, userspace indicates when unmapping can be perf=
ormed,
+	 * but if userspace is either malicious or sufficiently incompetent, the
+	 * GPU may access the buffer even after userspace indicated it is safe t=
o free.
+	 * Therefore, only allow explicit sync on unmapping if the BO is
+	 * always valid in the VM (in which case freeing syncs to all submission=
s already)
+	 * or if it's a PRT page (in which case there is no memory being accesse=
d in any case).
+	 */
+	ctx->explicit_sync_unmap &=3D amdgpu_vm_is_bo_always_valid(ctx->vm, bo) =
||
+				    mapping->flags & AMDGPU_VM_PAGE_PRT;
+	list_add(&mapping->list, &ctx->freed);
+}
+
 /**
  * amdgpu_vm_update_ctx_ensure_unmap_synced - VM update sync helper
  * @ctx: context for updating the VM
@@ -398,11 +429,13 @@ int amdgpu_vm_update_ctx_ensure_unmap_synced(struct =
amdgpu_vm_update_ctx *ctx)
=20
 	/*
 	 * Implicitly sync to command submissions in the same VM before
-	 * unmapping.
+	 * unmapping, unless we unmap with explicit sync.
 	 */
 	r =3D amdgpu_sync_resv(ctx->adev, &ctx->sync,
 			     ctx->vm->root.bo->tbo.base.resv,
-			     AMDGPU_SYNC_EQ_OWNER, ctx->vm);
+			     ctx->explicit_sync_unmap ? AMDGPU_SYNC_EXPLICIT :
+							AMDGPU_SYNC_EQ_OWNER,
+			     ctx->vm);
 	if (r)
 		return r;
=20
@@ -1562,6 +1595,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_vm_update_ct=
x *ctx,
 	struct dma_fence *f =3D NULL;
 	int r;
=20
+	if (list_empty(&ctx->freed))
+		return 0;
+
 	r =3D amdgpu_vm_update_ctx_ensure_unmap_synced(ctx);
 	if (r)
 		return r;
@@ -2024,7 +2060,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_vm_update_ctx *=
ctx,
 	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
=20
 	if (valid)
-		list_add(&mapping->list, &ctx->freed);
+		amdgpu_vm_update_ctx_add_freed_mapping(ctx, bo_va, mapping);
 	else
 		amdgpu_vm_free_mapping(ctx->adev, vm, mapping,
 				       bo_va->last_pt_update);
@@ -2048,6 +2084,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_vm_upd=
ate_ctx *ctx,
 				uint64_t saddr, uint64_t size)
 {
 	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
+	struct amdgpu_bo_va *bo_va;
 	LIST_HEAD(removed);
 	uint64_t eaddr;
 	int r;
@@ -2112,8 +2149,9 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_vm_upd=
ate_ctx *ctx,
 		if (tmp->last > eaddr)
 		    tmp->last =3D eaddr;
=20
+		bo_va =3D tmp->bo_va;
 		tmp->bo_va =3D NULL;
-		list_add(&tmp->list, &ctx->freed);
+		amdgpu_vm_update_ctx_add_freed_mapping(ctx, bo_va, tmp);
 		trace_amdgpu_vm_bo_unmap(NULL, tmp);
 	}
=20
@@ -2241,9 +2279,10 @@ void amdgpu_vm_bo_del(struct amdgpu_vm_update_ctx *=
ctx,
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
+
 		mapping->bo_va =3D NULL;
 		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
-		list_add(&mapping->list, &ctx->freed);
+		amdgpu_vm_update_ctx_add_freed_mapping(ctx, bo_va, mapping);
 	}
 	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
 		list_del(&mapping->list);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.h
index 0bd3fa1100dd6..ae1a8e8f6433b 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -293,6 +293,8 @@ struct amdgpu_vm_update_ctx {
 	 * i.e. all previous submissions in the VM are waited on.
 	 */
 	bool unmap_synced;
+
+	bool explicit_sync_unmap;
 };
=20
 /**
@@ -660,6 +662,9 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev=
, struct amdgpu_vm *vm);
=20
 bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo =
*bo);
=20
+void amdgpu_vm_update_ctx_add_freed_mapping(
+	struct amdgpu_vm_update_ctx *ctx, struct amdgpu_bo_va *bo_va,
+	struct amdgpu_bo_va_mapping *mapping);
 int amdgpu_vm_update_ctx_ensure_unmap_synced(struct amdgpu_vm_update_ctx =
*ctx);
=20
 /**
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f163..1f70a3ff0564a 100644
=2D-- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -900,6 +900,8 @@ struct drm_amdgpu_gem_list_handles_entry {
 #define AMDGPU_VM_MTYPE_RW		(5 << 5)
 /* don't allocate MALL */
 #define AMDGPU_VM_PAGE_NOALLOC		(1 << 9)
+/* Bypass implicit synchronization for VM updates*/
+#define AMDGPU_VM_EXPLICIT_SYNC		(1 << 10)
=20
 struct drm_amdgpu_gem_va {
 	/** GEM object handle */

=2D-=20
2.54.0

