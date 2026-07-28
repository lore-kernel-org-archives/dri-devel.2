Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFDCC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB42F10E55D;
	Tue, 28 Jul 2026 10:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+6Jf168";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3jVJ3vf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F91E10E868
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S823NN1663736
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MD81MiQjHMsJuaHXSjy1XEWIftZTPguoGe7ZSeE6sFE=; b=k+6Jf168t8mzceo4
 LLGLBK0ZM0YaXD0UoFc3+9XoOpeaQLS0tjY8yLGr0CG4epox8/S21MfTRFkIqxdx
 ilXbqtp8TNauTFhxJZSqEIvSgg127xgp6iNp/IlaQw8Eo5RRPmg1Bc9w3AU1Zy8b
 MMToKK6QMUeKecLkDmY5p/tvQxJMYYsHnvgbiY/tnNWc8AEC/mNI7bsYItqBBEwi
 A+iephR5E9xWNLVCm9gl47Vasj9yKdhT3t7mkPIOkKcF8elv3/+C9WHKmuYvWEtu
 goKU7wu5sA/H74yOr4tJt3dJdvXoxEiK3+o3IuvKT5sbQ+HseOJ4RhNE99V/ab5H
 ti1Xcw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpptts2fd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso68142981cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234129; x=1785838929;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MD81MiQjHMsJuaHXSjy1XEWIftZTPguoGe7ZSeE6sFE=;
 b=C3jVJ3vfTJTx1mtlAhWW0fIpi1D6+dcSRJuR1x1+QOo4dCk8XAIb9ITzktuTM61HY3
 YzujiPenodvMEeEjjYWXzhCwAdc8D2tHJGqEq9LNjfwBpOdgi75kfmHtQceGliC7s8ja
 RDLB8kWu4NY+D6rsW+P8U+syo+HcbZ9T6lNGNAKmvrKJLJU6ZBVk5vKcEby6n/rnqShl
 10FhLNyxVWnt73KDxcXwwzbDMYs8+X8qYGe1bO/K/ABiGIAhp4nWnYd/JKPV9FVCUZG2
 ID5HoOCp01bBZHtkCo5jxguBWjjdu4zblPeYghDKLNrdBvouagihZo76M/oF8DgUmpHT
 YHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234129; x=1785838929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MD81MiQjHMsJuaHXSjy1XEWIftZTPguoGe7ZSeE6sFE=;
 b=ojwzYqmgl6M/la/i/qZ1BxwWryzyedxG9+e5iAFOQdFb4yECt50gM9Aa4wBJmHJRh1
 5j83EL7Nm6IVH67fu38f6xh5MGLBRYgCPdEAdUER/73Brzswa75kKFobvHQDF7jNqNF6
 yL3z2g1a5Tqr4Ppf2SkNJCi1dHXjCYaXaWx1T6L8jfQ8e5gWI4FKLkuQSDb1KPL41b1v
 F9ouclN2u681DkrAVtcRFmjraQuEQVxNHWpBrhsp6Yt95RTpVDEVCPKk5Awcexe7W/3D
 IAK6K5KfeuR0vw36ZnmGBVXOfrdWv24affF8hGObnjej261eRgOXF7KdhkDaq5bstucD
 ZaiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCjILaGuW4kYkQXLPqgotGNfSWZALq7/JhKlek9xOHQulF855EgRylWPbAuOVHjMg9La8fL1MziUQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx89Fh86ZyLhStN4UJp38vwlRhvJDYyqZlP0LLPiUzBwKRx64jq
 koTUB6bwzLXTzvXrVzrXCHgpeEvt2mzEx0+8F1PHXQCIyO3txGkj11kbsw2AgNg48uT+apHL61P
 YXXY+ptkFxnGeIccXyqdYYEblcnO55WKPMU+RMFIQtBe2cZTmt5otCWJEx0RQrSr2lf+ECZA=
