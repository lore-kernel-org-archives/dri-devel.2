Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B181606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3IpmdvV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGJDIA5P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D2B10E7C3;
	Sat, 14 Nov 2026 17:55:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CEED10E2F2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEHq6s72720855
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MTTc3ZHWXywW0LYFxdTO0Y5ALKzAGNfd7iGemICb6xI=; b=b3IpmdvV2+pii6g+
 apUeujldW1xy4CyTj4FBErROIARKG7Y7+mfV5F4MvO2FSyhv2HGxJ/dsZSVE5oQA
 MubnIlT2uw8GujH3Lh18we3kuHnJn1IlDHS+qpjsqpZqviTzWO3yNEkMA+nMZCVW
 84ykrWK7A+PcPuEFdH1SM8D3hUCOs+tjPupkfJFS9HCspIu0YMWUvjTxHAsbYtnS
 HFoydeUHvlloS8kI93QiwUwtZeUhxvxHjECd3t2pQEe79hj6kCbHZTxT34nSFxjs
 hhAghEz9GQr7oO3m9swEB+hbfwiI6UFLzbHhyO6MN6Fck6dQnMpUnxkYaJdQHI67
 mfrMiw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj41d8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94607500fb0so366666085a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794678892; x=1795283692;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MTTc3ZHWXywW0LYFxdTO0Y5ALKzAGNfd7iGemICb6xI=;
 b=RGJDIA5PO2E9IdRNmshQ6tei6d9g4sXyKLZt/qH1JG/AOe8NWTvrshJ8LCWwSTyHme
 sp8DyQliXVVExhHXXH3rdiC+TBxvDpruwaYRiYJlFNWbz0nTrD6aPeLTL16CNzqP2SQj
 5kjw+qHO0lLxdw6gnsnxiSExRi1ui1cv4CGHS6EtQ9uAIcp5HibPkFdZ3nixlWTKF8dL
 v48jIzj1vBxg82/qzbPWe0LCveFggm+zfhTciPALPngqlURakTqXd0MGERWQo48Hpv17
 p2bZ2p5e4Jxgl2hOYMlMmU2KIT7upKZNalM+OXUEdMC2n6C7aGAs8bcOAyLoDRSD0I9t
 LfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678892; x=1795283692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTTc3ZHWXywW0LYFxdTO0Y5ALKzAGNfd7iGemICb6xI=;
 b=NOYMO9McPSuj/ASqsq5YPetyN+RybCv5Oej1cgtQ9wSw5TDPaeg8e4fw9B0Aunq4vP
 NJe8l6jC437CAtwvk6USQPzG33SjKyACFwHqpt1xYTan2dMWv6HigBpouygVqCD7loQO
 KN7uavTMZaY6ZJvnMHWW1wfk0YBJFwTdVSowslDQ/5VZCDVOLDQx2SO/HUQ/88JqPssR
 TyV+tAu3d10bUNZQF7Ib0JJ3FnPBl4WpEuhjymGZPra8PuIndr1dyl0DR0/ZV2E088ol
 BdMLPs+GMuO5Fs/qjaSHUOKAcQ23Zh3qr4cWEH/m0soqqs1PzDZ39gl0HCWaQzn+sK34
 zDcA==
X-Forwarded-Encrypted: i=1;
 AL+hErH0T9qZZ5+AqfOTX129a9KOXjzAVz+TjGAZKshK8++efUEsmEqWH7lhnuz3Gr6Fr3iENDyMwDCYg2Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hnqZlMrozine9Ac7Dmz36Y6NSZ2qqotd143eO1dEP/6u9797r
 0rLLZz8Y35D+fOQS08r5IYuCaDIPv0CQ+AfI44J55whx5ZtN4nHOqN0RJyjEl3dBuMtDmngfr9r
 rPy9XHAV0EiwS/8ZhNNI0uBxNfQLmm3q2FTnLTEf4aVxxc9VIUeIvgkMJFzGPSBkrwZQNbVM=
