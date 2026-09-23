Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FF2C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFFA10EA9D;
	Wed, 23 Sep 2026 15:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oe0+I2Ce";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A317E10EB29
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:37 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4c79fso392818a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790177677; x=1790782477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RmWPw9HQP1XagMM9TGKgOpF0w9bX79g0MmpHkabvFyc=;
 b=oe0+I2Cev5RWxvInwyJiQLBdVXjEuOa8L3KQzlCtz2h1HZKt1FIfrQX2I7HNzd/OFS
 CNbd6qyMUTv/PLG/arRNmdRwBN0rMjnmE5ehV0SYrkaSkNkZwGz0r+i43cVuCr42daIc
 PA5oemU9S8AlqUjNVeXn82ddCz6MKIuBjYw0tI/P8rz9zAL60ITA3nlSaXTVgtmsV0e+
 MZ6pAvCWrKGezksvt0kd4VjO4nygdDI3PDRdwOdOK0KgrhQzKMwTXbUJHaN1QN577VrJ
 /XGWeMIo7L5lZk5lmbhTZWMhyLQHhnJUQLWv7Y2k7G+XxAqsgMUwrGG0ub8tDLVzwLlJ
 tZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177677; x=1790782477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RmWPw9HQP1XagMM9TGKgOpF0w9bX79g0MmpHkabvFyc=;
 b=vXBdyDfeRtu/cn5cLp9KzHHBPeaiReqVSxbQZYv5/2U09NdfEbrVF0jt+aEKKLNWOO
 jzcFI1leIKSVYSHTuaMG7F0SXyTGZm4LBxM7uxsGHwgvaOMFq9e0jcXAD2n/2xh5Myuo
 fQEvQ93LxfeZX5NdlLmspZXo9tBjhPJumyqviOL9eqJ6q835/b8kVnwws30vmQ1zb5cb
 XcAqNXoUN3m1+yjuCZi6G3bdVVUZYmQ8yLrhjPnodtvdSx/xgzYvO2/cd6udwAxl7c92
 GD+axNoKbdz4WgUb+zk3n4ekjdEGAOncwrxPOLwWcVIjgX+xgVtCU/6PXIzEQ94r2nYP
 Yjhg==
X-Forwarded-Encrypted: i=1;
 AKwUvByVzIgwt1d2pP3Rc0CuG1uHQQEH0iwQ3vyOa0kGvjL9HTYx2QxNfZDWmrgilzEucJcXTRV4j/Mx/Zg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nhKiilmzi2pEnzdQRzyZNmblk9eiJq14kNRcymAuahk85CodAg
 msoORxZjlKVlSMb5TXJcS1gjrUTUDPiDZdGBWwWWOp1RBVGUBPQ8K4uY
X-Gm-Gg: AYBFou3ZEb1yBi+Qz5BE00oY5e+oD8x9fnQR+tmMjfl5yHiR0dWvD2hOUM2Qi5Bk7bi
 FEpVHp53JGL0YKSw6Ckg/kNSUCd6GDituHB+hMp/WBr6UnxiV198aAQdjA+oUDPhQ4SHeWVv88g
 /rA52gP0gTZtBlodMtzqZJfXC0MXG98IWLNaRfEOxgkVFd3Kl3dVOdAp7DcbGepmQnALLIvqxm8
 ZShI2oEfX6sybwWkJqtwdDjt379KOfwRdCmCf7mw0q32NQYjaXHB7e/COs3YIeR5acnrhqtXcDJ
 6UrbnfQHygC5INUgkdhnWvodcqbpICRjxtNqkWs2cH7zmzDLAeDClXD5vY9FlDACIPIn02dmirv
 j+L1OV38U6vqJthJjcY59JRLAFloF/gT7THPmCveliUAO2xUA1z/oPXPsW3sylUrP1dXk28e0gZ
 rVB/SEGi89Q1xc9ujPfEMLXwKFQ4/7NlFkVHBThKp919krhwK8xZc33couYK6w8PmG+bquk3/MA
 jWpGfZbDH32h4mnzgnjF+hHG49fuZsIpxFL+daclC8=
X-Received: by 2002:a05:6a20:c70e:b0:3dd:a197:7360 with SMTP id
 adf61e73a8af0-3ddf8296639mr2981172637.57.1790177676973; 
 Wed, 23 Sep 2026 08:34:36 -0700 (PDT)
Received: from arch.localdomain (123202092053.ctinets.com. [123.202.92.53])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3f5e79sm1318844a12.25.2026.09.23.08.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:34:36 -0700 (PDT)
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
Date: Wed, 23 Sep 2026 23:34:22 +0800
Message-ID: <20260923153423.804759-1-jerrysteve1101@gmail.com>
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

