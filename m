Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kvLgKBDE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=keUngtSc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CFB10E654;
	Fri, 23 Oct 2026 15:32:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E566510E66E
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6op22676495
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ss2KL0OlOxY+W+P1n4KMOe89FXmDrXUTQoz5/67K/78=; b=kvLgKBDESPU8ZDsU
 FIwwUJZZEzWiJ4CKEXrtOJUg9AnOQG+p5GN2TlIH/crsEBMur926Tt2fjkErDpZK
 HRJ4BKDDCJ00g/PEcqfWC/zgwxDHBGcwL4kUf8O0GA6JM7YJSZlfkpQr+LqcJku8
 KYvSV9NdZ7/n8B1BMpTIzLGHaz0MclWYnJRB71hg5tELNMcrkJSbxuP4S0rjE+Fg
 iTa/lVcI6sNqLiEcxhbkgmaJlGcsfVXIJjg5TfAMclkVqIpYv4mPbWMbP69SOtiN
 qMc8FYmT/giNSRt7RmLC81DRINxDZPQixaC6g+MUasQg6nUiUKdzyLSdCp551kJU
 xLdlNQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahvrmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cb9d27ddcfso173365137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769529; x=1793374329;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ss2KL0OlOxY+W+P1n4KMOe89FXmDrXUTQoz5/67K/78=;
 b=keUngtScfN7kpl5jdaa3iq5Nk+gzllDHqH0IROQEYNzsjlWvPOLkfNky0tmvQwngmz
 JucNCjuP8snjDA35A5AfrS/Jc7YwUW2qWBuGD95wFfgqmXltoskoFV03joaoyXGNLW8m
 FhbTKDlGapH7PEJE+Hamk5Plduw29+O+vPjTM65Il9yRdMOI0dEbEIwUxEWrsrqJ9UWF
 4sip7A5i3djM86awoSE+SY9Ciffq5FZ2b9/9irtjpcLWOl/o2m0JY8AwBUqFhOg9pSHD
 gM/06+V0t2gxR2Xzw0Hcw7lL1qINezheP5QAUsdMNBR4FZbVeG8gXFGEYRu7TrpdbEm2
 dkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769529; x=1793374329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ss2KL0OlOxY+W+P1n4KMOe89FXmDrXUTQoz5/67K/78=;
 b=FQfC6C/gA2RDkhEiK+Gd4eKK0CNYMUxvOHGiBAM4jIAkjy7QOIM7hBTLKqE9tDaZ0a
 /vYpvLx0NcQ+JpFZ8zSRHIlDugzbVdMOW9TlZbb5BFGn5N+mYdG3rFYCdN6LWGp7mpPI
 Ov+GwyC1JCiiGXvI6xAxWBQeoBvk6oxiT+C0DkUTkbMqOmrZXKWzk1HBNT8rKMYN7pT2
 RI9ufcAvLE3f+lOHckAxybxMHpGPpJu1PSnhS+gDAvYIbkAQNOQ15Yl+G1K+JcIvodV5
 UrEAuhM2Y4QFlVkwoFNzdGXi+uGn+gkcptr7fzTV0Z+AtWvVOTfKlN+ZE3VN39dyq5Th
 s7FQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByO25wWKtkFcteg3U3G6a6Fhbl7EphcqqlmEBgRZHCJy7+LuO45mRY1pSXmKOcKkNnQM/fJFAcMqe4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNM5HqB/B34xMa3C54SAXvlMYnewlU9Q6OhOqrsTxk/v/frj5N
 +pt6jjw6bZZRk+/TxUYi6XcHs2vYatLLZRo0f7Qd1ptClpbeQO/kGT+xAhzna3mWyjPGxypunF3
 T1aVDhercowWsxQqkdYPK49A50/1qw68l0gYSIEKtN/ojctTBLBB5pmaZwpyxWLKyKS0XSHg=
