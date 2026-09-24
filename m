Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B8C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5653A10E9CD;
	Thu, 24 Sep 2026 11:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bCj6rKOI";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C8510F482
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:18:53 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1326328a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790248733; x=1790853533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hiZAP5CE2Qg+2953jUYih6NAEp+heJ/HVnYd8DX8Ozo=;
 b=bCj6rKOIU2EAmTAN82GBRruVPPGdKZ1toO3VRWqCV4NWZhmi5LojwwyiUH+c1utcQg
 cjHQRqWLBQpb5PEXXw8GAH7uu48MEBqx0NaNliqFwz25K5DE6+tWZ0R9JlPFHRbtFSa8
 2yAU/dFLOOxmstq+4gn7VmFFztA/vqdCyJpGu9K4mtRLH/Cz4+gAUqACYQ2JCM0pXAXQ
 gV2aKrslXTEZPCzTLyBGCJ06Cn0f1Olmw27nDUNHIlIzlBL1WHLawYvj7fIfIOyupdlL
 b+dXbdulBZAPTB1g9Y3kKJxYebVE1djLdAnPGeWx74PU7d46NTh7G4kJ5xeGVKdOOpsK
 CqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790248733; x=1790853533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hiZAP5CE2Qg+2953jUYih6NAEp+heJ/HVnYd8DX8Ozo=;
 b=in04jGAHwZhdMIJSddeTP80d+Ci9Zlao1C05FlAgFzIFAZVCHYPcWiJBSoHGUDP6md
 SCASJjemTs60hVUKibtPv9IH6COqTBV2RH0MJpAmRpC+BLqNB8VHctq4ijW5/5beFcFc
 i/d7FvZB25s65C/0tmYFjXSSmujUvXZGHRds73JpxSIgJVKnSW9te1nUON8f+5kj30IW
 KAVfkhzy7fOKMhb2VRd9o6JUJh5EQNT+zJAMXqAw4QiD9DmwcuS1+H7Z8fUeYZtUhAhx
 H61e+/rdiwe2eH5ew3M7A4Ds0HVPjHKHZ9j9iBm9RQseH+LDewP5cIClOHcXJ0xVlX3a
 r5Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGH7s+Sbh3zUUjnIOF0cZKnqrHSMZwjjFA3QCRhS9ynXfS76odJyZvU/4R++mNVZGhwZGDpsgg+9s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nF35QCkV6qJH8PpwAGwBuLI+Xj0zFGhnYV9TMb/MlL2dRjMwNm
 kMKr0WXspqF9tR4QCOMVgId5372ZbUob6W8WxI7XOK8aXfuSs81MBze0
X-Gm-Gg: AYBFou1jac9LIguHZE8Roolq88zF73eQHDFtFLjLU8ch0QoqbidtEqVAA+SmAaCU4ua
 Xz99vt4pG+H3M2L98V0VJTpiNZGqPEiv//xmUrReIYhHG8c/4pX+k4aoDkoqZYPFrJzZeb6lODu
 5zFF0LJr2u6GpSGDQGVh5a94LaFwrIsa1yaIy78yAl3nhIxpvIr3h3YZLcw5hqB9zESNguWC4nT
 Q+BEJvGPx5WCY5WkxP+oeqQANMA7YfCSH9ae46LOh0sQCj2c26XBs+121hUSnzVnLlXo/r7gX9U
 d2dCBPg2/r/XpzjRdfj10FyD3WlPJmJAtp+al+hl/PDc7BUiuUVNYvC+xNe/R5VO+97anrXEZE2
 nOU7NTWzOajBXiY2QBRMX7v+8vUm3uR5G+t0vhtofUGvbRMxhG/dQbmGlKA/BlmzS/eXX1GdGSk
 /X0x12yIuTx26paP5kWSlR8NHbmhWeU3X9/pVpvEgNLMtueWoU4VRMuZWAdK5K5GBP8Neo3bETE
 3Q40cIJQe92a3mN2Hc2aV9HPffW0+RH
X-Received: by 2002:a17:90b:2dc5:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-3a09856fb98mr1677016a91.2.1790248733078; 
 Thu, 24 Sep 2026 04:18:53 -0700 (PDT)
Received: from arch.localdomain (123202092053.ctinets.com. [123.202.92.53])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm4314680a91.8.2026.09.24.04.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 04:18:52 -0700 (PDT)
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
Subject: [PATCH v2] drm/bridge: analogix_dp: use devm_phy_optional_get() for
 the DP PHY
Date: Thu, 24 Sep 2026 19:18:42 +0800
Message-ID: <20260924111843.937649-1-jerrysteve1101@gmail.com>
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
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 18e76d1e78e1..a126c411b5cc 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1427,21 +1427,13 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
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
2.55.0

