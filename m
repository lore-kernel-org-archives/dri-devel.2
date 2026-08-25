Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D815C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B58F10E949;
	Tue, 25 Aug 2026 08:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MHH7KxEL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADF610E939
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787644892;
 bh=cuoeQG2pazNi+8YJl21F2Xuphl17v5B8h0qeDM459J8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MHH7KxELm2irNFgtVxWOn8pKtag7WT7rxysamsSYtrwEA7Bq32lmzuNui6UOInpBb
 i68n34FRkaBmdkzss8l0LFYl27saXHHcqwQnsLqvCI5QIay3T33G5pi7zEgzawAScg
 jpjI/MEoEDrQCnbAivXCPbQtBfs6F0LxokiMWTUQbRz68fmNKMIqyviG5os2PqOgLK
 KLUdyYj5DF5MXTYDQbkfaFmhGC6dkK4Ralq+KwuYoRAXSLvDXY/O+olihw48+VOGj1
 rIpKsvsbWGi/IWXg3p1U76uW5pxcG3Cj5B9LMsthOtQmFUnIYeVZcac+zxoJJFWB8e
 DMANTSom0Telg==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8905917E0BBE;
 Tue, 25 Aug 2026 10:01:32 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 25 Aug 2026 10:01:26 +0200
Subject: [PATCH v7 5/9] drm/panthor: Get rid of panthor_group::fatal_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-panthor-signal-from-irq-v7-5-ebb5b4c891a4@collabora.com>
References: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
In-Reply-To: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787644889; l=1191;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=cuoeQG2pazNi+8YJl21F2Xuphl17v5B8h0qeDM459J8=;
 b=w04oY8pXl+hnGeoyg7SFb4HPblGqb0wVxOVO33lHvddMDmxP388OA4VRexBz+y9WQLPh5Thg2
 oLnYfTj94pLCqlC7YjfAF3P8VPVkgv/XLMgwbR82h9jLaDtovcplZFW
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

This lock is never used, and we're about to make fatal_queues an
atomic to cope with concurrent updates.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index baa06731797c..9adf1e21eb83 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -565,9 +565,6 @@ struct panthor_group {
 	/** @idle_queues: Bitmask reflecting the idle queues. */
 	u32 idle_queues;
 
-	/** @fatal_lock: Lock used to protect access to fatal fields. */
-	spinlock_t fatal_lock;
-
 	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
 	u32 fatal_queues;
 
@@ -3675,7 +3672,6 @@ int panthor_group_create(struct panthor_file *pfile,
 	if (!group)
 		return -ENOMEM;
 
-	spin_lock_init(&group->fatal_lock);
 	kref_init(&group->refcount);
 	group->state = PANTHOR_CS_GROUP_CREATED;
 	group->csg_id = -1;

-- 
2.55.0

