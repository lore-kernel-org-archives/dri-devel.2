Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B93606A331
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YTxCloex
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480D510EC4D;
	Tue, 24 Nov 2026 06:17:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A0C10EC5F;
 Tue, 24 Nov 2026 06:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501043; x=1827037043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=It6dJtsz9CITSl8dhImikKy8rYbk1Il9CvDb/LbkWvA=;
 b=YTxCloexlt08NyfCnanfdX9HnQJs82Ilwk/WOfIb6xwdSxxPQuAIy0DT
 23p4tMuP3gyMReN5FJJP7BYxjJLvXz/Bxqgua6w0o38rp/PUVSeztU+qq
 9wd0JQi7JR4xIjmEbx7wGiBEZXMZgT4i1F+t+p+0VuqOhaQYTUNd/mANP
 JGmspIbCfwQScMbeBVHZkgrVvFw83nTaua/+s8+8mryyVmJie9b/RGC8a
 h3bN4UXj78xFFyA788P8lAOBug9ywUi7w2SoANdcTUOkhlNQYJSOLX7Rb
 3ewgLp3GJPCKvxjboyXKFwBj/TNQYd/ysVc+vwLfbn1jIx4Jf3diqoS8X w==;
X-CSE-ConnectionGUID: 4VJkRr6FQB6TrO5gM7qScA==
X-CSE-MsgGUID: LsBWuaTnRx6hXsX8XD/E/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220102"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:23 -0800
X-CSE-ConnectionGUID: EuewtoVBTMu+6KIpQB27OQ==
X-CSE-MsgGUID: UCIOtt8CR3emdObaj8+lqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264205"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:20 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: Natalie Vock <natalie.vock@gmx.de>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC v2 11/11] drm/xe: Implement the host NUMA mempolicy device query
Date: Tue, 24 Nov 2026 11:51:35 +0530
Message-ID: <20261124062123.2431244-24-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
References: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add xe_bo_mempolicy_modes(), which returns the
DRM_XE_GEM_CREATE_MEMPOLICY_MODE_* values the device can apply. TTM only
applies NUMA placement when the pool does not use DMA allocation, so
report no modes in that case.

Use it to answer DRM_XE_DEVICE_QUERY_MEMPOLICY, and to reject a
GEM_CREATE mempolicy whose mode is not supported with -EOPNOTSUPP,
matching the query, instead of letting BO creation succeed and the
populate fail later.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c    | 49 ++++++++++++++++++++++++++---------
 drivers/gpu/drm/xe/xe_bo.h    |  1 +
 drivers/gpu/drm/xe/xe_query.c | 23 ++++++++++++++++
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index a831dd4d7cad..58ec0c8a3bd0 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -3662,6 +3662,36 @@ static int gem_create_user_ext_set_property(struct xe_device *xe,
 	return gem_create_set_property_funcs[idx](xe, data, ext.value);
 }
 
+/* Modes left as TTM_NUMA_POLICY_NONE are not supported */
+static const enum ttm_numa_policy xe_mempolicy_to_ttm[] = {
+	[DRM_XE_GEM_CREATE_MEMPOLICY_MODE_PREFERRED] = TTM_NUMA_POLICY_PREFERRED,
+	[DRM_XE_GEM_CREATE_MEMPOLICY_MODE_BIND] = TTM_NUMA_POLICY_BIND,
+	[DRM_XE_GEM_CREATE_MEMPOLICY_MODE_INTERLEAVE] = TTM_NUMA_POLICY_INTERLEAVE,
+};
+
+/**
+ * xe_bo_mempolicy_modes() - Host NUMA mempolicy modes supported by the device
+ * @xe: The xe device.
+ *
+ * Return: Bitmask of BIT(%DRM_XE_GEM_CREATE_MEMPOLICY_MODE_*) values that
+ * %DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY accepts.
+ */
+u32 xe_bo_mempolicy_modes(struct xe_device *xe)
+{
+	u32 modes = 0;
+	int i;
+
+	/* TTM cannot apply NUMA placement to DMA-allocated pools */
+	if (xe->ttm.pool.alloc_flags & TTM_ALLOCATION_POOL_USE_DMA_ALLOC)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(xe_mempolicy_to_ttm); i++)
+		if (xe_mempolicy_to_ttm[i] != TTM_NUMA_POLICY_NONE)
+			modes |= BIT(i);
+
+	return modes;
+}
+
 static int gem_create_set_mempolicy(struct xe_device *xe,
 				    struct xe_gem_create_ext_data *data,
 				    u64 extension)
@@ -3681,19 +3711,14 @@ static int gem_create_set_mempolicy(struct xe_device *xe,
 	if (XE_IOCTL_DBG(xe, ext.flags) || XE_IOCTL_DBG(xe, ext.pad))
 		return -EINVAL;
 
-	switch (ext.mode) {
-	case DRM_XE_GEM_CREATE_MEMPOLICY_MODE_PREFERRED:
-		mode = TTM_NUMA_POLICY_PREFERRED;
-		break;
-	case DRM_XE_GEM_CREATE_MEMPOLICY_MODE_BIND:
-		mode = TTM_NUMA_POLICY_BIND;
-		break;
-	case DRM_XE_GEM_CREATE_MEMPOLICY_MODE_INTERLEAVE:
-		mode = TTM_NUMA_POLICY_INTERLEAVE;
-		break;
-	default:
+	if (XE_IOCTL_DBG(xe, ext.mode >= ARRAY_SIZE(xe_mempolicy_to_ttm)))
 		return -EINVAL;
-	}
+
+	if (XE_IOCTL_DBG(xe, !(xe_bo_mempolicy_modes(xe) & BIT(ext.mode))))
+		return -EOPNOTSUPP;
+
+	mode = xe_mempolicy_to_ttm[array_index_nospec(ext.mode,
+						      ARRAY_SIZE(xe_mempolicy_to_ttm))];
 
 	if (XE_IOCTL_DBG(xe, !ext.maxnode || ext.maxnode > MAX_NUMNODES))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 4b2c17bb0f9c..e46a5c861465 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -454,6 +454,7 @@ extern const char *const xe_mem_type_to_name[];
 
 int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file);
+u32 xe_bo_mempolicy_modes(struct xe_device *xe);
 int xe_gem_mmap_offset_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
 void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo);
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 9cc35fc83954..f635ffa14e7b 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -788,6 +788,28 @@ static int query_eu_stall(struct xe_device *xe,
 	return ret ? -EFAULT : 0;
 }
 
+static int query_mempolicy(struct xe_device *xe,
+			   struct drm_xe_device_query *query)
+{
+	struct drm_xe_query_mempolicy __user *query_ptr = u64_to_user_ptr(query->data);
+	size_t size = sizeof(struct drm_xe_query_mempolicy);
+	struct drm_xe_query_mempolicy resp = {};
+
+	if (query->size == 0) {
+		query->size = size;
+		return 0;
+	} else if (XE_IOCTL_DBG(xe, query->size != size)) {
+		return -EINVAL;
+	}
+
+	resp.supported_modes = xe_bo_mempolicy_modes(xe);
+
+	if (copy_to_user(query_ptr, &resp, size))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int (* const xe_query_funcs[])(struct xe_device *xe,
 				      struct drm_xe_device_query *query) = {
 	query_engines,
@@ -801,6 +823,7 @@ static int (* const xe_query_funcs[])(struct xe_device *xe,
 	query_oa_units,
 	query_pxp_status,
 	query_eu_stall,
+	query_mempolicy,
 };
 
 int xe_query_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
-- 
2.43.0

