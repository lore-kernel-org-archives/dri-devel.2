Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15101C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1F510EC18;
	Wed, 29 Jul 2026 12:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlrK1pdS";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F1910EBF8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:37 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so599327f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329736; x=1785934536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nHJ7qvChTkqHT1PONJMbm2kO6eeTHCVgWIzV8QJmFO4=;
 b=YlrK1pdSkJDd92Id5TvY9bSJ1KSgIqrFefG+vvi031j0U/YCtZxQc8a6/V7IpsOp35
 lOzu4bojHzIXKWeKc4G7hV+CGJmmhfCbMN88foUVIsONw558AqvyXH/8c20ZnloRmDkd
 2Buxx7rNNy/vks7LWjiNF3dhMo9n9pfG8FVeDAg/HrzKIb98WVbP6m5KuCoOn114HMkR
 fBXSs/iLPllOXqVb9VUbrt/J4hbkk8Efgz3lNk3LlHwpgKK5m7utoVo4DgFV0brIFtxr
 mpmg94lm3GnHUeWC8QnS9wgOt8sD2LAbh5JWBpw0ej+Yc2BNfEVFOjYgT857iaxsjmmj
 CEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329736; x=1785934536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nHJ7qvChTkqHT1PONJMbm2kO6eeTHCVgWIzV8QJmFO4=;
 b=fT5RkgLYtAp/rFQUmZkTCLJI3kUaW8QrdfBbBzqt35qwZlIwHDaS4PNvVBAfuqbrIF
 ZiCMQklIFifd/yUukAdFALWOo41JWT/7JpFepqQSJ99kG8m9SqOs/2omsbQCtnpW3XFY
 Vjhb+1dFoodDzWx2GKLNLF4DzzJHmPrCgTdT/J+it0TrTH+m79wgGCrNGt1zjGeT5x2k
 LUTRnZlD++xfW7NbTLSXeBc1YLsTlkNceS3FowyWgYbxOhvLI6DwJebgpmHk0BQpmB2Y
 HyDG7Qd3an0dljYjv4wqOH6pOFpcPCVhR31q5dcxF8m574MN2uuPaq7t7AU3Q0aRZZYd
 2brQ==
X-Gm-Message-State: AOJu0YzJB5RFLOugxtnEbPnpt8sqfka+JM+QoYDxpyArs3whYOdmJ2Hf
 nF7CHMXEHRRwaVqJnCvNwE6gBdNvPFAAgoTH9AJBuyNO0IIclwWNaOvV
X-Gm-Gg: AR+sD11RnJDFc4n3TDDGdsis8gH8+jIZoYc4Nh9oNZHq3QCttf+nqZcMe1naPMrW4DJ
 Y82EPTSlJmfDyGy9Kg3KQWDx02lwvp+ToMcEnebjghB2iTtRZxN9sKMLSaWyQhOGev2L2+Dxlz6
 pzdECcXjN8sIlozSCpF9HDHOYYvGLTVyaeF/uRxDkleq/tJ/9u2QQv+OWTI3PqgS0yldiLZThzU
 IQfHEQU4mrELJEX9OK+FaQuviW/EJ+sBw7lx+yYZvAyY0F/TPf1O/X9jmWN68QaF67+0o4nTk8h
 zrV+q/hAxRYvX0xvgLOY3l44t0toRMlp4POAwfm3/CwXKcsbRpXMXUT3dpGJNZsBuw322+DnMZt
 HKV33/t75MD4qkvgHY9Wxd4fU4E679d6PlChJLsjKysDkuCJrpwuqbWKCQMYQe3SRwrQuOWzqma
 bdU5m3c8cJZxQH29H0lMtHCHJmz3TehrwfU+zGScj/7J7AP/Nr0q+gBkNhxZMpPk5k1ySAnrcH2
 TTN1BJbM/Vy4A==
X-Received: by 2002:a05:6000:4696:b0:47f:bf12:b14e with SMTP id
 ffacd0b85a97d-47fbf12b196mr735103f8f.34.1785329735742; 
 Wed, 29 Jul 2026 05:55:35 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Date: Wed, 29 Jul 2026 13:55:00 +0100
Message-ID: <20260729125516.230757-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
similar to the one found on RZ/G2L, but has LVDS support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS.
 * Dropped the variable rcdu from struct rzg2l_du_encoder.
 * Dropped the variable lvds from struct rzg2l_du_device.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 22 +++++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 3d13f61d3c97..a8d841421a0b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -55,6 +55,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
 	.mode_clock_max = 83500,
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DSI0] = {
+			.possible_outputs = BIT(0),
+			.port = 0,
+		},
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0),
+			.port = 1,
+		},
+		[RZG2L_DU_OUTPUT_LVDS0] = {
+			.possible_outputs = BIT(0),
+			.port = 2,
+		},
+	},
+};
+
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	.channels_mask = BIT(0),
 	.routes = {
@@ -81,6 +99,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
 static const struct of_device_id rzg2l_du_of_table[] = {
 	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
 	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
+	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
 	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
 	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
 	{ /* sentinel */ }
@@ -92,7 +111,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
 {
 	static const char * const names[] = {
 		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
-		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
+		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
+		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0"
 	};
 
 	if (output >= ARRAY_SIZE(names))
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index baf076d69cda..7812f36edbe0 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -25,6 +25,7 @@ struct drm_property;
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
+	RZG2L_DU_OUTPUT_LVDS0,
 	RZG2L_DU_OUTPUT_MAX,
 };
 
-- 
2.43.0

