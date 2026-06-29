Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD77C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B96010E048;
	Mon, 29 Jun 2026 08:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FHe8fJqD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9196F10E048
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:36:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6E5960008;
 Mon, 29 Jun 2026 08:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC21B1F000E9;
 Mon, 29 Jun 2026 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782722199;
 bh=FqhdTVMcMiRVErlXsbNjOwNML0uoWB/4mhp8XjRjDAg=;
 h=From:To:Cc:Subject:Date;
 b=FHe8fJqDoK5RU3EqLvJSvfgv05CJTRJPb8iN6CtrZX68HpAB0moktMjYDF+b6gRpf
 x9ZB7sYsdvJmtKB2ZQixE37UvQpIh9inbqmitNobjDRQAsyVtxz9FczASVrfzIfYUD
 GJb1d8RUR0sEXsF6fM8MbCcBOvxo+eRH8Hiz/Tohmxsf2eBcl2Xi3fwpXJkYh31W8Q
 IAjViERH3vm1UlmZOYIaVAcITz0k4AUjOD540xs7lGNhiT+0i60PK2S44q8mH+4ADW
 Gkx6vznMiMAk3CBFhKicfJRc8RZQhndv2aBqDxcPUVrQxwhbxXbuV+fpEPN6CNbDk6
 9zFsd5bVfAMxQ==
From: Philipp Stanner <phasta@kernel.org>
To: atthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Remove relic from entity docu
Date: Mon, 29 Jun 2026 10:36:32 +0200
Message-ID: <20260629083631.2547199-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
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

commit 4827d6d83f07 ("drm/sched: Remove racy hack from
drm_sched_fini()") removed the necessity to mark an entity as stopped in
drm_sched_fini(). The documentation, however, still details that.

Update sched_entity's documentation.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d61c19e78182..363d13fc929f 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -217,8 +217,7 @@ struct drm_sched_entity {
 	 * @stopped:
 	 *
 	 * Marks the enity as removed from rq and destined for
-	 * termination. This is set by calling drm_sched_entity_flush() and by
-	 * drm_sched_fini().
+	 * termination. This is set by calling drm_sched_entity_flush().
 	 */
 	bool 				stopped;
 

base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799
-- 
2.54.0

