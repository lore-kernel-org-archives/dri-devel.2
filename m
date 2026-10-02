Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D477CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442D110F902;
	Fri,  2 Oct 2026 15:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ELDmiyYZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A35E10F8F1;
 Fri,  2 Oct 2026 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ImZuupjvKmkCwGnQO//80uL5/d0IuR7aOd3RD7PNRlU=; b=ELDmiyYZe2liGxyXi43K7g4RQo
 V9SROnQm0a5595QmRD9rkRbk5rzCsyuY+YTKiZr9bAs+Er6EcA6ZZF4lCMotvDesvkL2Ql5T4PfS5
 N4NONxaFAAhOyAQHmbIMAV5PSrjYEM7opZMn5IwVH/76UQ78D7OeZGBE7X6dbzI731contWsMGea7
 BB9G1PD4HJcOL3VDFXmzzVo1t/nZ31EeK7ADYuUoidDkrDm0p1BRObod8lwcVaWUvh5EADk2ZbWuW
 257Mq75LZVU71Y+T9fgr5ZbMSzBF3o2Om067tTxZb4pirGpJtSzq0JrLDOsjP9LBE2Uaxaq7Jdtxo
 zKnauW0w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTl-00Afm4-3D; Fri, 02 Oct 2026 17:47:21 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 7/9] drm/sched: Ignore stopped entity attempt to change its
 run-queue
Date: Fri,  2 Oct 2026 16:47:11 +0100
Message-ID: <20261002154713.77591-8-tvrtko.ursulin@igalia.com>
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
2.55.0

