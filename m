Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E72105F7B1
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F238C10E14F;
	Fri, 13 Mar 2026 15:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iC9QR2v4";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECCE10E14F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414662; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jJsKd0Za7cKVGDYgfssDVwiuAw1FvAgfCGnwce48ejgDaje8MIhYqx5ITI1PlzaiuCiSefhXMGuWXhYHMtIPLSnC8pFqT7I4MVFhOWo9QKI9zwuAXQHgsaJkoHvBmOrryDSvzWl3lFcmIKKAhI8icj4x2ntRNCQF7wfpk5qOoS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414662;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NLgkhCEcGm8XnL5NKaz5gxvh9IYzBqsDM7CURVbgAc4=; 
 b=YaZI+zloirCQe+1qrLy8zQg9Q9QSt/Ubhxd+ChLRCLY40M3+7YTZXng7ajJ7I3Y/3UdZHwgy5OuhfqhfBVjRhAk5esj6wBAjqBCwYhYSALTSy/NQ2w99NOMoQCCh7lVgQ1Cbi8RJ8oESCRdgwYzHI5eZpzRNeycuWhcSCfy88Gs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414662; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=NLgkhCEcGm8XnL5NKaz5gxvh9IYzBqsDM7CURVbgAc4=;
 b=iC9QR2v4pv6RQNB6LevA7HE5y7LyIBLfne9HP7xeCjnRgZPLuAOoU3PSiieqYlpO
 12PN0MHYfkHCLjBRI45bkmr6GHin6xzRFRjB/LfBcNcIy4zWrH1soH04wMdrS9CZMMO
 6mTIxzAxzTl6lzv1MhRvI8vnbZKJ/1OAMwAfAEvs=
Received: by mx.zohomail.com with SMTPS id 1773414660569482.8627229381509;
 Fri, 13 Mar 2026 08:11:00 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Caterina Shablia <caterina.shablia@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 04/11] drm/gpuvm: Add a helper to check if two VA can be
 merged
Date: Fri, 13 Mar 2026 15:09:41 +0000
Message-ID: <20260313150956.1618635-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
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

From: Boris Brezillon <boris.brezillon@collabora.com>

We are going to add flags/properties that will impact the VA merging
ability. Instead of sprinkling tests all over the place in
__drm_gpuvm_sm_map(), let's add a helper aggregating all these checks
can call it for every existing VA we walk through in the
__drm_gpuvm_sm_map() loop.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 46 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 3c2b6102e818..4af7b71abcb4 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2378,16 +2378,47 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void *priv,
 	return fn->sm_step_unmap(&op, priv);
 }
 
+static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *va,
+		      const struct drm_gpuva_op_map *new_map)
+{
+	struct drm_gpuva_op_map existing_map = {
+		.va.addr = va->va.addr,
+		.va.range = va->va.range,
+		.gem.offset = va->gem.offset,
+		.gem.obj = va->gem.obj,
+	};
+	const struct drm_gpuva_op_map *a = new_map, *b = &existing_map;
+
+	/* Only GEM-based mappings can be merged, and they must point to
+	 * the same GEM object.
+	 */
+	if (a->gem.obj != b->gem.obj || !a->gem.obj)
+		return false;
+
+	/* Order VAs for the rest of the checks. */
+	if (a->va.addr > b->va.addr)
+		swap(a, b);
+
+	/* We assume the caller already checked that VAs overlap or are
+	 * contiguous.
+	 */
+	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
+		return false;
+
+	/* We intentionally ignore u64 underflows because all we care about
+	 * here is whether the VA diff matches the GEM offset diff.
+	 */
+	return b->va.addr - a->va.addr == b->gem.offset - a->gem.offset;
+}
+
 static int
 __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		   const struct drm_gpuvm_ops *ops, void *priv,
 		   const struct drm_gpuvm_map_req *req,
 		   bool madvise)
 {
-	struct drm_gem_object *req_obj = req->map.gem.obj;
 	const struct drm_gpuvm_map_req *op_map = madvise ? NULL : req;
 	struct drm_gpuva *va, *next;
-	u64 req_offset = req->map.gem.offset;
 	u64 req_range = req->map.va.range;
 	u64 req_addr = req->map.va.addr;
 	u64 req_end = req_addr + req_range;
@@ -2402,15 +2433,12 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		u64 addr = va->va.addr;
 		u64 range = va->va.range;
 		u64 end = addr + range;
-		bool merge = !!va->gem.obj;
+		bool merge = can_merge(gpuvm, va, &req->map);
 
 		if (madvise && obj)
 			continue;
 
 		if (addr == req_addr) {
-			merge &= obj == req_obj &&
-				 offset == req_offset;
-
 			if (end == req_end) {
 				ret = op_unmap_cb(ops, priv, va, merge, madvise);
 				if (ret)
@@ -2455,8 +2483,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 			};
 			struct drm_gpuva_op_unmap u = { .va = va };
 
-			merge &= obj == req_obj &&
-				 offset + ls_range == req_offset;
 			u.keep = merge;
 
 			if (end == req_end) {
@@ -2506,10 +2532,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 				break;
 			}
 		} else if (addr > req_addr) {
-			merge &= obj == req_obj &&
-				 offset == req_offset +
-					   (addr - req_addr);
-
 			if (end == req_end) {
 				ret = op_unmap_cb(ops, priv, va, merge, madvise);
 				if (ret)
-- 
2.53.0

