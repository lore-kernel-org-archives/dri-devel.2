Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC545CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0202E10E910;
	Mon, 19 Oct 2026 09:18:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F0F10E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OsKL1168031
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AgUYNODUiYWHIRoHV8RdT5emAtiRnqkIOPJGLCENO0E=; b=khHrW0tSwhUduI+x
 e/J8OB76mrxEgyhZBdOQpu+RAdcFMcmcg75fIfOL4YvVx1j3bxyoFMmO2RjmtfB9
 iSD0AVSUez2w5IN5AaHWuC59SMnJGPtaFKuxEDq6/TbwbTXsX0Sn954enSDm35lM
 tbPCCTD5ZlpDrg1JSAotnaYvo7GD3MGmcu/KmpWqQk8QIcbCrZQ5sE3olrgVPxur
 AEOtUi2HbTrvBsl8GxCcMCPu/e3sIaTukddA5uIxwvqk+7IYV/uOkKuPsL83Rwj+
 3FqkDofr2sPOfouwP1T7hoqWCz9n2orx/hCWZyu5sxXqznTVABUg8FmAOGJ35//K
 SfC+cw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8b5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a3f673221so742281585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792401495; x=1793006295;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AgUYNODUiYWHIRoHV8RdT5emAtiRnqkIOPJGLCENO0E=;
 b=MRtZ5+X+LcWY9d6II5lr8D7Pv/ey4flVruXU3qfGo4j7U891mVAprmeXc9RPRC2AbB
 AmJv6svmaIMnTXQDDyLnRCGCI7hMZsnDWymYAh8/xU/OfHwBhssTuWcS7U4rcxv2iCRP
 qyWNYqyhKRAmYtL4tCxstZd/EyUoR/deTj+bPWvWaumRhFZ8k03AsWoOdSiAPJy5JSU/
 K9PJvW0Z265zHv0JL8mITKo3lshKKUzicgBbkS+8BkMEh0NB4/KSo/qlwY1pqcMp+Gye
 5iuG9d1rSqnKlhuPXj8Tm5AY95fwTzW8l8rTHTE0vd7PeV74517+Ix43tK8IZqfhUfqp
 L8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401495; x=1793006295;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AgUYNODUiYWHIRoHV8RdT5emAtiRnqkIOPJGLCENO0E=;
 b=gbG9ieq58gPxZqIe5EDXnnaDCh6MxxF+CZpCZtn38nV8oznaEUCYfsuvNPDmV2z7ZD
 jX7Mj1vaImEE2SGj98XVFFUbEeQuuQF/0FPv5ZBxMrorhaEoYF1wmPu6k/C90ymHZb+2
 Hy6ZMggvEMkSKfifN9R7YCrb4Z1LSeBvqRYomZJQGWWXzTvGDsduQh7gtekBv8GKoEnA
 50brYGtipDhPTmOR1JnMgxuhlP5xuzVMbF52GlJkA+/iRxyj80jb1D7kupFIN7rKqWC1
 NWf6P8CmF9O8VDL2i/Y+tG/xzLFd1W9Bl5Ytonhsc73aVKolMx6JbOv8D0fzGh8ZpJhk
 8/Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1pefgEf0L1g9OtXJHFCZiHsmAw2YBNMGonToj75qk3QQbWbJvcMY8klJAW4gJuS/KSSdR7QOGaD4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8G+1Bd7PuCLqBL1OnP0xYGfDqLAG7YxEJGWvu7466YwW5N8zM
 9y/dArZiQay2oGtHSlvezXW1EWk8zaf9EQs3h6Fl9M5eyDhh/c/2b9QN+d3I7QIzb40fl85lZTm
 r0+rPLP1KGZf4DwZ1xYP0OUB2LIdGeIB7UyJgHKzN4SHpTUGittsM2xcbq06i2OEZ1nrCcCk=
X-Gm-Gg: AYBFou3PHb2VZglxaCsskg8rk+k81/XyBl+UaHv3K+sYrww0G/FRAquR+NtMIwOv93u
 iYs3RnueeMLGx/MqdCNIblds/HrpFC4NyA6zcB45Oh/wRv93hq5QAXKpRCk3IXjDYpW7H+ur9fS
 y/y6cnqvtn+iR2TczOPgA1ec6IlTZdEwKx00dqV53tOA1GAloexGqigJCg1dzfNhAeoLVf9IyED
 Rv5rRbEcs6x27ynmeBXbC7sd3G/gYMe/yptWKp3THfqIOQYOkzWFbJ2pRneoXA2tFsObIRf6WoU
 1EOwqbpDfvmNUjl68WDZEn5a8h2wv63Q5x4I644lpLeEAFHAPBEp5voRmmkgGpfdTaqF5sCV4+c
 UHZLPCPqa2+ClhTlwtjcgFtjkQM8omdz1hHg9u1oWUUUGHwqEzKQGjOeiyNjBHKuPOgPzzdvb8W
 MvHrbM9OiiLTU+
