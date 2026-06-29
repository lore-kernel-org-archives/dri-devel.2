Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4104C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC3110E92C;
	Mon, 29 Jun 2026 14:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cfRGgAUA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8yH/7Ka";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B7810E926
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5Fok2728575
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KKiaT5xx/5Rjyv5AnTtLaGoahc8vP2Fk5ORlipxINwY=; b=cfRGgAUAfp8TyRGB
 5zdChheuri6aZYZ5vYNmAUA79QSkHQn20SunMoRn1AyGLDmjIMlVPRvJ2Adkp4mL
 dAjN1rRqj5TiMWG+igCDKLxTf761iiX4AHm268gQSnxFawwCvy+Th6OA2FFq3CJ2
 palbmk9nTiHpxd/4LR3GYmHwbQDuoHzMRyOn0HWNWoEWmnW7pUQgo9CdzEQynlf5
 N2nxdr7aDvAh8G1a1z2uN7h+gETjQEquwY46iO+MP8DuetSTg2PGZ13iBoVhGM53
 AwHvqcV+8+wzNECLtP8Cy09xEOHd6KAJ6RGeDQwGeUKaw5f5uIBDQ2I+owdVY3kK
 ioGUEQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8pj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:29 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-737d2bd8bbaso2151383137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742589; x=1783347389;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKiaT5xx/5Rjyv5AnTtLaGoahc8vP2Fk5ORlipxINwY=;
 b=I8yH/7KaBcZK/9QaE3Qf3KZwh9Y+pH8lhcaJ+XJQEcjpvtZwx9sJsAO02FN7/KVT/f
 ja6Nw/AM7n7E43r1hge1jIw9csTMf+9ktH8KAoZQPA0yefj2yYWU2OV/petz3Ol3zNQf
 7gu/emL+6WHvFDQMxoO7eRl+IMqCD5XfpBqDy3sLJbbak35zwAfW87xsAfGxHqAWmU5U
 6GJlyFhRebUYiDnf9YagD3rMxXU/Q+g/lZh6tezDo9Cz9bOANkuu2gzcn+PVz47iUS5o
 Ra7yS8/zNGpYcvBBSLoN0B9+v1VAG2JXZDSAlXBJ8Mgo/RXWk0cUvbmJQVAFcY3NWSOT
 zq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742589; x=1783347389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KKiaT5xx/5Rjyv5AnTtLaGoahc8vP2Fk5ORlipxINwY=;
 b=GHmXGRrdecw0Ysl1pIBC1VsTxJjyFpVp+yiKShMVkn99NVtChFdm1S8YzAwUVw+2C0
 4SOTB6VfQ0pZ5H0Gnqt/SheySMNhhUSvpbx+R23XpK5HKlv03Q95G1IM6hF0U0RiX0Bi
 5pLECiCGK1fav5TVnIU5vP6f6Uukx91hH9SjxpLcWa9UpgRV1FDIh399WJLsCraPj8zk
 kC8n2aLqlm7doAqjPGsKQYluLZ0cJ0rafzIdLvRGSVDkckofJpigFEjH81PabbtJ2h8W
 Lg6igNp3LULMIbs+/gbiFiJCVxq3H03yyz028JFUuNzPu4I08eo0BdUqJ7OesZgxAF4U
 qIRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZmKGVFAEYccLUR443UzvhgQ8BxAHcsMA2CYFqH/wkf/L+DU2YcU4XUiiGaEaU4ox/UtV2rpTvLoY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJkGPcq4Wcq+3RmJZzZPLczTBjm64hdcd1OGvgSVYxr2igp1nc
 +UoRDxIb5CfsBtPOtMpYE9HuUAZOIuD2y9v14H7SvIHE4jV1o/5s4DI73lUpos0f19VhUiE1OQz
 zDAS7PhAT1dVqW+zWDznlWVtvXeXQJCAprjFTM81Yx1EYsFM8r8np3Y3aPNo9xtfS7I4YmzA=
