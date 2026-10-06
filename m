Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6852ECA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB6A10E13C;
	Tue,  6 Oct 2026 10:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LztVgXqv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxJy4ygE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9E410E13C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:26:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5lP7361459
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 10:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OsaI61rCGfIjgrkDnRITXwuRwuSSnYIbQplnAsxXdNE=; b=LztVgXqvpl+m+/Kz
 N56xbIZbQAX/LmvMEN9lwF8nuiZOVecPKsCf2vbs6lUHBsvjrsq4YJHWnjzCnhRh
 LoRLHInEqZlJNJDw7u23vHHuub3RAGa8e1hlo5swElK1QQYVbuXyWrMtoOLFuYRc
 XWfKmXAORdQ7ACJx5I85okEhSm0kJDmL1i0FjwRPHeo3cD41CG4Irau/oJkxn9rE
 IFl3C2f7W9mdpPQS4dfNX+0tpD6HxY3yiBk3/yr3DDCJYGQAD3voyzzFJ59nBkkg
 oFdc936JjCGaAfAZTYc6KLzMqDyAaaDQc7YoSaLhEDTJCroqkGXHYK83YcwVlXG/
 W7nNsQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0b4q0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 10:26:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39b77130a7fso2947820a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 03:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791282387; x=1791887187;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OsaI61rCGfIjgrkDnRITXwuRwuSSnYIbQplnAsxXdNE=;
 b=CxJy4ygEju+MjS0+BlEOJI9kazcP+D617fGahH3Kg1ABSnT1dwfc9380d4Z4Zl037F
 LsvDIxoUZMY2pk6i9bEOXcswm0l90qnTihr9B0+GMbwMVAd5yLFVd5k7L+5YlOt/JS/i
 uCL4CYO4a3w398DcVJsyMPrOBZDzQPpaQgSqbxCtImmISagB3KZRSFYuZH4C33jpm+uz
 HfPVQolNbKqqKDU43MNZbQNBKowCnt0oSjVxpphbmIjYfjoOa1Ds43BynWQAnOsTLs/H
 dsJX/QlcKRdb06wWLPpEvH0Bho9LwoSeictJ75XPSWXx5Yo5TA797eroq/jL95sRLUOj
 L3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791282387; x=1791887187;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OsaI61rCGfIjgrkDnRITXwuRwuSSnYIbQplnAsxXdNE=;
 b=YVGKqhsdjvzovgd/n8Ag+tBePPSSKZB+cFFXgSvWmwiRKff70sIFRzhEbpy5Nc5sAs
 uBfpB8KsgjO4+BYEZlzxgkGj9Qb6mayXt0t+UsCIgKprVZ5ueZ5o13CN+cfx1QRwwAmd
 vFWJVWYiG8R2TeQZIUvMe4pWHckatemnmAccSxQOieTOSV3ieNAKDkmWsNhR8TFxdxG/
 X4FOMhJQdLTA0loqw+A3BTX+oMmH9IBQzr2KYVvti2P3Q5IuioQK9JmWoEsZL1pUo3c3
 OljEqt/9Rr6tIaA08ftgpVxNZvw4uxp0wNnuzejGweJRF5w80RnUFp0UEZLciUE/Fe7d
 0Bag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsLSTnXB6OgG3XysH+vr7SJe3hkHCLOS4cHH4latAX8PnCP4B/sbhVCKIi4ATHx2vAzcsMJmMHrgA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLJPlhKvpBQGEqu1WrHmgZOSg5WnqFVYcS6WEO4zqK5OO1teCM2
 TL8yFD/d+8U+LLVIhGY4FzjF+BvaBp6CD/DuaPXOXxvPq0aJIsnNZRzNZzdADnH57GLj/BdEzT2
 PLaa19QCzxULQ41X76LOzTWuv8T+KPge0B0eTX/rX/hrzucx/7unG/79IvnVu+ibcGyleS0qsja
 I9eupIqQ==
X-Gm-Gg: AYBFou0/EOdH8dTRZlNujkESXoNIr+Zac1A0m42UL+0pRx/ZD9sllN12cFZawCxCWOO
 YpgzbiJL1i3HnOer3AgIpKu/SMobNXusCNBSoNWORFeVM6tMP75awPmzuS7Im1vEC6SDgKOVmAX
 KdoNgvhywTaRZouiCig5Z83WBgOCaLwBBLAAw8qkM0wM+chC1khPhEmKgyeDAUKr6BvMdJe2nBQ
 E6L44vHJST8w8GmxEFC3FbJGyYdNS8fi+L3S38lDUCcn8OVEm7LFlCzi7koGypt+EBAYl0UsmNg
 yxd/fUlbWz8j9DPnfjwL3/EEw7k1hXUujgw20wGl0IhAD0pSl7kP7lhUBSraJTVwRDYMYs+O/gD
 LmuM5hRi96MFjd5BxCVQUMIzATKMTXWs=
