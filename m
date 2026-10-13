Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D957CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41BE10E7FC;
	Tue, 13 Oct 2026 13:47:18 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7694A10E83B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:47:12 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-887fb6c0ad1so776934b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791899232; x=1792504032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OEd55JoJOoDV13ld4fQoCE8domEIQzBBmawfYivXwdA=;
 b=fA10tt1l+2YUNYrhy9dyv+VdqFjh7Ji6RNTcSUqEyurPbFT7liluhBaYT0vnqdgYBZ
 X180qUYFLK+msGGcqIrsD3WeJtySRpCa3HRQAxBbNmJLGtN7cjgBXQwc7wf8UdACqNqw
 3T/6na0z/Ywq4Q0DZzWMk4SFJtWyTUTkX8ri5Xqq7kpn0uvMxPzjcn1lZHzKoUQoVES4
 CYFfKJRD7gTwbzJmy2GojFWPFnyvAABtYEfqy1n5cJpU4fwr38CD14PkSFYwDhhAj+9R
 Pq9lrLhHgcY+MzTyY9ml9KccZprtYhUtDRP9dq8hg/XnrVhTrbuXEud2P6P9b6tqM7pS
 3FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791899232; x=1792504032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OEd55JoJOoDV13ld4fQoCE8domEIQzBBmawfYivXwdA=;
 b=eaymWa60vKSW42DPFydBbqxfrl4IvOrqwbX895Jek/iTYJUwoUGjhsErR2LTBMYJME
 m94Pu2HLcyHlAurPuCW6SYXLQ+R0e7xEw60vQCNf4pd9DqfuXHm31QwDfx6ZW4GXZ30F
 oMP/vhijNis6COZeT/jg3ovKV+NuiZwK1+e+Ds6Y3FjzDujYzwa/5Jn5VrVcXd0fN9gD
 gMbB3bZI1s5yy5ZGkNNXZ5luMMKPz3uUjRuN+gH4g8ZJ3c/oG2LzjN4Wmp2u2dBuT51s
 pIsvDkB0bjlU48XiXppm7SivihTBtygAVPivi86FXjbNaCGQ0DxJyycatOSDhqVA5G2w
 8Wpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEa9qwrefQ19Ycx76A+X+NhYWLMF7ZiXvLSRCvTugryBIXsT4CrU1D3SmIwyneDrwAlp19MES607U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYILNoIqmBR5bdiI49wxjFsOFOk7VDP5+pOSSKH21OP4uJDXfmnE
 niPFOR4O774bwTeXzEgweP3bUVPHTz7vkaNmc6CUNyOcaOfGpLIv0Dco
X-Gm-Gg: AYBFou0objzpLlrzU6GdwFv24mFx1b9zvlvmt/DwvFhi7T7d2c6sIpq3nlGhCWPG4FM
 oGTeIqDYULp1qRONGUh/G6fKYFRlcr9lWHMCdWyvD6vJw0dsNpzabzdic7Kh0xYgQHXaWNAz/I0
 CyGs93jeFCEiI6yBKPKKusHcIRvlBfcZx6vEQ2Ah49D/Ynlg0+ErW1MmE5o2hR4acg5oDozkhCF
 S13tMWA2d/BDDsa0sXnS2Rz7xaNtGPtmWm6cw8tcn9HGiK/2SEoBY/MzN90GIuqkDjz2qp1ZqIb
 bsurj8NVRMRF2yV9XDkzMl+NnouGW8weroOcSp518w6y+aq54TIc81p2m6NKIJtBhNgTTfNotOo
 HPbKCkEeFWFETfemvsFr/yfttTccwrZg3Du9X6kvxJumfzx931Y+XiLq4keAr9kbc3NkKlvqtyh
 uBB/4H3agplzNibCg0xxJ87gNtQ8L150lUy8LzXSy1RAcs45qtY9yYhH1LeBBcKuivYOlxemrzU
 fvEnhGFOg==
X-Received: by 2002:a05:6a00:b50:b0:882:626a:709f with SMTP id
 d2e1a72fcca58-897c3ff5155mr10872889b3a.3.1791899231770; 
 Tue, 13 Oct 2026 06:47:11 -0700 (PDT)
Received: from arch.localdomain ([161.118.199.118])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3cc80b0sm5044853b3a.29.2026.10.13.06.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 06:47:11 -0700 (PDT)
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
Subject: [PATCH v2 RESEND] drm/bridge: analogix_dp: use
 devm_phy_optional_get() for the DP PHY
Date: Tue, 13 Oct 2026 21:46:57 +0800
Message-ID: <20261013134659.335829-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
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
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df6963740d2..637b1bff0f6c 100644
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
+	 * RK3288/RK3399 use Analogix DP controller built-in PHY,
+	 * no extra PHY configuration is required.
+	 */
+	dp->phy = devm_phy_optional_get(dp->dev, "dp");
+	if (IS_ERR(dp->phy))
+		return ERR_CAST(dp->phy);
 
 	dp->clock = devm_clk_get(&pdev->dev, "dp");
 	if (IS_ERR(dp->clock)) {
-- 
2.56.0

