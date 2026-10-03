Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78055CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A4410FA6B;
	Sat,  3 Oct 2026 00:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IsUC4jJ8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYoCm9t0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F93410FA6B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeYPQ2502322
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yWz46xkNVBGoy4QZA/vjGyipwc++3rwNTm8zVWDVKio=; b=IsUC4jJ8h66qijVn
 UkchFA/dkBEwvanCbOlxO3nbTVVk5KjvbMq75+Xi6F6XyzEjTy3EHJLZJFBEAsQF
 und9ip5Nb170/D1UWBc8r5zN5A+Y7ZWz6/Qbkr/7VKNhMe/0S9HdV0tX33LTNVye
 8lzQghQaI9Je6ieUTCVvhKNtbxAF29QHiH+i5kQJsXodTq71fEf831YqWMl3CDlc
 vEeDjHcYYsJk0T6k7rQIgwEMD1w3soL2ciobO7kF1zMH53ir82Taf6cZxqnwoN3D
 ZuL67ZuH8B1AHqGjjLU24lVqJX+S+Ld/zgbPGTY4Smuog/lqNbcqIqFAGkfx9mQh
 ViQKZg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8ss2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91785bd637bso10829606d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987448; x=1791592248;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yWz46xkNVBGoy4QZA/vjGyipwc++3rwNTm8zVWDVKio=;
 b=XYoCm9t0PRRcC4fA2ZxROkZARNeSgYpcnMr7/G/BOiE7YWPr3bPJ+nw+qlbhvcrKuk
 uUh6c+7zQtX1gz8xH4rpbdFsE/+u7fscx5imerA0GKuse2OPdULF/IityXHmYxGOWAK+
 nVyHnpZzEuzs26osz7bihTgcUujV1tUyp96FLVWDECedH4oNUpQCw2rjvp2uyUex4e+U
 rfaXeBt2EOWKOnzxTUpkvNs45lui7itBGz1IapidVD9aNkLKdkf/teJj/KTCOSzcTTZX
 VUMWLs88HZD8HbhKIm9/5Db8H+LOyVSqLLqfdsU3t9v/pjeq6jJmGpRr1asbxg5vjm76
 CP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987448; x=1791592248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yWz46xkNVBGoy4QZA/vjGyipwc++3rwNTm8zVWDVKio=;
 b=VDMMJDUPopQNI+2N9H3yA2Jo19RZsWaZn+YwVJoTsqgF/VhLcJ/uS96JHFHOl4F8wd
 vOTlanVxWuM6yf9KmLzt7karKFA8XhHRhD2+gOl46pqM246RGhhgp9t/HCP6NEis0dNE
 oz4uVIvKDtGYuJxj25OjI1iXrS65qlwWhcEE+UC25Dm6iFZHBegKN5INR9n7h8LD5Wok
 WUYz5rDGg2ts/lJNwnyucM9+arczgPCYsafOXzjIiY9WbtCetydW93d1KOozP0YxFKDM
 VECZ1jgKX2HG901P+lxCQYkT3waexRm7CtHRD3vR4RvfU95gICmOoVYTTu/SPvj+GmYw
 6koA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOU8N4aDGJxTGn+ny8spWIBriuUrnmW34QFUJnD3FRgxYa4QHR0HR+h/RtlfO8bUmpnEaO8lzmPpE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lBPMHx2uTTzKQ34m3XxdADFJGpU/yOVZDTJngcXYY0JtANbDZZ
 mA/8lBaVffSIcO7dTJS6UK8DVIu+J1cUMGmgvrI+R/yhSROF1gco+l5JhSVHv2zOwCdpvBcyNx3
 dL/Wdsk2PkUpQ/vmybptfrz5RbRSfL/fl9VGSEmtD1NbqMmYIf25bSAyKB5bkpjoo0xUMroc=
X-Gm-Gg: AYBFou1D+0iQyEJZGftJ5atWzJMWFLoH8zWPvoEjKpexxwuXaQ8EO/EUHKArsffRnYL
 aqiah1RwOD6yhAiN0i1+kTLkubiucZUUhUUwtajUnlpm9pL09ugx+GfNiNMkHh3bBipjNRza1kw
 XlBnuSpRAEzvE0ThJwD0vvNwYSXqFJXdEuum8mUeAPZUuWrjsc7OZ2UIdthWkMZfgO6UKN6J2Lq
 KqowOkEL4/bmrYOZwkoZGeyNTAUyNvtFP0hgaHi3R9KqutJxacdxXhnSTYYnqyhqFBlAiG6IHSe
 2JrFXnBzHJjWzWjDlfMtyQkjEeT8Ath2s+I3Q4v0VO4YgcOeVgNXAk0RBXGP72ZOEeUiG+XPPhe
 6oLzYOdRf6JCdgMmhik2e2GxInP++PbdSgSf6LHb78tRW9lseSd52QIcHV7HGw7hwr3uvMQSV3N
 KVHaZ7dHMUPXnE
