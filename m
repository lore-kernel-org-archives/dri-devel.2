Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686D4CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A546810EABC;
	Tue, 19 May 2026 07:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUBhbmrf";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CA910EA59
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 05:52:05 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-83538fbd0b2so1211150b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779169925; x=1779774725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0iPmr2FZaFpGbv5xE0HK6353ex2Wmyxrb+8vBjR4oM=;
 b=BUBhbmrfn8ttwGrsz0f2QqGqCAFAqva+K9lKNoKF4d9jw2e59KQ26rpPI9bu9UNboo
 3kA1mMj+HRMPcAgEQLMUuIN5gzQX9cJPhq+0YPStfkgYMpMXVviIMtv3eQ694P5PJXDA
 LSG12j+8lg9Dt7QPLN0dg9txvJoeWEmDSfA8/N7hmwn/ey0YYe2L8EDMaI7r6ohnJilX
 EodaXWD3ROCECychM1a6LBBIJFHElVmXurrN4n8DpO6ep6ulU3D4opVQ+opqZUR4WP8+
 M+RW07Uyg0pvKAdHSBl9KMzDRv+FLYzcp3m6gguhBm5PLR2ycjL0NaCZAZXh4vWn5bjW
 eRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779169925; x=1779774725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f0iPmr2FZaFpGbv5xE0HK6353ex2Wmyxrb+8vBjR4oM=;
 b=l12T4g7mNqn52Ro8LeHN0y2l1b+9aMjKxe2oP7fErorpVV0T6nHZW+E2YMwf/5s4tV
 zWKeplX3E01+6fuqrWpWPvPwhM1TZVTNbDNjvUvOEd3+kqD+sBby4ye7CZf6tagpp593
 6PZ58y4Z1VXsUCnj9cW9iloACUcuRSmJKk/Ro6zgDLqagHd+mjgrvW2XqxjZxUPWaK83
 wCIBbs+8k1bMtauTypD3Q3TPBtnk2zi8QHgrrD9qxE7Wk2GDbLY2BZqFR8KRYaODN6JP
 ylhN48LIcHExjDmcPWiNJ1X7hzsyPmvsmW4Nwtd0Y3UarwHRKa/qpxwuunaSWpBCB258
 AkPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GkCrNbcqCdbHl9qWohGJ8qmChi6bd4plEfPtudlDT7Oh8A5Ng2pkma63F3LHYLsH21xYakrzbPZw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo7s9ePBjYdefOO2VdMUfu3b/DjlYeY6/xWYMZCCF2qu3eQbA2
 wHutM62YsAH4uc0c+Q9ed3BnYEXv4DckjvF3mmmZiTp6GLiLS0jqeinS
X-Gm-Gg: Acq92OGsGQx3S/iMCAOEtOHs34enVQZ86Haou/WS98b42byWg20JNLfxMIqq3XZkO9A
 Rtyi+yC4c3Qehmm9eNMz+/bAx0/IZD2NtFnzQg+fNmviETRQAb1pmH01t+Kp1Xlflw92XqcsPxf
 klac/2nRsw56Na7glHYlt+7Bc2oLyWU5L5fFNe5tJ90Vy8ZIEtyCLsR9eAGQTj00smiWdfxyjZv
 1pBR9eUrd0PEzJLMnsVu0pgouJJ9Fnf/npA4HrxprJXLZSE3KeRR+bf3afu5yX1LFDKcNf3Rfmx
 B1tIHivXlkV3ZrvB7lrHsB2QswRMvdOknV/+eGSFWGws/Lbrgm5ZFtHKc4u1ZSIxVBvB49uUs7z
 QkbUvsMrbDU174hNhWdI5hpIqkeQLXkek6H4F7np6Z7LgHkpE3fweJ3Z9Nq/4mbby2TZ5F8RrlH
 PRisVbplEhrDihYh63DHOHZesMtnQlaZ0Yk/U0IhoeDeyK/W1s3abD/VaqYxEOEykY1fY8DzkUF
 KdSKN0/Grxu
X-Received: by 2002:a05:6a00:2d0d:b0:83e:cc87:58f4 with SMTP id
 d2e1a72fcca58-83f339b425amr15909280b3a.0.1779169925063; 
 Mon, 18 May 2026 22:52:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f8b9c2ea5sm2641252b3a.13.2026.05.18.22.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 22:52:04 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 2/4] drm/verisilicon: add model ID constants and DCU Lite
 chip identity
