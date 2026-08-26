Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A05C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B05810ED42;
	Wed, 26 Aug 2026 13:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3hshwei";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KnSdgGGH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B872210ED3C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:17 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCM3Cx699242
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xryu42XUsfb3+Hia4BkFfpfTTvyqqe/ZdSGW8hsbJ3c=; b=o3hshweiH06amjID
 wjlhCdB+aKScpqg0qIpBfhQZWzGTTmSOOpx6vm9d5IItnr5VPeo3EkTDFycd/qub
 PlJTFwcJ9KpslrEHTDouS/T2/DWxFmsJtGh3gDaoevdVdjTXYCZIJj8zPuyJpqmg
 0Ian79ISQWIgGgYIHyCZC5sY8Eznx6rqXmsWlKPtUNhjzqv+3JpRZYRSIOaoII9d
 uZfqxMF48aDKHN9p6MRr/30iT+zb3jgLLA5TyAZY6ZRlN8PcA/JkgH4LAJVPGl4r
 qV4JaQ4Env0Gt9eH6xOmXJ+YByVevR+g6mH/o5VJQ2IEzGb1p2UkkEIRadPNg5Fl
 qAVYog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03a8axk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so1921494a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751976; x=1788356776;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xryu42XUsfb3+Hia4BkFfpfTTvyqqe/ZdSGW8hsbJ3c=;
 b=KnSdgGGHaVwz2X8X17djK7qn7z168IJ8RJun4T3PO0bev84lz+uk/q8R2zq63fRzAo
 nFmrr7wuDYuliHJawnBFWdDD0MFTmxgBu5TmctiamfnQtjfdvNZo8Z33fpmU+YZgRl16
 GI+cCSI/y+qt+HpYfIJW0h8rnKswsay9cwMpWTPAZyxCTBzquQWIqmtkC0lIUiJsMYNI
 iUikowIjzM5yEHFWerwM6SWGB4Bdgm013cPIHV+rso/KoY3KJAWe2u6j25v9VeZ+n5D/
 9vg+dbu+7U+xdVBqNb1B0XcCz9gdyIV4Es4GrtRIXgPIJwtQvq4CTwZM70qy2yMpU9TG
 Dnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751976; x=1788356776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xryu42XUsfb3+Hia4BkFfpfTTvyqqe/ZdSGW8hsbJ3c=;
 b=Lu8SmsrGIO/j3XH6jFRUEhnN41hq845u/GiJ2aZACqRyVYITFWpvCm1CUlj6JMbGbZ
 CjE52pqB4LRghc3OOP6ESF+SQSG1rurLoTYGzzX7tmVC67NlyBrhfysIOy9LKu3waX3z
 L1WpJ1hHnU6v5FhokFq5LqPTA+R7nKKHQ8hnuv7HgBhvq0t1vHPYWsnbYhdpbllrafIV
 TfpDSBjbtRRz1vtzaQtWG1kn/R7SNv4JgsVCS3pMeNPj1PBXRVbDf7E2mdcsZIBIv9Jr
 pAGJXFaf6sqcrVjz0f+hieaEqVEAkLW7AkDoXjWH3H2st9cYj1KMWJNE/bkhuZYtsa4q
 qmjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBFBgVLV54TrGsSJDNld7lBGKH7tVubkeN4JuKJOSyWXQFfqjRrNmRmmYo2Znh4PIeKpiDPeR3wv8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kGZOB4JmPBn9pOqkfq21GuqojRekIpCU2FsPNAKR/d68l4ZObO
 acXaUpXoYFEh4VvZKd1/medzJafB5sC7u91g+wzOdCSgq3H2xz/RUppWeeRwFvytmlDeF5qGUOg
 lE+luBetc+Eeryv6IffK6MfQCk9tAVKEq89eXOWqgdCUrtVV1kA9vahnGZp9zovFWi+ka+Vs=
