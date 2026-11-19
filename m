Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C1606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcTMoWPh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TP/TJTpP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE5511215E;
	Thu, 19 Nov 2026 08:26:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5605112158
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vFcZ1681179
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pPO9UzZPVsaDzgbO+XFBnwFaiT4fUA4lzXiiqyQTXJE=; b=RcTMoWPhevrzXQ2A
 HZi98H71JvUb5Fn73XVIjDhDKkGeIZKYGFFoz4d0i/ROiSXYOQ1bdRPALv8gSLqM
 gR3u4YmHAX2RPVPItL4hSRE0q1DVlpEK2AIeDPhcJYAdsf86yURk0j/uUfQHkNP1
 pEZGgmrRhoC6Ut6Q4a4q6vgB9pvYJdrPJ3Gc0DR59nYPlsAZY6joME3eRPTsIGxK
 GRgJuOO0fNV15HrY1VSoX91GC0ZUw8wL5olc282r6nWmzC35HQqhsJdztBY88ixI
 /S8Uh2EGThZ+KX5FozGYwAlRDt/dCj+DMRzVv/DEcmnGpdfm2gr+HX0TGe6xfTI2
 0YgJ7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcss4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961ed97d6so144671685a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076788; x=1795681588;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pPO9UzZPVsaDzgbO+XFBnwFaiT4fUA4lzXiiqyQTXJE=;
 b=TP/TJTpPzr95Z8+/OZ1b3vm7hTwJpS8NmOjcmoDMsnOEOqBuz49aFhDbTcaTdwJc0s
 j4fTrjj4eyG9hozf/nlnHNUHONGWnyNfu47vxhhx5GUs79hw6sJEtwb24YfGC7wG4XnG
 DhIzyd+gII6fboEEg/QVv3f4gRqO3wB8c8i2YQgKv3eNIr2I1MumkEpSCHA5b5fknFhQ
 D3XoeSczDWPuVsWDP3y75P3WEmmbohRZdTQt0ph6Sf0A/L2phZwaNrtUpNQijaAO69/3
 MV4FSUEOVqNkgv65KjK8QB5XG+OpgwIu/MSeWV3CB8zqjjArzKBUNtJXfj0ktkgwspXv
 oLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076788; x=1795681588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pPO9UzZPVsaDzgbO+XFBnwFaiT4fUA4lzXiiqyQTXJE=;
 b=JJVXhtbAi+RNuiSWZ7j3QnMhTGsDB+WT/Aq5bzq7ZIYoQMqHrikAiSjtw3mFvImZo0
 bLMuGnlBC+SayTByfNyZhqn0i2S1I/jhUVczKxjq5TFKmmdLDj8bw6XI0hCZXsSmBfim
 rV7NxGDZj8Daj2hLV6KL1o4uPYzNmkndybOpEeUKXBRVMOgEoVCJJM6T6p36ooQYV5b/
 l8DQKTIUPjv7q0TIa0JjkeTqDsrgh16V6V5VSvwN3yR/uKSVahT39gaRfJjnkpDauyaH
 dHpnsEv25BhbM4MI3wjiWqBU9jTqcyrbowO3vOT1DX+iNJSXhzQBB+eFd9kmZzV6/IOV
 sxBw==
X-Forwarded-Encrypted: i=1;
 AL+hErE+7q8XG77sSrZsebzsp/8709rJUryI6eZznfgyEYBeySLanghzNVyiIN5fEFRscxmhnEX/3WbEWZQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/c6MiftfLhmNpKoI+mR8GLEFUiIsPU0cr/sg7EeeYzpyZORgqQ
 H1iCi6vWc96jm/EQT+q9ug96cMUBDIFWLZc4IwW49Wia5ylhGjhlfY7Gsldox1DjjfCroHQ81bO
 AlQE8xwbiaFy51A1nRb6GkTCbWNdk/zfMrZBRfAB9pJVKv4ivzeaLOaRTl+wAxl/Hp12Hz9o=
