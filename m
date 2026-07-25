Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075FFC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB68E10E2DF;
	Mon, 27 Jul 2026 07:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hmh2b0+P";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E14410F4D3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:19:08 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca8758e7e94so22053a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949547; x=1785554347; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R27OrBVO4c+ZRT7KJNQVX6sAFfpZUPUtgxebharHHoU=;
 b=hmh2b0+PKBZBAME6g3OgFHtZMzR2sjy6PP5g1xmZOx60FyUgQSvl46GHBJD/OIc478
 0sd18FELjYe/qlqXsZOz1HL9CoImp0qGzcX2IV4uRUOYthyTkb0eI5shCEs3ljDezSjp
 Kz/x1s9nJXwTrg8PeZccn326Ir/tobQqSgBA8Qw+I77r95s/dtKKyutEXxKmDx7oUCLe
 B0T1BOhG4L5K+rebdplezdwEghr4Yz5hAN1FLf+wXVmosLB54O6Pb6ofGpaJhX9lt/im
 /O9GBDof6U0/NR+TU4e+v6rNJF8CWg4SmLoSFkvNlPKjNC9rLMcWQVAR5w6JY+0vCi3y
 CCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949547; x=1785554347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R27OrBVO4c+ZRT7KJNQVX6sAFfpZUPUtgxebharHHoU=;
 b=hb973eAtECxD0msSsFixNuEajvdTDWG8RhqGNkE0FWa2UcwOuA0kYkI8LFwv32mW3O
 Nn6IisYbSaR+MErwxcwhZOASvqB8oMu9SMYbR09jAAtM07fkFQYrpai8L4ycVPrV5xM5
 O+QMPHwZoIrADDbARe9nQsEo2mlitA8BvLTZ7AahdnrUwEK4O6KarF1jn+5m7h7rIW2p
 HO28fhFBGLKZwpYW9Sv1XEm9K2Lxa2k0IOOUh0Frf2fjndomnhL7pAbh7kdyb7YfQo8S
 Y7jZ+0jzl04dhY8lzlRwg7wHi7XE+OPoksbGKpWZfK+dLONOUb6z8K/1dbyGa9w/6sco
 cLYg==
X-Gm-Message-State: AOJu0YzIcP+cBvs4KaRZRDbZOOF4zBuurUZNfSIqWqmQ6F3Oy3xFb7VM
 bc3eA4ozeftEuSgadqVGRQMyUR2Kem9LsgGhitFAB2qRbQBMu6BbMC5Y
X-Gm-Gg: AR+sD11+OM6gD/pIppaiJ01sQa1/bsuxowUFeOzt3GLACRjQybTLyWHGQU1xAUsLXth
 LnzgWQcKy9wvXP0qczS0RKc9HO4QYNGAVpFAkxk3aBimEXMfUBIneYlNXpnFHUC3QBTzobWcJO4
 itCBKFcDAB9FOanwjx7dpO7O3GTIIkTyPpcIAoyF0hYviJNMdXfeW3CAiiap0DDYrSg6in/KX3K
 hVbbey6GgLDi8DQVkCJPOjKd4TrMKy2I3E4uFXGJTc/zV1t8qiUWx1AGbFtsrAcLCYUGFLL90nM
 vrrGEUCYKrvuTdaWFeeJUzaFaPCxO0vJAt6vIHoyQFS4/03ISLolycokpV1UcLTIsOIROJ7wDWs
 Hy4f2Eo0lreyN1sBCViHO9suMGOMEEFuDRWiEufbTRkLHw8HUfH1l21Y=
X-Received: by 2002:a05:6a00:852:b0:847:9919:e772 with SMTP id
 d2e1a72fcca58-84e595426f1mr573194b3a.21.1784949547576; 
 Fri, 24 Jul 2026 20:19:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:19:07 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:45 -0400
Subject: [PATCH 13/17] MAINTAINERS: add SpacemiT K3 display driver entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-13-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Cover the Saturn DPU, the Innosilicon DP/eDP controller, the DP PHY and
their bindings.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dea93a41962..9f2910a17c38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25436,6 +25436,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
 F:	drivers/i2c/busses/i2c-k1.c
 
+SPACEMIT K3 DISPLAY DRIVER
+M:	Cody Kang <codykang.hk@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/spacemit/
+F:	Documentation/devicetree/bindings/phy/spacemit,k3-inno-dp-phy.yaml
+F:	drivers/gpu/drm/spacemit/
+F:	drivers/phy/spacemit/phy-k3-inno-dp.c
+
 SPANISH DOCUMENTATION
 M:	Carlos Bilbao <carlos.bilbao@kernel.org>
 R:	Avadhut Naik <avadhut.naik@amd.com>

-- 
2.43.0

