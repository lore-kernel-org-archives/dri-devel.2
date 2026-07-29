Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14F2C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1116910ECC9;
	Wed, 29 Jul 2026 15:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K24YfTFI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwd90IPk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED9310ECBE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3eQB2412606
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5Uxk/s1mozQ
 uhwk+cHuG2u1j538IneDvUnNY45Gdb+E=; b=K24YfTFI+CLqhUK1gVVXSJFSSPH
 x13wMrLdC5xvYp26gD36kRWGFdhbiw3sWvctLYNDk3JLMWB+Cx2XAvOwWRfvXmU1
 1jiDqIS5G5T7dEsvS7wj95JPnmh4xzn+fZ/DJu52y5WWfMzUD3tI34IUXKpWgXo7
 UoDHZHILcY9hwH62wZHtRF4wkcaQH8VaTTeIMVc/9U20As8NHF8Xv6G2UMcNa+CI
 z/Bgvb3ab9xv400jGzQffY3XLqO3SB5BTOU8rzKLnl2A8eFp4lFp3aWLyQJQKXqG
 B0Mo4NR/v+NXWbOxmifkfDtwxoQVAokczisv8uRwcqkWNuLTS76olq1tRRw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3gh6xu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so1302046b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340613; x=1785945413;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Uxk/s1mozQuhwk+cHuG2u1j538IneDvUnNY45Gdb+E=;
 b=kwd90IPkjccPdMEAevcgPRWt2+aQ0nW8Rh1gBXRHKb+FUNzeiCbowef4HRbut6fOTz
 ZqLhrghYZL1VJprbnH8m5kA/G+64rLdpFuofqa2W8t5B5Vo+ZcLx1XuJYwCeFDKlRo93
 dBBRJolrNpXmodQ1DQWKA9D5WBnb78rFt1ykS+5qIZxe0b90dskj83j88xIgLdGFinlw
 CV97l5ovCdXLlnmxfoSzJSnjTWoAAVjOEnfoXC4n0D+toTN0Yg1eTnchUA25YI+MVWTf
 5gjLsvmRZiF5QZb2iIw2AkGUbpH7FEice848Sj3Lbho/H2W2lSVmZBRXrUJnBkcKCY3K
 FNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340613; x=1785945413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Uxk/s1mozQuhwk+cHuG2u1j538IneDvUnNY45Gdb+E=;
 b=M2wkMefJkwKZHPZOWpTY4XEE/AJzPIqwOJIW2Ob9iSJKXDkDl0+WR6LSLpC0a8QOOP
 FrCTJC0UXCAaH1WVE1IxiBvBYjpkkw4x/4iAk+dCmVglggJ6Co10YOnjTkUuxj5QnzPt
 Kuei8opmwRC/LkLlz8pQT+PTojeUjE7omIDDOzZE6F/8v3ao55QPCQH7UPAv3sra/MX+
 wJwrpOyeiiiPUxseOXiOFAgj+zR1lN0m26Sa8TzfYF8IZduXrjyuaN3nt2UfjB76UyIj
 JGpl+f2bz1TnU8bllkdFD65nqEGHZcCZFQCPblj+xxdKlopucCM8eOjnq+o/ZsaVV/nW
 MA4Q==
X-Gm-Message-State: AOJu0YxUVBX+cC4DLADI9eSKVBp1BFgrCA2+EF0ouxIsYh5kKIXNThwf
 1ztb2LNtwQfQe40qfN5QSG8px22+cR+K9AVKQrgYFplHgp3MbjYLM6EYt1s38TAn0yH1B7k2eoE
 Hb0N3LK2tV8wPU9qx9ZRlsqWviaOTDAfODFabhQcCSutwNAHs498LEYRH7TOxnKYFRZBvodjhv9
 LTi1c=
X-Gm-Gg: AR+sD107190flp7yxqCQK8yNDVy52ZVhmIlslpFTznQj2D81Iszz+KU/kHBgTtedRwP
 PDKjTKIhxwaac65fb4LnikhgK2HopW/sYUwycNMA0KguPFBI2eoZiiz776d8VYtnGIAg6m6B6NM
 1O5ag1L46W02RO5uvn3CppDs1UYbeLMB4Ssz6kW4ltnbTy47PaF/shXxQJgFRPRZk7yNroOuVJ+
 RtgBy5s6gp5WruXKexG7l3pkl4tBGe2oSKxe93Otwu0tJe1qlkiS+O9z9PjU6OvtDg5CutoKUdb
 J23vLDSOpzTjEphYOxTIHEGhe3wEp8SMmfQTR3NZY3NZcgaX/zgeyJHIq2Upw657+mP8SAbtvcl
 KcYcHpOwiQZjPhQjWy9lhqHPkMD9dCWyYz7Ue675PSo6H8Gw=
X-Received: by 2002:a05:6a00:2308:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-84e932ca8d4mr7961120b3a.7.1785340612790; 
 Wed, 29 Jul 2026 08:56:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:2308:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-84e932ca8d4mr7961099b3a.7.1785340612342; 
 Wed, 29 Jul 2026 08:56:52 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea0301b3csm1604311b3a.34.2026.07.29.08.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:56:51 -0700 (PDT)
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
Subject: [PATCH v7 01/17] drm/msm: Fix barriers accessing ctx vm
Date: Wed, 29 Jul 2026 08:55:38 -0700
Message-ID: <20260729155609.20190-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX58ntPwfej3pd
 yFW0zOEWGQ66IqZ84JqCByizPlGwEtRYStjfJOr9sBCkARmFaf673QJwpeXNNRok9CBGfYA6kms
 rMn9M10ugSno8c56hzXa5p9Q+c3M9DZ116cSw7EqGfCsdHdktMkmZWeMn/i6fCXsRo8AG3k6kO0
 JRXKdVGy32x8Yh6HXZllKD0hVQhMmPcr0bTsLLoZf7/M6f5L4rzo3SI4PSr6SojivRX6/Frmmh4
 nVzwszeYPWm1V+ZAX673A0kiTdVIlxhJRKhR8CaE6y+0rovN7/vKkRrdHw/JVi3/+GzVadd9Fh7
 sa5Sv7jK7cAe8FKZI/wT2A0MSpI33Z5UfgZq+zpaRG36eLRrGcbNLs6k+ncAHE4mzOKc7N7tekw
 MUhYyptGlEhTjG2kFLCBdY+jDfKM5Ak832dOYLxu6o8gwlnhDVaC4jCA1f4kQqYG9hiDrFEWOOt
 mSU1XeKkdsZHEv401Nw==
X-Proofpoint-ORIG-GUID: LqiB9ZbjcQeOyQ4Omt30yJ68UtPvcznK
X-Authority-Analysis: v=2.4 cv=EOw2FVZC c=1 sm=1 tr=0 ts=6a6a22c5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PXeb_Y4BrUyLDKu8J0IA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: LqiB9ZbjcQeOyQ4Omt30yJ68UtPvcznK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX3UoCNf9vS8Qi
 vjBns35lZ3FWPL6dyDwWTfAnWtZrPoej55yGPFHWVlfLl0D4gMGVOHLWXkLak2oOpG/R+1h1B3b
 Cx1ZgIGLIYWlo1FZuSerB3F0ljk7yw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

