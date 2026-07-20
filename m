Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2582C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085E410E69D;
	Mon, 20 Jul 2026 06:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ppmFMSkl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PZlQ+UzN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E87810E698
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNs5jg1910719
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sAWajNDsmDdfgw72NoAHcvCR3e7RdbDxsK9dwsX38+k=; b=ppmFMSklB3436Zxy
 9PqEsxzuYjTG28612NtTCjhLxX13bY7JI13nWGJaLEvyY7iHGiycLUpeBbyultxR
 bMWEud/Cf/cQj/U0Mk2KF4XK5Lm+JSNLI/cE6UfFXmVu4rebDnRUve7hcsfXkcRc
 gxWAzritBaWM3ztG0eI/Ii4L3CvyAHq2zuT/WUYF1yzwI5R9RjukbASPNcF49wFm
 iuseN8aMW4RAcWo53X4qP+/B4BUQX/kb2TimobdIu0k33D7EhjcDLWlYF5WWq5hB
 Zuh++wrsQDQhYlslQLcxshQ3/ztBTNV5XKIdQIoEkizZFKt2MxUnBbUzxuIHM+rd
 F9UhGA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aavmke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e623b0e95so1388518685a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527885; x=1785132685;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sAWajNDsmDdfgw72NoAHcvCR3e7RdbDxsK9dwsX38+k=;
 b=PZlQ+UzN3A8yMAievUwdwoWDzBAy02NfT89hWBZzBBi4J02re/NVIyIb+HvulHje39
 57O0RAwQ2GLSJ3JU6FBVuGPU1EJqEs9v2qfCmEbGlWHgYFQTwYjDlaSaIqkLAXYN2ynw
 KBtHSVSxcQ5dX12sPh3+pEPqrhNrGOb6gcUDvvYxU0p2zV3Jnti6rqyNQot+V1c2fLNs
 q/DBtvBFt6fgSMR51JABOAigaYrJA3LQbrGbpfgqz4HhiIoUuJ2AUfAfUrXY2DJBJYhV
 rjDMyArUh90PWlCSqPk5sLIViksCDbDP1hLWdhP7Wnvh/iA9zyiFWK7Pl/NnU8GvzA3b
 5OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527885; x=1785132685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sAWajNDsmDdfgw72NoAHcvCR3e7RdbDxsK9dwsX38+k=;
 b=Y8VYJFv7PghvwyO0XZLmbKUdtEy3A2Y3owJ5RqpcbWi7BZ1oz84Lfyn1FTOxVmUkiI
 atpMOM1frPOIL3lmO6OhP4ltMaUJqLJeqq4GtxAbzO0/EkeX0dvs5JumeOuFYOhEFbqV
 xm2gdkdffHGqZ6CzLA1/aAHEL/mXz46xq4qPjUCy3PCFzmd5OpaoqfmlsxxyU6sdlMbx
 cxdwgGvwG2x8gYi4euAY7/VpCwlrvbL3IkQawaqJ+qPlJZlJbsqxTYDp77Rv8uj29FTU
 8lLMuZ9vmVxf7kJSw/Tul/s6nusvSfbHab80rfljtzCI71aM65OF93xfUY6TpskYOocl
 vcLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpmikbl/t4DqR2aW7nILgXGiN3QdacSz6i2qQh1b3AWqY6diyyN4vBgeLLUOm23o8Ec61OPiZYI4K0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/EstTAasvOdZeR/SdrTdXAiDBlvEgkihNzdX5IgKvsQkycZA5
 1P6aza9lTYgR6gvR4EOiL/2jAQKBOlikdfJrZD4MvwUVcbtvck8NUHYi8Rj35/0bsqPC2OZHVM2
 u9/Sj9ZjULoF7W3LLOQReiwq9ApV/Cd16LBKZM9SSR0oUnaMXKqIbEJ+UFnOGBX4qMMq9yoc=
X-Gm-Gg: AfdE7cmTAQJrSEbD1q3lv7rhjTKIYR/EhwlPc6UIFqb7SBLglU286KcYekyrQJ8HrHO
 XX6LdSvCaePAEEEHyb9tVrs/OiayVhvpVNNxi6lkvgJfsmoKjLepU4HWoLAr7yQsJaUjKa1pztX
 g/zjt57t//b16iR0lcY1v7EPVxRwib8e8ak9khWRNUvHKVxmT42Z4rj9HZvJkMsf4bVSn7HJJyH
 ukk/t3YfpMxmUSe4hI/bQorDb82eXxBa6XJ7bdRJ4lM+i8FPjW8yvD90KMWpf8n/hBPk2Hh8oeH
 Eq+IMb4stpzQ4Y+SCG5bovfaSzhwxVSd7acDsEurney8qFI72eGoISvVroaEgCWSdHio370uRCo
 AX/juYCK4LNyZAnpK2s8ETkgvQaUS17+PN1u5pEnZPjKNZ6GiilxOr9RB/WYP5ik=
