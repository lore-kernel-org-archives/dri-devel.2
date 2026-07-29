Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D267DC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E240810ECBE;
	Wed, 29 Jul 2026 15:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Drx6JVgO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtV7thRI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A303910ECBB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:57 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3AfT3343279
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mmTWztalT6h
 ryopRPQtckYmk1TcKP24H1NmDD4Vro7c=; b=Drx6JVgOR6wh/NzjaJ0aUi7xdXG
 qEueoCPDOEw20d5RTebm9aIUM5JGq4HDW1Wb9CB2X9J7HB3NHhesLYTKaoZ/v6HB
 eVEpBcvAh8ZTc5JlNOQbAzcgNYxXuW3GO3291orO7ZUawK3IUusRPm9zyZnzAwXb
 FlmkHi0zV+Ykm7XTJ8+Bcd5rH9/3ni/TRxn/+QE4BoV52eoNBhlJBEVc7NdmP2fN
 lmtxmRiBo3s1EKVeQlYCW9/PN3tnaRAT+DHZxAFDCHjCSk9entlVxuBFAaJ6Bic2
 FuJ1dU1J56ror5t6FGesCHMy1jN41hL6RY9wVhYwwPr039xtznAULIy9Wyg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ms6qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so1302075b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340616; x=1785945416;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmTWztalT6hryopRPQtckYmk1TcKP24H1NmDD4Vro7c=;
 b=jtV7thRIGPWQwJPBALemep3F1UZX4g4oRPpaB5nmxup4yVKPj9giFKMfMCmoPWluhH
 LjoHWJByBkYgmjej1p+K13Va8wV0fWNH2+UVl9qCdpgaB1ECsRNJtuDXK780t3ZwAqG6
 u+G2VeJrQMpt1d1RUgep7Jr5VPLP2UsIIt9Oeq+/ZSyT+G1kkGlwF/DJSnMPwmEwaxKg
 AiEetRRbww2GvksAcyDzlMLYGxuQ1AaQWr/XYUX5M525DKX8K7pKxIcMg7zzI20hPa9p
 j6JVhVsxcoiXRRmkeDcYep/FEiURpMLeak6BvFFAB8IPSBY7KnD4h2JksghI4F6B5sI/
 USTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340616; x=1785945416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmTWztalT6hryopRPQtckYmk1TcKP24H1NmDD4Vro7c=;
 b=TDqupvEXp58MtQLfLSx6cg0vXcpGhWBPeQ9Abs/VQfqmY9qhmB/jb7c8vS6xHZWweL
 jPmxZNbpiEr0vOaidkG/N7HjHyw9PQChb16WL0K2WMg2eSsMFOAZ6d94DSfhnYjHiVOJ
 xuyl4SDRToYL8bVWBwo5ose3ch27OsKXInKssFGsad5amFFX+859rxqXCRIPmZQBHU/a
 ieoaoEjK36KBSVaqcr2diAIZiFsBzwHgzgvp3OIZglH8u1lLdsInj9kISeS5j7PNFUek
 Hp1xOcsWsUn6l0AlBzfXy+lc9RdbBS8NucAH0AFZJHX5WhU22txrb84K6842GHJ+jnw9
 G/ag==
X-Gm-Message-State: AOJu0YxQ6pcW/k0y2sIasrE1rtcj1eDWWyWSCUxktJnp+HBeAt6fRoJK
 bamwoOwPx9m0qdXLvjGhb22KiMnYvKYDsKrGQ0KKQMElQHXTn1b44/LxAAwzGH/GkqmNscNXoit
 ty6gF0/NK9tzw3jpYDDwAO03nXIpttqdPz8Y1lYYrYM/XIYkuei/vkXt1DTn4tsyilQRbt7ZFtf
 NRi6g=
X-Gm-Gg: AR+sD11vLfwnjMUa8AoU3NzP+dgcvZ5KA1qvrqwUCEBY2WmSB2cs/D3dd3coMya+xzK
 R97qrg6WSDMBIzSSTteNBOQ8G6KG8W84t7jaEMjiv9gLudEPARzl47SCXPXxr6MQaDqCGfOAy8P
 8RdtztRki1ddCrfip15Aw0i5sYNhjQAsFcDVi5SSyTKr41pjuM4ETManse7ud8vqS6NElJDIE03
 w2V9wukQ5/C7Ge7nf/uXi9UGQ8evhU11meSJhjUPh/b4wfqt0O3dPyhfdRRB/r+naRzPut4o7l4
 oZeQpUOeJMhG5AtRr3tklXLyEXwIbzhab4NaU6v1oPcZbnUqYmJekkZWnxEI2kPo62hZ/w1o2uu
 wje6QC6FCe8aIH+UzhglmAuf/nwG207rbqiezoiELKYtC/c4=