X-Gm-Gg: AfdE7cklgT4QBzMGoWRN1ymbY3cnJa4E6vZ7mBIioUu6bDYbiRn/vIr7PMAap7WTVLm
 rqALajapF1y8Ya/FGC+fOCedig80sDtGDjNaotA2g6i6lV/fUDoHNABRhrLjzMWK3FbnG/NBtLq
 6bPfe96now2UjQYfsONAHQtYH35Cn6HEQ3FAn/WQ5KlMTzH2U3Nr+xfB/MZ8ir3Hc8iAmcQJ3/g
 v5tf/HX2zygW+ao2CAlFjv/V1oYzoY9v+YMXkbAMIm1X5GEGizwREl/vZe41ZUThjSEXwcvuozv
 3O9y+fYJ3MN6l+Ku/KyROx7blkVEd9UmlkAhXO+PMbtYry4ygRKnWMD1sOgK+6EMJTQ5BkbUWCP
 VRP2FL87BRr+0b88neoM19bMwHIov9aK8bt3d7CL/9xmvEYUpdzgPmV1+nVgHnf6bX2kjdw==
X-Received: by 2002:a05:6102:9d3:b0:737:783d:1912 with SMTP id
 ada2fe7eead31-737783d1bc9mr3304782137.12.1782742589035; 
 Mon, 29 Jun 2026 07:16:29 -0700 (PDT)
X-Received: by 2002:a05:6102:9d3:b0:737:783d:1912 with SMTP id
 ada2fe7eead31-737783d1bc9mr3304489137.12.1782742586562; 
 Mon, 29 Jun 2026 07:16:26 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:26 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 16/25] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
Date: Mon, 29 Jun 2026 22:14:37 +0800
Message-ID: <20260629-msm-dp-mst-v5-16-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=2339;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=cRES0c0OGAe+Wq5TijiVC3vsN9LDNpp2DEfSA/mpQKY=;
 b=arKuHVPqm5eA3L5paw1TwrwN8uIZnY3e8pB52q2qrkpMOOAvN7es+uYpYWWqugJ/7BI/mope1
 lAb8WvzTnvMCm+B6qi8tnPyqwNVeBc9l+iSVedt5PO3t3w2TgcGLGaO
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -1xJ7b3g_ySgBbNPmLnLPVUMukcShHNf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX4GcU7nLFBJKH
 +392+n4ZFeMLcoJlIO+pmCV2BGB2aTo2qmWmT+xIJsBEh7nMNdq83h1LNyEESpbS2uj1ygj/8Xy
 CYHREfT18YgN6TwFU6YyxCiM9QuVPwEaQZJADe9t6petKd1u+qMxndomh/P9l+TZF3WbkAnR1wQ
 FrYXGK9lKzg3KmNAfey8qGeV4N35qtQ/jmegdGbPbH1kIiLuAsLGJmwFC44FWbZNyH40e7BIhqH
 kdDp2BGAOdZ6FUvQBSsutGORrwyj9Qn2vnPDrmMFGTuwWBdlhUfDh4f0jxvKbPqTnouLo8VzuWT
 uEHwkXsJkqGU/DMlwabjdH0rgHa660uF1hVqcW0O99LKxzLO/82cPHXbOEiNFrce3CKZrkFS0v1
 u4bdjzs+Et8Ai6axLAYTulu82i5SgTdjr4DL5U7/iTqzqnGumVMvMjIvG1Q9fVU1v857yXJaog0
 PpXNMbI2QjwcsnkFWNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXzOJS50VMb+BG
 TSsZxgwVfAYIHTTU0t0EkxKSZojKJP9IwkSJbUelBHSY1Y5DlcP7G66clJqJ6YtKJ/iXYs8LmDb
 hjcqL8VS8PXDR2NWtY66ffLQ053+CuM=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a427e3d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6cFZRJIsygQ8aEszaMkA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -1xJ7b3g_ySgBbNPmLnLPVUMukcShHNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

Add an API msm_dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c3be656f10ee..2a74302bcb7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -565,6 +565,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	return rc;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	if (stream_id >= DP_STREAM_MAX || stream_id >= dp->max_stream) {
+		DRM_ERROR("invalid stream_id %d\n", stream_id);
+		return NULL;
+	}
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
+				    dp->pixel_base[stream_id]);
+
+	if (IS_ERR(dp_panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	dp_panel->stream_id = stream_id;
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 75dc40261723..676213a48089 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -58,4 +58,6 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

