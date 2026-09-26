Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD493C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 17:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F6810E03C;
	Sat, 26 Sep 2026 17:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hchAiTaM";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FFB10E03C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 17:44:11 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so9340915e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790444649; x=1791049449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6al9428943yAcl20WwBMtLLUBgJYR9IbwENL+dao9Rg=;
 b=hchAiTaMkvyGM23V/udrfV6qOsaItnXccPQXZU1E5wIhcLECFj0HjQ0gs9WlmdW250
 MMmAuw6fNm825WInI3f2dza3oK2ZEuQYXCu2H7ubsw8YKSE/vPhtw/lUULeb9K4EQfav
 4BXVIEPtwYSd9m7Hjcznw/B3/7/rc20GlTBHLgcOOxX82w8P/kWZB+fRdJ0cUl4Gg1fE
 EPI4uTBqSDS0jO8XnoauScWuJ/wVtXDAgIjYnzU9IDC9asjN4QxbvPTLvI0FLC3oDCid
 2GZtcZUn4LFZ6jNJIlvXanCKN/hTMh22wuHR0Owoo+IPQOFBBpohqBwgndkS4R+slONF
 ITrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790444649; x=1791049449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6al9428943yAcl20WwBMtLLUBgJYR9IbwENL+dao9Rg=;
 b=lSOtCFYOoGuGG27V64oMjbTuHXk170DT32Pe3B+OkSQdTb+frrpThNJDlJJCvxkfmK
 cnnWxOBpJ5tBqaxpjougJA7zRVQMJI4GoJET+zCxLkAUMXIwgQ1MfODFRz9V+tjYhMuT
 aKhRE8Dj/roiOWS2KibIHqiVo60/KkttqcrbdahgLMX5GAw2pwjYYa8lToGTsQ0IO7Mi
 rzvOyJdQivAzXjb/7i6Ibeb7GZr9iNhJNJoELVH6UnGcsiuYC58JAQLbqqhSyLUXovaC
 i1VWarzq5rLfpYkwebXCQp0cQwMg4ifNgs0dVlnjieuw15VC2GGoipWh9PspY0PQPLF6
 3ugw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0uNcam7CulE+YP0VE/gZSv9kaVCAZHCwit/6IIU8zWLE++eoH9M/+OAfSZ0WFuQf5r+PKjIMkON0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kA7xyPB6wx8yrMPIH5FNU0IPsUy5/QYXJ3+ybqClUcqA8Wjg3p
 6bZvkrTLOi+mQ1Hxqa6Evc+EWHpzrNBIrCZMumdj3Q4E4JLnqSgS0M+P
X-Gm-Gg: AYBFou2sQaqljbH1CS5HYa5G8N6F8O61oKtEdbCNiiKk2+Y7+lFfDbr34HXW9TpxytV
 3jOoF9+0NyxlX+6fFr+UhXPt2qzcBrEsplzfTjQrylWfxUpZLww/gEOh8zEEfY9INLxfg+zHk91
 WV5E5bLVpL4XJpZSbKkwfcn/oCeFSR7o4lo0gpBUoPQADkYkuiJdV2RH3SUnkjl6ypF/rkV/hE9
 il8n+Ytpym330hIod+juli7H6fut7zr6AVSztMaWqLZu8Y5SkrEly8Yt2V7L53abr3P0fVpABue
 BF21TCUwMt4z0K3qtL1evXxquRwJGyiXukW3UCrhe0ZgWYwQ4knlrPFEzvsv9J3/7PIiBfOHMZ+
 PGSlHngszXp5ZvwpuzNseRLVD247mtLoY9kLymTLCrUuska7lon4SSsir0eN11sHfiAzhrmD/vp
 wgIDKAqj6yuPJ0RvY89acqdbWmexHGjXQw1LPwsHKUxFZhRRJfpPP6Q2t2VEPF9vmY20o06QnXa
 OfZ7ek/kdQViP6JZIvy48U7a2T3MGsqlauGd2Q7kifAaxVlWCMl+5BEHEI=
X-Received: by 2002:a05:600c:1d29:b0:49c:fc6e:a3d9 with SMTP id
 5b1f17b1804b1-49fe66eeeaamr183527895e9.24.1790444649393; 
 Sat, 26 Sep 2026 10:44:09 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a000901b07sm9455665e9.9.2026.09.26.10.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 10:44:08 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
Date: Sat, 26 Sep 2026 18:44:06 +0100
Message-ID: <20260926174406.346253-1-devnexen@gmail.com>
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

Only tear down a node that is READY. Otherwise mark it for teardown and
send NPA-RELEASE, as nothing has been handed to user-space yet, and wake
the importer if it is still waiting for NPA-RSP so that it fails right
away. A node already in teardown belongs to whoever moved it there, so a
duplicate NPA-REVOKE no longer touches it either. The importer checks for
teardown under the xarray lock before linking the node and marking it
READY, and unwinds otherwise.

Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
Assisted-by: LLM
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
- Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
  in teardown neither dereferences a NULL dmabuf nor drops the node
  reference twice (Sashiko).
- Complete npa_done when a revoke arrives before NPA-RSP, so the importer
  fails right away instead of timing out into a connection reset (Sashiko).
- Use the current Assisted-by format.

Found by code analysis and compile-tested with W=1. Not tested on hardware,
as it needs two UALink-connected accelerators in a vPod.

v1: https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 34 +++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..cb35026e6eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3265,6 +3265,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 {
 	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
 	struct amdgpu_bo *bo;
+	u32 node_state;
 	int r = 0;
 
 	/* Remove the entry from the Xarray. */
@@ -3288,7 +3289,23 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 		return;
 	}
 
+	node_state = READ_ONCE(imp_xa_node->node_state);
 	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+
+	/* Only a READY node is torn down here. If the import is still in
+	 * flight, the dmabuf may not exist yet and nothing has been handed
+	 * to user-space: leave the node to the importing thread, which sees
+	 * the teardown state and unwinds, and wake it up if it is still
+	 * waiting for NPA-RSP. A node already in teardown is owned by
+	 * whoever moved it there, e.g. an earlier NPA-REVOKE.
+	 */
+	if (node_state != AMDGPU_UALINK_NODE_READY) {
+		if (node_state == AMDGPU_UALINK_NODE_NOT_READY)
+			complete(&imp_xa_node->npa_done);
+		xa_unlock(&adev->ualink.imp_xa);
+		goto send_release;
+	}
+
 	list_del_init(&imp_xa_node->list);
 	xa_unlock(&adev->ualink.imp_xa);
 
@@ -3299,6 +3316,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 	/* Drop the refcount for the node */
 	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
 
+send_release:
 	r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
 	if (r)
 		dev_err(adev->dev,
@@ -3760,9 +3778,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
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
+		dev_warn(adev->dev,
+			 "IMPORT: handle:%llx:%llx revoked during import\n",
+			 handle.handle_hi, handle.handle_lo);
+		return -EINVAL;
+	}
 	list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
+	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
 	xa_unlock(&adev->ualink.imp_xa);
 
 	return 0;
@@ -3938,9 +3967,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
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

