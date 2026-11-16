Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7F606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JJXXqVQt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C10dNtCj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7984510EA52;
	Mon, 16 Nov 2026 16:23:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2958010F2B9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIbkV154582
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VVUhyr3d7Ss
 o/D9NKbMDpNOE2qLCl3mHXm6sLvlZOYA=; b=JJXXqVQtYeE7I2LIEKqks+Aj4Og
 6mnE8TIi1ILCOq3qM3zVIKPZcwh5rA41aKqTA6PTkfDdudLi89hQdm0W9KNvl/Se
 V7ZsXAWS9TIyjztwC3XSBW02c2hQsa04UDoTLnpOwWu3P8l3aDQGk3y/heMjTuRT
 nNm5k5Zz+jk+oQGwu5nk/eX64P7cDzS9BS1E6TA2RfiRwgwpbu07xlAIgaXOdyxk
 X76qpzY8fUBZL81X9hbki8jvo2HfuhfgWqE/h0hlG+5IywHykWIzfTG5M6T/EOBv
 s8Vl8bPkaZGplcg+mhacoh3bDccKZF7hLzLP6YotlMs9sona+8iakVmMXyg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6ghjhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:55 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b3b5b49cabso3194760c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846174; x=1795450974;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VVUhyr3d7Sso/D9NKbMDpNOE2qLCl3mHXm6sLvlZOYA=;
 b=C10dNtCjipltM2Y3vKRJkLPv9GapLykpWSihvnaWg5dt+B+tOmYN9/9xC0f+LnME4B
 wry7kI/VE91CzoAlZldCMQThV9sTgOaujgjEAdZ3jpdJntj7VEZeSS4oBNy0TQ7kyb2D
 ApKHJfJtv9CVGAvAlLHYc3b3dbrmbJH4bpVf+au9fTbHnagDCP0yZX1QNY3APZyvMksU
 kQdNLc4GEBNTmrXdCbTT8NIWhvH040nWuL2oPwt29g6+3050rRCTljiRKJi7LkgTVDkE
 HprW2E/qhKv6OMWXzYJn6To7bKT4kFpmwxu4cVLI87PWzehZE46T83+cTaW6UR1NjgrH
 4o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846174; x=1795450974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VVUhyr3d7Sso/D9NKbMDpNOE2qLCl3mHXm6sLvlZOYA=;
 b=RSjdgo2MUUslu82/7NFa9fr9aF/FokU+bE6ujQLtrNqhEvm8jz50es7WMwKQ0Mazk3
 C3u7bhtbN8B+d2busd9Y8pZqsWJAYEQfgMKVTtVwcr6Mskc/AsUEE3eUhG0jz9fdzjHn
 Vasxr7ZMxvAPvGX4UjU+OXeUf1tfg2F6t4nu4h8YJxG0TWC3GCA5Uq70Hg3zskz5rl08
 YO7PvVvApB4vtgJMPSQ4GD41DX8QVXlcgy6FB50oRXvsjUlMRmOf3rF+U8SuXwXiU+/5
 fGgi3pOhLHgkmnA6DnhAr+YUvA8GKj5ZOI99VrezBpp5aFDXyPSPO8nVROtrcPlnctnV
 sDbQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHYq6CtnooqsGWHvKZgHdiGHyFQK2UYKoLq+BkU/SufGbZLdd61EieH6ki7dV2AtO2gp1ldsxwPQJ4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8moBBILQ9ARqQZSqvy6iqx4Al4z7FyZM3XfyS2XbyJhnMQQwmz
 NBeF+bySrkNYhF8yItW41nC/bFLtbK8F+7kB7y4QmnoPHfABURnChJkby7/htpwvcQojGE2r7QE
 8K05YC2XWvRHKhGKJDbJWR591zXdR8Soqd7NRb1fKx2E2kcR8pFrgNfK1pMIu39qib1EyTgzd9R
 5BakU=
X-Gm-Gg: AYBFou1AbR4aSbcdVCxGQUHMQG16FRfucYZvGfzJ9N7Oz9nWofSY67d0I95NL1UfF6Q
 7MMZgq4CEbUfrnlptG8wc8uHYM9FEp8BIZYcv9L2bLeCpMh6qODPts+rRxQkm1WJN8ZnT9qtKfV
 fUjGWTo5FMcXETXOtaxjbbp2KX/tF3M6i6THMJwVGWh2wtbTmbJhsYUZtdApOZEn7eDl/VcfHuk
 bUwhH9cGtWCuswdG0LQn2ZBZyGDGT2V1Klk09N6H0rX/f/dnBKPyC1ttAibC9XHHLVca184HpXG
 QWoAijE3u51J1bnqcg1z6musijGjfSbaLaoPTajEFzBFIELBpWjQOL+AuI6p3s+xQLWk2vOtTgA
 i/bLVOYouLNM5R0IeYI74c/QYWanM97VNP+9DBuTDR3xnJffAp1O4CPFmPhM1WRpztAQQiiu0t+
 fw
