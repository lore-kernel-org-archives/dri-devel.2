Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CC3CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0654F10EF26;
	Tue, 29 Sep 2026 19:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J2Ury0OX";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648CE10EF26
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:34:37 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so18843845e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790710476; x=1791315276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=acnZdYKptnO57K0FUhrjejxYfH3e0lZEcXBnvErIjnY=;
 b=J2Ury0OXPmxB9Fjhvotr4qtn5k/jJEtHQQQ/NS2bkgbYBaxNVcAwxe49aGv3ORsfXp
 oubfUP0DTaEqqXcolDBLwOMZ6hJRLDKnaWRSfx0tqM+Tt/4ZhjOAVHMEuzevjm9YGgIV
 6k7Ac2sSI8bDowDirwpYH9rLHrJ09Fh+aj8PNb+LcZ9N4IAPJweU0tlVdf+6Z/im2bvw
 Ya5bheZw0yRR/+OmN0ox23fSGYdBIfMP/eTuaj0DNdQTJOYQ1SZAfoye5pkq9VWP2BzV
 EP6TT9NIrFkOyCKWV4z8Fd0eDQjEOwopHckLxNNyVwXaXs/jlputQiNLhTKVX0RdKUJI
 ww4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790710476; x=1791315276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=acnZdYKptnO57K0FUhrjejxYfH3e0lZEcXBnvErIjnY=;
 b=xB+RLF6LF9wPC/0h5rnXL0PN16Db9ZIxO9L2zp6CVAF+tMRyQRxTRQBCqouAGvzuWR
 O+p4Rtc5QGgIjLmMYLlKIs/r5Z1RKK7seZHda+vB84zVaqHulupBBzcRRioTfLB+6woB
 Rh/73WuHWlxcHD6cH3UmZpI6PyPeptw6o58BaG3m1BlAuMQPeXoOVUz7x9prc2Q5hpyN
 RRGKUaSG9F//mYF6J0QOsSZZdskfzwesX0QBDemSR44CiOiDag0jZwcA1uYOA0muyxYk
 I6CEx87+HkkdUJkN1m21MYo/YjlpPrFU4Khljsj2g2WFtWxNC8ZOR7jQsIoSUFXOXwoq
 rumw==
X-Forwarded-Encrypted: i=1;
 AKwUvByP448sN4YA9UBJFL2wAMHTW3KsTVg6sSPOlnrOfe+ZfsQ/8GE1G9sVsLHKiWOT7KTMQFkG8RZzDyM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltgK8Zo0CMM6hBqbspayZLvtcS091fhDGkG1ravIUVqbokZVz2
 yuZ8SF+Z9+HT2mXXEYTsfzezWkuynCNAmWztIYG0dN2iJDvHCZSSoOSM
X-Gm-Gg: AYBFou1mw7ulxQFwd4L7NqFhlB2V4bqUnsLHdaTvsTtLyPz7VGAKczbIosk5GREmmLC
 U012YeNYorhnpuO1NW7jDBlRWiJqrUUvhIz8QlMF35OJvQOOL0lHu4qo6dbTcUZBfJd4fs6hgyQ
 FB8s6JObDeahwCL8QNeIa53nOpIcYLiY+1cMB0tx24X/nZM9IliCPvphEqxyesIZCaY/FXpxi3b
 blJQWP9bNHmsdEoPvZjCYOzOoDK9HnTPwX+Qy8gE9FdX5rJZwfmNMVDpNpqVecWJOVv/U+6kmse
 pgS3m29LXfElQ6k9MNJ61kHZWXpd3Zj958YwCguh72P0CPIu6wIahglZ7OqtLdQY8BI38G+Isn2
 1oEsbCZ7a+C73ZqdEWQG5Xs0vlYaSVJOJGwmvCXwvoldNSN7jP/ISOKgtKfT2WUoFfaq92bgQSJ
 LjtLeIEKFEQAvt8vgirYxGEpF2OVG3UUnxnBBQsBG7gcEoN/B9juAqXRpIGcH4Y/ATgyfJAfz7y
 mAnFZQZGY6/wbSK3FykrPfkPkT1uKeqKJ97M316anjIhE2W0f5O7le1I40=
X-Received: by 2002:a05:600c:19d4:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-4a015032c77mr1786905e9.18.1790710475411; 
 Tue, 29 Sep 2026 12:34:35 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014f29530sm4477685e9.1.2026.09.29.12.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:34:34 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
Date: Tue, 29 Sep 2026 20:34:32 +0100
Message-ID: <20260929193432.100694-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

