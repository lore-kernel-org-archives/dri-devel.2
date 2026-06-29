Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA29FC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2213810E8C2;
	Mon, 29 Jun 2026 13:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZRTMjL1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIFSaFQM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF71E10E8C9
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4A02646947
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jg3KQF7o+VLEpzr4rtd7xV5y0tUXL2CgXc+z/83VRd0=; b=DZRTMjL1UvgFaKHq
 LF/eQzkKQWrP2L9R7iVF135oQnJkNS/J26MHWupyBG0NCo8vIZOAtKNRh0RBtBws
 n4yf0fUc/RLObJRCnpF/Cj58BWNJzB5QalWbgelAiQ4UEo+pgSOmXhmg4i9AGVUj
 uqH/srMO7l4m2Q/csYdjGoN/BpGDCItr0JvOihJZuPV9/FJgWVEp5WBIflh0P9Ao
 0ZNnPLyRS8U+QUCbq5/X7ZqYCchwSwLNlZhZQZGYZJ+cTzeBwpX4EESdk7UYG3AF
 41WuMgt4GjaotJQgD21RlRXEdCSjNOT15lJZizGtNYzvbS5cPQ2BoMetHaCcGAOs
 /Hr0vQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tse5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e9b9f30d65so58225286d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739077; x=1783343877;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jg3KQF7o+VLEpzr4rtd7xV5y0tUXL2CgXc+z/83VRd0=;
 b=dIFSaFQMNJM2hacDEb1fBkkA2OF2ZO3pVALuhzrk8BlAvQAGDu2FtlubvQIOBXzzq/
 IQuGctZzi3bY++mCqNm4Uo6Ybp63xX4K+7+6ts382ILExgGoFwjau8EH2MsX11jG+YEM
 YJduuztkk7PQFQYt3Z+qXnaY/VB5dqC7PHay+mIE63cxE0qPTW5zDhTYKdWWroybG+15
 lDrUuHAzDxxJBpHAfMLS6y0lba3HCW0ROdFCdSA6q/1KYgJxsfePK4KaL5ZHgIfS53dn
 srZEgaHDdnHjKMyy3WcpgKQylUFal/x1q47OMoQC1bzVECJ98p2/BGrWPNdCHraPwJhF
 Ni6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739077; x=1783343877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jg3KQF7o+VLEpzr4rtd7xV5y0tUXL2CgXc+z/83VRd0=;
 b=KCk4ixqLSZV+rvH1KIbz/Je58igz0l7lreaupXNrM0/YNzUakxm+8tzYmPjTn2XBjU
 cVedj2v0didwNvzHC86AbSDXaO1f0lIU6StIbYqlAEOJIzITduKHKlFmq8EdV5rdHmTs
 ozw35psdZjSu0e0vo/fr2P2swDPktNmEeXtQoWLL3mni08jOL+w+uYR2bbcw82MKtMVS
 Y6iLjsTj/wm1YSNapCTEzC5IKT3UwRl9i7yYGGl4fo3FioR0sm4HPCSjkmxQBfvg6xke
 Xo1/OzXWedZFAQRO0JjaAXT51qiwLctglJvjUKLrox/c4JpzUO3py0g+8a/QCKowzK77
 BA3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rra0OxICsjwD8trVRhVmmx1xo01ov5sk6ueCbRYmoLBo1KWbcITVIA4NvmQJf/iyYjoxZJg+W8Fkbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqChcjC16WYbo4Oui5aUiqXS33uZv5eDJK5hpkdFZpWMolPefY
 r5lOLGUtiABFHWRjGu7BHfNRCugIO9EgjLur8EaH8DowQ/lBmUpBXXouBPEvNQeNiGlotd5qvWL
 mLFe7bbCwDaw6Q0bDHVvdE3KSFf0oTkNLK+00svGczCV4M5ISawQwpuZrMOQleB51Fd/qSu8=
X-Gm-Gg: AfdE7cmtXtdP//pmZp8bQgmDo/4e5gy+C6jPRLgQMx4Ej33d+inaegC3SZ6ZvCct9DT
 5alN/HwcpIG1pnAq4tOHQYxOa70DkL3q/TJUJhbkYMmDFPSYbuSkqeXBtX5VHdaYkr91FHxsFgU
 8/yAoFkUOS6eVsjg7DZHxk3vjJpk4lEf0fVcTcTaVzyRe58ipEgDMaW35OfZD9AoUmdVbetpzpY
 LxN3FipV5Ud7w+aczuDo5ZNQusEKkYd1iOXUo7rSyecQ3ZGAKL24qaKDycWdVurnK/N7Uk0yOsm
 i+rjp+VPAPiC1vPffm5bivvfDLEtOaRnrUcTgNF1SVtQRfy77WXkANlFZfH1Nkg1gkxPkfJqjtq
 d567oMwtp9X4hOb5KRN+yZbhyzARHg0hTNfxDlWr+mbXSFiC2vyxZpV0yjAZJGnKcmam8Uj2QiQ
 ==
