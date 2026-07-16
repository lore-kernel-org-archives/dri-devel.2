Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6408C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0880510F3BA;
	Thu, 16 Jul 2026 20:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="in4g1Utl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bd4Qb4UZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300C110E3C6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJohIf3627037
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YHzHGsRPIUG
 VAMOUo6qKw+18SGmm5iq6ipy2Wi/zZYE=; b=in4g1Utl1ieeFIZ6MecIVVSwUK8
 gfIFKI4yMv1i5RUM9+X6TYJpJEyMsyaLs3NGs+56Is7/rSLJagPtt46OD4qm9nT8
 h1n4xzcHMTq5IjUvXcMEkfabwKezxg6HWnez5fVMCpQRHy82hrdiKApKMWMRPIi3
 dHge/835nYJGZyV4bDa0+CUOr556zvXfhRxhN79bFzzE5u4Ybtf701auGVvhZ7vL
 eYleISm8plKVbCMjAQzEXUds4CEnIeAiPfxJ4Poj1L6O9HTfZxyjYEGW9eS9ar75
 tUwpQXcC7h7EmVBJYRkQRvqfBUCHDxYcrEdcpCZWKIElTRYtafDVdlXYYaA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv2ue7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so135007075ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232949; x=1784837749;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YHzHGsRPIUGVAMOUo6qKw+18SGmm5iq6ipy2Wi/zZYE=;
 b=bd4Qb4UZR2i0+HDoLBwU6qpZvGYzknsPMvt56slajEg+w4ChW4DX9QSO0bnBEUzQlj
 YWu26/dB5Fe3uC9hpXaPqNRNJXHl85DDvqyPVSYurtDbPwjYiPYL6rmK8qb6EkEdqCMQ
 XPgolkST9SKCzXm1axMtMIy67oGGZZhV7Ypldg35gfAzKOY9jYxQNKsCVrOSfjEe1r88
 vRQgMwhhbbOX+tWIYR62CEyECiEeI7kSjEFAYpPNr5Y36hxebL4sck7B+KldPM2aWaFL
 lZApL9dX/iQfxV+plKEgwyWn8RhP0CLGTAHw9+7PDolNjFPMxH4PuGZo/gUzyb94/Y+z
 4Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232949; x=1784837749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YHzHGsRPIUGVAMOUo6qKw+18SGmm5iq6ipy2Wi/zZYE=;
 b=HMWKnwqtyfSsR2W2yfPCOt65Aa/V3Y0SCPdNqKavb+QeiF4wRujlLzy6DysbBt6whe
 BkVGjEvmxPoX67a3KPh1OCaexSH5CDydVnZiyzlmAIt9lR7mZeRx9JanaBiLRSpnknyg
 b5fk9iCPfnK9z+cBVEz2rpeAqk4HLqztJ3yREvCo4Tuk6QqJIjg+mCwvR+V7wGLs8z9S
 Wo5d1w1KYQ8DQHeMjaOpEenn/DIZo8NGH6bkK6pCkefwgJqs1qC3EGAMtxf/LUaxEh53
 RqBlsIcVaq0UMaEibi724b6wNbsZ7OPOa2tSkRLIO9NrJkafoe5jV6c6Cr2vs0mVPZkj
 J/Ag==
X-Gm-Message-State: AOJu0YyMp427LJjBXLOCFazf7ipkIRWwCKYh10j9tRq1dzWuVq66u+c6
 zltM2le+WuFylL0ke1l3eLlUXdZI/rxDfo7ZVzR0sNM5JiHBACBTDyxUOTMEqbAO2l/zl9Sookh
 Cava02OYWjbHGsfsPqZ0aFhIEJiWLOghNDGXRsEjOfglPWowEjrvc1pH1bglDR4hOwf1QvyyS9a
 N5fyA=
