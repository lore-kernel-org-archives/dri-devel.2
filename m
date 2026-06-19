Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199CCD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591D910F4D7;
	Fri, 19 Jun 2026 12:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G3a465hb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D0310F4D7
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F3AB601E2;
 Fri, 19 Jun 2026 12:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FBD1F000E9;
 Fri, 19 Jun 2026 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871889;
 bh=gKb+VxBLM7hJr6oQ3P1OxGvP8zjxIRGqOQRMdHk7igU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=G3a465hbFmNPg5Wf6mxWTHHd8A9PCwcHY8ABBDR7fUXf6Y/fqcT1vP5OIbHBAieEF
 /7avQIQt3Xebo2UqfEs2r1V3cqE+5LDhXpp3QPsJ0rtXCJJXnKi3ZcG/gF6NFFTe/B
 rNZdGKIFfNsiqpkg/eb2+ulW9Y38JqfSx3+TGW7vG9O1NXyJC3BnFUSffNk2rKLI/w
 sLeNHJnr2syAgOiUNh9L3hR3BLqHx20dw+fAlKgARgGtgApeAcTTtv+fZ50uuDi3PT
 ZUXRpKKdtjYm32wRK9sPIECCaFi//CWLtZzgFk/2qdiYZlxEZ0Z1CKnPa3ut4WEn2Y
 jDuBCs3p2oGRw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:06 +0200
Subject: [PATCH v3 01/78] drm/bridge: cdns-dsi: Return an error pointer on
 allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-1-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fx20ptoH7Xhzpj3Seh/VeSC+2f5pVSPEW5IG/Pc0eo4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJq8MN+zT4T20RIvr64H+9MNvvk/b+ltrinfc+Tn3V
 KNYPrPLd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJOL5gbOj4mp1Ts6m0eXlj
 9o0Vk4PyFsWeS5oi8+/WprytS2fJ/qqYoJ/JuLLlTlG8zt+5L9r3CjDWl4mXz9FNuzeFy9d0UZz
 74feypxudeF5En33VsPhN/iX3PVnTC3ljomVUrBlZhH8wJK0HAA==
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

The drm_bridge_funcs.atomic_reset documentation states that the hook
must return either a valid drm_bridge_state object or an ERR_PTR().

The cdns_dsi_bridge_atomic_reset() callback returns NULL when the
allocation of its state fails, violating this contract.

Return ERR_PTR(-ENOMEM) instead.

Fixes: a53d987756ea ("drm/bridge: cdns-dsi: Move DSI mode check to _atomic_check()")
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cf90d4468b5c..344c3f466018 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1013,11 +1013,11 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 {
 	struct cdns_dsi_bridge_state *dsi_state;
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	memset(dsi_state, 0, sizeof(*dsi_state));
 	dsi_state->base.bridge = bridge;
 
 	return &dsi_state->base;

-- 
2.54.0

