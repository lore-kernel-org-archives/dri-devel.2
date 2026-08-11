Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AD6C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3E710EBFA;
	Tue, 11 Aug 2026 13:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Rd8lpciX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6C710EBF8;
 Tue, 11 Aug 2026 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=8BHJdSEY80/uEIqyl9tQMiZRpxavTL1yg44IrKBMGeM=; b=
 Rd8lpciXHb882e4qcaeiMv39DITGvE9hZqe6e86w/SB2xtSMarNQ6peNbCfgP1sibWh5WTuB7OtJn
 P7/iqWjm3XCGGu2NvZ1HyTbBBecIbG4BrQh8dN3igmXuwMo8kyCtfLsAUGcNS3L2ovVMjWAWDtAHw
 WhKiOzkdgwtMRwmYK/Ll9DQQsNfFGLXrT24oWx9PNn5sRw98yZjNWrQG5XFnhdMgLk0JOjnMiHgze
 7NGql6Rcklf+c9Y/dhhOZ1pbD9g/5B1T7kG0nYdBEykuz4XrKs0adtNeZTDIfygw8ebz6t68G1Ljf
 bVoqWJX79hf1E7/3akH2+PAHeIYBuyfdGg==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpw-00H9q8-Ml; Tue, 11 Aug 2026 15:48:12 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 15/20] Revert "accel/rocket: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 14:47:53 +0100
Message-ID: <20260811134758.96339-16-tvrtko.ursulin@igalia.com>
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

This reverts commit 4f335bba019958e59c2a02c4d71b72a8457cc595.
---
 drivers/accel/rocket/rocket_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bb77b6bf0f23..3141f210fcd1 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -452,6 +452,7 @@ int rocket_job_init(struct rocket_core *core)
 {
 	struct drm_sched_init_args args = {
 		.ops = &rocket_sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.name = dev_name(core->dev),
-- 
2.54.0

