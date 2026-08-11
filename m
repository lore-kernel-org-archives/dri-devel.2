Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE4C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8338C10E2C5;
	Tue, 11 Aug 2026 10:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OzGbDw8E";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C2110E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443470;
 bh=f5zHXc9uXZcwLI3x1yehgFoxkAFjMfodJSRm8Oweu+o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OzGbDw8EFWezx8eO4KXDeaIzzu0pCm4mnRLuJtXR5ak7UFhhxhst3b23Q5cR2nUez
 W3HAk2IyZ2X+EETQ8hCtYg0wRCj0QzpqmyIfRWGSmErQ55CGTvB9ZUswGCSKuBdtmq
 gGSW+QbKYhMwGhCLV4X7YEBG3pgBy+jhBvNH2II9n78zhe6KQsx+4bVGqitIriZb6B
 +7QeCZVO/qt91FbZuj4IfzF9AZ8ePCbGX6xt/5JAefaPXKcEyIrN8qnunGqy0d0EQQ
 IZhRZVGTtxHoXG5wsq1kkv6A+r8cEVc0+hiBxQFl2QBwwLl65O67U6H7Yg5ugiP3BY
 iv6APB3xgkhMA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5578A17E0FAB;
 Tue, 11 Aug 2026 12:17:50 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:40 +0200
Subject: [PATCH v2 06/17] drm/panthor: Drop unused vm argument passed to
 panthor_vm_prepare_sync_only_op_ctx()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-6-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=1147;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=f5zHXc9uXZcwLI3x1yehgFoxkAFjMfodJSRm8Oweu+o=;
 b=SAigtzJNZQW4wmzNQ7W2aqpetbGDJ0MU8kbCobcaec2UpsJ5uz4iRfIV9kbidNSrQOReu28Dz
 uKcF1VfTsclCZ7gFK4W8yw0MwApEtRJK7vv+zSmRO1BQV9+77uGY5OI
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

No need to pass a panthor_vm around if it's unused.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 0b862d3c3605..6c48e88ad17f 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1463,8 +1463,8 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	return ret;
 }
 
-static void panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx,
-						struct panthor_vm *vm)
+static void
+panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx)
 {
 	memset(op_ctx, 0, sizeof(*op_ctx));
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
@@ -3026,7 +3026,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		if (!op->syncs.count)
 			return -EINVAL;
 
-		panthor_vm_prepare_sync_only_op_ctx(op_ctx, vm);
+		panthor_vm_prepare_sync_only_op_ctx(op_ctx);
 		return 0;
 
 	default:

-- 
2.55.0

