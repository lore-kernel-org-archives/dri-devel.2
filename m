Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7E606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jr9/6FxZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0254010E2A9;
	Tue, 10 Nov 2026 02:37:41 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EA210E560
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:37:35 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3720addb068so2574937eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 18:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794278254; x=1794883054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m9wZvEuCDe3XvfF7/Jwj2zWHljA+DeJITddjwCddf8c=;
 b=Jr9/6FxZ4sRL28XluNnAIoJN91nTn10X//H+tmrH4kRGjkbmY1eS162BF4ahXMSez6
 UoW6KucBx/bquFmVXMHdz3NZ2GIxnVOmjluUy0IKf7B+wGLQYTW5g1VgQKa+aljczD6R
 fj27Bm+otoRyqMYYBBso1ieT09PsZ0oI68NR7wmEsZqQW2i/7yq/X/sZGqTiujMBFDpU
 6sdZDZkZqc+MMi/LhTWUozX4VNORIn2rTHnjtIFh8jtekkZZId20CxTnONYG9gEeIIbN
 1PU6LbmomQiEKdBLYyQpdVp81ZkT9UmztnFiDUjlGlkV45sEoeTnay+00mq1LGmaa8y+
 WiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278254; x=1794883054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9wZvEuCDe3XvfF7/Jwj2zWHljA+DeJITddjwCddf8c=;
 b=jRvb0a7J87/3inLzhDbzhC3SkEDqKTfsBDgraJksd3L6r4mxc8IkoGsTxfHc3YYG0o
 JCxLR6aqVN5Q43YtDmYZRl0vjL5IZVkJ3yh9jHSXcdEjs8DWOnsvF9GhOAl2eTfxry5y
 XBehdSQO2fwU2y7j5xp68NrIjbjCvkPYdWXqcpkvUE/dtVVdPoVT1QeQ3+BYDqZ/VoHm
 J+UiGE1Dg9DYy/IJMf+kWpz4ObQsyvyh1uq4CWyf5QQ7Own1jSWpLrTHiM5c16jxQJEV
 Ihl2YrBO/LLt9EGcepSaHStcZUtwN115/1dQT9JgA97D7hTuG9lzruud9eOZmHhWBCgT
 APlg==
X-Forwarded-Encrypted: i=1;
 AL+hErHA380120BuMKWX8jMY4dBg7uJn/zTPeEeCjShUKuDppxxC1qp9ehYQOJ7Al6wQ6Ly0qkwDns3sOzw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+qoD3EQjiGE75qcHmG412ZJ1zKd87D001PqKM2oZXVnAaevOED
 jcIAYq63vmDK+W9EFG5S+4NUfDMsyiGy8HPhssWACa0Ka8ejlsh/9Vcf
X-Gm-Gg: AYBFou0IpJCb25+e92soQf8c/y6IqY9er6tqyUCYk+bCvr63ckh8BhSrxjrA0aH5Key
 gHjJ8k3OoMOcOB3yMtUZIp4w7MC8vcIfnlhGOOwvCgSfYdgWda7rX/VBSXsrduV4duAUPf9Ri2T
 aU2CaJstGwzRfbJG1RDR1wzzr4bhFXca1Fs8lr09m5IZVr4tdMdDQDh/k5JRJzfOG723cAFLa4I
 pJiHeZ7NpwH/iCcsF2+QxYmwFA1Qh2Hc3osSWgJmR9/YFSv+OhUUczlk9Uf5/D654CNOSh7WUya
 7xKK6464KTh8hzwTQ+Uni263jAILv0LBBzeY9eufE1rC0pr5gBhxtqh9Ete4ktInObmyAr7Y060
 F/65vDUmGhpUbeQH7Ma38mvSq9SFE0wozETWBsRjJzCba+ad3PkuvZL2YSnTcXZTrE1Z5fh10lu
 GJWk4cgc1TweQlguCPzUgVG4C4Vay9EuQgUpzCZ9SZlMagDhTQG4HwFI/cGRMYci7wb1oUFJc7t
 sjIF0zp70ooa3+EB75FiorN8SiWhlITegDG4C8RsHbL3t+moODLIk5dFKpa/vWeKss6quR389GH
 YBaskIz3HyAEOb+Zui1m3V2l0q3s9KB72d1+vgI=
X-Received: by 2002:a05:701b:4354:b0:1ac:2f6d:e1c6 with SMTP id
 a92af1059eb24-1b3b5fa8f34mr1600581c88.6.1794278253866; 
 Mon, 09 Nov 2026 18:37:33 -0800 (PST)
Received: from arch.localdomain ([152.175.35.61])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b54431sm2883025c88.17.2026.11.09.18.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:37:33 -0800 (PST)
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
Subject: [PATCH v3] drm/bridge: analogix_dp: use devm_phy_optional_get() for
 the DP PHY
Date: Tue, 10 Nov 2026 10:37:19 +0800
Message-ID: <20261110023721.2014061-1-jerrysteve1101@gmail.com>
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

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
---
Changes in v3:
  - Add missing changelog entries and reference links
  - Link to v2: https://lore.kernel.org/dri-devel/20261013134659.335829-1-jerrysteve1101@gmail.com/

Changes in v2:
  - Added comments to explain the changes made.
  - Link to v1: https://lore.kernel.org/dri-devel/20260924020417.868588-1-jerrysteve1101@gmail.com/

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

