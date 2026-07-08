Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931E2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BAC10E117;
	Wed,  8 Jul 2026 17:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGh5PJqY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BwLR7mJT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B436F10F1DF
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLNOQ3337440
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jO+ZQEMTAut
 fU7hx9qwLY9HF5Xgg9vMbG+XmEcF/E20=; b=RGh5PJqY0fPWIzSS7aHw7yBNWx2
 KKAQNxvzc9bKgQp7jj8Gu4K4mkBll4qgEg7aN9dQcubR4UvyUvnXKVuDwW/ESqMG
 O2fpFdg4zh0HmD/S/2Pcr2nnC0YdnG5ZS8HoDTMmkX8kqRdpovUkp99NcS0RmqeI
 pceqwJILItb98ZuZg9dzPDZABW7rhwhq95vPGdVaWkx/G0U6hXccldTouuJCM29w
 L9F96MjjAFWWGQGHUSefZqlIlhIfESDgDfKaPa2dFjtudpmn/e02mtcrFvaqBLZ6
 PtRSlWUijYdnnvC+iiQM2VDhEfFdIMsQc6PNCNJuy/fZuZOwsBiPVWDnkRA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssurpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso506315ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532080; x=1784136880;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jO+ZQEMTAutfU7hx9qwLY9HF5Xgg9vMbG+XmEcF/E20=;
 b=BwLR7mJTQY867MRhAsq2tm0CwTmnCWuXG8enMbBUOgnK/pgDXkdyPhDHZTEtW9q/FZ
 Sxu5sUFuEOxR+mu9xx8aOfeya1hyTVBvPVqWZ42x8G7xcqYHXQZwqrT6chsKw7ehov8A
 VE2qyv7DjzMbsafgVveC8A9uM3fHElUbv0Lca/mqEgCkX09OeHKweI2cQKU94z92QdI0
 PoRurU5kEWE8QFH9CdIEFVX1pkWivoY4lwBo5a4CAamgxnwhDkL8NswonS4yO1phIDOk
 HPsw+4DFc59+Je+8Nti3DNWLZ4iatsOKt+0NdJ8RHDvAGQ3H/Ztj0hfOVb4nrUsVFa3A
 rwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532080; x=1784136880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jO+ZQEMTAutfU7hx9qwLY9HF5Xgg9vMbG+XmEcF/E20=;
 b=OgeTc8whTWlul8IqNBCz0yDf9rpmrr/0v8fHRyk4SYJkRs62D0cTVuNjCBmNq98mru
 Qx48hI7zMs8qgmpaxSBrvX/uJZkQwqQDi+y2ewqbouX2qyQn1cJiVzNF6zzTWwjxu4qJ
 xv8M8eGFwfNGYb+TW6luLgnbtETu1LQcDAyj4QS6hbDxtaNs0LpJFzoa4a7VslUig79p
 m1B16MC+TZhihN3hRNMVUktFrq35OUpQ5//FP0Tt6F3CSAaI9rkTeXy1MHX7wp8KpIRd
 kxcB6zN2KXLADq+rEuL3zItA7PQGBUYASBck4+WALM3BtW6ERp+wyQyhBAaIFI3nz4n9
 AVhA==
X-Gm-Message-State: AOJu0Yx9+8hoquV/P+dij+yGEKC83Kc+6g34CsFsnwLnE5uQU5vMuMhf
 zxjWvjI0myE8D5/PkOLbewSVjRZCUdb0Se97t+9MZSEARZp4Uej1klxv7ZIFnNtyyDKhos1f5vW
 mQgS6S4ModUpI91zs1LXWZIAswqw7GoVw5dyT5mosL/0in5Lal5zalRE4tW8Zy6LKJZgG+NuEsd
 5hCRQ=
