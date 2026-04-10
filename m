Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE759E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A15210E900;
	Fri, 10 Apr 2026 09:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jq9IYHBv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBdm81yA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EC010E909
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:44 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5Lfkf2698373
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j/biFkItFX+oUMqk3cF/h471xd5ZBoQ7TawgNxLQz4g=; b=Jq9IYHBvHrs8c2lD
 HowZ6aHqSLR8S8SBZhQlTIFB1NS1vZKtaYPOks0A5BusgsAidkYgqJHsoNnvGGHA
 3wwG266xzfn5s2tBd4Yy8TnthIXkgf0lEieGn4l2An8rNa0vqo++rUuV0Fm6O3Lw
 VEShNTEh1yYTdx7b6TktHAK6oGGvx/sNA/R5vSHnST0G5bF40b2Djx/8iLc+s1T5
 og1cFUiV9oez8pdf+3xxnOxfHK3TIeb8F8UxkI4WqrT1yHc7w2aodF/d1NAnsVjQ
 8orAIZEzefGJ5zH1hzqX3THrrxMNIuq2k2fzvnZdrOkHHhZWKEueQCNNTtoXF8w0
 kRamlg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9tjfv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8abd6e281c0so43057126d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813683; x=1776418483;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j/biFkItFX+oUMqk3cF/h471xd5ZBoQ7TawgNxLQz4g=;
 b=LBdm81yAD76wY5l/l0ApIGQajSccax8/jRai1fR0OjDLMUEkTDDWhWXqlJ6B4r+X7n
 SkjnH28DyV52pmem71BWtnQ301VL6OO0Yfj41yEBAihLbxJoClXi76BgmBZ7yWwXgGqj
 obkC2m9Bnx89iL6I5qT1ImFFDXV2SVLQrJyZF33tRp0tX3vbBDVHA7A2mXJEw/MNVFNg
 DxsWVp7RV5OHPez/onCBEErdnPqlbzdSmIdu45S2hJpva/QNTlImzP/MImZgof5BnOy+
 Ae95Ho09Qa8No2dQ+dAWNF4bzq4mbh2cZAAF4A7ATyueMlYWvX0/R31t1WXh+5HGZ8t1
 rLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813683; x=1776418483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j/biFkItFX+oUMqk3cF/h471xd5ZBoQ7TawgNxLQz4g=;
 b=rSoU9OgGTdQJC+M3er60PiDI0+Gf//S31M6ZnmyAQaTqKKGDbINeVG+xG9tkGjaNsV
 a+aNTbmqTSLJLGBwZiG1HBLbmBIr26u40tVGeQfK3Rrw4x36YojBiAlvWhCS7mhlUqlN
 n0wrZLxLSZiSnzr+Ck+rHXH+GBG3IIk5WtIMXshkpiArl09+n+CcnID4uly5U1m0TR1m
 NN966FbURfp1ONderA6ECO82VJnhSsRPlMyAT8S8rljf5wTX/VkQJvgLVDIfiDJ1Svhj
 Vda9vUZNdJFF3SmPpDB3REvC6pAh5Bzpxp9uMmqVZZAJZrwiEzaGhEZKBiMkkWb+SFqj
 aDyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaJLZ/yuMi3OrybysrgOZUftan6dmbS5v3hHR4d6rfxp4MrDKKGJri3haW2SoxE+40Vl+my6d2Xag=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywf7NEKgps+GfwEkRuNIHIHedySfP9lCqdvyC0yC0iynzfVmd8I
 /Lca1i62JinPEjpMGaQaVVuHAApTlkQOKDGSQOczIBVYPSrbsw287xLSfPZ7OsJY0Dg/HnWDhu2
 8tuUSZYEtt8XV21lHSDDEtRlr/bR+2V2EXaPA0VdktgaTWvrnAukOhRGCIZBna5olr0EMtHM=
