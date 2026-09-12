Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF854C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 14:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C0410E6D0;
	Sat, 12 Sep 2026 14:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YILSQAJj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ViLhb/eT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5080D10E6D0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:59:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CEe6Co3149445
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qdbegSn+POyj07QfBSr0FKovBmkNgYaXeVZ
 djxMNseQ=; b=YILSQAJjhaRhnkh9oigecfm4D30TXO1xLJUmGjV5EM+L1dn38Ye
 hGmsvHcD1E6UIpWUoG0LydleLJp2ZD+DWX1VmQREv/VHGOINu6CdPgtnlQP46Uhh
 140UeWYI6C4rsaLnDTmNkiI/YLLTlr6nYVkAWpy5im4cFeKu75kFE26Nr0u12DUm
 8vWRmbcZiI0NSMiNmUjrstPb8iHZcgg2WC+owQRmv53UzlmdW7VGLRU17h6iAlzA
 eyrODTs9o6wb8BCYq2fKmuDvg9nzbv1KLpCRKVzOyRiUWliAkSXf2Aq4bBMBrGgc
 rBlYiN3eB2BI4NIjqFuONSuHy2MUzXCsDEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d96nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:59:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so3337762a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789225166; x=1789829966;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qdbegSn+POyj07QfBSr0FKovBmkNgYaXeVZdjxMNseQ=;
 b=ViLhb/eT5KaVF7v4XqM4/zLf8WGRzlNWUC0fzKke7gTL8icSQRV5sof5+18Ve/8Mmn
 tQQ4VrtMRhmuhUA6EmX9gXQXz5xjMF0rQU3tpHX3TeQG7k2Rh+J3hlxjIbBBGijIU+cI
 vqfqe2em2Ewi1yGH0rsZSB4ElSJgcZ2ID4+4+BTQE9E7EWz4I/lUhxbkp+z/zkC9JZpn
 g7YYJWyqOZcLXighv2GQKNhDqKa1btNjaMQodm42y2Pfd2j+q1okKGPhztqEsymnY3fD
 eaH7BRCIomvm8A6GcoSksJK2Igkn6sxmlUSZW74Sl1nfE7G9jhG7a0mGPrfd1cCnHRwi
 Awcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225166; x=1789829966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qdbegSn+POyj07QfBSr0FKovBmkNgYaXeVZdjxMNseQ=;
 b=che4ZTymi/+4jVm9PUGHW75hM/Fkx9CHoMMMGjHIhOiK/XJlJDcNsSSiemXFmYJAsG
 eFGft/itW8sJx1LhsOlUjxunR0+QqAHH59aGgG7ED6Z3KfeLCS/BU7nZm76TJTct0Iq8
 hh0+VsY7XlLd5D34zITN7xEfWhKC4jjts7d3vENCpwhRbRyFtCCbV7k50pjY6P4rv76N
 liD739b4nhLwRX9zAyASk3HATaEN3bbKMo/PrFPDMg6Yi5YtCA/KOBx30rMHMZOSb78e
 IeGN/LMqLPIo9zsvn0YAKaYgeGvZdfjc1fRCbWt0kllWVGFaBzz2dDR8G5VC5mrffc2y
 E3lg==
X-Gm-Message-State: AFuF++mKcrK2ZCwSjb0qiOV3xMvc88i/CDfEMWYuOdjn9u93zGsAz3Ue
 ERmh4Wabq8BTRk75DZHddA0gT6FUqfV572I+X7zBdmujeH1AZKav05RWBO/PLNOg87I2caPd9W+
 lUingaes6GsRBGvuxXZWhAMq9dZH96wq1aebzg/V2s6vHP2CUjEVxifVAj06IQx0J5exnhEujbk
 vAU1A=
X-Gm-Gg: AYBFou3irGWOyT5uTbN8vHXtCEtoAjM/aXvQ04oJjs90DKdRUBOggtx5oVHeXhzGUrR
 QvTznmVOI/rwmmgnSTlqzDC3NpNeQY2OT6GL/v5yPgysbGed3y/1nUw59BlQstARQiesPASnyUv
 aP9Ug6qfkULhkGrU+l5DYOVSrLNlfsvitGQAd9m55JrbXGmsIZeWnoE3jmFQ/EnERFt6WeerILr
 rkBUf6XbfowGQUlKzf3TLPhNELXB0q9nMUjadilLnXwdP2Hf5Nuqhfy7xKrRqc2ps9AhlgXlfnj
 GMmIES+iEcdHqVPubHnz1uTYtse5k9V1dX6aQoDRzeSwEQ9l+G/tKWy0UlAGWfjW6JdxcV3Vaoq
 HLzGRDVmITkpg+K0o0dRzZTSxGU9867YVkPj7D6YW2dRGzMQ=
