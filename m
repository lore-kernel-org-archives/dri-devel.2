Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3756083615
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EW0B4fC/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BJsZ3tWQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E20B10F34F;
	Mon,  9 Nov 2026 14:21:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163A210F379
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF9EB334886
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=srWWDrFCDRP
 ROXZSUPlVHkW6pI+FqTKkKRI9cL3NTrI=; b=EW0B4fC/QDZC1aagVKgphxXkVXD
 sZvuRSbIb2abWe+ZD0XMtxLZ2lu5jt3fO85vMF5gYfLR1C02URSB0qI/fkEyS7ur
 nfxcLhppzXKh5lReIhNuS93O7xCg5yyyGK9Sw/NCfTmhVZoKmJem3RvNA54f9bWi
 zAIBeKBfR0pPopwX3KbYrU+9/4Ndc3ZR+IyJoItE+U7tn9KtYFKdyPn9jcakDNfo
 RvIgLmI3rSRRAFWxX7JJcd54QYRiAqFbs0S+geXpmRI7udYtt2q/cdYuXTYL6toB
 6xHn46xtFshVu8bcCInqLFslgcEDkNh6JGHjUUlACz2jhHKRbHW5+hzIyBw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf58jdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a05a4396d2so728357b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234088; x=1794838888;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=srWWDrFCDRPROXZSUPlVHkW6pI+FqTKkKRI9cL3NTrI=;
 b=BJsZ3tWQ12680eGFobL7zk+mSbpd3gCXfe+sEru3oIkkySQ/X8K7rQh+ejQN2G4TKQ
 G14ICuBwhVqeKfVtCMyJwmJJ+svYs7kWOntaDpkhX9XLitLtX7Hw6gJ1RmFF428vqchg
 ADM34S0v3rVktSZLqcJx18GaizTftPvJKDabQRMIH9NQH1r9zE94q0S3zyZfHYRH9DYL
 zJOqHSUVbd+maY4CJtP9yWtx4OoCbubpnli0k5sXA+h/EOfjzsgxMsdSrl1lmbyIiA9L
 WpV1pyg0VqCsvN/8wbsAL+e5e+EIX9asd5y8bPjvsn2h9cZk3e4TJUf27CTwaI3jqYCG
 64Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234088; x=1794838888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=srWWDrFCDRPROXZSUPlVHkW6pI+FqTKkKRI9cL3NTrI=;
 b=WH0CgIkjDmwHuxOoY147d2aQMPUdNZYXJaY4mhQdRxd+6w+BhtoZxCFCdatm9QgkMU
 TeGlcz1sA/muzFqzqfYEzzyjrloJB20+LdOW8RydNBOBqvsJikezTK66SZLYwOnK/RWb
 wnpVtO6Uv80bcIf9zbimNOkA9LrgsPuOsmLcHlmRF9trDcrzlIJ02MBV6cNFiZG2vy2d
 QYZMwzsDPQgjcGrc3/Uh1EqPYIpr4B7TEGtbFY/Ny82J2gGQrkvav2FSCl19Xkb6yFAz
 9+GaV2EvLQ/AUfkpcLtx+WeGe7pE9jr6ItRbHdPeIWB92S+wpx9A2ZW3eTk5zyLsVuE+
 Bnzg==
X-Gm-Message-State: APuU4Z/+waNtSllruz8GpQ3fcNjXgrFYqmGRF5lXGN+8IsAWQxOJ8D01
 WpYxNYSQV6Ssb6DHuesB4ozEsBH0eumcuhxIzeQOpqFzI9cX/Fxi9mZwcwmCebWfibyF6bmPhCF
 K6IHeOfQsHLCGLbG6v6SgoUOKH4i5tDIq5IYCOxrHVNRfU0mkL96iNeMd6l0D7rVqyGHYk19Wep
 k0ySfqvw==
