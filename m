Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D550BCD6E55
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CE7112852;
	Sat, 30 May 2026 14:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nE8BshRa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F6E11283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A27D660122;
 Sat, 30 May 2026 14:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D051F00893;
 Sat, 30 May 2026 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149780;
 bh=DdNjjk0oegsB9aTdraRM+UYpEsOgo/eyy6T/oovX6Mk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nE8BshRajGahz0fWXvTVwIxX3+LNmPHc+WuxvWPohLpTiKP/XsCICPTdC7uBDhbsS
 HM23dOpWVEESJEFIXzh9ecscCYc4SBV4moCSRBstmJ7H3/dW1MEikpRU482veYqlfU
 /xHgw8MRnG7fKIBQQiVMBNz0xcyjP7QQCPWb/cPeAYNwBnCIhBmYcLRrH0RdGKmgUq
 qOoQ6LA50H6pc05XHyUOHZWr3rKmDyY6mXcQePgVQx1rEGsgiX4bi5iM8YW5U+yEbA
 LKYFrNiR/duGVjr4QaenhGHmhQA8DmGk+JmMjzDEGhnhRcfLMt/MTiIgPfYnZcEZLA
 5Ph1E4StUEytw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:14 +0200
Subject: [PATCH 69/76] drm/vc4: dsi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-69-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Zd/upV9PJf9vhvE90bnVfumZxCsXCJGwqboOMMNKSoY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb4OP99RybOAVqNq5S2TBnpj7B5R/ekke/9kWYv/qM
 OfVDdlVHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiff6MDUuU/NrjJ8V5ps9X
 8K6Y8Mn8l8n36SJts2ujck/2nOyriCpbGn84P4yFaduq6afSblaeZmyY/eaO6aLpksZ9t14wzEt
 4c9Ff/Vrj5or5qxcrTTldd49z8sRzPctOpYRyMP8p83m2w+4NAA==
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index fc76018b044c..0148f2befed1 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1409,11 +1409,11 @@ static const struct mipi_dsi_host_ops vc4_dsi_host_ops = {
 };
 
 static const struct drm_bridge_funcs vc4_dsi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable = vc4_dsi_bridge_pre_enable,
 	.atomic_enable = vc4_dsi_bridge_enable,
 	.atomic_disable = vc4_dsi_bridge_disable,
 	.atomic_post_disable = vc4_dsi_bridge_post_disable,
 	.attach = vc4_dsi_bridge_attach,

-- 
2.54.0