X-Gm-Gg: AYBFou0Vji+/Nqvr3tFlg231eHDvCt67qkbW46jxb6piXyyAeLts942qdPa5hfVuHZU
 BbllWIz5K1fXjcp5faxSGVyN2c5EeKf+1m5Qcbb+R9NoI7NP9ubwn9oGa7cxWt1pFrXVvQ5Klcs
 9NTyekVKS+s5+j5K3Gw2eEy15opuhlEpp4SKbPv4gPTyBTHgHFykCDbwcpOAlvb99kBH9bpXsLt
 v31SCtnH6l824knARYo9VPvdWmdhSFhKGYU97oEUSNuaYADvUsTZv37Y2yVNLkeprlbkhsrWp2W
 QrzJLD5Re4kQKDPG+shHqf4TWrHli4nJlYhdEbI6djB300uY87ADLG5vsabjtARAqA4KqRocthO
 xg+DbwBZrCTfJzkhLAYmD+biCJtzTDCNv0QqkoRitTnyYycf0VmiQt3lHI+IEtkmuF45FPg==
X-Received: by 2002:a05:620a:4722:b0:93e:fc4e:c48b with SMTP id
 af79cd13be357-9494bc845d3mr1111224185a.61.1794678891757; 
 Sat, 14 Nov 2026 09:54:51 -0800 (PST)
X-Received: by 2002:a05:620a:4722:b0:93e:fc4e:c48b with SMTP id
 af79cd13be357-9494bc845d3mr1111218885a.61.1794678891184; 
 Sat, 14 Nov 2026 09:54:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm11060292f8f.9.2026.11.14.09.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:54:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 18:54:36 +0100
Subject: [PATCH v4 1/4] arm64: dts: qcom: msm8916: Disable disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-display-msm-of-graph-v4-1-b8de044c6c1b@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5343;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=djTBa4Cy0m7HkGgyxoN4PACYXv7Ysx2A5Lx7uxzmuOc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq+KBhnHmajMKESfjFjlwcPvlKWpWhcvN7VQSD6
 sfFGusw6bKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavigYQAKCRDBN2bmhouD
 1yWND/9dxmVU3BXtm18guhYgE06GmvSifi3OECnyHgRMgRjvVuX3uIrxCbThZIDJyWSh72947Dd
 +ypdgo9nNf87rS+i5eBF8gfjHJc7rLEOz2Sc/1D5vyeAtR2NmD1+I23NDy51lUlgZa2NF40tHPM
 3W4VjOsiM0zAmfRkNy8hZQsKtqHEs6w5I8jMEdRMzzpagCrzYBVEj2kYq7h8i99yDDKZS0MRNEf
 Deyt41jLzanaZ9GQZ8H5AtiVrFkgIE+h72mR2xeHqwgAwu+puk76Xs25MVBveUopor6NEs/Aw7O
 phynhRNZUj4i5TmbXvyZedAiMgE9+qDjWojVT2QCfvK86rsNpVNwkQ1raNe+4sKuYJ4XyCX9Iiy
 nPCWKS9hMa8WiuMGqigRBC/MflmWsQu7ftKo4pEJ4s7org4N0vBg6Fa6X9UMz24Ufa7xwB5y8C9
 4YKmpNLzB0xwnV0vIc834Rddi3Tp5BkRJyX1ABk65EedTnbqEY5BGWvapxZ6dPU49LgjjkeF0Jn
 NBB3L/wkN9BGIHXaHN1WF17JNkuipmQA3Z5Y7sw5+9kOa8L9BcOyQARWWesjQbTbvH9sOY+nyEy
 nhJG7UT06Zt3+BFvn20P4BipFDZ/4yebIze/EJX8z93bRzx3KPtKNfDk3v/IPTdx3etmPmCVyo7
 XECGAN5NqVCITTA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfXwcfxr0OTl1j+
 4r/9IzErq+nPaOTT9T83MYcT6epP2Sv8S8q8r972ddPLevJfy3hsQwDr7Ddis62PGyEc+XcH6La
 WsAZtkwANpBXWZkI6eK5bg0Y8GqBS/HJgQUJ4prrrVOBS0kHJDtXwi2nGwIiJWJuuZWkYEzzQ5x
 JWFJAJM3Tg7uireCJbU6q7oPNj4ZZKQKK4aUResrRNbT3KnfHnH9EKvVbvisdoeObwjqV6a72yc
 y8+o3Jet6mh73S7vgYHMo1y7aEjkPMXn1Y1ZOwnrtJZn+kpr6I4IJsZhVQpT3xzFFNPL2a3dEaC
 nYjueOEbQt7Exc+oCd4YbzHbHgY6SdeTPHcj9N/Q6CXaVMHiKgCuKJ9+6DWJmjo9lfzPWjDlOss
 w3nyGrPFU6VKKKhunNBXzyhsHwMurXaGf0gNaPR/Z3ZcsNoUa1geQSPmNJtJicVDQnM+nFnJVPo
 QD+uGw+iv1AEvyntBoA==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af8a06c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=31hGAD3R46fbwAJXn2oA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 1NyMt-OVx2ZiBptokZyDOwfwVbuUawND
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX7Nk7/DUP8Zc4
 fJNb4z6sgNuvo7SjDkuTX5JBAkXF1JFRpfi/kuYPSYgDZohcOmby12sJkNZSPVjyM20J6I1ksTy
 5vrTNlvGd2vchJUP/10XtihtTAuwpwY=
