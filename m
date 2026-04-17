Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C70F43689
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF5A10E9A3;
	Fri, 17 Apr 2026 09:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="WZxkLVj6";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906E710E9A3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:42:39 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H63uhb137357; Fri, 17 Apr 2026 10:42:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=tzqCqQc+O5NquTMmQHuIIe1
 CnNrl1+zrK6XaidCKjWI=; b=WZxkLVj6x9xjOKHFdydt+UqrTkgkKZMoY/u+VEc
 +LYhaQTcW2h8IiE83V0M18oeqWU5AeIqwL1c3mCNCOwQj0gLbH+COn6h6ZYNDrKU
 djeFApK0IJv/r498dMlPFq3dvDbWC3l993Pszj/q9vD6i/ySNxGjt7ExEFV2JFbt
 xNQUbyu6HB7kacGrQhrgAoHNmCAKyYq7LWaRZ1MpR93toukALc6YXNYbO9NH5xaP
 iagU7GRU77/TFqx3G3WJ5hZy3TAMqWi7TweKvjjPmoe8tTzEzdfAKpH9rSbVKPCo
 Pk0zdZHvJiitp9uLJw+lMI9MXpeAY/GlDdj7JFO3LlTl30Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4dfcjr52f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 10:42:23 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Apr
 2026 10:42:20 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: FW trace bug fix and configuration update
Date: Fri, 17 Apr 2026 15:12:12 +0530
Message-ID: <20260417-ftrace_fix-v1-0-9fefe194592a@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQA4mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Nz3bSSosTk1Pi0zApd05RUE/MUIxMTi2QDJaCGgqJUoDDYsOjY2lo
 AOb99CVwAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776418940; l=502;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=zzQbFcb0ncRKQZKnaviwR3p8SyTA4Z0XB4T8or2sRlE=;
 b=o7yemzSjysoOrTQ2fYWlufV4KQ1lSpIXU9WU65gC2+WK4WKg0AlRKn8OFgZvfv1Nv2vaNAMdF
 xlV9Fuy1op2AGvEGPrlyZjgcqSBpR3dKzlDs1ibued8Q1zvtJlrL+h6
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-ORIG-GUID: SuufwWMdxRqLnAhEXazzNyEbpgEUI1mI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5NiBTYWx0ZWRfX+kAEGzgOF6xH
 N8QDaHekqclgmTP3vVnNuEwbAkb/MMGwmipkwiXKXaXnhj3yA84B3FflpAKsdJJpipyiYZBxrSY
 guEbMfuVf1BtxPtAyg3x97Mk/LC+NkcpYg+6jmSrO0BacULq1neDpSjOH51YvRVtCFdwjOVF8eU
 Y3DdIqkU49VQCG5D+i7ko3YHfUMK3oN/9LLD8aLqb6+uwIcHSgSJimECEARyGM5f0Hwdghhu53Z
 aPxh/U2K3RdV75XdfQ3WGb8qZx5QJ/kO/fgFKl6rB6hEi8qUe4V9YApyfvFgU7gGC5il859GSyT
 H3+YDdS7ciBpAynpzTDSwCaUfLf3rhzSFUcPTiXRn2jZvsq+4+zsFeLY299+yBlAfYFjWFUUHxf
 qARYTW3V1Zx9VQNXsTaxy6UofQirMKk4tsx6HYw0UWYAlrAOm8sLXEH+74NeL5gnvqV5MVPUXF7
 c68NoNPYaNHqgMTC8mw==
X-Proofpoint-GUID: SuufwWMdxRqLnAhEXazzNyEbpgEUI1mI
X-Authority-Analysis: v=2.4 cv=a4sAM0SF c=1 sm=1 tr=0 ts=69e2007f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=Z6cX24XRCVU5nlZxIyQA:9 a=QEXdDO2ut3YA:10
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

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Brajesh Gupta (2):
      drm/imagination: Fix segfault when updating ftrace mask
      drm/imagination: Restrict pvr_fw_trace_init_mask module param to read only

 drivers/gpu/drm/imagination/pvr_fw_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3bce3fdd1ff2ba242f76ab66659fff27207299f1
change-id: 20260417-ftrace_fix-5de47d2448c0

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

