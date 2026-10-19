Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF93606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cracqh0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA9B10F325;
	Tue, 20 Oct 2026 07:37:02 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB7910E9AF
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:20:30 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-170135e43c7so592270c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792405229; x=1793010029; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zL01sBFtwzYNtBLBNOJogTgRcd3XXRxHUdSzNtaNMhk=;
 b=cracqh0mfr4NjOv+VEDLKrcnjIgrKBy5/zsRHL5NYQfGSS6/AUALKz1yXnD30+A902
 vUx2i1dwA58JIR3DNexLxHESj6uDHmK6qFdKu4/rAk71HOEzpyCNfCJ3kRoCRVkdYZKl
 IpOlamE5c0ruGYfRSbLD2RT68jJvmwI80xkR63jpgHnUw4YARnFrduEJ3Fpd7RgcCGaO
 FU5hNBb8hxd3WpObheJ9aOFR9UBDhv4U8tQKzfD4fvhE/1SHLoaIHzEoBFpTO43Q4UTg
 f7pGvqC64kueI3xL5Jvq+lPBvYos+1v1HEYHHkzt12lGPFRUPweVAE6q01nrhOKpFWMN
 I6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405229; x=1793010029;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zL01sBFtwzYNtBLBNOJogTgRcd3XXRxHUdSzNtaNMhk=;
 b=bDy2QY9bFE0MpQOzky+ufLuGq07niWG4C2uQdoyNNQSYVxvg7llTbNpkbaSSCMqAmG
 kQZRi3imObKIQigY5fLWyovLX3JdYjrzcyimEVSf8tDdNjEuYS2cgshk9ndAh94L/zZw
 RW/bD2XiT1qdJf4H7+oRGigrt7EOsS4PK4iyTJAhVRScrcA1HUoL2O+WZk+IbXFqCBP6
 FVtpKKMCrZ/enr75AI7POWTk1Cle2/jh34aIo4/Lpiqkk/lOQe8EE7eeK6b+EjVjiOgf
 ZVKsbR0KDOtNnMgWhlRBqyGn/O2VFvL+byMaitVGCoCT6HR2//dd6UozBqflEGZV4wUe
 m7/g==
X-Gm-Message-State: AFq9FYL4KmTU2243xMMC2x6F+Rptcnj/acxWe54BukqjNfIYOa2NR4bl
 6+iJeH/PdSP48fetZseLjY+W8apLMSyBHl3hPrgaJa31WCfDXyclOkeC
X-Gm-Gg: AYBFou1gMmuNf/U9RqyUhfws4PqHchVSSewGeEFYunzBuRKOy60g5d7gGAVTQ/bWOhA
 OqcQsZQnTY8CsSbO+N6MDw+CKPe1kWrEoib1BO1arqWOYiMIn2phjWnA53Cbs0M1dDSqwm5Qa5w
 3m7bi5Iiv2+UWGGB9MPwWDthsRMYm57UINKXZhF8gdJ2yGGYQknjJcH46xdGspCCl3J9Fgv/2PB
 rlg7rNY6S1KMkvCjLGN19U5bY8JdCGT8daWlkckoPwvKExjJqCbl88qa3WqairqIkL7dqP5/rkO
 XTzElCI3j5ojrPD07eUIzU7zO0jqF0r+BBK6cDm+vtKHPRwb2/281m6AOMOo0IRrV+yw8sVkFQs
 N0+pTlMTNpT1L4dOH9Mv6JH0JJmsyPfZLfl2FlVOqc4fK5XRo38oqYiHEEJ5N0y5gO+ofE73uiS
 U6XfOUD75bAeutZ+FNRHNhNJ6yM4If3AeYsw25GwPCAYkWE9TA/9WvBNgeIcdETDotjRL1nLJPp
 r4=
X-Received: by 2002:a05:701b:280f:b0:17b:fea8:1425 with SMTP id
 a92af1059eb24-185138b58e0mr9940511c88.30.1792405228916; 
 Mon, 19 Oct 2026 03:20:28 -0700 (PDT)
Received: from [127.0.1.1] ([67.159.246.222]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18319d3b880sm26324251c88.10.2026.10.19.03.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:20:26 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Subject: [PATCH v2 0/3] Add VGA support for Apalis iMX6
Date: Mon, 19 Oct 2026 07:17:13 -0300
Message-Id: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACnu1WoC/x3MQQqAIBBA0avErBswMYWuEi2mmmygLBREiO6et
 HyL/x9IHIUTDM0DkbMkuUKFbhtYdgqeUdZq0ErbTnUGs0a66ZCEchaLHGg+GLMnNL3aeuccGWe
 h9nfkTcr/Hqf3/QBiOi3/awAAAA==
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405217; l=2441;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=Wtjo2nq6SBTIM531bE9hkp4uSTiLMC+4CM/B7PGT41I=;
 b=K/92ccUEyeN+TkExSsHIzTIooOpzahjw6HNCnpCaTctauVPX9ywt82Fnmfxdz7h43b7N6JoQ8
 agNgWXrR1O0Bd2/w7lhY8SXJ79VsHXNsansU0VxIDNA3yLiaBD/A/Tz
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a device tree overlay that enables the VGA output on Apalis
iMX6, which is driven from a parallel RGB interface passing through a
non-programmable video DAC.

The video DAC is a simple resistor network gated by an active-low
data-enable signal. For the bridge to work properly, this series also
changes the following in the dt-bindings and simple-bridge driver:

- dt-bindings: Add the existing data-enable-active property from
  video-interfaces.yaml to the simple-bridge binding. The property is
  read from the bridge's input endpoint. This allows a dumb-vga-dac to
  specify a data-enable signal polarity.

- simple-bridge: Read the data-enable-active property and fill out the
  bridge's input bus flags accordingly. The property is ignored if the
  bridge already has its own timings struct defined, to not interfere
  with its existing settings.

This change depends on another patch, and should be applied after it:

- https://lore.kernel.org/all/20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com/T/#u

  Adds the atomic_check function to the simple-bridge driver, which
  allows the data-enable bus flag to be propagated through the DRM
  pipeline. This is necessary for the VGA to work correctly on the
  Apalis iMX6.

Changes in v2:
  - Introduce the data-enable-active property.
  - Describe the VGA bridge on the Apalis iMX6 as a dumb-vga-dac using
    the data-enable-active property to specify the DE signal polarity,
    instead of using a dedicated compatible.
  - Link to v1: https://lore.kernel.org/all/as-heYw7PKLPm3yH@SMW015318/T/#u

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
Leonardo Costa (3):
      dt-bindings: display: bridge: simple: Add data-enable-active to dumb-vga-dac
      drm/bridge: simple-bridge: Support data-enable-active endpoint property
      ARM: dts: imx6q-apalis: Add VGA overlay

 .../bindings/display/bridge/simple-bridge.yaml     | 28 +++++++-
 arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             | 21 +++++-
 4 files changed, 148 insertions(+), 2 deletions(-)
---
base-commit: f33c2a109da4a527ed3103acb649a88e88cf368c
change-id: 20261014-v2-apalis-imx6-enable-vga-450f5777a476

Best regards,
-- 
Leonardo Costa <leonardo.costa@toradex.com>

