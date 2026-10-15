Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38FECC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3CA112223;
	Thu, 15 Oct 2026 08:59:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9152711220F
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6sVVp586453
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WtIbWYmm7ff7OUPpUFuKzJSSPLR0ROTbUkKbTEOsXzM=; b=kgroUWBL2VhZHY0v
 sEDYouHcrcnsMdtnLfnNjaQVlDt3gZxh9NXNnI4KpT8OxPlmOaNrdQs5cXsBkA6L
 yQTXu1PAKiqxiZciLM/gaGmxNfqgkaT+JN3nQD8KeupF3kn3QSoN/oGEN+2PzbAQ
 edzuIQoufRxw2p5hsoVZKW6TUjuDM8HxgoBho+XlDgOhATftVoMt6wZMSt1bT1se
 d0yeQSRRV4QXmrc1WdcYIXoqBfbfarqBCZS7TBJqZLxN/QpagEyalDnQIlzdQc+4
 YF78zWoH6XPhyWtWmlRQZ3j8Kt8yCahRSCkdWHb6yoG7hOS1vQ4E6HpdL+kFI++0
 1ApP0Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdesxpc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so1129749585a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054738; x=1792659538;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WtIbWYmm7ff7OUPpUFuKzJSSPLR0ROTbUkKbTEOsXzM=;
 b=VmB3ugFhjwpbINrppr6xDbySo2EWsIZhGzxgoc4vvRUADtbvrcGAMZSv8Yb/hhns83
 DatQAgTwQddhLW4GAZWQUUIoK7Xiw+EiJ4OoiIDmSwpjh7hZPziPDXo5hBT/5vbW6zrg
 q3rNkFOpLINfnHjVbkY6rekMTzCRhBAUrvv48lbXam468nNmjELwNw9o7LCT88w/X3lQ
 zzksmSF0bxauD9PDjdM94h1KPgc79oibTH3aJe4mLtRGHvARfifQ8OEWZ8VFEU7yoW3Q
 ci/y+5r7Z5H1zhv38xBe91FqbMfP7INGxfSMzLPkz/oadCv99GWjE1FVzlJgwJnxLKra
 EHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054738; x=1792659538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WtIbWYmm7ff7OUPpUFuKzJSSPLR0ROTbUkKbTEOsXzM=;
 b=yqRA2SvT69jlF3c7TxEmJrSYEoICi39DmWyPePRH+8lG9p/zSUzpWsi3GHkCwzv02e
 rFqP7f7zKvhinuCMzxdWuPnMPWzH49NLjFJCiVmbCKkA2NQLkCMam7nBOEP9TYlSyZrB
 aXv9E+T+3sQTFDWnGtYprqJZqlAgZslIJjU+K4lUg8H9ivqEZDR7qE6NrjmHzSR2M9h/
 4caI9cPwOucmZP7H/FMaA0a+fPC1sTuMPlRH3DdIpXT+F/D/6S4ypkbKIfzuLmjhlObj
 r+BoODMmey4t5LH64jWc8n9FCbeJofDaamS6YhdBtAN+wzk8sRPW74d76YMggPHJY3Lt
 QwMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjGxLtr+cYrBXejCWkvb/kzFN9NXchPWN8pXv29ReE96xQfHY4eeGpRsx+ePy5UtTjkkjVqTW8Lms=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIU+otselb/Nx5IzO8ttFbj/lcrReY1JhqwozcyRFvmu79CC5UV
 ATx0XVQZKkgeRceVBsNeiTPjhTr6qefullqbB+U6qO0Elz2laMwbD/84huah9kXkuh4fAXZjP/N
 Um3BhnwLgxzWWlkcWg7us/lZo+aa3kLdx9o133eve638ywqC+o2uJUHIPYoi4K7otbz2MRGQ=
X-Gm-Gg: AYBFou2/Z84voo5G94br8FuMv3nNQJ7sw47riQGd+UlEYKjViZpOGhS/fECdUAw0HLK
 ThLqfxPvCWMUSrIpJtuqf7v8sli/icPnemvPaLK/iYPPihCPEfQMNCtL+l6AF8JpLeNKubbpaVf
 AdVac8ry+IdzmogsTFS1SHPRYXxamLxvGsrzbkmp+Wj7yojHyFrQZiyZBEBs6WI4J5RkEB6Aisu
 sLvb4HpAck4L8cxuRhSQAFFAtZECxlhuzGwJFIhN76/FXwzEVGbTep4JsZsAlxheXEwj0DJaA6b
 2Kf/909HCy5y1d7s5go8utIDivTZDPys0VxXru1sbPciy2PGR8Qd3renfTP6LdtM8nDwvUFKtt9
 k4+VtXaa4jqAyQ2PGQKClO2vzYZFYtpG1gkbCIrYH8OV6/hbPlC6hvCF9UYU/sr3OExrKbHsLDL
 M0HRkL6J9x23Ws
