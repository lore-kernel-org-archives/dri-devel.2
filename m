Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7F2C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D80910FE9D;
	Wed, 14 Oct 2026 17:27:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C3810FE86
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F0C44398F;
 Wed, 14 Oct 2026 17:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D8D1F000C4;
 Wed, 14 Oct 2026 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998861;
 bh=hRydVjQzfLO67vcB5tDDAwR9o06uH1FPJLNPhIlUi9o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fB0CDcrCyb5u3KeQX5K7zQTwCgQh5rUqf7wKt6wZo+8hRxFhAHpbZ7UahEDDfLlPo
 y0Wd0/WnAZXDt01Vl1Hy4FFSYsZh+0vJ4zHKSZGAd8QHjyPdJUYkXRUdhVbZUGqYFA
 fIm8/P0Va2YyxPvfPteI/h9VLjX1Pv3HBi1QeJOze+o5lCiErcrKA2jqeEIz3bXPe0
 1+c2KRk6kzEzrEX2zP4o7jXJSP4DdmoF7UUAk+RU27/Bct1ltVWvMdaMxRK4RwWmCb
 U5XFKXZZyJCwWjatyXfQxEDy3U3wTBboOLSLVO2W31LChfIQb0Zx/Kj8qzCBbeeqLO
 MtMvRQtSDds8A==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:31 +0200
Subject: [PATCH 08/75] drm/bridge: analogix-anx6345: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-8-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yYGCg7oeKPh1gjgvGPd4xOINkepKjwN6uk973yPMkj0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/tptR3K+R3atm5fkoHuotU35/Ua/MjUumJwI//8R
 xVtr+XGHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiCoKMdSYtHdcimmK+9q+a
 YL05YUNByC5T6zNHSzzXbbu3/du1D48Xzw2qkr3XW3RuV/m3k3O65zI2PLVPl055MGWzte3u+WH
 PSz/ePXvq2fnfDWVuKz+ofT1iGLzmTVRfUfv51TsP73rm4XbrEQA=
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

The bridge: analogix-anx6345 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 407834a03b63..0cff9ff0265a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -481,11 +481,11 @@ anx6345_connector_destroy(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs anx6345_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = anx6345_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int anx6345_bridge_attach(struct drm_bridge *bridge,

-- 
2.55.0

