Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB963C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A99510F2B8;
	Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oODs5DBh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9F110F2C5
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785508929;
 bh=jYYG820tXshJx3PU/SOR9UtrbIPIC5j6ESqL4oAQw7w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oODs5DBhfuTo8yal0/bXsNktyEo+arQ5MyiNiwH6Sf3r2NEVJYL5GVKz/HD7mbQIR
 0df2h4uPY1dZNu7dSkMZAh/xYcbPum8j3uP0QlNYmez/YIJWfotmuqLsEKIieggEc/
 0SZQPGZa+kKUumZFe8Uqxr5tLF7VEngyOARCzsrt1rQ2a3vlnSaVtdf1YdfhPpxyT4
 VXOhRUIyUNahyva3Y7BdB6GwBcruCPu8CImcGHloTH1OG1bjUCakSO3XGAX9UQwXBe
 nkopTGajh+GptE/Da7ZgD+fJbgFdayJfifENeywnDogP+K2NhlQAyYTVSjeaYlchTw
 woXfbRiGRnrMA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A081D17E090B;
 Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0807348003A; Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Jul 2026 16:42:13 +0200
Subject: [PATCH v8 08/21] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-8-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
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
 bh=jYYG820tXshJx3PU/SOR9UtrbIPIC5j6ESqL4oAQw7w=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstEBUYn0qI1l1hWaSDOKwxLop5NMwGr6PE
 JvmW35WJcUQYYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qav8MP/RPO40ojodunQiZWBRnnkJ0/Ozwbu3sYPnpj0AvBVBHWVlDNo1AQB662oMAW15qc/89
 fb5uamVVzKo41QZVuzEmDswVcdd6Hy6I5Xy5Zn67VsPB1CU1EyWDQ3oZdq7oN/GSe2tWigzfp82
 ZJC4XdlcuRlJ78Zn5gB3Pul/fUwk1UgD3EchgjGTpOJiG+rHbwYo4sOb8k87g6FpiRpN+TbWRU0
 x2onZk38LyzNdHj8rEid2I/uNdxs3WsZ8m1JP2EFG/+KYliy+enXUqhaL3to5XNuag+SXIyK1tK
 2r6EIukRyOUunAc8jx2fN/PCIdofxV5V6Q/bQdNrLwcZHO3kCFCkCOmG4w6CyCofOzoiMN95OgA
 BFBARWLwFpcnxPYlMWbzx79vT9LiE/nZ9bJ9Q8Xy+l5+E1PORpjwyLUxxMQ++dvIVz246bE3K6J
 Zsz0VbcrVk3I5stANjFUyQNndgHC4fzEY7ZnGAMNTMXriv6dXchPC0F0nsxk1k/xkQ+9Zxb+nRq
 rL33qrKu4MtkDnynXAf26egv0EwURTG7LJ3Wjm/s+1q0Bwglwq8oGA4SHWYI+4f97s5b/cpondy
 cmJyxxZ0m/ns7P88G57obiFqx2M9fiSMExnmidWyFX5QVJiW1KCaq5Nfh5OnRyvECNnAHuP8aw7
 zQXy4Q13pfjBXcjIYEZQwMA==
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
index 760e1e0f8234..7127928c2650 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1804,6 +1804,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
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

