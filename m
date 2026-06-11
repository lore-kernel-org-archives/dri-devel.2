Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA14CD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF8010E83E;
	Thu, 11 Jun 2026 19:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="JMOQxeVM";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BAE10E83E
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 19:51:34 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-59e8ededf4dso81985e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207493; x=1781812293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72nkF1wkrOnPx9OWBQRisWDqaTILiCPcJlAlZTpPq2A=;
 b=JMOQxeVMsfgQkW4OlTUNUNWiIBczG3LYXFcpjSEGQlihv4KhmvOxfW0sQSjm3soQOS
 GgMfftR6R62rM+4au+JaIXjic17x+H5d8z7bFC8INdzJwjTvfFF79j4KIFDyj+gjxS9s
 J9jhqd5mZEwypJnyI+bTr8qMBp6+kGspfZvw+7LCzjuqYGG9drAa+d2nYSLDHz2i9fhk
 BwFn5GhnzXoydbPP/AWyybqWBPTwY759HANGY9jfw6ETRbUcqz+LdF6GD0B6ZywKAfGq
 aTbqJ1sI1u/4g2wpJwUO3WFmQXQDSj3/15orLCS5THyWAAv5bR1euH5b1bR8vTNc5H7M
 X6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207493; x=1781812293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=72nkF1wkrOnPx9OWBQRisWDqaTILiCPcJlAlZTpPq2A=;
 b=JIPDaOBzEGA6K+4wN3AZuB1+d7OaSogWzxgJ5wWFPmk4gYBDGA+vtzRYlYKlmoEulV
 j9+s5su31XFwvU1eZSPAxFJUgKuq6ZOs3z0saQgL3xdsvVg1Bh56KPn4zB8YDSRAmzsw
 QmcTCtAyDZy/lCmpzEOLG6f4p/IVDDL2CzwIwbGaq3hCQifUdrpxbj7djQsbenF1C8eM
 19EFfItDmaTC5d0XSLGSHikYXhTNh691OC/aflIgTN6hJH+xj/z5M0QomU5IXmaOnh+n
 uVqzzrBbGYtl6eoVVoWyKbBMygKyuCD/YufXUt0R9vW8otOY3sQt6V0rAgDXOoH9FiiA
 ymMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hLto+Gh6EIr+Oc9ovrl5XSqAV5jJWAgmA40LyRKMHHTc2w+XJen0qW0tkzeK7ZrFVFl7pgHzv3/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHD9avjJzQ27tqnAlPhKO2vzBdjXaU8Za9+5f+YGVlFNv8fXxc
 PDXW0wDmVkA7VSvmwrLWukikqP/jb2O/naYN1zDkJRNoNGFhfPX9Ceblc3oeULzt3NA=
X-Gm-Gg: Acq92OEOVIn56quktZZaeBxGGsf6S3IEEir3Mc8IBWV4sEY+85pW+9TMtHYLYnu7WwN
 OaHa/Jpv5SeFoBz2zz//ON4QQYialbm0Ee/umQR8c8+oaOmoV4+De7GS0jhIdbgBpBm9YY/5QDQ
 6eCamqMINLbRd0RtxzJuf/VohpmEzVBQr1+awUTvnvtSnO3ebtWvQBBC4yINY9Ox1EgKqb/sKsA
 KmCCZoCR93/inM+LbOWo/fTKnEm9gS+0R9DoqJaDE4ce6ERFyP/lUVJPrl9MegkTKarwPLTw/Wl
 XbZSBaf785K1bHKHLkCG7of4Mm2qZhpR9jnGfxm/rxvriM4krYkjEHnYbg8M8UX148CHJ75xpUB
 3DpkfEkefXGqXOOeXM1MfpcYJEuXMZ9do5l4ILpe5DcSlDjejTF4AGp7/qOGwyETmkd3yn0/qp/
 WRChUx/k6lnF5/VZb1IxloYQdE5EVR6t9r+sGVVvl8ScBuid9EqU+erV6BA7QialXDGPj9p/DEJ
 S+6sDpWV92//+F4ZVPxLd0EKyyzloOq9t8B7yAQh8t2E0e9TjYmSUJSwB9s
X-Received: by 2002:a05:6122:3c53:b0:567:4e8a:fb13 with SMTP id
 71dfb90a1353d-5baffcd3d22mr2941326e0c.8.1781207493222; 
 Thu, 11 Jun 2026 12:51:33 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:51:32 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 1/9] drm/amd/display: add GPIO HW translation helpers
Date: Thu, 11 Jun 2026 16:49:01 -0300
Message-ID: <20260611195026.25125-2-guilherme.bozi@usp.br>
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
index 64a5e11fce5c..b58af86dee10 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -133,3 +133,89 @@ bool dal_hw_translate_init(
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

