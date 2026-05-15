Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85AACD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF8F10F420;
	Fri, 15 May 2026 07:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMYN3Nto";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C1510F3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:53 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so4034965b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823773; x=1779428573; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vu8r9w9o/+B86iBJC+fZKkUwDRzmjJF1xgahG3OvjQQ=;
 b=MMYN3NtosaTXn7Sk/AywRRxtGZtGPa1MH7sdbts/Vq8xZB+9sJHjTChs0PHb3PUDAP
 u+X+/tly95Wx+Fl7JqgBaxPvmY9f60zoZfXaFQn2a5SNEsxkB1NSRNoCWYom63F4d9eK
 lCrI7qhPfBDRpSPIelbOD0mgQe8GWjVJEPSr1PPsB6YUAzMysq8EC1rrYMz+4S0HHB2h
 ewWcvWeZSE9DncJ43gQBR3FXyV82O2UEI4Bb6IEQRmr+k6BqXzfrizQQGRsmJHeuxWCQ
 4cfIhZ2D59uy4pyveupCeHYawCIbOL7IAqHPwfji+WcSscSxLWlPI60vTD9cl24k4QDX
 ou+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823773; x=1779428573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vu8r9w9o/+B86iBJC+fZKkUwDRzmjJF1xgahG3OvjQQ=;
 b=niv6+bfuBNlAOrvR0Sj35XvVYRvpqXGQem5Vi3FetRRuNIYE3EDAmhtCz/GmMx9t77
 AU50YMIOm68Hl2vQgqIS/0voIeG/LmGLLznvRuY49bzsogh1jbov9mNZy6l/+2mbMC3X
 O7TpfYIreejbOM0g1rvZ0cKsGwNMDN3CapY24+Hw7U2oVv7tlwK1IXrWd5SZ+X3XJO1R
 DB8QmpW5YEhy9TUPtT8/h+OWDWpwNiSvcKsS4SzyxqDp10giiGHO52rGspgyZ7qurBfO
 bVHjBAmNxkh5kJQnn6h/u52+BCPTgEtTIAtKdeOb+XOn/7juU8fZ6h+NSLFk6jzsj3Nc
 q/DQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cpP91mf7tbm9gqSEFx5PjRf6/G+XpfMnFbEeD1rYbqYxkcnkEvr8fRfswpUrEuJg7+x86R3TYk0w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgHqaZjXeCV8veNK93HHnli3o3qbERW4GpiqkbdrcvTIj57FAA
 jwzlxl1+hPwV2Mihp5+jZsLG85xtK6X7lWKAot9TS2m1kt8zTCcSgajW
X-Gm-Gg: Acq92OGJTKgqrjXUdz8GiaLJlkjjMNykIUHEcJVfnwFG2HGIP/X3bOArbr6HhqajglY
 WVyHyOeyFPywGPloQppLo5ezwsSlSOLI2bou9F/2eopjvRpOCXZUJ3GvgDRUQ4nR5aLqlO2Kekb
 51nMA8gfoiEPIf2tZ2YXw8zVr+mu2KDR3T9C+YCRu2ksENbIBW5oWdcT+6JULDAcLW0ZCe/wC1U
 XmoKNXm9Ftx4tjIHkfeXOhBlnEmVKR9yjol5aUmyz+S3FhlGGh/3qTZ13ZawTLDYuoJryM9vXjx
 25AnBvl181C3xtEzWEZPwKQSfiIKhsdZRANyU0xTF0RzWjRkN6xhgM9Ykdv/6kljs91uzYYmhJq
 NEbfxEUyKcmbkRM7fbCqDrR2STKBK+7b8+KOpOOWk7fAuqs03EAuHgnSDBn33vU8ZPHnOY2paff
 H0vizY9ouiBa52TdRj61IM2Lx/L3t46lv2py/cS0JSHImTCV3MfDr4vswStm2lRINLrlyJE0WPk
 4FxzqYZctZAlBs/EeIFD1qyjOM=
X-Received: by 2002:a05:6a00:ace:b0:829:8a84:b9fc with SMTP id
 d2e1a72fcca58-83f33ba720amr2908112b3a.8.1778823773353; 
 Thu, 14 May 2026 22:42:53 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:42:52 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v2 4/7] hid: Pen battery quirk for Surface Pro 12in
Date: Fri, 15 May 2026 15:41:49 +1000
Message-ID: <de275cc63e764d2acddf72bf3f50e89f307f41b5.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

The pen setup for this device uses bluetooth for
communicating battery levels and status instead of
reporting it over i2c.

Without this quirk, the device either reports an
extra, broken phantom battery, or hangs.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf63742315b..d16f55479786 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -459,6 +459,7 @@
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
 #define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
+#define I2C_DEVICE_ID_SURFACE_PRO_12IN  0x4376
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..61ecd840d0bd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -395,6 +395,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_PRO_12IN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	/*
 	 * Elan HID touchscreens seem to all report a non present battery,
 	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
-- 
2.53.0

