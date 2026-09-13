Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E0BC88E5A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 12:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E81510E0E4;
	Sun, 13 Sep 2026 12:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTM+lnbI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GhlQxFOg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297AB10E0E4
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:33:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DAU0k02052509
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fpGKnPlwQMJ6d2jd+nVDM/rLtIW0wAEYfjJ
 WJ0/R6KU=; b=ZTM+lnbIWAuul4Hcc1MMF1HCH6I/TcSe78+k0+DQpEJZ1fEdrLd
 cZiGKC4sCIZkwHPKu0vru9hnOp2QQRLMO2SFxQzmJIKWD66GKfkB6kg9fDx5A3qT
 9UQ7s7PmGOxsfgp9Sy3iG2t0zE1VaBVmehixQfTN4u7EP+kOlGK4E300Qi6FOoQ0
 FIO3LK1Ex7akrRHQwIh6lTnATnUiIA/JzgM4a/tzXU8APjzSm1dNeVac3KeolaBt
 vn3UWyZtZSt0MfGElRkoPf1NMpAH3u8JT/jyLmiRe6TeBRWgtEXAD2zA3xRs4//N
 WSO8b506TXCzQnFVuTGfvPUCbxjyhBbbipw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dk7h8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:33:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0050a554so336681585a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789302787; x=1789907587;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fpGKnPlwQMJ6d2jd+nVDM/rLtIW0wAEYfjJWJ0/R6KU=;
 b=GhlQxFOg/GBWHwt9zTjyw80DvS6Ku/zv6cZ8kZroWvCs1i39DI/RFv7TiRqOAzUIQp
 IGVGS+6lfY8dO1hNoAMkcTo3H9tyL0PewpjjzDR0JsBi6/VlGJmxYu3sCEFAWWLWzAwF
 gcgeYsF/m4o9YHmim3c22cMitnJ10JJ6prkpAlqX1mySA+gPoYqSOpbd1/XAcSGBKCvW
 7hfNPRCBi+FEm5hG9wX215wPJ2HPch5onwMhrvkRARpdJYqCh/9TIV9+GYbkg4vXAQzX
 LUnCTr0jMIss/JZUGRnT7ZjG6vFF2JyYyK1if5Y4S3eBelDRxECqx1YzCsCzK9/RKgm4
 00sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789302787; x=1789907587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpGKnPlwQMJ6d2jd+nVDM/rLtIW0wAEYfjJWJ0/R6KU=;
 b=ecdL8TNe3PC3Gfef/yncH2cfKgFudktVqn9PL0hDZL7u7x1jI4P/QZtIBiKPqnVhPK
 FCgVyr3M9+C9fy8SYSq7Xk9P/HDKZIGQMkpYV9wu3/w2aWhxg5fDXO/K8oEnNVbmbJuD
 /fEiFqypLYNqxitZgjSox4Ai82jGch5RI3qVn9vvRO97ANIk4oz5TUUr6n87ASKO0uJJ
 PrgjqTCFbVRyy0gy4WPgruqLCue5bh9PqXFOAre0lamyT84LzyNcGjW//V97HldkC4/4
 mJdRZSX2L3M2UFv06cAJG/+ehf3oBER485X0b7BPEE6H4PB8gUoFsO0Ar0gH5vu2uVBp
 E1ng==
X-Forwarded-Encrypted: i=1;
 AKwUvByW1sh6Gcpn7rTVJWSmXnVqzOr0hFcbk/CxIlUDoEPWYJ8U4a5q+poZENukilWfV8CmNnZyJNS3gfY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kFdfziQC/sXaQ00d0akEoA9jUzVIh5mTpXZouzq5rLdUFs5vtG
 Jy0hFLLSmW18YDn/ed5rhCVfJHdBof0BoDFhmr2ewhTwlExXtsobeCONpDJEmGMGZxE8jbsykUS
 jlhErJ/P+c987Q1PFNcZ9ZR5Jbx/7W5wOMjBE8pqpJUzAJk4QJ/mDMUXaVti3K0ne544e8Bc=
X-Gm-Gg: AYBFou1SrCCR5z4CBlvTdeBhZJA2r9JEnEkkTGISAa1QKR53g+SygwtYFyJGDYlgu10
 cHu84QiongbRfDyPs7Fc7MoS3EazU6bf8SfEJko7C86em6/KNMXlYeAOOFDpWcGptle3oma0PIV
 fJjEkRCpn4kYtsIaM0k7fn+rADnZZTmqMbaMSm9ZZYTglMGQpCZMYv0hSVplR+YeSoXC4VwUKvH
 zQ/o8kOwd86EMaOiAGRxlPK7Opi+pFTmzZ6CIF0qnG1/+HgSVHGysRJN+ojRrYWF0Jh7H6Thwgq
 +zJR4YgJ81pm9OgWiDC8eW3s9Z9PhjrHDF+5YlgzuEqkAWm5HPm4/v9hSLT7kd8caolRM0z41UK
 NiNKIYDvH86QZsvE=
