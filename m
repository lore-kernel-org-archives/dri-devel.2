Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24662C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7738910E191;
	Mon, 20 Jul 2026 11:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="iWRJ0sVu";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA5010E8B6;
 Mon, 20 Jul 2026 11:38:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAwUxY2673859; Mon, 20 Jul 2026 12:37:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=FOIN6e2SMEabmFxWwtM0zjs
 l0VvFvbzy+mXTRKddZHc=; b=iWRJ0sVu32rralg4SiBV2BWdEoHfGrh4rd4lFVs
 CGa+Al16ZCMR8WpemQRPSYWN4Xwi0hsxplEYkZsNMDXk1yhwuyDhAt2XSBunWK8m
 YZMs1jx81/ZP1Efe55ufXqLGItUNAebpRhGbNyyl9gHn1aYq7QuW7K9PyoRslBH9
 NAJ2YCkXl+xTc5pwzJgfNSzTpHO6MZRpAqNJqq3L6HQiGQaDN7V72jRrWdgCrU+l
 lYhsOHNolmJF0zdbRFswoyDejmFZKZ6LKR+HC5dQ7h5RlE/uEJdH24GUUaiDnWLX
 8WgYNGF/Y4xjwYDg/hMdIW16zn/ZwQ8fNdeNeNlDTLwO0Ww==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4ffyrq9hn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 12:37:49 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.138) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 12:37:49 +0100
From: Frank Binns <frank.binns@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: update BXM-4-64 MC1 support status &
 GPU support docs
Date: Mon, 20 Jul 2026 12:37:11 +0100
Message-ID: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGcIXmoC/yXMTQ5AMBBA4avIrE2i1ZS6ilj4GYyESotIxN0Vy
 2/x3gWeHJOHIrrA0cGe7RIg4gjasV4GQu6CQSZSJ5nQuDo7242wOWdUqBWq3Ahj6i7TMoWQrY5
 6Pr9lWf32ezNRu70fuO8HlNPVa3QAAAA=
X-Change-ID: 20260716-promote-bxm-4-64-489199ad7623
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Frank Binns <frank.binns@imgtec.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.4.138]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfXyxxXcfRBqhlp
 LlCCnjQcxp2QuNz+tic0Zmtn268mmIpOCM0c4eiEBilK6K4j3y5msYY8mQ6HP5/yLSlR6Yl0Evt
 oUjcUKGD/YEj5erhZw5+op9t2UBCtb8=
X-Proofpoint-ORIG-GUID: QVg6nbKEjirvg2TrICyWAoZMleCmBZlu
X-Proofpoint-GUID: QVg6nbKEjirvg2TrICyWAoZMleCmBZlu
X-Authority-Analysis: v=2.4 cv=a7sAM0SF c=1 sm=1 tr=0 ts=6a5e088d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=NzHnPcJToGcA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=p0WdMEafAAAA:8 a=r_1tXGB3AAAA:8 a=J0LzUdeAGxPty6-kYBYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfX/Is7cXue/nBn
 A5iC59HaQPxnr+AbdOigFBCY7HvN8audNWV5mrbzh9qsd2t9qdoIE61bN5y450zbDbas2ayaKEQ
 xkgMqriHvkcI3+jPDJv4HkVW+Zr8h84y63AxfoAHPGidSyztLiSwhaPchvHNj1JrJ0e7xpY0FPR
 3naUu5TSoFe/HReX19SFqp8xQ/qAmVscQa1UKg/T5LxJr4IlPlTz+Oyj69vqi9vw6CnEWBjDZts
 9Z/t3Ewa3vPol4AWUW2VJFZXB1WxUttO0JEPUC3453cXswNjWIOz+V/tfGsrI7pCT+1n6RpAZab
 g+GiW1QiFA0Qen0otGYvTK7aDli5/ct4xnalF7YBv6J2jX4Lr1qJJu88ZfUwH63PvM/KEtvWlTA
 8GGIhsDWih7O7+Bxd5pdfXGBcQpxCUDdItnF2AYTbW3iLQQ3MISNJy+LTU0P6tACMJPl+JChlgW
 1znE55JUlzFJJTr50pw==
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

BXM-4-64 MC1 (with GPU ID 36.52.104.182) support is in pretty good shape now,
having gone through a full Vulkan CTS run and there only being a handful of
failures. The firmware was also recently merged upstream [1].

The first patch in this series updates the GPU support documentation to replace
SoC names with GPU IDs (BVNCs) in order to avoid the documentation getting out
of date / out of sync with what's supported.

The second patch promotes BXM-4-64 MC1 from experimental to supported status, as
well as updating the documentation to reflect this.

[1] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1138

Signed-off-by: Frank Binns <frank.binns@imgtec.com>
---
Frank Binns (2):
      drm/imagination: update GPU support documentation
      drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported status

 drivers/gpu/drm/imagination/pvr_device.c | 4 +---
 drivers/gpu/drm/imagination/pvr_drv.c    | 5 +++--
 2 files changed, 4 insertions(+), 5 deletions(-)
---
base-commit: e5320be8a585a9286f231305d0d443d59c24e46c
change-id: 20260716-promote-bxm-4-64-489199ad7623

Best regards,
--  
Frank Binns <frank.binns@imgtec.com>

