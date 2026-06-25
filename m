Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8CBCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AA510F29E;
	Thu, 25 Jun 2026 12:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QuO6NzsJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9D710E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391232;
 bh=yx9hawI83xM0bKBVn9h6tWl1wS9JbU7rfhE200y+lzk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QuO6NzsJg0Ri8GrHWp9e4CpYdoCxMdEeArdOGpyuTP3UDN3u8o7syn7QPMjEhCELO
 DSDrdfgpoZqxqs/ub2Qhg+0ksbz67mH/fvP9v0SFtCkwWCJ/0E6LcguqjdwVwQazZD
 /JRvR69WQmFCD5AzwrzgJiQwCvBPKwO+auOqJ97GmchZ/VFDoq16PAV0HiULOyHRwm
 m5e43MqUnPKJPn8Q+rqaPCwvwZDNaqOgsV1ctwfTJRVg9txzNvRLj/b5vBhz83DDLN
 +S1BtkoijFGLo5XPKmhf547iF9Xl2pu7xdFN0CPLbVWu0WGqw3GhVaKyrZuMu5pViv
 F6dA5i4TfCnlA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 409F517E0F44;
 Thu, 25 Jun 2026 14:40:32 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:30 +0200
Subject: [PATCH 04/11] drm/panthor: Fix potential invalid pointer deref in
 group_process_tiler_oom()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-4-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=1197;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=yx9hawI83xM0bKBVn9h6tWl1wS9JbU7rfhE200y+lzk=;
 b=B9AVovW/1s9Oo6T9DGL+D5IUQ+HUDTytIJLf7HQnRTGXeOBMYzqhAn3m0FgJyNVhMFNXRMFuh
 p2GEwfQfuXyAKNzmFfvuFFyxasqD+6I44h1o6geeA8EmBBBFmvqfNv1
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

If heaps is an ERR_PTR(), panthor_heap_pool_put() will deref an invalid
pointer. Make sure we set it to NULL in that case.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index e97f29469d28..8fd4d97b062e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1600,7 +1600,10 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
 	if (unlikely(csg_id < 0))
 		return 0;
 
-	if (IS_ERR(heaps) || frag_end > vt_end || vt_end >= vt_start) {
+	if (IS_ERR(heaps)) {
+		ret = -EINVAL;
+		heaps = NULL;
+	} else if (frag_end > vt_end || vt_end >= vt_start) {
 		ret = -EINVAL;
 	} else {
 		/* We do the allocation without holding the scheduler lock to avoid

-- 
2.54.0

