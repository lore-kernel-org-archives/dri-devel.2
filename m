Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58303CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBE110FCFB;
	Wed,  3 Jun 2026 12:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qr37uoW2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 788D410FCFB;
 Wed,  3 Jun 2026 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780488872; x=1812024872;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V91GoT1tM9md2KozCeXm5aypOv5ZJavURFlxJQSbmOM=;
 b=Qr37uoW2xjDwpHARY9gYhU5sA0eZy0+0Bag8B43h/yx3M/+hhRTFdYuj
 CcD6J5ujsnRGN+b+ZjbD4I97cnymAGlxLSnLKj7O6fOZ3PS6qLilRaIj6
 hQrnl0J/RYXrON0vpKb9IYCqDzi+LkCiTwZYOfaW1ZR2EKtD/DcCCEuWb
 hxe980kzxCkCHRa82GbzkXqAwVV73a6UmSYSyWGwawGJzuGNelpetULzL
 AkpRUqaBUgBurd2oVD/REzNqA045AUcUcxfco87+KxZHMZX6B6cfUo/Kl
 fw1fpzijLvbd7UVamrck74DoN7ds2OJxVqZ2/931bR5LU48I7QE4hFL0r A==;
X-CSE-ConnectionGUID: svSLlOvgRLarCNpc5y6DBw==
X-CSE-MsgGUID: 0mVM0x6VTYC/nWEZQiWemg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92401551"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="92401551"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:14:32 -0700
X-CSE-ConnectionGUID: IqpauxNfTm2NjNmmAceq9w==
X-CSE-MsgGUID: w60EvJPMShKLRvi01WjSiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="249301240"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:14:28 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 nirmoy.das@intel.com, umesh.nerlige.ramappa@intel.com,
 thomas.hellstrom@linux.intel.com, matthew.brost@intel.com,
 niranjana.vishwanathapura@intel.com, thomas.hellstrom@intel.com,
 fei.yang@intel.com, himal.prasad.ghimiray@intel.com,
 matthew.d.roper@intel.com, maarten.lankhorst@intel.com,
 joonas.lahtinen@intel.com, matthew.auld@intel.com, stable@vger.kernel.org
Subject: [RFC PATCH 2/3] drm/sched: fix drm_sched_tdr_queue_imm to not corrupt
 timeout value
Date: Wed,  3 Jun 2026 17:36:41 +0530
Message-ID: <20260603120641.473434-5-sanjay.kumar.yadav@intel.com>
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

drm_sched_tdr_queue_imm() sets sched->timeout to 0 and never restores
it. This breaks all future TDR timers — jobs get timed out instantly
before they even start running on hardware.

Use mod_delayed_work() directly to fire the TDR worker immediately
without modifying the timeout field. This preserves the original
timeout value for subsequent job submissions.

Fixes: 8ec5a4e5ce97 ("drm/xe: Resume TDR after GT reset")
Cc: <stable@vger.kernel.org> # v6.13+
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4.6
Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 818d3d4434b5..be144e244745 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -212,8 +212,8 @@ static void drm_sched_start_timeout_unlocked(struct drm_gpu_scheduler *sched)
 void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched)
 {
 	spin_lock(&sched->job_list_lock);
-	sched->timeout = 0;
-	drm_sched_start_timeout(sched);
+	if (!list_empty(&sched->pending_list))
+		mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
 	spin_unlock(&sched->job_list_lock);
 }
 EXPORT_SYMBOL(drm_sched_tdr_queue_imm);
-- 
2.52.0

