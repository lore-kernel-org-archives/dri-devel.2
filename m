Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AB9C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B336A10EB78;
	Tue, 29 Sep 2026 04:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIfvVlvJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NR/2d5hP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D8B10E059
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47jJ54053026
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oyHmFa9wvulObjT4LWttQonigm0eeqeoGmSfl65guNQ=; b=hIfvVlvJl159u6UI
 9vUei3ndeCvErksnbbiFNQIAA23X3IMaoyXdrkJi9NJfPsbaSNF5wOgPSz3AEApi
 PvQUNakD+mFpHyD+l0Z57noE7RCfWm8EnFwj41DB1nMmCMSMsDQtGd30FPKHSm1N
 kg36m20ekUJgM8hnTbqkEWtytPFfBk/4d1Gvy6wUJWujzbwbTpj1hIBmQ3KXfH0a
 WzkjO4d7kSfKe2YxaHeCOm4VqLd2JTrpAkhC36wbJL3RQFyJRc0AuPn3DkIGfvBH
 EnlI9cyJgfQP4IQo42XH4KIzXO+ollI3XalV+p6k5vWQ7Z4L7u07GfQTES/INvae
 nizBlw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg28p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9143d796129so64802686d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790655994; x=1791260794;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyHmFa9wvulObjT4LWttQonigm0eeqeoGmSfl65guNQ=;
 b=NR/2d5hPvgtEDyMoqG5EkGm+XsPmGOfUVfi4m3XciigUamOomFKwVxmTQncbHuFkWG
 CSW+lNup19BB2tjq9sIrbJxN+3j4wHE/b7PraK0n5RzuJcc4+8Cg+u3zN6IhtwEKn+Zw
 TnT4GNzwqmlyjRuirnxC4PKLPLp47RzIdY07Nv3mlELhGkpj9NSWPmuRqgb44sP3Xdqf
 nYruBv4g/VFRkPWB2e7uLcqVzLyHULSzWnCdLsN2Vo18WaJ/6pX6FYdej8fmqaYTBBRP
 laV+dLfJKM/co6DgTipRj5UfXCDEE4JQ/d8SYkRYrYacZj8GI0uB04vDF/9r66NyvByO
 96MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790655994; x=1791260794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oyHmFa9wvulObjT4LWttQonigm0eeqeoGmSfl65guNQ=;
 b=Kig4wA2+o2Pm5RfyZ7qvdyCL0xsNeOMr7Ox5p8t2BARbb8kDZhYHWmCK70I4qyK4A8
 7Qq7wpvL7Qodbie1lOWVc2/CcJGQdv1q7k2b27+RrFICUrkRlmLXjyav8uZkTW8w23C6
 X7mNa+C2EsMnahENfiwuYNqypOCePHQKLVrdfpzCUMDQg0xz9B/JLu2nmxbUcCecqatc
 fAeOWCqqxfqm79pndUBlGMBIknbWLB9wNyrch7jYH+wtDqk14THNv13vWyBDf49mkXXn
 6IhX1WO9IwDK9NI3itJ9ixY/kaVPmHwQFJ668T6ett2mjWTM/l9X2xKkQfxsBut084qf
 1n0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRVqphCTLLtt91a+Hfe43kstNNv2PXg30W0GMiJFPv+p0BggvI0q2zVEPuK1b7n8OQpEspEiXcxqE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mnJF6ORRYn4qdXbXy+qqtCL1BjqOHgQSr31uymGZfdrLnQLhY7
 2vwIQ5hA9TdG/VsNBtt9PT6rTt0+E7Zsv9r860riLhLSkAQW4kPAGTriQPgyHdV38euLBGS+/uY
 +rDLZTRwGoizxiGOwgnZz26WfnCklRESTUDdph3pjMmVVHY4K5HXML7pZxoh1wgO++7JbHQg=
X-Gm-Gg: AYBFou1y2HEDZKVxrkZR2hDgIHX9fVY3F4kEtYlPrBLWUCSX1KbF7nStOE+HG2f6fHU
 7bgJt08hJu/7wdc7xX4l8RaKDjfMpMUfps4SICl6VuVQyLWyASWvidGRiwGuOyIIire8nGsgijw
 gLCoTSNX/KZuPFb09JU+FHe/XOHw2wr4f41CXUNjApA71AVIUSQKD5mYFeC07gBiyICPRkfWvda
 Sxbsgp/3zBojma7zwTrKK3iXmF0aAcO0LnV8YhFWnhXCEifHIRkqlYQUuF/dgDv47S3HNhx8CLG
 VQ8oRdL9wQoKEo74kWUE6AP3HCVMCVYGOOdLzIuyeUzGmiWH0fHmFVzfGIQqyQ13bUQZ9yP9A+g
 G6SKO/2pORnpviy8eKqf0143MEeyEblI1450mNRCoiW3r801FJ2fH2og4UTtruWY=
