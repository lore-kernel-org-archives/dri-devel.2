Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B080DC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71C510F265;
	Thu, 13 Aug 2026 09:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MzQXAUGS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096FD10F265
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:46:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBB4C409EC;
 Thu, 13 Aug 2026 09:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE061F000E9;
 Thu, 13 Aug 2026 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786614416;
 bh=059QHVrIU4FvtBb6TgfpigWxRmhKDqWqWuoeJnk7aNw=;
 h=From:To:Cc:Subject:Date;
 b=MzQXAUGS1M2kFHVbkZrfMu73e9Riko+OO7Anz2PQlooQ8ze42jYGyGr8M5w66wB+U
 cYmYJ8+cTfCnjIdPT2SSx9nyy0C1W3ZsY6VVULIaZskN/HUM1HHMKrWsHKp+DSD9du
 uDtFp12fOn6dMtZA5MydOWzjMlA7DE5HyLflnnGIHpmCh+bNODtzHawtO91mLiPMuS
 6V7uc+/p7lhqqXn5xbXI0BwbcsycTVvk/LkOAP/vbEd+V3RiOArol9pgo4n/nIpTyn
 0cDuTExK9yBD5w1rRtQlPp327OIAHqggarvUg6B56XapgniNCI2y0436fGczTVbMYF
 TNhJ1f234u4bg==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Lock drm_sched_entity_is_idle()
Date: Thu, 13 Aug 2026 11:45:40 +0200
Message-ID: <20260813094539.2407911-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
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

drm_sched_entity_is_idle() contains a badly documented memory barrier
and an invalid lockless access to entity->stopped. Moreover, it also
accesses entity->list which is at all other places protected by
entity->lock.

This function is in no way performance critical, so it is safer, more
readable and more maintainable to take the spinlock.

Add locking to drm_sched_entity_is_idle().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c51101ec70c1..2d941b2b2861 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -179,14 +179,18 @@ EXPORT_SYMBOL(drm_sched_entity_modify_sched);
 
 static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
 {
-	rmb(); /* for list_empty to work without lock */
+	bool idle = false;
+
+	spin_lock(&entity->lock);
 
 	if (list_empty(&entity->list) ||
 	    spsc_queue_count(&entity->job_queue) == 0 ||
 	    entity->stopped)
-		return true;
+		idle = true;
 
-	return false;
+	spin_unlock(&entity->lock);
+
+	return idle;
 }
 
 /**

base-commit: c9a2c8ddcd65e96e7f095a87c0cc0b3211f740ea
-- 
2.55.0

