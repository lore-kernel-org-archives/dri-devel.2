Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D7606A681
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S02yjx4J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9743C10E2F5;
	Sat, 21 Nov 2026 07:41:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F30710E280
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:40:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D92F45F02;
 Sat, 21 Nov 2026 07:40:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795246854;
 b=X6lAcKFK6gRb29k5isBbm8EfYHDcvq37UjZ4ctnv/4LEBJrv1/M3gdIJpYMnFskM/d7B
 5CYeuE+/rxqJYAs6ndpSaF4uCsS5HgTntCwDuK6Ee4MKp2q8i5DmclWZUmpCkulan2MOW
 tjsDFqm6gfewZXaR5blciIJB9kmD5gyXMy/4EvAVerOvfEQOqzB44x+dSJWHakqUQWwnB
 zYw3LhQlj3PHEFZ8KkuTL8TLtKQ0CceWClvd1e9+tAcCfOaTntjKQlJjXp/IPUVq17Y/d
 IQ4UbxKHscnKcsIxfr6uSJrnAXOeOj7Ve4oZG77B9oCUxNgZhNULRKonxbOwnUQ6qlA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795246854;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=bmnIfdFoXFEjiNoRPKpfleglyEVGeNmFcxEoMSCGJKg=;
 b=fwUonyK9EMS2mZhbEXHtFrzBq9Sy2bS20eJN6mnAdajRhmNN8gvAQpcSMc+p+nYQOTIl
 VZDQqT8PsKQoymlu2104hI03oYOljKyUh1HhmgzmkQwWelzJZEodFVyHqWpilpodUJR3h
 /7IVgiLwQa5kX+2joK9NPZi4llPJfgrP7LElKtgT4yzZltjInUTQlT4PSsWHFj5wPjcO9
 ZOPKgBcdo/9VoIXIhC5IxllJCfrFAShI7qNNglPnoW24H+6nKXstIaWSoxFfO/XbWacAp
 qCrFSng95XtlAT2utru5k6fnBwjvCK9w19XL0qR0a9baAstD/kSh4JWjk5DMf+/2dnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 41E6C1F000D3;
 Sat, 21 Nov 2026 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795246854;
 bh=bmnIfdFoXFEjiNoRPKpfleglyEVGeNmFcxEoMSCGJKg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=S02yjx4JhgdZhINP1cU+YI0wS+Kfvc2g+gng5OIfRvwwHleAPLLwwDCuTp6OR4oWj
 VFX7RpErjsBnwUHZpqRlQV2Qba2eTSNSVKi+EjkCgFRZNbNmHlapA6ZteuvHiX+Sp+
 5U5zkL6kb2GDx5WPpAFrOKHxZNOvJKp/NAY7X34EjCMLJCsav2eGrmfj9XPZZn7b4W
 UeSC/41puk57csIqK5wq8oThoJV7tpIUygnJYTDZF1a9yRLFhBsEQer6FHjea/edRa
 iL2WwcbJgbY3zrjpLv3AcHZf5TYdXJRt0pbu9zbDtSqY/qdkRYkOx6MhP2hv92yhy0
 U1Idc4iqfplIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F03F24BB60;
 Sat, 21 Nov 2026 07:40:50 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:40:45 +0800
Subject: [PATCH v3 06/17] clk: spacemit: k3: parent eDP/DP pixel clock to
 the PHY PLL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-k3-display-v3-6-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
In-Reply-To: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795246844; l=1510;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=6gL3YyNmGEMERMvKyqfiL6ksVzl19OCcxFRHkcl1q8A=;
 b=xOg+fwA8J1gM9iymZIoCXGCVrLLRNujuQFn+Eg2HwGBM0Bs74+uXVvOXSlmo0jJt/2Ypn4c3R
 tnw2+PYPlFgBJOItKfW5wwNcb6SZtoEd6mrQQXjsmxeLcYjABScrG5W
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: codykang.hk@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cody Kang <codykang@vsit.ai>

The APMU eDP/DP pixel-clock muxes took their second parent from an
input named external_clk, which no binding documents and no device
tree supplies. Their real parents are the DP PHY PLLs, which now
exist as clocks, and the K3 APMU binding lists them as the inputs
edp0_pll_pxclk and edp1_pll_pxclk. Point each mux at its PLL input
and let the pixel clock reach the controller through the clock
framework.

Signed-off-by: Cody Kang <codykang@vsit.ai>

---
v3:
- commit message: name the binding that documents the two clock inputs
  (Jerome Brunet)
v2:
- no change
---
 drivers/clk/spacemit/ccu-k3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
index 39df15c8a3e6d..8782e55926d99 100644
--- a/drivers/clk/spacemit/ccu-k3.c
+++ b/drivers/clk/spacemit/ccu-k3.c
@@ -1038,13 +1038,13 @@ CCU_FACTOR_DEFINE(ufs_refclk, CCU_PARENT_HW(pll1_d64_38p4), 2, 1);
 
 static const struct clk_parent_data edp0_pclk_parents[] = {
 	CCU_PARENT_HW(lcd_pxclk),
-	CCU_PARENT_NAME(external_clk),
+	CCU_PARENT_NAME(edp0_pll_pxclk),
 };
 CCU_MUX_GATE_DEFINE(edp0_pxclk, edp0_pclk_parents, APMU_LCD_EDP_CTRL, 2, 1, BIT(1), 0);
 
 static const struct clk_parent_data edp1_pclk_parents[] = {
 	CCU_PARENT_HW(dsi4ln2_lcd_pxclk),
-	CCU_PARENT_NAME(external_clk),
+	CCU_PARENT_NAME(edp1_pll_pxclk),
 };
 CCU_MUX_GATE_DEFINE(edp1_pxclk, edp1_pclk_parents, APMU_LCD_EDP_CTRL, 18, 1, BIT(17), 0);
 

-- 
2.43.0


