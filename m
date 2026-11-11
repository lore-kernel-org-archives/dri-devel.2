Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD0606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=logbUPvC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHq81sBC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2714D10FC4D;
	Wed, 11 Nov 2026 17:45:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A8310FC4C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0PXK3290459
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1kQSwLB+fzRuDQRMKlhVRp+UlWNsgysGW3ozsYvCnqM=; b=logbUPvChFd9rbdV
 udC1oXKBL6+PPIybAPu3+g/27IJUfg4liT4gQbgBOmNeadk8KFz1L2YQ+aVuU56X
 EkQU0XwP66kCC3poXhJSEWUiVX04TQgCEpi9emwSJfiRmBqg6PgkftJ2RCW/gqfX
 cPP1pjc+O8tPg9zbq3nXxE4QA7mMj9/BSmIKLSdhRXIyuE6scpYSIRGmLuwMTMtC
 8K6HzI0WZvq5y9XGowYOvR+sONo3t17E6sHeFWstMsLSlC8SWVDpccBAmKf+pDsE
 jrXKpdII/JCgjxnecHyP0LOBtIz4evNTWe07BlbPBZpHU69RAUz0VgiESrL9PhqG
 xnp83A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt150xwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:24 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9997828d6c2so541516241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794419124; x=1795023924;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1kQSwLB+fzRuDQRMKlhVRp+UlWNsgysGW3ozsYvCnqM=;
 b=kHq81sBCH3O0NIhcqBrol20WAIVylbpypNqz+1JIea22bOuGWn3aBu7RiutX0C2tQr
 MScnW/Cum8QmaeTM1btyELWPSzOzoibZk1DuNa3x+RxISdSbcbKhsVspGT2R2SgcYaOp
 ZkAC5vtpVknQ7KtaEnvlZbKTPrE9H0zLTCRbgLtAUSeWMY4PLmPrYN1bHm8d1iaD0pMn
 Q09qzVOAEtJ7AeSiFPbxJUrRgU7GGzINbpRmr1dxj0fUqMkBrYtvyTaor5vTsRKAEPUb
 1u4iSo9YGm3UF4voFIXyEoUvH0voSJDg+mmS8IauLTVqqw0K1wwRCR4uKL6bABn6E1ji
 fDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794419124; x=1795023924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1kQSwLB+fzRuDQRMKlhVRp+UlWNsgysGW3ozsYvCnqM=;
 b=g11pZXBWAZ05par9ZHK/kA/kEGsRbDQoM8FQeXf43AUDPFDJT2pASs6TjspvTyRWN3
 myd70HF8cjuIcd3ikfftsuqeeJYHZqOtFAXkm2HO9DWl0ghTaPP20L3eFDe+6Swxy9RA
 0nsmsCp7hrCopU0YilU7BqcfTCYwX4hZ2jJtxcpZWqEcgH32xU3twLYgzeJYWDlf4KZd
 Rm6IAPKg4alqn2cJFDhXijRNIX7YzrvWKiMM278w1Ya0vyXGGwW22FYQfa85gilcALVW
 jHs/2p/s4PhoerFwvxsngo0uH2GQN2SHb5ap3Ai1uMYIV6wCs/8+sBIYtvX4vyeEshUU
 V+FQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHUCh+xFwEwoe4JN4V+oyvoecLYqhKZNxae3gXFYflvaeZtQylPL4bx5ZTwkGsK2J6Rv3/SqCOcdAc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/WobZzGRQsaoWMEVlHGNybGQbBYOloLANZRJoq5uguKQHZcwYl
 mQqrZ1bbVoZDmJkj8mwPB6rQ5qPoBFH0a2H+6rHNHeMuDCbw3Z6l9sth5f8qrz2yjq97D7yu47z
 uhkjvtDW2LqsO0/RSVmir3H/yRmRUpjGe6eTdlSAGKf43zenvLUzR8uG0n3LMeuInDAUJaBg=
X-Gm-Gg: AYBFou0/QTguZfqYp89/kmJ10ONS80+v+69JbP+ihdf08lJSI+UUQWadOJnVR50L9Ze
 DVqL0TRhbHmS9PWN4Kes4RtZUU2kMeckL3nfiLKN7L5sh4Gb7og6SFhKLSVyYRR4vUb9P2KY0mb
 3IVq5YTzTp+IedERtC5gqY+F+ytKXXA176bPoVIVfx8lV7t0ozkv+A2Tq54ZbAgDJ1oUw7+u0vg
 c7UPAl/mDIdwbObQW3qdJugOMNE3hv8yqww5GeDE5zij78cuxND/h90wNZRwnnAJM93miFWxPO2
 hXUwJHNna73pW+CwJ3UD7FrDv7w55d3yJyjG0U6Q3LqPPnv9CIKZTk4WkOptUhBi1S+J+c2u16l
 d6zYMCHTsn470K2ytFzYEcfwVlZZU6jym9sMKHvPLyCB/vvcBp3wRWHD63VG356yYsUkaTQ==
