Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1D5105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DAA10E16D;
	Fri, 13 Mar 2026 15:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="K6pUvDLz";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F049610E12D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414666; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DJvPtfjswVG2CYQgaZONb7ubOV0Xkv1ny937G6Jv6getoTQgSUCXP9MFiB31XdVR1eYGDLJZxi+wcAbgMO8ajINFTQV94aNBBwxTQUR976S7Q5EyXyC9da7BDnugWuClXFdMRYPkb+TqG4iYrBKOgH31QSxes66vUEbg+/FwtlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414666;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZRQU21SydWlGn3SLbet8XcWT6vkQMy9G/ENgtuG/wQo=; 
 b=Vxmde0Ju4S8GFpLK3w9dadXZLtHyjz7Q3ryifLCQkFFNLqDfnmxBVSLwSSdWiSSawdre5n1o2Pe9+7DGAK0e45ZnUc18OSmgHVTkDCw/XaZGeY/5vrDazo9wZmXGimwP7G5SY6YYS7br4u5c9WiXqi3Eko/V9L+Fg+ZRkxuKZ6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414666; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZRQU21SydWlGn3SLbet8XcWT6vkQMy9G/ENgtuG/wQo=;
 b=K6pUvDLzzK4Qetf5hGVTZzE9Xnj9wCRBaSIHTYPeT6hK3uNm6KfRWBjheZZBfC9J
 MNhYGpaku1lu2VR/22zmsjUZltnDyDUncvKmhPX/tvK7d9xC+3abQfaHtZ8pjoq42K3
 cQWisRigbTSAapO5fUdREQ604OB4KK5ENQoU67pg=
Received: by mx.zohomail.com with SMTPS id 1773414664754963.8852629735313;
 Fri, 13 Mar 2026 08:11:04 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Caterina Shablia <caterina.shablia@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 05/11] drm/gpuvm: Add a flags field to drm_gpuva_op_map
Date: Fri, 13 Mar 2026 15:09:42 +0000
Message-ID: <20260313150956.1618635-6-adrian.larumbe@collabora.com>
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

From: Asahi Lina <lina+kernel@asahilina.net>

drm_gpuva objects have a flags field. Currently, this can be managed by
drivers out-of-band, without any special handling in drm_gpuvm.

To be able to introduce flags that do affect the logic in the drm_gpuvm
core, we need to plumb it through the map calls. This will allow the
core to check the flags on map and alter the merge/split logic depending
on the requested flags and the flags of the existing drm_gpuva ranges
that are being split.

Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 14 ++++++++++++--
 include/drm/drm_gpuvm.h     | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 4af7b71abcb4..0d9c821d1b34 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2386,6 +2386,7 @@ static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *va,
 		.va.range = va->va.range,
 		.gem.offset = va->gem.offset,
 		.gem.obj = va->gem.obj,
+		.flags = va->flags,
 	};
 	const struct drm_gpuva_op_map *a = new_map, *b = &existing_map;
 
@@ -2395,6 +2396,10 @@ static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *va,
 	if (a->gem.obj != b->gem.obj || !a->gem.obj)
 		return false;
 
+	/* For two VAs to be merged, their flags must be compatible */
+	if ((a->flags & VA_MERGE_MUST_MATCH_FLAGS) != (b->flags & VA_MERGE_MUST_MATCH_FLAGS))
+		return false;
+
 	/* Order VAs for the rest of the checks. */
 	if (a->va.addr > b->va.addr)
 		swap(a, b);
@@ -2459,6 +2464,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.range = range - req_range,
 					.gem.obj = obj,
 					.gem.offset = offset + req_range,
+					.flags = va->flags,
 				};
 				struct drm_gpuva_op_unmap u = {
 					.va = va,
@@ -2480,6 +2486,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 				.va.range = ls_range,
 				.gem.obj = obj,
 				.gem.offset = offset,
+				.flags = va->flags,
 			};
 			struct drm_gpuva_op_unmap u = { .va = va };
 
@@ -2519,8 +2526,8 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.addr = req_end,
 					.va.range = end - req_end,
 					.gem.obj = obj,
-					.gem.offset = offset + ls_range +
-						      req_range,
+					.gem.offset = offset + ls_range + req_range,
+					.flags = va->flags,
 				};
 
 				ret = op_remap_cb(ops, priv, &p, &n, &u);
@@ -2554,6 +2561,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.range = end - req_end,
 					.gem.obj = obj,
 					.gem.offset = offset + req_end - addr,
+					.flags = va->flags,
 				};
 				struct drm_gpuva_op_unmap u = {
 					.va = va,
@@ -2605,6 +2613,7 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 			prev.va.range = req_addr - addr;
 			prev.gem.obj = obj;
 			prev.gem.offset = offset;
+			prev.flags = va->flags;
 
 			prev_split = true;
 		}
@@ -2614,6 +2623,7 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 			next.va.range = end - req_end;
 			next.gem.obj = obj;
 			next.gem.offset = offset + (req_end - addr);
+			next.flags = va->flags;
 
 			next_split = true;
 		}
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 6a6e64cd2cce..5bf37deb282d 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -63,6 +63,8 @@ enum drm_gpuva_flags {
 	DRM_GPUVA_USERBITS = (1 << 2),
 };
 
+#define VA_MERGE_MUST_MATCH_FLAGS (DRM_GPUVA_SPARSE)
+
 /**
  * struct drm_gpuva - structure to track a GPU VA mapping
  *
@@ -886,6 +888,11 @@ struct drm_gpuva_op_map {
 		 */
 		struct drm_gem_object *obj;
 	} gem;
+
+	/**
+	 * @flags: requested flags for the &drm_gpuva for this mapping
+	 */
+	enum drm_gpuva_flags flags;
 };
 
 /**
@@ -1124,6 +1131,7 @@ void drm_gpuva_ops_free(struct drm_gpuvm *gpuvm,
 static inline void drm_gpuva_init_from_op(struct drm_gpuva *va,
 					  const struct drm_gpuva_op_map *op)
 {
+	va->flags = op->flags;
 	va->va.addr = op->va.addr;
 	va->va.range = op->va.range;
 	va->gem.obj = op->gem.obj;
@@ -1249,6 +1257,16 @@ struct drm_gpuvm_ops {
 	 * used.
 	 */
 	int (*sm_step_unmap)(struct drm_gpuva_op *op, void *priv);
+
+	/**
+	 * @sm_can_merge_flags: called during &drm_gpuvm_sm_map
+	 *
+	 * This callback is called to determine whether two va ranges can be merged,
+	 * based on their flags.
+	 *
+	 * If NULL, va ranges can only be merged if their flags are equal.
+	 */
+	bool (*sm_can_merge_flags)(enum drm_gpuva_flags a, enum drm_gpuva_flags b);
 };
 
 int drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm, void *priv,
-- 
2.53.0