X-Received: by 2002:a05:7022:3a85:b0:185:fd0c:4585 with SMTP id
 a92af1059eb24-1b50312b3b0mr11214607c88.33.1794846173945; 
 Mon, 16 Nov 2026 08:22:53 -0800 (PST)
X-Received: by 2002:a05:7022:3a85:b0:185:fd0c:4585 with SMTP id
 a92af1059eb24-1b50312b3b0mr11214575c88.33.1794846173198; 
 Mon, 16 Nov 2026 08:22:53 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:22:52 -0800 (PST)
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
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH v3 5/9] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Mon, 16 Nov 2026 21:51:44 +0530
Message-ID: <20261116162148.2864501-6-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX97jFfCr6fTug
 tnwsEIE4bBiC54FJaLGOkgm0M8wk9v0g0x3+JTCJEotdNvSJsYAsmIKKES9/DMkH5stliOkJcKK
 6IRPs+IBipeDAvc9JMHe/LSVxuc/uB79oCkxvkzl3WmkhK++g3pVfRyIYMEKFA7XR/F/STaIkvB
 d31zIOObFQh9K/brx4ySzeUw2Lk97kaB1rnePatlIxDk2NQccLoOlpDJAwgf4uZyIyMC2dPXgUQ
 9cQX05k4VCV/FqFgYq1NjduXFE5Ubaxp6s+JRb+p2UFhmRn8Eumu4NrkYEBQlL0Uv/j5LCvxJfa
 wHYk4UH/vEaRghUA/yLYZFS2bOSwbfWxGvZP3+ALxltS8vVIrEgOCHGY4k0Aym6rtl9yMl7bhoY
 L/L7IJ14etD3tCNOAaoMGu6tLZ/PTSuOgTfeakyi7H2aYVNEz6WUuPzxnv8aw7baosSt7Uk6Zzp
 og9oyGRclX64UjptUCg==
X-Proofpoint-GUID: UHyfDDbZUyGkbNrY4-YH71SCYrhroB5v
X-Proofpoint-ORIG-GUID: UHyfDDbZUyGkbNrY4-YH71SCYrhroB5v
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb2ddf cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VuDNxQijsV4jnZh2Ru4A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX0oo/yjMz6A52
 w7YdoWKvLUFOBGBZTyH5DvpzackZa6krH9ZgdN5++xoqHpRADrHc/IBzEIEQytB26I5XPdw78fT
 pST4NSWm2VXWytbLCfySfCCg6umNdw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160064
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

venus_load_fw() calls qcom_mdt_load(), which bundles metadata
initialization, memory setup, and segment loading into a single API that
does not expose a PAS context. venus_boot() calls qcom_pas_auth_and_reset()
for TrustZone authentication, which is the intended behaviour. However, a
new qcom_mdt_pas_load() has recently been introduced that works with a PAS
context and can handle everything qcom_mdt_load() provides, along with
additional functionality such as shmbridge creation and retrieving memory
from the shmbridge buffer when the same remote processor needs to run while
Linux runs at EL2.

Embed a struct qcom_pas_context in struct video_firmware and initialize
it with qcom_pas_context_init() inside venus_load_fw() on each call.
Replace qcom_mdt_load() with qcom_mdt_pas_load() for the TZ path and
replace qcom_pas_auth_and_reset() with qcom_pas_prepare_and_auth_reset().
The non-TZ path retains its memremap()/qcom_mdt_load_no_init()/memunmap()
sequence since qcom_mdt_load_no_init() requires a caller-supplied mapping.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/core.h     |  2 ++
 drivers/media/platform/qcom/venus/firmware.c | 29 ++++++++++----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 93fa77f05834..84a0d4a8426c 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -228,6 +229,7 @@ struct venus_core {
 		size_t mapped_mem_size;
 		phys_addr_t mem_phys;
 		size_t mem_size;
+		struct qcom_pas_context pas_ctx;
 	} fw;
 	struct mutex lock;
 	struct list_head instances;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 3a38ff985822..704343e241dc 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -117,21 +117,22 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
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
+	if (core->use_tz) {
+		qcom_pas_context_init(&core->fw.pas_ctx, dev, VENUS_PAS_ID,
+				      *mem_phys, *mem_size);
+		ret = qcom_mdt_pas_load(&core->fw.pas_ctx, mdt, fwname, NULL);
+	} else {
+		mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
+		if (!mem_va) {
+			dev_err(dev, "unable to map memory region %pa size %#zx\n",
+				mem_phys, *mem_size);
+			ret = -ENOMEM;
+			goto err_release_fw;
+		}
 		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
 					    *mem_phys, *mem_size, NULL);
-
-	memunmap(mem_va);
+		memunmap(mem_va);
+	}
 err_release_fw:
 	release_firmware(mdt);
 	return ret;
@@ -237,7 +238,7 @@ int venus_boot(struct venus_core *core)
 	core->fw.mem_phys = mem_phys;
 
 	if (core->use_tz)
-		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
+		ret = qcom_pas_prepare_and_auth_reset(&core->fw.pas_ctx);
 	else
 		ret = venus_boot_no_tz(core, mem_phys, mem_size);
 
-- 
2.55.0

