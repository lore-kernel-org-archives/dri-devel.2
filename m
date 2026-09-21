Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B81C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B20E10E746;
	Mon, 21 Sep 2026 13:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F3Df/y33";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D848110E38D;
 Mon, 21 Sep 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789996142; x=1821532142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DSkP4dIu/pAL0lozl8yDKmqnPoVZHzwdsPzAjBlFNVU=;
 b=F3Df/y33zJwm0vkgyDUgvlDCeSyQOSk52CDmx53Ph7fvCMKJGWKahKjZ
 swLKufDbH8YicYwKCgcTePBO+1rQZj6WfMJIdNkZw6bazQJ1hI7PatEfb
 +GGugbq6IBBY6ZhmFUbwd3rSCuljaoM/5m2oqaW0qtHsAwqGz/CLGB3PB
 OhRClkf4PXjKneDieZDMYwSHeIGnwZ+4VAqoEMMqp0/7QwtZQqh86466N
 fCfolUhx/ptOM4LNJoEuBTs0A46yZND7+a6FG74A0Kxj7VhsRzCNAMDR7
 3X9BkgCG+0OZVXTSPQXGWHEzA/Clshq3QQ3BGRYYyA3R6pzQ2b0HeYFFE Q==;
X-CSE-ConnectionGUID: gD+XgrPBSm6I7sM6IWLICQ==
X-CSE-MsgGUID: 4r9WtbvDScqR5rnl80mmuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101855956"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="101855956"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 06:09:01 -0700
X-CSE-ConnectionGUID: tAvPE3mARoK1yADwmL8bbw==
X-CSE-MsgGUID: GU5cyfctQjW2vdOAhmTcvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3678313"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa011.fm.intel.com with ESMTP; 21 Sep 2026 06:09:00 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 ankit.k.nautiyal@intel.com, adarsh.g.m@intel.com,
 Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH libdrm 1/2] xf86drmMode: add drmModeGetCrtcList() to enumerate
 available CRTCs
Date: Mon, 21 Sep 2026 18:37:45 +0530
Message-Id: <20260921130747.2557722-2-arun.r.murthy@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921130747.2557722-1-arun.r.murthy@intel.com>
References: <20260921130747.2557722-1-arun.r.murthy@intel.com>
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

drmModeGetResources() tells the system capability and not runtime
availability of the hardware resource.
DRM_IOCTL_MODE_GETCRTC only tells userspace which CRTCs are enabled
through KMS, not which are active in hardware. A pipe can be actively
scanning out without being enabled through the KMS state, so relying on
GETCRTC alone would report such a CRTC as free and assignable when it is
not.

An active pipe keeps its vblank running, so reading the CRTC's vblank
sequence reveals the active pipes: an active pipe's counter keeps
advancing while an inactive pipe's does not. For every CRTC that GETCRTC
reports as free, sample the vblank via drmCrtcGetSequence() across a
single short wait and, if it advanced, flag the entry as driver_active
and exclude it from count_available.

The list is allocated by drmModeGetCrtcList() and released with the new
drmModeFreeCrtcList(). Both symbols are exported via core-symbols.txt.

The helper is a thin wrapper over the standard KMS uAPI, so it works
identically on i915, xe and any other KMS driver.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 core-symbols.txt |   2 +
 xf86drmMode.c    | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 xf86drmMode.h    |  38 +++++++++++++++
 3 files changed, 163 insertions(+)

diff --git a/core-symbols.txt b/core-symbols.txt
index 766c342d..a14add40 100644
--- a/core-symbols.txt
+++ b/core-symbols.txt
@@ -119,6 +119,7 @@ drmModeDirtyFB
 drmModeFormatModifierBlobIterNext
 drmModeFreeConnector
 drmModeFreeCrtc
+drmModeFreeCrtcList
 drmModeFreeEncoder
 drmModeFreeFB
 drmModeFreeFB2
