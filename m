Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876C606A880
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=XyN2K4Fc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A90C10F645;
	Tue, 17 Nov 2026 12:50:47 +0000 (UTC)
Received: from smtpout3.mo537.mail-out.ovh.net
 (smtpout3.mo537.mail-out.ovh.net [51.210.91.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B2510F6BB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:50:40 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPjB27wKz3yrK;
 Tue, 17 Nov 2026 12:50:38 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:38 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.67])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPjB0qHXz21XL; Tue, 17 Nov 2026 12:50:38 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id B53F58E2108; 
 Tue, 17 Nov 2026 12:50:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0021dca712b-964f-4d8e-89a5-f62a52a32730,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Date: Tue, 17 Nov 2026 13:50:11 +0100
Subject: [PATCH v2 05/10] drm/amdgpu: Track dirty bo_va structures in
 update ctx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-prt-explicit-sync-v2-5-bb3851cb6a0c@pixelcluster.dev>
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
x-ovh-tracer-id: 5592907789732897084
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG3XxnRytCov7xMKw+EhD98gb8ynfBocRBYNMsMgfPlDCFR+1JbYh20mEpTDvjc/OAMpizSJmEixbfqrNq6ZfHkRWKptz1ZjiYoBZsqT6YZLIvgh+Bm38hXZALZdYWPJpTzsNiquE5gMrFM5vk+50Sz2v82HxhHf4bgwj5FLKNjn7JuOY8PgAFDqVFMGCsQSmj3ope/vcyiDW42MIHCTXPl/I3uc30uPcByhhQr7oMpAWQoN0SsCTukQSkZK0F7RMNjulDncxLtK/gvhgh+PRBanr/0zJ2EwH5rhrNCu4u91/aWpb6Qffv1J03F4bNMm3mlEiWWwTQ9/HtaoJACI/G0gtourMpSITVctJpjsuKIJcYW7xIzeS9m0TUqk9oB9XJD+Ib/tnZgpaxtLXS3Sro+z1tcGdWQeGv3lP8KzBeXlYMuUPNFZFd4OwU4KYvIwlm6aY4JSEbhh0x1/yEExNdCjXR+8uNSncl75bgnWVadgTYbwjpYfztM0rRgwLD+VJGqD+Hp+Jk6FwvzJGcbjYVJdytnaZU64qjC3nRcHGCyVF4LZGjaMGeFeefhd/6NfXxxwUMmSpQRbFPfyJMhS4Pzgdk84W+3GAW2vw556ekMU67y4C/JjCJX12abC9jrjlMqaGGcvtCd7DAIuDMnCYQQZ7O3z0apy7vN3Tb07joVlQ
DKIM-Signature: a=rsa-sha256; bh=2FuHkhres7c1a9hvpm6PvrBxWYxoOoyw665OrYuvrvk=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919838; v=1;
 b=XyN2K4FcizzRItPAWDOdQGuUcMco7E0t7S2Hggm0ZdFS9yDLhs5/k70gn+fc5NlXkGgtMUeh
 +7qKm6QfHiNai12UUhuL+nGUwdb6JjISDE6ziQO522Jo4GdamnAUiQ+zYsBoIE1+wdiHhDmdYPg
 8KoKF+4eadjVyV8jMj5qM2MfiFIJ7aZOl36p7xdMf3ZPijTx0KDtR/HCYmydAa3HY5gLqyLowZ8
 rCh24i8X76SWgyggtepsD57S227fj1AxxM4VF2R7UvR+PRyHjj8vIxv2/2qMwEJ6jeZer/TVZPs
 ONR9JnCUVH40NV4y1SkCHcnIeQJhBaqI5aS/OhYAHtVmg==
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

So we can later update all changed BOs without needing to do tracking
separately.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 +++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index e0090dc10682f..068c57ed537fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -80,6 +80,8 @@ struct amdgpu_bo_va {
 	/* protected by bo being reserved */
 	unsigned			ref_count;
 
+	struct list_head		update_link;
+
 	/* all other members protected by the VM PD being reserved */
 	struct dma_fence	        *last_pt_update;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1e2d45979efdb..330c288053352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1718,6 +1718,8 @@ amdgpu_vm_update_ctx_add_new_mapping(struct amdgpu_vm_update_ctx *ctx,
 	mapping->bo_va = bo_va;
 	WARN_ON(!list_empty(&mapping->pending_list));
 	list_add(&mapping->pending_list, &ctx->new);
+	if (list_empty(&mapping->bo_va->update_link))
+		list_add(&mapping->bo_va->update_link, &ctx->dirty_bo_vas);
 	return 0;
 }
 
@@ -1733,8 +1735,10 @@ static void
 amdgpu_vm_update_ctx_add_freed_mapping(struct amdgpu_vm_update_ctx *ctx,
 				       struct amdgpu_bo_va_mapping *mapping)
 {
-	WARN_ON(!list_empty(&mapping->pending_list));
-	list_add(&mapping->pending_list, &ctx->deleted);
+	if (list_empty(&mapping->bo_va->update_link))
+		list_add(&mapping->bo_va->update_link, &ctx->dirty_bo_vas);
+	if (list_empty(&mapping->pending_list))
+		list_add(&mapping->pending_list, &ctx->deleted);
 }
 
 int amdgpu_vm_update_ctx_execute_replace(struct amdgpu_vm_update_ctx *ctx)
@@ -1861,6 +1865,7 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
 
 	ctx->pending_maps = RB_ROOT_CACHED;
 	ctx->cleared_ranges = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&ctx->dirty_bo_vas);
 	INIT_LIST_HEAD(&ctx->new);
 	INIT_LIST_HEAD(&ctx->deleted);
 	INIT_LIST_HEAD(&ctx->freed);
@@ -1878,10 +1883,16 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_update_ctx *ctx,
 void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
 {
 	struct interval_tree_node *node, *next_node;
+	struct amdgpu_bo_va *bo_va, *next_bo_va;
 
 	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
 	amdgpu_sync_free(&ctx->sync);
 
+	list_for_each_entry_safe(bo_va, next_bo_va, &ctx->dirty_bo_vas,
+				 update_link) {
+		list_del_init(&bo_va->update_link);
+	}
+
 	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->pending_maps.rb_root, rb) {
 		kfree(node);
 	}
@@ -2135,6 +2146,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 
 	bo_va->ref_count = 1;
 	bo_va->last_pt_update = dma_fence_get_stub();
+	INIT_LIST_HEAD(&bo_va->update_link);
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5657aa63e9491..7a5f558970b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -305,6 +305,11 @@ struct amdgpu_vm_update_ctx {
 	 */
 	struct list_head cleared;
 
+	/**
+	 * @dirty_bo_vas: amdgpu_bo_va structures touched by current pending mapping changes.
+	 */
+	struct list_head dirty_bo_vas;
+
 	/**
 	 * @freed: A list of mappings that are freed and pending PT/PD updates during
 	 * this update operation.

-- 
2.56.1

