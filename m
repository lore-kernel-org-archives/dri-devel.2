Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E826DC54FD2
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C692710ECD5;
	Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="edD/tAPX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d+8t+8VY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD6C10ECDF
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3PAq3343553
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4y99CIHhO7Z
 Ma20JkU9vG7q5Jf/ock0IskJ460LHt8I=; b=edD/tAPXdh3PRCzl2ZeF8A5Au0W
 C7hMgP09AgYNb0zhEwVFeMEcJnQ4NFBF4gW7hcexatTK8vTQdczGEObq5UOpuyK6
 Qd60texAmuRbhNoyyZ4bOpspf59jalVunlzJHibw4AZG5UHvrC2BqUq08SjUOzDt
 HRQsrXI3JtzntdUE27qTWKU59xfygrF1kAmmTsRCDPG0QattencMgCAGUpmrwTye
 sKSae6cptA6caE0OyDNVoVVA+eLIVgV5wmekTniuDpWu/DvrrIZRPw4v33g3q3Wn
 4oNyRFHNWN26PWsObj/1AEL0F4kZPZMrPRv517JG69WuKxEwofqzYOX/Tpg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ms6u8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cccfa32670so12480535ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340636; x=1785945436;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4y99CIHhO7ZMa20JkU9vG7q5Jf/ock0IskJ460LHt8I=;
 b=d+8t+8VY/HTWDWBglvw/iT43NqBEXVKyZrUjhYNQjr+nXqMXlgEeg4R1NLj5hrk5DS
 D9xu3o7TCZwCHGfk5yzMC+BAuEH/DoGVkGQI+aZhR6tnteaNaxrMRXqDSjrqBjwEBq+q
 POWhYllHC8aUEwWWEqtMzOJWITR5pLg/8JJuVp+BQh04c/d7I57N6fFG+0oUhlkWDkPR
 mYMUjQvrKiXSyrVIi4LiwjIURCGbjNBTmQrccjJ76UgOIlExZxwEGlxVuY0d24U2Q5y0
 aNySzkcr53ZchEPsBy0hXxPpLmDaoslYrQ4gfmpodTbx0mI8sB2Vv30YTA65GQ5sJ2s4
 8Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340636; x=1785945436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4y99CIHhO7ZMa20JkU9vG7q5Jf/ock0IskJ460LHt8I=;
 b=oqtiZJW8ow3fx83kflkXSSfqfmRMVL6GieYASCQRVUsyFikyJCNxtiPqTAGQ/gGzve
 LCLUyujoSL+JB5sPAeTu3N/XSMQGcBsMf3QkdFiaigQICuaGEwhdS1WurCAX2udFwUQ+
 ZzvsR8H4uBif2gFpI2mPuwFmkOkjUdgQ0hNWtjafoCf/DHyUpFH78SUd5PpkvwOw/u56
 AT39VYWdLZmbtTjRqIWMTveMyWW/KJq5ZvCmZDZWn7gc90zSQ2e4bgCTRIUMcsmCGOxV
 6mnBEUQ/S28sxVcOYQTIBn/41ZrBZI7XcIFytwNwi9KpBa0pOPt0W9oRW4Ou+2dGzIJ2
 Wfcg==
X-Gm-Message-State: AOJu0YxKDJlQQTCopBOgSn2xEmKeGqOtV6idt8PqwGNjQDU7JQ/eP+1O
 IduXVF26KUsF7IDIhN4yWrLZ/MHYBawn/aVtvE34PafzCHbqpekFOARH2B0Pkl9r7JMvS1c5UHA
 VXM5LF0zHkLGALmlnwvnxWaFXSM8ssvuXCNmdhxF1ZwxlhG8Ngxjd4czrx8dKnvAwkPSMDc7eUU
 wThF4=
