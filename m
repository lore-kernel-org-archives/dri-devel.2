Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421CE606BFFB
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CcB1LBv5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PxL2nrLO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9114810F6A1;
	Tue, 10 Nov 2026 12:58:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0891010F695
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AABA1ik4186703
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AzcliHKDzNbrtR2+aqjMuMfRJkAoAlftzpPdnW0OI7c=; b=CcB1LBv5G+l5MAfw
 q+TpecImJGu5GNasjDxdz+XIDZav+B86I2g6vRX3wRRh3qk75s93OuLrm5LD1wHp
 PAn3f/qwEyfuUG5pOxJ2KQoE834L8MlmNEJSCFGA69/ugPgRPsd+d2IEZBBo+uM9
 kv0a7TLH8i0CJh/eiaGaZ4CpzFVaOAgACnYlJRLQzxBWZ2XkaEMd0BII7g1EuGYr
 6O44E/MdiKdMqkWHf8G+kXNjuZ23cBhxCnFYBkQneQxIKILY8G1vJpW3eo2yYo99
 irWWdrmrVGzZCjB6iehyzzToyZE6PzDuLB4LFaJYI/KHft8xK/HylXvYVJx7HWKJ
 DaY68A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwgvgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:06 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d304016194so488728137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794315485; x=1794920285;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AzcliHKDzNbrtR2+aqjMuMfRJkAoAlftzpPdnW0OI7c=;
 b=PxL2nrLOAIUE8z3bpdteKqO9NfPM96/jPe2Zl+0VF5S2PUeJrw/C9K9fXaRAbCTj2x
 YvlJuPQGOrIlihxTXF61mumIKJJHJjJLRTHv0Vg6rKsPW+3UIpiOgcWtQPYQRkoEsPPq
 hDxxCaArGqvfb8G3YyNO4/YhDnhcQ28v8gsBOBDNUGUvg+SMTXvCxmELCzfcv+PnccC2
 AdeEi7EQ1wmSi4K0vGJE76shObkk1RmzvHpQISQBnzKg0aABkHDW5aIHHhUH5zE7Yc6Q
 I3xpbZ7nEvLnyOQc6iPCptRXrKoMhggqCAQj7u1LB4WClNSl+/P9EEa0KrIskecxJma1
 DfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315485; x=1794920285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AzcliHKDzNbrtR2+aqjMuMfRJkAoAlftzpPdnW0OI7c=;
 b=Dvlj6MjpSQFgKsODwkY+ZEnKhjMrqot0KbPiIDp2vo9q2UxJaQedZRCfancOG+jfwJ
 oLmn7+xZXJC3FxbKqe7Cklbx3HLUJr5a6g6pYcUFfsEcfhK0jLeHSlY5NabMThcV8jKR
 BMqsurWSJ+0Lw3O8s3m3f9WYnMxAC5fOvqFBCXW289kI7U60syES63RyHpybENieuq2n
 iT7OUx8bEQ2Y1r2S4vYNhcx4vJdg30/FzyhIX91cQio4mdJs9sNguIb87aEBH7HMZi20
 rzRPaW33hOdrdn2+FZ3pcNiQciN7hlAUo67s/3Gdod/iM++a9ECRXlwgus+VCuBdFPkb
 xqew==
X-Forwarded-Encrypted: i=1;
 AL+hErHOVNZKKW9KsvX7an54Xoxfk1JAZ0Rt4ycrTpdf1XGX1O+176xNNYoByqveLiY7D94yMthfnoQq8oc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ODnKujGrK7b53JXNYo6aRShVk3UzZGnyDswPVUzNtgssl8lXM
 52EhUW8VEHWT3wqd3Y/n98jDF7oNGKix5XrGK95UvHARQ8hSzlSOPPCGhOn6rEKt4l8fORsBPJO
 mDVciF/IgWKNB/78IOpIG4AdS7ZZon92nSmFCvHmmlKt6qy/5QGEJV4KCuuatCwYVJeXN5QnaP8
 4asCo=
X-Gm-Gg: AYBFou1BYotjnZM8csy4OHfxn9TgVyTy+aXzj5IaatrgP6k1O5TZpt4N+psJTy8ESn5
 3K0rVjbaTgNY5ampgTCmE5DEwkJW6Vd6aYuzD/f8kWqAQk2a3hpVvDfbskO3ihxicc6WsFLQGxn
 4jLjTUmGt4bxm2Fi00I4IUHAUwClwbvY5ryeoF/FxDTJljnPo6i5uagsH9QhrVTa7NAzftfZ2I7
 RTzZmDKw6WQFHWRKQhbd4F21461Dhi69U2wUZyfMLROKtu5tpMwyVdeI1dBN8/YKYZxxb6Dxugg
 a/yq3UR7r2itGqaGXGPC/l3oSFGYCD+RFOW851ApRtCCX25oXz60Fmph4mGQ3w0lp8RZbMojErq
 8oneMi0fZ6endDW4QBKpzQf/7EbOCTlz1zmpwbEiCgNvT2uuQbGvmHls77hOCjimgXcX6Hg==
