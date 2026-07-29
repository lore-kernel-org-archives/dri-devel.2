Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F704C54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C76B10EC11;
	Wed, 29 Jul 2026 12:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CNtAwVnE";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFB110EBF6
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:26 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso812067f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329725; x=1785934525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XKm6yCQNcksyxuIgpcHIoi9E5tjt4D2YVHPUd/lYDCg=;
 b=CNtAwVnEwoUo97KrtOLgISbZMhr+hL3SKr9NZeK45klows2WA6wPgTSoHElXbnc8Xp
 GmBIY2Q71C/cYhqyLH1G38M0VCIuc7Lvnus9iXRqFh79USM/qPIjANDbl9S0Mx3Qtmnt
 N0HJXiHRFjXQhYV8WjeWbaiSocIOd4YIYAj8NKUl7gqJkQjd/C5Fh8u7SaMA0MEV0r24
 7Q7nbUQBw41u4Tmy0/E2+2aiBfqstFZuRKPISJTqox99GrR/NTr6GeUQrm0bo2/yjuEu
 5WE4f6ZchqsjXoT5th+gw/p95kvZeqwbsrAOxAhHaAbfr/qPXcbEKwFzjzadMGLhCl1Y
 3J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329725; x=1785934525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XKm6yCQNcksyxuIgpcHIoi9E5tjt4D2YVHPUd/lYDCg=;
 b=JoB/Il26gwLQ53+2LeYblhi3YfzNy0UmjWEYRAjAKJIw6htPvRx4fskPKmL4hPGMBW
 FO7WeqoJaB1D631p4rN4GiwaBxOjww+KHG4PV+gQP68cw3UuZDFMHRc6ZCdsEGw8cyLG
 dXYK2UhfYglVg44VKTtINfmXkPFk+XnA/QMi9STADzbq/lPttfBGzNPRTjaBKC5F3Mqh
 ElWYVz9nvW364jBqRPNrHbJJPmBH5Rs6vLUK1EPO24VSfH+CU52Adm2avQuAgUJABIMa
 R1fUYuBWu028xUUH6rgP7nAwDv1odoPPNe/QignuEZf7ubNQiXD9ZPSyPC8PSjXVadyk
 DC6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGnALdXC90KEmoWu7XRC5KNJsvow1n7bJT6NPds3Ti1qLRbFcTlt0YOxHhc8LdKDEVjVx63tWOl2U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3E5S8N+L1d342QImTJLu2ktO3KfOCoOi/eBDAF89hknPlud9z
 By8RZw82n4F9J97c4LnzxTYT7rYcy8n5ulDQFuy3djzsS8bZGXLDoafn
X-Gm-Gg: AR+sD11XyeLkEikM98JGVoWuNzC6Q9pYfhTLcx8AKQJ+VIldaaRZfyBdVZ/gBrfOQak
 vgza4RH4u5qAi+KrzGiWbv9sncNwzrTfb7rirFBLalooky9dqgEALfgVOQKB/HoxF9yZ6Lv32io
 rzs2rDFT5oNLCphf9UDqJNuVAxQsxe0GyZZiwhiA72RMa5ngw8dKDSZS1nvIYJSVHrAcPwK2IOw
 xK8Fn+WoRQqP8kV0MsKpW5RZlQcMvZaOmPtts/86MB0wPK3aNZSmbQ/V1H/JfJM5qsDURDYNTT3
 sJIdqFij83IQbd5i4Yd6/mot+ulKgy+ZSNnjtOMbW3/lm+rl1k5vv4PDgZ5lmGtXi4vzNl4N3iR
 t7D5c+mMw8raUwUOwGul/YurMj1zoRdF2dH4Gf0BOJD61SsdhUKHT2GrVvi8Xdz8ePmm0z0ozz/
 CLgMhhoQFP0iX9FLZk+kUUXQubHnhPHV5GUk1mHTh8GYuXC2k0c5at6pAaT7jr/umIQ6nj+Arx4
 DA5YRRZl4RIXw==
X-Received: by 2002:a05:6000:41fe:b0:475:f0c2:75b2 with SMTP id
 ffacd0b85a97d-47fbac058e0mr2854007f8f.29.1785329724602; 
 Wed, 29 Jul 2026 05:55:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,
 dsi: Document RZ/G3L
Date: Wed, 29 Jul 2026 13:54:53 +0100
Message-ID: <20260729125516.230757-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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

The RZ/G3L DSI IP is similar to the RZ/G2L but has different global PHY
timings and also the PLLCLK is ungateble clock. Add the compatible
string "renesas,r9a08g046-mipi-dsi" to handle these difference for the
Renesas RZ/G3L SoC. The power to DSI region is controlled by SYSC block.
Document renesas,sysc-pwrrdy property to handle the power control.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped renesas,sysc-pwrrdy property as it is modelled as power
   sequence.
---
 .../devicetree/bindings/display/bridge/renesas,dsi.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
index c20625b8425e..3832a553871b 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -28,6 +28,7 @@ properties:
           - const: renesas,r9a09g057-mipi-dsi
 
       - enum:
+          - renesas,r9a08g046-mipi-dsi # RZ/G3L
           - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
 
   reg:
-- 
2.43.0