X-Received: by 2002:a05:620a:1a20:b0:939:f89:3688 with SMTP id
 af79cd13be357-93cf1751b05mr840051685a.42.1790987447676; 
 Fri, 02 Oct 2026 17:30:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:939:f89:3688 with SMTP id
 af79cd13be357-93cf1751b05mr840047585a.42.1790987447198; 
 Fri, 02 Oct 2026 17:30:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:22 +0300
Subject: [PATCH v4 07/10] drm/msm/dpu: clear the DSPP pointer when no DSPP
 is assigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-7-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T4qe/ky6P713qCmilfQ+5NwYZw9WXGDP/jjKvtHyyOo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEye7h6PI3d1u3vhX5DTJ/vYsFb3Rk56RGQKF
 l0e27V5m8uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMngAKCRCLPIo+Aiko
 1TLbB/oDFXqDK7I3TzcVpkY8ny3IntudCZOJfJvFl2nGnOvsIDftB1iDwVluubR0odIwh/veNro
 Lw2AFIl6tPybNje67aPMwssRrSCiEPCFtRLV1mjfLYquWiuHkw7oJQvysmCYPRFfrNT6skcrUIn
 LJVZZfCVRf5O2/nuZzQnjw+s29xoqw9hp5R6W65UZb2snMTW82odzR80huairosXfECJd5HwOw8
 MbpklDSLPu+I8DXXcOui2ivfKG/vayvlMl7MeMFaWcoW3MbJY9XgVufKAIPJO9tlaqE8cCrU8he
 Fk08QDzCf0IM1zkFGlo0h/PLBUb6MsIzRivKpI4YXNiYe1ej
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: dznfv7yMahSeE3EPkDsi8PigjvYdAq2m
X-Proofpoint-GUID: dznfv7yMahSeE3EPkDsi8PigjvYdAq2m
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6ac04cb8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=jpbDcG_WXHA3xrgMYRUA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXzmIbGlM9Ys2/
 iWj1g4yNpZlrGWmu6l0WnJ943sFa0JmklsrJrjd27Kswh7Gg2nHhb0QJ15D0JVAReBnvxEAFVUp
 Pi+DBDP2zo3uFr0Z7x8LZYumDAKaRcw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX66hI0nJWOj80
 jtUjYogb+5mAC1NstfGHekPj9LpqINaPK1vENVcBQT1F7Ixwq+ZF3UMQDZXnne+cURGSULSxE3s
 qYZkL39f6VL0IAqjvQ6nmqVTJ12S+BhM8ww/jWD9QlgvselU7j+Lk9cBZb71t34uBhdARPxF0xq
 Pv9aHQVxweWu8BmkyO+R6k9HNqRp3TcnUhkCc3a9fUTfWZYf8nTF8rV9MvlJU/I1X7O+5QOvTqU
 dmsZkRx+as5jcgquoFbTCjO6W3cMvMX93yeJqpZGw8n6tHbYUnNuC44g4wnYnDLJCHweY3tfyQW
 oU7Wc8w7SMV6nEWWEtOffmsYz4p1DuwtIL/OJUHKajZWlUWphfGV+a1pTsxf4/ZGm4ROz0AtZQN
 pdE4YRY4F5U8NRcAIWS4lYjn8vwsMpTIl3A+/IqOekRwZP83tgIbIwETD/h60cvENNtOFDT+sbK
 YlL4V4FLN3+F8gn65Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

dpu_crtc_assign_resources() only stores mixers[i].hw_dspp when the new
topology has a DSPP for that mixer, and dpu_crtc_duplicate_state() copies
the state with kmemdup(), so a crtc which once used a DSPP keeps a pointer
to it for the rest of its life -- across reservations which no longer own
that block.

Assign NULL when there is no DSPP for the mixer.

Fixes: 4259ff7ae509 ("drm/msm/dpu: add support for pcc color block in dpu driver")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 1f8fce366a1d..2ff0dab33710 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1480,8 +1480,8 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
 
 		cstate->mixers[i].hw_lm = to_dpu_hw_mixer(hw_lm[i]);
 		cstate->mixers[i].lm_ctl = to_dpu_hw_ctl(hw_ctl[ctl_idx]);
-		if (i < num_dspp)
-			cstate->mixers[i].hw_dspp = to_dpu_hw_dspp(hw_dspp[i]);
+		cstate->mixers[i].hw_dspp = i < num_dspp ?
+			to_dpu_hw_dspp(hw_dspp[i]) : NULL;
 	}
 
 	cstate->num_mixers = num_lm;

-- 
2.47.3

