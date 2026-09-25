Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB27C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AD910E3F6;
	Fri, 25 Sep 2026 15:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bxg0wKFs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h9z9OX5i";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5C510E3F6
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PBVGou427364
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ySc0a6RXUPc
 52wNB5/s9LfTmLDyBrV82ex9cPFNjiSc=; b=bxg0wKFsHNjDYHIiEqmTvQWvwMV
 5Nifc4KXUahwyZDMhJ/Uuv5GKjp8sFZ8QKLFvqvDfE4Jr6/hNahGwU4YFgOgkcJL
 RmHMUOfwVKkFGKgiVKweDgJ6OGD6x3Wxb/PlEvoB9uEGmlJ7FU/UtNjegP9Bmxu8
 TANC9W6tQ+pigu6YmdqkRDDgAUrCwATF1hLkBu+CeP+CwZ6CmL0bDzxqLJGrAv6b
 teICyY4UVEPGmxSLnAjq/s6PUZ52w/fcExzJie8VlICxt7Vtmiebx+VtmrN1XiPH
 3hYl6njSsDCk4We8i6S+Q1t0x3tzNMkcQ4YvwE0eG0EmKym71sZBEd8euvw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e8y2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-86b70a52946so856343b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351910; x=1790956710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ySc0a6RXUPc52wNB5/s9LfTmLDyBrV82ex9cPFNjiSc=;
 b=h9z9OX5iGC9OIe3N31gx17JVtHkdMMKCQNYNVRaXMuoG+KjYpvFrH8alic3OR+sndE
 MCHwqEdGjQ7Y0hjShoioBMojFdBl1yJ2mjNcJ6gxfnuBjBA369/1lhDi31z48/EcgL/W
 E3NWEF0kbsC4OsD11/G83eO65+Cyj/HX6W0s5Yb0PiVukexE6/BWYPGgwwz60/nd4Muu
 ER6bb0sU0o5q6CbZIZVXcw2WbaCwshWBLte4h7mtvuyzdTaY3x4NyOiaHNHe56x9KXyF
 CyKFfTqhLHVTy8C3Sk7d0Jtw8peABQcCPlL+fOZ74EB1fmh2RcBcpCgSa9mJBl8+P9Oj
 IU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351910; x=1790956710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ySc0a6RXUPc52wNB5/s9LfTmLDyBrV82ex9cPFNjiSc=;
 b=27a6sHCwFskc4F4Roe+6W85jFB3CXWaJz4o40p9xNOOCoPo0NgMYr/RDYMhHFek+Ab
 it7Z61VXz8nFIvC0C9FSX5SDLnn+JaJ1MZyB6JoPOW6Nu8WfCX2S82FGz2l06oTu65oF
 s8OEufypKTQhFRLy+tcNFQ7WQumzHYOSCWuUhBxH5aDe/7ikouIvuWgzflhWoCdU20J7
 Kbs7UmlaGe5aZTj19MoRPlKf9mBOvf4heD2oCSh+ZWRoEiOF4GkvM80IHgq4GmsH2TLx
 V6roEnMvj5ASSmM1ajNN6p6LMiGdyNLneXQDyCCMDViMFPfH+Bftsj1J2oEpsEi8yqKC
 VYrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSsOQsNOJLq1JEycDqnxEvuFV+ziYW9mtG6i9IDSot3PYc971q7Vyek0yF2Mo0ETZYanJkGu5nPXA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+OQyURaV/JwCchZTyV2FtG9fekUYpRhmf4hB7plb0z5n8c7SW
 sLO4XvA+8xFZjQDoEex+5PvKRRVVfzCAr6vzdU8lIHk2WUE40o9TSOF67Ohr6pdy/d1CggwjSok
 yPmR9uCOfC3v5x0fW4mDp/chQcwXKRkB9aiToNWv/1ZLqxyeLsZvXu73B9pxIzPeauHN/MOQ=
X-Gm-Gg: AYBFou15NI7qS6NmO+he+hTjqZzm9v/PlG9y0A1XVAi2h1Ih6auzjv+3pQWLfO5oXxL
 Kg6jsTGRSZ7wEM1xte2+06UCx+usn7g2PATcUwQzj2gZOoaQZtJCefJnZypYAUv69a+DUqQWF6a
 Ie4Mt++vWqya4YAcL+SLvA6ytOu/0ERuosxnqIKihaXb0VPvhVRwGCwZPA+1+0hT2V59ApSs9hf
 y3wsDcvxSdau8gahJJBeG1fankDQRZUQ+TgFUuUiW7YjbuL/jd6YzRoXWpL+4PJbh/Gf2BnuXZp
 tkeYG9GDoLQni+DpoyvbytR98ZfsH5GPZUlnMABq7kLt4GvNnfZjfub3q9Lk9HyDzziXcW5zk1y
 aM8RNmj1bpZPDMgoxsQuNAgZ8pZg=
