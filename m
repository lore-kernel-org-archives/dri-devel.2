Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49395606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8CQRNUn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9319910EABB;
	Fri, 27 Nov 2026 02:08:24 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E466110EABB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:08:18 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so5121691f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795745297; x=1796350097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w4DH6C+tDE1JFdLKzQpNer3JwD5m/dqh3XkJoVpVm9Y=;
 b=x8CQRNUnerThX3Y+3llLCUbYe44po8O2gH6Gb1lwgQnSo/1KbM6+SGjaf3m9iIhueL
 qNDMaXkTsl6feLGMIxHa8upzWri1ZznJGsPF0nXNNekIbL7RtQOOLCbPPsRia065GlIc
 uf9VtmAL0RAkF29ZecbSPghjq10UqY2sd1+VNqeqJB/ywpbAswoJfyAKnplaFT2ZNlNT
 EeUpxXFVOQatl1TB4YufgCmWfM0rnLAP+YedEili8PwlSUIzAMxeIRPzUOQl9vJZKFYC
 wEDeQO1e/euDJSsTPqA+VNJI8TMww8OzQtQ3S5wQ8rcMjYon/koABn7699wcmy3/aC11
 bPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745297; x=1796350097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w4DH6C+tDE1JFdLKzQpNer3JwD5m/dqh3XkJoVpVm9Y=;
 b=rFBj1JEfEqKLYaj0mvjuYoHqDZkSiCUbNtiWwcr53zV/Ps8G+WcfXsV+NwK0uu5/iw
 DGRJL6nZg32h+Ddw+iDuSCzJNpiz1TYLpS8GiCpEqJFwVhxduftXxJKqsew6KXrB+4fz
 kxRX+prbg3PwZiB84E+qgrfriifLBJWm1XaT2TnBYpUhooaTdfTHd35SEoRQALs//MhK
 k0e4Gn1TlniycTup1iYoovhjAUW0wkCsxsNm7+fNXFxI0ACvnRBLLP6w/OK4QkytiEsU
 xZzdlpN4Np9dr/ScRP33J5hIdgqADfsC12S3SgFlZsFRPay+ewiFJEACo1jg/jPiNP1w
 tS2A==
X-Forwarded-Encrypted: i=1;
 AL+hErHHA/U8Vtt34ycpTcIC9+GeGm/oMIoc/6Hn0HhCutKKVa+Shnjwi6qLEzmNS9R18XU86HsukSjoZYg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+fxnEJdnbzP2QY89M3sPtPvgAXCRZiXCT6LX0FZQCQkhNQrO+K
 w4+rKOsuX+k9iZPYzJIkguFPFtxK4qqOemm/2T712vCkHdeiKmlPXGVm
X-Gm-Gg: AZFdTZfhw8AVI8F4Po+1ZGAzhfejVKx9S5Nv9/NIB36jfTboiVSI9WBlTeG5Dtci0NF
 Ia9dqPvvYtIcjjJwfR6KDOPloIO7mBNJ3IPHtGH+0Q5Mk63HdzfuHnEDhvVwI7fXcgsb/t7B9sf
 EWxedL5guCcFR58oi/eA8/g9+fEztFEg7a0x13s1/dfG9RPSgXtbsrfH+lbU2LT9st5YGzY+m9j
 6SniwiMOjUsfynT3UPoa5TpN7VVa17ygB6aPWTm56fxa/jwK4WOz3dLLdKyySH86Q6n91QQIKA0
 O17l4rmCcU43DNUquSofGkVqEqGEqTkueIHuKkSNMLwW3vgoV1JWCC6V+7t4YkvwmcODH1Uu10v
 XlR7GFENAJ7Ge7OW42U4i2ugrUAFWia/CllEvy+GF11zOESu2Rf8b6GFPQrRGUPUQ8HLk3nrn44
 +5eje9nQixtJI5ddJjNNGVTBg8AXI5ysVtjQP0aMCxc7wwCW57K5u8SVAQ+b5LAC0G4aSNH/SOv
 vxTy1eb+2JdY3tDDLDQpDayChI+NCSh+TMe2b7AP/V5ZQemc8vcXDw2EV2ugNEOZccjRe6YDGOi
 emQLDdNqGUIRQ4yeXfbsvQZ3PdD/QDtklqx6ynHMrGBxBqotfVRxOXR73SSMccUEul0/NNoCWc/
 ofB4XOfY+y89xY3nzqm3p/SrtdJwkuFf3rbUC/To6337wAA==
X-Received: by 2002:a05:6000:1863:b0:48d:b940:af7a with SMTP id
 ffacd0b85a97d-4abb665167bmr54566966f8f.55.1795745297215; 
 Thu, 26 Nov 2026 18:08:17 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm43390844f8f.49.2026.11.26.18.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:08:16 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH 0/4] drm/panel: st7701: add the Miyoo A30 panel
Date: Fri, 27 Nov 2026 03:08:11 +0100
Message-ID: <20261127020815.1621790-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Miyoo A30 is an Allwinner A33 handheld with a 480x640 2-lane
MIPI-DSI panel driven by a Sitronix ST7701S.

Its stock init table doesn't fit the encoding st7701_init_sequence()
derives from the panel descriptor, and the panel doesn't work in the
burst mode the driver always uses. Patch 3 adds two optional descriptor
fields for that, a complete init sequence and the DSI mode flags; the
existing panels set neither and are unchanged. Patch 4 adds the panel,
patch 2 its compatible.

Patch 1 does for sitronix,st7701 what commit 2f50e0a0f9d3
("dt-bindings: display: panel: Make DSI panels port optional") did for
the other DSI panel bindings: the port becomes optional, and stays
required for the panel with an RGB input set up over SPI. The Allwinner
sun6i DSI host links its panel as a child node and has no output port.

The board devicetree will be sent to the sunxi tree separately.

Testing: each patch built with W=1 for arm (multi_v7_defconfig,
DRM_PANEL_SITRONIX_ST7701=y and =m) and arm64 (defconfig, =m), no
warnings; dt_binding_check clean for sitronix,st7701.yaml. Tested on a
Miyoo A30 on 6.18.54 and again on 7.3.1 with the same driver change
(A33 sun6i DSI): the panel comes up with a stable picture and correct
colours. The other
panels of the driver were not tested on hardware.

checkpatch --strict reports "Alignment should match open parenthesis"
for the continuation lines of the init table: they follow the style of
the existing tables in the driver (46 such checks in the current file).

Tool disclosure: this series was prepared with Claude Opus 5.5
(Anthropic) as a coding assistant, in an interactive session: it
extracted the stock init table, wrote the code, the split and the
messages. I reviewed and understand it, and tested it as described.

Romain TISSERAND (4):
  dt-bindings: display: panel: sitronix,st7701: make the port optional
    for DSI
  dt-bindings: display: panel: sitronix,st7701: add the Miyoo A30 panel
  drm/panel: st7701: let a panel provide its own init sequence and DSI
    flags
  drm/panel: st7701: add the Miyoo A30 panel

 .../display/panel/sitronix,st7701.yaml        |  13 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 115 +++++++++++++++++-
 2 files changed, 122 insertions(+), 6 deletions(-)


base-commit: 53063c88338aa6125d43a7ce3ff1e0cf5066bad1
-- 
2.43.0

