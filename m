Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BB5CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5150510FCFF;
	Wed,  3 Jun 2026 12:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AIUJGhS6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F58410FCFF;
 Wed,  3 Jun 2026 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780488876; x=1812024876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5TXuX/14e/oQMSdfJ6Otaekb/Jwg7nqfGRcVheaeNb0=;
 b=AIUJGhS61bD27B//fdMtd0LtqfBolX7dv9/r3JiFPa3wyf82VN4VvEhN
 7/zoTh/0a22Nqqe3Hp6CCZhik2ms8xFHTJIOlTjHS+K2yyfu39jmLovbf
 /WXNLc72knlA+tt8bD4usRZZxqchfIJkvebX+V+FQtNITitEyy4XdCXBv
 MwhbQ5E8DRZAzpiiTD/vo1XDer+vrsk55qDAkRjMHvBSxYtzSHZKXv9Xz
 X5f/k55TCkIVAn9/znnBoZ/jPoq3ZWDC22Wg3Rtw8YT9OXA36nzGagK8T
 lThUacPZQwcXb8CvYVKrvgQvHa2Z/inetx27zJctthkn/jPl/9RegMxgU w==;
X-CSE-ConnectionGUID: NEBih7owT6KTvvrbXQ2kHA==
X-CSE-MsgGUID: CaFiOfe4TDyLXUvN15eyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92401555"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="92401555"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:14:36 -0700
X-CSE-ConnectionGUID: /x2+odXkT9yW973286Y0XQ==
X-CSE-MsgGUID: Zgiyzgv+STe2olt9KG7ZPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="249301248"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:14:32 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 nirmoy.das@intel.com, umesh.nerlige.ramappa@intel.com,
 thomas.hellstrom@linux.intel.com, matthew.brost@intel.com,
 niranjana.vishwanathapura@intel.com, thomas.hellstrom@intel.com,
 fei.yang@intel.com, himal.prasad.ghimiray@intel.com,
 matthew.d.roper@intel.com, maarten.lankhorst@intel.com,
 joonas.lahtinen@intel.com, matthew.auld@intel.com
Subject: [RFC PATCH 3/3] drm/xe: don't cancel other pending jobs on kernel
 migration queue timeout
Date: Wed,  3 Jun 2026 17:36:42 +0530
Message-ID: <20260603120641.473434-6-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
References: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
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

The kernel migration queue scheduler is shared across all VMs on a tile.
When a job times out and GT recovery is exhausted (karma > threshold),
guc_exec_queue_timedout_job() falls through to error out the job and
cancel all remaining pending jobs via drm_sched_for_each_pending_job().

After a GT reset, the hardware is recovered and those pending jobs can
run fine. Skip cancellation for kernel queues so that other VMs' migration
operations can complete after GT reset recovers the engine.

Fixes: 95f27831ee3c ("drm/xe: Stop abusing DRM scheduler internals")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4.6
Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index e6ad57cbbf0e..dd3ae58019b1 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1640,8 +1640,15 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 
 	/* Mark all outstanding jobs as bad, thus completing them */
 	xe_sched_job_set_error(job, err);
-	drm_sched_for_each_pending_job(tmp_job, &sched->base, NULL)
-		xe_sched_job_set_error(to_xe_sched_job(tmp_job), -ECANCELED);
+
+	/*
+	 * For kernel queues (migration), don't cancel other pending jobs.
+	 * They belong to different VMs sharing the same scheduler and will
+	 * be resubmitted after GT reset recovers the hardware.
+	 */
+	if (!(q->flags & EXEC_QUEUE_FLAG_KERNEL))
+		drm_sched_for_each_pending_job(tmp_job, &sched->base, NULL)
+			xe_sched_job_set_error(to_xe_sched_job(tmp_job), -ECANCELED);
 
 	if (xe_exec_queue_is_multi_queue(q)) {
 		xe_guc_exec_queue_group_start(q);
-- 
2.52.0

