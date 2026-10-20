Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DF606A325
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oSuOnz/O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE9710F6A2;
	Tue, 20 Oct 2026 15:41:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F303010F6AC;
 Tue, 20 Oct 2026 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=kJ9lSTAM9wjORVxlqlLv7eIa1m/lenaWHPp4UX0hMMg=; b=oSuOnz/O9LRYmAg5memfcztyB0
 qoH9HE1z+jRX2eEahTxJAvoNjbOklOZ8PzPUO0Cnk5CJdWqcLHZIvUqDQd40R8+JLR4eAtrSNmEOA
 ffGtgm9RNaVBtV5+E1jYL3SAmXEb2uRhlcFn0Rl9pkqwY/oy1CMcwbUUfS2LSRo8fl1UnlhV+TQJh
 f+ffjNGbdcvufPqzzS+RlvxX/+ICxfryLfpfckrJFZkoRbp5Q1dNI4u+LnUurr14e5WGs9Fjt4RwP
 faEh283gzXumvlHmTs2Cj3KmjMLRYgQKpIXhziqNHU7fDqf/suD54wnjlaVXe5IM6HKJ5I0n3tXMx
 J5+TrQGA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJBxx-004ieN-UC; Tue, 20 Oct 2026 17:41:30 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 6/8] drm/sched: Ignore stopped entity attempt to change its
 run-queue
Date: Tue, 20 Oct 2026 16:41:21 +0100
Message-ID: <20261020154123.33631-7-tvrtko.ursulin@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jobs submitted to a stopped entity do not go anywhere due how they are
handled in drm_sched_rq_add_entity() so there is no point to allow them
to change their run-queue. We can simply bail out early which makes
entity->stopped a clearer boundary than it currently is.

This is completely safe because it is always guaranteed entity->rq is
valid if drm_sched_entity_init() succeeded.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 95bb79b3d003..3ca671af02ed 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -584,13 +584,16 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		return;
 
 	spin_lock(&entity->lock);
+
+	/* Cannot submit to stopped entity anyway so bail out early. */
+	if (entity->stopped)
+		goto out;
+
 	fence = entity->last_scheduled;
 
 	/* stay on the same engine if the previous job hasn't finished */
-	if (fence && !dma_fence_is_signaled(fence)) {
-		spin_unlock(&entity->lock);
-		return;
-	}
+	if (fence && !dma_fence_is_signaled(fence))
+		goto out;
 
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
 	rq = sched ? sched->sched_rq[entity->rq_priority] : NULL;
@@ -602,6 +605,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
 
+out:
 	spin_unlock(&entity->lock);
 }
 
-- 
2.56.0

