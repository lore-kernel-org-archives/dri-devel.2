Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCB3C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5840A10E992;
	Tue,  4 Aug 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bviWPcyC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A1210E12F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838196;
 bh=BJ44gq7DJG+fqcEq/10trwLCTnEL2m5O1yzLhaGrkSE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bviWPcyC99z+IA7wiTxcqOblH4VmwfjWMVB/6d+IqG758ZeXbsq4F+lBszHtgoMee
 TqST+krLCRNwOB36sxzzrvkkONLtuIEgAO7NnB4+t3jEeyYUNahs+E5MHv8819ny6S
 /8PrqcqWhojms9q22T7Q/QfZmGQmU8wirV2ezlc+Vv5hDYJIZB/XKLsZcBvbBU80Tb
 AeKYvgKlqTHmt1SInvFakmg+tTENwX4P97Vs4hW+z/N/RpnorT88yjAd3GC0fRlhL/
 wA3mpMPqK5lIU+gmoH92HHlKNKR5z5M3wtGeizlw8ObhOxsS+aTVZfNGJzc1O6G55m
 fQJuiF3ODaD9g==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B5F917E107E;
 Tue, 04 Aug 2026 12:09:56 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:43 +0200
Subject: [PATCH 04/12] drm/panthor: Flush the cleanup_wq before destroying
 the drm_device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-4-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=1855;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=BJ44gq7DJG+fqcEq/10trwLCTnEL2m5O1yzLhaGrkSE=;
 b=COigHaAxvmSpC/bnWfhRWPhMjmV8cY9tQQbf2Evb/cDbimlOUB/2t6fGGjs4zjYwv2wM2GASN
 KREVcpnLZIMCu9U0quMWjC+Zelc4949EUEcivColYwysru9y9qIuOaw
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

If we don't do that, we might face various UAFs, because the resource
referenced by these work items might be gone.

In order to flush the panthor_cleanup_wq before device destruction, we
simply register a drmm action. This action is intentionally inserted
before any of the subcomponent _init() function to make sure we flush
any cleanup work that might have been queued in there if the
initialization fails.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 7d336f160d1f..b7c55a6f4f08 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -167,6 +167,14 @@ static void panthor_device_free_page(struct drm_device *ddev, void *data)
 	__free_page(data);
 }
 
+static void panthor_device_flush_cleanup_wq(struct drm_device *ddev, void *data)
+{
+	/* Make sure works queued to panthor_cleanup_wq are executed
+	 * before the device is destroyed.
+	 */
+	flush_workqueue(panthor_cleanup_wq);
+}
+
 int panthor_device_init(struct panthor_device *ptdev)
 {
 	u32 *dummy_page_virt;
@@ -220,6 +228,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_add_action(&ptdev->base, panthor_device_flush_cleanup_wq, NULL);
+	if (ret)
+		return ret;
+
 	ret = panthor_clk_init(ptdev);
 	if (ret)
 		return ret;

-- 
2.55.0

