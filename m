Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27F0CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F78510FCF9;
	Wed,  3 Jun 2026 12:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EdO7K6Nd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B77710FCF9;
 Wed,  3 Jun 2026 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780488868; x=1812024868;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=97ANJBeeHnfpIXt0MOMn+1oloc7lBuARnilYWz9y5Ro=;
 b=EdO7K6NdAYm63+YIzn5EDwk6PhD9XYeTBwPLglndnJHmYd8ZvErpG//d
 MURxBDv8p+XoP8c0Si9p/DfLh3nTJgSJIWpWyOtGdzxTX0kdF1p0i7D3B
 AwMwix9NC/whI/rzNDTu62FUBmXezAGnHaGd3vcqBoE8sgBmxG2Kox3Cz
 JojyBuqkPDyzBfFVImJ6Cgu/aQAS1yH3XVWZcObBoTW+qwrK5YFoyFeVQ
 2SLJl57QS2Ez19KSyVnhEqJ43+nFI3vHc9quIpCH+0/QUG5SAov+LM87R
 55amd0Ke6ZSviifPrwf/H5QpyOPobWh9uJfhajuFYB5tQhEOhrMfjv5eT A==;
X-CSE-ConnectionGUID: ngI2lc+RTMuyvGZkkm+WLA==
X-CSE-MsgGUID: UOEpd4QzShqVPiyfOmWcyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92401545"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="92401545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:14:28 -0700
X-CSE-ConnectionGUID: 2gqPh49fTymsuG0MnbSv6Q==
X-CSE-MsgGUID: 24a2ezzKSA6YO8SDa4jbcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="249301231"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:14:24 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 nirmoy.das@intel.com, umesh.nerlige.ramappa@intel.com,
 thomas.hellstrom@linux.intel.com, matthew.brost@intel.com,
 niranjana.vishwanathapura@intel.com, thomas.hellstrom@intel.com,
 fei.yang@intel.com, himal.prasad.ghimiray@intel.com,
 matthew.d.roper@intel.com, maarten.lankhorst@intel.com,
 joonas.lahtinen@intel.com, matthew.auld@intel.com
Subject: [RFC PATCH 1/3] drm/xe: skip banning kernel migration queue on TDR
 timeout
Date: Wed,  3 Jun 2026 17:36:40 +0530
Message-ID: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
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

guc_exec_queue_timedout_job() unconditionally bans the queue once a
job times out. For the kernel migration queue this is fatal — once
banned, no page table migrations can complete and the GPU is
effectively dead until driver reload.

The submission is already stopped and the timed-out job is erred out,
so banning is not needed for correctness. GT reset handles the actual
hardware recovery. Skip banning for kernel queues so they remain
available after reset.

Fixes: bb63e7257e63 ("drm/xe: Avoid toggling schedule state to check LRC timestamp in TDR")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4.6
Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index ab501513d806..e6ad57cbbf0e 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1543,7 +1543,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 	if (!exec_queue_killed(q))
 		wedged = guc_submit_hint_wedged(exec_queue_to_guc(q));
 
-	set_exec_queue_banned(q);
+	if (!(q->flags & EXEC_QUEUE_FLAG_KERNEL))
+		set_exec_queue_banned(q);
 
 	/* Kick job / queue off hardware */
 	if (!wedged && (exec_queue_enabled(primary) ||
-- 
2.52.0

