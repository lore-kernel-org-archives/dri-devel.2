Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA6DCD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC8310F103;
	Thu, 11 Jun 2026 19:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="ffzHzHNT";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13B210F103
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 19:52:53 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-59dc1714d44so60459e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207573; x=1781812373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx3WmKJTG77lqTbDvOLJOIOVlrZHcPVfnoy7d71Dt+w=;
 b=ffzHzHNTUIDFROyBos/qatkSSH8MfDpje20J90k8T7H3SIzk2dFahVnmQ5bw0ENOtN
 vpMvXVOP3m3lmmGdRyMWq0q1Xz2qDkE7YXxYSpqQqk6AHRKzM6BgdpVy+ah8vEKii78U
 Q0SsvP6XTtjthCeO1s9HN6GEhX+ezY99XJxzZ3bj/XE6ViGMLV16LD8izMK2GNYuYlwn
 G7SNFHZBf5716gfyysJ0RzEwy5MhWHqI7bebpOxq/eU198Kh2U2ioNcBaKoHV2PLwSaA
 BfDaq8VSsOZwOcl1Z/tplxWCr3oDELH+yMtp1jqrsM/Bbuc/k/lobv2We81lAd7NzLpD
 gjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207573; x=1781812373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gx3WmKJTG77lqTbDvOLJOIOVlrZHcPVfnoy7d71Dt+w=;
 b=Brc9Re6SLkT5aPzC8HG9b7WRvF40x4P9BHxz6ZHHQOPNiptGdnnZNW36H4OpwljJ71
 6u5DmpZEz04oNm0892iX3ocyeUZZJTtAxiIThj+eWo0tTlXHqFXoV1yowe+0aB+V42g6
 H0Ek19/aPPshw/mLPrzX46NIpCd3bXtajEkgDIPS/yc4hIFj07py6ZiCubw/vthPB0b7
 OINJTNNTqboDlQE4Z7ogTslfgLyl2BNnU4D9VSbcBXNk1tA41Kf5hldBNdY3cLewd8iQ
 +pvfymPNIHZF23ALC5/11oExgFCwwd+1e6thh8ZOLbSBYmHPU9zG31DU1YC7PfWpzPdz
 uj0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+20sEQhEDZbrTuqrH2VFP+XNDIeyFqu23sbLwKjsJ/IclMXAHR1rrhVIexr8m1PVEBc3phW+VPHG4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzoa3FSe93xX+IsdXlvOU0YYluRfi2DYsUCUbAKU8mYNBHPfxNy
 YFcCCiU2O8w5A7Ze0iRRVw5pDko4SIyydeHcGPoJC2a/Z0boeGEv/9I9VGzh/3Sd7Vk=
X-Gm-Gg: Acq92OH15YBOpHgFXMl2NvpKnILViTNSlkZ2JcgREa6DSYuNr7fnHO1PiTy++ULk/Qr
 d8ypIn7DNO7ilZ8N37dOlSu6tC93TQEx2fS/949CzrwlVoBUzzKbPiRzEHfluBpBopp0Op94HaW
 tcKg8dxBZKhrmFUCpaAjVmOpMZkRju0faCwDA70hGhDa97q+rbnW+gsKuqnC8IxuMU87IVF25Bh
 BpslQne+rjPKHzVqS1Z400q9G/vzuYiuS3hdzc6S7dE4iDoP+NliW8nK7CQhBEtqlHWZv8ILq+A
 Mb74u8JmLasQhp2RciL9Pe+W72Mfwbbv/skAgNFRBpDZICmO78fzQbR3LIxPNY9ZJMX1AhaYaiT
 WrzyJDmVx+tGoU4mSI/9wCGCap5cXh0x4hRN52A7EtnN0Pah+c7wDTX72NlqBxT2M7JBNwfyvZ3
 QFsCFskKnuFBAInHWmbvEJFTAGWm2wi9G6Km3eFIGV2Ax6FygS+DQiJL0iB9L4vvkM3LTa7iDsj
 o9wOnNcBQbzM1ZmSiG+I90XtmwkQrXU9pZUggQtyIXca0TrCg==
X-Received: by 2002:a05:6122:da0:b0:575:24a9:78da with SMTP id
 71dfb90a1353d-5bb0127018dmr3104132e0c.11.1781207572996; 
 Thu, 11 Jun 2026 12:52:52 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:52:52 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 7/9] drm/amd/display: convert dcn32 GPIO translation to
 lookup tables
Date: Thu, 11 Jun 2026 16:49:07 -0300
Message-ID: <20260611195026.25125-8-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611195026.25125-1-guilherme.bozi@usp.br>
References: <20260611195026.25125-1-guilherme.bozi@usp.br>
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

Replace dcn32 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++++-----------
 1 file changed, 138 insertions(+), 248 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
index 8493b9981f9e..71067a8da121 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
@@ -60,111 +60,145 @@
  * end *********************/
 
 
