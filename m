Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF4ACA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB9510E254;
	Sat, 10 Oct 2026 11:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lsTJ/1yr";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4079E10E254
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:55:50 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so5366745e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633348; x=1792238148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MUGs28pjyaKV6mm7T8DFRVWF7FBLghSbmcUfgUOr8K0=;
 b=lsTJ/1yrQtCQzMsk4+ewK0DFWEm04yZZeRvXA/DbvYRNOQpf8vOKOGPnK5iBYeuCnC
 h2yKfm9bQeCxQ01hcDmqYgSCfBmM+ivtGk6/1VPNQ4CvR7vZ+vuuRfV8QI6uxotDe217
 1FPdymyUjyMUmTyMm1LRgYe7oXjT6/CJw+a1uacU1DiXR6PiBmtwnrQqWLgNbazTJPK7
 KfUlCAC6aVdetbzZT9MD4HPnGm1xxCAd4cOVyJybV6gqUqkh+wV5rQA7EMe51kEtU8jQ
 FpDGSEJKZ8bLqKpqTFN+P18l7JJcOtYqzTcvvoXL3K/Kx9EkOzK2uR20luIVOW44+LYR
 ln9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633348; x=1792238148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MUGs28pjyaKV6mm7T8DFRVWF7FBLghSbmcUfgUOr8K0=;
 b=tobmkhBGh00N+b0MsFWfDyF5cAzpTjlmW0ekVk4qt1WTYd/kbykudedxkTVO6BRmop
 K9DtQ1XYVtnbkxStrHNyrZFPTBhFUgfRI7sFFJDC+/NDRr8lDc4SXC/rMDBkHVtQ58Ho
 ItoVJv5JUUSSvDeCmmgVXLTuwFM05ySFI/rD7hG5WVK12w6WLRBbXspHK3g7suhdGLNy
 RgR9NUxSFLxeC0uHAaJq+wvCnCpslcwLtUqMztxazuFa+RGcOX4OCDSaPBALMg+l86Bl
 JwD+Ry4l4WvWoYT+18wr8GRtx577z8v0O2+SLBDMkJft+jkSzJNh4WZM2oUjnDyoW4PB
 VKNw==
X-Forwarded-Encrypted: i=1;
 AKwUvByxm+Kf47r54d4I6fF/IV0O27FypmGoL7hEv9T44iWaz9xXtdqpuEIzP2FIMqn98xMJ3IMkWn+yDJA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZLVp46OaG3XKJnW4HFHkDl4Jm7G7H/RoQYuyaYqNZBd/bcb4T
 7aSGpUBrapqalhnxwUFndzRBVIIN9woOPuoCN03idrB8SFqqZA2ndyat
X-Gm-Gg: AYBFou0Tcae4Lr7JmUwE32VyhFUjymFB7GCa4UstxqSudHlzny5GoWZW0PSnOYuaIEk
 9VbJrPYrOS6jmJyYbP0cG1Lwb1dRvmmvvQv0W0mGXmodnhxa6LYuJsC7QXJ4vn4dxZvwIx0cEsJ
 avSsJTh1lUr5ChXHPDQxJh4omzoxp5US4h6mEapSfSJNA6pzkh8ZwsZQPcP9z08D8so1+WHLI/x
 s2W76od/4EOQYTMOPyOxMAwQUtNnI/Mjr7XdkmjT+p8OGBKNa07URKYqjzrtOH//jolhWAUtsit
 n65MeG/aqup4Jk/sh9QFD3HtOIWzdbbaGLKpDJYvpF/kFwn/5V5sxk4dsNQQq9dSiXk8bVAhUOy
 3a9Jfmw6SUzW83U4fRudu8+/HCz/x1MrxXvMnmW7Il1Fp34LGP4Nn4ZMgESyTALf3m0l24ZdTrs
 m8h9w2IvHyggmcNn8mBiA72u5H7fSlGlp62QZaO85bqfwCOhp8pXBgF8W3xQWqQumZkPYzd661A
 ngtAw==
X-Received: by 2002:a05:600c:4e01:b0:49f:ce78:3567 with SMTP id
 5b1f17b1804b1-4a18e4afc3amr83354515e9.24.1791633348096; 
 Sat, 10 Oct 2026 04:55:48 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:55:47 -0700 (PDT)
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
 CK Hu <ck.hu@mediatek.com>, chunhui dai <chunhui.dai@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/7] Add support for Mediatek mt8167 HDMI display output
Date: Sat, 10 Oct 2026 13:54:00 +0200
Message-ID: <20261010115539.9237-1-l.scorcia@gmail.com>
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

The MediaTek mt8167 SoC supports HDMI output via a dedicated HDMI PHY
driven by the DPI1 display block.

Support for HDMI output was partially upstreamed in 2021, but is currently
not functional as it's missing its HDMI PHY driver. The HDMI PHY is
apparently similar to the mt2701 one, but some differences in timings and
in the initialization sequence are better expressed with a separate driver.

* Patch 1, 2 add support for the HDMI PHY.

In addition to the HDMI PHY, a few fixes are required here and there to
actually get HDMI output.

* Patch 3: Some of the HDMI registers are mapped into the apmixedsys
  syscon. Since they are manipulated inside the HDMI PHY driver, we change
  the apmixedsys memory map to non exclusive by switching it from
  devm_platform_ioremap_resource to of_iomap. This approach was copied
  from mt8173 apmixedsys syscon.

* Patch 4: Since the DPI1 interface is hardwired to the HDMI PHY, it is
  appropriate for the HDMI PHY to control the DPI1 clocks. There is no
  effect on DPI0 clocks as they're completely separate.

* Patch 5: Some MediaTek SoCs require a supervisor call to enable HDMI
  output. mt8167 is not one of those.

* Patch 6: In the common path for mt2701/mt8167, a register operation that
  is meant to enable the HDMI_PSECUR_EN bit is actually touching some
  other bits that are set by later operations anyway. The patch makes
  more explicit the intent of the operation by setting only the necessary
  bit.

* Patch 7: Adds the device tree nodes to the mt8167 dtsi. Since DPI1
  is hardwired to HDMI it is possible to bind the input port of the HDMI
  node to the output port of DPI1, but the patch that adds the DPI nodes
  to the DTSI [1] has not been picked up yet, so we leave it disconnected
  for now.

The series was tested at all supported resolutions on the Sony PlayStation
Classic Mini.

[1] https://lore.kernel.org/linux-mediatek/20260921113914.779393-5-l.scorcia@gmail.com/

Luca Leonardo Scorcia (7):
  dt-bindings: mediatek: hdmi-phy: Add compatible for mt8167
  phy: mediatek: hdmi: Add support for mt8167
  clk: mediatek: mt8167: Map apmixedsys iomem as shared
  clk: mediatek: mt8167: Correct HDMI-related clock definitions
  drm/mediatek: mtk_hdmi: Set tz_disabled for mt8167
  drm/mediatek: mtk_hdmi: Improve the secure output bit toggle
  arm64: dts: mediatek: mt8167: Add HDMI display nodes

 .../bindings/phy/mediatek,hdmi-phy.yaml       |   1 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |  62 +++++
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c  |  26 ++-
 drivers/clk/mediatek/clk-mt8167.c             |   6 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_regs.h      |   1 +
 drivers/phy/mediatek/Makefile                 |   1 +
 drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c    | 217 ++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi.c           |   3 +
 drivers/phy/mediatek/phy-mtk-hdmi.h           |   1 +
 10 files changed, 314 insertions(+), 7 deletions(-)
 create mode 100644 drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.0

