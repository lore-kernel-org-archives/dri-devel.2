Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14184C5321A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6FC10F45F;
	Fri, 24 Jul 2026 18:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iXYkkLue";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA8F10F45F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=dLprRk9J+zndsqWeaTFRzrwihRtem60oKo0i5iDhVd0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iXYkkLueVoJXq6Rd2d/C11rDNonx15sT8NOQrtDQH6ElQOG2J+i3Fx1/9B2YqAYJ4
 HdKSbgPZBkuFid4aD+scYweWZFyGWttR9D5Tt5dEV2FJoJMl6+okuIZLWH9fi/USwb
 zMv8LgJWl82moU51h5Eu0D0/D9pXK9POtPCWGEHDphquczhZTzOCGZo2h/XSSqsmQW
 F/VPQA8/HwrBgy0Z13yX4BB0/7JrMLp+ppYtavQWQYovl75NAa+IfZ/wggI57u6qxe
 y5BK2SfQC+L8dmFINKRT8oNIbdUs2A5HZ7Ol9BOQxDKPuBUT1CPpg7GTn+iAbINRmh
 OwGYrJHRK0noA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AA8B717E031C;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id EF24448004E; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:35 +0200
Subject: [PATCH v6 13/16] drm/bridge: synopsys: dw-dp: Protect sdp_reg_bank
 from concurrent access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-13-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=dLprRk9J+zndsqWeaTFRzrwihRtem60oKo0i5iDhVd0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPBVMhcy6iA7F5gRVzKZAYpQElrVafDQ7
 TXjXZjF6zNBEIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qavxoQAKL/6K2DSitLSKpLVeV9PvmBZFKZf31q98ns9qpHGryljkGMFQFrKOB3Zmx0T70rqs/
 Dvl8jPVxzeWxs1Ces4XL8iICY6lYMe1c7uSun+0LEvDYPBo1DspgxZI6oI+VS8mRFbGPEJ4rUMj
 gAxDnn9+uGmYD6B9R5cDibWuM2Nix8AD+h0VLRyKair/GK6Mc7E/hJH6BheqxymRDG4i8N9XOzw
 8l63Xl+3PNKYvu3Yl507OxmnOWshaCK8y+d9lRyLcf6D3ptyFLd5GhxTnjM9EjNOjrOiP3Ce88w
 QkudCN6WjpZHZ/3m44qymyvJOHbg+kGiOE+lgMUeL8mz5w/c8qLuE4PEgpKcUdplVjUsu+1a21O
 60XHZsUKQIMuByAkalVfDklT6OYxjXRWF92AteninKc/AI7PVfAc/xCEvhuE8sgTp7g1EgK+BuU
 vP7kF5S7S8fyLdG1IvpCRzXpQg6QHYq0DRZr6ARqqnaUko07EwoMHTEpVZmRB+BXAvMxzTBJnjl
 zf/9oG6nW+h5vtTG7697n44n8jGdrPpHil5+KFrvPwyUDQ1uwMrVA6+nIg+AtIKDDnf5OlETznR
 6tOwpkGV5GgIcWEAPGKBGEL7WLhhLMgTtspR39pqLcVVT61lcECLQjWKD+2N+c5ApOpZY0rY0LL
 Tt0VPi7n5yDsNIAT1q9I07A==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Right now sdp_reg_bank is only used during atomic enable/disable and
thus there is no risk of two threads accidently claiming the same bit.

This changes once more SDP users (like audio support) are added, so
introduce a mutex to protect concurrent access to the bitmap.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 1bbb39b8d0be..88b95938649a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -322,6 +322,8 @@ struct dw_dp {
 	struct dw_dp_hotplug hotplug;
 	/* Serialize hpd status access */
 	struct mutex irq_lock;
+	/* Serialize sdp_reg_bank access */
+	struct mutex sdp_lock;
 
 	struct drm_dp_aux aux;
 
@@ -1045,11 +1047,13 @@ static int dw_dp_send_sdp(struct dw_dp *dp, struct dw_dp_sdp *sdp)
 	u32 reg;
 	int i, nr;
 
-	nr = find_first_zero_bit(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
-	if (nr < SDP_REG_BANK_SIZE)
-		set_bit(nr, dp->sdp_reg_bank);
-	else
-		return -EBUSY;
+	scoped_guard(mutex, &dp->sdp_lock) {
+		nr = find_first_zero_bit(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
+		if (nr < SDP_REG_BANK_SIZE)
+			set_bit(nr, dp->sdp_reg_bank);
+		else
+			return -EBUSY;
+	}
 
 	reg = DW_DP_SDP_REGISTER_BANK + nr * 9 * 4;
 
@@ -1683,7 +1687,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 	}
 
-	set_bit(0, dp->sdp_reg_bank);
+	scoped_guard(mutex, &dp->sdp_lock)
+		set_bit(0, dp->sdp_reg_bank);
 
 	ret = dw_dp_link_enable(dp);
 	if (ret < 0) {
@@ -1723,7 +1728,8 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 
 	dw_dp_video_disable(dp);
 	dw_dp_link_disable(dp);
-	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
+	scoped_guard(mutex, &dp->sdp_lock)
+		bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
 	dw_dp_reset(dp);
 	pm_runtime_put_autosuspend(dp->dev);
 }
@@ -2189,6 +2195,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = devm_mutex_init(dev, &dp->sdp_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
 		return ERR_CAST(res);

-- 
2.53.0

