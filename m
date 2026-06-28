Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3515C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053C510E671;
	Sun, 28 Jun 2026 18:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZgboEVu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="esiCseN7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A40B10E66E
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:07 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHjEFj416637
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tZWd8W5XX7/HLNdwSpAX6KBOEbdxtoiIAFwHFv69UFQ=; b=OZgboEVuxMcDN85i
 Y5Ji1oWho8PfMGeIZdEbxjJ5YhcbiRGlx1BYYIadY0gw1ON+y14UyGDxP9tbV0PK
 HQi5qL1YHZkIr7FkYaTYWSeNBj3qEUFlot/67+zbO8oIxIVTMh9LdMwOu9rEElbq
 ikEo/IyDHF8/heK0jFMc6LViM6UUyaTbh8LxyQ/4NTmczhRH5Ry/8SRzS9TH+uVS
 NML3evCLmknzYfoGaM3xtTyHWe9PRWKTydf7LxMGmXTnO6pBar/pudLP74K3sO06
 d1eiWBjT06OBmioiovGWr0jppBEvimC0TBPwiNqkR1O9ObmskJ2f2ljbZFoInebQ
 FD0Keg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7u9e0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:25:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30e85f5bc9eso4247466eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671106; x=1783275906;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tZWd8W5XX7/HLNdwSpAX6KBOEbdxtoiIAFwHFv69UFQ=;
 b=esiCseN7Cc5k8grxVx5owB5YnOeVvZ0ag3/vDUj16gUQPhzNKwNfDv3WIRZvaO840t
 RXfhhsLU1tjL45vHQLw6TGt290RNeTQeyE4ehu3kz4bCuy4gciDmRZVjzez2agNifgW4
 9SDCvbCmB/k3p7KwEsUZC6pW5MjgzMPb704R8mJyr4PBwNx8iPkQQrMOUYn6yVBvGbmE
 nV2NRRtqBdZ7nRpIS9unnqUyI5p96mhPPZItLrBf9E/w5gm4CoO15cqLh3jbKprMPBV6
 RCViAzbBIUkE0sq7G00VAGseyvazxo4wotVi2BbmYkHt4e3A0R05A/I9m9lHXqmbpW8h
 14xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671106; x=1783275906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tZWd8W5XX7/HLNdwSpAX6KBOEbdxtoiIAFwHFv69UFQ=;
 b=I1Ayn+Ro4br9837SDRrlVegCbKNjSQmpB/pIk2sTBcS9m6A5rU5LSwaIMLuaJPOneo
 tr+V6UhSfrAHCnQmUGIGCK3MBledpd9jYf92JFyDXolYm7k/vxot0DW4tOJ88XAubrBX
 cu1DDZ9vFeRLW/hpxe1jk4eVYITmP93k57kEecjITfFqYdPslxncdlcg4YluqfHbLHWd
 Wgr/SVtVoCHTUFS4sYYYv6d55oJIU+K57fRJ5ZLHEPUsrPUj49gQ1D2bZYRJUKW7Skod
 lfTexNdyY5WqMqRRB+/m5yz4n2cO8sSD+D1j+yUlfUekxZA8cSW+X6aOzF8U3uODVLql
 IMEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrD5XB7l0nWxLyK3TUxWTAHuWA04LCYg5ZsbtaPI1gedvYzveVtCRSP4N/GTGatCEKb9KkBt+yYiSY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+5g4P8dPnKN8izdORUNXJUB9gNO9Hggh04Ff+S6strkYkeODZ
 j/35QNmHgqb74gcDk2AdRahzUln2iUC8NcNQsjPHr314C7iLgqr1aWgx8Y//GbVzJmSCj3sWS7w
 h1Db495hCOS5fEXpQtafOIix3bygA/fpqJw2shttk03ZzVpPNRCyL2vL/wbXRUKpp71fnMKcUUQ
 4MNFU=
X-Gm-Gg: AfdE7cl5m/uzSo733/zgTnFdWe3uvTp6Pq9Nj1+/LjyU7kcmh+ZvEzcNOVU2/YWgyhi
 AEHC7P/Xn/oTKF+PuBZVT28Fjikop8YmR7MQ5UiXk5SJrC11Qo4Cy0N0zrbJvFU2b53NwDCe3ow
 5GBvD3ojWpgIkArxVe37e68Sk6uuk6AOn+UBbnYHzwCBJ511TlLqC7FFSUBS/3eFtxGNYJayQcY
 sQ2b/1AGxknYeGY9Z/pxRb8/T8eM68kUZaKwSzYVd0haFpUG4cD//FktXl/FzcOU3LYpvnYoIWU
 HfNy42b8vGvupxJljMM3fbmFZR+v5+a8KwYINlAfMlpYkEbDerqJ3YXUxzusQmaoW5ClNhFmmfl
 4iedJrOAN8Gbbcx8oSatu3EqWfPAgOYQOOmE=
