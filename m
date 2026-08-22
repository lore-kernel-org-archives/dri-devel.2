Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0711DC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4C710E3C5;
	Sat, 22 Aug 2026 08:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGBXYW/a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eh6rxpxU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDCB10E3C5
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:08 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M7xZlV1699062
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UnXKGew5QII5NxsBPl0obJnI0muW32nfd/TT4GgHu0Y=; b=JGBXYW/aLT9ANHYz
 kUXALbd4cYiIL74InmFCISBdcJldMY+1Z6i6HW15ZP1oE4XLeUaF+rloeQR9H/Xi
 +jjjb8pgAQrEvpPGKRtW4mAyXwk2DmSavlJO77/lm6muXFqbWEDlI5F2RMxJvje3
 Twl0izFxXuayb4o12HRMEkFlNycdH8kyW+FZbaOUwmUTKfqS+hcUTXOIonVIbp3/
 wW0ubmvcx2QKgiPwCpkd/fTcoCej9l+dh/daaqxfgxpoWfjAKfmOmpidCDN1Jx+g
 JsbQAPHbmIQLNe4DP4PoOZukg2y0VAwOWH9XETrtzMpqyMIzypwre9S1IEJXkyUA
 GRatsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g743xgnfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so174363285a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787388547; x=1787993347;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UnXKGew5QII5NxsBPl0obJnI0muW32nfd/TT4GgHu0Y=;
 b=Eh6rxpxUjz+/GixkDNZmcUv1S0ZD4eMLtZ7FYoLq/p5xDcRcYuf8NV8RCpp3txT/+L
 49n1eBEJFb5xxIW+9j3Q8dAyj1uDM5Izn7cznqG/Qixxomn6N5tvVcRyNYKtqMuYTn0I
 /e5HfgPNDb1X+UL2aM1FBWTi02O/vyvox11Gk8/QKcdFFJpzk7ozmNZ9eDLv6f6V1wIo
 XSW+pDMMnF7A5D07tR86WImECePOKz383wtSFPMuSVmgBQo/1CrkxVlth5u7X1wYRGGy
 Hq3jVa7pdhM5sQYwOFJhtvJUbYbuND36SFfZmMzVb+v6wRHDI8tpbVRRXW1T/TRAmdCZ
 kmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388547; x=1787993347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UnXKGew5QII5NxsBPl0obJnI0muW32nfd/TT4GgHu0Y=;
 b=OpxvHbQENGjX1dQlbq5FDdb8OEUM36BEGFS42hhrj/OFfQA+6jKv3zDD2wL61q2KEi
 YVlx0/KJYzomRdZ6O3zE3tPWeWwaqOmZ9SVqjoc8TEGAc9RDQRFkfM5vodHBxGgVcgl1
 FRUm38WGnSf02dKzAuHy7rhd07Qdfc4ZzEl9W2CWsrv01UUXEyvLYyUxwLz0ptsuQnV2
 wZC4VyW51NRCXroTfeTs8dJ3IkXL/IOgz8WxPZpZi3EK2Q3RVUEBEibB9a8Wq+fnZDvU
 2eGw1deqiymOp9f+fIwmy8mgWgR949MzYBxnUjj8kya2ziUdTj9F3brYLmrQCTLFSzjS
 /R1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqqlglc6dcJdoasw0W7tSh+twFtmrfl/w8pDf2+qZ0dao9jIa7r2INCX5SZoscw6kfT8lHiXzdMGVk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mztNJtCg1gZ5JfyM2eQFlR1jEFm399yJ5Hx5OBlo4cWUumX+9P
 /ABF7r0fWkAo51FXT6+L42tm9Ci/7apdV2XLAVR6vsBVjSVfR8shvwSLITJp1tYmmWcLi/nWuw8
 ZXHpHScIz+7yHFU5Gc2HzOJ1gKxQw77LUC/EGcXtm5vrryKKZiIs63tKM+f7yVmgWzQqaEu+TjZ
 vlIxxS5UTf
