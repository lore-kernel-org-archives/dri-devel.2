Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB71C44538
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D320C10EC78;
	Wed, 22 Jul 2026 06:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bYz0/G7/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASlUN3Nj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EAB10EC6B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:15 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M61q4R984390
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ts/aaAIVOgMyHZh7xcpfl75wOlTuht4I4M1cpLCbVwE=; b=bYz0/G7/w56STUJO
 C5Ky2xIZQWeU82AwCeSAlquc8GJzLZiKOELUc1He3QVtaFQxSkjpDxAPToKbrw13
 h5jeraXiuP5M52MeOddO0WVpOqsSFV4ctx0v1XIj5RbAZ5YJNdQYS5u3GIivJwyb
 2eGEVQPEgqVD3Pz02Y6WN3xhN1px+QarVBBHEM89k+c/rojDe81EVqDrvxPv7nb/
 vCg1CBEGQ4GpMv4Pp4dmkQQixrwVo9rQzUx8vQxcH1H2pjlaYeOJscZbNgLUVL+m
 Oc284ExT3xd2phfkkEeIHMMKIuMdENTH0hBQoTm8jIQSNeLa4EDYQfcVu8carV2c
 uZIX/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr838494-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52827090cc5so4701931cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702233; x=1785307033;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ts/aaAIVOgMyHZh7xcpfl75wOlTuht4I4M1cpLCbVwE=;
 b=ASlUN3NjBDxoYNvtzi2VZmdlSm0CkCdzlNAvqDlwYMoAewY0WrkDoyNPbbPCI8gVjI
 pixr4mZ+U/w92BIdTpvzFJsRcByO5SRUMZE7b+RqgxhFlSX+GpJoxGs0n9re9H64YBIE
 bPyn5pJ8HPacj7BkBBbQGqgjOk7w+h87alGF3xOSnzXrZdvba1Je48iynZ/Oyx0KV0VH
 QEyEi3hS5u3W4alS4i8gram6N0DfuiKPgCcRwBLLXf3g5tTfMkG0QNPG7IPN9te1tvb0
 Sx7ZH6HHkOktXY9xw6qbOxPlGLvOuL1JDgayaRU0wNBr0ZMpLYD6jY127/6wQGRAj6i5
 qsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702233; x=1785307033;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ts/aaAIVOgMyHZh7xcpfl75wOlTuht4I4M1cpLCbVwE=;
 b=gJdchKNLN3bQ5QEUJekm5vr8ZCUVR3ZbQFDW21ehUDCcBAI9PozTNTZoWRJY2cxdbC
 aT6GBXYLp8xH///zqFgCNBrlskGjFqtx1dYkO4jP5Pr17OeLTax+IUdr+TlIjqAiP+7I
 L+P1VMgiX9gWyo4TRx08t0CmU/pYr/see9tUoPKBp8ikSkj4N86Izyth9FEQT0t8A6F5
 o5/jbg88365HrvKjdijVAdY2LARogzxcKobiiIgTaktei2rGfqwLcKIDK8zJKX0bn2JS
 zippULjiIQbll143XApX+pa6e4K+rliysbhMMXVQrLZ9e76w7199EE7yaiOr/T6oH8XY
 0/8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqemr3+nwaF7qY7ObH4NJEp1V0+5uQyVHBUjz6srCCqVh9eNWZVcjoBbQ4Tr660n+AkZOFQ9yKG2n4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZu3okjAWQiOpM1C6RRPPsWipKlBN8DZ72YAsxqP8aOmmDbJO9
 HwfxaCrEQLR5sVd1jzXs9hjS2z2TYXgOm6C+Bosq+G+V6ptw7/jzYtFi3Q4eHEcUM6dPN4k/bzr
 AlmO48v1eZ+FhEQdcwaOrBsvdibiPyV34gtChEBRoiAv+DBvn6FDGcL4sP1CbmAGzHsyeCc8=
X-Gm-Gg: AR+sD13sPINOF+RatXmA/AcMwPqmMQpBgBTwN2Lqq6gyf1c1PHhs+QOnQkd8zsyfw1U
 /+Iy8MJlUBYdRqW3Eoj/Nw2lo7d9vTjs9ZvcQ2SywC6JrBJTyc9ctDwPo3XOPUzDjFvF4oF4B8P
 qKy8EfqRs+IT9R5tHSztz5/W8zW5ecHIfVDJGOLEBcKRDluxOlzige51FI3lqTvZPH6PCpWfnml
 aPbc1Mt45JsE8w9Lx5zjC+Z6RtVbzJz+0j6ME+XmqN4CtbGgvfofw37SZtG0putrDrFlSOhAACf
 TLafDFp9mtrzUf/jc7WMn4OIetrZoCsUiR0Vq6e/sdWBoEmHbJ93XPSTow16eeI60F/Vcc3AcMU
 LLh2QY6QHqI35nWH9j4TLXs7M31aKIMaSyqYeEnvy1ACDgRDEmu/SAiCic5nwP/lNNOb+Xc4yGC
 hHrzDWOSKkwqlYOw==
