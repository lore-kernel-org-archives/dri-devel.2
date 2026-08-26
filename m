Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7BEC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F375E10ED43;
	Wed, 26 Aug 2026 13:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRR0uv4L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcctitDT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7377410ED3C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCC3ua768394
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yXYsL0fAbC3F/0wJOXGtV7JM/BPaOMrDrDEXkiSmrko=; b=BRR0uv4LBgy0pCAW
 R14PWeeU6Sy/kqxuxReQsSe63wi6xFGTiSZhjXg2qiY6gmJerHEG473icK+2Lud9
 9gMA7Ca2/c+PhZgcHy4tNobwtO7rwYV7WT8Rrsj0n5bHXlOVwrGmvi+E+Exzw1hK
 BED28XtVG1vcWKPM1LYz6adQYdaINn2nFsx0MvTpDQ4F74YWPNDMXLXWuhIeZ2YO
 NzdRissYVYrZX1k1JS07KkcsNgAZyF5JSavkv5tTarD4VaVzNgJcvqvi1GRsuaED
 XH8b6Y072+FNwDhXlaeNDe4oiQ9auVs1d5XNjrO1fNxt/PwvmJIR6pnOTishuKyR
 5XQbgQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n0tvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so1290281a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751980; x=1788356780;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yXYsL0fAbC3F/0wJOXGtV7JM/BPaOMrDrDEXkiSmrko=;
 b=RcctitDTqQKrKMveJ7LREBgKmSXjsaODbTg09CYEbgOE9YMFdydyH7PXkI5pRRv/Hp
 UtQtD/dllqbfe2ruQ8yMihKQio0GjYWrdmkbskBJmhc+UiWxxL9cW3/qjrx9cedmTxrO
 A6XbVmPv5mSdS0BcR313ipXKa00/IcEtnuPgi+f5WXu0jErGvhZK8N8wl2im3ZdcUW/g
 sNY9DAowWT4vdPT8tFQ2lN9GN+P4WZnFspCQcDVxk85rpz1kAtexcThQTrecIB+BjTJ1
 Uwc6KtAnXBaLT1x4EyswS6qg4B/ghCjw82VrFyPl1yx6d1YT7pl/3qj1Tr9FgBSN0uvF
 bFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751980; x=1788356780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yXYsL0fAbC3F/0wJOXGtV7JM/BPaOMrDrDEXkiSmrko=;
 b=J9pwfVEgBs32W7z7jcYEVhG24RJb2iDaNRQeqHrTMxmi3YNV7CNdKkGpwmFondGfLt
 gjOk6PwYvHHmOgd3XfYPmeRnB1VzGopoMRnq34BOb9JKTxerySsjkI0g+01uts/Fp69A
 mFV7rwz27tbQDYOPIYY22BYMgF8rIl+NgxTFx/sdlZCvozIugkv6x5K1SM5ngzH6+Np4
 BS5TSM/gAEiQEHg+9vY+A31STjlL7Yk9l9GH3P6eufb+u5ncn4FemTZb0YzX16lnc2fY
 D/D1OXRskJiMPPuoK/fPnjRDMbHiax76cd7R4FBfFWrxD94rbXUpEzg4Xm0PNvrZ5VJ4
 jbJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiVvL1dH+iS7FcluNDd32noSosEBLV02HlIEf886JccAHIrhj4vVSe0rGDTh2SXSY01Edj8y36Q+4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5XuVGcRcpL0LrPkfitdfi/b3mZC3WFDcBmsSy5Mdnvla8L117
 VoxJyJjjDDbCGM4AulD/F8DpDdLqRYmCkCQnXaqM7pCUEBGYDFdqbDI1CLEp7dmhqxybgWWDDai
 OkBEpnHlP1livZxUvrFI5gy1yyqUg4j7J6Fmy0qhVvSQTEv3GvLyEXZvO3aDMkPOELACWt3w=
