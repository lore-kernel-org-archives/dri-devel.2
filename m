Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E413CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1A410E759;
	Tue, 29 Sep 2026 04:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="flnI5f3I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aDcf7WJc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926DC10E759
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47dtH3654849
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DMXacsp6xKcjLkbRHbNvBCwqajwM5OGMeDu1MzChQgI=; b=flnI5f3I1S5fXJai
 YqVYwBeHV825KKo6HWjD+sdbpWXMj6GPEjVplPdEruNvmU1nhvGAChzS24c/Lx8o
 Cixbo6isCfir4V0wpqOI2TZMINISc7TLejvTYaW3c0f+0RTuutxv29RBkzxMkyhV
 BfC798/3rIeKvFSWizLSX0KYG+zd6f4vrl5n5SDSQGMwQ/bC/RNu9QdzxuJNghTK
 u5n1OpDrtkI4M7E1sF7t/+wPh+F9nvlKmDqg8Lx137jMIn+AQRLsjTTNl1ZlHlfo
 3ixysGkAbBJrEADKk96lJtaslzrI/K6oXiFlqiw9NQsxwmtuQkQgE6a3ceQRHZja
 dls24g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew0jse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so56872076d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790655999; x=1791260799;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DMXacsp6xKcjLkbRHbNvBCwqajwM5OGMeDu1MzChQgI=;
 b=aDcf7WJc7VMkDZI/lNl1fmak/PmOwkqPHwnXr5OPOcogSdFfXZ6nTQ636inmRqQai4
 knf4fy47pSKSUmMxuAJjqUtYNj2w570aGQ6X31O2j32F9u2Qbswemkr4FYcToXB9H4fk
 yDuXzg2kPGnW5YmbDbpUDRaeW0Ws0CBqS/DBAwCVf39t7F7HNjHlUSxYaAU5SEbSwr4x
 L0Ha00azlQCJBfOYnRikpNB/55GobjrETy91tEJSbj5vMIBrW7Vx+Ewhm8BW3Id+bKgc
 Gdm9IbRrGAhPlKDLwr6/oKepA4EDEI8l5G2l/tqxg1DqynQ1xQjyM0xJqXzzTLQ5LRL6
 jgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790655999; x=1791260799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DMXacsp6xKcjLkbRHbNvBCwqajwM5OGMeDu1MzChQgI=;
 b=L0WYNIcnvaeR/NFXYhLuLV5iGk5+7H7SrzVsHFTgRgVS8mnZPmW+/jDE40LGsJE7/B
 7/ec4wxjWyqzMxgk1m8tjG766wXOL7I4b2vRKQfeR5JFlRYCKMxBx7msH4+dTDt7RwXA
 O438MJ/23r16diflCeI8cfz74JUD9+pJR3XEIvJ25WvclI6pP6CyOwFQyK2QnLOR65xl
 xCWgmCz/+kYdkskw7lN4L0nAOrcs9mjxFCAmrYcpTRmD2w89lUJDnIky4i5MCQj3gi02
 GWJE/MQGugJYtFXHLdNU44GJzii95DeXHrsRVhKfPhDb2KlMJPz0i0dbLr+4dVcF80z5
 4jPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWP8gtzpsZ5cx88FBmpPw5YbxHqiTL89BGf/OyP4u6cENa1aIKWLPbCyj3unGAqd6VR6tLNlzDl1c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2NXXvEQwORGojeQeeYiNICSRkh4ltdKB1OxtLJ5A/nwl1Tg9A
 ayTN8+9L9d90TLgDzwPwMLXZBAlS06XjCb+e/a7P5NmDWLFjURJ5o0f6Nyk30YELyAP3pnP7g5A
 8j0XnfWQ5d5yoa3daKuB87iHIGjvkIdwHTGgerlM+iGTJO1hcUyR+Ht97kPLrEVntCAHU2mk=
X-Gm-Gg: AYBFou1wDpvKgW0oQWA17h5HEYkBUkqfCHZaE4Hlhf3XJoe0MRk7fmJZYwxtdN6SurS
 xO3pvqotU1RTFCl6S9XJMjdqzBu+q8EFTwBFAU+76vkJCxFsLSaVZ2iVaeoa8voc5UoWRROYOH3
 FTraR9hQD7vpcN1WWTZct64jEoTjePsW/YFn81Quo7SBkElq8XWnu92MAcwmm80Yf0U8cgIz7f6
 z/qJ1lzj0Gyl7klnC+nl9JXHX3W5NdSiWFj/9OL4EzDYFy/ijR1p5DnRRaHajSRVJuUGS5zEzAs
 DFlzmtq1zuaHJmD6/S2o/AZOZ3DqwwEt3KhKd9DizswmlUEoSCD9r9cZVv9s2RGD//pk/wnIhS2
 qCf5t+vZ/3CUhTuW4OOpw8HiVKwebLNUirscnZjzZ7rtp0Vk4++Yi7EBnB9qGPJc=
X-Received: by 2002:a05:6214:20e7:b0:914:3ef6:ec0d with SMTP id
 6a1803df08f44-9143ef6fce2mr215585136d6.3.1790655998150; 
 Mon, 28 Sep 2026 21:26:38 -0700 (PDT)
