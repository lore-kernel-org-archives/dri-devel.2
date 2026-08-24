Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41314C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77B810E74C;
	Mon, 24 Aug 2026 11:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OCW5fEbG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WE6Nq6t8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407FE10E74C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMNdR3406345
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kHNvx8/yUX7DH2/W13exwyYo7xL3jhjIg5S8O7VsuNE=; b=OCW5fEbGmsu+L/sP
 MLAkFdgWm4+qipjmp28jZfMrN6N3FmHAU4cgdL2mIm9875YIRkRcmwDgdp7xrCg8
 COAntFPPV93h2hoqw9x2U2aXwCa8sarkw2HShjtVcFJ/GMaEmbwRL9Ew2ny/yct3
 pFsKwfmYmRnRQ6jt4rAZgRvivCLeGj9pe+B0lR3AOLoPZPImE1rUtUvG0AIIVzqk
 HX7HNmWMB0wujF0qXPxc0922ayPgutW1p2K10nRX/12+id622KQzbq5/9TiyPDr1
 0rSQA5wwrtU70CzWhTPIYd0kOvvuy31lPEwPCJv2MBI1gb7R+xuNGDJ1aYGMIOfj
 ZQtR4Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk0rup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6c166bafcso11558695ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570935; x=1788175735;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kHNvx8/yUX7DH2/W13exwyYo7xL3jhjIg5S8O7VsuNE=;
 b=WE6Nq6t8qqSa+wd22DLeXxSczP/doLhPv+tW2rSl9KQfbmVSj4y3wDRpzEccAw8IYU
 bIHp+UW0QfYsuz+RCCbOLZ3Ic3sIxN2VIGb54DjA4XCo9YIDEBRHjagyNZzMK27gcTPB
 IS4LpbS9Oiq/91OnOMw0IuyrswI2aze1o/dxBkMZ+/G2W1PRDZU7+4Ulpt95j6uaRVf8
 DArdM4YEnrENhPnH4KZ2N0neE6S7O+rAvrUP1cBY92xJvxzD84Kju1l0ImUjQJPwAruY
 m8ziICA6bvQgjj6jO3dlN5+9ETgCa3k2VYilCt0cO/11Xif4H1PES0RabfyPgL57Q16j
 RUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570935; x=1788175735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kHNvx8/yUX7DH2/W13exwyYo7xL3jhjIg5S8O7VsuNE=;
 b=ohygKV7lnfc9lLThsiwnLm3ZpgD4z4DN6NL2mFcCjRE3S+y8OIYAhxMsNxYQbLuldx
 NkGwoxnm3s2ciJZDwQPoGf+4cW2fVh6unVPPtsbDpG4rP4YfTzYXFyq5ZDOGzsPyEg/8
 nGm1BHcPeN14NDq5bbP3qQvGCd62/B2fsxz1jiQp/nE6/wWVoz0N9DdgsJIbr+uialpq
 d7oJgUTxHw9FEyaiGK4ZkCN/VHsIdepYio1ILzLP4B7V/ZPZwyyu17G7wAbP9zhNxLw9
 zXJLrrM91kMW5ZnM9pCSjouJFKkHPXNgdwQ9CHZzWSNwjhO5f85LFNQZDlVmRrYznA3X
 Xfpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsNIXoxVXpu3CzXle25UZGb1GXgiKKm9RW3K2tEg9EwIUhDB73VqlbVwVYvOoNoOC45ShCoQzDdGA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpobxqfiUrc7QZUGQZNNJhty7Dj9y9jKsaxo87ti0/ql+oKTYq
 ljkastLq9RQ2jF1iHzmP9yxo7YJIeiSkazOmmZ2hPmlPd0N4rEu078LQnn/gI+2enNP9x3QBhb9
 ExLOEkrF76JL5PVTmjK0cVkofW6UrhccR5XNDpipk3pcHppI+JEofwbsmeff+DhUhL7yUPGc=
X-Gm-Gg: AR+sD13YmLMttWeGAa3HE4JYgpOQMMDydyeUlR2aQZL9hVAdNmJz1dPYcUtg017oRIU
 Ry3nbHgKOLM9V/wHbZci0ysdn0IddkkDqnEdZQYskAVHpXD0gCf4tZlDE0MoTkVJezSHfoXT/L3
 8OMW2xhqj3b13iBJxzxpSuC/nVtzlQY2mJ7fiv5NY4bOd8xfCmHpje6ZTcM7WgcvBMRCMahvLRI
 5smAIP+Gax1awwKRTI3mj4rJSLKDzuA6/Dl4yNMvZaVgSIHCKPmuXHiu4CQjS0oeoxzNJ7hNnwH
 Y83sDTjrpeiHO+5x9jfpSMRO3kTtMN1AakCYiiWd3LgLRlCT6/9dYIcmCqeZft8Y3Ykz+DtqxuS
 ll5MH0kuvGe4IYhvX
