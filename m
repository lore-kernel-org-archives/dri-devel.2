Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C347C98306
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF8010EC40;
	Tue, 22 Sep 2026 10:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a8IgbJQh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199A810E6BE;
 Tue, 22 Sep 2026 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072283; x=1821608283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G3XfY1VczVx9tr4/vCIDmQw5HhuLtoyd/sdm5LrYL3A=;
 b=a8IgbJQhSNLj9socYl2Gz1UZoojtUjU0dCS3gSy6b/24ksiGawl5a89I
 yXeNrhm1fa670Fh0VSdsIETorcPNLaw56dFup+nDQhcurq3oJsYxBhNrg
 eHbh4GpUZoApEYyJPB4Ca/LTWzpQxHn7g3rcxG7MhTUWlmWDDyfdr+NyP
 asCy3eKD2XfgmQqg+HG7G4sb14Ac4/7H6s2DIZ7KZQ5H2F7HtDP5knOET
 BLuDw3fYhSLsyHkcj8x90W+ER5abq8a/HRGoeK9lbkxXyBjvOusR8ivsu
 t3dZphbRG5QU5BgprGMVcWToqrUXvo9LpJdv2mPOZ5wiAWZ3yZPjKywEU w==;
X-CSE-ConnectionGUID: V9qJAcyjRlOUbD0P7gKTVg==
X-CSE-MsgGUID: aBqPq+rMQMeBSyhVFdm78g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322858"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322858"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:03 -0700
X-CSE-ConnectionGUID: W3OTHcw4Tp2QGYqNlneeDw==
X-CSE-MsgGUID: CPylY4F0QnaSJWIQSJf0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307956"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:01 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 13/15] drm/xe/guc: Skip timeout recovery on a wedged device
Date: Tue, 22 Sep 2026 15:46:58 +0530
Message-ID: <20260922101721.1583542-14-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A scheduler timeout can still run after the device has been declared
wedged. guc_submit_hint_wedged() only returns true for the no-reset
debug mode, so other wedge modes can continue into GuC timeout recovery.

The killed-queue case already preserves an existing wedge. Extend the
same check to non-killed queues, where guc_submit_hint_wedged() returns
false outside the no-reset debug mode.

If the device is already wedged, use the existing wedged cleanup path
and avoid further hardware recovery. This also avoids the
kernel-submitted job timeout warning seen after wedge isolation.

The timeout was observed as:
[ 8939.200065] xe 0000:03:00.0: [drm] Tile0: GT0: Kernel-submitted job timed out
[ 8939.200066] WARNING: xe_guc_submit.c:1683 at guc_exec_queue_timedout_job+0x1160/0x2550

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 664008d21914..da2d4fa02a77 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1596,10 +1596,9 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	 * Killed queues must not newly wedge the device, but preserve an
 	 * already-wedged state to avoid warning on teardown timeouts.
 	 */
-	if (!exec_queue_killed(q))
+	wedged = xe_device_wedged(xe);
+	if (!wedged && !exec_queue_killed(q))
 		wedged = guc_submit_hint_wedged(exec_queue_to_guc(q));
-	else
-		wedged = xe_device_wedged(xe);
 
 	/*
 	 * Only tag as GPU hang if this is the original timeout, not a
-- 
2.43.0

