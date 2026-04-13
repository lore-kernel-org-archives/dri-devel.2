Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2FAF34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E54C10E495;
	Mon, 13 Apr 2026 14:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tu9OBUKn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJq263hd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688F510E495
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7SB6s1463124
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YM4SiJ2Zj80hOp1krAUX7NiRV5WgNIXZzU0sB+g1E9U=; b=Tu9OBUKnDAQSV07M
 dcK2CIyAVspJE/h+baTOjqtp3WBm1+eFGCcwbW3tycfCi9Z4vgIiOlPSiBBTVDGv
 RYpv6UzAFZTgFHYj2jYdorktUL0MBHZzVa/5ch6pqVYnMqPVGZuLYXava7F+BVWu
 3a0WGx8ugiXJgweK8/oWF3fi47At8oOFExKen5WqSlX6SSTlCQ04PZ8100p+VfLR
 L67ecL66Jr2+Hs5Ap0JgiK/m+Le6jth62RU0hmOXpgOqwrckhd/VTs9Y7uVRGJIc
 74xCrt5mgbJtA1YqZ0I9nTSFdYa3ScTTdCau3ikl9SKeJZkXFTm/8pDY26LfoBqE
 S7dgnA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfwnv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:43 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-467e8ec004dso5456170b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089143; x=1776693943;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YM4SiJ2Zj80hOp1krAUX7NiRV5WgNIXZzU0sB+g1E9U=;
 b=jJq263hdZQpWFCYOCyz75dlF75WrzZ9krOKyijhv/1UgoBl/xLGM8nZ5UyZ9erJOR7
 A4AgPozZF1aMTer25w1GRxhexok9ORfCS2u6eUa1V1K2KH+Runy41gios+eteRkdBGMZ
 8Vm+Q2XOgqjxFevakj+69reT8bu9yPP8qoUC6r5P/jDOauXrN1QYP74Kz21KHjAgRV24
 WKFec3o/LAyH+M8Rb5qDVOLGAEwNIOfo2yNowSkJzyI0nn35A9mklyofGgNkjmleoimO
 hPKhgXEpmHyhswb2faXbql0ApXND4k0Nq/rpAu5pSoj5t38l8pGNe/Lf+hDOUMog5yeM
 GOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089143; x=1776693943;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YM4SiJ2Zj80hOp1krAUX7NiRV5WgNIXZzU0sB+g1E9U=;
 b=LpFRW58ieKFoIEU3Ag5fD5dXYZBd/OFfpGQhYGxLoMiZvv/FG3VzQIXQuuh2u5gCZ6
 2vnTB6mmYckOlc0YWvtWEtuPEkZN4xE9CWgo1hysJqrzRXzmcsoBPUN+RTJnjxEN5FxE
 8MdsglfO62o/S4bcveAx0a5A3QmeqsC3/56MxEep86vYpUTRg7RTBFQVABZ2oqXjfPLh
 KISQYYt+wj5aWrnO7e1J6lagrfHBY6werQgszeycaxEkZMFG72/QqYMfow8+jophyMNx
 AAx+0qANqTKKLRyCH7U3opV91GTY26p09POCBpOou3AqfaoVf8RJlqpyCARcLjFLNlG0
 5Gww==
X-Gm-Message-State: AOJu0YznijCJFcL/lyvVuZqV09cqcn6fkXRQi+GrvVYskvlAFfUg7Egy
 xIn/nWlNQFylc24/BGxYp5oH2EtOgarMTCMd9TkWlU07vib/GOXehdE3znuVLDavC0yuvd5jKcs
 0WkUOl2HJJZGwbjRX4MAX9RgDBqyl9bF5mIgXBigO0ff0ntKFwQAASXaMnJ4o/KzdXyR7yGo=
