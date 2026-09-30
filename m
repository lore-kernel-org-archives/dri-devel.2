Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E09DCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64F910F1E1;
	Wed, 30 Sep 2026 07:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifOG7dAH";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59BFC10F1E1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:05:58 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso3102715f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751957; x=1791356757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u+ufq/9OYpFWz0jYyxkMsrt/5JaGVR8WMolNjJI/6Zo=;
 b=ifOG7dAHtLZnhMjHJEwmmqvF8EnVhi0wX8pJ2a+rNx7aCasVPuKvLv+qHKkpswUa3K
 lxgdlKF1jrlN1vUIUb9778WQafCk5T9NpXLECqPTOkzwBbQPzzaLAgLNHqOxhFJGadgN
 yqK2+FDbFtc6IyzdhbUmRnNNXbeCFpt37E3Np/F8+4i9CMVKvy5BlnopL9POO/scHrWP
 RCs6JcYxvj5bwMz1XQkI4743uPfBvUcc2A87N04aJAgtOlz2AQdTAIcwZAXtopXDu0c7
 zQnghoJqrgw8/sf3r2YLHRfTSZxb+6gl9R6aGAUiNAPWes9VGH0Y7kEObbmRrf0o7+dA
 uOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751957; x=1791356757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u+ufq/9OYpFWz0jYyxkMsrt/5JaGVR8WMolNjJI/6Zo=;
 b=t+O8T4BEcrbOi+KAHiLPJGldLlMUMUhpUqNxcQEt0fJrLMxEOSU14j5ivxZzf+tXu+
 fTLRoVLVbv1KBoWhZkuS/YQhigshaxcJzMvjiFgUBnaaj+u5xaLA6WT/aUSqWpw8uVGE
 rdnWrlu/l3PKNL6Uvk3KdV/sF/4R/i+D/0RZosv7GB7bWO+noy1c+qlfbS43ksyLWXQs
 AL/CACV6kNwrQNhlVI8J2Nw5t4AyyMaIUIH5/eIWCJE3pMGvN3eTEnhQdabgd63bBQmq
 5pH0rNHJJJNiY5jC3+0NuEFOEPaI18wT9K/izbbsqzDD03UfzzfoBrhfpU0OY/hgUa2h
 p3cw==
X-Gm-Message-State: AFq9FYLxMOzaeIAbG2lN9RCkJgIk5p9x+jPffHwTv0JWNeYAyi51iBoT
 DleAvHcHDlX/VcxQ/qVgPEknGQRcLFuvrdLYiwicSAZv5FPtQ930sXVs
X-Gm-Gg: AYBFou3D0Zv8YsoffBfoP/u3QF07jm8sD+3VM7uRPnrXxNfqqoSANG7dUtV0u+ztfS6
 XZVss5yCm9z7Bu9zHkR/R6jaR5NBlmRfVEbZZ1Bs4t/0vwtvTZ10HmEHf91uRvGZJBBq7+NuOb9
 fzLQ4l3GVPf8DdHilwoMpi67PZbSIgzXc9pm09Lu7BtFy11tqpqQUxapP0Dg5H0R9/dWiF+DBPz
 qzePoRfcjIGOaMXtcFD+Q8ovPgzm3nv0ZQ9VWxzECUQvN1uEZEzraPuV0TvvbCZBllzU++84pV2
 oK2N6hh/hZhzZH2yEG0xSi16IE802YS365/9quS3GRlUZ/4y+JePdzz62jRIKv57u632yrJFJhj
 +PbLxEd7DvldILMQvvMgINHZuBh7M7Go+ZWYOBA6LNi8OvTnWiloX/wieQo3jdC8eYfEQbVLfrS
 QYnjwoXSUiK//n81PZNRl226xbtxpJkqmBA7H95sfEPYbeAusGmRhlcm++pWy1EAxoGbBSbfZI8
 TwNJvFxBsNpKOfLPP+ZF73VmVy8OJY=
X-Received: by 2002:adf:e191:0:b0:487:aa6:c90d with SMTP id
 ffacd0b85a97d-48b0244dde4mr898761f8f.1.1790751956592; 
 Wed, 30 Sep 2026 00:05:56 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1145150f8f.27.2026.09.30.00.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:05:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/6] drm/tegra: dc: Expand available registers layouts
Date: Wed, 30 Sep 2026 10:05:30 +0300
Message-ID: <20260930070535.47130-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930070535.47130-1-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
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

Expand existing DC register definitions with additional fields in
preparation for adding the 8-bit CPU interface.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c |  3 ++-
 drivers/gpu/drm/tegra/dc.h | 54 ++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index b0bfa946e6979..5c67928bcabfa 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	if (dc->rgb) {
 		/* XXX: parameterize? */
-		value = SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
+		value = SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
+			SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);
 		tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
 	}
 
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 0cb0515968b35..5679e1ca0c2a5 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -274,8 +274,11 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_COM_CRC_CHECKSUM			0x301
 #define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
 #define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
