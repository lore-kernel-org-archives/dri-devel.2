Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A05CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1D4112823;
	Sat, 30 May 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U49twELi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CDF11281A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9EB860120;
 Sat, 30 May 2026 14:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DCD1F00893;
 Sat, 30 May 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149694;
 bh=/Fd64fwn9mMaYyv9v9TuxBgn4XGOTxN/tWE5I84E2X4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U49twELiD+1HItqN0GxwGnndRnUGry44yGNvtBHR8qbBJwV77y2boiRVDpjgzzWZk
 WPKEZ5Bq4BlPlCnsj1cbkN8Tdz5B7HB1qISoWlxtt5Hezn3QBnDEhLCGmoSWvuzwEk
 QQTu8/5Rrb8AoJfJGpynGT+bBX0ovgBT+F/jIYazbsXGYbnfjNvlQDE0FPdCSFvGUs
 fb8v3kwDHpDxjoDXlkqzzl8cqqJSTYzkbXLCsD6ZXafYgCOUEMsMZz46DL5Stw8Jxp
 WGFc924X3dZQlb+Tw+WxZqgyKGspH971VMNa+ljW/xxEgCryHYnOjehibI9VXe3c1n
 FtAq+R7vEYzOw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:42 +0200
Subject: [PATCH 37/76] drm/bridge: tc358767: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-37-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9HSR6QStmRvtRKdtfMe4gFkXjYRpwrTTbSkrCPaGYV0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb12bM8/1+ogVmTw9dE5E/tq3Z1HJ22K11693TBSf5
 nqgeem9jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR5XsYa8ULfTbrvwl7tjb0
 R7NbsP7qS+eNrzKebxW9J7Uq/tDZNwxrbPLqfk6+eST6Xf63v2JGwYx1inP/JltdFIh3f1G2ZfL
 kJTNO3DI2v/Q7qjqpsFrLklPy/ybOkwGijrqneTN+HHjY4r0ZAA==
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
 drivers/gpu/drm/bridge/tc358767.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7188935fdb82..966c3eae437e 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1931,11 +1931,11 @@ static const struct drm_bridge_funcs tc_dpi_bridge_funcs = {
 	.atomic_check = tc_dpi_atomic_check,
 	.atomic_enable = tc_dpi_bridge_atomic_enable,
 	.atomic_disable = tc_dpi_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = tc_dpi_atomic_get_input_bus_fmts,
 };
 
 static const struct drm_bridge_funcs tc_edp_bridge_funcs = {
 	.attach = tc_edp_bridge_attach,
@@ -1947,11 +1947,11 @@ static const struct drm_bridge_funcs tc_edp_bridge_funcs = {
 	.atomic_disable = tc_edp_bridge_atomic_disable,
 	.detect = tc_bridge_detect,
 	.edid_read = tc_edid_read,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.atomic_get_output_bus_fmts = tc_edp_atomic_get_output_bus_fmts,
 };
 
 static bool tc_readable_reg(struct device *dev, unsigned int reg)

-- 
2.54.0

