Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47064606A895
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=SL7xZHJ7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F7010E5C4;
	Tue, 17 Nov 2026 12:50:46 +0000 (UTC)
Received: from smtpout8.mo536.mail-out.ovh.net
 (smtpout8.mo536.mail-out.ovh.net [51.210.91.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B735710F6AE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:50:37 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPj75kqCz8C6c;
 Tue, 17 Nov 2026 12:50:35 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:35 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.101.225])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPj74fMhz21fM; Tue, 17 Nov 2026 12:50:35 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 03B918E2105; 
 Tue, 17 Nov 2026 12:50:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002d97255bb-ae0b-48dc-95d1-5650dc156d56,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Date: Tue, 17 Nov 2026 13:50:09 +0100
Subject: [PATCH v2 03/10] drm/amdgpu: Make VM maps pending per update context
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-prt-explicit-sync-v2-3-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
In-Reply-To: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 5592063362460639548
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEtMLNZ7zl3hZS0QujQ8yQ22LDgVdhzpha4+IeAp0v3qRi7RlvIawM8F+reK1uFP3gObEd+Op0pV8HKoYz/IdFHeIGUvHESHRdbqPgxwcMr3fWzuyoZqMedIbLa2wvXQtVFLNeDH/SlilX/nEw4JffXwjR3cVIo0cJmKV8Eqv7wYFb3GtDiyY8kK+D15qlVB6eVnD2K8S/ppqCIkQvmeaOPqMmihrStTy5aUOHI/ont7Q6Fbepgt9P26mfNwIpjinkQuMAdQr1HU9R20XlH3h1o0XjWzFPy3+3DVPHJyHRaudmjZ+fDDPELOO7vyMBoTNW09BYfnscefRboS7jGNrvoYfVzqpVyxaahwQ6TFdo8ziD7kAX2RTgILeSAjDw9KQz5mwPysszU48AzYCZ9dAYZr7Rl8WBwZY8I4Gnb/XlFoqU8dBHwIlz+VHOJjkbwLtGRrNoszh8/FJyjTgiF0cBfcB5XhbbVDMD5NGGQMf6O32phTUDFUNJpKdC8SFgTX8Y49pTMBbP1WnTTt+bSjdiDwumWNJJAFlcVpUIZiLRsdvDaL02SLpaK9WyKpqIAQJBW2n2ZJNQHe89D2ma2v1IjsjytwFTq6CSGtt58PS7KiGomI6wGGutfos6N4kQ6Bvu00qGzgCI7azDJm+JGLWaZQkzTKSoR6s+Uh5uCf0EizA
DKIM-Signature: a=rsa-sha256; bh=AYUxotVao4UApSGjzh7BkJbsSM8P/pPDlmnb7tB9BJ0=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919836; v=1;
 b=SL7xZHJ7X3jK3QQCky1QOIJdhh91RvTv4zbcKluyWIMIjeiWKUIeSxv7k44llHZGTFGB+uD8
 4ZE3HjBaGywNtyv6fgJNPphM49QbqUrRQ3OFY3ZlpnIqIbnfBK2M4GOyreeNIcwI08tFinrP8ra
 a3EjKczUw73K2aSfZj9aE7DFT6jiJri0CU10ylCJ7GTyXGGGPQCwlVM2RKBiLStWMMJwDKCE1v8
 WoqTWNX6e2DkwGt0kPjfSugpL5JXV1lw011cSfjIXMIXLAWvVIVS8lf+nuLbbloP6jMjV/gPucH
 BmjJ3XLhgZwWYNKtNM7fLD5n/LN4TNk67uU28Vlu3lOaA==
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For later being able to discard pending changes when an error is
encountered afterwards.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 124 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  11 ++
 7 files changed, 113 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 08ab754e56d3d..b20b84d0a54bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1351,13 +1351,16 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	ret = amdgpu_vm_bo_map(&update_ctx, bo_va, entry->va, 0,
 			       amdgpu_bo_size(entry->bo_va->base.bo),
 			       entry->pte_flags);
-	amdgpu_vm_update_ctx_fini(&update_ctx);
 	if (ret) {
 		pr_err("Failed to map VA 0x%llx in vm. ret %d\n",
 				entry->va, ret);
+		amdgpu_vm_update_ctx_fini(&update_ctx);
 		return ret;
 	}
 
