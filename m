Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D460A3831
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G46ypR9+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aIFgwYd6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BC010EBAB;
	Thu, 12 Nov 2026 15:02:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367C610EB20
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:20 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACBnDmK441529
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MTTc3ZHWXywW0LYFxdTO0Y5ALKzAGNfd7iGemICb6xI=; b=G46ypR9+397JZ/tB
 QkaPHyxz7xpQVJlHgF0JvmoTk1eVKyfmP8PR9KQj822Wj7L6WTwlk+1xKwJN6rOg
 /SVpPjX26ueOXfg/U4IC3yCuOjuHx/E7Rlbq7fBFITQOYF2e7hOH2OCCTyCcuByQ
 I4GD0Rbj5MBa7eeQ0TfYL9817L+CONXFa3v4vN/FpPSmaswfUa4s0mknPzw39Dwu
 gQDQtlf7x1XDMYh2hOjxIN/5FYjdQvPo1SpoOgthoM3E7Epg+GYwNgCAxZahTyqG
 fO3z/qQ4PKTgvq1ExR8cMHvh/He3mkpXwlWI1e3KeQYv0B63oH2esFyStrnMD/B3
 lDhCsQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc1yvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac41ff334so4067861e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794495738; x=1795100538;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MTTc3ZHWXywW0LYFxdTO0Y5ALKzAGNfd7iGemICb6xI=;
 b=aIFgwYd6YV0GAOrVFLWlDVAO5bqU0XcdSLQUirqENJEmYeCekpJWaGGqOl6LEVa/f8
 15JV3Eo+kJofF0FLWaLCYJZ9/rBKd1Lr8ciPXZ9v/UOfaTcyC23MfP630fFnCRncLsMO
 jcmzU2zXbKaAKvBJpzwjt2C2W7jIF1//kuPezousUGSXXGC0JyT7t7uXk5+7NsTIEIEO
 eN8SQIPvIn0gPaqYTTVCPPeMCbGLFCuKIal8ncLDBu+oIFTYgvMFNIzF8EdsMSoUTbIL
 NSUqmSRkol0lVI70Eki+SBi1u6Zp/Xzaem4ol0nyiOa5vl8+AAm+zroiAcHwwQ8SxJOR
 /JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794495738; x=1795100538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTTc3ZHWXywW0LYFxdTO0Y5ALKzAGNfd7iGemICb6xI=;
 b=ZsL/kbJ0La28D8OqPBJVa+pPoA00NpG7JyALqsBmvHgX0Tl0ifqBmnjbCpih4koGyn
 ZZF6rCWGPHkAcJX5G+sdlz748t/Mnp4nDtWFy/c8Zm3v+XMaiYNiLNGCGMupauhiLgdW
 iaSkv1GCOu0gwc9ao10nsFMFTZ+axBucUE9zi8+bbTIzi1TfmGfLYaxnUpfFKlCx5VDR
 ckdAq/AnFj7RFxBHpWBRZa+WhW+Of6q6xcQVft9LQv91Jos2Yn6iB2SRYca9x4KZIEXN
 9fPCMF8iWGcB2ozOZMEUjZwDqZya/gqEalt3EoqRr2zoMPouQkB4ml9rPZQDqCGa7W1V
 ln4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErE/DKCEHKFJ3mJzWdsZ4BEg4/f/AsVS3NIGNf2rW6q1R/zRUW2Rz29r/mN04CAxww0SKXxQ6LVWWzU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+x2R844BTxYsJjKpfe1/3K63v4WuNjEp4B94Vuj4aDQ8X1C5oN
 shp0OHFTM8Em8V93TZ2bwC4qxAH6XDhc4E6ZV0ZcRNNPma7anCF41rfNBqclSlQ5Lcff/rQGcoH
 497Jed/hgvK7feS5W9J/yOjmJTNWp7xEH9V5QrMAYrtWbX/xkU5U74Vr0cnEn8vOOPtMjk1M=
X-Gm-Gg: AYBFou2YDARtFaQqJckYabQQNfS/B5WWumfdsPcVyepPxF/bhqoQSodyFfNXefZucFs
 LQyKa2BS9jtBXrOKJkiXdf2+Wh7hHtidkfXmsU8vtzNCehuHzLOQ+y+RAwvSEe01C+YXVHQuDTg
 QZqwdpPgB7ktjcyJEZS19jGB1E7SLF2ZL8gUZpo1T3/0j0vKNzKfzNk1FDjEmUXnH8GkN7+6kDh
 RKvrnPTEgLXeSPaC9VJOfS4+KptkPIHwYShUjg0dQ87EyeapgBudoi38RGfncODNQcNGzfmrDz/
 WT3d5gysIJEJTWt/z7icFfM7df8k5MRIZC6VzsOZTWB0glRnGzJVSAExwu0zyR24OdZNQAhD5Fh
 +KK+FWhS0zxbPndJuU1VqzsK0pHvUHzHBp3vZfiK1MVfCufK7KzmFYLlgECE76Q6rUi8eqg==
