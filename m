Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686B60A3818
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=f8b/MO0e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C0410E5B4;
	Tue, 20 Oct 2026 03:09:38 +0000 (UTC)
Received: from mail-m8343.xmail.ntesmail.com (mail-m8343.xmail.ntesmail.com
 [156.224.83.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BCC10E213
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 03:09:31 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 51a4cee6e;
 Tue, 20 Oct 2026 11:09:26 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v3 1/6] dt-bindings: display: rockchip: analogix-dp: Add
 support for RK3568
Date: Tue, 20 Oct 2026 11:09:11 +0800
Message-Id: <20261020030916.3223833-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020030916.3223833-1-damon.ding@rock-chips.com>
References: <20261020030916.3223833-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15749095003a8kunmfd20f05334c736
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxkeVh1CSBgfT0MdGUpCHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=f8b/MO0ehj3Q58MW0sg3fHABf8jei7ay2nU8Ptanbnxs50JXWxgjLWUKEOlA0DASlOICdM3O4p+J8upJFSHdaSbZrNoX7jykGQMWE7vbPFHHTd3dEv9mPNfcpUHxXgXfm7J4mysFjuckFMj5q+IHcqBde5VsZkw2UK0ARQ6tDp8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=aqA05e3tEQzex5IV+W6xDQvoZ2RGk3y5IlP3Z09UWS0=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the "rockchip,rk3568-edp" compatible.  Like RK3576/RK3588,
the RK3568 eDP controller has the dp/pclk/hclk clocks and dp/apb
resets, but unlike them it does not use GRF registers, so make the
"rockchip,grf" property conditional on the SoC.

Also document the optional avdd-0v9 and avdd-1v8 supplies, which are
needed by the RK3568 eDP controller.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../rockchip/rockchip,analogix-dp.yaml        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
index 39dafe75a680..f8670a4e0430 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - rockchip,rk3288-dp
       - rockchip,rk3399-edp
+      - rockchip,rk3568-edp
       - rockchip,rk3576-edp
       - rockchip,rk3588-edp
 
@@ -47,6 +48,16 @@ properties:
       - const: dp
       - const: apb
 
+  avdd-0v9-supply:
+    description:
+      A 0.9V supply that powers up the SoC internal circuitry. The actual
+      supply source varies between different boards.
+
+  avdd-1v8-supply:
+    description:
+      A 1.8V supply that powers up the SoC internal circuitry. The actual
+      supply source varies between different boards.
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,11 +72,22 @@ required:
   - clock-names
   - resets
   - reset-names
-  - rockchip,grf
 
 allOf:
   - $ref: /schemas/display/bridge/analogix,dp.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-edp
+    then:
+      properties:
+        rockchip,grf: false
+    else:
+      required:
+        - rockchip,grf
+
   - if:
       properties:
         compatible:
@@ -100,6 +122,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3568-edp
               - rockchip,rk3576-edp
               - rockchip,rk3588-edp
     then:
-- 
2.34.1