X-Gm-Gg: AR+sD103Bv68l92zs+xI5bv/zQyPXCgiAVoNR4fzh8nXL8yJlM1YQar2pnb03DVcByQ
 /iTsa25sqPNEMu1199JFn6UgPg6ke7CqTVw3vMawX3MBi2pLoG4TbovfsbtMAjQGpf3VcYGeyBD
 bhPq0NODe9aUUfWjmFaClgNHX5L7JgunmCbbOPLpDENbCfE0XWAIb1UW6GKDdEzKFsFWCXxoZvz
 AO0pXFEOmJzNVq2YXb+T2tFrV1TBBl1QVyb+kXyD+2nNuHVFD0P/juV5QUrbm1FvfSrK9I26PLT
 S9O+UyhrxxEa7OaLYDv+Bav+PYbv/O/Z4UV3K4vY6cEFESkOvwMCrx/SOYuO9bg9k90+iVb8TxF
 K3bMT2pwuuiLqz4Cb22Vr/ATsEMjO7lI0qlgnMX+H+sROsXwTi+0IBplgsfB9YDJUG8PXB/0yHv
 1eJu644KYIulE6
X-Received: by 2002:a05:620a:318f:b0:936:cf9c:a994 with SMTP id
 af79cd13be357-937398a8cf4mr998426085a.19.1787388547281; 
 Sat, 22 Aug 2026 01:49:07 -0700 (PDT)
X-Received: by 2002:a05:620a:318f:b0:936:cf9c:a994 with SMTP id
 af79cd13be357-937398a8cf4mr998423585a.19.1787388546825; 
 Sat, 22 Aug 2026 01:49:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2fab887sm3066901fa.25.2026.08.22.01.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:49:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 22 Aug 2026 11:48:58 +0300
Subject: [PATCH 1/2] drm/msm: factor out a locking put_iova_spaces()
 wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-msm-fix-export-v1-1-917b3cbedd43@oss.qualcomm.com>
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
In-Reply-To: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4016;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9sFj+2Zg93TLyhMuoQHzR96CV7efblYg21SrHIBwwDU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1ZnUo0Fu+wBx0XhR23uyspMdFJIL9INYYu/rFvr8bH5T
 2t8EHcnozELAyMXg6yYIotPQcvUmE3JYR92TK2HGcTKBDKFgYtTACYiEsn+32vWUY1vei+jFlzN
 eGGid7S6/5qxM9cHXlWXAxNY/Pt1Kx3cJ/w9EvbQK/1Zr9fJ9R1L3n4yy1xflXFz5Venz6oqui0
 dPD9n28RMrPBaxyXF4NC+7394X7RR877uz+F5D7RYTZXbuH6YTGXY9jFH7vvmmXs0Z2+ducPZvi
 CO7Vs6R0uZgdyOFYs5t4ed37fUe0v2PZaUe8vSfv5wLZJ7ddrWyljhE9uZ87ptyofOmbrcirAzt
 18VKmZy+c3PxBePpM+Jt06f92WrLHfuk5Pytv4GPjKSmg+eLpSf6/uoWMAz+HC/391Jr9a6PyxN
 m3mqZGa+nF/B+/1cV79XHVlYFjVRpV9V64LZbn29fRwbAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfXwWfE3tyYVu5t
 Q5WcayRuTLD69gNgPTkvp7CWVqbVrkJWeL+QRgWV6NxdT6OD00G5suDYhJZG2SEMYVdGeWmlkfc
 N6bW8oOpHghdQ6vSUaA5ZkUAtoDWDXk=
X-Authority-Analysis: v=2.4 cv=HYckiCE8 c=1 sm=1 tr=0 ts=6a896284 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=s4q7lw47J6sqlY71xjgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: lyPxzYqiUhX2aI0QBpqbM8ennri_jB7T
X-Proofpoint-GUID: lyPxzYqiUhX2aI0QBpqbM8ennri_jB7T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfX35cktlVt8Rrb
 RivrMepzwFGiLajSTLVODuIRqCNRkbcSMTQ77epHfFISgnvMWNJ2OA5tgv9CxWRYof7KGtnlO4x
 4/Sv8oe43JikI3cx7h9Iw8XwPkWYPH1KAC/1jG7yVi3UqwDFvW/jCBmG4LLLkQu5QEB1qcU5uFQ
 cButV9ckvZza4Su/a9Aaj57tr5v7weUYNj6VD+7z1YMwVeh66zhSosnGzlCAot2nja7E+m7IiAs
 jzZESD85S1S8AnTStpfUqom7zgXbZOHsjNjaayASQnAhXUJdXC9zxm51tpvtcwtwmqZQ4rz+YRX
 nUgE/jrt9ayn/EW65jga0dNU79UyMJRWBBkuv01rb/etkysvy897Ni3OLrfq1s6YYFaWpz3fr1W
 Soq1hOO6KAoomp7sfQL8eBpipAgYSswM7GMCiroLrB+EJVtAu45ufEMMnw1ANZNp99dhW1t8SWo
 0/Ki6WPDeRScoJFkxqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220070
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

