Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B6FC982E6
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E48E10E7FA;
	Sun, 20 Sep 2026 11:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1aA7dT0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JdCRUx1z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC8210E5CE
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:08:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68K8VV8w2873095
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cabhqPDnRFFxZeQS+sv4cm
 /JJRYkr7vzBnhBand6l0k=; b=X1aA7dT0zS6nvlIlOMZgyU8KI9Hmd6m32ryNPB
 f15iYhIMBdmcumLS/3y54DBA7W4jbZZP+frgucAReZSgz/2Cb/2vl8B5s6wK6Qu7
 4eb4r9c18BMI+wp13lnhvz1Ac0kJcWgUyWlGx7IcleIPWfoHJpSw8+JDH8TJqIP5
 ID4dt9SL59wNhrnqBf87hZDiCcVnKuw/CA/eHmopPDIjXMx7Z2Bxh00wrNBoneps
 Zbd9Z9EKP6FrYnBV3zcYKWPofAHhZc29/90m33N1/g+O0ChyyUhxhlJuY7Qwqd+C
 YlGO8r1B9/Rf6vQ/fp4Yaogv4kW+Vu4y7ah3G6KsFiASBD3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshbsayrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:08:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0050a554so553015185a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789902535; x=1790507335;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cabhqPDnRFFxZeQS+sv4cm/JJRYkr7vzBnhBand6l0k=;
 b=JdCRUx1z3I6D7NKbf+5C5gmZtfORwDCBINi0g7NiJxuNqGYgRdqqocossl091as11A
 gQrCjVE/3MDy6XYkke6NwJ+mvTmNSJM4HOYmEqRP1u21BHH7XqYkuTqy5SqoHwQrDZvL
 CY7GFko99RiPKoZumXxyR8KYbCJLZgt7LRP0iDlnoDcfCqBxrjosD6wpor92Z8nfJP7z
 hNZQkI4UUredTT/4ZhM9Z3sY/SI9AgeIb49QotBj45k8eO9YPQmYcIiyQWdZffXiQjpZ
 xgbro/cNEfLi3AeRzzss0DiXxyyos+USQD1aMDBBQtEzpYUfBD7dnBhTl/XjMyuLSOdg
 WwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789902535; x=1790507335;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cabhqPDnRFFxZeQS+sv4cm/JJRYkr7vzBnhBand6l0k=;
 b=qiap4j05RDeIMquW49WthB8oZZXctAHS66/08WcdFT/lVIlQ/fIxv2VdcW7e4M6ahG
 THFtain+PGqtLp8DBs1mhjV95uaKr/ORUrT58wvKJoiND4ATrfk+RuG0HHmY2tUX3tR5
 ARRXoIiyM9XZtU+rl7lpQmVBHDpwPIUy0if+vK2ZcIfxFEaaJuZgrRdfIxSKQ+js1FtR
 0f6LG4Ow5XxdwwB7YRv00TTdZjB/M17aqLnLMWoxsRMKCQLl+zEXUZESBwop9QXHkSOh
 4izwE3LdOyZP9Nt7STZ18ZhnEqs0UWR3aqRNJbRwzqJAdbCkTPGew2UDN2kRAcZQDIp2
 nIFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBws9McGVfFx4kiqGUIFPAPUGoLlHcRa/Ih/PoxWv2ooVTRSlZymG0AxCRhlIsuwUYLqJ59GihVitJc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWQmuqvD2UYK0nx7rzKFmGoM/9/NG6CpfuZnrTh8vc6IXrkeam
 SoH8lQCRaMbzeAQefle8TI1+qMMsbqAWVJrBOxrXmi3et4bEaO9u7Fi1D16+ciisazja7BWgXPh
 f646MHRXM5NpFfZhq8EjTzUtYffn1j9Ya8xUILqUHmHtGw8xcBmoTB7h4RWviwipkB+EB8fo=
X-Gm-Gg: AYBFou0zU9mcUvCnNpdQ2vPlAIIin7SIFroyOOUf0C2sOh7kb7KMyRhYnGruzSWnjI+
 y3NrTmWXkBgPKIVBYF3az4WWzSOsH7VgGG8fPddlCmVVjkAayivBZggFvMmjzOtp+9wS3bxhQRm
 EoqjuXMyyDV+UEhsXcoZ2R/zQBsw7M0l6J6ARgP/7UpqgFM87INy4LfZc2LvOSIRohocayjUSox
 ibkaBwhlFT5CDQ4rbAa0Qfmnp91/qT+mhoovPz+ilF0kHTHJTgBp5lGzBPNJ0AOFbDmcGSsVc/n
 +F5kykIMBHc/QuQ5mLoXfu25I/QwnG1nS/qqFI7Y3Z+N/LztNjHnUtSVa2Oa8KzyCIvnxlZhmsu
 OyQZ+kNOj7xmuFosqd/4vF2Ghn/lcw9H83gzWs9YXbj+n2+pGyVrOrU/gyRZ1gKKZP+sTCjU5Ff
 hhofplbQEW0o+i
