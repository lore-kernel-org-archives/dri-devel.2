Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EE0CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C83410E358;
	Sun, 24 May 2026 10:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJePeVtl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mx+cP7xQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6C810E363
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O10aoS3537628
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cDgNJal3WXOXjG3gtCnualVwCHXb/rJSUqjbf1sfrX8=; b=nJePeVtl5lp5EcK1
 +l9jZFE8OE8tU0lteK2FfwEiFX03jNKPf0XKH9jWxDZwpYPO+FkujRR0oeAPlpcq
 yLV2Fzsa2f44bhPUqv9sG2eqH5+a9QJFRqBqWgd3aXHTghgrUsXOzVuwq2XWHQ/8
 S/R5U96g4ogI/rHwYtdCNukOQReuoPHCxpcMTAQ7sq52B/fu6VDJxQaIU6Dq0ooA
 sBp/Qn9FkfTN1IHyiN7NwH7HLe8pvxkZAeFtMbshFmi+QObVV0tfmP7ZZ+i7syCY
 wl/TDqOeGcxdOUxmOs2Lzj878kVSRI7m5VHRCGm7RCdkoN7JGLVAZ4py1jJR8IOd
 SqtnMA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0t69j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:53 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6347ed78bfaso11461135137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618832; x=1780223632;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cDgNJal3WXOXjG3gtCnualVwCHXb/rJSUqjbf1sfrX8=;
 b=Mx+cP7xQsUsqhEXoYPu+o9rppMI6eDQp5zshyTCxjA6dG3fxYBB9Q03sAyeQ7+4ZJe
 DV3gq6IJMsfvN22BzzNg6zIYKkq17RFcrZFs4lwNWDijB2LLnByM5wCpjDBjIyrn+oXR
 Mqx0k5lD8cqZPgnutZ/Fpbj+WUIwVDR9j3OIY8LU+W0daP5T/CWbPS3tEIix4Xb4ueAN
 jbBrCJUVRdTlcgekAwPHTFOxl9wBuwFKurWlm0h3tc7OjWx0SigX2FAJS+IQ7KV+O35V
 yaeznoisTsBo+xwRzKheZn6Wc09kOdAjFDRhM8NMcxvtJmfrvpYVV1tGF+VzoNkbLPzx
 wTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618832; x=1780223632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cDgNJal3WXOXjG3gtCnualVwCHXb/rJSUqjbf1sfrX8=;
 b=tN/MMmCBPI3V8Cgj7xP/2DhBgUWKCPR53bWDgbI4fOndVyQQBXRIp6XDhxj6LIehhY
 U4weq5gZBtxASbIrgLAFY+2rV/Xnxorc0HW3Rh4Vykx2PxWCp2EAbThFhi+uh85vEZFp
 ggUd5pSVYeRQb0i4VvUA97bF69PI3lk88YHCov1zhZYbCLLPsMuLkKDmcFlmysyWSifX
 ApbAx2E3GyMek91KWhsBBxBDYaAkv/LGCvaSxJ9V16sz9N4I41tsBInr2UAkLMDgKPng
 /1wrfMTaE+qNmypMxhiLxO4DFZTVsPbem/wZ0Xg8U9wSn+OOyBg+SEdE2adVk9qJKKX7
 HgTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9PtscvPOf4/qt/CsLostgjT2kyN8W/n0zV3YN+XXCJrXUjTbr74hCmbxCHN1dq98Uxq6aW9BqK1w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywnk+OhOoj/nwbP0/fAoI7mc6GqL1fvIKnF6HGMP0AawEtCerFG
 Ti3LkhALcU2rbJhsN/O+Ba8IXrf6njea6O5EuoKaV8sfkbCDzR12mWZ8GUPA2QtJzVeLtle6aSv
 AdvZV/U3f5DP4L6Xv4GGZqY2uNoECHovpjMH7KdueyhRg2z0NmXWEgATSTCuInrnY0T+8yvg=
X-Gm-Gg: Acq92OECCUrGOLnvqulM0VT+HW+7lJD4XpihPgaCpptFZc+vKNoW4xlu/rBzBC2hF5y
 TKCjBJMpeP9TF9zYDNaUEn2Rg5iUrOybBp/hjBfBio0v/fDzB7TM9MeEemzHAo7fXbmKfVKZPom
 0ud0yHxgH9V4NqAGzK93k28MEXuw0nh76mqeGG3Upqp3Q/LjfAIgWCnJk6uZzrvDSxv6oqz2NHO
 iC1sJcUr5XbKBz28T+GKwGrZEaYv7QienAfEo209Tkewe7FPA4GT+rUR1H8H6TblkEy0tBAW1bu
 AQeVhKF4tuB6yR02Nfv3SG9W3DZmHqEExDKgbYJNm+91FsDg1Dd+SqjoyHIQtYPe+fNi7RGsRYX
 Nl7OBrvSXjs7oxXDJ5SIPEnOLZHa5o3uRjKn3QlsLjvCHso4MpptkgooCom6Tn9b2Vf3BfzRn1x
 tCpwDzy7fLMZlNHYl06WJTEm7m+skUnvIgLXs=
