Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE49ECCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B775E10F0E0;
	Wed, 29 Apr 2026 17:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sMPusZQ0";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92D910F0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:00:22 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891f625344so490485e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777482021; x=1778086821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuDLjeXf2+QKCuCo/9df2ZiinICm/jlzSdG09cp5d58=;
 b=sMPusZQ0w/VB7W80AQQ7+7u2kGPkMyXXFRU+B4Ay6uspV6TusJHQ4eDfvb/o/9RpkM
 LpG+n9UM/SKz/0byGDYg3oWMx/FCxv1QZIu1lTQyPvRZr7SvGkUZaTKVBhWfYFhN+kWG
 ke5QYapyR5VG6ugF0yCU/gZBF111C24/RPvPoGIdofUOTDMEttdWc13W0HGSWV6MYVKe
 RKcuGpB8XP1Og1MmvAJPpvWKeF0LSI2G/hh6YuunitGHDxk/rIq0QpNMdgzrPPy0jtHS
 u74WEggPeDvUVkC2ccz3y9FU4g34e0CKQ5doF+aL295UvkOJnniCs06ckrGyjdRTe077
 4Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482021; x=1778086821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuDLjeXf2+QKCuCo/9df2ZiinICm/jlzSdG09cp5d58=;
 b=WYzWmAWYwWsupFnOvukwr6McBgGi94nuzGf7ijNFQtm7zskiLJqHmPtZhXbN7//YdG
 NAFpOoV7G1fNwOCooAO6kG4ZLuK4K1h5L0WQ4SLiy8SYq67UTQp7Gd6Ujjkj0sPQuXVk
 IBG2YTjGXpS5mguoLn56GWcVOL5T0w8e2ikGALKEMnBRGK9obCPaU4Iqqa9vNvAEFglO
 uszb/C6U5DVlUd8IFeUwKnhiCPCPulnwJ8Yz/ZQ2fNdwqOPSgyxl/ISRBEmqpm9ZLxiu
 e3yPax/Ra/oxgHUk33QXZYnoZu6i41F5tc62bJcNH37F+9+QgMVJSrjbPRTbWlk65a3Q
 1cpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qzRl/wZJfJVwm221UrNRU+JqdS2pZFtNzvxLz5ZpLh27N24VRPYE+wABC9x3UTq7prS5cbYdrGtI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjQWjCyroE2U8r+FD3NindaU3itYj/sqzG6a13PaIHehytrqpF
 gkZNGWn9S9a/4bAtLcAgR2dEyT3pZDNVsMaSuUTu34Om0FposaTVDYWW
X-Gm-Gg: AeBDieuXABcaX1VC5dTR48TSRDnMKvIN+wmwKV5W2+vkMiG1xPkMm4zzvm/KdYqLBVe
 ZqY+dS2JJQ/OhTJY+VxLsP8MLFSMyoSWvLXHxm3XxXSwXkJkT1CWDAH2ddXrg+jeOYGDLK9kcvV
 yeMM1RPBK7vPF5uG3rYsqKi4Q0XWnj6W7zcf3KtJ72YqJxZAIK6HyKiT2A7uIscR6rgR37v55fY
 FXcKDtVj1kqrULkRftWBvPuVeUxQZ6PBM1vOhVxtbslDrO1nN6tytz2IE12Am07hwMI3jYYmIx8
 hBJ0lgzZtCXlY4OZVjlwFOmBeUQpF5jbgWwQCqEFAgEs8kQcZ6t1CGLk+h3Hmwwqke8jQf8PD1Q
 kFRWgqnLdjPmvMn5TnBmk91ULmH0Fl3AJU75qpr2SM8oh+ctigGGJXeSFV0XtK67u5kgbOh/b5H
 QxEDBR3yb9QIKDedoeKA2+iRouaSrLpzd9smshII5ZQJ756jccZAIGYjMHVB+wUYBpWBI4thkzh
 IncacJYFKYFwfy/FJH41a1d8jXOOZccc1df8MLRSUhMOOQ8
X-Received: by 2002:a05:600c:a404:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48a7bfa1982mr56450465e9.7.1777482021011; 
 Wed, 29 Apr 2026 10:00:21 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:212b:3a69:4f2c:3897])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c856dsm4809755e9.6.2026.04.29.10.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 10:00:20 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/4] drm: renesas: rz-du: Make DU reset control optional for
 RZ/T2H support
Date: Wed, 29 Apr 2026 18:00:10 +0100
Message-ID: <20260429170012.366537-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Update the DU CRTC initialisation to request the reset control using
devm_reset_control_get_optional_shared(). On RZ/T2H SoCs the DU block does
not expose a reset line, and treating the reset as mandatory prevents the
driver from probing on those platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 18e2b981b691..2b772a11c7ee 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -380,7 +380,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 	struct drm_plane *primary;
 	int ret;
 
-	rcrtc->rstc = devm_reset_control_get_shared(rcdu->dev, NULL);
+	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, NULL);
 	if (IS_ERR(rcrtc->rstc)) {
 		dev_err(rcdu->dev, "can't get cpg reset\n");
 		return PTR_ERR(rcrtc->rstc);
-- 
2.54.0