X-Received: by 2002:a05:6102:c8f:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7d5061b81damr1261543137.31.1794419123932; 
 Wed, 11 Nov 2026 09:45:23 -0800 (PST)
X-Received: by 2002:a05:6102:c8f:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7d5061b81damr1261538137.31.1794419123452; 
 Wed, 11 Nov 2026 09:45:23 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e1f5810sm4846525e9.0.2026.11.11.09.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:45:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 18:45:01 +0100
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-display-msm-of-graph-v2-2-fdf8fd97f49d@oss.qualcomm.com>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
In-Reply-To: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hbrjZvH0hhYgCazLv6ThBvBfAtKM2TTDR8/XtS3ZJS4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9KmmauDWI+Y9xULUnh8XyMtrW28AyyFTHiIhq
 VsF2A03zUaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavSppgAKCRDBN2bmhouD
 1503D/9w7wx6Z2qEMiyq2ZWmcqISJSvP6uzy/1iMjmZg/gLuocm/cHe5ndH0sElMmXUH9EADj7T
 6zC+YJxOyZ4wpgephNA3DdIScwUhlNl+/2R90pdzOALEs68po5n/YKR+MN1Mp5cbMUPa4CjeILJ
 ZI/t5+xdb3ASSVooTc8rVGIOaFEcgbOLZ9rHazJPU7c7a0QFdhkx7vdBkAqSsvHOZvUJJad64Al
 hlaKFkW9lxsEFcxS74HAzichA60uKBNaO8FGMHiU6nc31y4/n2wr8FwzhgOS+t8casJ+J86r8Nx
 8Mi24/e9PejVLK3a2I+JGON1Zce/TelxtjV7HX73yYkSg6nlCUacae8Hyu3u/ssm9jbyotJbvmk
 gWrbFk8/hJvUvGajoftaEbH4FUXAt5Yti/AkgwCRpK0XKtCW+4Eu2t3dXPJMlGwS3Hhf9M+g+Jb
 q/j/nAKwzWzSAkIDp/G5mBBlpe2LJYhRgiNc+DVbxGHehtxmQ0eWjR/MIXHlsstHf2lJ0I0z2+5
 mk7PbzMGz/m2o886r8o+hdFYs7d/c6WdFAF5Uffk+mjNv8umaHWWBfL/Fud5nGo1uONmvnBQS9O
 aq19e+RktF/mYWUhfZS1k9j7jWCnwImgNdlLbC1m6Q4NaBr8LCvTga3U45QCmTe2jLLXdOyr5NB
 285bfqlU6UrVmLg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfXxX6jIDtpOF8X
 +Wfca2E7uV4zp1o0g5SdBnxSnx2vmTMAE588OGjLF9SYOydCmGVBYFTNE7Z/kIeeif2smkroO8b
 IQ5SiP2RNM9Od9NkzmOp85yDdeE9Yyg=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af4a9b4 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Jz4vbV5A2nIxJx3xYRsA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: _ODClbM_uyUW7z1BU0zWldjiE2BEFJaJ
X-Proofpoint-ORIG-GUID: _ODClbM_uyUW7z1BU0zWldjiE2BEFJaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfX6a/fvI6Lqh6q
 tmlxtvrDVGASdXhD8A/38GS85KT2EtX2CsqaMQpEkXuIHjHO+ukseSxgBKbHYTeIAdvSx12uWJE
 lrXKnHViwf0lVHDZVD9LXUHMQUh4NuqnSs4fzRpacD6UB3ljoEDBiTr5iVNdC59TyelQbgSrBUQ
 9aIrOAly6VOYTO7VXOlU6lZNjFmE8xv5daaBZiFWP6feiS5fB+JkkBlWVgLzZPM9JcqgENduYiN
 hXnl7vddZkyNi27vK3ZzQXIyKQv6+G5uF9FxR18TFFksNxH4j2oyHvwIbBKWXsxl5x/PMz1vWot
 VmhKKPc8Q0sWK/BRBy6aR2fgrhxXPqi07OQpXQDkyye6TzDseMcpSzSTkrZpQvnbarGrmRuGBMh
 m+UnsbDMyAJmO1lsjhMh9ZcZvGixwJU6n/qLyJ+qRVEPz/eqrugwGzR0v7AEnS30IOLMETPMGBO
 T19w12TsUzfjnOU44Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110070
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

MDSS DSI and DSI PHY are useless, when nothing is attached (no panel
description in DTS), thus should be disabled in DTS.  Linux MSM DRM
drivers will also fail the probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
index 7a3f8afae22d..9c2cef11e7a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -189,7 +189,6 @@ &mdss {
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l2a_1p25>;
 	vcca-supply = <&vreg_l22a_3p0>;
-	status = "okay";
 };
 
 &mdss_dsi0_out {
@@ -198,7 +197,6 @@ &mdss_dsi0_out {
 
 &mdss_dsi0_phy {
 	vcca-supply = <&vreg_l28a_0p925>;
-	status = "okay";
 };
 
 &mmcc {

-- 
2.53.0

