Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4776C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6AE10E692;
	Mon, 20 Jul 2026 06:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxzOkCCv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EhicLay5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9308810E695
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNscJa804395
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AeQrXGNfB+XoNNbsXI6SD4zb0QBkoDAOP9R0ui3Y6iw=; b=hxzOkCCvUH8nJgan
 mDLIODhEqR4RNCAFqHPk0Ldo0jDF2fJ16AcLVAb6MwN4kLXZTR538QfS0w87RNK9
 oQjrh4MYPtJqGPnpi2naYpQyzQl1+ejj9LPbJZBTmhT2/cJISXHRDzew6RWQf1kx
 h1xt6BUvZKrXAiiLfF4ki5L9VFNqh9s9ZN+MQEr4vbn6UxrGnLFKn/yIHmBlUyV3
 Mut5sRajfqQJWAKxw6lklIcx/XixJ+UcO4KZ4RCc5Tk5L0RNAYq59oTTA8Pg37uC
 ycoHvczWGcu4V4DkpztqP25ObDuJrh9hRQXtbsXj/x1+J3kjFbWteD3dXN8I44Vg
 XsEv9A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04umgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso251224206d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527875; x=1785132675;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AeQrXGNfB+XoNNbsXI6SD4zb0QBkoDAOP9R0ui3Y6iw=;
 b=EhicLay5DistSM/FInD13+OZtHvLim7jH9/M/uodoyfzbgb3w7yrhLuSszlomX3lS1
 6sZLTe2KSOReuyherwAgZyX8iG+UkqGeW1per/GfY537LmVHZdYJJbdhDKCTp/q87974
 FjI1VSTa2pITJDU2HQHWCKmtMlgR5mDuXbP7EPakkDOW4uChv5KKD7NLHju9mASI7/rt
 Q8xPJdVhlJTNoK0dBpU8m+C0Ms/hJ2ddjlNpIQ7BZMwln0G4ETYP5v6MF8rjxEKcK2Wl
 sENug8CNWjgY4z6CGrQwhetHXiXCwuVyMJO21FrMW/p+O3Y77dnuKkR9znIQp7D7IPLX
 kMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527875; x=1785132675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AeQrXGNfB+XoNNbsXI6SD4zb0QBkoDAOP9R0ui3Y6iw=;
 b=jm0y+Pt1w2EIBQTN6XBS7/noRSxyO8P0XNwHMekuQLTh2xq6UKlRiiYsfolD/VGfBM
 zR6XQmlEx5ron0gjD15yWlf7zyeAuibNAL+ybq2rVnbxz+fX2si9P9yEdfFeN7zVur3/
 WT0HW1y4T+GkCYKvYJ4iDkX7EwlnAlVTKCImKQC5GULW9AnEwIogXaF8+/LVSVNdB2Di
 7rNj+hrnAPFH611JOGbn5f/hgoTZvzC52XNhp+/q8DqRv3UQwYttQjgXh4g9QbuWE+sA
 3ruFjmlKBF2AwiC7WrfAogvSZ3c/9irfm45lAAhh8a7fhWTtIKs75SsQngGKkYWdNFS3
 DwDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz3DNWVtD+PA3/IIpU+fCvydKnmD/YzgGLffSMyTV83AwSjcp42QUSAt1BWNvOk4n7vmu/R1nPrbE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoWvYzx7QRr9fw2RAk9Ag9YSWDGVUfaTSFA7VWDNHx/TOCCamo
 Cu3XRIDIAszzuL/aMbfDHN6mANGd3CbZDtPKr21AerTuwHfUxdvbH1zBnKMJDr0sOreEuhjDjaP
 jhIWTDkTwdhnc0U0UYrOYH8Mtp0lSkWRjJCjKTkl3TW9fa2RoYrFVMqsfYzawDdS6d5/wPZo=