X-Received: by 2002:a05:620a:4045:b0:93e:b664:db34 with SMTP id
 af79cd13be357-93ebd27dd53mr3033931385a.57.1792054737650; 
 Thu, 15 Oct 2026 01:58:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4045:b0:93e:b664:db34 with SMTP id
 af79cd13be357-93ebd27dd53mr3033928585a.57.1792054737158; 
 Thu, 15 Oct 2026 01:58:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:58:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:40 +0300
Subject: [PATCH 3/9] dt-bindings: regulator: add Qualcomm LCDB regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0crPU1F57WiNmZgblPHqxJxKN+WWqULT8xXlWGIFR9Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXE3MMATOMFhtKps8PFYXmSqrI3N+vo7Dgn8
 esmJM/cIu2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxAAKCRCLPIo+Aiko
 1UZ2B/4rcY0My5fgNc6N/WUfHMYJS05A819Quw4iBwTE9Y5h18zsWhSwEIjpjvc6W2mFT1mrdPG
 El5ZIsYQW/gso2uwlR9hGkoGs0eH1iWT/sJJYf3mtJNrPmwoJqeZayL/yHV57dg00a8G9Qj/mQA
 RIMeTDEg05pXFBNINuXk4sdDkcWUIklN7sI2aL1vX3E/IAGHtWOG79UF6kMtcQO2g5A8sysRHHn
 OvRKyBEZp24bCS9LJ+vAFRdjdYNNsm+Taz4WW5WHyyAJRIdSD5nQymAq5GMtzZLW+/OgfIw2WXS
 P4dppgpPDq9PEm/pCj9968nqP+pS0EUzlTTK85CT6UDD/aSV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad095d2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=T9loRX4MMf1nJrAHyI0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: OJmDmnk8fb_HzZI7_-1i5Q626drsQo7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX6d1MWFozDy2w
 dRQPVXchPJYf7pAoNB18AtUZRa9hRq07hsl0lK98W/owIE26z6JOTD+K8uw58KCrRYjDE8zhmMG
 sOG95W3hWm+CM+ijgCaexLcPxsbz7Ybx+awAN5rVjl1otexNxDF1NMSrt6g1GL1QJKczdz1UZ03
 QPNUqb0FYZwcM87hGA5I4kcyHbXxRAD6IgreSqlryIj/bg3ECtlfz/O9H9W47sOrqg0+xgpTabf
 xMa6SKw8j+TkDRPqYcNCZNvNx5jxpWAQge55dHBvbpgE0yugtR9mVhZahaPTNIVBGBdMra/x+i0
 L348BAFaV1U2MMvvXJ/6aKLzXBm3UikSTLT/Uw+jR6ZhrkMcGGr50ywEGpVMkNWn1FqoOUYNmY2
 ayR+gSUjkjRCBp59HgsfszH++rYgSkv5NfloRDyWlWHjcW0t6eGUOrN2ZNmILAnXDhctKjQfRgg
 nF7GFCrwlch9Au+2DCA==
X-Proofpoint-GUID: OJmDmnk8fb_HzZI7_-1i5Q626drsQo7d
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXyrzL2fAj0yFq
 pcmfKYCnfIge0r8b/JMi7KXHRVJ3kmrGZY72G4yv5B5pVXOOhJb8VVjfre5b6FXFs3FXBof7FLG
 Ou2/jG1qfhbpAx0vdnxIFo/WhaKuqjo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150035
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,pm8150l-lcdb.yaml      | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml
new file mode 100644
index 000000000000..eb5014f86439
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
+        lcdb@ec00 {
+            compatible = "qcom,pm8150l-lcdb";
+            reg = <0xec00>;
+            interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
+
+            ldo {
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+            };
+
+            ncp {
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+            };
+        };
+    };
+
+...

-- 
2.47.3

