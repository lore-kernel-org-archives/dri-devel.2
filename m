Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6394606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bugPY9ZZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B8fMyAaf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A44410E862;
	Mon,  9 Nov 2026 08:37:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D0610F0DE
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:37:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A969t2m401380
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 08:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rL3BzTsPRbdacfMmgW4kuPbKSzAfAI6zxuXuHJ+eMAI=; b=bugPY9ZZO+xDwEYv
 QOAeANmpmkJ/JaJ4BFirK3JeT5RiLehMtR0B/YBUvx9yhLxHsYWtKiW4OGdTvopE
 VNJFd9clAYs3gWM9DNWS+uqRCVRI8tn/IUKlH5NcgCntYevFWWaQR75HA/48tofQ
 JkThpW+0eOfVrvDs0MEMuf1UwHIxtHxLDkJceEIQxqlkFjKCp6eePpiM8h5M1259
 xRCFvoF5mqATBtnHWWoIYviaqjudJkk4BfLsR99fWZZQ1VaNXspLEeqI2sXsuOF3
 WVTxVGzdVM4CGUdVv64yVkpTNROgy380dQSZmuYEOCUhnUh9T3fQLFkuGTGyMjsh
 0CycFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf5smq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:37:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3969a2a7so107828385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 00:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794213432; x=1794818232;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rL3BzTsPRbdacfMmgW4kuPbKSzAfAI6zxuXuHJ+eMAI=;
 b=B8fMyAafMclP3Fsu8YZ8GIL5Qbi2tbqGPcqwpjaZxA0SjB5YYnncgSshY2XmqLmB1j
 eJyjBcVLT4qa5dZ/n7s9ZGuidSdyh2oeIm6Ve7hDvO4PKKgSk52d8ZBz0DDQYnNFvHtL
 hCdu8BGRxu4rAWldU7ucwCRA9Tm4XpE4OQKR4mdlXfeWwkE7ogfZZh/eMFw7zWFa9gtl
 xqgzNb3yxonQU+Yt9kAiS2BHfsHGpq6Bj4GnHtre9ofveSNlQ4CVdtvMgXeHsb3H1sU7
 Wr/EDEaF4uH4pLzBedTAXF0BfEf2W9zO1GqoT0fYRLFfFkcjAgJ5mbTW8/sShHSWO6DW
 AVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213432; x=1794818232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rL3BzTsPRbdacfMmgW4kuPbKSzAfAI6zxuXuHJ+eMAI=;
 b=Rr+NOdQnXz02zbZWyl9fJEWhu6PsxFhX7z2iCQJFXlRn7wnswFAVzqzgIdUeiPlXB2
 dNqNIJSdbTqTd//8dIOwLa8HSpPjPXznfaEhuU5srqLukmYQCyZ3CZd9RxFDLQk1OY6x
 PtqdCvI+Ep5USkaUrCpP+IzlIkZKTqKZOm0pARtJBTTgElp2rOu3fajiJB/xMPamuoIS
 EKvM6Qds3OJ3tyiH5dqVJBg39FjqXPmpBLRzfDIvfI12bo/J2pcPA9TvoFQlMqYlNma1
 bp34HEgjA1VXDx+Xz6c/NMB0v9ymiv/vWfJrbH4r/JuunaELbC1mkNBS6+8Qgt+Ud9T4
 E/hA==
X-Forwarded-Encrypted: i=1;
 AL+hErHfHyMMWq+hPzDSr1hEU05xtRMfkWu4xyfH+exPOoDeIQ+X1jKdZd0Oof5lbffEDfCEPRQEq6jKq9E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9uiHmLQWTniCK8KIvatZtPpb+ziqa+744I9X6gbukzV1xjnufq
 Spv7GF9XxwtO95R9gfXHiJDkalWbiAeUsNvrXN5EquXI1Zv/5vQSIjjfFEMvpGiBwQW1zAuXV+R
 W4TQqr3hs5Gw+8S2/fwb+aiCu/CnOFtgqIqsvAOUc4Njw1oaEKQ39mHc5NJMRpZF8exz8pIo=