put_iova_spaces() asserts that the caller already holds the VM and object
locks, but is not named accordingly.  Both of the callers which do not
hold those locks yet -- msm_gem_close() and msm_gem_vma_put() -- open-code
the same lock, tear down, unlock sequence around it.

Rename it to put_iova_spaces_locked() and give the plain name to a wrapper
taking both locks, mirroring the get_and_pin_iova_range_locked() /
msm_gem_get_and_pin_iova_range() pair in the same file.  No functional
change.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c4cff3d53d81..f90afffe3442 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -47,13 +47,23 @@ static int msm_gem_open(struct drm_gem_object *obj, struct drm_file *file)
 	return 0;
 }
 
+static void put_iova_spaces_locked(struct drm_gem_object *obj,
+				   struct drm_gpuvm *vm, bool close,
+				   const char *reason);
+
 static void put_iova_spaces(struct drm_gem_object *obj, struct drm_gpuvm *vm,
-			    bool close, const char *reason);
+			    bool close, const char *reason)
+{
+	struct drm_exec exec;
+
+	msm_gem_lock_vm_and_obj(&exec, obj, vm);
+	put_iova_spaces_locked(obj, vm, close, reason);
+	drm_exec_fini(&exec);     /* drop locks */
+}
 
 static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 {
 	struct msm_context *ctx = file->driver_priv;
-	struct drm_exec exec;
 
 	update_ctx_mem(file, -obj->size);
 	msm_gem_vma_put(obj);
@@ -81,9 +91,7 @@ static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 	dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false,
 			      MAX_SCHEDULE_TIMEOUT);
 
-	msm_gem_lock_vm_and_obj(&exec, obj, ctx->vm);
 	put_iova_spaces(obj, ctx->vm, true, "close");
-	drm_exec_fini(&exec);     /* drop locks */
 }
 
 /*
@@ -106,11 +114,7 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
 		return;
 
 #ifdef CONFIG_DRM_MSM_KMS
-	struct drm_exec exec;
-
-	msm_gem_lock_vm_and_obj(&exec, obj, priv->kms->vm);
 	put_iova_spaces(obj, priv->kms->vm, true, "vma_put");
-	drm_exec_fini(&exec);     /* drop locks */
 #endif
 }
 
@@ -409,8 +413,8 @@ static struct drm_gpuva *lookup_vma(struct drm_gem_object *obj,
  * mapping.
  */
 static void
-put_iova_spaces(struct drm_gem_object *obj, struct drm_gpuvm *vm,
-		bool close, const char *reason)
+put_iova_spaces_locked(struct drm_gem_object *obj, struct drm_gpuvm *vm,
+		       bool close, const char *reason)
 {
 	struct drm_gpuvm_bo *vm_bo, *tmp;
 
@@ -669,7 +673,7 @@ void msm_gem_unpin_iova(struct drm_gem_object *obj, struct drm_gpuvm *vm)
 		msm_gem_unpin_locked(obj);
 	}
 	if (!is_kms_vm(vm))
-		put_iova_spaces(obj, vm, true, "close");
+		put_iova_spaces_locked(obj, vm, true, "close");
 	drm_exec_fini(&exec);     /* drop locks */
 }
 
@@ -831,7 +835,7 @@ void msm_gem_purge(struct drm_gem_object *obj)
 	GEM_WARN_ON(!is_purgeable(msm_obj));
 
 	/* Get rid of any iommu mapping(s): */
-	put_iova_spaces(obj, NULL, false, "purge");
+	put_iova_spaces_locked(obj, NULL, false, "purge");
 
 	msm_gem_vunmap(obj);
 
@@ -869,7 +873,7 @@ void msm_gem_evict(struct drm_gem_object *obj)
 	GEM_WARN_ON(is_unevictable(msm_obj));
 
 	/* Get rid of any iommu mapping(s): */
-	put_iova_spaces(obj, NULL, false, "evict");
+	put_iova_spaces_locked(obj, NULL, false, "evict");
 
 	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
 
@@ -1082,7 +1086,7 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 				drm_exec_retry_on_contention(&exec);
 			}
 		}
-		put_iova_spaces(obj, NULL, true, "free");
+		put_iova_spaces_locked(obj, NULL, true, "free");
 		drm_exec_fini(&exec);     /* drop locks */
 	}
 

-- 
2.47.3

