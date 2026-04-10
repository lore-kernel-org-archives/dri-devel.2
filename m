Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3281FE99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977C710E91F;
	Fri, 10 Apr 2026 09:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dd9z5gNR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMmThU5E";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12AA10E91F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oQkD4148720
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9c41ES0sdM71vStxR/HY5UBmWgzT7fFS9JcAFYCbYQw=; b=dd9z5gNR2KxjtgWg
 GTd1xa7zVYhnBYTsje2JoydhnQGt0TxnUoePVVI7X0dv/s8llqGOTpQ65xtJ9/oH
 kifVcV5psDg8RXooomXOYF+AMyjlY4KSKGayZ58roHvwZ6C4GtQZHBMyEaiTIrkk
 ljZo9flbEj1dmdDh2huF168xZR4r4U+Xrr1mOV8W6pcEDKOsNfERPau6sejU46rC
 d/yQKIYw5PA1myoIs4Kw18dwoBUg9ZC3u/OfnfN15gGIB+7swlAtY/CkEglKWzrE
 DQKAV7Qn6oacnlVK8ty0xCaVHag5sNu7Nvwlm3Q4v/0IjWFgD450Df4jzVGw+2bb
 WmT9/g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudggsqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a5f6110c1cso47969746d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813758; x=1776418558;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9c41ES0sdM71vStxR/HY5UBmWgzT7fFS9JcAFYCbYQw=;
 b=ZMmThU5Evu13Ie7ojjT/0rSXrk/SxgEE1nGwzwEdH/qtG0saIg0Uo5P0ILGfUCW4gj
 XWXYrWIkX4Vn/VytbHfRN/xiyBoFyrVOMb4O/WPsoqYF985bSIP5+qONNgCd0qzWmWmd
 /dG0DD4AeaYHh8zKMrpcqqNR/ERVye3gEErVHrwXZcG7EaBAipVc8I7bDPI5kdB/OTn2
 K6olJa/AH5x0+JtHDJ8/ZHMmsd0yjkUWIb8RQtqLMxzdSYEUUxc5AwuzNDXZX1Ix5FfQ
 3dxXvl2s8qLYWMsX6VtDsdrjvA+sz7febW+2Pa9bKpYz4DRKOC9XqqG0P/GJN/cNwJfv
 uJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813758; x=1776418558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9c41ES0sdM71vStxR/HY5UBmWgzT7fFS9JcAFYCbYQw=;
 b=YlZVbz4XkCot74dCUF4rbUHSS+7w5akKewe8KzI42XW6Bc4Pp0RTwlFubU0FxUlszR
 EY/Rzs8wP7jOfYVUQ2jZPsYRb9kwCOPj0YdAzQbQGMFUDAnN41rVM5P8SY1cZh7KlZlG
 D4U42VTr99gmzUg+Ebcu+MlorpbxHJ35tTQIl9Vy/Mhe1jWkYZqUFVX67gWCs8RrkaZf
 pASHuac/e0lgQlqiAdhC8ckGKpKu9y92DGKTKSrsotXesyPuaFJiiQu9IqjVdBRk05w/
 WqWUIyjduFb5x1KA+tOkJ8v0sONwsxOVEb2BK22PH5V3C/U3Us5bJiIx+6eP6yTi+kkT
 Hl8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfZdundgxCZqCkbOQ0ECVVOfTJbW/8kM0MLTF8Zg/bnL6F0FhP1w4+zjyyzFoC1HthQdkGY/nCbt8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEmI02h7ASVSIke/fnl/Yjxvllw40Pgp3rGuiLeHmT/iBfePtj
 LLT5veoD+5LK3UG3ZN73BsmIxrjKxFarv8EacDSegPwvJNear49Ww7oxTuKRluQlHVxZj+UXETF
 ppVGYid2RRyHowpKoR7ZTtJbsWGBaUgqa2lqbUHb615lRy8+0i4J8sPgbvg9vX2FOapsDmRA=
