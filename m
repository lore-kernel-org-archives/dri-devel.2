Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05002C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371EC10EE79;
	Wed,  1 Jul 2026 08:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CETJ7gX6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AFB10EE79
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:59:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 401FD4401A;
 Wed,  1 Jul 2026 08:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590441F00A3D;
 Wed,  1 Jul 2026 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782896392;
 bh=6pYIN2YqJMmrthBPue021Qa1ABPy6rMhZOJ/H9QgS6c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CETJ7gX6hGI9ozgiHscGMmVToBNdT8eFOFnk42ccTe/Vsisl7n2uRKnNrDyTiYINe
 bAzVpUTje+cA5/SS6TsJKqd94HQLh73OO0qgzkg2mzudTdsd+NrOVmTWEU9jNpMlqu
 LEPpt3v3j6jFgkf9WimVvPXf2kvNUVUvSZ2Dnoqtm7uw8nSXnD4PwcPY/IZB0byIs1
 0bm2XEa6KOzlTcu1yZ6VlDv1V08xZxuHN9EE/lkZHz7GqmBNB795TwJ3FaapOoqqix
 r1d0rS3IiPl/FMBagGzvGjm+GB2xeV38Fq7ccixKQRu9EZHWZlRTWkUQrhbA/tIlyH
 aUTyxcxSxTBGQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Marco Pagani <marco.pagani@linux.dev>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 4/5] drm/sched: Lock drm_sched_entity_is_idle()
Date: Wed,  1 Jul 2026 10:59:20 +0200
Message-ID: <20260701085920.3253248-6-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701085920.3253248-2-phasta@kernel.org>
References: <20260701085920.3253248-2-phasta@kernel.org>
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
and an invalid lockless access to entity->stopped.

This function is in no way performance critical, so it is safer, more
readable and more maintainable to take the spinlock. This also enables
future cleanup work where the entity can be fully synchronized via its
spinlock.

Add locking to drm_sched_entity_is_idle().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 0fc1213a0d3f..cb03d6a36578 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -178,14 +178,18 @@ EXPORT_SYMBOL(drm_sched_entity_modify_sched);
 
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
-- 
2.54.0

