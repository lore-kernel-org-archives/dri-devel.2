Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E33CFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 05:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D5B10E1E5;
	Mon, 27 Apr 2026 05:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="KIi1A8wP";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7999A10E106
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 05:32:33 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R5OscS2553704; Mon, 27 Apr 2026 06:32:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=t
 eWbYt27UK0lKHeLTFudsB6UkF6HLKwb8Wt3of3Dmps=; b=KIi1A8wP/UAhEVzqa
 clVt55gGDrQ2/V0j5yWbw4QGu6x6FFqex1lG3JKyhq068FfDeFf5n7JwZdbKeE4h
 lmGYuKp4eGNr4bqhTm4c4V2L0r6wTOqw31V7EQWJ5/jl62UG9Q6v8wqCMTpsGyvb
 2gBICo7/YSCzVQywHE5Gkr/A/TZD1xJFp7LX2ha0W1sEQBIbQvbNXqnLh6OrhJYQ
 5sm20v2HwyIae/06+Rmxto2xnIbDvUa3S+TRY5MQmUwvwpW2WxmlNe8zbPykUVvv
 AO+iqUQRWAhql7cheSbTt1oi2mA7EBOSXGBKL7vT+aCWJ5zZRvaom3/ZEPHVAW1m
 MsYLA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drnpxhdj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 06:32:17 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Apr
 2026 06:32:15 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Mon, 27 Apr 2026 11:01:38 +0530
Subject: [PATCH v3 2/2] drm/imagination: Restrict init_fw_trace_mask module
 param to read only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-ftrace_fix-v3-2-e081530759a8@imgtec.com>
References: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
In-Reply-To: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777267929; l=1053;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=4gehzTP3WYAnCEPh4ybTBACpCA+VsCeH2Ez4viuuwSk=;
 b=EO6A4Wh6YHkMp10pC/0XoICFSBDwRA4jPIHBj/98qItXiQCtsQlCi7rv3+0fTQJTc51eKRnAa
 yBf+z1ir8ltDFpOALRKx12Fr6Xa7ULsE0XoRa/u5lUX0TzbewQZezpw
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA1NiBTYWx0ZWRfX5CRP/Jt7/sWX
 JbTap8Zmh8Bfh+7EhrpUWJIrJa0+bWlliB6k06vzKyf+1R4PiiBMt78L5ZuPbuD93hW05Xmm8cs
 aGBFl5Q4mcufEtQiXOJnjPLHEhmqDAbmc164/f5Ale2vr+YkRD0CJgyPq8NFeLLVO9B/evSG4pX
 +gzUPlkW+7aWSXDzatOd9VynROzAJzo80bO/b6aB0dt5TIq2ioWfqkl3pMYnr34fzj94bfaxDs5
 m5skZHGcGyI71vj2OUYOrr4dKUq9nUqftjFZHLOA75hLaGcEeCVj1uijqi5ZAynJPgGqoVO6cWh
 q8r5YstE9POEdFX1aynsYI97HLRiGD4v+cQ6rmBVSiEadDXH5vSeBFeQA3ZCa7lNjeWa/WITShg
 tY3zNRc6+ej6atML8XXYQ/29UQhsSp2KWbKXa0AVAcx5aCzccsMYrRwvGxKAd9EEx07YKHW3zqB
 +v9K01t34ohOWt3LT6Q==
X-Authority-Analysis: v=2.4 cv=G9gs1dk5 c=1 sm=1 tr=0 ts=69eef4e1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=fKFdgPUslCYRdS_w59YA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: szj2BU4r8uyBj253sKlmu3rWJFmPHrma
X-Proofpoint-ORIG-GUID: szj2BU4r8uyBj253sKlmu3rWJFmPHrma
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

Param used for setting FW trace mask at module load time. Other debugfs
entry exist to allow update at run time.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 6193811ef7be..6bb5baa6c41b 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -77,7 +77,7 @@ const struct kernel_param_ops pvr_fw_trace_init_mask_ops = {
 };
 
 param_check_hexint(init_fw_trace_mask, &pvr_fw_trace_init_mask);
-module_param_cb(init_fw_trace_mask, &pvr_fw_trace_init_mask_ops, &pvr_fw_trace_init_mask, 0600);
+module_param_cb(init_fw_trace_mask, &pvr_fw_trace_init_mask_ops, &pvr_fw_trace_init_mask, 0400);
 __MODULE_PARM_TYPE(init_fw_trace_mask, "hexint");
 MODULE_PARM_DESC(init_fw_trace_mask,
 		 "Enable FW trace for the specified groups at device init time");

-- 
2.43.0

