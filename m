Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4AFCD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421F710E5E4;
	Fri,  8 May 2026 11:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PM1anrdo";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3024B10E5E4
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:17:52 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso1096139f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778239071; x=1778843871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39w49gZKpFRzhgKjJD0rTXzt/7rwWxh4HEQyrYnkNBo=;
 b=PM1anrdooXX8DN1/wITpkUK5uFKmIA0qJfNB3fLOz/RFhUZXiaDXv1LZyzQBsdgWMn
 uqPUmCtthvQ3t2CTLg/RjAM41lS0wjmeOPF+Dhzq5hLyhNdJ0eNYBTcwD41p2+Xm4vMb
 3ChMAhUhdN2UhJwYy8zf+1d5R5IM1MtS8ldbjCcocg3eF0C/YsegqJoluoIFW70sZfbH
 adtXbkP9HK2JSHwBBIE4+PoF/UwwfGxQOFJI+KtzqazrIUkn+DZ3LdJWmN4BhWdZ17fO
 5InSo2P5gNWVf534nPQI94QdZvaI2oRQAje9mfuG/KQehAd9JRT6g8Bx1e4L2c5drN8j
 JH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239071; x=1778843871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39w49gZKpFRzhgKjJD0rTXzt/7rwWxh4HEQyrYnkNBo=;
 b=pjSNGuV3z+qLL+7WO0iwtIbtt5ci1qW3LphSyg5i2swiS2WlkHNYj42QM9kZkab2PL
 38pJ6Xi/VZE/TqGfCUOvE63N2sVVbczRKS4EIMuUd1/S+VaX+1xM6pICFHRLj/0quYba
 1WRPTnlN5CILX+QJRGHuUVFOI8TawgHViA28d5YWSP+4/E1Asb3GXiADErQjQXml4t5T
 R2u+U48qoPmUIDRBH8beIYIHomOnb57Cg3IMtLtELslrYcUdS0io2EGl8PYPbIo1V1Ik
 WlRqUq9GOHSG93ifkL70LaXGUw8dvPtindn87h55ZsrapCAq6Q8hWgt+tRRlQcF84BL9
 m/RA==
X-Gm-Message-State: AOJu0YzJgfnfA6cMqQweuZiymk02xRvQyGWzKCKMovWngjxXefr+sYyW
 DXMR99kwkOp+0ypVj2p8wVU9PCXAEs053M77jhJbEWskttsI4a5XHr8+
X-Gm-Gg: Acq92OEHqySFD0VUiGXrwQ8oEOmk9KXPN7knkO2OQciNWsl0C581Y/SGpIij5DTWSyW
 gOG2svejCu0KXFTwyjoVnCll4GWBkYAM9B65iYGJZDYNvcPhM4IFqHIByTL5rs80F6S8iLEX8e+
 Tgm8gfn3qZmOlGvsWzsl9jqfaqceMVLr1vH9LBikP4pDZvqmuj7Tuisd+nPRqzxhK8QN+wcBCIl
 gTZXYtJou3DZCMqcxkZQdTdd55VuOjQw2Bk7IFhpKuSF+9tmKyDTA4jsIa8npvstK8A+S3Ehfrh
 wcAr1pDaTjx1P9zruzK2zWPdFnJX5TOzVcmQjaetWFWwWOMK88aaZu9JIRsmR4QRoeh4RQH3sPk
 ghoc9+4EjHGjGZKclepb/WyU4DZIRHc7PqtaNgyVkEv60P9TErX2wZZyxprPhzW+tqDhcKIIRV2
 /obPLUPo2a3rXKUWDiC0a8iTJBaF3jUzkRG6M91zf7u/UtXey5C/90mEevduaxWERf8IaOZu3hF
 GijciDGxQOAdqtlF+k0njuukHAc0UZ3qVbZCiU80eQKBLC1
X-Received: by 2002:a05:6000:40c7:b0:448:7420:9ada with SMTP id
 ffacd0b85a97d-4515b0570fcmr17977390f8f.9.1778239070587; 
 Fri, 08 May 2026 04:17:50 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:74ae:919a:e57c:bd9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm3535563f8f.25.2026.05.08.04.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:17:50 -0700 (PDT)
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
Subject: [PATCH v2 2/4] drm: renesas: rz-du: Make DU reset control optional
 for RZ/T2H support
Date: Fri,  8 May 2026 12:17:42 +0100
Message-ID: <20260508111744.771659-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