@@ -133,6 +134,7 @@ drmModeGetConnector
 drmModeGetConnectorCurrent
 drmModeGetConnectorTypeName
 drmModeGetCrtc
+drmModeGetCrtcList
 drmModeGetEncoder
 drmModeGetFB
 drmModeGetFB2
diff --git a/xf86drmMode.c b/xf86drmMode.c
index 5b5d7053..224212bb 100644
--- a/xf86drmMode.c
+++ b/xf86drmMode.c
@@ -35,6 +35,7 @@
 #include <dirent.h>
 #include <unistd.h>
 #include <errno.h>
+#include <time.h>
 
 #define memclear(s) memset(&s, 0, sizeof(s))
 
@@ -383,6 +384,128 @@ drm_public drmModeCrtcPtr drmModeGetCrtc(int fd, uint32_t crtcId)
 	return r;
 }
 
+drm_public drmModeCrtcListPtr drmModeGetCrtcList(int fd)
+{
+	drmModeResPtr res;
+	drmModeCrtcListPtr list;
+	uint64_t *seq0 = NULL;
+	char *probe = NULL;
+	int need_probe = 0;
+	int i;
+
+	res = drmModeGetResources(fd);
+	if (!res)
+		return NULL;
+
+	list = drmMalloc(sizeof(*list));
+	if (!list)
+		goto err_res;
+
+	list->count = res->count_crtcs;
+	list->count_available = 0;
+
+	if (res->count_crtcs) {
+		list->crtcs = drmMalloc(res->count_crtcs * sizeof(*list->crtcs));
+		if (!list->crtcs)
+			goto err_list;
+		seq0 = drmMalloc(res->count_crtcs * sizeof(*seq0));
+		probe = drmMalloc(res->count_crtcs * sizeof(*probe));
+		if (!seq0 || !probe)
+			goto err_probe;
+	}
+
+	for (i = 0; i < res->count_crtcs; i++) {
+		drmModeCrtcInfoPtr info = &list->crtcs[i];
+		drmModeCrtcPtr crtc = drmModeGetCrtc(fd, res->crtcs[i]);
+
+		info->crtc_id = res->crtcs[i];
+		info->index = i;
+
+		if (!crtc) {
+			/* Unreadable CRTC: report as busy so callers don't grab it. */
+			info->in_use = 1;
+			continue;
+		}
+
+		info->buffer_id = crtc->buffer_id;
+		if (crtc->mode_valid) {
+			info->in_use = 1;
+			info->width = crtc->width;
+			info->height = crtc->height;
+			info->mode = crtc->mode;
+		} else {
+			/*
+			 * GETCRTC only tells us which pipes are enabled through
+			 * KMS, not which are active in hardware. A pipe can be
+			 * active (scanning out) without being enabled here, and
+			 * an active pipe keeps its vblank counter advancing.
+			 * Snapshot the vblank sequence now and re-check it below
+			 * to find such active pipes.
+			 */
+			uint64_t ns;
+
+			if (!drmCrtcGetSequence(fd, info->crtc_id, &seq0[i], &ns)) {
+				probe[i] = 1;
+				need_probe = 1;
+			}
+		}
+
+		drmModeFreeCrtc(crtc);
+	}
+
+	/*
+	 * One shared wait covers every candidate: an active pipe keeps
+	 * advancing its vblank counter, an inactive pipe does not. 50ms
+	 * crosses at least one vblank down to ~24Hz.
+	 */
+	if (need_probe) {
+		struct timespec ts = { .tv_sec = 0, .tv_nsec = 50000000 };
+
+		nanosleep(&ts, NULL);
+
+		for (i = 0; i < res->count_crtcs; i++) {
+			uint64_t seq1, ns;
+
+			if (!probe[i])
+				continue;
+			if (drmCrtcGetSequence(fd, list->crtcs[i].crtc_id,
+					       &seq1, &ns))
+				continue;
+			if (seq1 != seq0[i])
+				list->crtcs[i].driver_active = 1;
+		}
+	}
+
+	for (i = 0; i < res->count_crtcs; i++) {
+		if (!list->crtcs[i].in_use && !list->crtcs[i].driver_active)
+			list->count_available++;
+	}
+
+	drmFree(probe);
+	drmFree(seq0);
+	drmModeFreeResources(res);
+	return list;
+
+err_probe:
+	drmFree(probe);
+	drmFree(seq0);
+	drmFree(list->crtcs);
+err_list:
+	drmFree(list);
+err_res:
+	drmModeFreeResources(res);
+	return NULL;
+}
+
+drm_public void drmModeFreeCrtcList(drmModeCrtcListPtr ptr)
+{
+	if (!ptr)
+		return;
+
+	drmFree(ptr->crtcs);
+	drmFree(ptr);
+}
+
 drm_public int drmModeSetCrtc(int fd, uint32_t crtcId, uint32_t bufferId,
 		   uint32_t x, uint32_t y, uint32_t *connectors, int count,
 		   drmModeModeInfoPtr mode)