X-Gm-Gg: AR+sD12eux3mBEHmiW/lRMCWfdpmPbQwn6R5pRE+nJPsSolRQBzJCzGQA4eOhe+qFXS
 w40m/IizvI9mTUeRkuQg9P6nroWOW7jm3p4vDCRSFPf+LgfQcmOosKnfh/Aocj7FEOB8Cv/MU8o
 FUav5P3/auP6R2lKlkKQnhhzmkTOKkuiDj4lsvh/sY/dedTqQTqQLe9KBjTzlIhNr1KgG/fsoPV
 1XLc8zMD2zjE33qjr47K6ew2zQyH5S5AO14T4H/quEOK0ibx4lmI1JO//hIF4j3rjWQIX7I2M9P
 hLXBlAb7c+IWod+cthCcpJBC2N1ObPkniV11JJJR9BCrZrCAfGbrfTB1oo11MdJ/7tsafdOgcZQ
 mzH8n/dJLNMMQtloHz1ZeCouvVaHxZ8Kj1w==
X-Received: by 2002:a17:90b:5828:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-3966d486840mr15749755a91.13.1787751980168; 
 Wed, 26 Aug 2026 06:46:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5828:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-3966d486840mr15749558a91.13.1787751979472; 
 Wed, 26 Aug 2026 06:46:19 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:46:19 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:46 +0530
Subject: [PATCH 4/6] arm64: dts: qcom: glymur: Add CDSP FastRPC extended
 context bank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-extended-mapping-v1-4-d046c1cb9a9f@oss.qualcomm.com>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
In-Reply-To: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=4639;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=r5KraKAc2ErxccoXBkNJW54tEPfhhL2AjLw2qF4SJdo=;
 b=hIRA1Fih6qQhcK9u/umyKrxNNwhTZnUVgztMgs6cdS8UxFPeF+ajSoHkSp/8sU4+hm4SCF3cH
 VkWHyTr4iMHCAmdJQjNEdKTVQ+W/IE1YCqM6W2VMetUMRcVIAXtIlqL
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: AM0mbAXaCBtPwGsJsZZwXD5FZU5Yto7S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX68Y8QkT/mYxt
 Vg1/VbJygZJWY2Al8bkcaru7uvS4EnRGxtDGmC5I/Pt+NcmLWhFEdKAEteOYw4uwpZJb5POqeA8
 61k52gROsGZPXXthsTFxGsYZv7Ijq/4=
X-Proofpoint-GUID: AM0mbAXaCBtPwGsJsZZwXD5FZU5Yto7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfXxCnwSmx/retv
 3Bt3MPp2qoWiJ4FjI2v9+IUTUyvpD45TaltMX7kHfopk4McIf2QyfWbhhddxHpkptazsRMD9cth
 6f6ezxNa/NjPmkGOZZ0GBcey553n2sGBaTZWtFBbAbXBlcQJKkG/waU2gF50Jcs9k/B5WxT+eAq
 ZjUSFYm4hrlzDdd9pol+fg/7kzAfHW1E6t7/PXTCEaOV+BubAjCBwglwtqFNd+gjq6F4srjs8+I
 A2tC3KNETwG1rmN2O9TeIjnLRTeZKpSrP7acB9HGh0ZC540pZ59cO36kAA5D2M35HPmW7C9k/ao
 HY5gweXj2ubdMFWlu6e0UaZ566ajh8bxSpLxidBQMfqzRUlYnVoFQ6bO8boGUqLB8M6Eixas5lI
 1QjK6dek2REmODLeJ8Sb3+dK6F+5NP6mIfnJColxvO+44avdJiONORdk7ViS/PshcTKHIOkrLZQ
 4R9BYB6q06yvV7KN6jg==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8eee2d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fgQI4hRS6EVOI71rz58A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260113
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

Add a fastrpc_far_region reserved-memory node and link compute-cb@12 to
it via memory-region so the driver detects it as the extended mapping
bank. Bump #address-cells and #size-cells to <2> on the fastrpc ancestor
nodes and update all compute-cb reg values to the 4-cell format to
accommodate the 64-bit iommu-addresses values.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index f04058d2e089..2aff2a8a39ae 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -695,6 +695,10 @@ adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap {
 			alignment = <0x0 0x400000>;
 			size = <0x0 0x800000>;
 		};
