Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4DBC5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D719210F2BA;
	Thu, 13 Aug 2026 10:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="N0GGUirQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DEC10F2A1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618627;
 bh=f5zHXc9uXZcwLI3x1yehgFoxkAFjMfodJSRm8Oweu+o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=N0GGUirQkxPamqJZ7vPAjRvKNAeMUIyoRAX942IXC+kh58HDHEDokSQONFlGo1VCf
 WvnqMRzRkitF995bgFpbopeJBIqR9B6bjlFz7wVHbQ9mZP2oeLsE3LwyiJXDSvDrQf
 7mgDWwhu4GhI6tjS4k6rRtDVGuHFQCpAmqdS6oF6V7oMX+wdiwadls0t8lyY5o8ChK
 PC64F8FsRDrMVjjVaQY7V48TQBEmbv3b6aoWzGkqOG9+KRG7kVzx1zzI+p8kW6y7tP
 5mEZ6BIz5V4JsBQ6gtPjbiNHfTuhPXxGrluB5xKq0hrglJYusOiv5li9OCTalXbLdH
 RhNWS4oNWs1+w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8822117E0EF0;
 Thu, 13 Aug 2026 12:57:06 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:04 +0200
Subject: [PATCH v3 06/17] drm/panthor: Drop unused vm argument passed to
 panthor_vm_prepare_sync_only_op_ctx()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-6-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=1147;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=f5zHXc9uXZcwLI3x1yehgFoxkAFjMfodJSRm8Oweu+o=;
 b=xNnwOzzx4Qtf6OZw4o4aNJokM+ajf6ZD+vOknzvBc/Z8NkMrmw/ReZpJlek/djAEgGzHJrE+C
 yubx3uolKeyCPoxnQbZGzslDnDd3V7pg6B3H/N6m7bURM9+q6LmuJaU
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

