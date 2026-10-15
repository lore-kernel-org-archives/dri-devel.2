Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56043CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895501121EA;
	Thu, 15 Oct 2026 08:39:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2211121EA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6JPtE644571
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=; b=PNXCkV87b8V9vDl/
 WrcQkt2SMWTpKA4duTGUDYX/HcebcOmAmoe5SEA7648Bzb340yuIqOvVDoSHzozh
 y6Uc7UCWzdbEFR77Jf988//jQBU2Ogtiw6Ac1VFY1M4FNn/8iOsSTw3G+kuTKR5T
 IRLtmIyem6WhitMfR3TUvhKhAwTowX6LRYkB5mLsc8Bl1RBmmq83lUU9p8S537T4
 0414gf808jSMUQg/sWDC5I2fDuruxONmjydCaa8BxhoSz7ec/vP3+OGrTq9U5Z71
 sxFlrkXSzACZ5TgBc4hi8HCd7OpvQFLNda5Y2jR8iskUM07TtI3os3N7ApbUFk5r
 gsPFdw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmya16t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso436368485a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792053575; x=1792658375;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=;
 b=iIwGIe0ab9uPiBbozRIa+btaOlKyetJ7UNPFDWTmhjucS39aLCAHh9mLnAuAnXWOnP
 Mqj1FBr01HDUwwTcC6k7fUsEN8IkSQuq/+BTsQnACYVigEAHjmcQZtk3jlDSCMYuMVho
 7tmuFCf8/+EpimK1a836rlLPjdqcUseantMyiTiD0B566GC7AeKnFyRbITBuuOieyx5K
 NqpSi6fEk7azhqqbL4SDPSo7mx3SU8RDvhb4VyAA672GbzxcnK8ze7maqkVNpXLTL8jS
 QtCc4OP3QAHWOf5ZDrx/UsrIMm6wQfi1PHTi+mwsnixJLkqAPFqsEw9O0uuAhrAMbl/e
 JI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053575; x=1792658375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=;
 b=vpK9ad0KmVf1aHH/sIDe7+sw81F08iuyVMq5CoQt5QatJ8F7rU/iVcDeifBjkMQrEw
 08WYbTvDTUzuUWpmT+zluCDa68eMZtj1dgGNXeKPMarplTgmGyx7SSh5EbWnonsUaqY4
 oJ775zOzUYAjja/nTQPFxTfHXjKvsCljKcUsAExeTGjg1XmBq7v70WAY+PathwRjJtmR
 5px67vUZKI2IRXVcil3UDZWZi8h7xD+5pMv+GoW1zNXvMTahR5HB8M/ImvmO04y6pb9t
 dfCCzhoxU4Pc5eBQQlklqLhWKPZV/CUitY/FuxhUi3MFsS8cb2hhi6ayhVtEVE2OasXZ
 QA2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1V6okNMJk+MaMtaEQuTdILRfvVu+g3jszMoEbZ47Ls7htLpAiG23yHnzHRvu1PoFgzyDzny7Sugs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3bKvmV7BmGniNEoyHX2C35h98qURGSw257ti2EgSMI1dbxgzv
 0X0bpVH7XbYa/6P9deKK8necwnGlDTkg9FdnF6quGQhI0UXtk9PE6YYIYntXQkOB5S4+eQtqFdd
 9u+t/19rPlrZCSszlnWCueJdSgchTWibhosnxhPMzvWcz7BdtakNqJFOzwsuPtxpTyG1tIVk=
X-Gm-Gg: AYBFou3NnFKUXg7KSzbUBHX6B7clnCejUYvzuNJA3ZPWwXUqjxvh2ZqLXHkHK8eB+eq
 IiBUKU0dXLJMJpXSRwbGiUKeXsoebwZZs9Q4xDOQtm1GMCCoD0GP0cv0ng6G9hOvbr+/oVv/15Y
 s8z/lMspD18fPJK81058cSRyXokQ3YyvdsdjUy2BciWm30kcJ9h5F/AjUFj8R5n9EWXILXHLpZV
 VohvglBbjKY7T1No+dTRxj0rgfhOa2XDeAFHUILbad097e2vNL1vN7J+HKp3v85B79AsTs9vydH
 rmAm8g54IhcDDlHh1F0eYIme5sBsFHvsr/6KDlnG8i01OFf795/xqwB+75qDXmA3Z2iw22YgDpS
 SSZ35ZysCTmkp2L770wJHzRngDqf6QgDayqr1g8+XQuzJ3RtHbJko8+ZIC11E4BjBuObWEgCj4Y
 4gQQgIhbLbAFl4
