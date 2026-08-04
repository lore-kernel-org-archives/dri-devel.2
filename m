Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43A7C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C88210E996;
	Tue,  4 Aug 2026 10:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SWl9AtfL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54A510E991
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838197;
 bh=XSkdnZ3DAajEze2bLqfJRokm+VnLLdWLRJ+UFTlbJQc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SWl9AtfL9RJXNaTOSzp0kSfbd1/iSCDFvD4SO/L0e6SdfSTqZw+lr3sBPeGK56AJ6
 vV/fNRGqpjZdp/4+TSuBNI/HMHPiOnPybISC+Y5NdWF4JXvOu4cmXtjL+Y9kpVZNDc
 W1qPSvuu8/vr/apOJPBdsw+rW/vlLySPaLgIjMupG+D9ejCa5UIK2c8x5UfGwNgyVc
 uoQAki01Fl7pAZP8zySc5GLJXHKPWqGRkJOG00F6WVROfMhW6EF4AvQyiquRDDTCGg
 O92HZ2ZxBuFQK4VTs6M5PxIyfvTeA8O83LXjeejXK62K8RNbIMeECWILJ6GrMt2LtZ
 myR9cKTgaOUdQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E70117E10B0;
 Tue, 04 Aug 2026 12:09:57 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:44 +0200
Subject: [PATCH 05/12] drm/panthor: Drop unused vm argument passed to
 panthor_vm_prepare_sync_only_op_ctx()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-5-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=1147;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=XSkdnZ3DAajEze2bLqfJRokm+VnLLdWLRJ+UFTlbJQc=;
 b=MyQVSW28q59iRpuCNhgnEsXtCbVbJn9xTxh/XLYf9IvK9HLWs2UrxIOXLkMp0Jmhg765LTVEM
 lZQMnqrlwRMBj4iaYQEUqLxmZrEhfmgtVNLkePN8NOphBmUybf/izE5
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
index 0182b72f1932..fb9dec64d320 100644
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

