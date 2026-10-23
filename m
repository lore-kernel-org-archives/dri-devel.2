Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51388606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SD8QxFZb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MWOTK4ts
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB848112D3A;
	Fri, 23 Oct 2026 23:26:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F3A112D42
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvZYn3471095
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 In1IJDjKvKLncIh6SA1OcK638AZD04er/Z2SLZZrgPU=; b=SD8QxFZbI7BBohKo
 M5rFrARfWHIClZmIvVfqynSCHQeeT0RlEgmuKcX4OA+5E/0o957vUxeLrFkvM3fF
 ElniuVdD97Th6YQDHk7YLOzxdVNK5fq2RgY4I2m18hcqRuUpoMceDH58ogcySv20
 v346Flya/ZzdYdF1q5PhkOePp31NQQFjumGh9k4TTSfB85HPrlIrNdFTIAfIBdNd
 Ko7FgVhzc0bERukLHj2rM5L4jvKUFwpGfuVpUj6G7Vne16GiFUz2+RtX9w4BwqCH
 U3tnX/c33yxSpRzTjvf2ZA7ZMzsbC8Lt4gQbkgIHvLeXQvgSVAaD0HloP87XW1aL
 f1T8Lw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrugv1s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso43404526d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797952; x=1793402752;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=In1IJDjKvKLncIh6SA1OcK638AZD04er/Z2SLZZrgPU=;
 b=MWOTK4tshcgO4FruZdbOYsP/zLFHpi1x+MVpKNtpDYrBgDmGZ644f/YNStpeJyIC1Y
 bL6kxur0p469i9UIH3uIJWo2f+VKg9fVN2LB8c/OOZdZWrvRY+zl2d9+IxhENQtoYaPm
 8IsV5sogjBAgRYab7xxhLCYjnrkElcaCMDaH72WTHzKlPkwMzKkQngGsslXUVMNqs/RW
 S5YOMRP282NWhgo5TkduWQGicrYUztxOvPYhxa4i/Rj47TRBr5J5u2Oztt355T/j0HjS
 itsfT9YU88vAmw0FEbaJpMdnxtmgHD3qgO4uyayH7AqCZZTyK+ikS5xX3vrZ6w/JXmr5
 VhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797952; x=1793402752;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=In1IJDjKvKLncIh6SA1OcK638AZD04er/Z2SLZZrgPU=;
 b=PgxmfRfX/YQRtLspx+fWT2r1hCcGSwb0zvzEBBd+Tp3cl/ulFjslJJU7E3wj8E7DAB
 wJ3WYcbglsFgycw8SPp0O0tmCcNoNpl4BaePkAGpJJ6ntGEld3knLoXURpGlEFm5S5li
 7xMzb1nM5/CZ/lj5EQL0lZ7FvptWKBuC6LlVn2TSVgRplg6hEphlaiYR+rznCRlRctzA
 VDjhpwo6Di7Q3YnGlA3eAnqRh3j2X6j6MjiOrhPwNa9N3OWTWbSusSZAO++p5d6olx1T
 GdYNfPjpEpvfmvIkNlPqPguhQZ+q4k0kcqvtsKxN069BLA9p1vnNFeRLd4v83sYPPn1n
 YtMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztw/fgzYtTVMGhXvozL4tTflmqbGVrguwHXfRWV6OU2IYlBQXSSfZmsusbLwFekdhyvV2VQdseWnM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKVwWsnIFChXKJPU7L1z01Iz+sIUpWjwVQ6I+Vdu135bcUyruz7
 S2KIuEqrYWGTwf05bNLwrJaYnbsY5uhuQD1gAs6tNNojgqiPNMvSarD3vi61QTfXnY84VBV81fo
 vdWDfofgfTqHDu4YjkWlpK+waLdZmROL1SGqlXq3QEu3SpD6VyAMJ+xiP8lrTrV92e474YN4=
X-Gm-Gg: AYBFou1N5E8kMapdBYst40B14GcTkR1Z/NPP0+SyX0aW7ZrSksOFoaEkAIRjuYjTFJG
 rwLcmrl+jczktHNFDi4U9ExDJwgjj68NtXAReBoFK5qOIgWeNlvWEg976mLMDit5W4Zq/YV0yNC
 FaZe2UCKPvOJpu9jc/yBUb/XQ+gfSG9DR+wuDzK5cNJX4jTL/LWnWJl4aQo786RWFwUn59Is6Gs
 Btz28hsKGkva73EhbXQI0tO60BHSQ2LoJxe1T956McDkZzhJ2xAHfNsIX6Nq5Vz1YGEFaT+ylU/
 Drtkx3RDWwBdEKcWjHdvPRg7sa/s67uDnUtj/Sqb4q2cbM8ss4N/JcPe0BxapUZnndKzM5GLL0G
 HhKHEV1AbVkRnjEuh+q4JNvFvuzekH0Y5WRemxMS4hZR4oUa4RXibZHZrwJnkkLheVt6jpFJ1pP
 q9Vseg5LBF+8ls
