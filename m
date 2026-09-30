Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5232DCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A906210F406;
	Wed, 30 Sep 2026 13:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8XBLEc2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DKjo644r";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB6010F403
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDIaT8614965
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y3X1MILjhoW+3ywmS2mPHQTbGl5p98m6OBcUF1sWG8A=; b=i8XBLEc2/b8vgxpY
 dL3748515rFdGah/cHbYi9fKWCYvWjSyTUlpkAk5H8wddH3tBtKvLKYe+mHbry5k
 /u6md2pdyfgCloXokgKES6JLPpzPsMTj1Uhb/zMa/+ZfQWDxHRIeIAB/KJS9EJxQ
 sIvTuT006NyyDWcRdfG5KB5iravEmlhXL4qLI8md8BeHIksCpSEs5hv21WkZdOOd
 1HBHepQ601tsoklt1xyI3Sy3UfCikU9+Xvf+4WpI70gEwL/LMunIxCBvcDtvKhkk
 uonn3YQH8c8iqJDKOxWDFoLDpYJE5NoPAKQt3rQ6nG2DlEGTRrnuhQUjsMbNEXqS
 04evgg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tg2ck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:52 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988b5c59668so2293082241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790775411; x=1791380211;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3X1MILjhoW+3ywmS2mPHQTbGl5p98m6OBcUF1sWG8A=;
 b=DKjo644r2LDkA7TcKmAJDPW3ADyNS++zx239P5WL6gcug4RXnmAmyV/+988u3LNE/9
 wnVADa+vale6CHfYrM1T3MXLxjHE3TILoZp4E/QzRHy+SIdeGMbymYPWqFycYLhFE1Mn
 6UpP8qtmD31FuYOCUivmh5UJqEvl04hWNH9ey9hJqrw6dfgIHBGKr07JaaY2m97r2/nI
 h5gnDcpTUj3jv94KNw586qMu/2+y2pg1JqEMmJ8TkXlX6FX1azhCO8Lr49nXCsaVVvO0
 Ueo3+rOx/TGHdEqfq1BQtu/8JSn69doooc1Y+2wsHfdgBaKzfHPsgDrMYe+9Zsm7SOrm
 3J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775411; x=1791380211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y3X1MILjhoW+3ywmS2mPHQTbGl5p98m6OBcUF1sWG8A=;
 b=QrplWFdLgc9Rt0xckTD9Eoc2oC8X/GGCjf2hYcJCZKN2BvcFN17cT9MAyrZ4O2IrNd
 4LfTOR6fM+EXwfvfEomtSeFMuNJ6X9fQOULt7PtKf1WBVrioB2N3+kV6skZcla4Ruyxb
 NUgJQyvoUGLOiVMJ6TZNgf7f++WsjNMEvHqnWou2Uf5SohPlh3Ydv8mXIqqwKmVK8Lpg
 H0UHmFr4PMttIBxH5tEYv1DSZNTUONohC0GrS6x5pAqd+HTwAYfOOncRgl2GRyF/Uq5E
 S+EbP2dwKYRZU6HMr4WLJxXDSMDy1c1DdXiYApmPO7Jf7DUBOADycwGr/R9lilUYD5b0
 DXaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMMjA1PAmBuYJHBTh4SLXAv9rt2MXfb+JQ0DDECPdtV8gO4bXWndWOF/txqHnwSyZaIkw8qDmcsf8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ+5WHXFgLdBWRdazYXrbps7iSGLFfVXnOU12bEyRZAVTmvwhaT
 +PN5uAiezjSXPO7CV9kwA3ZUNpq7sCVu3PYaman2RlxbjS7gndqJSxIRfHCWekKKO8evSviTp6B
 n5TA+mlbnvZ759+VkTrkd5C449Y/d6op5J46I2fSxjM9H5IIJXnpgu82A1FiOBP7krq1SmJE=
X-Gm-Gg: AYBFou0FKHgpwkRWbApl4LXUEVkpkPc/j1E97OfezWw32njcZJZsHLldVS3E/hIjCjt
 OiTrzXUl9oWNVk8nUVfWLNe9SpTtR10x0YO4DQKXeWaQIZMFgX62UfcSaGSpVmfGTHrkE1j7g9T
 mE5ksMJVQn6yuB8tgqXGRYpTjSgPC+DblhiUpEwVYTt6hwc8/fKo+dLDais7uyOcA6AEj4ykydZ
 OqtFuLIJmy0qVcxzpZo4304INsO4+6dR5B6//RbmZMEFT4Fcr9aA50nSb4o/b2J0U9bewRCDT2N
 B8qcGFgXMDEZk7JbL9fFEhPkIECRi8GOPHyrlzDhAVPWF7tKhc+N6dIrBAm/SWWi9qTF8az6DFq
 oTIqYkw6nbEDpAU8eLcjsDQ96Zhfge1fCHC42ZbLqfjMMVkGob6IS8DKgchXZYJ20uoyXpybll5
 hITe6Cx5LGVotl
