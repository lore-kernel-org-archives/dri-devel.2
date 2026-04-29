Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE70CD13D3
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1A410F0D6;
	Wed, 29 Apr 2026 17:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USUgyqVE";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0C510F0F7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:00:23 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso3260675e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777482022; x=1778086822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPI/IWDY5AjEaKDZ824ZagzMhOb02JbM6Y93TiTFTTk=;
 b=USUgyqVERUt0NSum5Etm02sKakdJQCU0wzPQyRdaiWMg4ly46Y2j7f/AY1rMn9nYvb
 4b1dugfC9a9o6fqkQIZip2H5uRMjlNyYdS3WWnXbV2xLCw6NlTSz+rctejf3fWgzJsr/
 n90NPF+ri0FUZqzedYe+4WHMUeJyAck1pZWd75tgGwfRvXMnmJTyOHU2lH85utX412AE
 DfVOX/ONOYaGhgzJJ13wo67pnYC5ltNTzKzwa/yG/a4YVVBm+VKiFg7apm1LhaMwsZs6
 FWkwBbX9dB0V7n/HeUF00xgw9XaPBhMztvLlYh0i27tloQ5eCIioQkSTtVqAiCMsJMyJ
 Zi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482022; x=1778086822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OPI/IWDY5AjEaKDZ824ZagzMhOb02JbM6Y93TiTFTTk=;
 b=bKcuc6KumApbwLnttbUVMUu0L0eOpnsR1V+03ymjqLgTXO/mB8WTfhS0QguwdHHYSu
 fx1anUUyZZz17wXr0C3IrdTYB1N4mTWOYLjqLnGC/27fLCJ+BgP8WUK9XZhG33c2nQzY
 E3ldpZQznps/rsWeNKlC3G87NnKXnnYtFn+WcaD69bR3rIZj9vOyUBKjpjimeAjDTZOb
 +IF0l8Tu3CbUpiJ5lbXF9YtqPFUoKK/DpZUGXgz6hdtI6VQ/0CMNEZKZCmtDsAJhNliu
 Bw9T/YtV5EnDLxJOC+dvOH3g53T4A00JpA376hZaA5x/KQODDhG9nzoNkKbogYt9sj8K
 YaUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tbPQN0I1zIaQXVkvHl5HebVNSgA1OnphYIDTSX751HzjC+Jcv3jw4M5B07ckkMgIftYQxW58b6IM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAH5ev37Qay/+xX2OaWxzyc6cUAGHilI446eyl/UqsTRCEhVDj
 AlTeV7Tpl+g/ANmcbshw1xUW3/MrdW9pg67xsw015W/xGNZVCZxMnYia
X-Gm-Gg: AeBDieu4m3eOgHtXCt9Rnz//Ezfo4hzRQStZMIounxo0qTkrYw3fzqN5VkN5NWfpKQo
 4pCToyfMnLViRDore/Fid9ypRLip8lfuLyL1/ZFu8VO4XZjZqV9hE+mFUwLsa8slp7yjL9t53DP
 L42tXZAkFw2DcRzMJiIUZh5vlgIzZmjr/cvXTs6E0bnJIK+cPobBWGhEahpptKCGAOd7rDcMiZv
 dFslxkCuuzlYSArBi3ZcpEvcXWIeukHz7jUEWMM5dexOAm4Em9tP+PZJFmSOJXHzkJOdEr3HcfW
 CuBDeq10qJDEquxI1yUZpOiTRqOtADuJ/U2hxSorqJFGM/ZpIbCRjg2YX/jWvz19oWRuL2/SdqQ
 KAky1tDyLUbsUYKYupCeudLYVTQ8FZmZoGyDoHpyBn08DhRxGFe08LjYopXo8LQh093WQmca7N5
 86Zyvbcj0anq4UD/j7lYoW6nqCILA1MmjDD1Ct1rWQ4khfYSAXlQcFqqDA94yPIIjfmm14pXQPl
 mGoC64j+TxItwh1RXrpB4a3Pmm7v/Nb2p45qVdaeHNvGKzs
X-Received: by 2002:a05:600c:b90:b0:489:1e8a:90b4 with SMTP id
 5b1f17b1804b1-48a7b53ca8fmr80064815e9.21.1777482021927; 
 Wed, 29 Apr 2026 10:00:21 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:212b:3a69:4f2c:3897])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c856dsm4809755e9.6.2026.04.29.10.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 10:00:21 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/4] drm: renesas: rz-du: Move mode_valid logic to per-SoC
 clock limits
Date: Wed, 29 Apr 2026 18:00:11 +0100
Message-ID: <20260429170012.366537-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
expressed by a single shared rule. For example, RZ/G2UL (R9A07G043U)
limits the DPAD0 pixel clock to 83.5 MHz, while other SoCs such as
RZ/T2H require a wider operating range.

Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to
describe the supported pixel clock range for each SoC. Update
rzg2l_du_encoder_mode_valid() to return MODE_CLOCK_LOW when the pixel
clock falls below mode_clock_min and MODE_CLOCK_HIGH when it exceeds
mode_clock_max.

Set the pixel clock limits for RZ/G2UL(R9A07G043U) to 20.875MHz minimum
and 83.5MHz maximum.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 2 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 0fef33a5a089..3b7162c6e1f4 100644
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
index d53068733c66..ad02efec1c23 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -50,8 +50,11 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
+	const struct rzg2l_du_device_info *info = renc->info;
 
-	if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
+	if (info->mode_clock_min && mode->clock < info->mode_clock_min)
+		return MODE_CLOCK_LOW;
+	if (info->mode_clock_max && mode->clock > info->mode_clock_max)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
@@ -107,6 +110,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 	if (IS_ERR(renc))
 		return PTR_ERR(renc);
 
+	renc->info = rcdu->info;
 	renc->output = output;
 	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
index 3e430c1f6132..39a1d178b856 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
@@ -14,10 +14,12 @@
 #include <linux/container_of.h>
 
 struct rzg2l_du_device;
+struct rzg2l_du_device_info;
 
 struct rzg2l_du_encoder {
 	struct drm_encoder base;
 	enum rzg2l_du_output output;
+	const struct rzg2l_du_device_info *info;
 };
 
 static inline struct rzg2l_du_encoder *to_rzg2l_encoder(struct drm_encoder *e)
-- 
2.54.0

