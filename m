Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380B606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=emTk5UXQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PWwYNqbP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF4710FC55;
	Wed, 18 Nov 2026 13:09:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DAB10FC55
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AICLBXr1785702
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hGRlOCITxGrJlyMVtqXraDekEyGY6Do3g1FwaEQjkKE=; b=emTk5UXQE3v2LVIL
 PL71S2IRUG5Upp4XtTueqDaRhiPSOmfP2VfR3K/gWTmVMxm1CAXEP6ZuwDv4WtiX
 T4ud2ylNobOBIQX5E9LP2F97jGW+p2iUDTOOlOaA1611yHOW6Ome98GqU3/s5m8d
 5eagLpQLD9e4atW42ZmPBRM2hhz5tS0YiiFcxFencU8co4qIOE7n4x6itNlzRoQJ
 5R5QiPJpNTwbgnQ9CA1zgTO9jDvujbzMQeDw7KxHvsxZKdrX7hZvTP8l8XJyKaiQ
 MU5GGG2sciHUj9nygHX7IcGidY5NVKU2F/+VDX37MNYLUQasigN1Zj91RjewFsbm
 9FuYSw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8b3qm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:09:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a6e56a2fa2so53786b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795007354; x=1795612154;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hGRlOCITxGrJlyMVtqXraDekEyGY6Do3g1FwaEQjkKE=;
 b=PWwYNqbPlkM6IzuftF9dzvEU0caO037t9z4PON93UBxT4V23F8dwEXkRJxRad7YqSM
 mvQEvo8cZ9bYTSQGtBviG0rM5iN5CDGlGGCccbgCuDZUu/JlDkHa40kJmxhLW5dpZf9J
 09BG9o2HFR4oQ6O/8nnbb6sBq/47W6LHqv2GuausdHCpwa20eMNg//cijCD6EZ7N9QXz
 Ox+WscPk9Abg3xMF5iIMDPnnEVWj84Mxi7RIahrYrshgLOSmMjP6R74egOiw5NN7yPoe
 F8pKH+D76p6r6cgbt8l1pMx0zHUQU026M308pMFWH89umH08BcU6k56tMWaeWnCkfY9m
 blZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007354; x=1795612154;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hGRlOCITxGrJlyMVtqXraDekEyGY6Do3g1FwaEQjkKE=;
 b=dj33xa/THdtlshh8tp2yYzZP0WKAIHlQyP+jimne9Pqb/azHp2cL7w9oOIML/7VnFP
 zXB7etYfvdbYjgfJF2hOZFxa4AjSPi6jnNWnfEEDUTa30VEQlYy39oPB3ndZfqIJW/ZR
 7sObdjKBpTMnX1bcbFfPAX6VLjGGeGN+6SaAscjLfM9M7eI01QyOOxKCTcZifNJYo31I
 7ee+aElE/UrsCxojCX76IlbqOnszZSDykVMvwpo/U76M5xI3kh8R2Al4iqgzbLuI6ab6
 aRrIybmxnHEFDTmcXervmDkUt9hSYTTTo/WDH4+xAOma13g+/GtfhpulUsHYSGg4jwrz
 YheA==
X-Forwarded-Encrypted: i=1;
 AL+hErEAj0gonhMzejeWUKTob8HybdG9iAEkrBFKNWO2ARsXWkR6PSk2kvji1qcLjosjkxxjqybIC5n5QXY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hglxvGP+URHrjPby5cbIhEJoB8eGemwIYZfRDfGMKocuBv/5L
 w/BCDhepBFgzh2wSJMNsE3qaimIFGUm5CTUs7z2eue/go57jHW6UwRndskZFg44gTBnlCk682kB
 fseFHb8ntSZqi/x0mwDL5bA2f3TM5boaR5O2askCrlCkBRRKL0F1pauWdxtHYye6QE7l9aqA=
X-Gm-Gg: AZFdTZfyrkyVlfMyrR4xZxPOdit8WBWBVk/WmhgnWiN1+TI44XSv3NxEneNVokhd0fR
 DCkny0H30j0zQgLa+RWiJXc/GCHaH9zKpCLOK03K7Jtf+VhTXo39Vk0lx3Qm5hZiTQhi3/RRYlY
 L4wPf4RffJ4MpUoZnJpcA0pRKJBsbAe9Qx54W+tZjs96c0e5leIC+Vq0M8fTFTp+//wnmJ/DY5H
 wLuVy1x6Dp3nKJIxXWn/bdrSPE+xCXNRqdiPmgn27K0Oqe1ZSLKKXFvdb9Qf9b18l1CEmCj9iaD
 TNPbfQV8//l8M4k7o2EUSQtCGdnJCzIMoOauLVZs3yfvCZ+Topt23gTU+68QrE78uR6dKnohOy1
 BbMTuaGtCjjWhHQJAJ3W7UcopIfUUsewXbEqlYEKY0GXwf1GVr9NLPWRJOQSzmDL6fHF4EjMSQx
 N94M6M/K/8