X-Received: by 2002:a05:620a:280d:b0:93c:7f48:8f46 with SMTP id
 af79cd13be357-940ef7cc968mr88719785a.4.1792797951904; 
 Fri, 23 Oct 2026 16:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:280d:b0:93c:7f48:8f46 with SMTP id
 af79cd13be357-940ef7cc968mr88716385a.4.1792797951395; 
 Fri, 23 Oct 2026 16:25:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:27 +0300
Subject: [PATCH v5 06/10] drm/msm/dpu: clear the CDM block left by a
 previous reservation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-6-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=td4pH6mKFwySyF+P0cdOuWY9YqmqMRtTvJGeIm7xLVQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zpabaLK6RAXYgWPGaIvXugxOiOr2TU8umJk
 3PC0bG8426JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs6QAKCRCLPIo+Aiko
 1Qp4B/sGWUAq+a3bP+1MbYAIjv/RYEUh1NRtMdlTj1TMI1K0XPzYCtUy35yys0yXWPHIehEYFw0
 Q5bTrWj6d0zfJ8WfHNI72At6m32XH2BnbuK7Lwlf1dz9HrMhYZKjSzyAdzNAWi0QjJ46Cjh0GRo
 A8r+p6sSu7fjt5z8t5T85xQR4guEPvC7S9pnfMLxs7aslbgzLbyovIk1nec4g2G0KRNyFsuyNKO
 UB9R6neO1XMEmxcVnh8OsBO2+OZElGvArmrYMh0KOZylfSM+X/S2ggnC/nc11CaEICgF1pPgkJt
 E5uKvtF/mArPU194baroCxZdC87QkOKwkeR4ESnN70uKL3Wp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX1xc3+O1Vf7hj
 ol+Ior2+H4T/epntuXE/eY+MrYDG1eJI49TwXSw+F+EW9pouOfKzxn13tqu9CwwCEkUOHR3F6RT
 SKxR6/7BD2U0vGzLs1NeBof9snsB4v8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX5APy//gxryBM
 yVTCY4e+Jw6Y5uiEBmUD00qA2W3qdWTpyqRozRcgC4gXd4i328flmlo1K+OvQF5xdMPaO0uF3iO
 9KD7mTz09qgHm4X2T9viqx1gvHjJLOAnA3wXm0Ux7KKhic/2zIswWsM0ZVtdmlq7n7R2Y35/y2h
 O6JJ/zRD6PGVCFMCdUFtwOkciURDa0DGhFS9M2z7aKS99qbKh9lGX752lizPaRgDLrt0SP8DRDX
 XZ0pBWk2WHQxvsNMQVUgfmBxLfoUhWciFJip1a/ptqSQM7unUeFKeocUsA1CN3+fAxhYz2Zebuf
 5ovU67w2hv8wpsZA2b42qDciEuCESvaZhDZmX/x6fZChOyALgxzPFFsXbJD+YcPwY7K00F4i4BS
 Bvz1CmcQMPaq1cuO3zl3pAvX969K7s2aMPISKO1IKHppZWSdvn2WHqgmmhq7fGigQo3y9QlobZq
 4903a6j47dvREXGN/xQ==
X-Authority-Analysis: v=2.4 cv=Ju5kP84C c=1 sm=1 tr=0 ts=6adbed00 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lW-OXhpROnvg2TLzoksA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: XfD3mEq6VNP4TU3QlD93ssXwrTJ9eGU3
X-Proofpoint-ORIG-GUID: XfD3mEq6VNP4TU3QlD93ssXwrTJ9eGU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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

dpu_encoder_virt_atomic_mode_set() only updates cur_master->hw_cdm for a
writeback with a job or for DP, so a modeset of a writeback without a job
keeps the CDM of the previous reservation, which the crtc may no longer
own.  dpu_encoder_helper_phys_cleanup() later unbinds that CDM from its
pingpong and flushes it, changing a block which may by then belong to
another display.

Store NULL when no CDM is assigned.

Fixes: 8b45a26f2ba9 ("drm/msm/dpu: reserve cdm blocks for writeback in case of YUV output")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 8fcd0b4e266c..b337f197d3f5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1160,6 +1160,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_cwb[MAX_CHANNELS_PER_ENC];
+	struct dpu_hw_blk *hw_cdm = NULL;
 	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	int num_cwb = 0;
 	bool is_cwb_encoder;
@@ -1231,14 +1232,12 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	dpu_enc->dsc_mask = dsc_mask;
 
 	if ((dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) ||
-	    dpu_enc->disp_info.intf_type == INTF_DP) {
-		struct dpu_hw_blk *hw_cdm = NULL;
-
+	    dpu_enc->disp_info.intf_type == INTF_DP)
 		dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 					      drm_enc->crtc, DPU_HW_BLK_CDM,
 					      &hw_cdm, 1);
-		dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
-	}
+
+	dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
 
 	/*
 	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not

-- 
2.47.3

