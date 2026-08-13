Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BB1C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C0A10F2BC;
	Thu, 13 Aug 2026 10:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fkyZ7yaf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFE210F2A7
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618631;
 bh=eIGFqWwRdHzc0YJCpTSG0l4q+0hV+wtL1nhMwVIM0fw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fkyZ7yaf2Qi4VPtneiVIqnMTTl9yJAdteFwyPkTdhVB2Nr2lQC6iB+36ij/Hb6B/S
 vhmuZ+DWTmDllrzalkzHz7QnHxRZiknq0i7ieYDpxpf/LfuuvPRON7h9me3dbV2yjC
 Q5ZfMHmbN5H1BxXWz4N/R5ADbS39rg0vbuJybfUyHbJZnEdngTVmfd1Kz7kOq8wCh2
 xcdFYUP2M5UzMzL7QXY7vQBDBFbJMiwsEpnB/j8K/PaQEzD6vuhcpqeYyesr9T8nKG
 +HypgXIGkn+IhVdQcc3HQry92tuX4IYps8ve9V+4RfMTJ/fwZ7sDzYd7OL2GBpWasO
 SfVlgqzDuOakA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 51CFE17E12A2;
 Thu, 13 Aug 2026 12:57:11 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:09 +0200
Subject: [PATCH v3 11/17] drm/panthor: Don't pre-allocate VMAs or page
 tables when preparing a full VM unmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-11-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=1151;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=eIGFqWwRdHzc0YJCpTSG0l4q+0hV+wtL1nhMwVIM0fw=;
 b=fa4HtmagwvGR0D9NJDH7N3QdJ0vf2bkumMgvZ2tqzec3OOrs4OV3sEaFK7XMDYt34R7F6gTMS
 r1Pd8HVXqOyDYCKlqGpAJlFKbxzcVUs7OKrARFlXg3Zx7FYNaPY/IFQ
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
index a48466788f4d..acdc0dd04f8b 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1466,6 +1466,10 @@ static int panthor_as_prepare_unmap_op_ctx(struct panthor_as_op_ctx *op_ctx,
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

