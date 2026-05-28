Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4345DCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A699F10EFF7;
	Thu, 28 May 2026 10:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQG+Juk9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctjK4OXH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4148010EFF3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:50 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vOS93545348
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tpsE/BLJmEgKnrnJMIR8sDLnWgNFGNEPlGiP1+qAsFQ=; b=kQG+Juk9SVHTotYL
 Czw2ZdEwNgLUIbA/J/QDHH6g4V/R96HodONjjJal42NCCypvvp72fccz7oJ3QsZJ
 oDpAY+Wz/MohKfweQZWGYPtJ4nmdcG0aK1B6FoZMg/xIl66NNwRg2kcKNQaVU8Bh
 gYHNF/JUnBoWs4GoeAFTKRmE/dKbi5AlrStEzcr4i6ceKaWzZfJbFw4lO+fUzQon
 xIDfWUrgeFEW+EzN7Yq6UC078+soP81MsBF4S7fHXmgITJFiQlvKcTSQgbLKVL/D
 raPCpPYRt/c2foL+wzYA7Yzx0jFHWH9BAKqor4NsSDXK3EAM147zBueMUstek2tU
 u66uiw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3tdgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9112b2756fbso2438887285a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964909; x=1780569709;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpsE/BLJmEgKnrnJMIR8sDLnWgNFGNEPlGiP1+qAsFQ=;
 b=ctjK4OXH9IdOIljFcvkPk5jNo1/W9WSklj5iIjfci7hwSndNVzpIwFwZedQ1Wqkx28
 F7TgwX2EPeNzBnB1Rywn5EGm+QozoOjkPYX3C1Yu/+4X//1lYlwntwNlDsVxiDYOIA1i
 jh2rele1Cf+gBYXRMw2OdA7r3m9IzlqfEPv7Eq/fjviAa2z+4F7Q6ojaBUMlD9da3sM+
 SObDlQo7gWVPxjZa7sPgwHFyjO0AHaIib68GmqeL1BMV847B3kSSo48YZs9aQRTFoAnU
 QPEvQYDW5+ePdoDhhiqL8bBxTSKV5t7jbFNcCw/9OGJpzwnH8dljP2IAvLzDIpjZd5U+
 SSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964909; x=1780569709;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tpsE/BLJmEgKnrnJMIR8sDLnWgNFGNEPlGiP1+qAsFQ=;
 b=K69Io969lZejD3sU4dS6qr9orXeGvZtu5PX3WHgPTvfLL3NV+mDtn3OLLFthhBXET9
 Y7ZTM5hgvI7m9WdA50G7bBdwPvLfRAODA+4cga4S0xXQqVUPQnyN10zBLzLviaNgYod4
 YSTiSjAmNkEPQhTOscmx1Dzx86JzSwQYg2QTvG6KptffS+E/GGrH+gH0aVbiqamNQHtW
 NkVeTLqQlnpElgi6Y8XB1eDpjRXa9LFLvQQySFSeCWJw6nC6E+rpbpLWEHwA3SCddFyJ
 88Gcz4KSukLuPZZElpBtYu2XklsonSjnCcyuFwkNPqbjJVQzYhniySXy6k08PvCBkzGF
 lXIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+mBc10Q8NhtYLwf1UwTcdzXGV2ASHZLbFjxFm9vmWLCse9ESuRRJpNz1vg4UL6HlIScznHUmXXdk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwceX1ZDlQZjv15YhReMHXpkBs7bZqqz5j5gg/G9QK2A5kfgdex
 PVk/kQC4pMzsA4ol6mm88/qED9dI1EYVcx6agmCCtizhQY2FveivM51JCPD+ZAmEhtdzcfr4Clq
 YKFvcIcthqwDfKLvdVbsuahIcb5JJ+z3NPsrTvFcAK9g0+bmXkIdaB95ufwX2hmclhypmRkE=
X-Gm-Gg: Acq92OEckUtjktw2fvTGF12COCOOcqJpJqYPbesjViqGeDzGY5tWqY7zbZFDqFCligI
 apakhX7pEQlmFczhiq5P/oZijjJ1MnigzC7WDPKv6BszpZq7lNf2nvut7FHA4rLV1+jCuFvwAAt
 34U3ycWgC/TueMvEiLt0rOJ+MuGJtwaHLj6ms2Z4TyOjdu7ifk/F0vPoUJK5tH42zDp1vLSqkYH
 98R43zwM5zQsDlEa/KkQdJu5KFtks3c7PkrWTIy5RRcaIRBTiWpTXCYeO/ocrvM1XtimOpIf2Gl
 sBqbsmTyZm5FKbaqIGyNRyFrB2OBXvb3uI86V8FivCg7k72FJwCgyUuDq8Xa1v9EXdXwRHj+lMC
 Z9kk3pLMDKlU5dIy9Rv4d0lpB1s+xL6Sc4Aeph1dsqQh8auS4soDyaHB/9QL5zomn2d1QFGHaTm
 0YibezL9su3RThivW2WQ==
X-Received: by 2002:a05:620a:1a0c:b0:914:c01e:6f92 with SMTP id
 af79cd13be357-914c01e80b6mr2782526085a.18.1779964908832; 
 Thu, 28 May 2026 03:41:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0c:b0:914:c01e:6f92 with SMTP id
 af79cd13be357-914c01e80b6mr2782521885a.18.1779964908368; 
 Thu, 28 May 2026 03:41:48 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:36 +0800
Subject: [PATCH v5 15/15] drm/msm/dp: pass panel to display enable/disable
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-15-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=3051;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=9RrNuNwTk/ww6iYx0SuggmHq9TFnipSUNnQOBEesNk0=;
 b=NUSYehlP04crvps+VPP259ZW5+AW1qkFK0Wi1t/AyhuKVspU510X+GVtKQ1PDP4N7qLZ9NfWQ
 uzd4MMW4C9gDsqvx+ZO39rdNfAIQjku5I/1EtfrdTdFiOT/K5fvu3H5
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: tLTiAfNVtpZfGU9JgqtSzokLPLUxQHNn
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a181bed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Kfrt2GjMPgVQdVN7MJkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: tLTiAfNVtpZfGU9JgqtSzokLPLUxQHNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwOCBTYWx0ZWRfX3uNs35RWaYQd
 tVq+oBaukdmBnXKBuYjstwbXSGUGGN+w10xYOo278v8+jv+0Ax2Oq67bRkCdV8/f4j3Ivaz3RwR
 lP3eX9300mjm4sotx5e5uzPFLCj4vAB76YktAB46Y4j5yyqmRz/bcDWv3/TPU1UFaJj0UGEpNCY
 tS9NtouVlxJhsOqNcqrTSamaYPppYI9ZXp9JN8f6QohqND6jEmcUNi/66dr3I6ueWLgoOgAZDl/
 VT1W8+/gDKqIiRrLKSN4PHfcuuQBEESrv4ddVT8S7SVpe3tB9BbHPeuvg/DhW84yIwnF87OHrOu
 T1kvm6NKulqSFKTXBrCAepB9L7kZh/NLubZ3ghyMLNFdLcEj6xIlzj6H9gi3eyI5MfusCE+vhGG
 mcgC1tPeYtgoDYCg55vpFBP4MGqSafariYmKFlMVdVO1lI/Cyqy+pX95XBYcndCWdllq0m6XD6I
 x92DGMDfftRYoIGC5dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280108
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
index cd1f2899b733..bea5bfb22967 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -650,7 +650,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -661,7 +662,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -707,20 +708,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
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
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 
@@ -1437,14 +1439,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
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
@@ -1479,7 +1481,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.43.0

