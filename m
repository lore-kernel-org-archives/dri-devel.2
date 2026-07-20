Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599CC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04FD10E685;
	Mon, 20 Jul 2026 06:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AD43UzGj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mkm9j5rO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F9F10E694
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNsOMs1020261
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3OofKccDOfFyW3ueerbx6UEZtUXR33ycNT1Iao2glmA=; b=AD43UzGj69Gs39pH
 Q/4R1a3CFwZV1I4Q7l1wrTZVgGGLUGrca3C3rCH3z/RLrFm5gQMrs90Q8L6ocVYH
 XenjEjbeoSHgacL+UR9pUN7G6/uOWSFr+MqKX7yZMQtOEnull7KeqPE/9bSLbo4/
 zBqi5QoM8TQuEUht66yKt6C0W2Y81oUhFVirvut7eapUvYUn9iYIJ1HkdnSYJVnj
 P1qyeMRdi04q1mDm0+JYxRmElW4/1s92U9AuAAsUKkLvo8O5gyvVpy7if1N0H4LS
 5bgl+fhXCB4aSHRM4Yl3V1y1B57/BTyP8WcUIyACWKRuFVdhoG7JoHpSEF6oycx4
 cO36mA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d94msm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-907a1e04111so7817426d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527870; x=1785132670;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3OofKccDOfFyW3ueerbx6UEZtUXR33ycNT1Iao2glmA=;
 b=Mkm9j5rOD9Qzzg4un5SP1FRMI6SDgmxB2AeiuFPmM1Mxaqh0Kvvt0EgkC+zcfTc6SM
 lN2KlJ5JNHeojpSlfdM2hkgj2psBNlH/E/OTxLq3uz9cnIxYUfKStWVrZ8Z2k8qEMpy6
 eE+RroLZizRY/8fPngYIa9WmxlVBBqihJMJ71MyiSDpy3czQYiQ568V5BC60sOkB9uBm
 9B9cmtLlv42/P9vbjWoLZoTX5kvFhKHzVRMEApERyKnGcgQ8BRy9rdxTF1t3LRwIylXw
 UwCv/J/n2txdLvkBeWU1vjCgnRNty3BCwy+XQybS1kY1e52BqmczE6j0IgHe0MmxQAet
 0DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527870; x=1785132670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3OofKccDOfFyW3ueerbx6UEZtUXR33ycNT1Iao2glmA=;
 b=FJA3XL3tzBLMquvhKPy7OWwCXwgheuALy1hQYNIp3GATIbzHVqUQ0URVPkIz44tWrh
 czjkAKRB0UlqyhFuZ4ljOxEPhI3is6yZAkFyNHrUtYDlJiNPS215KOC64+wno/ZeT8/I
 uEKD/BwiCRo62rnu0arKxPiJNxXs5uscVp5I47Bg6XusxYyQ0ubX33eIRguiJRbY5muv
 n1jgMzgIvOhnGcbk3vHwt2sMPtGbCWmQ83Ze4sGUaD01XvuK2kqI/1pjlTCvWq+4HcPY
 bMXUZMNkg6OzwB27FE9ocOkczyFwIAfcjOpkVc1dyZ+Qn9afHieEJxzeeoaJCMpM/JhA
 gkFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaqnsD3/yLGvRdP+RyeD+/gUPI+g9rdtNGS+Yv2ivumaJbs+jH/k+BAcHIoofC2MEF5FfC4zc+XnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykNngf54johSxJxBTAkfTC5pZig7eajHwfvx1Bb2OJjlLXHreg
 px8tPb9+8EU16I0mST5zASe+DBAwAwTpCQIjMXSpuzKIVk780jQskl6ipTgoxbYydoDIcT9m0tp
 ghmd947zThSvl789Uli7yOGTlJl/CY7+XvKDPp4wHQT2H63t5w3txzoKwpNQp+p83Q2MP3Jc=
