Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357D608362D
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vu51Ux2+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F9ZAfyWl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C4D10F3A2;
	Mon,  9 Nov 2026 14:22:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C6B10F34F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFGme971371
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UkojfpaA9Zy
 AFiSTVcPjf36KuXa9Qn7YPnWuS93EhrM=; b=Vu51Ux2+uDtwzBI7/p2hX9bsCg4
 v2zieU8iVdowAYsmoDUbFQQYMIVn67ifdcF/hTUerCCxz0wMuBx1pXGtOo9UaC4O
 0FL+QnuBCCIAAOA839qVRQ7yGWKVMty/VnqB3Kugk+qE7uysfLLUIon8XFQfARY2
 ae75GpWpIKURNhO/etQ8q0Lv8xkvHUx1HcmCrPgcLsQfjB5ja9MDY9W4uxCc2QJy
 m+N7F6jyHtRm+8QMLIr+PD5OJuu7Syvz76vfPdaYZMo6USl66PUPHlKHtNabqqHr
 08M9mXut6IoljmxJcdCaZU6oK2WBJE6PCw1WAvzLsenhjkqIyZirjtQlBTg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm3h3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e9d52f684fso9967095ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234082; x=1794838882;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UkojfpaA9ZyAFiSTVcPjf36KuXa9Qn7YPnWuS93EhrM=;
 b=F9ZAfyWlZR744RPUeBATfwMuDMiEANoSa2whsHQ5XMD5ih24xVz0OLlrgf9jCtLmIS
 nETG/Qn1gUTJisW2nXXuAisz+V2+KGu2GIjvAj/55TeRdlwVtRd79QBCXG8uCpkxhmrr
 G2xysO1Jg3zpKxBxGLkA1F4y4cbUYWlXCYgkJ4pWOPkRzWgtc7DuUaajexaob5xl60wG
 bnWbVijMaBnvIpuiOFomR0T7E2HaS9rRysA8sfETqA0dUeuy2M00zrqbsR7zDTS1V+mM
 ZwX3vO5hMR5yl83XyiOdk5ts3Z2tVS2XY8zZOCAGriEOnopiliUSnxZMBFYdosCUkPLC
 rBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234082; x=1794838882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UkojfpaA9ZyAFiSTVcPjf36KuXa9Qn7YPnWuS93EhrM=;
 b=wyV0MrbBd2rS0HJ+lGzOOq8kUzWUdZMALY1USGemzKsJBEleTXHbO9s5rg9G9b15Pj
 Cfw+i5ob7epKLs3iCDbRvX1AbGaVVlYrdaN0fG8Ur0bLYwfAGpbGPk3i0X9KeDWRuiy2
 sWYluHqllcUNRTbD95pe5ZBxTJ11ns90YwzxaJCEFRzpDRZ3Xko4mraduW5GJ4pjqPF7
 ht8R737xLdsZ1s+uCGSRqR7vWyEFLQTUkdpYRJv1g7CFS8ML/OyYO+IvB0kmtjSyQ4hR
 kn59/Nu4WqBZGQ3SfV3usgcSDdWD/exxysMUjeRh6OTz6DWevMXC9I+jEnDfxVU8Cyeh
 tvAA==
X-Gm-Message-State: APuU4Z+xfTWipx3wpS+jFTCwdWBzCSDkOKzreO88HiM/r8Ny8NoaJlEi
 wxWGGrV9NuyTpOxMdLbqd6ox29Tz3UnL3JMRJg5+CQKZ1bL95tu2YKJA8H5VqCqQAlq2c8/MsF5
 9QXFPp8MmF+W/NBPGKD/M2t1bh0pvtWQlGWYHiJ8MzHJe2SvnaTKHQ/gHLdvmVY5Aza4nsBF39E
 SUSfjCUA==
