Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530E2C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A90610F34C;
	Thu, 10 Sep 2026 07:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="HlYsmJjA";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1677310F34A;
 Thu, 10 Sep 2026 07:57:23 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A5FBNH1603590; Thu, 10 Sep 2026 08:57:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=Z
 w8fjKrjLwxOinKxvcIokMsm1ckLmARdYYiaNUrTCMc=; b=HlYsmJjAyFZJeV4us
 Q2vRF+OB4RgUFHtZa2eU12i88Z+CcSHM2Uqzb990wCdWO8Cpax8ZQOi82L0u0R/w
 FpQM82zwI8qutSAvKT47Z9423gx28yWh6GnBM85QTE+CXhujAEu02JAujZs2Hozf
 dzrl0TmYl3rCpI+4OaBc9Zm+XPlHa8tqLWjIoa9rOoWkIjiregbzZHR72pqUjDta
 ry89clA15v5Fi3zOAwkt20NN7qQjfyGl3+TsxYvb/1tWCQljefMe85Wk4yszan2I
 2GUHQjwcFBN91N6gyMBfQChVCZN5D7N/8h5YySL16t8tvruW1HkSWjKkjL2EwDJt
 Sm/Kg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gkk71r74r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 08:57:11 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:57:09 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 10 Sep 2026 10:56:40 +0300
Subject: [PATCH 2/2] drm/imagination: Avoid initialisation of unused FW
 trace buffer pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-2-7e10274384c2@imgtec.com>
References: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
In-Reply-To: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789027026; l=968;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=JqRrO6Qd3Tyqf3v2PAYTjQFo1c/RhL6uaEW90GjZc6M=;
 b=E67U1+xf88wnZef874mmjfn5Wt636bPCSnA9Qppcim0KLHsnju8jaPet2uDK1Plg4Ty8EemYH
 QnTuXONjzxYCqgycRO5Xr91hdr6rFwHg50wLgn9HO6SH9MjQaeUmGGP
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4NyBTYWx0ZWRfX0qhvHzwQYm1P
 xde4xCWuq/GpV8osIdUUfFNh7xBuo/+i0jpu539xUl92IiFelShFT48qIUX4BJMDpS9DiOn6j4w
 sLCT8ykU6bL5Hm71ILNz2X5afHe2Hsc=
X-Proofpoint-ORIG-GUID: YcBR4iaFUL213iUJeNnWJZ5IZ_rHTplu
X-Authority-Analysis: v=2.4 cv=IqGL47/g c=1 sm=1 tr=0 ts=6aa262d7 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=VN25UFedZO8qgD5FeVEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: YcBR4iaFUL213iUJeNnWJZ5IZ_rHTplu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4NyBTYWx0ZWRfXyRZgVv9rukH6
 dmkMztILNr2RuN9Js6ZRj3e6VjfxAIYCAj7kgA3CV3hDnSUh9rYORIdLvHBzgFB1UnLCfU6gSA1
 1E3r7EsWi1rY+HeDftZBE69IN0rrc0hbMH0EC9/4Js/re2oKj4fjKfYtf/hKXhb9lrg1NPaXsos
 ktvmcur1eawrfrXAkt1PHPt5Lb0l+Ms8T+SIFItZ0MU24rs/vv/aFwNVjjMJxvgw1VMwBlyMSex
 5cKAaXf7Zf2MQswMSTNblYnSm9qYHiAVwZz+ywF8vSckkW+/LggawthcCg+3Eahb4evALojVYuS
 FyNIsUmNBEwBH2WxIBrXc7JEdNJLZe/cMN+p8qFFepoto2rpdDnoeS8+yOO2F6Z6dibTXKoVOK/
 o2RyOFsl3DSnYOMP1mYYpNPKD5tq9e9LYmTYnlXqMHkhQyL7pZfp23n5/5+COEmWn44ppM8w3tR
 NKGGSRETOlUk7JQI5mA==
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

From: Alessio Belle <alessio.belle@imgtec.com>

This pointer, which is part of struct rogue_fwif_tracebuf_space (a FW
interface structure), was initialised but never used to access the FW
trace buffer - only the source pointer in the initialisation being
removed is used.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 6bb5baa6c41b..813b7b0c8d4e 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -101,7 +101,6 @@ tracebuf_ctrl_init(void *cpu_ptr, void *priv)
 		pvr_fw_object_get_fw_addr(trace_buffer->buf_obj,
 					  &tracebuf_space->trace_buffer_fw_addr);
 
-		tracebuf_space->trace_buffer = trace_buffer->buf;
 		tracebuf_space->trace_pointer = 0;
 	}
 }

-- 
2.43.0

