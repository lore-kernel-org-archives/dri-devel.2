Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239FF105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D9110E15E;
	Fri, 13 Mar 2026 15:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Jxz98mVH";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835B010E15E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414670; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OZ3UDp3ta/xBN/7ZS9cb24wivCzqQ35kOPOrg/uvTN1zET9MP2RQ8Z18m3puOqbKK2NjAhw0N2HTIcTNYvQEsQchW2QgKd0h9MqiAbxHUQ4e8Sc9VN2qZkz+IrrBeCKJ7hZfP31pccCGxlK7FnVTLl841guWi8UtyNEv375Unio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414670;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qvk09IecOrbewxeKSJE5mX77yqFCG/p3pQX91Tx/WqQ=; 
 b=Hlq9Z7UTwaTijzpBbLD37zCRekKFgVXPLqLOXTlCSjgqlQwbCS6bd3N9f3EV+O7bvyxCG457xfoRgP6c5kf8sen/OMzRmz7FQdcvzcNMfXAQChs/OZJogAQHlfY5Izqr8WsRM/ZY2wDfuzznOOFvecSBsu5u6kuTsx5AOluDy+Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414670; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=qvk09IecOrbewxeKSJE5mX77yqFCG/p3pQX91Tx/WqQ=;
 b=Jxz98mVHVfMTnYBi9W7j7iTeWsOYwcH4Jg9IxIWVdeltDu17azGLs6eOkypkA47d
 T+FFsh2HNHKHCQd9K55nTPrM6M6hrBg5L7ITCaPgw0DqbCKmxqPz+CPB4QgtIC8Kbg7
 SEL9sh60g/Jh4v0fN+oPWxCSNVjmq/gkVf9vd/Q8=
Received: by mx.zohomail.com with SMTPS id 17734146689121012.9497793163894;
 Fri, 13 Mar 2026 08:11:08 -0700 (PDT)
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
Subject: [PATCH v5 06/11] drm/gpuvm: Add DRM_GPUVA_REPEAT flag and logic
Date: Fri, 13 Mar 2026 15:09:43 +0000
Message-ID: <20260313150956.1618635-7-adrian.larumbe@collabora.com>
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

To be able to support "fake sparse" mappings without relying on GPU page
fault handling, drivers may need to create large (e.g. 4GiB) mappings of
the same page repeatedly (or same range of pages). Doing this through
individual mappings would be very wasteful. This can be handled better
by using a flag on map creation, but to do it safely, drm_gpuvm needs to
be aware of this special case.

Add a flag that signals that a given mapping is a page mapping, which is
repeated all over the entire requested VA range. This tweaks the
sm_map() logic to treat the GEM offsets differently when mappings are
a repeated ones so they are not incremented as they would be with regular
mappings.

The size of the GEM portion to repeat is passed through
drm_gpuva::gem::range. Most of the time it will be a page size, but
it can be bigger as long as it's less than drm_gpuva::va::range, and
drm_gpuva::va::range is a multiple of drm_gpuva::gem::range.

Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 67 ++++++++++++++++++++++++++++++++++---
 include/drm/drm_gpuvm.h     | 35 ++++++++++++++++++-
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 0d9c821d1b34..ca7445f767fc 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2340,6 +2340,8 @@ op_map_cb(const struct drm_gpuvm_ops *fn, void *priv,
 	op.map.va.range = req->map.va.range;
 	op.map.gem.obj = req->map.gem.obj;
 	op.map.gem.offset = req->map.gem.offset;
+	op.map.gem.repeat_range = req->map.gem.repeat_range;
+	op.map.flags = req->map.flags;
 
 	return fn->sm_step_map(&op, priv);
 }
@@ -2410,12 +2412,56 @@ static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *va,
 	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
 		return false;
 
+	if (a->flags & DRM_GPUVA_REPEAT) {
+		u64 va_diff = b->va.addr - a->va.addr;
+
+		/* If this is a repeated mapping, both the GEM range
+		 * and offset must match.
+		 */
+		if (a->gem.repeat_range != b->gem.repeat_range ||
+		    a->gem.offset != b->gem.offset)
+			return false;
+
+		/* The difference between the VA addresses must be a
+		 * multiple of the repeated range, otherwise there's
+		 * a shift.
+		 */
+		if (do_div(va_diff, a->gem.repeat_range))
+			return false;
+
+		return true;
+	}
+
 	/* We intentionally ignore u64 underflows because all we care about
 	 * here is whether the VA diff matches the GEM offset diff.
 	 */
 	return b->va.addr - a->va.addr == b->gem.offset - a->gem.offset;
 }
 
