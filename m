Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F577C9830D
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069C610E141;
	Thu, 24 Sep 2026 02:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="chMvUUfF";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E04110E141
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 02:04:29 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8686f46e4adso1065020b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790215469; x=1790820269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RmWPw9HQP1XagMM9TGKgOpF0w9bX79g0MmpHkabvFyc=;
 b=chMvUUfFbobFC3gRSLLGcIAggwdsbNtQUvKWnmOHcFw+FQCYSkQRP5idrcuqZofOt0
 0mtYBiD34BAbptV2T9kbjl86FfhbV5Ob5Peo4SXjCWDMJxOtwD14bfp3Z/KYNIuvx+/N
 0jQPoQ5uKgjEVEkxBn9LrfEXGoLar2mA2x6+faT8r96v5mak35OzAmuLrMvMMmav43fm
 bygKOwWzaT2gRnbhxwuhDPQFBqzqtHMHestBYQrq2aLqYUAH8DtKqzDpzTGZmH/KoTEh
 S3KWJm4EfrB7XirZvhbKrNx5fN33SNCSBsT+X+SWH/tx0Kmg97HPQxTqHWBa9tk1OeAg
 fCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790215469; x=1790820269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RmWPw9HQP1XagMM9TGKgOpF0w9bX79g0MmpHkabvFyc=;
 b=VlO0iln/r+YyUjxs7DGsi+4eshYoZV1A0ea5YFoJojnc5bRorFBH1lHwxoL2kMBa+Q
 x5gGrmt3r5CorDXL8kWzzOETq99SJecCDgQyZtR3hRnDT3QzinN5kt3cZVFzp6AKC8NS
 zoqHexUOpaBkr51sQpFH8v5etUMPXD4G3ZP7JUxJw83SxkErygcgaG+QFRe9lw5IrN+B
 bCaTfI2sW7BcZGZjcodNbBwqv3/nA16nNW6a84mLL8SuI/NeUD2x1iXAZjv6AjHUhLEt
 NDsHcBaGQjqW0GG7yxmsZ61NkLc7GjZMbmsiASbphrTIgUeWBDEai4AHyFTUh7LVS+Qn
 uobg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM/1HGeUZKry2psbClBS3G1Q/rlDMjaTN4fDdCS+EkCaWKfIn93FvRRRItqGdJDUPgbTUxjpkO620=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrKBEaEHb4+PE+iuCBTrtTYd0qEwRb9g5I3eSmlKpMfERdH3M/
 POqkF0LUvs4j9ROxGcBNYk6a0YtOts+MPz0cPV3i2kcW908nWQidHQxn
X-Gm-Gg: AYBFou1jek3WPQ85+AGIBHg3YFG1sutHrtqanlkwlI4seEP/3oFaK/cLwSzZRergoSV
 yRE+RQ2RE4jbmcLyu7+YyxlnbCCWdsKGm0yqH+p0OL/1z53D7Kw2Yu0vymKNVPgGk2x9+1S6JkU
 5Baf83PSdaAU3tEmza1fPArQnhev7bRLDVzE9q38J5nC5oycy/bZFXpwbEKKTBKoWz4o4pgTnYU
 veIWwFBwpDnTm7T9aPTrprwpdZa1kTWYiueDjORVIyyUYDWuZ9CaBopvTW73U4JeCwfGJpvrXDA
 fwK0keQbvaKFTUsWa89HXi3HBkH/wvAkbN/kG6+LSuY4n7/ZHQsebqlMFtPBnf+bRIByFCfJnZ1
 S0bPpEVmlvZaCxkeLBdqgi2rTKEeAHBAHYMI+tJFl38H4EQm7ynwebhC1DLk6oQq7qolfd3LmG8
 KsuV49iXBbidZOf+OPuZIjrvrzy32yQ/fcaUtAKSrNo+FxcPg7NJgU2PCnEzJxTQG1tw0R5mDfZ
 qtAlUZ7d9kyLO0B59F6HiqW36U7u4/D
X-Received: by 2002:a05:6a00:6088:b0:874:706d:856d with SMTP id
 d2e1a72fcca58-87e9b3ba37amr753328b3a.30.1790215468861; 
 Wed, 23 Sep 2026 19:04:28 -0700 (PDT)
Received: from arch.localdomain (123202092053.ctinets.com. [123.202.92.53])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d5c1331sm2041625b3a.24.2026.09.23.19.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 19:04:28 -0700 (PDT)
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
Subject: [PATCH RSEND] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
Date: Thu, 24 Sep 2026 10:04:16 +0800
Message-ID: <20260924020417.868588-1-jerrysteve1101@gmail.com>
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

