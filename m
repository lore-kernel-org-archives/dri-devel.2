Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7991EC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F4010E82E;
	Mon, 10 Aug 2026 13:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ZRz+h6/f";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BF710E82E;
 Mon, 10 Aug 2026 13:03:45 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACktp02390877; Mon, 10 Aug 2026 14:03:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Y1CWRy/dDSk9aPyUFp5Bm1/
 CIqmvMwDp8nvPmYn0jB4=; b=ZRz+h6/fDCMIW5yI7o4zzkZIJ/mmFPY29dXnsPi
 Z77KQ1x44vcwJ1mx+xj6UraBrlQbnp44+GzUOK7Whtcwf9tULkFkELk63u4oSFUp
 E1vLqThzHcQCRgd9tB+z2RYFbVilNMwbuglsgqza/nHfgvy6cuMzEnCTbWdhX9xf
 E1WkoNw4cmVDVLSmwwtCcnNnfyLcubosI57pKNM828cKZeRLH6iXwFwqNLESPxgn
 vXDEOzg47CGSfJG3oTSDdh/zm5xnDa8col+6HCDp1OnvtV6E//XVwH3eqi/TZyG6
 zDrap4J+e9BuOUtKTxU4g0cEsCMdYd/54AOdxlCfCOK4aew==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fwvhtspxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 14:03:34 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 14:03:32 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 10 Aug 2026 16:03:22 +0300
Subject: [PATCH] drm/imagination: Remove duplicated CCB control initialisation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260810-b4-upstream-remove-duplicate-ccb-control-init-v1-1-4ea79b116b40@imgtec.com>
X-B4-Tracking: v=1; b=H4sIABnMeWoC/yXNQQqDMBBA0avIrDuQiIj0KqULM5m2UzQJk0QE8
 e5N2+Xb/H9AZhXOcO0OUN4kSwwN9tIBvebwZBTfDL3pRzNZg27AmnJRnldUXuPG6GtahObCSOS
 QYigaF5QgBdlbw+Ng/WQdtGZSfsj++93uf+fq3kzlO4Hz/AC9dEXKkQAAAA==
X-Change-ID: 20260810-b4-upstream-remove-duplicate-ccb-control-init-ed10e641d81b
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786367012; l=1171;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=lQ37mDGWfEoAtELQJql+Fb7jxVQ48C2BxBDTCBfPOzI=;
 b=PzapBWdQGpVnB0bnJ3mAMwDOJdmF1AsyUrxGbCJjkkBCV+S/oG5u0cjDOOiHCjQFhre7VpWj9
 7Duw5YrLnFsDU53jsAZJrd4HojZouL4w8X/VqsigGBli9k1OgBF9cTJ
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-GUID: -thoe5m-K_Pcv2M5wl4MuYWQr5z-63HQ
X-Proofpoint-ORIG-GUID: -thoe5m-K_Pcv2M5wl4MuYWQr5z-63HQ
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a79cc26 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=niZZOx9_CWMANDpma8UA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfXxBH23DywFYJa
 dtnOWgO8epAcnwUDGwBeIdQuCg8BZ46IPs5FipAfI2jdb1m7o9x+j7oQzh6ezekm8xhypLfT4mn
 xFGXeU/V5mMhM3OlG8AxikKiCjATT+U6XQWwLIt7wkgtATcK/L2KB5xq8nIqrW891mzutB6i1JY
 F4/tskrnqhEE6eRCSTVAW5eWVXmoknpsby/audGWkc9zqcHTi1PGa90330D7njzY47UMOu0pnGf
 6P2cgSElXniUXG8GllHFW1HcqUsaJHgLNE+3mmvc1LX72QC7RjrPMOD3uxc+nEiAoo5IEZi9NGG
 oiHlYfYUwA9j+xcJ4UfPpRmk1Q3dsFAQ9X5vIMmYyzKAr2WEOVfPZm2z13pXyVOSO/+I1acABSa
 aNficYrZxPJBEQLaRNxGGaf3yIgVIlduJ/CB0zEv9XmkPJh3i2F7d4Q1uRy9/ZMrD8DA/R3NoNr
 Ygl0HgXtJwr903xKJHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfXwRLmab+T0u92
 eYqHH25FmQWJA8C37xlx5RalaIRMeBej+0G7hF0KC4LWVc2hLKqIwaebtKSchq5lnsWQMdrsnQ4
 XRu0Gab0QxGTeBP2OECfPgydFMuokKg=
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

The same is already done by the ccb_ctrl_init() callback.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_ccb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index 4accf18e2341..48672a86ca2f 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -82,11 +82,6 @@ pvr_ccb_init(struct pvr_device *pvr_dev, struct pvr_ccb *pvr_ccb,
 	pvr_fw_object_get_fw_addr(pvr_ccb->ctrl_obj, &pvr_ccb->ctrl_fw_addr);
 	pvr_fw_object_get_fw_addr(pvr_ccb->ccb_obj, &pvr_ccb->ccb_fw_addr);
 
-	WRITE_ONCE(pvr_ccb->ctrl->write_offset, 0);
-	WRITE_ONCE(pvr_ccb->ctrl->read_offset, 0);
-	WRITE_ONCE(pvr_ccb->ctrl->wrap_mask, num_cmds - 1);
-	WRITE_ONCE(pvr_ccb->ctrl->cmd_size, cmd_size);
-
 	return 0;
 
 err_free_ctrl:

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260810-b4-upstream-remove-duplicate-ccb-control-init-ed10e641d81b

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

