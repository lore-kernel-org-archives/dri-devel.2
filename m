Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F98FF495F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45ADC10E45A;
	Mon, 30 Mar 2026 07:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="h76td7zj";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5480810E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:57:26 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U5HJTh174202; Mon, 30 Mar 2026 08:57:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=yB9+piC1EbFFmqnHwBkOC6n
 /Sqlzu3GE4ZlF3exkrdY=; b=h76td7zj/zSY2UDxFeki1uFVUcE2HGcbpHYBq7V
 YNmMk22sE6liVCUMS09pd8NQHSWmYlF5Tr/UpS+IvKycQx+EPgzOmG4od4ShhvLG
 73m2cZIfH+fbhsXJw3oUQ0hfw+dTb4Ne80GRBdx9jyhvsbzQzOVql5oUyBCcJS6v
 LeJlNQWyOI/4DEJVGx4AhdjjG/TfAC0/XclpbUJ6ZTDTUqQkazPyz4vI7rmMCCR4
 5lNOr/+R9mHw7E+fXXIhihGzj9cmnNjgJExAeyGi2RQyLWHHb3IxQF7x12dwGtm5
 WXWeaEJ2ZLpX2a3kIWfasrVMp9Oi6fSv80hwxcOVPAOLP5w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4d67xusfkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 08:56:59 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.6.106) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 08:56:58 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Subject: [PATCH 0/8] drm/imagination: Job submission fixes and cleanup
Date: Mon, 30 Mar 2026 08:56:35 +0100
Message-ID: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMsymkC/x3MQQqDMBBG4avIrB1IDEjjVUoXmv5tRzSRDIog3
 t3U5YOPd5AiC5S66qCMTVRSLGHrisKvj1+wvEtTY5rWOGd4TAPrOsyif8of2aEcJvRxXfjhYKz
 1bXDwVBZLxg3K4fk6zwt1XWMSbgAAAA==
X-Change-ID: 20260330-job-submission-fixes-cleanup-83e01196c3e9
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>, "Alessio
 Belle" <alessio.belle@imgtec.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774857418; l=1503;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=lvp5iBbzvk/kDvWmLdotGafwfMUI49hfQihjvGfgTLU=;
 b=VGZPMAS4hkE4GC9hYhC8/xEU5F9LFtJ8ZwfebEbOLQmhwCc88L4uCUMLRrmPMvvQA/pkti3ca
 +dT8kmmmsL5DscZxqg/XaRQ/VWxU6NcNAh67s2Ad0VvqTSxpXVSiRBR
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Originating-IP: [172.25.6.106]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2MSBTYWx0ZWRfX0ySgs+hjmKeN
 KolZrrA+f8K6/29OTFWBfXp2mCadMBoSENzOJ279EAdbhX4VkaZFhKByF2beDbGC7a8d2zv8P6d
 GF1xL5qjIBHLXl7xRIsrVPutJleNNPhWGzCDlWwjhijPnOHsu3+D8qEJvETqYIDqI3qAgkKsCJ1
 UJRrLHPZKrpbz/fpZUgpgQz/esWKGvEMEwJM6QhytSFbN5pV24kJExL1i9j7u5vFlkWpm6LV6L7
 MkigWGK+lOpC7y7xoP7NScpsxWO+lpaU2cNjRCywlQZOkzoWjKz1Ou0KyIn51mIkF85L/SxZJqP
 7+TdowoA1Hm8dvRHTFZqMa0OAqxo22J0iOYugOTJjLw8bHokcq03QkELuBEF0ysKPJlyqRotbQa
 ZHIz7Xkr1W/qnnIMCk1rAZt5Ygn5PtUHbzWQaTPUX/FJS0jbWDzWdB92vbeUFWa4BKPWZxrQKFr
 DpkX4zCE5TIhWFheDiw==
X-Authority-Analysis: v=2.4 cv=QO9lhwLL c=1 sm=1 tr=0 ts=69ca2ccb cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=txNhvCuK94MA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=2L_qYD7-lHZGDKFFxjgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: KOu9Qe8EYfkSAtSHH-TDDW2t0QAW90TX
X-Proofpoint-ORIG-GUID: KOu9Qe8EYfkSAtSHH-TDDW2t0QAW90TX
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

The first two commits fix rare bugs and should be backported to stable
branches.

The rest is an attempt to cleanup and document the code to make it
a bit easier to understand.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
Alessio Belle (8):
      drm/imagination: Count paired job fence as dependency in prepare_job()
      drm/imagination: Fit paired fragment job in the correct CCCB
      drm/imagination: Skip check on paired job fence during job submission
      drm/imagination: Rename pvr_queue_fence_is_ufo_backed() to reflect usage
      drm/imagination: Rename fence returned by pvr_queue_job_arm()
      drm/imagination: Move repeated job fence check to its own function
      drm/imagination: Update check to skip prepare_job() for fragment jobs
      drm/imagination: Minor improvements to job submission code documentation

 drivers/gpu/drm/imagination/pvr_job.c              |   8 +-
 drivers/gpu/drm/imagination/pvr_queue.c            | 154 +++++++++++++--------
 drivers/gpu/drm/imagination/pvr_queue.h            |   2 +-
 .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |  10 +-
 drivers/gpu/drm/imagination/pvr_sync.c             |   8 +-
 drivers/gpu/drm/imagination/pvr_sync.h             |   2 +-
 6 files changed, 110 insertions(+), 74 deletions(-)
---
base-commit: 3bce3fdd1ff2ba242f76ab66659fff27207299f1
change-id: 20260330-job-submission-fixes-cleanup-83e01196c3e9

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

