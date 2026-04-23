Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7330F589CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3327C10F121;
	Thu, 23 Apr 2026 13:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WkLmNkn7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JG1l24/0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE32510F121
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8u6Uq029159
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IxKnnpsONYWDC/UdxZPj9n7rzpecjTFOvlyc5AqI6kM=; b=WkLmNkn7VwC2zF0j
 9ru9bL+9hZNmCUHDzpAlo2Vn6XYfy+gkgR41grcxb7bJdvzCwi51w1XV0W/wtl+N
 shW4kos8aog2IE6eW1ybAJP1ARSFsI0MMaVfJ3UVXkxF40n/SxKEnUOr90WqXPkf
 HS/MCCPo0JJhVplALEyPr7pSWKOpRYXR4mBLhL4O9xlO7yQW2QiNiZwyNFHY1D3a
 FcICWMhTqPq3HbZbI4Yeifgu13M9KBUTGgTcmZogzKQlHm7EUXOy1oxk/PP0D9Bb
 3ag4FFzVbJsanDg7iIN2SIaOgyoVgSRn5Sdhb/sO/uaPlPkITZl3a4mRR5CrtbQI
 JtVVsw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqdjm1qse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24308165dso77488035ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951034; x=1777555834;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IxKnnpsONYWDC/UdxZPj9n7rzpecjTFOvlyc5AqI6kM=;
 b=JG1l24/0Bli6sWwJ9NIPT+chdYt3pwnUj7l1AEGPSYCBRf5murIdru00HEv2pV9tAq
 ECv/jc8XZjyQwpHPTKHVpSMTFy3uHKHb5UzPCjYSf3yBAIG3xLunXEDySEf8+OX14VMd
 VwP93qDPGnrtfknlXftZUq6py6A2+rhdw6WViazjuQrVRHK03N2vd+0I6471U83ot3Vq
 aOBr2Co4yiKhwxHvAXMWoxXSAxH4Ac1bDkkdL8SG0AWBsBsTEiWdsAjxTCs22qMgQAHW
 0swMTRh20QOLUY80ppxt+Y+3et/pnlJPl971IzBsuGBK0bFEpZwMeKgnf8shWM7xc1kY
 a0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951034; x=1777555834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IxKnnpsONYWDC/UdxZPj9n7rzpecjTFOvlyc5AqI6kM=;
 b=qEL7yVnTUpmOpuHQpBS0RAxQSVwAjkDbxYEOpxPNBTtPxT4ZtdegPPz7369iSlQ3Rz
 k7fUXQMe5/jFEwezeLTJlk9Cw+TQtdXgwD6zK50Z7QNrtCbEoX9gZ7FzscR4iV+UJt9h
 Mg6UcLtKHjd8D64/pB96zjc2jMWmDXodB8HoWEmaElLX8ZobWvljpmJdEULf0+11w51T
 2gawcjjFmnb06LWWJU+DqpoMWZpAp8ZCTsXRD6i13vp21l6biPgFOpnGaVeBkb3VboDj
 R/NhAhI4CzWDakm3b4bnhJRC3Cud3Rs8JnLSHirUiklDoKikqhNu142ojd2r1i1IxBrX
 FCgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RfyTL5Mn3aqI1f1/ilcz7OoC4pYm8PZgdpBBvwn3KMBnYHbrLXkkdhdOSG/GJczIt+W1gz9XBwGI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxivHAACqV5scau9ZshDg6xpQfMFMeMq9WJu2w/U8r1cBGxnq/0
 P1GndPyk1qoI8cBPFGbb9j80Y8IMCWcV4lR+Lkps+iKDxumD4nveulqJZ92PPYB3sxG/NDVlQeV
 mLANcJc9eGzHuayALSFIHRAUiKZGBW9G/mkNWU0dIGg5kpBUXAUtuA1hwvJGSYyX/HGzm1C0=
