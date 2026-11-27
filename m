Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDD606A329
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k30r4jhX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EDA10EA85;
	Fri, 27 Nov 2026 14:25:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3D910EA85
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:24:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED74E40D7A;
 Fri, 27 Nov 2026 14:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357B71F02803;
 Fri, 27 Nov 2026 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789495;
 bh=uhHRm7kkzjKan9LF2/vrmffawdqZAtwXopyG8TlGTSg=;
 h=From:To:Cc:Subject:Date;
 b=k30r4jhXruTX9fAgzYXVcEn+/p7pBodzmjKKm6vNxHihGUwEKH67H874pxz0AOmX1
 cSq3ignEBGX2ahiYLauxK6C56tQNPxC2PjBz4L/gH6ETsbv0KRInS58AuSIrFicUAg
 hsVkUa9D+X0thZ4HdAxkPeAJ0oeXQlwd/bpJfprPl5a/w2Cw/6DRoFXWBn0V48p1Vr
 pIo99ma24g2BeXuXQqmG2/ORQxIgTC+kJgxozyKhYqngeGQoRP4p+CW3JrfrjL5qpp
 fFfYvVRJBBxI8aaobhNpElUK81cAEnpVldduOqR9XIlFYdfkjA0Zwk6n5t8Aor2T/G
 aOdmLNMkzZ4sw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: [PATCH] drm/sched: Document reclaim restrictions for
 ops->prepare_job()
Date: Fri, 27 Nov 2026 15:24:27 +0100
Message-ID: <20261127142425.2956053-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_backend_ops->prepare_job() gets called from
drm_sched_entity_pop_job(). Thus, it's in the fence critical path where
a memory reclaim might wait for the job / fence to complete.

Sleeping in general seems to be (currently) allowed in prepare_job(),
but a sleeping allocation risks deadlock.

Document the allocation pitfals for prepare_job().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Didn't we recently discuss deprecating this callback for good?
There's a great many users, though...
---
 include/drm/gpu_scheduler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 3b0978fa8cf0..1e4d0399a9b9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -447,6 +447,10 @@ struct drm_sched_backend_ops {
 	 *
 	 * Can be NULL if no additional preparation to the dependencies are
 	 * necessary. Skipped when jobs are killed instead of run.
+	 *
+	 * This gets called in the job submission path (dma_fence critical path).
+	 * You must not perform sleeping allocations in your implementation, or
+	 * deadlock can occur.
 	 */
 	struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_job,
 					 struct drm_sched_entity *s_entity);
-- 
2.56.0

