Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D76606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m9BOlHNI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hnqrZGye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C12B10F078;
	Sat, 14 Nov 2026 17:55:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8096210F078
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:55:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEHs0WP160764
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SWPuKJ/V2DaQHllZzOMnN6QFel9q0m/5M9pFHMBY898=; b=m9BOlHNIqLAo1BZK
 6OuVEt8QYlY6rUtJOAJ8jJaNRaffF37q004zZkVKHyEKHQKfYkod1Ozvsx6G1Prb
 g1+6ZGHsR4YcpyeotoK2oGK3AtuZKUz9nZR4/AFivYrRkLuk7yL5755gX6J6vMdg
 8zYFDChPoAk5jBKCbHrQxL40nFm6K/MLGZ+BlzeE9+d5xRm9+ybUVTf7p1dmwkGC
 FhxdFxiDtHu6tcrhTTX9sLEAOZHrTSv1WoOiyHFPuPe3M3Pr3EfPCGdggLdiE6vN
 xUp3k0pRZ0oWB/LZegj39KbOgcdteIlVX6JKIor/R025kuByI4McSI+GfhY07gqy
 Cx7ZQw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx1ehj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so419568985a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794678898; x=1795283698;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWPuKJ/V2DaQHllZzOMnN6QFel9q0m/5M9pFHMBY898=;
 b=hnqrZGyeK6kU21JsQa4IOLtaF+nl+ANNtAoRAZAUXB872lFuGbrgJkFkSZuZ4G7Igs
 zXAE+Yr7ZAigL75uElhOu0S0mq5ud4l3IlYTlt4YI8iJ+8yW+J2v/olOtBW5jf/s0MAe
 4CEY8d/045u1Y4rpl6u19Ku2051dDOMKgdnKMDl392n5z4QKqLmxrNB457Z1osqAKLLS
 WumQvaPjQurwUg3DGwbNFtuHkqlSLBTwGLfG79kSCnqvutO1weGBo6voq1buFTS5E/Mo
 R5EMc/hzpPPhxAu/hGo5+GN3V6xwnD88V8gL6JRIXQZfrBv7kX7LBpLY9idIkL3zDGrq
 m7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678898; x=1795283698;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SWPuKJ/V2DaQHllZzOMnN6QFel9q0m/5M9pFHMBY898=;
 b=ktt53FVZiWzrv4tR8e2vFMCE/hjgcz6wve+Ml7g+zuZwUeJpUrBqn4wb+QwSlv5fC2
 yfAdnd6XIX4IgWO3cox7kZNhb7MQNrRkZ1np4pg1OUBaECTDS/tHrCnxs4qA0wRZpXIP
 SnvMHVeH/enhvCFNkUOYqdl6I85fW5RPn13qYZ0do2Ej497sv3uDhFCJa2qLnT7epGbb
 1mudlMb7iMj+qc02iYyNUNdQJweMl7UcBuIrdroJT3ZRTKPNfkWtdSVzcPwOtsnaMfMa
 xw+AFbQugxhOYADi4gwnabSTDPTW92vYd5As2DVBC2Tc02966c48eRP6vWfm8cfuAfMJ
 xBAA==
X-Forwarded-Encrypted: i=1;
 AL+hErGYEvZETP17OqgjMzC3vQULF8ZcSnrgYgsldLOKItVrQqa2o7Taabg3+pk3MLoTBKc9jdqpDpdGY34=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/RhddYSXPnsNmQWBNE6b2v5AvithZmhRQ01XpmhdHt7YjUlsd5
 RRKyAb00eFp+KnsWFZhAccFRoQ00bav1HiijUubpD7Qqow+HCBk/5U1wJifXia2sRdszwDfBXWR
 pydpEl6sCAWOfdKGQ8JNWidD+uZJbZF89VZFxYUeV7xN0N6EdInMw+0ldZoxzYaGGwPbGrwo=
X-Gm-Gg: AYBFou1/f4XKjhMxTn2yUkqhRzi5QSDxBWKq0CAqj/1W8kF20apDGxbWFgW6hMMOFFo
 1Ki7WWkW2fnaZa0IDa6OlBw1wrSV1HS72o0hbJM5N07SGYI7TCvUPOJXFDMjiS5O6PPjX1VkI9b
 40NAwlBQffeOe3ABakL1hAuBxB7d7UI9vow6CvEJPSnkUX9/GrNZ7UUGUGjrVEnGaNf3UJbPn/j
 6IKGxvD+H/pH7Ws/JKoiAwl/WIi/7j3vPTmEOUWTQcMuk+Wy6XDTnuDpU3MI7FB11RUVFs7WLR8
 n0ykZbbtgzON5wO/kd/751aXa7XfR0w/VVih2T+Lw2zH5X120/cfhu+Z3CBSzLGdmEsKYGdXvCO
 pcd0kzryrOexcRuMP/L8TDIvQDh4fqcoTeYmGjvPkJ8q+s6NhY6IVyT+tENp5/S5hsisjlg==
X-Received: by 2002:a05:620a:1727:b0:949:6e10:b8dc with SMTP id
 af79cd13be357-9496e10bae6mr196349785a.13.1794678898547; 
 Sat, 14 Nov 2026 09:54:58 -0800 (PST)