X-Received: by 2002:a05:6214:20e7:b0:914:3ef6:ec0d with SMTP id
 6a1803df08f44-9143ef6fce2mr215584806d6.3.1790655997685; 
 Mon, 28 Sep 2026 21:26:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:26:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:26 +0800
Subject: [PATCH v7 02/35] drm/msm/dp: Pass panel to
 msm_dp_ctrl_config_msa()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-2-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=2554;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=rv+xhdZurP91oD31/maRc5wjQBgxGuj7o6Ogyz9jhxw=;
 b=9ytQUflWuqFjIci5NMCP+NYpYMSvH/nMYIMmzuoruz7yxejS3rG8oCsVR7G31NznaOhVP/wBg
 aljMx2tdOSmDQkKYGZWyaJXe2xmW1SgiJbodbrjOjJ2+N+yf1r5YV9p
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/5apqGUIt8cN
 I2roQo0sJEDFRjB7CleDI236xBkAMVCJRYkp9NC3XzE0elYsQ/S5Icxu7PTM6HZ9vIptC9QQqj6
 KXvEZ176dhg+/52RnjMARrMJwVBJfXw=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abb3dff cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=S9XaUHPIOYaisIUHpVsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXyR/zCwy7HewV
 yWiRiAoywMxCixgv4AcSn/dPZqfB/cl1w+OAVB5ndQCWQL7WB5iFePV2PqlYpwgktxe33LrTcEb
 N5z0Mgcwn6mELb0AlojsyscQGG7c4fc6dQiBLQKLtzkajOMWOtzezckVPDOWh3gNSQbK97bcVCi
 FEm52Gpj4Lzv99ynKol1IOAuMobHRhqfWt3XiBKigwrmnzOyiq6KLP3XukjktJj5uYogq/xmzAt
 9kxAfn6cgWyxuYGrawKfJpoT+kQcGRbM/x7HlhMc3j2ZWO/m6N1BDAylqPfc4iUMffD396WroYb
 5Z/p23xLL4JlR0M8kgRcWxBss1e6RVzvutnNQazauJEE9fgBXWOvK311bxkvo/6o+08/OjwTrQB
 a0gIadiXYrgMwlnqdpdxPcwF4W65Vt8KoanBx4mUK/bfjGW0R+q+gfMAUtv1oW5buLmbwMY4G+e
 BGreBuSDVWebfjLY4gQ==
X-Proofpoint-GUID: qp-Wa8Y7MSa-LtBxDM4I6yW5mGB-wY1i
X-Proofpoint-ORIG-GUID: qp-Wa8Y7MSa-LtBxDM4I6yW5mGB-wY1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

MST requires the stream ID to select the SOFTWARE_MVID/NVID registers,
but msm_dp_ctrl_config_msa() currently has no access to it.

Pass panel to the function and derive the pixel clock and pixel format
from panel->msm_dp_mode, preparing for MST register programming.

No functional change.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 59070f399e2d..1ed713b957c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2463,14 +2463,14 @@ static int msm_dp_ctrl_link_retrain(struct msm_dp_ctrl_private *ctrl,
 }
 
 static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
-			       u32 rate, u32 stream_rate_khz,
-			       bool is_ycbcr_420)
+				   struct msm_dp_panel *panel, u32 rate)
 {
 	u32 pixel_m, pixel_n;
 	u32 mvid, nvid, pixel_div, dispcc_input_rate;
 	u32 const nvid_fixed = DP_LINK_CONSTANT_N_VALUE;
 	u32 const link_rate_hbr2 = 540000;
 	u32 const link_rate_hbr3 = 810000;
+	u32 stream_rate_khz = panel->msm_dp_mode.drm_mode.clock;
 	unsigned long den, num;
 
 	switch (rate) {
@@ -2516,7 +2516,7 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 		nvid = temp;
 	}
 
-	if (is_ycbcr_420)
+	if (panel->msm_dp_mode.out_fmt_is_yuv_420)
 		mvid /= 2;
 
 	if (link_rate_hbr2 == rate)
@@ -2573,15 +2573,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	bool mainlink_ready = false;
 	struct msm_dp_ctrl_private *ctrl;
 	unsigned long pixel_rate;
-	unsigned long pixel_rate_orig;
 
 	if (!msm_dp_ctrl)
 		return -EINVAL;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
-	pixel_rate = pixel_rate_orig;
+	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 
 	if (msm_dp_ctrl->wide_bus_en || panel->msm_dp_mode.out_fmt_is_yuv_420)
 		pixel_rate >>= 1;
@@ -2604,10 +2602,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
-	msm_dp_ctrl_config_msa(ctrl,
-		ctrl->link->link_params.rate,
-		pixel_rate_orig,
-		panel->msm_dp_mode.out_fmt_is_yuv_420);
+	msm_dp_ctrl_config_msa(ctrl, panel,
+		ctrl->link->link_params.rate);
 
 	msm_dp_panel_clear_dsc_dto(panel);
 

-- 
2.43.0

