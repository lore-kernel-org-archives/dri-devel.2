Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74B5C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C4110EFBA;
	Wed, 23 Sep 2026 10:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5RKJwC0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F/iMFXM3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9832810EFBA
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA31nm3936250
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KnHn/YYXznG5uBOCe2EMlfQgoUjuqbdlAiuXokE+3LQ=; b=L5RKJwC0TLyzGtO7
 9REQq5D8nIdeBlbiqJ6bNbcfxAZMRzNsdwS4haT1Z/wpvAu1KDCKj6d4tZ5dPUsc
 CH0gQbxjp2s3f++AsAm+O7WeSyaGQJpDN8UHxhAgBSlThLYaIQrCt6qGqV7lZXdd
 0APQp0Xl+t3tafsWJDafAdU/UAscOjn/C/WDGVI717wHZIj8SbjtyqTFWEuK3c6N
 D8iL7eaNDGyhwRUlHQ1ktdqeOTmWnDogG9UzD/ZiFqY1Eml1PyLrav7aId1NIz2c
 44fu/R/GWNpA4sSIlHIELpq7A0uOwEKrCh/EWmyNUodDANlRSp32iVdXjImQ9ie3
 ErHy1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428t8a4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so1682099eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159275; x=1790764075;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KnHn/YYXznG5uBOCe2EMlfQgoUjuqbdlAiuXokE+3LQ=;
 b=F/iMFXM3YqgEIruYnz1tGhE+whwCHxD8Dqu2T6d9zYZDb1xFj5tbXiqCGu7NpNkXVt
 ohpI9PBtvcSRb9STq+bTovXV3R8MWrwO1LWUibbk8PiimJXbpihFzPCWVO0OTUBsp11G
 3GKZZDszrUD5Dp6VU1d651XJPsBG/wBBxE82Y0W/tCI6s96HK+3lGfZV1o557QP+tOKF
 t2N7iue08+jkAW48sM+i8cfpHblWVa9RZWPY9O7QkEx41sdeaz4kVO8IqkvHw0s3z1/1
 ZurqB3qcfR4rgzkZ+sa+1GkG9HMAa4gF0lltzkKrD1/g2tIFShF//xm3wocacnz0xC05
 T3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159275; x=1790764075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KnHn/YYXznG5uBOCe2EMlfQgoUjuqbdlAiuXokE+3LQ=;
 b=nqWZ3FaRxcb3dJN/R2zhfLfFrGCBghmmot1FQIl962yevxsHhMXHQ3pnZ87eZ1vvSS
 xflapIXtQDe1lB2rYaaN9V+CA5s03Xc7q6GG7ExB3gwRFrC9sn25mV4qN8hdBCTKViGL
 5LBOlPqQNC2DSPC3L2eMaFD7DmED9TJTdqDkmplsZMM7ZlDpd1uFXkJe9OS/YIWKqD0t
 DP243ui/Fl+Dlq49+L7/Yq4JmIx/lInzU4jq/RVH1aIWD71UZG5zVXGwGJG/RqJkGAX8
 Tk4d8ljXjh74eSmmDa4FIRD7o7UugMMF13ieim4YVXc1fLrxzU7fIvIv+ToHi3HxhtM5
 WBFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwizOmNZuiY+ERjqXqdFOTA6Rq1GQLAUVk3/Z3QEVAxuYkNGKqS7a2rVH7QXoOWFn5ugMaYKymf3js=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNTeaJdWtJW1Rqg7TDDBy61Ns4gNn322I1ww8mHLjlXWjRmoqV
 0nOHvvvmKdq6fHJbC5UVEB7I3fGqt/hZGsEn/xpWa9wCXadxPofFfnj49rv5SPXynjx3K8mkuG+
 Qjmv/7vtWiliQxNHnYnidt4mqqDuaoTEBdU5kpHhvTplGMyGttl9Oy6MfFxnsvmUalisV55E=
