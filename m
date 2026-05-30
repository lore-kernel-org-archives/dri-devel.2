Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7384CD6E58
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00304112815;
	Sat, 30 May 2026 14:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WImT72TM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A007611280A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8836840B7A;
 Sat, 30 May 2026 14:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EE81F00893;
 Sat, 30 May 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149643;
 bh=8ZbKlPcuQDcimp9Zw+N7MV0/BK/HgOxTVvkBX95189Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WImT72TMHu91/FVvgfsA3o4S7En0vdtFmpmqKHej7wDLIzzgdvmXGvULhw4wiaFB4
 dRTM3RdmWf3ANnVIDmIOgRweO9EzX6MCcrrp4rsueIc4UZ6Fm9k2qr3ATNZ+koEhnG
 W/FX3l9N9ZRHm57qQr6d1IUlQoeyBMsL6lsHt12ZEKnORkGiwM9pL7BclODasL+mai
 B70UOYImI/CxJOHCYiWSaur9vo1eE07QDH+W8ORNnFOpgc7vRJAsFqqhg7asRmfn9G
 WePoK4+/cUy/vCBrTBLMZeLVtKCM0bwCgVv495xX47wnOQRBv3LKxIWGExv9zlegvX
 MCzEcmVV8TZqQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:23 +0200
Subject: [PATCH 18/76] drm/bridge: inno-hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-18-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hb4I4w1zAGj+3tjvKDmbBjEtfGov95/+AKNOYltKDoI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb20drWSNjpV5lxpujH9ZWcJ60+PQldJjpxV3pwl8a
 TuklanfMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZS4stYH1hs5uxv8oN5TmpW
 eJQp1zG9Y6t4375OOCdo/Obi+23/RHQc2Nuq581v+Nl2RTZ+18+njA0fSqWYF4s8Xh6zd0ZmzkL
 nr/0J70peGDI7n/iq5Ru7WJq3gKU7032P6Qfln3r6leaxzQA=
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
To: Andy Yan <andy.yan@rock-chips.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 5fa533a4eb34..1e2a039cf9e8 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -877,11 +877,11 @@ static void inno_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs inno_hdmi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = inno_hdmi_bridge_atomic_enable,
 	.atomic_disable = inno_hdmi_bridge_atomic_disable,
 	.detect = inno_hdmi_bridge_detect,
 	.edid_read = inno_hdmi_bridge_edid_read,
 	.hdmi_clear_avi_infoframe = inno_hdmi_bridge_clear_avi_infoframe,

-- 
2.54.0

