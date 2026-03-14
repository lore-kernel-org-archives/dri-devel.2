Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE376107BCEE
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155FF10ECE8;
	Sat, 14 Mar 2026 01:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X79+d29t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BdWCQr9V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6350510ECE6
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DNI1KC1438594
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7B0471sRKQMwDEZP6vpU2reSm934CwZ9IjApmWlQSQw=; b=X79+d29t3XHKRreF
 +O0f8mcaQwDaxa2vr6lUB3WlkJGsbFJicY/jHiQHrOQBBki1vjz9+/lywyfsg8jK
 qifkCBCL8xdIzYHf0397vUECcnQmpTBYcKUlUMR+sN5AW0v0a5tSGcJmOpH6GhNV
 RXPJ+qXonZI/qzkziLbroYq5GA5/xW7E3lIpcdNPrwFhJsgh+dSxky3XXx2L9DSH
 zSblkUiGv4E6QZy8RDwECBKIbjF0jSpcNe8+ehuRDQg0ZmKn6uMNjNW6UCIBB237
 QjILzUK1KB0U6sW1zP1OHQ1BMgXeVH/gCid+QoISVQ+uHcg0VSQb337wYA2PFzGt
 GtbQKw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvnax9m1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5093787e2fdso357125311cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450587; x=1774055387;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7B0471sRKQMwDEZP6vpU2reSm934CwZ9IjApmWlQSQw=;
 b=BdWCQr9V7WcgpniUcXnjT/e+zFaKlep131zGpPLh+0TQZZlt4L3tq4+TiFF/xd3DTY
 Yp8MjzuU8TRjIJVKrMLQRPPbbC7OmutPeO2Ud3OTj6KdZhwf/Z7rnlRpmRfi6+nF/e49
 y+U42KTtH6JYhXl4gNvAXOZEIVE5krcPyaBVQU0lrGUUjpIklsIguIVXVvUhlm31ATDH
 CfwcfWuAmpuB3eptb9bgBmVItsGkCGusOmuRJXZq2eUgZJUroEjyqLpk2YgoJRyuVnaf
 InUlBq+SGr4dOjqVCrV426L2MCTGW76Ux0J2+AW7Zlm+9o90bctsds9XT36/wRxn/L0j
 HbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450587; x=1774055387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7B0471sRKQMwDEZP6vpU2reSm934CwZ9IjApmWlQSQw=;
 b=B+brNQQAODrb5xwOnsAtc+svercIMLTJFUQhls0NmIzp8b/zzHcf9yFFMyV6q1x6+D
 f+iW0MS3BWOyb9AZj8Ft8e+u3mNcC5WOhlYKNvV32TMJLKG6Edf8FIGXDQBms0dNoQIw
 7DCxWqVdoW31Ip4yLGUUorN3hkj0hNaoulkfjcB5CcMZ56mT5fJFaVSD3Gh83I8g6KUp
 jNIs9t0SlC6tWq4ujIdGpH8KsrQBdyn84SK/SZP59M2hF1WwjwDA9BcL+oOOgRJN7VOw
 eqTNpStOwHb/kjO38r0xfLKzB4BdX2Br3atMGv7QtGBCrI+pZNDxvA6WxcM393FHRqH/
 Miww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1KJ6UIqj1sWf4pIxNTbJrHBvhUy3YueNAxNZNQ1HVVx4YDr8wsoDbtB8Dnv/ffonCaRuvgNn3Szc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywa0TH2+cjSJs1uRCtL+1QoRJXK8H1aPPaYXVGeJlFxjheW/ose
 FGCo2nLfoRKFa0lc0GDPYZiLOCAdUPme+Uv4hchfSpfqf7E7m7pTQzXacbnbBUURw3V174/Mdbl
 A39uXkpH6vJrmZ3FG2FiTNhlcKANq+V/TdAN5V0ikPtyXwPqdlFLqQs756mp2b1yLykNYar8=
X-Gm-Gg: ATEYQzzb1gbO4orRYVnI/1GqH313aVSv167a6dcsRO9ChGi1kN12ISC9WydaPFIbVzt
 mhIdR3qQE/rs8NMbl75snDILB7TRxrSs1g+SYNHU2MogpTGEqCnGpHeOXQxi1uVSZCa7EVWTJjo
 yguGPjBwvcFwsVMI1drLOnkZD0/fsOJgTyqZM4BHXKg45gLrU3yJZLy7YMtTJtuSQp7ciw92jWP
 ee9YJM7VE7yrRL7427go0nxC7niN9yjF5FPKghjobGvHxokGYxkZ8sKnw7lzElas6+pSsfWBdxe
 DFFVFJn1/GjZUHn5EIPvnRwvuIamuH8IFSacf+thSJvpPuDxsjq/HcFhdRAeNMS9pqSvUIWlg8k
 omWJ2TSpu4oHU0oVH7npAsTE6mTfn1k483Gq3QhKHMLjA0B2inR8vLye70TNt7gj4nc0YRXucUN
 oOwO1W5HEGHm3NDG2TrLUas7yWfVGjVSrq/EQ=
