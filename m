Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCFBCD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740F110E1FF;
	Tue,  9 Jun 2026 09:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgzeQM3H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQoWmI3v";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B768B10E1D9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rKIa1584068
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sdy8wI2RH27j4YG85JCTBXzxHed9vdoH71Sb++hFk1Y=; b=ZgzeQM3HzTsjqyOd
 rOqOaMNP6DXU4a1f6C9+goRRq5bBacscyiuspgzTkvyCukq1LUOjPcmhbYLn7U5I
 kGw2uWpgT3BF/T9wvHuMicbOXNgfFtiMPoWDNSHFiY8gxvvQg8Q8F7UZ05Ljouku
 igAS9K8opG5DD07YJ49/5MoqPH3Ufih64usvdyJIg2fKnU06dgASQSiDzjmiM1yX
 rrGfTx+4ojjbZpOggYPkisd0jUJkOl/UVwDRvv1ZWPrc41JLoBU9sbkA5BZL8WVU
 2Bb88lqtVeFNDhrapIYqKo54EW9vmAUtvgxanSlzFPKmmihWKBc7JwcfF5pyQkYD
 BlfDrA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeerurb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51775f7b2afso116619741cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998433; x=1781603233;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sdy8wI2RH27j4YG85JCTBXzxHed9vdoH71Sb++hFk1Y=;
 b=BQoWmI3v7oHb4LcvwNY81BH4m+X1Jq8JTlewKLNo2x/kjdTSqLR8WBtxl8dp/k+Sih
 YlmzwfyTKoy58UHksD74YYgr49uMckFTRPUTCwmLTTFGSz4Sp7Fn0frOdJ4Qb+/uTST/
 F7h6D9iWxj3pxL83wMAwrZCpjSerdW4MqUjRh6SsvibCVpUAmvGcrSAGZwXeoyeacHIs
 OImfY5GY2hQEFq5lJ45/obkZDVpcTfGrECD9W3tL+eprUdxIFj5goh6WSw/mJozRE3EG
 nNDi+z+Sz07cPMZ84arLIpPqI8EZmchsXCNuBxIbUKCM9uu3guCltDiEbuC+oO9iNZTN
 2gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998433; x=1781603233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sdy8wI2RH27j4YG85JCTBXzxHed9vdoH71Sb++hFk1Y=;
 b=NR6SVovE07T95HYZgh3XjTvRO+lH8aDi8lIGl12ENJw/35h9H8WSYSrv3IbZnvvg7x
 tV9sp7pcn6egwucbUOpDEpK8b2wVmMjmTfUTuC44tIHCMTGxus8l1Q84+fzz+75Z3fdf
 oUc+oLt+FvW4I6gS8w6ORHDMf2QclwU9M6gm2KvQZu3bT1myx0yjliWL/f4Mak2mXkiJ
 DYDTWo4mrItsHOdT647kuYUi8UIzTK6ldY0U/8FyNy+Wf7vwjDvzGbys/5ZuP/l5VN/c
 LI//Rkzpld5qaDMLdhhA8gfZSn3XqWfsgM5ueqEdorALMcNCYsFK4dGJNGLg9LSPLrty
 Mk2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xJVNeebSQHA1Axo+pE/mCO/ZaC4r8sNGAURZrHW8I8WbPbr5PTsPehRCuZvCb/gAE1c1dRh7NzIA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2iACbBbE2mlfeoRRNql7zZZaV7N/9Ls3rUCWV4VJqVjIGe2dy
 KnqWaAaRIbQGRhT75nzki9VkdSIkFco+Ss+nyuNEZFiWjtt74R+dLkfFdM53ooCtlYsXPJ5iudE
 po9nEfHEEx/e7+hviRRUC58jfUPo9tyNDyySUG1Igv50M4OZ+rK5X6Z6lPP+7KH94Swon1bo=
X-Gm-Gg: Acq92OHuEBORBTCfx94cmvu3Kj39+lqWup8RvhAUS+X8i7Ks/wA3TfjR/t9/drhxCuB
 GZpSuFc20mcjaMYn8jKXZMrhM274HQoukALY/29IqCJgEfEVJnQAYktE7skx5GPmdFZCBGygCdA
 3fioupZ998HdV8vsMnAAXPw98tebL5hObzR3rI311wWFHKpQIGezO0YCn0Muq3iyXHlFX+RRIe8
 z24aXiThD9PpfsPOlYRR0giuDVjRgfocnodzQ9sQsXopH0fX3kOPrb4G0JKIxrYMrrzxGc48zus
 UN8SdAmZ/8UKyeJwqV7IsM8EfxhM8hfpgdyB6TkVmUjEF3GJD8ClWtloz3fj7vLAEp4P8maf9ft
 JHZMwcOFt0KQS7XMDK8D3wuMbCOGZ1Bne7uzk7rUFVtYwb6qFglz1Sq0pGdRnpmR8nRxJhVjxNb
 CnmK9a2er+0B7+q0jwKA==
X-Received: by 2002:a05:620a:199b:b0:8d7:c82f:ff7b with SMTP id
 af79cd13be357-915ad31433amr2072749785a.35.1780998433130; 
 Tue, 09 Jun 2026 02:47:13 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:8d7:c82f:ff7b with SMTP id
 af79cd13be357-915ad31433amr2072746985a.35.1780998432672; 
 Tue, 09 Jun 2026 02:47:12 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:12 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:29 +0800
Subject: [PATCH v7 07/15] drm/msm/dp: move the pixel clock control to its
 own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-7-ea04113e8233@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998393; l=4059;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=hFDmZxXei1KTLcixeb+NUk/Wwdocsh1JcTngaZx0hsQ=;
 b=JF48Z/GJSbnZ7/9+9I+TvqmWJrqHdn5mcqHwbMOXjLHOFIsqSag9uEeFiV5Mcq1y32OnonaE3
 XFvYmgDpZ5vC2HwI3jlo6NflCi50HfmIDN3dAw2GdOph3ifQF1DsfH3
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a27e122 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX+tClTANoGeND
 nS/dgnhMSUDWt6ZZZQzu5RDikwcfU6QqtxWMGpmneVClu0zJN8lcJCRavwHQpScEVJlH+LotLRJ
 G63ilvj/b7q/741BSCsZPyjKmi2gv9UrCMf1SK+1ShKwwOJSbvOmohD88/06qfRIHpM43KRSDEC
 DyxfMtbc7nUGgXDm6a/RkWOmGWRc1lq5MC9RWj0JG9lSP6Pv+FN9N2n80NulXVdweCcQzaUBTU7
 8lR8bcKE20Jgiwf+P00gz3VmxKmeu/C91e3kXvFdFLhIHIY6kVCwozWg7e7gy78w+kKWynSCL9d
 eIomibZDquisSq4yV7qjkHdr20+1R5+Sw/R9BUodIILck8WoYO4qlMCoVxSKrSCPa0g5ag6Xogr
 xaaQ/ZGy4/VLaiiyllchCwLAykTgI37x6RanI9m/7W0supleSnAd9XeVBfZj29H3hgUidfHevtC
 iF/hrZv9owgw98tBo7g==
X-Proofpoint-ORIG-GUID: XS7lgTA7MbmA2Jehg6b1aoydF5s_wBaY
X-Proofpoint-GUID: XS7lgTA7MbmA2Jehg6b1aoydF5s_wBaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090090
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
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1c2eccec6ec6..a2c44088e6a6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2171,6 +2171,41 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
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
@@ -2196,22 +2231,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
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
 
@@ -2514,26 +2534,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
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
@@ -2572,7 +2579,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2620,11 +2626,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
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

