Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824C8C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE90210F3CA;
	Thu, 16 Jul 2026 20:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwvSF+AQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ic+ZmQ4e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D470F10F3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJqPcF3853508
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6DIg0hlu8qf
 HUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=; b=RwvSF+AQrKvSjJMlwzuq0TyzPaC
 fLAEpCdxm5RjFcXJOC49mgFKwn4mKpg9ya0CAyaLVvxHGwJpMFhr/mCSdCwOk/iZ
 k0Kz99/5S35bWorzqoAKq7cz8HZCZ/eL3E5amrXxGGsnNWSIIv11hVq9V4J0mKki
 NXBx/ajdOCryOyU6XwzKvh0sFx5DCzvLzaBLt/YUzRHjn/BalAYdqC5j3xRU+tlN
 QbTB3mIikMdwZ44xPubvA8vWBFyOvZnlHBEfzBfjyFagbZDx3915p4G3Vg3b3rNk
 tgGIToqrhP2RqVu9fDMGrpNQyrhkZhEToOLddD76P+5q0Uhvc2oejKDbBsw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19y0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso49958465ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232956; x=1784837756;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DIg0hlu8qfHUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=;
 b=ic+ZmQ4eQW67Azb5NYfuyTE+dJ60niqkWutgLXtjySyqR5q6lzD9QLXklRraGrY5j+
 SFPsZXRvookZeTRVxhSlzFsDUcOzQVT0Emv5RI7wGhW8fMRip1ZelJeSHi4JTrYzVNNr
 CoXeTCCdZNCVn+jK/BvoWBqRDeRVmrkhI32HCR0jr/zpG0xBu51czIUhnUPPpMh7yeOQ
 YstoBh3s8C14jBNsXGdw0BBDyBadOIJKiT7O+eZ/MDAzclkTo6VOU/yQHv0WJ/v8sofe
 P9VR41UqTTo+CqZmQd9r6mIftofHlI1crXGSBKWb6/xpRluHtwEWY0gUlG8ia2hz9raw
 lD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232956; x=1784837756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DIg0hlu8qfHUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=;
 b=GsHz8fAXLbNp5teY6g0WxEnNAdhf6PtW5mTx9EqbFud/0Zuir13lUUBhM+iwBmHGtl
 6tAOWVxglJeyQuH5oELbmPRqIfvkDvhU/M6Pm7mlHDxZ12F7Md677ToRUb5W7Nqi7e1r
 Trinp1mSEU5ZiCdBbdZmCBaFpJ+LloIytfd56HVQv230r26MqYy9mn4p7vxZhofC13fM
 Dud9w45UD8rPT0/uUUCB+MkH1k2PHeTHuqVmWuFGmDebE8RknRkwmQfy3ouaLmyjx0Gg
 2IxU92N5BasmDBymi0WEZyqUqfyxvq6t94BC0WQZuomQYp/ycWJLVf9qJJh76fcTSPro
 KYTA==
X-Gm-Message-State: AOJu0YxFvIyqG0okFEjPYxgoMmhTMC/KSz0r+6O0EzEdk3UtH/y7wj05
 UsbsEDPOdI57vJtUPxB3tUJwvjMXwHU4xEZYAUbo0trFMtI09Dpljgh10Gwjc/uO/I0ZL5Q7zIe
 Qb0ZRkVJQVCjBNvLlzvyymCjw3wEivof4PCIXPc1GPkEOm1HCtgMIPEJW5RPljoe0sADS7jj3bA
 Cg1/A=
