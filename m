Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92C6CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D71D10E26E;
	Sun, 24 May 2026 10:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Waa6ssRi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Krps/wgU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D853D10E260
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NNQmGQ3194992
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iyv9syfthQXpoKYKQYEjdlG8jJw3/TSDQ0p9GxKw8Tg=; b=Waa6ssRifQJMB6u/
 akF5iunjLiwwFmxG2WIqS2dIhibph3JuvWbry7GAhI73MM8KfNk63eOd+tAqdXam
 zl4AEBg3wX40zXKPchf2n4y4JcY7t9PjpOpWc9NqqBYHZhwO5zCz/9x535CY0rsK
 jAmUODGAsCg3/cZ7KUaPc5Tgc1nnKsJ0zpTI7Bmm9OhD05EJFhrA+bwWmMCZ6VFg
 EmdsQW4DD6XZgKv635WFkUdLtmPT/UAEkGVP0vm2RqORXDb5swQpmobAZbczfTsx
 2idn+m37Fjkc1lEawq5+B33OLfJWu2PfEnMn0eUBPw6gBGAmd5A1D5Hp9k4xBorG
 hfiyVQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asty6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56f6ef62af1so21029190e0c.1
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618821; x=1780223621;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iyv9syfthQXpoKYKQYEjdlG8jJw3/TSDQ0p9GxKw8Tg=;
 b=Krps/wgUFaFmI520qWCb7+4iM95SpG0iaKnrCfUzOiCulfUzXXK+gKSUqiH4VueKGt
 XAgFcYYWtTH9vPOn5qv8XGon4xNmJHjUq+wuHW2B6Pi9Mo32QY+BL6BrwvOdm8P8c2Xh
 mnyAI9jv5ok7WltZOId4jTpTgjpbmrng17wF2x7KH9p2h65bJaOTJdV8G31AosG4UmE4
 FsRAYtsfKnEOnw2kvqZmlx8sRVSaxP4PKq+bylPgTP8h1hXL0f6l0xe1huHJ1ltJhJuZ
 ce3IKfzjMH1Ynnbjs1S6Ldxn4p8EvRLxJMs7MQISSYxMz/p2rt59j+Do2OCkgvGdFqWk
 UJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618821; x=1780223621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iyv9syfthQXpoKYKQYEjdlG8jJw3/TSDQ0p9GxKw8Tg=;
 b=cx1Su+XbiMhdNWCBI1j10nGzrjXQOTrD4dYEIbrxhAKnQ4gT00FPUSVL+xPXDR29Tv
 QAJgFp8EWcw+1WoRGlGxxlM9/ZGmzh14b2bZtb/D/fJr9Lo0q1r4zg6cU/eoxhyfNp24
 a8r9O58vOleJS7qhjoIPP+sXZMDjI0//YrALzjPLoUvdj5IXkcHvQyuAVmpAk2NZiUFs
 sUZlgE4As6u2RuYob+Oaxjlixdb4t90criwa+DCHR2rb+I6lnOmKxCierZ9T8/AZC2yS
 rGe7QT34u/LRhc/gsGXuF6u/Bp9PCc1Xj6Lt6EJlmd4LLpJmUKpyAUu9IkfHWBc4zbL3
 k0LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sH68EropoZtMB2UK5ncQEtKIRPVa9m7CPOnASv+0c/xwjxB9wNS5UeCFznmwJEoufIak4ZicE0iE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1cgAJ9mPG5f4UO6BY7TmEu19CmHgLR7R1MNvtiEATGkSbIgRD
 D9oFQZxNQeFs2KUQuz0Xq0Hldtowwbs3CPmVl0gxBaOznAq7NsLOjj+h+9YXlT0iIl7G8mMEHkS
 dkxQ/zQWQHsAYjTV24GCdMjwjyZTtspesDrYZYhgkqFZh27UwHy3rfY3LEkxYBC+HExV9POg=
