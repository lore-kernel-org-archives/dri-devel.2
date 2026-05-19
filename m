Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D389BCD5BAB
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A9D10EDBC;
	Tue, 19 May 2026 16:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LVXuw4+R";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85D210EDBC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:08:47 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so41339645e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779206926; x=1779811726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMZ95nXwBRqiNSLY0nFJjbkMYuK5JBNAh4WxIUQ9mYo=;
 b=LVXuw4+R4FTUqMIjq/PPlvZ8Zp24rF47CCjd2AdMlBc2rs/1VIaPB2YiP4g2vuCl2N
 cPEiOhu0qwj9ken9KR41CM2L6IgSjook+vcUZ60lXwRwoncJInczdwKCJtggmIpZ3QBL
 bxG5J07kyvjktxtAhN6YKLVIehH2SDzQLWhTAS5PbAzytHaN6JH8UKqovM1eVsz6fpZO
 uSYokh7IA055i4jak9jc0mnhbERbD/2Fl+MZp9foUUHwG8/9eY6MIZ+XB+LUhRkDDoFX
 gM8QwOHQE8tl+ifaaGEjwADuji1g5f5vvNT71BxyRZK+hZZRwUZew63rP6iDs3mQmzzz
 Ue6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206926; x=1779811726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMZ95nXwBRqiNSLY0nFJjbkMYuK5JBNAh4WxIUQ9mYo=;
 b=Lq0CY456OfhUmDnq1EOm/aV42eb3t7LvHV8jC6COGAhSyqg4I0vDCFooCLzGYSTMFp
 BOPnHOCoT5dmIG2QyUl9RkAzzBan7SdiRASE07nzEhEHVV/BCwIJjuvRKPndeGsDKwCd
 uX0yhvZYA0rCFtxVg5Pg1CjFM0t13xQK9AQPRM7iMGWzDGizz8PyT/KixCP9h/gApo81
 BSlVlpUe5ecejCS4oHlEwYnLoYbWgsDYlfbpPRlLETgdB2nGZ7mEM+iBiCImzeyj4XaM
 lWogzwbA0xfN4ESHmylsDHoXSrQJimWq7e0M9tB/FGQrabRa3Yh0VVFJb9robPSSubvy
 zchQ==
X-Gm-Message-State: AOJu0YzEspuzAjA77D+lGQhiXNFacUAyiOVd0ms44ENSfQT5QgzQgjao
 tBIABsZZ28lBDxhtQjV4L/RvMQciy9hfl5Y35eVkJGSLQGCORhMa5CUL
X-Gm-Gg: Acq92OHsNRF2agx64MHRP6Qbp1ok/L7jm71YK9ZhIxEdRFXJni4Dhu2fd7CXcJ2ec7y
 QKRv+ESMVSaq/g+wZ0wXElFv5UqDRjikUS3glk23Z5xn/hvmBK1x05WsHl2Jcb3tD1eQJOTb5h3
 ekIIL+B0AdTiEz0ZaIWdX9rNBQ5/wpZLq9QdW3jVkN2G9BuN7ahm0uMtXyejVGij1fmnaUcF8si
 +x95Yj6WUo4j8oxkVKA6NvDu8cr3Rm8XYQMTPnAYW9zyXWcWhSV4mbH9BOOVYs+8kyntNsQlRXN
 7RPEDBleeuWucI8LGLa1B5BUlrSSxBYjkIjG/LF7za80f4fTVqMe8KiC6piG0RXfdOwBdH8gYrX
 1annA4PiT6atF6MvBwuW+Q3ot5xLQ3+KpYRUw4mM1Hk9ivZYfOkAZk1fy244RMghSMi7qnlK7Ht
 NNVWmun7IRninrtkT7bq9KVlv1NPuOHYx82Bnpi5Er/KX4m8R8Nwvpxi7OJPSSzgL0gGiMAvzNh
 qIWdZ+GaQ2Oaacq20H+zae1MP9FeOp6EsP67Q==
X-Received: by 2002:a05:600c:848c:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-48fe60ecc19mr314605635e9.10.1779206926241; 
 Tue, 19 May 2026 09:08:46 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm372645305e9.11.2026.05.19.09.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:45 -0700 (PDT)
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
Subject: [PATCH v4 3/5] drm: renesas: rz-du: Make DU reset control optional
 for RZ/T2H support
Date: Tue, 19 May 2026 17:08:23 +0100
Message-ID: <20260519160825.4082566-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Update the DU CRTC initialisation to request the reset control using
devm_reset_control_get_optional_shared(). On RZ/T2H SoCs the DU block does
not expose a reset line, and treating the reset as mandatory prevents the
driver from probing on those platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2->v4:
- No change

v1->v2:
- Added Reviewed-by tag from Laurent Pinchart.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 26b95153ce88..48065f4952a3 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -380,7 +380,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 	struct drm_plane *primary;
 	int ret;
 
-	rcrtc->rstc = devm_reset_control_get_shared(rcdu->dev, NULL);
+	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, NULL);
 	if (IS_ERR(rcrtc->rstc)) {
 		dev_err(rcdu->dev, "can't get cpg reset\n");
 		return PTR_ERR(rcrtc->rstc);
-- 
2.54.0