X-Gm-Gg: AYBFou3Ajuc+A5+uJZC/oj6cWNmDI9Sl4FwbZ7gJPR5j7iyit4UX+x9h7h9cNKiKK7t
 R5gXMahg6SMAwXcxM/jIbBac2gvC5qnUNRCGpyQz+RbpTbNrsKGKRJ2kVL5WJpAS8lSR0fhrI99
 v6Hgi0vPGucjmW/MkX1PUPVoffQsygCSnPNfmiDBJvxjCZ6fpPkxNfQ9VrT0gfAClyPjPg7NX1G
 fi1KwQaKNk+7F/vX7n1bHRFKBxred2U4hfHCJpD36Kur7sYO90zjLlEVtriOPKs/znNO4OymzhW
 qvYUvngDHOSyn1C5e2eMP7w3bUZ5kK1XgYyJ61zcRVW8F3mwNlCBfTFRqTX90JTazUgaAhOCueX
 uzyDwuDfQjPgbGpLfxSCDoE4=
X-Received: by 2002:a05:701b:2919:b0:144:c122:6cc7 with SMTP id
 a92af1059eb24-144f9193b3dmr2210125c88.33.1790159275254; 
 Wed, 23 Sep 2026 03:27:55 -0700 (PDT)
X-Received: by 2002:a05:701b:2919:b0:144:c122:6cc7 with SMTP id
 a92af1059eb24-144f9193b3dmr2210108c88.33.1790159274610; 
 Wed, 23 Sep 2026 03:27:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:27:54 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:54 +0530
Subject: [PATCH 14/15] arm64: dts: qcom: maili: Add GPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-14-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=9922;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=YbDqye2yvDphoomeAbkXvJAQe2FIURd/yTiH/CKWuRA=;
 b=c4seMpP31QW30SERZ2dx5FiaFfOVT4rVDhg5PYtH69fzeJ99oSk5Io3hf84QrQ96m4rIE/Tfm
 LAFhVV2z+BFDJzQN5TK7Dod/gAxPhhOekOebh1E4XIgJ4U1UkPRVwhG
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab3a9ac cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KeQ0XDkze7PV3Olr-34A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 1B31luqJizYftWed_b5sIivkbCPWhW7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX9vD8kLLMxrXL
 MSRJDRfP+S8FoU9LuhfqLgYooeG8m05x5KO8fdM7Jt9NSu2Hcpq8HlcB8EJvuSNygy9ZpCn1Y+6
 98b4/4d8jPg5x+WJfGmqDFcuQSHZif5IwLQrO1dxELqd4NTGEeFXpAkOtzo81I02S42ASlIjjOi
 RORfNvqS9pcEVoEA2r2m7tHHH7i/JiRisgQhNSjZ39qcnvOf/z/rvgVb9ZG/coMKEYEwN77Rc7X
 0BNap6Ctp8u6Wsko4xAxzk+a2PpNW9emYeD1x5b9+KURqMECowumyrcLwNyy/LjoKuc5rwoVKF3
 JYveB6a2d8uKDAsUlHAei7Hmuiz8KBw92VEZJdwyG6ZQfttin97tuhhhaobhHMu+5NUAobZ63Jo
 Xd3V5IvkDwqw2BE2LD4BYUJtdad6+7dC1Lx2lkJ2C0FFKEqXcGzkk65XCnWseAkigSJSMul4mZM
 Y2W8j0DRHCTZg7nVqVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX4VKUSc4g3IiI
 J+kDOMusKY2E070hSX0GVUkQguLRKhYe/FkjTOHJY6NBImBVgwPz3E4sYRrQ9idb49psv+AdSGx
 X0Up4HPoVbpcu8eh3BiXeKaKQZnVA2Q=
X-Proofpoint-GUID: 1B31luqJizYftWed_b5sIivkbCPWhW7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230041
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

From: Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>

Add the GPU and GMU nodes describing the register maps, interrupts,
clocks, power domains, IOMMU, interconnect paths and the OPP tables.
The GPU node is left disabled here and is enabled by the board
devicetrees.