X-Gm-Gg: AR+sD12kipGjVbfQdfiExXAJH26hpOWUgzxVpPqS0imhnR9Bc2ZgeVSOjlI2nZhuvqy
 OejDtC4sNA9X35DRKF3s+pn3GakdGBCPPGGG2kSKq0SDcCRvHYHettbV6g+IMlJ+HlEVjtinGvq
 5Z24yr9mK8HqrqQoVHgD5NBgaFIzuXvy5QdPyudvmT0TkPGQ35XkdpORTwEYLB432YQ+pgejX+f
 UTLDUI1V/Qp0OJG8aVrZEVW9hLcvYnALOSMa749GuvBTXclHSjsMDGmERJMvxGPk5SGuvPaAWz2
 qnBlhDPRAsOljjOG1b8nrJQP5/udYdSgvhF13B0dtivIKQySBWRlf99eh8xZqydqn+v90k0qIDf
 m64gKiREpBstRTBlpIJxvnI7tPK2kv0Xnf2jZCPe6tqsOvN0=
X-Received: by 2002:a17:903:38c3:b0:2cf:b330:e0e8 with SMTP id
 d9443c01a7336-2d015affaf4mr86146485ad.10.1785340636242; 
 Wed, 29 Jul 2026 08:57:16 -0700 (PDT)
X-Received: by 2002:a17:903:38c3:b0:2cf:b330:e0e8 with SMTP id
 d9443c01a7336-2d015affaf4mr86146245ad.10.1785340635839; 
 Wed, 29 Jul 2026 08:57:15 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a15303sm13735525ad.3.2026.07.29.08.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:15 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 15/17] drm/msm: Don't fallback to shared VM for VM_BIND
Date: Wed, 29 Jul 2026 08:55:52 -0700
Message-ID: <20260729155609.20190-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX7Tujn4ipTQgA
 t+RTkqbNH5wI0lYjLH9lyqAv7gF0mrY1pKLmn7N/2UpAZ9F4XalSnbwITYen+7ALsWx0omHSkSJ
 yC8lPLFyQqUi9gYqKD6QyGUE8HDN6xx8cqP5miwXRV2/byJ+YyEu2XYw0SdgKqDjuly1PtF4xLr
 epvUp1bl7OMnjG59Lwzp/M1xKH84W9ZVRM+CbboJQWpUf92eZaHSWN0jhRHnKd9cYLZLo5tjOac
 Qm+XqA1OqW0052GvsJOffcWs4magWFibxc/uruq5G75HMqB1msvD+bjIrag5VFPzIkr/DlW70O3
 3Wap4JlUPs9lu90LcwPyZU0j+BJMzv9HcUQFLHjOqPWORvpc/UP/i3F3cweu0oUHbv5c3KEN3l0
 bHxP4EC2lZU85ikv3eXPLa/ygY9/wzs5OKAi540TUoOzjeTh++z+C2OWyazVNnPeIm8WjdM1rni
 GugHYnnhsmxAsdzxD/w==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a22dc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gtOrA9wvsjkmbczvg-32KgweFXKFiXt1
X-Proofpoint-ORIG-GUID: gtOrA9wvsjkmbczvg-32KgweFXKFiXt1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX24fXVPussWPX
 QqwgdxEbYLiuFRy3VM+d6/jUYYkvDUyNcnVq2efN6U6dorWcMu2wQ7yfFb8zQXSORyUpgbrnEkR
 YpuHHlSyxm9jK+m76oQp+5PKXBiRBRk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
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

If the user wants a userspace managed VM (EN_VM_BIND) don't silently
fall back to shared VM.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ++-
 drivers/gpu/drm/msm/msm_gpu.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 52ff72d8e17a..73d99bde26f1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -234,7 +234,8 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 	if (!ctx->vm) {
 		vm = msm_gpu_create_private_vm(
 			priv->gpu, current, !ctx->userspace_managed_vm);
-		smp_store_release(&ctx->vm, vm);
+		if (!IS_ERR_OR_NULL(vm))
+			smp_store_release(&ctx->vm, vm);
 	}
 
 	return ctx->vm;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18ed00e5f143..a1c4adcac128 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -875,7 +875,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
 			to_msm_vm(vm)->pid = get_pid(task_pid(task));
 	}
 
-	if (IS_ERR_OR_NULL(vm))
+	if (IS_ERR_OR_NULL(vm) && kernel_managed)
 		vm = drm_gpuvm_get(gpu->vm);
 
 	return vm;
-- 
2.55.0

