Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA43606A339
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BdenOtPv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FdzDX6th
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B11A10E733;
	Fri, 23 Oct 2026 23:20:35 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADC210E733
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvCJr4006345
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=; b=BdenOtPvNGQ88enF
 mSltnFeNBzigIkUNVQHANOpwbXdkWJyH9wzXgDcRmVe0PdLbp4qrzLRsEXhtAJme
 7L7Trw4CKtpldjkV0lpXiZSQVU0705H4m1xjMkEsjDRHNyQFnmenrPxrzWa9Ersi
 dRPMYNI7DlBM5NKfjqx1iISnhvMJsmByvrpIBJ9hZa19tbv4J73I1vq45hPLGky5
 jSrWPXKTNY/Nmvbq+LSq7UyoZYtlJKSeZ/LRbvQMTNz6jbYuWnfCzCPqAxHJxnRD
 daKdf3a61vTO4Tob6h8nG/g+jzdTPlQacyOIwUHKtfUJz3XfAK2PxLoA6PQVpCvD
 Bnjm1Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn25xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so89185485a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797611; x=1793402411;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=;
 b=FdzDX6thIEdyeHZClpwjCII70gE9tcjwF9bpzxZKAeVQQkDrYx20nRyvUfIteiOJJf
 yva3vygVrbNoYGXCCrWWl4vx9E4AiwXRWEinSdBth8ZDnbD2p9nGFbBVqDnDPf+S552m
 KRpb4BI02ftdw3uxMz/EytoW7Mw1vx4kLwJm24NfVjFYR3ZmuTBaGAq9lu15/fe/zhqi
 vppp/pEIPJfNqRYAduhlV3YlvNNyWkT/HdIINxtPBC4Zpu0CRXkTnjh2XIIykwJkOGNo
 GWlWlJ8gT6rSArN/9aT8+peM6EE/L9tTusSD4OJAwbs1PpFgbzWJCRX9PljDqy+LUAzi
 5Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797611; x=1793402411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=;
 b=iqtcfy/BM50++4zl8w4CWQED0qwRSZGLyoeDAWHA5OHRCM0kMt1Q8Gel7fCVPEgL+v
 Z4BPPFph7YjYGN6Chrgy5qJpUbyYPpGPKMlpv+IeXfucVwD6Gc5t2FY8Axn/nEI3HNJ1
 u57yCEwq5TRw3yetXF4FY87cn1pszLgje9QuTrC7GZkVmI5DzsP2efZZ6drSv9Nrng1X
 q4b51tcneHx8Bht5QOVXYmCfljEMyyYWosJgWPbK++vNWurFzBGxLQnroketyLNhJJoj
 PB5UUwI6uuP5zIZl3hdUOh1EelEI6XppqQKDI2cPB2FsVjxkjQbb2ow7JQxf9EimtI+h
 EcyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq3gQXFgOYIEZ7dhs5N9C11ATPGM8lXvJOq6DZu75AeCOWBzgUsnYuFbIVyV78m3twQmJBpg8rwgE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4wVCKvq2qYeTzj/CGfb5C83+kdKqkozkczs8qxjIczmtzqpOi
 T92bCAI6Y3dmsTxF7f7HPvPDXxHfORoTGsGVPH2+l3LIQgG8GuumkhzDFFoK8X8XckDFrCW8eq7
 /NH47Kj2g+9QD+ZA68+EsljLLV5YsSQLZ9ZECQQzwcXrshMfzOJ4MFDwn1ZDSu+nzovqhV1E=
X-Gm-Gg: AYBFou2d0ioOxheLphhsLJtpkZ2Oer4JL9ttqEMj9HicsNfsLqf/FMHtGCydvp1vG5/
 dloRhUnCC7sHhGAHfjrRRhKbp7wFd14b41EqKwjnBHJ+76nZO30jZyNDoS6DGxPzJHiOU9KJboN
 3PeF0IXGaXDbeYBBkdZ0C/HV4hgBAFV+5YJBiCo/VYlxzxg+uky9m6ZTyKTdWqeoykg854bGEkg
 5VIAqTX8jB5q9JjKVYcT81TKZ/0zERgj4kpuLP9MdhGEF5DKp286YBgHeNmT76YqnERt6D0wWYY
 3JUxKtrUh8boX0/n+3zL05Chhpiq4eoF4knB9Xxp7+9hfj6EIGD0b768wymMcYKsWLuegtQtzQ/
 jtyEOkVtJUwWUAkbZ49WNQCnarwymlIgYPwxj62mqjykk0B1o4qG6dEe7AWJsu5jCR6mSzi3DG7
 XRb3L/2PGQYm6l
X-Received: by 2002:a05:620a:2955:b0:93f:611d:a18e with SMTP id
 af79cd13be357-940ef913527mr82742285a.55.1792797611368; 
 Fri, 23 Oct 2026 16:20:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:93f:611d:a18e with SMTP id
 af79cd13be357-940ef913527mr82727985a.55.1792797609014; 
 Fri, 23 Oct 2026 16:20:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:37 +0300
