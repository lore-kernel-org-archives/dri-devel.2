Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9302CFB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78E310F3AA;
	Fri, 24 Apr 2026 07:44:53 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6D010F286
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:15:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g1pl53KYFz9vKv;
 Thu, 23 Apr 2026 23:14:57 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of linux@timmermann.space designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=linux@timmermann.space
From: Lukas Timmermann <linux@timmermann.space>
Date: Thu, 23 Apr 2026 23:14:37 +0200
Subject: [PATCH 1/5] dt-bindings: display: panel: Document Samsung
 LTL101DL02-002 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-manta-display-v1-1-196f80c5673a@timmermann.space>
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
In-Reply-To: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lukas Timmermann <linux@timmermann.space>, 
 Alexandre Marquet <tb@a-marquet.fr>
X-Rspamd-Queue-Id: 4g1pl53KYFz9vKv
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

From: Alexandre Marquet <tb@a-marquet.fr>

Add the dt-bindings for the LTL101DL02-002 panel.

Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
Signed-off-by: Lukas Timmermann	<linux@timmermann.space>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 24e277b19094..2de0a3a6d1fe 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -283,6 +283,8 @@ properties:
         # Samsung Electronics 10.6" FWXGA (1366x768) TFT LCD panel
       - samsung,ltl106al01
         # Samsung Electronics 10.1" WSVGA TFT LCD panel
+      - samsung,ltl101dl02-002
+        # Samsung Electronics 10.1" WQXGA (2560x1600) TFT LCD panel
       - samsung,ltn101nt05
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
       - satoz,sat050at40h12r2

-- 
2.53.0

