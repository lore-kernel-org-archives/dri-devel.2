Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299E91094462
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E7910E273;
	Sat, 21 Mar 2026 09:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J7B+sIvs";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6906F10E1D3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 01:57:28 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-94ace5d0e39so710118241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 18:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774058247; x=1774663047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NOjbfVu2iFXxJILdCEl8FiFsVKUYJeRJ3TBc4EnNsEs=;
 b=J7B+sIvsTOeO4OnJ9+0tlVHHfyWIVIPYt2XjcT6uTPsvmHnR8kYihGbpdEce2tNVIH
 0tK/MTcyXhJDKyMA9XbL0mZMLzNYnl3rQ+biFef3zs7mdVlyfcAo/ZfdRVaH2tfHvO3F
 IMn6nslL9XtW+jc8O5MbuyoF2hYuz8YpUdTrtXnAciwfU1enaPuYX3vafR6EoPW3mbFI
 RXzNqUU9ebqWP34NBhVfYM0TagOHbJF2Jh7cR9eNEn2suIPYLZUSF9y1yASYzuIC+MTc
 DjkUq1sJGRk9Cutx9QsyFyr9JaNL0ryXQjkjzD4ZQwfjORrrb7Uoa5Pz+AEXpxMwFOtv
 H/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774058247; x=1774663047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOjbfVu2iFXxJILdCEl8FiFsVKUYJeRJ3TBc4EnNsEs=;
 b=rs8gDywUydXLc5spcJTH3/xMlw2b1Gy++EF2+1wlQGwNz1Z3A7LVwj4MXEAWMxZpJs
 MYj8SAYuyYuybfA5nC12moVoUckK97jCvbx103mbj9pqR0te6fJMRVS1YHG6cNsL1JKX
 Ci3cjHFoMbiBVUf57/eFYW0rBtHrXMWM+bmiy2EA2hjzFKQvNW+Z+QNDpS8s+cNsNNG2
 kDLBg3nxbzIvs1BlX5hCafoU0eZacGFSQGEuloErUldMGybLauUyOr5dnD7olL9XH4ak
 4K89x5Wy/IIyADn/JEqYY7Dkf9Wfv67xd3X57UES9NaZiswv+ngspNVIdnT37LQQCA8V
 04Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPK9SdZmz4Mk7AeBZKUj0TCFVRCpDGMdHmPniSZCGUi8EsSSb2pcq+l9Fp/94FGdHWjCrWIS9ybSw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBB7I4i2aQEUrxwHBq9T70CCuhvmUwQUbZPzXEOEnCOMUo3Ytd
 45Xi7YNvFGpWXJp96T4lx5fvcrIi5sIMWkfI3+ADWVWPRhqhORPWtPxv
X-Gm-Gg: ATEYQzyp9QWx3+UZeEYt3okusedSV8wHXL3FPqDTZ87c9mcfw5swH26BloJyQLgMz0j
 HZmwG9+o3oBaBqO1sqmwiJ0bFoKbPBfKmT4tMnyYHUhZ+CLE+gR7TrAHjYELW6q+tRQnA8zDqpe
 pUS3Q9VwNP18/NtjSWI+7Fbzr3RUjbrXDTBPo/p7tRfgEcZJPvUwKVtM0ZqrlCMG0Nw8uNoMNaz
 dpWT4kAMaqNDshMrhpasJgxFlbq0oYRIP5jIN6w5YN8U7JB62+JzWZgiVICOo3jMRCPOE307svE
 qss1l/7pKW1jRfnTzp9wNZ1fjd7vlGgJIqy+dzRCpmJxboNFAUE9tDwDXIB837fMfhSQPLu0OJ5
 jMLrYKF4oTLYkNoG5ZX2aq2+9M/XlBhMrlvRjBBPDCmoLysgmLiENOTfs9Caewq+0TtikSg/e1n
 RHsXeSTY+nC5K79xB8xRYsf/6ISWEKYLo=
X-Received: by 2002:a05:6102:2ac1:b0:5ff:b403:a36a with SMTP id
 ada2fe7eead31-602aeb08fb4mr2284953137.16.1774058247111; 
 Fri, 20 Mar 2026 18:57:27 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.57.219])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-602afb00179sm1989296137.9.2026.03.20.18.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 18:57:25 -0700 (PDT)
