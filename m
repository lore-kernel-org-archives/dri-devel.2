Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB09C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A03910EC7E;
	Tue,  1 Sep 2026 11:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IXzrdKdy";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F54910E3DB
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:25:49 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-482e2fdf6ebso3845901f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788261947; x=1788866747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O15Reb8K9UpgINjG0MBTMyi3oJTA2sKCTZI1fZ2J21s=;
 b=IXzrdKdys7ATESW9NFuDyu0XVLbj2ReNYF+wiBJkPn8mFtjc0iKPk1NGk3E+RmgedD
 1V0ZB5xQRHIWVvh0bzvfHn9oNPa5MpIpRqMgUIB1grRE9hgz7D0aMcv4xt214IzNwHwG
 cAn0fqOHVpdbp0HcgW7Pim/3n7LyYtBt6dqVvUVQotQm/1GMU9b+IbnX8yQ4FWAhpqIj
 380Z5Sg3F/VzIcfKd4kmE4BmTK+bGdIBlAAgDt8cnyvUJpsAGBWjI+P9Kj49jQHX4jo5
 JQLkEVWlg1h23BvbBm+afZ5WMa1c7zMPgcPoE6hVAvH6MCxqlNmnp/X2AgKHqcRSQWSH
 Ap0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788261947; x=1788866747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O15Reb8K9UpgINjG0MBTMyi3oJTA2sKCTZI1fZ2J21s=;
 b=p9CcgmD8nRWcFgAJcrZXJi9Vcsveox9gJ1V1yYhQbcVF/g49qSIHO7GerLSwAxpOOk
 RlKHHnxJRnxV8N8cWyIs0yB/JOicxb4BA4uiS1MC8Qs1AwuKDcZNK1Im9HAR2RLo1HQ5
 cG5qzC1iuin0SIFUWaGYXD5wqKBmzM77VAQh6YcwmWBBhP9YIeYUCrkE2L/bZ8iPGbAk
 dWG+WhfXYM1lDIWrjig7IjAzeZQ2K+M5Xi453T1+1X5ELt8ZP1fnjH+ZnID3Ts3m1rWy
 9hysIv5TbS8KDcFHbzQLwgfaSpMXtCRYrpZtLVhnbOHs9f+p4YM7l7tP0cOFrUHHicu9
 d9Qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB6+YYdAx8+UhiwHS63iWmQ3UOJwMP2uc8VTpGMIxrQ/A/kUqZNJeHFYEJv3GZ9z/ujFqGcDUXToE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nJ12pcK5iQix8PI6jJ9ohnFfVFWliosE7KfFjOb7sG+Z9Ap+Ri
 GvaLWKoaY9qxMZNH35PfoVTo+ftXY301CM2HIp81DjpHzbRAZSOWnQ/Y
X-Gm-Gg: AR+sD11y4cjaN1gYry3q6q8GHx0DgWWgtcPljE79Vwq4GaI2vdnh5MMnaZYYvYh2aNY
 dQ/p45XbJROpNwMj5sgnKqZRwQYuMLE+CmSomMwY32cHQPhm2Gs7RUaHqgjsJn6eE30JxBlkmzZ
 IKBLeeJuyHqIQlG5c6WSfR/SqC5besoVsZOaiWXxeaNyb+FYE2/L7cz55rvAhI71VCR3H/ZXCm1
 nzxkEwuM2ld2PexeI2shbEjU6XEYGp0Gb5SOuJ6gAneZTfmNaWKIwy++WFVRLFBa4ot4vsRy2z0
 MnEbu1Fj2T8jY4LZ5+piQIZQlvnANrHO46MWmU8LI+eBkRo7kMQKMHsV3bLY8+sx4uN7oXee/Yu
 RTvBbxGPiMcNxYlrdpnGKB043aGjpbnmxxUoKUJbdPcN/1V5z15/cyIz1uezm89ZStGMO3zBzIK
 4Vj5LKKJPhx1rKyPXNyJvV6cMzfzC58nEdurqXSCa9AISXiT72Huv2VfoY5og5GNu2
