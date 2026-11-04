Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08411606D803
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ly2+CodM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I49cBpTW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C5D10E885;
	Wed,  4 Nov 2026 09:12:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56EBC10E885
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:11:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48KsjC715360
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 09:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6GuykzzLpkH56pQe4JsMmTWSBVarOy+Q20aNwDP3d4s=; b=ly2+CodMQxIjSAiJ
 tyHWVL6T//F0JJuiaYBeQW3qlj6C5Ae1PtXVCSRjupmXQd67VrwccNZPvvmuUcHr
 0hoMVUxykUke5b61mH3JNJSeciZLfBvc6felfvih/zsYtpUI2Cyk566oSGthXciC
 HmkVpkzWhTk0Xz7Im+ihuwO6THW8ix2Fg/+8i7Yaz2hpwsEY7BK1CUmfN8JWIUSH
 kKI9RVIVluLKrGZVwnY4oZYQXZ52WxzN+S4nk9il79uvfcNN5wsfWxlCi2/2Vnpx
 2a2oq7TCPZ9jbDlXjC2NgjqKBEbYdzkLN93souFSGtv2LUMoVFTAmNHd6SuQGrox
 ctl8uQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y2y3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:11:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e9501034c4so8699435ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 01:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793783513; x=1794388313;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6GuykzzLpkH56pQe4JsMmTWSBVarOy+Q20aNwDP3d4s=;
 b=I49cBpTWyGT1yrCd4Om0LdPARjvoZBad3/TGh2/8yFqzhkJFw2RDbPQKe1ty5PlVmr
 0HOShqaMq73woRRw06a4SvCxSLC9rewLiLW0xS5RPbgn7N5m+zh8s5bAMwiqbFBau93K
 C+x+aFBl90Zpvcwx1TtroSqM7wRGG4J1w6FlyuBA9Fg/2tqGOKmp5iCSh/+YtyUrWa61
 w797Bqmwoz53SGluPf/iv9Q2ISNsmA2dgLdRlcFi8g0A6xzDitWwBN7EgUUX8BpG9+v4
 FlYBJr0Q8Nb5vr9huuhMUFu5PuQcDBNNvR/TrjzLtz9qt+PGrjPrq8OOWxjyA9rgAO6D
 qSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793783513; x=1794388313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6GuykzzLpkH56pQe4JsMmTWSBVarOy+Q20aNwDP3d4s=;
 b=PksXk1c2PB2gbcULLJcxk27VEATP1L6L1lYuwVkJnru99KYGu2akpnSqYAJuB1Jpb5
 RCC/oZidEas7XWszfbG5IP2kfv6/uTb5zjUBn0QyNswZIBN5Mg7JqVNBqoDRcc6zxnWj
 D9RxxqlXfqMvEpi7/0ZyHxSYfa1rHI0WiNkJ5N6IwpsKwAGoCdFlqLi4FkM589+xAEOZ
 YDnhVZjD/7U8TFPlss+Mfepvd+Wf4Xhk8D3V/EFM9b2TsQl9Krz9kBsCpfazUs3LwJ59
 Ahop/CnhqrXKMrfej09O2nkmjuxmYdBUYlCqdZZVufMgoD7Z2E3d5pzSsq3WHNBUc7UM
 pHng==
X-Gm-Message-State: APuU4Z9h+6lUIIrQFpFsXTuB8+TO1H01FMFFWbInvvRp076JiSDlB92F
 p0VL0T4N8bvYlyA861ssGcG/6AFyXnvG6XIxa2GuOeibXEtnNV4W3Wp+gaDVyqJrOvodNCHaJrN
 ScPrqx69MN4ZiHQ6uUtYhavDwQfbti3YE599O5W8MIgz9HCG8jNpiKxWfVC1+k0B7iEc2Kho=