From: guilhermeivo <guilhermeivob@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: guilherme.bozi@usp.br, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 guilhermeivo <guilhermeivob@gmail.com>
Subject: [PATCH] drm/amd/display: Deduplicate DCN DDC register assignment
Date: Fri, 20 Mar 2026 22:56:54 -0300
Message-ID: <20260321015654.105059-1-guilhermeivob@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:46:58 +0000
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

Several DCN generations implement identical define_ddc_registers()
functions to assign DDC register, shift and mask pointers based on
GPIO ID.

Introduce a shared inline helper,
dcn_define_ddc_registers_common(), and convert all DCN
implementations to use it.

This reduces duplication and improves maintainability without
changing behavior.

No functional changes intended.

Signed-off-by: guilhermeivo <guilhermeivob@gmail.com>
---
 .../display/dc/gpio/dcn20/hw_factory_dcn20.c  | 27 ++++---------
 .../display/dc/gpio/dcn21/hw_factory_dcn21.c  | 27 ++++---------
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  | 27 ++++---------
 .../dc/gpio/dcn315/hw_factory_dcn315.c        | 27 ++++---------
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  | 27 ++++---------
 .../dc/gpio/dcn401/hw_factory_dcn401.c        | 26 ++++---------
 .../amd/display/dc/gpio/hw_factory_dcn_ddc.h  | 39 +++++++++++++++++++
 7 files changed, 86 insertions(+), 114 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
index e0bd0c722e00..905d14079b91 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"
 
+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn20.h"
 
 
@@ -182,25 +184,12 @@ static void define_ddc_registers(
 		struct hw_gpio_pin *pin,
 		uint32_t en)
 {
-	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-	switch (pin->id) {
-	case GPIO_ID_DDC_DATA:
-		ddc->regs = &ddc_data_regs_dcn[en];
-		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-		break;
-	case GPIO_ID_DDC_CLOCK:
-		ddc->regs = &ddc_clk_regs_dcn[en];
-		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-		break;
-	default:
-		ASSERT_CRITICAL(false);
-		return;
-	}
-
-	ddc->shifts = &ddc_shift[en];
-	ddc->masks = &ddc_mask[en];
-
+	dcn_define_ddc_registers_common(
+		pin, en,
+		ddc_data_regs_dcn,
+		ddc_clk_regs_dcn,
+		ddc_shift,
+		ddc_mask);
 }
 
 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
index 2f57ee6deabc..f347b8c7e2b6 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"
 
+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn21.h"
 
 #include "dcn/dcn_2_1_0_offset.h"
@@ -170,25 +172,12 @@ static void define_ddc_registers(
 		struct hw_gpio_pin *pin,
 		uint32_t en)
 {
-	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-	switch (pin->id) {
-	case GPIO_ID_DDC_DATA:
-		ddc->regs = &ddc_data_regs_dcn[en];
-		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-		break;
-	case GPIO_ID_DDC_CLOCK:
-		ddc->regs = &ddc_clk_regs_dcn[en];
-		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-		break;
-	default:
-		ASSERT_CRITICAL(false);
-		return;
-	}
-
-	ddc->shifts = &ddc_shift[en];
-	ddc->masks = &ddc_mask[en];
-
+	dcn_define_ddc_registers_common(
+		pin, en,
+		ddc_data_regs_dcn,
+		ddc_clk_regs_dcn,
+		ddc_shift,
+		ddc_mask);
 }
 
 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
index 36a5736c58c9..25eef1ee10fe 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"
 
+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn30.h"
 
 
@@ -199,25 +201,12 @@ static void define_ddc_registers(
 		struct hw_gpio_pin *pin,
 		uint32_t en)
 {
-	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-	switch (pin->id) {
-	case GPIO_ID_DDC_DATA:
-		ddc->regs = &ddc_data_regs_dcn[en];
-		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-		break;
-	case GPIO_ID_DDC_CLOCK:
-		ddc->regs = &ddc_clk_regs_dcn[en];
-		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-		break;
-	default:
-		ASSERT_CRITICAL(false);
-		return;
-	}
-
-	ddc->shifts = &ddc_shift[en];
-	ddc->masks = &ddc_mask[en];
-
+	dcn_define_ddc_registers_common(
+		pin, en,
+		ddc_data_regs_dcn,
+		ddc_clk_regs_dcn,
+		ddc_shift,
+		ddc_mask);
 }
 
 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
index 5feebb3b95ca..571a6f1b0cf9 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"
 
