Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B4BC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCD210E709;
	Mon, 31 Aug 2026 08:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jidii2EP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIqZuFm1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C38C10E710
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xtuc1844204
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NbKS5wp5S+RisOn+z3kwh1eHsCAjG5mu+3wciJLhaUA=; b=Jidii2EPuh29Dzpo
 j4o4cVVuO0Va0uORJ0h7iZdgN2wvMjZpLvVzRAbg2/8ktFEHV4dqlCI93m7hZqJt
 wwqMNZgq8Wrxz+RbM51XaeCgOaUfOsKILqv6wC+AdI9qRORvHfUgf8iyTWaBc8gN
 Wn4BTeRq1dUUzkMxRMb5xr3shPVQFYkjN+iv89cQZG2Ju7EodcvUs6NS8Al/JX0N
 nhxMMcanpn3pmLHi+w6K6/se3owfZmGhTBLMOlZuclUGdEGPEAbrz8fCwxpSGmtU
 UUh095I8NSfRB0MiA1+yMJ35EeWLkrAXCXXvrB4q13xR4A1f9ly7kMzl90+c7Ivv
 y/gJNw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrkgw6r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93915f50a5cso600514585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164263; x=1788769063;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbKS5wp5S+RisOn+z3kwh1eHsCAjG5mu+3wciJLhaUA=;
 b=KIqZuFm1olXwU6LI1VtN14a0k1GdiAls+cK4dwRvBDCgdsXHiQ2VlIQq+/SIx1A+nX
 a+/JAbUIKP58+JlvVZOHicBngn14BIm3P5/uNaNsBDI76Z9xtezWc+NcqW0Z4gre/2Iw
 Xb5siskay1PALTKGnIwsLAIH8owbEoCd89NJx93A4i5oooMmtGqg3LwIghD6DugFO3HR
 mKThVsybczTgHoUSLsl/1hRtWHEkBZ54kR2GqUrw9ih8EM8/eAbbiFdIdwqO865lSxK3
 noZWNGWjG+fzGEqh8myl3m2NGEMa32acJtbvDkWMbB8/8JhqvlRc94MKF/c7Q6L8QzKB
 2aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164263; x=1788769063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NbKS5wp5S+RisOn+z3kwh1eHsCAjG5mu+3wciJLhaUA=;
 b=RRT7orOSs42gfflwDTUBAm+uQ/44s+D0ee0e4v32EP6OrJcMB0fuebyMgC+ev7RjCw
 16oP3zI5FCZl9yeaJteqANgTe7eNWJsB8BGL5FfSiWbzRsofCb82WmbMJfMDDY5uno6P
 4bWA07EEfYXXWru3nXVm7pEqlkIfb4fP3dBb28hykvyLpY+COGDPZDWJXcZEvRKA2eMq
 7oxo/8mgcPBvXNSjCY/qLmbMdD48BFwrspasjb+05OMsl/I80VL1DpMN1FPgQFoz2MGu
 f6wD6kGbqzY/Aio8AIFJZaNbvB13bnUVksUX7Jit5ciVI2uw29wfUygbs3itXurW1OVJ
 yj0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6BwfyYe1C30s5T5KFwp45Cp6nKrH+x/4yUL9Z1C5KVNOktXJYpfZfceL3ak7Pd0/VSoYeaBDvEXI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nItkophULtk8nQ3eUtzyxNyWVZMEDRnjezpUJ/icLBbZlVX7MV
 sMy5ALEw4nVsIcSfTf8V6Ia8I6O/QmCP9IgwS9YIQNwQ7tIBr0NiPGGrCItj0VnhMKTeuTzpx9V
 FGcLiLR1RCKSem2hiqhnZaMviKiP0rdIqrd+Y8tswahszl+U+T9kYbhvqhG5e4R1zv7eldd0=
X-Gm-Gg: AR+sD10YbCe0czYZdyyeJE1q3I5GzR2+HLV+a55o1kC5bfDav2xQmkdVAtQL/vWeHPD
 MYSethH0QuLIjaoJSWiRsA2G0QncIvmrLr8lsEo4OEOnExEuSTp596FFWaXSCxFvU6oMxkDo82s
 SYYJhNsigfyy/PQdgkFjuhJIV1wp38rq72gciSEVsECccuw55d1Ck26cN7nXLXH9VnyfsykuIF5
 9wwmntASd2smQMJCa17Dof3JvG6L4JRVTjZpKXTovZHSQUhlgXEGgpGuT4uC4oK0Sw3VcfJ+w+G
 +BaCucTFQF3L7XrTi8Fv2Y46Jh7uf1I/0x6Rmo5+2jBsFaDSsb4OVQ7KtLItEug89YFkSf7UPp6
 zjc0veR5+bUCCLWq1P7/q941K5i2bjj16ppSN97cuDrw2VYD/KSVnH7pFXrf4lkM=
