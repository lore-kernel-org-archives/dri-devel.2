Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC8DF013D5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DBF10E1CE;
	Mon, 16 Mar 2026 08:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SVKECDnH";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697AF10E1CE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:41:17 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2aecefc7503so17659775ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773650477; x=1774255277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cz7mmWupQiHeJBt4/mLmGWxEIG5p++4iVJofkne7BcA=;
 b=SVKECDnHx9BlO6H5nyTdgmDxCv5ScTVn8IlTWNHD1DVfu9TTcqX3cUajuM4EAAwO2O
 cp8SabyoN/TNHkVKShQY3HngIPdmGaO1KQfT+y0NsuhAnhaD95BFa7bHotz/D+rlndW8
 NI+N90qny0lRM0wNuVs1arnmZjpT/5alfp4JVw4yDfpC3zRDfFK02NeQUGQiRZTCjXTP
 31yd1ltmstLmJHlzo4GuvpLoasDTBLzbpFyJOYyj3MyBqnXJaVT5UXxpnyDhpbIoegtV
 Ptv4mkAhUYmf9pIRscfoebY3IwQtYHUpQPeKvhtprb8lhzpWsHF4jzGnvbccSqNeghHs
 lr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773650477; x=1774255277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cz7mmWupQiHeJBt4/mLmGWxEIG5p++4iVJofkne7BcA=;
 b=hBP0vFfbRYIcuq0PfauxcVQdUPyjj3uWXiSbIpgI0N2q9Udhae4DOvD2i+zyMnQX1Y
 ZepabgXB+9MEqs9H/AC5RclXPpG6ZdziwkIFiiWqFE05KQ0ORVdQSrM5aCWW2joc/MAh
 RGrsK/HXeL7UE4R3S0eVE//JAHKJyuDfoh6mP/nAAT9lwrc8q1wuxFNKn9M7K+iLth7v
 DY2ajl05zwyYfvVRGVo1edByF4hGZodVaMb8Kef7ieB4JWpmZUin0lL5AdbJzVcQKiOS
 Q9tyhi2rNg8E/Sh1HJKjTEwomcAUKnbMyALdbAmNgdmaLatYrOisWMCMNqhWeM+lGGQD
 V4fA==
X-Gm-Message-State: AOJu0Yw5bNbZxlZzRKQPKcyOknxWHMj+neN9MgxFkFUB2QS8syrg3tXC
 Ik7sKaQhOeKzSdnN31a/mLM/Qw/tyrDeJj1udjiX53HAD8Q2JHRudHww
X-Gm-Gg: ATEYQzzb436ufgpLtuytONZkV6mG1ykgPDKPve1R2+GVcM5OgLANL82jL6eHKaJndK8
 FaZ2cNrC+qM7sXdj6KQ49cVQ3+Lp36F0dfM0QUP56nhJ4Zxc06rnf64rHykRdKGUIPNoNrYSy/P
 8JB+toLNjB1+1C16d3j2ovWjv4UniULKIM+29ld5BtoGMDa2h7qU0G5+oXQFl1mQuXkBKSMexcN
 9XHeDnhoqJ85B4wPBhghG3mSvJBj+tH2cRIgLdRda2ePJ2wy2WbECSen644JkDN+BK8usDRvxSQ
 lxFWE/dZ4Q1xb7m7wP7SPTnV9vw4JQ48rb2X+0exaXnaGhKjMd8BD05QxUEhffLKwYSYQtAJvFq
 7wWt8szZT2qgVJ7ALfyoVEnex2rfRX2PnWX3KN1z6yw2cTexf/bvZlbiun8BfRKpNWEjnq6I3pH
 6By2C4hWIQa1t8Gi3hHw==
X-Received: by 2002:a17:903:17cd:b0:2ae:ac0c:5a1c with SMTP id
 d9443c01a7336-2aeca95fd0cmr120435875ad.15.1773650476824; 
 Mon, 16 Mar 2026 01:41:16 -0700 (PDT)
Received: from nuvole ([109.166.36.159]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83188csm101699045ad.75.2026.03.16.01.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 01:41:16 -0700 (PDT)
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
Subject: [PATCH v4 0/2] drm/panel: Add Himax HX83121A panel driver
Date: Mon, 16 Mar 2026 16:40:38 +0800
Message-ID: <20260316084040.728106-1-mitltlatltl@gmail.com>
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
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
---
Changes in v4:
- use v2 as the base since v3 was using v1 as the base by mistake
- remove '|' from description (Krzysztof)
- drop description for reset-gpios (Krzysztof)
- use backlight_enable instead of backlight_update_status to avoid NULL ptr
- Link to v3: https://lore.kernel.org/dri-devel/20260315144536.515032-1-mitltlatltl@gmail.com

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

 .../display/panel/himax,hx83121a.yaml         |  91 +++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-himax-hx83121a.c  | 749 ++++++++++++++++++
 4 files changed, 852 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83121a.c

-- 
2.53.0

