Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA464CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD9710E63A;
	Fri,  2 Oct 2026 15:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qi6IO5v8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81D310F8E0;
 Fri,  2 Oct 2026 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=7ft/q98GUrJ7TX5RmiLNsVRWpyj/puWeXVh9jNvBcf0=; b=qi6IO5v87ypsuJJj9ZYpgUTxqa
 0BFBtA647QwD/G14PioxUwnXzdebmU5Avzh2pVnHCO4n0sBtXgMBB7EahHyITaw/X/5d8b7jI0X23
 njvCW1/6GesSDdM8hDjUtw8P9PR9ZDbzOiZlf2Kk7CCpTtCuKfKHWvffme4K3Dv3GHZSBNcS2EAgG
 FYEuWiJo8HmXhaobmZcwsH+Jl8ni5iw+zPgNj/M/a3uR+onjabOlRORx0qK56keOD7CFcKDkHnewT
 dVydiq2kIZEW0oE/1WdSDV9bgXoZGct7j2U1pfnqc2549ID3hXL3K+zM2O4Bvc1UMjcUrg+mnGmYc
 qOLuvZBA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTi-00Aflb-R3; Fri, 02 Oct 2026 17:47:18 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 4/9] drm/sched: Reject double scheduler initialization
Date: Fri,  2 Oct 2026 16:47:08 +0100
Message-ID: <20261002154713.77591-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
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

There is no point in having code and logging whose only purpose is to
notify developers of incorrect usage of the API while bringing up a new
driver. Lets simply return an error and let the developers figure it out.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index aba5545033ac..bb89c169d553 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1102,6 +1102,9 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 {
 	int i;
 
+	if (sched->sched_rq)
+		return -EINVAL;
+
 	sched->ops = args->ops;
 	sched->credit_limit = args->credit_limit;
 	sched->name = args->name;
@@ -1117,13 +1120,6 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 		dev_err(sched->dev, "%s: num_rqs cannot be greater than DRM_SCHED_PRIORITY_COUNT\n",
 			__func__);
 		return -EINVAL;
-	} else if (sched->sched_rq) {
-		/* Not an error, but warn anyway so drivers can
-		 * fine-tune their DRM calling order, and return all
-		 * is good.
-		 */
-		dev_warn(sched->dev, "%s: scheduler already initialized!\n", __func__);
-		return 0;
 	}
 
 	if (args->submit_wq) {
-- 
2.55.0

