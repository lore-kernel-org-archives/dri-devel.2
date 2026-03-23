Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA40F483E3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F47E10E055;
	Mon, 23 Mar 2026 18:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="LXfARGFe";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3557510E0A0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 18:31:59 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHNTKs4033998; Mon, 23 Mar 2026 18:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=sJo4cl95lyKVRuH6RzoZ6VB
 eP1eP3Hmzds6OU0jMF8E=; b=LXfARGFeJYExeOX+qDe5ECIaB2qQA1aquqiHRa7
 IjpuO7o1Mzn80L/gSK+vAnT7fT6gFK8HJ6A3Ih81InKcW6Sz4UuRHZd7Muvu+wgg
 UrG4Wyo30DK4iVk7frNoM2wT3dLOq+UYNh5pMN0bI2JFG/sa3mhfhUldehhbKcdF
 8qAa1CFjUYJBmSsIG/n4EFaxwymrO6lJgqp4NHIsqmfwGGDpx14B4lXg89JxtfNN
 7vFGog+ZtyLqSbauPTIlWSFNSj0Z4uLghx6GIx6yEBsoqzjfzTCn/dE2RVhaDV0N
 GKxhClx//6PyZHwoNHM9OqKN6wFaCc1xcmRd07kUMoexFQw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4d1jfqsrww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 18:31:44 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.37) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 23 Mar
 2026 18:31:42 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v3 0/3] drm/imagination: Firmware handling of context reset
 notification
Date: Mon, 23 Mar 2026 20:31:27 +0200
Message-ID: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+GwWkC/53OwQ6CMAwG4FcxO1uzDVjUk+9hPIxSoIlsZlsQQ
 3h3Byc96qn5m/T/OotIgSmK824WgUaO7F0OxX4nsLeuI+AmZ6GlNrKQFdQltByGpw0E6F2iKUG
 gSAmcT9wy2pQrIN82d3YdmFNpVV2RqY8ocusjUMvTJl5vOfcckw+v7YFRrdv/rVGBgtKQRjo2e
 bYXHrpEeEA/iBUb9Qeg9O+ABgmWsLKmxFqab2BZljeuTPI6UAEAAA==
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Alessio Belle" <alessio.belle@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774290702; l=1817;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=N8/YvF9QGcCpQnEJuZ1fp749TxJqxJedvsXaYYTEdWM=;
 b=/s425m7Whm+qns24nyxnrWZ3y3TZMpQdFNf6OS6cVU+hOft1I7AuEsRZ06pOYx4UT5lTrgJag
 yuMsi63o2NbCJlLXZXS+JAv/aU7I8FhKpQZ1CDm5S3B2ESOWxgxBFDZ
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.37]
X-Proofpoint-ORIG-GUID: 0h7E-hrurap1tdpQIc4Ojdj0OnDa42ep
X-Authority-Analysis: v=2.4 cv=HJjO14tv c=1 sm=1 tr=0 ts=69c18710 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=7IANbbwssFwA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=X7ODqez2nMEkfPg2YWkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 0h7E-hrurap1tdpQIc4Ojdj0OnDa42ep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzNiBTYWx0ZWRfX1nUlobBoSfsW
 pE9rPOxlU2UhWmYYalGhOj2jZBksnpLQ+rI0YuknVdrf+pmA+ZYGIwRhul/63pIk4JZrPfy12OH
 kFSSrfnJgUePxdZdSxIUh52tbUJoAACx/ZBSUf2RoJ5chQW+ehLm3kW69WhzMF87TR5Gc1uqS+Z
 7+CTBVTNIDRqb6ViKnrhK9WM5D7ByOOShVLp5dkips9Dj51Igwt4PuTPyQYDV+6ZM09RttSv8Jj
 tEqFpHZEkLGcDcHpLBihJIBOzct40wA5/jXGRv91I61pPyWYUcAFmz33PFkVbG3xq5pdCyq3IPf
 DtBzY3EjCOhDiWD4LIU9l0+5FKTrmM1p325oOQ0EIKgaorddbG9bT50k8RCnz5aTb+/K0lbQgQJ
 obGSzHnQvRGnQUtbZsjDSRFM8GasV4r0EaGpjEqgx311SQQFrqqtx59c1Xo/du/6/mXM1+5wy4u
 /W7hcRdXglQvMnlX8QA==
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

- patch 1: Adds missing context reset reasons.
- patch 2: Fixes the reset_reason from enum to u32 in the fwif.
- patch 3: Adds the implementation of the context reset notification.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v3:
- commit messages update to a proper format.
- Link to v2: https://lore.kernel.org/r/20260312-b4-firmware-context-reset-notification-handling-v2-0-aec5a64cb06f@imgtec.com

Changes in v2:
- enum rogue_context_reset_reason update moved to a separate commit;
- pvr_context_reset_notification() renamed to pvr_dump_context_reset_notification();
- added handling for PVR_FWIF_DM_TDM;
- update include order in pvr_dump.c;
- fixed enum type ambiguilty in fwif headers for the reset_reason struct field;
- small QOL and nits fixed.
- Link to v1: https://lore.kernel.org/r/20260305-b4-firmware-context-reset-notification-handling-v1-1-46e2ce8d46ef@imgtec.com

---
Alexandru Dadu (3):
      drm/imagination: Add missing rogue context reset reasons
      drm/imagination: Switch reset_reason fields from enum to u32
      drm/imagination: Implement handling of context reset notification

 drivers/gpu/drm/imagination/Makefile               |   1 +
 drivers/gpu/drm/imagination/pvr_ccb.c              |   5 +
 drivers/gpu/drm/imagination/pvr_dump.c             | 113 +++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_dump.h             |  17 ++++
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h       |   8 +-
 .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |  18 +++-
 6 files changed, 159 insertions(+), 3 deletions(-)
---
base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
change-id: 20260305-b4-firmware-context-reset-notification-handling-694a1b5e6b8c

Best regards,
-- 
Alexandru Dadu <alexandru.dadu@imgtec.com>

