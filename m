Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE9CCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0550010EC57;
	Fri, 16 Oct 2026 06:37:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA9310EC57
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:37:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G26iKY3902238
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MH0X6BkiKawAmL+k5dJ4f3ue5wUkyRRRhMdlkV8hsII=; b=ZHwzbViM9nGhb4R1
 Ueos5vlT0Cdsl1AYOAT3XhOIycKZCyzer1zLBAufSu6A+VyVJySERpS9EWv33l8I
 W5Wyt2aYei8VZkJUAu0T84n/My/Rbw3LsVpVfAI0L/13M6eQRnrTqt8rD0Z9IHxX
 TDBWv2ddO09w1PpmRDWGRbd5cSnap3R2j4souLREqhTQRHNewMs/NkULqwUG9D+i
 zLtSfxJtV2vy+TDHQmYQBX/xJ56ZqkrdK9m+vWEiUKcAa0RGiYwYRg/pn+IsKQ3U
 2wcfxHqEd49T4jNTOUBn0Ah3WuGtEi24KhOVFKk7abRmbZHaS0Yo5jXQHQd4K21u
 +7r3BA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3setdj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:37:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so1073826a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132628; x=1792737428;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MH0X6BkiKawAmL+k5dJ4f3ue5wUkyRRRhMdlkV8hsII=;
 b=GDSmICHD/SdG/bctUujGu6bZFDppyKhFjm2VXKGymuCmIvLcNyvmJomKjnOgB53P+k
 Yb55k3fndsUczIFdTcTDD0PQwVchQBgaINpoTiDYNirtp0+bzM96KdekoJL0gvf0avuc
 +05CS94zmJIzD36UV3woKuF8JABB2pEOLFwcfFwR0XK6ODFIM1KJQ7ArE9kNLHL0lkGp
 5eesUh/TFHsKGQk/yn/s1qOx8mPUoRge2Jx/8fynrmLAzgQPys8VmS0K8IX7nK6Dx8Rg
 f9DuTDAHBdaxLmXAleRXbU5inFrGPldjpKcgGlVcfKESzfPKkqwD4r2M+d7RLOk3VihD
 NNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132628; x=1792737428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MH0X6BkiKawAmL+k5dJ4f3ue5wUkyRRRhMdlkV8hsII=;
 b=0q7zpJ9cnwgvXufmhPb2xLUaFRJgKc53d5qePSxAMfFI2xqh8JmfGd1zVkeEz5t2UG
 PHCCFgQV4efrt0CEtnhsaSbdX/tqOqoDaIDs9ckGv3CUG62Bm968r9CoiLNWF26r651c
 5zH9Burn0rQr8PQImqcY2SXnpUTDrCDNhtJtCg/YcJIBsl9DEVHYeyxq0xmGedvV5R2V
 4nLxqtVeI8K2DJ5YkycNTYvCEVbaNWWWPxtiWchimwqJOFii5p0nayAGIRT8j1lAvxVl
 qvx42q6xbTzw/m54caRxnZs3j5cORFZRVQHPecklavKC1oSx/Pf0gE3yT6Bq1KgTzSXw
 GunA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaIt7G5I+YOeUDANRDwx9hYylCd7/qXseW8scXdyVJ6GyMoHetFel5C9TlQCUn8s7/8KbDiMG/jho=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI1TaX214W2nsUtTR18lcKmbhM7DsKiBY+gD9j/MiIydrWtgfYO
 mr5pJXinmLzbg3gmLXiPGzLeOP5LTTcbwxKqJLTpDS+c2Bvi2/zAMXyrxwi/elQR30AIpoCb5mt
 FfUp9lK+OGXPt98eeIApzZMYco0FJOLlfLT/rnc7BxZbQewDtmxToRV0QYX232NSQFGTpMig=
X-Gm-Gg: AYBFou08fQozIClMjKb0QFfraPb8j5//VQsf4qTRzpvvtOPb/0PYa9YJJKRUPMOcjLh
 kxQY08NUdUrkXTKahnkIfQYZ8I0BH733XvnHqm1RsE9wVdVQghA18Y2BjiwA1J+gk4+WBAU4sHw
 9NlTRjZinOAw/yyhqnPuOpC02PI7lVaa+A4rnexZL2ayu3pYpH6crxJneQ+S5bLmwRnM3mLqjjd
 N05tGu+wlDMj1a9F4DL7faTERF4zJvkdFC9yNVhjB7RAHvXYL3pSoxoKnsBHnqEUNvH0mLHlAk9
 jaioYDn0snt/mEd5Jz5G7X2FbuYFPThJnmqv2FQTWqMHhIZRi1X/xzLJFr+ycRhIwt0VDvYgOd6
 BJH4XxaRMVd18JRMYsaj9M0pb5UD1OaI=
