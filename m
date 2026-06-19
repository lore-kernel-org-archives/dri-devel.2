Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F06CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96ADC10F58B;
	Fri, 19 Jun 2026 12:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZbrOri4b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F71210F58B
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0881C42A5C;
 Fri, 19 Jun 2026 12:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A531F000E9;
 Fri, 19 Jun 2026 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871991;
 bh=UDvyVqooem1eGBTDvrC5XoLxS6y8To2MdNc/4H21c9I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZbrOri4bwUpFAmkaXJuIvmTaMipP2/kBG4RdIgpob96hh62Pe5ZJ3HbmANHaxVvmk
 kWga8L8sdexdbyU7T10QVLHWHsfSjqVdx22AidB5hLmy3XkvPoyKqIPoEtyxl4lWFf
 Og+sxBxE+tk3JKAg6sysmq4NFTDBwoKla3a9OSyRlgTfb0uRpwI5+l2+ur/T+s7L0s
 81FGuVbPB8QqOUWvm1MKsA75ZyLFMQ7atioX2AqfIEv01o9l+1w3T2UTrRkn4a+SZJ
 Ip6wO0TfVFRfABo13anOUFaZbBdhKhWB727F4a4xsi3RtaHfKzq8BakWIAE5sMB+GO
 pbDKDiVQrO3yw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:44 +0200
Subject: [PATCH v3 39/78] drm/bridge: tc358767: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-39-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=mripard@kernel.org;
 h=from:subject:message-id; bh=AgO2ZSvXlyKqJqdgIFoDEUKLSaZ9wHQDv51yAzTTWK4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJr+PTnx7Zef3O79v8SqmVjebrNLnCH/EnF18a1/H1
 FnH04V0OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEqnkYG7YseSkUUmujdvaD
 WUkXX6nvUc+5YvcXPt5c+opJWCzYvM6zlf305mApj1Xs5ywOGURmMDbMqrW7upjv1zvf2rvySlE
 9FfnvLYUfKTlFva4QT9470SiJsbGFzSaFTSyaY/L6+1m92gA=
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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

