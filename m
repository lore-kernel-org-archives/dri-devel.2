Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03C5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085B410E8C3;
	Mon, 29 Jun 2026 13:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o9Y1TRSl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTatqaK9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD7010E8C3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASqNa2601114
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nQqaaloZaS5enQFI+d8KGIEPr3AeTZ/Dz4Bxlwebq68=; b=o9Y1TRSlLWPBNBbb
 BV7fMM09Bhkg4WQt8GolLyniCDCNlqhMguOgFaYbPl3v9oXGC3yrTeo+8TqzxxBb
 hYJNfr4roZcVSiz7/LFgIU2YbQ2Z9p38QEfQpkyswLloWU1W3kbz1Uq8RlVJegTA
 ELzYXIvBlrFbDBS85CqSNDsOqm5EOLUojfs3H6Fi0nZIZ26voM6sMmKZZq1eepjf
 qtCqAQYYg9NDUxxW74KNhDA4oUrGVCmYMi8w/f/MK3hfpN3Eh808jtnD295CiUsT
 kuKMivNwEEpDq2ObddbJciqyRnxapQaOSgjksfVa9FlsL9qV+BxpNeaVChGXspeS
 91yelw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw9019-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ee593a5a2fso46462676d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739091; x=1783343891;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nQqaaloZaS5enQFI+d8KGIEPr3AeTZ/Dz4Bxlwebq68=;
 b=bTatqaK90JFzkFDgn+YbS3/92ktH+7oSxOvZXy5otnPjerMYl0lat8gL2VyAZVrwe6
 39HxdjLraUHCwEl9BhFeLRShQcqXi0BIpnNDtt9xCwLokQcpoTWtDnMoWBYibYuAg8mS
 47N7BWeYOO3KkQWvZtNqnXqR04LozKmHM02rsXa6FePcm33rHFwyiIdbNi10buKVHoJr
 XsEBAzUnbCYFkwH/9UJ7bSnzgryJ4cnXqOScesXdt/ckgsHsJwVcI7lwIetNoGh366tC
 ux8em+EScZ8zHQaIVR608q+iYL3d63qMF+b976CdPX8BMi4rLXzGGSl30JDf07AooZ8E
 KB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739091; x=1783343891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nQqaaloZaS5enQFI+d8KGIEPr3AeTZ/Dz4Bxlwebq68=;
 b=Qgk4NKfKzzyDAfiJVY+zOU26Ps2xRtr19DdcUeeYNXosksMbmPBsLaLG2d+aIuXBa1
 U487izTNKDhqwN+0Hlcec5zj5Em+uQpcnUro0M4JoCbZluFwaiArmZUL+0qKm2z3TKEX
 h8r2zSXM1jtp7NKQ1SYsttrnvSt9Okr96QXzVJCbijj8X7V+aZfqcFdw2FFXW0vt+kwX
 zAa+dotz8Sgk22FAWw5buogLz0QU13QHilnYRoorw5YVjBMSi59vh90sUVqEzuK1H4Cw
 SSVlfUrezakBzFK8fOh91J55j1Eqln9fTw+6G+VIzlK5KPRzGVy9Ev593z6niuDVsNX8
 857A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6M76gt9iH1QqgY3jaV2wDahKqNIlrm1SfaAE2+PAuBRKGAgqZas+vr4HJRPlEghmRwbc0KfYaBZg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPbjJQbDAbXHNykV/Cl2iuKx0HlfQnCfIeKzu14DGb/cylbdLU
 SEz719P/+tw4Moo2GKFUxVr9M6NRyoMx1xwo3pCeS8TFSNP67aAMlCL3OCVquB/VHcLSix8Ki+k
 a80ifv6d4fHhyPUEodsUugkKrnPz9BAADZLaKqeIPq6E/Z7AFFXK/wt/WM+/ouH1FqNAXQpc=
X-Gm-Gg: AfdE7ckV9Qgxn0NoVK4HB1hOJaXHZ38L+O9PK8G3YDGZWef2czIlEWvA+CH0R1zeGTM
 lS/DpgHAIplcDtJOlzbheJF3xpWCUYwAztHJpOom9wgFF5PN98L8mF8H7IgOwhaSTCYPlwNcNbD
 pz9UquSZ7Js7gnt6j60eCTECX10V2/U4Qnmf++GHD2j0L2kKeVWH3m2hzQRCS8UCJa4bDkKPJcs
 KPIWyy4KnZ88YGWgDGW7wKDT9fZ+Rlh6ZpSc2Bsxvsk9ehF83NBn3fHbyVbGRcykeWkH6eJhuIG
 tWmliRHQFsQPKQ4mWxzDTy5y7PvgAw5Kb76YxFScXm+i+pZTIqRzhcPpfEYv80Ydij7dHyp+GGn
 3XRETaoVr/SLI25YGWqwZtw+dA4/AuXgpZkAm8pgecdqnVoIMJJLc6jZdlwDUZwMeJyEf4bSagw
 ==
