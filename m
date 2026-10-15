Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D29CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E540112278;
	Thu, 15 Oct 2026 09:55:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DF3112282
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jVuw2416893
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=; b=izHdMitJr+EIvVx0
 PV+EjMSGVRW75TskDMqhHW75uL40KhnWkW5SfQumy0zoXJbx3pIXEF4gxdpVNA7v
 GYc86gUwhSTVihiMOIKpDFCKRWGfSKVUH9fQlCjIeSoCltLqhVREauGaM8HKjGTp
 RYZ2Wt8lXtNmH+UDav3KWfz6XV+e+LnKjkQ+wBfJO9Rs1eWnRU5mEFPFltmv8rRG
 BIOjGF9iCi4DjvSWG+i/AFDg3Yue43rOQYMENumrW2bFZIwwITaS3/t0tp5LCaCG
 rH0k/NU6drmGi+jI+rOLGBf9UllB0Mpzdb2lFO74Prn59xrpFol7XQDcdOvDhpqy
 CV+uLg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhhfp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so2010664a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792058125; x=1792662925;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=;
 b=dQDIO7vgtzG48nXh97co0vsSXwK9j6/RudZfu8sEn9OrEZLCsNQHKuShMX+xhMn4Ce
 q4DXLXzO8S2/Ccypgws3a8vEeAjV/nFaRC6ygbAD5rfi5yLi+2YWQD98qINf+fJkAGrq
 Xe7ORaE1nj2az+tVSXNXNuPaNGFIicOLr25Xf+91q+mmaHepz1o158fIGftBhGrcI/eU
 T0jyXirw2ys4kfq9qEnPaKdg8jkOjJ6N5OdQHRPxx1wKsPehsWkkKfY+aSzpDmlGhGRZ
 QTMFWD0lZtYcMYiOCxCxUnZ+0MdLA60gD1IxLlzSu3n3V8G59ZgB1Uk5lM4EPlUZpluN
 Hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058125; x=1792662925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=;
 b=fei5rzD8t3GrR4zZr8i1Iy8/sCpu4xL3HPm18UZSiAp58Q6IDl0UmOstlbg3aabYSQ
 cVkZKRJOrFprkGmMw/p9gKujHqCEW+IX4QMBDjxA611vX8wpXK1ZabDc5XkICstLWFvf
 Ykv3N/fVmG+71gS6T27DgdRxqSBIiEZLpxtYDLC7irMxlLaJAuCsAqYRvrprBGFByreR
 /MrCiGkHHsRNuGqR0QZ+jwo9bgD+HWbEyJdPCPyIBjBEIyCrQ5xVT24o8PTfamx7k6ZS
 HCYaVQrYC1wYEVSuA/eUnBRGdH0MJNdJWowCTomDVHIHR+jsFuXKQvz8A7p1ZPW3x6iX
 R9MQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmd+IFzcXgvilhQtIWpD28n4CLXdPh1SM737MSKJ4HC4XgBSg4bFl9NfY3UYK5XhedPpBzBNJFgyk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLknygRgD0+EDKhxvMwY6rhgOSvN1fvp8vyZk5hs3TilatzsJfF
 di5WaXPWuQSVz8W9U3mzkr2neGTmpM5WIPD+kTbMhlGjGbB9cidtS+9deMPkm9YH7muWTmvYlxN
 7fmZ3sNP5awKA15UM/YzPJxLdDSM3e9OUEbl6sRo4wDEF04YeAn+IB+Pfr9q2nhlYqS32jTs=
X-Gm-Gg: AYBFou07SdAICAu9x46raoTlacTWcz+rAaNb/sk740vzgKTK9OOML6t13gVgqcbFDks
 LuoC0K/8ZvvStanE41b2ch7p3Fg5ctMILLKnjfDQLzJRT1vbYKq+8O6kPZh4jsUgyIoNPcYuxoS
 Srip9ocKkYu2StLkTUWwg2/cLx6zlGQYEX7T/oDhT0ZR60DosulmTGQeq59xG/xWCfS2sSomWSU
 ijqAUTYoBEluIKwoTsCg1+QnwH9cwL5S9no4zl2rP46IuhP3BLwuSYAumBainEdx0Ws3iTgVmEG
 Djm4J8s3/vOEz9oUO8cOGXfggmCHOA4A8Af4JMPlRgGtnSmDdMjXrXzYMZUIytQMIKjmy+MEsqx
 731zgndJmp1AwaTIR3kchlcZTxWyKVqb8fPSU
