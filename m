Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30503C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E0710E1CD;
	Thu, 24 Sep 2026 06:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="nkKEOJbd";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D664210E1CD;
 Thu, 24 Sep 2026 06:20:31 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5dimI4070823; Thu, 24 Sep 2026 07:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=lUwFsFPqnT3RO6dPQN4ks/2
 q2bIAvxb7BjgpyWBwPuU=; b=nkKEOJbd3wVPsHHiotkPyjzA+SBswv8kuQAEBp6
 vpgNMzbu8rNFRoHJjCbZ0Xz5R5CSz4VsTH1QAFrcZ3RV0x2dI68LraNrXFVjEj8c
 yWRGGXOryRjnE5Zy+SUCNK8Cy0+Xo5rLKAjsX7Rfoh8yZR2Tgq4YUw8nrmIITIM8
 4xvMD/pgHty/IO71/wmF+dMS39PfbqsvYiMIIpDZJkxmSDUW+5VZRxRT7PN9HBjq
 a2/gDB0I7MThraK0VncMjNq7ZCalTwulfUoVv4p8Tu3h3rHGnVnkmQLFcWK5r0wd
 Q+kTczYEHGgjjMQmbZTva1Xyas3GlKm+T/tXsM42J6SHdAA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjftm9vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:20:16 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 07:20:15 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v6 0/3] drm/imagination: Propagate all KCCB command
 submission code errors
Date: Thu, 24 Sep 2026 09:19:48 +0300
Message-ID: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATBtGoC/63PTU7DMBAF4KtUXjPIcTxOyop7IBb+GbeGuo7sN
 AJVuTtOEaIoy7B80sx8b66sUA5U2NPuyjJNoYR0rkE97Jg96vOBILiameBC8b7hYCRchjJm0hG
 GnAZ90COBPp2Ack65gM8pwru1Bmx0UC4mhrJcBZscAXeapOforUFWkSGTDx+3Ai+v37muvJEdF
 3WZOIYypvx5azg1y9xPmWZrmamBBrx3iAKlU048h3gYyT7aFNnSZhL3ntzsieq12CJ67ZBrWnn
 tr7fn3WavrZ7Erte8gl7tV578X09Wz6heeqyksuv/8N7rN3tYPSShRCcaidL88eZ5/gIwW2LI3
 wIAAA==
X-Change-ID: 20260810-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-0dae4f05fcb5
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790230815; l=2846;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=DUk0kPEEyRYUeJsN1StTvIIcVJKVul+C0NOCGMp+QBQ=;
 b=HECMHpDTIH9494IFf6hUJtYPqI2TLFgnsv+gcJLcpr4RyVSZGfsBs80uvFrGzKFAvAH4hSPPx
 012iyb0FYh+D8c7LJXz7m42EJLxrdg2UIrmYS05Xt8owBBitgYctdFM
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab4c120 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=aErvwOJsbcN-9OlzexIA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX1feoeqM2D7yb
 Nvbcw+QRmcv2TfYi171idzngBC9GHSphSif0NVSXjXHZMfiGjChFcpwVdLrIK+HtW/A60CxpDcj
 P3LESePynkRAAOXR2dWUCrKToTi6FK6vRV/w7l+p+txAMRCN7TYgVFkUEVXrTUILxH4NvXUBiVb
 Y5d8eiL80/76mNSdVA8XP4OeSMYfbxREit6ZAIH9NNqSdWcDzGQTfK3cI78JOJJLKZcWmFLtm6f
 xfP0iH0sh2yTkyNbIo9aRh4C8SlTJFMo7rlS3bKIrPfDL7hZv+Sov4kECIVMSBeHLkEoQ2LlWey
 RPUyCrdJN2ZdS3V7WbMkCFnjK6vwxqprpJgtmy0NeXXqxOAgJbn/QUNXrt7QCLwXhNUIwLD/ETY
 s5SChy384Qcho3905LQuZHUde/tJ++HU0AcSHKLd+iGEMuKB08lT2Mym3KQlCWzUxHi0iAg0Vcj
 VoqYXRcM6ZIqRn1/k4Q==
X-Proofpoint-ORIG-GUID: EJUbtoQ1SPmf_cwmM7ANa_Aq20RobD-Z
X-Proofpoint-GUID: EJUbtoQ1SPmf_cwmM7ANa_Aq20RobD-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX4A3opPPyVPyq
 Zahpaice6VZG5FFrzyeq3HMQr4DrJywiqIgcGFeNWVSYX1XHvgDy5zqMmTP+zBvo4UOXYH4QB63
 KQ7vNbsBCTFBrmaGhcb4tYqVattMRew=
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

- Set up an error path for pvr_queue_run_job().
- Propagate errors from KCCB submission functions.
- Early release pm references in case of errors.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v6:
- Refactor the patch into 3 commits.
- Rebased on a more recent drm-misc-next.
- Link to v5: https://patch.msgid.link/20260908-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v5-1-5e262721454b@imgtec.com

Changes in v5:
- Added pvr_job_release_pm_ref() to the kccb kick command return value
check.
- Update v4 description typo.
- Link to v4: https://patch.msgid.link/20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v4-1-b684f58a06ce@imgtec.com

Changes in v4:
- Added a check over the return value of the kccb kick command.
- Link to v3: https://patch.msgid.link/20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v3-1-4578a0fadf69@imgtec.com

Changes in v3:
- Dropped the job->kccb_fence check since pvr_queue_prepare_job() makes
sure that the check would always be true.
- Dropped the power references from the patch.
- Link to v2: https://patch.msgid.link/20260814-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v2-1-35355fad50ae@imgtec.com

Changes in v2:
- Provide an error path in pvr_queue_run_job(). The path will use
pvr_kccb_release_slot() to avoid resource leaks.
- Link to v1: https://patch.msgid.link/20260811-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v1-1-ffd55254d6d2@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Alessio Belle (1):
      drm/imagination: Propagate all errors from KCCB command submission code

Alexandru Dadu (2):
      drm/imagination: Release KCCB slot on error path in pvr_queue_run_job()
      drm/imagination: Release pm references in case of error

 drivers/gpu/drm/imagination/pvr_ccb.c   | 33 ++++++++++++++++-----
 drivers/gpu/drm/imagination/pvr_ccb.h   |  6 ++--
 drivers/gpu/drm/imagination/pvr_cccb.c  | 12 +++++---
 drivers/gpu/drm/imagination/pvr_cccb.h  | 20 ++++++-------
 drivers/gpu/drm/imagination/pvr_queue.c | 52 +++++++++++++++++++++++----------
 5 files changed, 82 insertions(+), 41 deletions(-)
---
base-commit: a8fe4e162ba8212b7e51fdb024b37800f36b496c
change-id: 20260810-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-0dae4f05fcb5

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

