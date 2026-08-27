Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E4AC61DD3
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DD610EFA0;
	Thu, 27 Aug 2026 10:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iz0jDsx4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6965610EF91;
 Thu, 27 Aug 2026 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825932; x=1819361932;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X+SOUdhs8DA7lXpYTkz8gtUEIyPAsQTqaWfmyXVQ61g=;
 b=iz0jDsx4fgVoWtyfPThYj5Nmr2UHqo65dvrxfY2zs5lgeLk7zZXija28
 9vOVhsFY6HGNiT11IK4pMhYpkQ+gayfXtOJyUDc3+jSMf13VXN9LAyhvW
 aBVLS2IvvoOIkLRs7q7zZek2u1ILIF3W73vIPGYmDL033OtqJfnKQfE4a
 iQb2l7Je6wrurm65UMjqmvOQuCs7mYUxue8FxK7g0BHGHdP1BYAFkOcb0
 3qIJsvag2BQMqZonNlpx+yiH5t0BRI+AVbHW71H/YYSyh7M8mgh5RBYI2
 PRKPMWl6sO/NgV3vP0xqimBT0aggUcSMN548DVGNuEkLYtjGVmtVWpwUf A==;
X-CSE-ConnectionGUID: Np/XBnuOTOaVUZAgjwT/iw==
X-CSE-MsgGUID: QQg+WjtGRUGbALlSdokDxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445879"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:52 -0700
X-CSE-ConnectionGUID: LWDi5lIIRMihGxjb/NCg/w==
X-CSE-MsgGUID: t86GXjonTsm4rRTx93wg2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057659"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:51 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 11/13] drm/xe/guc: Skip timeout recovery on a wedged device
Date: Thu, 27 Aug 2026 15:47:59 +0530
Message-ID: <20260827101801.1247654-12-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index a307af458cf8..287a30027b1c 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1594,10 +1594,9 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	 * Killed queues must not newly wedge the device, but preserve an
 	 * already-wedged state to avoid warning on teardown timeouts.
 	 */
-	if (!exec_queue_killed(q))
+	wedged = xe_device_wedged(xe);
+	if (!wedged && !exec_queue_killed(q))
 		wedged = guc_submit_hint_wedged(exec_queue_to_guc(q));
-	else
-		wedged = xe_device_wedged(xe);
 
 	set_exec_queue_banned(q);
 
-- 
2.43.0

