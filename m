Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC61CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959AB10E59F;
	Tue, 12 May 2026 19:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="zfmqfX0E";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D147010E59F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:01:02 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2ff5472f263so1988602eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778612462; x=1779217262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mtB9iQDbC1TK2yGUTmHv+9UWkJZ55RDgRtxQiWv2Ig=;
 b=zfmqfX0E1gt/hfPCwm0loK+f98KfmUJ2bWvCxAadOQ3Zj/lqC2qFbae430r+lWLieC
 0StMlnpHkq/A6BAH4OnxMXWB0Pe1qF7In88Oc2NV3m9Pi2vTbgvVjrvsSEjJ5BpYpVax
 +8RweTZqOmWyybHXACNOV9juRdmDbFxVgNaQ9VUCVN7ngKPoIo9LvNg0drHyxlImv35b
 xM+y1/NMgfmqKjrSAg5csR5ce41L7MfDOXELPyeqFmBKmXr14uwxEZ4ysW77qoG97k8c
 7TpISZC1RiWwcIjkxpOCNApdBWve7zswxhf3Ksmz8TxLPI+/BgHh8e+e+06UWclocmh6
 N2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612462; x=1779217262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9mtB9iQDbC1TK2yGUTmHv+9UWkJZ55RDgRtxQiWv2Ig=;
 b=buPLUazFyPrcUPf1cpJsEejLeBZoI91s7AV7X1OiXBEJixRDYnbeLbN9pZU9RTwCUy
 ZfNrgASodPaTOgjD0ZQ8GJWd+xmZ4fB3JLY77sYRf75hO6M4p8IlaCQm6KLKvZPTbkaf
 JGUl42potywvr3lZwGmHFVtCIyCrokozScpUeLBunze6OOrjnkxLivuYGRHIRBvKrCxN
 V9B90QyA0w8+3ZtrmCVzlk2Ikix0LmTi+bjFc2RyCRlnTZW+ig6X92TFYpWRmG0bufyv
 JDpAdqY0Epzz2u/SA0ekTxjpJ7ObMrgkVHfH2GDxuqQ7dpAqW+auGnf+ykszbq154aPi
 IEag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ucJdJ6yyfVwy9NaTDG+RjfdW7gjXgT2qJmzvnYHME8EVmU3ngkwBaI2d7J5uZj55VBlhU2meEkyo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrUUVDqCLdr5nzwYRNRiwkV5+h00pJv/rSSSL/Eum6euvie7lZ
 v6w8i1kb5d5cMyHsXqTraNI7OBuUKh6Yt4MenHG5KJ5Wm/mCiMIWfaiDUeKAq4gfoaE=
X-Gm-Gg: Acq92OFLzArhfIm3D4m2feqnS81EDB1kGuls8xEwcvugLioUVT/QTnYeaPCgs+eQMqS
 OPI5gXh5+RrIhig+tq0SRs1h/Mc2JKyxqFtgDOIL1nxO1DxGEFYAave55T6727y/cbyptWASzYC
 cSf1UNga8fQMpQZzkjj2srQMXW4eG0gkVUfLuqrx8h4Mp620e0amIGa2jOIq41I01pmV1e1pCbd
 R8tZghymog7pWd0Q+52oraoj6IbEN97P8L3rFdoU8r09TlsoQgFU/4Fwf4ruciy+51riDTBhpbS
 a7KB0dnO7wpCgGSC6DqPBpBOt/mF/CgRspq7rcYsiuEGfvAqiJY8vUEHmrAXPIwTXyMCZbdZP2Q
 JxQvzUdSIbpnuiFPKDrFL5Bb9+z+S3CRah/4Y4nMowdih8XYy5wWml0Vp1q/U3LTfMsja+jSh4r
 PiUWn3y7CqWDP/cit3xXQESRWaHsxwFdIE7782xMA6Oh1jTTHtjPDIL7RzRWFJ0jfFUoBqPcysy
 wW5ioLKIcbaNjyTmQclwlHNtw8+vXQ38OK75U1Mw76s/s1GQ4BtiJ3MZBE=
X-Received: by 2002:a05:7300:c618:b0:2ff:c611:82c7 with SMTP id
 5a478bee46e88-301174807e8mr222994eec.12.1778612461972; 
 Tue, 12 May 2026 12:01:01 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88914523csm18716616eec.29.2026.05.12.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:01:01 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/display: add GPIO HW translation helpers
Date: Tue, 12 May 2026 15:59:44 -0300
Message-ID: <20260512190019.228440-2-guilherme.bozi@usp.br>
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

Add generic helpers and lookup table types for GPIO hardware
translation.