X-Gm-Gg: AeBDiev2hdhQVjGo/W0Xj32fUXIxctud1XM/F4NxGhLQwf471vfMzg7Ia6hu7dQN7ZD
 Lv54Dhtg1Jm96oDS/pQEjP+b4VhQY7W34xhmpJVjU8YS+/JTLWG8JrHIasnr2If39G7hh9UpgDk
 DE3HT+lMEmTayqWU1XpIlkczLrypMgWULfBZs+5Q1rM4G2147Nr6EiMNF9Ojla6kERHoq9KvOj4
 C1yZhgtW0FkieyRucAS3aw0vGxQprXQPYYiZNvcTZmHzJ5XWjgwEur9QHq7+ne6q6YW38R6oKKb
 GXGYxBicT4sBdZnLt4RGCAQUnFyV0bdIrFCxb/LSY6BiJ07bCbS4Pkm9WZ5H7VEdKtE63bL9GDj
 xbQfu1E+BB08s02pxGR5QQwgg4vDiM73BbWge7Baf2El0AC9P+e/bXEGXU8gW/8IJlu8+0rH5pK
 ED4r857rI=
X-Received: by 2002:a0c:f40b:0:b0:8a6:17d7:286f with SMTP id
 6a1803df08f44-8ac8613a142mr34289386d6.10.1775813758286; 
 Fri, 10 Apr 2026 02:35:58 -0700 (PDT)
X-Received: by 2002:a0c:f40b:0:b0:8a6:17d7:286f with SMTP id
 6a1803df08f44-8ac8613a142mr34289116d6.10.1775813757927; 
 Fri, 10 Apr 2026 02:35:57 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:57 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:00 +0800
Subject: [PATCH v4 25/39] drm/msm/dp: pass panel to display enable/disable
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-25-b20518dea8de@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2830;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=f/RQz16Zpyd+0rb46t9HWbjfcFSVL9mHw+8FAEWerak=;
 b=cC/O0ROu2E/i8qbjxKEb3wkm4o0YFsFvjR/jcDorbaKGJDvDveYW04Tw59v58WHl8xzKb9msu
 ooCfN0XoZdIDrqCOnIbTe7d2b7OGacAfHG0GRbJePcGs+rQ11Ibo1s4
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: uduyXmQ3noa3dhBTNt38RTKel2aa5hp9
X-Proofpoint-GUID: uduyXmQ3noa3dhBTNt38RTKel2aa5hp9
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d8c47f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HaYln3OoUMJQEL55_tMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfXxDhEU2fv8grN
 crL9YRlko2snHvFtRZbkT/ph4qcrPjL3U521uAb8BB/so6KRvTLJRgdVRytZh35c4wtj4889M8S
 jl4/5Lv7gZJLmMmhTUBfyV/NBa+/I+BWZGSeCChruPoUBJlAvfUQtYToJvqXyUDwQf6uuzrXuB1
 BqlUDq9DoyCZby+rw95RDU/7WBKX4RbZbvo66QEeJXB/k5H3f+80siyBI1zp8ues0rOjBqAs34D
 aUWt04rkiHGhEUbrx+b1DInSk5KqPYqJPQvdxBnDDrGrQ4ujOtZ4+ChRFYl7iaJe7rSXGNg/EDk
 eG55nat7yAiI8aEvqkxFseuU9RZmA3d8fKDWSYW4dvpfYI1rkxF43C50sYWXTUUHb23Awk00HIR
 BC/lkBd64M/KU3JZThJm9jIP2DbtoM47N9xwdA8GVlUa3BAiGdlqgQr98CEfkcXX2MFkSK9x4Jc
 ZJ0qBf+IO6pFaTjeLOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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

Pass struct msm_dp_panel to the display enable/disable helpers to make
them easier to reuse for MST stream handling.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7b3b9160e005..88a078e53dc1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -668,7 +668,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -725,20 +726,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 	msm_dp_display->audio_enabled = false;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static int msm_dp_display_disable(struct msm_dp_display_private *dp,
+				  struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	if (!msm_dp_display->power_on)
 		return 0;
 
-	msm_dp_panel_disable_vsc_sdp(dp->panel);
+	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
-	msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
+	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl);
 
@@ -1529,14 +1531,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
 
-	rc = msm_dp_display_enable(dp);
+	rc = msm_dp_display_enable(dp, dp->panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp);
+		msm_dp_display_disable(dp, dp->panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1573,7 +1575,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.43.0

