Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46495CD6E61
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A223310EDAC;
	Tue,  2 Jun 2026 09:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNRyBhCc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VWynz4uG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B03710EDAC
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:12:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65245lQI2692219
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pP/YEN94t1y4drOH5CzH4TOHLceSrZCrc4auNY99UvY=; b=KNRyBhCcoQIcRgf/
 bgTKaLmkKeNVAz/EMC848Wawi0l9agrXxpDz9G7i/sifTAmf+ybTGJyAIkSOSxID
 bL+pvBzgchsLgM+WZzzEyLB6cxNkfv3MuIgHcqThcBaDM6JAT+/qWCEgqqVUcMYk
 Ou71Wby4zlbTi6H9N8I82BCRf5qxbCzUZUPcVXUn/iE2n5n2yun/sdqCSrijKKeo
 C249KjHkdyYbycGG2Q3/ul3DlDH9i3QgxwnJP+IjTB4XFX3iITo07bdZltP7Wpif
 6RR5nqvnwQ4GuVCywJdu2Agg5O4geo1EfrHevqX6oKvFHUFm1d+OthcftEGW7Kxb
 /QN0Xg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumh6hq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:12:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175aa1a54bso37103931cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391536; x=1780996336;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pP/YEN94t1y4drOH5CzH4TOHLceSrZCrc4auNY99UvY=;
 b=VWynz4uGZBujYjBxwMTjd3pNC0H3BhOmnPytyt7kYPdrRk9qG1u6DfzxkYmacSDm2/
 h6A0EZm84QlyGPXeQvt/iT/JzBrzfo5e+LWyPa6GufhP9HGI7/rftlYC1pOP2dx7Lo49
 zDM/CkLvh93kFDiDfSIkO5QtAiQG8Y37PPHEEy6dTESW+7QVKd6QP9aP2VMawjmZK4qO
 i5a7C6odF5E/2zw9l+cr9CXW4tBE6SfrqBsYWzNLnCZmbEH5yz0FdgGayoI9TiiyI3jf
 wZDfUNaEZvpmDuTOhxHOrKpjBaQKxEBj2nApYkUTaHMBsCIixCjvSNHiVbOqO0oJLl4v
 7mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391536; x=1780996336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pP/YEN94t1y4drOH5CzH4TOHLceSrZCrc4auNY99UvY=;
 b=mmwtDHX41nN/mhLOt59l4RGnHMNdokdGhaSFnlGgRPiIRC9S8xH648C8yfIYD7/NtP
 D7i/0CdyaINBsyjxjhTNU3fMuIR4tvuN7UzwdfRuLfFHahXrsjCfcFmN+gsMZ53HTuTn
 ix4rxbyuicSPIU++uw8tL0OLGqzgpQHmofMqu8+c22+RlYPQ8r1w7PTrb6BbeIGrN7mz
 HZENrstj1ezcZxLfGI0koR2SIVWjZhOORZUBKJpl9zSCLmGFzys8h29+L8H3KraZSbKN
 /WYrH1xlfzZvp0wPFKwlJ/fMHa+oEMPWBdCTbC326BSfMR1Xx23mylrVqaJs4LCSpWMq
 IXkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KQvXTsufuPU7iFO3x00SRid06NrI/6nw9XlxBgTP3g/8QAgfVctmV5WCLQFvacSVEoG3ySjotIzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkBzsigDEOjz05hU4diNabOgqFpROwjsLs164lGKnsEFCuzo5Y
 3ellrjKcDfo1wVYFBG9uuC1qCqTGei7b1QoSciEVJUyx3guwfZWejcLF1ZyTIDtN5EdTQuf33Mq
 9Iu5mU/YkVDwsfoYqnXz/+e5FzlWCgDQugm9YTqsJP20CmtB62s7Pxziojf++5PbeNEfaX/M=
