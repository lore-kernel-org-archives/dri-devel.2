Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8674FFF60EF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D2010E9DF;
	Tue, 31 Mar 2026 09:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M0DoZlP2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A2810E9D8;
 Tue, 31 Mar 2026 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774947999; x=1806483999;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=ITHiJ8mV8MjBhrvl31MX8m6mVWmn+8bPpVNr5l5vxvo=;
 b=M0DoZlP2PCT7/uhvNWee1LH5rGA2NaILpcxlP0wiFgnEZqGRYssXIoOM
 FVuO1l1VfGMUBlOGy4LLmGWFrWXHfrZu5ldT+czSY/O53I5id3By+1Hl4
 O8RCWgAYIoQz5o/bJXr1JYV2gN4YJQsDHtDDgUaU6wrm81ZEKPlOcrq6P
 tpKAmdGXLrf9a20SJE32Qtk908a5lzETV3I8ICkS6lAH43PolBpy3J6Rh
 RL0M+tff7y3OGhiPUPGGnnXCX20RmNKeZoEDA66M/MPhVUDkaPIMhkoYI
 4IJO1mJhWnDTPSkd6wfYR5InqV4F/tOQuXSSG1T+YIOh8AeiX4xMde7sd g==;
X-CSE-ConnectionGUID: zp+9LmOtQfanYZdxgSnJIA==
X-CSE-MsgGUID: 9ZL4l0uSTmyoy9wGpNogXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87420768"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87420768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:06:38 -0700
X-CSE-ConnectionGUID: offoz/sSSB2IJLKuYOiEWg==
X-CSE-MsgGUID: rhktEMkVStSP/jLfqP7lzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226559855"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 31 Mar 2026 02:06:33 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Tue, 31 Mar 2026 14:33:59 +0530
Subject: [PATCH v11 7/7] drm: Introduce DRM_CAP_ATOMIC_ERROR_REPORTING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-atomic-v11-7-6a1df7ec5af8@intel.com>
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

The new capability informs users that atomic_ioctl() supports
failure reporting when an error occurs.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/drm_ioctl.c | 3 +++
 include/uapi/drm/drm.h      | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e7e863888d8958458978566b144f8..59f2b5b53830fd3aadc6e18cf49f0660a99e9c96 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -304,6 +304,9 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
 			     dev->mode_config.async_page_flip;
 		break;
+	case DRM_CAP_ATOMIC_ERROR_REPORTING:
+		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) && 1;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d275c7a7fe057840ef792f30a582bb7..6082410bcabfb4aa37b85e5f03d3611e5aed4aa5 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -812,6 +812,13 @@ struct drm_gem_change_handle {
  * commits.
  */
 #define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
+/**
+ * DRM_CAP_ATOMIC_ERROR_REPORTING
+ *
+ * If set to 1, the driver supports reporting of failure codes on error in
+ * atomic ioctl().
+ */
+#define DRM_CAP_ATOMIC_ERROR_REPORTING	0x16
 
 /* DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {

-- 
2.25.1