X-Received: by 2002:a05:6102:915:b0:7a1:f951:664f with SMTP id
 ada2fe7eead31-7d301bdfa5bmr834044137.22.1794315485341; 
 Tue, 10 Nov 2026 04:58:05 -0800 (PST)
X-Received: by 2002:a05:6102:915:b0:7a1:f951:664f with SMTP id
 ada2fe7eead31-7d301bdfa5bmr834019137.22.1794315484935; 
 Tue, 10 Nov 2026 04:58:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fba35csm58422365e9.1.2026.11.10.04.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:58:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 13:57:43 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-display-msm-of-graph-v1-2-0f3106f817b4@oss.qualcomm.com>
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
In-Reply-To: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=D5av+PWWr7DMo5sE203U9vXSqukOBl+F00tdjikV/h0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq8xTRpwMuCjyThiy1odPrxCMys0R3dS2sE/gBP
 ZFDr8w3BoiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavMU0QAKCRDBN2bmhouD
 1yJNEACVtaSDPqMhEv7yentDe58yPeWz/IcrptxIAhq3laWsRyCw+ahmya62LZ1nWpWKhpRknBM
 nOivFYCL9bCHBbflYIaFwwhQHWXtKL8536UG9nKzI//DhKqnHeDJ0CwAwD60b4b+agORXyQd+9D
 Q4MizsuPdWUjGrefM0vZ17mvtZvEeGniNn3aiDl80laPvRjXxKiqIWENGZrtP5LOcQ3o3TUnazm
 M6OIaIktNqBZkS6j4ySIH9K8P3+lZeqHaFiYgaC6wd90rWCBwWvHhe2o16qua+yJ8h55yOPnAay
 xL4wm9VImMerYCGLjLi8Zw2ZrB/bRmhXLWQkpnQRaBj5pcgU7yNRz/PXtHnPtrU/1NOURmnkU1j
 tIY26ctL51qIoq6fg5rtKmXMhnvTcPNi2VbUVVjTiC/MwEfQI+A+KgwwpcM9+yRCHfW5MDCyRV8
 6ibOGVB5JNvBFYoG6xFzhEhCa6vbGY7D0DtA4hhUw7emiRzcReWNYH32jLjsSkOdoXH0tUueox9
 n5vvjpJgYhKNnMFAJDQHFO1nBRtyf/FUgKVX12hb314gTMlQzkf39zOye5w+23h4Z9JlZKga/df
 vxsuOTQYoF3F4F2EZCBHCfViblGvzZx78t/f4dGlRggZZx+1X9dSK6vqHT6KwTyksQrxvevrzeY
 nkg/HNv2RAfMKOA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: Dxwn6rYIcW_Nw6WjJJz74O1oC1Bjl0CW
X-Proofpoint-ORIG-GUID: Dxwn6rYIcW_Nw6WjJJz74O1oC1Bjl0CW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfXyP9fzpMjKfWP
 NdKWaoAB0ak2o3CHyo4rWNlUcFM/kr8645a7Dx+KjT6dYXb0/WgDzI0jxdNX5oJt1Tb2rb45OIU
 ffPrLhnpuiGmybASaWASuUCF5b0HOig=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af314de cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Jz4vbV5A2nIxJx3xYRsA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfX5oI1D5n/9Aam
 rj1fXegGsEbwanJ6YMEbLwoKk5ut1xSmM/+uup1YNjRuemAG/QBUqJy2YHUE7cr64CWkoU6RNeN
 f7c74CizyAMH4l2gtSkQbWXST3z1hinXxUm64Ww58AaTuq+Oap0+FiMS/8nooqPnnoCwruxhigi
 5pZnwZeiNyeIrpC709X/dUt8PcSCryf5oeZ4dpKVKKLb6vVpUW4rLuCSDBQvMdE1+S4LTcBBrqb
 76jQXGMOcr3RUfWgGv9GX+N/0NqyBoiIlvmtxFolZoMrGdpFfm2algClJyRZIrlKcGYiJWYGIub
 /XnW/9FehteddkmYyq/Aud+pi6e6G0nUwStOwS7I+yO0kOYMgUZjnuORTzzye0gif5qy3YLDOO7
 wOMQaC+v5+NVoRA0Op51X8KuqkEz837GB6RjrlTK/6086TZ0UPNNrZD5XWYwLWXh+TJKSK+LTe8
 Hsna788B/D/nKYozHPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100051
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

