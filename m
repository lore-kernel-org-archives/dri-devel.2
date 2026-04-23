Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B07F589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A37210F12A;
	Thu, 23 Apr 2026 13:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctgTCfjt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQlF10IS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E8E10F127
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8u226366208
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=; b=ctgTCfjtpa4PTPv5
 PyyNE+e/s7ZoDKoP3ycz663AdQE6rQZarcbdD1F6YUw3fWdh7FypSF0LBksp93iK
 DzelQTaMlKXfLas8nCX79AA8eqQ3AN3rVNciLyQZqqBYks0Ae4uDtTyTe7BUx7BU
 BILu61X3m5ukuSfw6Mue+Wdvv5B/mZJ1byo9MoQywOwd2IMMIRMERaWYdqRT5me2
 QSDr8fVr4oyBBLVnRGYfE6x5Oh46gF11X/zk76SNFhKewaC939f6AuqqcbxZJ/Jv
 NsaDThfbGynSWY/8ZQvPQCi1jsQ23m9ejVb6PjGHSyBjf0PzUy6K+W8lGll5HdB0
 P+iSgA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35rbngu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2e06219cbso85179265ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951052; x=1777555852;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=;
 b=dQlF10ISOqqgJ/fDU+kiWCRFodS/NTcfqH2uQj9A4srSi+kSIXhAOqRFXz9ZQpzBQB
 12MQKXkD1LwSjt5XL5+KARCC7Mtr4WnubBxKHq80XVrl4yBxRjZ5P7Bb4sguww7xwUio
 4f0AnuaR86fLnoqPi1hBGxD1I1ky/5kZFzi5BO+ucBSOHRYXD+Cv9EEb3F+6CO0BkanW
 SRkSbzRqZAtC1l5NVVlc/9dxZx20DaCr7TQfvKDysbdnUqlJXqiVk2RkmbdUd2UrblrR
 eXwg5IF0d6FFBpnGC+N9LUw4Nk05pSgWGy56SUafd0eyX8LWKQ4cRxjsRpeNzvgvysRO
 5z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951052; x=1777555852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=;
 b=f0yN3lb5ZnH13VSJ2V/WZV3xRx3VUSqgBlBD9OrHeUpCS7xgfVe7b1Dy7SfiBYxhYb
 /Bw1GEcj96Lje+ThnAh/gPCw09woDi2kNufuBRppYppT6S0RazNPt7zlN3jdHeJhTIMB
 4FcKnYz6uztiB1w1pvCUzHcMQkO5q/6yazfmwCbDiTH9cC8yizKFlw/Zep4RaRTBz1IV
 9vavmVB8pkEsBHlG3pnRYPuybju1sYQJlWljsUXvBMduYaqdoKzpju+2R6Gz9agh0IpM
 9QzH4fTr8gJ7Fuj/8YjC6W4cFp1pGLu0b4C6EUaFoa2XlmlWlO3nTrzK6aoDSPE9b5vg
 FW+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xgf0hk6D5lF3hcOxnYM7p0IKW7h6+/qzVWHfTdOKiJbpiKsCensxosGw4ZOq/gUc1YmgEbTyOJVo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc8wnldC0wKvMI9dJavKV/2jSk+LaQoN1G85FoPq+v8pmwwLb6
 3xFUSqW4FVXpHsBGDtbhr3J9wKOMCI/u0SblbSv9RkDQEHmBP83EHCksnY3JOZEObCVae4Dg5QG
 2FYEy+uKQb4anCtEIm/jcHsZMSVT7dYtdaY3s6qkfcj8W1vyKayS7/OelE+SPJZmHBenQoSc=
X-Gm-Gg: AeBDiesJPlZQyV+dfp5/Z414lZ7V00d6YGDmvZ0/h3tW9RzOiUuX1SywY9Jh4DWSnj/
 k0ouUVh8QsHFDaVGcVg56o3kY95tVPiNwBQNRyOgmVHgSzJvRJMGgSa9qvvAwR/CElt5QCZKTEX
 R/NG13+mig/fkf+2zu+VLCKeBGw7+3yOmot86QrV9BIUDXS48rTy8OnWTwXqOw9M8rybU03iAI6
 vsjbalXYl5ewgor0fOLhba8xHGlTPlnNH7064Rpgccfi2cYJxoAnPS1v5EvOoEqXfs8tehiHPod
 uqSevU47hS9Ltd9UBbzZhnR0lFzWOAhwKBfviTtH40sRDWozGcVkVijNQ/DZWJI3uONAuUfLKQm
 UyvGgSJrIWqs4OpJotqa+fx6JkR2aQVsle5DLX38Iqu20yA+b3GxNuwel0o6ojzJWHg==
