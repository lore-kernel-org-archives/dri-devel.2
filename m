Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEEAFED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9C110E0B6;
	Fri, 24 Apr 2026 17:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="qs80G9/D";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D9010F65E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 17:28:08 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OHRmLT424393; Fri, 24 Apr 2026 18:27:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=E+eHNfMzZKwKVmlC0MX82ra
 +WXUkVzD3Skc0qwAFvoY=; b=qs80G9/DOvxpCEWqZLEHtGr+8rXi+ZFdzH784Q4
 6TVbLCzSd5gcaBoWaKGJsd+9EXxZV7fzb287M4IzjfUhrSIjAzBx0xIBaWlXo0Sc
 48pAiunQRXM2X0qiupLQj8HywvxqI8ya0SuDPYYaZ8wVuJZGj38Lj6c5HoraAHIC
 GIq4cfFFHyZ47Uv5sgBt164rQz90n5ji0XYh0NCbOtw3MzYDEF6xSS8O7oqLuB05
 CFEqaeqTErupA3yg3fTVv8jfcpISrxzbltjDr25M49KWlEQq2ChaurCQvpTuC9Tb
 kGQc5lxlGlFWciDf8xaCJKFiRLqn99iq3edHXtuaMkd7GXg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drbq401rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 18:27:47 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.248) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Apr
 2026 18:27:44 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v2 0/2] drm/imagination: FW trace bug fix and configuration
 update
Date: Fri, 24 Apr 2026 22:57:32 +0530
Message-ID: <20260424-ftrace_fix-v2-0-50146ff526d5@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASo62kC/22MQQrDIBAAvxL2XIuKaWpP/UcJQXRN9pBYVKQl+
 PfYnHucgZkdEkbCBI9uh4iFEoWtgbx0YBezzcjINQbJ5Y0rMTCfo7E4efqw3qEanFTqbjm04B2
 x6XP2GhsvlHKI3/NdxM/+3RTBONMePQqtei3Nk9Y5o73asMJYaz0AWX8ICqUAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777051664; l=681;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=EaV8mTSqUo0KUCeCxU4nKSudzErbw4FV3DdtP7F1VNE=;
 b=KkaYKxjMNhCWElZdTc2YgZI4VQNc89uxWQk7vEu1PpaBRaZKXob9o5IKCS2r0seORSMcDipJR
 IMV42D6FYIcABgX+B8ZgIkTDF8zI/H3s/+0snfqzlQVzRZpJPOiJFlY
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.248]
X-Authority-Analysis: v=2.4 cv=EIs2FVZC c=1 sm=1 tr=0 ts=69eba813 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=GONi4oyU4xsA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=Z6cX24XRCVU5nlZxIyQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: CszTaRR4dd4V3b4EfJV5ygoOa4m-W80U
X-Proofpoint-ORIG-GUID: CszTaRR4dd4V3b4EfJV5ygoOa4m-W80U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE2OSBTYWx0ZWRfXyM6T/8Ock7KN
 MMkjFSwGDXxEPQPh2OcdqEscpLKs1SqD19Dx+sga8SuDuWNctXURXmUdinDbWF8kGkOCoPw+miH
 Q+NMjg1JR6ptifM4CEsil33u8C87pbh60lz2iAFZGnNHeMa3rZcsEAIBET0KNLwka01onG+GUtD
 XIPYmfF5iK/8pJb++zTIBBHZEZbhhdyEL8mAWNBmOiGAm6pTA60gX22lPvyIZ7iWlJjiDTPOuUl
 NrMSLk0d/4TUf4hhIjL+C0WgQmC9sjslVw2KzJ5np3Q68EsVby2YbXbyuvbkIIRPSWI3p4JAncc
 YGZpQZjnLfF/rmkdeFQ19qNCTO8gY7b8UoVKh6GgrW/sWbquG3BJ7CuU9WyNKc3ffisUuaxp+HE
 Z77k/c24AYDaeY6zrRItQQdI2/AWNH9WmkvFlnID0gSbgRl8eeHEdDoXbmylqN47kvv4NKbtRwU
 N3kOi6rIJjPW3Rim0LA==
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
Changes in v2:
- Fixed the name of module param in commit description for 2nd patch.
- Link to v1: https://lore.kernel.org/r/20260417-ftrace_fix-v1-0-9fefe194592a@imgtec.com

---
Brajesh Gupta (2):
      drm/imagination: Fix segfault when updating ftrace mask
      drm/imagination: Restrict pvr_fw_trace_mask module param to read only

 drivers/gpu/drm/imagination/pvr_fw_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3bce3fdd1ff2ba242f76ab66659fff27207299f1
change-id: 20260417-ftrace_fix-5de47d2448c0

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

