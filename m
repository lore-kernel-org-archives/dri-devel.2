Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6D60A2607
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kh4dMs1z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ocxqvzhx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE7210E746;
	Fri, 23 Oct 2026 23:20:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3729B112D2A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvGSs4026628
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BHN0xNuoeyIHKTV1AFeaVEsWSbzhZXzn9ubdzSnUtM8=; b=Kh4dMs1zmYjhuW6p
 sSbZp9cQgJM6bbX4p1fLHPrJtQTjxOK8qYHZTdfIYn3LkzeMm7Mcf27XzDzZFb4g
 S70/vhZi9KhJd1rCsOXLeWBWt1VJn3Y2Rlw+DC25MZxceDVuPxC7Z4wsHM19teBU
 mS4vOrMFIc69ixVSRd90T6Lxi/r0DTelYAG7poMgwHpXO6unKxEHJ0JtdhDR0sOp
 GUVpJF5VqEAcFJHrX8hc/142lVo3/3gulZg4cU7VrKoPZPc48F6mN7lj352OlYk1
 zboJrR6YY8sSzbP2TxmluLU4aZelPK2BesQ4fm/4d5SnKFsf8GmDcmBR6jDsIMzi
 E5sdRw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcs7gvjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so266410985a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797633; x=1793402433;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHN0xNuoeyIHKTV1AFeaVEsWSbzhZXzn9ubdzSnUtM8=;
 b=OcxqvzhxuWw9iRDEyrE3RRoDMJqyZb1L3yC3Atq2zDYSM1rgLgB6U090arh0Bf9M2C
 T6/AUaOciEd0ucZAgAgLuWgFMdUtaAzGMIw5t/FzNm6wBDi9VGf6h9rxo7UuXUPdU8h/
 rZ2d6LsfsVwDVV9qzLube2RtJ8CJddHlx8yL55OslmOn8vpCYgpRwHYvbMfdCdncdyiE
 zPh4FeTIk1/NtHR0sM0yNwOcl7oK0Wk4UFuPy3iEJbNDBuvFrrcC5hmsLo/qx7jw+TEn
 UO06WIkWz7pP9S9SMdEJ8+VVHR5IPkMH3X9ZyNPL2L2s2iNDf3DXdsZtFJBOiy87U9ML
 5DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797633; x=1793402433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BHN0xNuoeyIHKTV1AFeaVEsWSbzhZXzn9ubdzSnUtM8=;
 b=Davzs8xS4DlYOQrEygaPRWv6P7bKsSC8ISyhPmntBsDnWsdZvDuQhrtavT9EA7EjAe
 4Rtlr+LzHzqKtQeJvz4Mn/upLTrbmIVt7S0vHg99bOKtpFiUt5vZpA61lNV+bXOePlBs
 S/MpTDbVWiJii3aXmOh4uCLeJDGtgQGaaKTHkcMZtSMcIHWLTGz8Jy7R6ub+Jj9sSh6l
 0hUvoVVJ7DFxautlUeSjMLY91G0llaDnBzzOn4y/um6SmRXdIvJTurHlNxFHUHAWc0jQ
 8PSoYOmV7E9uRzY+oBsQd3cnPi8dorCbb1kxp0m9kUo+mhvH9clVi+DK4xW1OdQC81c5
 mzqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtSQsbWfIdL8U02+qyx0tz5tnmXzlYtylTWKUH/5JFvU4IiEpZgwBrRx4cSsr1Bl45ijBavubd3b8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/Y5oFJZSHfNkdt4bZzw5ErHzN6rQx0Y+QIFIpdruXlnwiqZkY
 0w1QVLbHEK1PW5m/c5P5KGpx/eG+ETVTjZrtiIrZVtHDtMEhLnDtKyxGgVfSAaH5HKXB6WZ1/CH
 x0Sw+JHxZBw0JfxeForuRQwk2qZN0WQCQUOyRZtvRiBgCdN3eENNBa4KzhWUf7bi3Mud8FxM=
X-Gm-Gg: AYBFou0Ga855pW9JXy6BTdef5htz6Q0AzYeDx3qqwp9SP657p3/xpYaycyR/FRQnhH9
 oX2qltOPbu9WDwg0Nuuav6ZuWPg+1UxTSbOpB1uz9Xg8TZlGbnhEXdqLCiYwpSZScivwsHMuv4h
 Wwo3yAQXcyfZu2U5yGTv3x5KUzGF6M3ojspTB610vEhqQB50olPM3EmvmULxXL/rijmruEkwMhb
 7sURZnzPvlUltgSeg4YL2x6Ko45PhGmZtlB8z4eBpVYcl2Ov7UjLOphRrER27igKao5rW9GvCpv
 dOVrFozgnDsrBw67BI83GHO8KJ9d7sGxvLxreMD0PKS9P+HmrXCza2s6tJxrW2eJSwJMLLekLhZ
 5tcPFm8i3v9lmGwmEkTXgUZsXri/Aul/0h8GKXz6Zew8VJeh6TahtCi5uwyuLLl/mzXdtGlLUhP
 QgrA9nnrQLDenn
