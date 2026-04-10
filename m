Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9027E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCE710E90C;
	Fri, 10 Apr 2026 09:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B22hTKeC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUBsuxZ9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF4610E90C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6qXO41729939
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0vw+GVouMdxvKPWFW8nnI4YGOVXc23873dfqdgV/NTQ=; b=B22hTKeC3mO4k4+8
 gjK+W8+D9qBjDhIIIv8/CyiP9GoP42nWcFXemIfJgZ4PJasOXsz4ww8RXo7moxuM
 wThH4DqSFiBbc4aFoxWv3kq25AjY6CoghDTy4K3SPBMQ5XiG1fsJHBdclEVtb3oH
 4wbsXor5YNIoSwrH2O4+IuQWeEA1eiUtsiizdkAAUfvdaFTK5/bazsGS5n8ciBqO
 MYmAWIUydhttkEnwENYpET7eQhZwmT0jrCUb90K07/+HjThjltrEzbg8f3CAVWuz
 ZTMtElyToeMSUHmD1Q4nm37r0eU6gW3jdlKczMqiGpExwlsXJe+V4VFPpb8M4lKq
 uJdtDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxkn1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4031b86dso50942391cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813668; x=1776418468;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0vw+GVouMdxvKPWFW8nnI4YGOVXc23873dfqdgV/NTQ=;
 b=ZUBsuxZ9E/1UsFaP1pXVJ4zQkvjTcv1jLKzmpBlgjVZspy9MPIsTRk80PENP9iyiGO
 6Ns9dIdchjw62unc+o/ppIqFbLGEXoCUer9m2g1KfTApJSH9cjulEaOUsFImkgzD3uKt
 i37IeggU79YYFDe71Vp0PjKnZ9ltXAdeB1e8d4+93DXsk/q9UeDjTX5PnKDRTyFHWvEb
 aoGPJp1MKYBuP3vTX5PuxxojDJGwtcGP5Q52goIZBhyZRxlmMLEJAWl3mlOvSbJ9E3ZR
 /XZSH+xoeBPV9clyiHs4wfmY179W+ct0BALcwbksI2lAXw9twBBJ7CGr7ahrUSXGv5SF
 kqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813668; x=1776418468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0vw+GVouMdxvKPWFW8nnI4YGOVXc23873dfqdgV/NTQ=;
 b=SAGYXFguJ5sZVCKmY3B38Lw+sawdP37YD6iJizEWZtrC0xJq7DzC6wmuaM6g5W1qGI
 qakSr6i19F3abekkluznvsp5I9skxys0tjeH+52pJrrZUPKfbo+ORmBCXAZtSCKA7xYW
 dGglSduYxKyiIUGNuytIkJ19RD85H0yHVaA4hmf32Tn5oA6+hCEmzUeEP3Trxn/9iQRg
 XC9UwV2FVwwtdhO6+cNUea7wlv3kuYoo354T8XpZlUtNE5JqCcv+wqi01B3JPlu0qXc7
 hAf+HsJmt2/pdQIESGePHtxjFcnjSKh6cLMGf7DjUc5YFUMwcfD6AmKXlDvsSZa2zmgf
 8Tyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlFRuKkNXMNCSEenXmLoguR9Ju5p9dqz5+dtITZ9aebxz8w2ORMCp6s+Wrxrwf3rttaknajczL2gQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPwgJnylC9GKP5DbRfANrxVTI+X/k7fYGeDi1674D8AfHRX9b1
 c3Uow2n0FQrPOX+kbmMfEVXs81Lyoy1n/b7Kw87TMuwQ6nuIf3vzg7O485kPoqtjkhzc7Ldbsfn
 YesOrSZZF3g/FudK257I5VLUF6CbirU0HlD1bmilY4Ymd0wpMERAEqBYQK/8GkoC+7bOsGCI=
