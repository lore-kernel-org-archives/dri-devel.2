Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB8CF3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6201110E1EC;
	Sat, 11 Apr 2026 12:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HVtX1g1H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2XY1/ul";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2849A10E1F3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:34 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B9rCoj3327378
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U5Psy+WxXrFJxWjrPWpUan7fIsF4S4KxZB8EgUH3wwc=; b=HVtX1g1Hn1UjhWAO
 eUueBXyLW5F/JIiQD1ybbQrYHa1VlqXQc5keMZ5KOEitP+cIP9APU4wt5pnfXlK2
 u45AhyigTGRnVOfP673i09iqypc6/Ln465w2cvUW+sEsevIzbXgIrXchSuowPlgo
 BoT+J23XHz2W5h2P97ekfqQqR7Blr514IchPmEIc6P+iW0I4mLrwG9rhiLN5DHU8
 7k792e1QO5PlixINwHFV2gxC6+1uA6UUIrW5r5Y41lJ4EJhnWrtEkQ1ce8X5p3CH
 zisVNHcvFmeTMCiSgNtXUGhaU4zGeWKlhOftJhB7oVtGSflnOnNksh/1ozd6ps17
 zTPL8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfeyyrnf6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b802961ecso36157581cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909492; x=1776514292;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U5Psy+WxXrFJxWjrPWpUan7fIsF4S4KxZB8EgUH3wwc=;
 b=B2XY1/ulP7/QHc046U+JoX5kBYMt0IgAbHTFgnz2jVFLzfjQW/zATwzIo4AdfkreL2
 4GljIvA01XCR6WSq8u+ohlBJwjNHMRc4U9sH8P4S5+tGQbi9OG8GckqPt29Xo2E31EGZ
 AGz/t/iyEaVBbQhPno3OpB5ADMCrd3VWTjbkjxFmQkBy26YP5+g6svJMjNnkfC18ZjeT
 AFw6JXyN6iBbQVOQRXuYY96+ayyZq0YLYqvTWvIO+Yb3Q1B0ElpLNYHmJM2TpDWxTRgn
 iEXjCmkbNxVYpNVyDpyOAsMT8qpXImlLzm3TCBIVdEaH2lm9/Kkc25YNozUMSJJQOl4N
 mHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909492; x=1776514292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U5Psy+WxXrFJxWjrPWpUan7fIsF4S4KxZB8EgUH3wwc=;
 b=HI/iXjkcLrbTH4XVgc29UIDYAlKpLdIYy/13LB7y7DVnvO3WRunVwVdE00Ph76ZP6U
 UZlW9p+EJPJVXELT0M68txbagSYno9N08DoYw2srJVrGTSJzxkt1dM4nARcriLEe9nVA
 NrEbUtWsoNSkUF0Vp6HMXi6EFMSlQGY/8FkhW8CAFZrwkKXoI2SgYhI0Etf/q7sBGtrx
 KwFvYbVhrAZeI61/50SZxMt8ddpNVvXw1Qv2Ht+XJL/+hT8UeRH8XwFcA7SAmoiOVscK
 BV+Q4BhL/zFwqlff3sESjDFJGG/InSH9VjPdIi4VSxSicG6thqi6pNjw7I3npAxQ02jy
 0lXA==
X-Gm-Message-State: AOJu0YyMOZ+IGb10Mdyl8pJK5WAo9kcMwgPo1qMFXpc4r1ra+Q673kiP
 KIDMEYuj0EJqwCV3EZCgp1ge71VlHgWbAsHS8NnX4O3EFoRxMWACUiQ+Qjpo4Wzru3Uc2wT9IG5
 aaBilsBY3Qv5oed6/NMrg6t4PVR4yQP+YMRLyFO8w2vzWh9W2JGKE6Jqbnacbm2/+0iccW+4=
X-Gm-Gg: AeBDiesfCZwEFw1EWTaTNGV1ZFJG7vGr9CUCQITAPbs6ZUgXQ4zBJbmKxFW4Avq2QwJ
 p/b6Z1XRiF1OB9WRpy/2Ww7yZxWY5SGc5SGcfveife+l3eQIyJ+Y0P/e9Ts51DLLKAKTK6/E8Bd
 v13b/dujrr9ULUg8PgC3rzYuY4YbWE16HSx3pQPNl//s871yeaPWNfRvcKS908u9u6HZqlj2KdD
 O3qZUd0EENtQUqA/tm8rCMMI2Tw4XDSf25nvUt34aS01HhG8hKNnZCYHsW2eq2X44BPryxf5Tkf
 WUwDe0fP0L34y3uWuNmZ0j7LL7mbDMu43+zMocaVXY3Y4JvqPWlKAg9+SPVXhgQavf5G1GAk+6p
 Hc2QF4xitWbzGOKyynenpAaC7zRpfBmoC/6RUpjrHL9Qh2SHR367ZhTbEia30XmXZVi//jdj5Pg
 D7pPVynqgHhY2W4NKULgRP5DU1izUVGZwnX2E=
X-Received: by 2002:ac8:7e96:0:b0:50b:3d1e:58ba with SMTP id
 d75a77b69052e-50dd5b00979mr98627061cf.28.1775909492111; 
 Sat, 11 Apr 2026 05:11:32 -0700 (PDT)
