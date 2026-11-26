Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C76606A330
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJ40hVab
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F7F112632;
	Thu, 26 Nov 2026 17:21:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C1710EA3D;
 Thu, 26 Nov 2026 17:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A65A60CED;
 Thu, 26 Nov 2026 17:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51571F000C6;
 Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795713681;
 bh=qsGW6dVCn6imW0/lV9Clz9pMRKg/IwJXR5iUl70F8/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cJ40hVabU2mFW3Sk1Nnq/KWHeDsN3SleHx1p5lIwOStC3wYLO+DKPJhQAdjLwzYeF
 PDP1la/VPtjsMzKckH36pFkwz8fQPbcSOV3o+6dodWnK9eLya8t1ILlpLwa6pjZ6sb
 YctBM667YvDeqwXd+2wDO5KDU/lfPGKU9w+NJWEqBP2mm/JNQbUl/XLPfJngV1Y5so
 7bCN3hK4Bq6foMexYiXtXQDhJ3V7WwvEJ3FugcAT8vIaxZD1F5Vy9+xwJMyv4SGu58
 KmDpd4ym25yX3zWWHayCpO1vdDNR0otJqkMTwr0Jx3MiEJ4iuoplmRRWL+jHlPAtLh
 MN1m6Lcw4KsXw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: [PATCH 2/3] drm/sched: Hot-fix timestamp misordering
Date: Thu, 26 Nov 2026 18:20:46 +0100
Message-ID: <20261126172046.2473303-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126172046.2473303-2-phasta@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_fence timestamps could so far be written and read without any memory
ordering, a bug that presumably got overlooked because x86 is strongly
ordered.

Hot-fix the scheduler's manual timestamp evaluation until we found a
more suitable solution for mainline linux.

Cc: stable@vger.kernel.org
Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 99252674e266..3d26a48ff1c3 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -928,8 +928,16 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
-			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+			/* Make the scheduled timestamp more accurate.
+			 *
+			 * TODO
+			 * The test_bit_acquire() is a hotfix against timestamp
+			 * misordering. Replace it with something better.
+			 *
+			 * The counter-part of the barrier is located in
+			 * dma_fence_signal_timestamp_locked().
+			 */
+			if (test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT,
 				     &next->s_fence->scheduled.flags))
 				next->s_fence->scheduled.timestamp =
 					dma_fence_timestamp(&job->s_fence->finished);
-- 
2.56.0

