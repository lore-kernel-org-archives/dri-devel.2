Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a9ccP/Vj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D9810EBF8;
	Tue, 24 Nov 2026 06:17:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9B310EA96;
 Tue, 24 Nov 2026 06:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501037; x=1827037037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=51tr6jt9IkWfRai0JQOldcKKo3rFwOTkkqlw7SqhmcQ=;
 b=a9ccP/VjrABntauD0N/k+G43PHZpU6O0MtuTdVz8zhfY7uPEOTCR4equ
 5Ey2Lf3hXldmVzDnxWBTV3Sh+vi+JbdueuRzWOI22kElgcqUQKjDPMKRJ
 7z9aA2GeZe9oGqV12VMAB8VvLdRRsEjc5I/bKoNmYuHUpb/6kyrUoD8d3
 Gte73jNd94C4XLpJg8l6PbvuUhnxiW8/szTD4ZccfqSI6lom1wZf293hW
 QAH39PzdsL4asHwMDKgIPC/tdWH7LIweAP3lFym5ieAV2R79wutxOI2R7
 UngA7egRhVjd93ztTVAtSWDh/MsPLE9BgrzZDZpShcR9XGAuZ1OZCamDq A==;
X-CSE-ConnectionGUID: s5mRLEcCSD+QlWQ+CAV2uA==
X-CSE-MsgGUID: ZmfmBUdGQ963WCSCcSItFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220094"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220094"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:17 -0800
X-CSE-ConnectionGUID: ACbKwXduSzaRg7nnt85m8A==
X-CSE-MsgGUID: PDeTiMYOTSW0J/W6UGzB1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264182"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:14 -0800
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
Subject: [RFC v2 09/11] drm/xe/uapi: Wire up GEM_CREATE mempolicy extension
 handler
Date: Tue, 24 Nov 2026 11:51:33 +0530
Message-ID: <20261124062123.2431244-22-himal.prasad.ghimiray@intel.com>
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

Parse the GEM_CREATE extensions once, before BO creation, into a
struct xe_gem_create_ext_data, so the host mempolicy is known when the
BO is created. The PXP key is still assigned after creation, as it
needs the BO.

DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY is handled by
gem_create_set_mempolicy(). It rejects an invalid mode, flags, or
nodemask bits, empty masks, nodes without memory, and PREFERRED masks
that do not contain exactly one node. BOs without a system memory
placement are rejected with -EINVAL.

v2:
- Parse all GEM_CREATE extensions once, before BO creation, through the
  existing extension tables instead of a separate parser (Matt Auld)

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 137 ++++++++++++++++++++++++++++++++-----
 1 file changed, 119 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 29fbcc1cbbed..a831dd4d7cad 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -3603,7 +3603,19 @@ void xe_bo_vunmap(struct xe_bo *bo)
 	__xe_bo_vunmap(bo);
 }
 