X-Gm-Gg: AYBFou1MC7T9u4WTh4inS9n8uL9SBLSBA1veBzYqIPybAJK3DdukcOyKfaHBTmAY9DJ
 w9y6cB5bCIf9ne9HwtgOMcjQXsylLerOyOZAh8luG7BmP9kbeXFBs2MpWqYEnJ6tIA4VmBk0XW8
 zWCpcIG6Ur9kf78DSnm6Bw4ffqfMj0m2bdgX4IPv5enmpiqt7gaLb6iiZPgKKlvC3L3yJ5vRqc3
 jqOQSZMBGmzpOsEiK/HVfBiy+u8feA3HibIz6klOFO5BSdf2AVim2n05bT+rVxhzijuSNwPCpMu
 arHn4M/uHrMpFxpsUG6kiwnk1yqXC9hLUeLXmNR8gcR/RW6ix/wD6Zu7FhiTdJyFHaimZiayEuB
 EbRWlwtmVO0W03tRU21Vv4957/7IuXGO2zzIEfL4bnnsnzyZf/sFVIQN9bBEkbNvJl9gIPyeUEj
 8Rmrk0F5hDwPq719zRW8E7WWy9I8z/mpesfwk=
X-Received: by 2002:a05:620a:a18d:20b0:947:8f05:39fe with SMTP id
 af79cd13be357-9478f053a98mr202379785a.77.1794213431796; 
 Mon, 09 Nov 2026 00:37:11 -0800 (PST)
X-Received: by 2002:a05:620a:a18d:20b0:947:8f05:39fe with SMTP id
 af79cd13be357-9478f053a98mr202377085a.77.1794213431241; 
 Mon, 09 Nov 2026 00:37:11 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782dc37e5sm418223385a.34.2026.11.09.00.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:37:10 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 16:36:37 +0800
Subject: [PATCH v5 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-msm_gdsc2-v5-3-4a3159b5e4b8@oss.qualcomm.com>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
In-Reply-To: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794213397; l=1333;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=d8njmLr7CV+srDgKgb/TI5vSyT8vzzb8i6MXu/trLH8=;
 b=Lpc1jsqk39ukAc6Ha3p3NCpFtR4N6RWJAnPu3s7VJuOwW+CSKXIHIBpWmc/Ry+SyF04cgdHW6
 0UHN/K9ayQcDPV6pRIpXeSacvtn36fRImuv5AVBB2Fl9pDrWPlIHDX9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfXzZqk1ChYLEH1
 bDWqxbbcVYvddD/4d555CW+IA1qsCD5Sid8L8XVpJ2lAGmwdj1z/dFXRjCPwuOURGKtF0KaHTYp
 ETriyB1TgVLWMe3Pic7e8ULUAKo0t4g=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6af18638 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=GwFvbCpr4qPuEswRa30A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: fohabsIGfgqDLTY_SF8psTHJRA4rlTMq
X-Proofpoint-ORIG-GUID: fohabsIGfgqDLTY_SF8psTHJRA4rlTMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX3+KeYz0J09gP
 k3YcymAP2SAYG3Y2UsJeokJQ2DilCGQWDqtyxQUKAEXb0p9DH4iw3xk9aH+xj7aTxqHC2Ito5W8
 FEeV4SELdjq22lkTs4APWp3VAgr89udeHyR4fcV4fNrjUHw1VmXN3H1DS77p2xHrGQdr3cpzvZS
 qC1MXTc9pH1vgLPDVJ0avuDDPcfHN0whAGwPc5at5MwNOB1s9LJ0Il1beBSGasIdGfRvZUNrm7w
 /3uw2mY4FCytqf6lcP/dstIZHTDur5NdqiCEHgAKdLW5DX9SvpOTlZlmVLl5wDO+hN3HA4i7iYh
 KB6g+REXs0eXGs2Vx02+RffB3TE83ydyul1+c7TVeKshe8jwiHqWlV/qHN2iPrvebJ9SSedUY4Z
 Vf/RiCVl1TW2uzswesxxRWGPTcD9rr9uxDDqlFJ6R4qZtzbFlX9FPWcs9i/nAlXYWiYRweOhdKn
 COtHJ1PA/iaUiJ0lLjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090034
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

The INT2 GDSC on Kaanapali (SM8850) powers the VIG2, VIG3 and DMA5
source pipes. Without enabling it, these pipes remain inaccessible.

The DPU is supplied by both CORE and INT2, so describe both GDSCs as
its power domains rather than attaching the DPU directly to their
parent MMCX domain.

Keep CORE attached to the parent MDSS device because it also supplies
shared MDSS hardware outside the DPU.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Joonhoe Kim <26rote@gmail.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index e48a179d0722..98d367b9dac7 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3674,7 +3674,9 @@ mdss_mdp: display-controller@9801000 {
 
 				operating-points-v2 = <&mdp_opp_table>;
 
-				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>,
+						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+				power-domain-names = "core", "int2";
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.0

