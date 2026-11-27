Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD338606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dl/yAJg6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MiXf5xP1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC8110E622;
	Fri, 27 Nov 2026 19:45:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F271112962
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJU3sA526535
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=; b=dl/yAJg6V5IWealc
 HonWl/XayYEuUqwyZ+Kfr8HHgX7Ijwt6uf1DJGJ0xFx+7inn0QANbZjDt49Jspms
 7rPIKLjCydUe6gBAupZttKTZ3FNxYYW3J2mWUd4k0k9ceP1uvjtuoQSh/uDsqSuF
 oM1H+nK0hB5N8sydrAIT8/UMl90N0YdBNwYmAfnP1myFc+dE108gZ5ZaXhG7QjJg
 +GOdnalsEhgmPF1SrhRYXaZyRnJz/RASQWEzfot+HporP1yfMgnijoJXWqdqk4dA
 0nfYX6msWf1/qfiRd3h6ppmXtOyfB/dMz3l8OKWZOGWc3ldZJDL4rCkg865a5yd3
 63WyEw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g2dr120-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5363763b556so150852931cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808699; x=1796413499;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=;
 b=MiXf5xP1zvqfbKrFMUsnhQdIgiaRe2dtlMMpruYzOeYj4FTVcTy+4oOo7BmBi8ZaKy
 6+HzJyw9CRTko1oKg+p9Me3OWNjmmXYoqXGDN+ih4J2OoVlc43qPaQu1L4/wEI9/fjoF
 MITRW0iLHUBUAXXubOEVpACC0wzy15kmpp5WcC5cQRzUzfQhouoxqmHXGMTTCGUGePfV
 rTC9yP7BU19JlN+RY5sbQzuCD3p8m1WFhP0dDb6aeJhtc6Xj3JGZ3mB2vAA4NsfK4LQv
 UPQlTkUlmnZALq+p42tFWYdcop4fVBYeIBTeay6HaiQCNLmuJmVouNhKJ14USW0vsWo5
 eMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808699; x=1796413499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DYGTs70w9uTE7kxNN2SKwMuIU2Rlqde6W7n2IpjYaPY=;
 b=gzdG/Hpbeh2mRCPwiqz13PC31VteGBMDxqNVX+f1C3apWx3oLVMuJm4M4Rs8k2mn/u
 WFsQSaD0AhRqjL9VfnnBJqljyYZFThs6jTppuraPNzsTAt4YD162/BOQGhTXyUo7nQE1
 +oH89NT30pT9OdcrzOYSE6eH2qSVEIh40go/BK30tGQAJnXUpv/EzBjRTRiZ1kFnLFAP
 YA+secLGBGxRLDqTUQ6FhUP8cmJDE+PUbmhqhTba5/DCVLINvNF6RjGmGIWfteGxEZ2d
 hW/1VSlokPN4cktPkr9jzupz0hCHkUu8LM8ZdQymIjiqZ+yWq8TlDlYUiL86HFrnZozP
 tPPg==
X-Forwarded-Encrypted: i=1;
 AL+hErHyyygCGgytto14TMlz92qRv0MxpTOl4RZbP8dsPER3YexAJpqopNE0CB4sK/l1jsJd9aMwUfa79dU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8vTEtpPzHzZ/el48lVEZGFL4e6iaa9IZlFi//ZQyQZ4tX6q12W
 RWXcWXYetdxTmxY0cgSNW3uGK2jUrrm6e7ZkwRg38yYM5lS2MI8cJZ76bpF5Wq7A8a10aB7LnE2
 u9IczPqYu/ZFkcNTPr/eNyMHcy1U+AD89R+vgpZva9Ek02bWW13/6Aehtp0rMGwymv83sXgk=
