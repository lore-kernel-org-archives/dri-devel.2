Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D24FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F3F10EE4E;
	Wed, 29 Apr 2026 04:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Fax20U4O";
	dkim-atps=neutral
Received: from mail-oo1-f104.google.com (mail-oo1-f104.google.com
 [209.85.161.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4944F10EE3E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:15:36 +0000 (UTC)
Received: by mail-oo1-f104.google.com with SMTP id
 006d021491bc7-6966e1a0b91so35835eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777436135; x=1778040935; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FtGPxykfSJnjMbp7TJp87gUGFkeGywBatbMxDcRE/PA=;
 b=Fax20U4Ouj7gKTO5KOP0Ig9qEXvDpddkNGQ1pgodM6/i6dF5Uw8NYOL+jGMM5xSpCm
 ygqFmxv67Bmotu/BlQ/MPzP9tfgkSmc3yNERxcTiGWYCjE9gE/yXPsUXMCL5ziJn6WZz
 d3O4LjX6qp7N4zOE/lqYPo6BIHBJv/s4bzq53gkndarfR+mdiiD22QA8d8hlxBjJRq3j
 SSIyCMnv2Cc6tK/NXLKcgqHQ2GDP/XlFGkPBkfoy3rzhkgsPdVI403LEbIgIFvm/gOMJ
 902bZzEdaIe8aO1InYKZzaXURiUeS3WZ2/iM+5Ka145pjR7nc+i2k9bI6UJmVerfbXIw
 UXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777436135; x=1778040935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtGPxykfSJnjMbp7TJp87gUGFkeGywBatbMxDcRE/PA=;
 b=nWgf038768V5Q0bWDTVi92qLdSr6FWrsILYE9q14xFeXtpBjBUe5mJ9fLKAuDCyRIX
 T0wTxHTwSZfGVKF+8CnAjoA79+YJ69lg6J71a9rOMuAb7zfej7lHOtGxBNkHkI/7WaDy
 klXSbcbgB+FMacU5NBlkbxpJBdvJ+nKCnNJL7P03X0qrtpNKJrdlqshHaQ/g5fR4H0g4
 9s7cuPo0VU/yc33JYhPGIoSBpRfhBDkyvpzNyeyNAS9+BCJoDkWeUmlCjjp1Makzb3Rx
 R4DisuHXTWW358BLkQdNTkdbFh+C+iufsH1ML7wWcrPl1fJndiuC4f1qlRkcPD5cnCsr
 Skpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AmOJsTmA94UAPzm4dlZ1IIgX7rzjUyU1vfnjRTlEyO6pLhAQcz9ZMFD3TSsI63nt9jNH31diE5wc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUPmb+WPjSoQvtctq9PsrBF4Uv5V5Ici3tBNvEYZ3z3/Q/JS4T
 gsS1gmC8p62TGqdTmKIBqZ0ui/XGrMvt9mwPtryrWVWmqMIOG2O+lyVoC1AzceS3PPt+0/abfKh
 m9Zp2/Tyt7pedKrerdtl5dWKv0B5Z/0rreWgF
X-Gm-Gg: AeBDiev7nF4aSbY6bpFTetrPPZwHvFvsOXx04Zpc2znJKlE7C0/8Kr1eprZU4zzhF8V
 SiWMUBWCpxelJZCFYxLbXjk2EPNGzU/Itv1vDXcnKV622SvezbLztNryYl+LezXPYLdteuivSPx
 XhI6OEME3KUIb/BJLvfYCvBy6vEIN5C3Fs8SPCPExsmyLEneGwehPtM8YidBi1T3bDiHLmknHw0
 d7IA855I6uZLQT85RyAH29jucIfUR9h4lUZCYyrAU81odc6vQAzSk5/6Y8VVXwUKp+NWfZfp3Ys
 u7zzcLQ5cUTIEt5u4LcOSmgVMaetITKGEq5cQp3cjvD9MtIxZC3S3Z///rzxa/ubuasEs58H+lQ
 c2jdA55aNn8he+39kx9b0K2lZx1jDvwWe9LDzJP7J6dczeF/pfRMoZt8=
X-Received: by 2002:a05:6820:1987:b0:694:926b:551 with SMTP id
 006d021491bc7-69668520ec9mr1220128eaf.55.1777436135405; 
 Tue, 28 Apr 2026 21:15:35 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6966baf952asm41557eaf.9.2026.04.28.21.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:15:35 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH 0/3] drm/bridge: Add Lontium LT8711UXD DP-to-HDMI transparent
 bridge
Date: Tue, 28 Apr 2026 23:15:25 -0500
Message-ID: <20260429041528.558254-1-dennis@ausil.us>
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

The Lontium LT8711UXD supports two modes of operation: autonomous mode,
where it configures itself via strapping resistors, and I2C-controlled
mode. Review of the earlier Orange Pi 5 Pro series raised the question
of how a future board requiring I2C control should be handled, a second
compatible with a driver or we make both work with a single compatible

This patch set covers autonomous mode only. On the Orange Pi 5 Pro,
resistors R9, R17, and R27 are unpopulated, which straps MODE_SEL low
leaving the device invisible on the I2C bus; I2C control is not enabled
on this board.

The earlier review thread is at:
https://lore.kernel.org/linux-devicetree/20260425031011.2529364-4-dennis@ausil.us/

One non-obvious detail in the DTS patch: vcc3v3_dp carries
regulator-always-on because simple-bridge only fires pre_enable once a
modeset starts, but no modeset will start until the connector reports
connected, and the connector won't report connected until HPD asserts,
and HPD won't assert until the bridge is powered. Holding the enable
line high from boot breaks this deadlock.

Tested on Orange Pi 5 Pro with Linux 7.0: HPD asserts, EDID reads,
link trains, and scanout reaches the display.

Please take a look.

Thank you,

Dennis Gilmore

Dennis Gilmore (3):
  dt-bindings: display: bridge: simple: document the Lontium LT8711UXD
    DP-to-HDMI bridge
  drm/bridge: simple: Add the Lontium LT8711UXD DP-to-HDMI bridge
  arm64: dts: rockchip: orangepi-5-pro: Add LT8711UXD DP-to-HDMI bridge

 .../display/bridge/simple-bridge.yaml         |  1 +
 .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 88 ++++++++++++++++++-
 drivers/gpu/drm/bridge/simple-bridge.c        |  5 ++
 3 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.54.0

