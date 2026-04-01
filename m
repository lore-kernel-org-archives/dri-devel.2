Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F25FD3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031F610EF64;
	Wed,  1 Apr 2026 07:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCoAj8BQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XysuJwr+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11BE10EF64
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:27:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316HZv6639212
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sBvoySoeYPTqCC73JiWh2WN7eQdyTDqqIwz/3dpgTxk=; b=QCoAj8BQqcGZB8Ij
 RhWfoHLW9XwJ8NJrTgy4j/hn8qLuL8UEJ8+pQtUzbXr416JutLAVaiO769oMQV24
 pvMl5yub73qGVensZODpy1XvAW9HgAHEPxamnu/qh089Xmn5SvMOjemgHST4hDFW
 le49YWRBp4JSd0j9VwkuS+GARsa8oS6BAW//4+5J+0F0V+oI/vvPT13hqTtIRmKx
 H1ms72LHd3co8EQfv7qUSy2WMUlDomT/NOPe/AWbMza0vgvgIfkqnezma1iJysBq
 kyCjd+YiavtebK7K/NUiyV78mn97v3iKHwpwOxwNihjlnMrQqPhpXyJeHeu+GpCz
 nR7R/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2auxh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:27:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5093a985e21so166347571cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028446; x=1775633246;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sBvoySoeYPTqCC73JiWh2WN7eQdyTDqqIwz/3dpgTxk=;
 b=XysuJwr+Qn5lSyjtKWiQQ8SLiL6MtopaU7GfE6OUNnitrZxFmOfTuXaZHzGfAIuQut
 YNzIeYAuPEgNJ6oc5MNkWggQgdUaCg1XySaFu2cIjsmgovV8tc3D1OeNaWXQ9S1hrHph
 fhCpI/OHz7g65Xvi79yBhXqIQ2Y92Hzcd7edNeArYkW2P3Ue29feABeQFqe5848vnaw1
 lw6vuNij6fioGJGjX95ArO+Go8JemFqKWDBKO+Qq5nSlasNOD58zm7ptS975zkkZTivp
 ZzsnR/Kn8A9Ik6J/AcWOP4Rz6JtrzyNhCXYtAKBDvbD3oqSpRmVFpW2aYlcpVMYqqzy7
 +Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028446; x=1775633246;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sBvoySoeYPTqCC73JiWh2WN7eQdyTDqqIwz/3dpgTxk=;
 b=Ux+QYldW5lSO/3MCSYTfJDQkJiA8qrE40IhW3zJcKH49lIWGndWiVbHNv/+E1GC+EP
 qWz/Q+aqtQrch/qvj+oGdUKxxVcWK68f5qaokLjP3kkarpgUzKphdodVhy+te06l6l7R
 aVQFVPsWjBPLeF62//hfUOzFA+QDJqCQrAW7seD172QxyU/08jzUqv6D7rbao2iksZ0V
 UCj5eoxHtv/hdPNwZJ3xpR98KknJgbJGtGp9r0gXM/87agp2F2+caxA3ZvZcHjw5j2hG
 6Ppr2YwGJ2AgNw3BEIymeVL21RU9rF8YQU2bt8I+5agkRcL2KJqgkx+pqpYMdQZdbQM0
 A2uQ==
X-Gm-Message-State: AOJu0YzOjyLW2iMqOlbUgOpOSbWePQLzT2CZZzhXIcV/E/p5PPHY2wZz
 DFpno6nigN1jrbEFojIur6jUhrjM5+yHTaVu1ALoJE6RlJDJL9c5dgsFukOsYpVBDtEatiWIQwe
 JJ2AuKPDa0S3lWRQV2k8j/BVjtsjI4xpRX4s5IeN83R2hD9kqHnDRvpypBcRmJEZOhRm2GeA=
