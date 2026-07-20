Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EE8C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B4610E6A1;
	Mon, 20 Jul 2026 06:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LnPAuyED";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EoNEyQCD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587BF10E69F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNskas645389
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D03QOeyPxDyyec5WvQKHewnRJ0KQmMoPVroW949BZ9s=; b=LnPAuyEDWbfk7F9v
 T5cExMuJBFo97QkVaqCbmyT9TDHVTFsJjR9xCkY2n9SYe5gTOMZaJ6uc7/Eaa1rn
 +sB7Dx6b0xUbcitaRL8HnnmhMNAlm+JBWNBnxVX6wFa6SXEdGqpd2GpsBWDt5YUm
 +lKYMbkczN7fhEPqbFPJDSO4+nnhuFWXI5il380wKg+fPVBDoSiCi/jG3qc0W3IT
 wuaJRBYH5x5zyZAaKFpHBOrztiRubIYIX1cJiu3naItBOf+Mn5nHYrPJXCaO3SSf
 av+KMB0IY70X6AVKUthyt1HTtiMXRJ8qATdQvVKNvNKFq1ztqjvSvSadix6v3aH3
 MRyDbQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvvn2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ef8249f73fso77851036d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527890; x=1785132690;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D03QOeyPxDyyec5WvQKHewnRJ0KQmMoPVroW949BZ9s=;
 b=EoNEyQCDSX7Inx3d7+JhkrmtBnFhrfc0btIGVkMfp1MyTyXtqhj8XXeakazfZs0ASI
 60gyHq2bYeXHQzvmO6XRNsIGa/i87W5IryOgUHBtNUjA23GqmB8KLgveOIoDzYcDr8XN
 Hs4o2NLhFQO2QGs1CcScm/6EYvRIvJe5nqfHFvIrxwhLK9YBkMWYP939vuOgJNgRhMMA
 EfbVE7bHngpfLYRYvObiWK2WUCfPauLSvYRDGAXIgTgMOx6mTTaEMo2D4cSSQ7yXLYRL
 zy01uOGOdTYsp6x7pe3Fo0/BtJDQ3VoP4dXo46tRZ3WD+M3k011JxWsnTn8btiutdhJv
 lLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527890; x=1785132690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D03QOeyPxDyyec5WvQKHewnRJ0KQmMoPVroW949BZ9s=;
 b=bqd5xeUJLREbdXh1SunQEVhAx2sxaLgaa2m6xNwUp+74+DUvEf7XM36HXdCrEuazFC
 Jmn5W+9YPBb6t+8/h+A2JKt80sT8fWUcanahn44t6asLrNaJimW24ojdgr1rHqHMJiCM
 fqeULBf/Rpbbjlwuj+AmBez6PWf/qAC0dmbwzevLkCfk2yxz7XKy4Hsct/Ybtn7qkEY+
 j7nGhlKGId3EREfan343u5J3r4xQd2AqDwBhQrf59p//TGVJUQvpXZIncHhvAEkIRYF8
 STWfFJ0D4KHYJ7Z8aZuOoK5OZ0pK4UPSEn8rpKz6h3Jaz6KPk7mMngaTI6HOcJviAEGj
 Aopw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTOrm7kNBbjpKM2m+DmnnISOuJzZDcXFYoB0OWxlUcxgkc9JKz+rLzuPisfMDw4fxcAIXN/Mz0wWs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztqtpeQqrpwt5WRokpNvxmF/2FQXyf4iKzh1czdZXLEparIGN0
 po2co6FQOmK4/go0cSgYDGgcnragb7laZDPfpOdiPvnvRlun5sJP/+PZep39jiJU9ljDdRrXtDp
 +CyE2OEacEZJmmJwgek1mdvdQY+BY/pT8sVLjGgly5XvI6Lv3atei/c66B6q4wPYJXxmBzwY=
X-Gm-Gg: AfdE7cmBv2a9H0AlKGmdxc686HpAgJQ2dNKG6UycZjoX0WBjqKsJz9qvCSpMQ0LJj1t
 N+sOILLLGjdGJd+OMq9jxWRkmKftNWrykQgX0lBttUDfzcaoVY/eYt8ObkWLDw8y+ArCWv8umCN
 f8eVBLIltnlsgDedUeIauFAv/sHbn5AJklvNLpJnjPP5pesHP/41J1yTEkRZRbUe25aYN//vENJ
 tteCd6f4V02p4OTahGl43mVEdJC1ZL4Zf7FEqkYNgK2XWNUxfSszDqdZZdxtD3fyAivYKsJr7VW
 2HaAIgI1mtmOYOxydnUEynlNzHJGrZbqxH8pmIVAQJ3FFy1GwOr4maFtmrUeDLLuv/9x6q0Dz+E
 DpibIa+DDpqWkeRGq7r3HmJ/O3tf135/Ry6hTwRvSnpyK02+S1PAA2pJSk6sLSRE=
