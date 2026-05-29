Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B24ECD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D4010F96D;
	Fri, 29 May 2026 06:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="QQIR5Iqw";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F249510F971;
 Fri, 29 May 2026 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780036496; x=1780641296; i=natalie.vock@gmx.de;
 bh=1ELMkFBj6loNtL/eghowZBi43I+VEEjyVPceT0BLxrk=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QQIR5IqwbUWHTQ8Gn/ILZihhfK50KdbqwR573JJ9iIcfXUydly7/YngLwJdqR4Q7
 Z5YgnfffqtvgImRHDYNo/3pkkDGgHUuzv1GPkeBJbhLLoCoP2ekDU0IX20elLyX9g
 TxFi4kWC6YkSkHYayr+F0d+596j5RDvwjKDPhZB4qzD1TWXGk1w+GmmQebhd19MQV
 Lmn3ZwI0XMECau70eDC4f4VQtXMdCwLmZD+tf/eC7PYrvHySi7F69LSGbaW8e6cHL
 okcXFE2Yz7hVRtU659+PEuTjoutAZ4uAczdV3uT3wFl8gJ64Wh1b6RfehTW7Gu5Ed
 jNhQZoiIEpYnzXxhNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1wVpt70M3h-000ZqR; Fri, 29
 May 2026 08:34:56 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 29 May 2026 08:34:38 +0200
Subject: [PATCH 1/3] drm/amdgpu: Add and use vm_update_ctx struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260529-prt-explicit-sync-v1-1-9f1c60955cab@gmx.de>
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
X-Provags-ID: V03:K1:Iqs4eAiraz6cZE2wfIrJS5+2ErpBpElqvwlYIY9YLYrYshVWkvc
 N/6gJ27fG/xki4xGhcI4upf08Ft/0zYcAm4QP0BGrdh+tYvdLO9ectfGdL9McGogURgY9iF
 wYVq/cIGe9BQJmrGkzTm3i4MAWY18W7SVcK1GLExJtW3hYx9jsbxt+BEjodIqLZhMKHkn8b
 +FIx9t6yEW7fziCKHkazg==
UI-OutboundReport: notjunk:1;M01:P0:mg1wZRhBEtg=;tnhESZVtQG3+cfMaDcF5b9rhPtK
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

This adds a "context" struct to the functions responsible for mapping
page tables (and committing the maps to the GPU page-tables).

The core idea here is to record the changes associated with specific VM
mapping operations (most importantly, which mappings were freed by each
map change). We need this to properly implement explicit sync for unmap
operations, which can only be performed for unmaps of either
always-valid or PRT mappings.

Before this patch, amdgpu_vm_clear_freed gets a list of pending unmap
operations with no insight where they come from - it's very much
possible that the list also contains unmap operations for which the sync
dependencies are unknown, and implicit sync semantics have to be
assumed.

By keeping a separate free-list in the context of each unmap operation
and only falling back to the global per-VM freelist if
amdgpu_vm_clear_freed can't be executed right now, we sidestep these
issues. We can also record information about sync dependencies (and
more, in subsequent patches) inside the context struct as well.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  42 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          |  22 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  53 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c        |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 225 ++++++++++++++----=
=2D----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  88 ++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c           |  15 +-
 11 files changed, 344 insertions(+), 164 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69ddd..21759fe6bdfa0 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -876,6 +876,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, =
struct kgd_mem *mem,
 	uint64_t va =3D mem->va;
 	struct kfd_mem_attachment *attachment[2] =3D {NULL, NULL};
 	struct amdgpu_bo *bo[2] =3D {NULL, NULL};
+	struct amdgpu_vm_update_ctx ctx;
 	struct amdgpu_bo_va *bo_va;
 	bool same_hive =3D false;
 	struct drm_exec exec;
