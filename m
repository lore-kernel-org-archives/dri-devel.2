Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E8B1090256
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B5C10E517;
	Thu, 19 Mar 2026 16:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yidyz1+0";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18F410E516
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:48:38 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so12766625e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773938917; x=1774543717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bng5/yZC9lrbuKxC9dU3uqE7D/V7iSIEJ7NDOj06TGk=;
 b=Yidyz1+0xvScc7/kBTy8z5XTBotG+1n9Cs0flaRfqgCl9FDXZm6pIt81xj5JViLpnq
 6MyKkMwXE8SiM54CZiT9Kv9wTeHGbgAFQN01+V2giP0IKF2wFRg+MV59W0luj699Q3bO
 dV0Wa2I7uQ5YrdqPwcXZYgi8gU2zr5Uy2CW+BVgNd+Al8iRSBBiQKuKUqPV36o67QW4r
 7Bodw6QWCI94qql3wNQ7Kkass7DQwo1tfloPBZnKHjObJjcuiL7cIv5s56EwkkaHX6Zl
 kuVrOh06w18NT/2InNlKvudS/8PzlTcZRZjAEeEFKgoTfhd6GL5URJ7L25RkBBgLQV6v
 6qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938917; x=1774543717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bng5/yZC9lrbuKxC9dU3uqE7D/V7iSIEJ7NDOj06TGk=;
 b=ktNJOA6rqIfBqooaxYMoF2wsxWmBNRWgNSJAVlFQnekZtmSYRmbn7/8DoIKHH2Ry9M
 fUyPNuk/l86klII2twXEmBE3UkQDwWILn4xmHxik7qyQgC7rear64QqMwg3gjltGcXYj
 e5olLzl/HRrNRF2VB0VZjqD5FM764SUABdyOreSqkBi4wDAl9UgFfC4h5F4FbG1TDn1W
 7ebupdEsH/h8AR7VuH1blpP6VXa5h6on7N/QiN9ZoSwzAThTkvmxBjGTJqXREsdRpCS4
 Q6EbITjgMHFbFKZ8CM8VmCleOHS49NOmgxIiJRmksbD1114Q3I2eFE8gPXjGBLoqyhFO
 XPxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvEpriPd4NcOqOvt+5SfoUmpdQ/wfP0KXTDpydzIopqEjdHYqazwibS1FTPZzvTt/aEeL6bGvFS5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySPGhwaQm19xjEto5l/qKZHJfgZp4P/+3Fig/cY8Yxv4BfpUdA
 n7nRuTHKc6w4vaeKHWjqmN+FiV6dn2vflnNXrWIw4U9QLwNh1vRNhMZ1
X-Gm-Gg: ATEYQzxEeEPTK4dbURvGa/D+bkawSUADuUjo5hygeujHeq+4aViIDiSACrksHqN0Va+
 rzrdI1TwxINL+pQKvKN2FFQ15sl/PVOfx4zp4JWVumVHg9NKiiSxQPgGwwrTyq19kHPldSLsMXx
 fsAG/Ildw1LKRYR6twJiTKKEaUOSvhYhx3O5Q2LCGArBhSrd5hFG/UYU32ykP/iS5YOXNKvz5oq
 wR/uTcBsfiUKon6+p07wOqUZqnJCijTzpdn4WvWtNEBb0PM6ZnltGKNBRP51+n2R72jbz5JL7/t
 eXvw1362q+hbKQU/Ci0F6jnaNCSUeDQEM0POZSJGPtSLXjyoqQuy0eJwdkIBhIdxRtlwNjtKoqL
 s28yOPaBYuaL33NFXNFkZUXsQcXBJuHPH/9j86GingMpI5h+jIv+ta0GrZMBCOaYnYBxvYdMtlO
 8NU89r9VhG3u1Giusp2O1Zqg5/DZGI+20=
X-Received: by 2002:a05:600c:c490:b0:485:379b:57bb with SMTP id
 5b1f17b1804b1-486f441bc19mr132327915e9.3.1773938916947; 
 Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm: renesas: rzg2l_mipi_dsi: Fix assert of CMN_RSTB
 signal
Date: Thu, 19 Mar 2026 16:48:26 +0000
Message-ID: <20260319164833.409126-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
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

The CMN_RSTB reset signal is not required for reading PHY registers in the
probe. Move reset_control_assert() from rzg2l_mipi_dsi_dphy_exit() to
rzg2l_mipi_dsi_stop(), placing it before the dphy_exit() call. Since this
reset signal is optional for RZ/V2H, the call is a no-op on that SoC.

Fixes: 2991c3f0ca86 ("drm: renesas: rz-du: mipi_dsi: Add OF data support")
Fixes: 418bb3a69e13 ("drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index ff95cb9a7de5..d2da247abf05 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -541,8 +541,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
 
 	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
-
-	reset_control_assert(dsi->rstc);
 }
 
 static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
@@ -822,6 +820,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 
 static void rzg2l_mipi_dsi_stop(struct rzg2l_mipi_dsi *dsi)
 {
+	reset_control_assert(dsi->rstc);
 	dsi->info->dphy_exit(dsi);
 	pm_runtime_put(dsi->dev);
 }
-- 
2.43.0