X-Received: by 2002:a05:6a00:3d4c:b0:86b:b06a:d3ad with SMTP id
 d2e1a72fcca58-87e99568559mr5209965b3a.23.1790351909927; 
 Fri, 25 Sep 2026 08:58:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4c:b0:86b:b06a:d3ad with SMTP id
 d2e1a72fcca58-87e99568559mr5209932b3a.23.1790351909300; 
 Fri, 25 Sep 2026 08:58:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:58:28 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 3/8] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:32 +0530
Message-ID: <20260925155737.4161358-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX+asnYIPqx5Dy
 Xs1xqMWtRzF4/t0eqAcmrN/nwKlY8ZXxCOi/Ovi5Nuv/MvaIENJjxzItYpExNldx72gV6lu5RYa
 0EbwrVmFI6KD1OZfs8P0W9DKkdFKzT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX9sgVffmOMvkj
 WFxKgCuJ2Gf2P+hJCRRWPrJOj1ajTurQxfPjobP54XdKd4tddAuvP2INnZb4JjqMXADvP9yICj2
 LqgjMpgt2wFd2S3E+4pd8SzHbozWekZyvwG2pkuKyIKnwtInqE3cdSf1iyxqs7QBLQDjdj9m4GM
 r46tN2me4B9mDpjdycb/yWjTcRp/gDQK/RWvDtSD0CoY0fysmm1Al1PP0MkvLWec05118aGGQMj
 pEUvSxe82sb6ghoE9gIB8w6430hnYO0xzCqcVbpF91PX9HwxanXznIRf52qA89yL/kEz5vdhhq+
 5uKHNQD8RyRSH67p438SbcLqZnWoOLYbdGiJI0VkqbhnHPrIYhJeLVkZTkB/aydiVDptkQZZ2kP
 UEr4fXL9gkuME4ovcYbjcIGVpNCmfd7CNU3I5x3JPQf9fN3YK/FRBIl/JhddKyDu4N/6DIUohY4
 DfEJl6pVeu2aG3lnXqg==
X-Proofpoint-GUID: 5pgAME7BhJGLb75h8rZLVMh4JMfN8ctt
X-Proofpoint-ORIG-GUID: 5pgAME7BhJGLb75h8rZLVMh4JMfN8ctt
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab69a26 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Wu4PtPgZBy_53pNpwMMA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063
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

iris_load_fw_to_memory() calls qcom_mdt_load() which bundles metadata
init, memory setup, and segment loading with no PAS context, and
iris_fw_load() calls qcom_pas_auth_and_reset() which skips the shmbridge
prepare step required before TrustZone authentication.

Since the auth call is in a different function from where the PAS context
is allocated, add a pas_ctx pointer to struct iris_core so it can be
threaded between the two call sites.  Replace qcom_mdt_load() with
devm_qcom_pas_context_alloc() and qcom_mdt_pas_load() in
iris_load_fw_to_memory(), storing the context in core->pas_ctx, then
pass it to qcom_pas_prepare_and_auth_reset() in iris_fw_load().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  2 ++
 .../media/platform/qcom/iris/iris_firmware.c  | 20 ++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf2..68e6adcc1dfd 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/pm_domain.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <media/v4l2-device.h>
 
 #include "iris_hfi_common.h"
@@ -123,6 +124,7 @@ struct iris_core {
 	/* encoder and decoder have overlapping caps, so two different arrays are required */
 	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
 	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
+	struct qcom_pas_context			*pas_ctx;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 21cdf1c39835..e73a5dd98b88 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -115,9 +115,7 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 	struct resource res;
 	phys_addr_t mem_phys;
 	const char *fw_name;
-	size_t res_size;
 	ssize_t fw_size;
-	void *mem_virt;
 	int ret;
 
 	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
@@ -125,7 +123,6 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 		return ret;
 
 	mem_phys = res.start;
-	res_size = resource_size(&res);
 
 	firmware = iris_detect_firmware(core, &fw_name);
 	if (IS_ERR(firmware))
@@ -134,21 +131,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 	core->iris_firmware_data = core->iris_firmware_desc->firmware_data;
 
 	fw_size = qcom_mdt_get_size(firmware);
-	if (fw_size < 0 || res_size < (size_t)fw_size) {
+	if (fw_size < 0 || resource_size(&res) < (size_t)fw_size) {
 		ret = -EINVAL;
 		goto err_release_fw;
 	}
 
-	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
-	if (!mem_virt) {
-		ret = -ENOMEM;
+	core->pas_ctx = devm_qcom_pas_context_alloc(dev, IRIS_PAS_ID, mem_phys,
+						    resource_size(&res));
+	if (IS_ERR(core->pas_ctx)) {
+		ret = PTR_ERR(core->pas_ctx);
+		core->pas_ctx = NULL;
 		goto err_release_fw;
 	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
-
-	memunmap(mem_virt);
+	ret = qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, NULL);
 err_release_fw:
 	release_firmware(firmware);
 
@@ -166,7 +162,7 @@ int iris_fw_load(struct iris_core *core)
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
 		return ret;
-- 
2.55.0

