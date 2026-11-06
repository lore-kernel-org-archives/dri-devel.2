Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A04606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DXvajpiA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VC1/pubn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566D410EAD1;
	Fri,  6 Nov 2026 23:23:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B1610EABF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MnoLK1063675
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=srWWDrFCDRP
 ROXZSUPlVHkW6pI+FqTKkKRI9cL3NTrI=; b=DXvajpiAJZ8KK3v7j5nbZV3MxHh
 vWzxQvQNKRb4S5U5aBbbJd3LCIob8sLwzn7vkYC/rim/0A1L2cRjvGWMBnRPdTmE
 LsJc8IflLn9JLm8ornSuKxhqI404CwO02EaO9/7CdKiiWm4j86R67d5Eu8wdqTcZ
 cjT95H9YvpAj42PDvL4w+JEgIXMx3m4ELtkT9/VL4V+c3eP2tK9JXzz3uiW4fifF
 45x6h/b9dLlZN0AJ8uaWqOHPbYpifOFetXie5oeF/PDOfHl1dtN9tED0bfP/eAPy
 5Fl0/9j2KAcdU5xe7VLi5myYR7oy8XBoe1F06mD+G5NCP6irY1cCtvnV5DQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyv0raf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so1127166a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007366; x=1794612166;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=srWWDrFCDRPROXZSUPlVHkW6pI+FqTKkKRI9cL3NTrI=;
 b=VC1/pubnDIsS+l4WQF8cymNRmHo5WBQpqzZs6WZA65PdT8z26lwRlnEQQAriqxCPcJ
 mbk7Vy3Y9qEleUO1lbwSdv4D0F46t5VSOLziDSy29i4LatShGjuwNm/YpRdrqKpfWK1B
 6fMOhN1tMW/sJY4SxatlkOR3IDLMyb14ttrI6DNrjCdkRKjxGB/w/nlx3FxQJJbasaGo
 hhaxt7DlI8cj/pTWtUqKdUx7cZRPffbYxmQCqrqN8qciNOzts675stXtU0OOTkAatfYc
 hggX/KuP9EvhVhqyJ5yhLMdwH1qV0edZKSdEsL+posqRV+dPoIFYyGB409Ch2/f4slp+
 9ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007366; x=1794612166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=srWWDrFCDRPROXZSUPlVHkW6pI+FqTKkKRI9cL3NTrI=;
 b=pNIqxU0pr06nG3exKtUYBgtqgqB6xnfFL+WxySC1iyO9Rn4WxBT5pVarIseQYesE1c
 bvLA0AN3M5X+DZr1zOiF674wUwqamRs2PVeC3ZREW3iLuIMzqbJR4uWRBS5tT9JsU2VJ
 y3FZDvzYFaC+A6Pf5wNm34UEY5rd+p/lo7lZirhEiTcTUjKGLd1Qjp1ECILZU0FcT3wI
 2LZvliEwqtWLEyfs3q+mxwXiL0BINvVQn5zeQq1F2IM4CGB+hisrd8/KYivHg2830qgE
 OhK315wYUCvJoS8B46dDnNVi2OgvUlEIfax7DH4pGgxEzzgZUmKH+rEqv7sLnFoPboQF
 rqCQ==
X-Gm-Message-State: APuU4Z94+V8miRiVIchFsjpaXIPKHm8xFVcTR4rROCio+iq96er3PlD1
 iDIQe/kywDsogU/PPHxIOgjfwjf/AeoizE99nSrf4Vk3Y3Kd1rdJxCiN/sH5OfVBUNkdd2T1W5o
 lew1R4BHP57idza+lopdxqT7DVUf8Cv5tlDJYOy9iNHNL4pB0rgOoajf9P1x951fIi1TrVV3R/s
 bCPMU=
X-Gm-Gg: AYBFou3Ck7KrDM10Wy3wPjHkOejcD1NCWz+mJUVBq+YLclRvo7ShLCjYnkX0+6XhsXU
 Q4zu1WTzD7syGcziYr8LtSa4677mF/fXrIafsBJsbCSIsLP8PpKR1PEd+gadW/IJRXnoaDYvLAx
 lQFhUvzwb39Sj3hjiTB2VX9zH/GKQcXqdb6hXKIMI6DQQqOU3Ln7vG3WcRGbWRDRshe0MSwiEFS
 aH9yA8NMVGgCq1ZLAUtuddWK6/LJn97/kU9Eun3sXsVySSVZn8MDgqKdqZRFgwB0goIqEEN4uhO
 tin5Y70RT6Q33rfAJq8GxZaptV1x+0Cf6YE8OAXdmtSl2bxLOnELMfHIReXAvdNvdibqVfi6w6c
 kEnkhpzWXiRyT0qrk80cVnim2CuE5dqXLz6c4mbjDIGkKBL07S3FwCGI/H0Ck2i9y3QS2+BPI5n
 ksKeIA1x92Sv6sstjOr3xx9YWCzrYAnTXhLw/68EM8w4lJ8rR7o6h3PW8GCo5eeA==
X-Received: by 2002:a17:90b:39ac:b0:3ac:a139:1b13 with SMTP id
 98e67ed59e1d1-3b0db6f156emr3882670a91.29.1794007366481; 
 Fri, 06 Nov 2026 15:22:46 -0800 (PST)
X-Received: by 2002:a17:90b:39ac:b0:3ac:a139:1b13 with SMTP id
 98e67ed59e1d1-3b0db6f156emr3882652a91.29.1794007366006; 
 Fri, 06 Nov 2026 15:22:46 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb70a04a39sm1010142a12.15.2026.11.06.15.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:45 -0800 (PST)
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
Subject: [PATCH v7 06/15] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Fri,  6 Nov 2026 15:20:58 -0800
Message-ID: <20261106232220.47602-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0kWqQUr4NYNoBPVZ0PaPkEWf44Tc7OLt
X-Authority-Analysis: v=2.4 cv=IdYSymqa c=1 sm=1 tr=0 ts=6aee6147 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX9PArGsi5ubOr
 btbO4Z0xAg85zAV188qMVdsVd1jaCvBq8Y9rXEyjS3dpDThF7ku1UvkfjUPxrIK2Kn1nQNpi2Vc
 yqKe/8sK6YLZJJxngexVCU5kXEwg97Y=
X-Proofpoint-GUID: 0kWqQUr4NYNoBPVZ0PaPkEWf44Tc7OLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX/jYaCpLw3eHY
 iIJ210MDph5uKOp2g3kUrHRPXWoM8E4bGQ2ZBbLfjt4ds9a/ofyDg3v9V66GVQU8Xq929cXCEvq
 wLJX4LrqhT0w8nPXod60uc++ivzJISvBZjzJqGECxJWEJdwW8+KIJEMumggkrpskCNr5SOHso2O
 5s1SGj/4VtvZ3uA+tIphQYqnqzqUujKaw7DsAriJ8RIOWttnD5T6rPeuCybldigWQG7XJmsQswp
 aMmhZCR22x11T14SdT1fSCm6giCSJFjvV8MgenzAlfVKpqRoKhDHvforDET+Ej0zJ2cMeIrvPsU
 Rkm5yxmPNvPz3TziGg1ur/IiKIHwJQ/8IIezQ4+j7pr7BXHR3K+3Imfv03jzZTIsM3+69VqQ92J
 8ooZ1PswEfVJy7wtnftZY+EnFcC5thm5ILtvHq1cScXE5H3OFfFriIzxFZdhDjtEnH7C8mVf4pe
 tFOY8QZYJJov1+nYvaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060093
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