X-Received: by 2002:ac8:7e96:0:b0:50b:3d1e:58ba with SMTP id
 d75a77b69052e-50dd5b00979mr98626411cf.28.1775909491599; 
 Sat, 11 Apr 2026 05:11:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:40 +0300
Subject: [PATCH v2 20/21] dt-bindings: gpio: describe Waveshare GPIO controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-20-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TunD4E0x54s+DUKwuOGbXcTKMUnxxvwmjd9+k4H8VAQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpHtM3Gez7N+kbhy0GNn7VWDq9k4rV8AIC5g
 V9gzMYNDHuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RwAKCRCLPIo+Aiko
 1dOlB/9R7LXGfMg9J3Q3qbrUwPk+5jcoHdyw4BIu1kwNEY6QOBkdv6gsS6c3TuPy3k0JwKB93h0
 fOMRcIaHEOlOn25jeLblSp/mrdVhZCAb5J9U3ecVDSBU1Kep9OoFnBimg+yTRWtG4u46uAElXsq
 PpizulwSizhLUPv32+Szedtdb/fRJRpNR9vqfAUJmc5QcV6kSogBIO0cpM+bhQdKJLNklkClg8u
 itHCVH92adX1pQ/CJdsNgRTGzExAZSkf7OnJhhctcdmAAD8lOYWKC/Eb6VpLmoVFgxE58V5ldX9
 BbfgdcO7eIP825VIrDzxhl9u85az+rqkOPQlcrysLmZiW+B3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: fTysLjxSoAzlkSTP2jnw10bDa48IIcc_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX192t2qmflxCO
 28cIACzazufD1pYGRiutXQWz2672ZHl9uOIwPzAoX+XfZYhTjX+XD883wp2VbXexl2NAK759g7s
 zkUF+1ohqM4jNzdZmeFGxqvOMauA30HaEntH1bttr9JiS99yWvdRblXmizig2QUkF/SDtHsx71+
 Q/iSCvCEivM5MVzSPlisUN5r8ntUG/gKcQbk29dg8O+c5yANGiU5/pBl3s8zgxiigHHWm4o6Fl7
 0S+HU4TD4q4SmF/rXmCJYBVpUPsG9C5MBpU0aVdUzPJJveruvgmdmSDlNfVS4iRJK7jgmRN433B
 QdzZSI34MlAokACJ2xx9o0OfCXVG0lwI1utcxyroVvFwpqmDp6rr6TtJz1fEG5nLYLiLWJcgJBF
 ux7RlNbeI3I1RN7mQ0PinQeQvvDdhsuU/3PM9oXnFIhdpa22jZRacJVCx0oPyDl/YhqhudJz5We
 YyDAwGtmat5kKEdNwIg==
X-Authority-Analysis: v=2.4 cv=FPQrAeos c=1 sm=1 tr=0 ts=69da3a75 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=ClTKKeZw4Bcbv9k5X4IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: fTysLjxSoAzlkSTP2jnw10bDa48IIcc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

The Waveshare DSI TOUCH family of panels has separate on-board GPIO
controller, which controls power supplies to the panel and the touch
screen and provides reset pins for both the panel and the touchscreen.
Also it provides a simple PWM controller for panel backlight.

Add bindings for these GPIO controllers. As overall integration might be
not very obvious (and it differs significantly from the bindings used by
the original drivers), provide complete example with the on-board
regulators and the DSI panel.

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
new file mode 100644
index 000000000000..410348fcda25
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/waveshare,dsi-touch-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Waveshare GPIO controller on DSI TOUCH panels
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  Waveshare DSI TOUCH panel kits contain separate GPIO controller for toggling
+  power supplies and panel / touchscreen resets.
+
+properties:
+  compatible:
+    const: waveshare,dsi-touch-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wsgpio: gpio@45 {
+            compatible = "waveshare,dsi-touch-gpio";
+            reg = <0x45>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
+
+    panel_avdd: regulator-panel-avdd {
+        compatible = "regulator-fixed";
+        regulator-name = "panel-avdd";
+        gpios = <&wsgpio 0 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+    };
+
+    panel_iovcc: regulator-panel-iovcc {
+        compatible = "regulator-fixed";
+        regulator-name = "panel-iovcc";
+        gpios = <&wsgpio 4 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+    };
+
+    panel_vcc: regulator-panel-vcc {
+        compatible = "regulator-fixed";
+        regulator-name = "panel-vcc";
+        gpios = <&wsgpio 8 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+        regulator-always-on;
+    };
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            reg = <0>;
+            compatible = "waveshare,8.0-dsi-touch-a", "jadard,jd9365da-h3";
+            reset-gpios = <&wsgpio 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&panel_avdd>;
+            vccio-supply = <&panel_iovcc>;
+            backlight = <&wsgpio>;
+
+            port {
+                  panel_in: endpoint {
+                      remote-endpoint = <&dsi_out>;
+                  };
+            };
+        };
+
+        port {
+            dsi_out: endpoint {
+                data-lanes = <0 1 2 3>;
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
+...

-- 
2.47.3

