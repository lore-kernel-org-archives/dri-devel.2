Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78ABCDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159ED10F24F;
	Thu, 25 Jun 2026 10:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A3tQPUVB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A0710F24F
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:49:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 305E260018;
 Thu, 25 Jun 2026 10:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E11F00A3D;
 Thu, 25 Jun 2026 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782384553;
 bh=tyNOuSGWa5+Rly53LmNbMQLpph/AWKvqGd2joeA46v0=;
 h=From:To:Cc:Subject:Date;
 b=A3tQPUVBP2wgG77tbLbXKdyRIiqq2XXHyYh7/wC97/Ce3m4Mkx8Fe9a+i4DBvMXfp
 1lO0SOij3fQhKp804No5vRdVSAORgcXuKOZDDHyCYxC+UF6oQwF2jsmJEf9e0RDoWs
 lM2w1AnB2pL1ohy49hITHoS1HkQiHcndtTvUGV3W+sfEOIuh6X3RPczR1k+rLQqF2v
 +OIa7E7aylWf4mgxu99FKAk7omcsJR8QSgBVSccYn4z0Os4NVctkDV0LY6WE6pULtM
 W0fNGkq4ujVmt+IKhAiIWvFlAeVmT28ckZo7OExGENDnUO+BaZ7c/q7YEWhYRfnENU
 LKd3BZRfJR7KQ==
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
Subject: [PATCH] drm/sched: Remove forgotten header
Date: Thu, 25 Jun 2026 12:49:04 +0200
Message-ID: <20260625104903.1713213-2-phasta@kernel.org>
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

sched_main.c still contains the spsc queue header, which is not needed
anymore in that file.

Remove the surplus header import.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..9446b08fff1c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -77,7 +77,6 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_syncobj.h>
 #include <drm/gpu_scheduler.h>
-#include <drm/spsc_queue.h>
 
 #include "sched_internal.h"
 
-- 
2.54.0

