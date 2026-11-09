Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05660606EE84
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OFX7f41l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DA610E3D2;
	Mon,  9 Nov 2026 16:07:55 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3646110E3D2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=z1QALcT9YcY855Aj6PsigUBHSBfEix7sXDBjfUwG7Cs=; t=1794240469; x=2109600469; 
 b=OFX7f41lj9BCqdI2kq3IlGFbOusdkM9k09GhbD8BxVgxDvpJ5Xys1PpqkjCm59X9Wyi3VA5z+Iy
 nx+0VA4g337vyMpDivYWCMvHnrHPQWalCPQZspnumDlpIepCe6a82vbLm4g64BdcVY+sC0G6J2M2k
 fiT5sL3h8usQ7MtwK/QyycEpoW5V6BX8gBBX+A5qcFFHDTVJpMpeZPPUDpQJxFPSyoEVIg5JGqS3G
 eCHvqUSDkqijfaHw40MvYdHqw2Rq/avrFKtxN7sIzfVZtJN1xaG0qKOX2CM8/syzzyxVEcAgUtGrb
 e1T76fKjYHWexefFBLFsah5ZT1bSSaLTsH1w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xQRuL-007QWE-Pi; Mon, 09 Nov 2026 17:07:45 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org
Subject: [PATCH] drm/sched: Ensure stopped entity cannot be re-added to the
 run-queue
Date: Mon,  9 Nov 2026 16:07:43 +0000
Message-ID: <20261109160743.17020-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
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

When entities are torn down in drm_sched_entity_kill() a multi-step
process is undertaken to synchronize with a drm_sched_run_job_work()
consuming jobs from the same entity.

First the entity is marked as stopped and removed from the run-queue,
with both the entity and run-queue lock correctly taken. The process then
waits for the entity idle via the completion after which point it assumes
it is the only accessor to the entity in question.

What can happen however in drm_sched_run_job_work() if there are at least
two outstanding runnable jobs on an entity, is that
drm_sched_entity_pop_job() can re-add it to the run-queue due the
unconditial add to the rbtree via drm_sched_rq_update_fifo_locked().

What is required is that the teardown starts after the run job has
selected the entity and that it gets to it's completion waiting stage
before the run job goes to dequeue a job, and for the run job to be able
to de-queue a job before teardown has consumed too many.

Run job will then see there is another job pending (after the one about
to be de-queued) and it will re-add the entity to the run-queue. Run job
will then signal the completion and entity teardown will proceed
incorrectly thinking it's removal of the entity was final.

End result is a pointer to an entity about to be freed dangling forever in
the rbtree.

  drm_sched_run_job_work()	drm_sched_entity_kill()
    drm_sched_select_entity
				  stops and removes entity
				  wait_for_completion
    drm_sched_entity_pop_job
	-> re-adds to run-queue due more jobs
    complete_all
				  drm_sched_entity_queue_pop
				  ... fini entity ...
    drm_sched_run_job_queue
    drm_sched_select_entity - UAF

This race existed ever since the FIFO policy was first added.

Lets mirror the guard from drm_sched_rq_add_entity() in
drm_sched_rq_pop_entity() and close this gap.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: https://sashiko.dev/#/patchset/20261020154123.33631-1-tvrtko.ursulin@igalia.com?part=7
Fixes: 08fb97de03aa ("drm/sched: Add FIFO sched policy to run queue")
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/scheduler/sched_rq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 23f46ec610e7..6f67a146d99c 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -345,6 +345,13 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 
 	lockdep_assert_held(&entity->lock);
 
+	/*
+	 * If entity is getting torn down via drm_sched_entity_kill() we need
+	 * to ensure it does not get re-added to the tree behind it's back.
+	 */
+	if (entity->stopped)
+		return;
+
 	spin_lock(&rq->lock);
 
 	/*
-- 
2.56.0