X-Gm-Gg: AR+sD10UmU16GZAFHgLONKHPYMseBL8Uo/2mmH1gh7uBwb/xqg0eL7fC0yJSPnVJPcN
 nDqvpWZlW6T3wxaAj4CG3/t1zGWM1rieWnT0eHiMx1+CF9vPX6uTCflsPV2BZM8+i2/o2Cr2cN0
 V4kwzCkIszP4imTTsddxR34wZjZsoftkELAbbXliMNGKcdy47ImR9A1eTq4t3BqE3DRu7Zow8jk
 S0XQKOXPwN4KJsU4QxTNFeEckFxUB7DvsK1MGxiubOXeGrVBUccD1VCnMiUKpixTnSFfjmbwU5D
 7syuM2r9g7YxU7Ne4Y945ysav6+/cN4vhnmaHIAaDxo19ctVjbJ84vaXjw9jX6lxrJxWnj14RfF
 PpyUcPTBc5UYFs30V+CATsJlb6wtlOALE4g==
X-Received: by 2002:a17:90b:48c1:b0:38e:250b:122f with SMTP id
 98e67ed59e1d1-3966d49469fmr14165019a91.16.1787751975690; 
 Wed, 26 Aug 2026 06:46:15 -0700 (PDT)
X-Received: by 2002:a17:90b:48c1:b0:38e:250b:122f with SMTP id
 98e67ed59e1d1-3966d49469fmr14164660a91.16.1787751974220; 
 Wed, 26 Aug 2026 06:46:14 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:46:13 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:45 +0530
Subject: [PATCH 3/6] arm64: dts: qcom: kaanapali: Add CDSP FastRPC extended
 context bank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-extended-mapping-v1-3-d046c1cb9a9f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=4712;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=q1/8tKnQ7WG/1O5wqs9Uj1fKmN6XOdjbcNUUWVfHMek=;
 b=bZieD1bufpZ1PXCwTy0U0DPG4i8ay90Xfz9dELIhPIGvz0yfjJ6YgGIJkm9q8YZh3ix5XTpYf
 kO+a4wPyt2nBtKmG0IUaBOculJfHlqjzyCrfhDErKAw+82NdD2qyx/M
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: DWt2EhZXVgJ-ns5py1AELH8LILHwgwHH
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8eee28 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QQLvu54LoOUFz5X0MaUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: DWt2EhZXVgJ-ns5py1AELH8LILHwgwHH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX2prUBnsJV0DY
 61AGGsyvZU39eto+qIDj0Zye8LLQ0fiU3p40X1KpsvwvEr+rCPu+sZfaIYu33U8RK7ZE1ucCXE1
 gHDFLqx+4Atm/4k1wWCiiuLsypWbpfToNXHGFkQLuFmz34WMoMXfv3qbuDwjAbXd3lj6/9GRFM8
 bQAYRqYDAzlMsHFNmfwR/tbTMy/fCOiIH0TiDFU5DE/dyAALd/1LW6Bgq8VZn2aZp/vGffCYbjV
 zKG1+JypTeNATWTld6qL0/Se14p3RVL1jYGgfAx+BdymTJTSOTxZKKi9lL/j0ewrVC/RW/6aR12
 Y0BIt1X8QtuaJup+4Vwld/0ynTvfkIjAQ0gRaoBJYSR+3bjCgOY2BAhh7r7Pyr3pRvzqw7Mbx5T
 K/sr+sRNlmt9ZLjaTR+Q3J7pVyZZWYAuwj0UHWJ1VGL0LRGNcVdL2rSSIZOdXhfqc8LZhFveWZW
 Z4T1RlKp1k6nLwiaE0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX5E28XIs00M2V
 AGt0h87C3zx7Unf6+o8HZdu9LJZAeGNW4XgS8om3KteInC3F325jwlyngFgvojJBxwiXvvxuRFp
 7AeaLrq4Hq3C6hfFsUtT1V0I4TqOYXY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Add a fastrpc_far_region reserved-memory node and link compute-cb@13 to