X-Received: by 2002:a05:620a:d8d:b0:92e:db54:a2bb with SMTP id
 af79cd13be357-930b430817emr1250669785a.64.1784527884858; 
 Sun, 19 Jul 2026 23:11:24 -0700 (PDT)
X-Received: by 2002:a05:620a:d8d:b0:92e:db54:a2bb with SMTP id
 af79cd13be357-930b430817emr1250667685a.64.1784527884421; 
 Sun, 19 Jul 2026 23:11:24 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:24 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:15 +0800
Subject: [PATCH v8 08/15] drm/msm/dp: break up dp_display_enable into two parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-8-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=10329;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=hRpmG1O4u0ItaVOBRpgfp0VdhTJDT1a7d1EXr1Y1NZQ=;
 b=pYJS2Ny10rtwnjhmq5+hOOZYBvFl2tXORlmGDlWwZaUrH/D3jEOxHKrIF8fEipzabRv47T/YN
 g/ppEs/yBH5DAyA6WdW3qtPoBGjXNDIpbriJL8T3Czn4DoWGRRN+Og0
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 9FeMcwwI4xuyGYPffgz_oT_YyxCrIZCr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfXwhgU4cVeDKcq
 iKhMEtC9EdhSo6A2wH5tpPGdEc2EpHJ1Xs7vZ3GivQDnc9Fz+10TjxXsfBbaTX/77DNpHD0GAES
 t22DYTILqUDHKgswS9klRT8awebfhEI=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5dbc0d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yY1IV_0HXbUsaRqM5MUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9FeMcwwI4xuyGYPffgz_oT_YyxCrIZCr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfXzMFCeAt0yEjQ
 D6vYCO2S1DSvAHnd/15MOfLl3uUBn19w+/E6bG1DLoR/AOhn4C1g1IvZFdGPSA6H6oHHO6Qs5zx
 2XctRBs/D7jhMa7rFjH179HTx7tqunIEJ4DKqid8gDtUREIN9fJMgqR017sauSuu6rrn6P0Z3r6
 GyeHtC1VSa0fBYeoX7sasqTtD35e915B+k+4frd11f2x/il5G5WH/D9eIDh3m35fHmfw6Ps90DT
 2Mj1juWEyfLQPFmvP5Skof3gyWr2+Kb/uB8/55agFbMV9YRHaNRbOrvq2puDBOkAVDZgmXYEGu8
 jlLBHxb4TOSVx7kwdoIL30CaMArxQgrkQvEYmnixXJ8tNFRp64goxu4H+5oJrmQqdxIJ+yYnw5p
 iOr0fjFRZYjdDvekgI20zbOojMmTjgbp+v+qhyNa1aBQw9ibPymAtX5EVFUplw4GA/VsHmEUY5g
 i59Cj8dFxlKfqg+1/Eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200066
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

dp_display_enable() currently re-trains the link if needed and then
enables the pixel clock, programs the controller to start sending the
pixel stream. Split these two parts into prepare/enable APIs, to support
MST bridges_enable insert the MST payloads funcs between enable
stream_clks and program register.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  48 ++++++++++------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   3 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 107 +++++++++++++++++++++++-------------
 3 files changed, 104 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index a79d9bb93cd0..32607eb678a0 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2507,27 +2507,19 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
+int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
 {
 	int ret = 0;
-	bool mainlink_ready = false;
 	struct msm_dp_ctrl_private *ctrl;
-	unsigned long pixel_rate;
-	unsigned long pixel_rate_orig;
 
 	if (!msm_dp_ctrl)
 		return -EINVAL;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate = pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
-
-	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
-		pixel_rate >>= 1;
-
-	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%lu\n",
-		ctrl->link->link_params.rate,
-		ctrl->link->link_params.num_lanes, pixel_rate);
+	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d\n",
+		   ctrl->link->link_params.rate,
+		   ctrl->link->link_params.num_lanes);
 
 	drm_dbg_dp(ctrl->drm_dev,
 		"core_clk_on=%d link_clk_on=%d stream_clk_on=%d\n",
@@ -2541,16 +2533,40 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 		}
 	}
 
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
-	if (ret)
-		return ret;
-
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
 		msm_dp_ctrl_link_retrain(ctrl);
 
 	/* stop txing train pattern to end link training */
 	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
 
