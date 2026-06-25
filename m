Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EA1CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6232C10E1B5;
	Thu, 25 Jun 2026 07:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XVCaND2r";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B224910E1B3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782373115;
 bh=hkzfYVVjGHBY3wCztOp/YoLoaiKlZ/3wLbKqqSdRsyk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XVCaND2r5sPCE+3lo0KMcHZTUAbdizmgEvu4iINNGh/THYFgQjtCyTA0cywEHmo5w
 TNtjZoyJN/UaIS1PUpz5E69D0/uc2AbpoHp2agifXkWWCvkmyvw/DuRfhEdXieyWAv
 Dsl8V7kEZjFhGZruPdzSVt9fPAkLltxsy7jZUBRBXxU+RbbWou8GEe0/VGzNzkv+s+
 h4VD+QdvEcdnS8R+Hrx5RTo7ILGUs9IBn0HLckr4NchXFfV8TjMVHfV7Z04S28IPXL
 eTdIRhMVMnxMoMGTLAUQr0Ib0+LqKvcYcGBxY/X0ZvjNU6Jmih+eFIyn4jGZBfRx4U
 N3Q5i6U0ygfjg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CD69017E0F44;
 Thu, 25 Jun 2026 09:38:34 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 09:38:14 +0200
Subject: [PATCH v4 04/14] drm/panthor: Interrupt group start/resumption if
 group_bind_locked() fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v4-4-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782373111; l=1614;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=hkzfYVVjGHBY3wCztOp/YoLoaiKlZ/3wLbKqqSdRsyk=;
 b=tKmZ9Hn+i/mJJZSjbsBZmuJwJHt0NlHnKzVrDJWkuApqH+z44+VruQzQU72ev5nOa3GdK45gG
 YiVGKIzgWNzAIVs74lF9QW6aB53XnN2bjvbjBhPH6+flQhmt0EsCX+A
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

group_bind_locked() can fail if the MMU block is stuck. This is normally
a reset situation, but by the time we reset the GPU, we might have
tried to resume a group that's not resident, which will probably trip
out the FW. So let's avoid that by bailing out when group_bind_locked()
returns an error. We don't even try to start more groups because the
GPU will be reset anyway.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=7
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a19285806c66..1caa803c2850 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2369,7 +2369,13 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 
 			csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 			csg_slot = &sched->csg_slots[csg_id];
-			group_bind_locked(group, csg_id);
+			ret = group_bind_locked(group, csg_id);
+			if (ret) {
+				panthor_device_schedule_reset(ptdev);
+				ctx->csg_upd_failed_mask |= BIT(csg_id);
+				return;
+			}
+
 			csg_slot_prog_locked(ptdev, csg_id, new_csg_prio--);
 			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
 						group->state == PANTHOR_CS_GROUP_SUSPENDED ?

-- 
2.54.0

