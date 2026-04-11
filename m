Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A630F3ED4D
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E210B10E1DE;
	Sat, 11 Apr 2026 12:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EITOwlpg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RE43pFGy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA8210E1D3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B40EuM516803
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B7mkAgduLRIwjHS7HjVchMyGBpOAMFCr+vZmhtUZ640=; b=EITOwlpgdnKjwFHO
 48WMXU3hvSeIN3rejsMYcKnMxz2l50VMm8YQVqgvU0wV6X3D3cszHRmijJJEOPWL
 SjUxUYP3d9ZY105unmjjfJrrgXmgaGIGCVfuxoUo5t9MMAUh89nUqGkjMSLhO1Kb
 KlWSGcgYL6kiwTeah5Uf8gwiShYV+mkWKIhls1Rk3OJmEhZXNKDLPyW5BhVfU0pq
 3eJcjjj0a6CDhvGA5yGld3cB6Nq3KZcgD8Z/BPwoCDC7kmAgMip1MRrfwS0bs4oS
 mcWrRUdGScta5liECcLCqY3VkdVlRa2HJ2l2IZuNSqr6LapYKPKQcFOZ+s/OIpod
 kH3q0Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtgngc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d9a6a853bso73603171cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909459; x=1776514259;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B7mkAgduLRIwjHS7HjVchMyGBpOAMFCr+vZmhtUZ640=;
 b=RE43pFGylzDf90qyKuKt3Ghy5jf0oVBHiUTyTm20rJqN74W8gdj1ilZCr7n4ipUznd
 pwE6iQfx7Nfps9deZpyTjN8IxFiFMcVcYu+Y5ba1Cq2BrEQB8SgI5qv2eu0jEPiR7CQG
 I45pnZB6yLdqnbAhKaf6uH9afDnxMmM8KVBls5MXvaljWlzaRfUYMtA3ztT1HLZomGOl
 584J1YipxXh1CcgfTjPydFD8rGLfRayTY57Zoq3N1qjtfK/kPChYZgVn6NJ3VsMdtoy6
 ZpaCIHwfXIH3IetwtcuZZ9QnodPB8u7UlfCLf1h/KQrJueQMo/r3AnqrAPPGp0+gkPqs
 nIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909459; x=1776514259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B7mkAgduLRIwjHS7HjVchMyGBpOAMFCr+vZmhtUZ640=;
 b=Gtp5mqvXnMCv8GqLrbNX94kAypr7ukhVAWg5qw7iHUSOh8A56lwZaz8HorTL+IB+Bx
 AapC/rQ92LakPpwA3RmEnLUr0j0VlTftVCspKnBE3IdmP/vU1m8eqAfX9HNdFELQztsF
 QVFXMfYfFHVYjzGiEnS1aoliFY4Wp3OFBX5F+dgFq6p4SR0caBNztVXDQ7wmt4gwbBs1
 FWRCCA3YMZhx7XG+LsxcDa8jV+CyrYiURONAzRWCNryp7wvxqdQsWp8jyFoIXoA6F8Gq
 xgbdOyqhvuWSnzt0jpyfKu4W551VgrEbvoS+qIWFHotVf5f9egfzpa4jBeRQJ9betZSX
 /Lpg==
X-Gm-Message-State: AOJu0YymFE+KVX4vlmjcoRFLFwRjSLb8RMbxxNfZMsI+1fMXqEJsPyJR
 qOUjM//YC+gRLXD5AUDagHeXGrXopTt3jQVgaOnbLdDaSCsWbF4EPK+jXnTkpsZ6l9SHDX3Ixjw
 l7HhNGODBQDT8fLPId//vaBmi3wco6tA76rdfvcYNxPrU+Iqn6z2/HLEvmDRm8dbMfdMeiG8=
X-Gm-Gg: AeBDiesUR+uIgc6RnG8uoZZOKDC6YSayxK9xxMVZMERx3PgYgljmyml1tSzX2GFUxYz
 WbtbUL/adq4S/Pw2py9GxVGlyqmPBqv73Kc+F9caUPAUcJK9TizfCeOqb/imsrYxeLpDMiquteL
 iOm1xQBTvQ58qddl9WPM2MiHbD99FrwtdeDHeeasX+oqkJP79PuSRbci4twrMg83HZjEAxLHqyW
 ZO3TXeIcGLtxu3B5WNyFCVpNo6kYIt2wCR1q+MzZh2zfjxTcUxgHnqFBjETp2J9lKBBZFob/45I
 eW3QsVeUZUvSEKgzw8t/nkF9Kdb2xZQORKnYN8hPxGHsNaKyhdX4L/osimwM6HtJwLvjtMRH738
 nkzk9IlOOKgz3Kt488WR7QG8zAVMuPRgqX0FFp0ZSn5iDN48gYEdeHNtvIN0BnOHDOndvzNmOE+
 UqdAnSi4n+zP5FBxiOSdSjLQ7/kc+PdO2YdBI=
