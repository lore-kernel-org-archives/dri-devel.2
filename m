Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84892CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C8B10E74A;
	Tue, 29 Sep 2026 04:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ab1NG/4M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbRWy9jg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FFE10EC97
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47QHj3643855
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GYzN3WW/T5PYDupoBOf6xq5Ubj+LwYC+2OZfV6qkjFY=; b=ab1NG/4MhyDJcwN9
 boZToEIfxNwKi0y9rPEVnmeLvuUBAk4eeoLUfwfT4pvWQO+A18Vt0/XVUGcHnu0W
 nTVnUJNwAvNribMynItPjemRt1ImsMXPnNiFoT0PiXHRvBd0fMPBwSM35c0Mnb/Z
 5hB2roNVZHv+u80MuwvpJwB50zL71ICk+fO1PggByQ3/BFuoLsR2QYH2zBrFggB2
 gwjg7yBuI9BJSmNv6gGzA/wXJnG+HSHSki9r1KPUcWJUgkZrJmEDDxUScJumsGtD
 UOfc9UTXp6ay/NtuNs2YauDHXXQgf2SaA2HWk/kEEui1sMLNgZJxJyjBDiBd/V68
 1+hLxw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4s48a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91452ce83b9so39725906d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656002; x=1791260802;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GYzN3WW/T5PYDupoBOf6xq5Ubj+LwYC+2OZfV6qkjFY=;
 b=PbRWy9jgpseAgnlhWxL040vX5hAkrR3komjINxkNCzJRGIc0TW3/oW4CnWGdJ+rQHQ
 pNpBDUKcjq4DG9eY0pA5uSH1Y6urUr+nUqSSy69tCFW+8jlDdGnYdyB8ETvONvnFMeqJ
 3wETzlZo8XgZIPxcIZxfUn+96ezzdzUKSa0JNcLo112v6zpHkgG/W/0BcruagSfj7k/v
 a0HrHmjcSj8gToDSaa6Xr6bW6B2jsp9TmtWQlmzX01Mgz0lH4ZLQfbwHpy6leq1SitwT
 GPJD8AoU6o7lq9kWmTbgpjIT8z36RhHx9DQLtZxcWH0bgCnDKrKh/MPQqgMT9YV+ErcB
 p04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656002; x=1791260802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GYzN3WW/T5PYDupoBOf6xq5Ubj+LwYC+2OZfV6qkjFY=;
 b=z7bOkeMi3yDzfKhFsobEK9Gy9yLiJPCSXq6cjW/zvL2BAlyDdk5QUagl3NDiiTO3W7
 +8i3lXLXcs3IPTYg20ANDT06SjBw8vhFONtCkNyqjT7M7NVJ6T1I8Jawu2MDTcrhD44Z
 9TO29ymEGZOWTYz0o/TIOyYCbCyjtItQ+9o134K78xmx0tC9HtILPQU3SuQrHemXnoru
 zczxEhy3kf/CVzxaK6lv8AWwxTUMbSO91r2k/inkT1cuDwgoSdCYTEC3CwZLPrv1Bb61
 pM2R3L7/j6CEHRyysa2B3KJ3Dhtu5t0ouWEnADMoZi6WweFA7LkMkjzLpDemb6EQr6Fo
 1Geg==
X-Forwarded-Encrypted: i=1;
 AKwUvByelA7udyuqef/Qop58U0fjWe+MXq22bIZly5TnOuvQSyiD6Xiurdo+DWcSieQTBpVFMNi5tIRRLhc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPLYKENnhKsdR7OhMGVgN/qUY/hpjPHxrFH/h/WkzklWhsIlR3
 Htsa7GJkZFEvXHE9bXrbk1JLqa7p0dKexDXdui9BGLQfs6Oxp5DZRAUbWFxzZAzVtJlNUnpP4mS
 L8WNzEpPHE98v7fQRQnxnB37I6/nIudOKkxnaTqlNmaGMxvvY4Rli65++QwEbcU2HM4OJ+PY=
