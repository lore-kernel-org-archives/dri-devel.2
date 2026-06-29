Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8710AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16E810E8C9;
	Mon, 29 Jun 2026 13:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUldENrR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aLhFdGSu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE08010E8C2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASukp2603456
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KKiaT5xx/5Rjyv5AnTtLaGoahc8vP2Fk5ORlipxINwY=; b=gUldENrRoiE02QQx
 8KpwJoHCUWSLVv+rJG9OkrusdoCZqGzYTSLnBTGShHmzFvQj9Utk1pIfI+WTyxk1
 QKsLbYWWgJ7B2CtV3l+WOiaJOMWsOtD7aaxXFYwE4/RGTzw8FyPpAjDyuKbxDYlG
 QPjnor9iFxeSoOUo+mLmBCMQWn+lbxLerNB1Q8H6NKwXIV4RsjGN1mWGxqaQ+CqP
 yTWx7D21s6gSPcVOSDSMDnLIuqco+nzw1ykB06lKzoI0VyUkXd+vX+2Aoaq0QJ5s
 KK2CF+mdjVgQ65I8prFeh9SBNdJnn+v0JeX+IBPmc4myZ4z/5qVEFe5R6sq47zyH
 PKFI8Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq88y28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ee40bceb55so43525416d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739072; x=1783343872;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KKiaT5xx/5Rjyv5AnTtLaGoahc8vP2Fk5ORlipxINwY=;
 b=aLhFdGSu5D7G4V1Pn1HMqFhEmEhcjAjR67VYuoQ5JQE8H9XGQS+6WTXwcaS9m1Q2rG
 kXgOm+nwHO00FKpdAUxLuG8jNUHIRxRNxE+SNg4uls0CglchUdVV05vmLS567FHXr0kL
 O808llmY7Aq6sNzjw7yr1cuQ2e00MUqpnVoG5EuGVxF6aoorUN0Z/+ghoF1SaxSBBdYl
 IskztXfpv8Is65rKUyYLPQrqYSU0HLxPIGer3/Ot8D3x3GhTshdQUOaROhOrvbBl3PEE
 MjEpDnnvvCQQ/c3uVThfHAI4muJLP64xQwcXZcsviXRtqxPfMffR21UeeS6BvklFADaw
 1OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739072; x=1783343872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KKiaT5xx/5Rjyv5AnTtLaGoahc8vP2Fk5ORlipxINwY=;
 b=rjgb75/2oXvFOZEAX3ayOjhw29sbHGCclBw+u0Zh78ElwddilALfPiVb9GOkxqlG1W
 cpSFfSmlG3LsCEIBptT03siH1oit9xwfEIclr0O3kS3PBFTcCHOGKoPoV9jvl0aQ3fqT
 UAIelAO6JTBrk47IAQULv3ZNiD91kU4yqtnJsAFjklh3R7Z9UHdMtKU5lWg6HSKihfrw
 6u0uUgMGRfTfhzi/zJ/8Ji97YYUzbKKuaimUOm+QNappthLBWDOZOiqRF2xoLmtMjxvb
 QDCkE875azeby2We7oORn2+Ut3+a50Ge396t/Oo5JqVwmKW+eWgyQHZPYhIikyIaEh0Q
 FNtg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrh+0xPngyjub5qqWjoXRq41UhlGSMzqz4qht8az6kATvkz1ZPc6H/mmrWTxbkxI+2yjSliZcu5eME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz08Dk0G8jWXIjKHteJKOKQOZnmD6SI5YgzRKnbl2PaRDGaY38/
 QYD85QYw+WQBTa+HPwGJhC6gYgGDOJIdHwxZVBQu6v+FdxpW+vZw1BkoACQJ5mKgOs7PGc2Jw4z
 xqBFEiVxtepbEhp88Dud9XdrqJwBOxjHCvrdC4+2PY1ZN0BmFNW7bsfVhDkUc6yBHn3AbrmI=
