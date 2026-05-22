Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB07CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F4C10F639;
	Fri, 22 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dArtRNSK";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FEB10F5C7
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso47858525e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466305; x=1780071105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxhTRa0jJQh6ofFG9sXlZ7aauhKliKnMeyOlOjmQWhU=;
 b=dArtRNSK5HpATVhHBqn6wahNjPpBGrRUKvQczENnme80XaxH3czNn4Rafd2FT+234B
 ItJmbBolhraUyQ0CBwPNmeyqluBDRcs7vwUR60+RumEdaOAotjz9F5O78s2u146WYs7J
 xO3BVwFx1EGcFMupZ/cp9DNu1QFifwF/c5jNbQT/BwQt/xMzHAlrzoEmeUY4dyvwoqNQ
 pQWzhCwjur/xEln/jPqkCCK/7EwGQhRAkbBGY3Vf9hYTWIxA3bNzMW70VC9V2cTIGLYG
 0H3woT1ZlAstI+pHOxmlsLjQn2MIiVpxto5QrO1sYNbKMbjUWswh1MbSnBwp7YHFwie+
 ZVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466305; x=1780071105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxhTRa0jJQh6ofFG9sXlZ7aauhKliKnMeyOlOjmQWhU=;
 b=UH8tPcG+IsyXgljVOnQZh0zzvXyiKzOpdukE38p3BH25+d38IwG5aVr9EUgcmhcJJ8
 t5Ny3n4rlU5VaERu+sOb6KwuD/XdFK8mXoZE22I/Tj3yGJrv+D7ClMiQtT1eeQUGUbc5
 YCkc0ttcnH9Nq3meXu0wkPv28eTxtjeenL35uGFB+HyblIaqidCXKrFX0WVtJt6pm995
 IbgkgoNgUIhE2T3RMU4cOgRrBdO9lVJvdqJbXcgsLOOWNeRjMpClZib9uv5R8NH0ZaUY
 MbkVY2uJ4RAnWpaHoDIguF731OB1nflnzp1iN3FsP1HELysAIv7WMrlXbAS5MDTDbj+u
 R42g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JFkkxJzPfRD1C7DYigdIK4Tb+fcajcDIe1KuPHfY+mY8d5w7KTO1JJJK2yjOK/CPhvqdsDnIeo6M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyf4CS50Ote1Yp9C6Vcwa2pHlDupCjs1g/uW6/a/eJ5Hwrktp2z
 J3URL1/0otjqgxNi4sThgOvpcUCSKI3H585kuSMhpnInWlJBdbn1LHgi
X-Gm-Gg: Acq92OG3uoYUUBI5GU4TOa428VE5URUrCVkbbrDuVC2EU+lX3ld3qoXKWDko1RRxbaZ
 6L+Il7XZtWVhSaL68V3UxpFUiHdtijj4leVekBLZYtHtrIqyEIUk8f6/oou0eFrkVD2M0gc/6Ao
 V8HDEu/Ml6NPLVUYrXxy+ZzA4DiUGWe8Vyy4V5yiTtoDOvpFPeFjbWyLm1e+n6BLNfOOl1rA52D
 bTo831Xv+yY8TT/NOTiaijfhd+upjoyBLiBJ6y9HSirYoUXgICuhY4UC8oJQQTuVdie6rCw+F/s
 rZm1e1hMUmfk7e3WihxD6pygXYGduzBakJF9HLQtXOjSDiRPFAjlOjSrPM0lpJWnsKiDW6KCcU2
 ILa1shQImswPUITAZ7YC8VRpwRIywtUcp9Hl+KbgqEvpWIxPG2OAkdbK91BF9fcoIVlCJkNsCwV
 4CVmoKcTZJGwenVBNc9WDil6lBDUcQnGOULRiffAHcox8n3FzsabpZ
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-49044ebc2edmr57464185e9.24.1779466304832; 
 Fri, 22 May 2026 09:11:44 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:44 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 03/11] dt-bindings: vendor-prefixes: Add Riverdi
Date: Fri, 22 May 2026 17:11:07 +0100
Message-ID: <20260522161105.277519-16-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

Add vendor prefix for Riverdi Sp. z o.o, a design and manufacturer
of TFT display solutions.

Link: https://riverdi.com
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..bac056d486e7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1403,6 +1403,8 @@ patternProperties:
     description: Embest RIoT
   "^riscv,.*":
     description: RISC-V Foundation
+  "^riverdi,.*":
+    description: Riverdi Sp. z o.o
   "^rockchip,.*":
     description: Rockchip Electronics Co., Ltd.
   "^rocktech,.*":
-- 
2.54.0

