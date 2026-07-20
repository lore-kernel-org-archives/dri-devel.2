Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5723C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2C310E8B7;
	Mon, 20 Jul 2026 11:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ELoFcke6";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0437410E191;
 Mon, 20 Jul 2026 11:38:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAwUxZ2673859; Mon, 20 Jul 2026 12:37:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=T
 wKV9ZUaXVBtoJRpaCaw6Z+6i7UfcgtrTq6OgAGiG6s=; b=ELoFcke6J8KUtS5Pd
 PqhaZH813Z58CXfBHhOpq5NZNYwcnPcjKxjG5TWPMVdMYlMsXYm8+vTJyBie8vTr
 J0pjlF+JRq41XdLBVQhrczXB+WSdoJv3CNVgp0BfibfIfScDYTrjsz6bMUyYjqEe
 28TOcokWft7C3TELj4TtjXqyYDzZ2PWyEzdruCQGc8i4kYigxHwAK6lrGOU4oRy1
 5WGdhsjLn9cA4ob/uF/H/xMEQTogBsf31ia2r3NAY3Dh0tJV18IGA5Gm5igGXSLr
 LOXZ2wI6Ib8sVJaPnXU5PbRyBIKiWqXclkRUsFbMXwUc9hxQJ0tQ2ZuFm/18Yl8Q
 Ob+Qw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4ffyrq9hn7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 12:37:50 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.138) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 12:37:49 +0100
From: Frank Binns <frank.binns@imgtec.com>
Date: Mon, 20 Jul 2026 12:37:12 +0100
Subject: [PATCH 1/2] drm/imagination: update GPU support documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260720-promote-bxm-4-64-v1-1-39abcd1cf263@imgtec.com>
References: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
In-Reply-To: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Frank Binns <frank.binns@imgtec.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.4.138]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfX4MC3KbSJa1aG
 /EhP0Xu9EIOySZsBjFqywOUTMF5a7VX5p6tJq5PwX3iKfR0emUTjSy7CTNUVjqA7h0nlxXvgV25
 O7thpD8eHqBMEjt2YmpWXZEyEHg45Zw=
X-Proofpoint-ORIG-GUID: GXjz_vlZUOFN5plw-mk0jlr0Dy19BXHP
X-Proofpoint-GUID: GXjz_vlZUOFN5plw-mk0jlr0Dy19BXHP
X-Authority-Analysis: v=2.4 cv=a7sAM0SF c=1 sm=1 tr=0 ts=6a5e088e cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=NzHnPcJToGcA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=m4n3hMHeGltgG1YPZf0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfX0SMjjD1fAeou
 49MZeN5PJNpE71dyMuuz8qnyS5Tu5cdYNF69fUFH0fUP9oWC05H3omysBOFwP/4ccv1oHf0/ijg
 IGUggEoskPLJPJnKThZkwAZJFCpeQwlREgdQxop0Jw1BQvX/q61067KiH/7YJ8QozEHK3YmciHZ
 c7dUz/6mYevV1vFcXZ+iWub6gN+c/3cmRrPqIztQxnwYukJA295Ta/an4aRt+gtTHAjfJrVBL5J
 wwfYquaLx2iB1VUagvcYyOkVG5Y5mLE2X5Y4GG7Wxp0gLFJNJzLFgphQhoaYrVpzCF3oEMk243t
 +W1bLnC+2sw0sWMSe4gIcCMDbjETSXuRbGFHDPBpB+Mbs+j6aZTQEYcVkisAs/agfluom9iSNVj
 aOfzmCXsre0UqGFxuCZssdPeoZ569u+bB2aAkRpou6IfVUDxO5XuCf4AtVSBOAjtGlkbQLvO56E
 CMOJdm/iuusZlonunxw==
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

The list of supported GPUs contains the GPU model, along with the SoCs
they're found in. The SoC information can easily get out of date, as
typically GPU models will be integrated into many different SoCs and
upstream support for these can potentially happen over a long stretch
of time without necessarily requiring any GPU driver changes.

Replace the SoC information with the BVNC instead. This uniquely identifies
a GPU implementation and is useful in cases where a GPU model may have
multiple implementations due to, e.g. hardware errata having been fixed,
and the driver doesn't yet support all of them.

Signed-off-by: Frank Binns <frank.binns@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 8897b3bdeb4a..a22da0b911d5 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -43,8 +43,8 @@
  *
  * This driver supports the following PowerVR/IMG graphics cores from Imagination Technologies:
  *
- * * AXE-1-16M (found in Texas Instruments AM62)
- * * BXS-4-64 MC1 (found in Texas Instruments J721S2/AM68)
+ * * AXE-1-16M (33.15.11.3)
+ * * BXS-4-64 MC1 (36.53.104.796)
  */
 
 /**

-- 
2.43.0

