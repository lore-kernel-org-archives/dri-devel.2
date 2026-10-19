Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C74BCCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C812510EA78;
	Mon, 19 Oct 2026 11:26:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8255C10EA78
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:55 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OrMJ1167943
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5CG1ZmhSBv17Pssznbk9lW+JHvH1kxpH7x7K0dZwnyo=; b=ZQuWuBsfSgRd0sNe
 dyrPqEQvVipR82/HE8/GBSJ1dqFVvxGJJ3kdtH9mVxOfOZmNa4Dz1Nlqd/6N+6G8
 fIUclXJEIn1BRvvBhBAqUSB7MA52Zsh+qe1CBfcS5P6TKZE1DJVK7qTNXjCO0IKd
 vC5yASYhHbUpe6kkmQzNpgM1D0uYziw7AW28tY8vlT1naB/x95W+xhUq68F0GCne
 4BSu7FMjakh9NDNxSZxcNChJ+n+G1L1p2if4Ed+KBwGnrOAOKTWU/JOsFhHgAEyZ
 iXrUr9Gycv3OfAsFdsKfa9n6HPUSADwfFIMc2OI24dKtoru5VjGpHIsP9QgYFU6u
 uwbvnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8tfu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so402223585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409154; x=1793013954;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5CG1ZmhSBv17Pssznbk9lW+JHvH1kxpH7x7K0dZwnyo=;
 b=SRwiYcg8qjQXffI9+RX290Ph9ImBfQsrTNutCqArZSI08KcH3hzej/Mwv8AuDDCk/y
 2UO2cEysdB1TIfbCUtYRq3KrBLgmvjfgnhMR9lqjyD6YNO/qjTxf2Om5+dyfGJ0/xn+5
 VSoG0u1x4wy9v5jYb6X7/CYktivLFZm3CQp5WL7N1koTh5K7Ozxur8sS2XPR9agTmvGz
 Qq0bCBh2uY9vD/NXf6BWe3J2A6pl1XdRhIPg6eSJsKG/pkmRuysDserf7iNrqev24Q1N
 kxZGDzbidtzTt7WjfjEEavA6fR5BEg+ZcZrUh1MIJ7YrudIgfaR7M4Z5ONsdaiS+h5Ow
 dZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409154; x=1793013954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5CG1ZmhSBv17Pssznbk9lW+JHvH1kxpH7x7K0dZwnyo=;
 b=txjRyBJYyw/tRIg5isdyDGqgIEacGPpHG2Huw5y3p+XC3vWADATYMN5Z3W8NvtVGLR
 2DedKeCCs3k0/8NT5hnt4u6hGGUkiBIXkO61fn/QjVZoFJmPHjf+GkVSw9HxD4Hln7UH
 aGgrk+tkN+i9kGIcQyV2p50/ESLFmlbVQAebwr1WZoJpFYkh1ZIH5edE6FEN/cbGPlR2
 yY58VkMUY4aEkAIK294Wm7mv/y37u/p290J/6MQSG7+xyrA4U4wj9rCkeWSd+f7kqty4
 SOQv6/EHZC3chEzmDrFV3wDzaSTbMvHRnZSRcS/FdPuS8efeUpPZPVNBs1AQJ4LkPODW
 ppUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2wyAImZ/nuHQzxqm54Jb9bakGNhVsSYHUCrFzD7c1abi5N4Ncvi0lvVIm/uRAZ4vnaGQ9Q8gmEJs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLBgPMZXiZW3WrfsOkWepl33tKkW8cPwgVM3aiYQ/voebHsxCIp
 JvZoJbE49qaMRCNXPAmad6oD4Vnb1J4EHMxLoNdfFCXqQomR9ObPolZWbVAA3tEeDGH7Qhx/wNU
 fzdmrGcO+yirm1z7LyeVwih9/DHdehebGuKnbB3yKgBJVxyXpNn4e6An13zanpt8fk25+ONw=
X-Gm-Gg: AYBFou12hd65UJUgw9OG++U7+frJ1/FJmkHgmQPGAVCP6lA7ctlgO79X2zJuB6g20gM
 r6o11jRpuoDtTLabwIP7gX0IlMCLhbLKqJl/myLoYnloEbO9dtvfqyVa/V2FfGdaRoe4Ta+GHLf
 Lm4jqOODRWtOU7ZAy0I7tPoTZUlPSmtCUoTY340KZEliPaCmhUlPV5KqsKlIriRGEVX/r4SOs9w
 IWEhdtw1mPmNro2zDJyeO+CjKpoZG0vTxGTZ3rVe4fMrD2sUGP7WaTUBAAlHw6rha27JLbKiEOK
 /6pUIvykQuNf99PrXqc1o/7b5eahZtwjAaSyQ3727hZ2pumz6mAK/R65a3XJuI5ksHAx7Q2UTCK
 F609GOnEzLipBMrwCFxq85CYSjrjRGNYZZvcO4CsRoMESLo4d1V/Aa/VH1gmYmViio6ws6z9y4n
 FniWl/VjL+KfA4
