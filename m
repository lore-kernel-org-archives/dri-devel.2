Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B30CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF26510EDAA;
	Tue,  2 Jun 2026 09:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRB5h+VL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NgcqBtxZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBD810EDAD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525tXGX4012419
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IovUpKpDFwGWZaF4DLWER239PrNpT7oEBKFqXm1bx5A=; b=nRB5h+VLOnyb7b5H
 MzBxDkXq2aDo6Ver+IH7SW1QClrIB3SACFd4T9J+1+TZtZasYhREa4K7kS8OXacF
 /JiRFxZUq35P3Q/xIiEw5JQjAsZo/lyW28OL4eU0kxYyYfJMVQZOb3pgyEMAMuPu
 nK5NzkXQPz2SjTPsnZGXRrJSfrXFAx2F7VE5O6SLYd/r6Lnbk8caXOws+JYOH8ze
 x/H8u7QvIUWGcNDxXqnfzLqLf5v4S2JK+7FFImBMsMV3afIzbGbQTFlZTVts+m7l
 7oc/6bxsubZ6Nw9d/3JGxxPrt7GyRT1hL2Yl5clhtIKAdx561giMHGbIZAb3i5/K
 FW5xLA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf4gta6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174e8642f5so48319751cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391510; x=1780996310;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IovUpKpDFwGWZaF4DLWER239PrNpT7oEBKFqXm1bx5A=;
 b=NgcqBtxZWOTVhezpg/HzqaH7+VVfvNhyNi7BVxtUcf7sxAMRwuBJoTwOp5sKcmO9O0
 oT8RLZrdZIoyovC/fikKktkChEIkmkJFTIn/vMlwSONL7m0o/EtmUMXaU6yH21GTFr3x
 e81evQUxLuO6lZAkG5wsq9JBwJCW1U6LA0E262jUNf96+99ESb/DrSIUgzZPy7LQ3Z+/
 136PMf3m2038WP4f9OJFufQ7hsbpgJr8Vhbh9PVOH4PCLyeD4lKL/hL5SORUSySZAQ7L
 wNCGgS/0CHEGHK5c4XjzbaMAM1bfw+ZqSj17W7YO+ecxlnbWTLg/qWD/fgpMEJCOfPza
 1rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391510; x=1780996310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IovUpKpDFwGWZaF4DLWER239PrNpT7oEBKFqXm1bx5A=;
 b=F9IqOmbchUoHOqnGk0XwmjjARl4sme9N+GMK28BXhRVuXQQOjVyvgwbIc6tAeAfJ0h
 UDIrQEEYm5YTTtRbHxCEPv384ONw3U3BPCfHylgaiObVBVUBARUpa9Y9aVAQ+zAmdCAo
 oKdBuxlwDM7xjaFOQl7TXpY+WNZE4RkGq/uG/JYldWpGbdlRE4zkTmuimWEhmv9cu3Zm
 m/ZjiUHTuso1dPFLxnPYgFYVXQyPlvkdfLxv1dtdRh8XPf1Z1DyZRLEUD3/Crl6/Wcob
 4vwnsUm9Bzb+W8vsNKcm9gP7irBl6YkZB8SCcPQ4xPs3d4M0I25aI1JK5K6A7IzIWAUv
 1QsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FewtkICCu8Aphd8VYUgkgTXiwSxzoYIZVcRgeKrlNd2OZG4gYQT5X2Oqa+r2fSV97QJWKiiiyOFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8a5Kf7m1DA7/nhS2k6r6fXOK2BphQw+1Uyt+QcJ7H7RneH84r
 UMlnPKAyc3AZl5FCK/aITvA5BsRlCwrG/38A/HpEFzAnSTEMVlMFxEOhG8cz3tAJ0us6uD299D8
 mrTwwKe4L2E4B7oAKwKI4HLQrgwydDYnAOqqbvzZ9KzAZa3NnHD6kklib0gs9yXf1/L6wWbM=
