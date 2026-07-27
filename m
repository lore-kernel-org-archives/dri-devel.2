Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355D9C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B02910E668;
	Mon, 27 Jul 2026 17:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkYgJHu2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bQDQAeQo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD48610E4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlgiM033208
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EKOeCgzPYWc
 ztlbpyGWazJMpqT0ardtdTx2QvaXnCR4=; b=gkYgJHu2yowir1PMzn/DC3f0RWg
 I+ejAFQwqWypdVixe9My8Ek0KqCnQ6Zf7O4zYnfaCmHlEVxdg0Gp/ORnrK9M26Im
 CTUQNoaSDoHlxy/DfwFzlNft0tTq1jRnxV2wLjKwLq0baz8rFLMAgB05lDvgLu4Q
 QzFVb7AloE4ZqMG5c7JzEnRvZqhnuMdOsveRWmUOgLJAhzxIiqJtL58JOGlvFcL4
 aRvVEb1OhBjEqQ2mkKtTylV75oA631CeB/IveBxoh40JH+WDPGCBzSaDUUXq5RFK
 LENJ93XO3k5u7qP29J3+jcP5fKi2SA+yby1xPUo3khEmZ8sAJhFfXu42Neg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c62681-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so36272771cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785173617; x=1785778417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EKOeCgzPYWcztlbpyGWazJMpqT0ardtdTx2QvaXnCR4=;
 b=bQDQAeQoEyfT2mVGP3WJIdzcwNOMIUmMDLymWgtY4nBUa80aViblTwZKQcC/3K3rnq
 ejb6tkdfoByksva7ymOUUX26CHBgsS9onQPZ3teVcQ1kXol/5lCTuoB3gxdqtuVMjC+u
 sMgSkWrcogEFGOrt1OrMdhVBx89hql0Lob/6fT9rSO8QdMEX+P7+ACTYslfXukOUBSMq
 Vti9bKL8a2RyQK+nITwtkq0rx5qFNqLT2vadzFk2u5/aUPSja2sCkqwAfl/HcM7VWcQ/
 /ifzZkgU67wGRVd4oXtkIQqoG1T45tr9Ge4Drbd7cXAdduE6lNDPxBHRFCxUbXuhpSrW
 IBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173617; x=1785778417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EKOeCgzPYWcztlbpyGWazJMpqT0ardtdTx2QvaXnCR4=;
 b=hNijIwfvSnC2/VHPYkcnROoUdzCoClZkZlcpIm0xij3sG1FWbpoRDkEz4lHUQHt1Ma
 VIkN7TWoJZ1SzB+zBJGKFLA1zkrRIMJt5iQG1/n0MmsZo/3FQYYpYMaS6a3v/jVI5aJ+
 Mt/vo1NqHi/mRd90tOfAr9ezMPS5Ll51kFXtEhLkdHtVZpkC1bzXDpo0N4bR9FxoqLif
 TmECgwQYA+KE6yyyOINOKcZjjCOLzD5A6YPtJuudCYqXDgQ0SIysqfsaIarx8GKU8yZ8
 12FGxn5YeWiY9ORaY7SlUNmq3NyOHqYpafM4+l702Uqm0E+XeQGsGGumw10r2sNGKtO6
 lQ+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGvBdv+a7FeZ97REIZibX7Ku5yMPnLjAEQDozS33nPo3Ovdl0Mvc7bM5wkC/UcqWuLenID3x9fW3g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/Yw+jsOZDSW1N17EiPJEVoWUHwzblZG9ncmGP2+hdbNb5A7jp
 vnjpjKg4ZpZrKPulUfIi3/ikowNaXqVk72TPuwUHEX0XF2VPaNRASVP2A4upPxCC91caWCC5Qyk
 GIw3soceFNoIaz28BWPop6VnJIyzOM343FPRs4GOWkofHGshfBdcBxPN9Ourb+JyJblPExQo6Qg
 MUfh+BHg==
