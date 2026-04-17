Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B80F43688
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C99810E9A2;
	Fri, 17 Apr 2026 09:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="AXevyRXB";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9035610E9A2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:42:39 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H402XN4110672; Fri, 17 Apr 2026 10:42:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=t
 eWbYt27UK0lKHeLTFudsB6UkF6HLKwb8Wt3of3Dmps=; b=AXevyRXB6f2e8Apgy
 IHnxSi6BjethuMe2rynQ17h1BbVsII9Vr6e78RBJrSRljvd/vUz7/gKe2zbUrN06
 KBhSCF0yQE0HUReYGpYSNXV1FcgkvxLSuPusAetuBuLW+HH4eA/bbj9Pec96Ifub
 4aCLfBevMRC30rXGNqH277WhXs97wxGZZ0KuXVM546G4GNQU35cjJQ7ufnu3CDdI
 xuisWCwOtnYRkuDPLkbFXUYcZzGqAxzgJe9YYvCAKqNtzVJU5djwyMCHzBzy+kUb
 otj3LVlaEn75DvsTwxmSDQ4LfpioakzXjijwLFjzpVR/+vbF9og9M6vUof1j5qdf
 T3Lvw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4dfcjr52fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 10:42:29 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Apr
 2026 10:42:26 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 17 Apr 2026 15:12:14 +0530
Subject: [PATCH 2/2] drm/imagination: Restrict pvr_fw_trace_init_mask
 module param to read only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260417-ftrace_fix-v1-2-9fefe194592a@imgtec.com>
References: <20260417-ftrace_fix-v1-0-9fefe194592a@imgtec.com>
In-Reply-To: <20260417-ftrace_fix-v1-0-9fefe194592a@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776418940; l=1053;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=4gehzTP3WYAnCEPh4ybTBACpCA+VsCeH2Ez4viuuwSk=;
 b=JY6PbqqcDLFWU4Mprs1htmBua0yRz8GfjWBJxNQ4LldiWtgIn+I/6SFq1fGafsAkekCYPkqDh
 ruy7oQ6zwaqBBPfXbFTIj/M+0qXBNVAxokmt8zKwxqQ3lofGiwQ7GbL
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-ORIG-GUID: pkdz6a27Rfimvh99M6YKixcTSssfTOyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5NiBTYWx0ZWRfXy3PjexYvQ1Gs
 3PFSmM9DrIn/4c4efSGGwSkHPW+xLLksSJpymHfzNRANhLe4GjqIH3j8iD8Z7JXdBwhl+qEuSn0
 uqel/+hJH6Fsc7qTi0T80GI6CKQeIKz9nyI7ykJz7b+HO/GayJdqCtcRc//Jp4Ml4Vgmd9sP5nq
 XfwHW8p33E+Ev+/HBuuJD63nZY6Mm8bpfJc0TA56mTQyqbunPsCifgjxGQ38GyXkKRxqbXuOVIA
 EuUIFGq8jMIpb5/znqY/xm6V0gjfc79y/MRhsZDwqrlgQ9Z+XPb/aUAZcNfJiaI2We73to3jIpc
 HLT7u5jvDT01GMFIbjSatiLMU2UhLLqwXsNxPBeWxyvqgbBhgGDn0TumABMpTViK6YDkVwYjAFK
 2cosau1gklPCpXKuli7K7KviMjtONuWKVtbOZmvbPdqqwge6zHEEmtF/nDOAA/29QgYKi5AJ+bm
 KPr86yH1k0q6AI1tbhw==
X-Proofpoint-GUID: pkdz6a27Rfimvh99M6YKixcTSssfTOyS
X-Authority-Analysis: v=2.4 cv=a4sAM0SF c=1 sm=1 tr=0 ts=69e20085 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=fKFdgPUslCYRdS_w59YA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