X-Received: by 2002:a17:903:1103:b0:2b0:6b98:59ec with SMTP id
 d9443c01a7336-2b5f9f7abacmr276507075ad.34.1776951051725; 
 Thu, 23 Apr 2026 06:30:51 -0700 (PDT)
X-Received: by 2002:a17:903:1103:b0:2b0:6b98:59ec with SMTP id
 d9443c01a7336-2b5f9f7abacmr276506155ad.34.1776951050947; 
 Thu, 23 Apr 2026 06:30:50 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:30:50 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:35 +0530
Subject: [PATCH v2 06/13] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-6-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=6587;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=+wQbHvxygQq1aTrGxrx3UsURZ3ABehuwxnmcohM5NBw=;
 b=IHAV46nQNLUubTgKIDVGhPfQgFqulUO86Kl3iSQPjE5X2LvjBkucJI7tXaO5ADNUMyAYQSmUy
 GeU+J5TShgmD+pOBgO8R/SKND0QoCtlowbWHzfA7yq598FkxFpcLcGV
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX3yuGuVFwyl99
 R7az6+UQsJ1MtTi5bWp+GBEd0/C5T0BMqshkrUI2khPwVM5LwHWrJyi1nQ6O/TpcEsIBMW3Fyps
 RcAoBb3lx4Zb2qrGXBElRvKtqN5MWu+ajUWrfZIlspJqxJw4aRvQpbAj2kdQw3Dl3Fy4Nf6+Bx/
 PIY0KSfDn3UEkWHnm0kPdATr91N5m07eJjjeLNwFw6FY4TTil1KLZSm+wk5sh/uVVujHWs0O/jB
 bcjhuaPftwqwEYhcM46A6lT+43K/JsSpF/eVaqltCwNj8FgjqtqgXXcseZ4ZxhiUxi2kX+evYSp
 YF+tJX9lDMo6ELaU/69yj1Su10U9Klr274vRVFcGtZeg/3Kb8ugdZKkQYhfFPehHQaoQSb27CFG
 bA+5pFQ/xOP8rOYM1z3ZSu/tS4YTO5t4uJC4DA8/jtv+HOewRTYK/a3R4ByDgpugqxEPBjp9fLM
 N73efkGWhovW6o0Ih/Q==
X-Proofpoint-ORIG-GUID: bwgFswHg0gMnkrtbSJp9-OK13Tg6u2Uy
X-Proofpoint-GUID: bwgFswHg0gMnkrtbSJp9-OK13Tg6u2Uy
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69ea1f0d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=gbwaY6mYjfx-u0ET_fsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
or QHEE), which typically handles IOMMU configuration. This includes
mapping memory regions and device memory resources for remote processors
by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
later removed during teardown. Additionally, SHM bridge setup is required
to enable memory protection for both remoteproc metadata and its memory
regions.

When the hypervisor is absent, the operating system must perform these
configurations instead.

Support for handling IOMMU and SHM setup in the absence of a hypervisor
is now in place. Extend the Iris driver to enable this functionality on
platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).