X-Received: by 2002:a05:620a:8390:b0:93a:83d:1d26 with SMTP id
 af79cd13be357-93a083d2432mr875126685a.32.1789302787191; 
 Sun, 13 Sep 2026 05:33:07 -0700 (PDT)
X-Received: by 2002:a05:620a:8390:b0:93a:83d:1d26 with SMTP id
 af79cd13be357-93a083d2432mr875122385a.32.1789302786689; 
 Sun, 13 Sep 2026 05:33:06 -0700 (PDT)
Received: from quoll ([178.197.219.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm20863041f8f.27.2026.09.13.05.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 05:33:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Artur Weber <aweber.kernel@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Aleksandrs Vinarskis <alex@vinarskis.com>, Andrew Davis <afd@ti.com>,
 Steffen Trumtrar <kernel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: leds: Use consistent indentation in the example
Date: Sun, 13 Sep 2026 14:33:02 +0200
Message-ID: <20260913123301.100129-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10147;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=AlIaJEIuArFUR/Ki7M8tVpoeGLbBeitAeHOitnugLnU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqppf9BkR0CkRS49lp5YPjksTU5OTemdYktvvon
 lGCs9CU1+SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqaX/QAKCRDBN2bmhouD
 18+LD/9eTwuH4DhTOVdNetOCBQo8mjmDh6a46105Id9+ghu8F9b+7iOHiFMhbH/AdIA0ZAIup4f
 ZTB4BGdCmpmHTHp6DwZSY5j1FPDvr1D4h5iI12xvzO15ohg3OY04iOS4XKzXQFQ90F3IP7W6nOW
 TIGe3bQtAKCCp8tRxMQE23+eQ7nUv8AOMtIhhFQc5Q6KamCzz4yDMdC4iKDZIN12c5GzdXxO2T/
 72h2eXlh1ji7s3lTNlcTbYZOQClhpyXO8DA47EZIvZjKUaRWrKliD2OwRgVqesIKasXdbxKd+wx
 bHcuTklRP2ZKr5rN/XTnhjGzWJOgWEpQEFSDzPOwnP9oS8PNnSg5355vTA7RgYNYOXDNVd9zkXa
 oWu9ecRoj5S+3LHmoYLyWRP0GEkg5YCBy1JdoAAqx88JxnbOHUUgWAfkHbmOPYYyULs0Ury3b1L
 ByD7vZZ2dG6J8AxLGi8XCx9VRiM6pu6nNffefgU1gw/HmNM8H2V8850EWjqfb+cz490HvkIIzUy
 De4qYJda1Ux+Cr4abTGe9mEf1pTmvAJFzY05UbDzExqZ8XsbFHAY9f8WfvvC87YstXzPk+fnT6U
 JUbce9aHBVECCmt7GscfPtKtfwuhuEhCs86If+FdVZMzHrhvvAsKJ/xIehOhfpJdSF6xJUFZp7j
 s6+waFjqULVNcWQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _BVuJCqbZDHk78xrRwi0aX-EvKUMmzMg
X-Proofpoint-ORIG-GUID: _BVuJCqbZDHk78xrRwi0aX-EvKUMmzMg
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa69803 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=a7949CMAvHCJeXM5QSwA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDE3OCBTYWx0ZWRfXwiKl2RMzUhy1
 UYO8ov5ObfTR8ch8eEyILQVBqZeDjZ7ROcvU3dfvWf3RlLr19vbM1/wPGs1Ujkd3USo6Lc7wirD
 XRgDE9qDPGMNwdKv9ZhCwifCCd1Pob8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDE3OCBTYWx0ZWRfX/DkRFiq2/Xuy
 RyatEOFReI2k3ApmyO4IE0JYyNb/lngIYPKtFPhL8gbnYz0JdwL5IwaUhOtJGnzFKoeghGO00qt
 jOWKqSUlzLmpCz1vwqDfY+tkIUb9RfAjvw1TjETDWmSqM5sNtvpEVZREjGB3Xsh8HThN34X+1Y1
 EkMsKIe90vqcUiZHM0VQdtfduM/CNqOw5YWzTDmC3CTu0pXmV3nA9DVu/wACXJiakOy5EBKcluq
 BsxoSmBQ7HjpqQBhHhPk/M4XCoNmqjDkIjVC+jYFM87iXnxHCUqI6Mjw74UfGkeDoMnChbXPCEi
 vizaKVFylNJf1J0pZgc9RFdz1mJ9LURv/ABJ9NrF3Aauw4UHrpaThseXi3/AvqKgyDDCmTQETxt
 4d0HxdQS0Gi1gS9UoRFk3VO3E8PiOGkQEDAUB+IW/3bNRpSc4gST6IGbQnL35IK7Tvi4p9gdW07
 dgz3vZvDdCHYHtsT7oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130178
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

Correct indentation in the examples to consistent 2- or 4-spaces
indentation to fix dt-check-style warnings ("example 0
[indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
re-indenting entire example just for that is too much churn.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../leds/backlight/lm3630a-backlight.yaml     | 52 +++++++++----------
 .../leds/backlight/lp855x-backlight.yaml      | 18 +++----
 .../bindings/leds/backlight/qcom-wled.yaml    |  2 +-
 .../bindings/leds/leds-consumer.yaml          | 14 ++---
 .../devicetree/bindings/leds/leds-lp50xx.yaml | 12 ++---
 .../devicetree/bindings/leds/leds-lp5860.yaml | 12 ++---
 .../devicetree/bindings/leds/nxp,pca963x.yaml | 24 ++++-----
 7 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index 3c9b4054ed9a..6393cbf3afdf 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -99,20 +99,20 @@ examples:
         #size-cells = <0>;
 
         led-controller@38 {
-                compatible = "ti,lm3630a";
-                reg = <0x38>;
-                enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+            compatible = "ti,lm3630a";
+            reg = <0x38>;
+            enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 
-                #address-cells = <1>;
-                #size-cells = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-                led@0 {
-                        reg = <0>;
-                        led-sources = <0 1>;
-                        label = "lcd-backlight";
-                        default-brightness = <200>;
-                        max-brightness = <255>;
-                };
+            led@0 {
+                reg = <0>;
+                led-sources = <0 1>;
+                label = "lcd-backlight";
+                default-brightness = <200>;
+                max-brightness = <255>;
+            };
         };
     };
   - |
@@ -121,22 +121,22 @@ examples:
         #size-cells = <0>;
 
         led-controller@38 {
-                compatible = "ti,lm3630a";
-                reg = <0x38>;
+            compatible = "ti,lm3630a";
+            reg = <0x38>;
 
-                #address-cells = <1>;
-                #size-cells = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-                led@0 {
-                        reg = <0>;
-                        default-brightness = <150>;
-                        ti,linear-mapping-mode;
-                };
+            led@0 {
+                reg = <0>;
+                default-brightness = <150>;
+                ti,linear-mapping-mode;
+            };
 
-                led@1 {
-                        reg = <1>;
-                        default-brightness = <225>;
-                        ti,linear-mapping-mode;
-                };
+            led@1 {
+                reg = <1>;
+                default-brightness = <225>;
+                ti,linear-mapping-mode;
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
index 9416e1bfab92..2215ee1b2e5b 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
@@ -95,20 +95,20 @@ examples:
 
             /* 4V OV, 4 output LED0 string enabled */
             rom-14h {
-              rom-addr = /bits/ 8 <0x14>;
-              rom-val = /bits/ 8 <0xcf>;
+                rom-addr = /bits/ 8 <0x14>;
+                rom-val = /bits/ 8 <0xcf>;
             };
 
             /* Heavy smoothing, 24ms ramp time step */
             rom-15h {
-              rom-addr = /bits/ 8 <0x15>;
-              rom-val = /bits/ 8 <0xc7>;
+                rom-addr = /bits/ 8 <0x15>;
+                rom-val = /bits/ 8 <0xc7>;
             };
 
             /* 4 output LED1 string enabled */
             rom-19h {
-              rom-addr = /bits/ 8 <0x19>;
-              rom-val = /bits/ 8 <0x0f>;
+                rom-addr = /bits/ 8 <0x19>;
+                rom-val = /bits/ 8 <0x0f>;
             };
         };
     };
@@ -125,7 +125,7 @@ examples:
             dev-ctrl = /bits/ 8 <0x85>;
             init-brt = /bits/ 8 <0x10>;
         };
