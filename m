Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C564CD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CA511284E;
	Sat, 30 May 2026 14:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pm3DeJvb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F5911283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F3C641B0C;
 Sat, 30 May 2026 14:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD331F00893;
 Sat, 30 May 2026 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149791;
 bh=tm2mkg/hgsY/FQB7jCWJd/hpwYQvpRFFlFGKT7Fupck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Pm3DeJvbGrpWYHn7txV9Xapj9PYeEO1x+lDVgyeasJKxjGYCCKKbms11TlT0tu/ls
 q1pEn2dKP1dFQ0AYDzujmjmb8SH84D2Uos3G47YT6tXEPYDxHJ4NzJNMnoN4E5KKJh
 QpNvUbIHFtgDzuH+fjdNz4i862jw8MIdmWQ2ICppCbgC5oNzUiXgVEEqqxNfVZCUrh
 RfhWCtBRLyKvuYSLg/HNzSMs1B6JSe1BAkps2sSEKiDSHL/T7OnJ6NdNrNVnjU/qKA
 0ctrPEBDHZflctK6/GsT9jJ0J0ID7MQUz+JqOIw7sFZAvkluqKDFqB8SfGptYzElQc
 TlHlLLpQcLpgQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:18 +0200
Subject: [PATCH 73/76] drm/bridge: cdns-dsi: Use
 __drm_atomic_helper_bridge_state_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-73-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dv+RwJExtX5epTsKivrgzXvCEboRtddMuLccDIsBG4o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb0MLdSfLLpZ56Bvt+I47wJ4puSw7wGtH+PUsKRG2b
 23X+251TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIl4zWFsuP9x3g6WCclvjjPV
 LbGSqcq7y5U5O8vieju7u9Cvi9kBgVErGj9MesbyR2NS0OIrXlJujPVVInEf5u/PnJ4zadH67us
 FTctU7osu/2v9+qOrLNdW5yX/3H75Gayb9ODY6eXTNt3PlEkAAA==
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

The cdns-dsi bridge open-codes the bridge state initialization with
a memset and a manual assignment of the bridge pointer.

The memset is redundant since the state is already kzalloc-ed, and
__drm_atomic_helper_bridge_state_init() exists for exactly this
purpose.

Switch to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cf90d4468b5c..f4cf765f0be8 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1015,12 +1015,11 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
 		return NULL;
 
-	memset(dsi_state, 0, sizeof(*dsi_state));
-	dsi_state->base.bridge = bridge;
+	__drm_atomic_helper_bridge_state_init(&dsi_state->base, bridge);
 
 	return &dsi_state->base;
 }
 
 static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {

-- 
2.54.0