X-Gm-Gg: AYBFou3UVsqIrqHw3iyUQuwzHF8i6gg3FKoT7ohGYPkBJkKRg24Fehtpw7498ElsGT1
 EWr3WI00oIbr092037HmVFNJismhn2WA07Uewi66t5OJaQq3GXuCEGoJoc02MInwZotiEpEeiDG
 DrRTKA07n9IGKRGKVzvRanVrWXIjH2j5Y4TBirJgiXHDV+INzh+9FYRT+PKNg4juMAbBov/jRf6
 0670Jf87uSZTJ/vb8EKvSzkVjWZnqZVEi55n+XsqmKP3+PJGYrKXkeVF2czY4he2qe6BZ9FdMrh
 79JC5eN+zyNBuUmTQ1Rx5AmGgH7phtsLhilXXhOjvFySHS6k3fAJFulWIlYVkw4wIbJevaHAv0O
 vrImlJmLm5bjsqLXyQEsUByKoK71/K+2y+GUe7QgKawfdKI3G2l/cBJbP5OUpIukqmnZ2SK3vu9
 r5JZVaQbSbGOel+Oavn9MRFLDOR//IgUGq/oupFi5xHzyOMjOtwXKgqkJqHYR4+A==
X-Received: by 2002:a17:903:1107:b0:2ed:74a:6724 with SMTP id
 d9443c01a7336-2ed83776ebcmr40062305ad.43.1794234082075; 
 Mon, 09 Nov 2026 06:21:22 -0800 (PST)
X-Received: by 2002:a17:903:1107:b0:2ed:74a:6724 with SMTP id
 d9443c01a7336-2ed83776ebcmr40061805ad.43.1794234081551; 
 Mon, 09 Nov 2026 06:21:21 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed81711bccsm12019975ad.49.2026.11.09.06.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:20 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 02/15] drm/msm/a8xx: Export aperture helpers
Date: Mon,  9 Nov 2026 06:19:48 -0800
Message-ID: <20261109142111.256630-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX2/y0PDHysaoN
 eRo5nSiIkkuGwMJ5DnACg1qNmAfSH75slcz875OEKTMJwjH7vxrc7V0/qnfRCFBj57cLwGV3+M7
 Afnnus0tybzlDfoNgc675X2XISTDm3I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX0XFO6y7w9TA4
 eFAu9LeMOgJfGv+oLJBdwEEUUIcQLTIil4HKdeei3p5S4M18XLc/fUUAhHBdWhahtgQajPoVtnr
 xPL/5z8jJ56OLgTjpwoxVZaBBZ+Lc9dfBcyv8w4c6SRfdDL36AzyVmNvgkMoA7+7YmcOF8669TK
 6giQeQtS8tf2tonEoE+hlAwoh8hXwKe9Ne/pcXK8/fQM4fXE7VxyxAh0w7IDGM9JX3w7dI1zocH
 XSeP9C1V6+wcrblG+ELqb4tztr03fgAc/tqjceKZfaMfxV5CJXzsNPKbIRFiDdWaCV4qXwdmwNN
 IFzf0jWtQL9ysx0dmrgNiNRc/DMJV7TlHcZjXT9qzpx11JXEj1Kkt06G7BVx42ykUVDe/PUuVX0
 fDhlW2rB09tyyZ1NBE6ABaN+yNfoN0m9Psp5rx/HANKe7aBvl9JjjFMds6X/731ChZvRGCJfOHw
 pl2f+UR0wHROxRxnAAw==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1d6e3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: AOF78QR-kJLYX174xRIXx9fCvIFXRtmL
X-Proofpoint-ORIG-GUID: AOF78QR-kJLYX174xRIXx9fCvIFXRtmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057
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

We'll need these from gen8 gpu state snapshot code as well.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 3 +++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index ab4cb43e4a54..c58a2665e9ab 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -346,6 +346,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
+void a8xx_aperture_clear(struct msm_gpu *gpu);
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
 void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 25ee3ac16ed6..82cddaa7278f 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -32,7 +32,7 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -42,7 +42,7 @@ static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, un
 	a8xx_aperture_slice_set(gpu, pipe, 0);
 }
 
-static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -50,7 +50,7 @@ static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 }
 
-static void a8xx_aperture_clear(struct msm_gpu *gpu)
+void a8xx_aperture_clear(struct msm_gpu *gpu)
 {
 	unsigned long flags;
 
-- 
2.56.0