X-Proofpoint-ORIG-GUID: 1NyMt-OVx2ZiBptokZyDOwfwVbuUawND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
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

MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
description in DTS), thus should be disabled in DTS.  Linux MSM DRM
drivers will also fail the probe.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts               | 8 ++++++++
 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts  | 8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts   | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts     | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts      | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                  | 4 ++++
 7 files changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ba6ccf0db16a..1e990c8853e3 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -257,11 +257,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dsi0 {
+	status = "okay";
+};
+
 &mdss_dsi0_out {
 	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&adv7533_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
index ce75046ffdac..78602e9b0ffd 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
@@ -213,11 +213,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dsi0 {
+	status = "okay";
+};
+
 &mdss_dsi0_out {
 	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&adv7533_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &pm8916_codec {
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 906d31f1ea21..d3adbc7406b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -87,6 +87,8 @@ &clk_pwm {
 };
 
 &mdss_dsi0 {
+	status = "okay";
+
 	panel@0 {
 		reg = <0>;
 
@@ -109,6 +111,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &touchkey {
 	vcc-supply = <&reg_touch_key>;
 	vdd-supply = <&reg_key_led>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index 5b34529b816c..fe333ed489b5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -133,6 +133,8 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 	pinctrl-names = "default", "sleep";
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,ltl101at01", "samsung,s6d7aa0";
 		reg = <0>;
@@ -154,6 +156,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &sound {
 	model = "samsung-gt510";
 	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 3d6d9dd3b8a8..85d1cae19a66 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -98,6 +98,8 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 	pinctrl-names = "default", "sleep";
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,lsl080al03", "samsung,s6d7aa0";
 		reg = <0>;
@@ -119,6 +121,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &sound {
 	model = "samsung-a2015";
 	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default &secondary_mic_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 71b5c98458ff..65de798201eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -337,6 +337,8 @@ &mdss_dsi0 {
 	pinctrl-0 = <&mdss_default>;
 	pinctrl-1 = <&mdss_sleep>;
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,s6e88a0-ams427ap24";
 		reg = <0>;
@@ -359,6 +361,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &mpss_mem {
 	reg = <0x0 0x86800000 0x0 0x5a00000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e39743e22043..7d351cd15f90 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1634,6 +1634,8 @@ mdss_dsi0: dsi@1a98000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				status = "disabled";
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1668,6 +1670,8 @@ mdss_dsi0_phy: phy@1a98300 {
 				clocks = <&gcc GCC_MDSS_AHB_CLK>,
 					 <&xo_board>;
 				clock-names = "iface", "ref";
+
+				status = "disabled";
 			};
 		};
 

-- 
2.53.0

