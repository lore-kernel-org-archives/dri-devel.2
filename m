Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB3C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05EF10E9C9;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XuPQ676p";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECAD10F69C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:45:46 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed9865so8514705ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789141546; x=1789746346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RmWPw9HQP1XagMM9TGKgOpF0w9bX79g0MmpHkabvFyc=;
 b=XuPQ676pix7oV2Hy/9910939MMmQvWDSPUmZVlGzOOHFeXqu6k1Sqdb1QVO+X+X9wU
 q6nToO5pDwtnvRhiBtpD+DnxZFmpkAwAGKwMolf0iLXvBBKFa65kAKuFyzO6rJWNZPp8
 IuWD2q9db6rvVVhG0OihCQN0MYtlRM5T237SyqGWp8ANYNzMdeAcquJnZs6sVi/KYJOE
 dFzqzCP7aGoY3k6egv9ttMCssdW6/cRB3g9AxhaKeZuk0gQBmKQ5b+Wb318/XwUgxPPR
 QJFM7ppgsX9tRBGETDkrRJT/ipblmSIIP7h8QuDgdRXdb7isyUYZR0HcUk14rIvFD4kI
 7rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141546; x=1789746346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RmWPw9HQP1XagMM9TGKgOpF0w9bX79g0MmpHkabvFyc=;
 b=LjUdWnGm8i5m4RfpHpmGpj6pfvEOzG7hD9T2EoIQE6M4oMPhbQ1qeNddJjy/5oA1FJ
 RIT2iXa4gZiKgEpK5uacmLc60cX+QfJ0g61x6JB15ZNKoy7PN0HPzuzLbU/A+nkOE0Lk
 c8cbu0Zd5r3rAnSxVWkXNlIMvPaQJkFqFiagWYHiwjqLyAVARctclNPUgBw+w49ulo+a
 GdMIEr+BctT6mG4oaHem4JQuU3c+pBS97qsO/EucOU/Odo+ec0i/EO2zOxP1W0WVSkvX
 eoKrn6phAqLGgQsXopwf7J1tDZf8M+9tCXKNcX2jvLW8OsAql4j9AXWF/06fRtkwemN/
 RjOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLklNUEXkfCWSHXQTyrWB4fKOxsx93Z44174uzVRWgSVKpTF1P3xvJk9bmpTjXaQwYa2MU13XZd4Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kbEC10nn2LjZDfVWKUHgTA030aSTtiItMfcmhmXr9zmyx+LRN/
 SMqZkjerlkM+u8dIkjWfYkqwcfH+un2Ls/9bxe+fb/FYihCoVoCedmhj
X-Gm-Gg: AYBFou2XYTcWeydJSsw7Y8Hzusx3x5rVP/S8roFO5RCJVkBp1vbGeF9KNYA+w1pZO4m
 Ya1OtU0aqnKd+VV9UWdu+OM8GYqtFgoxIVkMr/DktLaNHixOYQqihS8kLArqT1Gbh86tM2UagDw
 e9CBld+Tmp+ogYbNqfbxhY6b7PUFtJ6S0cFKAVhnkV0me9uESj5ZTcZMAmswwYB/FfT89YiQ3TJ
 bpMuLVDbUBzXwqOJ1qn4WTV/ryzkaju2KzvL8/KUFX121POsAhf9mPsGe7H/KG8cAUuCfAB4jvg
 G3fqsqEMpwU9guQN2vRQeX69Dg+NDxyqHxGKOeE7TD+y8xBjF+pNWwAAQ6qZeS8Uxt6BfBvfN54
 JMbIYO0hWv8XrTMHK1GUx3LjJYTsCsnhYn3yeAfsiJmYy29+eishNFrZE2B5TLw68DqyyAKOroo
 U7L6zzRlpkhQ6BVl/gGx14vDkSYXCLsS1XGu+/y+Mn6HRKCbfi3w6Pe/EYFnl50oteHvOruuRWP
 8gfykd5
X-Received: by 2002:a17:902:f60d:b0:2db:5c0a:f184 with SMTP id
 d9443c01a7336-2dd2a34fd91mr100447505ad.17.1789141545988; 
 Fri, 11 Sep 2026 08:45:45 -0700 (PDT)
Received: from arch.localdomain ([158.101.31.158])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfc2d3bsm13628145ad.48.2026.09.11.08.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:45:45 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>
Cc: Jun Yan <jerrysteve1101@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/bridge: analogix_dp: use devm_phy_optional_get() for the
 DP PHY
Date: Fri, 11 Sep 2026 23:45:33 +0800
Message-ID: <20260911154535.266121-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:14 +0000
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

The DP PHY is optional: the Rockchip RK3399 eDP controller (used as the
internal eDP port) has no separate PHY device and relies on its built-in
PHY, which is programmed directly through the GRF registers, so its DT
node carries no "phys"/"phy-names" property.

Requesting the PHY with devm_phy_get() therefore returns -ENODEV (or
-ENOSYS when CONFIG_GENERIC_PHY is disabled) and the driver logs a
misleading "no DP phy configured" error at probe time before falling back
to a NULL phy.

Use devm_phy_optional_get() instead, which returns NULL when the PHY is
absent and otherwise behaves identically, and drop the manual -ENODEV/
-ENOSYS handling. This also removes the spurious error message.

Assisted-by: Claude:deepseek-v4-flash
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 18e76d1e78e1..28eb668d3e3f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1427,21 +1427,9 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	if (ret)
 		return ERR_PTR(ret);
 
-	dp->phy = devm_phy_get(dp->dev, "dp");
-	if (IS_ERR(dp->phy)) {
-		dev_err(dp->dev, "no DP phy configured\n");
-		ret = PTR_ERR(dp->phy);
-		if (ret) {
-			/*
-			 * phy itself is not enabled, so we can move forward
-			 * assigning NULL to phy pointer.
-			 */
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dp->phy = NULL;
-			else
-				return ERR_PTR(ret);
-		}
-	}
+	dp->phy = devm_phy_optional_get(dp->dev, "dp");
+	if (IS_ERR(dp->phy))
+		return ERR_CAST(dp->phy);
 
 	dp->clock = devm_clk_get(&pdev->dev, "dp");
 	if (IS_ERR(dp->clock)) {
-- 
2.55.0

