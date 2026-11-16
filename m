Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E98606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/snmn4A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB12710EC48;
	Mon, 16 Nov 2026 08:58:47 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F6A10E2FD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:02:18 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so24300835e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794812537; x=1795417337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2WwhmAqxPEFlsm5zE6uH7fU7EMvllXc0ISVSjbfBGoc=;
 b=D/snmn4AvG/FsheZwle+l7IErkLgcSXjfDEJUQWP5kC5iQRAq80rbR9mMyiLOa2kxi
 zexI+ttMnpFFwfwKbULfPYheEUKvEKgU111N7c0ms8t70z03bgxU8lcNyCDkwlxb7BZy
 kEAKnb+iLIA4t32G+RrE1/xAJYEKPHRcTBHTDHv4n9zW+ssAULEcb+++4GZvfPE+e8yL
 gD5WiEn3Z7JIYu2E8gfTlNmtq7esFJIpjMwRjsnAJfeoemHPv678L9Qi0lZ8ZhfRxLyn
 RRPl6KEmNOXiTQeFzC0xWuxbzi9+QwXjrM3cTIrTOyNV9IzzIm2VjZO+fUT/ai3WBaI6
 pkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794812537; x=1795417337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2WwhmAqxPEFlsm5zE6uH7fU7EMvllXc0ISVSjbfBGoc=;
 b=CcHxJ3Q/9/ggQgooKQPt+mI0T8rcLBD3sdDdGmXYWedKxZsFjHQrjxv90CNr+vxMPP
 MGz7JuxyP2/TD+gEpEWJAVtftMCSiZWY/QyE5oH4L+E0Sql1R1LJXvGJu4IXKy3T6rMf
 I/mQ2rK92Si4AHxOUc6FF+5V204g2//5cjEbc599etneqmQLD5YysS8VeEsGHHtcur6s
 KYXgQd040LxI0UPqVGpmrL4DjL8pcEetg0SLr3l+UOj3J8ZaZbuNlOiEvW9s+N5TPwTJ
 4efohSgagKYp4aW+RW5JOyersn9ewKKv9sDjXI9uPJLtzH4DqAgjFVOajtXTj4761GEW
 mstQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMHkg7TjuieNds8fiZuDcp7d07WxCrSQkVUOMFPf4XZYq3Ca+uXbIs62U8MmGIZVVCulHSECavt/o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/3y4MQ5JPzzeNEkWnC7cYuyJ5cMK4h2vgslICorYHOaZDFPeG3
 VP9hGvq+iJswqxctQ7Z9SokFHFiefqEGFg36cEoaKZFcC6mf0AGEKcmc
X-Gm-Gg: AYBFou0Fkm3kYK5EEclOQBtsSsjmrJnQZM2fHb0G8FrwKQuYkVVN80mdKrW62RGiOpt
 p/q1YQ/L4e+C6BlF0oDZ59wvdNCVZ6T0krdfNIlMzpDqZfxcF/B+BQ38hw3IzbOQxtlo1f8VXeo
 gQFNmwbsLK9/ggvRYev5pI6st/e1H8HIaz3g3e03aznlc2BVOuDl3i0JiDnYGIc/Pcq0DU7DquP
 NKojfKOQheWSrsibOvIxuFI6HRVo6Zex9FAaj+MrkDXSyo7WWewiLpFD7sclXJLGkGSdFeGqPuq
 mfMbd4hzNWRgvvLt+nRJLU7mhfZb/qjwdi2juGgFHdwtEDZeAUKrb4/Wo1XYxoOUwHPveXwu8bh
 56bHVv5vwRr/9ukyDavmsK1Ls3bzQuXCNpXaSp+6npQSgRM9GDULigBthPcuS7N3QwTPC2niUJa
 BWoWey6zKsqo9T57m3rVu+21J45RbL/3BdmaG6po4PxwHCqAo1mBTph6K/uSFFSv+WdIksYWmGY
 IhtB8QHZDM9jge4iFdLQeYwmtUns2IsS/8lKnTuLdCYbkY6x0q5CGPNQq9dhst3bfOsrz3aN5M1
 aBfN58yn9OJF78Qxo2hYT2rL8PIPgEER
X-Received: by 2002:a05:600c:8708:b0:4a6:30c3:1114 with SMTP id
 5b1f17b1804b1-4bb55a7ece6mr210888835e9.12.1794812536974; 
 Sun, 15 Nov 2026 23:02:16 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2538b9sm558777625e9.1.2026.11.15.23.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:02:16 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: display: panel: add Novatek NT36525
Date: Mon, 16 Nov 2026 10:02:11 +0300
Message-ID: <20261116070212.314228-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116070212.314228-1-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a binding for MIPI-DSI video-mode panels based on the Novatek
NT36525 controller. The first compatible names the specific panel as
fitted in a device; the second is the NT36525 controller it is based
on. The initial user is the panel in the Samsung Galaxy XCover5
(SM-G525F).

The binding was drafted during XCover5 mainline bring-up with the help
of an AI coding assistant (Claude Code, Anthropic), from a description
of the panel and the stock device tree, and reviewed and validated
(dt_binding_check, yamllint) by me.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 .../display/panel/novatek,nt36525.yaml        | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
new file mode 100644
index 000000000..5c6e7cce0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36525.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36525 MIPI-DSI panel
+
+maintainers:
+  - Adil Hüsrev Tepe <tadilhusrev@gmail.com>
+
+description:
+  A MIPI-DSI video-mode panel driven by a Novatek NT36525 controller,
+  720x1480. The first compatible string names the specific panel as fitted
+  in a device; the second is the NT36525 controller it is based on. The
+  panel reset (RESX) is active high in the Samsung Galaxy XCover5 bring-up
+  sequence.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,xcover5-nt36525
+      - const: novatek,nt36525
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description: panel power supply
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,xcover5-nt36525", "novatek,nt36525";
+            reg = <0>;
+            reset-gpios = <&gpa0 0 GPIO_ACTIVE_HIGH>;
+            vdd-supply = <&panel_vdd>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.53.0

