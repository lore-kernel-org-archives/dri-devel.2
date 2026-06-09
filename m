Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED401CD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D25010E200;
	Tue,  9 Jun 2026 09:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OBv5PezH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aaq4X/Y1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE8310E1EE
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6598Wppn2130295
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=; b=OBv5PezHWAs57cz1
 XWIp5N/xDSpiOHk7MJe1QJ4I4YJFx6ESrzTDWcofMItbt8yA8GQCAaRD2OllUsmJ
 NweKn2wbg/MEhMz/PD8Q0lLNGti2RDjGHdim6YXP3jQeMa9Zp3gvZwIxJX4fH7Xh
 IEIWGdi0u3MpOrvhi4/qVqkS2JII+CSuT9XSvnkxscFEBREfrwhXIBnRAQLaTr0w
 xIms7xyUu+imkg68mWNn8bAeo7M9DvW0/wqpaHRBDxxDtmcqV9YHpooclJcdXtZ1
 jQMBzcQRbJWMPWZbpPbc8zhze2VEBT1e6edjLQvIawnUyM27u92D9FW8UHSycK03
 F/Yfrw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt0a60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157a31ac37so605222485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998458; x=1781603258;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=;
 b=Aaq4X/Y1cdbRM7gNdFBHAXE4ki4bP0tJWpt7XHHxUXXR4JBaZeQMdAg7bszIl5VTAr
 9ibojycF2OikOk3mNO4ecRflKfSo659FioptkOv63GRIF7CDoYhF1F3+0m/PaBV7XxPg
 tYTd9PbbpinzTCr8cDp0m+fmkpc9RQEiiBMVNDLWH6o/6fyYXkP1CbA2RURCtbUasvD6
 S6HZu6vpYiA/lmKlkff39SrMB34uUxjM7F/tUd4R3p5NpR0fzGXfSvZpLRV3NA4hNuWz
 5PiMFPFtVIWEsTkoRCa3TcHB0szVoNcxfxVHBcNmlVBkzxN6PFOIEPa73pZHfGkZPQjA
 DyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998458; x=1781603258;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=;
 b=rtgNBsLVPVEwfGkrbAVo+osJZcIqXPQ/dmzqUwCGtVKTB8EI41BWSx8UJYJZNJlAdz
 MYC6Q0tUKcslHtIe+WQ5pNgY2PFf2RwA1E9e/6oWXGXiBfpfwvuoUFxwLxYcsYA2C5Ey
 u/iUD0PW9vr5SDvNNuoQYtlllAOGRzjQz4AWoRTI0Oil7NoTHN3GzlN1DDdEAOPMAk+D
 6h/CPRKlaOw/40sXczV4r60KeAWPmmUirL6uifoiQyF7PXB8Qu6AkzVNd7Z3lOo2mqW3
 jKYNmQ2q+EZeq8WHe/C9G+sl31MC8aRwjeGnNYBj3HDNpwtEVy7O3apdz3kU0i4Ylvfp
 oR/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fzXl02DIUPluhSq0HARS2zZOwnPE3lfkxuLsKBd8os3h3yx9UMmJ308STu5Z6hYoHn+th+ZhITpI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYLAlEWNuyKLZc0b1q4OJCAk4WXNFeoNl7YQDjZmCrSz9h2BZ1
 1nO3FU7jvtSq9fyf0hSLqkoNDf/vBNH0L8wpAZtYzNQAwMLSWAJw92f43M3f4e4mIvKYNvZ9LEa
 tMuY4mSahEnCrufhG0VfFyeOdY498nl6n9wGD3NIrG5xe/K8TS1TEikVkkDQ9BTFDAen6z2Q=
