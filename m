Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE7606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k/zcNqib;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=alE/Uui4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A61F10E70F;
	Fri, 23 Oct 2026 23:21:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35964112D30
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvG2b297426
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J4lgPqXZovRq5NOnbz19RGauzLDixNMu9fw1Cvv0pkM=; b=k/zcNqib6o3a3F1E
 UiOycBmImHXspTfur9uZU5ciDwoAKETzh+DVgpD0LF4xgWZmN44tN1jU8fMx2X2g
 VsJoFarfRpjhzdV+Fan832+Bb2of1+vE2jEjL0s/4ZrJ56ytKmPVl+YPtdsPDZBy
 NqHMFLYoScMVLXc+8IpCgMGu9fpts7Uk1II2KK0G/kY/B5DTeB6ncjhxeMDhq12R
 1UFRZ7S9W7W7Zrzv0GD/+wtzStBn101uKXwa66fooToVPIuaJ/AdnL/8CznT3DET
 1l4tQrG4HO0lchcI5mFlaX0cxk61DnEYX+qB+hB2Qj7t85y7fhC4SJb9SFz1Kr2o
 mvCrVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruhc39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so257064085a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797636; x=1793402436;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J4lgPqXZovRq5NOnbz19RGauzLDixNMu9fw1Cvv0pkM=;
 b=alE/Uui4MgPu8VxerPN0DfMANuPW2TSWAM//fc5gnVrX+FyrvBGALuz9joHaf5EOZs
 Am+IWz8gtX0yQN//8Lxm7P2bhDRJS8XoygF6iZvc+qdXU9teb6+JHBLb2kK9kew8QWZM
 CMi0EkZK2fMmd4/hIoLQdyM6g+VJYqZSEVFf1Sud8kImJbhJkbr2V+vt955K5SnqFhUP
 4WuR4s8YZn61BAFeh8pIE210qVVu6A0qFZPv8I4dWrBhODu1AQK0OG+62PMOnI11SIj7
 VkZLAV+f6HAEO6pbvm0Kd2S0ZAPgBxpclUXflYe5b421IUtncOMokj366TWRxCp4VjpR
 sU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797636; x=1793402436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4lgPqXZovRq5NOnbz19RGauzLDixNMu9fw1Cvv0pkM=;
 b=Drn0+Z9YVSR1eCs2lVkHLO6wsGs9BTNY+KjJC5Vu7cGn7j9xrso5xcpnMnCL1pWQZA
 9GhxKz+JlT+u8d81oacyMXVReSaFkEIIwMtlw783r01aA4APpmrzLPsIqrYBdwjduuL8
 UWgChrFn8hwxuvsjafQ570fjzRO+CjNB0D5K9yKs06UsxOPvjtMwzZwP4sHZfAScSxza
 9uCKST75N+fpA9rS1WXm87hKjyvrj4RIVux0i6aA8LNZ9cE99ryJ1gY++QIOY0UC/GL/
 K+0awWLa/k5s7setzMkxLTUfBTvMqQQmj5uaQPYXC6eEReltp1a9A568wxX087JwmIXX
 jqDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQU9HONHcuqD/2GRfyS88IZXnG+ObKNMLCnhasx0bQeKZi1o6tBx/Zm7IDzPCCbUIOMX7iXCBDXWs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcKUPOrQx6eTrmzKFg6WfH2PvB8ebLGCoXFScCkvlfpB8eB+cN
 jbTv379bPn4vcUkpr4I+cNgOt3xGoFKUnZmsgxyeoZBUlSn1z9gMJgId0+t+YDHwFtwsBTi9dtM
 RxCLL4H0NiJI5FJCAxMR5ydPjg/6Wl+mUBCxEZ23F4ZFp3nzENmO1E81hr6ZsUWptf/dH1Ws=