X-Gm-Gg: AfdE7cl7mb80uIB0ogJMvpSabz9LFAYEuhIy11egtKldWZc02n82OYNMeOv/WdYn8yx
 UBojaRMIHQzlPykomjQChhVSae+37z0i00bhf+5NotedECS10TuzO4pCrLzOnYgkn4EfOXXZqwV
 +WxZPB9TTqR7So2Y0zubFT8RzXLqqrU+krw5KWhv5fISnjdfB7zN2i7CeaCreaPfQv5NO/SreIq
 ujVYmsJJhRlos0aMTrwghwdLjVTATkaJ4Sx4gzb22f9FjxwB1HlNy9Nsw9OU9Aej1bCUgyVUDw9
 y+gWdV2YC8gZXX9lz/XdWP4xEbWPCKYygAdqFbQpb+3L+oEEI3WPtR75qhRqQyR8vwk+dcqQ4oA
 S3Y/cYfuLT7FVkY5H+tVPPfkShccrM+dMwG4Wyj8gRaRz/+p6yG3uOdrF0ASzR/Y=
X-Received: by 2002:a05:6214:3187:b0:8f2:940e:2406 with SMTP id
 6a1803df08f44-907783158c5mr138345726d6.2.1784527870032; 
 Sun, 19 Jul 2026 23:11:10 -0700 (PDT)
X-Received: by 2002:a05:6214:3187:b0:8f2:940e:2406 with SMTP id
 6a1803df08f44-907783158c5mr138345466d6.2.1784527869582; 
 Sun, 19 Jul 2026 23:11:09 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:09 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:12 +0800
Subject: [PATCH v8 05/15] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-5-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=2097;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=R/GB05yyZIVJSF623F+XRMd/F5oMOH1NofUwHQWiW7Y=;
 b=5REHOKLxPl4zuFV38phXa38fjt5YIzJk25ngOao5sGx791Ok9TUfnUaf/Qpx2KufujiAnvucT
 sExTXxSTfbiBxt4Z2Am6vbPRXSIg48KuzXhoGEs2jkWR3qvzS3x0rxl
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5dbbff cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TC1OlXllJ9dbkp4NpB8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: C5UZ-wymIe05Y6EsLLxhsDFKpnOtFPU0
X-Proofpoint-ORIG-GUID: C5UZ-wymIe05Y6EsLLxhsDFKpnOtFPU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX+4GCEqFz/IS4
 u0GIqh4aGtdNRkFwmjIVKk+FTuu0/8hJJHG1Nx8J/QNDsYdWI/XjqlH3XeRtx3SeO/yqwNeBWjt
 67aBoKqssaGyIhYNlqsEzCdjJgBKjjNSslTPreY8RsR+1steygb3q/G576VvaBPT0Qy45PgPua7
 jCeSTKfkH9ocmKY1zYcaI2vRduux8qj7hIkhCiKNK0x+70RLFuJnaLmrRz3YpOV3WazJgbff5at
 vkf/NKj4JIpyd0VHAhH7szFAtBS6hbmz2sb/zWRogEYltC20WmjNRNlI3k1sNl3CuF4nevjkmam
 Ws5ozN9a2l7Kg5wPSgVxT+UudUb19o/VZ3sSb6WPs1nixqvv1cXQdeqbzBEzcEieDqTCHA5O7uS
 mBdCYFA8keQWNaAzJhLMg3ZtCF8j51RJuR0MjdQ2QponQ0jjGl+wfaLY5HRN8AwM875e5pifPoo
 uyf/lw0qT+1XcfaaQaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfXxdWJPelzAThh
 6UgAbG1iUgClocEPgoYshkqMwoLVcpyPaSkIsAdyGu+zPWr6+mEHdIlP6sJFgK8Y5aqJPhXK0xC
 4zMXXc1xDxRCeuHLTRCLItraHI8Piu4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200066
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

Refactor the MISC1_MISC0 register configuration into a standalone helper
function to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 4c62b0e137c3..ac24c958852b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -458,17 +458,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 			ln_mapping);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
+					   struct msm_dp_panel *msm_dp_panel)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
-
-	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
+	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
+							  msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
@@ -482,6 +478,17 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+}
+
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+{
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+
+	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
 
 	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }

-- 
2.43.0

