Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A40F8E4AF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C31910E96A;
	Fri, 17 Apr 2026 06:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MbSWpLLP";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA0A10E95F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:50:04 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a0ff30b240so441150e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776408603; x=1777013403; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PV5yIQv/6bTdgVUZVXXsO9kP+vu/b8exNKt22mhgJ3E=;
 b=MbSWpLLPU99oujLFuGw6aeJCD0f8ylx1snmnFKlFhtHMzLBz1tSpIXaL919CTw1R4z
 Cgbd4mPoGMq7M6MT5sLj5iH4QbCFRkSo0vm4ha+jHkFDyrlBE2awejL9JeaZvAjw9STQ
 aFnwMGzOhfbECrkoK+pMKfZyNpFyVzXmviDCxvmIB2NLJnqGmQTRDKhdZR8CcXBTzPdq
 KWitlkFy0/ARAy4u2tWwDtNBkld5Ulk/qSmsE9GmOACLwEpUXrrmq4QaCQz8iigWvIcv
 OIfzCEsgtnqPjk1KjFBiz4B4nl938eMbFksjAoD0Lwa4g8dujMPFweKpbX7LsBmrztvs
 3ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776408603; x=1777013403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV5yIQv/6bTdgVUZVXXsO9kP+vu/b8exNKt22mhgJ3E=;
 b=dLjDW+q8NzZyI95w/iAwoW1UWuBPWijOYYf6L3Nuy0p7dB7pP64Qz8yQmJFm12ofEP
 feuRXiKFe3YCImejJXzw35Mk7aXdSS2rHP1eErkNiiuZxSnjg613s7A8FR5Vvgb3PIYf
 mS+8SbziWBHhH2dwR0dro9BHLdOMFhK7IRMzlWXnXM/K38oXAPIAeXXQ6CVE+bU05kWO
 RH+lORSNY0l9Rj17IUzNPZCU9XBcvXoCAYNI5bOZB0PuRwGmigQKsgSclqUstpw1DnZC
 G9eK4+eYXO6PQTF/SmsQGg3/XQgLAY/d6PyFKoduLnIWERrMCn6yfD1NaA/ArtmILMQ1
 89dQ==
X-Gm-Message-State: AOJu0YyvXeuFY7tmdA0+xJg3zznADe2tylbOTbxIA6UtQuusgIWQLJEF
 UcSPDjyvW1p4AE20HeDTUXqgnz+xVuQhx2zhj31qa2RhJsYNTLCvzA8t
X-Gm-Gg: AeBDiet8huvrtDMC0mtZkY7veCISolnXgHVKdxKa/dAfmlKbWSkeklu5woL6z7sYNZf
 Sv9IzAHpCKwQclyuJpttHjt8IuxoJ6vtAYopOTRRExYypA8VL1tud4xckZ//tew70Rs7CHn7Eb7
 20QC7eDXzpV/qjtEgAF/GNReSghKkLekVNTPKqQ5ozgU0ekV4t6CFByw3YhlmIJDCP7MXpJP1+1
 +ign6u2L5MWGpiLtOIoZWdDHZb1CfJ6QQGzaczH1Zxr+uHvFlAZ9hXeEgFMoIrDTV9MbIzmnGiC
 +xqsHXs6iG8d2jNNKBMagWMcEICantMf5uYCTRaa29W3ucBthXq54zVeJzDhFoCrXYdtqp8LSUr
 I5JLrZHFFNXKP6fJc1OvN0HNYleLAYdAvkba6llgY/qgXPjBaGE6SZVP9uCtxOg7dcev0GUMQDB
 z53kg9wBWd84+aQkwW4tAveyYZszA2pGD7Vg==
X-Received: by 2002:a05:6512:124d:b0:5a4:b2d:25c2 with SMTP id
 2adb3069b0e04-5a4172dd846mr452741e87.27.1776408602436; 
 Thu, 16 Apr 2026 23:50:02 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad143sm153202e87.7.2026.04.16.23.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:50:02 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3 RESEND] drm: bridge: add support for Triple 10-BIT
Date: Fri, 17 Apr 2026 09:49:50 +0300
Message-ID: <20260417064953.20511-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Triple 10-BIT LVDS Transmitter is used in Microsoft Surface RT and
MStar TSUMU88ADT3-LF-1 HDMI bridge is used in ASUS Transformer AiO
P1801-T.

Link to v3: https://lore.kernel.org/lkml/20250824092728.105643-1-clamor95@gmail.com/

---
Changes on switching from v3 to v4:
- rebased on top of v7.0

Changes on switching from v2 to v3:
- place mstar,tsumu88adt3-lf-1 alphabetically
- fix typos

Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
---

David Heidelberg (1):
  dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS
    Transmitter

Maxim Schwalm (1):
  drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1

Svyatoslav Ryhel (1):
  dt-bindigs: display: extend the simple bridge with MStar
    TSUMU88ADT3-LF-1 bridge

 .../devicetree/bindings/display/bridge/lvds-codec.yaml       | 1 +
 .../devicetree/bindings/display/bridge/simple-bridge.yaml    | 1 +
 drivers/gpu/drm/bridge/simple-bridge.c                       | 5 +++++
 3 files changed, 7 insertions(+)

-- 
2.51.0

