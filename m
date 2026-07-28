Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCC0C54F5C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF6510E9A3;
	Tue, 28 Jul 2026 17:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g4XPpNla";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826CC10E989
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785260446;
 bh=Ccx+QhJeQ1KNv7xuRbgnsS8npvB/wRINLZz8iwrkLyk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=g4XPpNlaT7gZK98tmTUODI//Ku9evjTe/ATkJaZXTo/W1QqsYQ+EY3iwzXwQg8lYd
 HRysTQmP3t4LTIqSl/eRGuF44UFsniLagGU0drSIIcHoY3NDdkfCPdZK/phLQzQick
 azdNoE23npSnTui9J0TrNlyO1PpJYqf4WIJLZ38phEyn5tRh4Qp/VpPyFP21Qv2RAN
 UBBd7Sl4/J959dSWmiwHuftgwzFWjWMQB8TpVCaiv8n8jqwaO1Hb4BvLdWP3susw2j
 RLr57FoxSiV/OHpn9UMcUVbZud4oeGFYlVXgyuWFv1QuB1J2f6b7mhsN6dx/FWBAVR
 vh4YmBSicZmBw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A978617E0742;
 Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 12785480035; Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 28 Jul 2026 19:40:42 +0200
Subject: [PATCH v7 06/18] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-synopsys-dw-dp-improvements-v7-6-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Ccx+QhJeQ1KNv7xuRbgnsS8npvB/wRINLZz8iwrkLyk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpo6Z2VOflWC8HvxPS5FNVqexeGhxvDVz8Fl
 cjjXCwxkY1yL4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqaOmdAAoJENju1/PI
 O/qa/YsP/1nWJ9Pl4XZcTE431N5GCG0Hk7Y2ZRgSE2ffZivIsg3j5MaNYWCpDsk1EUbdxiWcvAQ
 DBf0IALCKRLdgfvTBCJpii8rhis9LD4T8dkjL8enC4F7iYvDge33S6q+KQ73PC10OQx/I/niUz3
 V7ED2SnmUuKd/GjYU4DM9Y+4GdIf8Igr4T4/jDaBUceXWpAE/MG9u1s90K10aUsWLfwDpeycjBa
 myDatRGFNzTkhB6undPhOyhv3Le8JCf5RsVMj4kK7BYoibIFZx7LpRixH+gbT2YqvVxptHcv1Li
 Zc+Azx8RFvPqamn0bKJX51arsuc2SYTSg4NisVDLNkhFF7KQeOQnSZZHdOYRfR+U+5idykRlOdO
 jag3Ne/yRFZLlZrvY7kzmMoBVow6moOCsBgmlU6MvPpcO+j013Ii62CDWqLBWpHSb66vboCyyMU
 zL2w391lK8L8LmyUf0PWc2+EH4oLNqw/6MC4G1me2x5frgTw0SMs7/Pi2uEeQM8MZIPi/Pxyw8n
 puV3P2f8k1l7J2WqxZNlZ+2USkZxWmeTbskLcVw62Hu4Z+UInPNjktRbrpH4yiG/dHMNwEgA9K1
 L/2/VYaV3YGmCbMfRTFyBAkbyqI+pUEyTWwjl8q7DEUsCkYc7F+536ARvBE+XEfMgkaCHjhnbzC
 gzqb8HUGubaQJCtst79c0hg==
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

If dw_dp_bandwidth_ok() returns false for all formats, *num_output_fmts
might end up becoming 0. In this case functions calling it assume that
nothing needs to be free'd, so free output_fmts within the function to
avoid leaking memory.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 1281fe28b0f9..ebb7280ad84c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1802,6 +1802,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 		output_fmts[j++] = fmt->bus_format;
 	}
 
+	if (j == 0) {
+		kfree(output_fmts);
+		output_fmts = NULL;
+	}
+
 	*num_output_fmts = j;
 
 	return output_fmts;

-- 
2.53.0

