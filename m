Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C68C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE02410E36C;
	Thu, 13 Aug 2026 09:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EAyrX4LI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE4D10E36C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:25:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 535C040AFE;
 Thu, 13 Aug 2026 09:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2281F000E9;
 Thu, 13 Aug 2026 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786613149;
 bh=ZhCNxiDA8SnwYZ6xcBnoRkq2TX2dfnL4cLvkGttpTLc=;
 h=From:To:Cc:Subject:Date;
 b=EAyrX4LIrUUC5q5o0FBkarYNtmFAOanDEgIGXQmD8+Kb0KboVV4QTpJYE/LQGBpxN
 7TrxzMZymhWs0KyQcV0BOv/5F3v63G4ZKFaNZX+YYzvne8YOaINp3vjzV3DtnA672J
 RgRubb+dNydjkXw648on+MDW6UHYG0s4OVsRNq3OaDrMJOoBz+6cIwP2AJN3p9upxx
 HHpfu8B3mjFxEzZEGe5CO0kw8IKUgoJ5EICbIaPFHmlOzqJoEP+JMbTS+dlfgjGWVs
 nGgRXjWlMvJ/Xq+1YNXJAWG4Eo9Ci8Gk10laS4n+1YJFMVszmELKY89OF957GLD2eF
 cKpQW1Mee0gUQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: [PATCH v2 0/2] drm/sched: Introduce more locking to entity
Date: Thu, 13 Aug 2026 11:25:11 +0200
Message-ID: <20260813092510.2385962-4-phasta@kernel.org>
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

This is for now based on drm-misc-fixes. I send it out so we can get
consensus for our work in the upcoming cycle.

Changes since v1:
  - Remove a bunch of patches; make this series only about locking
    entity->last_scheduled. The rest shall be done in separate patches
    and series. Consequently, also do not lock spsc_queue, yet.
  - Move lock-cycle patch to first position. (Tvrtko)


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

Philipp Stanner (2):
  drm/sched: Lock drm_sched_rq_pop_entity() externally
  drm/sched: Protect entity->last_scheduled with spinlock

 drivers/gpu/drm/scheduler/sched_entity.c | 52 ++++++++++--------------
 drivers/gpu/drm/scheduler/sched_rq.c     |  4 +-
 include/drm/gpu_scheduler.h              | 10 ++---
 3 files changed, 28 insertions(+), 38 deletions(-)


base-commit: 9a11db68872055e6ead919bad04d6330851c522d
-- 
2.55.0

