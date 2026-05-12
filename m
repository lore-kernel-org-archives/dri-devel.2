Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E9CCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF2310EAEC;
	Tue, 12 May 2026 14:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6GpN2BE";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210C610EAE6
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:41:44 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488ad135063so45702245e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596903; x=1779201703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgAo1QhSf4NjgO8ap5MR36rDEgMWMS95+8qq7l+7W58=;
 b=O6GpN2BE87iF4D9Jn0vK9QQ6WeE42YjGgDJK0hfDkMe3520YY9ZvLcIODKyWGSkm+Z
 2F6UoGD1VSBnNEpZ7kBUjSXAwo6NakQ5+RA7bRdlD8F7z/VZu/LJSubRhx8IpNpmIUWQ
 4fK6GKJvLhBuWA7FLooYj6+Ga0E6p61AbV/L6vppH3DysUpSoqjcVflTwFk9gIrL8hgw
 6hD8Htpk6Lz85iV/NhioeV3VowRx+j1CeDkmJ/cgV4isyqL2TZAYjl5u/f2IKC2nah35
 2SK69qj/gK0QWupfYDJdS2ix6NqDbQbgbbH4Dz/0v+LtP2Uk8y0/4v+2K6XMRVqWQ+7o
 xWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596903; x=1779201703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jgAo1QhSf4NjgO8ap5MR36rDEgMWMS95+8qq7l+7W58=;
 b=Mstn5p0O/wjI1zJsHgv7/LsKg2ueD2kddoez4uLuC709iemCHRSFoAWVQ2v9QzuEIT
 g06zPYkBKbNtcOk0DG5+DH35gklNV7YQB4ySkaQbtsw10smY+/cfqmI3zKYusU0kF5co
 QXloXKcxuDERoXlFWuQsIXSr7WZ1WjWj9a+wPCCi3njv8cp4TG1isOklrJoIty/6vwUt
 GdDWVS9F8npgPEdZ/7VBS78X33P74kJmwh31IixwApG5wigwon2eJvkciiYJ+o6yI/i6
 A230iHXiXrkuC8kWW9Y415PNgj4tdWuY0UmO5BNCM/SblCfMbP4C7VkaE+QrKQ6IUtSL
 e5jQ==
X-Gm-Message-State: AOJu0Yy/zQLYy4SZbAexwGLQ6uWFWKANvRlnE0zGPR4F4W4NyGQC/rOk
 CIwYXQzb2NCwHZUGamOxu4XWCcW5zmT1661q6+MktjJwcN3gYNKLtR1Q
X-Gm-Gg: Acq92OHNlBcuwWLHKiPYxnag6Zuoa61vLIWEGNXerRwRFWBJePnQJ6TzYisak4efHZd
 LQz/A92fKMfeMSKSPClzJfduYTxh9phfFkatcSBTpJZhemWWd8DHdmJ+SJIbuW0FigLpY2lzxyO
 jsrO4djRBPvVeDe/N8JNnH0H2kjKSqn1JPGADIh0z+qq/oqvep+8zLrEJB/7Ji7TmMqeZvjxtpQ
 JgStoKcgPPEeGQOQm+A8yzyw/TZPtJLuPKpV2NvW1mCagihnnVDFaaAyZEQP4Z6PqJaj/p9ZFs3
 tNqSIzKam+KRMimvRpDiRGmx6GDqolfLWptAeiA8wSuw4SsAzMB3A6zBzpkq3TCrfYH3+1LpFX9
 gISSELvLnMQgIWJ/HUZB+o7NGdJo9/efu+kJyNocqsfyCzvUkQmczcFQQg/XShsmXu1L43zYBpc
 M+RV3x2nIK7rMfK48hrarbrqZcqOiXy7wGGolcObjpaW6apog8oQJt83Sbr+v05CihX4xxBWJf1
 EUdSZH4CT7GRVZtkzeSsgPRujOXZZumZIrIO7s7DxfaLg==
X-Received: by 2002:a05:600c:8908:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-48e51dd879emr325128105e9.0.1778596902553; 
 Tue, 12 May 2026 07:41:42 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:77f5:545a:798:321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm34978713f8f.31.2026.05.12.07.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:41:41 -0700 (PDT)
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
Subject: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-output clock limits
Date: Tue, 12 May 2026 15:41:03 +0100
Message-ID: <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Move pixel clock validation from a fixed encoder check to per-output
constraints stored in rzg2l_du_output_routing.

Previously, rzg2l_du_encoder_mode_valid() applied a hard-coded 83.5 MHz
upper limit specifically for DPAD0. This approach cannot scale across the
RZ DU family because pixel clock limits vary per SoC and per output
interface.

Add mode_clock_min and mode_clock_max fields to rzg2l_du_output_routing
so that clock constraints are expressed at the granularity of individual
output interfaces rather than globally per SoC. Update
rzg2l_du_encoder_mode_valid() to look up the routing entry for the active
output and return MODE_CLOCK_LOW or MODE_CLOCK_HIGH when the pixel clock
falls outside the declared range. A value of 0 for either field means no
bound is enforced in that direction.

Set the DPAD0 pixel clock limits for RZ/G2UL (R9A07G043U) to 20.875 MHz
minimum and 83.5 MHz maximum. RZ/G2L and RZ/G2LC (R9A07G044) share the
same DPAD0 pixel clock limits.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Moved clock limits from device_info to output_routing to allow
  per-output constraints.
- Updated commit message to reflect the change in approach.

v1->v2:
- Dropped storing info pointer in struct rzg2l_du_encoder as it's not needed.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 4 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 0fef33a5a089..d1bc205eb5f8 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -33,6 +33,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g043u_info = {
 		[RZG2L_DU_OUTPUT_DPAD0] = {
 			.possible_outputs = BIT(0),
 			.port = 0,
+			.mode_clock_min = 20875,
+			.mode_clock_max = 83500,
 		},
 	},
 };
@@ -47,6 +49,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
 		[RZG2L_DU_OUTPUT_DPAD0] = {
 			.possible_outputs = BIT(0),
 			.port = 1,
+			.mode_clock_min = 20875,
+			.mode_clock_max = 83500,
 		}
 	}
 };
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 58806c2a8f2b..307ae70dd382 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -30,6 +30,8 @@ enum rzg2l_du_output {
  * struct rzg2l_du_output_routing - Output routing specification
  * @possible_outputs: bitmask of possible outputs
  * @port: device tree port number corresponding to this output route
+ * @mode_clock_min: minimum pixel clock in kHz
+ * @mode_clock_max: maximum pixel clock in kHz
  *
  * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
  * specify the valid SoC outputs, which CRTC can drive the output, and the type
@@ -38,6 +40,8 @@ enum rzg2l_du_output {
 struct rzg2l_du_output_routing {
 	unsigned int possible_outputs;
 	unsigned int port;
+	int mode_clock_min;
+	int mode_clock_max;
 };
 
 /*
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 0e567b57a408..4af2ae09ff39 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -50,8 +50,12 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
+	struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
+	const struct rzg2l_du_output_routing *route = &rcdu->info->routes[renc->output];
 
-	if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
+	if (route->mode_clock_min && mode->clock < route->mode_clock_min)
+		return MODE_CLOCK_LOW;
+	if (route->mode_clock_max && mode->clock > route->mode_clock_max)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
-- 
2.54.0

