Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE24C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 856FA10ED27;
	Wed, 26 Aug 2026 14:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="F1pMF2WI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9728810E2EA
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756183;
 bh=GzR6HfRXlLcIDGEAtWZHYpe21WeYBskWqA2ihJfMXu4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F1pMF2WIpFr3bgmgMJNZHboiEY+5RK7VGsYFw2t7W8lqnY3ZUj4zuTfNxbu0g/NIP
 1UIEzl/VMC7gKabCS/w8vJ7izqHwAY9zwV1fF3tUG/ri06M7jz6n/SVmh09iifM942
 VNSMOpyfwgq+drOJiKpHQX2N23GRdVYJ+0pbOpm7gJBEHkm974soMre+y4lT4L40BC
 ITHs9EWhaKNYaKB9anxg51LEZrI2CWcc77W94QulSAQBUE6AN0V49/HFMYHXpXrlal
 rllkLI3/rhr85L0ivS3e41CltKf7TZGB0ZzR31Q2BKzp+EIqq/nhKX61Ls/RAI3hBt
 w2ZM8LcAPhnMA==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A9E4717E0FE2;
 Wed, 26 Aug 2026 16:56:22 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:05 +0200
Subject: [PATCH v4 06/18] drm/panthor: Drop unused vm argument passed to
 panthor_vm_prepare_sync_only_op_ctx()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-6-982cc8f4234b@collabora.com>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
In-Reply-To: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=1147;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=GzR6HfRXlLcIDGEAtWZHYpe21WeYBskWqA2ihJfMXu4=;
 b=9DfdLTo4Cssn5LWpAcGmXUCPxBNlXin39WE/2M2vfiCR6yNFx2E+DzVip/8Cl8GSmyOE4sxQ9
 Hdi2bh0yDTLCdNo0MMGhWd+WvIW+do06n/q+BdHrBp+99BQcXJECJeo
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
index b4e41556247a..44a44602b8ba 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1462,8 +1462,8 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	return ret;
 }
 
-static void panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx,
-						struct panthor_vm *vm)
+static void
+panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx)
 {
 	memset(op_ctx, 0, sizeof(*op_ctx));
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
@@ -3031,7 +3031,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		if (!op->syncs.count)
 			return -EINVAL;
 
-		panthor_vm_prepare_sync_only_op_ctx(op_ctx, vm);
+		panthor_vm_prepare_sync_only_op_ctx(op_ctx);
 		return 0;
 
 	default:

-- 
2.55.0