X-Gm-Gg: Acq92OGPbIwCu3IZw0zFdpovpE8p6+pXi2rq6s4ApU60OhuRq0EjDsPzZEpFetsaOl2
 UjbvNeKClyw4lgKupvupjfV0KSR5KQyN4fIyLI80HrEtjkIg6neDUZ87ZuEC8A4epV59L/60eGp
 bp9FRhPesucQxGkJ+qg2rRtUT9ocHpzV9YMPJXc3QMLprPUStjf+ezM48aGwmQu+SJd711O+EcL
 jyLvxpt0fqvN1UDwJbeEonDNTYJp32ROsCbrV5BQV1W0iNKGacLJOlFpty5RFCRVAd931sCoUFa
 c2jJWw4RNP7QHruMHvZmsBLH65BNMDViWAlCZRFYCPEcjHzlCVIrjjpUL3N6vwBVG0xhHADVkvq
 PzkD98ohiKxzXXL46v4eNDQX228yyEY1eEykqr2ULC4of44NXrcq9kSlJxMkxNj+Y6+2rSIa1yp
 shEh/+c0WE8f9PgI+yGQ==
X-Received: by 2002:a05:620a:410d:b0:915:5930:94f1 with SMTP id
 af79cd13be357-915a9df2c2bmr3231751285a.47.1780998458166; 
 Tue, 09 Jun 2026 02:47:38 -0700 (PDT)
X-Received: by 2002:a05:620a:410d:b0:915:5930:94f1 with SMTP id
 af79cd13be357-915a9df2c2bmr3231748085a.47.1780998457753; 
 Tue, 09 Jun 2026 02:47:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:34 +0800
Subject: [PATCH v7 12/15] drm/msm/dp: simplify link and clock disable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-12-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998393; l=1745;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=4TJKG8RTz4R+dv3UNXgRl/mjeEf45SUuZJzked/IkbU=;
 b=67mFLZcs9VBQqLt7xo15/S6j1IHHHZ3K34SenEqCrc5lvTHl07V13t6VKL+1o2FuYFBz0V8t7
 2Dn5yBchox7BFFHn6ITXS4bw1TUlLoC5CURYvnEyvl8tl4vePoZanFU
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: P2FXi88WdR4j0uSriM251evqgrr4DuxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfXwudNaGvFdXL5
 DVUxpqxH07kbam8IfYcsVOPIy02xYzucGhE9LPOsKZOVcjICaBHoNqUjuNiHtpfy6foDyg/j0MP
 vBmd91zO7Nd5pPM47sLugW70RYaJSrQIsoSfUfL8izC6FydhfVUAXvGk0FYt7FIz2EylZUKqdfO
 Yx4qXbioL/iL4khN5sU1aqWPh+s9Bv42jBvB2LmG7cWsvlTqhbynyGwvtXVW2RxWpStFPTzRJ/F
 Ehno9g0pBqgFG1kUvHYzQcioV7dR/8yZBcxhOgE0Gdk12amtKJFfk/4KVd1H+nBhKHJ5fpOKR45
 9bsqLGZHbU/iI84mO6Zw8e8fyzh9LTw/+ZCiB/bUL12koiMSpTkDSZZfh4e7nzOiL1nUjfzgcwh
 8oSBwP8ROg57W3NiULDGUHS1Yp2LFJdFYdiNxfLWDIBlOeHMXNqZ/SWRK1rljact+4MQc53TYT5
 fWLI//2EypzoJmGbZXA==
X-Proofpoint-GUID: P2FXi88WdR4j0uSriM251evqgrr4DuxD
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a27e13a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=W1j8KJVysGQzs9t885kA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

Move the common disable steps out of the sink_count check to make the
flow easier to follow.

No functional change intended.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8f472633da82..63e5b191f95c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -716,27 +716,19 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 	msm_dp_panel_disable_vsc_sdp(dp->panel);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0) {
-		/*
-		 * irq_hpd with sink_count = 0
-		 * hdmi unplugged out of dongle
-		 */
+	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
-		/* set dongle to D3 (power off) mode */
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
-		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	if (dp->link->sink_count == 0)
+		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	} else {
-		/*
-		 * unplugged interrupt
-		 * dongle unplugged out of DUT
-		 */
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
-		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+	else
 		msm_dp_display_host_phy_exit(dp);
-	}
 
 	msm_dp_display->power_on = false;
 

-- 
2.43.0

