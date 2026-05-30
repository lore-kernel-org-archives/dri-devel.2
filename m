Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8B9CD6E56
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC40A112841;
	Sat, 30 May 2026 14:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gf4f0c5+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7438A11283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBFD460120;
 Sat, 30 May 2026 14:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6761F00899;
 Sat, 30 May 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149777;
 bh=NfkOwgjZs7VyXMtx+rhfXNMme4+/bQBZKAf8TwCgOp0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gf4f0c5+2jFaIavVYug/snmkn+crTPGgPE/mAoK3SPrgv3YbomqIARarIDJ86sVCN
 Yda8NG8q3eNaIZGyT5zHHIt9489ebS9HVIxVZ2xsvuqMmocxjrktPePfmz8+Dw9LWr
 d8TmVGTypgrg/wFbrne0PbRaTs+NTTb22eqNVaBDTjQmRUTRV89JQXyZQc1K5cHvZj
 t60tdZy3qdE7pv2gS/chCR+MA+m5h3Q5L8OXVfRBpxfqz1otVB/Ibsnwj7iT1TY4cN
 vL898+2oJfAmgfg7obBNbzydDzE/zdG0SC+Vhuc8P5u8UaZkWnmkN2oEhtsml35JUz
 RaoA7Hws1oSXw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:13 +0200
Subject: [PATCH 68/76] drm/tidss: oldi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-68-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=mripard@kernel.org;
 h=from:subject:message-id; bh=epZZYbbSU8XTETQWr2W/ZHTSemMptbBbxZg65owKbMM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb4PlTTqyMq/vYuzzTZodYu9xMu/V1zqepP8lh8pP3
 W2ese11x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAbjJtYwN0+KyuFuzNsi75z55
 KX7tjVSR+NoN4VF2x8/M4Jt0SPfEi39v/8fHKz2w98oW5oyrLJ7KWKepyfP7woenUrbcB46eieC
 odBJYYxd7t/qn0pftLbLfLI4Fv72v57wwIfDfN5HG1b98CwE=
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
To: Jyri Sarha <jyri.sarha@iki.fi>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 9c9725aac829..5eb749f495d5 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -333,11 +333,11 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
 	.atomic_post_disable = tidss_oldi_atomic_post_disable,
 	.atomic_get_input_bus_fmts = tidss_oldi_atomic_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.mode_valid = tidss_oldi_mode_valid,
 };
 
 static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
 {

-- 
2.54.0

