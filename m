Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC1BCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB05510EFE8;
	Thu, 28 May 2026 10:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HF9RTp/f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K7VT56c0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6753210EFE7
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vK7k1562565
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lj1ey6ImyO3i3vMmCJMMvm8iJ4e0EDN26FxKqAvXcRQ=; b=HF9RTp/f3RpbIIrd
 qA5SVCJLvnyO7HAkP482gjg3dQ7aI2zSSPkdMZue/JcU18fbEH580OX/qnJv07Ra
 dBDX9VaFIamvhapWHMtC3BQARp6L3gksyTpoxTAOOyVgrUJc6Fw/IytAqvIx4YoM
 fcevawvjX84omOfMXZtuE3Wv5M8hveo93nMXk5Z2upzz72UXIdr3aZBVW9LyJdR5
 H0u+qQRCHvCdH71Z0r3X9MGcrOY2P8WthJTq66FrYFLJsMJEUYbbczF+9SAHSZGB
 TnNmkxv83D5BOAEszC+fDkN4s7Z7joU9OPQ22adHS6M2Zg48S0qC4enNbM2deLVQ
 5DdTtw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2td97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914bd251f5cso632969585a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964860; x=1780569660;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lj1ey6ImyO3i3vMmCJMMvm8iJ4e0EDN26FxKqAvXcRQ=;
 b=K7VT56c0Z0DeKUlJVuogqQIE0S8SCfjy7NMEEfgLhs8GkJdQ7UDNT0DviHlJuky/C7
 t7Nv5qf+bzsbdYYLfZNqqgUZeVhzF4yFC6u7CUgGlupmOdabrIx5+QdUXaOvs70ag4+n
 6o6IYITw7tj3W5pe3E/QhAjUYksyT5HQdovvZUt8ZADUCVXhCsysL+4ua9jClgggNObr
 UyHz4FuvIWEAuQvwTAUhHKu56+P4mCYXYxgZi5+vcm47PhV/y9ZgbCecYJRjWCP61Dp3
 WOaD2zCkOI90rEFs/aeaxHs3p29+7tzih54t3FEZx7kbpFH3suiJeeQ6UI+uHRaGWtaz
 yBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964860; x=1780569660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lj1ey6ImyO3i3vMmCJMMvm8iJ4e0EDN26FxKqAvXcRQ=;
 b=N/mCHzpDzxUhVqwXbAK5qhkQ45ZEOB0wLPonHiy25AlusTJA+RS0DV/UU0jx2Y9XVI
 wx+mCTkkWXMc1ZxIGzDpPPIgDcKjJQk3RAjF3hfX84Gd8+LyWAkr6LzygbdHLDmVJ70B
 mvhXVKMFmLId+ho7dv7F08jmphDhyKLCd1KBwFO/Jck5WBbkgPQ11TG+tfttjdrsOdws
 Skf6N0dPviG5iAVY5hStv0cv/qWaXA3WLSZlfgziB2EOwGdEQoHCGV9c05SLRGzi4zLI
 rbBGBTnZLTFkvuTeaQs/bvLVBYw/x2xBZDj5z6ChyU+Ik/d9e+ph8XdvijBBwHwCI793
 9sfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Vngu4qwVynbACfYuM+8AzfXG+EoCL7YSs+PThhZLmfp3KbJXC2ihNtJlBXaj9Y8sm1eUei0xgtBs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynH/D+xzbqy1aWliiXwSZYej22q8Al1vFiz1qFVg1Oe9EANe5g
 vCnweqwwvU6QIC/9JLuzYf3AOu9iUFBsSyBBmjudj7KQrAEidVt4P6nBw0b6b1p8njZEghTOX8K
 RtivzOI7qFSeuERYUjoGhl1I0rZojE3VZQJN0v/cN6vH4u422lbUoKAUC3O7XMYr1Yc0dzog=