X-Gm-Gg: AR+sD112T4YY8iqCEv0okIHYIkQHjB4G43Hx4ICvpIjYVlS3aeth2R4Yw2DzpCkJrY0
 +L/5tlgmBD4EQ44pf53P3LFboEvCTHYl3SKI0owP3aA9bJnb9ZwxTS/veiVGfLmsLtzyCLHzi9E
 vK6XU0OB13MV9BZOGfzGmqqvLd29ykphEmMWd0sxT1E5m09uxA4mHHULizvAe+POxjekl04gKTN
 pny5cqSQRhyUdZhD2Oo3FiYn5rUevW0Q9829R5Ie4kCrOwiPbvrp46sNh1ANDtqmDTYn/TNlCiz
 Hzitauca1Eu+C2jXHHDsMv0K8v4VWCcPTSEACLhKsmJKZdhB8K0JmgzBySbmSoUq60csr4XOBFU
 TFazB1E9OthijJVer936Wb/An5Jm9CGFEfezUG7yfiroE8BfBvTVtfYo6x9fnJF4=
X-Received: by 2002:a05:622a:6097:b0:51c:7b12:5fdc with SMTP id
 d75a77b69052e-529d71a5fd5mr11609841cf.88.1785234128952; 
 Tue, 28 Jul 2026 03:22:08 -0700 (PDT)
X-Received: by 2002:a05:622a:6097:b0:51c:7b12:5fdc with SMTP id
 d75a77b69052e-529d71a5fd5mr11609571cf.88.1785234128396; 
 Tue, 28 Jul 2026 03:22:08 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:08 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:35 +0800
Subject: [PATCH v9 06/14] drm/msm/dp: split link setup from source params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-6-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=1402;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=HQ9e1tJtpEldKUtU4+gyneCaZfO9vxBnWuue04uaU6g=;
 b=9ivr3sS37dYtST/5l+jqnU7RTta4ILS5W7k63E/6rrfyj4Y6Vgsunjq2Td4BvkIKBOc1nb8hs
 nGwdnj1JZrKBvZETN8d3nfr3Oc/CBS3eyz47Vx59TydNjk8JIgxUnYc
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfXzKOo1Jl/1irk
 X1xRpzO7dSaKSZu2O6fIwFxCw1jXldqOgkhyu3fVTFzbvVq7WIUUzJEyYCLQD3AHzBkk8qmsj+G
 Woi5UUzlj758bHS/mOlrUvrwHg1g8hY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX/LmBYk33YPcR
 yJv4msQKQdc/vusEB/cPEs8xcHD3El/aeKGPht7booJkdoTEV9ajwPw/9TGsmOTFQOCk5664Eqc
 rlSWFnyDm+ycHyph5+67eydfKvIc+eReeKtkqA726nMds19mUxCrV/NSVVmEquFMcDBgGLZ7uGe
 Sfdkmq3vmPxkqzVR1kfgee/FoCh9c5U4S2ZWVNHZaIGAFGsGvs2OWsQDaaKJ3hlc6OG0YVp2Khe
 4JpkpjfW8nd8CGl114QCpYf/5CLLtswhnJaE5yIdlfUi4M+3W6Tenc+AM7ePmHB4wn2G75cycU+
 ocANZm1cOgVQcsybusC2khdqCns5eef4CDtzStaz95cmBvybaRx9GNVHGCLNNBxTmZh4h96IsoZ
 WToeh/Z+fOUYV2q186N2UbezjrW4u7c+JfhuzA9e4R/9jYt7UB9kaGiiU6ZAViPdZqYuIKAoGeh
 g7nbJU0XCmpQ+dD9j4Q==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a6882d2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=saXSvH3Ee-fMY4W8qR0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: xNcmxp4bhZLucFXBPWkIyZNvXGJXvbja
X-Proofpoint-ORIG-GUID: xNcmxp4bhZLucFXBPWkIyZNvXGJXvbja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c557e0f01dc6..f343bd6c2b81 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -486,10 +486,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
 {
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
 	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
@@ -2556,6 +2552,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
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

