Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9134D10E2DE;
	Wed,  1 Jul 2026 05:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="CCHMFtKV";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90A510E2DE
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 05:19:53 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6614n8SN3371502; Wed, 1 Jul 2026 06:19:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=OHnpwUiJ6TSbRVgzdrsSSPx
 jkP6l6nTOzopabVXde28=; b=CCHMFtKVI+Bs3/fk/eGpsTXjYaqhWJ5VwTM0ZYu
 ZR1TpfTKJvKRot3tQtdPDivYZHitsq5YwnGTXpahIXujOzn6ryISXNOUNDiAzqt1
 /FUNE5z3pyjoK0dUJnSZGgqgUqzHPIYylnBayKoFIUIHuT9J1DkurlVOoUskntBO
 UC96Ic8IXte4hnQ6Tx0nrUU/s6F85OS1Y/Azjo48jcwBtCcxYZlnMTKvbAiCuMAk
 K+9gkPdedMqQ2RikrnpnAwls1QR6ritRIsYANwQY0cMp0b/7BMnpqAdpxEqtpCpJ
 Zr/2BNQKFTsiTNBzskwFhHEG+5vHWQ0Du1Q6GotUWhprpHA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kum1af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 06:19:41 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 1 Jul
 2026 06:19:38 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Wed, 1 Jul 2026 10:49:30 +0530
Subject: [PATCH v2] drm/imagination: Fix returned size for
 DRM_IOCTL_PVR_DEV_QUERY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-b4-b4-query-v2-1-a1b491387875@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAGGjRGoC/22Myw6CMBBFf4XM2pq2Yn2s/A/Dwg5TmAUUW2wkp
 P9uYW1yN+cm56wQKTBFuFcrBEoc2Y8F9KEC7F9jR4LbwqClNtLom7D1tveHwiKsQ3NFjWckB8W
 YAjn+7rVnU7jnOPuw7PGktvd/JymhRKsujpS0J431g4duJjyiH6DJOf8AdMpO9qcAAAA=
To: Frank Binns <frank.binns@imgtec.com>, Alessio Belle
 <alessio.belle@imgtec.com>, Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "Luigi Santivetti" <Luigi.Santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782883178; l=2635;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=UDx/USxnTWsJl64RIf/KoTgsa0SS1K/mC5Yd3H7VSi4=;
 b=pYNaMYwi4PfVeIi70F0JElJX1sS+xcHBx6EWFL6zVfQyDEs2VwAz//kpH6O3cKx4mXs9706j/
 5WaYxkL+EMJCv4iuPkplVyoRHa4wX+fgTGReRMlWQAt7oWwUzpYW6R1
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a44a36d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=zSf4H7TkD-6S84OFmusA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: qPxTzffrdAutCsoTnVVYIttUlWGIJURU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MSBTYWx0ZWRfX+HNyj07HZ7au
 iCv2TeY/a2cDHpENcFxXvMHfRLChb/ikImUpSl8tnZn37vLEa+9eypNFL+xoS/iF4zrSmyXQRJe
 GPM+TiY3vhx7v86T4eItT7wP5NXadIGBVTOZQGwOOORi5xaBqt2c/NTVJTSckTGp4WSR/ypkD2H
 bLCUlRnQ2zHdZnERtg91Azz4P6K/vzU+mvUmCCsRhIMzxRDFiT8VjRSKqIoJGhc+fSAGDHFCNAO
 yqHMaBi/FQ8NTHFi18lv1n0tfUa3oYnspVvwjLunRQg8OPQXoP4xbo/K4x8DB+O6tO7yeAi3LRa
 zohAYNO1ubAQInr5VGEDI01hyTjOIZdoz1fSFvfB6YEpBvZxiarP555EmcqRkOE3qkPCzsMR0WJ
 NUs1uNd2hTgjOdcV0Et73IoqjcH29NZjSrfPYLl8b2vP92mD4a2gooBHLT6s0TemBL0sbQDCmvj
 pFJgz6T/dtYdljhkGFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MSBTYWx0ZWRfX2VJu9azEzGlk
 Jc2g2UiYsxO7GpbbNaiKT3161eoLKFYc0mmTidoyAZq/wYvQebQJIOS2Mn4nJbLWE1EBEDthx42
 BrdHsOtdoxY+fv5/k0Njv6dFwpCLMhs=
X-Proofpoint-GUID: qPxTzffrdAutCsoTnVVYIttUlWGIJURU
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

For a few subtypes of DRM_IOCTL_PVR_DEV_QUERY, driver was overriding
the returned size unconditionally. This would have resulted in
increase of reported size beyond the amount of data returned to
userspace when args->size < size of query structure.

Updated behaviour matches with the description of
drm_pvr_ioctl_dev_query_args.size and written byte length.
None of the structures of DRM_IOCTL_PVR_DEV_QUERY changed after addition,
so change will not break any compatibility with earlier version.

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
Changes in v2:
- Fixed description of commit message to be clear.
- Link to v1: https://lore.kernel.org/r/20260629-b4-b4-query-v1-1-d17fe10b32c4@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_drv.c | 6 ++++--
 drivers/gpu/drm/imagination/pvr_vm.c  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index ca3042d14253..ee86c74df0d7 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -515,7 +515,8 @@ pvr_dev_query_quirks_get(struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 
@@ -596,7 +597,8 @@ pvr_dev_query_enhancements_get(struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index e1ec60f34b6e..396d349fb6ce 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -1019,7 +1019,8 @@ pvr_static_data_areas_get(const struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 
@@ -1069,7 +1070,8 @@ pvr_heap_info_get(const struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 

---
base-commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0
change-id: 20260629-b4-b4-query-bfc68c2c5cef

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

