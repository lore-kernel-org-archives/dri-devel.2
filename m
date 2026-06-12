Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14745CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD6810EA4B;
	Fri, 12 Jun 2026 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X92sq7j2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEF710F588;
 Fri, 12 Jun 2026 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781275335; x=1812811335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QTuqOqlzsRWUNP076Izfu+Hx8PMhVN2XLfFoh74s6zs=;
 b=X92sq7j2BCRpKrvFymyRbsaaXubY7svZJIY9DeoPGCaXLbN1z5Ob8S1s
 Xbhx/n875MORnZEW0W9rde+HOO4k+SUuqSu8wbG0/GK0MVW0IAbtlh+JC
 UL7tsYm2DKBI0d+NDDZPKxcLmKggAdB49ZOaXflhFeaV5Q56BPzaH4NRa
 y3GJJlkE1XmnLEdzL8xUsYMwE8HGnue2KlVazSfPlE51iCvuPmiJ7d0lE
 fzW/60UQz2MZawK4S1m8pG51O6vKe1OfO+50wHGLjoZQ84OOQWgCLJA2E
 0N+vIHM0sjXbt58BtyQoNVcayzfgbTXHHnryt3sSTbSApsnRCB85aksWY g==;
X-CSE-ConnectionGUID: qg+SBkqPSAGrn+2Il4fTSg==
X-CSE-MsgGUID: gUDqoa3DRdKmgLDx2hWwOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81240518"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="81240518"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 07:42:14 -0700
X-CSE-ConnectionGUID: cruocnhfRCu00eSP2UyvKQ==
X-CSE-MsgGUID: 0fHYo1CPRWuDsYUduX8Shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="284944550"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 07:42:12 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm/modes: Add DRM_MODE_MATCH_TIMINGS_VRR
Date: Fri, 12 Jun 2026 17:42:00 +0300
Message-ID: <20260612144203.31715-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Add a new mode matching flag DRM_MODE_MATCH_TIMINGS_VRR. This is
identical to DRM_MODE_MATCH_TIMINGS, except it requires the vsync
pulse to remain anchored to the end of vtotal, as opposed to the
start of the frame. VRR capable hardware can therefore treat
matching modes as just variants of the same mode with a different
vblank lengths.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_modes.c | 23 +++++++++++++++++++++++
 include/drm/drm_modes.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 3f8e025fd6d9..e1eed13a8e94 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1469,6 +1469,25 @@ struct drm_display_mode *drm_mode_duplicate(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_mode_duplicate);
 
+static bool drm_mode_match_timings_vrr(const struct drm_display_mode *mode1,
+				       const struct drm_display_mode *mode2)
+{
+	int mode1_vsync_start_offset = mode1->vtotal - mode1->vsync_start;
+	int mode1_vsync_end_offset = mode1->vtotal - mode1->vsync_end;
+	int mode2_vsync_start_offset = mode2->vtotal - mode2->vsync_start;
+	int mode2_vsync_end_offset = mode2->vtotal - mode2->vsync_end;
+
+	return mode1->hdisplay == mode2->hdisplay &&
+		mode1->hsync_start == mode2->hsync_start &&
+		mode1->hsync_end == mode2->hsync_end &&
+		mode1->htotal == mode2->htotal &&
+		mode1->hskew == mode2->hskew &&
+		mode1->vdisplay == mode2->vdisplay &&
+		mode1_vsync_start_offset == mode2_vsync_start_offset &&
+		mode1_vsync_end_offset == mode2_vsync_end_offset &&
+		mode1->vscan == mode2->vscan;
+}
+
 static bool drm_mode_match_timings(const struct drm_display_mode *mode1,
 				   const struct drm_display_mode *mode2)
 {
@@ -1538,6 +1557,10 @@ bool drm_mode_match(const struct drm_display_mode *mode1,
 	if (!mode1 || !mode2)
 		return false;
 
+	if (match_flags & DRM_MODE_MATCH_TIMINGS_VRR &&
+	    !drm_mode_match_timings_vrr(mode1, mode2))
+		return false;
+
 	if (match_flags & DRM_MODE_MATCH_TIMINGS &&
 	    !drm_mode_match_timings(mode1, mode2))
 		return false;
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index b9bb92e4b029..6e3eccc3c349 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -193,6 +193,7 @@ enum drm_mode_status {
 #define DRM_MODE_MATCH_FLAGS (1 << 2)
 #define DRM_MODE_MATCH_3D_FLAGS (1 << 3)
 #define DRM_MODE_MATCH_ASPECT_RATIO (1 << 4)
+#define DRM_MODE_MATCH_TIMINGS_VRR (1 << 5)
 
 /**
  * struct drm_display_mode - DRM kernel-internal display mode structure
-- 
2.53.0