X-Received: by 2002:a05:6214:130d:b0:8cc:d6a6:f54d with SMTP id
 6a1803df08f44-8e6dc53bb25mr248660676d6.8.1782739091265; 
 Mon, 29 Jun 2026 06:18:11 -0700 (PDT)
X-Received: by 2002:a05:6214:130d:b0:8cc:d6a6:f54d with SMTP id
 6a1803df08f44-8e6dc53bb25mr248659806d6.8.1782739090649; 
 Mon, 29 Jun 2026 06:18:10 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:10 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:38 +0800
Subject: [PATCH v5 20/25] drm/msm/dpu: expose dpu_encoder ops for DP MST reuse
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-20-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=3441;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Tea5Jce8MD/RzZsevZLf4xjvhzOhaNCerFeZKirGZak=;
 b=03vrRX0qwfBSkfomWsK5+tGFhYlK93ryAf76FKomUK8Vpam59lbtxLK/MKJdJktg26RC5giMu
 tDN0xdWTdR/B2ARLA++41ZitJT3+ICyDiNAuI9uI64RGxWF9s6k3AuA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX2cWOdV13X3DE
 3Y6LVjxZqTC+dSvnjyL6p4LoQubCJIQaa1a2LsoZxrs+O+8WU9gFHhhfW1dSD+JxKfWUmAlI4G7
 hw93ghqkUEU7/MByWCedVTwvbWQoT10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX6xphjnYIbYDu
 V527r6VEUEFwb9KKwW1R8RVB59BM4hIUT5ZTV5WSsZtZuhLZ4UlEvqEvKNsUD8JjyYoFz3cC+b1
 UkbBrE2qCjaUD9RTiq/JYzazEX16bpmaS4fzCGv05FZIcWetMr+uvILCSpO1EEWFApPvd/7K5Y8
 UQHMgyorRiXkM3Bg0nvq0Z0g09mLclMkoCE+M33Wmcanh+ZXEBrjX/jBtv0w5m64xQVZJqq1WG4
 2nOJFYZtBxTvbdDnjlEyaVkRJbtm6qddrcQi8ZokwV5vQO8Xk6HyUVnZiY2VKJwzU2LOQAXDygg
 +zt3voHsqEuowWsYVm9lBYo9VnCA9a3D+Qpqxmm/6NFZV0DqSPYbgYQAG7hhRrE3xgv2CT0JDeA
 JZeouqsnWvfHCkg4vwKGFy0k2WlWR7CdpTbwdds3au6IA4d+mpwGJBWnAMkgW3MqVR4vra7npNP
 ZqhF0+Q5z28NkripQ0g==
X-Proofpoint-GUID: 8MaawGUu3_ytmDQbn2dzp9PqFomYlwxB
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a427094 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8o_kNyP7FEPhiWKY2ewA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8MaawGUu3_ytmDQbn2dzp9PqFomYlwxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
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

Export dpu_encoder_atomic_mode_set, dpu_encoder_phys_enable and
dpu_encoder_phys_disable so MST encoder helper funcs can reuse them.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 ++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 778e231d4967..1c74ff6f0dbd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1149,9 +1149,9 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
 	}
 }
 
-static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
-					     struct drm_crtc_state *crtc_state,
-					     struct drm_connector_state *conn_state)
+void dpu_encoder_atomic_mode_set(struct drm_encoder *drm_enc,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
 {
 	struct dpu_encoder_virt *dpu_enc;
 	struct msm_drm_private *priv;
@@ -1334,8 +1334,8 @@ void dpu_encoder_virt_runtime_resume(struct drm_encoder *drm_enc)
 	mutex_unlock(&dpu_enc->enc_lock);
 }
 
-static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
-					struct drm_atomic_commit *state)
+void dpu_encoder_phys_enable(struct drm_encoder *drm_enc,
+			     struct drm_atomic_commit *state)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	int ret = 0;
@@ -1381,8 +1381,8 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
 	mutex_unlock(&dpu_enc->enc_lock);
 }
 
-static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
-					struct drm_atomic_commit *state)
+void dpu_encoder_phys_disable(struct drm_encoder *drm_enc,
+			      struct drm_atomic_commit *state)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	struct drm_crtc *crtc;
@@ -2739,9 +2739,9 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 }
 
 static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
-	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
-	.atomic_disable = dpu_encoder_virt_atomic_disable,
-	.atomic_enable = dpu_encoder_virt_atomic_enable,
+	.atomic_mode_set = dpu_encoder_atomic_mode_set,
+	.atomic_disable  = dpu_encoder_phys_disable,
+	.atomic_enable   = dpu_encoder_phys_enable,
 };
 
 static const struct drm_encoder_funcs dpu_encoder_funcs = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4942097e7613..25ade3dbbeda 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -98,4 +98,10 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
 bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc);
 
 void dpu_encoder_start_frame_done_timer(struct drm_encoder *drm_enc);
+
+void dpu_encoder_phys_enable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void dpu_encoder_phys_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void dpu_encoder_atomic_mode_set(struct drm_encoder *enc,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state);
 #endif /* __DPU_ENCODER_H__ */

-- 
2.43.0