Subject: [PATCH v3 04/14] drm/msm: order the display snapshot sources
 around its worker
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-4-66a30120a5ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3385;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iM9tCgrXdMoAc0lpkEnlYv/1Wi0+ANIcrUxdVoj0Zoc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uQ6bCAvbaHcUOf6zm4fkNhaoPgtnI4zjMEC
 UZfQ4tZd0qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrkAAKCRCLPIo+Aiko
 1RXaB/0Y8Lonvh6jZWrcv0URyoAS1bINrba12P7NMwDxQZfoRpbYorwdGNjkccMf7Uxq4Snd4hF
 cgOb5fJB0c5EtcNIjBwBVyIfFB5J1ZzUAREMHFvnKyhu1xV0jKOQyGEpszJPOa6PZSpmyq0eqIJ
 EoPvxH2T/s4kFeBdpeqJi0B8kpikE48crpwJBGdLSdE3538wcVtRO1nNwukiHCtPuBJnGYhrH+/
 gl8jI35CLEEyn9PNmaSEcAxscTQ2ntFXVDqJN1ysAe03SIAIfv5pI8WsftdsIx/n+dHzEy7ROcl
 F40a5Y1QmHJjjZzXnn1MTRheZVTda8+3hmJ7RwbITAhNwv7k
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX2niKWYBfoc0b
 f8zu/Qd+oVwZps44w4qqUgR2TlmhPUz3DTYAwa+zdQm/uSZBFG1hYrY6lAiuxxdNb1h7hQcXvAs
 tqtRvM4lZxnb2a/VUeWHVvT5AV5Z7MbgEdvukV1a5Che29AT+RajWYJ2yanSOXvrerZEv59yOBa
 Kx8I8mZHvlpChWDD6zUJN2CQpQ//Vygi/8rE4iO2jDIpAjyS0M5J87YbnV4BqVDPbmTLFVwNj11
 2p0/fHZAbGKvga3vSlBZ5WXC/T8DI+rJn6MGCbwJ36KizfIdedDFovqw4RJntdsy/JaKQKnGUg/
 dDIiuDLjbXOJRWLTzs5wayKhrEIx72PTrcFbvSkcG4Nfg5kBDiHDXbDTuJaM1QWtRn9NzNx36SR
 YJ1mt40PPjWPmZeNPeyN+ERVS1n637m+FiZqSN6YfuDF66URddDOK/PJhuX1Fu1CfCWdnIIsFhx
 9r6PKoOt1o6LmmRu62Q==
X-Proofpoint-GUID: fJfAuxBs65yBbDlSMzoBuwJj63y5hEkW
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adbebac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=RYZzOHaK-VtI4H7RTV8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: fJfAuxBs65yBbDlSMzoBuwJj63y5hEkW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXw0YXPTdnl4ZI
 7DO7atYqsSXMizR6pVeKRV7AK5/bipINwrp2qMAGAymGBziL9atxZlpjOHgu/M4RFBqHBftUuV7
 MhSr935tIlq+KjfwrCP3Q1zRUP6HzVQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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

The display snapshot work is queued on kms->dump_worker by the IOMMU
fault handler of the KMS and by the DPU interrupt handlers, but neither
of them follows the lifetime of the worker:

 - the fault handler is registered by msm_kms_init_vm() in the middle of
   kms_init() and is never unregistered, so a fault during kms_init(),
   or in the error path of msm_drm_kms_init(), dumps a KMS which is
   still being set up or already being torn down, and a fault after
   msm_drm_kms_uninit() queues the work on a destroyed worker;

 - msm_drm_kms_uninit() destroys the worker before it uninstalls the
   interrupt handlers, so an underrun or a timeout in between queues the
   work on a destroyed worker as well.

Start the sources only once the KMS is fully set up and stop them before
the worker goes away: register the fault handler as the last step of
msm_drm_kms_init(), unregister it first thing in msm_drm_kms_uninit(),
and destroy the worker after the interrupts have been uninstalled but
before the KMS itself, so that the dumps still pending run against an
intact KMS.

A fault during kms_init() therefore no longer produces a dump; the KMS
is not complete enough to describe one at that point. The handler is
cleared with the kms argument left in place, so that a fault handler
already running still gets a valid one.

Fixes: 2ec5b3dc18ba ("drm/msm: add disp snapshot points across dpu driver")
Fixes: eabba31a839a ("drm/msm: register a fault handler for display mmu faults")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index f3e39c3907a9..a94d2888a21e 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -182,8 +182,6 @@ struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev, struct device *mdss_de
 	struct drm_gpuvm *vm;
 	struct msm_mmu *mmu;
 	struct device *mdp_dev = dev->dev;
-	struct msm_drm_private *priv = dev->dev_private;
-	struct msm_kms *kms = priv->kms;
 	struct device *iommu_dev;
 
 	/*
@@ -211,8 +209,6 @@ struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev, struct device *mdss_de
 		return vm;
 	}
 
-	msm_mmu_set_fault_handler(to_msm_vm(vm)->mmu, kms, msm_kms_fault_handler);
-
 	return vm;
 }
 
@@ -245,6 +241,8 @@ void msm_drm_kms_uninit(struct device *dev)
 
 	BUG_ON(!kms);
 
+	msm_mmu_set_fault_handler(to_msm_vm(kms->vm)->mmu, kms, NULL);
+
 	/* We must cancel and cleanup any pending vblank enable/disable
 	 * work before msm_irq_uninstall() to avoid work re-enabling an
 	 * irq after uninstall has disabled it.
@@ -256,12 +254,12 @@ void msm_drm_kms_uninit(struct device *dev)
 
 	drm_kms_helper_poll_fini(ddev);
 
-	msm_disp_snapshot_destroy(ddev);
-
 	pm_runtime_get_sync(dev);
 	msm_irq_uninstall(ddev);
 	pm_runtime_put_sync(dev);
 
+	msm_disp_snapshot_destroy(ddev);
+
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);
 }
@@ -339,6 +337,8 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 
 	drm_mode_config_reset(ddev);
 
+	msm_mmu_set_fault_handler(to_msm_vm(kms->vm)->mmu, kms, msm_kms_fault_handler);
+
 	return 0;
 
 err_destroy_event_threads:

-- 
2.47.3