X-Received: by 2002:a05:6122:420e:b0:5cd:575f:9396 with SMTP id
 71dfb90a1353d-5ee1c410b75mr2624795e0c.12.1794495738200; 
 Thu, 12 Nov 2026 07:02:18 -0800 (PST)
X-Received: by 2002:a05:6122:420e:b0:5cd:575f:9396 with SMTP id
 71dfb90a1353d-5ee1c410b75mr2624725e0c.12.1794495737312; 
 Thu, 12 Nov 2026 07:02:17 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e354b0sm106758475e9.1.2026.11.12.07.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:02:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 16:02:02 +0100
Subject: [PATCH v3 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-display-msm-of-graph-v3-1-7fd0c06ec6df@oss.qualcomm.com>
References: <20261112-display-msm-of-graph-v3-0-7fd0c06ec6df@oss.qualcomm.com>
In-Reply-To: <20261112-display-msm-of-graph-v3-0-7fd0c06ec6df@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9dTvCk7cwJUrn/2g/CtsxuZcz130FNIV0U3EB
 3iZ0q2KzueJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavXU7wAKCRDBN2bmhouD
 1748EACOQzt3/Oebew7ZYI+TTsb2I6dA09V/GcaIzOPdYAEJYmA/eCohJbmBE8eTaCNXemkGGIU
 cZ5IhZRs472JvcL78t0uYlbMureeMB2D0NG6le7KWiOc9llvCNAaHqgC6qDusl+ocU6/YcS1p+b
 akCuWXsYK7Fb9KmTMkbWR6bFD0ELEg8+neARbHlFMtRNklDGxNHVeuQyU0l+xZCAsWGK7ulpFdC
 PBd6e5p6HiEriqvLsdr/GDM4BAfW6avMtK5c96GrjUMIzrQVu+pfKG8KRuskmUYeiQpR3UiiXlB
 Ie35h7kZ7dcMHJLkgKDb2vpHvt6iBJCPGo2HBZ17doOWavVg96aIDBYhi1LWXHNyVqYLW4GHm1P
 ejCFMIAvrFdYAYqvhhlp/7BKJKx/8pGHzu3ITsyCCtXAwYBmEGnUA73Ez/Ysk4+SyRXh66udvs3
 6+C9Hqpdxk+G1dowqYHAhFR+KDXUEdIhGMTymTvYBaBbJCpQWn8WZbJRxd4Ism3UL3hbQSElDZ3
 YcUh6f/FTTDLczZzhRJ6dgXnDgxocFV07lAnZLc+FeOjXAP6fOPes7g9PWMt2lttqxpIlUloCaQ
 lyLaRAgQod/4E1a+LbY5Zs3qpbFKRCt/7qChEQkEH14QSZSR5hp0+2jk5vVji0y1eXCVGzQ1uBF
 4SDrCj8TXDQ+vMg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: JSNtmn1vdRmblXFlquGXtLAisKvO-5fs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1OSBTYWx0ZWRfX0ZumjpKwTJgz
 IX0HWEXhxcz2YQRjk01vzkzzDSuTicAApoeLFsp/M4Vo3uHC4NhpkRHkegL5uq9JxPzvsymbtbv
 Zta+fEAkA67sniWUrh0Ojfn8n9DA41M=
X-Proofpoint-GUID: JSNtmn1vdRmblXFlquGXtLAisKvO-5fs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1OSBTYWx0ZWRfXwbalIXNSDv5C
 ZZZwd+UFajjUmgBEr3EdRGpvVRcTshvaHPSQqIYuDfk1N3nvrW1ulXT9lqLsKrok9G3AzPLUJxk
 2EKDuD37SLy9JxGJjvFrje7rssKYbmyJa9i+EnJ0iyaTY1r68GQVhGnUTzJSol3UsofsGsZjly+
 kUvdqbZVbNWHnlXWi3OoFKCYdlEwmyr5r6kvyS27Cmz4iRrKLd+HYlbg2VRyQ8tpqC4Tu6qZayM
 AaIc3NBf5dX4bZFWqsZJYpyaz/mWHa8mRv3MQP+gUDR2NiozYc+Rw33wDpKgVR/Uup5qwzOCJzW
 2/KCCvWxjeuJN205FLKIi4ah/6jBqZHh025JYPYMR3gB8OfJllIs5ZgNu1jBerS/K2BN38e4o2T
 NpotGwXy/4Ugr89XTbjmx+bemaEMYMS/BX3cqFt8ZwlEeB8GfLt97l6f3tyICQliiXskHaf5FOu
 8tC7a8Oe0MRThBmn0dw==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af5d4fb cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=31hGAD3R46fbwAJXn2oA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120059
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

