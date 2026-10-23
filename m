Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=StF+YeLY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P/e/vYp7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5992F10E692;
	Fri, 23 Oct 2026 15:32:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD90010E691
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Ih93557684
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=; b=StF+YeLYDSVzUNM1
 6mf5WseDRSzF98fvo2Y1dKrVmtTZY3CXZKzouVbKv/3q3HcYIUOr6OXHZ8+n1uV2
 0WPJP8YhxapmZcoOi7u8R5U4BwMeC8DK6+iIo/QMFKAAZFIwj6m/5GSvsa9dNrRC
 C7t43US/d8yOOMUMTDN9fvPF0fvi00buSZfGhoq97EwDTmpongSWPFRrcUNH5Zgv
 lfCioEFkFCHm/DEINYRGCd5nZme/UJbp1A0FFpmT3VyKITbWwBHLU3Mev7OP6hgN
 qK2Fxuy7s7Y194kPIntE9mzsv4aOqNUG07AVLKsK8Iqusgh2T8G9xuIbeWCQ3LPH
 MtMe3A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjcbkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:52 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98a9c848bf0so238371241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769512; x=1793374312;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=;
 b=P/e/vYp7XxB9glyYWlvoBiynNM1n349eZVnRmO3gRYJMkME5mTOgAFpjaKgRKQO26N
 S1oIzi+2V8JAnQkT21IV4afC9IAsZ0ZqiwIWV2WM46K001xD602Fz4L4/w9DV5B04lrx
 9gHzOCZhL0/qCxnHFANYOmiqPLp5qIHVVIm2OMkKu/nFrPh9+rSAAPKW95TTFLPy9UVe
 2jxOunmCq43Iy0SSV87SlONHI/6+FiXOZxEKfdFYGBzAwmxkrAyYNeeNo3DYj/A0zNkl
 J5mkddMz9iHMrYBc3s66vSCZeKMcvKVEJYK/k/My8LfABQxJgYgOqLtLcNEMuL/svw6b
 Nf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769512; x=1793374312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=;
 b=sOp2sFrbveAW74pf0KVCDsB9NzNYcpBYqh6qxJRbt4i6UV90BacZYrRLOHGUpLUvdS
 C3IXWKjcgWVvh5P8nsYY3Q8gBOdE5pEkEkbAGuPbMP33hvf1Jkc72DKAY0DAQttTjUqU
 /jCdV2bYmRh0eeW0okJUY1OebpnZyqWHnJ7L70mFFAFlKfn90BEqcNKESpVpOx7cRDg5
 B1/eMPYmEWxXzl6Qfw0WLzzWI9rMgYi5NOwFviDk6g3PjwtFynHj6R7KtGwUGv4VKBl0
 BE8ySeeajr53BdckDjAiMY2y6TZS8JXuP+ZYhvGEuaH2tblEhl7UObXxpWNbWBmUHAGn
 qpsA==
X-Forwarded-Encrypted: i=1;
 AKwUvByRKjzEMM8ZskMnBt5Z9BXUWCSSf8hnDLn+cquCYHX1W2mm18J5EbxhjZ8V1Hvqpk5D+VYsTFkQR2k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/Z5dxpSvYPmZ/T2KLJRDIhIDdZEceZvSgnIZbveS/nRXFJJvF
 vU0PZGwGFjCjU+Z9UKhlYRtsrN8tYQOmWo/yj6iNBlxUITZVbZv1inbMNKMVKipz+xSsUeBZFmB
 vRbbhX9l7Gu9Ln8PVoeN0uu3fxFCIJ7HKr+GQit9xtor3NVYqvR15DWfjqVGOqDGh8v5rCTw=
