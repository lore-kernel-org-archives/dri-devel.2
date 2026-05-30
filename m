Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498ABCD6E58
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59B112826;
	Sat, 30 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oOJPmaCL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFB211281A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 286BD600CB;
 Sat, 30 May 2026 14:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B811F00893;
 Sat, 30 May 2026 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149691;
 bh=6gQpEm/78mlcCakrQ1wG71iWVmJB/QiMKGFkT7Lziy0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oOJPmaCL4mp+5ceQnWNm8MolahUj6DgMvHzU6e8mLNe5vXJpy/V9llsAD5A4qNf7s
 1jNgpBnIpV40oy+b8evETe3mSXFzvyIu+FNbDn0zJxW95wF9D3vtzxpPEkQNetYBP6
 iDTYuAGP1FZ2S4p6ut2fvg/Z7AQtwKS3dV5SL1FsWi+WuPjw6h8yG/W2euhNLQk5Iz
 57nNbonktCLUvrV93TzcVuyNmbXSNTAe0t8+tngvKxdkKekbuo2uglsYQE5DmTSe+i
 BMvNtWA609gWunP1zMZYbKQpxOWx7S/HGVOcEVsxJ8TdilYKYxvqa3lxJkn1FvZ2Lv
 rjkkB6iZWfDmA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:41 +0200
Subject: [PATCH 36/76] drm/bridge: tc358762: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-36-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TyhRzfHZVGUth8zo/lT0679fYCnGgmuZ+K5gO1+wL50=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb12L93FvizNqUcs8r/hqev/mAwW/FUOf94dtzjGbX
 c7zKPZlx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIz13GGr5QrTWF3BIqE7f8
 n1Bovca+x9G4QdGF7dbCLSLuPErfDjCeP1d1M8/Dk++6yoxb9+/3MVaz1i828FzXIrz5nr7jYRd
 9gde3+Qv5uUSsSt5Y3OVasrH24Pee5Q9WrDj40C745c/tIRkA
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
 drivers/gpu/drm/bridge/tc358762.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 3d75d9cfa45e..4f9943b0223e 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -224,11 +224,11 @@ static const struct drm_bridge_funcs tc358762_bridge_funcs = {
 	.atomic_post_disable = tc358762_post_disable,
 	.atomic_pre_enable = tc358762_pre_enable,
 	.atomic_enable = tc358762_enable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = tc358762_attach,
 	.mode_set = tc358762_bridge_mode_set,
 };
 
 static int tc358762_parse_dt(struct tc358762 *ctx)

-- 
2.54.0