X-Received: by 2002:a05:693c:6383:10b0:30e:c2c0:a7ea with SMTP id
 5a478bee46e88-30ec2c0b39fmr1605934eec.41.1782671106000; 
 Sun, 28 Jun 2026 11:25:06 -0700 (PDT)
X-Received: by 2002:a05:693c:6383:10b0:30e:c2c0:a7ea with SMTP id
 5a478bee46e88-30ec2c0b39fmr1605909eec.41.1782671105369; 
 Sun, 28 Jun 2026 11:25:05 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:25:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:58 +0530
Subject: [PATCH v3 5/8] arm64: dts: qcom: shikra: Add A704 GPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=3396;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=esFO/JAL5nI43vIKxxFbdEl/5ME/PRB6OGuZfuTuB+I=;
 b=cVh4g1YdCpiwy7z9vQ1tG/9H+36qvoH8yaJMvnRIf/86r21odJv0LC0eJ6esfGD/OIpgsy8dl
 bSGuHuQPLv5CJuKWNam17yWd+3YB9Sd4PLC20Ocorpubqx9Ndcb9TJy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXx6LLHqZqmdkv
 tDfYAiqHS2pnG25ncc6U+uS/ZvH7f9MANZPqXhDKpbfTcd9GCT7puMlLUml9fCL27G/efW03VFp
 pcfmWaqxDsPAnOusj3d9ZyP8mkaBPaoLGgVSFzCTx5iV5GFQArZ730Wd6Zs7W/ZkA5ZAtdKaj2T
 EKkWYfWBuvvbcLau7okBVfAvG0MNRU7jmBjSIDqMWE8J5G181Za9F+o8339lqG8iwsbNxMqaBAM
 i5iD3hUDzVklMCcbT1O9BVMLf5WtwnYbxDBjKz5TFg18GdKs1vQCDOl1q5suMHxsAF3iqAzsO30
 2Mqiblgcn8ItBRB2irea54rKawQ3xTdDhk3I0ynePkO7CDi0rysO5wS/O4322RHppImdJd4Y7HX
 jVYq663PCKImi0syiKtZ1RHDaRgOzjMM+kfDAz4j4ebX3Re5aQIp5gX274SMDJHlGRD7MwW9CP9
 76J/F7kGLjVVzBdD9YA==
X-Proofpoint-GUID: CWgInojfkrmOYLIsokQk8mD_7H8ak8Qt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX6vjjeCK0hP+g
 Qb/PmZg4aLepY+zFBMR3Tsz4jJICpzE/qVkl03wh5/PjLiQ7vwq+1RQjo++JiunBA36WArR97gQ
 wF6Ikq3pLhquQnMKkMuVerh/na10uWY=
X-Proofpoint-ORIG-GUID: CWgInojfkrmOYLIsokQk8mD_7H8ak8Qt
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a416702 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
interconnects, IOMMU, OPP table and the zap-shader region.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 398cb1a4dc86..89cc5dc767e2 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -642,6 +642,104 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		gpu: gpu@5900000 {
+			compatible = "qcom,adreno-07000400", "qcom,adreno";
+			reg = <0x0 0x05900000 0x0 0x40000>,
+			      <0x0 0x0599e000 0x0 0x1000>,
+			      <0x0 0x05961000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "gmu",
+				      "xo";
+
+			interconnects = <&mem_noc MASTER_GRAPHICS_3D RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "gfx-mem";
+
+			iommus = <&adreno_smmu 0 1>;
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			qcom,gmu = <&gmu_wrapper>;
+
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1142400000 {
+					opp-hz = /bits/ 64 <1142400000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-1017600000 {
+					opp-hz = /bits/ 64 <1017600000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-921600000 {
+					opp-hz = /bits/ 64 <921600000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-peak-kBps = <7046875>;
+				};
+
+				opp-844800000 {
+					opp-hz = /bits/ 64 <844800000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <6074218>;
+				};
+
+				opp-672000000 {
+					opp-hz = /bits/ 64 <672000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <5285156>;
+				};
+
+				opp-537600000 {
+					opp-hz = /bits/ 64 <537600000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <3972656>;
+				};
+
+				opp-355200000 {
+					opp-hz = /bits/ 64 <355200000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <2136718>;
+				};
+			};
+		};
+
+		gmu_wrapper: gmu@596a000 {
+			compatible = "qcom,adreno-gmu-wrapper";
+			reg = <0x0 0x0596a000 0x0 0x30000>;
+			reg-names = "gmu";
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+		};
+
 		gpucc: clock-controller@5990000 {
 			compatible = "qcom,shikra-gpucc";
 			reg = <0x0 0x05990000 0x0 0x9000>;

-- 
2.51.0

