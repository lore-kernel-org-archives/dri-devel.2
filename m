Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C18EC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE87110E0E5;
	Thu,  9 Jul 2026 18:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yr64cHKx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aqILzqIS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44DF10E9C7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:43:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWt4E2514873
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=; b=Yr64cHKx2hYIcvXe
 23qMLVYQYQjimgeW56vjD2MNs3ZzA8c2CBI8GfDJhERElGzyCBvkOMB1h7wK1Ydx
 AMjl5K4t1loPPLIWggmRW6d+ZMsz1M/pH87YN4nX6YjIoQETLejy3YLdK3eN9bhH
 QA6ZIBnYhld8ocJ+bTjhZpS2KhQ26xVmhRk+yw2weltV8Z/++RofZkaVNAwzB2eQ
 BquSxmo67+ChX5W8gQvc0SWRzGhn1GnjncLx2DlY37Fvwm7R4uJz1XszME1yvMOW
 ZI00+PqI+jIGcuEo/oVw6vZexs0PM66Snyv6aGdWHdoefkyQ6rHbXtcMtAF45dUS
 z0xWdg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418kybs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:43:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so1288077a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622591; x=1784227391;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
 b=aqILzqISiPNEwu7vIFdWb8rZnD7uZBpuZPSx2H6nH3hqF3dsBnAva2/l0jvgFbCLe5
 6XImPIjQNN3M5RWVGM40xlILfsf13L1hjSMFl8t3TgaAIiuis3VnDqZFmuJd7ms6BVGB
 X55Xe/qsuxKHkXm/x8fBZAfZJkXpf4Az65Uan9ujaVWuyA94BXvtTcqsEO1X6qjoRtII
 5qV1devl9uq/zY/iL5B0Emg2ux6JB0RjPEijEGeUIIgnzVDe8wunuxljzpQap/TE8l8J
 eJ359nw2dTq4Gp0/2Jq6EN4pkuA+BFGNeqzI061zMZ7KztlI4ixaISbZga+Zoc/ECqdz
 6KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622591; x=1784227391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
 b=bzRNWeZZmEpUXGrp8CgmNtzJ8EAECIp404KAvoNrFcmDwNVo9+dXmaczp/AbMkyDep
 rugspXakVYocZVQ+/uPhvs2aTimxDmUyZdmpZCyKQevrcUYwK7L1X+ye6PlExpLJEITB
 OtVRsucNcTrlgJCpApodOBlS26LwcXmJ6uH0SdijCqIkmR7onTgyvoxKhiktcqNq2LqY
 ROfK7ncGHiZ/53D5zDFGYmN/siRtcirHvsMGQ6Wiflepfn7T5yV6mtIjF+TRjHH20iuM
 n2N2EwEeM7502qQW3RkgSRgZd+Ei1uirhWX+PEwYuiQJyJNb/ofgkasmXVPhZRahEIke
 S+Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqarzlGlxbFIAtCLB50+Zk3rfQNdjxDyx6bF9ktlSN2qTUfHoz1tLpmLWDGf40l54ZWTyBSl11L0dY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxF6IqycuFP5D9JYOtLaUUVG8xaUbJTgttGAokDofVerAdv5Mir
 aiyPweIDUyAV1vtYn2XTDXT1GJT2XtSekyF5RAKZ8g4dowbC1AY1YIjXYEBptY4RX+ZEJcLTTTS
 Lq6tzIHS0ye3TW3x6FNT0UwwEKsi9883Tolm6+Dhy6bbpdPiRep4AZVdIDVEluhdMn18jJtY=
X-Gm-Gg: AfdE7cm/vkde/GYA89qMrF7H44o3WSMvIIUSgtXH3tE2jV70SP1qZFI6yf3Ya/vnVwj
 pa9CXk32JTN1ZPwJHgGm59ajEK5VGaBkPr7Z4sJLuvAoX2q+kYMys1Er1RJ4J/xHynODdiUYCN/
 gi3aHYey3pjXi71vsnCA0zidw08zvCm9/anaU3W3rzDtYKIAx1GeKniB0hGPcl+zgT79U1Ghiau
 p0qdVqEPSS26it5icei5zJu4ycQTc2m7RTmyV7LF0VdXIzNotOMLJAAOEttO9+fMX87jfVW4084
 86d7ao1+764X1UkG0sKEvhl4jW5qGn+tXxgzFoTp0LkrnCodhvqeGcu5qbrO58zoIZEfjmA4m8j
 PIfXH24+tskHrnYe//g50DNCl0NRJzCI9QL8=
X-Received: by 2002:a17:90b:562b:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-38d1596cd89mr399555a91.16.1783622590626; 
 Thu, 09 Jul 2026 11:43:10 -0700 (PDT)
X-Received: by 2002:a17:90b:562b:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-38d1596cd89mr399511a91.16.1783622590143; 
 Thu, 09 Jul 2026 11:43:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:43:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:04 +0530
Subject: [PATCH v6 5/7] arm64: dts: qcom: shikra: Add A704 GPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-5-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=3495;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AFPL1mLXpKffrlVn7dhyAuVw3rCpzngGAE8+zg6xtsE=;
 b=tacrVztp9Jm3lWTvjjWw+Fn25POssjiE+J5DI8nPBE5GAX4Ro4DXa/HhntJJc+zyCEmRfs1LQ
 PKX6hvgevKVAd+LXbcTmBLwciCfuu6XNqjkJwaY5W0UAJFZrhFyYmNK
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4febbf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX9Gp6HVjycHVx
 xaiujQwjvw04Nz99DfAOiLLNOz8jxYi8QEWdbGWF5qBUd7xH9fCEBuKn3Nx8kQkkQVHlQC+XvWe
 xoQUXkJ+87xwUsiRGnQgS5eWntWJhU8h8S6hgqRB+j8nfEpcZgyWPo1zCb4SAJPFf6cylRqsQYm
 RB580ChBc7AVUxd8O8V0dTv9RQAEbHb27wWBdn5dkO1wyVtBfl9Yod6fLhsGToNrdh+aRby61HU
 9D++hoiZTScf5zqVoSJgv3f5TBAdcDdondLGC2MdJXqN6fFVQQ03g07q7tw5KHoIU3fw+IXMBD4
 UoGUTcttBfRAgbBSAhts7Mgrhds7E/jrjSEMUOuwv3DuoWMQB4nAbdwBmiSLLY5Ohfj1yF6dl7/
 5AYatzzXVTGB2aZHfL0kXcNnoETHgW4CUTVWEy3PLQXghqZnCQ/xcdGfHlIUCFE509Z8fJCtgyL
 ydWEf9XSLbRJ12PD9wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX8jv3xy17yw3a
 pHpLwx7fzraRqkT5A0cqRjjY/rgVlUqlxc74gEal0ww3qzopL65rrpYyMIt+zLmuafuBI8Z0k4m
 kBazwpNZzV64krKUmL5hdc1xLAe/zfs=
X-Proofpoint-GUID: _S-DzgsX8VoPEHzcrBsYa5ERDOR9x2ok
X-Proofpoint-ORIG-GUID: _S-DzgsX8VoPEHzcrBsYa5ERDOR9x2ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index bb11e832d9a6..34261221664b 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1992,6 +1992,104 @@ glink-edge {
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
2.54.0

