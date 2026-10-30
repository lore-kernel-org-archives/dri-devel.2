Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D20606A331
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JfLf0274;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O61AGZ9Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C448710E214;
	Fri, 30 Oct 2026 17:10:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B6D10E217
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKor2495308
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EOWyfjg320LsKD74ASlFLIJyIS4lGcmnKVpPXhAJO90=; b=JfLf0274sJkJhp0e
 MpthktA3hCXfL601o8AhP8utAJxsqLWLvT8cAbJ8UCxw49uft/r5x3p0nITHHemH
 uoYZiw6PnBzU0j9uT/yR0ktYe9/NnU4Yjmlnuy5YrzeX6txG9hfAhLskFAvWC+5+
 h8pttzgL34wtBJ0npBcG7N2f0AO63ONo0aLMo4F8zz5vZtxla49hOyk5MD01wcpU
 70D7wuGIvhKf2ov2A1iBILuBelpVqmz3yKZiB+15MRnloMxP/9uz7VjHPlMdplj1
 j/qTl4UoNgd+n7zOuZkZkJyoIZor0VBzKrAJzH4wzsRxkSTWrXgHWXFNkMqpUqoy
 mbfboQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p46ka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:03 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so1452448c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380203; x=1793985003;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EOWyfjg320LsKD74ASlFLIJyIS4lGcmnKVpPXhAJO90=;
 b=O61AGZ9QQV1KznXvH2j1Bee5jGglK4ClJ2nGIvnNYucFmog5SwlJFkI9hRFoR+87E5
 saA7h4unMrs9erb3HRbIy6vSto71osgNAIf5pxiScNU5eqVFBMgRbVpzLsNyZGSRC+PD
 7593saj8ZcSkZCcZwPeqkc00m+7b2vsfBZKl22iuD4GxLIzK2latauaCZMv6niWKrwvV
 pmQ3f9smCju25CaZPedKXkYThuH7uBTu8yP1wolwIeLzGqBQNCKMKwIduXOruLT4WtgT
 1ckxLiwbCI1oQVvQoqZg9t2lLdZAEm8C1kzSQrzgS1fY5vMGYNE+MNJQEynZIid/f/jF
 QPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380203; x=1793985003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EOWyfjg320LsKD74ASlFLIJyIS4lGcmnKVpPXhAJO90=;
 b=U952+p1VW62puo/IMuY22T2ks3k12Qsz8En06DeZQQwX+khESmYLYTSpiE6aV5t68F
 B5NtA4WMtRq35IwtAJusViUtktD+VhfuAZt/srH2mZChdwEgBmGLP3Eyu9cyxVMV2lqG
 9En2CZx3ga/q89ZXFCcySzW3kh2e+JTZvvEf9v3jiYjICryxgtskiLQNtx1l+F/yr2mV
 J9Hl5I2MADtDpowxZwZJip0OvER9QdQz1SRXLH7NRc3tk/GmS8ewNst3AvCvBjhE1/T0
 JEC/9gIlrX2nvBVglCXYpGD7euPs4KDMmQOUmXlqDaxmPB0Wrde+2Jq8CgHEjdYLPqom
 WNSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1pdN2XOXIMUMpNUBHKZ2OfvvM6kh9VchsHm0xfweJy1ff0O7LgOKwgxwOvNVvT6XqekxYJPlP5y0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJG/cED/co+q354HzbJgppi0A8jOq9T6UsHCPhhiLpl/FK1uLWS
 3L24CQ7J7QJ1w3vGi/0A1n/TF4nkaw3Ypra97Ny9Uci+6Cc0SE7VeMxEYS2MZVdvFvOBjTiqNTL
 o2s0q85xHsh4fUc0roIxHrGruRaNixeIrQc/W+lCQ/xM1A8hIJPnimKywuWC41xEk6cvPuRM=
X-Gm-Gg: AYBFou2UyWeG9MFK2Ilx5HYb72/whMkncOzKITM9yWvWFLZdD22FKTcEoJuiFxM34+6
 YjIkrYjHfqKI9FCOpixbyQUNAMni7dwCp1zW37lgwiUNkJd695u93qsSKo4e+znw6Oj8/Rvzxpz
 sBNQx9yz4+TlffWxHUvAYTFhkvqHmHTEAsIPKoZadYrNdu8kLM8YCDWLBumNFtmZS2qAC9xnGgt
 R9D8OHNCY8wDs2K4V+pXdUvVmRHePEzetIovJ5/wNeSMZI1RDxZqAJq7/JbIiNzf3w1EBLgV6m8
 NBWeMhqpBNwRXSooCiTZq1+bPtdRbQ8sAppj3TgueY9p0TN7vYk9PRakqH0hphH71mqPQo+ma9i
 G1ZMf1EbR0zi5koGWk0+UECWDbYlCZynVfwq7SeSKOkehPExr75Atjm2OHqmXfhrYRd10NY6Ujw
 ==
