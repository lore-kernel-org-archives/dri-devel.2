Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D94CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9065211284D;
	Sat, 30 May 2026 14:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WhUHY6Z0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AC011283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B94A600CB;
 Sat, 30 May 2026 14:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799091F00893;
 Sat, 30 May 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149775;
 bh=Tn6IYbJut81bu5rnO4kMWRkPou2qVASrZA0bTa65t4A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WhUHY6Z0YZPOYqjGQxz4q1uEqZb2tIwzQEFz+cQSQkx7te4o9TyC4fGH1xBYtLSIs
 PXnLeAqiDiPDG1LoBwll731ONr856Q3XJGaYWub+Qmd/ccqzqSK+bpLM6s9XfKYl4Z
 o63qOQ8aUz6g1FzTFIuvWHFbGlfYwWRT3wbH6x3pl/k76Xxwb0aATvsugaEfmtFsSO
 8buvq5v2c/VFhyhAfqeangI6aGk1QB7AXqxgmemQOKgcUAVKOkPgMpqtFiPjPkAm2d
 xK7AVeBa1yzHQRATHNHqY44FkyhYFr7L+rNzB6pjqpIAuzGkLYF4Tpc9jfPAhOEbnc
 yjRicV36uApAQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:12 +0200
Subject: [PATCH 67/76] drm/tidss: encoder: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-67-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=mripard@kernel.org;
 h=from:subject:message-id; bh=d8RV8qicz9V/LB/Wvd6LifM7403ujbeVK62HsxGB19g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb4N2tqUFrosQevY0e8YTDhmuux3yPc7l7q3+kRt1m
 OezlYV2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlUJzNWs+6NtVrNfrnfsu1d
 3g5urgOve+3lpKT280z/81ndR6Pd8TaLo6mv7sPPr3a2P/gut9eWsT5D8UOKTGRBNNN7g5XSk00
 NU6rjbnYY1Lq7FDSKGNt8fffdfX/Noe03Tvov+XKis3X3UwA=
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
 drivers/gpu/drm/tidss/tidss_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 34db8d2a3792..698f8d964ca0 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -74,11 +74,11 @@ static int tidss_bridge_atomic_check(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.attach				= tidss_bridge_attach,
 	.atomic_check			= tidss_bridge_atomic_check,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
 int tidss_encoder_create(struct tidss_device *tidss,

-- 
2.54.0

