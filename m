Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D3FCDB470
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C41D10EDD2;
	Wed, 24 Jun 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sIe89tty";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E5D10E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:58:13 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-139b5e604b9so310146c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782244693; x=1782849493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=APSMXL2QA/kOTC2fqsHTZZlYL8XNY6Eh93NOD7Wrt+4=;
 b=sIe89ttylCADrfJOnjcXxuOZ0IiVk4Yjwwxr1T1AmVBWz0VudzkKF/c1ecqxw/1843
 +Yuj8jd7Gc0q1V43XwXM25k6eXb6zy2kmMsKaudElHAOCdjtPBMo2kLE8mTMK7pVDKut
 FfXFRhSiD7wi/E+B8Dr6Zu20IhxsOrsM9oKlKmsMGGWPOFjUrFPZ4NxQEG2ufdnqEdV4
 ebyKbb/b38hChLpttm0H41WC0oQcRKlsf3+basSs+nCl5D7Lx9FYBXglz7F4BCN0QJKQ
 NKDNGmVkSsXATZ88RyMnoD1EQ6zbe+P1LOtLzLg8h37dSSA/0pIGJpios93kX682NPgD
 jDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244693; x=1782849493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APSMXL2QA/kOTC2fqsHTZZlYL8XNY6Eh93NOD7Wrt+4=;
 b=D2JRwtvoPJStastsDWCisnnNpu75gtKDnrSehMpftAFTKD2BgKIHpYZG4t1gpV/pBh
 WcCrF3Spl8iupjc2TWzv0S2wvxuZ+Xu9WWxX1APmeknplyMGot8n5oVW7fS7CkerAr38
 cFY9UDenNBsDQWVVLrcZl8gjliBtvS/cQ24itlbSQkAnHObn2jP5n+iKntz1RloAm9kG
 HKwpG7taGa6gp3atjDR+TQCPMdIfd9e7Lh6xf1SQ9hjnqnFA50FZUElXabCewfhMWs/p
 AEmm2CGiVGNvhL1yKKjiZFP0kz6XaOrnQ1JTzDA1UxdEUVVeU16wEhLeRZdjv+HA5Pu7
 u0LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UiPMTwq3C9TUFZsU2uKxMn9kZQo40Zbm+T0nW5miBnlkxjvlJMqnZC3XU1T9X1hKBzU73uXxcuNE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwceRWM+N4DOKmCQWU90uLZS47UNQjuph4gB5eKILwCkIRwy/o6
 d1szoBgy9HJyL19GJxI1E39V5xTERr/9iVT8eTYnzG0G6Ht0T91GmSmr
X-Gm-Gg: AfdE7cl0xZdhzx1Pc1WAY7uMeERk2ba5aSgAa2sNhvgCuz78qCLd9EjI7kl4v01kCWA
 f3eWanvZjnR0swLg5xmlPO9VLZQedGadstPbr1M7TBm+IISzkWsgtO03Ysdd1p40x8FF6Nj8sSq
 zC9yHpmKYJ/1Q7luAUfeynwjuhM1JULBQjE81sFJmz2YwVBPqTInCpqv4dB/1GEZPqwJpTIfpOp
 VHZkjzA896MM5jlizrPQmTYhw0eA0DDhPTUpAhIdv2T+cAdnqq5sHgqUYMA7O0gmd5IW2h/+NMX
 3H8LYsYJpreZckANgJcuaZDcEgjWaFK3jqgvIzdskdAnWH+Q+zjl8xp4JdRc8RIu3Wp3FkQ2VF/
 oXvQu9n+uQ2dmrCaDHiKzPc/0FXaKb67Oemndj3Lrgy4iAqyNEnsZGn2GmiM/xdHdiL5aKtJpHf
 f/xqTkWOufo0YOXSWS9t3RVyKAeoq390MEeXfD8ZKO2SOYcg2wVxbx7u/BTSMywZSMn1Gz4ksyr
 LbiSP7SQQlBvJPtUV8wBoysVjI/rD+hgNrng75Cddw=
X-Received: by 2002:a05:7022:439d:b0:137:8db3:73a7 with SMTP id
 a92af1059eb24-139c5dfa968mr3114369c88.31.1782244692728; 
 Tue, 23 Jun 2026 12:58:12 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add85c40sm15730896c88.15.2026.06.23.12.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:58:12 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com,
 sam@ravnborg.org
Cc: leonardo.costa@toradex.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive
 Touch Display 10.1" LVDS
Date: Tue, 23 Jun 2026 16:57:36 -0300
Message-ID: <20260623195741.495734-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

This series adds device tree overlays for Toradex Capacitive 
Touch Display 10.1" LVDS V2 on Verdin AM62.

The display addition covers two interface types:

- Native OLDI (LVDS)
- DSI-to-LVDS adapter based on the SN65DSI84

The Opto Logic vendor prefix and panel binding for the SCX1001511GGC49 is
also added.

Leonardo Costa (5):
  dt-bindings: vendor-prefixes: Add Opto Logic
  dt-bindings: display: panel-lvds: Add compatible for Opto Logic
    SCX1001511GGC49
  arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display
    10.1" LVDS V2
  arm64: dts: ti: k3-am62-verdin: Add Toradex DSI to LVDS adapter with
    the 10.1" V2 display
  arm64: dts: ti: k3-am62-verdin: Add Mezzanine with Toradex Display
    10.1" LVDS

 .../bindings/display/panel/panel-lvds.yaml    |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/ti/Makefile               |  15 ++
 ...zanine-panel-cap-touch-10inch-lvds-v2.dtso | 109 +++++++++++++
 ...dsi-to-lvds-v2-panel-cap-touch-10inch.dtso | 143 ++++++++++++++++++
 ...verdin-panel-cap-touch-10inch-lvds-v2.dtso | 129 ++++++++++++++++
 6 files changed, 400 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-v2-panel-cap-touch-10inch.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso

