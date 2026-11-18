Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18B606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g4Mm2InU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YFAlQVUM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF6C10FC56;
	Wed, 18 Nov 2026 13:09:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6623310FC56
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AICLFTf3420566
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 50tJpTY0/NQyUgPm5jhQ+vnZd/4bBfqxV08nQXImnYQ=; b=g4Mm2InUlKtWel8W
 AxFk2UYEeAs/Y4adM6uBs6VVrikELWv71NK6QSY0xFKeC4/Uyp0UdKT7bIwkbxiq
 6wXUN6KAsdXLKSFORbje5RI171Uz20MFjy5lebVO2Ye68nboGkj7gHu6JJtP634N
 mVYjKJWldUuMZyf6Y0/yzE5EHwkSt0e9RJQ5nSF8WP9nl6CeSFuNl9ECACDNwsyC
 l2M5X0xl5NXxOkwKEE4xCo7Mvr0rJwGD4o9KI1MNoZc6VEw7izz3icrIHG2NEbHa
 hOOuJlNvl/66byJtoU2aCgIqEmFzdkUzB5jR5doXwFSNBwfYIrWM2kQneRumz1j7
 KxYrdA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8u2dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b0a0747175so175868a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795007362; x=1795612162;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=50tJpTY0/NQyUgPm5jhQ+vnZd/4bBfqxV08nQXImnYQ=;
 b=YFAlQVUMX5laTnuI3uSfExr9e41/ys7uuX8qBxv1emMPJoRYNdjS+IhzOZYe0QR9jx
 K2ScGGWpbwkb5OOH8nO96KK9/qULS0s16FACYn6eJZ0H7GVIq/kuZ5N/aeTXa33NWIIy
 v8WsL4z52AQF2zJuSXPZqlH6AefqMqVyngB1R/RMxoPYfUs4ZhhoiZ+kdvK8jQ5THf5f
 JiCNcNY+A4A8XdqJdkKp8Ajum6h6RJoBJBv0sTqFmoKpfFQ1JFxI0NzRRfFyfucQ6Fvm
 GUsjjSKt8z1Z0T2SpN4b4B+f75VRGjefMyllAWAq2SlePcrKwLx37wpl6H6b7brVeodK
 C+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007362; x=1795612162;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=50tJpTY0/NQyUgPm5jhQ+vnZd/4bBfqxV08nQXImnYQ=;
 b=ndlIRgh0ieXeUFbkGHIr2ditV2GmtFTURbtikxU6Na08wlfugHOggyFdfgspNT0YAz
 8OyO3qYKoZwfjeiu7zD1FOxNDvG/1f65jYX7taTNHVjqMZzpsIRZhchJL68GHCgBKSpN
 eHv34UU5Pgxf1PUXK+CrsOiNBhVQscVvMzbAU0YVJjJmRvvUBaEZf+7MGFYgSTQ07P2t
 WH3aBwx8TTWVNTz+n3tJGzs5AtNBUzowfiRWO9mFq79YShu7ld/MlyppqdMqjfPx1qOp
 Fs6lMRn9Kurf4mWhxm6ZDUVLTttJeDZfCWxQ0bdep2Bl7OPElMrUuzOoXxkszFy6Pq85
 PlpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFD/qkMgQpEJaIOJVPF8rEcL+QmOBw44ogKz/OOI+bBg1AO7M+kzcot9bQZD/mIesNAkmDwDeKSnSU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+pVcrN2ASdAJIcNuLSgvhPOzEzsrvzwgJHe3QAOum3uCxyDSEy
 medTmQzna3mRanp76pxZVTBuCLHzunYOrMnST3LLXMQiVu+kamr6L2V7h9mEk9ghhxqcYJ0oFpY
 9DguiARMMTBgD7DHCLjpsb1iyQED0VTKjbuNpCLxQGW2TjYknR/u7HeqeMrRRYV3TArzyPGg=
X-Gm-Gg: AZFdTZfQs4BkItLCskEuxUX1ByKLWd0SRBFYTwAAjHEE8NDzMa59O50d+DYnAusAoZq
 53PgCos86vSndSN2KvplT0vzOgSuqjGaBIE24y4LgEdWkbvy4aYy7cEl7IrkrxKeMDDRHV1VVgZ
 EwqmsL8h4b8eHLsD/Q/VK/KLb8/06N3yrAW8zBkSfSx2JaT/yfYA3v7YHxDbbHbJtwmbFO3oX7H
 4FoPIiKpzdKxrH4lt2tQmJDjjqGHh1B9NIeCH7REhq7vwCRLe6e2XAc+YFPeBrPsWR4TGzkinvj
 EIr3TYZ/gBYjUKWIbx7NPeeeE9DwscoXRkO3dm/tnq8lZjCFylpFUunmP49KJprJGhkagSZBMSI
 FiTpmiDtOfo7yd8HMi+RStD4RL9WdnAZinP9gNWrl9441TpQO0rCnxwHKOvAHVn8w3kLY7GsocJ
 xTtmRql/oz