X-Gm-Gg: AfdE7ckWibUwo//cbDyOxGLBhkt9JZcg+rHr58lw5/BmeazlcSA/29QtKTsYZBuxH7U
 ozhuhS08zrvuCQ3ApRkiGV6j5sKTunmGD8cF4bl0XfjBL5s2h7iQVk2weAuiRfIvsQV4SQZOMSl
 yymdTvtIRf69wYJCtVjXPh49dB4gjQeQOCShWu+YsR8ENzrn0C6wOAw4HhkEvH+XlnZAEaEbXVN
 JrHpQO8q9FDCm+RIptTdCQdbd0PTz9aQGl2xS3Q0XGwa1ZLnEFtVuaYv/SsZXp14tTHonQpmfg6
 HF4bQauDUfc0WzC12PkgQNVfj1OGhAtpD0oAt+LymifhO6L4Onyzwm5ONid83COaUzMahoMIBBi
 BoTjwVo83hFMxqDMN9jIZAi9qSgD9Km2jVZsn+rATI/RSqto=
X-Received: by 2002:a17:903:1210:b0:2c9:c517:d078 with SMTP id
 d9443c01a7336-2cf2ec54ea4mr9006295ad.36.1784232955666; 
 Thu, 16 Jul 2026 13:15:55 -0700 (PDT)
X-Received: by 2002:a17:903:1210:b0:2c9:c517:d078 with SMTP id
 d9443c01a7336-2cf2ec54ea4mr9006155ad.36.1784232955241; 
 Thu, 16 Jul 2026 13:15:55 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf1055cde6sm25822265ad.52.2026.07.16.13.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 05/10] drm/msm: Add helper to check for per-process
 pgtables VM
Date: Thu, 16 Jul 2026 13:15:28 -0700
Message-ID: <20260716201538.365824-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a593bfc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4aDCzPfTH0uMOhJcsooA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX48fIAldo4JdF
 5XOh7fGCRKLkJ5MbgNmfWK9bpS4JeRxNNjq4nFtJFqhs0lBf0Dz9sSmQPnbwevuGzFyKajPcLvy
 aU4NAip9uxMdqJfpgUE+h+skPr0jVOp6XkVoanG6TlGntmtlEnOFNiO7R1txeEJMbUmCDBD8UPv
 oTeSyghUHrnfkFLZFezE3ystG3RaCYp4yKnyBzHnUTOSzFIGjxYhcQLNh3lIN7RoSZi1QO98TzB
 l5d1ssDtj5lLLFneDx1+Yb3wKjcPjYIzNn9Tkp0x/tJwfaMrnGzTENdjWIcDVVPlpy65JAXUuqt
 0vbLfnFoWmqr1fCns1cFpvEHwROaQ2c6R4MI7Zd7bArt/K+9xW91PQrLKbLZBKDzIHr+pOlgw9F
 6eCrvsS2B3ynRI6WicRzvJ6Xu+OVSYGwR2GdcbPwzus4QnNVpTryMlqxvkEGjOice4ktrBVe2FR
 iS5JZqWnrJPhO/gJXOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXwUlRdw9A8IeY
 geOm4sfxNcLQivb290EpVQ7BuPMO6dvlN3hsXvmpdJwnntEU0gp4R0TourMdOh/LbGsaR/jF0co
 UQp5TgaUU6vvFn+efmx/GmTEpQX5AAQ=
X-Proofpoint-GUID: 6asH5bw2e68nkTLZlpqjgtzjcKsGoTnm
X-Proofpoint-ORIG-GUID: 6asH5bw2e68nkTLZlpqjgtzjcKsGoTnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160206
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

This will simplify a following commit to allow lazy VM creation to fail.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 0d54141ff089..5738eac9aebd 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -356,6 +356,12 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	return 0;
 }
 
+static bool
+valid_per_process_vm(struct msm_gpu *gpu, struct drm_gpuvm *vm)
+{
+	return (vm != gpu->vm);
+}
+
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len)
 {
@@ -414,12 +420,12 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = gpu->suspend_count;
 		return 0;
 	case MSM_PARAM_VA_START:
-		if (vm == gpu->vm)
+		if (!valid_per_process_vm(gpu, vm))
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 		*value = vm->mm_start;
 		return 0;
 	case MSM_PARAM_VA_SIZE:
-		if (vm == gpu->vm)
+		if (!valid_per_process_vm(gpu, vm))
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 		*value = vm->mm_range;
 		return 0;
-- 
2.55.0

