Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC3606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oQAGVHoG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D8610F426;
	Fri,  6 Nov 2026 14:57:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B43F10F57F;
 Fri,  6 Nov 2026 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ArC9bJG9fP0UBwI6Ku8ZtVSs2DW1c9QAxxMAeYKAuUs=; t=1793977027; x=2109337027; 
 b=oQAGVHoGhE5UukHqbNM68yYtgN6VheokhijIhclE/uXNwSVOKT+uU42fMNSsZRgLi3bJNj9OxYu
 h4eVVmWGEL/gKoy1kiwPPuggcHfw+nf+MCbouDY2oxDif54AhYGBiebHd5HUPZedEkTIlrtfyeojW
 gtXHqa+69gTFApHfNfZ/j5jM4IsTsfQRdU/WQurDnghmdiq81cav22qZYjiEjf6pmcjUObgTkcoU/
 k9kdc0TQvSPGo/x5Gnnug982HwsDcomZg/npkVQIdDl3QIVObDMURCzQbD2s7exfYVdqPu8SPREyN
 zyENtm51UBrciRUJrGHu/eJ862f7NBwROrwA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNJ-004VmZ-IL; Fri, 06 Nov 2026 15:57:05 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/7] drm/sched: Ignore stopped entity attempt to change its
 run-queue
Date: Fri,  6 Nov 2026 14:56:57 +0000
Message-ID: <20261106145702.61640-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
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
index 2844049d4c66..a18f637f9e99 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -594,13 +594,16 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
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
@@ -612,6 +615,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
 
+out:
 	spin_unlock(&entity->lock);
 }
 
-- 
2.56.0

