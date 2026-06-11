Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E4CCD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431D310F0F3;
	Thu, 11 Jun 2026 19:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Gs1xuKwF";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B6010F0F7
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 19:52:27 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-59f967189e7so64109e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207546; x=1781812346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkrcsSBf4E5uIJla+SJtmicxw+grtZfy8hRoNdM7964=;
 b=Gs1xuKwF5hYkGQKidmi2LyR2F8SmCt4YpC/Mhd+7s1Rj8I76/2wlk5dnSEb/xxKbwJ
 6tpU6WnjpnuUY/koYyqvXPsSWaQU1meBsnhXxP0k3pyH/8n0oUNqGecJrCLIQsLAWELa
 RuvuV8E2scGQ7JdKX3VXg6ijVyV0ge/clNHNBp4GCyk3yFrnToz6YO0QxKrMAvHfmGNm
 f9CDiAVv3FXyqDwEtBpJcX5mdd2ayElFuH34bct8o5a+eGGO8Ef4FL3i+r+eRFoWq6wg
 /e725MGeKbHiozY/UHTZranDajd1iN14OOPrw2Dm6BYu/sHKZQTEwnDMycrTvrw9MzCG
 Yi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207546; x=1781812346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UkrcsSBf4E5uIJla+SJtmicxw+grtZfy8hRoNdM7964=;
 b=mw2oER4KfigsCsKFRDNhxZqjV8I0UUHjcP4OFATwhFkmkBhd2OUsuTcOCTzLrWzW/e
 p6/GCGaDCpfUGOcG837kO/tSdFDUeio9AOieop/rFVgpUzAegH0C5HC5hUieqMlgfu/C
 HDqb36+wu1bIfNNDYY+N5ELfGJuZROuqHDjjx8DBKvrRsnmeL8p7JQbevDWsod1JO6CD
 miMaw/KS06gsX/Q+xbYMaZKmnj7swGVhgui8TfVat5n2k12shCgTnuMAE06MVobDYzfJ
 gYVY3TH/q1ynpgLhgcZWMF+w9/kIT++rjdjDdqRte4BR6z2uHMRXfR4HeefXR8QrLcj4
 1dfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rzSMw0wmbN9de5N4hqUoMD4QjcoyOJlzmYf4B4DDGn5Sur5IXTe/apa95/1twb9Jus5pBNHenfrk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywl1ofNT5nnuMfYm70qNJV3Z+M1Pwtu6RNRcP11aDJ+08YN8HUp
 X9ff6nCtOANMxk1gQWFX08rzL8N8V3uMz3aKPhlftvme8A0yu8HAM6pasJXQlfJ5k+k=
X-Gm-Gg: Acq92OFL+cDE+jwkCdyVjhQLGJ0llyRI+j1v1Ew4GvKufR+oVkxLJgQDk/YGBEPr5Ve
 dAKMk7ZDJMwzjCx5l5gFodPs7pc1KZN/iWEV8nsxbwo0L58jLdRObSUVB2rlXShth7ab8sYBPtl
 gZxoh+gpUJrCrJ8eZCJXIdyz+V9Y0DZquDrcyGcV6+167JPKygb9EeWRwTkk44Q2Rp1YNfw/0k0
 nZPRvD1w+B+Ea928eRdjMB0v+M+m7F0Q+pezTvJWkEAYD1JAQta0jIymAOe5x8fFbxLIC1X0iUB
 d3w/Za/+VA++cuUC0aG8rRYemhtgJUL0VVOTvpDnrX5Qcj1RgD/+3wTHIi0+VTT4D/nNMCMT0hl
 UoA4tw2loC6dEGYcCq2N5RZ1zoi0MmaG45p7bdoOBGj/X0HPlsG/5+aS30KqSS1mAJPCD5QBBJW
 MoIa4L0xdt+5NPGKN9Sh1L9xSpcPKxC8DTyLHkhc50fIdKWfRlHoIEQIfITGY6K8IXAExewf6Xv
 kOa7VP7fYDj1anb0ijxe4/Tl32j/PUN+l3V6dgRyHkG7EFoyA==
X-Received: by 2002:a05:6122:430b:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5bafd9b53e6mr2845515e0c.1.1781207545991; 
 Thu, 11 Jun 2026 12:52:25 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:52:25 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 4/9] drm/amd/display: convert dcn21 GPIO translation to
 lookup tables
Date: Thu, 11 Jun 2026 16:49:04 -0300
Message-ID: <20260611195026.25125-5-guilherme.bozi@usp.br>
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

Replace dcn21 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++------------
 1 file changed, 147 insertions(+), 270 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
index e3b11b3c1daa..18bd4d4e32d0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
@@ -60,6 +60,135 @@
 /* macros to expend register list macro defined in HW object header file
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
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_G),
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
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_6),
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
+
+/*
+ * GSL is intentionally omitted here.
+ * id_to_offset() for GSL is not implemented on this ASIC.
+ */
+static const struct gpio_pin_entry gpio_pins[] = {
+	/* DDC */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK),
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
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_G,
+		   DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK),
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
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_6,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK),
+};
+
 
 static bool offset_to_id(
 	uint32_t offset,
@@ -67,122 +196,20 @@ static bool offset_to_id(
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
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK:
-			*en = GPIO_GENERIC_G;
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
-		case DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK:
-			*en = GPIO_HPD_6;
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
-	 * directly in the create method
-	 */
-	case REG(DC_GPIO_DDC1_A):
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDC5_A):
-		*en = GPIO_DDC_LINE_DDC5;
-		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
 
-/*
- *	case REG(DC_GPIO_I2CPAD_A): not exit
- *	case REG(DC_GPIO_PWRSEQ_A):
- *	case REG(DC_GPIO_PAD_STRENGTH_1):
- *	case REG(DC_GPIO_PAD_STRENGTH_2):
- *	case REG(DC_GPIO_DEBUG):
- */
-	/* UNEXPECTED */
-	default:
-/*	case REG(DC_GPIO_SYNCA_A): not exist */
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 static bool id_to_offset(
@@ -190,164 +217,14 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC5_A__DC_GPIO_DDC5DATA_A_MASK;
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
-		info->mask = DC_GPIO_DDC5_A__DC_GPIO_DDC5CLK_A_MASK;
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
-		case GPIO_GENERIC_G:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK;
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
-		case GPIO_HPD_6:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK;
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