+	amdgpu_vm_update_ctx_commit(&update_ctx);
+	amdgpu_vm_update_ctx_fini(&update_ctx);
+
 	if (no_update_pte)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index f33dfdb6efe2f..8ec6b46e3f25a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -22,6 +22,7 @@
  * * Author: Monk.liu@amd.com
  */
 
+#include "amdgpu_vm.h"
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
@@ -94,6 +95,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	r = amdgpu_vm_bo_map(&update_ctx, *bo_va, csa_addr, 0, size,
 			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
 			     AMDGPU_PTE_EXECUTABLE);
+	amdgpu_vm_update_ctx_commit(&update_ctx);
 
 	if (r) {
 		drm_err(adev_to_drm(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 55bdf5070837a..2816d0851bf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1044,6 +1044,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 
+	amdgpu_vm_update_ctx_commit(&update_ctx);
+
 	/*
 	 * Once the VA operation is done, update the VM and obtain the fence
 	 * that represents the last relevant update for this mapping. This
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 2e6a8e6f577a7..e0090dc10682f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -64,6 +64,7 @@ struct amdgpu_bo_param {
 struct amdgpu_bo_va_mapping {
 	struct amdgpu_bo_va		*bo_va;
 	struct list_head		list;
+	struct list_head		pending_list;
 	struct rb_node			rb;
 	uint64_t			start;
 	uint64_t			last;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 63068be7ae4fd..84a14a5cc0be2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -104,6 +104,7 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		amdgpu_vm_bo_del(adev, *bo_va);
 		goto err_ctx;
 	}
+	amdgpu_vm_update_ctx_commit(&update_ctx);
 
 err_ctx:
 	amdgpu_vm_update_ctx_fini(&update_ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 90f27feb84257..97cf04da6a025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1589,6 +1589,73 @@ static void amdgpu_vm_prt_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 }
 
+/**
+ * amdgpu_vm_bo_commit_insert - insert a new mapping
+ *
+ * @adev: amdgpu_device pointer
+ * @bo_va: bo_va to store the address
+ * @mapping: the mapping to insert
+ *
+ * Insert a new mapping into all structures.
+ */
+static void amdgpu_vm_bo_commit_insert(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va *bo_va,
+				       struct amdgpu_bo_va_mapping *mapping)
+{
+	struct amdgpu_vm *vm = bo_va->base.vm;
+	struct amdgpu_bo *bo = bo_va->base.bo;
+
+	mapping->bo_va = bo_va;
+	list_add(&mapping->list, &bo_va->invalids);
+	amdgpu_vm_it_insert(mapping, &vm->va);
+
+	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
+		amdgpu_vm_prt_get(adev);
+
+	if (bo && !bo_va->base.moved)
+		amdgpu_vm_bo_needs_update(&bo_va->base);
+
+	trace_amdgpu_vm_bo_map(bo_va, mapping);
+}
+
+void amdgpu_vm_update_ctx_commit(struct amdgpu_vm_update_ctx *ctx)
+{
+	struct amdgpu_bo_va_mapping *mapping, *next;
+
+	list_for_each_entry_safe(mapping, next, &ctx->new, pending_list) {
+		list_del_init(&mapping->pending_list);
+		amdgpu_vm_bo_commit_insert(ctx->adev, mapping->bo_va, mapping);
+	}
+}
+
+static int
+amdgpu_vm_update_ctx_add_new_mapping(struct amdgpu_vm_update_ctx *ctx,
+				     struct amdgpu_bo_va *bo_va,
+				     struct amdgpu_bo_va_mapping *mapping)
+{
+	struct interval_tree_node *pending;
+
+	if (interval_tree_iter_first(&ctx->pending_maps, mapping->start,
+				     mapping->last))
+		return -EINVAL;
+
+	pending = kzalloc_obj(*pending);
+	if (!pending)
+		return -ENOMEM;
+
+	if (interval_tree_iter_first(&ctx->pending_maps, mapping->start,
+				     mapping->last))
+		return -EINVAL;
+
+	pending->start = mapping->start;
+	pending->last = mapping->last;
+	interval_tree_insert(pending, &ctx->pending_maps);
+
+	mapping->bo_va = bo_va;
+	list_add(&mapping->pending_list, &ctx->new);
+	return 0;
+}
+
 /**
  * amdgpu_vm_update_ctx_ensure_unmap_synced - VM update sync helper
  * @ctx: context for updating the VM
@@ -1632,6 +1699,9 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->adev = adev;
 	ctx->vm = vm;
+
+	ctx->pending_maps = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&ctx->new);
 	INIT_LIST_HEAD(&ctx->freed);
 	amdgpu_sync_create(&ctx->sync);
 }
@@ -1645,8 +1715,17 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
  */
 void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
 {
+	struct interval_tree_node *pending, *next_pending;
+
 	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
 	amdgpu_sync_free(&ctx->sync);
+
+	rbtree_postorder_for_each_entry_safe(pending, next_pending, &ctx->pending_maps.rb_root, rb)
+		kfree(pending);
+
+	ctx->pending_maps = RB_ROOT_CACHED;
+
+	WARN_ON(!list_empty(&ctx->new));
 }
 
 /**
@@ -1901,36 +1980,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	return bo_va;
 }
 
-
-/**
- * amdgpu_vm_bo_insert_map - insert a new mapping
- *
- * @adev: amdgpu_device pointer
- * @bo_va: bo_va to store the address
- * @mapping: the mapping to insert
- *
- * Insert a new mapping into all structures.
- */
-static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
-				    struct amdgpu_bo_va *bo_va,
-				    struct amdgpu_bo_va_mapping *mapping)
-{
-	struct amdgpu_vm *vm = bo_va->base.vm;
-
-	mapping->bo_va = bo_va;
-	list_add(&mapping->list, &bo_va->invalids);
-	amdgpu_vm_it_insert(mapping, &vm->va);
-
-	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
-		amdgpu_vm_prt_get(adev);
-
-	/* PRT mappings have no BO and are kept off the state lists */
-	if (bo_va->base.bo && !bo_va->base.moved)
-		amdgpu_vm_bo_needs_update(&bo_va->base);
-
-	trace_amdgpu_vm_bo_map(bo_va, mapping);
-}
-
 /* Validate operation parameters to prevent potential abuse */
 static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
 					  struct amdgpu_bo *bo,
@@ -2015,8 +2064,14 @@ int amdgpu_vm_bo_map(struct amdgpu_vm_update_ctx *ctx,
 	mapping->last = eaddr;
 	mapping->offset = offset;
 	mapping->flags = flags;
+	mapping->bo_va = bo_va;
+	INIT_LIST_HEAD(&mapping->pending_list);
 
-	amdgpu_vm_bo_insert_map(ctx->adev, bo_va, mapping);
+	r = amdgpu_vm_update_ctx_add_new_mapping(ctx, bo_va, mapping);
+	if (r) {
+		kfree(mapping);
+		return r;
+	}
 
 	return 0;
 }
@@ -2071,8 +2126,13 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_vm_update_ctx *ctx,
 	mapping->last = eaddr;
 	mapping->offset = offset;
 	mapping->flags = flags;
+	INIT_LIST_HEAD(&mapping->pending_list);
 
-	amdgpu_vm_bo_insert_map(ctx->adev, bo_va, mapping);
+	r = amdgpu_vm_update_ctx_add_new_mapping(ctx, bo_va, mapping);
+	if (r) {
+		kfree(mapping);
+		return r;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8445599d9539a..d35494440cb5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -279,6 +279,16 @@ struct amdgpu_vm_update_ctx {
 	 */
 	struct amdgpu_vm *vm;
 
+	/**
+	 * @mapped_intervals: Interval tree of VA ranges mapped by this update operation.
+	 */
+	struct rb_root_cached pending_maps;
+
+	/**
+	 * @new: Pending new mappings not yet applied to bookkeeping structures.
+	 */
+	struct list_head new;
+
 	/**
 	 * @freed: A list of mappings that are freed and pending PT/PD updates during
 	 * this update operation.
@@ -583,6 +593,7 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
 			       struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm);
+void amdgpu_vm_update_ctx_commit(struct amdgpu_vm_update_ctx *ctx);
 void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx);
 int amdgpu_vm_update_ctx_ensure_unmap_synced(struct amdgpu_vm_update_ctx *ctx);
 

-- 
2.56.1