Date: Tue, 19 May 2026 13:51:07 +0800
Message-ID: <20260519055114.1886525-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519055114.1886525-1-a0987203069@gmail.com>
References: <20260519055114.1886525-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

Introduce symbolic constants VSDC_MODEL_DC8200 and VSDC_MODEL_DCU_LITE
to replace magic numbers in the hardware database and probe path.

Register the DCU Lite chip identity (model 0x0, revision 0x5560,
customer_id 0x305) in vs_chip_identities[], making the existing
vs_fill_chip_identity() path able to recognise Nuvoton MA35D1 hardware
purely through register reads.

Also add three register-level macros for forthcoming DCU Lite support:
- VSDC_DISP_IRQ_VSYNC(n) in vs_crtc_regs.h, for per-output VSYNC IRQ
  bits used by the DCU Lite IRQ enable/status registers.
- VSDC_FB_CONFIG_ENABLE, VSDC_FB_CONFIG_VALID and VSDC_FB_CONFIG_RESET
  in vs_primary_plane_regs.h, for the framebuffer enable and
  commit-cycle bits used by the DCU Lite plane update path.

No behaviour change for existing DC8200 platforms.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h       |  1 +
 drivers/gpu/drm/verisilicon/vs_hwdb.c            | 16 ++++++++++++----
 drivers/gpu/drm/verisilicon/vs_hwdb.h            |  3 +++
 .../gpu/drm/verisilicon/vs_primary_plane_regs.h  |  3 +++
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
index c7930e817635..d4da22b08cd5 100644
--- a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
+++ b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
@@ -54,6 +54,7 @@
 #define VSDC_DISP_GAMMA_DATA(n)			(0x1460 + 0x4 * (n))
 
 #define VSDC_DISP_IRQ_STA			0x147C
+#define VSDC_DISP_IRQ_VSYNC(n)			BIT(n)
 
 #define VSDC_DISP_IRQ_EN			0x1480
 
diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
index 09336af0900a..a25c4b16181d 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
@@ -90,7 +90,7 @@ static const struct vs_formats vs_formats_with_yuv444 = {
 
 static struct vs_chip_identity vs_chip_identities[] = {
 	{
-		.model = 0x8200,
+		.model = VSDC_MODEL_DC8200,
 		.revision = 0x5720,
 		.customer_id = ~0U,
 
@@ -98,7 +98,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.formats = &vs_formats_no_yuv444,
 	},
 	{
-		.model = 0x8200,
+		.model = VSDC_MODEL_DC8200,
 		.revision = 0x5721,
 		.customer_id = 0x30B,
 
@@ -106,7 +106,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.formats = &vs_formats_no_yuv444,
 	},
 	{
-		.model = 0x8200,
+		.model = VSDC_MODEL_DC8200,
 		.revision = 0x5720,
 		.customer_id = 0x310,
 
@@ -114,13 +114,21 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.formats = &vs_formats_with_yuv444,
 	},
 	{
-		.model = 0x8200,
+		.model = VSDC_MODEL_DC8200,
 		.revision = 0x5720,
 		.customer_id = 0x311,
 
 		.display_count = 2,
 		.formats = &vs_formats_no_yuv444,
 	},
+	{
+		.model = VSDC_MODEL_DCU_LITE,
+		.revision = 0x5560,
+		.customer_id = 0x305,
+
+		.display_count = 1,
+		.formats = &vs_formats_no_yuv444,
+	},
 };
 
 int vs_fill_chip_identity(struct regmap *regs,
diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h b/drivers/gpu/drm/verisilicon/vs_hwdb.h
index 92192e4fa086..cca126bd2da5 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
@@ -9,6 +9,9 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
+#define VSDC_MODEL_DC8200 0x8200
+#define VSDC_MODEL_DCU_LITE 0x0
+
 struct vs_formats {
 	const u32 *array;
 	unsigned int num;
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
index cbb125c46b39..67d4b00f294e 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
@@ -16,6 +16,9 @@
 #define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
 
 #define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
+#define VSDC_FB_CONFIG_ENABLE			BIT(0)
+#define VSDC_FB_CONFIG_VALID			BIT(3)
+#define VSDC_FB_CONFIG_RESET			BIT(4)
 #define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
 #define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13, 11)
 #define VSDC_FB_CONFIG_ROT(v)			((v) << 11)
-- 
2.43.0

