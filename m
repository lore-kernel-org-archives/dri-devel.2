Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B00C5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E1710F05A;
	Thu,  6 Aug 2026 00:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HvYcU6fC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176B910E1D3
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785976751;
 bh=ducKjBPCYJYhSfXplJWCZV3LtVZN3hY3HVjvA1+pg2k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HvYcU6fCohJEk7cHcudq+QcBz95gMwuLoNFMlVCCL8CXDg14LzxdTQ3C1fkNScd9A
 eY7PMFiDwjtGpL4vSF7KLs9mKnB8I4ArVBJQLti5zGav3PXPrGj40A3eOy5K9RcxWH
 33MUNhiWQdNjgnj3jsyKs7w2nXlGRx4DsYiea1Yl7Zwku44MW0UAKDKu1ychTX/QOV
 uu+YHn7YOZ2iV+EGFnKP8DuXTXCTOBW/RdPvpEbalO9upCaZvANXO+QXW/xn3sVke+
 0uqs66JKQHErslQ3UGkThkzYQ/6Zh4ECKlDX/f54qLjwyVgN/9DcxA8JkGKlvgaCw+
 kbY/HW0vxm1AQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BEDC17E07C4;
 Thu, 06 Aug 2026 02:39:11 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9260848003A; Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 02:39:14 +0200
Subject: [PATCH v10 08/21] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v10-8-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
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
 bh=ducKjBPCYJYhSfXplJWCZV3LtVZN3hY3HVjvA1+pg2k=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpz160npRYqUBlOvpOjumwaS1C+mL4ZNKg+d
 yy6BL/UsAVwfYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqc9etAAoJENju1/PI
 O/qajMcP/1Ab2Tu1NS9cIEkuhHDkc0AdhHAsM2k9U33GRg/1BSNL3WwVj23KFcOoYZjdUXUlxXr
 dBEFbijl/mdo02Fx/P86aN1pLCzfBKdbZoDq2Rm6lYuu2Yduab8r6Fjgskx9bT3bz+KfLMuIv66
 2QVHDev/R+xHmR+hItfXCF5+opkxs1XTCXjIQsGQK03Kb1XSP5FPk8QXkbTsHuKSZsSc9kkd3gg
 LHg6nfNVysrh2G2Rs1jVwqlDNo/yLI+HoB3ksvevmhFLB3j90QqDU+7jGoWkeYcuZeQDhfInWTS
 myJAKZX53W4XL1ZuGkp28NVyYLPSHByvWm8tYB3cc0XdbX43CQxAHuT6alxqIJ7BXbm5P+G9lBQ
 JCOa3WpPUVHPNoCGHfSr5SDBDPT7tIyfeWyPer7e5kE94ZNN2H/WMrvIMRnaAO8JfmFPgURSX+T
 uhRNizCcMOZc/upOVMKoK8kgsNmirMuNWysgb63rv81nQwWTZ+d44ZMvucqvDEy9cdRECBJZHi2
 MzOYgIz7kEjjzsXdOQ5xaiKJqeMrDvlvRcDpBbYQHUqaJ/lFakIITfgt/AuCYNFxRkZlIY6Mk7Q
 YiyN6QuyKua+HfZTU1KzewiTxL7NUYIysnRAFMVGFN7IVml73letAEMU+H/sy0+B441xzaYRJCt
 VEzfpqZu+CdIESMauW8ojqw==
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
index 696cdef279fb..bd05ae9b044a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1819,6 +1819,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
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