X-Gm-Gg: AR+sD11BggRVepNePcZ62QDZXuVbHkYi7uk+rLjHwIvFqaYcjgfunHqFfXFu6uSBUbo
 9Tq0ms5/xyxDwX+mHSa0GEMPRkPry/APc4qAix3ZzxdjaJzo2IjYt01VKY3Ijtvn9ozzjbwvgZK
 8MOsU8X5XfGWmFsH4VbEA2dTRyAkQxIY/9I889FK+afTkE94moAO0tQgSAau7gK8+y4N8/EotB7
 lGkAWK/xsTtUQLBEEuOu7xXDYuRNyxL48GNYd58ebYO0X9CvYAI99j1ST7Ql9lfIaJX7A+AdFyg
 jtUlWUCDtHJQS5NBZRVwRsm3EaIuG01D5e7NEFkA2Q6oJaofpBwqwS1oDStAcArmcGDJpORTku6
 g1aO+Ys5sP+jgdmCAULADHYdXwMm7kBZDe68UkSOU
X-Received: by 2002:a05:622a:13cd:b0:527:2b06:2bd0 with SMTP id
 d75a77b69052e-529a872c55amr96205861cf.83.1785173617318; 
 Mon, 27 Jul 2026 10:33:37 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:527:2b06:2bd0 with SMTP id
 d75a77b69052e-529a872c55amr96205441cf.83.1785173616879; 
 Mon, 27 Jul 2026 10:33:36 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm2945391a12.15.2026.07.27.10.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:33:35 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/5] accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
Date: Mon, 27 Jul 2026 19:33:24 +0200
Message-ID: <20260727173326.2219191-4-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a679672 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=tZkrDhJDKE0PsY8Pgt4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX5H7ulzbgMcJc
 14nTMurp+kmd3TMGmlfavftc44gIg+CvEKHUMic6do9R4M/hm3RVFDlBQvCqpzGCZ6c0vcXByDc
 aSEBHjbZOAN6pzPprlrkR2bD2YUcAeA=
X-Proofpoint-ORIG-GUID: mk62VtZGdz6gRlQmoh83kD5M8wtLmbcm
X-Proofpoint-GUID: mk62VtZGdz6gRlQmoh83kD5M8wtLmbcm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfXy1MOO6smiDI0
 O4AYSnr89iMEkXg6VgLc0ayQ27ZhaEs9TjMisNyiQN07BurHL4pzXIhVN5sQvdrBQjdGVgq0xLd
 LJ7dYW2x2W6tXdB4fGDtBXcX0d7XUinq3bkYMMpHm71sNsLZP+Zxqs+6H6/oNINiDYKdcDHUVEV
 sxj8F5bWWOFYsZN4QcnteoHkdLI+mhd5hOoypoLy9MvYPZXAsNYW3hmu6HoFDxQHOkOn57tTPb5
 8KtNwwo31ZWn5bguTQmCBsjjYvoZYSupeOGkxerToYB7Y6lixAY8fupvAN57yMriqwKr1FhkVem
 nl3g87gZZPm0LJXlKYqb5Ef4PZTHFcvIZ9szzICBVzjCq8rOacxWpaRrXaYza5QJhsmxAeRRMFB
 JLxXGL7Bvu90l5KC5M+0NjN/Pg5zzWCq+ZiEQoOzZevNeIwDyIUuEyxThUGfr8EtmEg6hMeTR0b
 7ATwLsOKR/7o+Ay9dTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270162
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

qaic_debugfs.c uses mhi_device_id implicitly. Include
<linux/device-id/mhi.h>.

Fixes: 5f8df5c6def6 ("accel/qaic: Add bootlog debugfs")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/qaic_debugfs.c b/drivers/accel/qaic/qaic_debugfs.c
index 95c78e12dd61..909a4d774d90 100644
--- a/drivers/accel/qaic/qaic_debugfs.c
+++ b/drivers/accel/qaic/qaic_debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/device-id/mhi.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/mhi.h>
-- 
2.43.0

