Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A397107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E0C10EC66;
	Sat, 14 Mar 2026 01:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLKoeO8f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PY4SrYwu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1D010EC99
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DI6j5i1749485
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PqAtWAY9FAqIvdzkP+oLI4lRLzY7loPC33zOvhTcaJU=; b=SLKoeO8f4dgOy7mS
 MoRr53rOuDkxR68sbQug8F1nNRaBWSUd6mIqQKNdotob1iuY/7ff5uaT/AzkQwe2
 dT3Rj6p5zJ3B2v00PjCto4DYiL6Q+DQZBe90nnwPWAbyZP2x9TF4ThkHW38/Hd1g
 IlUNs/ghBR3w2mk986widj0baNj1gH8Pi6/YSvjZXgEHjTAwx4p46Hr2BumgLVx5
 cyx7pWhrfnh9sUEur4SMUIw95iVbosHqZ3yRd07Q+4+CKa3KgJqNGDjCco+hpmXj
 EbXINVfrOuBBynmGt8d1DXvXbG1XHeFELKzdOJcM1dyPVhlmBR9u+cgMWvinNr9L
 zZJDfQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvgj6jm5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a0013d87bso432435286d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450566; x=1774055366;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PqAtWAY9FAqIvdzkP+oLI4lRLzY7loPC33zOvhTcaJU=;
 b=PY4SrYwu7I3AIgz5OGn58y/41RX+HJIy+PfAIUTtFveKDZN+fxC0B0BCsv4d39jg5V
 21YcQdOmbeSuMJHskuVyRwqt+OVODS0ax8/qCpu4CTj0GbYSFuaKl2nyFStAnxgrUcLW
 yYGqegeYpKtnsFWbQU3ktnC2IwtekXwpEC4VYnBeOVK9NhfQO/tSy8tvayqRiPdZCvOG
 Y2OaDOBq99mFc6JUUgcd+uJDdSDqwr23E36vCp3VmmfbIcAvMxUQfdYtwQELlq8XgZ43
 no/QmTIJ0FgsmIMIU9yLMq2qtvBy0q4PBdzVWYGy+35N4rmCSex9xUNXljSDaDYpBFe8
 hFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450566; x=1774055366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PqAtWAY9FAqIvdzkP+oLI4lRLzY7loPC33zOvhTcaJU=;
 b=XUkyh7/3nYBiLYx8Ey/hi+6h0GrX7w8hveyfffVMiQiEvJZ0bIqheGGf1BJ7hxVK/M
 5fneSnlRcTxa6gjkad1BthYwk/POs0WAbchPbV2AmH7glt0q3iQXBEyD65OL+o5b1EEP
 3K2vlFcTbkKrwmT2iU+3s0gmXj+7dL/Ij/82rT3gdYSt1oC6a9cgjQuKOAnNWUs3gSB7
 FkTnfPU1Sfvy4CUzNoVWqCgMU/IeW0e6+zKemQPDpHoD8Gnk7ZmWHiBABfA15f/snygb
 ifOF87u32A+EKnfL0Z+hK6uBCGw772Q75cH4NS56i5yKCvkxlhksj0bEQKvbzapriSnU
 ElbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS/iG2RzDAh152oRTmW5ocTv42wJF+SslkOjt5J8oVCZYmLC9rKyGERH+hht/r//GwEI8C0CGAYjU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypMb70wt0LcK09CO9TbPTfATqVO2n2OICUdrGc6uGhMBH8vklz
 EEjp7Uakn4BPX9S0Lc83AKo5Ql9WmUcGRXANYHiDHYulpzOZ1vPpDoFGrlQu8N1vFuUgh+PoeaD
 n/RtcJnjx/44Gw+jTKbt9RZk6svIPhQaG5m0AwIQZb4FhUiOBKeDDtp64h/YoI5YXtLBOvSU=
X-Gm-Gg: ATEYQzyIzAAf4vT0UABKm4oo/Y7zzfNfDYHrqAL/mqKqYmwra1Ce6/OuBhCkogp0zo5
 WJD0hmdSnhsJASBf4oaWF3y20a2IspP9wjMH+sSByc/1BiEF9AxG/Z8RtwXkam/TOZJLAUjZFQO
 +3Lfb3YJ/TwrAke0GisXLg27z7R+dxxM3XdqDkhVMzdtSf0Y5S9o7GEkKVwJEpKFAQ4zF15ANcT
 ARUy49MfJH+WScRLaciQm/pSXKjQlGp0dkvVnC+W34P2NPCQU5zBGy6NVkL3UEpCqrkGgp/nlu4
 b/kHwgOOw6sf9ckJtXTqiBTWA255iGApT03wAEjorj/lMBhR5LhYZNVi4bhk1N/VQhv0OuN1YmH
 bKuRWCAt82SLWOkA2beWnk3rqsKotWKU9+WnAFb2Oc2EuhYBRVQrviBz7qw0euQ4srz53fo1xrg
 uQ0ljoo+XxpIfq5KrQR479pnzfR0i2518Ttiw=
