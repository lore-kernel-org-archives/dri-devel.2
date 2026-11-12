Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EC60A5BE7
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZfflmosK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hL70VxnK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2EE10EBA8;
	Thu, 12 Nov 2026 15:02:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838F110EB60
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACAfJP41953702
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T9jAmjlpPJzKEesHQGiR1/l1Z0EuOSLOuEzosz2QsKs=; b=ZfflmosKG2Xs7tFf
 pJMyx5GvhcxNkwfpWvgSZP4Bd2uL9DJRO6NfdatdYCiSxL3NaguJN617x1ymuD3H
 4fXWZQi6HLKnI8teXiYWQpQ+IxwrA2mWfiBFgt72wRQ6BjsvSP6m8Hn72FKrfq0F
 zFTjLTuJrnTEhKRhIEGHJB8ducqa3QdUDkKoUfFET85fkdVqcvyHHDeVyZLc+O3c
 QNa/JHDhDN9c53ZHPLJTMJEKL118pnsWhRaDMjB3xlUTdgwz67ljCKfjFo+ReLCI
 HWl2MxDBvntgJtA+mzOxNuYZf4PnrHdN82teZNfPK2lokWaIp+UjAhyzjnhwXXSr
 TaIF9g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx30w4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:02:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-537548d4bc0so103105321cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794495754; x=1795100554;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T9jAmjlpPJzKEesHQGiR1/l1Z0EuOSLOuEzosz2QsKs=;
 b=hL70VxnKMFhr3AhEi7NTs7nBlu45Thjv+6Oeh0DmNRPX6cUBHWBJAQGRopeOqk5pJW
 ta9wLCPIOotZ394lJbWHj2U8OGKwl1c9B9zyyZ19ubCYMm1QOH6h7hIFmctnGI+MyC7j
 f120cWmr+4pC/rg4K66ZbkONT8HXL+1tvBTMSqA6XcgsnN+ivmzMGJqYbhU/8O5OimGe
 ueNwmEwnzMGk3nsL0XbbsUIQ6450Cgv+8jWF7MqFWSgZPkAxiPS36jHq+VZK9x+lk0BS
 6KZvtpo3h6sPrSOfji2rNRwdpwR3E7nhWWzffUI4Mv9aVsVklo/ijBjp5Zt2AudA2lYO
 yPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794495754; x=1795100554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T9jAmjlpPJzKEesHQGiR1/l1Z0EuOSLOuEzosz2QsKs=;
 b=OwTTtBFA0nvYiV2HzfOR+6jm2UJ7GJvOY/6/3j59TkLYeuLdnbyveh6nfOZD39p9s5
 7JwAXAlH2nmLEHoS+Z/l5gz1JlJHeFTip/ucX3ozu4UFuUqZla15hBJqSHGIxj8kZkgl
 ZbYVv66Hn3KsDu7PYnhcrBtwslcEI+bEWOV74uXqgX0C8Sl9lLaicnfA1ChyAlfn3G0z
 1atKgnOWF9lV7nSWA1EJHnqig9usHmyWy/Pyyq2kcW91QyvFpumt5RsPOgf6IXUWEMMH
 JP4zmEHJUIiyFPNI+EohB4WKB9DfZXdYoZuD1uJb5HuXCVdwI8QtYMNugI68JL8XKiz3
 /kwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHF/qStLBwO4gWLUOYCXoqXbrkwBKN0/xI6we207okdIr/L5LJNVSQSJJ+aLCg0e1P6PThxZz8ISEU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8iknVYXVmwU9wawGxQDhJ3hhEm0TDEdTYdN41ZH2msrrDaSvYX
 n9us+64mkIuHLud1i9j09abH8ZwD8OQLAd6Oq8UNmGcCswB1oYcHbhzSWHbawa2uxmf2O7LHxjH
 7n856/VvX1nwqTSyU6IQUFtgi7cFHzzy4kMdRFWtJ/1Gj/zcNwvS/81+h81v1Q7yobHvxUehx6J
 osIf4=
X-Gm-Gg: AYBFou3Q+QBWqrVJ4A2HAgC9gQ/FaJGJura2ZgN7hw9+hhSmb+x2xxzhqGCjRJTRMdd
 Rq00dGetshSA4pLELuFQ6XK24uvXUDcy/p0AoTlaW+hM2H5dpEzHPSZQCOS4zLHbEhuzHokK6sy
 RX5t6G5uC4Af5ygXORtNFiDRzJw/o8BuN5wxi6JhtceI1nVYz7eVzWctJ++kNJROLD3T3770I8i
 XpsW8cfdOkUT0qTQsefjYNdIFlJh6jI8hJ1SSR+I2rlKk7zocdDSeI2w5prb9zTBI1GbNsRlTfu
 dAC9R8NShiRTF3z0YgpJxf/Psg4kdiolxY82d7nqnZl5NmSmYEVSj3O1GiI6qonWg/s8i/T1JNT
 0jKMo1IA4Yg3RkC09Xh3E1sks1NYgHEQxrm9meO8eITRXVqXdXFbYzZSi5wJLerNFdImpqA==
