Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D12CD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0EE10E0B6;
	Sat,  9 May 2026 19:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KjuJ/OGo";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CA710E0B6
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:21 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891f625344so30112115e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353220; x=1778958020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xJOgLdtwku62ymp2K2MnoFiWaCIU8dOodRBTGK0ZfaI=;
 b=KjuJ/OGoftgFiQaceXuokZIp623pjMHcMtNPjHYJUOHGE9ju4tGAvLgasV3kvCdx5r
 96tAvkQSGeH6dXB2QED8dADbNJmJHzU24hx7MARhv0c9loLXWTAhixdbVNOful1GCOkO
 nweOM4zVeztEv74lGd5nWDY/0J2I1hxFUSJAaidJ2Eo0aW2LTojL54M2i54BJuY3XWE0
 YfuWx8zLo3APSn5XGCifQu0MIvD/diBJbBsy7xeUPofetDeyOi3XP63mgGbyFJq7aIhb
 2B1qNqzQRrxrqNxVkRlv2fnf9amROAuo6LxceriIUXwVRcd87mJP5GJo6wcEaM3pSn5t
 euIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353220; x=1778958020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJOgLdtwku62ymp2K2MnoFiWaCIU8dOodRBTGK0ZfaI=;
 b=XIpWZgObZ2z30jlWs6U3ebQ9AxYLszVYXvIcbtBjvFzOISh47AAxGiaynD7Ic3WzCy
 gjZXcpYx46LjtQ6GHu3we4SSQhsVc26aQUln+WmHtdTBzFJxz/L7DiZrPuqZWIl7WHo/
 bTtSNBpNGJAumSVvaOuwZ/uiDFYOoDaoiWRlZj+0sp+JaA+qXGsRZGXYFvRzp0sA29qx
 qCUFbayNba8zwukkg6b2w6MG3u+A16SPtQsxonicaG1gJ9osV3Cyxn1ykR3XZQWp3jJr
 4OJTPWDNUoArrHsu0MO7WMqTqre9EmegS+LRIGNryt3w+cNLJjsfr8If6W7rA2ICVr3m
 JWiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JolflN9ngILeRKp9D+u0FbKweH1kpjEwMxqsmkKZ3W/SwNhdnftq2hjKweeAqUzMIDuAWxlSgtFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4vg2TbCW0JvTWXPc1pJ7oawAzk5HaLcoB1Zmqd/eLaifX8l3J
 mNpDWGEUnBDHeYpIesIC27tlvtJ+e8u+FGubchf/NA9OCpRWSBtNSntE
X-Gm-Gg: Acq92OH9q+EpIFj1b2RElRnS2FMJZHcrDcM3thLy0cNHM1JT+iQIo0mjigSN4QrhRAY
 WGAyU34Ve4mJYtX65YN8HBdo6bYXSPTgDHS45rNSrSElaU2m0Dv4HmYTFetGFgfyNr4zIbE7uya
 jAud3sQ7VoY7E/l+WDrBJgVonu9Oz1pGe4Z9JedZUnNzOjb9CI9WO6AHgP67r+qoj/PmRpW4cUI
 As1upeI5B5M3s0YNwIEPS3GYUNS1TKwy8fAOlFU1gtUPOOdsNb5MGFVUrdV248uKB9ZA9qrmc/e
 XqekHlwlt2ixo5E7sr5wVm0Nu1C/P5BUh60mEzDHwRos60HMihkhDZwok9RS/pKb8B8Vr6uA9R7
 bJGhBfYhys/6+REbd+0bwvKG8jiPawH037f2c1ieqeyuDh3f0pEsbsmvvGgQHEuMcQjhyXyza8+
 GfGb4sTNJexPRi2na3H7eHkA3b5E6rJiW2dWJxR2DFummpOalVG0z9Wx/dEAu5E3AdRYs=
X-Received: by 2002:a05:600c:3b20:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-48e5dfcd4a9mr171071145e9.3.1778353220094; 
 Sat, 09 May 2026 12:00:20 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:19 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
X-Google-Original-From: Jernej Skrabec <jernej.skrabec@siol.net>
To: wens@csie.org,
	samuel@sholland.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 jernej.skrabec@gmail.com, Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2 0/8] drm/sun4i: update DE33 support
Date: Sat,  9 May 2026 21:00:07 +0200
Message-ID: <20260509190015.79086-1-jernej.skrabec@siol.net>
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

This is second series out of tree which aims at properly introducing
support for H616 Display Engine 3.3. Previous series [1] reorganized
driver so proper DE33 support can be easily implemented.

H616 DE33 support was actually introduced a while back, but it was done
without fully understanding hardware design. Fortunately, no user of
H616 DE33 binding was introduced, so we have a chance to update bindings
and introduce proper DE33 support. Issue with existing binding is that it
considers planes as resource which is hardwired to each mixer as it was
done on older Display Engine generations (DE3 and lower). That is not the
case anymore. This series introduces new driver for planes management,
which allows doing proper plane assignments.

Remaining patches, which introduce all the missing bits to fully support
display pipeline on H616 SoC, will be sent once this series is merged.
WIP patches, which can be used for testing purposes, can be found at [2].

Please take a look.

Best regards,
Jernej

Link to v1: https://lore.kernel.org/linux-sunxi/20251115141347.13087-1-jernej.skrabec@gmail.com/

[1] https://lore.kernel.org/linux-sunxi/20251104180942.61538-1-jernej.skrabec@gmail.com/T/#t
[2] https://github.com/jernejsk/linux-1/commits/sun4i-drm-refactor/

Jernej Skrabec (8):
  clk: sunxi-ng: de2: Fix Display Engine 3.3 definitions
  clk: sunxi-ng: de2: Export register regmap for DE33
  drm/sun4i: Add support for DE33 CSC
  drm/sun4i: vi_layer: Limit formats for DE33
  dt-bindings: display: allwinner: Add DE33 planes
  drm/sun4i: Add planes driver
  dt-bindings: display: allwinner: Split H616 DE33 layer reg space
  drm/sun4i: switch DE33 to new bindings

 .../allwinner,sun50i-h616-de33-planes.yaml    |  46 ++++
 .../allwinner,sun8i-a83t-de2-mixer.yaml       |  16 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  87 +++++++-
 drivers/gpu/drm/sun4i/Makefile                |   3 +-
 drivers/gpu/drm/sun4i/sun50i_planes.c         | 201 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun50i_planes.h         |  41 ++++
 drivers/gpu/drm/sun4i/sun8i_csc.c             |  71 +++++++
 drivers/gpu/drm/sun4i/sun8i_csc.h             |   5 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c           | 131 ++++++------
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  10 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  40 +++-
 11 files changed, 567 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.c
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.h

-- 
2.54.0

