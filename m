Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F9DCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F001610E7B8;
	Wed, 20 May 2026 16:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VR//wI8A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jWz9rnU2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E3110F0D5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCe7kA316969
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ddK7or9wy6b
 4dbI0qP5KfxhLsio0GbpdcAYFvLAgVMQ=; b=VR//wI8ALd3J7ynNlPcIB2KJBBN
 B+FYTrE5ZJLxH/iq1YgXMK0kzCuvXP8UcsaBYhYx9ziorbgl1M2HrcslfTrbAhVh
 yiBtULYh97kqRAIeiErbE4o6TDvrBHEwOfna19P+z7cwq60T0lwL4rtTVy81G366
 ExHPwqISF4FRGQX+dsk5mWzxEpYLZztO8dmQefoBaiY31WATh2S9IHzfZlsWJBgM
 ejiIf5CpCTmG3fSPmDZetSeuG7DmApWHoeE/Ql2diZ1FuXZi7QE6wgNwBXJhG0Cc
 Ol0yriLJWfwJ6/AUf8RWxEauiIoVFlWch1KmBipzNlnhEFDGFB8VsG98/Bw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9d5qrxrx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2be9e0905a9so88615ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294327; x=1779899127;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddK7or9wy6b4dbI0qP5KfxhLsio0GbpdcAYFvLAgVMQ=;
 b=jWz9rnU2E8+/XAsFQfLNbl/KpkNTew/4VoKdrXGpspVIp9XVJGFiITKiSKh1JXs0rx
 8cbNSZaJlOEjP/9v0iqda00DOc0/31Xma3HNvTHOKuqi9UAZRBuOpud5P04UvNOdmwzX
 yTm0nsLZ54rA5BBL046ow0xszP/HELMgcyyzVk2HuF5s16hGp82IEIZYlXI7zpDLWgY0
 10tFzhNH//IQbGhywAeM6EF9/d5r2BF8isc4dbsgjvwcEKUEwYImix0zqQgxev3EfRr0
 kvtQumwj3ECfPD+4V+NCSo7qc8pqT3LKHKmd3aVLNs63h5vkxmFMJPVUYqFcX1zNGWN2
 YvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294327; x=1779899127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ddK7or9wy6b4dbI0qP5KfxhLsio0GbpdcAYFvLAgVMQ=;
 b=sZ7r1/4JBZYVbbxMyJZoHghh6mDrVlA2VT50MDDTx3QeCHL+weI/NnmFlbFPTpOm1h
 /1RhTEUXqbBZul224x/evb+FTk4SvSD3jnEuXs0FVd1lHgwjZlo/1rGbpwinUeu3JeuY
 NgN/w8zjIHWDF+8XpwYqd7Dl/nkBZe3QvVcPt9TkSp8vuJyKiMfuQhldpwtNsVS+vpgG
 v4a9vjEtctnNSHxtD1HUONJU+4eDplTWv5umQ4EH4CERXu+unNmRZhbIGnZrFPKuh36E
 JmwAwBh4PiBQnAasFUejlNvHe2OCxmK97wiVPbhGN3Wotpsk/dMMplfrPKiB/j05eEdN
 UsPw==
X-Gm-Message-State: AOJu0Yxv3oaCBlOs0bilvtaMmb3hlqxq+Qds8aNDcIxtIqOjaYiAq0tS
 lC5bTZk0xBLwxSBbZ5sXy2Hx/y39CghYGh94r0RLfktp+d/tcT30Ko0Zfo5h527hhFhX+Rzq+1c
 jcK0FzO/JnIZ4nNy4eQfakoGWAsAJjpWfu9GDNu+rcTxE7Uf65KyvS+IHnNqBXVcQ0l5s5hoqk7
 50UIM=
X-Gm-Gg: Acq92OG+t5VGl0DNGkGeGLschZjIhBy4czu7EpPG9IlII6MguQGwDdhhjefZTPdmUSF
 xSWIUNOH/zoTqjC3zMjcPF14+DrLcXuGoqZ4ajknwIoToGF9UFQPzs/zkXrEVI7SriiyapZKW5W
 szsj0DdX54g0/71f7vGri5UJ7xa9faihblevG/MQqk2f1SeYVr5Jlx2Y7/ZMMSNDSewTt2jJdhL
 /peYstZJZhu3631HnWD5vJxUkWS4Yd8K8apnILAzhDHJikngfNKcR9MBR2YXq75+McMHlg17K9J
 7yRXIxsGdGGHEpxEOkC6CmDXEdTzxiO5xUV3aGsZVughpVnvyWCDf2rBJeD1qzjwH3KeU2T1YZ9
 x2X7wUO1LTAAjawinUqGwaaojBTGDIxk5
X-Received: by 2002:a17:902:ffd0:b0:2bc:e299:4c9e with SMTP id
 d9443c01a7336-2bd7e8786bcmr259901705ad.18.1779294326692; 
 Wed, 20 May 2026 09:25:26 -0700 (PDT)
X-Received: by 2002:a17:902:ffd0:b0:2bc:e299:4c9e with SMTP id
 d9443c01a7336-2bd7e8786bcmr259901235ad.18.1779294325946; 
 Wed, 20 May 2026 09:25:25 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe4973sm229491975ad.41.2026.05.20.09.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 05/16] drm/msm/registers: Add perfcntr json