X-Gm-Gg: AfdE7clg8/sobAjFdeZJTnxmjt/8DJClepHQw4RMOnbY3v81FkrXRB7RHlhVDDXnKPP
 n+f6HhAEE4bPGWCJRPeDLjuFKU3kc7ScdH5J71z19ar58Al7WLOsnj1tkS0sn4NHz/HeKq9xTIX
 a8AvlI2FpciiU31dcn4HISFyZoHsgNii7lFr41suXuJ9Ey995DHmIjyZ3TeyJ0+FwVVWhLwd6jq
 E065hIVL+OgYSHGM12A191olN09tqDDh5hgnPjPmHuL6TKwPlgYmyq0Lwib30z8t5Z/OjRx6ZOT
 Ysr/DTtN0EqG3KyB15I2F8mthyoRdNo3gtZlYtUcPhtTaIshOOS7R0lnpb+oOuOTlE7caJzGGq+
 qpwBkKiLaCQjtmx9huJHIZ9oNXlIOo8Ws4dme/gzkW/W14oBKXM7UAzT2Xew89SE=
X-Received: by 2002:a05:6214:500f:b0:8fd:6e32:2bff with SMTP id
 6a1803df08f44-90778509f1dmr133304546d6.64.1784527874701; 
 Sun, 19 Jul 2026 23:11:14 -0700 (PDT)
X-Received: by 2002:a05:6214:500f:b0:8fd:6e32:2bff with SMTP id
 6a1803df08f44-90778509f1dmr133304326d6.64.1784527874341; 
 Sun, 19 Jul 2026 23:11:14 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:14 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:13 +0800
Subject: [PATCH v8 06/15] drm/msm/dp: split link setup from source params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-6-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=1402;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=m7a3fzYm8nfwxq2seY3v0u+Fo5r/mlnnqjBe8DmQUGM=;
 b=chonLmhqOwTIGtD1JV5pLq0RH7vxKrwc6AaLVvZN9VAm0hBQzkHmET72yQfwCT/8o1QrgVGOW
 KA495hrb99MDlXUktgehooV/JA99dRBLpSk0Yl8rCaSBTzna5tPBaQc
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dbc03 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=saXSvH3Ee-fMY4W8qR0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX3koGngVaX47B
 rL6s+Xmow+tRvK9A4JtCk5lXKUbD9P9psbN1uTobWW+6+E9jCefr9hJj5u6lsafFDy5fN0WSNhq
 I20Q7blIZUwPFKqkseOO1lp0vbkhmCoHA2MGeKrvwpFpD2HUCzSfy3jFhHe+81VcQJmn/Xoe/Yv
 YHzpaCdxf/r6OZm+G7nxRH+6iXYsIr8qBR88NO6pfBu4BIuRY6I+2rgFVlPGlcJ/6JiPEcP2vNE
 c1IO0ceRj+DPHx3jo4I2nFp6LhOhH/AlH8T5e2WLaO90bbN/HOd5r0MlHKrmLKorM/kTQPnv4Ht
 GOebNFoWReXdFo9uJCq5Wm+ZsrOVgy16tMVWe1RC0UFUHZroM2SwOdZL/iOr9IWp2lFPITVMRZR
 acKYXO69Sm1vr/UiS55Ljn2XUzsDA4g4Dyj+vJM2Erhkmn54vIvTXiebhDQyL2W+wOEssFc2Rv0
 K3W8jMtYIC4dYdnSDhA==
X-Proofpoint-ORIG-GUID: 2nr_EnCGTxvOWFqLuWmO1nqOve0fMOkv
X-Proofpoint-GUID: 2nr_EnCGTxvOWFqLuWmO1nqOve0fMOkv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX0VjEllPuQBGH
 mugOJ4himHQC3xKflpfjB56VV9EJH5ibxK9o3mTZc9zSVMy9HEd4927QsJvNGMXrQXczeIoHDRh
 8Z3gP6iUS5FtkP5a6UUPg7tsLg0dgE4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200066
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

msm_dp_ctrl_configure_source_params() should only handle stream-related
configuration. Move the link setup out of it so MST can program link and
stream settings separately.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ac24c958852b..711579de899d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -482,10 +482,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
 {
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
 	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
@@ -2552,6 +2548,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	 */
 	reinit_completion(&ctrl->video_comp);
 
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+
 	msm_dp_ctrl_configure_source_params(ctrl);
 
 	msm_dp_ctrl_config_msa(ctrl,

-- 
2.43.0