The exporter records an importer when it answers NPA-REQ, so it can send
NPA-REVOKE as soon as the BO is freed, before the importer has finished
building the dma-buf for that handle. The revoke handler assumes a fully
imported node: it dereferences imp_xa_node->dmabuf, which is still NULL
until the import completes, and drops the xarray reference the importing
thread still relies on. The importer then links the node and marks it
READY regardless, so the node can be freed while still on the per-remote
list.

Only tear down a node that is READY. A PENDING node is still being
imported and nothing has been handed to user-space yet, so only mark it
for teardown and send NPA-RELEASE. The importer checks for teardown under
the xarray lock before linking the node and marking it READY, and unwinds
otherwise. As NPA-REVOKE always follows NPA-RSP, a revoke that finds the
node NOT_READY is stale, and one that finds it in teardown hits a node
that is already being released, so both are ignored.

Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
Assisted-by: LLM
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v3:
- Handle the node state with a switch: tear down READY nodes, mark
  PENDING ones for teardown, ignore the rest (Mukul).
- Drop the npa_done completion on a NOT_READY node: the exporter only
  records the importer after sending NPA-RSP, so such a revoke is stale
  (Mukul).
- No longer send NPA-RELEASE for a node already in teardown (Mukul).
- Use dev_dbg() for the revoked-during-import message (Mukul).

Changes in v2:
- Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
  in teardown neither dereferences a NULL dmabuf nor drops the node
  reference twice (Sashiko).
- Complete npa_done when a revoke arrives before NPA-RSP, so the importer
  fails right away instead of timing out into a connection reset (Sashiko).
- Use the current Assisted-by format.

Found by code analysis and compile-tested with W=1. Not tested on hardware,
as it needs two UALink-connected accelerators in a vPod.

v2: https://lore.kernel.org/all/20260926174406.346253-1-devnexen@gmail.com/
v1: https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 51 +++++++++++++++++-----
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..ea18e7f2e0a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3288,16 +3288,35 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 		return;
 	}
 
-	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
-	list_del_init(&imp_xa_node->list);
-	xa_unlock(&adev->ualink.imp_xa);
+	switch (READ_ONCE(imp_xa_node->node_state)) {
+	case AMDGPU_UALINK_NODE_READY:
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+		list_del_init(&imp_xa_node->list);
+		xa_unlock(&adev->ualink.imp_xa);
 
-	/* Invalidate the GPUVM mappings */
-	bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
-	amdgpu_ualink_invalidate_import_mappings(bo);
+		/* Invalidate the GPUVM mappings */
+		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
+		amdgpu_ualink_invalidate_import_mappings(bo);
 
-	/* Drop the refcount for the node */
-	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+		/* Drop the refcount for the node */
+		amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+		break;
+	case AMDGPU_UALINK_NODE_PENDING:
+		/* The import is still building the dma-buf and nothing has
+		 * been handed to user-space yet. The importing thread sees
+		 * the teardown state and unwinds.
+		 */
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+		xa_unlock(&adev->ualink.imp_xa);
+		break;
+	default:
+		/* NPA-REVOKE always follows NPA-RSP, so a NOT_READY node means
+		 * a stale revoke, and a node in teardown is already being
+		 * released by whoever moved it there.
+		 */
+		xa_unlock(&adev->ualink.imp_xa);
+		return;
+	}
 
 	r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
 	if (r)
@@ -3760,9 +3779,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 		return r;
 	}
 
-	/* Add this node to the imported handles list for the remote GPU */
+	/* Add this node to the imported handles list for the remote GPU,
+	 * unless the exporter revoked the handle while the import was in
+	 * flight. The dmabuf is released with the last node reference.
+	 */
 	xa_lock(&adev->ualink.imp_xa);
+	if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
+		xa_unlock(&adev->ualink.imp_xa);
+		dev_dbg(adev->dev,
+			"IMPORT: handle:%llx:%llx revoked during import\n",
+			handle.handle_hi, handle.handle_lo);
+		return -EINVAL;
+	}
 	list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
+	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
 	xa_unlock(&adev->ualink.imp_xa);
 
 	return 0;
@@ -3938,9 +3968,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 					"IMPORT: XA import failed for handle:%llx:%llx\n",
 					handle.handle_hi, handle.handle_lo);
 			goto cleanup;
-		} else {
-			WRITE_ONCE(imp_xa_node->node_state,
-				   AMDGPU_UALINK_NODE_READY);
 		}
 	}
 
-- 
2.55.0