X-Received: by 2002:a05:6a00:3a14:b0:847:9b9b:8981 with SMTP id
 d2e1a72fcca58-84e93328759mr7904844b3a.33.1785340616512; 
 Wed, 29 Jul 2026 08:56:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a14:b0:847:9b9b:8981 with SMTP id
 d2e1a72fcca58-84e93328759mr7904810b3a.33.1785340616038; 
 Wed, 29 Jul 2026 08:56:56 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba92b0dcsm1178305a12.32.2026.07.29.08.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:56:55 -0700 (PDT)
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
Subject: [PATCH v7 03/17] drm/msm: Synchronize VM creation on ctxlock
Date: Wed, 29 Jul 2026 08:55:40 -0700
Message-ID: <20260729155609.20190-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXxTw/nk9P3tUO
 i0kVYrNQrJDx0ZhsXBQwOXDXe8+46AdHeyJ+LNTBeEjtK0JPQ1V20GD/NwTLJrfU9Kjz7vBCBJZ
 1xqsusvY0ONBnFZQRhOw5B8V7ZtmaL18CG577jLBmr+HwnzhOAdpjCDS1LDTg2dmKS02lJQXPFJ
 nLh75d9OvtWCLm/Nb32xUFUvp2jgXBRww+AtQNIWXDvn1tT5IrEv9Nvx1HGp8nqEVROmj7rFMR8
 gqoL2NF0PTw++KZcOXw/Apswzgu7DzSvckphPYAxjznjWVqHQa3sziMnO1HNeR4qxx46MyGhjGn
 m05zEh7xJ9Dl9BSvoKg7RAeZCDTnPFTBcV7iCmeQCofOpAYkvsultTVCoikiY98eZvc3P2/CuJP
 J0/9UslPY7pXuwGNzyMFXCiF8LQqpdIeFLfmO41gboA0xHth3JP0GB5WpKbe2ZlC9Liz3fWExsg
 AWEIToY+i5JAsNvIe9w==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a22c9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Hu6Oc1eQfK70imYNBQsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: GqwNeuCkcmzNDF1k-OE4KlJ18fImXgmG
X-Proofpoint-ORIG-GUID: GqwNeuCkcmzNDF1k-OE4KlJ18fImXgmG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXz5y6ylgJHxNw
 cMiLeSInESRFdBCs5IalUa0yahg23pAE36eHe4KTVwe0YE45jnryakVkY1V4uuwC0RAoJRyoW/U
 cX8JFR+T5BvmVnP7BGDDnkxxStgUpzU=
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

And serialize setting EN_VM_BIND against VM creation.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 ++++-
 drivers/gpu/drm/msm/msm_drv.c           | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..0d54141ff089 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -503,7 +503,9 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
-	case MSM_PARAM_EN_VM_BIND:
+	case MSM_PARAM_EN_VM_BIND: {
+		guard(rwsem_read)(&ctx->ctxlock);
+
 		/* We can only support VM_BIND with per-process pgtables: */
 		if (ctx->vm == gpu->vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
@@ -518,6 +520,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		ctx->userspace_managed_vm = value;
 
 		return 0;
+	}
 	default:
 		return UERR(EINVAL, drm, "%s: invalid param: %u", gpu->name, param);
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 384f32f4d0c2..2fd1b717d8e6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -222,7 +222,6 @@ static void load_gpu(struct drm_device *dev)
  */
 struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx)
 {
-	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_gpuvm *vm = smp_load_acquire(&ctx->vm);
 
@@ -230,7 +229,7 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 	if (vm)
 		return vm;
 
-	guard(mutex)(&init_lock);
+	guard(rwsem_write)(&ctx->ctxlock);
 
 	if (!ctx->vm) {
 		vm = msm_gpu_create_private_vm(
-- 
2.55.0