X-Gm-Gg: AYBFou3kEIXfiK0VIPRF8/y/TdTBvfXTR+fudLEfQEX4H+tUIVxPHuBuf6HXafhbIkK
 TMzNMmmOlk/mL7+SYcZO/NJTHI1KKSqpI+k6Nd0+9EQ5VFBzpDvxdvtn+A8vyE+b5mWI1KA7JqH
 3mp0hL1PNYM9+Y7bX+p8lk6BPQOsKYQwkZdTEyI8jckCPaim7wm+Px5+6orrd+8BJd/LrPpVM/L
 +VOZ+5rzKiw4wsPu+TpIFnakiLkRzkhpgr6Ij1CBOG8HLtlhGr2y6nORt+fBp7jncSDQtBb8L6R
 O3PCvCd7LjFF2JwzR073go+i3EAvrcE6QBPteKht2CmuUQXdsNGNtlZm8qePMxcfOpREGs5PaYn
 ElByj5jhQl8UnQ36/UvbT9JGLiQSDxnqH8lbEkKen+wlStdqtjWfE4vJPiln9pVgRM4lfV3QaQC
 mNUxdjY+UZD7ad
X-Received: by 2002:a05:620a:d94:b0:93f:59b8:e29d with SMTP id
 af79cd13be357-940efaf66e6mr77845385a.26.1792797636376; 
 Fri, 23 Oct 2026 16:20:36 -0700 (PDT)
X-Received: by 2002:a05:620a:d94:b0:93f:59b8:e29d with SMTP id
 af79cd13be357-940efaf66e6mr77843185a.26.1792797635887; 
 Fri, 23 Oct 2026 16:20:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:45 +0300
Subject: [PATCH v3 12/14] drm/msm/dpu: unwind a failed dpu_kms_hw_init()
 step by step
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-12-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3855;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CqSiLL5IBlX4YCUe6BZMO8fXF9pjuxvbGKp7tY7bOYI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uXRezNuWAVHO0XDxUZpHkJhvnEIk7EChiQR
 Fo6aKhsGceJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrlwAKCRCLPIo+Aiko
 1RDvB/91eD0ioDaHLz9YmtbaBo8ltKUN5v7BxsU0fkhKOc7eHUIqYaIW33fqE0DfjvE5YKBQJc2
 MiklEVsMzb2bJTLdiFRx5ROkGAqXCtIC76zBleGHtvnurKg48Q8Ky86u0c7O8xQ/q+ENUXLj6V4
 a1xYtF62VOohFcLi1JRtXVEFgijHlfwtoiNTv+0cFVB3js3NUmUeXmnQlqER5+qb1BwUdtkvlPN
 UYYaOm3H2rnQMcN/z7+F1nL8q5hduxTHJ5rmU349JCIGwyGfsPwcBdIeH8mNDVCjeR4wenlrOd7
 3Qq4YMXFVzSbAeCmBh/vEWiRdQg89+MvcwN24mWQabquSe8L
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX43fd4KBi2m1v
 0TeVLkawrRBeMPRDyz4wzKhPQUdCBnkUx7IE58xsb81qyU4+/GDSoR4ZHBOdryEKgrL8SV6xRfw
 hTyszcnehz029e5eiTFhtt+fSR76Rlk=
X-Proofpoint-GUID: GTCFet4cVIW7wcR2rbPUKJT8PW9wgZv9
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbebc5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=mqmjYGUTO374PHIbFJAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: GTCFet4cVIW7wcR2rbPUKJT8PW9wgZv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX/Xgy5grUT+zg
 whdF5Ov0Lum1tF+SgnLt0w0voVC7fJRwbPzjdb1Jqpr+aNaHTydWxKcimwmU27DmbLGJGPPYhT/
 YIx9laSyK/OaDjt1g/GwCHTtzpsQcIu0RkQ5Yr3Y3dyrksbfWVFOSpzjA+INSRJbMq4cuvL7hqd
 5/v6Y/b0R4nfeLYHEUghsI6hRhnuhcLdcJ0B/m86crl0xlTlTsVCPj/IsdKrcnwXEKqDwKCf8UI
 twVI6uBBV7y1c3O8CYZPtam9tKO6k6P/8nqgOXnZT9t+xCBoVhgOPw737lfZibBkiq3SvLIT/HW
 H7TUxJU3JoYTcffsavvT/JlQjVo8lpgDnig7efZlP2Ek/x9RoKlacNrA+IX9DySLvRYJhJ0VkCB
 fiGKy0J7jBYJD+WAXtImj5nRz0xeN2laBboYskE+kqHvRJEtziuYHq1VrDTFzWsPACBkb3cgdXv
 MXXJ7s+LvG7V10tJLfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