X-Gm-Gg: AfdE7cn1Hi2kxBibYRuWtZOwEObStGmnckU+uCf8uJz9BtqtKcbAA19JaP+1iPTOsnp
 HcA18LnzE7oas/vduUy5FmJOO3C9ug1SiZ009Pi483tsxXE9RTNxtmwlweNjNFAprbnnCoyX2Ec
 tcCF47zlepDp9lNSEqTCcd36zxXqOrLzrYleSpsZWhjK03zztBgmV2nrUQr7RuL5H8aE7rNTcVS
 +vdR/jU6zfjzbJe+XmAeI/yOJoAuTtVx8DDGR28O7oxUxQJ58SZH7OvQaE2XEZvyWtNPH3dhWma
 aRiTcqwtUmCE4XSmDKN6P5vXq0H8p5lyOoG7RhneEry9uOvLiMHZiT/VTbo/CFSiHqes8BEY4xb
 jJVOzbKMlGaAgrBGibsd7Mn4yt2ZuVmyOyfcFabhqTqZD+pc=
X-Received: by 2002:a17:902:f64d:b0:2ca:5d24:720b with SMTP id
 d9443c01a7336-2cee9b82e93mr139874125ad.39.1784232948857; 
 Thu, 16 Jul 2026 13:15:48 -0700 (PDT)
X-Received: by 2002:a17:902:f64d:b0:2ca:5d24:720b with SMTP id
 d9443c01a7336-2cee9b82e93mr139873795ad.39.1784232948438; 
 Thu, 16 Jul 2026 13:15:48 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10120539sm25289885ad.19.2026.07.16.13.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:47 -0700 (PDT)
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
Subject: [PATCH v5 01/10] drm/msm: Fix barriers accessing ctx vm
Date: Thu, 16 Jul 2026 13:15:24 -0700
Message-ID: <20260716201538.365824-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXx6cSsqvuDWji
 IYNMSiK8AEianFnzdesDKEoGW+vt6CMdfKvw55ytsy8b12iR/g7p0ihHNmxkXbfm8V6QhUXemjj
 GDEKpISsMcZDjGYolsIE0tZLVavay1FJvKIMv+YYJLguu983DkKKH6LQYDylR/TRa3k8ZpQzE9E
 h9tNDy2Lh3Cb2O6BRQoXFJWg0Yk3kSZ9K5/y+bBqMyg4OctSqig+CGXKrZUTUbIIAEJemUky4V4
 swvrv0yc+a+eksnHOJmcBPiF9u6K8wHidAaYPorDxvdLfHoX7c1kanfGXv6enQCD9CY4cp0Cu3G
 3OTkSO9HPxra+1i7Z83izW2aolwfbtC5Tgxh+j/xwbMFDKLcF2B331IHjhFb2lvMRURwu3wB8Rb
 YJ6iF/74FZ/z5GddnW3EIBx2aQOsG2kUBArDmiWkcvtRaI6yPxNaqn0as2VSgArsEYoojDJ1wg1
 Rj/Cv6xnE/fMr3Nzt3Q==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a593bf5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PXeb_Y4BrUyLDKu8J0IA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: EV6mStBGQ4cjQ6ULn4PU4RnS16yQcKWB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX+ww8Txsvhogy
 0YPC9aVEog3Q89HvGzVlKbioExM6QjX7cc0EVarFRdt56zphYJhSbeeZZ6wZba6EQsFpx1tAPQP
 nq1f7Il4hVLWRD2Tp4W37hsK8lD7r60=
X-Proofpoint-ORIG-GUID: EV6mStBGQ4cjQ6ULn4PU4RnS16yQcKWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
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

Don't rely on store ordering to protect us from caller seeing a
partially initialized vm.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 32d5ebea2596..ec88155e0ed7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -224,18 +224,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 {
 	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_gpuvm *vm = smp_load_acquire(&ctx->vm);
 
 	/* Once ctx->vm is created it is valid for the lifetime of the context: */
-	if (ctx->vm)
-		return ctx->vm;
+	if (vm)
+		return vm;
+
+	guard(mutex)(&init_lock);
 
-	mutex_lock(&init_lock);
 	if (!ctx->vm) {
-		ctx->vm = msm_gpu_create_private_vm(
+		vm = msm_gpu_create_private_vm(
 			priv->gpu, current, !ctx->userspace_managed_vm);
-
+		smp_store_release(&ctx->vm, vm);
 	}
-	mutex_unlock(&init_lock);
 
 	return ctx->vm;
 }
-- 
2.55.0