X-Received: by 2002:a05:620a:468d:b0:8cd:8938:f000 with SMTP id
 af79cd13be357-8cdb5a610edmr773788385a.28.1773450586677; 
 Fri, 13 Mar 2026 18:09:46 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:8cd:8938:f000 with SMTP id
 af79cd13be357-8cdb5a610edmr773785785a.28.1773450586260; 
 Fri, 13 Mar 2026 18:09:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:14 +0200
Subject: [PATCH v5 10/10] drm/msm/dp: clear EDID on display unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-10-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mM1BPVW1QTH7/BXc4PZivhB4YvjG5aoCpugqUPEORdA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLU0Pw/Wr8XI+UeUONhk97j/MiQGZKZWH4bTZ
 ZuB82VI0PeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1NAAKCRCLPIo+Aiko
 1TH6B/9HVOXDOqe6Kq83wbuYJWfsDNfh6vW+7Iqx/NVA9Nnx0o83c41Vav4ihMIyb6Qj/LUe9ao
 uWaO0T3m5Y+Vv2/2cXK7OJxlssS5LPWj0xJlATqaY5bzdmw4dosdX2AdVx7FFeOTDiHeYjeB/So
 P6p/pVrXzztbZMMFYu86QiYRLBhrTMSz01gNqcf+CPIskZM9fuBZ/YqlRAwHOjHKsxfjREYZqll
 BsRNZz0tTh3ItupQBaB9fPnynvNfTPevJZI7r/gBQdChqRydV32MfJ7vOJTssXXg8i4pOX26CXZ
 JoAKIXO7q0Oy9FFK+YEYEeco5LmhuYsZzV2UVLxqIyWs7CQX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: WncZzcX-ANTj4Mhp1YAqmHQUgxNn2MVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX3uCfUHhGs7sY
 JSX0Treal5n+xtLzfO0KNrfx1jszpz4wcGWoD6f63EWSgWxywd2snlVkILfotyeQip14KzblWIM
 V3Lb9/VYALcinadl5cCtX/9jOZnMCQ+/nFwNURAXNUKjkLwg9GJ8jbWPL8pVjFwLH8+WOFwrqNl
 7grhkslOG/AeuCBej4MkdaTsvFH30cz/vJp4/rMg6rviqWWcHqCxIDGZf/GdJLOx/6orjWkv1ud
 uX6fWO8aHWbVGqqioyR+erIPkecyg0tc/OTzF6Ji9QjJPMjdP7kgPDUk5zyrjagAPpJWA9/LMy2
 YLtCS4L6Q+qmBlyY3lPS8dHTJKrd1ZFKY0ZSaW9TG2DR+fKWaf9ChThuqoCChaTVEWV+BjznblZ
 u/5Kl3QedY7fYRjHmAc9qndSgW7LPqQdSgCrLObMLUACViyURfkUFDKQUObJpxBvMNWRmMPs0pz
 56/YV+5Bkf/ytqcIDYA==
X-Authority-Analysis: v=2.4 cv=X5Ff6WTe c=1 sm=1 tr=0 ts=69b4b55b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=NIqqIfc2bYnrFRhDr3kA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: WncZzcX-ANTj4Mhp1YAqmHQUgxNn2MVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140006
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

Currently the driver only updates the EDID when it detects a connected
monitor, which results in the connector still listing outdated modes
even after the display is unplugged. Set connector's EDID to NULL on
unplug to clear the list of modes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 8 ++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h   | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 0a38957ea901..5c6a24ec140d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -447,6 +447,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
+	/* Don't forget modes for eDP */
+	if (!dp->msm_dp_display.is_edp)
+		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
+
 	/* triggered by irq_hdp with sink_count = 0 */
 	if (dp->link->sink_count == 0)
 		msm_dp_display_host_phy_exit(dp);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 891211b23202..6bb021820d7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -293,6 +293,14 @@ int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 	return rc;
 }
 
+void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
+			    struct drm_connector *connector)
+{
+	drm_edid_connector_update(connector, NULL);
+	drm_edid_free(msm_dp_panel->drm_edid);
+	msm_dp_panel->drm_edid = NULL;
+}
+
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
 		u32 mode_edid_bpp, u32 mode_pclk_khz)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 177c1328fd99..9173e90a5053 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -49,6 +49,8 @@ int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en);
 int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 		struct drm_connector *connector);
+void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
+			    struct drm_connector *connector);
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,
 			u32 mode_pclk_khz);
 int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,

-- 
2.47.3

