Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA8606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VAlz5RyR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E852B10EC6B;
	Tue, 24 Nov 2026 06:17:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAE910EBF8;
 Tue, 24 Nov 2026 06:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501040; x=1827037040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=adCy1jK5yqmR3TMJKMO9ynZEJiTQc2odQTrlAcjag4s=;
 b=VAlz5RyRWnWSFThG715FrNVg5tqv+RpqBJ3wZ6sTWul4JT5K0/+1erNP
 cOaE9v1S+94Z+cKj+sH7CnGOOY9oG0egmaiODMyvX0s9BgQtha/KJwk/V
 DKffyoMM0DwvZtsyg5PClc5CuaMR8ssE/yNUecLf/qhwKN/D1DvjozX6O
 PVXCVNfmAewZ7OsEZxDCl1jAgJLeJKV3pDph3U3JujL591jtn24DlaPAP
 81JAzrgsgQ+ZnxnRkvxzNyTgNHAPwXtEN8C+9Z/diKNZHK5Oqde/m8EB/
 MaRFB/S3BrvSiQIGdyN/jZ8f0EsoxS15CJAM7q+vw9Yrl8tqLgxLe7/0g A==;
X-CSE-ConnectionGUID: oChjZ/8/T9299n1/NdlEpw==
X-CSE-MsgGUID: W00Z3o7bRZmmJ1FE+DDfJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220098"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220098"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:20 -0800
X-CSE-ConnectionGUID: k98ro3YJR46XgSBWC7/MIA==
X-CSE-MsgGUID: FLB2DYurQmGzmIs/2Na+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264193"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:17:17 -0800
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
Subject: [RFC v2 10/11] drm/xe/uapi: Add device query for supported host NUMA
 mempolicy modes
Date: Tue, 24 Nov 2026 11:51:34 +0530
Message-ID: <20261124062123.2431244-23-himal.prasad.ghimiray@intel.com>
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

Add DRM_XE_DEVICE_QUERY_MEMPOLICY and struct drm_xe_query_mempolicy so
userspace can discover which DRM_XE_GEM_CREATE_MEMPOLICY_MODE_* values
the driver accepts in DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY before
creating a BO.

The reply carries a bitmask where bit n set means mode value n is
supported. Requesting an unsupported mode fails with -EOPNOTSUPP. A
kernel without the query returns -EINVAL for it, which userspace can
treat as the extension being unavailable.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 include/uapi/drm/xe_drm.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 8818ed57b153..1db3202c4518 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -710,6 +710,7 @@ struct drm_xe_query_pxp_status {
  *  - %DRM_XE_DEVICE_QUERY_OA_UNITS
  *  - %DRM_XE_DEVICE_QUERY_PXP_STATUS
  *  - %DRM_XE_DEVICE_QUERY_EU_STALL
+ *  - %DRM_XE_DEVICE_QUERY_MEMPOLICY
  *
  * If size is set to 0, the driver fills it with the required size for
  * the requested type of data to query. If size is equal to the required
@@ -764,6 +765,7 @@ struct drm_xe_device_query {
 #define DRM_XE_DEVICE_QUERY_OA_UNITS		8
 #define DRM_XE_DEVICE_QUERY_PXP_STATUS		9
 #define DRM_XE_DEVICE_QUERY_EU_STALL		10
+#define DRM_XE_DEVICE_QUERY_MEMPOLICY		11
 	/** @query: The type of data to query */
 	__u32 query;
 
@@ -824,6 +826,30 @@ struct drm_xe_gem_create_mempolicy {
 	__u64 maxnode;
 };
 
+/**
+ * struct drm_xe_query_mempolicy - Host NUMA mempolicy capabilities
+ *
+ * If the query field of struct drm_xe_device_query is equal to
+ * %DRM_XE_DEVICE_QUERY_MEMPOLICY, then the reply uses this structure. It
+ * reports which modes of %DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY the
+ * driver supports. Requesting an unsupported mode fails with -EOPNOTSUPP.
+ * A kernel without this query returns -EINVAL for it and does not support
+ * the extension.
+ */
+struct drm_xe_query_mempolicy {
+	/**
+	 * @supported_modes: Bitmask of supported modes, bit n set means
+	 * %DRM_XE_GEM_CREATE_MEMPOLICY_MODE_* value n is supported
+	 */
+	__u32 supported_modes;
+
+	/** @pad: MBZ */
+	__u32 pad;
+
+	/** @reserved: Reserved */
+	__u64 reserved[3];
+};
+
 /**
  * struct drm_xe_gem_create - Input of &DRM_IOCTL_XE_GEM_CREATE - A structure for
  * gem creation
-- 
2.43.0

