Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1CCC561F8
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F86910E99F;
	Tue,  4 Aug 2026 10:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oCF/cfJc";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37CA10E991
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838199;
 bh=RvHXpuZkvPZY2gpIgfn5uNsN8J9DCecmCGZwPoCSsFg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oCF/cfJcl6vyl5mZwhKaGnggWneqWt09JhjKBSUw68wsqE8j5BS5mEGsH48EnnWZ5
 MmJSwRBivQVcuhryffDsT4EPVc2mXx8JbAQlOspflfUej4zfJsCv+NCG3GCeH4adrQ
 6o6Zj+KwhaesCavnD0c9UiCeLWgtTRqh1s/Wsuq+uC4TfoTHXAyo4BTzP+8Av3AFQb
 ddzrXHdWxgOFIqABmK9Fdc9A2/v05Qn4MHAmM7ktn2Cbz7nrSHNGvGfzM6oaocs7m3
 HhiOh8MszHODgb6+APsqDaoYBRw5gM5AsCix0eZ4g9sT7xO6gHW7PibNqoMW4MU8ew
 D6VlMARkaj6CQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 27B0A17E10F1;
 Tue, 04 Aug 2026 12:09:59 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:48 +0200
Subject: [PATCH 09/12] drm/panthor: Don't pre-allocate VMAs or page tables
 when preparing a full VM unmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-9-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=1151;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=RvHXpuZkvPZY2gpIgfn5uNsN8J9DCecmCGZwPoCSsFg=;
 b=QM8EMCXOVN/5GrmH1bGT4TXjDpDLBezEXKm4I/KyGMshzbRnrAFScnTSfL0nS4sQZ2m+BHDpa
 fbahScv2wmRDSHhOc6q1Bl3/BkWtl7lHghyL+fbqJOPKfx/V46bjFB3
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

In the cleanup path, we unmap the full VA range to make sure things are
clean before the VM is released. I'd rather not fail on memory
allocation in that path, so let's make sure
panthor_vm_pgtable_prepare_unmap_op_ctx() doesn't allocate VMAs or
page tables when the unmap range matches the VM virtual address range.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 1264c3ffa832..2ad8b15de0da 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1484,6 +1484,10 @@ static int panthor_as_prepare_unmap_op_ctx(struct panthor_as_op_ctx *op_ctx,
 	op_ctx->va.addr = va;
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP;
 
+	/* Unmap on the whole VM range don't need new VMAs or page tables. */
+	if (va == as->base.mm_start && size == as->base.mm_range)
+		return 0;
+
 	/* Pre-allocate L3 page tables to account for the split-2M-block
 	 * situation on unmap.
 	 */

-- 
2.55.0