X-Received: by 2002:ac8:598a:0:b0:517:91e5:1086 with SMTP id
 d75a77b69052e-527a961c7ffmr29048601cf.38.1784702233414; 
 Tue, 21 Jul 2026 23:37:13 -0700 (PDT)
X-Received: by 2002:ac8:598a:0:b0:517:91e5:1086 with SMTP id
 d75a77b69052e-527a961c7ffmr29048311cf.38.1784702232777; 
 Tue, 21 Jul 2026 23:37:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:30 +0300
Subject: [PATCH 15/24] drm/msm/dp: do not reject wide-bus modes while a
 YUV420 mode is active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-15-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=p0Rd9oPmiONIcDwy0yPI6eTa7uZg5IuJSk3yNdX0Wak=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTo7I5ZjesJCBg3IFjmsDzx71PdD/aI0HSsQ
 aGpMsdSYMWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6AAKCRCLPIo+Aiko
 1fQbB/4nTv3dHJr5ET9DfzmacacMg6Lx5fk0mMMtffHkL8JP45XJYKWl+Rm3zUPCmhEpI3M3kuH
 v1iiYEs92BjV3qIR2LQPiPyFG0OGHs12OUzdyblcKRynzx98lxFORbs0aQRrhtWd+1MJwfT3fqV
 feM85ZV2U40B1hziTqzjEsM5PQi0rUfJ+DXvNICxrGcKUdK6kFFKTF2c690sXq9Ve+nU9R1GrFU
 VEqPwamOB8U+r6fl4kay7wZ78ENgvXXYT+jMVbQ4UliP5bM1phX3LxTKGsJJBOPvm2n2YrGDLzF
 Cw6rj1aQg6ivTcKes/E6iWRJbRn5XC1grg30hvGwav2J5RuS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: S2P-BmFuOWPPZTRo_6qkPNiKYsFIjRga
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a60651a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Y4CFgLxAi_mMOGnJ0dIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: S2P-BmFuOWPPZTRo_6qkPNiKYsFIjRga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX15ilFCKLfm6f
 amXC4lx5XwhvIg7yNjyFOaboTVKaBXn/gv/d8p6++1nTG3DaeEOANE3SuHbHeArEicbiNg7VL5Q
 ef4FEfqea7JyAYNZ8Tn/Pn+7a+Ms5zUuULvV1EIrt6GksnZhJ6mgQPJjkRSHPE+wkGz28jWXfdc
 kjrdEHxAFnBzL+UNpXQdFpGtQHcC4QFeTgd/GZjL4la43+tphwE7indddw9OW19g+GsYKGLYl7t
 +UyhGEtZBFNd987/VUMgyBie3CL1RMAgy7r/yFcgb7JsUp4cOuts1qY86VUXzHG2HRBmELu2Rbc
 DnWKaO3ATfho0lKCVpDmQrQ3e1FhVPq1kMxe5iAcznrkd0cNpkPAULAuHQcrPIIGDCC6URHV1ie
 G7yYF+k0X8L2yJ40e500+YJYcGuaLVkPtYUQDb2Zdz4KyX7rdjzXJ4B5I7o+ABuPD+wA6MJEsd+
 evIeZseh7Wvqu2N/vMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXwbIJOqanzE5b
 /vsnt9ym7vno8OreEWnI5yLJkW0vswof0nGtEyUDba+Xi62x2TkGQ5cWvEAyOtpa3Wg6UVp1+Ey
 z1HwFNjFcMWzvuSggm91vXvuxRsC7XI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

msm_dp_bridge_mode_valid() halves the candidate mode's pixel clock when
the sink either uses YUV 420 output or drives the wide bus, so that modes
relying on those to stay under DP_MAX_PIXEL_CLK_KHZ are accepted. The
wide bus part is queried through msm_dp_wide_bus_available(), which
returns false whenever the currently committed mode uses YUV 420 output:
it inspects the stored msm_dp_mode.out_fmt_is_yuv_420 of the active mode,
not the mode being validated.

Consequently, while a YUV 420 mode is active, an RGB mode that needs the
wide bus to fit under DP_MAX_PIXEL_CLK_KHZ has its pixel clock left
un-halved and is wrongly rejected as MODE_CLOCK_HIGH.

The candidate mode's YUV 420 status is already evaluated as is_yuv_420,
and the wide bus is disabled precisely for YUV 420 output, so halving the
pixel clock for either case is equivalent to halving it when the
candidate is YUV 420 or the controller supports the wide bus. Test
wide_bus_supported directly, so the decision no longer depends on the
format of the active mode.

Fixes: df9cf852ca30 ("drm/msm/dp: account for widebus and yuv420 during mode validation")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1baeb9401cfa..bd1354f2c15d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -722,7 +722,7 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
 		return MODE_NO_420;
 
-	if (is_yuv_420 || msm_dp_wide_bus_available(dp))
+	if (is_yuv_420 || msm_dp_display->wide_bus_supported)
 		mode_pclk_khz /= 2;
 
 	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)

-- 
2.47.3

