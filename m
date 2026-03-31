Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C35FF60D8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C4810E897;
	Tue, 31 Mar 2026 07:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="La4IRbCP";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C9010E7D4
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:52:36 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-94de68feaf4so3093760241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1774921955; x=1775526755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAXZ+JVlQDzpRClVg4fHLc14WbopBlWfTMLP+TpCKYM=;
 b=La4IRbCPWnB6kVUMlKlbsw1AkcW3KHNyFFDPMgY/S+5ByNqxc3BJRYMWUKfVvAMdZZ
 GltSLbVMg2hasOKwXHL3hsZeTRh4PWCTrExX5PwGS7aCGj7k93d3JUTo0sPTBKpeSm9Q
 0cdoJUwGFSO8IqGrvd5FHjQVDWPB29BEpRooD++KsevuhCFFBYb/BFJFxrD9Ktmt/Gwt
 9EO8EG5rmw0lY6xQ4//wPbALr4GUHiE7Mle5EuWMisHeJ0ubROHU2Ax17ZlYA8ZvixaJ
 QwoucI5/hkWvJqNRLteMsToFVX5b+uI9ZIRzSk0eV2zMgQuiO0ED5VGHHzbA+PTqgt86
 EfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774921955; x=1775526755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GAXZ+JVlQDzpRClVg4fHLc14WbopBlWfTMLP+TpCKYM=;
 b=RMhCYFcpabX1JnzYZPbycRjwas1AJZB/JXtcALOaubD9QYdwLroPy+oMIe1sm7l5Rd
 WZ9bBk8VRPndMs9hgnNXUMXQzyrSXThKCrREPl4FyKd2/hJmdcblM84znCXIcu1H8Ex0
 qWA8S7zE2lKPCcDzcr1K/S8GwT0DNHhlH+CnidOcrtqVVCUd7Q9szHUCAEw2twrcDRfl
 biT9L7HjjBoGgEwgRfWgaGyj3k5GZVNifKXS3BQLdPY3QIY3GZnPiXg2dDER9OaRbTsO
 uNZAXZ9cEr92e4eobHDeSvK17WBvNAS5rSdXb69tx0sJxkewwfIKSrQfM2kli/ZNUQ/o
 Ml3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0bMTz40VQg8P88QZpM06C6oidXmDVORqL9Vt2+Yoraro4ViXMrI9wTGSVwt6sw0cZl1+1cXrQg1A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGW5x/gO3F+MIUSlPNQbKuROc4HwU9NfTanj2Nvv9oyRwbItWh
 40ar0g0Rv0WcEcZT4ST+10X2qlQAzem3iLQF2boJRFmihFw5Y/vtjwCAA5Fo+UbVOPk=
X-Gm-Gg: ATEYQzzduqTSC8WY9YZDPFFoaOCyf7lSOVAUb/CXnFaMkrz1a8Ay5YvLumm1EqZzJgW
 pS86yztoFi7gM+bnd4MEx6U92aR5GiCmd0YNvRNvyf7naxMFmhHpX4zpZSkZmuV9FYuGhHnFzxM
 5BCWfGkmOMtxZZy4MwMxiL9zuLbt5hp5wdqc8YNLPzoXUXmCFPzzFL5zbnCMJKrj+N6I9gy9+39
 D7HfWMzEGdQo9mAkXUti/L56vFJxaoC3UHeMv0D50ZtCrfUPebKD4Bn1UN2G8GZ0g2ePR2r0Mv4
 IQ7TnmSxKNZ51bkCLdx5uDfvPX68JfnBmOGkfGbsRMoh3GOGWXoo0BE+W76XIiP6s+HTDzAvYWz
 KMTt6rR3KA8l2KNMs2y4zb3gLNUuAwaCTuhMdyeI3egFWIMwD2l70Jvlap4OiTH4FXfjbl+iR2u
 tgIjvESymvNM91uHOs7YJ9YQGEwjaJ4ELjIu/LdkvaRpF594znZA+Iv0ZFOearL+8pud+6XRClY
 xfSVFm4OfkYSZkNkl/5ajZtUMm+2rV+xmaRZgFeF4lP3uLEMkPBbpkpzOuE
X-Received: by 2002:a05:6102:5486:b0:605:26eb:cc15 with SMTP id
 ada2fe7eead31-60526ebcf5cmr3513492137.32.1774921954840; 
 Mon, 30 Mar 2026 18:52:34 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-605129b8347sm10852730137.3.2026.03.30.18.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 18:52:34 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: guilherme.bozi@usp.br, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/amd/display: Deduplicate DCN DDC register assignment
Date: Mon, 30 Mar 2026 22:52:02 -0300
Message-ID: <20260331015202.51017-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJgF-xs=3fbKQO5Mj=coPMXq0ecWmV0bJDNFN44coEHV3WS=wg@mail.gmail.com>
References: <CAJgF-xs=3fbKQO5Mj=coPMXq0ecWmV0bJDNFN44coEHV3WS=wg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:23:33 +0000
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

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---

v2:
	- Corrected type mismatch (ddc_shift - ddc_sh_mask)

v3:
	- Fix threading (previous version was not sent as reply)
	- Squashed fix to avoid build breakage

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
index 000000000000..863177cf67e8
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
+		const struct ddc_sh_mask *shift,
+		const struct ddc_sh_mask *mask)
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