X-Received: by 2002:a05:620a:4623:b0:8cd:8d50:169a with SMTP id
 af79cd13be357-8cdb5b8a3bfmr755062785a.54.1773450565937; 
 Fri, 13 Mar 2026 18:09:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:8cd:8d50:169a with SMTP id
 af79cd13be357-8cdb5b8a3bfmr755060685a.54.1773450565543; 
 Fri, 13 Mar 2026 18:09:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:08 +0200
Subject: [PATCH v5 04/10] drm/msm/dp: Move link training to atomic_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JI7bZYAZgZZoG3QbCYkVN62ORKAZ93CC/pbTrYikaXc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLUzvSvRU0YMLXy9h7xpFPKQwsTjACPD3ArMl
 C4jgvcRQx2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1MwAKCRCLPIo+Aiko
 1Y4xB/9UaFY1JNob4h3aSk0mKkF9ebTmHHwh/OdSZS8sAQZv0mNBREBQpLU/Qe/X6aH9RJhGqo7
 xpVmr3AT8g3gVQO8sryfGijOJXexdwMrqYAnc4u4OWC2Y70ilj+eIMVhq9E3KHXf9G2owxZRwng
 WUSOUYGhi1QYeg/2wmS8CTSAW9nU9CDaovmwgM9nLEvaZJYF0I/9etpKLH+RjkGnBP7HTUkpG8i
 +N1qeLI7owHTltmhNxW/zrnFXFIWy6bKODuSN6KM29LLYMqhalSycosziNdcsjo1+dpafBi505u
 Dms6iPoG09CtOlgBQC4JqqlSVYSTTddTa9QT/9ZgqCbYSAai
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX3oAc2+J6hGM5
 kan+YavRq+dRdb29H02JWF2/PO6odIl5vyhhjPtcAt5gn9N4hW2YC01a+a/vX4My7NP12YoZQRt
 Uv8vsMvszJ8k0nBWPVD+bthtU9SiJ3zp1URL04bcTyjN/G71GFNS8pHuI660tJSiG09k/OjAJBg
 GmRFad1JhcBEruzzl36Hmq58x3aMLUY0JTXXsNgLzfh2wOqldsHX7X90p3HRguU4QGc4Jvs5fuE
 IPRM94kTamIKl1X9u3e5wH/o6dT4eaz6AYv41iAJ0PD/YwVQOwOL5uD6rdnZk9+URfH2mjJlCyB
 sZcJZ2Z6pYgmJ+LUKDjPreZF8Ed8TR5Zd+ctzOf8c5U5qN3z8ztanWNkEx8M1TqShhqLuJOUTff
 svwOhOi8DL1wcicxbabvEqenyo7Q9J0w/85DAGYJpMYTEYXjyI527kpgo+5EKKvm2rUb4Yb5wMk
 Gw4WoYfb+udDqQQCjDg==
X-Proofpoint-GUID: KYsewu7CXukLGhKLtQcZvqj4s44Fg9cP
X-Proofpoint-ORIG-GUID: KYsewu7CXukLGhKLtQcZvqj4s44Fg9cP
X-Authority-Analysis: v=2.4 cv=H+vWAuYi c=1 sm=1 tr=0 ts=69b4b547 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=IoBVowuyLm_M3JZO-XQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140006
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

From: Jessica Zhang <jesszhan0024@gmail.com>

Currently, the DP link training is being done during HPD. Move
link training to atomic_enable() in accordance with the atomic_enable()
documentation.

Link disabling is already done in atomic_post_disable() (as part of the
dp_ctrl_off_link_stream() helper).

Finally, call the plug/unplug handlers directly in hpd_notify() instead
of queueing them in the event thread so that they aren't preempted by
other events.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a05144de3b93..e7b1ed5491c4 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -436,11 +436,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
-	rc = msm_dp_ctrl_on_link(dp->ctrl);
-	if (rc) {
-		DRM_ERROR("failed to complete DP link training\n");
-		goto end;
-	}
 
 	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
 
@@ -1695,6 +1690,11 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		force_link_train = true;
 	}
 
+	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
+	if (rc)
+		DRM_ERROR("Failed link training (rc=%d)\n", rc);
+	// TODO: schedule drm_connector_set_link_status_property()
+
 	msm_dp_display_enable(msm_dp_display, force_link_train);
 
 	rc = msm_dp_display_post_enable(dp);

-- 
2.47.3