+static const struct gpio_id_offset_entry gpio_offsets[] = {
+	/* GENERIC */
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_A),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_B),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_C),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_D),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_E),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_F),
+	/* HPD */
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_1),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_2),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_3),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_4),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_5),
+	/* GSL */
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_GENLOCK_CLOCK),
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_GENLOCK_VSYNC),
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_A),
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_B),
+};
+
+
+/* DDC */
+static const struct gpio_ddc_offset_entry ddc_offset_map[] = {
+	{ REG(DC_GPIO_DDC1_A), GPIO_DDC_LINE_DDC1 },
+	{ REG(DC_GPIO_DDC2_A), GPIO_DDC_LINE_DDC2 },
+	{ REG(DC_GPIO_DDC3_A), GPIO_DDC_LINE_DDC3 },
+	{ REG(DC_GPIO_DDC4_A), GPIO_DDC_LINE_DDC4 },
+	{ REG(DC_GPIO_DDC5_A), GPIO_DDC_LINE_DDC5 },
+	{ REG(DC_GPIO_DDCVGA_A), GPIO_DDC_LINE_DDC_VGA },
+};
+
+/*
+ * GSL is intentionally omitted here.
+ * id_to_offset() for GSL is not implemented on this ASIC.
+ */
+static const struct gpio_pin_entry gpio_pins[] = {
+	/* DDC */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	/* GENERIC */
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_B,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_C,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_D,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_E,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_F,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK),
+	/* HPD */
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_1,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_2,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_3,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_4,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_5,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK),
+};
+
+
 static bool offset_to_id(
 	uint32_t offset,
 	uint32_t mask,
 	enum gpio_id *id,
 	uint32_t *en)
 {
-	switch (offset) {
-	/* GENERIC */
-	case REG(DC_GPIO_GENERIC_A):
-		*id = GPIO_ID_GENERIC;
-		switch (mask) {
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK:
-			*en = GPIO_GENERIC_A;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK:
-			*en = GPIO_GENERIC_B;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK:
-			*en = GPIO_GENERIC_C;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK:
-			*en = GPIO_GENERIC_D;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK:
-			*en = GPIO_GENERIC_E;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK:
-			*en = GPIO_GENERIC_F;
-			return true;
-		default:
-			ASSERT_CRITICAL(false);
-			return false;
-		}
-	break;
-	/* HPD */
-	case REG(DC_GPIO_HPD_A):
-		*id = GPIO_ID_HPD;
-		switch (mask) {
-		case DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK:
-			*en = GPIO_HPD_1;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK:
-			*en = GPIO_HPD_2;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK:
-			*en = GPIO_HPD_3;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK:
-			*en = GPIO_HPD_4;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK:
-			*en = GPIO_HPD_5;
-			return true;
-		default:
-			ASSERT_CRITICAL(false);
-			return false;
-		}
-	break;
-	/* REG(DC_GPIO_GENLK_MASK */
-	case REG(DC_GPIO_GENLK_A):
-		*id = GPIO_ID_GSL;
-		switch (mask) {
-		case DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK:
-			*en = GPIO_GSL_GENLOCK_CLOCK;
-			return true;
-		case DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK:
-			*en = GPIO_GSL_GENLOCK_VSYNC;
-			return true;
-		case DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK:
-			*en = GPIO_GSL_SWAPLOCK_A;
-			return true;
-		case DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK:
-			*en = GPIO_GSL_SWAPLOCK_B;
-			return true;
-		default:
-			ASSERT_CRITICAL(false);
-			return false;
-		}
-	break;
-	/* DDC */
-	/* we don't care about the GPIO_ID for DDC
-	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method */
-	case REG(DC_GPIO_DDC1_A):
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
-		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDC5_A):
-		*en = GPIO_DDC_LINE_DDC5;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
-	default:
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 static bool id_to_offset(
@@ -172,158 +206,14 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_DDC_CLOCK:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_GENERIC:
-		info->offset = REG(DC_GPIO_GENERIC_A);
-		switch (en) {
-		case GPIO_GENERIC_A:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK;
-		break;
-		case GPIO_GENERIC_B:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK;
-		break;
-		case GPIO_GENERIC_C:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK;
-		break;
-		case GPIO_GENERIC_D:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK;
-		break;
-		case GPIO_GENERIC_E:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK;
-		break;
-		case GPIO_GENERIC_F:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK;
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_HPD:
-		info->offset = REG(DC_GPIO_HPD_A);
-		switch (en) {
-		case GPIO_HPD_1:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK;
-		break;
-		case GPIO_HPD_2:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK;
-		break;
-		case GPIO_HPD_3:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK;
-		break;
-		case GPIO_HPD_4:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK;
-		break;
-		case GPIO_HPD_5:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK;
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_GSL:
-		switch (en) {
-		case GPIO_GSL_GENLOCK_CLOCK:
-				/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-		break;
-		case GPIO_GSL_GENLOCK_VSYNC:
-			/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-		break;
-		case GPIO_GSL_SWAPLOCK_A:
-			/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-		break;
-		case GPIO_GSL_SWAPLOCK_B:
-			/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_SYNC:
-	case GPIO_ID_VIP_PAD:
-	default:
-		ASSERT_CRITICAL(false);
-		result = false;
-	}
-
-	if (result) {
-		info->offset_y = info->offset + 2;
-		info->offset_en = info->offset + 1;
-		info->offset_mask = info->offset - 1;
-
-		info->mask_y = info->mask;
-		info->mask_en = info->mask;
-		info->mask_mask = info->mask;
-	}
+	if (dal_hw_translate_id_to_offset(
+			gpio_pins,
+			ARRAY_SIZE(gpio_pins),
+			id, en, info))
+		return true;
 
-	return result;
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 /* function table */
-- 
2.47.3

