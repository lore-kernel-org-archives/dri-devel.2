Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A02606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R1v9b0gd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD0110EFDD;
	Mon, 16 Nov 2026 12:30:42 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2D610EFDD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:30:36 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ea7190aea1so11538965ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794832236; x=1795437036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/bRCXejfhUAGNyTypvLnWT3Js4ffEtsgZQ/cFVYR6A=;
 b=R1v9b0gdnPSUdX/I0L0gA7Za/z35tIP66Ggj90AZcwN8/zJJhBHzUpKupga8EhkShP
 WsJDE1LP0kKdsx24Gy4AEwbzTGY0qY4C0Z3jaHSxRzR33wrogeRX4FKv+0jyom5N34KN
 te//ezxClQpiazRESG6MZ1l+GI4D0jkI736hD5E9TT1zHdxu0L9QNl10sQjWFW3e7afQ
 d3NXlXQuZnJEOioExe76q/kZQ+zbuL0bhrRw25nGSn0gmVCDGZTH8z/ycCwQie3NbWE5
 hK2pw96lT3UVaOS5sgj4/tA1HtIAZcvS5xs8jHDYjhEPQDWyrgJl2AF5VXjbhpGPjghu
 /M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794832236; x=1795437036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/bRCXejfhUAGNyTypvLnWT3Js4ffEtsgZQ/cFVYR6A=;
 b=xJXsf6GCQk23F5TFVmvPayMvPwZ/6EkYsg929tRxY4WH3jZBiQR6odfWVdvE7P1OdX
 qr8UtUOwC6PxS42usgO3Pmi08xp1eDp5qEaVq9omvRL9EZ7qqsfdn6xFNgOjZpdFNgYl
 81D871RW+juV1bnGiMQactyB92koXTyyVbNjcyTSxMt+HRdFECtIjzf5EsKwHbCHVIdW
 nEvTzytzcPcQqqQtfOL6Ke8VAODyUzJ8vrg3/wMpYpzWMIdakkioCqb7YPFEW3GMNNyf
 d9Wzzuk6xJ78TJmtGBuSIsGpyzJ8daUewFX7veUHsBFDyK8aBouJbhzUkozEKZnpJ2E9
 J1IQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFuMqJMNhoXY0+X8BhSvF/1mCCGUWyAsOfqjFuAEcm5oz0eiHYdzpLUlxZ0/b8MbHLtIqYYps5waAM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9iTVsOa3EEq+WuTWA52owLLSZybbUX62mzkhLikdb+e+ANUFtF
 z87ULHmkp59AednKiq96rZRhOJeeHguWAgQUDVfGBMdGeWNCoDPIhelo
X-Gm-Gg: AZFdTZfQ/++qwwGZQtvF1kQUcXKT1vlCD4iTLLmGmUI+xNHuhvVCMnxRGrrgD2otIjU
 6g7DZmvRj23UNp7lgJq32gkh/l8Rsu51YpZeIqjMBTPjXeNvW9RYi17Ww+EnPGw+fZic2ybl2qh
 wVjPTPbSkwUn15p/jl5gYiiBxOL659tuEtE9BPz+8OSub1tAuvLD+NY64/SAGkgY3182j4tTrNX
 aM2qeiHIQQqPpf6ldRyn+Z501ljbMFFbA4dc2oaSQXH6TAqWvy9DxxIVZie5gD8HYTUh4oP5c2x
 DYntwRJjvHkYX3l6MVqzPxj9jpVJglUJm17tCfAYMOEMttQu3n2eO6ZmuqPyEUFYRVKAO6Bk/4j
 zH3n8u/JD6Z4in4KtMUibZGhpBWjyjLhQozOh0UdrpbAgeQHBWuTqmmTRbP4YYryK32ya24ut6Z
 CcCZrWYuzIWUI6eAOAGqyMjBSbva9JtrpUmZsPpVxU1oEhsYhmY5mV8ONtCA8lKHZXsQhVOSFbt
 7oCwO1HnveTc5Na+kJtJ1dSh/zPIfzG+CQJ++s5LAmnLSiweidvHZ41+xnpL+jf71rHSO8MPzta
 oB3v3aB+Iwy9SGVLqH76xTBLnXycLJ+eBfFGGXs=
X-Received: by 2002:a17:903:1844:b0:2e2:e24e:a88a with SMTP id
 d9443c01a7336-2ee0da7f49emr93338495ad.22.1794832235891; 
 Mon, 16 Nov 2026 04:30:35 -0800 (PST)
Received: from arch.localdomain ([152.175.35.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f4acd77sm37607385ad.3.2026.11.16.04.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:30:35 -0800 (PST)
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
Cc: Jun Yan <jerrysteve1101@gmail.com>, Damon Ding <damon.ding@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v5] drm/bridge: analogix_dp: use devm_phy_optional_get() for
 the DP PHY
Date: Mon, 16 Nov 2026 20:30:24 +0800
Message-ID: <20261116123025.638531-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DP PHY is optional: the Rockchip RK3399 eDP controller has an
integrated PHY that is part of the Analogix DP block and is programmed
through the controller's own MMIO registers, so its DT node has no
"phys"/"phy-names" property. The other supported Rockchip variants
describe a separate PHY and are unaffected.

devm_phy_get() therefore returns -ENODEV on RK3399 and the driver logs a
misleading "no DP phy configured" error before falling back to a NULL phy.
Use devm_phy_optional_get() instead, which returns NULL when the PHY is
absent and propagates any other error, and drop the open-coded -ENODEV/
-ENOSYS handling and the spurious error message.

The behaviour is unchanged for both CONFIG_GENERIC_PHY settings, because
the real implementation never returns -ENOSYS:

- CONFIG_GENERIC_PHY=n: devm_phy_optional_get() is a stub returning NULL
  (devm_phy_get() returns -ENOSYS, which the old code mapped to NULL).
- CONFIG_GENERIC_PHY=y, no PHY described in DT: devm_phy_optional_get()
  converts -ENODEV to NULL, exactly like the old code, which mapped
  -ENODEV to NULL in its open-coded check.
- CONFIG_GENERIC_PHY=y, any other error: still propagated, as before.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
---
Changes in v5:
  - Fix the comment and the commit message to mention RK3399 only.
  - Link to v4: https://lore.kernel.org/dri-devel/20261115053625.404795-1-jerrysteve1101@gmail.com/

Changes in v4:
  - Rework the commit message to explain why the behaviour is unchanged
    for both CONFIG_GENERIC_PHY settings, with one bullet per case, as
    requested by Luca Ceresoli.
  - Link to v3: https://lore.kernel.org/dri-devel/20261110023721.2014061-1-jerrysteve1101@gmail.com/

Changes in v3:
  - Add missing changelog entries and reference links
  - Link to v2: https://lore.kernel.org/dri-devel/20261013134659.335829-1-jerrysteve1101@gmail.com/

Changes in v2:
  - Added comments to explain the changes made.
  - Link to v1: https://lore.kernel.org/dri-devel/20260924020417.868588-1-jerrysteve1101@gmail.com/

 .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df6963740d2..6d50ffdae17f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1426,21 +1426,13 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
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
+	/*
+	 * RK3399 uses the Analogix DP controller built-in PHY,
+	 * no extra PHY configuration is required.
+	 */
+	dp->phy = devm_phy_optional_get(dp->dev, "dp");
+	if (IS_ERR(dp->phy))
+		return ERR_CAST(dp->phy);
 
 	dp->clock = devm_clk_get(&pdev->dev, "dp");
 	if (IS_ERR(dp->clock)) {
-- 
2.56.0