+
+		fastrpc_far_region: fastrpc_far_region {
+			iommu-addresses = <&fastrpc_far_cb 0x0 0x0 0x4 0x0>;
+		};
 	};
 
 	smp2p-adsp {
@@ -7980,6 +7984,8 @@ remoteproc_cdsp: remoteproc@32300000 {
 			qcom,qmp = <&aoss_qmp>;
 			qcom,smem-states = <&smp2p_cdsp_out 0>;
 			qcom,smem-state-names = "stop";
+			#address-cells = <2>;
+			#size-cells = <2>;
 
 			status = "disabled";
 
@@ -7991,17 +7997,19 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 				qcom,remote-pid = <5>;
 				label = "cdsp";
+				#address-cells = <2>;
+				#size-cells = <2>;
 
 				fastrpc {
 					compatible = "qcom,glymur-fastrpc", "qcom,kaanapali-fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "cdsp";
-					#address-cells = <1>;
-					#size-cells = <0>;
+					#address-cells = <2>;
+					#size-cells = <2>;
 
 					compute-cb@1 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <1>;
+						reg = <0x0 0x1 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2401 0x440>,
 							 <&apps_smmu 0x1961 0x0>,
@@ -8011,7 +8019,7 @@ compute-cb@1 {
 
 					compute-cb@2 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <2>;
+						reg = <0x0 0x2 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2402 0x440>,
 							 <&apps_smmu 0x1962 0x0>,
@@ -8021,7 +8029,7 @@ compute-cb@2 {
 
 					compute-cb@3 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <3>;
+						reg = <0x0 0x3 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2403 0x440>,
 							 <&apps_smmu 0x1963 0x0>,
@@ -8031,7 +8039,7 @@ compute-cb@3 {
 
 					compute-cb@4 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <4>;
+						reg = <0x0 0x4 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2404 0x440>,
 							 <&apps_smmu 0x1964 0x0>,
@@ -8041,7 +8049,7 @@ compute-cb@4 {
 
 					compute-cb@5 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <5>;
+						reg = <0x0 0x5 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2405 0x440>,
 							 <&apps_smmu 0x1965 0x0>,
@@ -8051,7 +8059,7 @@ compute-cb@5 {
 
 					compute-cb@6 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <6>;
+						reg = <0x0 0x6 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2406 0x440>,
 							 <&apps_smmu 0x1966 0x0>,
@@ -8061,7 +8069,7 @@ compute-cb@6 {
 
 					compute-cb@7 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <7>;
+						reg = <0x0 0x7 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2407 0x440>,
 							 <&apps_smmu 0x1967 0x0>,
@@ -8071,7 +8079,7 @@ compute-cb@7 {
 
 					compute-cb@8 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <8>;
+						reg = <0x0 0x8 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x2408 0x440>,
 							 <&apps_smmu 0x1968 0x0>,
@@ -8083,7 +8091,7 @@ compute-cb@8 {
 
 					compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <10>;
+						reg = <0x0 0xa 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x240c 0x440>,
 							 <&apps_smmu 0x196c 0x0>,
@@ -8093,7 +8101,7 @@ compute-cb@10 {
 
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <11>;
+						reg = <0x0 0xb 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x240d 0x440>,
 							 <&apps_smmu 0x196d 0x0>,
@@ -8101,13 +8109,14 @@ compute-cb@11 {
 						dma-coherent;
 					};
 
-					compute-cb@12 {
+					fastrpc_far_cb: compute-cb@12 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <12>;
+						reg = <0x0 0xc 0x0 0x0>;
 
 						iommus = <&apps_smmu 0x240e 0x440>,
 							 <&apps_smmu 0x196e 0x0>,
 							 <&apps_smmu 0x19ce 0x0>;
+						memory-region = <&fastrpc_far_region>;
 						dma-coherent;
 					};
 				};

-- 
2.34.1