X-Gm-Gg: AfdE7cm7QpUrQiKLG5B7BAlQ7z0pifL4wwjAEpq0JyQpRviveBoNHGcjwoIADh3Nlo8
 rc/inUN7hliqiI8LK9qYqVewtC5W2NAlOn2FCGNDpJqTQs80G0/duF5gI3fYg9bZYH+iUDNLR1Z
 bu4NFxzG1QX6+0QAOrvnbeKo9X9cljlH+sT5E6DKy3QWU55RIEf5v16o7CAcNu+ga6pQMfpJGCj
 S2RpqX4ITU3OOCjc2Ew9y8Bw6bRKmeWjvR82pepfx2l4x54t30kTxY1yTgmu5QbBGLYfm1uioyA
 rhafbjADzT9+44oCqQ1ss4dXTGg6riiXptkPTDNAu+2Vhp28/66meqVCe6E/vHaEuqtFtHYhDsj
 Fu1wgBwD23tozdPw7WcJS6BrBZNq76iN2JPQZ472IIBCHZY2CZCgwDRq0i2nYBU4ia3+BLgXPLw
 ==
X-Received: by 2002:a05:6214:f25:b0:8df:1814:3a1d with SMTP id
 6a1803df08f44-8e9847828d5mr169656236d6.22.1782739072522; 
 Mon, 29 Jun 2026 06:17:52 -0700 (PDT)
X-Received: by 2002:a05:6214:f25:b0:8df:1814:3a1d with SMTP id
 6a1803df08f44-8e9847828d5mr169655486d6.22.1782739071875; 
 Mon, 29 Jun 2026 06:17:51 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:51 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:34 +0800
Subject: [PATCH v5 16/25] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-16-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=2339;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=cRES0c0OGAe+Wq5TijiVC3vsN9LDNpp2DEfSA/mpQKY=;
 b=BPXZQqbD+OoLrbR4WKv2/cw7Eg3WmwIrZamFveBb1IYFuenm+zS8vwTTcMf9uNx5hMwA4KBdI
 XiOdxk5XCUGCwUYjQZHTQoiZNCwx0RKrrh4S1PG910ygnx/pr8gXZjl
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: AyK33rDk33F3-weSzxwJIRtgRIfnSfjB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExMCBTYWx0ZWRfX8gnOd58Jb+TE
 +u+2UqR68Iepv/xJMtfwxy3UgYZpPJgQNgZELDjCM1y93hvo5Hy8JdEw0q6I/DxvoVzZlEs9b19
 t5xEx39c2nQJtc6wA9Cq2CwkUMgThxI=
X-Proofpoint-ORIG-GUID: AyK33rDk33F3-weSzxwJIRtgRIfnSfjB
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427081 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6cFZRJIsygQ8aEszaMkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExMCBTYWx0ZWRfX3vfRGLAiNlUU
 kac/NUnhCwZ1yJS76LGWIQdf5w0HfxiMQiath6dV+cl/bLvkmGDR3PnMChu3r12OTfSHPsKUBCm
 +q8gCzF5dfZfaDCMAClyE4c53L+7bFoXQCnjpVA6R4R0GRsi3pBK2wdg/sLh+kYVlr5b9hpSakM
 L0uheeopzR3V2/lnrHXKqW1XgGVsOb8f066z8GWirfxaSCRxSsU821koPrDESkj55eccXyDJnWt
 CY/0aA4pdUu3jNHNnVpPK6ybIGBbLLIwmIqxObQYXvW7EgayOOSkwENsKAP7pLPurmhaD85KmyF
 UwO6VgTrIH3dGPuH+xHGunswPyCuGXJomtGN9CBSh6iRfXHp9jL6UfaEcGyvpMARcUFn9QV2Qop
 IZMarQBuhikQKdUKjwgDiJ2oaqo61bnKnPfu/6NAv8nLApbWvVA2S/fvREwb8I4mAI9x63oFcwV
 +qJS1MlhwnxJLQIKUYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290110
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