X-Received: by 2002:a05:620a:400a:b0:93e:66db:69b9 with SMTP id
 af79cd13be357-940ef9727d2mr83268885a.55.1792797632612; 
 Fri, 23 Oct 2026 16:20:32 -0700 (PDT)
X-Received: by 2002:a05:620a:400a:b0:93e:66db:69b9 with SMTP id
 af79cd13be357-940ef9727d2mr83265585a.55.1792797632128; 
 Fri, 23 Oct 2026 16:20:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:44 +0300
Subject: [PATCH v3 11/14] drm/msm/dpu: clean up the self-refresh helpers on
 teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-11-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=x7Um4Zh4cOtsynGFkbo/mRPO0qZY+PJocyHznMzNkZY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uWjGtrz2xJsjk/AKcyyVz4BvaRFGZntwWMx
 U+SmgJEifSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrlgAKCRCLPIo+Aiko
 1Qv3B/4vDAzTKH4or8FdWIFi2eL4ti0qrqm2sHPiWQRi4gcGYjcD2ig951J40wzGrQk1do1aXwN
 YLMtLK8xUwnwMVCWG3X1aQsi8tKC+6u6PW/rWDXurVIPwauoGxx8c1CUEFnRW+3Hc25Nlm/d6v+
 gAxLcq9k7xSqevWrMHw4OcopSaIjth3oMdCb8/8MxNg1swnXNw8xe8Pt0Vf16P3y9y612cZ0xdh
 IMMe4MYl6C6QnqEjgrr9dDPfz6bVgSOX50jKt8Qd5QIVk0yWwNBDrLCUOr/y7wF6Cc7wcujx29n
 iy4wQlhuCl+6EyxBBexlAPfvZjro4s+56lGeYO9g3vWflppb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXwI76CGEV8mxo
 kDxmHpPBFGaOk55pEE2c09uMWgSAomBWRrznY3/pK2wsrM4gvxQQ/CayTNLnEZpJ+J1w5+d/Tze
 L0KpbK5XSn8VD599+mxUVGSNz43l4FM=
X-Authority-Analysis: v=2.4 cv=XJCl2ghE c=1 sm=1 tr=0 ts=6adbebc1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=r-hXt3OJkovplFG2WMgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX230nCQ3FOr/l
 TBFRFX/cXS7EKXlDTi7M6vw4SYqIzcAM+D0vHRla9gPJR1Dxm2vXDEwjwlavW51RzNeytI+WPRS
 fYbIuuECwjVTg9AHWB3IX+oaRizyzsS0DEkYHfmAgezDOFCctpfZJG41XXaPVs9USXk1OKN9xqb
 Yskkp/RX2l0N7sPLdkXWJgbAc0d1Qt+wJ1qXj+iECI5ZB519r/oQ+DMaQunadb0QmXtsKrR9o0l
 LACmCLGaS4OIwLiom1/bCr4SLHAAMenbXiCrrF8vMVkowZZ940//IFqbZQaQomeqBQN5mrKf2n6
 6Drhl/i3b9j4uSr6xyfoPpIQiyd2S06EJyLGMmTa/u8IiOJEDua15hGpT7xgAt/YNU0tN+1Zy+g
 gxzE9odPz3m9wdaF+RowavgUOgPezcYFX9jdlIgPa+2eBUoLHud1xrltnzUg/pyfxCwwa5WW7dW
 j0KErHaSgIqPESC1vjg==
X-Proofpoint-GUID: Xksgsp163n4KCU4D5tNEatEFfI5dd71V
X-Proofpoint-ORIG-GUID: Xksgsp163n4KCU4D5tNEatEFfI5dd71V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unbinding the display driver on MSM8996 with DPU oopses about a second
later:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000870
  pc : drm_atomic_commit_alloc+0x10/0x9c
  lr : drm_self_refresh_helper_entry_work+0x5c/0x1dc

dpu_crtc_init() sets up the self-refresh helper for each CRTC, but
nothing ever calls drm_self_refresh_helper_cleanup(). Every modeset
commit, including the one which shuts the display down on unbind, queues
the delayed entry work of the helper, which then runs after the CRTC
and the DRM device have been freed, and its data is leaked.

Clean the helpers up when tearing down the DPU hardware, which cancels
the pending work while the KMS is still intact. Doing it from a managed
action instead would not be enough: the DRM device, and its managed
resources with it, outlives the unbind as long as userspace holds it
open.

Fixes: 1122697810e5 ("drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 65ba8fa697e9..934ba47b2dae 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -17,6 +17,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
 
@@ -885,8 +886,18 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static void dpu_kms_self_refresh_cleanup(struct dpu_kms *dpu_kms)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dpu_kms->dev)
+		drm_self_refresh_helper_cleanup(crtc);
+}
+
 static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 {
+	dpu_kms_self_refresh_cleanup(dpu_kms);
+
 	dpu_kms->hw_intr = NULL;
 
 	/* safe to call these more than once during shutdown */

-- 
2.47.3