X-Gm-Gg: AYBFou1rfS+iXZwJo7B0dRmJk177nbRJXkHm8Io/Svw98pp+D3Yd4YSk5cxKamSXuw6
 Bv93KwZBw4v21HylpOsEUOabsoTYF7c4s7FHqXso/2KbTI+6nKpAIEpz2RFjeqgTTM8zYa44usH
 g1XGdiaq7uWaCw/EbYbHizF9WPRDW2QsKUY6E8Y4HPirBXlzD0Esi5tRLGUEkH0GLfcNU7mSlTB
 /SyiOloXvAKc7XVjv/j8Hx9y33zRbC7XsLRi9lOuq3aG4453AFFrrdH7nFtb6u324AqhCFZ0OmM
 FD0g0jBpddXz3bLSlJv+/ILc0Iqw3RFyTIoykbegbQTwKYTaVxadsHS6QxcU0BCg2Qq4PWhcNv9
 dbYgTtw/n7lxibEnTjZTzACHhaxsVSp35sorBFor78M+TvHsXnnmJM0dYfv9KWA5mTHB2AW1XWa
 GZrJYayWKIPscBf6nesxkaIlFTYxDtqndLxhef
X-Received: by 2002:a05:620a:1714:b0:93e:7ddb:4ee1 with SMTP id
 af79cd13be357-949b34d2748mr63530485a.31.1795076788017; 
 Thu, 19 Nov 2026 00:26:28 -0800 (PST)
X-Received: by 2002:a05:620a:1714:b0:93e:7ddb:4ee1 with SMTP id
 af79cd13be357-949b34d2748mr63527285a.31.1795076787363; 
 Thu, 19 Nov 2026 00:26:27 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:26 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:25 +0800
Subject: [PATCH v9 23/29] drm/msm/dp: mark the SST bridge disconnected when
 mst is active
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-23-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=1111;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Ky+XcbutFyz/cXz6z0Zw3/ezOmjUUoQaMdosLPDLKBs=;
 b=nP/fS22rtyeubTiHMyxRIV97lTbda48vdtxjL7JIoGUxRD2Ku+jhLfwSeN76QcaFlfjcYF6VW
 4woXV4WT9JlAnlZeo/FSZjsjB8nFzoAoph2ghO4kf9S+utvW+kTHxcN
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: 5ulL5c6lgeKbH3mPRvOixmep3mA_ua-W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXyZMuv2zzc9SR
 TI7A6ZO0XZf6aJ5dlB9VcKZKS5/V9E3tf2ruIX+cTjbdeEgTm8HIyPJf5tl2xe0KENuIM7yQLRy
 5P7WrzgZ6ZFj1PGH+I59Hdb2t00aXU4=
X-Proofpoint-GUID: 5ulL5c6lgeKbH3mPRvOixmep3mA_ua-W
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afeb2b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX9MH+PY3sljWC
 buK7wAQYmzQ19EN9GkPEAltc6ueEkA3lUqBbgtSxiWxdYxpv/HrNZw0+CIrA+IjAXj1CE8RfNT4
 JoqUyNra2gfGBN9IP6kH/hioapM8jVluZYAPaLXCXY2jdkf1UkCz9snSGbEADkj365AgMMoGcjD
 4TQCZhWpIRAZGlKL8+0wvdoq9+IGZ7/NrrmXnaywgs3Eq3qRFuFgwdtaLOrObuYEKLBCL6f5lcK
 JzKwqFLURMbdmJNxRKNSooy5FiPyTYQHklZ9EHrQTSkJNK401RJB4qk2025X/TYHVt2C+5/+eSj
 78ld/+jnZoAXQMpno7sNb7CLRlFuEFYcrJ55vEC9Qby/HoD68DOCyKYoxKrn4omnNopMwBrtl9Y
 xgA/N+MVCXS9J6FI4Vqg48QGe6QiHGHUvG70YhSx0Jqw6w/eWJrdJ4j0l2xiBIdG9Wlm9w24tXB
 dvng+w19CYw80gKdWSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. Skip detection for the
SST bridge when MST is active, matching the behavior of other DP MST
implementations.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 75eaf739b86f..17487a7900d0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -976,7 +976,11 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	if (dp->mst_active)
+		return status;
+
 	guard(mutex)(&priv->plugged_lock);
+
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");

-- 
2.43.0

