Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A90ACD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7FC10F52B;
	Fri,  1 May 2026 13:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Hm9vyvsH";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D5810F52B
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:52:55 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so18758035e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777643574; x=1778248374; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4a0NufHsK0XpXOY+2VZGRubm4xGOIO41KwE6sxp9fdQ=;
 b=Hm9vyvsHXgDEELNpOrV+C8r6XgNzlAhTj05B8auaVUD3T1QvCZQYWuHyxzjdmzO6O0
 DDf9ojrqrH3hnQvYNPpchqqkxnQZY01Z1Tx1cVfNNHxNVeI3ca36+MuEnPvS7F6S60XE
 ed0nNXf67RyGBOAIZdGMrx4y5eXjGgL5/VIROU+FsL1TWAwGnL4rTLDbwGjlkeFajmhm
 JNxI5lCkRCskWf9iJtuowplRgWbOidenKAHk1dZA/7WBHltQw6gMH6iyqYWPhah5OF/n
 QLNO8zimZTlte3OUHHp06Op6FePpurUCtUI+WDOWZLdnGybB9zp1D6vZUTP9whwfdHuc
 b3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777643574; x=1778248374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4a0NufHsK0XpXOY+2VZGRubm4xGOIO41KwE6sxp9fdQ=;
 b=YjKoKaPwZCxyKaBhLk5293nvdgI7w/+FvAHFKzgoSj/gluf4mLcUZHhAIqrwECgS6M
 6mzr1t+FqPrNgG15EuZoYcokgJlC25hSknYoQaUPW3LCaU0JkALJWtuyPQQTgCZPNq5P
 +kA/CzNnATevOeYalKzoQsrj+VpddrR5gQ2RjTZbMpBS+jGIAq9hkfzTPs/uNeMnqB4T
 uO6GMmchBaudhbxmHPAsRCa1+68I1HT02DatPGojxu1uJrlMqnK0yzZue3LyjMroUaE4
 pgAnYfPpnJrZ8yxLGozcun60wISOwtv9si0isgIsPLj/tAMGHxfB5LfDkOdY+6qBLwwX
 JeEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+f881PyiX8AkzXIO3ZMLNTmOklDPXggbTPDbGRK2NssJ1VZfNsAOtjuG4KSk6vvkzHcglfRPIFFLU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxP/RCkFY1n863SXa43e8hdPl1mfwP3UOYVx+FhEMGxc9ewCuKj
 aWdjUccsC/fNF+4/PmRXaGZ5dNQJh+GBQhE+3+x1r6VDZotGaJ60Yj5oMfjmf75G1p0=
X-Gm-Gg: AeBDietwhHIlLJiVDZOBQ/bva+2nXyx4U3Qg6CJPWPnVFhoLoNEnJL3Im40X8N8aZdD
 xCSiPPrEMhGI3Fym0oadl1Y5VwHwifks508LqtWm4OsnSEf6KWLKMOvg90l+IIxjac1779CiXQu
 umVWK+R0e84reJGcWpWBm8bxeMLUb/Ena/rSWbrZUaCfY9zXJKd+eMf4JKmDdiDwrq1yjb4lQzO
 LiK5A5SGIIxA2cJzOVZB+5+O9ffe/h3wVa41eBKvXZLLJ5+Zy+Wd5e1UO69o3pv2b/H4llaSosh
 +TOhavX7YDppqJII8SGTmKQPtThJ+3erxv38COK7y6ZTRUtpf2Xc+Tfdoy/uai9TlTwFNbPTtWz
 pA72dS6FdyvZ5NpeSJiukLKZMiHlvvCMl9pYTnb4AmufDsjoXrknop9iJ3a4EtS2Z9ketXnhoPz
 z0z2/bvIBU8TMh7baGZtHE6RmMSIhpfyz2Y0e4nY1vSEzR0NfEJpEzn1T8veH2TzHkKjeSKgHbH
 mOpI5+l
X-Received: by 2002:a05:600c:698c:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48a8447b63amr127933675e9.23.1777643573958; 
 Fri, 01 May 2026 06:52:53 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm143934275e9.7.2026.05.01.06.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 06:52:53 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 15:52:45 +0200
Subject: [PATCH 1/4] dt-bindings: display: panel: Add Novatek NT37705
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-fp6-panel-v1-1-e09cb05651cc@fairphone.com>
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
In-Reply-To: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777643570; l=2217;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=RTl7Y1O8e+RJXuxSn/M/jl/nMzqeTvQ7RKDRGde9pMk=;
 b=YFQI6GCHBOcdRW0vNjaOfwbl27MEuOcdgabIHkYmiIZtih2yy1DW7qHpPr0Pq0sQlyUKJURh5
 g7DyT2wAbuIClh+j4KMIB37E2sRxHmf+79I3mIe8y3lMfOkFVEP0dlw
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.

Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
from BOE) using it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/display/panel/novatek,nt37705.yaml    | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
new file mode 100644
index 000000000000..1c796599f6fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT37705-based DSI display panels
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: boe,bj631jhm-t71-d900
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  dvdd-supply:
+    description: Digital voltage rail
+
+  vci-supply:
+    description: Analog voltage rail
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - dvdd-supply
+  - vci-supply
+  - port
+
+unevaluatedProperties: false
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
+            compatible = "boe,bj631jhm-t71-d900";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+            vci-supply = <&vreg_l19b>;
+            vddio-supply = <&vreg_l9b>;
+            dvdd-supply = <&vreg_oled_dvdd_1p2>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.54.0

