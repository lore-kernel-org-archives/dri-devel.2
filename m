Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA887F327B4
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9A810EB8E;
	Tue, 21 Apr 2026 07:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="nnLyfcDf";
	dkim-atps=neutral
X-Greylist: delayed 443 seconds by postgrey-1.36 at gabe;
 Mon, 20 Apr 2026 12:25:20 UTC
Received: from chaosmail.localdomain (chaosmail.tech [77.81.229.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9383310E57C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:25:20 +0000 (UTC)
Received: by chaosmail.localdomain (Postfix) with ESMTPSA id CF4F41D4117;
 Mon, 20 Apr 2026 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
 s=mail; t=1776687473;
 bh=/PTH1YQKxf++4SqLvTRsLqkxHUKvKP8NqVdN2i4yky4=;
 h=From:Date:Subject:To:Cc;
 b=nnLyfcDfYxTdyjmwGfGkD9QR/WfCUqvhkf7dMaHCJyYGW2dM/PDKuMSrQ47X+tcOZ
 DTQolMn2aex5yyYuDt7vuuBiDrzRTTKzz8ZvSGeAqwT+8cuEhmNkq7pU5hImyUs+9I
 l/xt9AZPWggPzKmB9eH/jYUbisyRQUE4tH3qmbOo=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Mon, 20 Apr 2026 14:17:43 +0200
Subject: [PATCH] drm/appletbdrm: Use kvzalloc for big allocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-x86-tb-vmalloc-v1-1-7757ff657223@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWZukmhK8ilhUDUbc0pZIxLsrk
 rP5Fue/wJFlclBGF1g62PG6BCRxBGbQS0/IbTBIITOhpMAzz9A3eMx6mlaDyhSqTUlTGITTZqn
 j8wtW9W+3NyMZ/1bgvh/be4t3cgAAAA==
X-Change-ID: 20260420-x86-tb-vmalloc-4c94d5eaeeae
To: Aun-Ali Zaidi <admin@kodeit.net>, Aditya Garg <gargaditya08@live.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 soopyc <cassie@soopy.moe>, Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776687472; l=1525;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=bnC15W3ECPu4vYfLM+l2WX7DqlVVXjhMAy7MGG8WTno=;
 b=b58f1CCIp3H1alycl74aLFeBUs3sMGPPrHIw8LpOe3Wzt/QJPn/s1RRHqe2ytDOxDXzKNX1VK
 CPCjHcYMOs0D3JzhJzek8SID/3ZnezLSiIm7Pe5IPy4Fxh4ej14bkyn
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

This driver is attached to a ~2000x80 screen, which is a lot more than
a single page. This causes out of memory errors in some rare cases.

Reported-by: soopyc <cassie@soopy.moe>
Closes: https://github.com/t2linux/fedora/issues/51
Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index 3bae91d7eefe..278bb23fe4c8 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -353,7 +353,7 @@ static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
 		       frames_size +
 		       sizeof(struct appletbdrm_fb_request_footer), 16);
 
-	appletbdrm_state->request = kzalloc(request_size, GFP_KERNEL);
+	appletbdrm_state->request = kvzalloc(request_size, GFP_KERNEL);
 
 	if (!appletbdrm_state->request)
 		return -ENOMEM;
@@ -543,7 +543,7 @@ static void appletbdrm_primary_plane_destroy_state(struct drm_plane *plane,
 {
 	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(state);
 
-	kfree(appletbdrm_state->request);
+	kvfree(appletbdrm_state->request);
 	kfree(appletbdrm_state->response);
 
 	__drm_gem_destroy_shadow_plane_state(&appletbdrm_state->base);

---
base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
change-id: 20260420-x86-tb-vmalloc-4c94d5eaeeae

Best regards,
--  
Sasha Finkelstein <k@chaosmail.tech>

