Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8281BF3026E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 14:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960F910E15F;
	Sun, 15 Mar 2026 14:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SBLkdRlh";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C2510E15F
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 14:46:10 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so3648291a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773585970; x=1774190770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=488Hq9Gnkxct0mKIctR4RCCjc0FmYu7caXBMO4q401A=;
 b=SBLkdRlhP1aLigCBtKNfQSIFh5vPPKTouz1SSEjViOn+8aoXTRy46sUkzDoKVGlEZi
 KV5a5hCc77FaiGqIe6rg92BFwM+Hnc7AyYWUOP4fiGQmw+8e2KWfWGgw2ivyAj7/Apql
 RQ4ZQVCAIlOYIbkbUi+qi1rKst+YT30qMRbVMdyfkz2udvxV+4ERoZe8htvGl/aCQ8Fy
 wG8atkcaRis5TrdYAesc18XYjb209SU4H+7hN3T40xoU0zwYC0BzCzrw6H6iOSCyew0q
 JjfC6jMuOpC/r2WinxC1386QV3UZUNyMkkVRlPR81zVD9iDvHd1+sUNqWEybcAUjE1BY
 sRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773585970; x=1774190770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=488Hq9Gnkxct0mKIctR4RCCjc0FmYu7caXBMO4q401A=;
 b=o0O2x3bRlbAxUEXVGAPKiGFa2WA1KrfKYrScE2nw/yA/W4WOCTrAG8VUn4tk+Aujk8
 nW2LrIhgcHBeUexEaYnUxNeL867mQQFkpBEAllt2JQDGEZOeDf2RvEQlvGB5ztkJIzN3
 taPZVlFemkabEnKmOjdgh44os84q/0dHdh53Qu6JG6dgixYrt4Eo9Os3dJCaN6bwlXYX
 Tr3XHNLww6+4C35mvOvwsqwUWe2i8aPxFGDqJc9v2Rt/mZrJWfZ9lgEEc/j5to4wYiPb
 NfUEuUE6AHRhoVEAPmlkaHV6SFRoeMs0AvoqDygZfEyzJ4URH7j9DJ9K8A3Oxo0fe/jx
 4JVA==
X-Gm-Message-State: AOJu0Yz+DskzZNbFxjihNyMlDqVEyuB6aEy/HOoRzrPNc1IGGXjtemlg
 GKFaPy+ktUyWu+vWQfterWFXqhO+hyPVL57tvWtlNiNjjzROfAUCWIce
X-Gm-Gg: ATEYQzwsen+tUsk/9RblFtgzts+iij0jfcBGmzTIEo3RCPwn4pbgkct/s7pQPYca6Gw
 HgN7sS679n1S7DZJXA/7HHvZU1YCStnsBlksNRKRtMtQ6sF2qFsDPYEomS4KD8PmaS1x5xWEKTZ
 IMtTS3QKCs0o11nhBhTuEVefW6yeTE6ButyaglQ2/YhfLUjkg0a3nqcBfWsxESsz0tAGjOfd1T+
 uZRh1P0VByyXhocaabSPI6fD4enUxeYBNCmqsVD9hucMRMLlD2rKCdV8MoxZc+5tzBQ4maaTjfG
 +l5ieVuf7UAtv/PkremI1fHnDKAtfPSCyKAjqUvVdkJqbyJUXGJYMvyVZsh7eFZXaHjPw/SUbFb
 ODvFRXC/FGtRBy/KbAEY+L0TKhflyWt8b/4b/axmov19hM3Zz91BSQvnrKJmO1/eyN44dH9nT09
 ugcuwAgNPO/afWmLPbYQ==
X-Received: by 2002:a17:90b:3b87:b0:359:9073:c368 with SMTP id
 98e67ed59e1d1-35a22081e73mr9292412a91.28.1773585969738; 
 Sun, 15 Mar 2026 07:46:09 -0700 (PDT)
Received: from nuvole ([109.166.36.159]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e196fdsm14022887a91.2.2026.03.15.07.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 07:46:09 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 0/2] drm/panel: Add Himax HX83121A panel driver
Date: Sun, 15 Mar 2026 22:45:34 +0800
Message-ID: <20260315144536.515032-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add a driver for panels using the Himax HX83121A Display Driver IC,
including support for the BOE/CSOT PPC357DB1-4, found in HUAWEI
Matebook E Go series (Gaokun2/3).

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
base-commit: d517cb8cea012f43b069617fc8179b45404f8018
---
Changes in v3:
- remove '|' from description (Krzysztof)
- drop description for reset-gpios (Krzysztof)
- use backlight_enable instead of backlight_update_status to avoid NULL ptr
- Link to v2: https://lore.kernel.org/dri-devel/20260305084810.370024-1-mitltlatltl@gmail.com

Changes in v2:
- fix dt_binding_check (Rob)
- use devm_drm_panel_alloc (Neil)
- move panels specific chunks before module probe function. (Neil)
- fix supply in .c file
- do not initialise statics to false
- Link to v1: https://lore.kernel.org/dri-devel/20260303115730.9580-1-mitltlatltl@gmail.com

Pengyu Luo (2):
  dt-bindings: display: panel: Add Himax HX83121A
  drm/panel: Add Himax HX83121A panel driver

 .../display/panel/himax,hx83121a.yaml         |  86 ++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-himax-hx83121a.c  | 750 ++++++++++++++++++
 4 files changed, 848 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83121a.c

-- 
2.53.0