X-Received: by 2002:a05:620a:1727:b0:949:6e10:b8dc with SMTP id
 af79cd13be357-9496e10bae6mr196347485a.13.1794678898148; 
 Sat, 14 Nov 2026 09:54:58 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm11060292f8f.9.2026.11.14.09.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:54:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 18:54:38 +0100
Subject: [PATCH v4 3/4] arm64: dts: qcom: msm8996pro-scorpio: Disable
 disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-display-msm-of-graph-v4-3-b8de044c6c1b@oss.qualcomm.com>
References: <20261114-display-msm-of-graph-v4-0-b8de044c6c1b@oss.qualcomm.com>
In-Reply-To: <20261114-display-msm-of-graph-v4-0-b8de044c6c1b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VAmAuSw5Qrz1Gz52ayox0A7+zqwBb2WXC/d4EpaIHcI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq+KBj/U1se/9pEQcrSLEYidME6fGqzdtTKxEP5
 iEtUNZ/oN2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavigYwAKCRDBN2bmhouD
 1zcaEACaJZx/cwNuCU2I2yLeRQN/WGPPfc4u8o0xMi6NoozUyadyvLWur+AT63rJg7Xw8u8cuui
 AoYR0BBQFOdWpcr1x2hX0ac8pV7dUwYmXY47jM8jAOsLSoSvN5UGfgVOqOteZYasSVljSl08Ybj
 0yIsNi8N8ymmL7UcLsTMhtXl6huA6FilsIK4R3BLnmjLRl/0ZmfIHoMvvuITVpNDYeMXoQt/3BM
 oOmF2X6JpFlvl1uKgwcDTgFoXWvsjheno1mUfGfA6qsaNpjvE1DffppmOOrTvq3eqhmI9Kzs0G8
 eQ74Jx/iF71PNPFclYYe+HZIZgOTHOYV0ChKNMrxITNKIYFXX7kJt2QzZsSD9AqhTPd3wOF7YRE
 THGN4sIQd+2FuY2dmljTugwUit2WwLrkNhkjfpXdh3I81TZ8FNCbWGbBhv/I3+cXoE4/iA076ie
 1snmX0yGZhbs0w5zSR80fUMPHpXJE6kkNoV+31jzps/06/7os/JDVbDMKrLn8+WaUeweqRtF8uV
 Dz2CALqkARo4wW0tbU49Tgw4AfxNstsO3kE/o/8bkI/sqK6VmPcPs+KLF9siaI0z2cAGtBInhJ7
 vWmSEOp4jngAmQUo6IFVKcZqwt2zJhwu3kHTlz2MdoP13I+fpv4JbGcUKDCqCfmvIpwDI5bgt2i
 69WvE6DuXNryRow==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX0T0cKx/awoxT
 q5vGaAYLDLcvI4WHHTUkPXlXfYZc1bXe/aMM42ffg95WJkAmu+Di12gjk3XVdw9YGIammkR/A/4
 HwjojYv68gF491pCvdtv6iuqn+tTUBJPayOeVRMmjog+uRsE+aSrEzSBUv+pt2z5295l5Aqgvj2
 N2ZKzXhVhGwC9Ctmj40dBaf9VVcqRlRu8Tvn3QTnDi/E6JOyA5DsmXaF4kixfJF5Jvropyd92F0
 X54OF8lz0KYT7Ek71XOCPlZ3DiL2hJobdw1V44oRnWYj+UMpQYtv19bARYhsCZ02LnWYTzP5Ldm
 09C8gULMCztb4zFFjMe713j+5ik5x09tGxDT0fKgnsAnvMs1oSnV9bSgl83nsjiBIeO2LOKgO5S
 w61ATRr6IAPOmelMGp68K8CwH4TDfd2bIclsNadO+Y2+gHg0So6rTTSrtE2hs/RvrYZ83EJcP9q
 EJg8+9umio1LuuiFtBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX7nOtaI8p1vCn
 XaxleLiSbBfMfVZrGT2tj6dtz3ueNCZdV7ZQ8F0+QWeWUI8aJSEabcY5iPaHvzWgyEq3t7xkK28
 x8jQv6UONamA+XJcV1hU9YmB4XQhDP8=
X-Proofpoint-ORIG-GUID: Vnpn75yjaAjtPXktNTTTul_8Iwlq8GSm
X-Proofpoint-GUID: Vnpn75yjaAjtPXktNTTTul_8Iwlq8GSm
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af8a073 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=F6vqezskldl5T9wOwfQA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140071
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
description in DTS) and MDSS being disabled as well, thus should be
disabled in DTS: no bridge will be registered and no component device
will be bound.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v4:
1. New patch
---
 arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
index 1cc33c3123a4..85c542328d96 100644
--- a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
@@ -111,6 +111,14 @@ &mdss {
 	status = "disabled";
 };
 
+&mdss_dsi0 {
+	status = "disabled";
+};
+
+&mdss_dsi0_phy {
+	status = "disabled";
+};
+
 &mss_pil {
 	firmware-name = "qcom/msm8996/scorpio/mba.mbn",
 			"qcom/msm8996/scorpio/modem.mbn";

-- 
2.53.0