X-Received: by 2002:a05:6214:cc2:b0:915:ea96:d746 with SMTP id
 6a1803df08f44-915ea96d8c5mr98257376d6.28.1790655993762; 
 Mon, 28 Sep 2026 21:26:33 -0700 (PDT)
X-Received: by 2002:a05:6214:cc2:b0:915:ea96:d746 with SMTP id
 6a1803df08f44-915ea96d8c5mr98257156d6.28.1790655993310; 
 Mon, 28 Sep 2026 21:26:33 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:26:33 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:25 +0800
Subject: [PATCH v7 01/35] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-1-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=2701;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=U5xt8vpiVAWHAYVlgspV/jOouZBlgXr0Z45thYBSl0w=;
 b=mnCVYmvynhZjvcbku2fjIveX0aUa6o90Mrbha+MhPr0b30P9vazI5lWLiXIWJ8adE4vGKknar
 F9pEXIjcF9gA1xqJjIq2npMvB4bL5tEvk2psaWB44cx12CMfyfN2WYS
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/u7ph1hzD0ZK
 sjFfj9103FVYNHLQLZZIO1ovK6bcjfd2q7XBXMrkacke5UH6fPspmDxkpPrhWLMD/6mOClWjy8a
 G+U9lkv9o4cR+00iCNJJ72rYCgw4+dM=
X-Proofpoint-GUID: iTLDSzwuhJJbAMGASDswoFl6ZtNo4pTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXz33/qetOQGmZ
 hB0gz+UPln4WcsvFNoAoG4tvz8NUdpS1R3VeGtqDN+sioYyIEJd2p1K/JWKIvmTsmNIGoingxCg
 VENzUkgTrwUGKDAKirAxh5pIE8JB/JwwSvw2GrjEtihctdhcIITslcJTIs1Bxz6dFlzi7lLVGHc
 uLNDE7ec3NzP91V54C2h8BiQFA/h7LE3b9eWDENZNWls0bNK09RoXq6KzJjKG60wqmIIduUjCdm
 Mdai0hdUfwjB2sOdCQuhDO10DsRw7xsswj6OwnPnsMwCN63CWyFoFhbRQWrtL4mT9cXUi3XN5dR
 yNE/crjjymbLS1eaKAHm8hcKaUQKkuQsF7MCCT9iIAFSFWyAW+8nNS7EWSs1J2SVcVNOK2+V3l5
 DU/fgcSH3EZA6roLeT8eJMGecF4rBZYxQCNTiJNEiG2F0BFBdCm1vkyIBEaGkbCscQniYjlXcHi
 mRa40yvvhdy93IC7K5A==
X-Proofpoint-ORIG-GUID: iTLDSzwuhJJbAMGASDswoFl6ZtNo4pTj
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3dfa cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a95-bzEMD9sxZBs1_CcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

msm_dp_display_disable() currently mixes stream-level shutdown
(disable VSC SDP, off pixel clk, clear power_on) with link-level
teardown (PSM config when sink_count==0, off_link, PHY re-init or
host PHY exit).

For DP MST the same link is shared across multiple streams, so
disabling one stream must not tear down the link. Move the
link-level steps into msm_dp_display_unprepare() so that
display_disable() handles only the per-stream sequence, mirroring
the split already present on the prepare path
(display_prepare_link vs display_set_mode / display_enable).

SST behaviour is unchanged: atomic_post_disable() still calls
display_disable() followed by display_unprepare() in the same
order, and the cached dp->panel used inside unprepare is the same
panel that was previously passed in.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a420e3d49928..03ccdf7e0366 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -722,20 +722,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
-
-	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
-
-	if (dp->link->sink_count == 0)
-		/* re-init the PHY so that we can listen to Dongle disconnect */
-		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	else
-		msm_dp_display_host_phy_exit(dp);
-
-	msm_dp_display->power_on = false;
-
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
 }
@@ -1482,6 +1468,20 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+
+	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	if (dp->link->sink_count == 0)
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
+	else
+		msm_dp_display_host_phy_exit(dp);
+
+	msm_dp_display->power_on = false;
+
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);

-- 
2.43.0