-      };
+    };
   - |
     i2c {
         #address-cells = <1>;
@@ -142,8 +142,8 @@ examples:
 
             /* 4V OV, 4 output LED string enabled */
             rom-14h {
-              rom-addr = /bits/ 8 <0x14>;
-              rom-val = /bits/ 8 <0xcf>;
+                rom-addr = /bits/ 8 <0x14>;
+                rom-val = /bits/ 8 <0xcf>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
index a54448cfdb38..bca00b774bb0 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
@@ -280,4 +280,4 @@ examples:
         qcom,ovp = <29>;
         qcom,num-strings = <2>;
         qcom,enabled-strings = <0 1>;
-     };
+    };
diff --git a/Documentation/devicetree/bindings/leds/leds-consumer.yaml b/Documentation/devicetree/bindings/leds/leds-consumer.yaml
index fe6a0faa1d3b..b4065c9733a5 100644
--- a/Documentation/devicetree/bindings/leds/leds-consumer.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-consumer.yaml
@@ -53,15 +53,15 @@ examples:
     };
 
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      v4l2_node: camera@36 {
-        reg = <0x36>;
+        v4l2_node: camera@36 {
+            reg = <0x36>;
 
-        leds = <&privacy_led>;
-        led-names = "privacy";
-      };
+            leds = <&privacy_led>;
+            led-names = "privacy";
+        };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index 23f809906ba7..85182ad7ad09 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -121,18 +121,18 @@ examples:
                 function = LED_FUNCTION_CHARGING;
 
                 led@0 {
-                     reg = <0x0>;
-                     color = <LED_COLOR_ID_RED>;
+                    reg = <0x0>;
+                    color = <LED_COLOR_ID_RED>;
                 };
 
                 led@1 {
-                     reg = <0x1>;
-                     color = <LED_COLOR_ID_GREEN>;
+                    reg = <0x1>;
+                    color = <LED_COLOR_ID_GREEN>;
                 };
 
                 led@2 {
-                     reg = <0x2>;
-                     color = <LED_COLOR_ID_BLUE>;
+                    reg = <0x2>;
+                    color = <LED_COLOR_ID_BLUE>;
                 };
             };
 