X-Gm-Gg: AYBFou2PCWKr9aqW03nkI5kUOd9VOngDh8K869ULlnDYdS3aMKbFkyAx36S7Jap7znf
 yqx+Cjr7MBjDgRpd19CzMNy6yr51uJ/ld5mEY0ypeSdoxosEZJtfj8RsEKqa4uGhOjhfIFvEMSQ
 nkv6KSbP5JIKBYIguPzoiVL8m9sjX1Xefq3yK8024iyLerif6bMDe2wCp73IAadHUCPY15Dkfir
 ntTfi8LV2uGV2pXwGAxBgG68kZC0S6mD5JtlMqHwptgDKAWUO7gJAISPGIQw5m3gbxBzDbB0VrT
 XTMth8HUrRe2C50C/JgSWnNB1B3Pp2RkgQVGqN4UgGRh9OrBV3h+663WinuEwd3gOHVoKTI5vyb
 WzqmF1E+BP7rTaGeSvhoOsF3Hu6Ow757zqazRMi44lgucvg6VyKXDYnkzrIK5BDM=
X-Received: by 2002:a05:6214:19e7:b0:914:1807:dc82 with SMTP id
 6a1803df08f44-9142f6c351fmr263711076d6.1.1790656002427; 
 Mon, 28 Sep 2026 21:26:42 -0700 (PDT)
X-Received: by 2002:a05:6214:19e7:b0:914:1807:dc82 with SMTP id
 6a1803df08f44-9142f6c351fmr263710846d6.1.1790656001955; 
 Mon, 28 Sep 2026 21:26:41 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:26:41 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:27 +0800
Subject: [PATCH v7 03/35] drm/msm/dp: drop redundant config_ctrl_link()
 from msm_dp_ctrl_on_stream()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-3-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=888;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=K08RSR7jFMIU1z3Wf63hI19PHcL0gXlgR6VRva1a4mo=;
 b=fyWqoVQcjO6e5YPg2W4msIxUou1AZAGIusEl9e7VZCSk+44m5z2e/n833X7kNz9T9O8r1teA7
 jnnOHqDRV8ECYAIZ8z4ZCGHduSlUQSnhPj3WgzrqYQzCKU902b9LsKu
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX4kcmvvI1y340
 zjR5bbhWDX/RJmE+0W65OsE/e8o1tlwexrjeKlMjDTXRLcI4UkYMZ8qwgZRT7zUHExpGM98Lov4
 p32uOabJpJzjgmdFEitNTmYvWnsS288=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb3e03 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=P3NwbF1cJ5UVZmgLWE8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX2+4dogfgXAVU
 IPx1RA8HKAywUrKo4KmQ4TG11vJDgP26mjX14fXCLi88Tc0kRGQ+YfMRJPE5oZvSzCAlfGs7G57
 YBC9aS2okb+WAM8SfMMBhMNW8NWa93BkFzut9ki4+UWShHTxSnU2Hy4rf2GnogH/5Er5T/2gyuY
 Cqh3MkrdGrTZZ+HDCvSpadZB2bc8bedjRQsZy6qg8BkW3crOst1mbMkq9Cabpx3ioV2jialPqHJ
 wuMoX7ATtaYKalrUIoTwBDdWloKc/uCXAw43/9vleuZM544fVG2wJ5tRdao3Leo2gLNY0AFfSDJ
 LkrZy8IChUaLpwe+UE/Jj8rIL7qOWG2HdQ6v2iIx3C0iYo52D9eFjGL0VSRjX5IrmDa0Ox70zcJ
 pw2b2+SsCKFL/iplgV34/03Z7mXZnLd+kU8jBsWKnoAAPw0uhyvZ5xqn4KeELLe9iRo/UxaZA+0
 P+rCGBjiK4PCd7+yK6Q==
X-Proofpoint-GUID: bgaX4Hf2JloZrYuUlHBNxw6MPakJT8qd
X-Proofpoint-ORIG-GUID: bgaX4Hf2JloZrYuUlHBNxw6MPakJT8qd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

REG_DP_CONFIGURATION_CTRL contains link-wide state and is already
programmed during link training.

Calling config_ctrl_link() from msm_dp_ctrl_on_stream() rewrites the
same configuration and is unnecessary. Remove the redundant call.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1ed713b957c6..e7bb9558c0b4 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2598,7 +2598,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
-	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 

-- 
2.43.0