-static int gem_create_set_pxp_type(struct xe_device *xe, struct xe_bo *bo, u64 value)
+/* GEM_CREATE extension values, parsed before the BO is created */
+struct xe_gem_create_ext_data {
+	bool pxp_hwdrm;
+	/**
+	 * @mempolicy: Host NUMA policy, mode NONE unless the mempolicy
+	 * extension was set
+	 */
+	struct xe_host_mempolicy mempolicy;
+};
+
+static int gem_create_set_pxp_type(struct xe_device *xe,
+				   struct xe_gem_create_ext_data *data,
+				   u64 value)
 {
 	if (value == DRM_XE_PXP_TYPE_NONE)
 		return 0;
@@ -3612,11 +3624,13 @@ static int gem_create_set_pxp_type(struct xe_device *xe, struct xe_bo *bo, u64 v
 	if (XE_IOCTL_DBG(xe, value != DRM_XE_PXP_TYPE_HWDRM))
 		return -EINVAL;
 
-	return xe_pxp_key_assign(xe->pxp, bo);
+	data->pxp_hwdrm = true;
+
+	return 0;
 }
 
 typedef int (*xe_gem_create_set_property_fn)(struct xe_device *xe,
-					     struct xe_bo *bo,
+					     struct xe_gem_create_ext_data *data,
 					     u64 value);
 
 static const xe_gem_create_set_property_fn gem_create_set_property_funcs[] = {
@@ -3624,7 +3638,7 @@ static const xe_gem_create_set_property_fn gem_create_set_property_funcs[] = {
 };
 
 static int gem_create_user_ext_set_property(struct xe_device *xe,
-					    struct xe_bo *bo,
+					    struct xe_gem_create_ext_data *data,
 					    u64 extension)
 {
 	u64 __user *address = u64_to_user_ptr(extension);
@@ -3636,29 +3650,99 @@ static int gem_create_user_ext_set_property(struct xe_device *xe,
 	if (XE_IOCTL_DBG(xe, err))
 		return -EFAULT;
 
-	if (XE_IOCTL_DBG(xe, ext.property >=
-			 ARRAY_SIZE(gem_create_set_property_funcs)) ||
-	    XE_IOCTL_DBG(xe, ext.pad) ||
-	    XE_IOCTL_DBG(xe, ext.property != DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY))
+	if (XE_IOCTL_DBG(xe, ext.pad) ||
+	    XE_IOCTL_DBG(xe, ext.property >=
+			 ARRAY_SIZE(gem_create_set_property_funcs)))
 		return -EINVAL;
 
 	idx = array_index_nospec(ext.property, ARRAY_SIZE(gem_create_set_property_funcs));
 	if (!gem_create_set_property_funcs[idx])
 		return -EINVAL;
 
-	return gem_create_set_property_funcs[idx](xe, bo, ext.value);
+	return gem_create_set_property_funcs[idx](xe, data, ext.value);
+}
+
+static int gem_create_set_mempolicy(struct xe_device *xe,
+				    struct xe_gem_create_ext_data *data,
+				    u64 extension)
+{
+	u64 __user *address = u64_to_user_ptr(extension);
+	unsigned long words[BITS_TO_LONGS(MAX_NUMNODES)] = {};
+	struct drm_xe_gem_create_mempolicy ext;
+	enum ttm_numa_policy mode;
+	unsigned long nr_words;
+	nodemask_t nodes, missing;
+	int err;
+
+	err = copy_from_user(&ext, address, sizeof(ext));
+	if (XE_IOCTL_DBG(xe, err))
+		return -EFAULT;
+
+	if (XE_IOCTL_DBG(xe, ext.flags) || XE_IOCTL_DBG(xe, ext.pad))
+		return -EINVAL;
+
+	switch (ext.mode) {
+	case DRM_XE_GEM_CREATE_MEMPOLICY_MODE_PREFERRED:
+		mode = TTM_NUMA_POLICY_PREFERRED;
+		break;
+	case DRM_XE_GEM_CREATE_MEMPOLICY_MODE_BIND:
+		mode = TTM_NUMA_POLICY_BIND;
+		break;
+	case DRM_XE_GEM_CREATE_MEMPOLICY_MODE_INTERLEAVE:
+		mode = TTM_NUMA_POLICY_INTERLEAVE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (XE_IOCTL_DBG(xe, !ext.maxnode || ext.maxnode > MAX_NUMNODES))
+		return -EINVAL;
+
+	nr_words = BITS_TO_LONGS(ext.maxnode);
+	err = copy_from_user(words, u64_to_user_ptr(ext.nodemask),
+			     nr_words * sizeof(unsigned long));
+	if (XE_IOCTL_DBG(xe, err))
+		return -EFAULT;
+
+	/* Bits at or above maxnode must be clear */
+	if (XE_IOCTL_DBG(xe, find_next_bit(words, nr_words * BITS_PER_LONG,
+					   ext.maxnode) <
+			 nr_words * BITS_PER_LONG))
+		return -EINVAL;
+
+	nodes_clear(nodes);
+	bitmap_copy(nodes.bits, words, ext.maxnode);
+
+	if (XE_IOCTL_DBG(xe, nodes_empty(nodes)))
+		return -EINVAL;
+
+	/* Only nodes with memory can back the pages */
+	nodes_andnot(missing, nodes, node_states[N_MEMORY]);
+	if (XE_IOCTL_DBG(xe, !nodes_empty(missing)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, mode == TTM_NUMA_POLICY_PREFERRED &&
+			 nodes_weight(nodes) != 1))
+		return -EINVAL;
+
+	data->mempolicy.mode = mode;
+	data->mempolicy.nodes = nodes;
+
+	return 0;
 }
 
 typedef int (*xe_gem_create_user_extension_fn)(struct xe_device *xe,
-					       struct xe_bo *bo,
+					       struct xe_gem_create_ext_data *data,
 					       u64 extension);
 
 static const xe_gem_create_user_extension_fn gem_create_user_extension_funcs[] = {
 	[DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY] = gem_create_user_ext_set_property,
+	[DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY] = gem_create_set_mempolicy,
 };
 
 #define MAX_USER_EXTENSIONS	16
-static int gem_create_user_extensions(struct xe_device *xe, struct xe_bo *bo,
+static int gem_create_user_extensions(struct xe_device *xe,
+				      struct xe_gem_create_ext_data *data,
 				      u64 extensions, int ext_number)
 {
 	u64 __user *address = u64_to_user_ptr(extensions);
@@ -3679,12 +3763,12 @@ static int gem_create_user_extensions(struct xe_device *xe, struct xe_bo *bo,
 
 	idx = array_index_nospec(ext.name,
 				 ARRAY_SIZE(gem_create_user_extension_funcs));
-	err = gem_create_user_extension_funcs[idx](xe, bo, extensions);
+	err = gem_create_user_extension_funcs[idx](xe, data, extensions);
 	if (XE_IOCTL_DBG(xe, err))
 		return err;
 
 	if (ext.next_extension)
-		return gem_create_user_extensions(xe, bo, ext.next_extension,
+		return gem_create_user_extensions(xe, data, ext.next_extension,
 						  ++ext_number);
 
 	return 0;
@@ -3696,11 +3780,13 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	struct xe_device *xe = to_xe_device(dev);
 	struct xe_file *xef = to_xe_file(file);
 	struct drm_xe_gem_create *args = data;
+	struct xe_gem_create_ext_data ext_data = {};
 	struct xe_validation_ctx ctx;
 	struct drm_exec exec;
 	struct xe_vm *vm = NULL;
 	struct xe_bo *bo;
 	unsigned int bo_flags;
+	const struct xe_host_mempolicy *mpol = NULL;
 	u32 handle;
 	int err;
 
@@ -3776,6 +3862,20 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			 args->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB))
 		return -EINVAL;
 
+	if (args->extensions) {
+		err = gem_create_user_extensions(xe, &ext_data,
+						 args->extensions, 0);
+		if (err)
+			return err;
+	}
+
+	if (XE_IOCTL_DBG(xe, ext_data.mempolicy.mode != TTM_NUMA_POLICY_NONE &&
+			 !(bo_flags & XE_BO_FLAG_SYSTEM)))
+		return -EINVAL;
+
+	if (ext_data.mempolicy.mode != TTM_NUMA_POLICY_NONE)
+		mpol = &ext_data.mempolicy;
+
 	if (args->vm_id) {
 		vm = xe_vm_lookup(xef, args->vm_id);
 		if (XE_IOCTL_DBG(xe, !vm))
@@ -3791,8 +3891,9 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			if (err)
 				break;
 		}
-		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
-				       bo_flags, NULL, &exec);
+		bo = xe_bo_create_user(xe, vm, args->size,
+				       args->cpu_caching, bo_flags,
+				       mpol, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			err = PTR_ERR(bo);
@@ -3803,9 +3904,9 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (err)
 		goto out_vm;
 
-	if (args->extensions) {
-		err = gem_create_user_extensions(xe, bo, args->extensions, 0);
-		if (err)
+	if (ext_data.pxp_hwdrm) {
+		err = xe_pxp_key_assign(xe->pxp, bo);
+		if (XE_IOCTL_DBG(xe, err))
 			goto out_bulk;
 	}
 
-- 
2.43.0