X-Received: by 2002:a05:620a:7113:b0:93e:96cb:3083 with SMTP id
 af79cd13be357-93f29d38660mr1173731785a.33.1792409153851; 
 Mon, 19 Oct 2026 04:25:53 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:93e:96cb:3083 with SMTP id
 af79cd13be357-93f29d38660mr1173726485a.33.1792409153274; 
 Mon, 19 Oct 2026 04:25:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:38 +0300
Subject: [PATCH v2 2/8] regulator: dt-bindings: add Qualcomm LCDB regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-2-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3SFfXzC0bHwD78fBjVebg7PPYXaNP6Xkrxk92qxdGA8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f45ExUy8zE6GyGWTzcNpkND1+27Rx4Pfw9BQ
 6UtgAofC8aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OQAKCRCLPIo+Aiko
 1Ts2B/98bk/jBz49LoQOXRdknyPydiybtL39hdFjjUGkcUHaKwplQ7TB1JRybSNObZRTkyXdxJB
 +BY7yezNBzGTD+08+W14ZBvaWsk86BhzCqaB6d4XxP5ecFSPMPMhBylrI3MNfacfRYcv1UOnTlV
 M2lGTsjcb08YUJuAnPh5ufW5YvynS+xVBEFAboQhhSr7CgiJdBhCyInbkmbO7DfPrh/CUv6QT4b
 or2F/y1PNr9t+uOm1JN1a3Gpq1PkkFpjOnL53qsT9+Len7Mr7HVhgXuL4ryBLhsNs195CJKtkAk
 K/+8RsTwGCIjT/CQUApvfXUNC0xQzg9VpQvknt9zraXr0Ofo
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX0ACEAllheW38
 o10+NjA8B34atBgVANzYJhYyBa5CmWrXG6w+SQuQ0dt2uXTRvJt2T03uj32w69PD/1xLbktyRHR
 K9F3CXLr2Dz0eHtNx1K9DUlYcaEAtX4=
X-Proofpoint-ORIG-GUID: r5FZ16q90ASwxa_5CQeiDkcYJ0iXlNra
X-Proofpoint-GUID: r5FZ16q90ASwxa_5CQeiDkcYJ0iXlNra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX/yTLN4Ff/HKO
 CU7rvtajVyA20teAIga87g5u/vtsMKS36cJWBjhykPmyeFAjADC9GXFdiZDd8p6g5xMPR0IdJed
 GvLEW4QBXIye1EEDPsozwoXB/8QBM8KkIotvjxkBGwPOI/a0BnTxeygGAeEb3fnRN+X5nAPPEgu
 tBnDM6D52Lzfncs4FedrYeh99czq0+fCUnJAVaxfjLr3BGQefHPAHMLTYZPmCWvd0QsAWELP/f4
 0HmtxBikN3afvCuCQyRokvSEurXGaqn/Aw8mUDqS5uFjgwuYUc9iMjSqBbgvHAjWs9rMtEoal3z
 E+j0iOW9KEOk7Sul8hCNWVfrMyAG+ZhGn5nS5PzxcFekt3i5G2nbxi0rwy4wMB9CGAJzPWMHOah
 BlI0Pk8QdoCBtC+MbnkfJ7vycY7snbx8ZVwHECc4y2AraMOa4f9iBhjm4hkZYoRfXNS87wsnTiX
 cLj64mHL1M+F6ZouWxA==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5fe42 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=SXD4J7xBejkBiF3T0k4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045
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

Several Qualcomm PMICs have an LCDB block providing the positive and
negative bias rails for LCD panels. It is not supported by Linux, so
boards using it either model the rails as dummy fixed regulators and
depend on the state left by the bootloader.

Describe the LCDB regulator present on the PM8150L. Use it as a fallback
compatible for LCDB blocks on PMI632 and PM6150L. PM660L has a different
version of LCDB block, so it's not being covered.

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,pm8150l-lcdb.yaml      | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml
new file mode 100644
index 000000000000..d3cba1aa0c2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,pm8150l-lcdb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LCDB (LCD Bias) regulator
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  LCDB is the LCD panel bias supply found on Qualcomm PMICs such as PMI632,
+  PM6150L and PM8150L. It consists of a boost converter feeding an LDO, which
+  provides the positive bias rail, and an inverting charge pump (NCP), which
+  provides the negative one. Both rails are switched together by a single
+  module enable.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,pm8150l-lcdb
+      - items:
+          - enum:
+              - qcom,pm6150l-lcdb
+              - qcom,pmi632-lcdb
+          - const: qcom,pm8150l-lcdb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: short circuit on one of the outputs
+
+  ldo:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: Positive bias rail.
+
+  ncp:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Negative bias rail. The voltage is specified as an absolute value.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@ec00 {
+            compatible = "qcom,pm8150l-lcdb";
+            reg = <0xec00>;
+            interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
+
+            ldo {
+                regulator-min-microvolt = <5500000>;
+                regulator-max-microvolt = <5500000>;
+            };
+
+            ncp {
+                regulator-min-microvolt = <5500000>;
+                regulator-max-microvolt = <5500000>;
+            };
+        };
+    };
+
+...

-- 
2.47.3

