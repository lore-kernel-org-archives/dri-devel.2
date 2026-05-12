Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F60CD4F25
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70BE10EAE1;
	Tue, 12 May 2026 14:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dAD8buZE";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2547610EAD5
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:41:43 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so4420334f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596902; x=1779201702; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0HvXZD2JH3Hm4dxIzGecREAhsQ21ewQFNBJt/muUZQ=;
 b=dAD8buZEiqGAJaX//00anMWU6bp08pBTJUMi/LSBMfWi0M5JQArsxW9+95bWpTLU5i
 /+qP3mkgVfwP/V0O7U9t2HqjXME2w8dc0OwxToESCuTDt7Pzzckmlyu36kOVXN1DSzdo
 F/P78dVK3Vw2K81CRcuDxpO9EA1Fy9u7XmFFptu4AxdZUZ6s3Cdlo4fsKp7SySP1EYbB
 ZnS462XEDXPHct8OTOoo9iBs+XC+ZzRWCOCwq88l3GxyKsmpXFPjTdeuelM3Lqo7tcDf
 FgHwqNsXltV6yuJRWeLfKMprdt6ZCfUgR6OHVy75jlaVHX17hbMQ+Eie7geqEJE/cy/p
 dDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596902; x=1779201702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K0HvXZD2JH3Hm4dxIzGecREAhsQ21ewQFNBJt/muUZQ=;
 b=onCUyfyfrxL7XkrPVrjYh3yZk4fulZUHViOAeD/TGjn1r7Krh5S6pxcS3+QFetBtJn
 ahs5vbOjq7/sDmv5EOJXko+RbPOGfc6xiEgYXxjjjvE+F0awtiWHZ/NvQXvHPWTGCplz
 o6SfuuBkSlHSMk9/fL8SuHTDx2ncIKn5dI6jPUBfYR37NXfeKliK9vLuNYy1arJBcH46
 JOhKjNgVfwjMaX01lZaiu3tEz0MZq352QQ3gMXKOkK7DAqGXx/F26eTB6flevU3uR3CR
 Gxy634YN7xM/+Qnfp7EMOce1YzdIKHKGCuidY9CFmrcGxCEUOmYCS2YXMDolCgiNvUy6
 Q3FQ==
X-Gm-Message-State: AOJu0YwMhIPuLG9WhDhJ3d7Sns9FCVAyPyvB3UqB6RRNCR2o8XReyCmt
 +i90GcB+dvrSOdGg28nysn9Jqw3q9SOuUfdXv2FT9RDNEXSarpXfASO4
X-Gm-Gg: Acq92OEx48hiqIocKdHF3nsNjo/vY7Y37hqTipH77+96IGyTSdLrGVbeIPdRZxNHLUE
 NLyJlwIp6mgx+XZdb/vKeWFd6wwnOomLR6Q/ftn+A2CpJoJ/xVYUCyNzVAvePT5e3HRvVWDlFss
 i2ecfCMMzdDRc7k4nbNLG/87yOVX9CNc3Z+h1gd07g1zT0jpP2jYb926q5z3ZZZY57BLoU4n0GM
 2T3p446IJZIXEO8NN5wvMQUzkALQBn8nfBl/2fHqjFu1J/s3Wr1w4HlUdBvKgTgsZQEPvKytda2
 yB/Mg6la3EyOlKB8lLkTBC2O4rBx/wgL//6lGFYchl8cJ/S0FYGUV6sD8AlJs3y70CqvozRjZuc
 Oy3BYDCG27+2CXGmzV/L/dPOKOxStBkprB5wpf2c6qshY/2xzMsTjdCR5+7Fb9knYodzwDVH69O
 TlLEEw/VBnLkrPDaaDymk3xlMrvBgDvG67OK10qYgsZji75fjiqXmy1uczqgtlhoNnZihYrVsk8
 cWK4X6X+Z2vjvxc2eeer67Uqex9ffVhfI0=
X-Received: by 2002:a05:6000:200c:b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-4515b056aa0mr45843437f8f.5.1778596901460; 
 Tue, 12 May 2026 07:41:41 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:77f5:545a:798:321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm34978713f8f.31.2026.05.12.07.41.40
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
Subject: [PATCH v3 3/5] drm: renesas: rz-du: Make DU reset control optional
 for RZ/T2H support
Date: Tue, 12 May 2026 15:41:02 +0100
Message-ID: <20260512144104.761531-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Update the DU CRTC initialisation to request the reset control using
devm_reset_control_get_optional_shared(). On RZ/T2H SoCs the DU block does
not expose a reset line, and treating the reset as mandatory prevents the
driver from probing on those platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2->v3:
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

