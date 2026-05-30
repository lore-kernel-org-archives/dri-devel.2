Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA08ACD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F200E112817;
	Sat, 30 May 2026 14:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mgqSDDeh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF82112816
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7785F43AF9;
 Sat, 30 May 2026 14:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54F91F00893;
 Sat, 30 May 2026 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149670;
 bh=8QEpNKXHJhXmgaoKpfpe0VrF9qOcHStx6IO7XSLZwaE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mgqSDDeh/0F922GqXt6M2sXpSA9qXlrhtrgZyidK5v4myFdpBGU2ctP9H5TxUCckG
 JsaeRQvFEFlJbph37tMSelcCjYM6fk0BJ/xPEevEfRrb+r1wzjJ0PuphbxmYDlljDH
 JCSqX0ln0xPjacBn5RX1yM4YB4qKOm3K4tMDtvavxRvm4eHeB3v9n2YkylyvwBq8NL
 3j28MUar+ZxaXpNGndg2VedoQEYm8RR02eIkVxCidO5B6SQ1ZLSMvaLQ48kvKUrAOF
 zRQJGxKQJPGnSlSRthrwc0I2RK5NUmxG/yhJJfAVuJ/ZPxyoBE/+SaIHWRghKdaMn0
 lFjQm7yI7dz0g==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:33 +0200
Subject: [PATCH 28/76] drm/bridge: samsung-dsim: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-28-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LmwrjGKoYhoCUDilp2/4/CiMN89S/eOguYh+SyjTVmQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbx0Pn9v5NU+W5Yng8jOaNi926XhrB1VWxXy0ylr8Z
 90xA6ONHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BeAiOxgb1p3q23IydXHS8q60
 C4+uLz3zUlP5hcji/d/agtrf+RhrXGz+fG7V309tfa5GaZuYr5dcZKyPj9/tKvRk3aPozVnBp3R
 NP59o4U5grHkv/E4xR8tDR1LO47HMth07TTdO+S1T3x+T9gIA
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
To: Inki Dae <inki.dae@samsung.com>
To: Jagan Teki <jagan@amarulasolutions.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 9ee0515074c7..5788066d479e 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1833,11 +1833,11 @@ static int samsung_dsim_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs samsung_dsim_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts	= samsung_dsim_atomic_get_input_bus_fmts,
 	.atomic_check			= samsung_dsim_atomic_check,
 	.atomic_pre_enable		= samsung_dsim_atomic_pre_enable,
 	.atomic_enable			= samsung_dsim_atomic_enable,
 	.atomic_disable			= samsung_dsim_atomic_disable,

-- 
2.54.0