X-Gm-Gg: AYBFou28yS+11asm8yXfZJiNgJsaxbF6AJRYc7LDDUNpAbUWDAENqnRhZz9jp3TC1I4
 PZQnVFfsczuxCycJomUWkeZShVTKvPUCmGDrfJaaJ5yZ/lwOfQdshWC6/kJnCusu7Xhlb8vyeIn
 qPP8HO2EALmdEagCyPMB3Z1Wl4zERY7KKr+86RfMEp96gxTG33v0C7Xn91uP/F2n3u/QGUK3895
 yLqsoSPHkNa0/ibmkOJ29gw7eOurHmxidDsv/04OiWNSnFltdYMttdguikCh7PnzSB87ET5AgwJ
 i3eKMekfQ04xtuqDFgqOWeUk9atfycoE6ysPjTwtrs7LwWLf9LgSR08L4VdRtLXBjlgwmKUtnb1
 ZrWMkznKD72PBRLOnwMecYAZMiLfnsBPT6CbEZgD7Tpr8pcHG6q21lDwI7hioRYc2U7Yfrbvc1e
 tn1IHRU0IM
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr13983272a91.45.1793783512653; 
 Wed, 04 Nov 2026 01:11:52 -0800 (PST)
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr13983233a91.45.1793783512186; 
 Wed, 04 Nov 2026 01:11:52 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c896cc6sm8253877a91.9.2026.11.04.01.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:11:51 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 14:41:36 +0530
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT37802
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-jshekhar-nt37802-v1-1-58e5e7fb2556@oss.qualcomm.com>
References: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
In-Reply-To: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jayant Shekhar <jshekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793783500; l=2222;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=8A0ZKqgwoan8Smk+YA31w0++rT/VvW9+pTsfyOAxJv8=;
 b=7X5FqluwOB8V7OwMt2jW5i8pgUVH300hw1vXITg/Cr3uXrREPTcpNQ4GW0VFYlCaalow7mQVv
 ConL3h9588gCjSGxkOT10ExM5HWosSKPkHE+EN+vc5CKV6Z4XZ52jRD
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: yxlQU4xwaCwakQshXxvVjEzRhrMp4Ir8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX3qhd36M3jSPB
 z7/ABiOpVh/0VCol2rpCn9zmSh7z5FZN0Ev1TSfzHf42gvSOU1Bhq5cg6nPHF9W7xlf21N2uG55
 FI+NdGVDo4pcQkAOFMZsqJvW+xr88gk+YWQIsp0Y30M6mjU45D/2AWw2TmtyLp9WlofQ5ZPCbl8
 5qUL32QcyhmGW1ZJg9jKCLhc3uC2Kv9q78rFAv98fJ7MiQJDyAxb/z0rxLLGBU2BVRHG/mTmbiu
 D2c9Q/rsGdBHbrxfLWbekZg4sAV5nKtBDd4J3nihzHXDE9XhNS0kQk7UFYr4u6a61LkEswXbb8W
 9iNPXDw4MFhtis72gB1nbGiUtKc4omvq0l9qVM2gYPOerarJkZa6r3a+9Rt9fzXUP6yGfyMQvms
 uTMjwTi4D15u9WhNjbz4yNSst47tViFeFNguyCLOz112EL8SDyZPZStmtrHtyQu+ilXGczOuBTK
 SgV/RJC+XKd/gQ2529w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX6MNInqKHttLM
 vegU6XXGBVzVpJTjLsSOsY4ndzWcGXIljMY+7qZWEGQ6ZeDPZDq7cjuO1HRl3jpybMhlCETS4OF
 R9CS/oL6lotr1JtxxK64g1sHKdKSZDw=
X-Proofpoint-ORIG-GUID: yxlQU4xwaCwakQshXxvVjEzRhrMp4Ir8
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeaf6d9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=RPLscFmMtlOloyN4f_4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040036
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the Novatek NT37802 AMOLED DSI command-mode panel.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 .../bindings/display/panel/novatek,nt37802.yaml    | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37802.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37802.yaml
new file mode 100644
index 000000000000..14a59a9b0fec
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37802.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt37802.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT37802 AMOLED DSI Command-Mode Panel
+
+maintainers:
+  - Jayant Shekhar <jshekhar@oss.qualcomm.com>
+
+description:
+  The Novatek NT37802 command-mode AMOLED panel described by the Maili/Pebble
+  platform. The downstream panel description identifies the module as CSOT.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: novatek,nt37802
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel number
+
+  exvdd-supply: true
+  vci-supply: true
+  vdd-supply: true
+  vddio-supply: true
+  reset-gpios: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - exvdd-supply
+  - vci-supply
+  - vdd-supply
+  - vddio-supply
+  - reset-gpios
+  - port
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
+            compatible = "novatek,nt37802";
+            reg = <0>;
+            reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+            vddio-supply = <&vreg_l12b_1p8>;
+            vdd-supply = <&vreg_l11b_1p2>;
+            vci-supply = <&vreg_l13b_3p0>;
+            exvdd-supply = <&display_panel_vdd>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };

-- 
2.43.0