X-Received: by 2002:a17:90a:d2d0:b0:3ac:a7ee:6785 with SMTP id
 98e67ed59e1d1-3b3d064623cmr4717329a91.1.1795007354039; 
 Wed, 18 Nov 2026 05:09:14 -0800 (PST)
X-Received: by 2002:a17:90a:d2d0:b0:3ac:a7ee:6785 with SMTP id
 98e67ed59e1d1-3b3d064623cmr4717270a91.1.1795007353575; 
 Wed, 18 Nov 2026 05:09:13 -0800 (PST)
Received: from hu-pvgtejas-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm4909533a91.6.2026.11.18.05.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:09:13 -0800 (PST)
From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 18:38:29 +0530
Subject: [PATCH 5/6] arm64: dts: qcom: nord: Describe the GPU CX SMMU aperture
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-adreno-scm-fallback-v1-5-e99cdbf3121d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007310; l=953;
 i=puranam.tejaswi@oss.qualcomm.com; s=20261118; h=from:subject:message-id;
 bh=X3BYyKqxKWnNq/2Ee/BaF5+6CSmMGjwe4nL62q2A2QM=;
 b=UkUP+L/Nz2kMolwrh3okH1PQP7XCpSODyv6+97tzssW3NKCY6eYnOj9m2p5B1domMEQKvaQWz
 SeiOJQK1+mgA29JPDjhLLxzxFan9XU8VJyen2q0dOtkyuDeuxgOwtLU
X-Developer-Key: i=puranam.tejaswi@oss.qualcomm.com; a=ed25519;
 pk=I7kFxZ7dcroo7ZWUatk8fR/J/KVbRzZq4ZBLhRRGpJo=
X-Proofpoint-ORIG-GUID: qiaBL5v-NFDMxMdiVhHH3yZb3Sod0yfu
X-Authority-Analysis: v=2.4 cv=N9u8hG9B c=1 sm=1 tr=0 ts=6afda37b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LT-FgXCurgc86i5H5_MA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXw3jfGfkygFpW
 KC2Z9zwgOixSY6SVSfXdDwJtQPcTgaFUb+I7v72Lkyc5zbbR47MJiMdvqNh6oNxIITy/8QzjmEs
 2BGB594Ee4nasG3230qVrXeXFXHkE7K0lBM+6cPF04jQe+OE6SQdiVOWFrQVr4BTfY/aX0ic0/3
 /ph0NnJGNBmF2S7kpHnKVPhncRpnIASQw7WikZynxkx3VA/QqDoPZTKz6+QIvIIhghf4giMxZ/s
 NGCAAB/XHKWjWsBNy2EQrEoEU9//lV0eRObEbm9WHI7bPr2S0MQIa/PePwoWxGmGHbqsXqzDZfh
 +h81RMl3IP0KGkAwfTshtVONJfy9DSIZp+u8pkz/DDRiGgE5jhLHS8UPxyfaV5E0hmS5s95DGZp
 yOgxPXNVG73fmAm5Ss1S+WiVHZ1ks2VQc/Z7zoB2SHZCduwnkMLMGlfm++6qLbCIj5tI1+/mt/y
 C0cjsnYOwdMBV/0p7/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX3DJyRbkz6Wdi
 xPWfKl31WXAcNmScgPYIDXEV+8L/XcG4Wu4/sFVDdZRK7a3lR6vSI7H3RdQtPPcAUeXBa3DjcOL
 Hb0upjRg13mRfLKLzo1TvuslDLtXAe8=
X-Proofpoint-GUID: qiaBL5v-NFDMxMdiVhHH3yZb3Sod0yfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
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

Add the CX SMMU aperture register region to the A753 GPU node.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/nord.dtsi b/arch/arm64/boot/dts/qcom/nord.dtsi
index 3e29c43ca9ad..cb5ee6b68779 100644
--- a/arch/arm64/boot/dts/qcom/nord.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord.dtsi
@@ -1717,10 +1717,12 @@ gpu_0: gpu@3d00000 {
 			compatible = "qcom,adreno-43051701", "qcom,adreno";
 			reg = <0x0 0x03d00000 0x0 0x40000>,
 			      <0x0 0x03d9e000 0x0 0x2000>,
-			      <0x0 0x03d61000 0x0 0x800>;
+			      <0x0 0x03d61000 0x0 0x800>,
+			      <0x0 0x03d60000 0x0 0x1000>;
 			reg-names = "kgsl_3d0_reg_memory",
 				    "cx_mem",
-				    "cx_dbgc";
+				    "cx_dbgc",
+				    "aperture";
 
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
 

-- 
2.34.1

