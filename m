Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9655CD2ED08
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A61D10EB2E;
	Wed,  1 Apr 2026 13:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Y/ZxV2Yj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C7110E4E9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775051348;
 bh=giSrfw7GLnGj03ZsMMUzXyxc/5BRxItoVDwxjW9HAZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y/ZxV2YjsD/GbNBiHIKM1XGMxLXi/7vsi0WZy2h1U3eDk4LeY8Kwu6+1l/PHpTbbJ
 ysCPIfnwTFfo0OETNz0/xzAVVL50nq03+yZHcoNgdTBKVoH3oYsqTu89KfSmo7ArJf
 nByHzt/jypyppoQxOJFYpYmt5cwcgYDdJ8bQ3KUognJpSjrKoG7gG5FMcPGXtIhcM1
 jnhygZynBKUfF5KwCjK73QcGMPUByfWeJ4hc0v/BQzPGNAurS4yhR+9drGMlkzs+BQ
 b+W3MD2rr25FDy6G+U0kPk9TCLhfJtVlbKd6j8AbRyO/x5CJAYiLhrImTRELNmSEzJ
 bDPcatt2pdcCw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9422E17E7527;
 Wed,  1 Apr 2026 15:49:07 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v7 02/10] drm/panthor: Remove unused
 panthor_vm_op_ctx::map::new_vma field
Date: Wed,  1 Apr 2026 15:48:46 +0200
Message-ID: <20260401134854.2275433-3-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401134854.2275433-1-boris.brezillon@collabora.com>
References: <20260401134854.2275433-1-boris.brezillon@collabora.com>
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

This field is never used, drop it.

v7:
- New patch

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f8c41e36afa4..ab67286e3a6e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -197,11 +197,6 @@ struct panthor_vm_op_ctx {
 		 * to allocate in ::run_job().
 		 */
 		struct sg_table *sgt;
-
-		/**
-		 * @map.new_vma: The new VMA object that will be inserted to the VA tree.
-		 */
-		struct panthor_vma *new_vma;
 	} map;
 };
 
-- 
2.53.0