@@ -1000,8 +1001,11 @@ static int kfd_mem_attach(struct amdgpu_device *ade=
v, struct kgd_mem *mem,
 			continue;
 		if (attachment[i]->bo_va) {
 			(void)amdgpu_bo_reserve(bo[i], true);
+			amdgpu_vm_update_ctx_init(
+				&ctx, adev, attachment[i]->bo_va->base.vm);
 			if (--attachment[i]->bo_va->ref_count =3D=3D 0)
-				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
+				amdgpu_vm_bo_del(&ctx, attachment[i]->bo_va);
+			amdgpu_vm_update_ctx_fini(&ctx);
 			amdgpu_bo_unreserve(bo[i]);
 			list_del(&attachment[i]->list);
 		}
@@ -1014,12 +1018,16 @@ static int kfd_mem_attach(struct amdgpu_device *ad=
ev, struct kgd_mem *mem,
=20
 static void kfd_mem_detach(struct kfd_mem_attachment *attachment)
 {
+	struct amdgpu_vm_update_ctx ctx;
 	struct amdgpu_bo *bo =3D attachment->bo_va->base.bo;
=20
 	pr_debug("\t remove VA 0x%llx in entry %p\n",
 			attachment->va, attachment);
+	amdgpu_vm_update_ctx_init(&ctx, attachment->adev,
+				  attachment->bo_va->base.vm);
 	if (--attachment->bo_va->ref_count =3D=3D 0)
-		amdgpu_vm_bo_del(attachment->adev, attachment->bo_va);
+		amdgpu_vm_bo_del(&ctx, attachment->bo_va);
+	amdgpu_vm_update_ctx_fini(&ctx);
 	drm_gem_object_put(&bo->tbo.base);
 	list_del(&attachment->list);
 	kfree(attachment);
@@ -1273,22 +1281,27 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem=
,
 	struct amdgpu_bo_va *bo_va =3D entry->bo_va;
 	struct amdgpu_device *adev =3D entry->adev;
 	struct amdgpu_vm *vm =3D bo_va->base.vm;
+	struct amdgpu_vm_update_ctx update_ctx;
=20
 	if (bo_va->queue_refcount) {
 		pr_debug("bo_va->queue_refcount %d\n", bo_va->queue_refcount);
 		return -EBUSY;
 	}
=20
-	(void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+
+	(void)amdgpu_vm_bo_unmap(&update_ctx, bo_va, entry->va);
=20
 	/* VM entity stopped if process killed, don't clear freed pt bo */
 	if (!amdgpu_vm_ready(vm))
-		return 0;
+		goto out;
=20
-	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+	(void)amdgpu_vm_clear_freed(&update_ctx, &bo_va->last_pt_update);
=20
 	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);
=20
+out:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 	return 0;
 }
=20
@@ -1298,6 +1311,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 {
 	struct amdgpu_bo_va *bo_va =3D entry->bo_va;
 	struct amdgpu_device *adev =3D entry->adev;
+	struct amdgpu_vm_update_ctx update_ctx;
 	int ret;
=20
 	ret =3D kfd_mem_dmamap_attachment(mem, entry);
@@ -1305,7 +1319,10 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
=20
 	/* Update the page tables  */
-	ret =3D amdgpu_vm_bo_update(adev, bo_va, false);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, bo_va->base.vm);
+	ret =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
+	amdgpu_vm_update_ctx_fini(&update_ctx);
+
 	if (ret) {
 		pr_err("amdgpu_vm_bo_update failed\n");
 		return ret;
@@ -1319,12 +1336,17 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 			   struct amdgpu_sync *sync,
 			   bool no_update_pte)
 {
+	struct amdgpu_bo_va *bo_va =3D entry->bo_va;
+	struct amdgpu_device *adev =3D entry->adev;
+	struct amdgpu_vm_update_ctx update_ctx;
 	int ret;
=20
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, bo_va->base.vm);
 	/* Set virtual address for the allocation */
-	ret =3D amdgpu_vm_bo_map(entry->adev, entry->bo_va, entry->va, 0,
+	ret =3D amdgpu_vm_bo_map(&update_ctx, bo_va, entry->va, 0,
 			       amdgpu_bo_size(entry->bo_va->base.bo),
 			       entry->pte_flags);
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 	if (ret) {
 		pr_err("Failed to map VA 0x%llx in vm. ret %d\n",
 				entry->va, ret);
@@ -2923,6 +2945,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *in=
fo, struct dma_fence __rcu *
 	struct amdgpu_sync sync_obj;
 	unsigned long failed_size =3D 0;
 	unsigned long total_size =3D 0;
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct drm_exec exec;
 	int ret;
=20
@@ -3032,7 +3055,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *i=
nfo, struct dma_fence __rcu *
 		struct amdgpu_fpriv *fpriv =3D
 			container_of(peer_vm, struct amdgpu_fpriv, vm);
=20
-		ret =3D amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+		amdgpu_vm_update_ctx_init(&update_ctx, adev, peer_vm);
+		ret =3D amdgpu_vm_bo_update(&update_ctx, fpriv->prt_va, false);
+		amdgpu_vm_update_ctx_fini(&update_ctx);
+
 		if (ret) {
 			dev_dbg(adev->dev,
 				"Memory eviction: handle PRT moved failed, pid %8d. Try again.\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_cs.c
index 10d8dcc3a9721..ea9b3983f10b7 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1093,6 +1093,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_pa=
rser *p)
 	struct amdgpu_vm *vm =3D &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_vm_update_ctx update_ctx;
 	unsigned int i;
 	int r;
=20
@@ -1114,30 +1115,33 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_=
parser *p)
 	if (!amdgpu_vm_ready(vm))
 		return -EINVAL;
=20
-	r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
+	r =3D amdgpu_vm_delayed_free(adev, vm);
 	if (r)
 		return r;
=20
-	r =3D amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+
+	r =3D amdgpu_vm_bo_update(&update_ctx, fpriv->prt_va, false);
 	if (r)
-		return r;
+		goto err_fini_ctx;
=20
 	r =3D amdgpu_sync_fence(&p->sync, fpriv->prt_va->last_pt_update,
 			      GFP_KERNEL);
 	if (r)
-		return r;
+		goto err_fini_ctx;
=20
 	if (fpriv->csa_va) {
 		bo_va =3D fpriv->csa_va;
 		BUG_ON(!bo_va);
-		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
+
+		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
 		if (r)
-			return r;
+			goto err_fini_ctx;
=20
 		r =3D amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
 				      GFP_KERNEL);
 		if (r)
-			return r;
+			goto err_fini_ctx;
 	}
=20
 	/* FIXME: In theory this loop shouldn't be needed any more when
@@ -1150,16 +1154,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_=
parser *p)
 		if (bo_va =3D=3D NULL)
 			continue;
=20
-		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
+		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
 		if (r)
-			return r;
+			goto err_fini_ctx;
=20
 		r =3D amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
 				      GFP_KERNEL);
 		if (r)
-			return r;
+			goto err_fini_ctx;
 	}
=20
+	amdgpu_vm_update_ctx_fini(&update_ctx);
+
 	r =3D amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
 	if (r)
 		return r;
@@ -1195,6 +1201,10 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
 	}
=20
 	return 0;
+
+err_fini_ctx:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
+	return r;
 }
=20
 static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_csa.c
index 11d70fe4f75a9..e1c85e3b211b0 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -66,6 +66,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t csa_addr, uint32_t size)
 {
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct drm_exec exec;
 	int r;
=20
@@ -88,17 +89,21 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
 		goto error;
 	}
=20
-	r =3D amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+
+	r =3D amdgpu_vm_bo_map(&update_ctx, *bo_va, csa_addr, 0, size,
 			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
 			     AMDGPU_PTE_EXECUTABLE);
=20
 	if (r) {
 		drm_err(adev_to_drm(adev),
 			"failed to do bo_map on static CSA, err=3D%d\n", r);
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
+		amdgpu_vm_bo_del(&update_ctx, *bo_va);
+		goto error_ctx;
 	}
=20
+error_ctx:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 error:
 	drm_exec_fini(&exec);
 	return r;
@@ -108,6 +113,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
 			    uint64_t csa_addr)
 {
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct drm_exec exec;
 	int r;
=20
@@ -124,15 +130,19 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
 		}
 	}
=20
-	r =3D amdgpu_vm_bo_unmap(adev, bo_va, csa_addr);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+
+	r =3D amdgpu_vm_bo_unmap(&update_ctx, bo_va, csa_addr);
 	if (r) {
 		drm_err(adev_to_drm(adev),
 			"failed to do bo_unmap on static CSA, err=3D%d\n", r);
-		goto error;
+		goto error_ctx;
 	}
=20
-	amdgpu_vm_bo_del(adev, bo_va);
+	amdgpu_vm_bo_del(&update_ctx, bo_va);
=20
+error_ctx:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 error:
 	drm_exec_fini(&exec);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_dma_buf.c
index 656c267dbe587..8036dbfa83352 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -513,7 +513,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *=
attach)
 		/* Reserve fences for two SDMA page table updates */
 		r =3D dma_resv_reserve_fences(resv, 2);
 		if (!r)
-			r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
+			r =3D amdgpu_vm_delayed_free(adev, vm);
=20
 		/* Don't pass 'ticket' to amdgpu_vm_handle_moved: we want the clear=3Dt=
rue
 		 * path to be used otherwise we might update the PT of another process
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_gem.c
index a3de2481a0546..e95aaa5167538 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -50,6 +50,7 @@
=20
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
+			   struct amdgpu_vm_update_ctx *update_ctx,
 			   uint64_t syncobj_handles_array,
 			   uint32_t num_syncobj_handles)
 {
@@ -76,9 +77,10 @@ amdgpu_gem_add_input_fence(struct drm_file *filp,
 		if (ret)
 			goto free_memdup;
=20
-		dma_fence_wait(fence, false);
+		ret =3D amdgpu_sync_fence(&update_ctx->sync, fence, GFP_KERNEL);
+		if (ret)
+			goto free_memdup;
=20
-		/* TODO: optimize async handling */
 		dma_fence_put(fence);
 	}
=20
@@ -318,6 +320,7 @@ static void amdgpu_gem_object_close(struct drm_gem_obj=
ect *obj,
 	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
 	struct amdgpu_vm *vm =3D &fpriv->vm;
+	struct amdgpu_vm_update_ctx update_ctx;
=20
 	struct dma_fence *fence =3D NULL;
 	struct amdgpu_bo_va *bo_va;
@@ -344,12 +347,14 @@ static void amdgpu_gem_object_close(struct drm_gem_o=
bject *obj,
 	if (!bo_va || --bo_va->ref_count)
 		goto out_unlock;
=20
-	amdgpu_vm_bo_del(adev, bo_va);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+
+	amdgpu_vm_bo_del(&update_ctx, bo_va);
 	amdgpu_vm_bo_update_shared(bo);
 	if (!amdgpu_vm_ready(vm))
 		goto out_unlock;
=20
-	r =3D amdgpu_vm_clear_freed(adev, vm, &fence);
+	r =3D amdgpu_vm_clear_freed(&update_ctx, &fence);
 	if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
 		dev_err(adev->dev, "failed to clear page "
 			"tables on GEM object close (%ld)\n", r);
@@ -740,8 +745,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, =
void *data,
  * otherwise stub fence in case of error.
  */
 static struct dma_fence *
-amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
-			struct amdgpu_vm *vm,
+amdgpu_gem_va_update_vm(struct amdgpu_vm_update_ctx *ctx,
 			struct amdgpu_bo_va *bo_va,
 			uint32_t operation)
 {
@@ -749,10 +753,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	int r =3D 0;
=20
 	/* If the VM is not ready return only a stub. */
-	if (!amdgpu_vm_ready(vm))
+	if (!amdgpu_vm_ready(ctx->vm))
 		return dma_fence_get_stub();
=20
-
 	/*
 	 * First clean up any freed mappings in the VM.
 	 *
@@ -760,42 +763,42 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	 * schedules GPU work. If nothing needs clearing, @fence can remain as
 	 * the original vm->last_update.
 	 */
-	r =3D amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
+	r =3D amdgpu_vm_clear_freed(ctx, &ctx->vm->last_update);
 	if (r)
 		goto error;
=20
 	/* For MAP/REPLACE we also need to update the BO mappings. */
 	if (operation =3D=3D AMDGPU_VA_OP_MAP ||
 	    operation =3D=3D AMDGPU_VA_OP_REPLACE) {
-		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
+		r =3D amdgpu_vm_bo_update(ctx, bo_va, false);
 		if (r)
 			goto error;
 	}
=20
 	/* Always update PDEs after we touched the mappings. */
-	r =3D amdgpu_vm_update_pdes(adev, vm, false);
+	r =3D amdgpu_vm_update_pdes(ctx->adev, ctx->vm, false);
 	if (r)
 		goto error;
=20
 	if ((operation =3D=3D AMDGPU_VA_OP_MAP ||
 	     operation =3D=3D AMDGPU_VA_OP_REPLACE) &&
-	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
+	    !amdgpu_vm_is_bo_always_valid(ctx->vm, bo_va->base.bo)) {
=20
 		/*
 		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
 		 * bo_va->last_pt_update and vm->last_update or otherwise we
 		 * potentially miss the PDE updates.
 		 */
-		fence =3D dma_fence_unwrap_merge(vm->last_update,
+		fence =3D dma_fence_unwrap_merge(ctx->vm->last_update,
 					       bo_va->last_pt_update);
 		if (!fence) {
 			/* As fallback in OOM situations */
-			dma_fence_wait(vm->last_update, false);
+			dma_fence_wait(ctx->vm->last_update, false);
 			dma_fence_wait(bo_va->last_pt_update, false);
 			fence =3D dma_fence_get_stub();
 		}
 	} else {
-		fence =3D dma_fence_get(vm->last_update);
+		fence =3D dma_fence_get(ctx->vm->last_update);
 	}
=20
 	return fence;
@@ -804,7 +807,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r && r !=3D -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
=20
-	return dma_fence_get(vm->last_update);
+	return dma_fence_get(ctx->vm->last_update);
 }
=20
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
@@ -825,6 +828,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *=
data,
 	struct amdgpu_bo_va *bo_va;
 	struct drm_syncobj *timeline_syncobj =3D NULL;
 	struct dma_fence_chain *timeline_chain =3D NULL;
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct drm_exec exec;
 	uint64_t vm_size, tmp;
 	int r =3D 0;
@@ -891,8 +895,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void =
*data,
 		abo =3D NULL;
 	}
=20
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, &fpriv->vm);
+
 	/* Add input syncobj fences (if any) for synchronization. */
-	r =3D amdgpu_gem_add_input_fence(filp,
+	r =3D amdgpu_gem_add_input_fence(filp, &update_ctx,
 				       args->input_fence_syncobj_handles,
 				       args->num_syncobj_handles);
 	if (r)
@@ -942,21 +948,21 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void=
 *data,
=20
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
-		r =3D amdgpu_vm_bo_map(adev, bo_va, args->va_address,
+		r =3D amdgpu_vm_bo_map(&update_ctx, bo_va, args->va_address,
 				     args->offset_in_bo, args->map_size,
 				     args->flags);
 		break;
 	case AMDGPU_VA_OP_UNMAP:
-		r =3D amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
+		r =3D amdgpu_vm_bo_unmap(&update_ctx, bo_va, args->va_address);
 		break;
=20
 	case AMDGPU_VA_OP_CLEAR:
-		r =3D amdgpu_vm_bo_clear_mappings(adev, &fpriv->vm,
-						args->va_address,
+		r =3D amdgpu_vm_bo_clear_mappings(&update_ctx, args->va_address,
 						args->map_size);
 		break;
 	case AMDGPU_VA_OP_REPLACE:
-		r =3D amdgpu_vm_bo_replace_map(adev, bo_va, args->va_address,
+		r =3D amdgpu_vm_bo_replace_map(&update_ctx, bo_va,
+					     args->va_address,
 					     args->offset_in_bo, args->map_size,
 					     args->flags);
 		break;
@@ -973,7 +979,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *=
data,
 	    (!adev->debug_vm || timeline_syncobj)) {
 		struct dma_fence *fence;
=20
-		fence =3D amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
+		fence =3D amdgpu_gem_va_update_vm(&update_ctx, bo_va,
 						args->operation);
 		if (timeline_syncobj) {
 			if (!args->vm_timeline_point) {
@@ -994,6 +1000,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void =
*data,
 	}
=20
 error:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 	dma_fence_chain_free(timeline_chain);
 	if (timeline_syncobj)
 		drm_syncobj_put(timeline_syncobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_kms.c
index 24526e92f9b8c..098417b1403ba 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1548,6 +1548,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *=
dev,
 {
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct amdgpu_bo_list *list;
 	struct amdgpu_bo *pd;
 	u32 pasid;
@@ -1576,7 +1577,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *=
dev,
 	pasid =3D fpriv->vm.pasid;
 	pd =3D amdgpu_bo_ref(fpriv->vm.root.bo);
 	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
-		amdgpu_vm_bo_del(adev, fpriv->prt_va);
+		amdgpu_vm_update_ctx_init(&update_ctx, adev, &fpriv->vm);
+		amdgpu_vm_bo_del(&update_ctx, fpriv->prt_va);
+		amdgpu_vm_update_ctx_fini(&update_ctx);
 		amdgpu_bo_unreserve(pd);
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_seq64.c
index f4be192235889..c1bebee4c6027 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -67,6 +67,7 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu=
_device *adev)
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va)
 {
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
 	u64 seq64_addr;
@@ -94,22 +95,25 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struc=
t amdgpu_vm *vm,
=20
 	seq64_addr =3D amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
=20
-	r =3D amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0,
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+	r =3D amdgpu_vm_bo_map(&update_ctx, *bo_va, seq64_addr, 0,
 			     AMDGPU_VA_RESERVED_SEQ64_SIZE,
 			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=3D%d\n", r);
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
+		amdgpu_vm_bo_del(&update_ctx, *bo_va);
+		goto err_ctx;
 	}
=20
-	r =3D amdgpu_vm_bo_update(adev, *bo_va, false);
+	r =3D amdgpu_vm_bo_update(&update_ctx, *bo_va, false);
 	if (r) {
 		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
+		amdgpu_vm_bo_del(&update_ctx, *bo_va);
+		goto err_ctx;
 	}
=20
+err_ctx:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 error:
 	drm_exec_fini(&exec);
 	return r;
@@ -125,6 +129,7 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struc=
t amdgpu_vm *vm,
  */
 void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *=
fpriv)
 {
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct amdgpu_vm *vm;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
@@ -149,7 +154,9 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, st=
ruct amdgpu_fpriv *fpriv)
 			goto error;
 	}
=20
-	amdgpu_vm_bo_del(adev, fpriv->seq64_va);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+	amdgpu_vm_bo_del(&update_ctx, fpriv->seq64_va);
+	amdgpu_vm_update_ctx_fini(&update_ctx);
=20
 	fpriv->seq64_va =3D NULL;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_userq.c
index 154742bdd5a6f..fbad5106180f6 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1024,6 +1024,7 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev,=
 struct drm_exec *exec,
 			 struct amdgpu_vm *vm)
 {
 	struct ttm_operation_ctx ctx =3D { false, false };
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo *bo;
 	int ret;
@@ -1045,8 +1046,10 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev=
, struct drm_exec *exec,
 		if (ret)
 			return ret;
=20
+		amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
 		/* This moves the bo_va to the idle list */
-		ret =3D amdgpu_vm_bo_update(adev, bo_va, false);
+		ret =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
+		amdgpu_vm_update_ctx_fini(&update_ctx);
 		if (ret)
 			return ret;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index bff3031c4bc1b..c9fb29abb0e66 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -382,6 +382,35 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base =
*base,
 	spin_unlock(&vm->stats_lock);
 }
=20
+/**
+ * amdgpu_vm_update_ctx_ensure_unmap_synced - VM update sync helper
+ * @ctx: context for updating the VM
+ *
+ * Ensures that ctx->sync will synchronize to everything that's necessary
+ * to unmap freed pages associated with the context.
+ */
+int amdgpu_vm_update_ctx_ensure_unmap_synced(struct amdgpu_vm_update_ctx =
*ctx)
+{
+	int r;
+
+	if (ctx->unmap_synced)
+		return 0;
+
+	/*
+	 * Implicitly sync to command submissions in the same VM before
+	 * unmapping.
+	 */
+	r =3D amdgpu_sync_resv(ctx->adev, &ctx->sync,
+			     ctx->vm->root.bo->tbo.base.resv,
+			     AMDGPU_SYNC_EQ_OWNER, ctx->vm);
+	if (r)
+		return r;
+
+	ctx->unmap_synced =3D true;
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with th=
e vm
  *
@@ -1247,37 +1276,31 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
  * Returns:
  * 0 for success, -EINVAL for failure.
  */
-int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *=
bo_va,
-			bool clear)
+int amdgpu_vm_bo_update(struct amdgpu_vm_update_ctx *ctx,
+			struct amdgpu_bo_va *bo_va, bool clear)
 {
 	struct amdgpu_bo *bo =3D bo_va->base.bo;
-	struct amdgpu_vm *vm =3D bo_va->base.vm;
+	struct amdgpu_vm *vm =3D ctx->vm;
 	struct amdgpu_bo_va_mapping *mapping;
 	struct dma_fence **last_update;
 	dma_addr_t *pages_addr =3D NULL;
 	struct ttm_resource *mem;
-	struct amdgpu_sync sync;
 	bool flush_tlb =3D clear;
 	uint64_t vram_base;
 	uint64_t flags;
 	bool uncached;
 	int r;
=20
-	amdgpu_sync_create(&sync);
 	if (clear) {
 		mem =3D NULL;
=20
-		/* Implicitly sync to command submissions in the same VM before
-		 * unmapping.
-		 */
-		r =3D amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
-				     AMDGPU_SYNC_EQ_OWNER, vm);
+		r =3D amdgpu_vm_update_ctx_ensure_unmap_synced(ctx);
 		if (r)
-			goto error_free;
+			goto error;
 		if (bo) {
-			r =3D amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
+			r =3D amdgpu_sync_kfd(&ctx->sync, bo->tbo.base.resv);
 			if (r)
-				goto error_free;
+				goto error;
 		}
 	} else if (!bo) {
 		mem =3D NULL;
@@ -1302,16 +1325,16 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
, struct amdgpu_bo_va *bo_va,
 			pages_addr =3D bo->tbo.ttm->dma_address;
=20
 		/* Implicitly sync to moving fences before mapping anything */
-		r =3D amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
+		r =3D amdgpu_sync_resv(ctx->adev, &ctx->sync, bo->tbo.base.resv,
 				     AMDGPU_SYNC_EXPLICIT, vm);
 		if (r)
-			goto error_free;
+			goto error;
 	}
=20
 	if (bo) {
 		struct amdgpu_device *bo_adev;
=20
-		flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
+		flags =3D amdgpu_ttm_tt_pte_flags(ctx->adev, bo->tbo.ttm, mem);
=20
 		if (amdgpu_bo_encrypted(bo))
 			flags |=3D AMDGPU_PTE_TMZ;
@@ -1350,18 +1373,19 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
, struct amdgpu_bo_va *bo_va,
 			update_flags &=3D ~AMDGPU_PTE_WRITEABLE;
=20
 		/* Apply ASIC specific mapping flags */
-		amdgpu_gmc_get_vm_pte(adev, vm, bo, mapping->flags,
+		amdgpu_gmc_get_vm_pte(ctx->adev, vm, bo, mapping->flags,
 				      &update_flags);
=20
 		trace_amdgpu_vm_bo_update(mapping);
=20
-		r =3D amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
-					   !uncached, &sync, mapping->start,
-					   mapping->last, update_flags,
-					   mapping->offset, vram_base, mem,
-					   pages_addr, last_update);
+		r =3D amdgpu_vm_update_range(ctx->adev, vm, false, false,
+					   flush_tlb, !uncached, &ctx->sync,
+					   mapping->start, mapping->last,
+					   update_flags, mapping->offset,
+					   vram_base, mem, pages_addr,
+					   last_update);
 		if (r)
-			goto error_free;
+			goto error;
 	}
=20
 	/* If the BO is not in its preferred location add it back to
@@ -1388,8 +1412,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, =
struct amdgpu_bo_va *bo_va,
 			trace_amdgpu_vm_bo_mapping(mapping);
 	}
=20
-error_free:
-	amdgpu_sync_free(&sync);
+error:
 	return r;
 }
=20
@@ -1521,50 +1544,41 @@ static void amdgpu_vm_prt_fini(struct amdgpu_devic=
e *adev, struct amdgpu_vm *vm)
 /**
  * amdgpu_vm_clear_freed - clear freed BOs in the PT
  *
- * @adev: amdgpu_device pointer
- * @vm: requested vm
+ * @ctx: Context for VM updates
  * @fence: optional resulting fence (unchanged if no work needed to be do=
ne
  * or if an error occurred)
  *
- * Make sure all freed BOs are cleared in the PT.
+ * Make sure all BOs freed by VM updates in the context are cleared in th=
e PT.
  * PTs have to be reserved and mutex must be locked!
  *
  * Returns:
  * 0 for success.
  *
  */
-int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm,
+int amdgpu_vm_clear_freed(struct amdgpu_vm_update_ctx *ctx,
 			  struct dma_fence **fence)
 {
 	struct amdgpu_bo_va_mapping *mapping;
 	struct dma_fence *f =3D NULL;
-	struct amdgpu_sync sync;
 	int r;
=20
-
-	/*
-	 * Implicitly sync to command submissions in the same VM before
-	 * unmapping.
-	 */
-	amdgpu_sync_create(&sync);
-	r =3D amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
-			     AMDGPU_SYNC_EQ_OWNER, vm);
+	r =3D amdgpu_vm_update_ctx_ensure_unmap_synced(ctx);
 	if (r)
-		goto error_free;
+		return r;
=20
-	while (!list_empty(&vm->freed)) {
-		mapping =3D list_first_entry(&vm->freed,
-			struct amdgpu_bo_va_mapping, list);
+	while (!list_empty(&ctx->freed)) {
+		mapping =3D list_first_entry(&ctx->freed,
+					   struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
=20
-		r =3D amdgpu_vm_update_range(adev, vm, false, false, true, false,
-					   &sync, mapping->start, mapping->last,
-					   0, 0, 0, NULL, NULL, &f);
-		amdgpu_vm_free_mapping(adev, vm, mapping, f);
+		r =3D amdgpu_vm_update_range(ctx->adev, ctx->vm, false, false,
+					   true, false, &ctx->sync,
+					   mapping->start, mapping->last, 0, 0,
+					   0, NULL, NULL, &f);
+		amdgpu_vm_free_mapping(ctx->adev, ctx->vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
-			goto error_free;
+			return r;
 		}
 	}
=20
@@ -1575,12 +1589,37 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *ad=
ev,
 		dma_fence_put(f);
 	}
=20
-error_free:
-	amdgpu_sync_free(&sync);
 	return r;
=20
 }
=20
+/**
+ * amdgpu_vm_delayed_free - execute delayed PT clearing
+ *
+ * @adev: Device to use for freeing
+ * @vm: VM whose BOs should be freed
+ *
+ * Go over the list of BOs whose PT clearing was delayed and clear all of=
 them.
+ * PTs have to be reserved and mutex must be locked!
+ *
+ * Returns:
+ * 0 for success.
+ *
+ */
+int amdgpu_vm_delayed_free(struct amdgpu_device *adev, struct amdgpu_vm *=
vm)
+{
+	struct amdgpu_vm_update_ctx ctx;
+	int r;
+
+	amdgpu_vm_update_ctx_init(&ctx, adev, vm);
+
+	list_splice_init(&vm->delayed_freed, &ctx.freed);
+	r =3D amdgpu_vm_clear_freed(&ctx, NULL);
+
+	amdgpu_vm_update_ctx_fini(&ctx);
+	return r;
+}
+
 /**
  * amdgpu_vm_handle_moved - handle moved BOs in the PT
  *
@@ -1599,17 +1638,21 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *a=
dev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket)
 {
+	struct amdgpu_vm_update_ctx update_ctx;
 	struct amdgpu_bo_va *bo_va, *tmp;
 	struct dma_resv *resv;
 	bool clear, unlock;
 	int r;
=20
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
+
 	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.needs_update,
 				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
+		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
+
 		if (r)
-			return r;
+			goto error;
 	}
=20
 	spin_lock(&vm->individual_lock);
@@ -1633,7 +1676,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
v,
 			unlock =3D false;
 		}
=20
-		r =3D amdgpu_vm_bo_update(adev, bo_va, clear);
+		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, clear);
=20
 		if (unlock)
 			dma_resv_unlock(resv);
@@ -1653,6 +1696,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
v,
 	}
 	spin_unlock(&vm->individual_lock);
=20
+error:
+	amdgpu_vm_update_ctx_fini(&update_ctx);
+
 	return 0;
 }
=20
@@ -1812,7 +1858,7 @@ static int amdgpu_vm_verify_parameters(struct amdgpu=
_device *adev,
 /**
  * amdgpu_vm_bo_map - map bo inside a vm
  *
- * @adev: amdgpu_device pointer
+ * @ctx: VM update context
  * @bo_va: bo_va to store the address
  * @saddr: where to map the BO
  * @offset: requested offset in the BO
@@ -1826,7 +1872,7 @@ static int amdgpu_vm_verify_parameters(struct amdgpu=
_device *adev,
  *
  * Object has to be reserved and unreserved outside!
  */
-int amdgpu_vm_bo_map(struct amdgpu_device *adev,
+int amdgpu_vm_bo_map(struct amdgpu_vm_update_ctx *ctx,
 		     struct amdgpu_bo_va *bo_va,
 		     uint64_t saddr, uint64_t offset,
 		     uint64_t size, uint32_t flags)
@@ -1837,7 +1883,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
=20
-	r =3D amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	r =3D amdgpu_vm_verify_parameters(ctx->adev, bo, saddr, offset, size);
 	if (r)
 		return r;
=20
@@ -1847,7 +1893,8 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	tmp =3D amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
 		/* bo and tmp overlap, invalid addr */
-		dev_err(adev->dev, "bo %p va 0x%010Lx-0x%010Lx conflict with "
+		dev_err(ctx->adev->dev,
+			"bo %p va 0x%010Lx-0x%010Lx conflict with "
 			"0x%010Lx-0x%010Lx\n", bo, saddr, eaddr,
 			tmp->start, tmp->last + 1);
 		return -EINVAL;
@@ -1862,7 +1909,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	mapping->offset =3D offset;
 	mapping->flags =3D flags;
=20
-	amdgpu_vm_bo_insert_map(adev, bo_va, mapping);
+	amdgpu_vm_bo_insert_map(ctx->adev, bo_va, mapping);
=20
 	return 0;
 }
@@ -1870,7 +1917,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 /**
  * amdgpu_vm_bo_replace_map - map bo inside a vm, replacing existing mapp=
ings
  *
- * @adev: amdgpu_device pointer
+ * @ctx: VM update context
  * @bo_va: bo_va to store the address
  * @saddr: where to map the BO
  * @offset: requested offset in the BO
@@ -1885,7 +1932,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
  *
  * Object has to be reserved and unreserved outside!
  */
-int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
+int amdgpu_vm_bo_replace_map(struct amdgpu_vm_update_ctx *ctx,
 			     struct amdgpu_bo_va *bo_va,
 			     uint64_t saddr, uint64_t offset,
 			     uint64_t size, uint32_t flags)
@@ -1895,7 +1942,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *a=
dev,
 	uint64_t eaddr;
 	int r;
=20
-	r =3D amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	r =3D amdgpu_vm_verify_parameters(ctx->adev, bo, saddr, offset, size);
 	if (r)
 		return r;
=20
@@ -1904,7 +1951,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *a=
dev,
 	if (!mapping)
 		return -ENOMEM;
=20
-	r =3D amdgpu_vm_bo_clear_mappings(adev, bo_va->base.vm, saddr, size);
+	r =3D amdgpu_vm_bo_clear_mappings(ctx, saddr, size);
 	if (r) {
 		kfree(mapping);
 		return r;
@@ -1918,7 +1965,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *a=
dev,
 	mapping->offset =3D offset;
 	mapping->flags =3D flags;
=20
-	amdgpu_vm_bo_insert_map(adev, bo_va, mapping);
+	amdgpu_vm_bo_insert_map(ctx->adev, bo_va, mapping);
=20
 	return 0;
 }
@@ -1926,7 +1973,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *a=
dev,
 /**
  * amdgpu_vm_bo_unmap - remove bo mapping from vm
  *
- * @adev: amdgpu_device pointer
+ * @ctx: VM update context
  * @bo_va: bo_va to remove the address from
  * @saddr: where to the BO is mapped
  *
@@ -1937,12 +1984,12 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device =
*adev,
  *
  * Object has to be reserved and unreserved outside!
  */
-int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
+int amdgpu_vm_bo_unmap(struct amdgpu_vm_update_ctx *ctx,
 		       struct amdgpu_bo_va *bo_va,
 		       uint64_t saddr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
-	struct amdgpu_vm *vm =3D bo_va->base.vm;
+	struct amdgpu_vm *vm =3D ctx->vm;
 	bool valid =3D true;
=20
 	saddr /=3D AMDGPU_GPU_PAGE_SIZE;
@@ -1969,7 +2016,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	 * from user space.
 	 */
 	if (unlikely(bo_va->userq_va_mapped))
-		amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
+		amdgpu_userq_gem_va_unmap_validate(ctx->adev, mapping, saddr);
=20
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
@@ -1977,9 +2024,9 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
=20
 	if (valid)
-		list_add(&mapping->list, &vm->freed);
+		list_add(&mapping->list, &ctx->freed);
 	else
-		amdgpu_vm_free_mapping(adev, vm, mapping,
+		amdgpu_vm_free_mapping(ctx->adev, vm, mapping,
 				       bo_va->last_pt_update);
=20
 	return 0;
@@ -1988,8 +2035,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 /**
  * amdgpu_vm_bo_clear_mappings - remove all mappings in a specific range
  *
- * @adev: amdgpu_device pointer
- * @vm: VM structure to use
+ * @ctx: VM update context
  * @saddr: start of the range
  * @size: size of the range
  *
@@ -1998,8 +2044,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
-				struct amdgpu_vm *vm,
+int amdgpu_vm_bo_clear_mappings(struct amdgpu_vm_update_ctx *ctx,
 				uint64_t saddr, uint64_t size)
 {
 	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
@@ -2007,7 +2052,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
 	uint64_t eaddr;
 	int r;
=20
-	r =3D amdgpu_vm_verify_parameters(adev, NULL, saddr, 0, size);
+	r =3D amdgpu_vm_verify_parameters(ctx->adev, NULL, saddr, 0, size);
 	if (r)
 		return r;
=20
@@ -2028,7 +2073,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
 	INIT_LIST_HEAD(&after->list);
=20
 	/* Now gather all removed mappings */
-	tmp =3D amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
+	tmp =3D amdgpu_vm_it_iter_first(&ctx->vm->va, saddr, eaddr);
 	while (tmp) {
 		/* Remember mapping split at the start */
 		if (tmp->start < saddr) {
@@ -2059,7 +2104,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 	/* And free them up */
 	list_for_each_entry_safe(tmp, next, &removed, list) {
-		amdgpu_vm_it_remove(tmp, &vm->va);
+		amdgpu_vm_it_remove(tmp, &ctx->vm->va);
 		list_del(&tmp->list);
=20
 		if (tmp->start < saddr)
@@ -2068,7 +2113,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
 		    tmp->last =3D eaddr;
=20
 		tmp->bo_va =3D NULL;
-		list_add(&tmp->list, &vm->freed);
+		list_add(&tmp->list, &ctx->freed);
 		trace_amdgpu_vm_bo_unmap(NULL, tmp);
 	}
=20
@@ -2076,11 +2121,11 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_devi=
ce *adev,
 	if (!list_empty(&before->list)) {
 		struct amdgpu_bo *bo =3D before->bo_va->base.bo;
=20
-		amdgpu_vm_it_insert(before, &vm->va);
+		amdgpu_vm_it_insert(before, &ctx->vm->va);
 		if (before->flags & AMDGPU_VM_PAGE_PRT)
-			amdgpu_vm_prt_get(adev);
+			amdgpu_vm_prt_get(ctx->adev);
=20
-		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
+		if (amdgpu_vm_is_bo_always_valid(ctx->vm, bo) &&
 		    !before->bo_va->base.moved)
 			amdgpu_vm_bo_needs_update(&before->bo_va->base);
 	} else {
@@ -2091,11 +2136,11 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_devi=
ce *adev,
 	if (!list_empty(&after->list)) {
 		struct amdgpu_bo *bo =3D after->bo_va->base.bo;
=20
-		amdgpu_vm_it_insert(after, &vm->va);
+		amdgpu_vm_it_insert(after, &ctx->vm->va);
 		if (after->flags & AMDGPU_VM_PAGE_PRT)
-			amdgpu_vm_prt_get(adev);
+			amdgpu_vm_prt_get(ctx->adev);
=20
-		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
+		if (amdgpu_vm_is_bo_always_valid(ctx->vm, bo) &&
 		    !after->bo_va->base.moved)
 			amdgpu_vm_bo_needs_update(&after->bo_va->base);
 	} else {
@@ -2156,14 +2201,14 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, s=
truct ww_acquire_ctx *ticket)
 /**
  * amdgpu_vm_bo_del - remove a bo from a specific vm
  *
- * @adev: amdgpu_device pointer
+ * @ctx: VM update context
  * @bo_va: requested bo_va
  *
  * Remove @bo_va->bo from the requested vm.
  *
  * Object have to be reserved!
  */
-void amdgpu_vm_bo_del(struct amdgpu_device *adev,
+void amdgpu_vm_bo_del(struct amdgpu_vm_update_ctx *ctx,
 		      struct amdgpu_bo_va *bo_va)
 {
 	struct amdgpu_bo_va_mapping *mapping, *next;
@@ -2198,19 +2243,19 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		amdgpu_vm_it_remove(mapping, &vm->va);
 		mapping->bo_va =3D NULL;
 		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
-		list_add(&mapping->list, &vm->freed);
+		list_add(&mapping->list, &ctx->freed);
 	}
 	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
 		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
-		amdgpu_vm_free_mapping(adev, vm, mapping,
+		amdgpu_vm_free_mapping(ctx->adev, vm, mapping,
 				       bo_va->last_pt_update);
 	}
=20
 	dma_fence_put(bo_va->last_pt_update);
=20
 	if (bo && bo_va->is_xgmi)
-		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
+		amdgpu_xgmi_set_pstate(ctx->adev, AMDGPU_XGMI_PSTATE_MIN);
=20
 	kfree(bo_va);
 }
@@ -2568,7 +2613,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struc=
t amdgpu_vm *vm,
 	amdgpu_vm_bo_status_init(&vm->always_valid);
 	spin_lock_init(&vm->individual_lock);
 	amdgpu_vm_bo_status_init(&vm->individual);
-	INIT_LIST_HEAD(&vm->freed);
+	INIT_LIST_HEAD(&vm->delayed_freed);
 	INIT_KFIFO(vm->faults);
 	spin_lock_init(&vm->stats_lock);
=20
@@ -2768,7 +2813,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm)
 	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
 	dma_fence_put(vm->last_tlb_flush);
=20
-	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
+	list_for_each_entry_safe(mapping, tmp, &vm->delayed_freed, list) {
 		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
 			amdgpu_vm_prt_fini(adev, vm);
 			prt_fini_needed =3D false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.h
index 2e01a51d5e41a..0bd3fa1100dd6 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -262,6 +262,39 @@ struct amdgpu_task_info {
 	struct kref	refcount;
 };
=20
+/**
+ * struct amdgpu_vm_update_ctx
+ *
+ * Encapsulates various state that is carried around during VM updates.
+ */
+struct amdgpu_vm_update_ctx {
+	/**
+	 * @adev: amdgpu device the update is done on
+	 */
+	struct amdgpu_device *adev;
+	/**
+	 * @vm: target VM of the update
+	 */
+	struct amdgpu_vm *vm;
+
+	/**
+	 * @freed: A list of mappings that are freed and pending PT/PD updates d=
uring
+	 * this update operation.
+	 */
+	struct list_head freed;
+
+	/**
+	 * @sync: Container for everything to sync to before committing PT/PD up=
dates.
+	 */
+	struct amdgpu_sync sync;
+
+	/**
+	 * @unmap_synced: Whether the sync is strong enough to guarantee a safe =
unmap,
+	 * i.e. all previous submissions in the VM are waited on.
+	 */
+	bool unmap_synced;
+};
+
 /**
  * struct amdgpu_vm_update_params
  *
@@ -391,7 +424,7 @@ struct amdgpu_vm {
 	 * This list contains amdgpu_bo_va_mapping objects which have been freed
 	 * but not updated in the PTs
 	 */
-	struct list_head	freed;
+	struct list_head	delayed_freed;
=20
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
@@ -518,9 +551,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bo=
ol need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
-int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm,
+int amdgpu_vm_clear_freed(struct amdgpu_vm_update_ctx *ctx,
 			  struct dma_fence **fence);
+int amdgpu_vm_delayed_free(struct amdgpu_device *adev, struct amdgpu_vm *=
vm);
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket);
@@ -537,7 +570,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
 			   uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence);
-int amdgpu_vm_bo_update(struct amdgpu_device *adev,
+int amdgpu_vm_bo_update(struct amdgpu_vm_update_ctx *ctx,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
@@ -553,24 +586,25 @@ struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu=
_vm *vm,
 struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 				      struct amdgpu_vm *vm,
 				      struct amdgpu_bo *bo);
-int amdgpu_vm_bo_map(struct amdgpu_device *adev,
+
+int amdgpu_vm_bo_map(struct amdgpu_vm_update_ctx *ctx,
 		     struct amdgpu_bo_va *bo_va,
 		     uint64_t addr, uint64_t offset,
 		     uint64_t size, uint32_t flags);
-int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
+int amdgpu_vm_bo_replace_map(struct amdgpu_vm_update_ctx *ctx,
 			     struct amdgpu_bo_va *bo_va,
 			     uint64_t addr, uint64_t offset,
 			     uint64_t size, uint32_t flags);
-int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
+int amdgpu_vm_bo_unmap(struct amdgpu_vm_update_ctx *ctx,
 		       struct amdgpu_bo_va *bo_va,
 		       uint64_t addr);
-int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
-				struct amdgpu_vm *vm,
+int amdgpu_vm_bo_clear_mappings(struct amdgpu_vm_update_ctx *ctx,
 				uint64_t saddr, uint64_t size);
+
 struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_vm=
 *vm,
 							 uint64_t addr);
 void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *t=
icket);
-void amdgpu_vm_bo_del(struct amdgpu_device *adev,
+void amdgpu_vm_bo_del(struct amdgpu_vm_update_ctx *ctx,
 		      struct amdgpu_bo_va *bo_va);
 void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_si=
ze,
 			   uint32_t fragment_size_default, unsigned max_level,
@@ -626,6 +660,40 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm);
=20
 bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo =
*bo);
=20
+int amdgpu_vm_update_ctx_ensure_unmap_synced(struct amdgpu_vm_update_ctx =
*ctx);
+
+/**
+ * amdgpu_vm_update_ctx_init - create a context for VM update operations
+ * @ctx: The new context to create
+ * @adev: The device associated with the VM update
+ * @vm: The VM being updated
+ *
+ * Initializes the context to an empty state.
+ */
+static inline void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx =
*ctx,
+					     struct amdgpu_device *adev,
+					     struct amdgpu_vm *vm)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->adev =3D adev;
+	ctx->vm =3D vm;
+	INIT_LIST_HEAD(&ctx->freed);
+	amdgpu_sync_create(&ctx->sync);
+}
+
+/**
+ * amdgpu_vm_update_ctx_fini - finish a VM update operation
+ * @ctx: The context of the update
+ *
+ * Adds any leftover mappings needing to be cleared to the VM's delayed f=
ree list,
+ * then frees up resources used by the context.
+ */
+static inline void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx =
*ctx)
+{
+	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
+	amdgpu_sync_free(&ctx->sync);
+}
+
 /**
  * amdgpu_vm_tlb_seq - return tlb flush sequence number
  * @vm: the amdgpu_vm structure to query
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/=
amdgpu/mes_v12_1.c
index b169e577e5838..255ff4cd4f887 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2038,32 +2038,33 @@ static int mes_v12_1_map_test_bo(struct amdgpu_dev=
ice *adev,
 				 struct amdgpu_bo *bo, struct amdgpu_vm *vm,
 				 struct amdgpu_bo_va **bo_va, u64 va, int size)
 {
-	struct amdgpu_sync sync;
+	struct amdgpu_vm_update_ctx update_ctx;
 	int r;
=20
 	r =3D amdgpu_map_static_csa(adev, vm, bo, bo_va, va, size);
 	if (r)
 		return r;
=20
-	amdgpu_sync_create(&sync);
+	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
=20
-	r =3D amdgpu_vm_bo_update(adev, *bo_va, false);
+	r =3D amdgpu_vm_bo_update(&update_ctx, *bo_va, false);
 	if (r) {
 		dev_err(adev->dev, "failed to do vm_bo_update on meta data\n");
 		goto error;
 	}
-	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update, GFP_KERNEL);
+	amdgpu_sync_fence(&update_ctx.sync, (*bo_va)->last_pt_update,
+			  GFP_KERNEL);
=20
 	r =3D amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
 		dev_err(adev->dev, "failed to update pdes on meta data\n");
 		goto error;
 	}
-	amdgpu_sync_fence(&sync, vm->last_update, GFP_KERNEL);
-	amdgpu_sync_wait(&sync, false);
+	amdgpu_sync_fence(&update_ctx.sync, vm->last_update, GFP_KERNEL);
+	amdgpu_sync_wait(&update_ctx.sync, false);
=20
 error:
-	amdgpu_sync_free(&sync);
+	amdgpu_vm_update_ctx_fini(&update_ctx);
 	return r;
 }
=20

=2D-=20
2.54.0