X-Received: by 2002:a05:622a:2305:b0:535:14f9:3efc with SMTP id
 d75a77b69052e-556c1195ef8mr83529711cf.53.1794495753825; 
 Thu, 12 Nov 2026 07:02:33 -0800 (PST)
X-Received: by 2002:a05:6122:4d86:b0:5ec:d5e1:ee2b with SMTP id
 71dfb90a1353d-5ee1c4bb798mr2491992e0c.23.1794495741371; 
 Thu, 12 Nov 2026 07:02:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e354b0sm106758475e9.1.2026.11.12.07.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:02:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 16:02:03 +0100
Subject: [PATCH v3 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-display-msm-of-graph-v3-2-7fd0c06ec6df@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GCFRCKJTBF0tDduwhG+AEpuoFlapsyUUwKoJTS/2B/I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9dTw/N/EMo0/73D9HuBKXPhSALwVSdxATrsmZ
 oewOiIsNX2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavXU8AAKCRDBN2bmhouD
 18UKD/4woiD/Ev4qypVFuqNMNuCXZI3SbvQm8sS+F7CsHrUisNE6AZhRIMiocqt/yfQk/Nn/dR1
 tCdQWwuZujVtx3NiSUczQKSVReKIAz/t1UomCrIvzO5o80YD5OYawjUF5d08u/ofOHOyEYaKavd
 5M7af9hvn/PnVzs1wQjrAw2ZmjQmZu7HFW069FaRPwm7bc5+GMMHRP/tIqdhMnSRunCywgkILLI
 BZ+sfDa/6ViK0ERYBB3+UqLrlFu6bQT2fHMmwmGcg/e347wUOefYaH4NGNgPvvD6MqrsM3UHeiE
 czB/RIqnkqPRTEKTB8lV2Kl4UaepC3biqwLLr+Yvl31sv70NNUzWzqR8+Vrg94vDAqa6Jyz+tR1
 AZSWWEI2WW0h/9VJKRTDhTa18+Fobtx2Ge26+eAH0eBO16H/Krh37iquAq05kl0Bt34XSVBRxq+
 cj3wsb4brSj/+95kezwUR6wGW94e5s36oX9k7eGDSOBePFTXDGwLgRGBBInRUuSXre96KZxs+HT
 vLDuzJ8hJSsSqjgKwKXbbSw0bbO/oza4PGLS1UpNYVpyVGWeYfh+lEKBhDl4xndtjKhtQpBW+zy
 5FEBS+UsVh2s84doqXzZZjrrCdVA3AK/mNHmyr7jcK5X48KVjOjG4bT6LtNSIZtSBHSM8RXNYsG
 lKvDey+8vtsG+RA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af5d50a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=eMlgcxtRJz0w_Lr9rQYA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1OSBTYWx0ZWRfX1maNGAmC9idV
 JhIcCtNqH4LLZ356+kh14uF6UXyt13DQjfgCouIiY2usOZKVapNaXu/0qlyDVlNMRD2GZiidRXa
 rD/33CAloH48rLmH1kvEgz/3UhsFPX6vLGlTNvAKyP3s1Fx30vJ9jjnaGQJ+S4Ql7nDT0xg0iUL
 Y5nczmWuEJpLdbrxRJb1wm6BhaY7KbWxH6p1VpX+mucIsBX7kE5jwLN7Ypm3oO/gJlD9g+X2Ort
 VTvF+EDusdu/TrgdeQPuNRPu4FzhiFeiaVO4Wz3sn9RfRLRqbULn+zzDnE0eldUPvRK9Ek1lONQ
 4U/ueXubrC+mVs7Ba5TAonJ/cvI72+cTPIwHg5NYoWb7dpDWi1tEP7FTyRWgCaS/UoM7YmwtouU
 H7XT7tt+9J7MdwgYnNBRRdSupPEqL9ZNQpPa4WVKm/Xk9tgDn4mHB6ZAGFsQTVApIKhIgi3yvVi
 Eo7eYLKB+c8JGr8W7vg==
X-Proofpoint-ORIG-GUID: VwsueV2iwWsA29K_D6SK2wHfRdM4cVmP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1OSBTYWx0ZWRfX10Wzed+MDG8U
 jOjlhfVD6oWVzYvXeTCe3zzDfybth3eCBzhPi/QBrC3HmLV2VIZKlxEdX/IrXtug37vmji53iRA
 i/NPD93PFxUcpCPdIbBmDDmEqOc5yaM=
X-Proofpoint-GUID: VwsueV2iwWsA29K_D6SK2wHfRdM4cVmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
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

MDSS DSI and DSI PHY are useless, when nothing is attached (no panel
description in DTS), thus should be disabled in DTS: no bridge will be
registered and no component device will be bound.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

