Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C73C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94EC10E3CC;
	Fri, 25 Sep 2026 15:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jIh+/103";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DUxl3gqX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E15410E2A5
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PA4JL9609258
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YsHFeSAp3CU
 eDC6/pijBcy66HKE+cMN4f7sayTp0/R8=; b=jIh+/103IYUgxoTwAISVwVI9lYA
 8X9dPiweKj3Cj0ivXSMIKmEEEYGRkUWAlt253f8PyQYc5/C5IXZKTsHM/umc7NKA
 2qHjdlZledxNycrIjw0fOBEbnjABaVvwICnn0YA8AvagzVYEbEgDNlPIGtXsrNyp
 jsm/bGVdqYxHfYx7CxYfX6L5j0HxotN3Xxhv15jXbjs9NG6eni44ZN5Na69g4V6i
 y7nAIjsa5GyCEmkP+3JLpXFcMhqq1R7qf8iIV7LFudxHOYebTl9UKNvj0Wf590Zv
 pvNmY0xMfykGXoiZlTQXIYgWC5D+/2MeOiaVPRfK8in7WG24ohov7Ck8oZA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvns6pq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8710450f731so775834b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351921; x=1790956721;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsHFeSAp3CUeDC6/pijBcy66HKE+cMN4f7sayTp0/R8=;
 b=DUxl3gqXPIzvBQcb1/1pwxUz4+7GD6LVKaGyoH4gw69LN6mVXKj6Y/tysd1jf92zH8
 hn27b7AFK6mz8lo6f7Xrq9gJYWhtvapwtJcJc9hoqrSDZ+nG/gwvKI7vLv3aHwS1fhRx
 iIqzYH4JzYwKxUUmGGjZdSUh1Y1sfOGlgBA8xdsWnNOiAKo1XZJWb4hQTzpK1vOyhTV+
 PTSYljANTBm8jFp/w17UYBMkexBUNbcYKyoA1oonBpg8nJfSx5tkpS7cAs+A6ZmMnA7N
 zvk+hUH8YntDYSrasVO97Crr/9UZusU+HWyeu9O56ld9BYnOwDF9RWRiUehT6/GNZSAX
 r4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351921; x=1790956721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YsHFeSAp3CUeDC6/pijBcy66HKE+cMN4f7sayTp0/R8=;
 b=NLYqSgJuyDdh+vTBPoSepBOSBtAUSFD2lIcTY6HiB8fJKLXm+x+2xmYYoXsgrDgWFn
 3e7P0PeEe4ZkNyEQrdjjpb75zyzk1W0ZEddPLBs4ee+Jjtyf3dA5zQwp195Ncy9vavRB
 XcHv3uDi0jUKkBzGQCQNfERxIzn9T/1Nemr4AcTMQprCEyF6/oMIyPrjLW276bxtAYcz
 odv6wT3wJUBi8HzGzkdfLC9r08hb3gLZatoEDx0uCzhvEedfVzSEtk1aruSMAnMC3rBh
 2xoP7VCzosBORl94GJ2iW667HcFeW0+nJ+qnp8vlmw4dDgyzUv9xQxReqgu2HdBWeo9g
 BEvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoRaltBx3fMOYcJyd3KG6Ud9gYJm4NP/7lns+l6M7tKdYz9rXdQMBZeIIbWBWdRGrOpMZg2TywjI4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5O1NklhTUkBVMBbB/Ghs2F62jeiVP9veTBk7RNGsgSittevLY
 dVXmt6Ybat05daQAONaeKlPkZ8kQFsVYqDQHOZhOwrwRsOIE2Cg/7t3eW6cIKrMqPonD05pcOfA
 TSMq9ar427yrfWw5s1HddKk1yrza/ZcpDHFE46+pPavU/1HOEmwSwFpFBJncywRYl2l3d6Zw=
X-Gm-Gg: AYBFou0sHhdbRcasJXp0uw/vlWnQy0R5l4rkHTUYxnNSMK4mYJ8DvmEK9YOO9RU4uHu
 im4TzK7MawGnbuHluJrXL97NIuG1hM/RKZ5J+dMU4KZ/CkqL0xGg+fj1igofhTVvgiE4hBjRj6A
 cMUJWZ5Kz1+/h+A8jr9wWBWby74ydNJdT2FWpd9HwM4ylhKdxPf80dssDbQ0LTtYcbw5oTXcsMa
 xDo2hSW1dduYBqUQgmpXAfVii+xc3Og/GnlGC5bpT67v/JMrd0pParfocXcwCMTGUcHDbd2W0PV
 7oDHg98qa9h26B62WMvBmGPpDaNkn5E1zqD7fwnFAfFnOYx8DhUfuMLLjoviQekKXF41v0zOUXk
 aAEqcfP0kbmvXtzC440AHKTdii/U=
