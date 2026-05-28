Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFBFCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8474610EFF9;
	Thu, 28 May 2026 10:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X8UFai0+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cC/zXPCs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A87410EFF5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:35 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8w4q9124976
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=; b=X8UFai0+9MuaAWsB
 tIK2fdVnaHnbQQpyp+mCqUUUcwy/Eep/HgeLjKDkjtUmoEl62qAVxXgMqGMo4VXv
 GI3up3BaHEqibRKV/SPGf2IeBPSnN0oAcM91PIQmKUJ9HEvcvrIn3UMegeBqIfQ5
 xj9gMFb6aBIUf+DSsES2/0JaHBqS1ynM3d1ntqfACuulRvyFdO0cvjsjSeilEUs1
 crNCdfoaQfjpLtG0rCijSKpxZiGP7iTloDSYNfV6qnis3u3g0iTtrqEw9WVKggRw
 m6mGKPAJuv0ZewLwdjiTsdxJEKmhU73RLvYzQWTv2T5M11Y62bto4HPJ4KKQxgrD
 pga+nw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycadqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-914d0204c67so993635985a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964894; x=1780569694;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=;
 b=cC/zXPCsYmXCnvPwN2CzM0sXCldBDGgs+yjXjbn1oXqA3LgeJj+svCYp1BvlrMY6Lt
 ynNjgaqNTTA/a9r4d1NrpA+rOkIO2xYhaoAjkBt5k0sEHYXetr3bMK1ezRYAdBzC8a1C
 ykohA/7JRnhSQVoDOyjs2P24qmpTpl+OgIYfDOPGGEjnW+SBG4jjI8I4eP9g/z7Fchpa
 CYIuxOwZx5a4nciWiJo1jgJ92YnLVcUvXVn8/kqzFUQH7tKdsDMWRcDeOBVN3oMlE/Qr
 oYyNgPIS/CkDMFDA53Iu34YKKazSm5Gv8+8AuO/1NhYP2JnKaAK3TCT0nOHC/xH1Mql2
 /lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964894; x=1780569694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=;
 b=Zwzt07W5QG8qv4RxChzj/mMYgHkGukH0tuVnJedXG08EZJT3ZdaUISWdSqhHl74VVK
 SCCZ5AzM4FIOe4SjXx3PoGDZYPmOnXpJmo0nmL7KByL43rylyQ6ufFTouOzMabGQHjOL
 B3NkoICnzQEl3C/2oNl3dnkEncGFFXMsLZn3zRXp+HdHCJKripp5ReV5t60Hs4ISILVN
 lfmlNQEbmF9F9Dry5kWox36E8bxz7/XKwP9y9deaaERI6G5mjmWMwEDR0AqnBtn19AD8
 TsxmiW0OqsNxEOItvbgdGURM9z6lFxbiMfE+hZTpPHhRgbzZS4P991BQTp8o/d0uQpYN
 Ks4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+htlHzcSzWJ1Lcnv0kxcg7OJiuf6zxVu3MZm6//1fusBIBqsnpb8noGSJ31lE1bVG/Ov1CIPaz7Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywm6mzojy6gEYwQTiyLB3hJwFQk+sfcgBKxnrOqnjf5G5HrSP6n
 OSWb8ZQMjJYQBL1+aflxotsYPODQjmtnIDy9ZeLQedL2QxYM2D3A7M+hghq2pLIaJ+11NjWyp08
 ATMRxLsj+BXNlD4UY3nTEn1YJVkgbeZeuEZ4jLK4teXGsM+vpxq/ihH4ho8KyIEVBCVC1Gho=
X-Gm-Gg: Acq92OF+o1KnBWuHjcvrAOfOoN8tODglucAteuuuqfLXplxG1fv4xzHRshdSURCrpFd
 wsyMFaaEyUlnciBOxe0IBv8X4wxX8zm9/vHrO7H2hYl3FCm09NOJIrtHrpcMCNgByu9PTGDbBkL
 ty5fOXHcSEx59GzffAJoQoDodMs2W20mbOUcMPuXDPQcRlme8LfxOoQHU5lOdR0cPSISOr/V/UW
 B/u4OHcCHHrnqxYj2pu/h+IhUE2hHdL+ARJdHlH2nwaeFTMC0olc34rYV8p5xxJw7F1IwpMxJeq
 CEtP9lh/2nQN07wWqSmL5pJ2z2w3XVm4fmDgdMVfx5yL7cNEhhQLCAWSkiLL7oM7ntcpYzbN9jn
 GW2K1hIhClEJilDPqUAKPMh4tlTaaaXY6R/p8dLib4P7OpAVzpfQrOAKwUMuPmwLZEmmoKI45oT
 zZugYzaTpexYsisCLt9w==
X-Received: by 2002:a05:620a:4608:b0:8ef:3953:7ab with SMTP id
 af79cd13be357-914b4974690mr3816770385a.40.1779964894481; 
 Thu, 28 May 2026 03:41:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4608:b0:8ef:3953:7ab with SMTP id
 af79cd13be357-914b4974690mr3816766885a.40.1779964894022; 
 Thu, 28 May 2026 03:41:34 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:33 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:33 +0800
Subject: [PATCH v5 12/15] drm/msm/dp: simplify link and clock disable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-12-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=1745;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=4TJKG8RTz4R+dv3UNXgRl/mjeEf45SUuZJzked/IkbU=;
 b=O2vDyy28Q7m7hkeaHk95FcqK8jDLNnDpdGRxSppdMbe8o4dOhJ9Tlri//9/rgsR4+pALPGcry
 hGSxUNPZVS4BGE82XwS86BiSvY//xdZxMeVXzMHqTznPpXMmplATIXV
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a181bdf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=W1j8KJVysGQzs9t885kA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: cJkPiG4tVsMpBKcoThVnveIiyNK90nmf
X-Proofpoint-ORIG-GUID: cJkPiG4tVsMpBKcoThVnveIiyNK90nmf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwOCBTYWx0ZWRfX7KcWUKluGU5h
 HTPHe/q1DvjhaA9TdbIB13iiDHdsIGJateiKq7DlOodHL+sZVyAOvpjVZhQe0yV+9/OeXD7XcwU
 lbGBBYX8nYV9liQNrazipv982xSxV3Kbi0XEq3BJaHdbFumUimmbCyZIc2qqv9calPML4KtVCGs
 XUBlMgiavqPW3PyF7GChlFjpFIqOD7qQwe7uNbkNdQX5H7BN4JfZu9JcWYuZv7fnGBTGXMFbg+7
 /w9QTWA2Sp1BWxo4XlyG5GwuQGGpIK+rNCUojCq+u/DoUx99ZAyaB/oeA8FbH5MIVb4h1jpq06r
 gbeFd37mxHlZv7q+eGc12a6PjwNOEsZh6Q//tKbNbKaKDip3qDDWL6l5qVlJYyDx8G33G91Va5T
 NBEMehLFyKSFf+mZiQWH5NeUhPq7bi3Zcr5ANlKKoFiifS6JYW8szhkpWC6sv5R7sophoCVGeqF
 7aeHXxgoZk4AO6HboSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280108
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