X-Gm-Gg: AZFdTZdsx95wdRfORVq4Nxyw3MhoxlKgoub1iNbmhkPx2t8gldYsdIaqTM5ZKE0TbgC
 n9ZKeCR9vOEkq2N2ovX1J+mbg9Tqpuj1iE6KxGeSV7gh+cqeN1HhWy0zatNNX6u4JFmOBxFj+0x
 HAdMRi0zFeBoIzIv9UeVnCPRmL/MKuhoLE6wlEA1Hg2MlfzXSMowUtdRqXK40EKnaCA443197l9
 BSQWD3Cy8I92vkuaZrFdSh0GiECcaFKBfZoE1y+qymYClsTK/stzo9c0cYWBc9HzT/Mhj7YGao7
 rf9H8rB93akd+wnDVUvXDlH9PTlQ+w2A51ON8SkxC3Iv4p63+R2RbEDPmNA720YGKe4yMhR1chJ
 qfUsObN3ApKiLvsfmK4DXuBAcVdKSLIhWhCxQWL6GtmFQ/u0p8y6Qd/R/XXDUJX5sa+ZP+fnwSQ
 Wwjt4Mh3G8DRGpqW5o1c3jAth73JfY9uny2oUVjKaDzX4AloAy030Ijuqs2h4c9A==
X-Received: by 2002:a05:620a:29ce:b0:949:8901:dcab with SMTP id
 af79cd13be357-949ba9b3de8mr4738195785a.23.1795808699348; 
 Fri, 27 Nov 2026 11:44:59 -0800 (PST)
X-Received: by 2002:a05:620a:29ce:b0:949:8901:dcab with SMTP id
 af79cd13be357-949ba9b3de8mr4738190885a.23.1795808698864; 
 Fri, 27 Nov 2026 11:44:58 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:44:57 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:17 +0200
Subject: [PATCH v4 04/14] drm/msm: order the display snapshot sources
 around its worker
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-4-242b0a3f8e47@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3385;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iM9tCgrXdMoAc0lpkEnlYv/1Wi0+ANIcrUxdVoj0Zoc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2bGB58rqVr8hoJL8BnbuQS4YkuMzpnyL0Cl
 tSINwYNVr6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndmwAKCRCLPIo+Aiko
 1X1kB/9vKjFh9sbWfnCE0uG58KbQXR/HZIt3VNbJNfmh2xHotRLuCJvPfk/oovco5wLCwpDdbc/
 EZwQPgT/s/O8BdiL/7EuYAEfB6R5i3/qloDBIAwprPX7t4mLS0GkNMloOyEaNOp7toaJYxX9XMG
 Pv0N6kUgVzNnPKLdXgWsnrBMhLlJB2YCcVc36LV+J06r2Y/OFYZKR6TkQTloo05WxWWAhGE9c3z
 +YYPPBJEfbM6ZgOFkcD9004KMDjT1CXYYY3VbH1YYhoEkRSMmOG7QjKXXMBMhboZ5h1pWURUQno
 kV68Ky1yMdhNfmaBS3cIYhmpmKj+yukqpl0Gg/rEh80vBySd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXwYJgJ/Yqi3MC
 YyUcl3e/jepu1rAcyXqxXOI6/19ZfkCvcXA45VxdPPmkIC9QHId5AMVcps0Iz57gkabj3VGOzPG
 f/vMHRnW/vQVrMXgM8MIP4WmoTxhV8ykWEyaiT/dw/kjq96vJNY88gc9RbobmCsJxA/P/d3yR++
 jbSgfcCGQ+JE1x67i5Hxw9SBrpep2VUVCsEYSSxtFlrDk0ppAPhAWxfjLA5UBcLwmWmns+skSzb
 Fey8C7Q2HBN4QQc0+0geIlIiiFyb8bkquMdo4ShmjFwOhHK8j2HtbrYiSWHrjeJdSX09zU5enwT
 m6vk/ukGwuND6GH52+TtyfAiVpX8ZJS1lt4f43dhH20UVeSBMIwvTVY0Ioz15+wouScOtRiB9ty
 WYuy+7anDS69GT8re0btZmhuqxLUivc+FhMOUe17FP7n3UFDOB4jdbbiStWNIoKlaeCVpr6et0j
 YdFeqFTQ5IiYhTC0/Bg==
X-Proofpoint-GUID: rM74kQqB_56dDqGyF3RWJ6we1cE5_G51
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXxpeQt8YmGJZz
 ri7A3H0ajAzrMovT7Nk5Pgh2y1U3kTvGM+v/60qYmmb14ljEAivtdjdsg1rN7Sp0KD8PtZl5+qA
 hFkAfyJM/ggO7jz639muJbm8qVPehqM=
X-Authority-Analysis: v=2.4 cv=dJEzC+Zb c=1 sm=1 tr=0 ts=6b09ddbc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RYZzOHaK-VtI4H7RTV8A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: rM74kQqB_56dDqGyF3RWJ6we1cE5_G51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
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

