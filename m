Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19822CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75DA10E1AD;
	Sun,  4 Oct 2026 16:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EylX6xkA";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C0610E1AD
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:31:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso11803135e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131490; x=1791736290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=klRLuslgHZkHfKV3cIJoQTmbsYS3GX5KrVERzHwo0vI=;
 b=EylX6xkA1QHD4EjY5uw5nsUuw/xig9fCpsEBDMKd+St3f8JQjND8xl29gPlCTOXIMy
 eEhMCU7QnblY5dm3TS+xqEZ874strHFtnqieglsaT7FF39kD5F5k/vtOLcBSdtJ+xPOK
 cY5sYdRTiwTaus4tbbU/aJ4krqLAjQnSX5IH+kh2rZTqfL+z9dgAsuNtjJisy69DSqbd
 scFhfBiHQPTyaK42K4D3hFZiQW6G5wrr2egNXObZmIlNkrjhaVyQsBhf5aCSwWt2yktq
 Wrs2x1lBdeDUJpPW4EQzvwx3RVmc22aVAYUv0P9Y59nQydz0pZgOpBBl2Xkor7ntzjXg
 h3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131490; x=1791736290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=klRLuslgHZkHfKV3cIJoQTmbsYS3GX5KrVERzHwo0vI=;
 b=upj+dnE+vXJxxfhmjv+r7UYnA4qN/y+3g6qdpWqRSRjq7wVA9JIuiXu/KUuKjXBXob
 Ysgtd8A4U9q7PQo7GEWCIvoN7WUQO+aFNJu0dLyFbV7JCl56a1i8rw8PTl1OpT0+dtS2
 2XMLfWU1oawABJQkMbb9E6tFm3if+JgZPNdh1blTDVln17XL3GOQw08RO7ua4V5Kcm9l
 3r//dPmQ8iVY/3dUxApHgK++UNKNPJcN4SF8f6PN973Hud7I1Vf6PWknNzX97suaPI+X
 OZK+lv6/06LjMEUuXDBwnQdTz0K770q+LtJywe92zs08j4IRyplpzCEpEhxHIlhXXAga
 ZKEQ==
X-Gm-Message-State: AFuF++k+3oIaG9NOj5iyjm7f5Vn15YhRZyjbGtSfK8txERvZ2BbFFHv9
 iZZOwBpoEfPmUdZrwRkhDnmMIsMrGUW+hi2z5ox1g3cEzY+0UxGIL5fe
X-Gm-Gg: AYBFou2L1fH1dV5DqHlfViqqikuQgpQ8t7UJ1rL9BWeinYTPXpHvlSTOUpaZ2NemhRv
 qTB3XUDq8vnx+TCXT8if9nCI8pEmM2SBH36qKV+/yK7ePlTLz/EogxPTvZqtOvO+uynOZAhu1go
 BXWGaewN+eupDplC2INt93KbNerPhxnwMnXQR3KkH05mJfY3zTGgy362yOjuYaCZbO8eswhyOM4
 EF1PTWnCdgZQpV3BJm65kunMCQwbyUAB1oCCKrgzSH6pq/8RiU4V8g1Yc0ewtlrVAc+/QcVccnx
 fWl+bJkUsExdDC7YIyKeoVFJGJSrWpw5bcdDxX23Yh+jTBX9DennuouPHUWfXVSth+Xx48PRjfo
 WsAIxCCrolhwVsKmxbPgUNMEaGmVvbP5F7uGqL5bY+kVsXve+RqNZoy2mF4GavYDiTpXQpcMoO1
 5ypH/Y/b6fx0tXSrgp+ROxsFnEwVQAdVYDkXwb+3X4ZcM8F2nN2i226rAB8GuvOXN1KEvb8g/xc
 OGoLLYBfLezRsvM7ps=
X-Received: by 2002:a05:600c:4705:b0:4a0:1c16:d6f6 with SMTP id
 5b1f17b1804b1-4a1680ffe47mr81460025e9.24.1791131489734; 
 Sun, 04 Oct 2026 09:31:29 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0316b2524sm315365035e9.1.2026.10.04.09.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:31:29 -0700 (PDT)
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
Subject: [PATCH v2 1/7] drm/tegra: dc: Expand available registers layouts
Date: Sun,  4 Oct 2026 19:31:08 +0300
Message-ID: <20261004163114.181800-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004163114.181800-1-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
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
 drivers/gpu/drm/tegra/dc.h | 49 +++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 7 deletions(-)

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
index 0cb0515968b35..7005df32f485f 100644
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
 
@@ -451,12 +460,26 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define BASE_COLOR_SIZE_888    (  8 << 0)
 #define BASE_COLOR_SIZE_101010 ( 10 << 0)
 #define BASE_COLOR_SIZE_121212 ( 12 << 0)
+#define DISP_COLOR_SWAP_BGR	BIT(16)
 #define CMU_ENABLE_ENABLE      (1 << 20)
 
 #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
-#define  SC1_H_QUALIFIER_NONE	(1 << 16)
-#define  SC0_H_QUALIFIER_NONE	(1 <<  0)
-
+#define SC0_H_QUALIFIER(x)			(((x) & 0x7) <<  0)
+#define SC1_H_QUALIFIER(x)			(((x) & 0x7) << 16)
+#define SC_H_QUALIFIER_DISABLE			0
+#define SC_H_QUALIFIER_NONE			1
+#define SC_H_QUALIFIER_HACTIVE			2
+#define SC_H_QUALIFIER_EXT_HACTIVE		3
+#define SC_H_QUALIFIER_HPULSE			4
+#define SC_H_QUALIFIER_EXT_HPULSE		5
+#define SC0_V_QUALIFIER(x)			(((x) & 0x7) <<  3)
+#define SC1_V_QUALIFIER(x)			(((x) & 0x7) <<  19)
+#define SC_V_QUALIFIER_NONE			0
+#define SC_V_QUALIFIER_RSVD			1
+#define SC_V_QUALIFIER_VACTIVE			2
+#define SC_V_QUALIFIER_EXT_VACTIVE		3
+#define SC_V_QUALIFIER_VPULSE			4
+#define SC_V_QUALIFIER_EXT_VPULSE		5
 #define DC_DISP_DATA_ENABLE_OPTIONS		0x432
 #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
 #define DE_SELECT_ACTIVE        (1 << 0)
@@ -493,6 +516,20 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_CURSOR_POSITION_NS		0x441
 
 #define DC_DISP_INIT_SEQ_CONTROL		0x442
+#define SEND_INIT_SEQUENCE			BIT(0)
+#define INIT_SEQUENCE_MODE_SPI			BIT(1)
+#define INIT_SEQUENCE_MODE_PLCD			0x0
+#define INIT_SEQ_DC_SIGNAL_SHIFT		4
+#define INIT_SEQ_DC_SIGNAL_MASK			(0x7 << INIT_SEQ_DC_SIGNAL_SHIFT)
+#define NO_DC_SIGNAL				0
+#define DC_SIGNAL_VSYNC				1
+#define DC_SIGNAL_VPULSE0			2
+#define DC_SIGNAL_VPULSE1			3
+#define DC_SIGNAL_VPULSE2			4
+#define DC_SIGNAL_VPULSE3			5
+#define INIT_SEQ_DC_CONTROL_SHIFT		7
+#define FRAME_INIT_SEQ_CYCLES_SHIFT		8
+
 #define DC_DISP_SPI_INIT_SEQ_DATA_A		0x443
 #define DC_DISP_SPI_INIT_SEQ_DATA_B		0x444
 #define DC_DISP_SPI_INIT_SEQ_DATA_C		0x445
-- 
2.53.0

