Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD54F9EDC0
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4EE10E29D;
	Wed, 22 Apr 2026 12:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pA5XJcTu";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E6F10E29D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:15:01 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so34794625e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776860100; x=1777464900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nLinte2bTrSfydnPw4RU23zBy6zkLJ7eny7r/S0aKYo=;
 b=pA5XJcTu8xs+2oYaoJ2YQaEiVmyGkesyOFnhqKp8X+tMsxvZJBgk8rWSFxY9NuHWOA
 +7Q6BiIZyl7MDkW1UqQ390qqWh2JdXONmkMAhFZZrhoY7v/o+uoslNzRM8geRLXlAMnN
 MlOOmdvRKuB6nByTjCiAAtvhGLu6k4bD7Vui3QFz9rrBhMxgoBORqf3hrgt1ZvzYL7Yf
 C2cdaQ5Q1WeTe3qz0geO8UAOS1aRF6Gwf/VGKvrn6lKmii37VosEUcloeL9Y9bXyHlHR
 jOpYMLrWNEyM4zwPPVlq+8ARuQUsgLjhJt/8nTTA6CTxjcCNcDIKzs99rfWQbutCNL6H
 22Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776860100; x=1777464900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLinte2bTrSfydnPw4RU23zBy6zkLJ7eny7r/S0aKYo=;
 b=TD1iXY3K1Uc88zcQYC7hnYF4AHJmOirbdxCgFTCpDKCWV2xTtXg042V+z8wq4NKD/6
 C2oNm/Am6rflAACOnnmrK58yQiLcJ2y1PenhMX9FhEMhQcySMBjajXyNde4cw4bqIe/e
 lFzp9wyQBWFa0Z5YCiGj/O8piGpbiVpHUIwjZYRCX1A7Qw5mfuvO9A6Rek8VM+GFPJ5/
 hVZNZH4bU+Cm1xOX0db+OggGCdeqamS+fDcTfN7gjsyXxBz+5uDZ42yV3GvYRzobBqKp
 GAsAN2CCYFavh8t82gNQreF8BERebnDmJ/Mk5CA/lhsIrKvKFjjI5TiFfbzy8GFzVcXf
 zz6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GlDMpY0V1enOf/FKP3/PPlebtRK3FRKud72s1XAQYBC2Fgu1aWgexGJ+CpxS4Wq+AdfRZghFSkXs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEmn1Qe6XYr7ZxKDGGCOy8kVckg9T4+muGRszgo5OzEBX4yAkU
 Ysw7vS10X7NOSM1bjWEkKVq56TkzIiQR3rp+euEL0X6TTmeVfnFbdL7J
X-Gm-Gg: AeBDiet9CBqFuul/+7VGD5/sy2JoaIAAjT00ns/1muTvDSnZYO3NENCQRHw2T5ZiZHp
 a0co96theJnReX5rF46o8uQldkuwxymSeD9r8G7Ws+D1ys/V9BJWVcg8uZzp924ybbMrlc3Y7Eq
 Ze831gFgW7IRJV4QZ0LfgD1mmKN1k53Dhh4bp3mpltBz3KNm7i7A1dWgX5GQS4DOBlaY5DmIfVW
 v1PqF5h4QxYuAwPjOoY/aMnfxedzEfKpbsWUdT4CEavheU3t51rqWoQh6hYvBwOlqKY3SBiccx0
 WfC7Qi+mrHEVTqgPBL0/pwMw2KYOmWgYa6IunuA7N4otwibEf4WJ9YgK4eUjhzJwIyWVQiR3MyQ
 AyjZ68BBeWU8PvvUvey0EapyLCEXdPnPN4QRu8DWUYq93Zv2Ei2AqnYvAYjGADlwMepN4b9la2I
 diL7BLA9bpon4iKsiK5tdXBjjXs38QGH0nw7DmGZmO/w==
X-Received: by 2002:a05:600c:4895:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-488ffad67f4mr158637015e9.19.1776860099737; 
 Wed, 22 Apr 2026 05:14:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:a996:3b08:6e96:ca85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm192056665e9.0.2026.04.22.05.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:14:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] drm/bridge: adv7511: Clear HPD IRQ during atomic_enable()
Date: Wed, 22 Apr 2026 13:14:54 +0100
Message-ID: <20260422121457.166780-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Biju Das <biju.das.jz@bp.renesas.com>

On RZ/G3E SMARC EVK, suspend-to-RAM via PSCI powers down the ADV7535
chip entirely, causing the HPD status bit to be in a stale state on
resume. When the display controller driver's system PM resume callback
invokes drm_mode_config_helper_resume(), it calls the bridge's
atomic_enable(), but the stale HPD IRQ is never cleared, leading to
incorrect behaviour.

Clear the HPD status bit in adv7511_bridge_atomic_enable() after
powering on, so that any HPD interrupt latched before or during
power-loss is dismissed before normal operation resumes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Tested HPD, s2idle and s2ram on RZ/G3L SMARC EVK connected to ADV7535
on both polling and IRQ mode.
v1->v2:
 * Dropped PM support instead clearing latched HPD status bit in
   adv7511_bridge_atomic_enable()
 * Dropped suspended variable from struct adv7511.
 * Updated comment in adv7511_bridge_atomic_enable().
 * Clearing the HPD status bit unconditionally as there is no harm.
 * Updated commit header and description.
 * Dropped the tags.
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 6bd76c1fb007..7663814b4032 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -792,6 +792,13 @@ static void adv7511_bridge_atomic_enable(struct drm_bridge *bridge,
 
 	adv7511_power_on(adv);
 
+	/*
+	 * Clear the HPD status bit (ADV7511_INT0_HPD), so that any HPD
+	 * interrupt latched before or during power loss is dismissed before
+	 * normal operation resumes.
+	 */
+	regmap_write(adv->regmap, ADV7511_REG_INT(0), ADV7511_INT0_HPD);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (WARN_ON(!connector))
 		return;
-- 
2.43.0

