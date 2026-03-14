Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7FE107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F8F10EC72;
	Sat, 14 Mar 2026 01:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="osqP+Xe2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpKlt7/z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D158C10EC72
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:43 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DG7kWU481304
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2O9Vp9tLne1oeKIvhX+ujqUzU0muXQjI6Vz4oFspS0A=; b=osqP+Xe2XRAjbM8n
 Thtz17APc0SdPv+xXHGm/ro0GDteP3Fo2Vl5n/pYOzkDyRMTtEa7USuQhaCTyEnq
 2SweVqB/vzEd/qqs4OyLq3s7Kg9wkcSbdqB4Rzt6qLf9ukWS9Z9q5VvegXFX4wJV
 tHxtpmHMhDqenEpgbGfpmLaNheEq5e/Q2lN3P7wbvehD+59Ejyl82P+NitV2ex0K
 bI0hdSE2x3ScwfPz/rXoqibIKZGqmmyImMoSSOuubunnBtX0vMfn4uK097//hYkb
 1wHCRvq5B7toV2tqv5fy3sD7yXR8K8vvo+DQZuVAddgx+vpG4BIkz6eVte6q17Zw
 tpwjEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfh7txge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb706313beso431974985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450580; x=1774055380;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2O9Vp9tLne1oeKIvhX+ujqUzU0muXQjI6Vz4oFspS0A=;
 b=hpKlt7/z51UoKqTg2P2LZ8/yR3XjIWBLH45dhtnyX1UlyEYP2KakXmT87DJz5Xz8zP
 j78bzLUhQBx9Q5aagnjSLCGuKtUN3TCVXCR9Eog/7PUSurbrMqIeLAm1vh6rScU0jKF7
 XvGAllvSEoZbEO2mEz2yjQdUIJQW9HFCLSA2Ph75JVFOePT+wnlTF7zuDJat10M1K2V7
 HCBKIB2wQqc5zhjrI4JbNMN6/BJR+LoPn5TIJiXZgitQ8g1kUif3odZ/bunV8G8SKrwg
 CB581q/MmKrvUM6mwKTTEJJVklyhVAwPNZjS8GygeGHfyUo4S9fJ/JmfOvNwmnRxamNa
 UxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450580; x=1774055380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2O9Vp9tLne1oeKIvhX+ujqUzU0muXQjI6Vz4oFspS0A=;
 b=AoHplTAkvKFv8bDPckd9z+tclEAWA7K1DeGNPHieKWLA59lhI8a8B+P33JPTSF7gJZ
 QyU//EyPfp4Wp5SekKb9WhwtOfCIuDY+UmJec3l1MpfDouBnsSRhujaVg1CFsvMqYcfI
 P1S9sJ7DHRcugyObfE+sqKd9zNJZcmaTpomC4NbBo1FBYTfuHqR0YmBDJSoJE/DVvdD/
 AO08CeZEYyiM2codWynyDNLXksBNAU/sxXHtElaCN9pyj9A5nOpniehKQia0vd5O11DL
 ZmsavA+itAfloGnFZqKgmGcwdeT61LEdKeOWOlprwi58YpyDQW60EUbknmrANSQWGjtz
 Rezg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4mxN/hnhdaMvIRA8s0GnL6QNWVCr0iGzLgCOQlnFcuobvU+K3xjQ/Z5iF/7ghfSdYvkqa4aXZaek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDewrjYcVE2uR47jn7fG2WceuxWWoWcMrbcSKsqWip4wim4qbq
 qk3DGVcKdtAXiW2VQSdc59wW7CX+0owARipdQCOyJ8x8/douYprZDimiJteg6hrcr844JxDbUDC
 WwZK3KVyCUiF4n7jy2fry4ZQBLO1235JlKjuFLYA+8k4J9S56rq1ggA6arY/jqt9A6DIQsKg=
X-Gm-Gg: ATEYQzw73fVTT0Ctt2JG/vC06QRaTyRloWW0zOf2hXACOvKblJvsuzR0FyCQrri+KK/
 N3OdrXbSp+WU49IBOfqm/7lZz+OhNV/ksHUkkFmi5rqNZ7G8WjH/bbgZeICL4nOEGKSmNlqXawD
 Swo5aoRvOgZ/7n6x4mbBtVeTWegz6SwPbUq8Aa6Trrs4vZaIDjqD+BuoXFAMu8yNo+G7Dtv/kkw
 cfED84SZsiax/3t3rHFJ1+29YNfKWYxTIkuyvNCCDhxPjEtNT4kYZpItV8kJMeCSRf8+nSG7QTL
 nn6LGsxzSKUJ/IrYJN+rrxKBVNO3TliHfSpozTqnI9TJOSH8Fzq7uSa+rQd1S1d4+rRyP3oRwdJ
 jWMpTsIvjQmrt2SH0+16zb2hv/FCf3vbPmAzY25XWEBLq/vCcV+ANPd8lxEfGhEWfmua36d3GHT
 fGjIRyULgTzJrygshKGh/cCwdligPLtGisgmA=
