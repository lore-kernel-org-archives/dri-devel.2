Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395CCCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 06:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4897C10E169;
	Wed,  6 May 2026 06:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p1O6rkJr";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1160F10E169
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:25:49 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2b9ea536877so4186685ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778048748; x=1778653548; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7nDWMXGjrFtRUXalafYwWf9F5pGmxAL66BqMwA6cUc=;
 b=p1O6rkJrlVYSvRBz8SN/t5l4AsbzPet3hgo1C1X3zrxSeGGHcVgkXL21Di4mPf/H7d
 Tx8E9ZnT/YFTu4zgwL/8+QA0PurLJM1dzCM4z0xHXZmu1SgQDnaGkIx22mnZ7j9sSKtu
 Q2Llx9AwjHAPsRpS2D4VBCXw6W5oSjfdgZgQj7GuOjQXhApEL4TAsbQppPrv9rldXmHe
 ofnhNuJGLiSn635vRhSXtcKScHg8m558FoviDAmNeoc1LyPiTMu44WENs4eHOalMEnTA
 pp/VcILvSCeKzdy7JNfyAYZVOwf91Q3FI99oui6f3/fa00DtjYbPjTm+CytLVLJk1hc5
 KGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778048748; x=1778653548;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7nDWMXGjrFtRUXalafYwWf9F5pGmxAL66BqMwA6cUc=;
 b=aV1VOI5YYkUO2+KNu8nvXHj/sMLQ6GBmSHF/Qdf+zQEA6zU0LpXPpqLNYbyoqA4oiS
 hzmboILNvEANwstT2snrRASjCdoae6Ln1dCfqdPjvvJBusBGjRu5ptfKv/CimrPCHWxq
 cfp6MTzHnczjvIybW77kEnJJqFO1hkBR11pk/PIRrewrx8xHpUQTzqWvaGbQTG9Fs5xX
 2k3q3cMuzZIYkHRKu5WvGcIfIXEscpXC8lqIavemnN6MivrdLpbJvdAvpe7SjnVVvv94
 XLT6+UgxeZw8CHKR9Snbz+whCDvjzYLxlJjGa7oA0pEEiwfIfb46gdSVG98AlD4FX5M2
 gyHQ==
X-Gm-Message-State: AOJu0Yy91YSa/q8yxxtgWOvoIhpmf5E0ifkmf35Eavqbh0sS6BHGZA7h
 XsyTW8rAVeMVLGkv7ymuDNICvcNfb+eDHwu2lN44S7mZZpM79uxbugwC
X-Gm-Gg: AeBDiet86RrJf6wkk7e5UxL/plWQzcroLorSxofYzz0wguLHfENPhmNs9ZVvHQw/oNm
 riu1gqC65lb7unbi4GzRs0i48eRfGFvjdpdMgta1P3M7V30l/FHbM0c7IQEekQSYnjeHwotpRsU
 DaCus0YIhaVU/8Z5JHdJZQNaBeXJE0mGUKG1Mz9N49ErY0lMldO6XxJv/MNIN67zerXQwhWhSQd
 6/ggetTz+8uN6vr1v5e+6nIifpg2Jb39RN+j8QFMy6ydzgJVx/48p4J6mFcO22YES1/xqgt+jCR
 1c/GOyxnDYb57H3B1BHv9XlweUQqRqASoG+WhL/9/CJQWBWI3vVs2zJGRj1XXRnUb3TECGVPQyV
 erVppq97ctw12L/Pe92YtJMGkx4U/9sbK26/utX9JMPeeRmBMKZU5T+BeM4xn0wK8Zo79Wg1fpO
 Tt5vSTGiZE4ceA+4lAWp2r8CCWtoLUVnSrfJGDQ0SpWvA9yCoxrSZA94GcdpufcuXd4viPSYDxw
 3+FbXuIemOjMrRv8q72WQ==
X-Received: by 2002:a17:902:ea12:b0:2ba:6601:8e3d with SMTP id
 d9443c01a7336-2ba6601985emr33306655ad.9.1778048748474; 
 Tue, 05 May 2026 23:25:48 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7bd2ab2esm16330865ad.4.2026.05.05.23.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 23:25:47 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH 0/2] Add support for PIXPAPER 4.26 monochrome e-ink panel
Date: Wed, 06 May 2026 14:25:36 +0800
Message-Id: <20260506-bar-v1-0-12195406f4ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODe+mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNT3aTEIl1TI+M0o2TjNDNLY0sloMqCotS0zAqwKdGxtbUA6yhOo1U
 AAAA=
X-Change-ID: 20260505-bar-523f2c3f6939
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778048746; l=1346;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=UjBqsNiiU9KCI7HYTN7euFjJJz+PKYjeOpuER7dUuqI=;
 b=4INSpmJ7FzhpAQwBk4GPstZZDtDnhd0yDSWfXPYdhLBJo9n1mxDzQpjOu97rFTpLPeUsFJ+s/
 n5yNe4ibHVBAjeVhs/oaJAsXjoX4FJyR8TGqG12JEwU/nASNPHzDri5
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

This patch series adds support for the Mayqueen Pixpaper 4.26
monochrome e-ink display panel, controlled via SPI.

The series includes:
- Device tree binding updates for the Pixpaper 4.26 panel
- A DRM tiny driver implementation for the Pixpaper 4.26 panel
- A MAINTAINERS update for the Pixpaper DRM drivers and binding

The panel supports 800x480 resolution with XRGB8888 framebuffer
input and uses SPI, along with GPIO lines for reset, busy, and
data/command control.

The driver has been tested on:
- Raspberry Pi 5
with Linux kernel 7.1.0-rc1.

Feedback is welcome.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
LiangCheng Wang (2):
      dt-bindings: display: mayqueen,pixpaper: add pixpaper-426m
      drm/tiny: add support for PIXPAPER 4.26 monochrome e-ink panel

 .../bindings/display/mayqueen,pixpaper.yaml        |  25 +-
 MAINTAINERS                                        |   3 +-
 drivers/gpu/drm/tiny/Kconfig                       |  15 +
 drivers/gpu/drm/tiny/Makefile                      |   1 +
 drivers/gpu/drm/tiny/pixpaper-426m.c               | 828 +++++++++++++++++++++
 5 files changed, 866 insertions(+), 6 deletions(-)
---
base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
change-id: 20260505-bar-523f2c3f6939

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>