X-Received: by 2002:a05:620a:4547:b0:93f:1b70:52a with SMTP id
 af79cd13be357-93f29d53d1cmr1275118785a.46.1792401495371; 
 Mon, 19 Oct 2026 02:18:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:93f:1b70:52a with SMTP id
 af79cd13be357-93f29d53d1cmr1275114185a.46.1792401494838; 
 Mon, 19 Oct 2026 02:18:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab2e4e05c2sm15893441fa.25.2026.10.19.02.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:18:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:18:03 +0300
Subject: [PATCH v5 1/5] dt-bindings: display: panel: add Truly NT36850 WQHD
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sdm845-hdk-v5-1-4aa7e22cd0ed@oss.qualcomm.com>
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
In-Reply-To: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FUR3zv3ZZDVPFSKArK7sPMtEQuW7+6U9gHUlSMhh/U0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1eBPDDiwCNLY+8Sta1NZOSsWVbU9ix5MG3v7h
 niSHLtKtH2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatXgTwAKCRCLPIo+Aiko
 1YtIB/9A6QWWUiEeAwS5BszeA6o206fN2mxnUbkWpxM42EsZXmNaMq19doW6gD2ylyErAX5rwmo
 FkFtAQFQai6eWSn/s92V7+3OYpBkpYkBKdKNxBja+Wh+FNZYdcIQxw+482wmF2mnNl9I91d6amL
 AC+sY6zg64VP3R7nacc1FH76S6z2byaNCcK/DWWoChEPMCgIOzOI8jOF8ei0RR0QKGnqsUXqkAf
 swgUsac+00GTJI/BFHVsMTH3g0vt5nouj6phgM2ugHmt8KlGM1sW8t90NmlJzANDaYnL0TdTxm2
 oSFB4vEL07IW+5FlNWj7uQypEYPqhn9tLWv7RWJ4elFpmu6X
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX5ZOIT2K4XLB4
 T2fL3WOv/HS4DEMeYp3ut0G+GoH0ERE0c2MzjtYZUKUjpCqASNPnzCjNS1TVyke3l9hHK0ba7nU
 YZbjKMxj1COttP6EmoTYbuY/ISzePaU=
X-Proofpoint-ORIG-GUID: xg-tKUou2u71OLnNGrj2HydaHyU7GjcP
X-Proofpoint-GUID: xg-tKUou2u71OLnNGrj2HydaHyU7GjcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX5ifKSSXpT+m7
 h4GLMTYgEclv5/JZJkMMBNkYJcnNZReUZC7u+LkGNrkZXnANt/68/8lh2ZhuMIJCQzTghXfrW9w
 4UTZmXZ8uzaIvo3TXvB0Gnm3eMY6hPVpUiimwbphbXADd052D/Y0dP+85MaXwqXsgwHiWoczHqi
 k6etOnpcUB8Wdou/dd4Xv1qTdhGRUuc+oZUGMg4yn0F09gpigQvbMKG/R/Qe/dI6WkCpAlXjtTU
 O6/MogWlQCLp+3LID+78sEJx9DGHbYXiFYNPKzdmXL5m6SbPC0YnRQsgLku4ajdYfx3buP3HTU4
 cSp+9NC+HgspsLVY4KxmPt+vaCr7dzq186FNe8ynsGIJ+jhwUbxJ8r/zibQA+WbQn9Oixt4fCNO
 TuOR1Q8jdrf2D1qx/JdxehDcy4UiQfPUqGRGaetcPhyQnp3h+xGiq764om2ByddjVBs4gpORi6o
 ZWcxNpETNH21TJQMogg==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5e058 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=od__NDLvqBWtWXuahMwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190036
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

Describe the Truly 5.7" WQHD dual-DSI command mode panel based on the
Novatek NT36850, used on the display cards for the Qualcomm SDM845 and
SM8150 HDKs.

The model name of the panel is not known. Neither the vendor kernel nor
the HDK documentation mention it, and the panel block cannot be taken
apart completely to check the label. So the compatible is built from
the vendor, resolution, refresh rate and the controller name.

Assisted-by: LLM
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../display/panel/truly,wqhd60-nt36850.yaml        | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml b/Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml
new file mode 100644
index 000000000000..1cc63a6adc7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/truly,wqhd60-nt36850.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Truly WQHD panel based on the Novatek NT36850
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  Truly 5.7" 1440x2560 60 Hz LCD panel driven by the Novatek NT36850
+  controller. It is a command mode panel using two DSI links and it is found
+  on the display cards for Qualcomm hardware development kits.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    const: truly,wqhd60-nt36850
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage supply
+
+  avdd-supply:
+    description: positive bias supply
+
+  avee-supply:
+    description: negative bias supply
+
+  ports:
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - avdd-supply
+  - avee-supply
+  - ports
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
+            compatible = "truly,wqhd60-nt36850";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+            vddio-supply = <&vreg_l14a_1p8>;
+            avdd-supply = <&lcdb_ldo>;
+            avee-supply = <&lcdb_ncp>;
+
+            backlight = <&wled>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    panel_in_1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+
+...

-- 
2.47.3

