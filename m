Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A244C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ED010E8C6;
	Mon, 29 Jun 2026 13:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMM5j4DD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJ75ethe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABE010E8B7
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:44 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKeJ2656133
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LzV7EjoUtPZtDBhS+QkVIWq9FjNr7Nkm+r9qnzqK9RI=; b=BMM5j4DDORq5kv2y
 8XSNs7P9RTh9Exa4hf5HT0pDCSA8LWSbpYI2OGRFr5yJpe5wAZhsfuOrRYImjNNW
 TcEoNe1vCeV152HVGfA/6b9VGvVxfjCX/LJdF8TvCXa5L+Id20Tg3xmbHsD5dLve
 jpp9/cDj1I90lxc4/scsNx+LN0ptI3HOkSR5WFO1vq/aAQGmC7uuvOPC46WNftsU
 wJF6/JEbaG77GWErkdF+pUndY7Os1kGD3lI09lHKp7sVDKhrONIfMO7DMo1XVmKy
 zrkAQgWgEhv99qn1YjdlMltYZLgD1Q3vyMMaqaNMOzg+lcjdzcIIo5f0n0/ygfjw
 kAwBTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gyg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso68147826d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739063; x=1783343863;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LzV7EjoUtPZtDBhS+QkVIWq9FjNr7Nkm+r9qnzqK9RI=;
 b=UJ75ethe1US6Y8sD2WP/pS3wCedX2kROBAtI2ch+cQZRRJJozS4UE306LfwkGISmy2
 YwLDZW/HY2pAkipHX72kso3SnOMayQzXKds95I5SUSWE9OwVULZ/VobFdV/tXpg5k4hg
 6pU5wjH6RCddYXuLs9NjSX03B9LKzpy5nAx59fLGcwn3JklWMX3hu7/eY4x0DrvCOT0B
 Mdg0yIMfRYiO3nTII5kGfmpshRgkxzog39ggc1DAmWQH1PBezW/v4KF7qMockcuVr+hA
 Hl+3TZ1ibTGXKm/mf54s0WT0v7oxGwb0XRS2NptKa/WQtattHZfl9vy1tnNRGYjXIr+6
 NVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739063; x=1783343863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LzV7EjoUtPZtDBhS+QkVIWq9FjNr7Nkm+r9qnzqK9RI=;
 b=dF48GSN+JlmdMwEUJxxIDZAnCpCp2tz37E0Ib294DSotd0rYC3nGT67Aagmgph5lvG
 C0/sm3ZT1eYSo0GwJB+OdzSs/qz9UxuOFfNymuCARtUEhEzESJ80V850D0IJ6p7+1Qu2
 Y2xjWmkJRPnb+8TXjwmAQH4J7P7fyG1HJ8wWPo/tboeERLA2kUz40iMmD75tDLQhw4W8
 k1kbAi9GtkoLWhdIv3CWar3Z6kXrQF5/5eXnP9I5V3wVnHtRe4EoSHMyRvdnjt7QlnId
 /GaPPkjFPJT27iqcxkLof+NAfCOIFb3P+sxAuDPZ/vNh2Bp2gllSXWF5tREhzJBy5xPx
 AEyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6xIM9Jwt9J7KKIUczzdp3k0yblb5gW/Yn7Wh8Mn252DZEYE110y8dFPYfcq2tn44Vad5DCrIskx0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyEEf80Cdk6EuEQegFfclStzBTrl9SLm4oey5v76neUv4n4Vl/
 JSF3y2xz3pHb+6EkotuT8j1aasWknqgcYBmZuqIxcZmxcymGyOdQitSjM77V21xBrqNHeWFhX8+
 GjJ25U+kuYMD7W7JoGPx10h0/aEZVGCYfmkMq/513jXcdPtGOpnKzCRwh3XzkmKMdcyp3aN273p
 Iifez4pg==