X-Gm-Gg: AYBFou3ByWuNUJcL2dZj5/pix/uaTy/NekT7g9WYcnjvwK7A4aafmTe9GYhcvmhpTvJ
 C43Qo0L3vl8l3sFBuedqD6wUuJ5l1rN6x60rh1roqT1ozKhxBEtkeqs5wS5ESG78fA+C9X77fWp
 AAoqjqlHmo5epNtanCJqTvaUFZF0LHMA2wuWpgV/GUw1ByUBhdIWu9T/lGwgHFKZg3iUJyW0+FB
 Gq9gdhazhGSudmwJQBLXqUBqa+6j9M4GP62HB4lmXp6GYT5MLWPwrJV4TfabrW3v6Myvh1fzWo3
 kfT28/onLe9KCFljVWNd7sEuKqzJ89B4jxwz/y+vjX7PY1CT9IG/tl/5Ko7OSPAuH43d8Q61xNl
 3jM1sq6J9hhDd6qiBQx+K6k6h5gVAYLb6oG9rbkozkQrdG6dsS6JqIho6QtxT6/neud4tGHENIr
 WInE24nI2SePO4
X-Received: by 2002:a05:6102:6445:b0:7cc:9d82:61e2 with SMTP id
 ada2fe7eead31-7ccc31cfefdmr988221137.13.1792769528996; 
 Fri, 23 Oct 2026 08:32:08 -0700 (PDT)
X-Received: by 2002:a05:6102:6445:b0:7cc:9d82:61e2 with SMTP id
 ada2fe7eead31-7ccc31cfefdmr988186137.13.1792769528478; 
 Fri, 23 Oct 2026 08:32:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:32:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:29 +0300
Subject: [PATCH v2 14/14] drm/msm: drop the runtime PM flags from the KMS
 teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-14-83727c122de7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4747;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=B4JgGLbwDstbXJHsjEO5t0PiEr07XCtrTjLF1Zlgghk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233d05ctLcFT1lQ5L0/y1fptF2HZbcHeyP4sb
 JAkkvqqzfSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt93QAKCRCLPIo+Aiko
 1SETB/9GthrzeNPq8k9LtQHSiF43VI7ukKfO1qp+Sqy1VfPwJGk6afIi5bG9zV9tuFc3RXD7H9S
 Wdyw9IQyb7B0r8OjXjtaPsp3ABNorMhRIe+ar2YRvLeRN0v/J04O2oqFuI/u7hYEiPuNOfzIEkX
 a+byim64iLn2VYOaMOZMNT4qm0TEhNSiQd8SN9KrUDiI5iB2sdUPxGifzecdttWjyYjiAgLJHvM
 vQwH9gdoe6FgLUwN7HBlulveia31pWVKDg8HF7TABV8sVfwT5PFJuhaF43nXuvt3uL9ok4N5H49
 AOtjRoBdgN/3XUcMg3RXyD5dxC+F79DScnWsLE8tXz+K5+z9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX0wjhhosNIhS0
 76ZaKeD6ASN/BFS/xb/za/zGkSJp9QGaHfuzts2taIyH+Pwh2CaALGLsh29GOTXj5/e2f01v/Z4
 InO9iQGKQ7FwFyQJjNR+eYS0VXlbJYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX/YAIMx8xDL5b
 pJ7qXhIYB4hAC7VhsFVlamYr3VZEsokyd3+Z1TowTCxARf3K4uQcwwPUJLRtEal2JdpzDMrk3RN
 nu2n5qT7BqbsYf2KdSybo9Y7YmvhaSEIqdzDRDeJ72usoj9mt2zTfnI6VxhJIPRBACbTkpuoTkO
 Xytmv/eCbUsUvSwwW9eELerVuLOJZPns3ZxhtOHuMegGMO8zVZJvo3z3oYSByMQdZ64mtzgXbH1
 GpQk26kHyxK1SIwjqqZi9oIV8cTy+nCUG0RC/838B/4i3kO6dFcN1wmbaO/rvDHRFF00yRuAcZT
 ShEX2YakZNTihsaXJhCWsyQPrAASfs0QFQheNoDSC6eNDaJfTxVOr2/bh18BvoLeY1kqgON8aEd
 pLhZTAx4BWVrgRTEVhDGZ6S5MbnrZFEegVbbjboW8f2vF7uQH61K+PUN8Jfevh0oXI+rxhiJPIe
 /2mF8ZbnEy6elBC781A==
