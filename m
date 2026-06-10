Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B52CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EED10E7C0;
	Wed, 10 Jun 2026 08:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D7euH2ph";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4978410E7C0;
 Wed, 10 Jun 2026 08:26:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F6146001A;
 Wed, 10 Jun 2026 08:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BD31F00893;
 Wed, 10 Jun 2026 08:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781079989;
 bh=N/meOR8qXZA62uzXKo7V6ddIdrYaFI08nRHNwkyigvU=;
 h=From:To:Cc:Subject:Date;
 b=D7euH2ph0IRx5agO0gaC8kNCg/qxTzdB45LZ2MgtRE8hNgp+rHYbfSzV/BxQenHYt
 TP2nltVdTft9SDuhDqRmw+wQooocWHUmfwcB8HKm0aGCpn9O8THjjXKx0m1CS3OQ/J
 sDMYRZHbhlRkW+zLElSrMNaPRwOQLgtfkOa9F3Ar6CgvH5ieWV7/ghVK59n5TzAkZJ
 Ylsrhsj0BVWhyC2wLCW0w6GpNIuAitcUz+uJTaq3WGymLeW3a8oqNWgPUe9oyPGLfd
 Innx51sYQo1imPN23H03RIBohDSnnK3GykmMCvai/IYofIUQ2AnOq2vTtMGYVXY5mF
 aLmhVJm61TNhA==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/nouveau: Document weird looking bugfix
Date: Wed, 10 Jun 2026 10:26:03 +0200
Message-ID: <20260610082602.1292853-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
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

commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
fixed a race. To do so, it replaced the automatically locking
dma_fence_is_signaled() with manual locks plus
dma_fence_is_signaled_locked().

For someone browsing through the code, this reads very much like a
cleanup or rework leftover. Future contributors and / or new maintainers
not familiar with the history might be tempted to remove that bugfix.

Document the bugfix.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
(I did not test this)
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 42a81166f3a9..519a0c164a72 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -159,6 +159,13 @@ nouveau_cli_work_ready(struct dma_fence *fence)
 	unsigned long flags;
 	bool ret = true;
 
+	/*
+	 * This is not a cleanup / rework leftover, but a bugfix to prevent a
+	 * race with someone signalling the fence. The locked
+	 * dma_fence_is_signaled() cannot be used. The dma_fence implementation
+	 * is not fully synchronized with locks, but also uses atomic bits,
+	 * which can cause the dma_fence_put() below to be executed too soon.
+	 */
 	dma_fence_lock_irqsave(fence, flags);
 	if (!dma_fence_is_signaled_locked(fence))
 		ret = false;
-- 
2.54.0

