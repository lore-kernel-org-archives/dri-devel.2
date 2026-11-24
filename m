Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DxZXwpDd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01D810EC11;
	Tue, 24 Nov 2026 06:17:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E36E10E7D5;
 Tue, 24 Nov 2026 06:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501031; x=1827037031;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VTer7Z7ayDa0ppO49ohLNoQWEJby028lXjpKf0VVENg=;
 b=DxZXwpDdyS+LnVi5MJZnMlmZFd5BmW90Cckr+P7tROJhLrAk8CKN+bIw
 IiMJ5fY2cIGdFh/pC4zGbejjiRxfz2V0Srs1cxYFqF+zv+HxG4fAo4+4P
 /dB0+GwomlSVfJ2XMJIRshiVJ4vLy2PeDelyVN06k4rLRmJFZl9lVGa6v
 lGNDDJQj/vvGBv/OU+9BMq0j8XCP2Yy6AWny5w2eLLUVBCkZ7PCrPGuxY
 ROXMGRO3Q6EeoVVn9pIEyFh9Pd09murg/5fEi56lmvlPuCK0MQuXPlk4t
 d3thucXhiquO9Gkkla19nzcA/vSihqWnwnaNQ7+SlY4QKfX5p8UqtlNm0 g==;
X-CSE-ConnectionGUID: rby0P6PERTiXPS6sE31KBA==
X-CSE-MsgGUID: 5WFBhpsASxWWFmB8lHJ5Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220078"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220078"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:10 -0800
X-CSE-ConnectionGUID: NKNSmbrVQD6oExkT2F3C3A==
X-CSE-MsgGUID: pmn17w0oTEuReGh6/Tv5lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264159"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:07 -0800
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
Subject: [RFC v2 07/11] drm/xe/uapi: Add GEM_CREATE host NUMA mempolicy
 extension
Date: Tue, 24 Nov 2026 11:51:31 +0530
Message-ID: <20261124062123.2431244-20-himal.prasad.ghimiray@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY and struct
drm_xe_gem_create_mempolicy so userspace can request a PREFERRED, BIND or
INTERLEAVE host NUMA policy for the system memory backing pages of a BO.

The extension is only valid for BOs with system memory placement; the
ioctl returns -EINVAL for other BOs.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 include/uapi/drm/xe_drm.h | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 578f0c1eb43e..8818ed57b153 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -777,6 +777,53 @@ struct drm_xe_device_query {
 	__u64 reserved[2];
 };
 
+/**
+ * struct drm_xe_gem_create_mempolicy - Host NUMA memory policy for GEM_CREATE
+ *
+ * Used with %DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY. The policy applies to
+ * the system-memory backing pages of the object. It is captured at creation
+ * time and applied whenever those pages are allocated, including when the
+ * object is populated later or restored after its backing store was shrunk.
+ *
+ * @mode supports the following values:
+ *  - %DRM_XE_GEM_CREATE_MEMPOLICY_MODE_PREFERRED - Prefer a single node.
+ *    @nodemask must contain exactly one node. This is a preference, and the
+ *    allocation may fall back to other nodes under memory pressure.
+ *  - %DRM_XE_GEM_CREATE_MEMPOLICY_MODE_BIND - Allocate only from the nodes
+ *    in @nodemask. The kernel never falls back to a node outside the mask,
+ *    so allocation fails with -ENOMEM when those nodes are exhausted.
+ *  - %DRM_XE_GEM_CREATE_MEMPOLICY_MODE_INTERLEAVE - Spread the backing pages
+ *    round-robin across the nodes in @nodemask.
+ *
+ * @nodemask is a user pointer to an array of unsigned longs. Bit n set means
+ * host NUMA node n is in the set. @maxnode is the number of valid bits in the
+ * array, and bits at or above @maxnode must be zero. The set must be non-empty
+ * and contain only nodes that have memory. Requesting this extension on an
+ * object without a system-memory placement is rejected with -EINVAL.
+ */
+struct drm_xe_gem_create_mempolicy {
+	/** @base: Base user extension */
+	struct drm_xe_user_extension base;
+
+#define DRM_XE_GEM_CREATE_MEMPOLICY_MODE_PREFERRED	0
+#define DRM_XE_GEM_CREATE_MEMPOLICY_MODE_BIND		1
+#define DRM_XE_GEM_CREATE_MEMPOLICY_MODE_INTERLEAVE	2
+	/** @mode: One of %DRM_XE_GEM_CREATE_MEMPOLICY_MODE_* */
+	__u16 mode;
+
+	/** @flags: MBZ */
+	__u16 flags;
+
+	/** @pad: MBZ */
+	__u32 pad;
+
+	/** @nodemask: User pointer to the host NUMA node bitmask */
+	__u64 nodemask;
+
+	/** @maxnode: Number of valid bits in @nodemask, at most MAX_NUMNODES */
+	__u64 maxnode;
+};
+
 /**
  * struct drm_xe_gem_create - Input of &DRM_IOCTL_XE_GEM_CREATE - A structure for
  * gem creation
@@ -839,8 +886,14 @@ struct drm_xe_device_query {
  *    event occurs after their creation. Attempting to flip an invalid object
  *    will cause a black frame to be displayed instead. Submissions with invalid
  *    objects mapped in the VM will be rejected.
+ *
+ * This ioctl also accepts the %DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY
+ * extension, which uses &struct drm_xe_gem_create_mempolicy to request a
+ * host NUMA memory policy (preferred, bind or interleave) for the backing
+ * pages.
  */
 struct drm_xe_gem_create {
+#define DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY	1
 #define DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY	0
 #define   DRM_XE_GEM_CREATE_SET_PROPERTY_PXP_TYPE	0
 	/** @extensions: Pointer to the first extension struct, if any */
-- 
2.43.0

