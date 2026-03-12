Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949F106ACEC
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF38F10EAB8;
	Thu, 12 Mar 2026 21:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OKh8DthI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9700E10E305
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 21:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NXkaGX7nlKYg5SOHjVLErs+bK3INDBge4zhemVx5PGg=; b=OKh8DthIEg7JIzRIGOeFQbXBP8
 SvjJFp4U25pxM28Gxfc+p8vbyOjCIBb3y2f6FfXBYt+vIVe2m8i2EQV7RY/66p4klKG3j/u9LiiM6
 ReRxyu/yt0zW5QJJW1JLO+Mh6+y4ZXK2S2iKn6Y12NhLUsZY8H/WXhDNX0fJqYaey5LAGu4aZoxJy
 46/Hm7mgJ0l4cE2Zfg27UoL+r8fJS1XJQ6t8rHqM3PjnBWtFYY8OrRqQY8zM/UVDsKpwcRcln025g
 qGDkzPfjJTeHGIlQtfsjlwk1t03jM2b96zi2+E22bgUBLWqTK/4pi3luEP8r3I4fYL0cDJKRfAhFy
 cIGIJKdQ==;
Received: from [189.7.87.203] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0ngA-00ElyQ-4L; Thu, 12 Mar 2026 22:34:50 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Mar 2026 18:34:23 -0300
Subject: [PATCH v7 1/5] clk: bcm: rpi: Manage clock rate in
 prepare/unprepare callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Chema Casanova <jmcasanova@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3491; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=b9Nf4ppP1CN6gGunwOnQ7j5yuk7aAOGVOvFlqCd7cDo=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpszFrt4qjlkf1ummrT3PwCFZq83+cg8JN+uBcf
 M+fXZF2+1OJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabMxawAKCRA/8w6Kdoj6
 qilOB/9K6MYj/fvLMBSRAMEk2tnXWH9G9lORMgjUv964Q93EjhOUVC0DpNqyKXNoxLRQ45a5hVd
 k1CL4HJkm9pvSPMwuIgY6qCDm06rzc+1TOKWx5OzN81CG8Aw9OsmiyVLnsMkxgRp/r+mnSch/Eo
 FKg2M6l4aEn917bWB1ABmDInLN87LdZDNzo2qD3QLciRfxYJnMqqjPPmiusaMkfHlRBB2IkD1c1
 rZzPEaWqbwXpJdo8jkHY5DvaWL3Jv8nBhLKmVGohxwyF/1IjcOk9wjxhRQF5GC/jciNW6csKzww
 +vYK/lC51Jd6Pf1YRK4jd01R7I7R4fwMAT0ZccZAfMRGswGe
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

On current firmware versions, RPI_FIRMWARE_SET_CLOCK_STATE doesn't
actually power off the clock. To achieve meaningful power savings, the
clock rate must be set to the minimum before disabling. This might be
fixed in future firmware releases.

Rather than pushing rate management to clock consumers, handle it
directly in the clock framework's prepare/unprepare callbacks. In
unprepare, set the rate to the minimum before disabling the clock.
In prepare, for clocks marked with `maximize` (currently v3d),
restore the rate to the maximum after enabling.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 1a9162f0ae31e330c46f6eafdd00350599b0eede..df2d246eb6efd0c9a9c508eb7a43a6a70e1c3810 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -289,16 +289,31 @@ static int raspberrypi_fw_dumb_determine_rate(struct clk_hw *hw,
 static int raspberrypi_fw_prepare(struct clk_hw *hw)
 {
 	const struct raspberrypi_clk_data *data = clk_hw_to_data(hw);
+	struct raspberrypi_clk_variant *variant = data->variant;
 	struct raspberrypi_clk *rpi = data->rpi;
 	u32 state = RPI_FIRMWARE_STATE_ENABLE_BIT;
 	int ret;
 
 	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_SET_CLOCK_STATE, &state);
-	if (ret)
+	if (ret) {
 		dev_err_ratelimited(rpi->dev,
 				    "Failed to set clock %s state to on: %d\n",
 				    clk_hw_get_name(hw), ret);
+		return ret;
+	}
+
+	/*
+	 * For clocks marked with 'maximize', restore the rate to the
+	 * maximum after enabling. This compensates for the rate being
+	 * set to minimum during unprepare (see raspberrypi_fw_unprepare).
+	 */
+	if (variant->maximize) {
+		unsigned long min_rate, max_rate;
+
+		clk_hw_get_rate_range(hw, &min_rate, &max_rate);
+		ret = raspberrypi_fw_set_rate(hw, max_rate, 0);
+	}
 
 	return ret;
 }
@@ -307,9 +322,27 @@ static void raspberrypi_fw_unprepare(struct clk_hw *hw)
 {
 	const struct raspberrypi_clk_data *data = clk_hw_to_data(hw);
 	struct raspberrypi_clk *rpi = data->rpi;
+	unsigned long min_rate, max_rate;
 	u32 state = 0;
 	int ret;
 
+	clk_hw_get_rate_range(hw, &min_rate, &max_rate);
+
+	/*
+	 * Setting the rate in unprepare is a deviation from the usual CCF
+	 * behavior, where unprepare only gates the clock. However, this is
+	 * needed, as RPI_FIRMWARE_SET_CLOCK_STATE doesn't actually power off
+	 * the clock on current firmware versions. Setting the rate to minimum
+	 * before disabling the clock is the only way to achieve meaningful
+	 * power savings.
+	 *
+	 * This is safe because no consumer should rely on the rate of an
+	 * unprepared clock. Any consumer must call clk_prepare() before use,
+	 * at which point the rate is either restored to maximum (for clocks
+	 * with the 'maximize' flag) or re-established by the consumer.
+	 */
+	raspberrypi_fw_set_rate(hw, min_rate, 0);
+
 	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_SET_CLOCK_STATE, &state);
 	if (ret)
@@ -387,9 +420,6 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 		}
 	}
 
-	if (variant->maximize)
-		variant->min_rate = max_rate;
-
 	if (variant->min_rate) {
 		unsigned long rate;
 

-- 
2.53.0

