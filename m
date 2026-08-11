Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15EFC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2613510EB4D;
	Tue, 11 Aug 2026 11:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="K1FMKop4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6310EB4D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786447421;
 bh=vHJduzfqNFgbMCmyvy9Sf2suzsd3wy07CJG+Q7XSuCE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=K1FMKop4jh9+PAR3huBi9KXh3nVE6uAK/ff1TPzZkLRuJAlgZZsBdDxmg6pUL8orw
 nehFor6MLAYiyBTqFkZgWG6i649tLhZ+lwlqEt1dYqXoHEJ2WCpTKw1NAas2r9YMk1
 HOtUmYFAdwrXPzuwoHYUaJnKK3I0xjQ2Wl8ERmP6KKBqGcQSd05WI4REeDjlzUSnSM
 PZmkUd/7lQANhNMO/oWiRxB1W3vnHmqFtJ4Q7gbugNb8iyBdP3llEGp24ed1eg/QAQ
 8BdZBBlQ5KpR72BRbpX6nLm140AxMYily0GQoxtmA1El2aBvm6fAEbOCGUVFiewwho
 m1RENNWO0JqDg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FA7517E0F83;
 Tue, 11 Aug 2026 13:23:41 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 13:23:39 +0200
Subject: [PATCH v6 5/9] drm/panthor: Get rid of panthor_group::fatal_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-signal-from-irq-v6-5-12f2ab53d735@collabora.com>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
In-Reply-To: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786447418; l=1093;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=vHJduzfqNFgbMCmyvy9Sf2suzsd3wy07CJG+Q7XSuCE=;
 b=4l/aiZ2/+co2EJ+kXB8pTsnjGOyqH4o0TTsJPAtRyOXN4mOdXGdaYmS5aY2VHMpmu+9JbxoN6
 32pbD2RhcgbDB1sZD+PqvJd6htGt8kV3Ioh5hOH6d2Onug8eS3xry7C
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

