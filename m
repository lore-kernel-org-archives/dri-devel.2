Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E0606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWz/TTop
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C0410ED00;
	Mon, 16 Nov 2026 08:58:48 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15EC10E0C0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:02:16 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so18085415e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794812535; x=1795417335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Oar97+R2dcLaRVk0nmpwc72qymMp7EMYfC2wL31fOwU=;
 b=rWz/TTop2yT+uXTtkDD2w8SMlDshncHVRIhpxPUT0I+BjlDWN4sPIcq+LXMCW+wF8S
 T9vBGzgQ5moEx2e3fp3dHsJT5c/pz8PwXO9JLqQ5nXQaytr3GtNffv6eE9c0VAPakT5S
 ApwQ2k9UT1PQv4Sb9uJMePMJI39of1o9og9O04cGYkB5sP51YLEU/T6AwVSaK6B9fYrX
 SCAj2c8LxbpmeoL7qiQ5WH7JF70N3alWM/9AbRiFwwaY7mnCeX9xmjge7rEFYLAUCoWj
 1T86TVi70bRlkQPGZCLQ6ikClGzgJj2wxnsaAU+JEWVWH9eGPr5BkmXo7Zet+GbEKK22
 bMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794812535; x=1795417335;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oar97+R2dcLaRVk0nmpwc72qymMp7EMYfC2wL31fOwU=;
 b=lKOuCjDM79mS01zeq89KJT8oQj4/18GERbBahZlpuAlGZA7Q0thXMKmVyuG/3d84vm
 PnaGsss+i+RQkNY3TV8ZPB0YEx5bfsfoW5N4kZvKcBQxsm0DfdwgibeAVD7EEfAjLwMd
 5uezItNxNmd9+TuTB1sqDfMivRI9NxAIYGLOzSog9iHtvRRhlSoV4n+GuBoE42adEMt3
 bCa7bIZ3i/A2P3Lv1w3uHQVv+CGb4K6elc7Pfint3z41gNCWBe1an98Wu85G4ZXJAD1O
 OqzmuwrTCIsyruRFPoqG3XXYjVZD5yBm45OnF5TwxTQSmrzj0O8qttrJg0YGV9fDKFyr
 rWYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHJ8BuotRmSKdmWIgsH1JJbjwlDNIVSiiFpaeUhSM3aQR2iYzRn04e1eNiQ/IXGv8mKwjqDxbCQxm0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+f7MW2CKmrS7VOK8U5l5N3rAX/XijK7gOM1fAnssA9+T78zKpJ
 SNPtJlivbuquoC9AzEs0RDNFIhjHcHn9JwLiMxRPD44wpPXoVKgx32Ac
X-Gm-Gg: AYBFou0Wb2EEOoniwrmOP7jnbs3/k+aBQgflspelOwZqhihpVOv1RUp7L63Ou4Vk1na
 rYNqXL02z1WogdqUW8jEmzSn5o49hiCbeBU21/p+pw4F6KqujyxI8eCYYjyJI9RBIbH7zgGN1Xj
 P5iPSd960Ocuh48h+ByXjEXEwBLm1M/+/uXo3MCrLvIFA2Hy7UI069/Wcqb806L5iXUgdYgHtVX
 TXZy2CQwn1na+NksoIFF88l9aIVE1ZavEbTap34uuYnkTwmX8vPN6g4Nur877zgtDlYw0hacuLc
 oGlXbFHTrMFv68AaHFHPb/bLhPP1DlOFMl2qV29B7FkL4NUQGXsaWGY3y3W+SkT4Vzi7bLaE+st
 mMdZKCH8edKSfOrABKrOzAy9Cpyba7txAmkMT/rmDzq0jzkD+d4T5rAnQD1pjE1T9s6dOJS7GTS
 gbQhfLAveCY+O580LyvM+oLPiK5bVz+Gj9xXn7RaMg9fG29OQttJxLwQTX8sxhGO39MO6lL1qvv
 aomfVrAwy1TtDxuWBJqCaLeJFH0xeh9X9W/P9BzAb+sVLMYWmw03LOjDkmw8Qa3gZOGQeLe/M4m
 eiEAUjJIeShn
X-Received: by 2002:a05:600c:4e13:b0:4ba:38a9:85e3 with SMTP id
 5b1f17b1804b1-4bb55a47fabmr200763425e9.12.1794812535128; 
 Sun, 15 Nov 2026 23:02:15 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2538b9sm558777625e9.1.2026.11.15.23.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:02:14 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 0/2] drm/panel: add Novatek NT36525 (Samsung Galaxy XCover5)
Date: Mon, 16 Nov 2026 10:02:10 +0300
Message-ID: <20261116070212.314228-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a DRM panel driver and its DT binding for MIPI-DSI
video-mode panels based on the Novatek NT36525 controller, as fitted on
the Samsung Galaxy XCover5 (SM-G525F, Exynos850). The panel is 720x1480,
uses an active-high reset (RESX), and a DCS init sequence that mirrors
the stock Samsung bring-up. Backlight goes through drm_panel_of_backlight().

  Patch 1  dt-bindings (compatible: "samsung,xcover5-nt36525",
           "novatek,nt36525")
  Patch 2  the panel driver

Tested on a Samsung Galaxy XCover5 running 7.4-rc1 plus this series: the
panel initialises and displays correctly under phosh. checkpatch.pl and
dt_binding_check are clean (bar the usual new-file MAINTAINERS note; the
files are covered by the DRM PANEL DRIVERS wildcards).

Based on v7.4-rc1.

Tool usage
----------
This series was developed during XCover5 mainline bring-up with the help
of an AI coding assistant (Claude Code, Anthropic). The assistant converted
the vendor init stream to mipi_dsi_dcs_write_seq_multi(), drafted the driver
skeleton and the DT binding, and drafted these changelogs. I reviewed every
line, validated the binding (dt_binding_check, yamllint), tested the driver
on hardware, and take full responsibility for the contribution.
Prompt summary: "convert the XCover5 NT36525 vendor panel init into a
mainline drm_panel driver plus DT binding; keep it checkpatch- and
dt_binding_check-clean; test on the device." Review comments are welcome
and I will answer them myself.

Adil Hüsrev Tepe (2):
  dt-bindings: display: panel: add Novatek NT36525
  drm/panel: add Novatek NT36525 panel driver

 .../display/panel/novatek,nt36525.yaml        |  71 +++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36525.c | 486 ++++++++++++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36525.c

-- 
2.53.0

