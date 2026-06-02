Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F7ACD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492B610EDB2;
	Tue,  2 Jun 2026 09:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXY4wOTK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RAmyg5ym";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FDF10EDAD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525tZre4012479
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NaE5h732hDoKExFZJ0IFYAnF1/2ly5i/KuKrn899XBU=; b=YXY4wOTKfWxUh3MX
 G0pk5pl33KEHGfFtIcs7sX1dFl0nMLvLEP6E+3buRHZq9vyzG77Jbyk0uFGI7Tcl
 IwbxIshdHa+FOWjJd2kzFUuWF/mRDuUPe5mbyZXYVM76i4fIrfufMecfRnJ5+v/h
 goUfoTUGk4qMCikDNlRzrw3RIDohZjD2vb6lwvubeCYZMLfUZ7wkMZ8SXAy/+I4T
 CZGIVj2wOfvpi7IcKH4DbmbIJe2zlvz8BabPrG7i2sLsSogBsoA7fBo9ETbs6E/N
 SR7bmAYiBBgjtsw5VqLuk5uK0lkZCFFPVG2GV68PmmGNKT1UNBBjkVW1MK8muRy7
 aVKi0g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf4gtar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5175bf22b1bso20850731cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391515; x=1780996315;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NaE5h732hDoKExFZJ0IFYAnF1/2ly5i/KuKrn899XBU=;
 b=RAmyg5ymLEWNuCiAPaY34ESmUI10WBskcyqJkdrNl9B5ayhLccXmcQn99U6I0qTKYZ
 IqalmlFcTFzJu1Psa8EHWTHxRL3h133lKCiytRu5e/nP3eKfD2IKfvU2WSIE1iP6BY6X
 3fGAC0Ytbp7H+xqzCcBYf65iEWQWgnqc9K3U79AgCxKs621vuA/4Thprm+wUek19e7Rk
 8j5hACRaR4zeUbNhNWuQUqvHyiVbHkrRb+VetZMc5o8w6/kIZlGy11Eeg83TTByqMqiq
 yDhZmK9iyOoa1H/8j5+BVPuadh5Zh8jL/uPx0s2V/H39P3Erhc5+mfo04pn2Pxy/nnAq
 WvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391515; x=1780996315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NaE5h732hDoKExFZJ0IFYAnF1/2ly5i/KuKrn899XBU=;
 b=mfDypW2VuUl2RfLZ42MNFfgB5QHcIM/i/Bz/bIj+WYcaLnn/v0o0xhpWhuRIwHdPNm
 HIc4ZW2TV7CwVplkJwcCRHhKgwfcFV7K8sQxudNBIJfPyRRGDt/icRrju3QDwYW/3XHK
 +xEkv9giNRYipk/DJjddoX1JVUCaTUI4GbWDXz98DKbFSIan7S6nsBAFHDsr1zkEzElN
 BLhE2aE8KGiEMnhyFRyYr5A32a4NRGqdJiRLmWr3GIrnrm4hKBWZnemzVognSefIbkef
 h10necYIIS2WWtkvBZpQbpYrvBTLgHk+A5CTAod/7otWXKv1o6EdypcOJniaAWKTqzo5
 veqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f5Q9AbuRmyeyvc5m2uOiAq94OERJ6/xYIsGxBNLKIl0jmtz0xrOfFb2RTD8reo3lAnI4BbetBk70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1037kkhAXY1X1y0u5t6HeqikBwOqBdNBo4BfaDEG3hacIDFHF
 UPjAvoZ2H4tdHYWD4HR6cFx/f9t9MeiLhdxvTvSbwrKJHlcyfohhojo4CLvD6fX2eobX8IzEd4Q
 nrOdKE+yxKe5Uf9ewB1O9YA9z9EE+KyeoRp3dyLTMpKGP4jZSa1fbvM49Ws+J01XhpW9QAjY=