X-Gm-Gg: AfdE7cmO4l9GMjHiQwEBG5xHUJxxYgtaEmJqwZGjshhOehetS/YGvxEmoceIkj44fd9
 RuYzluY8A2rUG/gUpUY4nFtB9cRVIqZMd0RtyzxNlVmHptIU+tHsWivydRlrFg4UNOCr/kyGGWF
 yPZc1WYtBUzD8NIg0GUqjmPmPPZ5AgSJFPngofusv0/UnvJHrJCkRwmTdD1FRfQNpLyNFNozk7I
 N6GhsBCY9QAIHAJbdoCBMd02/36VKZYC0tkK3QDJm3mRlFg1nO5fybMj24xazKLCdr/7UoRWTCT
 fjyYZJfbaRXWKwr2YHbSoWsFoLvBiskzuST+oq/+vGXKbycChMr4b+aWM7UaYnmY44eZ3CUkDIV
 Url2hnzXHTrtUFogCkQIyE6fb9ogiRlmbLYUN1JN3SfFVZxoy89QY0BvSZg==
X-Received: by 2002:a17:90b:1c0f:b0:381:18c3:1b99 with SMTP id
 98e67ed59e1d1-38941205917mr4211068a91.23.1783532079720; 
 Wed, 08 Jul 2026 10:34:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1c0f:b0:381:18c3:1b99 with SMTP id
 98e67ed59e1d1-38941205917mr4211039a91.23.1783532079282; 
 Wed, 08 Jul 2026 10:34:39 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38903295585sm938106a91.2.2026.07.08.10.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:38 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] drm/msm: Remove invalid overflow check
Date: Wed,  8 Jul 2026 10:33:54 -0700
Message-ID: <20260708173356.578713-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e8a30 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0g9OVxrcTuodNeR8YWUA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX7ojjV49nHnVa
 gMAUCt3CRb+B5MPXG1o37NIIDRpNU10WfzRr0GaKHiEM0ZD0upuisp0syTHTjoX/bvYIiI5DoK3
 h033bMPWuJpK8lveRCb7JlEpRjqkkEogowR9CHSokqBjdnEA7omYJCpX26FoaWKv+2MoPxCviAO
 5RkU33+vr9vZ9M52LXSh+vscEKrSFdMTFNgYMJ2+NAZYHwxvCvf9a0AQ18BM7ekDK2ixcYS9bcT
 2xshoKqIewOI4FlsfgzrHPSga1K/n5rLK0yJcXSoh5tA3Qpglb4pAwTxOVWO2uWdNDJOf1I+xcE
 CcX6iNuGiyQVum8/uVECSYGkjHi4JIibrCEQSuhmkTdO49zjPc8PT+jECTx4viBjf8FnHW2CjYC
 F9HhKBGUcQrWnpuM9C2pefiJ6xYqLEMD0XneSVVFQ/gWxSxpjVwE6iR9GN4SnCi4+rAXFma4nAp
 LIhA9qNKGtmYyvNOOCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX4HbxbOdNw6aP
 DJcGt5qpXSx6rNLgcu3JtiDY/nIHwogwveWkLsqebbUHWCF0Ej+dA7JADYqf6K43D4Lrm4UfyPo
 jQJCUNKlM9w+kpPI6/4tEUw3vA6Y/pQ=
X-Proofpoint-GUID: _cgDlupgeYeIyXXdsRLXZZLrF9Fu7dPU
X-Proofpoint-ORIG-GUID: _cgDlupgeYeIyXXdsRLXZZLrF9Fu7dPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080172
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

On overflow struct_size() would return SIZE_MAX.  But kzalloc() (and
friends) check this already, so we can just remove the check.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 56929e821200..3113faedd04c 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -36,15 +36,11 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 {
 	static atomic_t ident = ATOMIC_INIT(0);
 	struct msm_gem_submit *submit;
-	uint64_t sz;
+	size_t sz;
 	int ret;
 
 	sz = struct_size(submit, bos, nr_bos) +
 			((u64)nr_cmds * sizeof(submit->cmd[0]));
-
-	if (sz > SIZE_MAX)
-		return ERR_PTR(-ENOMEM);
-
 	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 	if (!submit)
 		return ERR_PTR(-ENOMEM);
-- 
2.55.0