X-Gm-Gg: AYBFou2NDGFpwU5jdbeeT6xP41+wRNBHVS4pxXQYIpyT+ktfms5CpXB7Gy7/ZPC6un/
 rUsgSa1ph9etrN0z9fBe8mTAb/n7bIlIVeAOpETReM9iAUbDbt8O1A5eVFbzqbPcWgVN9m8h7Mq
 d9METM5xyhAbk7amCTeCM10gPKk0MzmYWrPe00mAUI0hmHgWwHS/ZTxuuNDgdj0e8Z2z/ol0sGu
 Zld+HXvkjQMyqmSJukY9DgqTYHotjfsgPhPZUIoZUbxYmR89qa66th02PE4CoaNZmm5d/0GITAa
 RK61F/9lmkuNqaHLIGpNvr3NGG1oXwOX72GIJundMdBoRQQqAhMyEnouJUUdxHofWST9QL739mE
 ZWmBX6Ku0iUNecSrzM6dihTcaWoq32jCRs3yXCDKJfZTw7XqWA8/OA/H/AlZmDwth6oIBnmc7bN
 zyD5itijMYk081
X-Received: by 2002:a05:6102:570d:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7ccc33a2d26mr929939137.21.1792769511801; 
 Fri, 23 Oct 2026 08:31:51 -0700 (PDT)
X-Received: by 2002:a05:6102:570d:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7ccc33a2d26mr929910137.21.1792769511350; 
 Fri, 23 Oct 2026 08:31:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:19 +0300
Subject: [PATCH v2 04/14] drm/msm: order the display snapshot sources
 around its worker
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-4-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233SzdzYewQmxR1JfzkOVurhbQdQ7mJHjZpww
 nrzNLJwNgyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt90gAKCRCLPIo+Aiko
 1eq3B/9ijW/ZBpeGSKPZauP7o/sehHu3RRTyq3US6wN6m7TIKdx03UD/IYwH3+twG8XoqmXJ4xb
 y1FrxxyqFV5V0Uz7RRaCbcD2pzty4FSTdlpi3RIH7BYkq8RC9ypgFErF+M1JejTaM+JZb5O+B3o
 EnjHgOtlnGQbG8Mkaf1FbHBe7Qnl26PXvNQEqB3Qhrsqe2R3JiB0C7nxi0To54VzeDIy1l93N0F
 AER7EOscf4UbA5++R9qzMZWgsacmbELKuATXUs3yI8ZCoNeSWiSQZnGyLwPAUBX5q5NoPCCzyHK
 LgjbhCiAkA8DtdtSEqPj+qSiU3Jl8clSSliekw9wM8Bc+GUT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: nhc7dJZNORdfuehjri0whgdWFRGd7rl3
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb7de8 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RYZzOHaK-VtI4H7RTV8A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXwEvoPtuk2LiK
 4Gb4Ng2wSQI1zSMfI2OMlXZx4sgHYUjBD5JkOvCk9x6dTHp7p7ebk4fPyPY94Fi/RBQNBL7yfWA
 3dPQMA7081oi2hFAxMm7ZQrFADGewhk=
X-Proofpoint-ORIG-GUID: nhc7dJZNORdfuehjri0whgdWFRGd7rl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXxOQKFaYtXC5E
 oY4Fny1kzzmjDuSjHDOoR9LqI+MWZcJxWrv7t31Kdep39tDTv+Bk3NPox8ccYVlLaeomyTLUVT7
 wgi+tmJ+N8W7G9ekbavRAwbZ3D/mAKJnEDONfHJrqdzYxN92ywnKoQ+dRkFQncGO/RYZwMQlaak
 XOrXf9+uBOPx2G9/qYlsYEF8eP7DACh8oGBCDUNUJabYrqgipgHpefCSUSsE4JzIcZ+QkWya+mj
 mv/qrxr7GkK5/yEyMaG2qR3+9hvTyxjjCPPfFJYRPEz9i/hCQHnbYMXOg6+vku1HXHxvwXO/unH
 1KFGIFdkDOFB/NHovaVP/SPzxAPs8pPoNJQm87M5n0B7diiClbkCDHH1KnUT2VTBcyDQDl0neaq
 j036/spPID1scLxaVReA++DdHZro9L4BinmCkDam91I01RLX5DLDbBlk0uzXYtIRtv8Dx5mDhht
 k4ZddjsIEzsM/ZoZhUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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