X-Received: by 2002:a05:622a:59cd:b0:50d:8b40:d97b with SMTP id
 d75a77b69052e-50dd5ad8ef6mr101502081cf.17.1775909458963; 
 Sat, 11 Apr 2026 05:10:58 -0700 (PDT)
X-Received: by 2002:a05:622a:59cd:b0:50d:8b40:d97b with SMTP id
 d75a77b69052e-50dd5ad8ef6mr101501651cf.17.1775909458536; 
 Sat, 11 Apr 2026 05:10:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:25 +0300
Subject: [PATCH v2 05/21] dt-bindings: dipslay/panel: describe panels using
 Focaltech OTA7290B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-5-75cdbeac5156@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z9LTIc7mkl8iWxx7biEWKT9WKaSV6D0MGLZPFj17wto=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpF1TANS4p4rX2cYweDRiiHMA7RoKoPoC9QX
 c6o/e1yVUaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RQAKCRCLPIo+Aiko
 1WtSCACBJdPTyjoXeeXSRIv58J/lofWPnpp5jcJnhszneW6J3/v4wsakJe1FN4+zbnjl2MKC33B
 3+lRHRCxFd8vDAnxX/Wq1+XDBWttO/OaDi6H3XkM+sVPw9Mv1IjZG9gz/MJEQslATnIDIcS0qwH
 gi15MoN40fxlT4HKJcXm3zy2OFJkRtCW6hXWSc9rxGFEtPQ6pDHqGB+/P0tQ/XqiFFQBAQuP7iT
 0GkJp9b9LGX4casWhIoZLMNZ26WsXarMBsGL/Wjex9ATiKgCQVDH9BpwtYZBQ2RcY475rEMhOwq
 bzXo9vmAyMLfZt5hPeVTyuZamNjIyXMFbFa0vU1K3JyeZY3a
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69da3a53 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=QaDNpyu5kUm-e7c-h_IA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: sDIMCuGbbkrEJmzRmsyHhnj4KzIGI9NC
X-Proofpoint-ORIG-GUID: sDIMCuGbbkrEJmzRmsyHhnj4KzIGI9NC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX1BJzbLrwVBSy
 OvclPzS588sbHFCWTAFgGWLK8SRVQCsoi+WYvZW0mgPW6l/X7juopqx/6wog1sH+oIhDKQ3QfgQ
 u6AJ4TXpvyP9+fSpN+CX8YIrGqM7/mWLPh89qSZIjM2Vj0fuIYickrQcgixOJcSJ97P/1K8ip2m
 hj/iwh4X1JWl6UfUSt92EZ0uuWojH6Q0el82PuO0rZFZXyKp8zuLRZrb+PFrnkMqHGxbORmNV+j
 ZCZlLpYyYtUehjrpIfjJuY/VLSkka3YeZQvbAzx/0c+NeGqvNU1LNLXAVbJFfzxAv8j+Pq8X5lo
 QFJSQCEXIF0l+t76AxrWNZ08Zuu3aXKFspYq4oqiBhXELwj+985+lO2fdwZskan7y08xZGGlBEf
 MBNsszn8y74YSYGocQM2/0TTaIvd3wU3zD+RZPxoBTTvu10lcgcCaMGQYBfmTIy73KMvvLp+cQl
 CKxWZpKbIASSPdIMB/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110102
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

Add schema for the panels using Focaltech OTA7290B controller. For now
there is only one such panel, from the Waveshare 8.8 DSI TOUCH-A kit.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/panel/focaltech,ota7290b.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
new file mode 100644
index 000000000000..f2f6e254b7de
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/focaltech,ota7290b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Focaltech OTA7290B DSI panels
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: waveshare,8.88-dsi-touch-a
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: supply regulator for VDD, usually 3.3V
+
+  vdda-supply:
+    description: supply regulator for VDDA, 7-10V
+
+  vcc-supply:
+    description: supply regulator for VCCIO, usually 1.5V
+
+  reset-gpios: true
+  backlight: true
+  rotation: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vccio-supply
+  - reset-gpios
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
+            compatible = "waveshare,8.8-dsi-touch-a";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vccio-supply = <&vccio>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+            backlight = <&backlight>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mipi_out_panel>;
+                };
+            };
+        };
+    };
+
+...
+

-- 
2.47.3

