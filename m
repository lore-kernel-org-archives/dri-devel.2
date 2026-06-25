Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBCACDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A32B10E1FA;
	Thu, 25 Jun 2026 12:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OHhLDGx9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D588710E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391231;
 bh=rZ+Pt2KTgzwEomnvD9y63h3OCHEG3EiJL4tdpUwLQrs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OHhLDGx9PX3XfdY5NCzCL2dZT+O6xUacDmweav8dCs+Q6EiePBFA74xwojNghkp/D
 o8iIU46W8OWA48lqrbt7rH+tHVrRM9STLe1OUYs5FqfaNC0kouZ2SwLGZKDeY7xitp
 YLl2Lo3KJpE6z6MaKeSagQO4EkRYz13N/vi+o85UqQJZdZfms2Ekq+GUGLewstZntn
 KHlY7zH1U2vF6WWyczZEjbXlIWUpjRd/xO3scgxTwoO9okPUPyBX9nydpUarycLwTu
 VAgMtgFRYW3ZGy/QWJ8G5GNZZFFTORGP5fH3A+b7rr8MNFso62NIoInUm+Xc6/EazU
 PYszgMHdqp+kQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E684517E0CF3;
 Thu, 25 Jun 2026 14:40:30 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:28 +0200
Subject: [PATCH 02/11] drm/panthor: Keep the reset work disabled until
 everything is initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-2-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=1553;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=rZ+Pt2KTgzwEomnvD9y63h3OCHEG3EiJL4tdpUwLQrs=;
 b=E3b9wk9UakPcaJ+D15FjfgaIF4RrG8FTc3FDnbDYO3zMuBGv5vGsFsycr/haoYMUbkzfjEtAk
 l46IqvZzG7lBbii9NobbAqN56zGJmLORyJUXu9VYDvKUrSqp14aZ0H3
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

The reset work will sub-component reset helpers, which might not be
ready if the reset happens during initialization, leading to NULL
pointer dereferences or worse.

Avoid that by keeping the reset work disabled while we're initializing
those sub-components.

Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=4
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index bd417d6ae8c0..0b25abebb803 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -207,6 +207,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 	*dummy_page_virt = 1;
 
 	INIT_WORK(&ptdev->reset.work, panthor_device_reset_work);
+	disable_work(&ptdev->reset.work);
 	ptdev->reset.wq = alloc_ordered_workqueue("panthor-reset-wq", 0);
 	if (!ptdev->reset.wq)
 		return -ENOMEM;
@@ -285,6 +286,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	panthor_gem_init(ptdev);
 
+	/* Now that everything is initialized, we can enable the reset work. */
+	enable_work(&ptdev->reset.work);
+
 	/* ~3 frames */
 	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
 	pm_runtime_use_autosuspend(ptdev->base.dev);

-- 
2.54.0