X-Gm-Gg: ATEYQzwmeOKKuClOA29IFkGNDK7zDVDe+hWbz5sIkwTT8vdt80lcINwB26B6pRPsv65
 Sd9lR58odsozQqWKZNL4kK6a7sGn63gInhLUyYQLnFMN0SU1kouGyZ8dDJoko96mDwN7GKkREdK
 VUyrHcHaDx+HQUzhgIYPRQcrvJwONeTEEQVmzqT4IpndIspouW+Xb50Tqtw4HxiMMstcdI3cijE
 //J4iULiKuV0YBMD6BBtqPD+HbeWImddRsM8veD6qoQButEVB3HMXL/uIRpKVva9C9bIgmne7sq
 /LqGVI98/wx99Z/82/SWHhkcEhZEIW9RciGJ2H6cH4W/L/MnhnD8KtHxNxXW0TdstbEpFZJkPhE
 k0oZ8YchWcR0KQRKrNyt3oXwiPpWDDMFfVEOwdt+rHtUAnwrGWr54jHHh9yEMVS9mV7g5KK69Jy
 iqtndNqGpKaBHQO7b675zE6fIYu8PzpE0CYzY=
X-Received: by 2002:a05:622a:4d44:b0:50b:37ff:727e with SMTP id
 d75a77b69052e-50d3bcd6cd5mr40547641cf.44.1775028446029; 
 Wed, 01 Apr 2026 00:27:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4d44:b0:50b:37ff:727e with SMTP id
 d75a77b69052e-50d3bcd6cd5mr40547281cf.44.1775028445581; 
 Wed, 01 Apr 2026 00:27:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:27:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:37 +0300
Subject: [PATCH 18/19] dt-bindings: gpio: describe Waveshare GPIO
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-18-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3596;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HtwzxipjsvoqNyUTrD+D5sP0QrlPOyCeD+T/UASezKA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMitIROjhvWTZMh0HuxwLl6RLwi2dOSpLP4PQ
 63JxM58QDWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIrQAKCRCLPIo+Aiko
 1fFTB/4nRUdFFEb85PbFCgZyabFbNUMA4V+tVCnyUm+SYHghuDXjxBcCFVnqQhNafu1K4xcGGiB
 VwkmMjSSEN/x+s3y6YNdN933IlUJSZbnY5M5VKo+RtRva2IjZC79yp7r6doW2wksSlhx7d3n6yF
 RSviYmx8ORBgAJRWefPP2YxNVneOmgPCd8gNHj4AIGh+qdqMjV9Izz5C19OM5iNNys/lnczDj3z
 Q5zyPDh0f1mb1yHeNuySA7Q9mbs+X+v4AiZtJqkaV6zHWpAJvxun+CAPRXfuAysnJv04+xUa/x6
 Uxz4N1lx6KS3QWDLiM/iKcCUF3eXqvzeArFXI5g9K5aDVz0L
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX52UjcR9ciYiT
 7KqZw+ryhIZLhodoZUqXOgJfKw3YVpqdXR6XA93DpT689ZvblWEog831A6MSUSAGDOlganIVe1J
 L7p8bjyfj2vzOiLpa/YToV0AWPSaE4EXXTj+Me3Vj7mUKt4+iMNY6CwKYw72XWG7PeHEdMAJFF5
 PpYis+Rs76jzwfOnGwPR3XMHKRojkWATjaIB6fw6Vw4dKNTQNuH3UULIa+W2jeFYRy0x+3y15Yy
 z9L7axv+kxVHPySfRzWQqh0V1Hyh0j1OVYqLpmo9fWaKe+a8boSFV8REkagBMGTeN7YLNqdkSwR
 7M4077wFylkTaIiCeyGuEZnZq3yVlX0V8lxsTg8rzO4uW7FkFFe3qIrft2nsfmRHXAfN9Odrvua
 3c3asuOTyVwxy+5skjGSaIkgyWKpMz0fHVN28TFPWGTQjunHl4pphv/fKioPQUv/oAM9cFaqi6M
 MuaMlVKLyEWnNfU739g==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69ccc8df cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=ClTKKeZw4Bcbv9k5X4IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: rRkqbHM0FRSiMcYJAOQZUbG82ZeCuZPE
X-Proofpoint-ORIG-GUID: rRkqbHM0FRSiMcYJAOQZUbG82ZeCuZPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
new file mode 100644
index 000000000000..2e622b668f2f
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
+        dsi_panel: dsi_panel@0 {
+            reg = <0>;
+            compatible = "waveshare,8.0-dsi-touch-a", "jadard,jd9365da-h3";
+            reset-gpio = <&wsgpio 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&panel_avdd>;
+            iovcc-supply = <&panel_iovcc>;
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