X-Gm-Gg: Acq92OGgXMr36dNsd8nG+9HfzBSJqPlm+QZjm5sS22RfubqkgVVY8xZ/0a/cwAKZ1mG
 K8fvUQdSCx8YnvKkjWYY6E33ViDwqPIL3kRt5i0vU3ZS16ntKLx46wBKXhl8nxS8qZV/53o1Ca/
 2csdalYsso483c7voKtYUYB9+dCB5gDQUynYP7hMMtsEjkdGSeiDlJiADUvh/A6u1Gs6eBxqDbv
 rBlGhM/FzJNPpyV/ni+tkaaxApCmT45Vdpl0VKzUrOXPZYnLIjQiyjUpoj9MyRp0/N1eJdX9+12
 vOcqEfNK8zJNpCajhZbFNMVRodS980Ci21wiEm+Jpi/i5r658BkheE5YxmzeQpf/ThEUWxNOeZL
 t0Q1/onDscaMoz2U3LGINXmjnNpEek6vs1AWk6caTYhTPzopeg5I3YmHNz1YU8LsG7W1V2gaWya
 bCxkPSDag9OkwS/Puv4A==
X-Received: by 2002:a05:622a:8f1b:b0:516:e10f:b1fa with SMTP id
 d75a77b69052e-5173a6336d6mr167602101cf.2.1780391535935; 
 Tue, 02 Jun 2026 02:12:15 -0700 (PDT)
X-Received: by 2002:a05:622a:8f1b:b0:516:e10f:b1fa with SMTP id
 d75a77b69052e-5173a6336d6mr167601781cf.2.1780391535411; 
 Tue, 02 Jun 2026 02:12:15 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:12:15 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:23 +0800
Subject: [PATCH v6 11/15] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-11-2c17ff40a9b2@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=3896;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=yXTeHtGoeumB61qfMSu4s70qnNcHeimTgjHJ10HGZIA=;
 b=4CiVna5IhAqn8eXmUh3DDUaDP1YSx7SFCAhVi5jOL0G9RpUkR379l+6FAU2Wnz2Ze+wWoQ0vU
 oJ7UZfFNxEeCLAoXayag36/4ZK5b23E3cJHFhZz6xUdkZWKSSTVkwHu
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfXxySDZa3mtd5x
 GK/m0uIJxmmZwUtELT9EoVvdvlneS/KR6wEB1uaP3Cts7pM7NP3yWZsQOqL6mdTPnffsDKKZ1LA
 ds/i109DNaXfZqj7RS8rk9nMeBDbwGwzwrfcrKhfIIMBWO9Yb5VeNO9Tl0R2ZX+HtjwP/v9JatY
 SnD5R74T4/l8HJ6+Iv3q0mgZ+f6y0cM6veVe3CFrn6tQLoPVeO/rTgyvYssOTkdf/+FshNiK2w4
 Dibgnn3dvDaGy76GUjn/sQ4iqb3iWSBBiAQTQ7MVv5nWLkJ/qUV0W7Rl387D6OY2oZXdpL2uavM
 o6Tg0aQvnTmBh6i4sw9MWS08hT8FiRaXY3f29m9o/YCXhgph+bT+gxjCRqLIRcLR9TjqVdT/yBl
 9irD3rhL0X4Y9evD1TabeK1NFBNP7NB1WkMn8fnQ5VGGWVm6Doz04aXXytJSd6k7XsNKFALxoX5
 ejv29kvJvszmVCfTTjA==
X-Proofpoint-ORIG-GUID: 4-ujbkqn55nxoqox93eeRh7fPUhYt4kB
X-Proofpoint-GUID: 4-ujbkqn55nxoqox93eeRh7fPUhYt4kB
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1e9e70 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2kxiPxfbkJi5fZIrDGYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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

Split dp_ctrl_off() into stream and link parts so that for MST
cases we can control the link and pixel parts separately.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 10 +++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++--
 drivers/gpu/drm/msm/dp/dp_display.c |  7 ++++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 902a6f5d181d..c88929d1fbab 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2212,7 +2212,7 @@ static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned l
 	return ret;
 }
 
-static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
@@ -2241,7 +2241,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
 	if (ret) {
@@ -2635,8 +2636,8 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_init(phy);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel)
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2650,7 +2651,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
-	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 00b430392a52..5902cf7e746a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -22,8 +22,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train);
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 230e14615a23..8f472633da82 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -725,15 +725,16 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
-		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_display_host_phy_exit(dp);
 	}
 

-- 
2.43.0

