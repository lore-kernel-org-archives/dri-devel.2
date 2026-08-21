Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D180C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283C210E2DF;
	Fri, 21 Aug 2026 14:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jKtvMQrE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E3010E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BDD361126;
 Fri, 21 Aug 2026 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8991B1F000E9;
 Fri, 21 Aug 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323254;
 bh=nTpwkZfhW0MVu/55N9kCqibxmIRab4eqoZNRPLzjSD4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jKtvMQrEPCm2NXQoJdvhhdwG/T0SJtvaaWcGW31fggoElcKjfNG/khuKfMZeFYU7Q
 p359tlfB4fTKVPu6RA/xybEEDnSdoU8B4B/WoVngrcrjWhtqWqtKeP/wMsEHB2dw99
 WNAeLW+ZKKJsNxZNZT4Ct/lmGFd1AoJi7t04PhUckleaoHIeN33w1T3LBQOM9cZCI/
 blKq6f1lKDf/6bAFPM3ejW+gnNeOq2MGT70XJMjOCJObDk7eMVEwYygBgz8ORDFzHj
 7zEVoBeEyADAYO7ql5BvFMuuFl9RMtLUfrUTEWYkzqY0671rYdpM21K+T0dKc8cwhg
 CRTW0aRtWDvLw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:14 +0200
Subject: [PATCH 38/70] drm/verisilicon: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-38-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WpJi3euaGXU6DIGTp/hLoW44xSOQ64NGBJt256AH8D0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyZxrti66qr7PICv0RMWm0AmWZuLiKn2+Zj4Priz4e
 7gr9JJix1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIgypjrbTDgrIXNs82/57D
 Jzqp3zk2YzrvdJugycvFFVjcSxZNF14wt1ny7aXtRbZNvyZqCypJM9ZXZmfZ+CVU7bo590zIjgd
 dhhmeG/c+13MKKM495fN8Z9y8nq9n1z3KXjP5ht0iFdu/f4oB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The verisilicon crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
index 0b8a35d09cd2..c24c1588cbe6 100644
--- a/drivers/gpu/drm/verisilicon/vs_crtc.c
+++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
@@ -147,11 +147,11 @@ static void vs_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs vs_crtc_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.set_config		= drm_atomic_helper_set_config,
 	.enable_vblank		= vs_crtc_enable_vblank,
 	.disable_vblank		= vs_crtc_disable_vblank,
 };
 

-- 
2.55.0

