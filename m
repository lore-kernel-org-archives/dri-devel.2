Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0B606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Vbml+9K5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB5610FD27;
	Wed, 21 Oct 2026 09:42:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F4D10FD10;
 Wed, 21 Oct 2026 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=GJzeaTpZqVIxVkIIE61LYZXU2u51XkZg/vAcigcjOTM=; b=Vbml+9K5aEDDr0uW8tfzbFoFN1
 2FbVEuhxYwvHhIDdHddnORqBNbKD71jKX+A86uw0SJleFfaos6m2E3t2dFSxyN9aw/pndlhWhAIFk
 DwaqinXA073Yyn+kCuejPwuBoykDIa1PuyycVXxcyvQ6T9DNsjaRV60X7t6HaDe9imlfWv6VdHZlU
 qZwIm76hNM+Qy+IzYoj2PVHIzfsnOaAWePWatG+rmhSpQagMsLOQ1r1r6hlDNc/vEUvMZYAoJ9ugI
 cda06MhDQpFUILPr1zWNhgkt6QxGADgOIs0kZbuvwmuuP2N/pE/5BU1xZ03o4MlWLQl9dkng+FipL
 MzJlT7Qg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJSq6-005Uf1-HH; Wed, 21 Oct 2026 11:42:30 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority at
 runtime
Date: Wed, 21 Oct 2026 10:42:27 +0100
Message-ID: <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
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

Another consequence of the recent revert of
77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
is that after the revert we need to adjust entity->rq_priority when
runtime priority changes are requested.

Only amdgpu does that so the impact is minimal. Also considering dynamic
priority changes are largely broken there, due currently broken entity
scheduler list handling where the special case of a single scheduler can
never change it's run-queue. And coupled with the fact for the rest a two-
tier approach of drm_sched_entity_set_priority() and
drm_sched_entity_modify_sched() is used, where later directly maps to
different hardware queue priority by replacing the set of schedulers
completely.

Hence the regression is limited to rings which have multiple instances
other than compute and graphics, which would be SDMA only, for which I am
not sure any userspace actually does dynamic priority changes in the first
place.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e12709b7bd0c..03e68b4102d5 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -456,6 +456,8 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 {
 	spin_lock(&entity->lock);
 	entity->priority = priority;
+	if (drm_sched_policy != DRM_SCHED_POLICY_FAIR)
+		entity->rq_priority = priority;
 	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_set_priority);
-- 
2.56.0