X-Received: by 2002:a17:90b:1a90:b0:398:b71e:60c1 with SMTP id
 98e67ed59e1d1-39d9c2346c6mr16000764a91.12.1789225165667; 
 Sat, 12 Sep 2026 07:59:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1a90:b0:398:b71e:60c1 with SMTP id
 98e67ed59e1d1-39d9c2346c6mr16000726a91.12.1789225165245; 
 Sat, 12 Sep 2026 07:59:25 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95092c06sm11060515a91.4.2026.09.12.07.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 07:59:24 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm: Enable THP for GEM buffers
Date: Sat, 12 Sep 2026 07:59:21 -0700
Message-ID: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDIxNyBTYWx0ZWRfX0L12YyL3JAUG
 r2g1fLth/3FZ4f57iOdeIgFt+91ot/mtvZbiobcfa5cM18gddrPJcHBkn+QYOHXA/AnN70+QlRQ
 RtAoGEW0Z1q4Cl2q1U23i8ljGFZB6foL97cvwkbDMS6rXUXN13+lQrC+YI1OmJjyTC5C8bf06mD
 4QwUwsZfF5oAi7RHozQibpMIVUrgOVnLWw8qxJUlmV8tiEib3Ka4Aekml2wRNyD0CvtsN26lPsw
 JkbvCQCBsCXVfvjfmzIa/TTk2ksXXKv4z4QuVMq9Yev+T2EpuhMZ29MLa3c8p5WEJ6jIuWUG3K4
 Cu+QEug3uDCy6/UZuDPDcV203Ox67V0MFU4sCKmQRlnqH1wJ3ROGJrdxV4HitE8cHeZxv/JCg34
 7oV8ahY1VWVwxceLubddZJfdGPEZ+3GL8PX/tmjly7zIZm9UTZceh+CAehrRW1ph5mag373bMCg
 gGXu7fEbUo0LwAdhP7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDIxNyBTYWx0ZWRfX6kl/hEELfzys
 Cz2N2Y7UU4JzeI/ktJP/FDJ7BYga/G7pQoQWkLqzibA9fL1gr1e1trcSNe79TiTdJb+cJC4pNY1
 yia3oz+SN4DFwN2SDo6UP1nG8x9SIrQ=
X-Proofpoint-GUID: t-leGnPpj5aphMn6A-awuKpOD7VPpFmK
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa568ce cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=bo7bELecpVJEBXAwH0gA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: t-leGnPpj5aphMn6A-awuKpOD7VPpFmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120217
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

More than 2x speedup on darktable benchmark which was bottlenecked on
page allocation/pinning.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
v2: Initialize THP earlier
 drivers/gpu/drm/msm/msm_drv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 73d99bde26f1..581903ccd5e6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -58,9 +58,31 @@ static bool separate_gpu_kms;
 MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
 module_param(separate_gpu_kms, bool, 0400);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static bool transparent_hugepage = true;
+module_param(transparent_hugepage, bool, 0400);
+MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (true = default)");
+#else
+#define transparent_hugepage false
+#endif
+
 DECLARE_FAULT_ATTR(fail_gem_alloc);
 DECLARE_FAULT_ATTR(fail_gem_iova);
 
+static void msm_gem_thp_init(struct drm_device *dev)
+{
+	int err;
+
+	if (!transparent_hugepage)
+		return;
+
+	err = drm_gem_huge_mnt_create(dev, "within_size");
+	if (drm_gem_get_huge_mnt(dev))
+		drm_info(dev, "Using Transparent Hugepage\n");
+	else if (err)
+		drm_warn(dev, "Can't use Transparent Hugepage (%d)\n", err);
+}
+
 bool msm_gpu_no_components(void)
 {
 	return separate_gpu_kms;
@@ -161,6 +183,8 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 	if (ret)
 		goto err_msm_uninit;
 
+	msm_gem_thp_init(ddev);
+
 	if (priv->kms_init) {
 		ret = msm_drm_kms_init(dev, drv);
 		if (ret)
-- 
2.55.0

