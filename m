Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B022CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070AB10EBDB;
	Tue, 12 May 2026 19:01:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="XQsjTatr";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809D610EBDB
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:01:10 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2f7020a928eso8269234eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778612470; x=1779217270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hizmGFeGIKLsiG1PAA8nrLlhLcFzv1q22RtftzUoG94=;
 b=XQsjTatrOKmPkl1MBBwmc0umy8BYvov+4Qi99MzTBfz9btGrS9Pp+9J92Rw6eMBdjh
 rtGu1Jh+MmHoIOKmIarOPLTwGy5ClbNDjH2xdzKLpwTJw+ppuASiGLauUvQg1ExilVc2
 FrTCKc+Ug0Uof9F9rzDOS05ybWUbfp7mA5gQ/xb9/etND9pZvjAdTnfffiUAncbNzhjw
 aPCGitSPXaQlcJC3OR7YfnzxNsmkS6hU1imC5acV6vkth43UFHWnz1imzbyhoPvMZG5N
 K2HC9PQZJq7oYMwI+SAT5z+LT2jrEIu5o+aLdn5YNZ1cEVbc8SoNIEj5Nne+h1L4RpWu
 LpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612470; x=1779217270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hizmGFeGIKLsiG1PAA8nrLlhLcFzv1q22RtftzUoG94=;
 b=ALwnRvdEDsbF8Z0nYTwDY/fWnoY2pL+PFlFsth2v+ZRG3RlFewcCxDpAAvs5GnK8vO
 c+yRqNP+FS6ZkaA4DLV/Fag4qjX78fCwg23FO32+/WEKy+fsG+VXUiacg6WkW4wV9x7n
 3P16GEma6sLF6/v5IF/73nehFAIYlHXVpQoGSnC5z58UOQ76hhBPKLPUKrNr0ZCgBPvt
 vsviXlRcYj3hYwhHHgzFLhAN042yzYZsgjodjCdlOrEBr4Nq86IuakACCOFE9BVM/zHF
 OAasg/rjyXfTIgblphoYxMpaih62RzECUY8EALYvG6NkWmT1yMHbW2vYnhdcoQuL8HNu
 QKgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qq9GkOUdDVac3zNv+rCXYYpQnd8o1PeWTU4BncFQ4+LCQv45Si3K/quzV5v5jeexIUYQDqRfMs8E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIARfriD3ragOhg1hfhLRSSiYu8frKjQdWI0sEf1VQEVBwPbcz
 F/Kxyu8571r+RZRKrKw3naqe9Zs3940YFI7GPmkQQfZqew8MiA76/v8k0gGod/gSHX0=
X-Gm-Gg: Acq92OG8xN2sGdRlboddMj+L0JC7L9zQpdiP8qzXxkT8ePNYpS4wU7wag2Wu22CVMAA
 TT7rsY4CfxQNS6jUxMFGeutoNjlPwE3Q0qzRaRdNrNQbhOWXfpb0DXkh5twv9S5bZCYHlxWUc9W
 dq1gC1q7oI7GkAMqILNl7LNYYNWbG/7K51Imbyr/NPXGk+56il+WZ2VXoqZ9HZwk8ayHmtgpmyF
 bxxoA7a/PMiNjI9qkbKin0OF07jVqAGahlvqVjQmASD5FWAPLIQAxUBpWCoAPisq6xg1JUZLFfP
 4KXbjo4lPjIIvQtZOocpHwsf5/P4u60HHjtf50J072D1zh4GaxGqwtADLfcq79hoCv4OCDIa5Zt
 A3oc0CAgEGAM/0zLLJ6kMUKrDfEnBaE+2H64yLXqrjIGgJpTBGgSK/6a/dCXQol00P8qCUgvbN0
 vkiuN+We3Bxv1OOdA0YVhIkNVwXxSOwtCHPGkNFUUnnixzD3cUw4aRLvdxD1DZkHHgVrrYvI4qw
 apAkWufxMdR1DE7n4D//sOiLrMTkfumh60/GJM6qXJ7pV6w
X-Received: by 2002:a05:7301:22af:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-30119874564mr192326eec.18.1778612469663; 
 Tue, 12 May 2026 12:01:09 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88914523csm18716616eec.29.2026.05.12.12.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:01:08 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amd/display: convert dcn10 GPIO translation to lookup
 tables
Date: Tue, 12 May 2026 15:59:45 -0300
Message-ID: <20260512190019.228440-3-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512190019.228440-1-guilherme.bozi@usp.br>
References: <20260512190019.228440-1-guilherme.bozi@usp.br>
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

Replace dcn10 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
 1 file changed, 173 insertions(+), 311 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c
