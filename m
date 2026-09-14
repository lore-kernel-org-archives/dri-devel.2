Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0A3C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CF410EE0F;
	Mon, 14 Sep 2026 12:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Yh0EST8W";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B0510EE06;
 Mon, 14 Sep 2026 12:22:19 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9nSLP3968925; Mon, 14 Sep 2026 13:22:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Lx3zuy+iPKuZEM7t1bg0Q0f
 zhR5rofzlUOKm2HoWC/c=; b=Yh0EST8WJnEL/8KQbR3GzkSBnq2gvREWhfIMDnU
 ZSmK33BorpAfXLINdhA3x+Ph7DFn5tZi2oU/1uj0D6WOOynS5+sgM3L3bgXd7wdy
 HewfInTrkOc3Ros9/IAsCwyJ2j6BxqHpRA1eDRn09sVVek5r+nj1oXy4wlQraBuC
 3BuxX2Gz9zTKp9+WscF821mfUSfsUPx60lsuqS7z/opkJNrrlP+BcJmFG4SyJ7D4
 sjdqRDj+b6aVq/qawoGCHUQ5omLmeb6RU7oj0HB/FWUBo0TbZWP0LXGjhnshm6lS
 ikLO8xbdUDUqcrcQ6svsTx09J47A7lAmoIMBcDzkCdNmATQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtuhky2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 13:22:03 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 14 Sep
 2026 13:22:01 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 14 Sep 2026 15:21:37 +0300
Subject: [PATCH v2] drm/imagination: Explicitly set CACHED flag on META FW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260914-b4-cached-flag-on-meta-fw-v2-1-160b0e4e160f@imgtec.com>
X-B4-Tracking: v=1; b=H4sIANDmp2oC/42NTQ6CMBBGr2Jm7Zj+oKIr72FYtMMUJhFqWoIaw
 t2tnMDle8n3vgUyJ+EM190CiWfJEscCZr8D6t3YMUpbGIwyJ1WrCn2F5KjnFsPDdRhHHHhyGF7
 oVfDmWF+8Oxso+2fiIO+tfW8K95KnmD7b1ax/9p/qrFGjtdYTBa1a624ydBPTgeIAzbquXzjmd
 WnDAAAA
X-Change-ID: 20260804-b4-cached-flag-on-meta-fw-b0fb2589ba72
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789388521; l=2098;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=pk5CzGMv6wfqQ27YN+s2fZ93xkhlABGu0wmEGpqqng4=;
 b=YCUBszvHoH9rvt5rQxm5yV8fgEnnuftaBr+bE5nMp2UvsJR452loPbjq9kGGRJFGM0uyrudc0
 THlU8uSQF+ABZgRPIVbiBgjIgbgUs+e+tWiCqAtLGN+xIYmTzXJSwW7
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aa7e6eb cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=e5mUnYsNAAAA:8 a=XEBLIeaGfW8ddilKDEYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: L0lO9eqNwbGKGxgxk4DV_X_cIGVOwybi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3NSBTYWx0ZWRfX53bLV9r1B00h
 UzP+w79pDcYZxiCDP+yVmtUDT/ede9V7mfwGrICl/jhWDeyOirgOFHGcKZLUqMTZ8fsJi+6fz68
 qL8Be7Vwhn2uBLeZe1fEazkGrPme32QJLmiuqQy+jNTnTxvlyWfhlvGBMVuwGYNdR3TEmjxwDdH
 RbdKI4pwgbX/KFwEh2XX2xYw6C3cOU9J89SFY7UqozYdIuay19hZ7RnnCKpbwYGkHgb7Z7nVsXa
 L01s2b/ruUZiu+E81FHiQLJNNgZzM2yaIHyIL9qT3RTL5721v89LXp8oXHqTRmPQ3w1eFW02MzJ
 AAD6wd/blz1O05HK/hl5NH9kwm4Q41F/iHMMaYGkf0zuGgDpO1EPsVIjE9GxuLJDY+6LtIz7/x/
 3sQ9RBfOReGnyDZpOY7a8am/s3YWGBbtIyBHSn0NPuGHlHlK7R/WpP7mEJlC6WgBSeceZ4tghp2
 W+xK8qEbl6INSv1PbdQ==
X-Proofpoint-GUID: L0lO9eqNwbGKGxgxk4DV_X_cIGVOwybi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3NSBTYWx0ZWRfXzXn/rSYNxh5/
 C6o4pmdzsVlbzKTLhYsOvLhBf1iyi8t3AMKeLfEuGAxcm4rrpSYVsRd/kxGzq6DmMF7BDAwAnqA
 DPxZBBXsmcjIfB9lMyZQos+i3O6FbLA=
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

From: Matt Coster <matt.coster@imgtec.com>

For completeness, OR in the CACHED flags when we're not ORing in the
UNCACHED counterparts. One of these is probably zero, but (a) it isn't
evident just by reading these lines, and (b) the compiler will make it
disappear in that case.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v2:
- Update the author field to the correct value.
- Link to v1: https://lore.kernel.org/r/20260804-b4-cached-flag-on-meta-fw-v1-1-333bccf10d3a@imgtec.com

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
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 9ff03bc60a08..b5837ba56e33 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -509,9 +509,13 @@ pvr_meta_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 	u32 fw_addr = fw_obj->fw_addr_offset + offset + ROGUE_FW_SEGMMU_DATA_BASE_ADDRESS;
 
 	/* META cacheability is determined by address. */
-	if (fw_obj->gem->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED)
+	if (fw_obj->gem->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED) {
 		fw_addr |= ROGUE_FW_SEGMMU_DATA_META_UNCACHED |
 			   ROGUE_FW_SEGMMU_DATA_VIVT_SLC_UNCACHED;
+	} else {
+		fw_addr |= ROGUE_FW_SEGMMU_DATA_META_CACHED |
+			   ROGUE_FW_SEGMMU_DATA_VIVT_SLC_CACHED;
+	}
 
 	return fw_addr;
 }

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260804-b4-cached-flag-on-meta-fw-b0fb2589ba72

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

