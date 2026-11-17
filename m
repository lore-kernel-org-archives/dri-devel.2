Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075A60A383C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=sbjq6CF8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A8E10F6CA;
	Tue, 17 Nov 2026 12:50:55 +0000 (UTC)
Received: from smtpout1.mo537.mail-out.ovh.net
 (smtpout1.mo537.mail-out.ovh.net [51.210.91.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFED510E5C4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:50:40 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPjC555fz49tX;
 Tue, 17 Nov 2026 12:50:39 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:39 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.125])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPjC44HDz46by; Tue, 17 Nov 2026 12:50:39 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id F27878E2104; 
 Tue, 17 Nov 2026 12:50:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002c6ecf3a6-a6cd-463b-9638-0e1571502b6c,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Date: Tue, 17 Nov 2026 13:50:12 +0100
Subject: [PATCH v2 06/10] drm/amdgpu: Add function to roll back a VM update ctx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-prt-explicit-sync-v2-6-bb3851cb6a0c@pixelcluster.dev>
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
x-ovh-tracer-id: 5593189263177310524
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG3XxnRytCov7xMKw+EhD98gb8ynfBocRBYNMsMgfPlDCFR+1JbYh20mEpTDvjc/OAMpizSJmEixbfqrNq6ZfHkRWKptz1ZjiYoBZsqT6YZLIvgh+Bm38hXZALZdYWPJpTzsNiquE5gMrFM5vk+50Sz2v82HxhHf4bgwj5FLKNjn7JuOY8PgAFDqVFMGCsQSmj3ope/vcyiDW42MIHCTXPl/I3uc30uPcByhhQr7oMpAWQoN0SsCTukQSkZK0F7RMNjulDncxLtK/gvhgh+PRBanr/0zJ2EwH5rhrNCu4u91/aWpb6Qffv1J03F4bNMm3mlEiWWwTQ9/HtaoJACI/G0nslU9xSRxHAv0z9cx5VDK74DiBh2j9/dM8lI0aH4QM/vEx94hIjj+XUtB81XIG08UFKmc8vhtHfX5E7t/UO1FkwE6pQutwiMKz4Vq+YkO2ZjS4ZIUH05isWmn+wLR8gEWJ3iTrJbKAAjDZu0986lxE4e6bIeY0tVXrBxQsJstOojcE9zIaQnohVKFPMw26jmZteCDGKykQ8g5K9aKnUbSbJKxIsyDJx4Iv/ep5WhamujpDUE89Aw4qcPQDQsp4yp8DzzOcfuwJ1H2EGsBmDOpZiwHWURT9AAjXtterGFU+fTjRVKkrkalpZTlrlEUgHxG46LrOT4+T0kK3dT2n6dmg
DKIM-Signature: a=rsa-sha256; bh=i5dZDTBA+fIUFAw6TWoe9mG1Zg05j36xpZHOTI427xg=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919839; v=1;
 b=sbjq6CF8ukjE8Nn4WWzQm3CA4wofOhKzWelnM1+SKTiVlWCBIo0rLYT4RwUde3el86D/w13r
 179myNxuXpR2kYSE7dlBs2WwXJIg1Pd16+PqKkkThxDFTAZJVuRdXHbMe6sa2GCaolzMuq1XV2I
 cUrEvW2DrhQ3w6IqVnYtQZWMYdgzIgH3NCSviDdZOkXKU3FtuEO3RC/Cm5XjNObJSpZYATvNAs8
 ltelaLNpDUjG2lqfpbMDGiKp93pA+Lcc0AwuE/ykx+C+rGSkMrEU35cATvFRmq0kv8r+v2fKSSE
 5Fb4fNSpxW75gXe7YlLdjPHA10gdgqDa9o8+IkCzJsNrg==
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

Used for discarding pending operations and retrying. This is needed when
we do lots of mapping operations at once and drm_exec tells us to drop
everything and retry to avoid deadlocks.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 41 +++++++++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 330c288053352..ac4a1ed9b1196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1874,37 +1874,48 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
 }
 
 /**
- * amdgpu_vm_update_ctx_fini - finish a VM update operation
- * @ctx: The context of the update
+ * amdgpu_vm_update_ctx_rollback - clear pending VM updates
+ * @ctx: The context to roll back
  *
- * Adds any leftover mappings needing to be cleared to the VM's delayed free list,
- * then frees up resources used by the context.
+ * Cleans up any pending mapping changes, but does not reset
+ * anything else (like attached syncobjs).
  */
-void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
+void amdgpu_vm_update_ctx_rollback(struct amdgpu_vm_update_ctx *ctx)
 {
+	struct amdgpu_bo_va_mapping *mapping, *next;
 	struct interval_tree_node *node, *next_node;
 	struct amdgpu_bo_va *bo_va, *next_bo_va;
 
-	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
-	amdgpu_sync_free(&ctx->sync);
+	list_for_each_entry_safe(mapping, next, &ctx->new, pending_list)
+		list_del_init(&mapping->pending_list);
+	list_for_each_entry_safe(mapping, next, &ctx->deleted, pending_list)
+		list_del_init(&mapping->pending_list);
 
 	list_for_each_entry_safe(bo_va, next_bo_va, &ctx->dirty_bo_vas,
-				 update_link) {
+				 update_link)
 		list_del_init(&bo_va->update_link);
-	}
 
-	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->pending_maps.rb_root, rb) {
+	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->pending_maps.rb_root, rb)
 		kfree(node);
-	}
-	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->cleared_ranges.rb_root, rb) {
+	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->cleared_ranges.rb_root, rb)
 		kfree(node);
-	}
 
 	ctx->pending_maps = RB_ROOT_CACHED;
 	ctx->cleared_ranges = RB_ROOT_CACHED;
+}
 
-	WARN_ON(!list_empty(&ctx->new));
-	WARN_ON(!list_empty(&ctx->deleted));
+/**
+ * amdgpu_vm_update_ctx_fini - finish a VM update operation
+ * @ctx: The context of the update
+ *
+ * Adds any leftover mappings needing to be cleared to the VM's delayed free list,
+ * then frees up resources used by the context.
+ */
+void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
+{
+	amdgpu_vm_update_ctx_rollback(ctx);
+	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
+	amdgpu_sync_free(&ctx->sync);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7a5f558970b5c..8d4f59c286c2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -623,6 +623,7 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
 			       struct amdgpu_vm *vm);
 int amdgpu_vm_update_ctx_execute_replace(struct amdgpu_vm_update_ctx *ctx);
 void amdgpu_vm_update_ctx_commit(struct amdgpu_vm_update_ctx *ctx);
+void amdgpu_vm_update_ctx_rollback(struct amdgpu_vm_update_ctx *ctx);
 void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx);
 int amdgpu_vm_update_ctx_ensure_unmap_synced(struct amdgpu_vm_update_ctx *ctx);
 

-- 
2.56.1

