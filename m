Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940AACD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 08:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E078410E3D7;
	Mon,  4 May 2026 08:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dqueMUTI";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD2F10E3D7
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 08:02:12 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so346798f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777881731; x=1778486531; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rg5udYoZeehjUQryzul1N4fTdsRztvPb50rKAHLeaoE=;
 b=dqueMUTIkxCAFmuPQC3fF4sf6W9h/HdCga3wmR7wZMf1xLs966jhhaVVn8dIAGyQ8Z
 sM0mjuQtyUe4wmGwAcDqYblW/sEvRAQwKcoixjwsdDCM3Q0D659WeLfdxKQ1ctRq1R1V
 NhgMOrS7WoTXWqbrC8oG1wTpr3iltNpqHdWPkV0PMp6IjSMYwRFkuFG9RZtfH/+CUTOF
 G4cZ8DK4OouxrJTI9s3U7Ng6ZbwTJEgfLp/xbUo65mjmEKT4Y0rzVOg3VUrbju0YMn4s
 7UNrYjaM17y1hVqkRNnrCjA9vJkavseG8/bhlSYvONLg03cuEx5waqCRivAZR+u5FE67
 K88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777881731; x=1778486531;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rg5udYoZeehjUQryzul1N4fTdsRztvPb50rKAHLeaoE=;
 b=nG1l61GKQqSIBONmE0LVcv/5c5fM3rg9+uDHKuOwWW25PEn61PgXw0SUrOXCcXjLZm
 5i1mohuQTJAgDb+BiXr5JVdPkAK/pSHN0SVe9KJx4tDjQIbB6bCEtVfToT+C+pzM7umz
 IRWSk7CY3zXqgCGx4HClj3g7IkGfVjWaDpSPHlVGbhGjM2cmtsAofJ076hWjarpk0Ywz
 E8CSxpJSFGKx/dW1kBkA62mBSF6xUaIAiVPRo4bFlVqi/etHwAK7BCaBiFguHjYS6i53
 7oNBaJE1vDqoU4475Dfaq2JWI/tKjsxd483pYbVGtUjZlDJd6xH9cZ5mtlC3cZ9O8lq5
 YQSw==
X-Gm-Message-State: AOJu0YyXc1FtxOpiEEcK8TDp3pzposL60VZdt9E20pIa75TqDNXvsnAw
 OFz7L+f0Rt/+Ld5nUtrLSLq6SSa55TMKytIS668aqicv4cTxvhJ0MBlo7m6rNoxj7ig=
X-Gm-Gg: AeBDieubY3ktah5Gcw3NvlwHnnJJ+ATZOhFUCrTIdMz7QqygyvDhaWvDTfBCgiVZVX9
 Zj8D8/XFsqADVds4ELBS46HqBVaMpq52Tz07U6yF2F0oMdf0mfAZXKszBgEzb8pMVKLmEsICJYv
 sqvGZFlnom1ONR25bb+OYAaQp919sRtqVdpQfHhy4V+CTqMycMgg7yc+MX47Q0ye1AQG7j+M+Q6
 nr7Bnm2Ex78f8T4+hp2JixLkHT984LBV4jQJq/xXmV51Hnz7MKBVestM5yXOnr/4Rai8HpwN909
 chjImTTOcWWtrOuRV1B7og6xJ+WoX/oyePzI0ffVDcu4EPvFMhREoUDg8d06J3T4fXwYT1m8a32
 jj3R73lZLm38fgygc3Oy7w1V35afREOQSLsyCsfVeI2eofCuCksL30HTHgiiTrMFkJZei0+OI6z
 JBLmF08+uRt4M+8RLeReTTMvBKDQzGbhH8yVyaDkDD9gVb0qysODzT3YM=
X-Received: by 2002:a05:6000:440c:b0:43f:df55:fe5e with SMTP id
 ffacd0b85a97d-4494aad7a40mr17780464f8f.0.1777881730057; 
 Mon, 04 May 2026 01:02:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981defb3sm32255216f8f.20.2026.05.04.01.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 01:02:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Mon, 04 May 2026 10:02:04 +0200
Message-Id: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1S+GkC/5WOyw6CMBBFf4V07Zi2lJcr/8O4KGWA+mhJi0RC+
 Hdb3OhOk9mc5OacWYhHp9GTQ7IQh5P22poA6S4hqpemQ9BNYMIpz6ngJYx20Ar8vcwzCnKWBi0
 MVl1xBM/B5algFWDBRV4gb2rakqAaHLb6uWVO5zf7R31BNUZ3XPTaj9bN2x8Ti7s/kxMDClXJs
 M5kuIwdb9pIZ/fWdSQ2J/5hTemPVh6tTCpGRZY2VH1Z13V9AUR6s6BBAQAA
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JaQLph1fDFoND2GO0hCL4fd2O6UsqhltUs4hWnc5M5I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp+FJ/GtTpEfBWK/iVdg99R5G8MciUcSEu9ztDdWnn
 JBoNdUmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafhSfwAKCRB33NvayMhJ0Te8D/
 416er81uookd+JqHcJ1mDZw/9ZVUHbRTK1DxF/opxsUlpRtaeOWQhloEJ1h2th2A6t5ZWH1UVIJ+51
 PpS81eccdEL+2+XKBJi3MkyQCCznSHLyA2sOPct0dD6J68ShRR9Aox2kygusVBtyeo6myM/7PBE7PY
 umXlnSsjYkR4pkFOR7k8XSStrNlK5gzmZvXdgd2wgFav6qwSinlKksqGy0uLxOqeueDBaipUGVimeN
 NpMYeXE3sJW2AV0x+w/MYbatsj3DZdJh7w9jYYd1x/9HL7oxkDtndWL1Ov6MWD9WSPZ3EhJ0bLqEAG
 IyqpEC7oOPOyPOnySiq8YoJwjBKMNMFfEmAoB+grcNGycR+rReRrgh0SztHk/HsJAJ0/V61xXpzMGa
 NpPUgLz41Q6+S5JLvlv9LMqlax5Y/c35FnxhwQG0uN6SP9erV17UquIi4+SbZ+6QStZvrvKmZJ9RVw
 oC61mXlhcRGJ77dkHLJPHpMGxMBTxTQCyOiXl4FUBqOa424ikqUmEG8QEfzu/Vt36OZjEmRiw28hOy
 +m3KfzhMhA2H17Zkdcofma2AAY4bbFa4MuxHDX3xIBjF64+Em36zcUqiUWg4Dpwd/YhVwD9lBbvbYZ
 D6AcDSavs1aATRCxMWSUZ+ayuJ4tyCjVeDGM+LEZzMZxkYF1wkA43WNZRNEQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add support for the Renesas 63419 based dual-DSI video mode
Display Panels found in the Ayaneo gaming handled devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Added DDIC compatible as fallback
- Added rotation in bindings example
- Fixed bindings subject
- Added second MODULE_AUTHOR entry and re-ordered signed-off-by order
- Link to v2: https://patch.msgid.link/20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org

Changes in v2:
- Add missing rotation property into bindings
- Fix commit message & subject typos
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org

---
KancyJoe (1):
      drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels

Neil Armstrong (1):
      dt-bindings: display: panel: document the Renesas R63419 based dual-DSI video mode Display Panels

 .../bindings/display/panel/renesas,r63419.yaml     |  97 ++++++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 357 +++++++++++++++++++++
 4 files changed, 467 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