X-Gm-Gg: AeBDies+Hom/9DU06uJ4oaY8WdQSQJn4uja4GZiaUKJxdns/bUGnbeCLIJx+HSVtZvy
 KAyXdjrdSTp/pOtEnQCEkdGTsOk0YHL1XyCIPuKfLvxuCwF+NqSbEUg0vPmJacHXHnOjYS9PmXm
 TRp6GhAl8jWtcwhHkSd3ZVbYa4RblK7BzRq1ioDI1VDCBxgCSK6BcLdyVcZAHzTWa612dn58XOh
 4Ich87c3IdrajDttfoCZ3yzTdRuf6eM4WxQg1XJ5YGTn5mLhql6JNG5v5tnGpYyW9BQZir6DXlZ
 F0LoNII8RHHIBDx4AG4HmD+QNlLfcduSX3Pxwu0riw7EdS8GvKWnfY3vR323xYNR8aUslpNhxbg
 EPddN3Fhy6gjW77jVSNrBcgMvQzrAv6dFZ/V/BqZ2XAhcpKp7/zMhhl/WcYMtL7feJDUgYL4jtx
 b/F7rCmKA=
X-Received: by 2002:a05:622a:7102:b0:50b:5286:f768 with SMTP id
 d75a77b69052e-50dd5bdaedbmr28094501cf.48.1775813667802; 
 Fri, 10 Apr 2026 02:34:27 -0700 (PDT)
X-Received: by 2002:a05:622a:7102:b0:50b:5286:f768 with SMTP id
 d75a77b69052e-50dd5bdaedbmr28094221cf.48.1775813667380; 
 Fri, 10 Apr 2026 02:34:27 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:27 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:42 +0800
Subject: [PATCH v4 07/39] drm/msm/dp: split link setup from source params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-7-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=1313;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=vaB5TI6vRjLHkdJJHUC0+HLPLyjZuxAcbDY5pvSAxd0=;
 b=g5dy/hjzpqUBHlCBjit+1XAMpFzbXR2uUyC1CU778OHY7g9h5f7BS1OKg6d5GQ8yCvuSBx+89
 jexa4rpk6R6CpOOvw+UYfzVzsgtOokS5vxOsTFBalMToFMTIa8JOWfj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: 6O1l_LvcPi73xVmH0GLn5b1ys1bUh8Mi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX2O6jFpzVBQLz
 Zygk3hF1yaY6mui/HlPKRKl+hKxmbsLf0PA4o5eP57oXqxR2Cba7vlFxXmxoj9MWfuUJx8qikbF
 HW+BjOfeOLUW73cduadurgsonSunisA+dlYmjrHCcNGbY3Dv9R6au04JWQD7JhsvJhEvY09tRen
 4UilvVx9eUi65tujZoYLydJiElbi9P1+QyPTgo/yF7r6eTkfXcV45mCsIsfhUmS2OITSkD4kcTP
 UowI8VLyoEkr7l9MeseO0nLbZbIJHak3AYdTIHo/dzkLeGvogOIBEbzh0oqm0M2fanIHYn95yWl
 g8GHmMMlqMFxqe75+4bW2F1tztHcyUAPzizuCP+84UEX9XRV6VgJgjOW7yu6Qpd1LvIUyZYTZpx
 Dh5pp8xveHNkeCAlUItfSnD/BgkZmwa7YX4UXSt4F5OmkWiHx/9zHBWHXcmZV8jZ+JEsfkExSBN
 etwYYikB8cWJnio6GUA==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d8c424 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=saXSvH3Ee-fMY4W8qR0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 6O1l_LvcPi73xVmH0GLn5b1ys1bUh8Mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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

msm_dp_ctrl_configure_source_params() should only handle stream-related
configuration. Move the link setup out of it so MST can program link and
stream settings separately.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index fd6caebae148..cd58968d4e14 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -479,10 +479,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
 {
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
 	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
@@ -2571,6 +2567,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	 */
 	reinit_completion(&ctrl->video_comp);
 
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+
 	msm_dp_ctrl_configure_source_params(ctrl);
 
 	msm_dp_ctrl_config_msa(ctrl,

-- 
2.43.0

