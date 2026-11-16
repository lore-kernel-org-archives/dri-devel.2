Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88F606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JIJ1mKo6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E68F10EFDC;
	Mon, 16 Nov 2026 12:11:58 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06FB10EFD5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:11:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so16916255e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831111; x=1795435911; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=crdLSmlfnO7VKMZXhE1g/GIeZeZ2qlXrtngZdD7/DKk=;
 b=JIJ1mKo6k4f+rS92C4JwHbF1UCj+1uuSW9DlFmDycANYilfqs/iz5AcQRwOn+KALvP
 qcGg44viu/i/C76FS8lLh7mbpmYFurezlr2/bbO577gzl27kRbqRGfn/DLIiHX9+k1CS
 ozKpHD/ArWnCE9w6481yxZE84afW/I0oDzxD8AJerxrBVds1rKVdum41OE25KHo+k2ef
 DnJTIm7D/dOg/2sXqN66uZss6wkCdFAQnohIIA40j4auUJ//b2Y4vvpM7jtfgVTdMcRg
 s01TbpOIbM3KswalwRIoJQ8nUsa1iNg7jLj9gF4EPCIofd04O78TDd57mrC67KGLlgb7
 1jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831111; x=1795435911;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=crdLSmlfnO7VKMZXhE1g/GIeZeZ2qlXrtngZdD7/DKk=;
 b=IO1v1lfjYwimcFXIwOlqz1yCbTdbNnXMEb/ylG8EGxV0QpBKC+SFxEkYBvDXN0ZS5C
 FDRJzlvs2d14xedEqkZ7ywT/TXMCVGj20z6fycWORkZnEs7tMGcKQkRw+zZREHyQ9GOo
 pP8wbdfs7PZUz4oXOokRWBDrTA/0d5OdmvTdEKFSdgK6J+yH0iuzzBC6/qdYjKfx8MQy
 KwfbucvuG7nKb4IPdvejStMIy55Fc+gxtZlk5fI7K4O4ZD++C7a2QDbickxtWEk2DLyH
 RMFlLkcGCd6RIIhP+yegr/mq+Cj/uWZT9XVZZvep+pRB2bS0nKKPNwXxM9bftAlW3pUt
 ykhw==
X-Gm-Message-State: APuU4Z+yDax9WTtTh3c2U5gjUEzpE0X9cBWtO1CnLZoWNA+Jza5ljVek
 HJdUUBQBtnRJYPYJDYqwF2emWV2z4smpgUiKEgVeJXgR1dYrBJRRVHvQ
X-Gm-Gg: AYBFou29m2mpkAVei2mRt1Blu+CC3UU5ltaFkVtHSYUWbzI2DJEbzOyJOaWlL6A7tV0
 r8nEURJLwAAOreLqUxxHBUWn+QmBmaOOoWzWd6jAeb5BULEWiE2Q7P/SOVsUSgWMH1Tqss2d1fj
 fjr7wyt/gt/T9oRlDIGkxUyfen7lAgOKOjLVtw6sFQeCOtrNWaTcI5oedH4ZS80VGsMNYoSisvc
 E2cqISiCjkDNT5mSqY8Jg6gb1QdcTx7G4Owt+OAfCo0F/l+Ln3FV60Z8TxEqob+PRimPdgkAszq
 t6rhd4r20dDGWc7gFufUVowPbBe1bmuCGSO1jPyJkywtU12AbUKdUzUaH+7mG+vlgDMUGYbUiO1
 zQarLfP6St+CYuEuf4Ft8F5gSu1LSYIi4ag05GwmUkagCAy0fJbatPna2TKX7kLm9raglW0kOyG
 CbIjwjleC7MZdrP41pXhMpXdOdbBuavG38Cpw4ME1tCAbdg6QUsYeQ9CaSZ5Lu7eUdggKPVbIzh
 rtK9nL393XaBrSar4U2EPpwxCUsYCFgV1hFuFgahrNhsoh4D0FMBu8S4JiDDPzbgw7FcEnwPBt0
 SzlalH9chLc55vtWCh4VzsmVzaaGEVM4ZBSkwpyYHV5POjwVu0y7IE3+fUmjamDgDdKb4uuYO0D
 o0zGDEfcuT0gAkmwujYJvNKYTIN7XW2A/YIdn9/8fl6ZIPkPxkXH5oB3RxmNCBbYk6mSVkwd2
X-Received: by 2002:a7b:c009:0:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4bb55a832famr162798335e9.13.1794831111064; 
 Mon, 16 Nov 2026 04:11:51 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm61442005e9.5.2026.11.16.04.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:11:50 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 0/2] MNT Reform 2: Fix the internal panel on i.MX8MQ
Date: Mon, 16 Nov 2026 13:11:47 +0100
Message-Id: <20261116-reform2-internal-panel-v1-0-765cf8d5ff4f@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDQAwAvyI5N+BGuhW/Ij1Em7YBjZIVEWT/7
 uJxYGZOSOIqCbrqBJddky5WIDwqGP9sP0H9FAaqKYYQIrp8F58J1TZx4wlXNpmweY7ti5iHgVo
 o8Vo8Pe5x/875ArE+tEpoAAAA
X-Change-ID: 20261116-reform2-internal-panel-35c872aabb28
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The internal eDP panel of the MNT Reform 2 with the i.MX8MQ module does
not show a stable picture. There are two problems.

The panel-edp mode for the Innolux N125HCE-GN1 is a 70 Hz mode that is
not in the EDID of the panel. Patch 1 replaces it with the 60 Hz timing
from the EDID.

LCDIF underflows at 1920x1080. Patch 2 connects DCSS to the MIPI-DSI
host instead and leaves LCDIF disabled.

Patch 2 depends on patch 1. The video PLL rate in the device tree is
four times the 138.78 MHz pixel clock of the new mode.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Christian Gmeiner (2):
      drm/panel-edp: Fix Innolux N125HCE-GN1 mode
      arm64: dts: imx8mq-mnt-reform2: Drive the internal panel from DCSS

 .../boot/dts/freescale/imx8mq-mnt-reform2.dts      | 52 ++++++++++++++++++++--
 drivers/gpu/drm/panel/panel-edp.c                  | 15 ++++---
 2 files changed, 56 insertions(+), 11 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261116-reform2-internal-panel-35c872aabb28

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