X-Received: by 2002:a05:620a:2602:b0:939:8905:ce9b with SMTP id
 af79cd13be357-93bf55544a2mr484188085a.17.1789902534748; 
 Sun, 20 Sep 2026 04:08:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2602:b0:939:8905:ce9b with SMTP id
 af79cd13be357-93bf55544a2mr484184385a.17.1789902534312; 
 Sun, 20 Sep 2026 04:08:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c795c7a4sm1190216e87.56.2026.09.20.04.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 04:08:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 14:08:52 +0300
Subject: [PATCH] drm/msm/a5xx: don't read the GPMU registers on GPUs
 without a GPMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-a5xx-no-gpmu-v1-1-714200254f76@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMO+r2oC/yXMTQqEMAxA4atI1gbaiL9XkVlYjZoBq7SjFMS72
 9Hlt3jvBM9O2EOTnOD4EC+rjdBpAv3c2YlRhmggRYWqSWGXh4B2xWlbdtRUka5MmdVmhJhsjkc
 Jz679vPa7+XL/+z/gum6HyiJAcAAAAA==
X-Change-ID: 20260920-a5xx-no-gpmu-128218b739bf
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4197;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kr013Ufa31MQkHDHr89ESzCC02MmnCtRi2ICjwnvrWs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqr77Ej292QiEnGqBxUjMeAHTbA1cKHVwf3Phlx
 PAUXmL96caJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaq++xAAKCRCLPIo+Aiko
 1ZLEB/kBuO6oeyZwGWSKoH9aOSuNxwj6P7dPfvefxA17M9Y5zDBnU7A3zBiL39tf/TXTFF30TEV
 swjSzazT4XumxWBP8CL+7Ni3bpB1qdEVzY6f3jiLnRAN/2GHzoollpxA+0FzXTmiV5Pk1o4Cqr/
 1p2I7v7xip41mnHOig3aHTD5p2WW1YpmEBEtDGh/1K/QY9ouFoeWAcQrhZdxUdH7KtrLDHJhEjY
 vOUVGy7pjyYnBtBkt+2wkM6VsED2nVDXYlO62SYFENusmsVoQ9YXsL4G5M/Fv1kOZ28RmoWIM5+
 FJKFsAiMAbk9j4ojT0hr2WwIdd5v6aopsLYTdP9nuBWQknX9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ht-qcsvnf9hFPYrCTN-HyHuF2K6pbfe-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE2MCBTYWx0ZWRfX2Z2XDTuLyPu/
 RquYZl1pSabdUBn5y9QtsM9VPV4cZzJsZIpymSfNbJ4uYWsRwFYQ+eKabNosasRiXnq6dTKtlP9
 TSOBTH+flODImBW2jVkNRZwtEBHtpJCVGH9c4tOZa6LVS10crDz7o2p85IsBk3WOTSQKOJVbuG7
 9fohP1rCxR0qYVZ9wBx616qnH9kVGf2yT+wDnap8HcMRptoAXFcFcRDyEQS3TcDufbDLKMwtNPj
 eA1I2fuSKdxwh8z7uj8v4i2DW8t3S8vTx5kaNBp4QGCP7VB7I9OFkbjGqSeX45abUrF6M8nQBFF
 GMVjA6UHm8eJqve+k1cn6Z9hiIh3esLKqBqsCpdDPziJLwHJ8es8nEmADJeURlywXAZRWvrbGb+
 hTh0s4OZ8nS8pq1GQcD71C4SOW38/8GYxBQMZtfU/6/zJFMyewAzZJoRKdd1cHTsi1bk1AkfGB7
 GtjPPyhb1/ONW8jo/4g==
X-Proofpoint-ORIG-GUID: ht-qcsvnf9hFPYrCTN-HyHuF2K6pbfe-
X-Authority-Analysis: v=2.4 cv=bPqDs/+Z c=1 sm=1 tr=0 ts=6aafbec7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=vx_jCk8yxa604MycbTkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE2MCBTYWx0ZWRfXxlhh71YSy6pb
 UAiJPqTMVlTh3dT43xRYETIbPS9krOBFR/ryoRi3iJWDjxvLKMMvT5RLL9+HnXgxz0g6oKM9Jpw
 E9v3Q/mln49RkxtgZkGdtfuGtAarhAE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200160
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

Only a530/a540 have a GPMU.  On the other a5xx parts, reading the
0xa800-0xac60 GPMU aperture during a crashdump resets the board -- on
sda660 (a512) a GPU hang thus reboots the SoC instead of recovering.

Split the GPMU block into its own array and collect it only when a GPMU
is present.