X-Gm-Gg: Acq92OEiavHo9aiRS1yxnSvuKKwnEw5P9aP3k+faGwzNyo64T7hmWYDt44ZdzFUzwlJ
 Erxw3m9sGDykS+okJrG1r7UnirNItvqe5Aiy+6zRSxhjBq59t4beNZvcnMPklCvTuCtBz+0HG6Z
 MfvOVGLIHDVN8Cr52TYoPUpiD0T0cu9Lha+VT/KvQ1PCd8Y1kQldf0IrJpl4ocQb/P4XaxRaaYx
 h7281YGvm1meO8J3DEfB2G5+WJ+ZKKGYKdJ363+y0Z4AP18Pc49Q+s4cGoSWDHdESVij4gcl4Ch
 0HC0BOgJiLtFjazteRkqgEbVvrkDD2ohGz3sOGCv6OQnVZMwp2TNcVN8DZ0R/hoPYrOOWBQxDj0
 OnJ8SL7wKBGC58IV94RIzBZlYFPGWGMk7sDJtDDiX0gXE/gTyY/t8O0HzCoqQcFL9cefq0ytWz+
 o/Q6mAM6EYyBbrWOH6oQ==
X-Received: by 2002:a05:622a:5588:b0:516:d4b1:48cc with SMTP id
 d75a77b69052e-5173a5b4efbmr215685761cf.8.1780391509708; 
 Tue, 02 Jun 2026 02:11:49 -0700 (PDT)
X-Received: by 2002:a05:622a:5588:b0:516:d4b1:48cc with SMTP id
 d75a77b69052e-5173a5b4efbmr215685341cf.8.1780391509319; 
 Tue, 02 Jun 2026 02:11:49 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:49 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:18 +0800
Subject: [PATCH v6 06/15] drm/msm/dp: split link setup from source params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-6-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=1402;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ixgmYJIVCgIesw8IPUX+/UcnW6cdOBjM+XPZmes1+Eo=;
 b=wQzA1NrqLbrqIbng1TSRR2q9hmwp+iEZEBvdcs8FrTVsSEdAZMPKBB4tatmzXucFn4wiG3Qc6
 4279BVHj7IKCpFz2/1YLNZLLtl56qWVDUllMS4Cim1r5nPqnBWg2OO6
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX81A7qPttEwKK
 Xhg2lHezUu9xdjbyi3oYazxWbZW38J2nfd9piZdKmvvsN7gHJbo7ieYGFvhpxzGAE9O9mqcl6gi
 CCewoBUdLY3b4Jll3Y/g17qkY5TOlPmBf7tC/JMj+bdBDDTrM8ARbj52PpcpAml2rav1Cf5mO9n
 eDaAkm3UPmjSk7ifyT4zeD2vOcKauU7TrHbCJ46wsbRrjuXUZkZrLZ7WRr8lGYyQK+TcMeMrYc+
 XAhOIc4JlvDxoyYlKAjbt4jJ6FBSHLnjh7MPUzP9ZQFpYeox5f0lhSjoHlLZpCrrzV9u7vVWz4o
 wMawzS6jiILbqAd3YJnNHPJCPviZ4o/z+wCxJl3OVqVUbb43zJrMHwU1fXPFvgT50do5+HHoN+R
 39+SeI08ldbLLfVINdN/nx8PCieXs90HxdhLPdvlDx2sOj/r3fnyms/nyy6fRFvj7n0kQQ8HVH3
 5HotMFVDp8GBEPv71GQ==
X-Proofpoint-GUID: wHWSTRyywze8Ay8TnIk885rwtg5JE4GE
X-Authority-Analysis: v=2.4 cv=AJZ7LEvz c=1 sm=1 tr=0 ts=6a1e9e56 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=saXSvH3Ee-fMY4W8qR0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: wHWSTRyywze8Ay8TnIk885rwtg5JE4GE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020086
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
index 71d45b2c4daf..1c2eccec6ec6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -482,10 +482,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
 {
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
 	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
@@ -2551,6 +2547,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
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

