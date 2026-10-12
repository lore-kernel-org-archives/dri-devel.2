Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37335CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B767C10F583;
	Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2AF10E4F3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:25:44 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1475658f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791789943; x=1792394743; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0X2fplabp5QOh4xkFzr/FigCgPmHhH9f7OOGboLoAI=;
 b=P9rPowbNyc6kIR+8zjiezrFjRjxror/bd14dcXusp4ChBCT+n2r7k0C6g+8zI4XFLv
 GfgBSW4YJXEU24yTOYsUv5Qzq18kAVFcegvQMZhTNfn3ubL0H89acNYCvnEZL6QF6cc5
 hn0oqTXqKcYQRWomAqLyZI+GrZhJ+xT7FPi0AGC1sm2rlCTG0jk8/4W5PyIC2ZBJCefz
 iVv0EiaPap0ZTlm4K+Ak31cH5uuK6k+PGvHbi/ujwJJFyhMnUQpasZJxvZl4whXTWfJK
 dVbbPNmKtVWGHRK3W2fAWeFjhkXQHqU/BF7ceumKCfP78hXEsnlC85QVZpVmQVFft6ue
 iQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791789943; x=1792394743;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0X2fplabp5QOh4xkFzr/FigCgPmHhH9f7OOGboLoAI=;
 b=UUIFbO1IN4sLAzRfNgPQquRsolWgxNDArWIIMO36fMxGbyjwJ+h/nEDSN0G4B6sDmD
 CGoh0HBNuPQUr7t/a8+7gwxvhsbVNq8QcBryPbfQ4ASBxl+Yn0N2r5TwzZzqOAW0t3in
 zmxQPksHhB3QBi3/lVFWM7LsIRdVPWCVEGSi1lNYrzRygQA4Plkv2Xym9FVRYhFqwM3N
 jUeNgZFy5pgo3mZgXbCpX3zodQV1JIrUh09pEkMdAwUKHwR+CUENboJ/DRhIXxbEPHj7
 02oozbz2s08BnCArd0TrzACg17ne+T9bd/K+o7R5ZL/WqrbW9gFpFrYbaZCJQqSawEB2
 ThmA==
X-Gm-Message-State: AFq9FYKaOW+np4dN5yPSmIcaTsQmmUoejzOM/zfcKVjTILWPwjAQD0Gk
 rhp7sF9SNpYQuMQt54jCPJfVOoRLL/khlAPUJ22D81gvC+E0iibyr/IC
X-Gm-Gg: AYBFou0RyYoj0XlL16q1Kg95eu4VU77CO3Q4M4zWaF7xBTdIY5WiOsBF0BJFU5RSSNz
 cHkQYe7rqcKCTHbGPw/Z+GTWr78GfXdp7jsj3W4Y3eKfedFuAR2Djfpf1i5dkCQLtn2hwcq2XFj
 oYVFb+03EO/ojV9i0JRwY2GqMKm9dU22jlxsxfaGnqU5KQgnGQ+IqaxWOzCeColJjZAaOVhpAgV
 wnMEfxJKt/d4CKlaAIhaXsoDxzKHf+Lrfb6/L4ntcTldDqAZOYv/TkP8nbYSD9NtuunUetTNicu
 sNC7ysUKqyEC1LGhOxR6dVipYa3lO3y1TcSVPpdZgCN/Wc204erLPVjGqjplXTtPOa3nKOUArTh
 1vv9lkGRkN5jBFr3wJT/0BmAOkBnIJnlP5bsT9b97MnSsEaylFhlcpBuZbma/ri7DOCJKCJCpRK
 FwazWTPG6jYqdD/u+bB8j+QMBnNBvMSGfyzBEmn6KLo/9r3XS8803rgBnV1B63XwVZyr8A3O0+p
 RtXrYhrXklxGQIEbGZK2AhvsKFptYgrOkABEz0kXwjwY0b8rG2oV0KF//4UTk7d
X-Received: by 2002:a5d:43c4:0:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-48dbaae8e33mr12493470f8f.37.1791789942797; 
 Mon, 12 Oct 2026 00:25:42 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aadf9bsm17523377f8f.29.2026.10.12.00.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:25:42 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Mon, 12 Oct 2026 04:25:23 -0300
Subject: [PATCH 1/3] dt-bindings: display: bridge: simple: Add the Toradex
 Apalis iMX6 VGA DAC bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-v1-apalis-imx6-enable-vga-v1-1-8905d8746504@toradex.com>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791789940; l=1045;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=O9xo6x/Vsususv0Ua2eMzb6/yhBucutOa+18ozmEW8s=;
 b=37sR/q4rsvp8/0G2BU7g+IBhwPmrrzyaZ1/VxQrnHcJjiWbLbf2XnbzLTPJEjCxDGsQuZuSjh
 HbRJlB47ZlZCC13TAqoR4wM22Qy2GtPBeeyW86uPQBEWd2NKM0i3WS6
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

The VGA bridge on Apalis iMX6 consists of a simple resistor ladder that
converts a digital 16-bit RGB signal to VGA. The VGA output is gated by
an active-low data-enable signal.

Add a dedicated compatible for the bridge, since the generic
dumb-vga-dac doesn't describe a data-enable signal.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 7636c24906ba..a86231a4a908 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -37,6 +37,7 @@ properties:
           - ti,opa362
           - ti,ths8134
           - ti,ths8135
+          - toradex,apalis-imx6-vga-dac
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

-- 
2.43.0

