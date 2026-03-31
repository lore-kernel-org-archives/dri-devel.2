Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15E7FF60F6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFAF10E998;
	Tue, 31 Mar 2026 09:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zxg6PLo/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2003910E997;
 Tue, 31 Mar 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774947965; x=1806483965;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=qnRRtne5gspPSLbvOe1OG+a9Kb5Rkdq52jazPl5pXjg=;
 b=Zxg6PLo/aWt0bR7b7RDBoggFyQ9R5kLDpIUnkzbcCmjrYLLLcV2gpiVl
 bc7weAgQy/ljXxolushG7CEwa59/uH5WrVYeL1rx+bGy0Ql1uShT2eVKC
 EEKklgBe2ZjTUZenEG77WXYxB/Z+Tq1OVrVTvEc/0ra2l1lfPwj9OsHzq
 ZbRCF8JAdZV01K7W0zOeOa5XHxvixe3gOVKVQWi4WWqPZprng7VaWWLlw
 D5LrdwLLNhpArfBmMRwHIfadF31VmGc4LuGciGjOLFSj5SvPAh14k1QS8
 0LLUBmuYlS8gbHxdgkRhZD2L/IU9PHO71Q5Glb1wOxPwaPQGr6r7cDdxv A==;
X-CSE-ConnectionGUID: cfIyuGaXQUenjDwwiGZsZQ==
X-CSE-MsgGUID: lXm2dbZIRFed6qfsDo92ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87420605"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87420605"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:06:05 -0700
X-CSE-ConnectionGUID: sW6K7L+kTESVB5s9YOKxrw==
X-CSE-MsgGUID: PIwdVhwXTaOsmIYnDNU1NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226559627"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 31 Mar 2026 02:06:00 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Tue, 31 Mar 2026 14:33:53 +0530
Subject: [PATCH v11 1/7] drm: Define user readable error codes for atomic ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
In-Reply-To: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, xaver.hugl@kde.org, 
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com, 
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Arun R Murthy <arun.r.murthy@intel.com>, 
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15-dev
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

There can be multiple reasons for a failure in atomic_ioctl. Most often
in these error conditions -EINVAL is returned. User/Compositor would
have to blindly take a call on failure of this ioctl so as to use
ALLOW_MODESET or retry. It would be good if user/compositor gets a
readable error code on failure so they can take proper corrections in
the next commit.
The struct drm_mode_atomic is being passed by the user/compositor which
holds the properties for modeset/flip. Reusing the same struct for
returning the error code in case of failure, thereby creation of new
uapi/interface for returning the error code is not required.
The element 'reserved' in the struct drm_mode_atomic is used for
returning the user readable error code. This points to the struct
drm_mode_atomic_err_code. Failure reasons as a string can also be added
on need basis by the variable failure_string in the same struct
drm_mode_atomic_err_code.

v3: Remove fixed error (Jani/Xaver)
v5: Fix kernel-doc (Jani)
v7: Rephrase the kernel doc description (Suraj)
v8: Removed the below enum and suggest to use INVALID_API_USAGE (Xaver)
	DRM_MODE_ATOMIC_ASYNC_NOT_SUPP_PLANE
	DRM_MODE_ATOMIC_ASYNC_MODIFIER_NOT_SUPP
v10: Added more error codes for the enum
v11: Add default/unspecified error code

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 include/uapi/drm/drm_mode.h | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index a4bdc4bd11bc142e9d3b172397e18a1909a21488..8bf5fd8533912dc7a188aad19cc3741dd2099592 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -48,6 +48,7 @@ extern "C" {
 #define DRM_CONNECTOR_NAME_LEN	32
 #define DRM_DISPLAY_MODE_LEN	32
 #define DRM_PROP_NAME_LEN	32
+#define DRM_MODE_ATOMIC_FAILURE_STRING_LEN	128
 
 #define DRM_MODE_TYPE_BUILTIN	(1<<0) /* deprecated */
 #define DRM_MODE_TYPE_CLOCK_C	((1<<1) | DRM_MODE_TYPE_BUILTIN) /* deprecated */
@@ -1346,6 +1347,61 @@ struct drm_mode_destroy_dumb {
 		DRM_MODE_ATOMIC_NONBLOCK |\
 		DRM_MODE_ATOMIC_ALLOW_MODESET)
 
+/**
+ * enum drm_mode_atomic_failure_codes -  error codes for failures in atomic_ioctl
+ * @DRM_MODE_ATOMIC_UNSPECIFIED_ERROR: this is the default/unspecified error.
+ * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
+ *				       enabled, invalid falg, page_flip event
+ *				       with test-only, etc)
+ * @DRM_MODE_ATOMIC_NEED_FULL_MODESET: Need full modeset on all connected crtc's
+ * @DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED: Property changed in async flip
+ * @DRM_MODE_ATOMIC_SCANOUT_BW: For a given resolution, refresh rate and the
+ *                              color depth cannot be accomodated. Resolution
+ *                              is to lower the refresh rate or color depth.
+ * @DRM_MODE_ATOMIC_CONNECTOR_BW: Refers to the limitation on the link rate on
+ *                                a given connector.
+ * @DRM_MODE_ATOMIC_PIPE_BW: Limitation on the pipe, either pipe not available
+ *                           or the pipe scaling factor limitation.
+ * @DRM_MODE_ATOMIC_MEMORY_DOMAIN: Any other memory/bandwidth related limitation
+ *                                 other then the ones specified above.
+ * @DRM_MODE_ATOMIC_SPEC_VIOLOATION: Limitation of a particular feature on that
+ *                                   hardware. To get to know the feature, the
+ *                                   property/object causing this is being sent
+ *                                   back to user @failure_objs_ptr in the
+ *                                   struct drm_mode_atomic_err_code
+ */
+enum drm_mode_atomic_failure_codes {
+	DRM_MODE_ATOMIC_UNSPECIFIED_ERROR,
+	DRM_MODE_ATOMIC_INVALID_API_USAGE,
+	DRM_MODE_ATOMIC_NEED_FULL_MODESET,
+	DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED,
+	DRM_MODE_ATOMIC_SCANOUT_BW,
+	DRM_MODE_ATTOMIC_CONNECTOR_BW,
+	DRM_MODE_ATTOMIC_PIPE_BW,
+	DRM_MODE_ATOMIC_MEMORY_DOMAIN,
+	DRM_MODE_ATOMIC_SPEC_VIOLOATION,
+};
+
+/**
+ * struct drm_mode_atomic_err_code - struct to store the error code
+ *
+ * pointer to this struct will be stored in reserved variable of
+ * struct drm_mode_atomic to report the failure cause to the user.
+ *
+ * @failure_code: error codes defined in enum drm_moide_atomic_failure_code
+ * @failure_objs_ptr: pointer to the drm_object that caused error
+ * @reserved: reserved for future use
+ * @count_objs: count of drm_objects if multiple drm_objects caused error
+ * @failure_string: user readable error message string
+ */
+struct drm_mode_atomic_err_code {
+	__u64 failure_code;
+	__u64 failure_objs_ptr;
+	__u64 reserved;
+	__u32 count_objs;
+	char failure_string[DRM_MODE_ATOMIC_FAILURE_STRING_LEN];
+};
+
 struct drm_mode_atomic {
 	__u32 flags;
 	__u32 count_objs;

-- 
2.25.1

