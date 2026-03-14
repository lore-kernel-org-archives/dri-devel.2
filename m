Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C806107BCEE
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF02310EC6D;
	Sat, 14 Mar 2026 01:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+EiaUsb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dquGwBuc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC7710EC6D
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:21 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E0gbMD2411565
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FSS4Apq1RtX0e2b4UQIuC0SLm4KCkQ7NHbbPUFHwauU=; b=J+EiaUsbfX6EZPkI
 T4vJxXzK4XGT0gKuAL8NEGKsAQBAb5Y3vRrgqSe5UxzY6WoGiJOmiNxZA+7XO9c2
 ZFOvJssMw3h2Mw26FA7fqHNLIQH62Kx40N0BW1S6GRffxr/u3Ho56I5X+OICWV0K
 7sfjqU3Sv2c67KgHIFQi+b8G5tnxU35v7K1nNqbBXgIAoR4vczFTdi4jgM5U74D9
 G1SiQWDK6Mpr6laM1Gp/yafUz5wp7OLHYN3xXeegF/RVLrLHw0uZTP8URUI+1x4q
 ruqT5zUkigl+ndxmd850vV07fRI4WirIbtKviKQfs7xuV++eN3OeTcqfzqr6mhzJ
 Bq0NCA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvwcer1qx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50937c5b742so220126971cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450559; x=1774055359;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FSS4Apq1RtX0e2b4UQIuC0SLm4KCkQ7NHbbPUFHwauU=;
 b=dquGwBucVNsfnXkR/iC9XOzf+yymn1mItOGTmqNc4fa84NnlH4jGXaz4oAyRcO+XLA
 1AAyuePyJNhOX0vRxurPjQ1QmPSg7H+jbyp0QcbaOR/Lb+Aj6sph9RSfKY03jm31T86G
 UomfECTMqVMCy4l7gPL1HmAyoqtbKHoO9Gwj0H5lt6PLi8bnZvq0RpWZQ2EVrkhYOqjT
 t2Hv3cRaLyBZu6iv8doX5GIxkG98wtQ5Z6yGDZCUkPSVtnARX8cz31WZKbHF/cDHvc9p
 QffZo+rqFfu3XC5U9tVw8Z4SxJHNWFQeCzIs40ae5nSVHLjVm7KUBUPDEkeSCgOKyvqL
 29uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450559; x=1774055359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FSS4Apq1RtX0e2b4UQIuC0SLm4KCkQ7NHbbPUFHwauU=;
 b=KWXp61eryolupk8cbBxVHQXXMFBfLnGyhWr6XpfvYuUZmoXeMrjRtp+Zg4e8n7t3wd
 KGiekBMyzj0CgWgM21Tk/DFOhZowoQj3b3+tzN342FnnIbbAf6994GEUpQG/hrA5qOlQ
 LRBrkOV8KUVE8d592ueCaHGW3PLGuUBBArDZ7gfO2QgF6AlKOfk9E7mCEtsP5FXyjLX7
 IZHF2yAXYJeSiB6hNAkCP+UvzQL2i83NM/HQ3+tloqqNKndeqbgvI+zjd1e4j0n5nwC9
 eqYJ2Chx/VBo0aPwneIazy6cC/HeKLgLnjq0W249LKTeDc1OR7z+CSbErg8ttuRV4efA
 PNUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi8rLskdqd3A6SV3r9p71Sj1rPDTIcK5jR5TEGwN2fcIdLdd3ljPAUkhxKLqtdddLbpSFwee/G7D8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwWIyQVZjhXONc7LjGom1pr5p80QG/Ce4TaQB/elAsrNy9RhEg
 OT2Dyskd0E8xLa3V+FtmLfqPRsERaHmMZtH1B4VNZpNdHuBh/o1IvM3/yNlkKtTSgJA9BJd7UtF
 K0TwCjMdtAgvZKwusOA1erVciVYNlTPCfgdUriefeUoyu0/26DEf1TD+d/ez7SNr1ML37N4g=
X-Gm-Gg: ATEYQzypXwJ59pK6u8/7Ly4U8JPzOvlNOTgUfjryRo/gh937pTb6BxYDkugG5xC1f1u
 s6X6yNNFnDAO/LJX7fxDSkURfg9LzIjz5UteBh7zoCKR6AdtmfxhJNebQ7eg0EcDJj+WqOjOpAt
 dIK7pF1OW+ILZbx6e2EUCthIMrupURF4q931YQmoP96UeEu5U+pB3Db3NY5K66CzQ7cUYadcmsP
 6VtiE+iS6HeR8eCAGCIAY/1r/M4eH0uefd9sYh9w+gHKuD9feFRp1n8Ut9omft6F3+IZeEs/lsi
 P+9fx1STEHhDJguHZenW/p/I3n5ljVKIzHnMwlhDszuGJunibOgQoe+V4olll0mqJ11XRa7e1WI
 B51I8/bsHCd0CHghcYFvDzKDuKa6lOYqoOYV4KOMZc/zwkPWeeg8qT8l7IOUqnDSoWe9lj2IwfE
 zahjWy8Xwts/DGayRm2sWLpwN4dQ3bUSYt3OY=
