Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCF606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VA1PesVq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fsyvYz82
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874A011253B;
	Thu, 29 Oct 2026 20:18:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81534112527
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjGXK1077310
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yTsteG5a3Ia
 JO/lb122nv9JtPhW2mkEDubQMWm/3wXI=; b=VA1PesVq2urWe65w2PmaqXdjLxb
 p2iVzsPBZpEMkXpV/C3taM1Rj6CMYHclPnntq3FejbeWQGklnSBUsQq25KQ119MF
 nolz8Hzb8cK0a/0ZEG3a81noVr3ARSK2HXXDZxNGWfXMN5nYAIpQS1Q/bp9OTUVW
 FMXcCcUuCdcJ3Q5finPQL0btGxGAXVXLGOJ+DqncC4vRWpuZpxzQitWeAgr4ggqP
 oCuX2mqfMwU4HEI5ZyTiqf+H7reAR7YEzVIQF+wwjapNDl34rvflgRrs0yORA6In
 IDZCblL1xcaHmysbcGWnhizTHd7VjF1ZfggEvtcYdITrRY0b7sH8QCUJLdw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmba4rhhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2eb362d1f5eso200845ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305077; x=1793909877;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yTsteG5a3IaJO/lb122nv9JtPhW2mkEDubQMWm/3wXI=;
 b=fsyvYz82VkIf625mRfViOEamNDbqbRK3p8ai/XLWfmfkRayHcTQb0JSSZnDHQORphZ
 aQiK6MdlQRuoGi03pNPBz103i3Rv5TB94qOoKSvqDdrbDuMnsLsOhADqH9CIfclpzVaT
 Nn8yuTmun1mPn74CINNdArBfW/BrxP4c7+pBBmS7Dd9k0imj8SB43jKWfovV3+xbBCiK
 13ijq3lcDtFAnoS5Y94zo4uiln4EO43QeKHp2zlBL/fuMS8SbDzNqv2aAXet8KJRIlbK
 x6HTGJVlg6wQHVV+LoCXamPAgUF8JxP5ZjnWuq/8fjubOvBJdbipRVjfKgrKBganOh2l
 nkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305077; x=1793909877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yTsteG5a3IaJO/lb122nv9JtPhW2mkEDubQMWm/3wXI=;
 b=FzNWDHsaWfUh0WrdT+oR4Twn/DlsUZOcjdalUIf6/6xwA9oltX7Sho4joOMUjN7pU3
 kaOAocfUIkgdtFn1Pbwx6JP1BktXsi27CwM+ly3DauXZALNozzNhbAclZGuuU4thicRD
 s1gpz2eixjHjdGmR+aXgjkblm7pXSNGKRbhKaFWKSREHC/zYwQ/1tr3WR3onNrsdGtZG
 Sfy3bikYB7VSwnu1yp34MC9Du2xTOuUSM/Qjf6GCUFPsNo8TPsjTiTo/GHu66SEjQZUR
 I/yL0fv2ffmjncdUNd6y0ukfBZSI4+kbQVvGGpy4LrJCgcTO7wZ9BzlSqx48ncptw0g5
 MwIw==
X-Gm-Message-State: AFq9FYK+XiU/KJ+CtkKrKkUCEASNXZ0kKVjL6+hejvJUYFrnQLAC4Zr8
 dFjrAvSzluDtv7PGT53YtrUI0a5nPcWL8REBJTnVde8a9qxMbEW1gZMLNdcXXOwwVoxutPUpd9C
 QeqmmtdeWgAsxogLno4k5WHUveRNaa8yq3AxZcqNof5m8O6zHCcMuQBGYQkIAWVJoK+q8OfGvJw
 PDNSM=
X-Gm-Gg: AYBFou0w7fdO+AzS8WF6PVndP8k44w1CuOyHtrQ6jxmloHbttRszbxCB/GX9SKicCIk
 M9tYBl3RT1nDYZcsx2kWSObjINRq+AsHOP4/vT99Ca2BcfsOaZ++nqaH8QjQYGIyt26blTjyc4u
 hVFGur9obsfU812mPgO1kWjGmx9msAz/YhvYyKYCqOS/yzX7g3HHnTj/5cfZqjir8ROqhIWaXyV
 O2lZuGwr5UQr1ZH/7zb4NVDzzr4QnJLIoF5Y+SZxytn1j2bCY59dkTdPkRyAIBlM/f45DkEImsM
 fOVRHARSRqs8kbDE6vWMGfDLO8RBEaOaPN2eamjS9UB3lodqdgOB/3nH2vL5ixLGqpEVkCMGEZc
 4JUlGwh4Pj1+EEEiKgR5CGFt3u+9pelf5BMZkdKAu3HwRP2Wedtswuecvq05Qy7iy9+hGSWnzt7
 LiRLCPXRmZiBlq+mJm0gsX3w8=
X-Received: by 2002:a17:903:41c9:b0:2e8:2d05:9780 with SMTP id
 d9443c01a7336-2eb36414e25mr5294045ad.8.1793305077227; 
 Thu, 29 Oct 2026 13:17:57 -0700 (PDT)
X-Received: by 2002:a17:903:41c9:b0:2e8:2d05:9780 with SMTP id
 d9443c01a7336-2eb36414e25mr5293905ad.8.1793305076784; 
 Thu, 29 Oct 2026 13:17:56 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3694e20csm567305ad.53.2026.10.29.13.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:55 -0700 (PDT)
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
Subject: [PATCH v3 06/16] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Thu, 29 Oct 2026 13:16:16 -0700
Message-ID: <20261029201730.151754-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pNFB3PPS9iIAiuC5TBHghiFBMdUalsMG
X-Authority-Analysis: v=2.4 cv=X8PHu2Te c=1 sm=1 tr=0 ts=6ae3a9f5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX4axRzUObF9op
 B1erIO4MnAQqfzdiEuQ71z35bwDPeXLp5wJzT/4e3rewrQys42rqId+S3FpAPmGnwu22IQk23Id
 NQATNXRCqyD5aJUWSmC4+tQJn/qkIkyz8hakcArkdEvvkWc78uI23G+QJMXpxsfF2GVz3JbEC2p
 5dXW/lxNismSs/Q3GrzfMVFfg8Y6qTRelu/zFwnU4B3u0Jp6M3d6syFLPqSkV/s/p8EOsC8yvdC
 xVqmKZpH+ha6Dqd3qarqapfV85KiYbZlpjrNmduETT3pkmeFPzSMtuvJfIIkJWGafoHi2OSwejp
 xzKYrccBjLz+DeEJ0rDg42xUaJG6tRf0MmpsKulOioUFIY0hhYYCU8shRokpQygVcsUa+kD0OUe
 cTYUfzka0ZMmqzW0Hw2PMa7WNXgCY+o5ztV0L3d9nH76xTDD92BsU7I3gxDULfKebQiVrSqBRhN
 Qs9BGWP4ITPtiiZR0ZQ==
X-Proofpoint-ORIG-GUID: pNFB3PPS9iIAiuC5TBHghiFBMdUalsMG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfXx5LMEEZG8SNp
 Cea0BdFk3fPcbxnpiekaGhG7mwX8aKSuuDV0xW6xCIXYllQaaLccZpaNQwV8Rlqrm02Keon6MwT
 NgqTBUlTkqOP2u8fUuPa59PegPchdQU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290079
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

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

