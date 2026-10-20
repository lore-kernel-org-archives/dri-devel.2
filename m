Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020E606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JLlMolZt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333CD10F6C3;
	Tue, 20 Oct 2026 15:41:36 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E0210EA0C;
 Tue, 20 Oct 2026 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=0v45P7fnL0anmdG6nzcNQD6SgTnL/FLePBF85A3Cvhc=; b=JLlMolZtlSTR5tXr6a/aSl5/4B
 KK+sL7scTryibedYkBOmDgbFUGg2597e1VPgsALCex9yNZPFw3yrJDVkrNx3szcwHzoSOoxcqL7BT
 T9kKE6LLw6C1tORwrJfJupHi9uc+FCs9AUHHG6nyuQuwlfIud7lGnFEiWsyPYp9qZxx+gxv+ZOc67
 tLdm0K3CcLOYjQoY3pQjmrV9FwqC8w+XenZqXb0LsqOdHmbi4G9rZTFhsG9WXLfvxIZnasYk8JLTq
 xsxeFoZWfvdhZHLKxBvkFacwo/hV95ukd8XMtVHh8tBxWZpYJR/jN8K9pu8Z7g00lmDnhqt31kMfc
 j6Fnzv8Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJBxw-004idw-Fr; Tue, 20 Oct 2026 17:41:28 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 4/8] drm/sched: Remove log message of questionable use
Date: Tue, 20 Oct 2026 16:41:19 +0100
Message-ID: <20261020154123.33631-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is no point in having a log message whose only purpose is to
notify developers of incorrect usage of the API while bringing up a new
driver. Lets simply return an error and let the developers figure it out.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index ca1665bb49cc..d86738611b1e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1104,6 +1104,9 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	if (sched->sched_rq)
 		return -EINVAL;
 
+	if (args->num_rqs > DRM_SCHED_PRIORITY_COUNT)
+		return -EINVAL;
+
 	sched->ops = args->ops;
 	sched->credit_limit = args->credit_limit;
 	sched->name = args->name;
@@ -1113,14 +1116,6 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
-	if (args->num_rqs > DRM_SCHED_PRIORITY_COUNT) {
-		/* This is a gross violation--tell drivers what the  problem is.
-		 */
-		dev_err(sched->dev, "%s: num_rqs cannot be greater than DRM_SCHED_PRIORITY_COUNT\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	if (args->submit_wq) {
 		sched->submit_wq = args->submit_wq;
 		sched->own_submit_wq = false;
-- 
2.56.0