Date: Wed, 20 May 2026 09:23:52 -0700
Message-ID: <20260520162454.18391-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX2wCwD5jJZ0AB
 sYUEEiDqCKkAs7qLZ36t4bv+LOYVQ93kJmzyJ39aaAQfh8BdALEZSJuHnylSg14J3zNOTx3WhZ7
 oOYy2OkliWcsAR5kllPGsRLvHbA2nmzDmpkjSKmZ6mp6Rq2Xg1hZglsggNHmjG5DcupMAjtkc8R
 RzFeWokRnW4qLOhZ2adxS9zHo8m7vBvX6T1aernMghQk6aeqRFD5lnu34ZwBt5FyLgWxNFRj/VF
 SR1p3RSzI2KBRs7SkCD052pLLbh2rzHv6nYZMEZbUeyPdAQ4DCh3W9BGewwJT7zIHr2ayGLpREG
 aKvGLsf6ZhYBs+EVccepIyIUZiCtrHQ6LMO7NShqclQhy3r23+QpH54yA6Pd0s64M3WP4BWfIpX
 PdUEvMPgPL3ftqjTMXOwEYq5W5hU1xwFu+kHShkGnvIF4s8L1XywlId4zqUtyRMo4XfjJWA+mWt
 e/tteSBzxmkuuQbC8jQ==
X-Authority-Analysis: v=2.4 cv=QshuG1yd c=1 sm=1 tr=0 ts=6a0de078 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=tPAUhwUxvbDVC6ka7NAA:9 a=ulHW8LRkPv6jbv31:21 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ypV83V6fy2OaKSPusIYuaUXUyatBfBNN
X-Proofpoint-ORIG-GUID: ypV83V6fy2OaKSPusIYuaUXUyatBfBNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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

Pull in perfcntr json and wire up generation of perfcntr tables.

Sync from mesa commit d2c4653ee953 ("freedreno/registers: Add gen8 perfcntrs")

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile                  |  25 +-
 drivers/gpu/drm/msm/msm_perfcntr.h            |  48 ++++
 .../msm/registers/adreno/a2xx_perfcntrs.json  | 109 ++++++++
 .../msm/registers/adreno/a5xx_perfcntrs.json  | 128 ++++++++++
 .../msm/registers/adreno/a6xx_perfcntrs.json  | 112 ++++++++
 .../msm/registers/adreno/a7xx_perfcntrs.json  | 228 +++++++++++++++++
 .../msm/registers/adreno/a8xx_perfcntrs.json  | 240 ++++++++++++++++++
 7 files changed, 889 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index ce00cfb0a875..337634e7e247 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -176,6 +176,11 @@ quiet_cmd_headergen = GENHDR  $@
       cmd_headergen = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
 		      $(headergen-opts) --rnn $(src)/registers --xml $< c-defines > $@
 
+# TODO how to do this for a2xx/a5xx which have different .xml arg?
+quiet_cmd_headergen_json = GENHDRJSN  $@
+      cmd_headergen_json = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
+		      $(headergen-opts) --rnn $(src)/registers --xml $(filter %.xml,$^) perfcntrs --json $< > $@
+
 $(obj)/generated/%.xml.h: $(src)/registers/adreno/%.xml \
 		$(src)/registers/adreno/adreno_common.xml \
 		$(src)/registers/adreno/adreno_pm4.xml \
@@ -192,6 +197,24 @@ $(obj)/generated/%.xml.h: $(src)/registers/display/%.xml \
 		FORCE
 	$(call if_changed,headergen)
 
+ADRENO_PERFCNTRS =
+
+define adreno_perfcntrs
+ADRENO_PERFCNTRS += generated/$(1)_perfcntrs.json.c
+$$(obj)/generated/$(1)_perfcntrs.json.c: $$(src)/registers/adreno/$(1)_perfcntrs.json \
+		$$(src)/registers/adreno/$(2).xml \
+		FORCE
+	$$(call if_changed,headergen_json)
+endef
+
+$(eval $(call adreno_perfcntrs,a2xx,a2xx))
+$(eval $(call adreno_perfcntrs,a5xx,a5xx))
+$(eval $(call adreno_perfcntrs,a6xx,a6xx))
+$(eval $(call adreno_perfcntrs,a7xx,a6xx))
+$(eval $(call adreno_perfcntrs,a8xx,a6xx))
+
+adreno-y += $(ADRENO_PERFCNTRS:.c=.o)
+
 ADRENO_HEADERS = \
 	generated/a2xx.xml.h \
 	generated/a3xx.xml.h \
@@ -226,4 +249,4 @@ DISPLAY_HEADERS = \
 $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
 $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEADERS))
 
-targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
+targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS) $(ADRENO_PERFCNTRS)
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
new file mode 100644
index 000000000000..305dcde15c5e
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __MSM_PERFCNTR_H__
+#define __MSM_PERFCNTR_H__
+
+#include "linux/array_size.h"
+
+#include "adreno_common.xml.h"
+
+/*
+ * This is a subset of the tables used by mesa.  We don't need to
+ * enumerate the countables on the kernel side.
+ */
+
+/* Describes a single counter: */
+struct msm_perfcntr_counter {
+   /* offset of the SELect register to choose what to count: */
+   unsigned select_reg;
+   /* additional SEL regs to enable slice counters (gen8+) */
+   unsigned slice_select_regs[2];
+   /* offset of the lo/hi 32b to read current counter value: */
+   unsigned counter_reg_lo;
+   unsigned counter_reg_hi;
+   /* TODO some counters have enable/clear registers */
+};
+
+/* Describes an entire counter group: */
+struct msm_perfcntr_group {
+   const char *name;
+   enum adreno_pipe pipe;
+   unsigned num_counters;
+   const struct msm_perfcntr_counter *counters;
+};
+
+#define GROUP(_name, _pipe, _counters, _countables) {                          \
+      .name = _name,                                                           \
+      .pipe = _pipe,                                                           \
+      .num_counters = ARRAY_SIZE(_counters),                                   \
+      .counters = _counters,                                                   \
+   }
+
+#define fd_perfcntr_counter msm_perfcntr_counter
+#define fd_perfcntr_group   msm_perfcntr_group
+
+#endif /* __MSM_PERFCNTR_H__ */
diff --git a/drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
new file mode 100644
index 000000000000..8095345ffd8e
--- /dev/null
+++ b/drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
@@ -0,0 +1,109 @@
+{
+    "chip": "A2XX",
+    "groups": [
+        {
+            "name": "CP",
+            "num": 1,
+            "select": "CP_PERFCOUNTER_SELECT",
+            "counter_lo": "CP_PERFCOUNTER_LO",
+            "counter_hi": "CP_PERFCOUNTER_HI",
+            "countable_type": "a2xx_cp_perfcount_sel"
+        },
+        {
+            "name": "PA_SU",
+            "num": 4,
+            "select": "PA_SU_PERFCOUNTER{}_SELECT",
+            "counter_lo": "PA_SU_PERFCOUNTER{}_LOW",
+            "counter_hi": "PA_SU_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_su_perfcnt_select"
+        },
+        {
+            "name": "PA_SC",
+            "num": 1,
+            "select": "PA_SC_PERFCOUNTER{}_SELECT",
+            "counter_lo": "PA_SC_PERFCOUNTER{}_LOW",
+            "counter_hi": "PA_SC_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_sc_perfcnt_select"
+        },
+        {
+            "name": "VGT",
+            "num": 4,
+            "select": "VGT_PERFCOUNTER{}_SELECT",
+            "counter_lo": "VGT_PERFCOUNTER{}_LOW",
+            "counter_hi": "VGT_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_vgt_perfcount_select"
+        },
+        {
+            "name": "TCR",
+            "num": 2,
+            "select": "TCR_PERFCOUNTER{}_SELECT",
+            "counter_lo": "TCR_PERFCOUNTER{}_LOW",
+            "counter_hi": "TCR_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_tcr_perfcount_select"
+        },
+        {
+            "name": "TP0",
+            "num": 2,
+            "select": "TP0_PERFCOUNTER{}_SELECT",
+            "counter_lo": "TP0_PERFCOUNTER{}_LOW",
+            "counter_hi": "TP0_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_tp_perfcount_select"
+        },
+        {
+            "name": "TCM",
+            "num": 2,
+            "select": "TCM_PERFCOUNTER{}_SELECT",
+            "counter_lo": "TCM_PERFCOUNTER{}_LOW",
+            "counter_hi": "TCM_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_tcm_perfcount_select"
+        },
+        {
+            "name": "TCF",
+            "num": 12,
+            "select": "TCF_PERFCOUNTER{}_SELECT",
+            "counter_lo": "TCF_PERFCOUNTER{}_LOW",
+            "counter_hi": "TCF_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_tcf_perfcount_select"
+        },
+        {
+            "name": "SQ",
+            "num": 4,
+            "select": "SQ_PERFCOUNTER{}_SELECT",
+            "counter_lo": "SQ_PERFCOUNTER{}_LOW",
+            "counter_hi": "SQ_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_sq_perfcnt_select"
+        },
+        {
+            "name": "SX",
+            "num": 1,
+            "select": "SX_PERFCOUNTER{}_SELECT",
+            "counter_lo": "SX_PERFCOUNTER{}_LOW",
+            "counter_hi": "SX_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_sx_perfcnt_select"
+        },
+        {
+            "name": "MH",
+            "num": 2,
+            "select": "MH_PERFCOUNTER{}_SELECT",
+            "counter_lo": "MH_PERFCOUNTER{}_LOW",
+            "counter_hi": "MH_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_mh_perfcnt_select"
+        },
+        {
+            "name": "RBBM",
+            "num": 2,
+            "select": "RBBM_PERFCOUNTER{}_SELECT",
+            "counter_lo": "RBBM_PERFCOUNTER{}_LO",
+            "counter_hi": "RBBM_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_rbbm_perfcount1_sel"
+        },
+        {
+            "name": "RB",
+            "num": 4,
+            "select": "RB_PERFCOUNTER{}_SELECT",
+            "counter_lo": "RB_PERFCOUNTER{}_LOW",
+            "counter_hi": "RB_PERFCOUNTER{}_HI",
+            "countable_type": "a2xx_rb_perfcnt_select"
+        }
+    ]
+}
diff --git a/drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
new file mode 100644
index 000000000000..d95503543f94
--- /dev/null
+++ b/drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
@@ -0,0 +1,128 @@
+{
+    "chip": "A5XX",
+    "groups": [
+        {
+            "name": "CP",
+            "num": 8,
+            "reserved": [ 0 ],
+            "select": "CP_PERFCTR_CP_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_CP_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_CP_{}_HI",
+            "countable_type": "a5xx_cp_perfcounter_select"
+        },
+        {
+            "name": "CCU",
+            "num": 4,
+            "select": "RB_PERFCTR_CCU_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_CCU_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_CCU_{}_HI",
+            "countable_type": "a5xx_ccu_perfcounter_select"
+        },
+        {
+            "name": "TSE",
+            "num": 4,
+            "select": "GRAS_PERFCTR_TSE_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_TSE_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_TSE_{}_HI",
+            "countable_type": "a5xx_tse_perfcounter_select"
+        },
+        {
+            "name": "RAS",
+            "num": 4,
+            "select": "GRAS_PERFCTR_RAS_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_RAS_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_RAS_{}_HI",
+            "countable_type": "a5xx_ras_perfcounter_select"
+        },
+        {
+            "name": "LRZ",
+            "num": 4,
+            "select": "GRAS_PERFCTR_LRZ_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_LRZ_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_LRZ_{}_HI",
+            "countable_type": "a5xx_lrz_perfcounter_select"
+        },
+        {
+            "name": "HLSQ",
+            "num": 8,
+            "select": "HLSQ_PERFCTR_HLSQ_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_HLSQ_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_HLSQ_{}_HI",
+            "countable_type": "a5xx_hlsq_perfcounter_select"
+        },
+        {
+            "name": "PC",
+            "num": 8,
+            "select": "PC_PERFCTR_PC_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_PC_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_PC_{}_HI",
+            "countable_type": "a5xx_pc_perfcounter_select"
+        },
+        {
+            "name": "RB",
+            "num": 8,
+            "select": "RB_PERFCTR_RB_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_RB_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_RB_{}_HI",
+            "countable_type": "a5xx_rb_perfcounter_select"
+        },
+        {
+            "name": "RBBM",
+            "num": 4,
+            "reserved": [ 0 ],
+            "select": "RBBM_PERFCTR_RBBM_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_RBBM_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_RBBM_{}_HI",
+            "countable_type": "a5xx_rbbm_perfcounter_select"
+        },
+        {
+            "name": "SP",
+            "num": 12,
+            "reserved": [ 0 ],
+            "select": "SP_PERFCTR_SP_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_SP_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_SP_{}_HI",
+            "countable_type": "a5xx_sp_perfcounter_select"
+        },
+        {
+            "name": "TP",
+            "num": 8,
+            "select": "TPL1_PERFCTR_TP_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_TP_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_TP_{}_HI",
+            "countable_type": "a5xx_tp_perfcounter_select"
+        },
+        {
+            "name": "UCHE",
+            "num": 8,
+            "select": "UCHE_PERFCTR_UCHE_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_UCHE_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_UCHE_{}_HI",
+            "countable_type": "a5xx_uche_perfcounter_select"
+        },
+        {
+            "name": "VFD",
+            "num": 8,
+            "select": "VFD_PERFCTR_VFD_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_VFD_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_VFD_{}_HI",
+            "countable_type": "a5xx_vfd_perfcounter_select"
+        },
+        {
+            "name": "VPC",
+            "num": 4,
+            "select": "VPC_PERFCTR_VPC_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_VPC_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_VPC_{}_HI",
+            "countable_type": "a5xx_vpc_perfcounter_select"
+        },
+        {
+            "name": "VSC",
+            "num": 2,
+            "select": "VSC_PERFCTR_VSC_SEL_{}",
+            "counter_lo": "RBBM_PERFCTR_VSC_{}_LO",
+            "counter_hi": "RBBM_PERFCTR_VSC_{}_HI",
+            "countable_type": "a5xx_vsc_perfcounter_select"
+        }
+    ]
+}
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
new file mode 100644
index 000000000000..ec303e0b9f28
--- /dev/null
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
@@ -0,0 +1,112 @@
+{
+    "chip": "A6XX",
+    "groups": [
+        {
+            "name": "CP",
+            "num": 14,
+            "reserved": [ 0 ],
+            "select": "CP_PERFCTR_CP_SEL",
+            "counter": "RBBM_PERFCTR_CP",
+            "countable_type": "a6xx_cp_perfcounter_select"
+        },
+        {
+            "name": "CCU",
+            "num": 5,
+            "select": "RB_PERFCTR_CCU_SEL",
+            "counter": "RBBM_PERFCTR_CCU",
+            "countable_type": "a6xx_ccu_perfcounter_select"
+        },
+        {
+            "name": "TSE",
+            "num": 4,
+            "select": "GRAS_PERFCTR_TSE_SEL",
+            "counter": "RBBM_PERFCTR_TSE",
+            "countable_type": "a6xx_tse_perfcounter_select"
+        },
+        {
+            "name": "RAS",
+            "num": 4,
+            "select": "GRAS_PERFCTR_RAS_SEL",
+            "counter": "RBBM_PERFCTR_RAS",
+            "countable_type": "a6xx_ras_perfcounter_select"
+        },
+        {
+            "name": "LRZ",
+            "num": 4,
+            "select": "GRAS_PERFCTR_LRZ_SEL",
+            "counter": "RBBM_PERFCTR_LRZ",
+            "countable_type": "a6xx_lrz_perfcounter_select"
+        },
+        {
+            "name": "CMP",
+            "num": 4,
+            "select": "RB_PERFCTR_CMP_SEL",
+            "counter": "RBBM_PERFCTR_CMP",
+            "countable_type": "a6xx_cmp_perfcounter_select"
+        },
+        {
+            "name": "HLSQ",
+            "num": 6,
+            "select": "HLSQ_PERFCTR_HLSQ_SEL",
+            "counter": "RBBM_PERFCTR_HLSQ",
+            "countable_type": "a6xx_hlsq_perfcounter_select"
+        },
+        {
+            "name": "PC",
+            "num": 8,
+            "select": "PC_PERFCTR_PC_SEL",
+            "counter": "RBBM_PERFCTR_PC",
+            "countable_type": "a6xx_pc_perfcounter_select"
+        },
+        {
+            "name": "RB",
+            "num": 8,
+            "select": "RB_PERFCTR_RB_SEL",
+            "counter": "RBBM_PERFCTR_RB",
+            "countable_type": "a6xx_rb_perfcounter_select"
+        },
+        {
+            "name": "SP",
+            "num": 24,
+            "reserved": [ 0 ],
+            "select": "SP_PERFCTR_SP_SEL",
+            "counter": "RBBM_PERFCTR_SP",
+            "countable_type": "a6xx_sp_perfcounter_select"
+        },
+        {
+            "name": "TP",
+            "num": 12,
+            "select": "TPL1_PERFCTR_TP_SEL",
+            "counter": "RBBM_PERFCTR_TP",
+            "countable_type": "a6xx_tp_perfcounter_select"
+        },
+        {
+            "name": "UCHE",
+            "num": 12,
+            "select": "UCHE_PERFCTR_UCHE_SEL",
+            "counter": "RBBM_PERFCTR_UCHE",
+            "countable_type": "a6xx_uche_perfcounter_select"
+        },
+        {
+            "name": "VFD",
+            "num": 8,
+            "select": "VFD_PERFCTR_VFD_SEL",
+            "counter": "RBBM_PERFCTR_VFD",
+            "countable_type": "a6xx_vfd_perfcounter_select"
+        },
+        {
+            "name": "VPC",
+            "num": 6,
+            "select": "VPC_PERFCTR_VPC_SEL",
+            "counter": "RBBM_PERFCTR_VPC",
+            "countable_type": "a6xx_vpc_perfcounter_select"
+        },
+        {
+            "name": "VSC",
+            "num": 2,
+            "select": "VSC_PERFCTR_VSC_SEL",
+            "counter": "RBBM_PERFCTR_VSC",
+            "countable_type": "a6xx_vsc_perfcounter_select"
+        }
+    ]
+}
diff --git a/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
new file mode 100644
index 000000000000..e60aab1862ec
--- /dev/null
+++ b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
@@ -0,0 +1,228 @@
+{
+    "chip": "A7XX",
+    "groups": [
+        {
+            "name": "CP",
+            "num": 14,
+            "reserved": [ 0 ],
+            "select": "CP_PERFCTR_CP_SEL",
+            "counter": "RBBM_PERFCTR_CP",
+            "countable_type": "a7xx_cp_perfcounter_select"
+        },
+        {
+            "name": "RBBM",
+            "num": 4,
+            "select": "RBBM_PERFCTR_RBBM_SEL",
+            "counter": "RBBM_PERFCTR_RBBM",
+            "countable_type": "a7xx_rbbm_perfcounter_select"
+        },
+        {
+            "name": "PC",
+            "pipe": "BR",
+            "num": 8,
+            "select": "PC_PERFCTR_PC_SEL",
+            "counter": "RBBM_PERFCTR_PC",
+            "countable_type": "a7xx_pc_perfcounter_select"
+        },
+        {
+            "name": "VFD",
+            "pipe": "BR",
+            "num": 8,
+            "select": "VFD_PERFCTR_VFD_SEL",
+            "counter": "RBBM_PERFCTR_VFD",
+            "countable_type": "a7xx_vfd_perfcounter_select"
+        },
+        {
+            "name": "HLSQ",
+            "pipe": "BR",
+            "num": 6,
+            "select": "SP_PERFCTR_HLSQ_SEL",
+            "counter": "RBBM_PERFCTR_HLSQ",
+            "countable_type": "a7xx_hlsq_perfcounter_select"
+        },
+        {
+            "name": "VPC",
+            "pipe": "BR",
+            "num": 6,
+            "select": "VPC_PERFCTR_VPC_SEL",
+            "counter": "RBBM_PERFCTR_VPC",
+            "countable_type": "a7xx_vpc_perfcounter_select"
+        },
+        {
+            "name": "TSE",
+            "pipe": "BR",
+            "num": 4,
+            "select": "GRAS_PERFCTR_TSE_SEL",
+            "counter": "RBBM_PERFCTR_TSE",
+            "countable_type": "a7xx_tse_perfcounter_select"
+        },
+        {
+            "name": "RAS",
+            "pipe": "BR",
+            "num": 4,
+            "select": "GRAS_PERFCTR_RAS_SEL",
+            "counter": "RBBM_PERFCTR_RAS",
+            "countable_type": "a7xx_ras_perfcounter_select"
+        },
+        {
+            "name": "UCHE",
+            "num": 12,
+            "select": "UCHE_PERFCTR_UCHE_SEL",
+            "counter": "RBBM_PERFCTR_UCHE",
+            "countable_type": "a7xx_uche_perfcounter_select"
+        },
+        {
+            "name": "TP",
+            "pipe": "BR",
+            "num": 12,
+            "select": "TPL1_PERFCTR_TP_SEL",
+            "counter": "RBBM_PERFCTR_TP",
+            "countable_type": "a7xx_tp_perfcounter_select"
+        },
+        {
+            "name": "SP",
+            "pipe": "BR",
+            "num": 24,
+            "select": "SP_PERFCTR_SP_SEL",
+            "counter": "RBBM_PERFCTR_SP",
+            "countable_type": "a7xx_sp_perfcounter_select"
+        },
+        {
+            "name": "RB",
+            "num": 8,
+            "select": "RB_PERFCTR_RB_SEL",
+            "counter": "RBBM_PERFCTR_RB",
+            "countable_type": "a7xx_rb_perfcounter_select"
+        },
+        {
+            "name": "VSC",
+            "num": 2,
+            "select": "VSC_PERFCTR_VSC_SEL",
+            "counter": "RBBM_PERFCTR_VSC",
+            "countable_type": "a7xx_vsc_perfcounter_select"
+        },
+        {
+            "name": "CCU",
+            "num": 5,
+            "select": "RB_PERFCTR_CCU_SEL",
+            "counter": "RBBM_PERFCTR_CCU",
+            "countable_type": "a7xx_ccu_perfcounter_select"
+        },
+        {
+            "name": "LRZ",
+            "pipe": "BR",
+            "num": 4,
+            "select": "GRAS_PERFCTR_LRZ_SEL",
+            "counter": "RBBM_PERFCTR_LRZ",
+            "countable_type": "a7xx_lrz_perfcounter_select"
+        },
+        {
+            "name": "CMP",
+            "num": 4,
+            "select": "RB_PERFCTR_CMP_SEL",
+            "counter": "RBBM_PERFCTR_CMP",
+            "countable_type": "a7xx_cmp_perfcounter_select"
+        },
+        {
+            "name": "UFC",
+            "pipe": "BR",
+            "num": 4,
+            "select": "RB_PERFCTR_UFC_SEL",
+            "counter": "RBBM_PERFCTR_UFC",
+            "countable_type": "a7xx_ufc_perfcounter_select"
+        },
+        {
+            "name": "BV_CP",
+            "num": 7,
+            "select": "CP_BV_PERFCTR_CP_SEL",
+            "counter": "RBBM_PERFCTR2_CP",
+            "countable_type": "a7xx_cp_perfcounter_select"
+        },
+        {
+            "name": "BV_PC",
+            "pipe": "BV",
+            "num": 8,
+            "select_offset": 8,
+            "select": "PC_PERFCTR_PC_SEL",
+            "counter": "RBBM_PERFCTR_BV_PC",
+            "countable_type": "a7xx_pc_perfcounter_select"
+        },
+        {
+            "name": "BV_VFD",
+            "pipe": "BV",
+            "num": 8,
+            "select_offset": 8,
+            "select": "VFD_PERFCTR_VFD_SEL",
+            "counter": "RBBM_PERFCTR_BV_VFD",
+            "countable_type": "a7xx_vfd_perfcounter_select"
+        },
+        {
+            "name": "BV_VPC",
+            "pipe": "BV",
+            "num": 6,
+            "select_offset": 6,
+            "select": "VPC_PERFCTR_VPC_SEL",
+            "counter": "RBBM_PERFCTR_BV_VPC",
+            "countable_type": "a7xx_vpc_perfcounter_select"
+        },
+        {
+            "name": "BV_TP",
+            "pipe": "BV",
+            "num": 6,
+            "select_offset": 12,
+            "select": "TPL1_PERFCTR_TP_SEL",
+            "counter": "RBBM_PERFCTR2_TP",
+            "countable_type": "a7xx_tp_perfcounter_select"
+        },
+        {
+            "name": "BV_SP",
+            "pipe": "BV",
+            "num": 12,
+            "select_offset": 24,
+            "select": "SP_PERFCTR_SP_SEL",
+            "counter": "RBBM_PERFCTR2_SP",
+            "countable_type": "a7xx_sp_perfcounter_select"
+        },
+        {
+            "name": "BV_UFC",
+            "pipe": "BV",
+            "num": 2,
+            "select_offset": 4,
+            "select": "RB_PERFCTR_UFC_SEL",
+            "counter": "RBBM_PERFCTR2_UFC",
+            "countable_type": "a7xx_ufc_perfcounter_select"
+        },
+        {
+            "name": "BV_TSE",
+            "pipe": "BV",
+            "num": 4,
+            "select": "GRAS_PERFCTR_TSE_SEL",
+            "counter": "RBBM_PERFCTR_BV_TSE",
+            "countable_type": "a7xx_tse_perfcounter_select"
+        },
+        {
+            "name": "BV_RAS",
+            "pipe": "BV",
+            "num": 4,
+            "select": "GRAS_PERFCTR_RAS_SEL",
+            "counter": "RBBM_PERFCTR_BV_RAS",
+            "countable_type": "a7xx_ras_perfcounter_select"
+        },
+        {
+            "name": "BV_LRZ",
+            "pipe": "BV",
+            "num": 4,
+            "select": "GRAS_PERFCTR_LRZ_SEL",
+            "counter": "RBBM_PERFCTR_BV_LRZ",
+            "countable_type": "a7xx_lrz_perfcounter_select"
+        },
+        {
+            "name": "BV_HLSQ",
+            "pipe": "BV",
+            "num": 6,
+            "select": "SP_PERFCTR_HLSQ_SEL",
+            "counter": "RBBM_PERFCTR2_HLSQ",
+            "countable_type": "a7xx_hlsq_perfcounter_select"
+        }
+    ]
+}
diff --git a/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
new file mode 100644
index 000000000000..fe4d01f10ff8
--- /dev/null
+++ b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
@@ -0,0 +1,240 @@
+{
+    "chip": "A8XX",
+    "groups": [
+        {
+            "name": "CP",
+            "num": 14,
+            "reserved": [ 0 ],
+            "select": "CP_PERFCTR_CP_SEL",
+            "counter": "RBBM_PERFCTR_CP",
+            "countable_type": "a8xx_cp_perfcounter_select"
+        },
+        {
+            "name": "RBBM",
+            "num": 4,
+            "select": "RBBM_PERFCTR_RBBM_SEL",
+            "slice_select": [ "RBBM_SLICE_PERFCTR_RBBM_SEL" ],
+            "counter": "RBBM_PERFCTR_RBBM",
+            "countable_type": "a8xx_rbbm_perfcounter_select"
+        },
+        {
+            "name": "PC",
+            "pipe": "BR",
+            "num": 8,
+            "select": "PC_PERFCTR_PC_SEL",
+            "slice_select": [ "PC_SLICE_PERFCTR_PC_SEL" ],
+            "counter": "RBBM_PERFCTR_PC",
+            "countable_type": "a8xx_pc_perfcounter_select"
+        },
+        {
+            "name": "VFD",
+            "pipe": "BR",
+            "num": 8,
+            "select": "VFD_PERFCTR_VFD_SEL",
+            "counter": "RBBM_PERFCTR_VFD",
+            "countable_type": "a8xx_vfd_perfcounter_select"
+        },
+        {
+            "name": "HLSQ",
+            "pipe": "BR",
+            "num": 6,
+            "select": "SP_PERFCTR_HLSQ_SEL",
+            "slice_select": [ "SP_PERFCTR_HLSQ_SEL_2" ],
+            "counter": "RBBM_PERFCTR_HLSQ",
+            "countable_type": "a8xx_hlsq_perfcounter_select"
+        },
+        {
+            "name": "VPC",
+            "pipe": "BR",
+            "num": 6,
+            "select": "VPC_PERFCTR_VPC_SEL",
+            "slice_select": [ "VPC_PERFCTR_VPC_SEL_1", "VPC_PERFCTR_VPC_SEL_2" ],
+            "counter": "RBBM_PERFCTR_VPC",
+            "countable_type": "a8xx_vpc_perfcounter_select"
+        },
+        {
+            "name": "TSE",
+            "pipe": "BR",
+            "num": 4,
+            "select": "GRAS_PERFCTR_TSE_SEL",
+            "slice_select": [ "GRAS_PERFCTR_TSEFE_SEL" ],
+            "counter": "RBBM_PERFCTR_TSE",
+            "countable_type": "a8xx_tse_perfcounter_select"
+        },
+        {
+            "name": "RAS",
+            "pipe": "BR",
+            "num": 4,
+            "select": "GRAS_PERFCTR_RAS_SEL",
+            "counter": "RBBM_PERFCTR_RAS",
+            "countable_type": "a8xx_ras_perfcounter_select"
+        },
+        {
+            "name": "UCHE",
+            "num": 24,
+            "select": "UCHE_PERFCTR_UCHE_SEL",
+            "counter": "RBBM_PERFCTR_UCHE",
+            "countable_type": "a8xx_uche_perfcounter_select"
+        },
+        {
+            "name": "TP",
+            "pipe": "BR",
+            "num": 12,
+            "select": "TPL1_PERFCTR_TP_SEL",
+            "counter": "RBBM_PERFCTR_TP",
+            "countable_type": "a8xx_tp_perfcounter_select"
+        },
+        {
+            "name": "SP",
+            "pipe": "BR",
+            "num": 24,
+            "select": "SP_PERFCTR_SP_SEL",
+            "counter": "RBBM_PERFCTR_SP",
+            "countable_type": "a8xx_sp_perfcounter_select"
+        },
+        {
+            "name": "RB",
+            "pipe": "BR",
+            "num": 8,
+            "select": "RB_PERFCTR_RB_SEL",
+            "counter": "RBBM_PERFCTR_RB",
+            "countable_type": "a8xx_rb_perfcounter_select"
+        },
+        {
+            "name": "VSC",
+            "num": 2,
+            "select": "VSC_PERFCTR_VSC_SEL",
+            "counter": "RBBM_PERFCTR_VSC",
+            "countable_type": "a8xx_vsc_perfcounter_select"
+        },
+        {
+            "name": "CCU",
+            "pipe": "BR",
+            "num": 5,
+            "select": "RB_PERFCTR_CCU_SEL",
+            "counter": "RBBM_PERFCTR_CCU",
+            "countable_type": "a8xx_ccu_perfcounter_select"
+        },
+        {
+            "name": "LRZ",
+            "pipe": "BR",
+            "num": 4,
+            "select": "GRAS_PERFCTR_LRZ_SEL",
+            "counter": "RBBM_PERFCTR_LRZ",
+            "countable_type": "a8xx_lrz_perfcounter_select"
+        },
+        {
+            "name": "CMP",
+            "num": 4,
+            "select": "RB_PERFCTR_CMP_SEL",
+            "counter": "RBBM_PERFCTR_CMP",
+            "countable_type": "a8xx_cmp_perfcounter_select"
+        },
+        {
+            "name": "UFC",
+            "pipe": "BR",
+            "num": 4,
+            "select": "RB_PERFCTR_UFC_SEL",
+            "counter": "RBBM_PERFCTR_UFC",
+            "countable_type": "a8xx_ufc_perfcounter_select"
+        },
+        {
+            "name": "BV_CP",
+            "num": 7,
+            "select_offset": 14,
+            "select": "CP_PERFCTR_CP_SEL",
+            "counter": "RBBM_PERFCTR2_CP",
+            "countable_type": "a8xx_cp_perfcounter_select"
+        },
+        {
+            "name": "BV_PC",
+            "pipe": "BV",
+            "num": 8,
+            "select_offset": 8,
+            "select": "PC_PERFCTR_PC_SEL",
+            "slice_select": [ "PC_SLICE_PERFCTR_PC_SEL" ],
+            "counter": "RBBM_PERFCTR_BV_PC",
+            "countable_type": "a8xx_pc_perfcounter_select"
+        },
+        {
+            "name": "BV_VFD",
+            "pipe": "BV",
+            "num": 8,
+            "select_offset": 8,
+            "select": "VFD_PERFCTR_VFD_SEL",
+            "counter": "RBBM_PERFCTR_BV_VFD",
+            "countable_type": "a8xx_vfd_perfcounter_select"
+        },
+        {
+            "name": "BV_VPC",
+            "pipe": "BV",
+            "num": 6,
+            "select_offset": 6,
+            "select": "VPC_PERFCTR_VPC_SEL",
+            "slice_select": [ "VPC_PERFCTR_VPC_SEL_1", "VPC_PERFCTR_VPC_SEL_2" ],
+            "counter": "RBBM_PERFCTR_BV_VPC",
+            "countable_type": "a8xx_vpc_perfcounter_select"
+        },
+        {
+            "name": "BV_TP",
+            "pipe": "BV",
+            "num": 8,
+            "select_offset": 12,
+            "select": "TPL1_PERFCTR_TP_SEL",
+            "counter": "RBBM_PERFCTR2_TP",
+            "countable_type": "a8xx_tp_perfcounter_select"
+        },
+        {
+            "name": "BV_SP",
+            "pipe": "BV",
+            "num": 12,
+            "select_offset": 24,
+            "select": "SP_PERFCTR_SP_SEL",
+            "counter": "RBBM_PERFCTR2_SP",
+            "countable_type": "a8xx_sp_perfcounter_select"
+        },
+        {
+            "name": "BV_UFC",
+            "pipe": "BV",
+            "num": 2,
+            "select_offset": 4,
+            "select": "RB_PERFCTR_UFC_SEL",
+            "counter": "RBBM_PERFCTR2_UFC",
+            "countable_type": "a8xx_ufc_perfcounter_select"
+        },
+        {
+            "name": "BV_TSE",
+            "pipe": "BV",
+            "num": 4,
+            "select": "GRAS_PERFCTR_TSE_SEL",
+            "slice_select": [ "GRAS_PERFCTR_TSEFE_SEL" ],
+            "counter": "RBBM_PERFCTR_BV_TSE",
+            "countable_type": "a8xx_tse_perfcounter_select"
+        },
+        {
+            "name": "BV_RAS",
+            "pipe": "BV",
+            "num": 4,
+            "select": "GRAS_PERFCTR_RAS_SEL",
+            "counter": "RBBM_PERFCTR_BV_RAS",
+            "countable_type": "a8xx_ras_perfcounter_select"
+        },
+        {
+            "name": "BV_LRZ",
+            "pipe": "BV",
+            "num": 4,
+            "select": "GRAS_PERFCTR_LRZ_SEL",
+            "counter": "RBBM_PERFCTR_BV_LRZ",
+            "countable_type": "a8xx_lrz_perfcounter_select"
+        },
+        {
+            "name": "BV_HLSQ",
+            "pipe": "BV",
+            "num": 6,
+            "select": "SP_PERFCTR_HLSQ_SEL",
+            "slice_select": [ "SP_PERFCTR_HLSQ_SEL_2" ],
+            "counter": "RBBM_PERFCTR2_HLSQ",
+            "countable_type": "a8xx_hlsq_perfcounter_select"
+        }
+    ]
+}
-- 
2.54.0