index fecc8688048d..000f603def58 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c
@@ -58,146 +58,180 @@
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
+	/* SYNCA */
+	GPIO_MASK_ENTRY(DC_GPIO_SYNCA_A,
+		DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK,
+		GPIO_ID_SYNC, GPIO_SYNC_HSYNC_A),
+	GPIO_MASK_ENTRY(DC_GPIO_SYNCA_A,
+		DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK,
+		GPIO_ID_SYNC, GPIO_SYNC_VSYNC_A),
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
+/* DDC */
+static const struct gpio_ddc_offset_entry ddc_offset_map[] = {
+	{ REG(DC_GPIO_DDC1_A), GPIO_DDC_LINE_DDC1 },
+	{ REG(DC_GPIO_DDC2_A), GPIO_DDC_LINE_DDC2 },
+	{ REG(DC_GPIO_DDC3_A), GPIO_DDC_LINE_DDC3 },
+	{ REG(DC_GPIO_DDC4_A), GPIO_DDC_LINE_DDC4 },
+	{ REG(DC_GPIO_DDC5_A), GPIO_DDC_LINE_DDC5 },
+	{ REG(DC_GPIO_DDC6_A), GPIO_DDC_LINE_DDC6 },
+	{ REG(DC_GPIO_DDCVGA_A), GPIO_DDC_LINE_DDC_VGA },
+	{ REG(DC_GPIO_I2CPAD_A), GPIO_DDC_LINE_I2C_PAD },
+};
+
+static const struct gpio_pin_entry gpio_pins[] = {
+	/* DDC */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC6,
+		DC_GPIO_DDC6_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_I2C_PAD,
+		DC_GPIO_I2CPAD_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC6,
+		DC_GPIO_DDC6_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_I2C_PAD,
+		   DC_GPIO_I2CPAD_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
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
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK),
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
+	/* SYNCA */
+	GPIO_PIN_ENTRY(GPIO_ID_SYNC, GPIO_SYNC_HSYNC_A,
+		DC_GPIO_SYNCA_A, DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_SYNC, GPIO_SYNC_VSYNC_A,
+		DC_GPIO_SYNCA_A, DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK),
+	/* GSL */
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_GENLOCK_CLOCK,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_GENLOCK_VSYNC,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_A,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_B,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK),
+};
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
-	/* SYNCA */
-	case REG(DC_GPIO_SYNCA_A):
-		*id = GPIO_ID_SYNC;
-		switch (mask) {
-		case DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK:
-			*en = GPIO_SYNC_HSYNC_A;
-			return true;
-		case DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK:
-			*en = GPIO_SYNC_VSYNC_A;
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
-		return true;
-	case REG(DC_GPIO_DDC6_A):
-		*en = GPIO_DDC_LINE_DDC6;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
-		return true;
-	/* GPIO_I2CPAD */
-	case REG(DC_GPIO_I2CPAD_A):
-		*en = GPIO_DDC_LINE_I2C_PAD;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
-	/* Not implemented */
-	case REG(DC_GPIO_PWRSEQ_A):
-	case REG(DC_GPIO_PAD_STRENGTH_1):
-	case REG(DC_GPIO_PAD_STRENGTH_2):
-	case REG(DC_GPIO_DEBUG):
-		return false;
-	/* UNEXPECTED */
-	default:
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 static bool id_to_offset(
@@ -205,186 +239,14 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK;
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
-		case GPIO_DDC_LINE_DDC6:
-			info->offset = REG(DC_GPIO_DDC6_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-			info->offset = REG(DC_GPIO_I2CPAD_A);
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_DDC_CLOCK:
-		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK;
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
-		case GPIO_DDC_LINE_DDC6:
-			info->offset = REG(DC_GPIO_DDC6_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-			info->offset = REG(DC_GPIO_I2CPAD_A);
-		break;
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
-	case GPIO_ID_SYNC:
-		switch (en) {
-		case GPIO_SYNC_HSYNC_A:
-			info->offset = REG(DC_GPIO_SYNCA_A);
-			info->mask = DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK;
-		break;
-		case GPIO_SYNC_VSYNC_A:
-			info->offset = REG(DC_GPIO_SYNCA_A);
-			info->mask = DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK;
-		break;
-		case GPIO_SYNC_HSYNC_B:
-		case GPIO_SYNC_VSYNC_B:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_GSL:
-		switch (en) {
-		case GPIO_GSL_GENLOCK_CLOCK:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask = DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK;
-		break;
-		case GPIO_GSL_GENLOCK_VSYNC:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask =
-				DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK;
-		break;
-		case GPIO_GSL_SWAPLOCK_A:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask = DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK;
-		break;
-		case GPIO_GSL_SWAPLOCK_B:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask = DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK;
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
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

