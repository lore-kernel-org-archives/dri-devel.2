Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E878CD3430
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CED110E730;
	Mon,  4 May 2026 14:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0+73Vod";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A837710E730
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:59:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488ba840146so36533455e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777906749; x=1778511549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hQdlPNCTbv6uJb78SK3ljaR8gX7GI26O+ePLCgSshWk=;
 b=F0+73VodA+JvOdTrGt05LwIA7s+dtVSwwmUNjCF7VbpxW6RyjJty/gCANWiB/T+3hW
 tu7Xnl2p/hxWcv4sr3oQIq5yzlQR6DcyrhCAdMfteFgqWcmIkNlikTWZjyy3w/jwoM7c
 oUqj/Bbfk8YZFIY2CFIScErtJTCM0A4f1qEr9TiGqP9S2rZy0uemDfbEKR+vZ9M0dwvu
 nX6VBbFyGpexIoRHBgmPSmxFSPufRvSjU7xfjjx1nRgJ4OGipacI9EFT4upEh9funrke
 sZJB6eXKumBjh2z1lwBmqbWpXE3xEohi7V9FCg1JXne0VDKV+3t5/9YihVXpjT/yUUfs
 uXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777906749; x=1778511549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQdlPNCTbv6uJb78SK3ljaR8gX7GI26O+ePLCgSshWk=;
 b=ox6Yue/1HDjjXuxWOtvfcr8sSVfnT1Gqcszi1H0WuPjLFqt+NpPMgghnPL751rEQLU
 mlCFObphGzEc3OoqwpGwhkuC37zljajpN7QuVVTiDIl8A5xaiJBLMGoytcSyI02AErkD
 33K/kkL9qKiXXaUCz+pdqj0P62weZg/xV52rX73w0QE8exYFlZ5tNGMEbmO0enfA3cGx
 6Qxz83oVlixK/oXw0WrOkcIoGpLl7e1qVazhTv5Yv5J9nm+YR7/tDJi8+Ah4DqOyqI1Z
 5kyrD1N06qod4YQQC4/pXbOirGOqmzIZNkBtBV8RJvcuOEItY/1c5rygXLJC6g3G5ZPn
 rr0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PvG1Fk2yZJ6pZFVDNwQOzVVugcP6TZ5UIEPK959w5r0aBb4JHVQI8Gb/EJ1/XmATpL1QJ30EKt0Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyh3P9DpqkAD1meFO5VdPRqHCEDdJ35YQ2srcNSSROEq87Y5KSL
 tsW7mPIMm3BnLwjY8toLt48tC3hOWNAEoWQa8NzshPzRXZY5xU20cCNc
X-Gm-Gg: AeBDieuo7RKAf+cdZO0Mdq7tlDcuqLvhnT/THzfDmroY6vdXoHuz6alYLa9CHCeLlno
 2FFQ3DnmsYShUIhQCl9+4PZIutvzXgDr+Pc9Pwk/gTqB6EG6KInFrl/YMDcqnGAlNUXKnZRhkCW
 vjq9z1j+ieLbGJLcWgnWi8dr4ObgAiuD+fpMssqrq8s1fI7SWwnXFAi9zKX6Yi1OC/Mxch68Eu2
 RlJPvGs69s+CNtvSuWj6zw274kIjLkRebAk6MHPSRAUJ0dpkAk1+0WKegrbRhoyubBfFgqAenna
 Ea4QD6on0ffEvdF7zpIc0/Kd060W9kI5MZa468AlHkO/8lmfA7FtgmMV5lvUIAVEF/OqUvNwTtO
 cwI+IUbyv+Dj5ySPKHNWF1WDlZU9nODzt9bjGjJxEwiRFaGIZT52Ft3uyTs6tawVhZYXEwMHlud
 IVqc+TrdhtuFuhu3E5FOJpUR5frnkH047fefY+gfD3+vBHyJ394ycePRkQjAA=
X-Received: by 2002:a05:600c:a316:b0:489:1aed:1658 with SMTP id
 5b1f17b1804b1-48a9866e6eemr119176125e9.23.1777906749088; 
 Mon, 04 May 2026 07:59:09 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:6444:b23f:58b2:338c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba6f83sm270015255e9.9.2026.05.04.07.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 07:59:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] drm/bridge: ite-it6263: Drop unnecessary blank line
Date: Mon,  4 May 2026 15:59:04 +0100
Message-ID: <20260504145906.155198-1-biju.das.jz@bp.renesas.com>
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

Drop unnecessary blank line in it6263_hdmi_write_hdmi_infoframe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4f3ebb7af4d4..8a7fb5b2ef07 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -815,7 +815,6 @@ static int it6263_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
 	regmap_write(regmap, HDMI_REG_PKT_NULL_CTRL,
 		     ENABLE_PKT | REPEAT_PKT);
 
-
 	return 0;
 }
 
-- 
2.43.0

