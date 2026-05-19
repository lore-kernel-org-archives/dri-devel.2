Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6634ACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D439210EDC6;
	Tue, 19 May 2026 16:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AR1umYBb";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F6210EDB7
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:08:48 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so25085475e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779206927; x=1779811727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAWcMRCYIfI13fsHZY8bUdRnZOMEHAf8WPoUZ0UW9yQ=;
 b=AR1umYBb+UZnxdVtH3kRjTSsMAVnL1ZkrKW+jRhmTZLyRZDjXMPkpqGCBdzoMShASN
 1le5f+ervIb7VPJew1DnDv+iPYgOSsYYpn8zY3InhV86iDSgoHUvVkMW8ckO2OJtBEoY
 VadqZ/MvGa/EkLD5SrI3IIyPrxRFse1LkqPpWYuXg31R71S2M2PCDw6zcfPCMmoAlsc2
 QTsNULYu2Yj1fxRL510RWokEgdAtI0e6o/vjfYAPhF+5RZ+Pxw04Lo7fmligZZ2KfARd
 Z+4q+l2sysc1I752RdH4Y+UGjyan0HRp8GmulN88Tz/ZbygGEyF4R3E3k+0TN1jzlcaq
 Db0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206927; x=1779811727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAWcMRCYIfI13fsHZY8bUdRnZOMEHAf8WPoUZ0UW9yQ=;
 b=HQqyXu2VRt8huqzsvQ8piEZHdbxWTZJ8dzZwAw947Ztd11XxHGah2aqyH4bHwiPDPk
 NKcXpBTblLHBJeShFM8n0byJCqSb9Al8U2QIiOVz+vyNOtaT15xintaw68uS/qJGwGAm
 rTlcFv26KsWHluAr5MZejT2dELZHi1IZbZRsPEmLl6reAYn2AW+w8EBwzWW46q7LZMB/
 9Ox5ZL4KCdosjUno8u1ROKN9EvMDF2MJFdwP46a8zzq2NU+P9a9UxzBqyy5O35ftNELN
 nh3sXMMxB/zwxiPBehjHI6UhkZrymoSB+JOyXT194eALqNWxCnDR2jxtQ7mHqWwp/rp9
 uYfA==
X-Gm-Message-State: AOJu0Yxyx1M0ixKHybODR43y85XJOF1M640oqMVMEHocYlXE1yXLx6Bf
 QeNnSfUp1ML+5cZMZrxjJ2pSutEkmNKtmRyyhQVDohu6ecWeAWLPRsXp
X-Gm-Gg: Acq92OHi7NhTb4Yr+APU71LNflhzurOc7l9y1D9voCQedWQjRQA4bp96pmrR1pAYFBS
 5CgMhIpBS9h/LgyIo3FuMcylzO3R+dKi4+twqczCpvQhAw9yIbO9YVZDe4F4GE3ZhOB/VewDXlC
 9aSf/6wokMBxwhVH9TA3tmR5+9Towi+exrgL9/IZvXtEBo+u92SNi9bhWo/XUo3iq7kLsSdITxH
 gxL/fd9FPMG9tfB59sMXQZ9wR7Vekjr0BEcck/8myLVG2gxXBBCGzM93KDso/eGBE1PuJWdaSQY
 AqGvfwjGZ5ajDb6LDXGPtnt2C/3+rlKmOf+CtYbr47tM8A9ENdR7y0f95oxuygESuXXl7fwOMfH
 lJzWb8P9pxBG21i/UZSpFTSPVo+stuZ0ALD1zCBF78qLIJkDReShRcxj40Mt+LpxSk2aUtigsOf
 xUrwaiSUlqMxKt/XPFrYwvKLnnYv7zvPuWMi+TLqjkMbJUMvdy9SgA/+Cbt4WrbQz90GsgVRWI+
 30Jwz9IEg4UbH81aCB5OUthmHg9IStEZ/Ztq9xq/RbZdeEK
X-Received: by 2002:a05:600c:4692:b0:48f:d835:e104 with SMTP id
 5b1f17b1804b1-48fe6325391mr323856325e9.16.1779206927342; 
 Tue, 19 May 2026 09:08:47 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm372645305e9.11.2026.05.19.09.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:46 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 4/5] drm: renesas: rz-du: Move mode_valid logic to per-SoC
 clock limits
Date: Tue, 19 May 2026 17:08:24 +0100
Message-ID: <20260519160825.4082566-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Move pixel clock validation from a fixed encoder check to per SoC
constraints stored in rzg2l_du_device_info.

Pixel clock limits differ across SoCs in the RZ DU family and cannot be
expressed by a single shared rule. For example, RZ/G2UL and RZ/G2L limit
the DPAD0 pixel clock to a narrow window, while other SoCs such as
RZ/T2H require a wider operating range.

Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to
describe the supported pixel clock range for each SoC. Update
rzg2l_du_encoder_mode_valid() to check these bounds when evaluating
DPAD0 outputs, returning MODE_CLOCK_LOW when the pixel clock falls
below mode_clock_min and MODE_CLOCK_HIGH when it exceeds mode_clock_max.

Populate the pixel clock limits for both the RZ/G2UL (R9A07G043U) and
RZ/G2L (R9A07G044) variants to a minimum of 20875 kHz and a maximum of
83500 kHz.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Dropped per pad limits
- Updated commit message to reflect the change in approach.

v2->v3:
- Moved clock limits from device_info to output_routing to allow
  per-output constraints.
- Updated commit message to reflect the change in approach.

v1->v2:
- Dropped storing info pointer in struct rzg2l_du_encoder as it's not needed.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 6 +++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 9 ++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 0fef33a5a089..1e4b9f38c55b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -35,6 +35,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g043u_info = {
 			.port = 0,
 		},
 	},
+	.mode_clock_min = 20875,
+	.mode_clock_max = 83500,
 };
 
 static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
@@ -48,7 +50,9 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
 			.possible_outputs = BIT(0),
 			.port = 1,
 		}
-	}
+	},
+	.mode_clock_min = 20875,
+	.mode_clock_max = 83500,
 };
 
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 58806c2a8f2b..885558eb9547 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -44,10 +44,14 @@ struct rzg2l_du_output_routing {
  * struct rzg2l_du_device_info - DU model-specific information
  * @channels_mask: bit mask of available DU channels
  * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
+ * @mode_clock_min: minimum pixel clock in kHz
+ * @mode_clock_max: maximum pixel clock in kHz
  */
 struct rzg2l_du_device_info {
 	unsigned int channels_mask;
 	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
+	u32 mode_clock_min;
+	u32 mode_clock_max;
 };
 
 #define RZG2L_DU_MAX_CRTCS		1
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 0e567b57a408..56220139a149 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -50,8 +50,15 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
+	struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
+	const struct rzg2l_du_device_info *info = rcdu->info;
 
-	if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
+	if (renc->output != RZG2L_DU_OUTPUT_DPAD0)
+		return MODE_OK;
+
+	if (info->mode_clock_min && mode->clock < info->mode_clock_min)
+		return MODE_CLOCK_LOW;
+	if (info->mode_clock_max && mode->clock > info->mode_clock_max)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
-- 
2.54.0