Signed-off-by: Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/maili.dtsi | 309 ++++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/maili.dtsi b/arch/arm64/boot/dts/qcom/maili.dtsi
index 886d307e536b..27558fbc307f 100644
--- a/arch/arm64/boot/dts/qcom/maili.dtsi
+++ b/arch/arm64/boot/dts/qcom/maili.dtsi
@@ -3776,6 +3776,250 @@ tcsrcc: clock-controller@3b13040 {
 			#reset-cells = <1>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-44041400", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x6c000>,
+			      <0x0 0x03d9e000 0x0 0x2000>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem";
+
+			interrupts = <GIC_ESPI 364 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 0x0>,
+				 <&adreno_smmu 1 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_microcode_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-1450000000 {
+					opp-hz = /bits/ 64 <1450000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3_1>;
+					opp-peak-kBps = <20832031>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x88295ffd>;
+				};
+
+				opp-1400000000 {
+					opp-hz = /bits/ 64 <1400000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3_0>;
+					opp-peak-kBps = <20832031>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x88295ffd>;
+				};
+
+				opp-1350000000 {
+					opp-hz = /bits/ 64 <1350000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <20832031>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+				};
+
+				opp-1275000000 {
+					opp-hz = /bits/ 64 <1275000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1_1>;
+					opp-peak-kBps = <18671875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+				};
+
+				opp-1201000000 {
+					opp-hz = /bits/ 64 <1201000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1_0>;
+					opp-peak-kBps = <18671875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
+				};
+
+				opp-1126000000 {
+					opp-hz = /bits/ 64 <1126000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
+				};
+
+				opp-1025000000 {
+					opp-hz = /bits/ 64 <1025000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
+				};
+
+				opp-951000000 {
+					opp-hz = /bits/ 64 <951000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
+				};
+
+				opp-843000000 {
+					opp-hz = /bits/ 64 <843000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82c5ffd>;
+				};
+
+				opp-801000000 {
+					opp-hz = /bits/ 64 <801000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2_0>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-759000000 {
+					opp-hz = /bits/ 64 <759000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82d5ffd>;
+				};
+
+				opp-693000000 {
+					opp-hz = /bits/ 64 <693000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x882e5ffd>;
+				};
+
+				opp-636000000 {
+					opp-hz = /bits/ 64 <636000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <10687500>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x882f5ffd>;
+				};
+
+				opp-578000000 {
+					opp-hz = /bits/ 64 <578000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe02a5ffd>;
+				};
+
+				opp-539000000 {
+					opp-hz = /bits/ 64 <539000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L2>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xc02c5ffd>;
+				};
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xc02d5ffd>;
+				};
+
+				opp-461000000 {
+					opp-hz = /bits/ 64 <461000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L0>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xc02e5ffd>;
+				};
+
+				opp-422000000 {
+					opp-hz = /bits/ 64 <422000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-390000000 {
+					opp-hz = /bits/ 64 <390000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-357000000 {
+					opp-hz = /bits/ 64 <357000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0_0>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-325000000 {
+					opp-hz = /bits/ 64 <325000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-274000000 {
+					opp-hz = /bits/ 64 <274000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1_1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-222000000 {
+					opp-hz = /bits/ 64 <222000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-190000000 {
+					opp-hz = /bits/ 64 <190000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2_1>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-157000000 {
+					opp-hz = /bits/ 64 <157000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D3>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+
+				opp-125000000 {
+					opp-hz = /bits/ 64 <125000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D3_0>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82f5ffd>;
+				};
+			};
+		};
+
 		gxclkctl: clock-controller@3d64000 {
 			compatible = "qcom,maili-gxclkctl", "qcom,kaanapali-gxclkctl";
 			reg = <0x0 0x03d64000 0x0 0x6000>;
@@ -3787,6 +4031,71 @@ gxclkctl: clock-controller@3d64000 {
 			#power-domain-cells = <1>;
 		};
 
+		gmu: gmu@3d6c000 {
+			compatible = "qcom,adreno-gmu-845.0", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6c000 0x0 0x32000>;
+			reg-names = "gmu";
+
+			interrupts = <GIC_ESPI 368 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 369 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_MXG_AHB_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+			clock-names = "gmu",
+				      "cxo",
+				      "smmu_vote",
+				      "ahb",
+				      "mxg_ahb",
+				      "hub";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gxclkctl GX_CLKCTL_GX_GDSC>,
+					<&gpucc GPU_CC_MXG_GDSC>;
+			power-domain-names = "cx",
+					     "gx",
+					     "gmu_mx";
+
+			iommus = <&adreno_smmu 5 0x0>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-556000000 {
+					opp-hz = /bits/ 64 <556000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D3>;
+				};
+
+				opp-788000000 {
+					opp-hz = /bits/ 64 <788000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-825000000 {
+					opp-hz = /bits/ 64 <825000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-880000000 {
+					opp-hz = /bits/ 64 <880000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+				};
+
+				opp-917000000 {
+					opp-hz = /bits/ 64 <917000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,maili-gpucc";
 			reg = <0x0 0x03d90000 0x0 0x9800>;

-- 
2.55.0