X-Gm-Gg: AeBDiet6aWjSwkOXq7uLFvxXQxHf5ggtW4UjuKQEyj+jlLds+WbwFcg5Z03O3EXzK4T
 H7q7+zyGW5BwuyMw8rOlNXgqAwlKP1SBBgJYXk6Q0cvBjzu3EUSQfszq3NMxPwHePWqABj54ua6
 JOlMlo68qZMC27qiqN0pwhyhK37icev3CUJJCGrslNYXWkv/JH3zIhZAyK3VaRjqL+MAxBq4mWP
 3zxFCoIapZGU7RT3q5VHYYpyszoUFJW/Qwh6qwaqYK8Kc6IGRpVJD+slUnn0IR4VDYNa1wkaMZZ
 sCcp+OzqxJc5ILubOJPNsAe9GJyIFW4NcLtLCefY4SUN4cpM6TOpGd4UYzJSVZTUKC37ZytUPgD
 /uy2fJu7N8fBA/2tjSyNPAiVlejKtUE3lkUJYBfWASUVth/xtq/qBuEOJG1YE5iiMkA==
X-Received: by 2002:a17:903:2acb:b0:2b4:6398:6aa2 with SMTP id
 d9443c01a7336-2b5f9f3a802mr308921975ad.27.1776951033400; 
 Thu, 23 Apr 2026 06:30:33 -0700 (PDT)
X-Received: by 2002:a17:903:2acb:b0:2b4:6398:6aa2 with SMTP id
 d9443c01a7336-2b5f9f3a802mr308921065ad.27.1776951032700; 
 Thu, 23 Apr 2026 06:30:32 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:30:32 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:33 +0530
Subject: [PATCH v2 04/13] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-4-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=7570;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=EqdrZDhwbeUXkKMJ4KC0f5Nf+jlPc2iG/3BjVoOnKh0=;
 b=DWWeTu5sHeIIPoCMxxKeKnUf2R7cu3pGbQ+jYfdVZkIXigbOi/ygY3cFzpTJKwEs98YuT397d
 803RuZl0G89C1d1JcfrPcKhpHAcQX1cQd6AXFddmyDniHzZlnyXOdzi
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69ea1efa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=17OVpTNTOV0qq6DYWkQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: nm2HxNHhDvlc4InhOrk9ipKjzJgowqOC
X-Proofpoint-ORIG-GUID: nm2HxNHhDvlc4InhOrk9ipKjzJgowqOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX8TL27HgG68G1
 rmTQQshuZtBWttRoRQWy/NH7LeXffEYMsa9/bXdP0zn+5a2o+Qc5bQoTmzuNdQDvJgEv8PQ2kWY
 NWDbcMahPL74CDkuWZt7uf0xbpOjvBTCwA8O/M0gyWyMzJTvEbXTRZSCTRGMwpKrunAFvPCtSL/
 kV1LxdmXJaCOxpCgL8Cl7muXT0BS6YUxNs1oemXMnVxOw/tRnNc6TGgX3LZrRa7lcvhAUkMKme1
 Kyy9fO58nTQcEXiA2QO8tCd0m+SkewYkgBDgf908czPFui87ow/2Io9hlMZ37b61UdXsmCmu9tz
 ePhtqz+TAIyJ7TRZqc5XD6L8r9QTkbWoaPacxLCHBjbmvWxrFT7Rhj/m6gg+hZqub6RRc0Cd50q
 Bu0i6Ufin6HTBVySIjgRuIw1fpVDAg2tCUuyaEhJk+bJauNVayabJx8ZjB2TCgCyyVkxSo89yKM
 8c0imRuYPWQgtSXrcfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
