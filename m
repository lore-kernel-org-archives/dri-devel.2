Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D9BC5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EC210EBF6;
	Tue, 11 Aug 2026 13:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dcE7OTpe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69BF310EC0B;
 Tue, 11 Aug 2026 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=8p1/4x3AMsIhkOHx00neB8SMGFxOVGfy/1O6GGcyvKI=; b=
 dcE7OTpeRjjz9Wya0MmhLJhDfKIN/rvLQbKdE1dBQzvSSjECU38b6l3TzEwPcq+jEoQsmU+RDZwba
 BujrkaQ4zskbl3Wyn2HIjCiu46WC58RBTkit1vuXtL1LgF66bH5OBm5QTQHxZsolyB9kaqZ7BhrO/
 ce8e4Gfr8FMv0s5jViDARrb5pD5vQ9lqm4syejP5Ts66Puhd8kFBPeUad7nLCpduI23OQUKBOizqR
 M3KFqS7f3bNXxVDrCwzIHBnNNLjYG8M4GOpLt8BlWpNM4DcsNm9nBnEGB4cg8JgOMd5i1INJoCz31
 DpZxs7UesTpZEmLP1rbpWVsNAdnNvvtIug==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpt-00H9ou-Hu; Tue, 11 Aug 2026 15:48:09 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 11/20] Revert "drm/imagination: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 14:47:49 +0100
Message-ID: <20260811134758.96339-12-tvrtko.ursulin@igalia.com>
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

This reverts commit f84d73d2a08498174d950ba5935930dd94df7d3c.
---
 drivers/gpu/drm/imagination/pvr_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 9e759421f075..24a8645aa913 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1285,6 +1285,7 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 	const struct drm_sched_init_args sched_args = {
 		.ops = &pvr_queue_sched_ops,
 		.submit_wq = pvr_dev->sched_wq,
+		.num_rqs = 1,
 		.credit_limit = 64 * 1024,
 		.hang_limit = 1,
 		.timeout = msecs_to_jiffies(SCHED_TIMEOUT_PERIOD),
-- 
2.54.0

