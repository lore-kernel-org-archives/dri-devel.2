Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BJwoH8pE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W8LW4DOk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA398112D4C;
	Fri, 27 Nov 2026 19:45:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8610112D33
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAv9t1127695
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rg5rgatsYgAUjn0TV/JmsO52huJMs9qOXDw8b3uaAGk=; b=BJwoH8pEeWIyG797
 Qo6bvaOVdTNdEUoA5w1vfGDImV1fdrPLjumpJQSujBWkWHQ8etPDk880sjmEg2TN
 lUmn/ah0rMFV7ZwB748yqXCBJt6lMfV1MDj0i2l3cj3ZszgpFRPuZP8KKvfqTCgw
 XPmB8/9SjmGbJ+tCddw523+FhuUjZTt5iFPr6X0TCgJeHawRcdtdW+1XIaMDjCkN
 j8za9cyXNeDAMvOgcBJGmPTg4a1TDXCH1NvZZdniw4w7Mr27GBAQGcZcTUhz6JzW
 YcybEiZE8G/aMzVNYHMNLas6myrYFG5DLn9tE0Osq5RgGeHH7XtKBClniq5vQpQf
 eHFkUQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6trvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso1473021985a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808712; x=1796413512;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rg5rgatsYgAUjn0TV/JmsO52huJMs9qOXDw8b3uaAGk=;
 b=W8LW4DOklufGbVzEt8ytK8QnTRTtTPDDkqaH+J14aPkZ8cdXi08In/baf9YUgKCagD
 J5jA+xKPs5opSg1DrzQuSg42DJzxwmVKpdYylQaZedkTcNE0FXtwkPvQSnP7Qd4Kaapj
 ojHRO3orukYnUq7JJDNhhBgynynFtVmhBFrbJws+fJF+BIm04SzIX5N2u+H0R1SBtM7Q
 4zx5Hpse/KU4o7dyAdXJYSyQ2H4XXE2xlabNDvPS8c3qaUlGnhNGBD+jp2ORQSAEASaO
 UIt4AAldfcdxfEl44aFfsbf2R2Mk/5Ryv6LZ+iiUemeboIRMXX4ftLmpM/HpWAGp0Kva
 S0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808712; x=1796413512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rg5rgatsYgAUjn0TV/JmsO52huJMs9qOXDw8b3uaAGk=;
 b=HoXDpLd6NQ+9+EeMxuvWneFOxi6qeDlET/ZBV5KPyktJJDCTOetZfToyyd08Kqi0Z3
 uvzQE9OyTEND3gKJeutSFQB4tMii51bnvQ+XmW2H7fQ2mZZUxXUCyTtBO6x24g6fihor
 jxzhD9ih1qXIDerORQ4TTrYu3SFV9zDzwM3V8M702KZWxmgzGHHaNHnurypedVk2Ac7P
 nheuBHbL7EDiNEx0/LV+ZF0HAPB2UnkXEddN23yed6PZlh5r4m1YPc5QYVcj7n2fFXbq
 iBFJR6OVTmDfWUh2zGkLpJO1ihqInJIlp6CvCM7gqnID26+0Uk7+VbnxY4x4OXaPi2B+
 QBwg==
X-Forwarded-Encrypted: i=1;
 AL+hErFpbU5K+mk+80s0j4fG8uLjmT3avnnDCG2XDIGf5v0cEt72pew+Lxt5q0b0kDmVPK6BlOsjoQ2OimU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80xLIt/3Y6nGIAsJW7spbdMoxOCQjrmWlbB1ABlU2g85cKb/fz
 RSjt8LBgNaU5x6WYsZf6Mj4zkfMjBkS1mZ099/9WV5xw6rks1MvE+CTvqRFNZjETfVVnigyoU96
 M75lEY7iM4Dths7rVkhY2wBgcONt1ei6e6SjEfywrU/LiRCaLR/2+EbncEoiNnTztb81qjBY=