X-Received: by 2002:a05:7022:3f0d:b0:18a:8164:ce4 with SMTP id
 a92af1059eb24-1ac4fb0c60amr4017429c88.0.1793380202701; 
 Fri, 30 Oct 2026 10:10:02 -0700 (PDT)
X-Received: by 2002:a05:7022:3f0d:b0:18a:8164:ce4 with SMTP id
 a92af1059eb24-1ac4fb0c60amr4017380c88.0.1793380202065; 
 Fri, 30 Oct 2026 10:10:02 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:10:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:25 +0530
Subject: [PATCH v2 4/8] drm/msm/adreno: Simplify adreno_probe()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-4-89d3082d97af@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380168; l=1922;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=4IwBjgmZtlASF3bKahjtC27XmmmLfOr5jE0Tf4p3+0I=;
 b=31I4AziRK5+9Pqar0RIswLtFl79uUaePJYhCKxMRgXVX1k0FJpRaM+TKifUzVhcEok2rF8Hgl
 uGnViKYuy9zANDEc5IhfAhhJiKWOlXyNh99TCwEKNRodCkO8rXfN/Yv
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX41tX+zohla2B
 1Rs7JH4JQvgZ/708slrPYj8McBXE1IGwjLYuU5/xDsHfj/j2TMQUBGK5Ue5q4XasebAFj9Sds/h
 6uewnGhbm4THJTU8C6lBQkC09a4TUkT8d/qF7HFknTVmToZyM6A3xqwKQIPkvJu/0lvA+y9tTff
 gSSNHcwnNSVeI8jY0UP+IHo16OSeLYdp/aQlJqCJKTjG84ykVuR38kFd41eTMRmfujn9HgFgIK4
 CaUWzbHl5kN1iASzy1nzU9kyGJCEeCx+GH1WUieA7dG4H4gqN3DzdThOHUDYscKlYwBNQuIhR82
 BiBhNtqtQ859AUefsfYlWLixdASkL6ojZpBy4ywbt0VwGvVUFkAODCX4BQqWxMnT/ujMxIE/X3H
 yyhq60SrxUJEP4QordvaRUMJE278YcnhHzlwsirREHyPHbrVTvhc02S7UDAwLkdI4PdL+McCLkB
 8h2xlSA5Leh2Yx0BlDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfXxNa726Z/mw0F
 O2CCwAKn+JcXSPco1M47CGdEszpqLpZtSJDKFu00lqq2Ut95bSxW0vtwm678viOxMbqHo10T0bm
 saGhg27ptM8Ulg1WJENSQaQKnqlnsoM=
X-Proofpoint-ORIG-GUID: QCjpUbnPFGKfRuCVAuYKz3GYBU-xQI-f
X-Proofpoint-GUID: QCjpUbnPFGKfRuCVAuYKz3GYBU-xQI-f
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4cf6b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=7EupJXidagRHOzv49WEA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300068
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

Now that it is possible to auto detect and create separate drm device
for a "GPU + no display" case, drop the special check for "amd,imageon"
compatible string in adreno_probe().

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 8 ++++----
 drivers/gpu/drm/msm/msm_drv.c              | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cdf26b38b904..34718adefbfd 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -271,12 +271,12 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
-
-	if (of_device_is_compatible(node, "amd,imageon") ||
-	    (msm_separate_gpu_kms_components() && adreno_has_gpu(node)))
+	if (msm_separate_gpu_kms_components())
 		return msm_gpu_probe(pdev, &a3xx_ops);
 
+	if (!adreno_has_gpu(pdev->dev.of_node))
+		return -ENODEV;
+
 	return component_add(&pdev->dev, &a3xx_ops);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e25ef578d2b3..e0c0f1248d1b 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -115,11 +115,11 @@ static bool msm_separate_gpu_kms_auto(void)
 	int gpus = msm_count_gpus();
 	int display_subsystems = msm_count_mdss() + msm_count_mdp4();
 
-	if (gpus <= 0 || display_subsystems <= 0)
+	/* Single card if there is exactly one GPU and one display subsystem */
+	if (gpus == 1 && display_subsystems == 1)
 		return false;
 
-	/* Single card if there is exactly one GPU and one display subsystem */
-	return gpus > 1 || display_subsystems > 1;
+	return true;
 }
 
 bool msm_separate_gpu_kms_components(void)

-- 
2.55.0

