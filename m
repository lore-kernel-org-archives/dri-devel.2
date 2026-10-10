Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8101CCA6004
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9C410E7B5;
	Sat, 10 Oct 2026 11:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A7bwVcJI";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DEF10EA11
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:56:14 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so4073345e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633373; x=1792238173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qd6y2NiBciAjRKr5ndbJ7uSamNBWAtmvHRlzXouwwJA=;
 b=A7bwVcJILLHEfCLzT33ouYKP/SPTkfsuDJfKW2QcfNeahEuliBZEQDLhxQAE6aoPVS
 GMtdRWa7JJvR3rAoM57kCaQlk8rBa1xYBGexVY6YJy6k58SvZOtAvEUUwOfcKLvWZd3u
 ZutDhlBd9MPAnB/6q01HrO5pleNfjPNVfFuQm3NSba5zxpGzjYPLvCVKExBI+dETJlF6
 qXjSiKcg8mCKW+v4ybgrG5ZtLPU0kzpe4eb3Off6Wl0YPFgJhHJFOG5sOCaj4h+3Nv7y
 esuRXUDBC+UmZNs+Ee4m3oGam4OpvWCEu0xDtzZFLqIviH0ldPANZMHBj//3DNWz2Ho6
 sU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633373; x=1792238173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qd6y2NiBciAjRKr5ndbJ7uSamNBWAtmvHRlzXouwwJA=;
 b=zDzrFvdsGAx0UUpFlnVLzyxx99LAhBleo6m6Zb7iBCcpkcY19KadnzWkkLg2YQyNRa
 HSeTibYaxbi/XvjVvSPmEWVFLGwUfCd4nj3L21wL9QXze4aBw6llPDnrSUcL0q8NC9EI
 HAzXerggHGKBltsR4HgsdRus8m3PdDTKE/hr7Prw2zaoLKXfryoWUIo+CPrMEJ8UrcOy
 H9P4HXTF51wai8JFTOtb7mxAKc868JmDplQTP5aNabtp9MlvzUOktRWqpYuT+41mvcE3
 7+zwIeZdIigKzE+Htda9Z1pYv+TWI+cN4lr5fWhusHL+zQKa2BebFkIGZUBkwiwuLVDK
 trKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8WUnW67y4GzBXA76yfcoxA7e+MwHevsjPwiHXO3wYm4iQWR+pUlws0y/pdr31uv+O9/YzYetz4D4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ+U5btRF6C9WIidkmbfNYhyMQ3bdjNDaX9jkmGecnRqCg0g6LG
 ni+8r4MhuoPAbXOwcYXZgEJmzeSPtVAalO+mgTHJzC65eVxSEe/17VOm
X-Gm-Gg: AYBFou3DCLMOV9HP+3jlWY5uMbrwqPzwoNBWK/O73F+Ri7hQrdmPPH/Nw1HmWCLkIBz
 7vz91qO25RbMPKql4gtEzmLkWQcXixSTn5QeCGs+9FMAwYvJpGtUGTCMXiDOI+zjzRljrd33Vnx
 UBaRLB8BsJqbtA9lxtKjJFiP6dkbZgrxAgwXD3/EGpJTp3eaAHgkJXMCNsnH9xX5aB++xvQOLlX
 XrPPNt7e3XWbiqwUxS2hRp74fPBPc57Da90UFvbkeKg0h2D1uChhCtV8hLu+/lOx+bW/ZqAwC6X
 Ypcw761mYia+lbtROOZQruRxiTkLGM/Mdxt/T/xb9D7O0nTWihVt+7iWcaySRs8PSFKzAv+m332
 n0GPoAzeLvEL2NiN8OpnJwRomJZpUDV7liafC1ZSgInAB0IeeNZy0scERcDfkXBodVIADDaljym
 H4Rwd+Y2w+ZXKJQL1K8oLlQBDuI7DHN2AjfkpxXevs0qGqfKc5sZeQNKMAbK9E/9uchg==
X-Received: by 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a18e49d633mr79294265e9.7.1791633373147; 
 Sat, 10 Oct 2026 04:56:13 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:56:12 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 chunhui dai <chunhui.dai@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 6/7] drm/mediatek: mtk_hdmi: Improve the secure output bit
 toggle
Date: Sat, 10 Oct 2026 13:54:06 +0200
Message-ID: <20261010115539.9237-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
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

The secure output control bit toggle for mt2701/mt8167 currently sets
bit 0 (DEEP_COLOR_EN), 1-2 (DEEP_COLOR_MODE), 15 (HDMI_PSECUR_EN) and 31
(HDMI_PCLK_FREE_RUN_EN) in the same operation, but only bit 15 is actually
controlling the HDMI_PSECUR_EN bit, the rest of them are already being set
in separate operations later. Add a define for bit 15 and clean up the bit
update operation.

Fixes: 0fc721b2968e ("drm/mediatek: add hdmi driver for MT2701 and MT7623")
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c      | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 9896eaf81e7e..781177a1f190 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -63,7 +63,7 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 	if (hdmi->conf && hdmi->conf->tz_disabled)
 		regmap_update_bits(hdmi->sys_regmap,
 				   hdmi->sys_offset + HDMI_SYS_CFG20,
-				   0x80008005, enable ? 0x80000005 : 0x8000);
+				   HDMI_PSECUR_EN, enable ? 0 : HDMI_PSECUR_EN);
 	else
 		arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904,
 			      0x80000000, 0, 0, 0, 0, 0, &res);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
index 2050ba45b23a..e0c35277c553 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
@@ -219,6 +219,7 @@
 #define DEEP_COLOR_EN			BIT(0)
 #define HDMI_AUDIO_TEST_SEL		BIT(8)
 #define HDMI2P0_EN			BIT(11)
+#define HDMI_PSECUR_EN			BIT(15)
 #define HDMI_OUT_FIFO_EN		BIT(16)
 #define HDMI_OUT_FIFO_CLK_INV		BIT(17)
 #define MHL_MODE_ON			BIT(28)
-- 
2.43.0