X-Received: by 2002:a17:90b:3d47:b0:3a0:9fe0:3aaf with SMTP id
 98e67ed59e1d1-3a8736f333amr646745a91.48.1791282387145; 
 Tue, 06 Oct 2026 03:26:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3d47:b0:3a0:9fe0:3aaf with SMTP id
 98e67ed59e1d1-3a8736f333amr646726a91.48.1791282386719; 
 Tue, 06 Oct 2026 03:26:26 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853e66d7fsm4088289a91.5.2026.10.06.03.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 03:26:26 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 15:56:07 +0530
Subject: [PATCH v3 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-glymur-dtfix-v3-2-44e2bc5370c2@oss.qualcomm.com>
References: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
In-Reply-To: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
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
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791282367; l=2005;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=5HL2Jj1toihlaBIsVRiUv8m3bLw7lr7UZZmbpTxh3dM=;
 b=Yh10oiU0F4Vnt+kyZLiBy/nNHfYk25rmfjH8F22kt+RGtbTDjSopDTC3B9A0R7Ru2C5EtYE3s
 /3ayel1XxWdDd7lw6TrSSgNQWbl47SYugmWCcQ+dL/m7SlZXN6I0NKf
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MSBTYWx0ZWRfX1yPt/9AibGPe
 DTrG+WonfxMZgImTujlbSkj/KeyWMlE+MpBlkoMVe938yvxi0Y1EXjTlT5arexzSvomdY83kg6r
 3RIKwP485wT5HlUIILlyD6OZF9CEX5iHIsO/up2aVHLF2aZYh/dHdpewusnHHailL0D7D/4XdlT
 d49AQCI3Usa8dV5+iFXm8Y5VeuAQI+QH4rnlW3JijDzulLdDMrUhhvfjbwtKRcoA0FSCOhUQsHs
 DTkanSJMRGDLOtM39zRwAnKiBWLSxpgisthGNch8Iy5pu8+MF6c5ChmZP+iJE8eOz1k9RQy0bk5
 5XbER0ZkoYIvMyPp3f9kBOe7saUkdpMKbJ97spqhTEm/IN7Ro8REGrg+8EmadR5dBAfMabRn+li
 qMcKMK4Kz8XztmZgBjb8LLYAT3gUpgA5c0ZUrF9E/6NGgeCHDS5MmoCW4BWiBq+jTN5PRqImjOg
 FI/yO/cmuW0adjXHFLQ==
X-Proofpoint-GUID: ctggUDFMbUkRvErXWmnf8gWycZQypoUk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MSBTYWx0ZWRfX3lFzSHl/MlGV
 zQ855HVgnMkDjWk/dYt66gr9CJLo+4n76PgoJI360RyE1mVpK1unXjJaH7VNrdFi1cHtpgj40sU
 BUUlb+U7Yg1fch60cMQV7R2PNoOgUys=
X-Proofpoint-ORIG-GUID: ctggUDFMbUkRvErXWmnf8gWycZQypoUk
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac4ccd4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=lQw7s4k734Nnm4ZOuq4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060041
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
mistakenly given reg values of 10, 11 and 12 instead of 12, 13 and
14, which don't match their SIDs and leads to SMMU translation errors.
Fix the reg values, and rename the nodes accordingly.

Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index de7c395d9c35..3219603372ce 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -8471,9 +8471,9 @@ compute-cb@8 {
 
 					/* note: compute-cb@9 is secure */
 
-					compute-cb@10 {
+					compute-cb@c {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <10>;
+						reg = <12>;
 
 						iommus = <&apps_smmu 0x240c 0x440>,
 							 <&apps_smmu 0x196c 0x0>,
@@ -8481,9 +8481,9 @@ compute-cb@10 {
 						dma-coherent;
 					};
 
-					compute-cb@11 {
+					compute-cb@d {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <11>;
+						reg = <13>;
 
 						iommus = <&apps_smmu 0x240d 0x440>,
 							 <&apps_smmu 0x196d 0x0>,
@@ -8491,9 +8491,9 @@ compute-cb@11 {
 						dma-coherent;
 					};
 
-					compute-cb@12 {
+					compute-cb@e {
 						compatible = "qcom,fastrpc-compute-cb";
-						reg = <12>;
+						reg = <14>;
 
 						iommus = <&apps_smmu 0x240e 0x440>,
 							 <&apps_smmu 0x196e 0x0>,

-- 
2.34.1