is a new generation of video IP that introduces a dual-core architecture.
The second core brings its own power domain, clocks, and reset lines,
requiring additional power domains and clocks in the power sequence.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 220 +++++++++++++++++++++
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 2 files changed, 231 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..0fd8a8db01af
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
@@ -0,0 +1,220 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,glymur-iris.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Glymur SoC Iris video encoder and decoder
+
+maintainers:
+  - Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
+
+description:
+  The Iris video processing unit on Qualcomm Glymur SoC is a video encode and
+  decode accelerator.
+
+properties:
+  compatible:
+    const: qcom,glymur-iris
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 9
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+      - const: vcodec0_core
+      - const: iface1
+      - const: core_freerun
+      - const: vcodec0_core_freerun
+      - const: iface2
+      - const: vcodec1_core
+      - const: vcodec1_core_freerun
+
+  dma-coherent: true
+
+  firmware-name:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 4
+
+  iommu-map:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+  power-domains:
+    maxItems: 5
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: mxc
+      - const: mmcx
+      - const: vcodec1
+
+  resets:
+    maxItems: 6
+
+  reset-names:
+    items:
+      - const: bus0
+      - const: bus1
+      - const: core
+      - const: vcodec0_core
+      - const: bus2
+      - const: vcodec1_core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dma-coherent
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - iommus
+  - memory-region
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/media/qcom,glymur-iris.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    video-codec@aa00000 {
+        compatible = "qcom,glymur-iris";
+        reg = <0x0aa00000 0xf0000>;
+
+        clocks = <&gcc_video_axi0_clk>,
+                 <&videocc_mvs0c_clk>,
+                 <&videocc_mvs0_clk>,
+                 <&gcc_video_axi0c_clk>,
+                 <&videocc_mvs0c_freerun_clk>,
+                 <&videocc_mvs0_freerun_clk>,
+                 <&gcc_video_axi1_clk>,
+                 <&videocc_mvs1_clk>,
+                 <&videocc_mvs1_freerun_clk>;
+        clock-names = "iface",
+                      "core",
+                      "vcodec0_core",
+                      "iface1",
+                      "core_freerun",
+                      "vcodec0_core_freerun",
+                      "iface2",
+                      "vcodec1_core",
+                      "vcodec1_core_freerun";
+
+        dma-coherent;
+
+        interconnects = <&hsc_noc_master_appss_proc &config_noc_slave_venus_cfg>,
+                        <&mmss_noc_master_video &mc_virt_slave_ebi1>;
+        interconnect-names = "cpu-cfg",
+                             "video-mem";
+
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        iommus = <&apps_smmu 0x1940 0x0>,
+                 <&apps_smmu 0x1943 0x0>,
+                 <&apps_smmu 0x1944 0x0>,
+                 <&apps_smmu 0x19e0 0x0>;
+
+        iommu-map = <IOMMU_FID_IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
+
+        memory-region = <&video_mem>;
+
+        operating-points-v2 = <&iris_opp_table>;
+
+        power-domains = <&videocc_mvs0c_gdsc>,
+                        <&videocc_mvs0_gdsc>,
+                        <&rpmhpd RPMHPD_MXC>,
+                        <&rpmhpd RPMHPD_MMCX>,
+                        <&videocc_mvs1_gdsc>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mxc",
+                             "mmcx",
+                             "vcodec1";
+
+        resets = <&gcc_video_axi0_clk_ares>,
+                 <&gcc_video_axi0c_clk_ares>,
+                 <&videocc_mvs0c_freerun_clk_ares>,
+                 <&videocc_mvs0_freerun_clk_ares>,
+                 <&gcc_video_axi1_clk_ares>,
+                 <&videocc_mvs1_freerun_clk_ares>;
+        reset-names = "bus0",
+                      "bus1",
+                      "core",
+                      "vcodec0_core",
+                      "bus2",
+                      "vcodec1_core";
+
+        iris_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000 240000000 360000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-338000000 {
+                opp-hz = /bits/ 64 <338000000 338000000 507000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_svs>;
+            };
+
+            opp-366000000 {
+                opp-hz = /bits/ 64 <366000000 366000000 549000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_svs_l1>;
+            };
+
+            opp-444000000 {
+                opp-hz = /bits/ 64 <444000000 444000000 666000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_nom>;
+            };
+
+            opp-533333334 {
+                opp-hz = /bits/ 64 <533333334 533333334 800000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_turbo>;
+            };
+
+            opp-655000000 {
+                opp-hz = /bits/ 64 <655000000 655000000 982000000>;
+                required-opps = <&rpmhpd_opp_nom>,
+                                <&rpmhpd_opp_turbo_l1>;
+            };
+        };
+    };
diff --git a/include/dt-bindings/media/qcom,glymur-iris.h b/include/dt-bindings/media/qcom,glymur-iris.h
new file mode 100644
index 000000000000..dcaa2bc21db5
--- /dev/null
+++ b/include/dt-bindings/media/qcom,glymur-iris.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_MEDIA_QCOM_GLYMUR_IRIS_H_
+#define _DT_BINDINGS_MEDIA_QCOM_GLYMUR_IRIS_H_
+
+#define IOMMU_FID_IRIS_FIRMWARE	0
+
+#endif

-- 
2.34.1

