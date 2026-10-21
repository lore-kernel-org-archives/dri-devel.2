Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E08606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PJFcJm9x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF56410FD3A;
	Wed, 21 Oct 2026 10:04:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1FC10FD3B;
 Wed, 21 Oct 2026 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577054; x=1824113054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XFLiTB4clPi1HCjwYHWWN7r4MRbNaogqnQGqDxw/Ejo=;
 b=PJFcJm9xi5SjHjsW8QpzfVtsleAKralYv6nqOT6oyIsVqhbAJ/+vniX1
 HlxwnaZ8evNUIXweU2enRfd1TqHzArE4SW32tkYe43RKXAlsXcUYxfniU
 o+FmvBY7oym/PSQYnZQAp5hlDSE4qUfPuEMp2kZIT9d633Bp83iE/rzAM
 JTwBG6pbhO81BAtYWuvqQwao/Sp98Z7aGCn1/tQkML+egcLgCi9oqNip+
 F50u85q6dJ0h9hoczi3c0RmEKGi9EJYZ5NvjIV2Yt+KSEBgHTKF03L0UO
 9UlIzcNADzGXFaWD2FLrgLY8OwmrWLxFuVa/+3THyYnyM0ipBbbOpIMOL A==;
X-CSE-ConnectionGUID: MPfF6sZUSfCyshxDH9tJpQ==
X-CSE-MsgGUID: CcD8/aplRGufBvoIvZ71Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290325"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:14 -0700
X-CSE-ConnectionGUID: rcpXECXGTZ6ZAklko/z5ww==
X-CSE-MsgGUID: c+BJ344QSJKbLpBq8A8T4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382158"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:11 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 15/17] drm/xe/guc: Skip timeout recovery on a wedged device
Date: Wed, 21 Oct 2026 15:33:16 +0530
Message-ID: <20261021100322.1014449-16-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Assisted-by: LLM
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index aa948581576e..bf3d16a72357 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1668,10 +1668,9 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
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