X-Gm-Gg: AeBDievowURGqb8JUlTPe4V2n3MdbB1Ip4aIlQs3cnDYyGp1ztAEfof04YDcK4f6Y4F
 nbRKsLZiHcWvCCPblGQYoZufsEP55FFlDPDPG2cZXM/TDvkdmws1huJwseSs9pG2WiVHClKKca0
 jZT+CCY92PQV+iA41B0twQS8X/h4P28g5Y4LtomKyyHTbJ1TUklwsQ473M2x0AdbwhgFnIQaPeO
 F/6sNEx8p3o16XZbYxSRmDvlU1QbuMk7n7RUlsapk9RC314/p1QcIcXVkTCXDYE//TQl4TcCoTn
 zaWM/K+mXQOVLOjALsaKFp6aSeF4mG4PWrF91SkDZAqIObqRiiMsCr722xCqISAVSzX8eSEV1nD
 MyzS8AH+a3RYtzJwPs+cnWJixYyACzegM9eI4B6pYWjdBppVTwtbL4I/powz61lXTFNLNHsIIFB
 gKgtgK4WcE7Bf8OohYc4FHE5/1cIWRYepnd8M=
X-Received: by 2002:a05:6808:2383:b0:466:f3a2:dc37 with SMTP id
 5614622812f47-4789e91d1a8mr5906340b6e.30.1776089142556; 
 Mon, 13 Apr 2026 07:05:42 -0700 (PDT)
X-Received: by 2002:a05:6808:2383:b0:466:f3a2:dc37 with SMTP id
 5614622812f47-4789e91d1a8mr5906300b6e.30.1776089142010; 
 Mon, 13 Apr 2026 07:05:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:28 +0300
Subject: [PATCH v3 05/21] dt-bindings: dipslay/panel: describe panels using
 Focaltech OTA7290B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-5-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2185;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YNT6HJHw0/nCX1SaijWIwtPuC2ZuLp0/LuAjLLjwj8k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgmQoSiaFtAo67akgghmrqYUVSE4xx+oTpFU
 qpAdn+c9O+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JgAKCRCLPIo+Aiko
 1aP4CACKe6YIma38tUfoF6tvlx57U2bDp/AxO6wcWq1ufDdvaZn8fnEuXmin4pgufvz4UvE7R7/
 aJKpzBAUb6GXnjaQiVD36SMZuzXvHqtIZJvdNzygr26s19zHWR7OPPcrLcd2iI8rrMvIeGY09gL
 V38Ja9fv/f3/xmOICslXPQvGVOfAe7jxFy06rBdmkYYsGAV7k2lTg4/OYeF4+Huyn+gSkBz0QG4
 vqwpCcg6JuuE+XdOZTUA0pSsmBAcdZ+vdfktD+YXCTyxO1P290H7x18peGnz4LfOZYAjS+s1N1J
 VxcBZORCYpciuv8u0ViYq/lIyQhNV+HUaKkm6Eyb8Rtr7ABo
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: kT7Mywr3xezkYhX_mvCnnu_Ye7GHpjIh
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dcf837 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=-Tl1ayhUDf8JvLimEB8A:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: kT7Mywr3xezkYhX_mvCnnu_Ye7GHpjIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX7ZnxEWKm/OOA
 3JVxg4lxaOB2MyLN83122mkVGRyr9jYNijkbioRKloit+earFqwlbj3SerdzGqV1f3lM92tkX4j
 uo8iU1wkpZATm/cjgT7FcgRLeG6kB9PlwZ+RqaiZO+2TuV68HTLSnUhW05V2rqTYF/7q2IE2dpi
 wlWQ3HMwvNhvTUTPr3Rp1B/yJ6km2pdhNFv6LirrvFZNrmNdBcSbm3wXqQz/QYU4YJEWLz4T0Qa
 voTG7FHct51GC+1wlr1RAWowOrTh3cQPD0VmmH9j5d3YVzif8bwncthuk7nwgjUmHvMVV/PJZZH
 ST0zGJQbbDoJvkIxCJkmw3/Vmc/OoxXWwljNG2PMQaeDA4bOHsBxXT7u+4OmUwl91zK9QfB7xbR
 5mj28PzDsxyNAC1qrr2DPOPCvm+zzq5JfcjNvCiIoSyv9VoF+z+82Yro7UqpSO8uDKY5q7U30fn
 dL/+s+DQZ2GXfP50u0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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
index 000000000000..db6775f4d75c
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
+    const: waveshare,8.8-dsi-touch-a
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
+  - vcc-supply
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
+            vcc-supply = <&vccio>;
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