X-Gm-Gg: AeBDieuvhEpYpsAIEgzU7qKnXxzw1UDGC0nIn5oPA5wwNP1VSmZAaevY81mr3j4qyTP
 6tLwGjPChDSGAcnOvV7SbuLq+b/l0vZknqTjcNnTCzGWURW+Aphjbd9oJqRySCYyKdXBxcquby3
 tEYLK/3LakX7GmaH4aoo4jT83iizFfLW+HTK5MNdK3mrabQNUgw2tCp8Qh7KZHjoR3IHZmZoCrn
 1lGqp67+tjTfBmTPu0HMZahE0GNzpLNAR7l5CPAmGvmmYVRdxDaJOMlO3pyEjx+RnOaW/ao7jBK
 JsXzgaR0sNmIwxT4SNpO3H+JiCZfbdPCCphDteweSiOeEKmsZBAiYC1f4fquREJ4GlJMezTZlJE
 KP1GA0LjJKQJmt0Qov67KlTWYdHtyUkZdxzhE2pg2KBwDFBr2rdC83mRu0F9S4VhrJlW6ncBf2r
 KzcR4b7Zc=
X-Received: by 2002:a05:6214:f06:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-8ac8621c0a1mr34233966d6.23.1775813683273; 
 Fri, 10 Apr 2026 02:34:43 -0700 (PDT)
X-Received: by 2002:a05:6214:f06:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-8ac8621c0a1mr34233626d6.23.1775813682843; 
 Fri, 10 Apr 2026 02:34:42 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:42 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:45 +0800
Subject: [PATCH v4 10/39] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-10-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3860;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=guzQ38GsRaOMwlRV9h4phTGd2vjPW/70KLxhOMZyCc0=;
 b=OJAr9yvQwhCxq/bCn/E87eHrdjxjohJh9n6mdnmJMS5gvqXMIRWVTF9aTTEhE7GpBYdN+yNbR
 TDO+rpqEOrMDdk6X0KvOWgYtMQofDl7bsHS3zNH0mbxJ/JeMneBUSH0
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX5PzW0fibnyMX
 R29A+BKplPXeHwsPz/EXiaJ4gzsLIyWrm7y9P+qvdzxMud2rKw4qPoZPFPsdMqx1L+zl8hh1arr
 Vy7z9ZLcG75O25I7QylK3oZl+YcWIy1ku7IjdtfN2di6O3aJXUN6/3rXRI0YOqVmkRNbWSdc+CB
 jrbudGdYpdHK0+J6fqEWVo47kNaEiCHYuBX4Aiuneaw8H7lLMjRYuEtKmdHd441Hyl2Jqw3BQVN
 VYqhdYAucrf+khNwPkVnCR9LeIrpS9U2xikVvMXNuytyb/NJ0chiikKDEe7qUB3/bEGmFSuvXAx
 PzYOvkPEJN+5MO3THamLt2ZKx2shHB0CbywVNVyWw9eM1p3RObg3aeuQUtEmnqp0XGfMxbdfrXB
 GVzjXgbL1kZPQOrLFqRi7cWKzD1wVtehahQzyO4z1zvfayvbV1ozfuahcQmOP/SXUgbaqQlL55Y
 AuNkdDHXY06Fd0UD6+g==
X-Proofpoint-ORIG-GUID: Zk8mXXodjKvCmwsb3KqcLPVvMDsbHIqM
X-Proofpoint-GUID: Zk8mXXodjKvCmwsb3KqcLPVvMDsbHIqM
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d8c433 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=OtQsdMd2eBjxU-v0TgUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100088
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
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 8 ++++----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    | 3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index fa62f8f91189..120ec00884e5 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2200,7 +2200,7 @@ static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned l
 	return ret;
 }
 
-static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
@@ -2228,7 +2228,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
 	if (ret) {
@@ -2620,7 +2621,7 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 			phy, phy->init_count, phy->power_count);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2634,7 +2635,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
-	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 32196e97cbe9..b83be2252a9b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -19,7 +19,8 @@ struct phy;
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1bf1335712bc..31e229ac2393 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -730,7 +730,8 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off(dp->ctrl);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl);
 		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
@@ -738,7 +739,8 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off(dp->ctrl);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl);
 		msm_dp_display_host_phy_exit(dp);
 	}
 

-- 
2.43.0