X-Received: by 2002:a05:620a:4405:b0:934:b798:c245 with SMTP id
 af79cd13be357-93936d0293emr610518285a.16.1788164263333; 
 Mon, 31 Aug 2026 01:17:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:934:b798:c245 with SMTP id
 af79cd13be357-93936d0293emr610514185a.16.1788164262891; 
 Mon, 31 Aug 2026 01:17:42 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:17:42 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:19 +0800
Subject: [PATCH v6 02/29] drm/msm/dp: refactor msm_dp_ctrl_config_msa() to
 take panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-2-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=2550;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=1Dvt36Iz2rR47bCfGnFTYvWtkSA0SbZBJEcZBGDHD2s=;
 b=2y/HmOwgCkVqSGh5Hadd6IDPuaLb73KeDVgi50efvxk361fGKhZPWwnMmbwKCVUMZRZDeEEbW
 b6vH6WZ+Q8oA4hbNbaRIENY+/8wV8aucLVs0pzMdrX/3ilR+x2btSii
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX/m/ayYliA8/l
 wNamWegcU+bpk2XLxJ53Uisng64YEI8JZ0A3lGbTJNUBjBwxzaxK6BgcubF71LlZ4jnM3VaenZn
 RAEcAhy4Vjv6COrP7X5nPA2o6y8Uv6jRSNBavbMSHcdN13UimNFoYvT9UxKiKN8i81tRjzMdPwX
 tl2agRYa8/gzb7JFJt3BUOFPtDflsiCNpDkmbWFhxG9ifltXMjke0rgVUh1+2R3n7cAtXyTzwoa
 zIqQwJgYvPlfOVRpfY4yjCL/gloy06aJ436ju1jAMBnrtMi7UwFZmSOZC2yTkd04Uxz6YclxlnR
 yIhxP76NCSbD1z79tfzvXAOxKgnLFFPlKWxTB/P1YfajpHKW/FQgBsvPklHteZO/X1UTHx9/RQH
 jIRKsS7bAuCVAK+hjQOu/rOQ22EJXs9DAHAR+Dk8hnoKeld80Hki8blrNt/TScjFmrGVAzK3Gac
 bMAccmVkjIc3E+elEIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX1T9WyduRN+Sf
 kDqNCM+uvkw+4XLZXtkpcMewNHGRBjARczAZKve/56RlyvXgFRu60XvnoEXH2KkE+VPVNdoaPR8
 +ldLNKG1KjT9OoBmEhJHiXTn9xbP9SY=
X-Proofpoint-ORIG-GUID: bGuShnqST08fb0vNWOi4GWdP4tEiFOm6
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a9538a8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1b9t6BJMd9RmoPA7DzYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: bGuShnqST08fb0vNWOi4GWdP4tEiFOm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

Replace the (rate, stream_rate_khz, is_ycbcr_420) parameter triple with
(panel, rate); both values are already derivable from panel->msm_dp_mode.

This lets config_msa() use panel->stream_id when writing
SOFTWARE_MVID/NVID for MST streams, added by a later patch.

No functional change.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 59070f399e2d..1ed713b957c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2463,14 +2463,14 @@ static int msm_dp_ctrl_link_retrain(struct msm_dp_ctrl_private *ctrl,
 }
 
 static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
-			       u32 rate, u32 stream_rate_khz,
-			       bool is_ycbcr_420)
+				   struct msm_dp_panel *panel, u32 rate)
 {
 	u32 pixel_m, pixel_n;
 	u32 mvid, nvid, pixel_div, dispcc_input_rate;
 	u32 const nvid_fixed = DP_LINK_CONSTANT_N_VALUE;
 	u32 const link_rate_hbr2 = 540000;
 	u32 const link_rate_hbr3 = 810000;
+	u32 stream_rate_khz = panel->msm_dp_mode.drm_mode.clock;
 	unsigned long den, num;
 
 	switch (rate) {
@@ -2516,7 +2516,7 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 		nvid = temp;
 	}
 
-	if (is_ycbcr_420)
+	if (panel->msm_dp_mode.out_fmt_is_yuv_420)
 		mvid /= 2;
 
 	if (link_rate_hbr2 == rate)
@@ -2573,15 +2573,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	bool mainlink_ready = false;
 	struct msm_dp_ctrl_private *ctrl;
 	unsigned long pixel_rate;
-	unsigned long pixel_rate_orig;
 
 	if (!msm_dp_ctrl)
 		return -EINVAL;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
-	pixel_rate = pixel_rate_orig;
+	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 
 	if (msm_dp_ctrl->wide_bus_en || panel->msm_dp_mode.out_fmt_is_yuv_420)
 		pixel_rate >>= 1;
@@ -2604,10 +2602,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
-	msm_dp_ctrl_config_msa(ctrl,
-		ctrl->link->link_params.rate,
-		pixel_rate_orig,
-		panel->msm_dp_mode.out_fmt_is_yuv_420);
+	msm_dp_ctrl_config_msa(ctrl, panel,
+		ctrl->link->link_params.rate);
 
 	msm_dp_panel_clear_dsc_dto(panel);
 

-- 
2.43.0

