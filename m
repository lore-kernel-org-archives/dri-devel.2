Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E48C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB18E10E694;
	Mon, 20 Jul 2026 06:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ky9TbRx8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STMY0Jn5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F0A10E698
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNskap645389
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bEWZpd5Gqhtf8XBYTYHEDseLEqITUq5QSnbj3RUGq/w=; b=Ky9TbRx8knauOddX
 Pk7hl3W85uFyBtKMCwfWklxUngDv5r9eH5guLeJ/IRNYtGg5AGYvFqelijs+VhMb
 9nh5NNyYzKZDF6ccFS58Tb9ZtPuZIjugOUL3uO2uHUViHJpIh+5GZAXx6EtoyBRb
 Uw5y80Fkszmu5j1skXbY11E1tXYBTAT+U+UNIG7avYrO7bfA8sjh41PfNPGOunGs
 H0JtVYz/kyCkme29aAATmpxDUO4q2Zo3ZwfiQHjJ+kcFshA514/664ndyqI31iGe
 PsK3fcwBf0KEz2HCsUVLKswTNcChdmTQOvqFDA9ys9B1J++E4rDPXpllz5TXntan
 gOdQ9A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvvn1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8fc92c5373bso182759666d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527880; x=1785132680;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bEWZpd5Gqhtf8XBYTYHEDseLEqITUq5QSnbj3RUGq/w=;
 b=STMY0Jn52UYJ2Mx1au2jgakhZeglKVnEozl2LXOVo6ZGO7WWKqTBnj4BQxfuzD1RKt
 erSOxtXHE6TFaXmvbK3jQxLRpFpIJZLoqhlW+mlNiHp5J+8c779zTAX8K9mG6i75xIH5
 OUFXcEchAWzYG2A+3cTLXXSJhVDIa8dOHoVfVqNvMNNjSaXxA3cV4hlfBU3DZHba1mBB
 jsvy4wICflWUB9e4g0tLGHewvEhI/B9YdvhIpoP6GVYvIhtdYPqxA4as2mDsfYatXLck
 e72iPMBcxG2OAgiQHRV9dOlr5Q2TMDSl0qnwvUiyHbCIXbnS0eW5XdFV0dXi6m/8e+oU
 UZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527880; x=1785132680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bEWZpd5Gqhtf8XBYTYHEDseLEqITUq5QSnbj3RUGq/w=;
 b=NH+iUrIlkgo28oFLxF/OeM0I06Sr5/kW+hkfW+AEa8i1Uc3aCOeJKvy+XLLtSmIdoz
 4QUyweLjETZ4AwlHTcgCMQSUZHSY8XDgbPQDWpr1fg6yBDZbIFQWCl9FYpYanKUTozsH
 ZbzRVJA7K6T+Hxzt6eQHVY/8SKm12L3QHOSBlPHyc1zLz+IRGt8a2kz/bGETNQpbIIP4
 GAfDx4RWglZAa3uAlfP2z6eq4b15YGG0vfCov4W+J/wmn22/kw5ch4Vgef4QfOh+6Wu3
 +t1VE4yTzhxxJ9XWTKP5uHsYS1B8+WsfX1nHD52f46OupD/YWtNuKFWs6guvClna9LID
 weMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGA33yt6uqZ8VZWaq3cqCDf4Ehf52S0Rzrm0srAQU6BtsQ5981JtJJmQf/aNpOJkyosOdMRbhLywI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgTtplB7KhVdw6BlQIBTE8BKmS+rWI1/yiWKBMhgoGwkkOnW8t
 1DpNgbXu5fhqui5rzESfK96xq5GK8ng1j0WLzj6W3JGZL4EagbaOmw1i878445NOv0JB+lH8LcN
 xmp+1FA0N+e/eIjamvTVerHkbPkMrJQrhwZRt8Mb7jeGXulUIRdd5c4km30CxLhAXzkmme4Y=