X-Received: by 2002:a17:90a:e7ca:b0:3b3:ab75:c947 with SMTP id
 98e67ed59e1d1-3b3d06a489fmr4456555a91.1.1795007361495; 
 Wed, 18 Nov 2026 05:09:21 -0800 (PST)
X-Received: by 2002:a17:90a:e7ca:b0:3b3:ab75:c947 with SMTP id
 98e67ed59e1d1-3b3d06a489fmr4456486a91.1.1795007360842; 
 Wed, 18 Nov 2026 05:09:20 -0800 (PST)
Received: from hu-pvgtejas-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm4909533a91.6.2026.11.18.05.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:09:20 -0800 (PST)
From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 18:38:30 +0530
Subject: [PATCH 6/6] arm64: dts: qcom: shikra: Describe the GPU CX SMMU
 aperture
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-adreno-scm-fallback-v1-6-e99cdbf3121d@oss.qualcomm.com>
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007310; l=958;
 i=puranam.tejaswi@oss.qualcomm.com; s=20261118; h=from:subject:message-id;
 bh=OrV/5vTYv13MHRURk6HQcE68oIHzOJUujrYoLsrCZl0=;
 b=E02f0xCUQ0B2N8YwWTg2OQt6tBwet88oCSzgp/qF8U6IEa/zGvNPhvlA1LLu0l2TD5KGmW876
 bGya8WcAb/nCcfpQ0ad2361m10ugHZ3zS27WF3pmhb2SD5rO+ux7ch2
X-Developer-Key: i=puranam.tejaswi@oss.qualcomm.com; a=ed25519;
 pk=I7kFxZ7dcroo7ZWUatk8fR/J/KVbRzZq4ZBLhRRGpJo=
X-Proofpoint-ORIG-GUID: vzEUilr0GYXLWtv3bbxKYw9_Vd9QrlwG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXxf6Zhxv73qZK
 HTDhim7rkP5yCKvgY2PnSL4O2O5VCxVCuAuBQiYZ06BxaHb5kuf82QpBHeqd3QT/5Hi2N6aybtL
 OrHmvnajmI9Ed8Ncy4gFag36gPDFGOE=
X-Proofpoint-GUID: vzEUilr0GYXLWtv3bbxKYw9_Vd9QrlwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXxxvqcaQvVCU1
 Hlrb02DqwfxaIh2njcOV/ktG2YFCUw6V8kkrohyEYXmuTpabBtGkBuP7XxTiGR9VDn0qGH2wnpN
 ontWbJJ2KOZ3xan7brAClpH3faiYj+faub8L9aXrgUQcjrER9Wp172XuklN7QLchik9sK/u2C4T
 vgTUiFMH6PvB8lbiHwD7NHBmxe284pHfEJMOpMHaeVu4y5yE27YZy4on9ZfnbAkx4Tol0njoZJ5
 f3KC3Vr0elCXlU8E2kwnhTO3a+vk9HymiR8krY5FOMCVKmmjB8fKZC3O2C1DyjuS0tL6TgjLpUG
 JvghcaMsVSwH8dlnKagxrvKnNK5hYunHJkxhH2gRnmH5+886JdnEqiTs4zIj7xbU7fnq2XynpQe
 CWk7iG/gMxQUAJxll/9ZqI94kKOyVYK5e9X3ewu6Po8ObQmwa7IqRXECedm3EaV/VRwc+2QstB0
 Cm1itFfxquBo7Rw+WcQ==
X-Authority-Analysis: v=2.4 cv=NNVAaE6g c=1 sm=1 tr=0 ts=6afda384 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KBsJZNVkQGKO3p3TXRAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052
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

Add the CX SMMU aperture register region to the GPU node.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 0a95ad5a5582..ebbe5e23d173 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2647,10 +2647,12 @@ gpu: gpu@5900000 {
 			compatible = "qcom,adreno-07000400", "qcom,adreno";
 			reg = <0x0 0x05900000 0x0 0x40000>,
 			      <0x0 0x0599e000 0x0 0x1000>,
-			      <0x0 0x05961000 0x0 0x800>;
+			      <0x0 0x05961000 0x0 0x800>,
+			      <0x0 0x05960000 0x0 0x1000>;
 			reg-names = "kgsl_3d0_reg_memory",
 				    "cx_mem",
-				    "cx_dbgc";
+				    "cx_dbgc",
+				    "aperture";
 
 			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
 

-- 
2.34.1