X-Received: by 2002:ac8:7c4e:0:b0:508:ff31:47f1 with SMTP id
 d75a77b69052e-50957ea4b91mr74476831cf.50.1773450559580; 
 Fri, 13 Mar 2026 18:09:19 -0700 (PDT)
X-Received: by 2002:ac8:7c4e:0:b0:508:ff31:47f1 with SMTP id
 d75a77b69052e-50957ea4b91mr74476511cf.50.1773450559043; 
 Fri, 13 Mar 2026 18:09:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:06 +0200
Subject: [PATCH v5 02/10] drm/msm/dp: Fix the ISR_* enum values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-2-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ww/3qknDh3ls3uKJd9KJ6MipP3FzUf7GXLi0EYvbbNM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLUzpMT48Ul1fCy2axFvUY6so32R8/lXIrhK+
 jiXWcynaeCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1MwAKCRCLPIo+Aiko
 1VvKB/98dmFO4H+csqmM6Uvyh0/4Gwx4eTwsJ+9HO8uwCsOwxLyR+B/6DgT275/B5fMKUad6hAZ
 5/whaKv1MgRYOZDPnEy43V0DhwOanfnjkEVUjKgcsZhPv8f4h2UsGpTH6nxhWxAik5EjpU2yv9g
 iE4E/1nGmLuOljEh+sSpBUL/BFQIoHolvVVepuWqbr+xjAF2DsFV8TcYd28IuAaNKI1VPyBeoQZ
 /EGA97xGYhTzHemOcmYzOiacD8ZkCXfh547h1IChZmQb36dETF74o6lhvonkQD4yd8zHi525957
 N2xIjxL18NL5J6O9dWgr15pqdDYBeRIlW1WtG2yhOc4BiRsE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Ibpx5OF0-vZr7lva9Wgtkzu2LVAQzc2Z
X-Proofpoint-GUID: Ibpx5OF0-vZr7lva9Wgtkzu2LVAQzc2Z
X-Authority-Analysis: v=2.4 cv=EIcLElZC c=1 sm=1 tr=0 ts=69b4b540 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=aneus3DpQx8xEqIVSrsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX87Re2P7cm0vb
 TGu/Qvt0f7pDBgWOBVdXk9cOkIrEV7BkBHwOlI423JOXuApeFjNyE00umd7RmtWac6Ix07Eptu/
 yOXE0GN2MBcK+rYb2+YRXePj/gJn8VY/ynB/uBro2JaypqsH40iLUpSdotoy3q6BwjlKD6YVoe/
 RDDaUoRhgpbf2TfuzSe8NFlCVft09ZZtbSWejBCs8qB1xyG5tYKp6PcXw2McvW4/vgE7lHWaqf6
 FwlFHhjDHC4azHFxTTDapf5xFDwmB6Kx/53x0XG4/FT2+Y97Fxr/jyTV5ZHZQSguDWNOef5Pa+h
 fVqZtzA/47Uz7jGSQoxWMiOerUlNPBxLO9ZgzAJbi0wF3H0gcmFPtveZiuPlfTaKxvFMzdp1NzW
 k5DNJ++upDUyf8ASURiv135PM4sxZCyoYkBC/oIEEuvm8IInaRYaJo1qRe7pQU+2xQIX73bnFON
 69qIzKUfMbOyb2hZq/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140006
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

From: Jessica Zhang <jesszhan0024@gmail.com>

The ISR_HPD_* enum should represent values that can be read from the
REG_DP_DP_HPD_INT_STATUS register. Swap ISR_HPD_IO_GLITCH_COUNT and
ISR_HPD_REPLUG_COUNT to map them correctly to register values.

While we are at it, correct the spelling for ISR_HPD_REPLUG_COUNT.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 476848bf8cd1..5997cd28ba11 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -38,9 +38,9 @@ enum {
 	ISR_DISCONNECTED,
 	ISR_CONNECT_PENDING,
 	ISR_CONNECTED,
-	ISR_HPD_REPLUG_COUNT,
+	ISR_HPD_IO_GLITCH_COUNT,
 	ISR_IRQ_HPD_PULSE_COUNT,
-	ISR_HPD_LO_GLITH_COUNT,
+	ISR_HPD_REPLUG_COUNT,
 };
 
 /* event thread connection state */

-- 
2.47.3

