Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EEFCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099D310E198;
	Tue, 12 May 2026 06:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="UdzGiMHS";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6E910E573
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:47:41 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64C4BwAY1813823; Tue, 12 May 2026 07:47:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=EGoVlp6yC2OyesoAAFh39yD
 FsOIk7hPMHaLSgIta74g=; b=UdzGiMHSn2a/GQVIhVSvAG13s4vTcicjgifr+ZX
 FDaG7qu28hfVoR3c43djQcP3OpgJrmAeXuG/C8GBcTLlJ/pVA8gDFiPE4cnbEADD
 03M+oUoAjXnarUsngOmSqLJgjBqkwXeRN9DjGcpNmkNg6jOjH6quJ75uNL3GhKNs
 T8IxskvZUOXdgAT7T1+TFWpXPHu9Z1SocBs2Y4hyqVTfIIvf+TckNWP1uMqLugA0
 xdsU5R/cUFVbVxhwglzzMdWAr0/s03svg+nPMvkcQ2Y93NJT3v4KF+mEbVDfP9s6
 rMyQ2mfczGW0SSihDepHGWtC09KmPrzhM1V9W+82e/bz07g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e1w0t2c66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:47:28 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 07:47:24 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH 0/4] drm/imagination: Multiple enhancement
Date: Tue, 12 May 2026 12:17:02 +0530
Message-ID: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAObMAmoC/x3MSwqAIBRG4a3EHSeovaitRETlb92JhUoI0d6Th
 t/gnIcCPCPQUDzkcXPg02WosqDtWNwOwSabtNStbJQWay2200WkOHsERGHbXvaoVKe0oZxdHpb
 Tvxyn9/0A38Z4N2IAAAA=
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778568444; l=1070;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=MZIpiwDUx8gQjwrInM+D18ASA2OTgLxNxN1/ZFTOfAU=;
 b=lzw8ZW8na3hlf8DWKAlKiQT+WypgwGoAi2qceM24RGlNpTo8Jv6UaeqU7TP0e5A7H1m0vMsbg
 CackxCWOYIiBHXt8/DliAqIQXY4vm32tYu06gvM1brHWNI5/tYl8XW8
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Authority-Analysis: v=2.4 cv=b/6CJNGx c=1 sm=1 tr=0 ts=6a02cd00 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=f7c8-jAbXVoTAZo7cbUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2NCBTYWx0ZWRfX77o6u/JVUcMJ
 nKcvzLK/RrjbTe7tlByazPmx/KKBMW0H2N41cCG7w0OSUe2qrGIedAP48+XEfKBgytOr/0TnOXi
 zqxYxaz9ZCVNLfTpUbLcG+qIu2fgDFYbmvvhA0DKIUhB+G6/0R7oDRgBnXUiFHYVM1dpRxHL8SO
 8Z63iAXtyTNMj8zjXgo0zJolFi660rmGAcH9xAFw1vSOKKynt3I+IJPOdj0ubgiyNmDyMrnFYh2
 6apCFFKlWPJTHjT8E0sZ0N2eY8QSnK/2ci5Yek2knjlpWzwUpv8kN5F3DJsItZLQXhmjqcmLO6A
 9u1S6MF07nWQHpzUc/Ci3caKLApvj8H+WAJbKOeMi4JDNnAUZcszf26jVa2QbI7I9SujaUjxVRH
 69BRTCpdnmRBWjWs9dPDPzyBkLc0+/DVDhYbDmUsxoUQeJWVeS/JNESeF6Bxl4iA4gI+VQa1j82
 79bzKUWeNjlUBximqZQ==
X-Proofpoint-GUID: FaxkYKY_R8QID6-xIxdv_JfCrqWkFr79
X-Proofpoint-ORIG-GUID: FaxkYKY_R8QID6-xIxdv_JfCrqWkFr79
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

General enchancements to improve driver reliability.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Brajesh Gupta (4):
      drm/imagination: Populate FW common context ID before passing to the FW
      drm/imagination: Don't timeout job if its fence has been signaled
      drm/imagination: Rename FW booted to FW initialised
      drm/imagination: Access FW initialised state with READ/WRITE_ONCE

 drivers/gpu/drm/imagination/pvr_context.c | 30 ++++++++++++++++--------------
 drivers/gpu/drm/imagination/pvr_device.c  |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.c      |  4 ++--
 drivers/gpu/drm/imagination/pvr_fw.h      |  7 +++++--
 drivers/gpu/drm/imagination/pvr_mmu.c     |  4 ++--
 drivers/gpu/drm/imagination/pvr_power.c   | 14 +++++++-------
 drivers/gpu/drm/imagination/pvr_queue.c   |  7 ++++++-
 7 files changed, 39 insertions(+), 29 deletions(-)
---
base-commit: ddfbe68a14260aabce25322fac81f2d02501369a
change-id: 20260512-b4-context_reset-f6909e31712d

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

