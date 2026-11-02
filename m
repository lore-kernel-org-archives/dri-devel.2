Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED2606A331
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GUUJLxKt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640B710ECAD;
	Mon,  2 Nov 2026 10:14:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3891E10ECA7;
 Mon,  2 Nov 2026 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614449; x=1825150449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7IpDwJmRTdw3XSPox/I433wtrgCa+9htsBCkbyO2Ov4=;
 b=GUUJLxKtoIXjmA2L879ccbTIv+U8b89gcD41hKioUuP9Fet7KabYVvGz
 8u9r+5pag/xe1WUK55WV5mAFLxGy4b5QOEVGHYYAfCbszr3nCR/4LpWL3
 knczpGEdMODfegx1QEzzfmLYi1mIVyOfX26WPybquS4FjjHDjxJewrgMB
 c4gCnt0puaNmjHBEHjklgYEudk9wYwxyDwCFczVRRYQpUYElZ2i56RZIY
 DAAoKC0xZpL3bl8riYN/1ArmfoGchncHqRVCt0aY3dif8T6e7L+aXOX1r
 hGQMXDgsMRUVogt+VQARx+NO9h0R8xsVnZ5fvF8QX8v0wRyCsdZUCwbqF w==;
X-CSE-ConnectionGUID: 6CwNLIzmQHG5gXX78aXBtQ==
X-CSE-MsgGUID: s4Y+zvXzSIqJlDjWvVfbcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200821"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200821"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:14:09 -0800
X-CSE-ConnectionGUID: 1G6NGygHQ62Re55z1Sjdpw==
X-CSE-MsgGUID: 3rE2n2UcTR62Ef+dSCzY6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002803"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:14:06 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 6/7] drm/xe/uapi: Add GEM_CREATE NUMA node placement property
Date: Mon,  2 Nov 2026 15:48:10 +0530
Message-ID: <20261102101803.455921-15-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
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

Add DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE so userspace can choose
the host NUMA node backing a system memory BO. A negative value keeps
the default device-local placement.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 include/uapi/drm/xe_drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 578f0c1eb43e..0b39081330ee 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -843,6 +843,13 @@ struct drm_xe_device_query {
 struct drm_xe_gem_create {
 #define DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY	0
 #define   DRM_XE_GEM_CREATE_SET_PROPERTY_PXP_TYPE	0
+	/*
+	 * Host NUMA node (as a signed value) to allocate system-memory
+	 * backing pages from. Only honored for objects with a system-memory
+	 * placement; ignored for VRAM-only objects. Use a value < 0 to keep
+	 * the default device-local placement.
+	 */
+#define   DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE	1
 	/** @extensions: Pointer to the first extension struct, if any */
 	__u64 extensions;
 
-- 
2.43.0