The new helpers provide reusable conversions between GPIO IDs,
register offsets and DDC lines, allowing ASIC-specific drivers
to replace large switch statements with static lookup tables.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../drm/amd/display/dc/gpio/hw_translate.c    | 86 +++++++++++++++++++
 .../drm/amd/display/dc/gpio/hw_translate.h    | 21 +++++
 .../gpu/drm/amd/display/include/gpio_types.h  | 48 +++++++++++
 3 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index e6e36a912b13..18f14f9f244c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -129,3 +129,89 @@ bool dal_hw_translate_init(
 		return false;
 	}
 }
+
+bool dal_hw_translate_gpio_offset_to_id(
+	const struct gpio_id_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en)
+{
+	uint32_t i;
+
+	for (i = 0; i < table_size; i++) {
+		const struct gpio_id_offset_entry *entry = &table[i];
+
+		if (entry->offset != offset)
+			continue;
+
+		if (entry->check_mask && entry->mask != mask)
+			continue;
+
+		*id = entry->id;
+		*en = entry->en;
+
+		return true;
+	}
+
+	return false;
+}
+
+/* we don't care about the GPIO_ID for DDC
+ * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
+ * directly in the create method
+ */
+bool dal_hw_translate_gpio_ddc_offset_to_id(
+	const struct gpio_ddc_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t *en)
+{
+	uint32_t i;
+
+	for (i = 0; i < table_size; i++) {
+		const struct gpio_ddc_offset_entry *entry = &table[i];
+
+		if (entry->offset != offset)
+			continue;
+
+		*en = entry->en;
+
+		return true;
+	}
+
+	return false;
+}
+
+bool dal_hw_translate_id_to_offset(
+	const struct gpio_pin_entry *table,
+	uint32_t table_size,
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info)
+{
+	uint32_t i;
+
+	for (i = 0; i < table_size; i++) {
+		const struct gpio_pin_entry *entry = &table[i];
+
+		if (entry->id != id || entry->en != en)
+			continue;
+
+		info->offset = entry->offset;
+		info->mask = entry->mask;
+
+		info->offset_y = info->offset + 2;
+		info->offset_en = info->offset + 1;
+		info->offset_mask = info->offset - 1;
+
+		info->mask_y = info->mask;
+		info->mask_en = info->mask;
+		info->mask_mask = info->mask;
+
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h
index 3a7d89ca1605..339e381f8fde 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h
@@ -47,4 +47,25 @@ bool dal_hw_translate_init(
 	enum dce_version dce_version,
 	enum dce_environment dce_environment);
 
+bool dal_hw_translate_gpio_offset_to_id(
+	const struct gpio_id_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en);
+
+bool dal_hw_translate_gpio_ddc_offset_to_id(
+	const struct gpio_ddc_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t *en);
+
+bool dal_hw_translate_id_to_offset(
+	const struct gpio_pin_entry *table,
+	uint32_t table_size,
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/include/gpio_types.h b/drivers/gpu/drm/amd/display/include/gpio_types.h
index 8dd46ed799e5..afd3fc73a911 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_types.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_types.h
@@ -277,6 +277,49 @@ enum gpio_config_type {
 	GPIO_CONFIG_TYPE_I2C_AUX_DUAL_MODE
 };
 
+struct gpio_id_offset_entry {
+	uint32_t offset;
+	uint32_t mask;
+
+	bool check_mask;
+
+	enum gpio_id id;
+	uint32_t en;
+};
+
+#define GPIO_ENTRY(_offset, _id, _en) \
+	{ \
+		.offset = REG(_offset), \
+		.check_mask = false, \
+		.id = (_id), \
+		.en = (_en), \
+	}
+
+#define GPIO_MASK_ENTRY(_offset, _mask, _id, _en) \
+	{ \
+		.offset = REG(_offset), \
+		.mask = (_mask), \
+		.check_mask = true, \
+		.id = (_id), \
+		.en = (_en), \
+	}
+
+struct gpio_pin_entry {
+	enum gpio_id id;
+	uint32_t en;
+
+	uint32_t offset;
+	uint32_t mask;
+};
+
+#define GPIO_PIN_ENTRY(_id, _en, _offset, _mask) \
+	{ \
+		.id = (_id), \
+		.en = (_en), \
+		.offset = REG(_offset), \
+		.mask = (_mask), \
+	}
+
 /* DDC configuration */
 
 enum gpio_ddc_config_type {
@@ -293,6 +336,11 @@ struct gpio_ddc_config {
 	bool clock_en_bit_present;
 };
 
+struct gpio_ddc_offset_entry {
+	uint32_t offset;
+	uint32_t en;
+};
+
 /* HPD configuration */
 
 struct gpio_hpd_config {
-- 
2.47.3