X-Received: by 2002:a05:6214:2303:b0:907:5b47:b875 with SMTP id
 6a1803df08f44-907783a06aemr125648956d6.35.1784527889820; 
 Sun, 19 Jul 2026 23:11:29 -0700 (PDT)
X-Received: by 2002:a05:6214:2303:b0:907:5b47:b875 with SMTP id
 6a1803df08f44-907783a06aemr125648726d6.35.1784527889386; 
 Sun, 19 Jul 2026 23:11:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:16 +0800
Subject: [PATCH v8 09/15] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-9-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=3890;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=cC8v2WuisuVaw0cBf4g3L0Y6jW9Y1zprJ/LBzfDlZvU=;
 b=V7hE7hyNsEQYHZHCC9TbZojrbarQgINs6s//Ii+LSbpYzSERG6objSv6/4GknaWiRB/rHJzY6
 n/PX53bDddVCpzuM4Bsm1bBYLwoi1r9Gy8jm99LQjtkp2frQIG/2e+0
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: kBSpK5IYk-yISRC4UYF3xA0z3cgaefwq
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5dbc12 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3ttbkIfPOWFMAE6HwJMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX6Vjl2nfw2u1V
 iPkXmW2fR+wvjYVe3oE+dga1Umqnwzy3R38mFgbp1OIk4iUiw9sctmNjHuQaT5bPpafDPldediD
 JxN1FX28wknAs7H8BvzGhoSZwXvQ9ruEIrxyzWg/0bk9AaG3VChxG8ykn894nU5OsOXxxb+xlgC
 v/T2r6Vo7hPFHKm9vL7kvyIVqSCLNNiFiLTAqIAnIUcX9NS75OFsavd+i06t5jxPt8VWWoCQbQb
 82XAFIHIpIDnzeFWDpqGbGJ5Ah9zuWd6O/nclBxG+JkPbpsC5uIsVfGnfX2OVWUDh4/jaamknjb
 prnGcLYHjbKO7hgax3V+s0QSmTcIQ5c2kNyPNT7KON4J9jGFVdrKNULIg5Fqn0n1x8jQBtH91h8
 5VQyhho05CNtGVQYO4fqqbQkUCyCAde+szDAj/zG04OD7JZMsHbYfeQuOBsoX6/ns8UiHLLR5fH
 69Ie2hhvPFC/NKAq0sw==
X-Proofpoint-ORIG-GUID: kBSpK5IYk-yISRC4UYF3xA0z3cgaefwq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX8I3a1qL7vsaR
 RBe4qRo3yL9Gj20pvIADDkOZZV1FmQMuUU8VE71WrOWFvHBTJHeVD5feZ9WC6fs/G0T+ALkBemx
 soEtS9KrDuag3G4QxSmojvqyrTbdq5g=
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

dp_display_disable() handles special case of when monitor is
disconnected from the dongle while the dongle stays connected
thereby needing a separate function dp_ctrl_off_link_stream()
for this. However with a slight rework this can still be handled
by keeping common paths same for regular and special case.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 +------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 32607eb678a0..ae79cbec26d1 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2601,7 +2601,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2609,23 +2609,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
-
-	/* set dongle to D3 (power off) mode */
-	msm_dp_link_psm_config(ctrl->link, &ctrl->panel->link_info, true);
-
-	msm_dp_ctrl_mainlink_disable(ctrl);
-
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
-	dev_pm_opp_set_rate(ctrl->dev, 0);
-	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
-
-	phy_power_off(phy);
-
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 1497f1a8fc2f..5d615f50d13b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -19,7 +19,6 @@ struct phy;
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
@@ -46,4 +45,5 @@ void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ced299cad831..9df094340f0b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -716,12 +716,20 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	if (!msm_dp_display->power_on)
 		return 0;
 
+	msm_dp_panel_disable_vsc_sdp(dp->panel);
+
+	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0) {
 		/*
 		 * irq_hpd with sink_count = 0
 		 * hdmi unplugged out of dongle
 		 */
-		msm_dp_ctrl_off_link_stream(dp->ctrl);
+
+		/* set dongle to D3 (power off) mode */
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_ctrl_off(dp->ctrl);
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt

-- 
2.43.0