diff --git a/Documentation/devicetree/bindings/leds/leds-lp5860.yaml b/Documentation/devicetree/bindings/leds/leds-lp5860.yaml
index 0e88c71c2d39..710fec3738ed 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp5860.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp5860.yaml
@@ -100,18 +100,18 @@ examples:
                 color = <LED_COLOR_ID_RGB>;
 
                 led@0 {
-                     reg = <0x0>;
-                     color = <LED_COLOR_ID_RED>;
+                    reg = <0x0>;
+                    color = <LED_COLOR_ID_RED>;
                 };
 
                 led@1 {
-                     reg = <0x1>;
-                     color = <LED_COLOR_ID_GREEN>;
+                    reg = <0x1>;
+                    color = <LED_COLOR_ID_GREEN>;
                 };
 
                 led@2 {
-                     reg = <0x2>;
-                     color = <LED_COLOR_ID_BLUE>;
+                    reg = <0x2>;
+                    color = <LED_COLOR_ID_BLUE>;
                 };
             };
         };
diff --git a/Documentation/devicetree/bindings/leds/nxp,pca963x.yaml b/Documentation/devicetree/bindings/leds/nxp,pca963x.yaml
index a16ca11f630b..dac316741b9b 100644
--- a/Documentation/devicetree/bindings/leds/nxp,pca963x.yaml
+++ b/Documentation/devicetree/bindings/leds/nxp,pca963x.yaml
@@ -164,27 +164,27 @@ examples:
             #size-cells = <0>;
 
             led@0 {
-                    reg = <0>;
-                    color = <LED_COLOR_ID_RED>;
-                    function = LED_FUNCTION_STATUS;
+                reg = <0>;
+                color = <LED_COLOR_ID_RED>;
+                function = LED_FUNCTION_STATUS;
             };
 
             led@1 {
-                    reg = <1>;
-                    color = <LED_COLOR_ID_GREEN>;
-                    function = LED_FUNCTION_STATUS;
+                reg = <1>;
+                color = <LED_COLOR_ID_GREEN>;
+                function = LED_FUNCTION_STATUS;
             };
 
             led@2 {
-                    reg = <2>;
-                    color = <LED_COLOR_ID_BLUE>;
-                    function = LED_FUNCTION_STATUS;
+                reg = <2>;
+                color = <LED_COLOR_ID_BLUE>;
+                function = LED_FUNCTION_STATUS;
             };
 
             led@3 {
-                    reg = <3>;
-                    color = <LED_COLOR_ID_WHITE>;
-                    function = LED_FUNCTION_STATUS;
+                reg = <3>;
+                color = <LED_COLOR_ID_WHITE>;
+                function = LED_FUNCTION_STATUS;
             };
         };
     };
-- 
2.53.0

