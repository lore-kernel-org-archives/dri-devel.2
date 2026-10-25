Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD4606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=NJQboMZ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9079510EC4C;
	Mon, 26 Oct 2026 08:36:44 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E7710E865
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:58:19 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so1251427f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918698; x=1793523498;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/BvMQkzk3cbMAzfEoRy8m31ymEv5Jtrkq2HGUm904Yk=;
 b=NJQboMZ814l7hGj2fmfJwwO/FA0Hq8G+HF7JJ/Ccwq4XYhOwPEnqiEtMFnkjelLUGH
 k+W03hP62Hz1UVnV+6RnIPOACf+Jp4LuTNfdwYMbFHRbUL6Zm/qBvhIaEbT6M33P80y/
 J8YVAEK1qBd5J3POenPGJktZW7llkIxuVCgyK1ewuqGLRDP4hcZSSj269+u5uPTdZ27g
 1sqAwqmt0kfCsvA8jU3iJnE+KrXC7GGCfJMY7jUwCLL4QuJL9e1hA4cKNpf9B/NULmwX
 60MRhsD+Vdh2/FbbN0KXUAtJY1ks0VKhFhqgf1W3FDqhE3EeoDQ+AbjXGIPF5Nt8FUkz
 D0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792918698; x=1793523498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/BvMQkzk3cbMAzfEoRy8m31ymEv5Jtrkq2HGUm904Yk=;
 b=b3cagOcjSYkwVSq4RsSuvD2m7J0ZYyMKJsGYfmdFs2/VJd4p30JsXELut5GJHBl46y
 Kxnp4IMbJnsQHfS6zwTcexKJri3SnazorvmN2ahc16kjNSdZUQk8VU3MQluErrzDtwTb
 0udtwVzOXqrmBd8uyECwtkvnXfekqlX9vPLi88lVvn+tY5NN6WxD9hHN5yWdB6W2dg/I
 qcIEoU3MFlL0w7LuhBlxjPo4Bb9oNwxZZXjMCoKQmxSTMvBMY6vHr/eMO+JlCHC8WkY6
 E2dQJTBOLd4wKbXBNuW2nSM2r0Ix/KddpUhFDeUjjQzZOKbR3Df8W0bxyuQ8gHkKDWee
 DYXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU3XEUojOF0PWsvphCqh3jyOVzIrjEwDSoK9vXhqA+HQTJBnHLFNbsB5TuQqKNa5m4foPQ6ZJjo78=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJa80xOa6r0kn5Mf2cBX7Lem8PPhLKE2WRkNEr8SdrYDNiG0NfC
 zKTWNEP3XoXZ761SG2vmIB24vsVowwbh9KvJDSdS74cNkvxbnxMyBZ+kE/FA8AhoZNQ=
X-Gm-Gg: AYBFou23rk7dyC0eh8EkR25FEUjueXFB96mSqZUogi48wVN0uRrJMv6BoGfExqmdVWS
 EYtNhabE/cckhnrQCJyvWNriFqVVlVbuw2Q7j9m1BIyjBiDH/cPvS0jq+HzIkETn/oZeLSyX956
 6p1dKt9amIBpg2azXnDm9jPua71B5zrS1RCs+L9uFrX7Tm9yiJ3iIDowNLLeLudLwzYVO+Sr+5c
 DejIRwrLUYaufg5LEZPiK/6GD4yLUEH9YHnGJvTC/eBwNR2/JO9rSJqiLcWqNl/i2H8Nhf+asss
 vhzlCLTiQR0ABRRKucsKzKesRZ+R9g3/2CVRB2uW8hqVdLM6d+oDzaiAlOZ3r4JKOWr6N4wRDbF
 LEFkYzmTxljGv4/DsLXTEHQDps2MD81WrR2XS4Bdh9vVjEM6F193lkncs5b3JrmxBfRf3GN+3BO
 77unmCQuTM0qPxjUW2+HEGjbHyFs0xAwg07GQc+d0cBXsz/5APdCWySC7aGPDRzgkdfj0q476Vh
 11b11ZIpKc1JBne5chrc9DJKioMRsUt8kjdhgLxfYZUxNci9wAWSgI4BuUpAcTPaPoCnuEolM1Q
 HAZfOJFMsssg/EENfgxbFaz+De+InGgZxJx6kK7CNDnJfrKxtyH8mzjyFN6nDAFOWln55oCOVVH
 GYNjLzIMtx9D28QRoOkU=
X-Received: by 2002:a05:6000:1626:b0:48e:4ad2:32e0 with SMTP id
 ffacd0b85a97d-48e4ad232f4mr1415110f8f.29.1792918697894; 
 Sun, 25 Oct 2026 01:58:17 -0700 (PDT)
Received: from localhost.localdomain
 (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr.
 [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm9094542f8f.17.2026.10.25.01.58.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 01:58:17 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 0/5] drm/ingenic: Add the X1600 LCD controller and the HiBy R1
 panel
Date: Sun, 25 Oct 2026 09:58:11 +0100
Message-ID: <20261025085816.60405-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The display controller of the Ingenic X1600 is not the one ingenic-drm
drives: it fetches frames through descriptors and keeps its interface and
timings in register blocks of their own. It is the X2000's controller
without the composer. This series adds a binding and a driver for it,
then the panel of the HiBy R1, an X1600 audio player: 480x800 parallel
RGB, set up over a 3-wire SPI bus.

The driver covers what the R1 uses and what could be tested: parallel RGB
panels on a 24-bit bus and one full-screen RGB565 plane. The composer,
smart panels and other pixel formats are left out.

Two things come from the vendor kernel rather than the manual. A flip
also writes SRD_CHAIN_START, which the manual doesn't describe for a
running controller; flips without it were not tried. The panel's set-up
sequence is the vendor's too: HiBy calls the panel LG35583, its maker and
controller are unknown, hence the hiby prefix.

Tested on a HiBy R1: the fbdev console and a player drawing through
fbdev, blanking and unblanking, 60 page flips in 0.97 s at about 61 Hz,
and the colour order (RGB order swaps red and blue on this panel).

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time. The R1's backlight uses the X1600 PWM driver
posted separately:
https://lore.kernel.org/r/20261025084643.93167-1-olivier@mgcrea.io

Olivier Louvignes (5):
  dt-bindings: vendor-prefixes: Add HiBy
  dt-bindings: display: Add the Ingenic X1600 LCD controller
  drm/ingenic: Add a driver for the X1600 LCD controller
  dt-bindings: display: panel: Add the HiBy LG35583
  drm/panel: Add the HiBy LG35583

 .../bindings/display/ingenic,x1600-lcd.yaml   |  70 ++
 .../bindings/display/panel/hiby,lg35583.yaml  |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  12 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/ingenic/Kconfig               |  22 +
 drivers/gpu/drm/ingenic/Makefile              |   1 +
 drivers/gpu/drm/ingenic/ingenic-x1600-drm.c   | 694 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-hiby-lg35583.c    | 342 +++++++++
 11 files changed, 1226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
 create mode 100644 drivers/gpu/drm/ingenic/ingenic-x1600-drm.c
 create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c


base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
-- 
2.39.5