+static int validate_map_request(struct drm_gpuvm *gpuvm,
+				const struct drm_gpuva_op_map *op)
+{
+	if (unlikely(!drm_gpuvm_range_valid(gpuvm, op->va.addr, op->va.range)))
+		return -EINVAL;
+
+	if (op->flags & DRM_GPUVA_REPEAT) {
+		u64 va_range = op->va.range;
+
+		/* For a repeated mapping, GEM range must be > 0
+		 * and a multiple of the VA range.
+		 */
+		if (unlikely(!op->gem.repeat_range ||
+			     va_range < op->gem.repeat_range ||
+			     do_div(va_range, op->gem.repeat_range)))
+			return -EINVAL;
+	}
+
+	if (op->flags & DRM_GPUVA_INVALIDATED)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		   const struct drm_gpuvm_ops *ops, void *priv,
@@ -2429,7 +2475,8 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 	u64 req_end = req_addr + req_range;
 	int ret;
 
-	if (unlikely(!drm_gpuvm_range_valid(gpuvm, req_addr, req_range)))
+	ret = validate_map_request(gpuvm, &req->map);
+	if (unlikely(ret))
 		return -EINVAL;
 
 	drm_gpuvm_for_each_va_range_safe(va, next, gpuvm, req_addr, req_end) {
@@ -2463,7 +2510,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.addr = req_end,
 					.va.range = range - req_range,
 					.gem.obj = obj,
-					.gem.offset = offset + req_range,
+					.gem.repeat_range = va->gem.repeat_range,
+					.gem.offset = offset +
+						(va->flags & DRM_GPUVA_REPEAT ? 0 : req_range),
 					.flags = va->flags,
 				};
 				struct drm_gpuva_op_unmap u = {
@@ -2485,6 +2534,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 				.va.addr = addr,
 				.va.range = ls_range,
 				.gem.obj = obj,
+				.gem.repeat_range = va->gem.repeat_range,
 				.gem.offset = offset,
 				.flags = va->flags,
 			};
@@ -2526,7 +2576,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.addr = req_end,
 					.va.range = end - req_end,
 					.gem.obj = obj,
-					.gem.offset = offset + ls_range + req_range,
+					.gem.repeat_range = va->gem.repeat_range,
+					.gem.offset = offset + (va->flags & DRM_GPUVA_REPEAT ?
+								0 : ls_range + req_range),
 					.flags = va->flags,
 				};
 
@@ -2560,7 +2612,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.addr = req_end,
 					.va.range = end - req_end,
 					.gem.obj = obj,
-					.gem.offset = offset + req_end - addr,
+					.gem.repeat_range = va->gem.repeat_range,
+					.gem.offset = offset +
+						(va->flags & DRM_GPUVA_REPEAT ? 0 : req_end - addr),
 					.flags = va->flags,
 				};
 				struct drm_gpuva_op_unmap u = {
@@ -2612,6 +2666,7 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 			prev.va.addr = addr;
 			prev.va.range = req_addr - addr;
 			prev.gem.obj = obj;
+			prev.gem.repeat_range = va->gem.repeat_range;
 			prev.gem.offset = offset;
 			prev.flags = va->flags;
 
@@ -2622,7 +2677,9 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 			next.va.addr = req_end;
 			next.va.range = end - req_end;
 			next.gem.obj = obj;
-			next.gem.offset = offset + (req_end - addr);
+			next.gem.repeat_range = va->gem.repeat_range;
+			next.gem.offset = offset +
+				(va->flags & DRM_GPUVA_REPEAT ? 0 : req_end - addr);
 			next.flags = va->flags;
 
 			next_split = true;
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 5bf37deb282d..cd2f55bc1707 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -57,10 +57,19 @@ enum drm_gpuva_flags {
 	 */
 	DRM_GPUVA_SPARSE = (1 << 1),
 
+	/**
+	 * @DRM_GPUVA_REPEAT:
+	 *
+	 * Flag indicating that the &drm_gpuva is a mapping of a GEM
+	 * object with a certain range that is repeated multiple times to
+	 * fill the virtual address range.
+	 */
+	DRM_GPUVA_REPEAT = (1 << 2),
+
 	/**
 	 * @DRM_GPUVA_USERBITS: user defined bits
 	 */
-	DRM_GPUVA_USERBITS = (1 << 2),
+	DRM_GPUVA_USERBITS = (1 << 3),
 };
 
 #define VA_MERGE_MUST_MATCH_FLAGS (DRM_GPUVA_SPARSE)
@@ -114,6 +123,18 @@ struct drm_gpuva {
 		 */
 		u64 offset;
 
+		/**
+		 * @gem.repeat_range: the range of the GEM that is mapped
+		 *
+		 * When dealing with normal mappings, this must be zero.
+		 * When flags has DRM_GPUVA_REPEAT set, this field must be
+		 * smaller than va.range and va.range must be a multiple of
+		 * gem.repeat_range.
+		 * This is a u32 not a u64 because we expect repeated mappings
+		 * to be pointing to relatively small portions of a GEM object.
+		 */
+		u32 repeat_range;
+
 		/**
 		 * @gem.obj: the mapped &drm_gem_object
 		 */
@@ -883,6 +904,17 @@ struct drm_gpuva_op_map {
 		 */
 		u64 offset;
 
+		/**
+		 * @gem.repeat_range: the range of the GEM that is mapped
+		 *
+		 * When dealing with normal mappings, this must be zero.
+		 * When flags has DRM_GPUVA_REPEAT set, va.range must be
+		 * a multiple of gem.repeat_range. This is a u32 not a u64
+		 * because we expect repeated mappings to be pointing to
+		 * a relatively small portion of a GEM object.
+		 */
+		u32 repeat_range;
+
 		/**
 		 * @gem.obj: the &drm_gem_object to map
 		 */
@@ -1136,6 +1168,7 @@ static inline void drm_gpuva_init_from_op(struct drm_gpuva *va,
 	va->va.range = op->va.range;
 	va->gem.obj = op->gem.obj;
 	va->gem.offset = op->gem.offset;
+	va->gem.repeat_range = op->gem.repeat_range;
 }
 
 /**
-- 
2.53.0

