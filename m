Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE669C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CCD10E077;
	Thu,  9 Jul 2026 14:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHB61/uV";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5620E10E077
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:30:30 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8484f229529so1322702b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783607430; x=1784212230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMvpv3Bx6FDuVBz3Fx9UC3bZbRQXohaKI0IUh1fx6aI=;
 b=jHB61/uVYXrwKPEPzVEHQaifTMfdVdLiT6U8b2Cicy6qHJ1NlmWCOrhiU87SJs6nV6
 36nrDI9LIhgXUaD2FDz+FONtdAjWiH0ZFel9IIKzPDz/VvA9hnCQlUvPLKGyD3AvJrvB
 b8rSu9y/U4/sveuhRDjrFl1mrAw/4p3CahLecq7N98DMtP3Wk7uucCs+/aR+/SiDTv52
 EQA+DqpRDcJVl1cPMXHoBq3FjcUKGWw2WpD2DjfvBQPNNhQJO9oPEpbVO9nhuNUuk/ID
 m2GzDT0q7kdFIRfREjRh8GrLUxVEN1eNXYkyT3PeMyGs7aHdYH1AjN1uVsPzShjOjyiO
 zncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607430; x=1784212230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMvpv3Bx6FDuVBz3Fx9UC3bZbRQXohaKI0IUh1fx6aI=;
 b=Qg0kXsKngVJ/9LlrQPTPQ1H+wmEh0+LSb86BJNf9nEiK9bePwzAEwjii3wCzPvVbjO
 MBTw9P0Mo1vG7GAPrXpiIF6CYMViDV+LqlWPgwK86xv/F8PYJv6qbdXAheffZpd+ZYjf
 CHtT1XDkJLE/bwnM1+aDnEq08Cdby96XI96UtXBXLYrBnvlahwqGpRwrIHb681zPu7fR
 Kb6EUpIG0advNdIzykU09K6WHCA+bQRfGJgDCoWIi1HMkgLRR3whJZDsYJDoD/OyI1W4
 Vht/tIIO81dLAShC7U/Al6z9TK16I9hWlAyEpRbq9j8Fb0FpEvpAx4AUo9T69JJ2yl6w
 x54g==
X-Gm-Message-State: AOJu0YxmJJQHvxZORAcKAHzHT58PS/bh9pvsATiZ4+I0w2ZpIGVkBQsw
 Sn4b31VMgsSHrHJNPAmEwWESsftNsvXqootOHPSwVDAOJ5S5a02juxan
X-Gm-Gg: AfdE7ckr3n3jVRRHPXBkIY3Nct6DKvJBEVm0UOtA9g+CXBjAtJ7X6cKCvs3LSyk/ahq
 v0pJpIX5eOrlwhP4P0iCD9qPhZ4ji6mhbEzsDU6+PuoDU1SfiTErNrUMf0bul7yPD+U31l3sk6B
 Nx1aXPwLCFSca81wU/qwPAKBnb1XFDUElGeioGbaS6HVQ4PQPjVdi7oPNz7UtxGsCl5XfBNCTrs
 EW6f6ZiRt5EAF7v6l50BBX7qbXBiZYIbmIOhD6PtPjMubnE9HmwdIMV11Xr5xBZg94obkFKQIRC
 WClODXDKIpjSzvsnoT7/TZkg83yNtMU5jU4a1h2TaBuAIBx31V+p3ogY+sg3BI3ibwp84Qb+ldg
 kmE0KP2rK70Tc2zcw0xDxUwYyJVJkK7aOSpQclczJ4X8ctvEWbx24qpY/1MkEaojtk0QgWbBRdM
 Vs8+j7y9h+PY2as/Jk4g4eGYvbdn1HjLeRBdPd1Ts=
X-Received: by 2002:a05:6a00:14d5:b0:847:8f68:e8d7 with SMTP id
 d2e1a72fcca58-84842eb8303mr7103567b3a.8.1783607429602; 
 Thu, 09 Jul 2026 07:30:29 -0700 (PDT)
Received: from nuvole ([144.202.86.13]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca79aff904dsm2009666a12.6.2026.07.09.07.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:30:28 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v3 0/2] drm/panel: Add Novatek NT36536 panel driver
Date: Thu,  9 Jul 2026 22:28:44 +0800
Message-ID: <20260709142846.12463-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Add a driver for panels using the Novatek NT36536 Display Driver IC,
including support for the CSOT PP8807HB1-1, a dual-link 10-bit panel
found in LENOVO Legion Y700 Gen4.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v3:
- Only include needed device-id headers (Uwe)
- Link to v2: https://lore.kernel.org/dri-devel/20260705153515.46147-1-mitltlatltl@gmail.com
Changes in v2:
- Collect tags
- Mention the CSOT PP8807HB1-1 is a dual-link panel (Krzysztof)
- Use devm_drm_panel_add() (Neil)
- Link to v1: https://lore.kernel.org/dri-devel/20260630023439.248861-1-mitltlatltl@gmail.com

Pengyu Luo (2):
  dt-bindings: display: panel: Add Novatek NT36536
  drm/panel: Add Novatek NT36536 panel driver

 .../display/panel/novatek,nt36536.yaml        |  91 ++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36536.c | 488 ++++++++++++++++++
 4 files changed, 591 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36536.c

-- 
2.54.0