X-Received: by 2002:a05:620a:6845:b0:93e:69da:a670 with SMTP id
 af79cd13be357-93eb9619adbmr2871609285a.20.1792053575494; 
 Thu, 15 Oct 2026 01:39:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6845:b0:93e:69da:a670 with SMTP id
 af79cd13be357-93eb9619adbmr2871607485a.20.1792053574988; 
 Thu, 15 Oct 2026 01:39:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d702a5sm1175500e87.15.2026.10.15.01.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:39:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:39:08 +0300
Subject: [PATCH v4 1/5] dt-bindings: display: panel: add Truly NT36850 WQHD
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sdm845-hdk-v4-1-b532b9f4029c@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fT31BRXck6wLmrm1EKJZG7Thy04mm4/J5d4uR4ASm/0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JE9EO7FC4gbOCYABFKGkdF6EAPQMLKZk2U6A
 rKNKqcA2QOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCRPQAKCRCLPIo+Aiko
 1bSrB/96k4zdq5RJ2xrN2ces8Sb1LrtiMozuwikBzqcee5xBxtdq0hSh3sIr2oeuDKlCDdsCzOh
 NJo1rMTjyHIwkvm/hqi6Umc0p8r6aYjP1uWUWar9vWuBO9VCtGSv8e/jhtmcQwiQpgxo8nkAJDc
 KgmQKgZPxJa+ClbeXFHSRAih1cvezCmfAg2oUuYMCuNss1MEw+p5wsbhSq0nt4nhiOqbZHXilUt
 7bNdFBVixN5OFpNh52EAYRtXqVLuFqxqtTeO9f0Y7at7cA1QAe1hb/ootFJe7FJuQuJSsVXfpxq
 KRMjhnlauAl1AM9AzmHPHSImCIR5COmpwkPP4kWz62dLaxXd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: FZ1YZ5Ra3VNVF23qfwIOx77es19ubZYn
X-Proofpoint-ORIG-GUID: FZ1YZ5Ra3VNVF23qfwIOx77es19ubZYn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX3VLmCKrv0bBd
 m4Gm5HHkl04kFo8KcPRaF8yxXIs58KxZEp6gpVVIE67DuFK8nD5gnJoJ+NDWuHSjz6CKBnHj2Qq
 tpgNl9STLIrw1wknO14R/clV0L0o3nE=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad09148 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=od__NDLvqBWtWXuahMwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX74JF+wts23d8
 PJ62jNBCNVu0OsOU+AS2s1x06DLs1iHxJYyFKZmwkYwUNr25/V4IVqLaNSep5UWyUfwhhLf4BkR
 W1f4LaOxWqvyUCJd2Uc5DqW54upHEfiIQn+13zIQwVgbv5e4l0OT1kIeLltApAobHbV+HLHg116
 PG2HZeKAXOHGFB+u8mhiTpLf45IHQyLU8LXp+KzUXzf96jVFtnV8u2UIDPmfFUs8ot2pXFFXpFf
 1g3ABCk3wG87cZguLoWB2XC0W4A5LOghebdL+wu9yfLA9OCmdXhXU4nITG599fxz5i9zcjhNHvQ
 WTui7c6Y68nn0QM4r3gtXtq4cJOPn7ctFUGvaQKpVqj4ZFKQKgjOZALyTnoj5JTUN2RbG7cqdQ9
 TYlAheQGC3o8f9D4BY9ePvrIxOnMhfy4D9Z/sYNbyHTCOBtpn23f0eONcS12szAz3iYq7ZXIiQF
 1cBowv3VBeq40Dap9ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150034
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