diff --git a/xf86drmMode.h b/xf86drmMode.h
index 2a7156db..c634333b 100644
--- a/xf86drmMode.h
+++ b/xf86drmMode.h
@@ -147,6 +147,30 @@ typedef struct _drmModeCrtc {
 
 } drmModeCrtc, *drmModeCrtcPtr;
 
+/**
+ * Per-CRTC availability information, produced by drmModeGetCrtcList().
+ */
+typedef struct _drmModeCrtcInfo {
+	uint32_t crtc_id;   /**< KMS object id of the CRTC */
+	int index;          /**< Index in drmModeRes.crtcs[]; usable for vblank high-crtc bits */
+	int in_use;         /**< Non-zero if userspace has a mode set on this CRTC */
+	int driver_active;  /**< Non-zero if the CRTC is active in hardware (its
+			     *   vblank is running) even though it is not enabled
+			     *   through KMS. GETCRTC only reports enabled pipes;
+			     *   reading the vblank counter reveals active pipes,
+			     *   which must not be treated as free. */
+	uint32_t buffer_id; /**< FB currently scanned out, 0 if none */
+	uint32_t width, height; /**< Active mode resolution, 0 when not in use */
+	drmModeModeInfo mode;   /**< Active mode; valid only when in_use is set */
+} drmModeCrtcInfo, *drmModeCrtcInfoPtr;
+
+typedef struct _drmModeCrtcList {
+	int count;                /**< Total number of CRTCs on the device */
+	int count_available;      /**< CRTCs that are free and assignable (neither
+				   *   in_use nor driver_active) */
+	drmModeCrtcInfoPtr crtcs; /**< Array of 'count' CRTC entries */
+} drmModeCrtcList, *drmModeCrtcListPtr;
+
 typedef struct _drmModeEncoder {
 	uint32_t encoder_id;
 	uint32_t encoder_type;
@@ -317,6 +341,20 @@ extern int drmModeDirtyFB(int fd, uint32_t bufferId,
  */
 extern drmModeCrtcPtr drmModeGetCrtc(int fd, uint32_t crtcId);
 
+/**
+ * Enumerate every CRTC on the device and report which ones are available.
+ *
+ * Convenience wrapper around drmModeGetResources() + drmModeGetCrtc() intended
+ * for compositors that need to discover free CRTCs. The returned list must be
+ * released with drmModeFreeCrtcList(). Returns NULL on error.
+ */
+extern drmModeCrtcListPtr drmModeGetCrtcList(int fd);
+
+/**
+ * Free a list previously returned by drmModeGetCrtcList().
+ */
+extern void drmModeFreeCrtcList(drmModeCrtcListPtr ptr);
+
 /**
  * Set the mode on a crtc crtcId with the given mode modeId.
  */
-- 
2.25.1