X-Gm-Gg: AZFdTZceXR/0izDKguORmvSNZneC3JfMPElDDy/77TC777zrtTe7l/oQTwhkoJiavFT
 d0pdMMOzesaO/M7ilK9UW8J8lobsY2XcNF24ZJ4IeNVULJwBOUHWtCT7TCRJXeSUcs4Q0nmUS+M
 uPGNB9987Gi24M+ME9pr25a0DWjfCHRlralvJ1FpyZHayevdHz+QLMXU2QdF1ceRTo9+VYxVDBO
 kZI+7IIvbSkye593LGVOdO4pyS54RNZ6APPIzo8e95hbPVU9hdOemAUawtqHNHP0jsAcYQurjqH
 SVWOFC0+QsDHCafCYpSsha678vrXDMSGD3xx4Q8LeCjfS7XxwjWodP+IE7GOFDOP1vqd0h7Sl6P
 7E5QgdxPOUY1y79FetRxPs1mVU6wl1ItWfX2+yXsG3bV+YVKSao+BGOrLl2k0WrMXRuTw3zMG5j
 PQoleoeqDm0zmNTQASgmm12bNA3o0tWjzJeatZa8YI9t7Pxxds8Gxt8RTgS5ezbw==
X-Received: by 2002:a05:620a:838e:b0:949:2fca:4a82 with SMTP id
 af79cd13be357-949b3618329mr4506006585a.32.1795808712275; 
 Fri, 27 Nov 2026 11:45:12 -0800 (PST)
X-Received: by 2002:a05:620a:838e:b0:949:2fca:4a82 with SMTP id
 af79cd13be357-949b3618329mr4505999985a.32.1795808711810; 
 Fri, 27 Nov 2026 11:45:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:25 +0200
Subject: [PATCH v4 12/14] drm/msm/dpu: unwind a failed dpu_kms_hw_init()
 step by step
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-12-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3913;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=92eHwzGqthl7H8hl7x99iYr8YLFLfDgzG+O0y7VogAQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2rnOSvLkoi8SnbEwQZ0yVVu3jx6n1WfIXJi
 5zBUwSTbGaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndqwAKCRCLPIo+Aiko
 1ahUCACVwwHomX5/rpzyyFGZj6ynWzRU20p23FIbvc7HILrXOXzbxIedkVWKt/Z5LFOsWprJ7nR
 aAF5fPf4MuKjxOR7zuhhI99Rbi+TFzWzo43hqZugAdfo6bbZ5pgR9QEsRoASEMtjODHpnWzqMAm
 dq2IF3Qv+ad40QSriIk1L+Gp7qN16BmxdLP5K+2vKXxiOUTsUkkouWus6w7xuOVwk8WYt6CMuO0
 3IkjBKUP2oU3dy1nNHdHrjaRi5HKlNQU1g+3vm6NsYijUnq12UNZaQ4uGUqNw9tAgBa7HlVAMD4
 o7ioiPzPUk0pDsdsUfS3vLf7YdUsziCuZA1N72dlVziAI22v
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: IBy1wUSWcv0t0RYdkyjFyNMB0EB_dvOv
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09ddc9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=mqmjYGUTO374PHIbFJAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0r3LvmuMhZ1S
 vgVBiAUUJlEMvuVcVUDPahmX4Lr/wsW/dl3UC4sPW1UpRQvOs9ujknp25fs2rhGxfFnR6tmYuuy
 1BhNvUtfICCYg/zOhpj+WnqJ/iklKZk=
X-Proofpoint-GUID: IBy1wUSWcv0t0RYdkyjFyNMB0EB_dvOv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0VkCcpfqd7EM
 w5sLwY84C5OHKNGoF/pPoQlJQOPBQ5tLMdKvJTnWXi3u2czckTFOUpPT1RqngzmP0w+AX6dB7d2
 MSlqdfC2KQXDbCPZ/V8SAUpd6L3ueCHTZ5/UQQ1Yt88sBZ+RGPvyIK442WYjJuEFp4yJDwgkAGK
 0DMRT5XYobH38r8QzW4EXoU61rGvKncZoI8Bcgm3P3tGF9m3cMXWotiyepzLI3ERS3BC8GD6D5G
 ECSI5MTbbpFZ5s2ThpV/9XyglpNhQI2X3DZp13ydypX/ig0C+AE3Ti6VD8W1ywKoAjIDlWJRd1T
 HEWAmK069aBwCt5RSOTzps30V5igb+GkvduohNhU5cJ/zengITVQikR8+51lEISb5fapKR8nbv8
 gC4z/di98di50drPBkpmRcZbRA77klf0h76MBTOSlvl/ClglEpwJn6sZpVAB9OHEofBL9sB75C4
 1PgpWyUa4kwS2RYt7sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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