X-Gm-Gg: Acq92OFHr2rTr5TkzW5NZLBrN3Vw2DO3fUlVL72S4VfK9KK2FcGGkZI7nYC0MAl5Epj
 rRyoUk6MC0ljkG01xrhpevGIJ3vllDHl1qCXy5AyqoAySG0WbfaT9SfENFFoCA3atket5ojpUUe
 17UpjctMIED0B5l2Tv7zEtxUrLiiLdfckOq0ML7DLO8R7zhb4Tmx5wufuqOnDTJOekLo5z+cBMr
 qnskaZPn+fu4FsX/zYyPczyHwaLjcOmOI3iXPBCOoA0ria8G89Lg4K7qtDF96IRSRoZ2xEHKT1I
 yMuohJLUx8xutGy2+iMAFbsCdkrI+aIO7sqkrIgOOtu2enw5jzy6oD2VB9T/boFo0sLqLMLuaUD
 I+bxwOA/FC1tyEffxQPaqcSNhe+N5s4PJjl9+4zOEPEUMDfhT7PD6MURDZpKBeAO483yopfmFfc
 gDiizo6Ux9LE1bHwam54qhmF2GB5TPGapgtZ0=
X-Received: by 2002:a05:6122:1310:b0:56b:1eb:d396 with SMTP id
 71dfb90a1353d-58664ddc313mr5496531e0c.14.1779618821372; 
 Sun, 24 May 2026 03:33:41 -0700 (PDT)
X-Received: by 2002:a05:6122:1310:b0:56b:1eb:d396 with SMTP id
 71dfb90a1353d-58664ddc313mr5496527e0c.14.1779618820941; 
 Sun, 24 May 2026 03:33:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:30 +0300
Subject: [PATCH v6 02/10] drm/msm/dp: Fix the ISR_* enum values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-2-cf3ab488dd7b@oss.qualcomm.com>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
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
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=M0xFObuyqZgBlqNrkdp3PVX6fNui+g+cwQXG8fz/uhs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP8qvFgjuBpy2TdYOyhSO2wLOR65eGv95Da8
 AIL9bX3hXqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/AAKCRCLPIo+Aiko
 1SqiB/990K2kPsax9ea0OrmCVcDsuamPI+mrHcpsT1rLpmgDpHrzNb65CoGdS6CLHZ7RJKWoUHm
 wpRbX2/iT7SQMAtdBwVeqNrwYh1hKUaILucW64mONupci45Qc7LGyV2tgLbq3spRpHI6ykE3jwo
 9zT5DO6I8IFFXOVLra/uNe8tgSC2ZI9DnTYWuqfVeecbqBP9+Al+ieDo4RlBtLbMzvreZ1KsWXH
 /AKAvxrOLLLhnbjYNgmd9groKwDruSIkT+NyGrcDBvbQpvI47Fos6Wlv2zW3J3CLRDQPRF9BkaM
 J6ggWq344csTY6gYKOjN571jk4q4M27cVX1Vk00aQG/5R5EZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX6ZWzNzKesT6W
 sWRCLJqLhSeYXJMGHcZGHGDGKCUDVAKsj8UExCVt1+dtPoz/Wj+vzMOwlW399zdQgJxSoUagIPf
 Wpnb9hFP6Zryhq4bc/YgsHUgYJiiWST3Ed+24r5WzGE8S6r6i7yhb47UGMd8jJG1NFoiQSLF2/P
 C3DSfC6NtmdzhBey5BFCe1cbomrQ3Lx3sXbNkP2pr9yKkGi9DPgxoXuhCXwp9Z/5PzOnMAcZZRM
 1Mi+NlNUXV5PU1G+ZCUrwkW6NnE3ConO8NExRZJyWttg5HnVOWnB+BapOYltrLjQQBkzoW/PuHX
 v1JZYiFaRqQ+3X2YOIn6VLRN7fOABKuACgc4MYR71j81xsyKhHlmMQiQMATp/nC77+BO9LES8Na
 Hd2bUmzqvjsGkmj3omDA6FYirUJ0GFZUChXYVvj0+1LeDJL330e1bEGz1iXwDLr+z7aCy/Vt1uo
 +HnSeOZTXkhXn24/61Q==
X-Proofpoint-ORIG-GUID: izCr82QGxznfRIQRjZ3luEvo9v-z9Gtf
X-Proofpoint-GUID: izCr82QGxznfRIQRjZ3luEvo9v-z9Gtf
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a12d405 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=aneus3DpQx8xEqIVSrsA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107
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

From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

The ISR_HPD_* enum should represent values that can be read from the
REG_DP_DP_HPD_INT_STATUS register. Swap ISR_HPD_IO_GLITCH_COUNT and
ISR_HPD_REPLUG_COUNT to map them correctly to register values.

While we are at it, correct the spelling for ISR_HPD_REPLUG_COUNT.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1b3cbf4016ef..1dd168acbbc3 100644
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

