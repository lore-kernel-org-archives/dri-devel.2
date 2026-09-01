Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81DCC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 23:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1707F10E117;
	Tue,  1 Sep 2026 23:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jb6r1tBK";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B0E10E117
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 23:44:09 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d7195706f1so4220015ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788306249; x=1788911049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q1fny0bMdrHzrb/Y/AQziUWSkRiiitvwLoZ2sKa9vaw=;
 b=Jb6r1tBK4sGpong5dcWig+y1ByKoaf52d1uG1gCy2wYL5p3HnjRi7v1KZTnxVyM+zX
 J87GxpVvhxmtvHQO21vq+WWqtqwKHcZCsg4wBYZC89qVwXo7FKMRgEqmSuq+TN/kvlig
 0BJyhCxrQnA0801dlz66jUCIfRaYlqK3edKhCCC/hAWlqkvjaYRV99Ed/VnkpRc01y/o
 nGZ4FQPHz68mhdaT8H7LTEpwVftINMiiMWeqoZEPNmJDxYsMZZ9hwHNEF0rkm7trE65K
 0h1n7tUYT7WN7g+hUYtji7rVMLBGEbsUZ5MPLB1Xsj2dLxB5W45PtMAxY4GszLEOkRW/
 o4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788306249; x=1788911049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q1fny0bMdrHzrb/Y/AQziUWSkRiiitvwLoZ2sKa9vaw=;
 b=jC86KACJ2IzSOPzTys98OxH/Dc6ZHwY9OrCIaKldplh0oSoVhTXvtYs/aii2MDuYgM
 dyg8Gc5kZmVBLeoOf97yMIzpcNBVWGCFZGEmJgLt+WAP0UUxLU9Q414jUS2QL6j0LFCY
 to+7UifMpQu1oq/VeouwdVIyu1KftROqBQTNAz1ysOyFVw+EN3XEyB+kOyfvt4gfctfX
 d2n8ibYYsiQDvRiPGx6zUWKo2MsCWwresExU0VYlDuDxijWeUBae+W+9XaxZSeeHS+aB
 Melrdv3nlodD21wQTQ+8SdpXKUc6BYZyQgVzgmBBdboQVLhTLeqULtBcMGhEug5tHakc
 almw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAvIb7X7QEDZbNtGgEnsS+onzl7yMhNRe5s6NTAjANP0j1cex2Rjc68bC2+lsBt84gSkVz8NYgJzo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8WyYEsMaYdwD+bflVeHLVDSXScYRCqiRH/ewFUuryTu28uPAn
 m3xp3vvUvVRavSX5ZB8jzyPsLOfXWP09nyeMPt9ut4MY5SeyyEq603pg
X-Gm-Gg: AYBFou2liQ+JtfJBu5DjZhYHezc/X/7RsTp0KHR1zgOqHtaiKQ1FKB65Us2IuXH09en
 ikRyB/N4pY79NZ5fpkO0zUQiI7G0MR97yGdj8Cl7tp1oia225ufS4ZwOdXHO9szTx88g7hxj5AF
 TMORBsv1lZXFSnl+bjooAMeUvcUibQQ88M67q7dUEEwOmeRGvj2ySp5QOGgwisWmBm01XkERFGZ
 qp1uKj77fnrD2pheI0PKUoNSPOLHn4sxTZg/hbwhIwJqRE4QRKedepMnYyWz5Phvdrq93AWpclr
 mdYAyly8YocdGlSNXqur9eqWwmq6KP3gY34ho2yxAsjOaqMTtwan0TcvXWTmBUNtYp+zWRz/wC4
 6cAgnSDNj066ssJMjAnpyJbu8h3zJi3ViH7qfyzAsCgrnjqXcVnd5xL4HZvMLmmiAyMFL9+9LNp
 aI5w0q1h5uX2uUiXmC4SpdV/TkRAaa/YCNUdQ5u2eUlwLMXylOGpSvtoHPl6aLXzxexwTxYxq2L
 e/q8V3Vmo+MhVihEvv7bTUk+g==
X-Received: by 2002:a17:90b:3d81:b0:398:c150:e7b3 with SMTP id
 98e67ed59e1d1-39aedf5d923mr868098a91.4.1788306249089; 
 Tue, 01 Sep 2026 16:44:09 -0700 (PDT)
Received: from anarsoul-xps15.lan (d50-92-231-36.bchsia.telus.net.
 [50.92.231.36]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990baaeec3sm8299903a91.0.2026.09.01.16.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 16:44:08 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/2] clk: rockchip: rk3399: add 85.5 MHz rate to PLL rate table
Date: Tue,  1 Sep 2026 16:42:30 -0700
Message-ID: <20260901234351.190506-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.55.0
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

85.5 MHz is the pixel clock of the standard DMT 1366x768@60 mode,
which is the native mode of many cheap HDMI panels.

Use a 1368 MHz VCO (24 MHz * 57, already used by the existing
1368 MHz entry) with postdiv1 = postdiv2 = 4 to hit 85.5 MHz
exactly in integer mode.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/clk/rockchip/clk-rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index c2b243d7a5e2..db241d2df625 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -98,6 +98,7 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
 	RK3036_PLL_RATE( 148500000, 1, 99, 4, 4, 1, 0),
 	RK3036_PLL_RATE( 106500000, 1, 71, 4, 4, 1, 0),
 	RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
+	RK3036_PLL_RATE(  85500000, 1, 57, 4, 4, 1, 0),
 	RK3036_PLL_RATE(  74250000, 2, 99, 4, 4, 1, 0),
 	RK3036_PLL_RATE(  65000000, 1, 65, 6, 4, 1, 0),
 	RK3036_PLL_RATE(  54000000, 1, 54, 6, 4, 1, 0),
-- 
2.55.0