+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn315.h"
 
 #include "dcn/dcn_3_1_5_offset.h"
@@ -191,25 +193,12 @@ static void define_ddc_registers(
 		struct hw_gpio_pin *pin,
 		uint32_t en)
 {
-	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-	switch (pin->id) {
-	case GPIO_ID_DDC_DATA:
-		ddc->regs = &ddc_data_regs_dcn[en];
-		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-		break;
-	case GPIO_ID_DDC_CLOCK:
-		ddc->regs = &ddc_clk_regs_dcn[en];
-		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-		break;
-	default:
-		ASSERT_CRITICAL(false);
-		return;
-	}
-
-	ddc->shifts = &ddc_shift[en];
-	ddc->masks = &ddc_mask[en];
-
+	dcn_define_ddc_registers_common(
+		pin, en,
+		ddc_data_regs_dcn,
+		ddc_clk_regs_dcn,
+		ddc_shift,
+		ddc_mask);
 }
 
 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
index 985f10b39750..d6e97b246bae 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"
 
+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn32.h"
 
 #include "dcn/dcn_3_2_0_offset.h"
@@ -203,25 +205,12 @@ static void define_ddc_registers(
 		struct hw_gpio_pin *pin,
 		uint32_t en)
 {
-	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-	switch (pin->id) {
-	case GPIO_ID_DDC_DATA:
-		ddc->regs = &ddc_data_regs_dcn[en];
-		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-		break;
-	case GPIO_ID_DDC_CLOCK:
-		ddc->regs = &ddc_clk_regs_dcn[en];
-		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-		break;
-	default:
-		ASSERT_CRITICAL(false);
-		return;
-	}
-
-	ddc->shifts = &ddc_shift[en];
-	ddc->masks = &ddc_mask[en];
-
+	dcn_define_ddc_registers_common(
+		pin, en,
+		ddc_data_regs_dcn,
+		ddc_clk_regs_dcn,
+		ddc_shift,
+		ddc_mask);
 }
 
 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
index 928abca18a18..06a4d7a8a1ac 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
@@ -12,6 +12,7 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"
 
+#include "../hw_factory_dcn_ddc.h"
 
 #include "dcn/dcn_4_1_0_offset.h"
 #include "dcn/dcn_4_1_0_sh_mask.h"
@@ -195,25 +196,12 @@ static void define_ddc_registers(
 		struct hw_gpio_pin *pin,
 		uint32_t en)
 {
-	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-	switch (pin->id) {
-	case GPIO_ID_DDC_DATA:
-		ddc->regs = &ddc_data_regs_dcn[en];
-		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-		break;
-	case GPIO_ID_DDC_CLOCK:
-		ddc->regs = &ddc_clk_regs_dcn[en];
-		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-		break;
-	default:
-		ASSERT_CRITICAL(false);
-		return;
-	}
-
-	ddc->shifts = &ddc_shift[en];
-	ddc->masks = &ddc_mask[en];
-
+	dcn_define_ddc_registers_common(
+		pin, en,
+		ddc_data_regs_dcn,
+		ddc_clk_regs_dcn,
+		ddc_shift,
+		ddc_mask);
 }
 
 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
new file mode 100644
index 000000000000..1f2bc7eea82e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DAL_HW_FACTORY_DCN_DDC_H__
+#define __DAL_HW_FACTORY_DCN_DDC_H__
+
+static inline void dcn_define_ddc_registers_common(
+		struct hw_gpio_pin *pin,
+		uint32_t en,
+		const struct ddc_registers *data_regs,
+		const struct ddc_registers *clk_regs,
+		const struct ddc_shift *shift,
+		const struct ddc_mask *mask)
+{
+	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
+
+	switch (pin->id) {
+	case GPIO_ID_DDC_DATA:
+		ddc->regs = &data_regs[en];
+		ddc->base.regs = &data_regs[en].gpio;
+		break;
+
+	case GPIO_ID_DDC_CLOCK:
+		ddc->regs = &clk_regs[en];
+		ddc->base.regs = &clk_regs[en].gpio;
+		break;
+
+	default:
+		ASSERT_CRITICAL(false);
+		return;
+	}
+
+	ddc->shifts = &shift[en];
+	ddc->masks = &mask[en];
+}
+
+#endif /* __DAL_HW_FACTORY_DCN_DDC_H__ */
-- 
2.47.3

