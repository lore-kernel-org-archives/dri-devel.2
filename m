Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F22C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C2810F3EA;
	Fri, 28 Aug 2026 14:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8nkxqiZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rt6Dr7tb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3ADA10F3D1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDl67U038609
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hMggueJrEfi9Ea0CXs0IW5lUopvMP6HZ3I3Pa5LDYY4=; b=Y8nkxqiZpP6cd/Zr
 D9evTg+nu14ILTepQu3MQa4ruXrjJUDhPeHJCg0zkK1FOgFv0Qgp1zr5nzvDt+iU
 3/9/JjcEZmq75vtQ2wuzVWhZ1AqS62b6p7t3Slql0K0pHBSnG6PruHDuw+ypmBuO
 I22wGZvElXpzB2wtKdlAWKwTP2xOY/L8fkkVtGbWmaRNTEIx3VizOam/cbIy9glj
 dM4OFkqzd5TlR5i8BE1G1Wp25jCE9CMRtWA+eo6IklF6LSLbulEtRrfkCO5/JNx+
 U48FB3As1OwhJ7roJzuSMGfMVuqzNiTyRoYjnFhSWm5z+HvJZBJMLov8ExTYtp6I
 Rf2Skw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afgtnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:44 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-744e80385dbso230510137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925943; x=1788530743;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hMggueJrEfi9Ea0CXs0IW5lUopvMP6HZ3I3Pa5LDYY4=;
 b=Rt6Dr7tbR1slUlqD4u3nU75MNU6LsefQy1SK2az9EhaX38OjcE00Zf2M4NA4SuG1Em
 Clha5XWFOoCSG3xr5kpXsP5D+rsFVJba9SgoSYP7XIqcQi/iOPgacozlvf7lYOBDKQ92
 dEu+bCbXMbr1SB3g2I/BordOrI2Je+tXO0EKojO1Te2YTugVs0EHEY5gw+mu4xcbvwv2
 LjlLo0RRstvO81OgDoiDnmEfU7xHj8tNr8Xrq72G0Prt/BHT6fk/wxXV7z8Wqeqkbpwu
 ouh+YvoIqTwC+rBOXxnwgMpwdMfWYUuxgzxa4EMuSdaMGatq16rG8gMvSzcO/dXB/MBs
 ZoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925943; x=1788530743;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hMggueJrEfi9Ea0CXs0IW5lUopvMP6HZ3I3Pa5LDYY4=;
 b=OcwJ/5gx0NS3jQHvhi8wLwTRiNJxNkRwqKUlpTGbbP3GVw+ewSW9JiLOFTcD6aMC7d
 xyScH+NK6Bt313wz2621TcU7463GhhVMNjfV2T9BRfggKhOtGkOL3Z5IckgHHBqA9bcZ
 LpnuX0fQU+jydBlwg9x4fOgHsy9F/Jd0/ZQqSffHXaw4c1MSDszvlF3ax0QM7DesDCvc
 3EjpEagIAnTx0XwPpjwN9J28Z8bPg5HccUT+ECv3pqvkCtOh+/CGNQJDrkmJFUl0AzQA
 HIRBsuRlSJzKFdjBpuagWbgEu4v3H69S6DCL8bRkwnY7BWs78Q8gu2pWfCF+yCp02hn6
 8TGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+l7CDR9ByIS0lyfMJVDKLz0oQ8cb/B/SPEZ6s1onbWkgqFfTPUTaNdz7T1LJ0I5SXCfPArRKksVc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNVuZAeZqzEKS+Bq3OE9rz2x8rYmZ5YbFSf+uTApT7qUIKsnE/
 ZThEO6bCKwBfXwnrMTT3udYlY2IU+fT7lc0dQsBnGh6xgh9FqjpYfwU6G8d+GnADDQT7TCb/SWQ
 AdIvmWQDbVqZxLTYb6EhX/b/GxburKv4tvCQet6CSZ2NCShSOIFG7mJTs4iMFx60UPdLuVl8=
X-Gm-Gg: AR+sD12b22PMF+Ja9MBFgFbTeAvtcr3t+O+UDjhIeQRr0J+jJJe7vITwPHjaQ8eq62c
 6cmnuo2J0uOcIhAlS93C/mdZ9Y0s5lmsHhRGD1KPAyoya7Lh3SqrKKamHtPHlPxDbBxqyb749n0
 9LC0g+AzZ0V5KPtFqPgIb5OFoqMvILpp3JubaFB3uMLqNDqZZXLN7BeTwUXVoBByY97RiweqgVK
 7p85SckPY1LO3zVX5lKJscvwRKRQaIIQIzkUbvYK8kBePvjV8PMx2hvqDv1RtJM1ccudfT17ZSd
 7LjZXmTtamc1MhVmEucX9ATgm3uCKyO0fCbOM+U1mVDpfLffSLcbcSnmrW0JBhQghfgxjYaPu0M
 ZK+i1zcCF56lvufBhG30gmXg=
X-Received: by 2002:a05:6102:441b:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78596acadafmr1836563137.4.1787925943411; 
 Fri, 28 Aug 2026 07:05:43 -0700 (PDT)
X-Received: by 2002:a05:6102:441b:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78596acadafmr1836517137.4.1787925942860; 
 Fri, 28 Aug 2026 07:05:42 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:04 +0200
