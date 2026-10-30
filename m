Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D760A2604
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JW2Y/oK5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HzL/EX1B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6541129E5;
	Fri, 30 Oct 2026 21:20:17 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D501129F4
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULBHYs202837
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=evggxsHhN2a
 TRopkjxRADAhNYxlfnJlOA46wMGwegEE=; b=JW2Y/oK5HibHJP3bOd0oQuPvvPp
 JHiwzxsd9Za4rLwLwyUjvAQJx0bQ2++SUuPE4VeG6B2JP5xncZRS9+E2BkqRXpMN
 53YLXcz5gv/eLLAYRDDTap4ylUT7CPoc5YuqyiDf5AliLquEpnKa4N1iYlG9D5CE
 AjAojaGNjwOoyN9c30rmOuRE95ud8HAMJnuE9ps8RtLQRhA+OOc8MsXd7oudE8UU
 GUKnMgF1jEwf0f1lWD/HObs2Xxaor/TaLQyXcK1tbvidLsPYp83wdkFETzyVsqVK
 hucFrdi8v+M5UPyxz934b5jHXaEobG8mGBfzToxKvbT0/Tyc0/J2v3179PA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g1bu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdaf2073b0cso587228a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395186; x=1793999986;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=evggxsHhN2aTRopkjxRADAhNYxlfnJlOA46wMGwegEE=;
 b=HzL/EX1BUl/vK8Bn7KH5QW/DZv0U+ezafOHevh0fLfn6CEMonJIYjRsJ8uFp6DTKk9
 6tZ6H/80EXVQq99gHBWecYNEwiSh8QgVzHICQCcLsmSNqUd5s9GRBtluFvVK+XVcRbNc
 SZglquk0Ni4o0otYpLPebF1A0rvQAsdBAQ0nts8cz/EUPWjIHBgQCBl2o6x3zuacWF2C
 4Vc3KFNqri0Tm98/t+xRhLbPsX6YzIAxM6PqVK78qL43W6NxVbGME+/nFlSoIE7zf0TJ
 6+WMnqLCSNf6aBsI2GWym8ThVJyypgchGwidH2RM3VNiXBBpZx303M8k83Dz90ccJtaM
 W/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395186; x=1793999986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=evggxsHhN2aTRopkjxRADAhNYxlfnJlOA46wMGwegEE=;
 b=o+TNDIB51Cbr0XV3dhDLSlfC8X3oL7ROrou8oz+aCMecOi/Sb68qfHRzmzhc/nvpGn
 BGbhEsIbua0Kxhnha+/oXAjpn/tzXXkNnOKc95e4Pm3ZDAntfPBFcOP3VoTkoNHupzrl
 oMEbKL0mw1lKRgzB0LjRNGieQl7akhjYiYiZkTJcZZ8cnLczxYQb/B9jptebyDq8/GFZ
 BM+ZTP8j9JAtpZmAEqs9bNL7QWOyO5bf602I5nBxsNenRxxiCh/M3uiO0SmjQRH7UwAP
 Z9SsctCdAl5B/X1pI+ML13VX5EaDc4ytXA5WuE10ayqXDCo/6BB8Axvt479Wu692eqgF
 HbgA==
X-Gm-Message-State: AFq9FYJehjRQZ26pfYKCcyqVFqEsZebz9u5Y6efVYnj6UVj2yEapEMsf
 ewK9kyfTEzWVpYcpLyF55Exee4lLtTJKpSRItrQYozECO3s7rr4DNcL6sm5SNw/sHHcrtw6zXW4
 KV/BomJ/+TXqjpENqteckO0deScC31p8zQK+Mfhp72X3dVeibtAzD0cHXFl+X29eIkEXw6Fl3Je
 /TEoE=
X-Gm-Gg: AYBFou0B1RT9qm61SZ0UzpPEA1Hhx5uYZZyCYL5xD8lr6I8NHxruhpabS0PuL/8YYyN
 Zf0PbyZuv6hhGAh5GQMbN7fbpV8etfRoSjBYFTUFM0JUDZg4m2ASNztff3JqOPuSHRI4YEub6qk
 VslSeNi8u9VBLrMJMx5hKMDUTymCZXXfQcY1QUoOt9Jthc54vafNffmjF8QZcL+/e4TzkmlocNs
 TU81zDsIXcoodWFoys+UK2DZC7kGzQWZnMREodyAJA0hu4os+m3QpkEaGrmpeRDlt1/SPtHa+Re
 LAPMQJamAezRktMD8n9TLJyoGORO/7D3sD6GNtWGmVboLXaAUzoWa2QZQ+TSYD3WbNQZYFCVRv/
 bK2KlkH4Az9teTYAjz+YZH62ZB0c+nAjfF58Mj0YgPlXRIzj9ZNZWjLxxs+Rc2rE59SoA78VUTV
 Hk6GcbLfmZW91d29uL+aVgHLY=
X-Received: by 2002:a05:6a20:e20f:b0:3e2:ae03:b299 with SMTP id
 adf61e73a8af0-3e928f72ab7mr3093704637.34.1793395186425; 
 Fri, 30 Oct 2026 14:19:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:e20f:b0:3e2:ae03:b299 with SMTP id
 adf61e73a8af0-3e928f72ab7mr3093677637.34.1793395185999; 
 Fri, 30 Oct 2026 14:19:45 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9638149sm414566b3a.20.2026.10.30.14.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:45 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/19] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Fri, 30 Oct 2026 14:18:08 -0700
Message-ID: <20261030211928.45761-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4zF--uRG3YMIoXRWiSxGQdtNIWVRcdH0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX7lM4ozt87I1C
 KVnZJaEuPoIIxZth7QbF+gMl8KV2aE+GCIQ7sggm0mXxrZi/hN3U0IEKTFu5906pWKHdc0Y4poI
 Na5bcltZZWgFO6emN2o75Gl2aCPYtyw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX01abmK+2YlgV
 P3MptcnH4LXnZL/XyAcDlPm1DXnHydsRsGxCzGKiqij6KkuFdbM+dDus8t+Cbi2IZBDfqjvTnSc
 k7plEyQP5LRSR9kTAPODNdek9+QuxuUtpFHQzOWkJs1vrKXB5qUR3qMwgQGmiNIRnor+1kqr3tH
 cwEd1smTnkc4HHxocYrcSBGTkARfpcurI6CKIcj+GMD40LCwkqjsiX9fUnwURh3OX0d9asuKzm9
 +A2AjS2QSChK9SPgzkNa+qv1Vci1FGtcu13IWxSzFJ5zJTSp5vho5bWxpgd7N/Yt+EyrZ4TZsvZ
 cJctexX1Qq9EFl/1ntt6yqUDOdeuhpE2G62lQ2Me0ufFTYaLXnotKoq7UT2RiN7kj7PBGRvhLjI
 XvdS2n/9cyskQtzoupmHxbTZS5GLeA==
X-Authority-Analysis: v=2.4 cv=IpyL47/g c=1 sm=1 tr=0 ts=6ae509f3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 4zF--uRG3YMIoXRWiSxGQdtNIWVRcdH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300085
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
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 8e91edf16ec2..795c16d88f45 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -370,6 +370,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
 	unsigned int pipe_id, i;
@@ -389,7 +390,11 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
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

