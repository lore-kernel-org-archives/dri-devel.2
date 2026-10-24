Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51147606A328
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nVceZx+O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GVT1qnu2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B230210E7D3;
	Sat, 24 Oct 2026 10:30:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4EC10E7D3
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8otUD1167529
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j94BsXEDA7Y1sr27o39tNrIVO8VP/cqZsrlA9BINVVU=; b=nVceZx+Oaxtl/yF+
 rwF9rjyA8ux6Mh0FvrAXnPM+l6DRVSpC6BmuD0SL2fwkzv353uXQwvI7YL1wgRHF
 mrMTGdfC0ocmKg9NxblJ/3qdn9LbmPqKE9h18nzGLHe3Ks/GUPSrDgpBx5UaRUba
 q1qt/476MZXdfLmAHo8ucKguqctLBFbhTlBNRVoyopmF910B85hSmZPw3IKQrgL3
 MAMGc8+N5IwEjwzNycScEZHlfoEe31DGhxudnBumyuQyfzhHssINMviOI9x8qBX5
 70FQCT08gHxtwmuZMq/DOS+Mf2jitFT2lexQBm4GGGB36UVCBIw8ymW33pgOQiX+
 zEZzzA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3gqcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-18b5ee75447so6377213c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837844; x=1793442644;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j94BsXEDA7Y1sr27o39tNrIVO8VP/cqZsrlA9BINVVU=;
 b=GVT1qnu2n7uUEG8WFUTMQr0gmg3ENKha+NZTEnR0pk5IPZUrLKXA5aPbBCQEg4vdj8
 JW/tkQ09h2PctQhMN/7yJgNqdEtUMlJPbFDTuNbOMpsxvTDchcptdfU1keEPtUSSz6/H
 qmiw1ViY5eBVUJQLYW44+WDs4LfSjEJEGESVIQVshQHPPslwbYEj5wle/MabHs/ppHpW
 EGC0rUp+Tmc3HZVBF732iTvKzRTUi5UymlXqR/hEe0hJk3BoTGJ3KcMbzHg2X4iNkEQT
 VRQ35m5zBxpjG374Ou05rw6J5hsW4FHrAh6IDbAz35Rv0GFprq2wo5E5tX70UTH288RX
 ssUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837844; x=1793442644;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j94BsXEDA7Y1sr27o39tNrIVO8VP/cqZsrlA9BINVVU=;
 b=S+uOab98v6KbfeMe5cPw32FTc3Pcw1HgRmXVI7bQoyuUIszbXMOMAbIPH+5eLh1/eE
 S53Ny09C6XrgrkTVaT+ywpI/4SxGcAuc5mpQgKmilFxjXD+gOdMMq6EP2RlGxyyYD/Qd
 dAnP6VzngS4anrWHgjVs9KLwwrhxL22BDxC4tIG+GZ+SAshpubv0wCClC3xbZG1LFvrS
 aGqvDD5ZdWNmmNzEgQ6XVXGnyZ/4t4Pfqv3yC0NhZq46u4bfDPULB9aTamijqJfVBMT5
 JCyyDALDGJKs8xTytg+hDwk9PhDs9ksH7+8VZBIu76GTVll8MG9BnOFI882UMjUHrpfZ
 QqFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUR5jOfS7UfGnQW4b+yiF1MVmeQcaM0DGPcgtKd42RI6tyq1QGuVUESfDVqVyLTj+FC5rSpHnNvcs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLnAZR36jWA437QRQb4v8fkdP4gn+FhdJD5OkKnxK9UFoJOrlxB
 iBJ6KnPGl8myBPoqIEjSl/fyv02drJ4RcfGstNT+JtWEw09EIU2JtgkVW4eobKins+29G5XxKRP
 P68nUVHUyytUH0caJLhUygPYx9f9hNimKK6QaooCeY0po/LrSDMXTA/Idqm5JZldWEPjW9hI=
X-Gm-Gg: AYBFou2ZomnTY8cHr+jEc8wNdj10XXuh77kaU5TsadJJF1pDPol8c0qfiBB22elJMO/
 aGPI5WNHH4sMLyzfPB1mlSTtQeOc1TbTrjhJJ32yl9Gw+ivbP3v1Z0zaqzHGKHXfJwaFh2z437/
 QymwWQ/bFZ7v4e3RhlQggaUb2GPI5+bopFSrbwgRjl9Yq5PIAazZAUPn84u53mNIeOrY/WENa4j
 30J5+pfhXQvcE/5im8yf5IbYNgIdWigXzmXkqf3OByDtLJXjd0gjgrCCLncseNXdOHHzxoNVpY/
 P6e4ZrE12463eamL4aL8Lgk3H5XrV+vVgmrUjWqWSbKtwjJ3WLZ14pUk4/YAF14a4fRFD+CO6lg
 7mC6UJ2MDSAo/wa43kPrVJ2E=
X-Received: by 2002:a05:701b:4192:10b0:193:8116:f5bf with SMTP id
 a92af1059eb24-1993571a391mr2354247c88.16.1792837843883; 
 Sat, 24 Oct 2026 03:30:43 -0700 (PDT)
