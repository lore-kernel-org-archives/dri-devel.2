Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F486C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F8B10F3DA;
	Thu, 16 Jul 2026 20:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jUdnP2LP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0CJkphU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FB610E3C6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoPU13753254
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+pCiq/Qy0Lo
 ydinUbSokabUuk5OYFJlIyBFzOoKUkG4=; b=jUdnP2LP1nJy0NY7V2mjhocw1N+
 IvWULgS3auzaJf7W3Jg6GH5SxYlMv4rN1YMapHvnbQYLtKhAMfr7T3govXuhoBu4
 fl0sBEl5bWHYkP//iiwsAUGlcgWcUIaBG6MQccx6ng06DLzK7BIX/B3aCXiyqh44
 k8RiGViI6QjYoQtJKmYlXZY653C/2BY61ega2lUzfuUcQztqXgBZUR5QDEyHQC3U
 DTj0AkyAQahs0ZYr2avxnKVyn3NBTsUGwkw5wjPj6r4yLNY+L6HLooXUDzyNIq7a
 GRRMrI5jGpIyLnyn6wi9yJQiPgj6tJ1mNa7pvL3UoKTxb5d9+vIXRSBWTXA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex35pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so142908305ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232962; x=1784837762;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+pCiq/Qy0LoydinUbSokabUuk5OYFJlIyBFzOoKUkG4=;
 b=h0CJkphUcgCN73iMG59u3Oz0w0I4iiEQ/lwv3ikLgdva4HlJWInpkaj/trYJwwi42K
 C5xn6ah1t7bernaGsIj+zmuvXan6Q3689VRBb+WpysKNIvIMDcl/StsBmLdkIDSft193
 /3yKnL+RZiHCOEeoxKhO71AiW7uCj6Ue2MZcAylUdmTazrHCrvQn1+yJUEey4SrwFLgz
 TPB8K6yYsjbeE0tppPnGYWFcmV0Wt9+f0E2onKEgbGzrYqf0/ijlUDxQtpSVy90jDDq1
 nCcDpaiJFYyUwG/uArKDVycaZgqlqWEc+g9NY5kw5DeGW5S16fri/325wBn88bdLfWKz
 mVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232962; x=1784837762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+pCiq/Qy0LoydinUbSokabUuk5OYFJlIyBFzOoKUkG4=;
 b=SYORledmdnP3HZ4xeNEIXA2631/CmOFHcT1RT4NmMZFWPYFDjPH6OcwJqIR1tABm5/
 9VVq9hQXXAScjESrOr+Lyg200jpgcBXUs/B6ckofORL5FR393SO5/GxnAG1hUTEeLqkg
 3j+aSg0jK0SEAD0ULpzCuD/M1lzc3uvGaBYUJuACNwMkmvtCrL/0EcDKl5dOVknnDUQ1
 ljHAPk71kUZN4Z2jq+zVAFvlQYcMwKBkbMh664iDl05R4Pd7tlQSleZ3B1t3sxX4NYbs
 Orjy6IdnHOt3GwDENFYZ6kn5Pz3GwdM0swa6h8PaUJA8cBltjfnw2ynbss0KYBHVvUcN
 X1rw==
X-Gm-Message-State: AOJu0Yw9hPsjVSx4puCD8l7GFA0bVfbbStf6rnzVNt+JR+O5OG6v0WQX
 6R2fh5ea9ldtAUQUP8uj1BiYAD3o8EJTKlCJV5s6Y7Vj2NjiOmh0sQFauhYjdWktOj6WypnKyIs
 rYcxE8+ublJkGZNBao8Q2ZwiTqNq/hM+hDiRJhKTDejOvqUs0WHoFbKgkGg6bGTuro59o84dD4I
 GIM08=
X-Gm-Gg: AfdE7clEC7rUokEpLnCzNtDwMiP0UjybQiZv9yVAJ2huxtD2w5T4+1hdS44iw6J4omY
 kcVDS/pFTj2iFYcdLy/fYGqhVc6Zwr5sRKI3GwlTn0YM6UkNgAcLsz9d71Gty07hcXRET0eZZ+7
 9p2Jx3FGeknHn+z0+flVIsYKEHMP4ZP4Hh3PByPv5EfNYnFhUrw9+K+He72LQ27pttJB537Ceip
 QFwEx4eR3/BA1LOJnn2Nr0/0Xm8x0IgiFrM08ppWOGEAMsIFAisLorsHMEO9JFjCN1wEei7VjWt
 RF2emwvxZVYtyeDqflJSr+po9qspLWFZJFcWNNM7AzO1wMZx/lo5gDyr3nf+5ETEEP7Yb+NYrvR
 uR//H8ZY7e5++xrPWypz9pHE34P1fQmU1Bk19Mm4a+zvIr/M=
X-Received: by 2002:a17:903:2ec5:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2cf03cef19amr92452565ad.21.1784232962528; 
 Thu, 16 Jul 2026 13:16:02 -0700 (PDT)
X-Received: by 2002:a17:903:2ec5:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2cf03cef19amr92452135ad.21.1784232961998; 
 Thu, 16 Jul 2026 13:16:01 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf105b244asm25206495ad.61.2026.07.16.13.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:16:01 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 09/10] drm/msm: Fix per-process-pgtables check
Date: Thu, 16 Jul 2026 13:15:32 -0700
Message-ID: <20260716201538.365824-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a593c03 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vtH2vi951kckHO5NeAIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: NR6Ic4KhEXCUTGFuTaZZ2bEa3TEVzK-A
X-Proofpoint-GUID: NR6Ic4KhEXCUTGFuTaZZ2bEa3TEVzK-A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXwyIDKcMFG3xU
 SPrCfwei7IpC2A37RmGY8ClX+xs0tFbGjcoNhXktKnu8U9KpI4dnnBrkDNu/pVKU2Rdh+vg0dj3
 7djmNhog4ExOw3xmCGtbWQ/pQBV9U0s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX4df+9zwbWu6u
 31OR3nimei5m/eW718UrA6PcM0Zx0UIbIV0zDalratPEWZvnE++2hYgoXhWyaua+B5VGDJgaRcj
 MyCHr/8HdDkN8oohkv9VkK5Jes04B9VRb5RV9I0Z8bCSln3AR1ib91z3gy1gv0Dhev3HsItDoN+
 3/w0eH6g+fiA3Tg5jh/lq1ApL2BeLfsZdrG85p6SfMwre4dL2NHyOUN+VyBVR4frQsqx/wvi+E2
 +dpU0TYF4wprAAn5+5Lc4E7ebJqiKXT67q2+lLl3Kpd9kwKf06aYsOrTjZXrCS0SFfQwJ5vebxb
 N/xhx59NM6CAw9F3PYJxWqZX7mCUHXNWLgB4ik61zvXvm32RBYN6dIjoD4jHqjCDBkITKk6cCFT
 SmsdwbolNj9R0EA8FcPPYYdA+X01PeIfmWSHDTf+M8kCx6fTfIF33o58TDVP9z2nL8jlFHbyswg
 RjgSZ6HwPVJmz2ujmBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160206
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

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support.

Instead just check if create_private_vm() is supported.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 84101e534ebe..3370cd44382f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -513,7 +513,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		guard(rwsem_read)(&ctx->ctxlock);
 
 		/* We can only support VM_BIND with per-process pgtables: */
-		if (ctx->vm == gpu->vm)
+		if (!gpu->funcs->create_private_vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 
 		/*
-- 
2.55.0

