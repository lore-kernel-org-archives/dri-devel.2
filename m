Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F80CFF60EF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD8010E9B5;
	Tue, 31 Mar 2026 09:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ckxnqpcG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06B710E9BA;
 Tue, 31 Mar 2026 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774947976; x=1806483976;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=XP/NU/zQoBZbvJQdSUKHqYKcbCyQXs98XyeG6e1RRA0=;
 b=ckxnqpcGLhRN4tEzOhYRTBcWuowHXki6G7/RjXSEENUrfuo/D/rG3x1m
 5EJO5QW/P6eKaBdXFM2XaPhhQCBkUGS/9UARfGXRY3PAfLOupUfu1oz/F
 cK/GeqfnZ4mbdvcTu8JnZiTaLdAUYF+xS/Sl3gtn1M3YYpLfIEaSEDj8T
 exN/X87ujGISZRugdq5sGBzWABNML9IM1iU0DpAvH2IliYjRXDo7JTxJx
 WXLyohfZcV9mdq9HIVHS4l1UTMfeQJDxQPVNwR90+DHdMLXJBjtZFpp6S
 xtupI0BlAUxa18GPE7LxDGIvV6fVDqW7tCG3YahMOBo9YRJBeIwsxcmuH g==;
X-CSE-ConnectionGUID: zsNytpcdSMGzbcrWKlg35g==
X-CSE-MsgGUID: vUlY/x6dSRK48rF5rOoYxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87420639"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87420639"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:06:16 -0700
X-CSE-ConnectionGUID: b06HUAZvTyWL+seOOm5oIg==
X-CSE-MsgGUID: BT9flaEESzSJ9na95KioiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226559695"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 31 Mar 2026 02:06:11 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Tue, 31 Mar 2026 14:33:55 +0530
Subject: [PATCH v11 3/7] drm/atomic: Call complete_signaling only if
 prepare_signaling is done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-atomic-v11-3-6a1df7ec5af8@intel.com>
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

Upon returning valid error code on atomic_ioctl failure, changes have
been done to goto error/out in cases of error instead of returining to
accommodate returning the failure codes. As part of this change
complete_signaling() will be called as part of cleanup. Check if the
fences are initialized/prepared before completing.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df7f6cefae616970a99a4b04de7121..64e33aeb9ee2d553b1247cfb9a11e17d8ddf1e86 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1573,7 +1573,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_out_fence_state *fence_state;
 	int ret = 0;
-	unsigned int i, j, num_fences;
+	unsigned int i, j, num_fences = 0;
 	bool async_flip = false;
 
 	/* disallow for drivers not supporting atomic: */
@@ -1723,7 +1723,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	}
 
 out:
-	complete_signaling(dev, state, fence_state, num_fences, !ret);
+	if (num_fences)
+		complete_signaling(dev, state, fence_state, num_fences, !ret);
 
 	if (ret == -EDEADLK) {
 		drm_atomic_state_clear(state);

-- 
2.25.1