X-Received: by 2002:a05:6102:5cc5:b0:7bd:3530:d84b with SMTP id
 ada2fe7eead31-7be72eab133mr311278137.6.1790775411433; 
 Wed, 30 Sep 2026 06:36:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc5:b0:7bd:3530:d84b with SMTP id
 ada2fe7eead31-7be72eab133mr311260137.6.1790775410985; 
 Wed, 30 Sep 2026 06:36:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fbfb582sm356731e87.57.2026.09.30.06.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:36:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 16:36:46 +0300
Subject: [PATCH v2 1/3] drm/msm/a2xx: Add hangcheck progress detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-adreno-progress-v2-1-3882f0fcd7b4@oss.qualcomm.com>
References: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
In-Reply-To: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mrFjQ87puxCi5QNDllM5X4hiL/QtD1aLbA5Sw9zYT6U=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9ZegfyTlZ0V0rWWbSecV00/uM+v9vzyz7FCW1a8kvkmZ
 1gzW1awk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATydzMwbCppF79p1PbBtXn
 pivEHx5knZbsv7/PQiXT88Fi+U1Bibt9ZIQybk5UFG47f9Lb6Z/+z1M/VzZlHtQKfumV0VuSJ1J
 6t39x8DozfavjbY4vP1l7Sgf2yorm12W5rZiyqPp/Gfsnkc0XMhv1p3C9sSwUenY8dc32nQUV/8
 Mr1x/K1V43PcdRQzMlzmhyy9YnwY3yDi3haQ8u9vZYsu69uffxifh9PF9WqjOsn3qw3DEy7Mz7k
 v/ZzMGfNT5FvIgTyYupYJNjn/m0NnuZzLGUNsGwjCCZRUFNleJVs8+tEp515s07dulC/5AjtpYr
 XH+UtDRXzrj3yaVtQeXyO46clSVns228Ngrl3I/fOV0KAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfXy35jPJuNV6Pk
 u2pBYsYyO87dUbvzsibvY4Y/5Smf/7M0vPgisTJ2G2dir45ezpioJIVddx5Mfd/2vjNrPZ6kvQH
 wGoBZ4av0WIvJPk697CX4yy1oX6Fdlw=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd1074 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=7JSXepjcj89yP10iIeYA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: tnmp6ju3Z0npA7TLp1yyGWcLvh7SO06S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX+iNZ2Nl8GOyS
 /fxsQ9DtGx0MSEJrPioVnINQKt45SQ/k37vYR0HZG/SojdooLRE8M7T1dIv2++CwMylABAtBs59
 kDV9YIelCJY0lNlweNglmydRdsN8WoUc7BW9TgtjYiv8YfMuXopsBq1EFJiarwwBilcBOPUAuDI
 v7YAxy1VLWJSvLh/DwlYViKE00qXSgB7T5KdtJD4VOhikZkBDbvRkIuP3KUHjqFED9hpzopLzrR
 pre6Rml9x650cFg3sKMu0C94lMjQLAp0D5c/JT7E8mvolWMe9yTGE0cOHkpJ9h0DEbmAaexnH8W
 1b8Ie/eIJh0CWgss2tknUpGvVpNzLoOcGiu9EOBYnKjfi3M59HtqeRqjLfZ9OVmj3NY5W4k7qBR
 AIemQ9yLc1EROG8q2UvO8YOvYa8jPjdg6w4tUI6hQRMOqNCrUBwGi7nCImIDTkoCJxqlAljI321
 K27qUqiIf24Q/yL/guw==
X-Proofpoint-GUID: tnmp6ju3Z0npA7TLp1yyGWcLvh7SO06S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300054
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

A2xx has no progress callback, so any submit still running when the
hangcheck timer expires is declared hung, no matter whether the CP is
advancing. A false lockup is particularly expensive here: a2xx recovery
is unreliable, and a second reset shortly after the first one leaves
a2xx_hw_init() failing for good, so everything submitted afterwards
fails as well.

Compare the CP IB1/IB2 base and remaining size between timer
expirations, like a6xx does.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index df4cded9143f..59d2f1684e6a 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -489,6 +489,23 @@ static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr;
 }
 
+static bool a2xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	struct msm_cp_state cp_state = {
+		.ib1_base = gpu_read(gpu, REG_AXXX_CP_IB1_BASE),
+		.ib2_base = gpu_read(gpu, REG_AXXX_CP_IB2_BASE),
+		.ib1_rem  = gpu_read(gpu, REG_AXXX_CP_IB1_BUFSZ),
+		.ib2_rem  = gpu_read(gpu, REG_AXXX_CP_IB2_BUFSZ),
+	};
+	bool progress;
+
+	progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state));
+
+	ring->last_cp_state = cp_state;
+
+	return progress;
+}
+
 static struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 {
 	struct a2xx_gpu *a2xx_gpu = NULL;
@@ -553,6 +570,7 @@ const struct adreno_gpu_funcs a2xx_gpu_funcs = {
 		.gpu_state_put = adreno_gpu_state_put,
 		.create_vm = a2xx_create_vm,
 		.get_rptr = a2xx_get_rptr,
+		.progress = a2xx_progress,
 	},
 	.init = a2xx_gpu_init,
 };

-- 
2.47.3

