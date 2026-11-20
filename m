Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2A606A339
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUeezrLD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A84D11291A;
	Fri, 20 Nov 2026 11:41:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CEE10E715
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:41:08 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so7827485e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795174866; x=1795779666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+qZJp3IOLR8W+jXWOKTm3fVJRlvPeQHbpUSJTeUQL8=;
 b=IUeezrLDfz1JGsNTkjAGoD2UkS8MoBc0LAaenkw0BsEsk+WhOwirhLKjks9jh4qK2v
 RQqTtTYUWYwkMGoWSfz7keFbylyfRZCxcTthT72GCzhduG1D/z1jOG9t1Xe+8I2S5gFN
 YH4eDJtjn259/L12qzUi1rdKPV9UOEM19wQZBoNkKpNsY4GTwpzFBuBg/PaD6ui+2xJU
 vvb+ibgxTra7QAmacKuKg3BOgsiQW5PIk6C7U8AwpyHi9k0b5T/Lp0GSW75O3eecEaRX
 lyEwo69ZxXeytvO8nuQFzU9QeanvTSOz2FJ2wBpXk3ztvVwLkW5qmUtWISzJ94BgZqV/
 7q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795174866; x=1795779666;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+qZJp3IOLR8W+jXWOKTm3fVJRlvPeQHbpUSJTeUQL8=;
 b=kFQkqqWOS13eJ/ZeaH5/nKxSQZw9zJkXgWWBUPiwianBQ4hdrvPWWA6qsArSr0mPye
 G2XfKYn5kcd7Bae33obcY4LU/ywdg5aYYL9PuuLFBDlpAUmZwNuSMzyyiN8hvARfN6+Z
 JRjHNIH6fG3lL9auXRwJupdG3kWRkZLn8E3AWs/IVjqoIYdCIauQjModfYNNUN9vXyDJ
 XwWzAfKkyVwhH3Se1SUzuSBXXPW9NftkNvgfNgvro/pM+CIkVCu8aF/Eo6V/oT2fpab/
 F6haVFJcjcX8b1IO/8WtvdJvyhdP1kHLpwso/ZFRtMvJ00y1Mv4r3qrKMEvhBoMOH6/u
 Tahw==
X-Forwarded-Encrypted: i=1;
 AL+hErEIHmxLao3tVvgC2z/CH1DDZQ4YlPv26jjVVhLMVgt4IP+xr3yT5fuo+OGurWLZxSjsJwuByqx3c1Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Ph5+JbA08OjlaMBrbvV4ge1D2WJmJ287RDf1rMiOM75PpDNi4
 A4HFlrtDTPkR8Q79rfjt1R1/YQeEDftfrqhzemHPm65+qdV75oaTl39f
X-Gm-Gg: AYBFou2mywBZDCY+Z9DHa85xGTaZXXy1aB9kgThKrDOFzCJu+4kqemStq+r+9oqvZxc
 7lhOVcFXk1I629zMYDvfH2F49MXUF7STy6NN6ErbMqtBtB3ENt+38w1EMpPax481kwcMgbCHqo/
 qRvXXh89RC6X5cnNsiE5tYuVV6OmPoZpLuYxtRmdrG9roD+32/ojJUrxHg6CR38xs3XO5XEta4z
 Weh0wfBqzaDTtLHG3dKdUVZkfN3jod8zZ2VENhLf3nmRxr9MS5F/yx5A72tN+tjTkDBvUmVaofg
 JPsv9UQHRlzKMLN6Ikm/sNvZ7JptxZwkwlGb5zMr9kROchO8z1O83ZUIIGGwtzV23B/Byn3R2CT
 jKZyjgEJ+HLXinjmkwWi6CUWnd1jB0S4oyWe6+RBodU0NbKbMfFV5FxJCwmRb4HRpJi9N8Pbyyi
 b203tfhVKYe/rdFQ59e2B7B18nMq5T8f5+zynUpTwdGA58OtfT/TJLuVjkD4ISrodZlGZezHPCB
 gfmAqlo3mCPXJesgZ2oU/RHVkOTv0R3gkm/V6HBuiO8gjCQGf8q1SQ8PpZL5gSP3VdnYe+t2iiD
 EfYktNt5XkNvNHpPmmiz45VaAA==
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id
 5b1f17b1804b1-4bb88813462mr53820315e9.20.1795174866206; 
 Fri, 20 Nov 2026 03:41:06 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm27419345e9.4.2026.11.20.03.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:41:05 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, u.kleine-koenig@baylibre.com,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: display: panel: add Novatek NT36525
Date: Fri, 20 Nov 2026 14:40:59 +0300
Message-ID: <20261120114100.978148-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120114100.978148-1-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261120114100.978148-1-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add a DT binding for MIPI-DSI video-mode panels based on the Novatek
NT36525 controller, as fitted on the Samsung Galaxy XCover5 (SM-G525F,
Exynos850). The panel reset (RESX) is active-low, and the panel needs
three separate supplies (vdd/vpos/vneg) plus an optional backlight.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
v3 -> v4: no changes to this binding.

v2 -> v3: no content change. Resent as a fresh, standalone patch
(previously v2 1/2 was a diff on top of v1's own patch instead of a
complete patch against mainline, which Krzysztof Kozlowski correctly
flagged as a git-management mistake on my part; see the cover letter).

v1 -> v2 (addressing Sashiko AI's review of v1,
https://sashiko.dev/#/patchset/20261116070212.314228-1-tadilhusrev@gmail.com?part=1):
- reset-gpios is the physical RESX pin, which is active-low (asserted
  low, released high); describe it as such (GPIO_ACTIVE_LOW in the
  example) instead of GPIO_ACTIVE_HIGH. The matching driver fix is in
  "drm/panel: add Novatek NT36525 panel driver".
- Add vpos-supply and vneg-supply: the driver requests three separate
  regulators ("vdd", "vpos", "vneg"), but the binding only declared
  "vdd-supply".
- Add backlight: true so dtbs_check accepts the backlight property the
  driver already parses via drm_panel_of_backlight(), instead of
  switching additionalProperties to unevaluatedProperties (which would
  also pull in every other panel-common.yaml property, not just this
  one).
- Fold the compatible string into a single, driver-matching value
  (novatek,nt36525-xcover5) instead of samsung,xcover5-nt36525, which
  never matched the driver's of_match_table at all.
---
 .../display/panel/novatek,nt36525.yaml        | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
new file mode 100644
index 000000000..9158125c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
@@ -0,0 +1,83 @@
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
+  panel reset (RESX) is active low.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - novatek,nt36525-xcover5
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
+    description: panel logic power supply (vdd_ldo28, 1.8V)
+
+  vpos-supply:
+    description: LCD positive bias supply
+
+  vneg-supply:
+    description: LCD negative bias supply
+
+  backlight: true
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - vpos-supply
+  - vneg-supply
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
+            compatible = "novatek,nt36525-xcover5", "novatek,nt36525";
+            reg = <0>;
+            reset-gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&panel_vdd>;
+            vpos-supply = <&panel_vpos>;
+            vneg-supply = <&panel_vneg>;
+            backlight = <&panel_backlight>;
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
