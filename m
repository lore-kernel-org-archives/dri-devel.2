Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D61C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FF410F35C;
	Thu, 10 Sep 2026 08:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jkstefJ/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D3510F35F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:00:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4BF9601F1;
 Thu, 10 Sep 2026 08:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA01F1F000FF;
 Thu, 10 Sep 2026 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789027213;
 bh=baqzOEa39blnTKps4s0V+tnU2yLnDHylSJ/jJm1nfgc=;
 h=From:To:Cc:Subject:Date;
 b=jkstefJ/M6iHY40YmyEXjIWOTFz+r1hdvYUj+lnff5ZLmFtloVWE74hOYKYDREHEl
 rcAQ6EIhiP5RIVUJC7ks4IIb1tGRJCs86/AqMHBhqTKbdcYEL8Y/b8sUtsaU51dQne
 fseTJ81gOBeds85Trk+sdo44MCQKs0wS38C0nYopjzpUC628ocAAplbe5Fcr4ofHvF
 OubohARgKHFD+c/tGU2er9si6gc1rcmo9ogvgyVgJvReD/qQ+em7zUTPWusmhLxkrZ
 d7n3nZQMdrxnkany8Igj0JsBqeNzsDgoNJUYKU0US4iED19Smab1wr297t3ugAG5st
 qvAgNrYbGpfpA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] drm/sched: Introduce more locking to entity
Date: Thu, 10 Sep 2026 09:59:40 +0200
Message-ID: <20260910075942.2000338-2-phasta@kernel.org>
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

Changes since v2:
  - Fix ordering bug between spsc_queue_pop() and
    drm_sched_rq_pop_entity().

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

Greetings,
Philipp

[1] https://lore.kernel.org/dri-devel/20260611123423.39819-1-tvrtko.ursulin@igalia.com/
[2] https://lore.kernel.org/dri-devel/20260626081942.2122144-2-phasta@kernel.org/

Philipp Stanner (3):
  drm/sched: Lock drm_sched_rq_pop_entity() externally
  drm/sched: Lock spsc_queue_pop() in drm_sched_entity_pop_job()
  drm/sched: Protect entity->last_scheduled with spinlock

 drivers/gpu/drm/scheduler/sched_entity.c | 53 ++++++++++--------------
 drivers/gpu/drm/scheduler/sched_rq.c     |  4 +-
 include/drm/gpu_scheduler.h              | 10 ++---
 3 files changed, 28 insertions(+), 39 deletions(-)

-- 
2.55.0