X-Received: by 2002:a05:6a00:301a:b0:874:708d:b631 with SMTP id
 d2e1a72fcca58-87e9d8da4dcmr5253184b3a.29.1790351921269; 
 Fri, 25 Sep 2026 08:58:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:301a:b0:874:708d:b631 with SMTP id
 d2e1a72fcca58-87e9d8da4dcmr5253154b3a.29.1790351920637; 
 Fri, 25 Sep 2026 08:58:40 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:58:39 -0700 (PDT)
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
Subject: [PATCH 4/8] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:33 +0530
Message-ID: <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eB1sx5FKYdQ3dlAvZjgt1klTKJVIx8Zq
X-Proofpoint-GUID: eB1sx5FKYdQ3dlAvZjgt1klTKJVIx8Zq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfXw9Bua3VlFbfS
 cPYsD8Zi5HHZL35+sT4FgIkYM62n2zA5bfDNcIRQEbrNB2sW+X+6GOYLnoap4AqpHsQccIupz9m
 r34X0AG8i8zPyzA4nLtRb20Ot9zSkSo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX5pXS5qPyoK+d
 sTRu6SVXRcROn1sC15FnywQUKiM57I3Mtf1e7+cwssYvEyDteVbqImYLPUGekxaVgQHubG855Xn
 9bQJqDcxbafEVF6ZKBBuSnu9VCCwacAxbOwoImlQFQWCVG/enPB5JWkX2PQhy2KUOq/evwibHDO
 rTIdjmVRdXJ5OyqAxD6PgDDGuG9YH/G7c7wxyw+reMpKM9LaKS/YQUGCFr25vX87XSol75doTrf
 Rsm2vSWBfxc48PquazyVb3LizfH820Il9Mq/WcdZcXeYPGQ+AIt/NCcXTFybZZ+2mUt91I11JA5
 Vse2AMCh2/H0Oi53SuZc3YpsXprlHCI6qtsixGTr2IlkJ2AW+eNJ+tCtT7nXmGW5uGhHpjJRx4g
 Qfm0ArPlfVn4SD8k86oPTO11v5dDdF2WahGvqIBodDu15yiVLkV82comJO9wAxUlvEvpMFTOA3a
 o9OAbXwPaDV1H1QCdQw==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab69a32 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=KXBF9D8WR1mqcvW3O5AA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063
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

venus_load_fw() uses qcom_mdt_load() for the TZ path and a bare
memremap()/qcom_mdt_load_no_init()/memunmap() sequence for the non-TZ
path.  venus_boot() then calls qcom_pas_auth_and_reset() which skips the
shmbridge prepare step required before TrustZone authentication.

For the TZ path, add a pas_ctx pointer to struct video_firmware so the
context can be threaded from venus_load_fw() where it is allocated to
venus_boot() where authentication happens.  Replace qcom_mdt_load() with
devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), storing the
context in core->fw.pas_ctx, then pass it to
qcom_pas_prepare_and_auth_reset() in venus_boot().

For the non-TZ path, pass NULL to qcom_mdt_load_no_init() directly,
removing the explicit memremap()/memunmap() since qcom_mdt_load_no_init()
handles the mapping internally when mem_region is NULL.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/core.h     |  2 ++
 drivers/media/platform/qcom/venus/firmware.c | 29 +++++++++-----------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 46705a666776..adcf67043bf6 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -9,6 +9,7 @@
 
 #include <linux/bitops.h>
 #include <linux/list.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -223,6 +224,7 @@ struct venus_core {
 		size_t mapped_mem_size;
 		phys_addr_t mem_phys;
 		size_t mem_size;
+		struct qcom_pas_context *pas_ctx;
 	} fw;
 	struct mutex lock;
 	struct list_head instances;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 3a38ff985822..4ea4c7769ac3 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -86,7 +86,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 	struct resource res;
 	struct device *dev;
 	ssize_t fw_size;
-	void *mem_va;
 	int ret;
 
 	*mem_phys = 0;
@@ -117,21 +116,19 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 		goto err_release_fw;
 	}
 
-	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
-	if (!mem_va) {
-		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
-		ret = -ENOMEM;
-		goto err_release_fw;
-	}
-
-	if (core->use_tz)
-		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
-				    mem_va, *mem_phys, *mem_size, NULL);
-	else
-		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
+	if (core->use_tz) {
+		core->fw.pas_ctx = devm_qcom_pas_context_alloc(dev, VENUS_PAS_ID,
+							       *mem_phys, *mem_size);
+		if (IS_ERR(core->fw.pas_ctx)) {
+			ret = PTR_ERR(core->fw.pas_ctx);
+			core->fw.pas_ctx = NULL;
+			goto err_release_fw;
+		}
+		ret = qcom_mdt_pas_load(core->fw.pas_ctx, mdt, fwname, NULL);
+	} else {
+		ret = qcom_mdt_load_no_init(dev, mdt, fwname, NULL,
 					    *mem_phys, *mem_size, NULL);
-
-	memunmap(mem_va);
+	}
 err_release_fw:
 	release_firmware(mdt);
 	return ret;
@@ -237,7 +234,7 @@ int venus_boot(struct venus_core *core)
 	core->fw.mem_phys = mem_phys;
 
 	if (core->use_tz)
-		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
+		ret = qcom_pas_prepare_and_auth_reset(core->fw.pas_ctx);
 	else
 		ret = venus_boot_no_tz(core, mem_phys, mem_size);
 
-- 
2.55.0