When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy(), the teardown
of a fully initialised KMS, whatever step it failed at.

Undo only the steps which have completed, in the reverse order, as the
kernel convention wants.

The hw_mdp, hw_vbif and hw_intr blocks are allocated with drmm and go
away with the DRM device, while dpu_kms stays around for the next bind
attempt, so clear the pointers to them as _dpu_kms_hw_destroy() did.
Otherwise dpu_runtime_resume() of the next bind attempt passes the stale
hw_vbif to dpu_vbif_init_memtypes() before dpu_kms_hw_init() sets it.

Assisted-by: LLM
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 934ba47b2dae..3546efacba3c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1161,7 +1161,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 
 	rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
 	if (rc < 0)
-		goto error;
+		goto err_global_obj_fini;
 
 	core_rev = readl_relaxed(dpu_kms->mmio + 0x0);
 
@@ -1188,19 +1188,19 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(dpu_kms->mdss)) {
 		rc = PTR_ERR(dpu_kms->mdss);
 		DPU_ERROR("failed to get UBWC config data: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	if (!dpu_kms->mdss) {
 		rc = -EINVAL;
 		DPU_ERROR("NULL MDSS data\n");
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	rc = dpu_rm_init(dev, &dpu_kms->rm, dpu_kms->catalog, dpu_kms->mdss, dpu_kms->mmio);
 	if (rc) {
 		DPU_ERROR("rm init failed: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dpu_kms->hw_mdp = dpu_hw_mdptop_init(dev,
@@ -1210,8 +1210,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(dpu_kms->hw_mdp)) {
 		rc = PTR_ERR(dpu_kms->hw_mdp);
 		DPU_ERROR("failed to get hw_mdp: %d\n", rc);
-		dpu_kms->hw_mdp = NULL;
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	struct dpu_hw_vbif *hw;
@@ -1221,7 +1220,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(hw)) {
 		rc = PTR_ERR(hw);
 		DPU_ERROR("failed to init vbif: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dpu_kms->hw_vbif = hw;
@@ -1236,7 +1235,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	rc = dpu_core_perf_init(&dpu_kms->perf, dpu_kms->catalog->perf, max_core_clk_rate);
 	if (rc) {
 		DPU_ERROR("failed to init perf %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	/*
@@ -1253,8 +1252,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(dpu_kms->hw_intr)) {
 		rc = PTR_ERR(dpu_kms->hw_intr);
 		DPU_ERROR("hw_intr init failed: %d\n", rc);
-		dpu_kms->hw_intr = NULL;
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -1274,7 +1272,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	rc = _dpu_kms_drm_obj_init(dpu_kms);
 	if (rc) {
 		DPU_ERROR("modeset init failed: %d\n", rc);
-		goto err_pm_put;
+		goto err_self_refresh_cleanup;
 	}
 
 	dpu_vbif_init_memtypes(dpu_kms);
@@ -1283,10 +1281,17 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 
 	return 0;
 
+err_self_refresh_cleanup:
+	dpu_kms_self_refresh_cleanup(dpu_kms);
+err_mmu_destroy:
+	dpu_kms->hw_intr = NULL;
+	dpu_kms->hw_vbif = NULL;
+	dpu_kms->hw_mdp = NULL;
+	_dpu_kms_mmu_destroy(dpu_kms);
 err_pm_put:
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
-error:
-	_dpu_kms_hw_destroy(dpu_kms);
+err_global_obj_fini:
+	dpu_kms_global_obj_fini(dpu_kms);
 
 	return rc;
 }

-- 
2.47.3