X-Received: by 2002:a17:90b:3883:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-395def03e79mr30789683a91.6.1787570935014; 
 Mon, 24 Aug 2026 04:28:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3883:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-395def03e79mr30789587a91.6.1787570934583; 
 Mon, 24 Aug 2026 04:28:54 -0700 (PDT)
Received: from [10.213.109.15] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af750esm9825643a91.11.2026.08.24.04.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:28:54 -0700 (PDT)
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:07 +0530
Subject: [PATCH 4/4] drm/msm/dp: continue link training downgrade when
 cable is still plugged
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-qcom-dp-typec-reconnect-fixes-v1-4-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570901; l=2888;
 i=saurabh.anand@oss.qualcomm.com; s=20260824; h=from:subject:message-id;
 bh=IfIz+h7lQZygsMdbtFUdSpKAhh+9x4RQKe/zH5OKDOc=;
 b=70s+9NlE/x16oDLy3h3yl/e0qgXl8cliK6Ap3cvHqBav7G3wt3ikUBcZo/oLqVYiI0KPj32BW
 gb5Bfb6yrglCOkGTi5sK9oNebP+RwX+OI0MuE9RzHEYSyImEo1FBfaW
X-Developer-Key: i=saurabh.anand@oss.qualcomm.com; a=ed25519;
 pk=AzGwbGUPO11yi5XTeGyJKOJWLfzXp5Dru4z+PCg/uXs=
X-Proofpoint-ORIG-GUID: rbvyYfLFZiGaaP5l2fhgRBfE5CXcEzHR
X-Proofpoint-GUID: rbvyYfLFZiGaaP5l2fhgRBfE5CXcEzHR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXy2g5n7At2I7J
 WTThg0TnMNb4HZXd54bQjBrS5KqaDIwFbaEJChpIDLnqhS3sHlGeT8TKIJLOZZ1Qh8eL5qn+i9z
 0WFqRVgmIqud3VbvFczt/thdHFqdK08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX1ubsqGwICsSp
 hk3NSqnUFauaw/c6OsYOCEQDJB0bn8oA2KZm3tu7q+SR7dTG6GhGpt4VSqH4N1iYyWjAuFTyRHX
 SfGcZMXD5yRUGYRdHKiRRxMd7MSMbFoQQm7CbBxd7SdHgpxeVGZyWWqBBstvGYMg9eUQORQ/Mi+
 Ad8Ly4fWTOgRgEcacfB0gj43SUy1kJQzpe5hXn168snQtTaNUWKAizLGOohGXEhRsHmOu5BFjzd
 uaC+u1w7Sk4a5pzGWX7PNs9vJYWhUvRF3pkc1t0TNtszIWdf9fQUciBhGcgyb79RWe/2VI/xRN0
 zSUR4D1kS77xgTY1G1XMMVFVui4GOu5ytXucRhKrb2BZgI2wqvUAgzk0WX6OSyey6smg03PSqH4
 WIbh6jyN5GnGwHFtEr8qUlavF8vQ0n2Q88rdpM4TGvlHZq6lHzCfeXZmuzMFodbQ/uKvQi3cdi9
 MA8mF05CfojMy1uniyw==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c2af7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mNJOpbDVpywo_FzgO_AA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096
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

During a Type-C reconnect the AUX channel may report link-disconnected
transiently while the physical cable is still present. The link training
retry loop in msm_dp_ctrl_on_link() was aborting immediately on any
msm_dp_aux_is_link_connected() failure, preventing the rate/lane downgrade
path from running.

When the display is known to be plugged (msm_dp_ctrl->plugged), an AUX
link-disconnected status is likely a transient glitch rather than a true
unplug. Allow the downgrade loop to continue in that case by requiring both
conditions before breaking out of the retry loop: AUX reports disconnected
and the display is not plugged.

The plugged state is snapshotted from dp_display into msm_dp_ctrl just
before msm_dp_ctrl_on_link() is called, so the retry loop has an accurate
view of cable presence at the time link training started.

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 4 ++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    | 1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 59070f399e2d..e8fd8f4c75fe 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2379,7 +2379,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			break;
 		} else if (training_step == DP_TRAINING_1) {
 			/* link train_1 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !msm_dp_ctrl->plugged)
 				break;
 
 			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
@@ -2404,7 +2404,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			}
 		} else if (training_step == DP_TRAINING_2) {
 			/* link train_2 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !msm_dp_ctrl->plugged)
 				break;
 
 			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 5902cf7e746a..95533b0b6297 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -12,6 +12,7 @@
 
 struct msm_dp_ctrl {
 	bool wide_bus_en;
+	bool plugged;
 };
 
 struct phy;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1f60c78a463d..93a37a44273f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -644,6 +644,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (!msm_dp_display->power_on) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
+		dp->ctrl->plugged = dp->plugged;
 	}
 
 	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);

-- 
2.34.1