Subject: [PATCH RFC/DO NOT MERGE 06/12] dt-bindings: display/msm:
 eliza-hdmi-phy: Add Eliza HDMI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-6-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=2ZoWKXh14IFtzY+jQ6vF0Zhx1BAkHO8mYs9EuOJq9ck=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWdh7HfytneGYVObjElDzO1HVTUQvEj7tn3D
 XQg6/WJeMmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVnQAKCRDBN2bmhouD
 1wt+D/9VrlG2+yThOGo4fnvqiAFSf7vxedxD15XsiCrnglQiiclrvXuBJ3VNN8TrQJtLNGagih5
 dlXwCMTqnHie8c+pydAR5ohQsNXDyardZTgaAjUirpa+wZxFF76rfVBGKcu0/e2IjdltiQVr6yj
 i0XvsNaS4q0w50TEkK3dOJP5fDmBVBk6DDwMA8NiHU6jsxTuK+LQTnKCsR15L2BsGrosX/BrRd5
 zlzVIxnvLOZaqWeuL+Ky+gDjlHyidxGbz6JCzs5e/Z3g95iBRFC3B7UVcJCK9sR1TCjLdxHefnq
 kVqh+FgzvcbKHsZeSha0B4TwlDbbTZPmdbmGCnZuLNfCHlF/wpYauRTJ5uHTEHIATHixlEXerA5
 MWx3Br9x3dvPUIuFzKpKXmkaQlPH0zGkRQ/FdHxjk4NeSLjX4DGWCzbP+eKmzfA8e5WflT1sph+
 8+51rU4aTvygnPrSOZ9PwIrtNNmojcZZlHvAhGftM+81G9umoXMirbdZeXvorC3n+5UbADeFamF
 vft7Mdm584q+tmdVV8rc0qNKI1RGdgvB6swbSbCZByK8n74Vzo10dbCcZGE7e+JlZJdoSlZF7fQ
 CxtCIGKfM/IxK93srEX8Hn6ENL5br4AbNBG1dWR71NCSsjO3jMECbDGN6NscLiszcsQgElAMMNM
 R3/NufZ/7h4Pn+g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 6LV3OmlHrlHMxFnnynH2ie7rDzioGt-b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX3GF3F0O67HUb
 w2/RnCkrASDOoSqVQTCulH1lZ0QGrPCGKs7Q/ljC4mpxYvfdxB97Is+W+ppj9bQ+8O8rwzM0wcZ
 YqMyFpHKa+v5y7NY2DvibbVmFlQhyc0=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9195b8 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=m4uPUOG36isBoBWOdqQA:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfXxFPNMw4rd/Co
 anYFjS8xsKgD/fWNUHrGLjwxloqjh2QnTVg6niJd/VSzTMRJHhVLDr/d1n3Ya/bHEqAsL5IbTf4
 6voT8kSV4qAV8a/EgDgV7g/TLZaVwmdEclblQKfKeqxev0zYvAEeJ/nMXJaFidfZCPsG0r64423
 MG3m6fBHXpWCYmCi1fkipSy+Sj1GJWE0j+IEsngPCHA0MK4W1ePQR3R9BHJ12oBNrdg6oukc1yt
 /YVO/kh0N/bwUptVtVHaVGO+T+1+WteFzp+6zti2Zy7YwbIA6BhDpTZLVnAEJ0O/ht4l13/rDc6
 S7XbgrnTbB2FqZ/gaROgbWCijhhBmhFGNZfTV0nwX5j7hS2NvbycbmQkGcK5oHXOVnNNaEm5qko
 pZ0CgW/WIja3BVrwHMKrrK6JOVZlM20cfGzfL5gM52JpAkDzOQ0TD19FrNZCDwVTUdKsdg1pIH8
 +u07pLcMBUily9lZV3g==
X-Proofpoint-ORIG-GUID: 6LV3OmlHrlHMxFnnynH2ie7rDzioGt-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

Qualcomm Eliza SoC comes with an Synopsys HDMI phy, unlike previous
variants with HDMI support, thus no compatibility is expressed.  There
is no documentation, except register list and register programming
sequence, and downstream sources do not point to any supplies.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/phy/qcom,eliza-hdmi-phy.yaml          | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,eliza-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,eliza-hdmi-phy.yaml
new file mode 100644
index 000000000000..764fec0ef29b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,eliza-hdmi-phy.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/phy/qcom,eliza-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Eliza SoC HDMI phy (Synopsys)
+
+maintainers:
+  - Rob Clark <robdclark@gmail.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,eliza-hdmi-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: iface
+      - const: ref
+      - const: xo
+
+  power-domains:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,eliza-dispcc.h>
+    #include <dt-bindings/clock/qcom,eliza-tcsr.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    hdmi-phy@9a0600 {
+        compatible = "qcom,eliza-hdmi-phy";
+        reg = <0x0aea1000 0x1000>;
+
+        clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&tcsr TCSR_HDMI_CLKREF_EN>,
+                 <&bi_tcxo_div2>;
+        clock-names = "iface",
+                      "ref",
+                      "xo";
+
+        #clock-cells = <0>;
+        #phy-cells = <0>;
+
+        power-domains = <&rpmhpd RPMHPD_CX>;
+    };

-- 
2.53.0