X-Gm-Gg: AfdE7ckFx0sY1uCU5xki1Nv8PP3RFsDDCNSClVvlHxeifS6ToEw2j36vtfFElWbc/V8
 OjNB/nc2v3gMa7EMzXh/1MWfu5wh2sOeO0HEbdKrnRa4DgLECm11kQWZ0LZXBP4ovg61CW36hjl
 IEZ/rPC0yLG1xUfIbRDcP3Efv7Xd/3AYtc663eiPBcCH57qt3Adq6juOAytWxFc2mg+reSwBDVJ
 Idp5edE9t5S3zjWpfD49rKsx61KDXJLfsc65Q8bKj1D+LNiHX7aXfCHUowWSpGRMTMcYSINB5Z0
 tZHSWPBjdozt+nvPWZ1nKfIYm78IMqDqzcNFvTz76YR4I+gs8RNWE4mRmmnWjpP7JEnXVp9lVqv
 2yyRs4VnHtLS+5GH3pdj0Ry9XH89mTHYKdwvrBLjPqozDAiOnGNNLhL32fp1KLd8=
X-Received: by 2002:ad4:5f06:0:b0:8ea:658b:aff9 with SMTP id
 6a1803df08f44-9077852a123mr127422026d6.50.1784527879854; 
 Sun, 19 Jul 2026 23:11:19 -0700 (PDT)
X-Received: by 2002:ad4:5f06:0:b0:8ea:658b:aff9 with SMTP id
 6a1803df08f44-9077852a123mr127421816d6.50.1784527879383; 
 Sun, 19 Jul 2026 23:11:19 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:14 +0800
Subject: [PATCH v8 07/15] drm/msm/dp: move the pixel clock control to its
 own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-7-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=4071;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=u42nKidDiGf3s4uqGsqfLPYmVyOqtiq6FmPfz83VIe0=;
 b=yxSxLVwOK6nvrS5n2lp55EMGW4AYExevs0LChoKa0lxxQOChL76cEzV+X5VeX11o+v2IFzJ9Q
 SgbtxVlUmJaBfOqlE7QT6IpVtYGWDAWh2ye1xW4fszxkQHeCnmgC+z/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: iAh7L1YU16fFfYaJ0TljJMsHpex87Jxl
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5dbc08 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX11N2fG1cljLo
 lyyOBRpYjh/Nujm9sDxBQFTNHqgNO+8BKN6oQCb5H/hjSadtGx9pskjXrovuqwypuEf1ET2c9Rz
 ny6BrEmfYzXkBaKsdSqaiw+bjkvnOPgKyPBngCy2X9mOVVnGDGc2GWVhdOkaCsQrTv0n9dexOVk
 kcA/ck4Tq+ZfXHRNbib+cz66HcrN6W0uipPo0DmJ//to4FfinqHKvl4vsJGFspUD0YFx/v3xxjd
 ZMx6q1ONBTz3Ys04LnVkaUYaRucsATcN5J/7EPJM0sOPer1TwgdJI6d5/yAmRcnrd6KmBtlq4Yt
 bk2NCIog5DDyBhB3kUJBEnIDfzYNhUxO37Y0gQwUwJyUYQAWKEfcxoA/uYgKAaYFlpT3UI3kspB
 iA93N+pNZ+Pp4LwGhj7KHTrceD99ugDYHI7PXTg3FDHA8r94/Kd461Vi3SHjcZjKZL2Sn/UhLRs
 oLWLRK8FdY6bVTA7+Rw==
X-Proofpoint-ORIG-GUID: iAh7L1YU16fFfYaJ0TljJMsHpex87Jxl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX27GviEL23PNA
 4a3BIw0/10ZYWWjFlNZb2zkBcO+8vrujQhVCcf9TQ4PsDAjnYRuI7eWieHF2PCmJVotCH2iLjQP
 /SFxP1Mvn2aEbj9sOcGwi6+nOlHAHQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200067
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
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 80 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 711579de899d..a79d9bb93cd0 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2172,6 +2172,41 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
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
+	if (WARN_ON_ONCE(ctrl->stream_clks_on))
+		return 0;
+
+	ret = clk_prepare_enable(ctrl->pixel_clk);
+	if (ret) {
+		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+		return ret;
+	}
+	ctrl->stream_clks_on = true;
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
@@ -2197,22 +2232,9 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	if (ret)
 		return ret;
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
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2515,26 +2537,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
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
@@ -2573,7 +2582,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2621,11 +2629,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
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