+	return ret;
+}
+
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	int ret = 0;
+	bool mainlink_ready = false;
+	struct msm_dp_ctrl_private *ctrl;
+	unsigned long pixel_rate;
+	unsigned long pixel_rate_orig;
+
+	if (!msm_dp_ctrl)
+		return -EINVAL;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	pixel_rate = pixel_rate_orig;
+
+	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
+		pixel_rate >>= 1;
+
+	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
+
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	if (ret)
+		return ret;
+
 	/*
 	 * Set up transfer unit values and set controller state to send
 	 * video.
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index f68bee62713f..1497f1a8fc2f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -17,7 +17,8 @@ struct msm_dp_ctrl {
 struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 155beefdfdef..ced299cad831 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -617,7 +617,42 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool force_link_train)
+static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	int rc = 0;
+	bool force_link_train = false;
+
+	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
+
+	if (msm_dp_display->is_edp)
+		msm_dp_hpd_plug_handle(dp);
+
+	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
+	if (rc) {
+		DRM_ERROR("failed to pm_runtime_resume\n");
+		return rc;
+	}
+
+	if (dp->link->sink_count == 0)
+		return -ENOTCONN;
+
+	if (!msm_dp_display->power_on) {
+		msm_dp_display_host_phy_init(dp);
+		force_link_train = true;
+	}
+
+	rc = msm_dp_ctrl_on_link(dp->ctrl);
+	if (rc) {
+		DRM_ERROR("Failed link training (rc=%d)\n", rc);
+		// TODO: schedule drm_connector_set_link_status_property()
+		return rc;
+	}
+
+	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
+}
+
+static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -628,7 +663,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool force_l
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, force_link_train);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -658,13 +693,10 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 	return 0;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
-		return 0;
-
 	/* wait only if audio was enabled */
 	if (msm_dp_display->audio_enabled) {
 		/* signal the disconnect event */
@@ -675,6 +707,14 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	}
 
 	msm_dp_display->audio_enabled = false;
+}
+
+static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+
+	if (!msm_dp_display->power_on)
+		return 0;
 
 	if (dp->link->sink_count == 0) {
 		/*
@@ -1371,14 +1411,13 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_commit *state)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 	int rc = 0;
-	struct msm_dp_display_private *msm_dp_display;
-	bool force_link_train = false;
+	struct msm_dp_display_private *dp;
 
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	crtc = drm_atomic_get_new_crtc_for_encoder(state,
 						   drm_bridge->encoder);
@@ -1386,44 +1425,29 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
-	if (dp->is_edp)
-		msm_dp_hpd_plug_handle(msm_dp_display);
-
-	if (pm_runtime_resume_and_get(&dp->pdev->dev)) {
-		DRM_ERROR("failed to pm_runtime_resume\n");
-		return;
-	}
-
-	if (msm_dp_display->link->sink_count == 0)
-		return;
-
-	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
+	rc = msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
 	if (rc) {
 		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
 	}
 
-	if (!dp->power_on) {
-		msm_dp_display_host_phy_init(msm_dp_display);
-		force_link_train = true;
-	}
-
-	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
+	rc = msm_dp_display_prepare_link(dp);
 	if (rc) {
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		// TODO: schedule drm_connector_set_link_status_property()
+		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 		return;
 	}
 
-	msm_dp_display_enable(msm_dp_display, force_link_train);
+	rc = msm_dp_display_enable(dp);
+	if (rc)
+		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
-	rc = msm_dp_display_post_enable(dp);
+	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(msm_dp_display);
+		msm_dp_display_disable(dp);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
 void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -1438,6 +1462,15 @@ void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
 }
 
+static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+
+	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+}
+
 void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 				       struct drm_atomic_commit *state)
 {
@@ -1450,11 +1483,11 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	if (dp->is_edp)
 		msm_dp_hpd_unplug_handle(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+	msm_dp_display_disable(msm_dp_display);
 
-	pm_runtime_put_sync(&dp->pdev->dev);
+	msm_dp_display_unprepare(msm_dp_display);
 }
 
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)

-- 
2.43.0

