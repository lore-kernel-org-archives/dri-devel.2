Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F9CC5CFF1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38C210EBB6;
	Tue, 11 Aug 2026 13:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NEw0cuaw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F6310EC01;
 Tue, 11 Aug 2026 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=OHIy/Kv0pLMiD3Y2g9Ayoid1KhjN55vqFl7hFBY6cXE=; b=
 NEw0cuawlvUbS74N3a5HHbfR+AwOtR5TgsqjZIHnNTCDEAuEC19v6ayR5WU/+dVhu6FMFsx1VQpTM
 tmiCdwD6LG2BqaE5rptIF01Hs3Wy5qkOt8PNeXA8xFbE8zKAVsnV8RZ3x0DFYzpaya2RpfBY5/AzV
 cx31ufv7lBM9dlV4CdX9nzJ7XoTENIib6+Rpgq+3/835RaQTknM2ns/Rmza17eFBsqa+QYgVa5/6G
 7CbQ2L/DMyf/eLqvbZAbDx6EXDrH2RbJ4yrrS671O4rYgx5Ue4fnGUbDLD3GGzpdrGh5CF+eWxolc
 EfmDqCHKC+D3EAaXrRT4fIYL630rixxR6A==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpz-00H9rl-Qt; Tue, 11 Aug 2026 15:48:15 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 19/20] Revert "drm/sched: Switch default policy to fair"
Date: Tue, 11 Aug 2026 14:47:57 +0100
Message-ID: <20260811134758.96339-20-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 45c211ddf92a1f9b4214ffadaf70d9037f53aaf6.
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 8127c93a1718..337db7b1e688 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -84,13 +84,13 @@
 #define CREATE_TRACE_POINTS
 #include "gpu_scheduler_trace.h"
 
-int drm_sched_policy = DRM_SCHED_POLICY_FAIR;
+int drm_sched_policy = DRM_SCHED_POLICY_FIFO;
 
 /**
  * DOC: sched_policy (int)
  * Used to override default entities scheduling policy in a run queue.
  */
-MODULE_PARM_DESC(sched_policy, "Specify the scheduling policy for entities on a run-queue, " __stringify(DRM_SCHED_POLICY_RR) " = Round Robin, " __stringify(DRM_SCHED_POLICY_FIFO) " = FIFO, " __stringify(DRM_SCHED_POLICY_FAIR) " = Fair (default).");
+MODULE_PARM_DESC(sched_policy, "Specify the scheduling policy for entities on a run-queue, " __stringify(DRM_SCHED_POLICY_RR) " = Round Robin, " __stringify(DRM_SCHED_POLICY_FIFO) " = FIFO (default), " __stringify(DRM_SCHED_POLICY_FAIR) " = Fair.");
 module_param_named(sched_policy, drm_sched_policy, int, 0444);
 
 static u32 drm_sched_available_credits(struct drm_gpu_scheduler *sched)
-- 
2.54.0