X-Gm-Gg: Acq92OE8kXrkF+VQrsyTVzy6O4zCtggVxAi9MfCEtJpSRWLf89VkF9p83DMxkheezzX
 JYubc9WzvfX8LDuQS3si+Y4kqee9r7pnoz6/VsVNVwEzYHT7gSVoHLC2CAyY8kzt6afuUuo30xd
 mICekjbULj6kTVupHag12JdcPhEXU4l1WQZTxWVqIIHxNMMp1+mYksvz8bFOuL4LBCSJzM1RuJo
 7ViGrrNLRoxAHE9n0vBYHB2eOOuiwUwS1RZ6YtCF3S79HnRXpg9pNPxLcQ3H4T9Qnr9LoGOy0lf
 cfSjBSxV63oZbCnVtCU1UiM5Vj+ddRPYCLN8F/run825G3Wo5hFLQDccTF2pVRCNCVwyKN4odtx
 jzo8v2svtxeWPzAcnAPTRshNVFgJTCquY0BB9GCTcOg3UUer8aKnRk7TDaBH31xzOrZivaZECGz
 /z4+mqu9NPmqa+YCk9XQ==
X-Received: by 2002:a05:620a:1995:b0:915:f9d:5c30 with SMTP id
 af79cd13be357-9150f9d5ec2mr741387585a.58.1779964859945; 
 Thu, 28 May 2026 03:40:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1995:b0:915:f9d:5c30 with SMTP id
 af79cd13be357-9150f9d5ec2mr741384585a.58.1779964859468; 
 Thu, 28 May 2026 03:40:59 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:40:59 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:26 +0800
Subject: [PATCH v5 05/15] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-5-a9221c1f1f3b@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=2097;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=cG/LGNCcQTa4kjEHUBEM5XHcqi1wHebQYuwINqyWaz4=;
 b=1MPEuzi7QI8Owj0RNyKbbmcyjAce09Crte4j3X2MKDzzDN0sL29ULlXfzr41meYxeD4Fh8RNM
 dibPlaMG0jOCNpG53r4TT3zajMzZxZrARUj+ezY31VJW91Lsehf7N2a
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a181bbc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TC1OlXllJ9dbkp4NpB8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNiBTYWx0ZWRfX7pYZeIdLeZDE
 WS0KMgEicsYT7osrEQghKG+pEgwB1P4WRRNTWm0T2rBMXIGLGb2sikUe3L8NOLiviQE8/AndBYc
 298FTHAxLWrWucdqb5++H2m9UcXpYYy7XWpN4eu+kYXb0J/W2eAev94ZQdkatkKVWmHBdtnKC4t
 eZnry2o1m53o2jqNu+3v1CSYZwZATmteNPvwvQESyjesSbL5gGDB9rP73TvTzjC/O5bxq+CsJdp
 XjUm1CexC9WlRSUJoLTgJFKpimhyhxWuQ/wDByt4u9sEATRbxW7AgmKYTeTxwLO0p84G6Qe69nU
 6+PWau5XCAqN+E7O3EYSZ0n/vjMMLNgA05MlzHicydgRU6KzFBum5TiBXlwh8ValNHYUW1YbKn2
 BuzlP9qv4A1rCwfje6nUQ1oiC5fZdoFr4pKzRv11toioSdAI8UIS2dr9dNPVoLqtGY3QlH9sl/W
 +O5uXBEbWWvKQuiAA4A==
X-Proofpoint-GUID: iBkN5X-VbilBhAYGUhnjH6Y4eAU9yRPa
X-Proofpoint-ORIG-GUID: iBkN5X-VbilBhAYGUhnjH6Y4eAU9yRPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280106
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

Refactor the MISC1_MISC0 register configuration into a standalone helper
function to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index cc00e8d2d6c7..d4f48669541a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -459,17 +459,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 			ln_mapping);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
+					   struct msm_dp_panel *msm_dp_panel)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
-
-	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
+	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
+							  msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
@@ -483,6 +479,17 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+}
+
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+{
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+
+	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
 
 	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }

-- 
2.43.0

