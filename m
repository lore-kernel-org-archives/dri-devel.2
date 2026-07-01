Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E36C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2F010EE6B;
	Wed,  1 Jul 2026 08:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WCQghcL8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A59B10EE6B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:59:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 530B7600AB;
 Wed,  1 Jul 2026 08:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499651F000E9;
 Wed,  1 Jul 2026 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782896375;
 bh=w5ZcDaSIWJHhsB2aS76I+S5sLCFLK36Re5/LClq2P3s=;
 h=From:To:Cc:Subject:Date;
 b=WCQghcL8Gyoc7pTau3w1rhDbGRntu0Ul5m1QW5vCJYrmLPaPYBTKgD8G2Yw97mg+d
 a3lZBYQ0v9ua4cDTmHBgXA93vHell+O5yM8CqxoyBovHk3xTf1rvRZ1+bwJR5tSRVO
 RqgH8q0Z3xiH0fWma3aYUgx/tLtxDXN8Xe0FEJa5K+7BPt9DdGPPMzHoGLZnR/XnwI
 n5sFHhkloKzA3SzailwtIA9qgVgf9Qlxt4t6bOdzVhUMFlWc5iNdlvzwg4l1LMJ0ev
 oPJq7nC62rTzFXRBP2/GOuoWn8QlnTUW4SnbLvi9a5y7hOouB2dQN83sRzvUcUZN9s
 FUyavMb0Et3ag==
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
Subject: [PATCH 0/5] drm/sched: Introduce the miracle of locking to entity
Date: Wed,  1 Jul 2026 10:59:16 +0200
Message-ID: <20260701085920.3253248-2-phasta@kernel.org>
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

Both Tvrtko [1] and I [2] have recently proposed some improvals for
drm_sched.

While taking Tvrtko's feedback into account for my patch, I realized
that both his and my patch can be fully replaced with a bigger and far
more beautiful series.

If I am not mistaken, it turns out that the entire entity->entity_idle
completion is also nothing but a workaround around the grave mistake of
not using the greatest helper with parallel programming that exists in
computer science: Locking.

This series adds locking to the last_scheduled field and all checks
related to detect the idleness of the entity. As before, the
job_scheduled event queue causes the periodic checks.

This way, we can get rid of memory barriers, RCU, a few lines of code,
make things more readable, understandable...


Tested with drm-sched-unit tests. I'm a bit busy right now, but wanted
to show you guys the idea. Before merging I'd test it more exhaustively
with Nouveau.

Greetings,
Philipp

[1] https://lore.kernel.org/dri-devel/20260611123423.39819-1-tvrtko.ursulin@igalia.com/
[2] https://lore.kernel.org/dri-devel/20260626081942.2122144-2-phasta@kernel.org/


Philipp Stanner (5):
  drm/sched: Protect entity->last_scheduled with spinlock
  drm/sched: Lock spsc_queue in drm_sched_entity_pop_job()
  drm/sched: Avoid lock cycle for sched_entity
  drm/sched: Lock drm_sched_entity_is_idle()
  drm/sched: Remove entity->entity_idle

 drivers/gpu/drm/scheduler/sched_entity.c | 75 +++++++++++-------------
 drivers/gpu/drm/scheduler/sched_main.c   |  2 -
 drivers/gpu/drm/scheduler/sched_rq.c     |  5 +-
 include/drm/gpu_scheduler.h              | 16 ++---
 4 files changed, 41 insertions(+), 57 deletions(-)


base-commit: be4f10d44757211fd656fa57f37034657f26c883
-- 
2.54.0

