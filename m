Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934C2FED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088E710F65E;
	Fri, 24 Apr 2026 17:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="O7lhlJnn";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A351410F65E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 17:28:10 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OHRoui424436; Fri, 24 Apr 2026 18:27:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=t
 eWbYt27UK0lKHeLTFudsB6UkF6HLKwb8Wt3of3Dmps=; b=O7lhlJnnDW0/vLES8
 y5FWrzH3X9m7GcANXpcWOlSlohJ9WZUdteyFOqpgeFAPUCv9Fz03sOuWTgD92Wqa
 r9Azgbhq7Fxb+JCaFsd7g21IvjOqRLBoFentsBHM5DSJ+bpEhjPSHjg9Qqxaafut
 RZWClSDIUlYHdgEnnw1pzReo+/9MEh6ALmxu1zT4gk0dQvt4IJ2d6IDpJLF0wa74
 x8g0hwTEH8hLN6QTFi8ETGyKi0uoHUMAa0wQ/WRSFM580hjZukhGW+QgxoGmAPFd
 cP8zZsSpeHUbCa6YdKs4Ocq9h4SLUoGD5BR42TmUVd/PqtD0WCnupprs0stxfC+K
 PBmCg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drbq401rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 18:27:52 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.248) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Apr
 2026 18:27:50 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 24 Apr 2026 22:57:34 +0530
Subject: [PATCH v2 2/2] drm/imagination: Restrict pvr_fw_trace_mask module
 param to read only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260424-ftrace_fix-v2-2-50146ff526d5@imgtec.com>
References: <20260424-ftrace_fix-v2-0-50146ff526d5@imgtec.com>
In-Reply-To: <20260424-ftrace_fix-v2-0-50146ff526d5@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777051664; l=1053;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=4gehzTP3WYAnCEPh4ybTBACpCA+VsCeH2Ez4viuuwSk=;
 b=EtWItESmxseysJmv+if29nXrOQhZ4rtlwTs+WrlVQ6XWTwMAu4T+aaqpVYEpL4aw1z67z/ROx
 a/kdZQWSBw1CSOFrLeqMiX4GVoZfoGqLAifSa4rGpW1SQ0WniAzEvqR
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.248]
X-Authority-Analysis: v=2.4 cv=EIs2FVZC c=1 sm=1 tr=0 ts=69eba818 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=GONi4oyU4xsA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=fKFdgPUslCYRdS_w59YA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: lKc93tCv20sO8jdrVaZ2Srd7CqYf6APJ
X-Proofpoint-ORIG-GUID: lKc93tCv20sO8jdrVaZ2Srd7CqYf6APJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE2OSBTYWx0ZWRfX/JDpB4NuCwOk
 oGpuiKXvcmLzaFf46wOhs/QPZsTwvSVk1uSrHBjPbJ7A6wx4vCDG7sj1lINp65Ztf0+5YvRWfs+
 MrTZ7Z8w0BUryTeeyzcGcqmn/1BgghPosBqx2iuG9+r/ywOQmoqTOrXQDlj75NFimaMNwAeghjh
 MLas8jhw/T6qh/L6oXXafZB50OY70gt15xqWy47KEw7NJ82A8iSmvinv7v95C6Px2Jqk1p2TcwB
 iCDSnbpiY+rfunvaovngZGeSHErEWE0ywbqiRkhDTsIx09lkw9JS7YwtOgQIo74RsyXsY/H9B5f
 OYp6pCaIbX4YqMkWAtpwSau1DCaTT014U0Z9WhJbzvEaZ9AkdYk+rIqel6AlFgMFp2MifBih3xn
 HUYYvA1KfzTihYHeYUptD5xxuX1gCxAKRg6N96f2e0KvfD3x5jL9p20ku82Bt9QdRskJE/uzbb1
 RFvRxp7cZ05F1B6lPNQ==
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

