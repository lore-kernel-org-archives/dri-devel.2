Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D10F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3625B10E444;
	Mon, 23 Mar 2026 20:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oy9Dfmws";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hbN27R4h";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C7510E444
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqbnQ2971877
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lVL5O2LZPIVIF6OfH5Vaje2elHwGIQmYJFJtw0KLdVs=; b=Oy9DfmwsqoNtpWML
 ED2eU9yOaMJ4rrJYBNPK8YzXD/vtV4jd02IDqCfqQQLi/Zn9BxPuhE1iDkrO4cgD
 WJ+BKUnL9gvthLXwOyAANsaYAQpwm07X0qrbqiNsj6hrbaX8QDDLGIg+2X2tQ/Rg
 OWYnGKovBs6iDyuV/hUFl3Xj8WC24u40eI1CzTMYVmM5zgkTo7iVWTO8bYN7DBdS
 TP37npjrq+9BXkYFnh4WmVEUyxhhydGj/yHIJz2k4qfg6OwNfGWOGUi1XoiRfYlc
 bVwo3/0n81VK3rTJ8CwESgNWbzTvF07kFYAG/kb+EXFoSKQVEontgctenbSuXhBj
 jt59Jw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc2m25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630753cc38so21910185a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296845; x=1774901645;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lVL5O2LZPIVIF6OfH5Vaje2elHwGIQmYJFJtw0KLdVs=;
 b=hbN27R4hqQ90NZikGLZcBd0EjFaHnbp1fqQhdtetu1s6udeDAIoHuE1pKWLi+fjhmc
 0j6m91tiluK3jCsrnHuIBfDjDvfQFUV9fxNO5HlrQ0F9BcJjlv4GxwkO4QqxHIRosw9q
 LJdDYD9X8P4KtK8iaSUm0AOztEZTSXpboXB5W2hp9u2n/2BzhKiaaztlSgWv4ucYe7mg
 nyv5CtCaU9fUi+jMiMi8XTrI00UfWI6Kgawh91HX62j9MGd5dTWTT+9JqXtrlHj+R/q6
 v+cZjP6VC0VNSaCOFcfDYgdv+J5Ah3sr86soLZmavPAkpH+qXT9s4oRAvNl+azRtsoYk
 W8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296845; x=1774901645;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lVL5O2LZPIVIF6OfH5Vaje2elHwGIQmYJFJtw0KLdVs=;
 b=bQAgtirS4F4em3UpU+o+PXRRulIcc1GCX3pywO+xUN8HOIdI/bj0G70gIHEGq5eshC
 /H33inGXLaRvJ7zI6yR4a2UT/0m8vYVMN4pYfIkfwp7m9XcjcalH4i1bcOg0iOgaXN9Y
 /50Jd1+yooDCizSajpEZygwEEpspoAVwDWNeKbbz0JIPrxdfOgNRPGgDmEftACiPMjhs
 BbhIyB+30+KfvTEeJ50otczdZr/MyWcqfvQ7S7XmLQPz//XRqGHr2anF1es+H++OYp9V
 p2y91pFdOihADoF+MWIr4RcP/QYJvP7tsr89Ec03cXhgZWQe2vuM/vP52cwQMWw6BHLY
 pdeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3LoAHBPqhbkfEWSJgZ8MeN3jboyVFtEW29XBR3TPLjGCs0mVP9k2h0obX/5ny//zlE6U1zzouxOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSaeE9cCQ50RuKijLoYJoylMIxiMDH5/l+t8guew9NdC2VHgW6
 37b1vuI0mXfLaef1SxSUYHu76gHAc3GFADW3S9//B/lZK3Ie4RT3NR5688daGhFxzm+wORStVwX
 A2CG92hXebONvEIkch0u4JGComQqEr+ZS018fsguKI+vd/7im/n6fVxSTYcbS1DZI5d08QEsEbH
 n/HEY=
