Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BF606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQFUykQf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91EB1129D1;
	Fri, 27 Nov 2026 10:20:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BCB1129C5;
 Fri, 27 Nov 2026 10:20:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDEE94539D;
 Fri, 27 Nov 2026 10:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C71F008A0;
 Fri, 27 Nov 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774832;
 bh=jdnt2/a/ZbMnN00rqXnxGWnUTsU4G3OMV0NCuzfNtiM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nQFUykQfesqG/I9SJFTuoB2Oq6I92Vw2E0PuaZqxx6mjXpvhxB3BXNBHyuc+IkVy0
 ZCPhMkc8JvUtfgvKg+IU3PJNf7Df9mCKgpx+4w5UuaiNLC6VCkkIe86RhlRWy63gC2
 Hfq8cZq/ZDYc8/AbTbMd4OTQROVHUwuuZjO8n+oB1X4NzovL7B/TzTNx6gF4m/0zFw
 DGYVes8EXPCCRI+oBphIdnpKmGsSS7v7QIrDSg7uzO2oY0ZJbYyttGqt1MWRGiUHU2
 yA1ruSDPP059L3Rz3annSE1CjlmnzPCpNh+Z6J3DxEyx4chTIxHW6xpwbIkHqqo6I/
 jM1ZPK5Oawtiw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ruslan Vagner <rusya92266@gmail.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [RFC PATCH 5/8] drm/amdgpu: Stop using dma_fence internals
Date: Fri, 27 Nov 2026 11:18:10 +0100
Message-ID: <20261127101812.2706432-7-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127101812.2706432-2-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
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

amdgpu_ctx_fence_time() directly accesses a fence's internal timestamp,
not ensuring memory ordering.

Make the code more robust and readable by using the (now improved)
dma_fence_timestamp() function.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
I think this should, contrary to my previous statements, be fine since
the lock taken is the s_fence lock, whereas this function's caller holds
a distinct fctx lock.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2f0349233695..9d6d92cb9734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -170,6 +170,7 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 /* Calculate the time spend on the hw */
 static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
 {
+	ktime_t scheduled_ts, finished_ts;
 	struct drm_sched_fence *s_fence;
 
 	if (!fence)
@@ -177,15 +178,15 @@ static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
 
 	/* When the fence is not even scheduled it can't have spend time */
 	s_fence = to_drm_sched_fence(fence);
-	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
+
+	if (dma_fence_timestamp(&s_fence->scheduled, &scheduled_ts) != 0)
 		return ns_to_ktime(0);
 
 	/* When it is still running account how much already spend */
-	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
-		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
+	if (dma_fence_timestamp(&s_fence->finished, &finished_ts) != 0)
+		return ktime_sub(ktime_get(), scheduled_ts);
 
-	return ktime_sub(s_fence->finished.timestamp,
-			 s_fence->scheduled.timestamp);
+	return ktime_sub(finished_ts, scheduled_ts);
 }
 
 static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
-- 
2.56.0

