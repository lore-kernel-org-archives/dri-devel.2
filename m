Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD68DC53200
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E9910E06D;
	Fri, 24 Jul 2026 18:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XG3slHku";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC95C10E06D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=+BP3yAfmv0iJDhc03rsvm9pbQVWfq3cvB1j4UIg782o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XG3slHkuYYUv9w+gzQWXlmuz4zl7FC/xS8R8E0/XRCYI4L0vOC4Mio/9cgzxtkoeP
 5PmJ/M9XE+teJCqD0F5p6+VzPJADuAx8FnsMGAKIsfckZbyFykkDQweIIkiZp/UgYi
 0X625OQzZVOPapBE6rJAV1MzeH07F2FWmWSafIk9RYoPR393feTjH8ZwJGPXMvCa/6
 n6LvbRZY2IgrP8dwqu0wAeEDbSglpsgWzKFLIi+BujXzKZqjvtmR6RV4CIYNFHXnNc
 n+J8iMvx/9y5+9dPVMDbtbMomqxFrrHRzs9cuJP6aZRrhXXAG/aoIcVMjZcih06KYy
 WoTm+plwsx2kA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8247A17E0254;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id E2388480031; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:27 +0200
Subject: [PATCH v6 05/16] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-5-041d99a19c4e@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=+BP3yAfmv0iJDhc03rsvm9pbQVWfq3cvB1j4UIg782o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPBjdywFTzDTaVXGdilCObTvMKWIYLtxk
 2K7suQeIqIUyIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qa4S8P/07bfGaDPegp+ACmrRP/MJhMDqIesDaqld6fnMYkczHA21y64CKkseZr2L3n7mOmcWT
 X4+zsKYgXdYx/Z6DQkwhPee/7j3rCYu1nImgE51FSF7/JMxsSPQzl1dX+48xxm3cyKIGlp24TvA
 ypdlWIJ7ZjWN7hUIc4MrJ4NCLBGHlzagTsh7nbIdzA5U475BXekto0Gyq/jE+58jxHXNraR71EO
 ZcALPNOG7GyjoHH1z3kKhsM/Vk4wnSE5QFqG3QTcVESwMgcYTWQ9igzZuVFAe2sIyrhIuDKbQAq
 M9Q5IZe7c5myotflUKflVeXcdJsCSv67Z/7gM9mdDhT3LiK7oaiFW8TBZzfLrE+xiv2fuplofjs
 NVMNRL6GMMA+44Fb5jP+HYj5KFZsP4U1DR9oeEVqX/fW4pSZrTHZejUe9kHRZh/jGpS8TaQzOLl
 fjQfczxMnUE6u8c1LfIyBVGWWTY3LtQeAs+nGJjbgwon33E+POS6uTAa5sqgZKWAb9rC6gmIIth
 /NMUI9/eF1gHDe9q29RPAw7oCHDAAwV6K//21CkaaZI9VPNODd7/DQfZjUTqE5FL/mKTzvBywhI
 /pQqPK+b6D+TzWPBacth74WOHra9xilW8AdXjdpiGk62Wl0oXtTQWUAoRtRPlVWUnOkP0WWvpSW
 R+kORJPKhCqWdIIluoO4sCw==
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
index 2f0ee7ab7feb..7f6506f8d4bd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1797,6 +1797,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
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