+#define LSC0_OUTPUT_POLARITY_LOW BIT(24)
 #define LVS_OUTPUT_POLARITY_LOW (1 << 28)
 #define LHS_OUTPUT_POLARITY_LOW (1 << 30)
+#define LSPI_OUTPUT_POLARITY_LOW BIT(8)
+#define LDC_OUTPUT_SELECT_V_PULSE1 BIT(14)
 #define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
 #define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
 #define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
@@ -303,9 +306,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define  UNDERFLOW_REPORT_ENABLE (1 << 0)
 
 #define DC_DISP_DISP_SIGNAL_OPTIONS0		0x400
-#define H_PULSE0_ENABLE (1 <<  8)
-#define H_PULSE1_ENABLE (1 << 10)
-#define H_PULSE2_ENABLE (1 << 12)
+#define H_PULSE0_ENABLE				BIT(8)
+#define H_PULSE1_ENABLE				BIT(10)
+#define H_PULSE2_ENABLE				BIT(12)
+#define V_PULSE0_ENABLE				BIT(16)
+#define V_PULSE1_ENABLE				BIT(18)
+#define V_PULSE2_ENABLE				BIT(19)
+#define V_PULSE3_ENABLE				BIT(20)
+#define M0_ENABLE				BIT(24)
+#define M1_ENABLE				BIT(26)
 
 #define DC_DISP_DISP_SIGNAL_OPTIONS1		0x401
 
@@ -451,11 +460,30 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define BASE_COLOR_SIZE_888    (  8 << 0)
 #define BASE_COLOR_SIZE_101010 ( 10 << 0)
 #define BASE_COLOR_SIZE_121212 ( 12 << 0)
+#define DISP_COLOR_SWAP_BGR	BIT(16)
 #define CMU_ENABLE_ENABLE      (1 << 20)
 
 #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
-#define  SC1_H_QUALIFIER_NONE	(1 << 16)
-#define  SC0_H_QUALIFIER_NONE	(1 <<  0)
+#define SC0_H_QUALIFIER(x)			(((x) & 0x7) <<  0)
+#define SC1_H_QUALIFIER(x)			(((x) & 0x7) << 16)
+enum {
+	SC_H_QUALIFIER_DISABLE,
+	SC_H_QUALIFIER_NONE,
+	SC_H_QUALIFIER_HACTIVE,
+	SC_H_QUALIFIER_EXT_HACTIVE,
+	SC_H_QUALIFIER_HPULSE,
+	SC_H_QUALIFIER_EXT_HPULSE,
+};
+#define SC0_V_QUALIFIER(x)			(((x) & 0x7) <<  3)
+#define SC1_V_QUALIFIER(x)			(((x) & 0x7) <<  19)
+enum {
+	SC_V_QUALIFIER_NONE,
+	SC_V_QUALIFIER_RSVD,
+	SC_V_QUALIFIER_VACTIVE,
+	SC_V_QUALIFIER_EXT_VACTIVE,
+	SC_V_QUALIFIER_VPULSE,
+	SC_V_QUALIFIER_EXT_VPULSE,
+};
 
 #define DC_DISP_DATA_ENABLE_OPTIONS		0x432
 #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
@@ -493,6 +521,22 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_CURSOR_POSITION_NS		0x441
 
 #define DC_DISP_INIT_SEQ_CONTROL		0x442
+#define SEND_INIT_SEQUENCE			BIT(0)
+#define INIT_SEQUENCE_MODE_SPI			BIT(1)
+#define INIT_SEQUENCE_MODE_PLCD			0x0
+#define INIT_SEQ_DC_SIGNAL_SHIFT		4
+#define INIT_SEQ_DC_SIGNAL_MASK			(0x7 << INIT_SEQ_DC_SIGNAL_SHIFT)
+enum {
+	NO_DC_SIGNAL,
+	DC_SIGNAL_VSYNC,
+	DC_SIGNAL_VPULSE0,
+	DC_SIGNAL_VPULSE1,
+	DC_SIGNAL_VPULSE2,
+	DC_SIGNAL_VPULSE3,
+};
+#define INIT_SEQ_DC_CONTROL_SHIFT		7
+#define FRAME_INIT_SEQ_CYCLES_SHIFT		8
+
 #define DC_DISP_SPI_INIT_SEQ_DATA_A		0x443
 #define DC_DISP_SPI_INIT_SEQ_DATA_B		0x444
 #define DC_DISP_SPI_INIT_SEQ_DATA_C		0x445
-- 
2.53.0