X-Received: by 2002:a17:90b:4b82:b0:3ac:95d7:2fa5 with SMTP id
 98e67ed59e1d1-3ac95d73294mr2101674a91.44.1792058124620; 
 Thu, 15 Oct 2026 02:55:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4b82:b0:3ac:95d7:2fa5 with SMTP id
 98e67ed59e1d1-3ac95d73294mr2101652a91.44.1792058124192; 
 Thu, 15 Oct 2026 02:55:24 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e1a11sm3612322a91.7.2026.10.15.02.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:55:23 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:24:33 +0530
Subject: [PATCH v2 2/5] drm/msm/dp: Add DisplayPort controller for
 Kaanapali
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-kaanapali_dp-v2-2-c15cb83d9140@oss.qualcomm.com>
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792058098; l=1543;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=ATHzw5/SdPmSlyNoH0Ua5Hf2It3tpnIynG+5Y/cT+DI=;
 b=YGp6zXS+wBzvJdnS9MQVlBt8BFQejgUvDgEhmw7g27ZvToYAfyKWFShxOJybCzNl8VdhDYpPN
 sxmttc5wyYzC1TwmFRGZ5qbn1mrYoCunbzY4JXFTAswOUtR3cFGLGPj
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX9JC/WNBnr5D4
 TUlOZMeuQbcaWP6a0vzCSmnR10ltFZD4CxHKLZEw0MYDtChCj5bcRrpQ3opOJBSNMyagM1zKSWy
 yorkRGNU/r51Kf3aq9is4JnpPx7RNGaqMLkYHB4jt7AK1zn7ef+L26xWamk4Srp8umXfUiRnJ76
 SKAuPdY7kVmD/e/pS9pU7OsoiC4Qm1+I35xVSYsSg7gWrc11tuDhU6H52bfeITg2sYjaYUbtDDb
 iolDEB+D2586Jhb6iVBvx4ZdZSR+XLrlyo5zexaYeUCbeUYLlRwZvFAfwpuof2Ao/S2ZMuklH27
 c/PPI0oHaQMwvtb1ReNnRKhYVW1bOJnVrheovVpyN47wotwv+aoYIicNzECh1P3Lkws1R08Cmnf
 u6mSf0XihfqjZ3h4aU2H06NxReA+FBOcscjJDmJ4nEKFLcHqFbGc3fhj/2Re5xgnK7lRnGAozm8
 +U/K7jLG2rx8akqmyTw==
X-Proofpoint-GUID: vNA06-_y9yspMOhq_WP-dcWW302w1fqo
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0a30d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-Dt519yxSYS-YsuSjdkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfXyoW2nbwCWwcE
 1+mJ8F217N5WAomBVeG+Et8AK+GYJg0N7YPEnpvdQSeY//jZPMRp79rB7x9HW1vQusifsCAH62V
 E/ggrDwwVvMFWEO8GWOUIjSYliD8eIA=
X-Proofpoint-ORIG-GUID: vNA06-_y9yspMOhq_WP-dcWW302w1fqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150039
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

The Qualcomm Kaanapali platform comes with a DisplayPort controller
with a different base offset than the previous SM8650 SoC, add support
for this in the DisplayPort driver.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9299ce616fdb..348eb6967abf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -158,6 +158,11 @@ static const struct msm_dp_desc msm_dp_desc_sm8650[] = {
 	{}
 };
 
+static const struct msm_dp_desc msm_dp_desc_kaanapali[] = {
+	{ .io_start = 0x09ad2000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{}
+};
+
 static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
@@ -168,6 +173,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 
 static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,glymur-dp", .data = &msm_dp_desc_glymur },
+	{ .compatible = "qcom,kaanapali-dp", .data = &msm_dp_desc_kaanapali },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1