X-Gm-Gg: AfdE7cnQRCAxMiASOJtVy3uIRaBaX0tVHgGQbO77tOKT/hk0fACmOtKuIwOL6XOewew
 o4vDaP0xB4WE31Mghjmzk64WQe1+gtf3q+P39ML0ZLIFjxJQ/0/4iaO7noXYKoXGmQDQqV/jjwC
 myHiweXQT+gpTCI0dUf177mGtedxQkwdcJswUxsapa7yziIthEwa72yZJ76pr2AJKXJFenPZkcI
 RKOTl3/MzFa632UBB/NP8azpai16QM7u1oasC0O8m+dFA/0hpMkxeGzMTPKBoSei5RdbNkQPeHm
 13J2g39+EdNwDgJVakLAhK7rjZ2rFeQNRi5vbbavsys+cHI4hpMi5hslpMQTAfu8TfXNsHlnbaj
 sa80UscLIekLteESA3YNSxIzpFba4zr4tTQunNmPgf1mv/McrDgyX1+8NUfDlvCY03nqBOlJIqA
 ==
X-Received: by 2002:a05:6214:ca6:b0:8f1:505c:1d2f with SMTP id
 6a1803df08f44-8f1505c20eamr13345496d6.1.1782739063141; 
 Mon, 29 Jun 2026 06:17:43 -0700 (PDT)
X-Received: by 2002:a05:6214:ca6:b0:8f1:505c:1d2f with SMTP id
 6a1803df08f44-8f1505c20eamr13344646d6.1.1782739062528; 
 Mon, 29 Jun 2026 06:17:42 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:42 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:32 +0800
Subject: [PATCH v5 14/25] drm/msm/dp: Mark the SST bridge disconnected when
 mst is active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-14-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=1381;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=58ED0OzaID2aMTdkIIoG1uZJg33GpZvfm1KUdw++Gl0=;
 b=U1Zb7oADAm5o3+xrnnPz2levK99dw0V98Lj9r0eI95mHB3sYdSIq1N/em78YTrcv8NMqOebgj
 gTqTlr3ZRhDAyRNZYcgxFKPN0uJByrAigMoQxx4uZG8EDAXORAo+5gs
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX+C5On7LJpud2
 Cuj69spFmyj5HoMw/Dc4TJHmLSBZK/OnHHE8PgbXOTrgbN6a7Uk7ntNhZPgQvzI6+G6rp7lrlSZ
 SP9zb3Uzh5u9f11O508hYh11S4QgSqGnsukub6CEm97UtKlyKKENTm9Z5Q7pyszaipHAPvrGXnX
 WZsmvMGZotU21Q2aMWnVF/YbW9RB+QHdp7JDm1rSu+XKa3nG7fHcaxP+w3e5uheFOHvQ9rAULJl
 LrqdqGSfv3Q4BC8oMhbCj23LxM6tT8mJklyzOMpgVs2MlEMHBOXKvsLTQtxokrswsU9lQTQ3uEe
 fk+pHsJgAbuUeifcYQr2s0LvUCTxcWYx5q08lwUXr0t3qczh4m3TwRQ2iR5XUfXVpJzpPc+reYF
 6TmWzgHByqys3gvLH77DIy7SLGCeru6TgTnqgpB1C082Hg7sVcq2y9qSWrT8+mp1mFeXi6oMk7J
 +MSSOsdO0YEv5B0FIXA==
X-Proofpoint-GUID: tP2WnIDnTOlyprGw-_h735lvwJsj-DSg
X-Proofpoint-ORIG-GUID: tP2WnIDnTOlyprGw-_h735lvwJsj-DSg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXxtrl0xaNMJ13
 7Fv/MSb0nji0lCETs/owSqxsCDq9Zwr//NYggsm5/lOWHi9huik5Mu0WRydDucEzDJYZM0/jHtS
 SG/bYyUJHu1NoIGCnwhGjNDnTJMxkOQ=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a427077 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. Skips detection for the
SST bridge when MST is active.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d0081ea9f5cd..5786e598a406 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -910,6 +910,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	if (dp->mst_active)
+		return status;
+
 	guard(mutex)(&priv->plugged_lock);
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
@@ -955,6 +958,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			status = connector_status_disconnected;
 	}
 
+	/* skip for MST */
+	if (priv->max_stream > 1 && drm_dp_read_mst_cap(priv->aux, dpcd))
+		status = connector_status_disconnected;
+
 end:
 	/*
 	 * If we detected the DPRX, leave the controller on so that it doesn't

-- 
2.43.0