Additionally, the Iris driver must map the firmware and its required
resources to the firmware SID, which is now specified via iommu-map in
the device tree.

Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
 drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index fb194c967ad4..b396c8cf595e 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -34,6 +34,8 @@ enum domain_type {
  * struct iris_core - holds core parameters valid for all instances
  *
  * @dev: reference to device structure
+ * @fw_dev: reference to the context bank device used for firmware load
+ * @pas_ctx: SCM PAS context for authenticated firmware load and shutdown
  * @reg_base: IO memory base address
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
@@ -77,6 +79,8 @@ enum domain_type {
 
 struct iris_core {
 	struct device				*dev;
+	struct device				*fw_dev;
+	struct qcom_scm_pas_context		*pas_ctx;
 	void __iomem				*reg_base;
 	int					irq;
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 5f408024e967..0085dd7ec052 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -5,6 +5,7 @@
 
 #include <linux/firmware.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/iommu.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -13,12 +14,15 @@
 #include "iris_firmware.h"
 
 #define MAX_FIRMWARE_NAME_SIZE	128
+#define IRIS_FW_START_ADDR	0
 
 static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 {
+	struct device *fw_dev = core->fw_dev ? core->fw_dev : core->dev;
 	u32 pas_id = core->iris_platform_data->pas_id;
 	const struct firmware *firmware = NULL;
-	struct device *dev = core->dev;
+	struct qcom_scm_pas_context *pas_ctx;
+	struct iommu_domain *domain;
 	struct resource res;
 	phys_addr_t mem_phys;
 	size_t res_size;
@@ -29,14 +33,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
 		return -EINVAL;
 
-	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
 	if (ret)
 		return ret;
 
 	mem_phys = res.start;
 	res_size = resource_size(&res);
 
-	ret = request_firmware(&firmware, fw_name, dev);
+	pas_ctx = devm_qcom_scm_pas_context_alloc(fw_dev, pas_id, mem_phys, res_size);
+	if (IS_ERR(pas_ctx))
+		return PTR_ERR(pas_ctx);
+
+	ret = request_firmware(&firmware, fw_name, fw_dev);
 	if (ret)
 		return ret;
 
@@ -52,9 +60,27 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 		goto err_release_fw;
 	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    pas_id, mem_virt, mem_phys, res_size, NULL);
+	pas_ctx->use_tzmem = !!core->fw_dev;
+	ret = qcom_mdt_pas_load(pas_ctx, firmware, fw_name, mem_virt, NULL);
+	if (ret)
+		goto err_mem_unmap;
+
+	if (pas_ctx->use_tzmem) {
+		domain = iommu_get_domain_for_dev(fw_dev);
+		if (!domain) {
+			ret = -ENODEV;
+			goto err_mem_unmap;
+		}
+
+		ret = iommu_map(domain, IRIS_FW_START_ADDR, mem_phys, res_size,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
+		if (ret)
+			goto err_mem_unmap;
+	}
 
+	core->pas_ctx = pas_ctx;
+
+err_mem_unmap:
 	memunmap(mem_virt);
 err_release_fw:
 	release_firmware(firmware);
@@ -62,6 +88,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 	return ret;
 }
 
+static void iris_fw_iommu_unmap(struct iris_core *core)
+{
+	struct iommu_domain *domain;
+
+	if (!core->pas_ctx->use_tzmem)
+		return;
+
+	domain = iommu_get_domain_for_dev(core->fw_dev);
+	if (domain)
+		iommu_unmap(domain, IRIS_FW_START_ADDR, core->pas_ctx->mem_size);
+}
+
 int iris_fw_load(struct iris_core *core)
 {
 	const struct tz_cp_config *cp_config;
@@ -79,10 +117,10 @@ int iris_fw_load(struct iris_core *core)
 		return -ENOMEM;
 	}
 
-	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
+	ret = qcom_scm_pas_prepare_and_auth_reset(core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
-		return ret;
+		goto err_unmap;
 	}
 
 	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
@@ -93,17 +131,31 @@ int iris_fw_load(struct iris_core *core)
 						     cp_config->cp_nonpixel_size);
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
-			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
-			return ret;
+			goto err_pas_shutdown;
 		}
 	}
 
+	return 0;
+
+err_pas_shutdown:
+	qcom_scm_pas_shutdown(core->pas_ctx->pas_id);
+err_unmap:
+	iris_fw_iommu_unmap(core);
+
 	return ret;
 }
 
 int iris_fw_unload(struct iris_core *core)
 {
-	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+	int ret;
+
+	ret = qcom_scm_pas_shutdown(core->pas_ctx->pas_id);
+	if (ret)
+		return ret;
+
+	iris_fw_iommu_unmap(core);
+
+	return ret;
 }
 
 int iris_set_hw_state(struct iris_core *core, bool resume)

-- 
2.34.1