X-Received: by 2002:a05:600c:8011:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-49cdc5660bamr148450025e9.12.1788261947024; 
 Tue, 01 Sep 2026 04:25:47 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c510c9sm226325455e9.0.2026.09.01.04.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 04:25:46 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Douglas Anderson <dianders@chromium.org>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-hdmi-qp: Compute ACR CTS for unlisted TMDS
 rates
Date: Tue,  1 Sep 2026 11:25:41 +0000
Message-ID: <20260901112541.84588-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

common_tmds_cts_table[] holds only six TMDS character rates (25.175,
25.2, 27, 54, 74.25 and 148.5 MHz), so dw_hdmi_qp_find_cts() returns 0
for everything else. dw_hdmi_qp_set_cts_n() then clears the CTS override
enable and programs a value of 0, leaving the sink with no CTS to
regenerate the audio clock from.

Any deep colour link falls into this gap: a 10 bpc RK3576 HDMI output
runs at 185625000 Hz (148.5 MHz * 1.25), which is absent from both
tables. N is computed dynamically and comes out correct at 6144, but
AUDPKT_ACR_CONTROL1 reads back as 0.

Give CTS the same dynamic fallback that N already has, using the formula
from the Audio chapter of the HDMI specification, and drop the -ENOENT
returned into an unsigned int for the unlisted sample rates.

Fixes: fd0141d1a8a2a ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
This was found after testing unrelated patches from DetlevC that rename
the RK audio cards to see the impact in Kodi. RK3588 had audio output,
while RK3576 did not. I'd not used an RK3576 board for a while so tasked
Claude to help triage the problem, and this was the finding. The problem
appears to have been exposed since Kodi reworked plane selection logic
and support for 10bpc planes; earlier Kodi/LibreELEC images were using
8bpc planes thus avoiding the problem.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 45 ++++++++++++--------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 5f4718c3b9db..7cf327de0249 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -307,8 +308,15 @@ static unsigned int dw_hdmi_qp_find_n(struct dw_hdmi_qp *hdmi, unsigned long pix
 	return dw_hdmi_qp_compute_n(hdmi, pixel_clk, sample_rate);
 }
 
+static unsigned int dw_hdmi_qp_compute_cts(unsigned long pixel_clk,
+					   unsigned long sample_rate,
+					   unsigned int n)
+{
+	return div64_u64((u64)pixel_clk * n, 128ULL * sample_rate);
+}
+
 static unsigned int dw_hdmi_qp_find_cts(struct dw_hdmi_qp *hdmi, unsigned long pixel_clk,
-					unsigned long sample_rate)
+					unsigned long sample_rate, unsigned int n)
 {
 	const struct dw_hdmi_audio_tmds_cts *tmds_cts = NULL;
 	int i;
@@ -320,23 +328,24 @@ static unsigned int dw_hdmi_qp_find_cts(struct dw_hdmi_qp *hdmi, unsigned long p
 		}
 	}
 
-	if (!tmds_cts)
-		return 0;
-
-	switch (sample_rate) {
-	case 32000:
-		return tmds_cts->cts_32k;
-	case 44100:
-	case 88200:
-	case 176400:
-		return tmds_cts->cts_44k1;
-	case 48000:
-	case 96000:
-	case 192000:
-		return tmds_cts->cts_48k;
-	default:
-		return -ENOENT;
+	if (tmds_cts) {
+		switch (sample_rate) {
+		case 32000:
+			return tmds_cts->cts_32k;
+		case 44100:
+		case 88200:
+		case 176400:
+			return tmds_cts->cts_44k1;
+		case 48000:
+		case 96000:
+		case 192000:
+			return tmds_cts->cts_48k;
+		}
 	}
+
+	dev_dbg(hdmi->dev, "Rate %lu missing; compute CTS dynamically\n", pixel_clk);
+
+	return dw_hdmi_qp_compute_cts(pixel_clk, sample_rate, n);
 }
 
 static void dw_hdmi_qp_set_audio_interface(struct dw_hdmi_qp *hdmi,
@@ -471,7 +480,7 @@ static void dw_hdmi_qp_set_sample_rate(struct dw_hdmi_qp *hdmi, unsigned long lo
 	unsigned int n, cts;
 
 	n = dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
-	cts = dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
+	cts = dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate, n);
 
 	dw_hdmi_qp_set_cts_n(hdmi, cts, n);
 }
-- 
2.43.0