X-Received: by 2002:a05:701b:4192:10b0:193:8116:f5bf with SMTP id
 a92af1059eb24-1993571a391mr2354211c88.16.1792837843365; 
 Sat, 24 Oct 2026 03:30:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:30:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:09 +0530
Subject: [PATCH 3/8] drm/msm/a6xx: Fix stale boot up BW vote
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-3-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=3775;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=voH+JkrR9QIo+7kjwDUt48OKHwoMp5q/sdC06buV3JQ=;
 b=gJ33HT1NFi3QtbiCd69PZDhwQT3+LvJ4P8gpJokrgedWIzmsFNZ3OH32KpgHg/+bCx6vhYX+U
 Sk82RMQNEA4DmaWZen2Ox3AVyt2QqTjk0DFcpZ1GVaFzu1e78kgoiTx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: nZ9Da9KPWxVLlsZV9ynMu7Gksw9Vb2ne
X-Proofpoint-ORIG-GUID: nZ9Da9KPWxVLlsZV9ynMu7Gksw9Vb2ne
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX76zwPabDgbaG
 1KyNoQXKmuAlaUcr2u9UJQB00sBRwgIbQ0kJHgPCDJUeugRYLf4flipRqKDOBGz7FpMT16xvt8e
 ZKvJepnI1M3VzDionsemqwKfwPm20R8=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc88d4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=mfC4Gle6AAAA:8 a=daYzuOo6NrLquwzkd_0A:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=aghUjlmjzLPIEfOzDLpx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX4q1nH+8VJvBB
 gNu/qmsZBk+KIaHeuF+2PhjktIJCAiYRcgKaSZZSid/kjBz6Nd5IkOMuY5aYn8ZMbfKuYOEDE7G
 6/a62x7xyKaWuevYpYO8PJjcFUYj28Vij46riHVbXDPHNclEvvvBIUI6czgqc5QjW9duTXyMYCk
 b7SCANQ0Ktyu9efgFdSA3TW0ZEUK7w9M/WMNRpFZgnUUGgpYZoQRpdRP25whvYUdq0RiR3p+S1q
 cMiS5n/nuIBe5heS6oH/SeLs4EbT1eSIgdxKrufgR7zpwRamZVvyW1tHQq74KpIWdLpN19UyRzp
 unpP3vvN5ms4BSDkjM+MY175ognZ4pz7fzKN3ainTRUyo2/cxuxEPjRpF+++gqb92M9FlN47aE4
 llcnFxJpjeqmzyu6XDNZ6BmbPGNsSJk6rfCukXDRoOAmdp64q9pMqpp2l0g1qVWuCaz/UOd5Gjp
 v7fSDnDklw0GHWHwhAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

An initial bus bandwidth is voted during boot to bring up the GMU. In GPUs
where the GMU drives bandwidth scaling, this boot-time BW vote is
redundant and can be removed.

Fixes: 7047e655a567 ("drm/msm: adreno: find bandwidth index of OPP and set it along freq index")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 +++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 7e80670736a6..991db3c9cd96 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -76,6 +76,13 @@ static irqreturn_t a6xx_hfi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+bool a6xx_gmu_scales_bw(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+
+	return a6xx_gpu->base.info->a6xx->bcms && gmu->nr_gpu_bws > 1;
+}
+
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu)
 {
 	u32 val;
@@ -169,7 +176,6 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		       bool suspended)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 perf_index;
@@ -187,7 +193,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 			break;
 
 	/* If enabled, find the corresponding DDR bandwidth index */
-	if (info->bcms && gmu->nr_gpu_bws > 1) {
+	if (a6xx_gmu_scales_bw(gmu)) {
 		unsigned int bw = dev_pm_opp_get_bw(opp, true, 0);
 
 		for (bw_index = 0; bw_index < gmu->nr_gpu_bws - 1; bw_index++) {
@@ -1393,6 +1399,10 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Set the GPU to the current freq */
 	a6xx_gmu_set_initial_freq(gpu, gmu);
 
+	/* Clear the boot bus quota to allow GMU-driven BW scaling */
+	if (a6xx_gmu_scales_bw(gmu))
+		dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
+
 	return 0;
 
 disable_irq:
@@ -1913,7 +1923,7 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl", "mx.lvl");
 
 	/* Build the interconnect votes */
-	if (info->bcms && gmu->nr_gpu_bws > 1)
+	if (a6xx_gmu_scales_bw(gmu))
 		ret |= a6xx_gmu_rpmh_bw_votes_init(adreno_gpu, info, gmu);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index d3f6cd8b9741..b9e966e602e2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -239,6 +239,7 @@ bool a6xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
 bool a7xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
 bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
+bool a6xx_gmu_scales_bw(struct a6xx_gmu *gmu);
 void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
 int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 6b34e704a70d..ac684d72d2b4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -810,7 +810,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 	if (!msg)
 		return -ENOMEM;
 
-	if (info->bcms && gmu->nr_gpu_bws > 1)
+	if (a6xx_gmu_scales_bw(gmu))
 		a6xx_generate_bw_table(info, gmu, msg);
 	else if (adreno_is_a618(adreno_gpu))
 		a618_build_bw_table(msg);

-- 
2.55.0