X-Received: by 2002:a05:620a:2915:b0:8c6:e224:d55b with SMTP id
 af79cd13be357-8cdb5b0a024mr716441385a.41.1773450580310; 
 Fri, 13 Mar 2026 18:09:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:8c6:e224:d55b with SMTP id
 af79cd13be357-8cdb5b0a024mr716439585a.41.1773450579768; 
 Fri, 13 Mar 2026 18:09:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:12 +0200
Subject: [PATCH v5 08/10] drm/msm/dp: Add sink_count to debug logs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-8-0c8450737d64@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3288;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uIWeA/ok0gWyJD8sfFcM8MT443ZdrZtcJRL3n//W9TI=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGm0tTSh6w8lGRerJ/v8G09Zdpb2EhrbiZfwUUFII0M7doIz5
 YkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJptLU0AAoJEIs8ij4CKSjVFZMIALIx
 Wa8lM8Exb5QxLX7rdXHrHj9HIzuJmN45QgiEaO3JoNAnv9wNdFZ0s6cWV0TOOB0BVPbNtWexB6f
 gNd4DJJYbjF7ptAQuKF9zwyGhxVq66PhJyvdflMNzyu0vMJzaXM8DCF/NfTBhAtvow8oKp9Lxwo
 hQEXYSsd4knhqSo5GxkB7PJDEjVBLKitM0DY4nMG27+u+NuG/e6yCETOSLZc1WMct/d/NbvCdv6
 2EETqNn+LtVuCdyCMdH69EyXS4xnMQQWrctI6vl+kJxDWdZPhTIhoJz2MqRAJeEpYC4M79dSN5v
 U+QHwBF1y2ZUhQuhnro8XC3JLRGcq5pUvbZkfqU=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: HKSs4r9g7ZO5PzM-ExEVBWV39s4BOrDe
X-Proofpoint-GUID: HKSs4r9g7ZO5PzM-ExEVBWV39s4BOrDe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX7PaECqi0qB0G
 0N6WkxcMODDJTGOF4gTuCKro3RFMW+QyOgHNiZ1Fudtx5PCLqE1weHDxBxH2gZxTd0YgTAN+WMu
 +gfQnzuimV28Fw8oUxfee6SxdGsxOcER9aBQ6FGQ8KwxxG+oEARnDk0+tWXfMz6KYK+7q1axbiy
 kDWuy3PgOT0+XI481EdtG+GSScyMaZZemmqcRIcLnR+3CSjmbF0XxYMVTm4ZjOYb79ytn3KwZn8
 oLYDpKWeCYjRYkxCXqv4nb+WBKP9u7f2zkgjWtlkwbOPZWxkIUo3NefBWBVH0lMHXvA9gJiDkZ5
 WVIsh/NjDUore+gCCN5K5beUIzUN2qtxHziEEDs0jdfMS1L9S8tVeXHm8ioyzN/nkstzy3x95Jr
 QwutotPMwhWABe3QNASyfqXq4g6IH3NmPvzvZgayy271fqFuYj/NTvOJ1E1YTH3I7w5JbonShVV
 +H1a1dVlGxxVMabVl5Q==
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=69b4b556 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=D6o9UKO1UCu5gje6phcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
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

Add sink count to the debug logs for [un]plug and HPD IRQ handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
[DB: dropped link_ready handling]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d61a8ddd30a8..b4deeea0ec59 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -388,8 +388,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 	int ret;
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
 
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	if (dp->msm_dp_display.link_ready)
 		return 0;
@@ -411,8 +412,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 		pm_runtime_put_sync(&pdev->dev);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	/* uevent will complete connection part */
 	return 0;
@@ -440,8 +442,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	msm_dp_aux_enable_xfers(dp->aux, false);
 
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	if (!dp->msm_dp_display.link_ready)
 		return 0;
@@ -465,8 +468,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d, sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	/* uevent will complete disconnection part */
 	pm_runtime_put_sync(&pdev->dev);
@@ -479,8 +483,9 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	int rc = 0;
 
 	/* irq_hpd can happen at either connected or disconnected state */
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->link->sink_count);
 
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
@@ -493,8 +498,9 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
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