X-Gm-Gg: ATEYQzyNfPVfuPRm8HC3HpcijEtI1G0Z7bAtUcYmFFAjf+9OFBI+7tJm8DOrtZrYHkC
 GqkshR6vA/b8qK0dKwnB0OXae60UP9FrP1fKzUGItiqqgueA3+oJn9+ChVCNayhDVin4E9Lhb6E
 zs1jrCKFgjCZ3rr4aSmWG6P0wW3sI128/T9ceh90Cp8NTPdkewvvxwDpCc57+k5fZKNM2OOttAk
 Hln5zTwpcit9wPQyst5s6IYGY8Cv9amNQ7XYsBzWkzS5ESYKFFZaOhbHNOQO/SGFi7GVmhuI0qY
 RkPUGwInLUkMFf3GLZWJHBTJ4YXLK91q2JeK6iKg+Vm4hFx59FLX2fAkriKYSKUzxxNHXnnaV4K
 5R2M+lumIhLbwnkvEae2l8eLph3r4paZ9N6HcjComtGjK7w==
X-Received: by 2002:a05:6a00:4148:b0:827:37d5:af5a with SMTP id
 d2e1a72fcca58-82a8c22d010mr10820907b3a.19.1774296845445; 
 Mon, 23 Mar 2026 13:14:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4148:b0:827:37d5:af5a with SMTP id
 d2e1a72fcca58-82a8c22d010mr10820884b3a.19.1774296844899; 
 Mon, 23 Mar 2026 13:14:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:14:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:27 +0530
Subject: [PATCH 15/16] drm/msm/a6xx: Enable Preemption on X2-85
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-15-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=3858;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xUiKo1yj6GLcQVb+vkBst3BMjf309OP8s++yQjsuSJc=;
 b=2rI1YvLFs4YYZPHksxVvp7iWMp+avy/Jx1t3dSt7bJZ5N8uTnzF/6lWeRkdCGwsPD//qlh/0f
 /PZWHx81nUxDi8atrdNqCYjYvRLPGVWtk5p/y/wNKIQGLcEePilBj9U
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c19f0e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PN0yGgm3WGXANvjD27MA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: mU4QnSwaqG6SblPvBxg6eSwSk3CKWSz6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX2WTSkkJmUxF7
 o5H8tpjJkRaJmkyTuxiRC8moX5IZXCaJioI49+Zy7A1S9NO8YP/2jTzK0mcyz2pRuiaureRu+vo
 1sJBTHuVKIRZ+Rsha5p3vUgn6bTVOFf9Opzve8OQ3TZvn0OVBCm8x49HhJA8Yg2O38DqUGdqpPE
 MhNLa6pCDS3c5I0dJBi0soRzOSh7F7BPbsdqsfnrJnEvbHWr45bppDEXID4G41aFFJwrlfKYP/T
 s29BW5MOIKxeeKBc+MQTml5GPxlmT5i0349PzRDU+GEKZRONcEOee0gDKMlDfglCOmt8ocQumTF
 /7D2Uf+tInqyLS5MO/Tj6/BaLgppQtKivyj4rFGIsK4b0rgpQPrqDX1L3CCQccNc4gGa9GiFxCp
 XSeEZoGKmpAQqpPY816Ca52dl1uFytwIhBxdLYMTXzkh1KgNoTc+Zjct+SX/HdpZIpforPH9gW+
 QVnKsSLqQSlq0GgODWA==
X-Proofpoint-ORIG-GUID: mU4QnSwaqG6SblPvBxg6eSwSk3CKWSz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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

Add the save-restore register lists and set the necessary quirk flags
in the catalog to enable the Preemption feature on Adreno X2-85 GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 21f5a685196b..550ff3a9b82e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1761,6 +1761,44 @@ static const u32 x285_protect_regs[] = {
 
 DECLARE_ADRENO_PROTECT(x285_protect, 15);
 
+static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
+	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0, BIT(PIPE_BR)},
+	{ REG_A8XX_RB_CCU_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_RBP_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_CP_HW_FAULT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_INTERRUPT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0, BIT(PIPE_BR) },
+};
+DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
+
 static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
 	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -2082,11 +2120,15 @@ static const struct adreno_info a8xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &x285_protect,
 			.nonctxt_reglist = x285_nonctxt_regs,
+			.pwrup_reglist = &a840_pwrup_reglist,
+			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
+			.ifpc_reglist = &a840_ifpc_reglist,
 			.gbif_cx = a840_gbif,
 			.max_slices = 4,
 			.gmu_chipid = 0x8010100,

-- 
2.51.0

