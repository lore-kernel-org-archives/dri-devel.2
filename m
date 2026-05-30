Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B7CD6E57
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF490112836;
	Sat, 30 May 2026 14:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fiCl/x6t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7677112824
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C03C540710;
 Sat, 30 May 2026 14:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0751F00893;
 Sat, 30 May 2026 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149710;
 bh=gWg804gAxrcNTEegtYIa2x8tDvqmCiF2u2fmojtUVNo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fiCl/x6tvFqcBbb17naBkod/2oseWpp2M2iJ4ctBfXbwO0pjgrRbmp/OLLKfUMrZ3
 XeVeCwCKM2vkCbfZsi4uLXD5mKog/R5s+kQ9I33JpJJSicQz0qlLvTn3dnKVl0QvQG
 8EpZ0t7yXZdqiCUN5JZJ54qH+2+YKvgo6sFkjmd3d8MyFjqjS7kZC7u6jDs4N9WiGt
 P4pD0lHX7fmYHxyi8K9zCkQm29Zdx+jgZfvdT24PbF21tz1W71I4nVD7Pth3fZIBHO
 qUJFT+R1L8DVEBWQXiZgDzIQ0ferGypVJ7Ijo5TZ/qXJBbY0OpMEmTTBN+mYXO/QgE
 ZqpvlrmnLdXpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:48 +0200
Subject: [PATCH 43/76] drm/bridge: ti-tdp158: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-43-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PB44zpsb9SbawXOY+t1V6YI9bfWX0XNSG/yZON7Kij4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbz0Sr1+Jd5xYqF1+M0vXPivS7OXUuvsMjntDWxRDC
 iN9Vf90TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgImcP8lYnyR8hP1X2I8+v6zK
 tvTrKrmtRu6hb6sjHiq1rdj0Y9Vxr+Bji1zE1wRLrX+mtk6yVLGUsU5bM2jp3597A7nKJl/Zn/q
 X4WvqCcabiRpKRRP5e9TNou9csHPpFahp/7vedEdDbcaliQA=
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
 drivers/gpu/drm/bridge/ti-tdp158.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tdp158.c b/drivers/gpu/drm/bridge/ti-tdp158.c
index 3a19967f213f..01fc643bd78f 100644
--- a/drivers/gpu/drm/bridge/ti-tdp158.c
+++ b/drivers/gpu/drm/bridge/ti-tdp158.c
@@ -58,11 +58,11 @@ static const struct drm_bridge_funcs tdp158_bridge_funcs = {
 	.attach = tdp158_attach,
 	.atomic_enable = tdp158_enable,
 	.atomic_disable = tdp158_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static int tdp158_probe(struct i2c_client *client)
 {
 	struct tdp158 *tdp158;

-- 
2.54.0