X-Gm-Gg: AYBFou3FeVbXjSLV80X4emPdi/h/thDfeulbS0o0gyTi1CWxb+BpnXtLk1f4JpJBYwG
 x0IfcUj9rKOGCiR/DVKbrR86zTbjlA4/QLbMCU05VK990Sb5DBFX6gImASVpfi/WQN8cV508XQS
 S4MG5gibz63oASM+JiBUcWrhEigZA34Pdy45lWTbTxMH5hsMpkIJpA/I4iQZI51ZWrpqqie1QDD
 p9SFSaRgCSKL4IDLWq+2+qcWla3V4JyvR2pJpJR18g8kDPtBowuOzypFr4MVkl1kwEaAOkJuV5H
 pDBMsMagCDV4HSRdTLsfc8YFMJK+TTp6o6UP8YkGxulPaNUekbhQ8Ym4Dg/FHlgio5j/Pr36bGe
 CD12YBHAKAlMtxu6Yq7gwtLJUZs4OKfmU6+3R3BfEMaWxkCjYack5wVRZaOL19sUYem/9dEbKak
 vH59ewqAluoEej9k/Dd+LNEZrIFqlAtXAQU9kyGEbikw56IBZX9C1I4Sc2YrgDIg==
X-Received: by 2002:a05:6a00:1597:b0:886:cae0:fb6f with SMTP id
 d2e1a72fcca58-8ba54af5ffcmr253694b3a.14.1794234088045; 
 Mon, 09 Nov 2026 06:21:28 -0800 (PST)
X-Received: by 2002:a05:6a00:1597:b0:886:cae0:fb6f with SMTP id
 d2e1a72fcca58-8ba54af5ffcmr253683b3a.14.1794234087610; 
 Mon, 09 Nov 2026 06:21:27 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b64a1e6232sm1454677b3a.52.2026.11.09.06.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:27 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 06/15] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Mon,  9 Nov 2026 06:19:52 -0800
Message-ID: <20261109142111.256630-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p07E5gfQv6r-XkErwuR5_n36XFIalfxp
X-Proofpoint-GUID: p07E5gfQv6r-XkErwuR5_n36XFIalfxp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfXxw2Nt0UMh7uU
 P/Jmsp2nRHlZiI/wegYPk7Pzq7Ya1a1HEliOlNQS8VGFHN40lJMWPBT02vQ24zCcDPLiT32Fz3B
 1Itz3eqPmUSMpZT9AWejWIEhwKoTuWs=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af1d6e9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX5vi0fbR81rHI
 QTXAWfhqrWqmbSbup+JBggwtbPpYR5r9KoJ6Pi6wlouV+h1vfMXpj2f69Z4CaZtD8JzJJJN6Ag0
 c76roZs8Psv/WQ2EX83NY/vdUctLvi6lBQeJLbEdplxu7mDcFOdkdIGxp9fElbBQSqpsh42OJ2e
 2Au9vSOIpIT0DV5IWI1e/GToT6cVrfzCnHYfV52DH2yIwfbWHRwyMecr1BINmV66Hta5F8T6MpZ
 RnVdfe8KkfklbbhLE20EfM6mL+maF+5J6eV5OeNt6d0OOo+QUPpkaEfXo4pP12jUuSNJpwuY6vQ
 BBRyyHndA9OVH7x8ohkpktDdYL2NXT0xzvgs9V9ibYlOlDU6z1qXlvE5imewqncVTPM7+cMRWBT
 z38H7dBCuHvjvLBf/7k6ky7JyWcQ8337EbCNUNjs3xvMa3UwxTJEU5jNefUEl4Eb0t3bQNl6PBq
 guo4T+N38X4Hs87hJUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
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

From hw PoV, it's all part of the GPU.  But from dt perspective it is
it's own device with a separate io space.  So we need to detect this and
direct writes to the correct place.

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a29f8149493c..59898b49a201 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -373,6 +373,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
 	unsigned int pipe_id, i;
@@ -392,7 +393,11 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
 				*gmem_protect = regs[i].value;
 
-			gpu_write(gpu, regs[i].offset, regs[i].value);
+			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
+				gmu_write(gmu, regs[i].offset, regs[i].value);
+			} else {
+				gpu_write(gpu, regs[i].offset, regs[i].value);
+			}
 		}
 
 		a8xx_aperture_release(gpu, flags);
-- 
2.56.0