X-Gm-Gg: Acq92OHr9U8tKkx1YLAjOjTb79yyhP5rMjoPuNlkb0P1o1Dj8/LUMpA0AFy0/mGTL/g
 Wb6OPVOSrtICN78Gg06WE3ls7iJFmDuuKjSpbS6sjZaGO5sLP7TAPqR/fjg3OJZfyNYV8kM3lAq
 D0DTNJuBg3Rs9Adz1mzm9oXUQGV7jLrDAX6v5HfWHR5cXZQLvx7BKMhYR+0OE9SFGdDdU61L4Gf
 REmfTtOHgmWKU0DEowrPyhV9BMKai33Xiwpmi3IGDHqth/q7Ud8mwSKFR+uIBUihJkm4mVSiiFK
 H+sUQgSSktO/exdM7ZVFfY0zWtmsx/WuOVY+cP9i5dYsNvnNIDR3EIfajVJzk+4ay7XN4CTP/VJ
 Rpu5Cx8cE9j+00KIc3aPqZrtJUZriL9ZiVViZdwql2UZtE4/BQ/u8vYiDYzjQ5vOYGjOosUdB/c
 mUIcFUvZoQD7+wQbX+Pg==
X-Received: by 2002:a05:622a:5c16:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-5173a67b6d9mr228737071cf.14.1780391514725; 
 Tue, 02 Jun 2026 02:11:54 -0700 (PDT)
X-Received: by 2002:a05:622a:5c16:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-5173a67b6d9mr228736671cf.14.1780391514240; 
 Tue, 02 Jun 2026 02:11:54 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:19 +0800
Subject: [PATCH v6 07/15] drm/msm/dp: move the pixel clock control to its
 own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-7-2c17ff40a9b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=4116;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=UaT/1/E05CYDg064KZ/+/vx3fX/KlDmWiJULn3OKuWU=;
 b=pXXnr4sV6x3w0BqHmYpCW0puPOY9afsmy+fiq1U7KJCeiclrWdmD+o0hAUYlVFWTfxehgqSSl
 7HVICWYZPaEDMXk262IaFXRvQb44qsL3sPNCBIBMB/VVmzEtnAYNNbL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfXz8jtYaoCI5IP
 4BtE9Ht36M942sg4fK2qA5L44GwY0fy3CldqIlbea5KkwZJc5lveqMIdlZP5p1b4JPTUNBnsA5z
 kH96UJeCwNJlfdgMJEXwtH6fGJGkLu6P58bQ4n1OZ3YghOvr4kBmpglxxh7S3KBE/HHV70DYOP/
 khghvEUNNIf19Z/YDDRLwMaLki8j+//ESXCaEWO2EeW9sm9WM0fNwBVdX6pqHbVLi8q3mh/Qcah
 L8ZbH1IDgFTSCMUWgA2oTaRktBdU3ynLDaUwojEr4Smldp9dRlyKv+p9MlZpxzvBicDfj8CJBid
 EnVJYRJ8i/9VA9r90pJuK5dne0WjUNUd4k1xXAJBtVKrNP+CkyWn4oF35g7cEY2IArSoaN88Chy
 YfPIy+hrJxM2/8GzX0RsoibkL7YGy5GQULJjxMGy3UTgF+YcHkKhL6AvKoZbALjC6Tvsc1x0sYR
 VEHzJ1PH44N1Xz3z41Q==
X-Proofpoint-GUID: l-HcTVYJqjZ3biyxPvwi6FkGjkuv8kKg
X-Authority-Analysis: v=2.4 cv=AJZ7LEvz c=1 sm=1 tr=0 ts=6a1e9e5b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: l-HcTVYJqjZ3biyxPvwi6FkGjkuv8kKg
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

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 81 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1c2eccec6ec6..ac0a2c387f03 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2171,6 +2171,42 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+{
+	int ret;
+
+	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	if (ret) {
+		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
+		return ret;
+	}
+
+	if (ctrl->stream_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
+	} else {
+		ret = clk_prepare_enable(ctrl->pixel_clk);
+		if (ret) {
+			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+			return ret;
+		}
+		ctrl->stream_clks_on = true;
+	}
+
+	return ret;
+}
+
+static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (ctrl->stream_clks_on) {
+		clk_disable_unprepare(ctrl->pixel_clk);
+		ctrl->stream_clks_on = false;
+	}
+}
+
 static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl)
 {
 	int ret;
@@ -2196,22 +2232,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		return ret;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			return ret;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2514,26 +2535,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
 		if (ret) {
 			DRM_ERROR("Failed to start link clocks. ret=%d\n", ret);
-			goto end;
+			return ret;
 		}
 	}
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		goto end;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			goto end;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	if (ret)
+		return ret;
 
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
 		msm_dp_ctrl_link_retrain(ctrl);
@@ -2572,7 +2580,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2620,11 +2627,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
+	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 

-- 
2.43.0