it via memory-region so the driver detects it as the extended mapping
bank. Bump #address-cells and #size-cells to <2> on the fastrpc ancestor
nodes and update all compute-cb reg values to the 4-cell format to
accommodate the 64-bit iommu-addresses values.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 35 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 131fd2a16c54..0f258eb2a7a9 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -451,6 +451,10 @@ rmtfs_mem: rmtfs@d7c00000 {
 			qcom,client-id = <1>;
 			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
+
+		fastrpc_far_region: fastrpc_far_region {
+			iommu-addresses = <&fastrpc_far_cb 0x0 0x0 0x4 0x0>;
+		};
 	};
 
 	smp2p-adsp {
@@ -6011,6 +6015,8 @@ remoteproc_cdsp: remoteproc@26300000 {
 			qcom,qmp = <&aoss_qmp>;
 			qcom,smem-states = <&smp2p_cdsp_out 0>;
 			qcom,smem-state-names = "stop";
+			#address-cells = <2>;
+			#size-cells = <2>;
 
 			status = "disabled";
 
@@ -6022,17 +6028,19 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 				qcom,remote-pid = <5>;
 				label = "cdsp";
+				#address-cells = <2>;
+				#size-cells = <2>;
 
 				fastrpc {
 					compatible = "qcom,kaanapali-fastrpc";
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
 						iommus = <&apps_smmu 0x19c1 0x0>,
 							 <&apps_smmu 0x1961 0x0>,
 							 <&apps_smmu 0x0c21 0x0>,
@@ -6042,7 +6050,7 @@ compute-cb@1 {
 
 					compute-cb@2 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <2>;
+						reg = <0x0 0x2 0x0 0x0>;
 						iommus = <&apps_smmu 0x1962 0x0>,
 							 <&apps_smmu 0x0c02 0x20>,
 							 <&apps_smmu 0x0c42 0x0>,
@@ -6052,7 +6060,7 @@ compute-cb@2 {
 
 					compute-cb@3 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <3>;
+						reg = <0x0 0x3 0x0 0x0>;
 						iommus = <&apps_smmu 0x1963 0x0>,
 							 <&apps_smmu 0x0c23 0x0>,
 							 <&apps_smmu 0x0c03 0x40>,
@@ -6062,7 +6070,7 @@ compute-cb@3 {
 
 					compute-cb@4 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <4>;
+						reg = <0x0 0x4 0x0 0x0>;
 						iommus = <&apps_smmu 0x1964 0x0>,
 							 <&apps_smmu 0x0c44 0x0>,
 							 <&apps_smmu 0x0c04 0x20>,
@@ -6072,7 +6080,7 @@ compute-cb@4 {
 
 					compute-cb@5 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <5>;
+						reg = <0x0 0x5 0x0 0x0>;
 						iommus = <&apps_smmu 0x1965 0x0>,
 							 <&apps_smmu 0x0c45 0x0>,
 							 <&apps_smmu 0x0c05 0x20>,
@@ -6082,7 +6090,7 @@ compute-cb@5 {
 
 					compute-cb@6 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <6>;
+						reg = <0x0 0x6 0x0 0x0>;
 						iommus = <&apps_smmu 0x1966 0x0>,
 							 <&apps_smmu 0x0c06 0x20>,
 							 <&apps_smmu 0x0c46 0x0>,
@@ -6092,7 +6100,7 @@ compute-cb@6 {
 
 					compute-cb@7 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <7>;
+						reg = <0x0 0x7 0x0 0x0>;
 						iommus = <&apps_smmu 0x1967 0x0>,
 							 <&apps_smmu 0x0c27 0x0>,
 							 <&apps_smmu 0x0c07 0x40>,
@@ -6102,7 +6110,7 @@ compute-cb@7 {
 
 					compute-cb@8 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <8>;
+						reg = <0x0 0x8 0x0 0x0>;
 						iommus = <&apps_smmu 0x1968 0x0>,
 							 <&apps_smmu 0x0c08 0x20>,
 							 <&apps_smmu 0x0c48 0x0>,
@@ -6112,7 +6120,7 @@ compute-cb@8 {
 
 					compute-cb@12 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <12>;
+						reg = <0x0 0xc 0x0 0x0>;
 						iommus = <&apps_smmu 0x196c 0x0>,
 							 <&apps_smmu 0x0c2c 0x00>,
 							 <&apps_smmu 0x0c0c 0x40>,
@@ -6120,14 +6128,15 @@ compute-cb@12 {
 						dma-coherent;
 					};
 
-					compute-cb@13 {
+					fastrpc_far_cb: compute-cb@13 {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <13>;
+						reg = <0x0 0xd 0x0 0x0>;
 						iommus = <&apps_smmu 0x196d 0x0>,
 							 <&apps_smmu 0x0c0d 0x40>,
 							 <&apps_smmu 0x0c2e 0x0>,
 							 <&apps_smmu 0x0c2d 0x0>,
 							 <&apps_smmu 0x19cd 0x0>;
+						memory-region = <&fastrpc_far_region>;
 						dma-coherent;
 					};
 				};

-- 
2.34.1