Fixes: e20c9284c8f2 ("drm/msm/adreno: Add support for Adreno 510 GPU")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 49 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 5d96b8f63156..3974aaf6fd33 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1337,9 +1337,14 @@ static const u32 a5xx_registers[] = {
 	0xE800, 0xE806, 0xE810, 0xE89A, 0xE8A0, 0xE8A4, 0xE8AA, 0xE8EB,
 	0xE900, 0xE905, 0xEB80, 0xEB8F, 0xEBB0, 0xEBB0, 0xEC00, 0xEC05,
 	0xEC08, 0xECE9, 0xECF0, 0xECF0, 0xEA80, 0xEA80, 0xEA82, 0xEAA3,
-	0xEAA5, 0xEAC2, 0xA800, 0xA800, 0xA820, 0xA828, 0xA840, 0xA87D,
-	0XA880, 0xA88D, 0xA890, 0xA8A3, 0xA8D0, 0xA8D8, 0xA8E0, 0xA8F5,
-	0xAC60, 0xAC60, ~0,
+	0xEAA5, 0xEAC2, ~0,
+};
+
+/* GPMU registers, only valid on parts with a GPMU (a530/a540) */
+static const u32 a5xx_gpmu_registers[] = {
+	0xA800, 0xA800, 0xA820, 0xA828, 0xA840, 0xA87D, 0xA880, 0xA88D,
+	0xA890, 0xA8A3, 0xA8D0, 0xA8D8, 0xA8E0, 0xA8F5, 0xAC60, 0xAC60,
+	~0,
 };
 
 static void a5xx_dump(struct msm_gpu *gpu)
@@ -1448,6 +1453,7 @@ struct a5xx_crashdumper {
 struct a5xx_gpu_state {
 	struct msm_gpu_state base;
 	u32 *hlsqregs;
+	u32 *gpmuregs;
 };
 
 static int a5xx_crashdumper_init(struct msm_gpu *gpu,
@@ -1565,8 +1571,30 @@ static void a5xx_gpu_state_get_hlsq_regs(struct msm_gpu *gpu,
 	msm_gem_kernel_put(dumper.bo, gpu->vm);
 }
 
+static void a5xx_gpu_state_get_gpmu_regs(struct msm_gpu *gpu,
+		struct a5xx_gpu_state *a5xx_state)
+{
+	u32 count = 0, pos = 0;
+	int i;
+
+	for (i = 0; a5xx_gpmu_registers[i] != ~0; i += 2)
+		count += a5xx_gpmu_registers[i + 1] - a5xx_gpmu_registers[i] + 1;
+
+	a5xx_state->gpmuregs = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!a5xx_state->gpmuregs)
+		return;
+
+	for (i = 0; a5xx_gpmu_registers[i] != ~0; i += 2) {
+		u32 addr;
+
+		for (addr = a5xx_gpmu_registers[i]; addr <= a5xx_gpmu_registers[i + 1]; addr++)
+			a5xx_state->gpmuregs[pos++] = gpu_read(gpu, addr);
+	}
+}
+
 static struct msm_gpu_state *a5xx_gpu_state_get(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a5xx_gpu_state *a5xx_state = kzalloc_obj(*a5xx_state);
 	bool stalled = !!(gpu_read(gpu, REG_A5XX_RBBM_STATUS3) & BIT(24));
 
@@ -1581,6 +1609,9 @@ static struct msm_gpu_state *a5xx_gpu_state_get(struct msm_gpu *gpu)
 
 	a5xx_state->base.rbbm_status = gpu_read(gpu, REG_A5XX_RBBM_STATUS);
 
+	if (adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))
+		a5xx_gpu_state_get_gpmu_regs(gpu, a5xx_state);
+
 	/*
 	 * Get the HLSQ regs with the help of the crashdumper, but only if
 	 * we are not stalled in an iommu fault (in which case the crashdumper
@@ -1602,6 +1633,7 @@ static void a5xx_gpu_state_destroy(struct kref *kref)
 		struct a5xx_gpu_state, base);
 
 	kfree(a5xx_state->hlsqregs);
+	kfree(a5xx_state->gpmuregs);
 
 	adreno_gpu_state_destroy(state);
 	kfree(a5xx_state);
@@ -1630,6 +1662,17 @@ static void a5xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 
 	adreno_show(gpu, state, p);
 
+	if (a5xx_state->gpmuregs) {
+		u32 o, pos = 0;
+
+		drm_printf(p, "registers-gpmu:\n");
+
+		for (i = 0; a5xx_gpmu_registers[i] != ~0; i += 2)
+			for (o = a5xx_gpmu_registers[i]; o <= a5xx_gpmu_registers[i + 1]; o++)
+				drm_printf(p, "  - { offset: 0x%04x, value: 0x%08x }\n",
+					o << 2, a5xx_state->gpmuregs[pos++]);
+	}
+
 	/* Dump the additional a5xx HLSQ registers */
 	if (!a5xx_state->hlsqregs)
 		return;

---
base-commit: a15fac810c76397ec9f62a6fc26c4d7ab6e238a7
change-id: 20260920-a5xx-no-gpmu-128218b739bf

Best regards,
--  
With best wishes
Dmitry