X-Received: by 2002:a17:90b:4a85:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3acbb68a0a3mr1547613a91.3.1792132627808; 
 Thu, 15 Oct 2026 23:37:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4a85:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3acbb68a0a3mr1547604a91.3.1792132627331; 
 Thu, 15 Oct 2026 23:37:07 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1e1esm2703298a91.1.2026.10.15.23.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:37:06 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:06:47 +0530
Subject: [PATCH v5 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-glymur-dtfix-v5-2-f56a8b94b4a9@oss.qualcomm.com>
References: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
In-Reply-To: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792132608; l=2068;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=5Pr03qQhNLRXOGv0RgI7lxb2r0c4i7mfLQhNHQv8TV4=;
 b=+vLCPCBS0d1y6CQkVqsFNpndDW6h1mukkd/toByoy/9Bikzv3H3HxDQRWVRkdR503Pzqy44xr
 B/gOI6UVYh5BPaXNooWPIWVZfr4aiXGAjuOJkAwKG9ch35xzCooswlp
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: fDpiN-5faD9uHH_7P9sgqBMUtMdGxg3K
X-Proofpoint-GUID: fDpiN-5faD9uHH_7P9sgqBMUtMdGxg3K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX/2oKedyo9Ua0
 7dTgRk6wVZaehg81PXg/T5R12LKl/rzc55BHUYgIob72PZpvle/Y9e8ejsEDI/1hvPZ8H2lggL9
 sgPAjiF15LJPivmzUGCz4IH+fEMxYU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX6WsMg/2108Gt
 UB+27ja9HkPwJbobasx1sCc93ae8THFbnw5/O0K8/EebJ5TzR+4uIFFbvTV0AkEGB8KzLjiy6KK
 obL7bZmyLWt/W7rMwlkYXC90gSGdtRLPzt7mOI/ktSfztJSoe6TXCzHg75Sfb3D4490vUtiXByK
 3G5Tu/WVz/F7Yw7a7qR9ZGvubLGpaemoZ7ghSiuQ5Ln5k9jMoVkH6nzomnCqzcmDaCGYnt1Cxfk
 yjUJ4AQcRR6jY0AYKIpHmLi8E8vTezsKVW9yT8GBK2Nr2OeZCIVsPk/NBLDLWQCwMeke8poqLTj
 sLWZXyd1AVmS4o4J5iAqk6KCT1vIKupPWyHglE65ZMg0BfycbX3ySh5SA4yA1GipQfILzFor05S
 w2558gBFdVnsZWkoJiAc4nuq8C/vxZMMPyM5pXGrXUplkVs17DZhxj8X2b0sfjHo7ekWlnnKmUp
 VCevLXK1mepgbXeBIOQ==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad1c615 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=50Dod7zhrM_yUD2Akn8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160026
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

The reg value of a compute-cb node must match the SID (the lower
nibble of its IOMMU stream ID) it is associated with. In the cdsp
fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
mistakenly given reg values of 10, 11 and 12 instead of 0xc, 0xd and
0xe, which don't match their SIDs and leads to SMMU translation errors.
Fix the reg values, and rename the nodes accordingly.

Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index de7c395d9c35..42d9ba3d3cb6 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -8471,9 +8471,9 @@ compute-cb@8 {
 
 					/* note: compute-cb@9 is secure */
 
-					compute-cb@10 {
+					compute-cb@c {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <10>;
+						reg = <0xc>;
 
 						iommus = <&apps_smmu 0x240c 0x440>,
 							 <&apps_smmu 0x196c 0x0>,
@@ -8481,9 +8481,9 @@ compute-cb@10 {
 						dma-coherent;
 					};
 
-					compute-cb@11 {
+					compute-cb@d {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <11>;
+						reg = <0xd>;
 
 						iommus = <&apps_smmu 0x240d 0x440>,
 							 <&apps_smmu 0x196d 0x0>,
@@ -8491,9 +8491,9 @@ compute-cb@11 {
 						dma-coherent;
 					};
 
-					compute-cb@12 {
+					compute-cb@e {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <12>;
+						reg = <0xe>;
 
 						iommus = <&apps_smmu 0x240e 0x440>,
 							 <&apps_smmu 0x196e 0x0>,

-- 
2.34.1