X-Received: by 2002:a05:6102:2acf:b0:660:cba2:b6a5 with SMTP id
 ada2fe7eead31-67c7b9af5afmr5183811137.7.1779618832530; 
 Sun, 24 May 2026 03:33:52 -0700 (PDT)
X-Received: by 2002:a05:6102:2acf:b0:660:cba2:b6a5 with SMTP id
 ada2fe7eead31-67c7b9af5afmr5183797137.7.1779618832144; 
 Sun, 24 May 2026 03:33:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:36 +0300
Subject: [PATCH v6 08/10] drm/msm/dp: Add sink_count to debug logs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-8-cf3ab488dd7b@oss.qualcomm.com>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
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
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3448;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PPASzQobCBYdb9dmAmZWGNYYaeV5Anue8MN6gudi0n8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP9VIdNVQybDZfFejeH8aD/nykS731k0+PtY
 PPkI7hBIn2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/QAKCRCLPIo+Aiko
 1W7LB/wJ0X1mFHNE5Aa8udZzN774lvkGCtFHmzn0/lqay1eqC807JcY8C5QC3erM1r/R6Rhft9G
 JZYBnGQ1IbI76o33dfqiVFzFuS1CyLO2+fAqSWruvyJP7nqK8PDIcEv4mkWAgTLIvTvxFBg2w5I
 9eAYT5JtObbTkZnyFNC0PeI7ikPaKWDwWs2UcXyA5RjEd4xrgyyORG1A66FyVKZRJcksTUrhHid
 UqaQsfq0df2kodpQzB5ddzhnTs4ToMT0EPE2znSx5Db9CON2laJggzolSm2db1ZCxsBtSdfWAdf
 ThL6aihfKYqwe5Mf1WbI1FyPz9GoPyipL4BaFifbqu7niN4A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 9nEt2fLMxNpcHIIyZBnKLa8tpp9uLEXz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfXwjHOsgvvqzCH
 cG38kSsBn0T0nKLVIcezFvb33aK3Uc0yBkZzJ8JwdvzXAswz2KBuyxT3J1+FEUr3gt7fQKe7nME
 m2j36tgLYbqrsZ5x0P07KZ25xzNd4nRCQq5h6Ax82VaRr1XJyoGLymUQucVEUt2hWydUqNm7qg8
 cBuRbXCAOBiBUvHErUH8PvFEF+K507cxzhZLLfd/03h8ATw8yu3cdjBW0jMZd7bW1g2du9G8+C2
 cWJHG1DCYjeaeLeA1/fTjTDfkoFxtIYHpCxmzExKsCoFbD7YcWUyRr20OzGNKQ20QYBCMkU5xxd
 oWBJmOrB7e21oKbslNlGJ0YuZKEWH1NOaXrLfFNFgCbu5uCfBocs7e/bPgyyT7fSBAG5l+NoAPC
 fmApO3i9MbznhYhLuitRu9ZV16UnKkH30h46llBZB6tV8EvOiwdlG73iFiUIjSFcxk2pEzO9Me0
 PB7r6alMcno4k5Rtuuw==
X-Proofpoint-GUID: 9nEt2fLMxNpcHIIyZBnKLa8tpp9uLEXz
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a12d411 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=D6o9UKO1UCu5gje6phcA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107
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

From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

Add sink count to the debug logs for [un]plug and HPD IRQ handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
[DB: dropped link_ready handling]
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index cdf8e618838a..fc41ac38556d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -389,8 +389,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 	int ret;
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
 
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	if (dp->msm_dp_display.link_ready)
 		return 0;
@@ -412,8 +413,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 		pm_runtime_put_sync(&pdev->dev);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	/* uevent will complete connection part */
 	return 0;
@@ -441,8 +443,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	msm_dp_aux_enable_xfers(dp->aux, false);
 
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	if (!dp->msm_dp_display.link_ready)
 		return 0;
@@ -466,8 +469,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d, sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	/* uevent will complete disconnection part */
 	pm_runtime_put_sync(&pdev->dev);
@@ -480,8 +484,9 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	int rc = 0;
 
 	/* irq_hpd can happen at either connected or disconnected state */
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
@@ -494,8 +499,9 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 			rc = msm_dp_display_handle_irq_hpd(dp);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d, sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	return rc;
 }

-- 
2.47.3

