Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA66C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6253110F353;
	Thu, 10 Sep 2026 08:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZuOJwkwt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0227E10F353
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:00:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7AD4760216;
 Thu, 10 Sep 2026 08:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A731F000FF;
 Thu, 10 Sep 2026 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789027220;
 bh=hdqZMf+Q3fCD1KfNYFni9UVbypZbZ+uQ54oqG5U6q0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZuOJwkwtd0qQW5pYo/dNkTIcXlgqCpRDYdc53tWdkiDOvRVSrJv9y4h6I4x2SXLRR
 NXosFSngbQEtSzPY9M8u7L1thsIBucnGPkdCsGW/pjGaSvD/M7LX1tsGp/Icwbn3T+
 nDwb1ra877GdvjlxIRM2mzG9w5GX1YdctgodwyL5FQM4Vjl2sq7poF4lTFsqLEDdfF
 shbGov40PL3byTTjLXvoGI0/5TmOWuaNf5uOP7Uc/4UXkWneIgbfvhhmpUXR1PdVbx
 RewTVhvoxlejjVueYr5jstxpNgGc+JNGLKpo5Fq+2UX9YHANGXhkDsWOAELOVpjuKT
 Ort/MA8mc1qOA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/sched: Lock spsc_queue_pop() in
 drm_sched_entity_pop_job()
Date: Thu, 10 Sep 2026 09:59:42 +0200
Message-ID: <20260910075942.2000338-4-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910075942.2000338-2-phasta@kernel.org>
References: <20260910075942.2000338-2-phasta@kernel.org>
MIME-Version: 1.0
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

As a preparational step to lock the access of entity->last_scheduled, it
is necessary to lock the call to spsc_queue_pop() in
drm_sched_entity_pop_job(). The reason is that later the existing lock
needs to be moved upward and the relative order between spsc_queue_pop()
and drm_sched_rq_pop_entity() needs to be preserved.

Guard spsc_queue_pop() with the existing spinlock.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 274d7a702298..e168f445f2ab 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -563,9 +563,8 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	 */
 	smp_wmb();
 
-	spsc_queue_pop(&entity->job_queue);
-
 	spin_lock(&entity->lock);
+	spsc_queue_pop(&entity->job_queue);
 	drm_sched_rq_pop_entity(entity);
 	spin_unlock(&entity->lock);
 
-- 
2.55.0

