Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A79C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A47810E822;
	Mon, 29 Jun 2026 10:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FTRcHEnd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB16A10E80E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:40:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4FD9432A3;
 Mon, 29 Jun 2026 10:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618191F00A3A;
 Mon, 29 Jun 2026 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782729650;
 bh=BNR91HuruOnHavdjUljqtyXHMBNtoJ01dkm89Xgz4aU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FTRcHEnduaIJhlg8wxOeuDzRaEMjhvg9wAAkhV7ED98Ed/xv3rAK1ffIgeZMe3zVT
 lgqX+5leO789VvUF8LlRSU538O9RYCbRA8KvIyUdIlVirqEIMe/xER5J2JpIq0Xuid
 TlNCQeKQF2jNtekdpPbeP7vcHnsyexjFjZ1kxHX5+9CoQSY6lYskBb/6h5SCJePPn4
 JOZzMLSJe4oV4X58gkRn/aGuEIBEhagn7B1fWbmwhABEZ3qdB2+Ta66cX6xw6oL+En
 AJlpldEZBPM7yDMzimvyiPOZs84OPLCppNQDVfeJqhr8NgqmxKWTaGIDdkbFrcjGug
 hk3vXLPpYx6sQ==
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
Subject: [PATCH 2/2] drm/sched: Deprecate drm_sched_wqueue_ready()
Date: Mon, 29 Jun 2026 12:40:41 +0200
Message-ID: <20260629104040.2695163-3-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629104040.2695163-2-phasta@kernel.org>
References: <20260629104040.2695163-2-phasta@kernel.org>
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

drm_sched_wqueue_ready() stems from an old rework, see

commit faf6e1a87e07 ("drm/sched: Add boolean to mark if sched is ready to work v5")

That commit moved tracking of the hardware ring's state was moved into
drm_sched.

This is highly racy and problematic and something that should most
certainly be covered by the driver.

Deprecate drm_sched_wqueue_ready().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c4e4ac436a86..35a7892c8dc8 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1198,10 +1198,14 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
 EXPORT_SYMBOL(drm_sched_increase_karma);
 
 /**
- * drm_sched_wqueue_ready - Is the scheduler ready for submission
+ * drm_sched_wqueue_ready - Is the scheduler ready for submission (DEPRECATED)
  *
  * @sched: scheduler instance
  *
+ * Deprecated, don't use it in new code. This function was added to have the
+ * scheduler represent the hardware ring's state, which must be represented by
+ * the driver's respective data structures.
+ *
  * Returns true if submission is ready
  */
 bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched)
-- 
2.54.0