X-Proofpoint-GUID: R0CBIUxnqFaNk42pULL9ykBjAuN-cvh5
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb7df9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=83TlOTTOEq1NsKmbc34A:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: R0CBIUxnqFaNk42pULL9ykBjAuN-cvh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

The DPU, MDP4 and MDP5 drivers track whether they have enabled runtime PM,
and MDP4 whether it has pinned its blank cursor, so that ->destroy() can
tear down a KMS whose init failed half way. ->destroy() now only runs for
a KMS which was initialised successfully, where both are always true.

Drop the flags and the checks.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 4 +---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h  | 1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 7 ++-----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h | 2 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 5 +----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h | 2 --
 6 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 3546efacba3c..e994fd267c5b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -927,8 +927,7 @@ static void dpu_kms_destroy(struct msm_kms *kms)
 
 	msm_kms_destroy(&dpu_kms->base);
 
-	if (dpu_kms->rpm_enabled)
-		pm_runtime_disable(&dpu_kms->pdev->dev);
+	pm_runtime_disable(&dpu_kms->pdev->dev);
 }
 
 static int dpu_irq_postinstall(struct msm_kms *kms)
@@ -1320,7 +1319,6 @@ static int dpu_kms_init(struct drm_device *ddev)
 	dpu_kms->dev = ddev;
 
 	pm_runtime_enable(&pdev->dev);
-	dpu_kms->rpm_enabled = true;
 
 	ret = dpu_kms_hw_init(dpu_kms);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index e39831a397b1..769b8ce6332f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -87,7 +87,6 @@ struct dpu_kms {
 	bool has_danger_ctrl;
 
 	struct platform_device *pdev;
-	bool rpm_enabled;
 
 	struct clk_bulk_data *clocks;
 	size_t num_clocks;
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 58a269cae31d..0668ae79f6f1 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -129,14 +129,12 @@ static void mdp4_destroy(struct msm_kms *kms)
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
 	struct device *dev = mdp4_kms->dev->dev;
 
-	if (mdp4_kms->blank_cursor_iova)
-		msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
+	msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
 	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
 
 	mdp4_destroy_vm(kms);
 
-	if (mdp4_kms->rpm_enabled)
-		pm_runtime_disable(dev);
+	pm_runtime_disable(dev);
 
 	if (mdp4_kms->vdd)
 		regulator_disable(mdp4_kms->vdd);
@@ -437,7 +435,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	}
 
 	pm_runtime_enable(dev->dev);
-	mdp4_kms->rpm_enabled = true;
 
 	/* make sure things are off before attaching iommu (bootloader could
 	 * have left things on, in which case we'll start getting faults if
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index 06458d4ee48c..9dd829ec9401 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -34,8 +34,6 @@ struct mdp4_kms {
 
 	struct mdp_irq error_handler;
 
-	bool rpm_enabled;
-
 	/* empty/blank cursor bo to use when cursor is "disabled" */
 	struct drm_gem_object *blank_cursor_bo;
 	uint64_t blank_cursor_iova;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index c349eedd55a6..bbf459bff35d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -575,9 +575,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 {
-	if (mdp5_kms->rpm_enabled)
-		pm_runtime_disable(&mdp5_kms->pdev->dev);
-
+	pm_runtime_disable(&mdp5_kms->pdev->dev);
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
 
 	mdp5_kms->num_hwpipes = 0;
@@ -734,7 +732,6 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	clk_set_rate(mdp5_kms->core_clk, 200000000);
 
 	pm_runtime_enable(&pdev->dev);
-	mdp5_kms->rpm_enabled = true;
 
 	read_mdp_hw_revision(mdp5_kms, &major, &minor);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
index 7bf2172fce0b..c0b163c4baa3 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
@@ -62,8 +62,6 @@ struct mdp5_kms {
 	 */
 	spinlock_t resource_lock;
 
-	bool rpm_enabled;
-
 	struct mdp_irq error_handler;
 
 	int enable_count;

-- 
2.47.3