X-Received: by 2002:a05:6214:45a1:b0:8f1:8349:59ee with SMTP id
 6a1803df08f44-8f183495b58mr1994156d6.35.1782739077018; 
 Mon, 29 Jun 2026 06:17:57 -0700 (PDT)
X-Received: by 2002:a05:6214:45a1:b0:8f1:8349:59ee with SMTP id
 6a1803df08f44-8f183495b58mr1993626d6.35.1782739076518; 
 Mon, 29 Jun 2026 06:17:56 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:56 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:35 +0800
Subject: [PATCH v5 17/25] drm/msm/dp: add link_ready to manage link-level
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-17-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=4047;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=RzJquXKOi3YyeF66FrBYDSkGWZjxoRxULVA0FumTtYk=;
 b=uDvZBeCjHj64vJzwwVSx51y1oYqt3Q1Phfzltonav6DnFiFlPGSlBBBPbFKIxLzgaiB6UVYQ4
 8ks5xhS1uBWC+VK+q9JuJF7LioWKSqX15JHjALQjbQUQHc2bYDlw+7G
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX3ZeesS+hicNE
 79Y4ekv7eH9FvKhPwhmMehtCoWSf4b/YMSAl9vxXxuBarODZjYYH0nR1+7GcUVWM3L9/5N0SC+1
 IKl2olup4AAVg3TFnfVRI1zRNTvxGeqYUyy+JlYIUJder7+OSJGjvW2OAn3Sp3/iD6bRnPfGk8v
 ynBB9bMc8WqyHy24ahCKL5BReHfgzUG26mo+CLaoCVtlcGOPqUybzoJwyyHOAw/4Khed/H/5uwb
 TNC3w1dpgGCtErIlIJgAOIv52sQDDqHGEp9W3TW3x+fqdj3u9bBNofUMSB4ipPXDvrA9kOCNTS5
 AB9ArBdpEqKG0JFbAk/cnqMnWjZHHZSawq8KxvZvhBg/DIATNPyDVyIvSchYj0liQqJ2l2kktZQ
 swIyidwVy0mcOCPOu1kjIDGWjHBeoSEdTgf+XMIgbqhikDNQo/jLxzeHdAOlB0szTRWj9Lmog7L
 RoM0StvSa+CpxjwFPuQ==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a427086 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=r0U9Mmpn2XdHegFmGjAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX3zfqi+Vi82GN
 RH0bl5CLlGjcHVmQEOq47FIm+M6yNeL+tkr51jmzuR590nKcihQxdw3TR0mLxhRYu1AuMdZEneJ
 6YmEZBEL0weyRvpH2L7koqgTS28oFko=
X-Proofpoint-ORIG-GUID: _L_BxBjvketrl91pz8GmyOuPmGtV_-Kg
X-Proofpoint-GUID: _L_BxBjvketrl91pz8GmyOuPmGtV_-Kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

In MST mode, multiple streams share the same DP link. Track a link_ready
state so msm_dp_display_prepare_link() runs only once per link and
repeated calls are skipped.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 2a74302bcb7c..d56ee10ee065 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -702,6 +702,9 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
 
+	if (msm_dp_display->link_ready)
+		return 0;
+
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -714,14 +717,18 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (!msm_dp_display->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
+
+		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+		if (rc)
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+		// TODO: schedule drm_connector_set_link_status_property()
 	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
-	if (rc)
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-	// TODO: schedule drm_connector_set_link_status_property()
+	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	if (!rc)
+		msm_dp_display->link_ready = true;
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	return rc;
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
@@ -1566,16 +1573,16 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_p
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_display_set_stream_info(msm_dp_display, msm_dp_panel, 0, 0, 0);
-
-	rc = msm_dp_display_enable(dp, msm_dp_panel);
-	if (rc)
-		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (msm_dp_display->link_ready) {
+		rc = msm_dp_display_enable(dp, msm_dp_panel);
+		if (rc)
+			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
-	rc = msm_dp_display_post_enable(msm_dp_display);
-	if (rc) {
-		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, msm_dp_panel);
+		rc = msm_dp_display_post_enable(msm_dp_display);
+		if (rc) {
+			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
+			msm_dp_display_disable(dp, msm_dp_panel);
+		}
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1624,6 +1631,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->link_ready) {
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+		return;
+	}
+
 	if (msm_dp_display->active_stream_cnt) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
 		return;
@@ -1642,6 +1654,8 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	msm_dp_display->link_ready = false;
 }
 
 void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 676213a48089..0464f8941e8d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -22,6 +22,7 @@ struct msm_dp {
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;
+	bool link_ready;
 
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;

-- 
2.43.0

