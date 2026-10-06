Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03853CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D178A10E352;
	Tue,  6 Oct 2026 11:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="k7iuNhVs";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A3A10E14A;
 Tue,  6 Oct 2026 11:07:00 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6eXT1790091; Tue, 6 Oct 2026 12:06:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=j
 zWmq+X9jefrj+7iXdNSiEPrpUunVsnjrnJubry36V4=; b=k7iuNhVswRI34qWdj
 zk5D77wtBpqO8r6hcMYDUpzjEqTxr2zLe/DC42CpOUF0ZzZfOu2qiVuG8/P6hXVq
 4+xYfnIxoSlB5QsUF3eAReJ+EXOyX/eIknWeRGvya7ZEAMg4wP/rw6RV25/2yBV5
 3kEhFkA810fjNmgk7wozN5DwO/4yOKWsgz8Iy1G8q9elf09m+IWWAb7CzoMXnImO
 VDb8r708Z6o1PlnhoNDHrOEZXCFe1QOcS0O28rh1nZX0O7LyhO/Bj08RJLOoDZYB
 64jrKtAKoYbJuqeTJYWsqAHVn2cvSMvScX+MZPXWpWcP/G5bziUyFzx4wP+tuLjZ
 PF35A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h4brugugp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:06:53 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.23) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:06:45 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 6 Oct 2026 14:06:37 +0300
Subject: [PATCH 1/2] drm/imagination: Remove wrong soft reset code from GPU
 start sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-b4-utility-function-to-rw-regs-v1-1-a9faca685c4c@imgtec.com>
References: <20261006-b4-utility-function-to-rw-regs-v1-0-a9faca685c4c@imgtec.com>
In-Reply-To: <20261006-b4-utility-function-to-rw-regs-v1-0-a9faca685c4c@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sarah Walker <sarah.walker@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791284810; l=2515;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=5dY7/vf+n9dbbYhurr37Lp5WGc78/kyDHCvsXN6+89M=;
 b=rQVJ5uJtqwAqlakzK8VkcWAWXwfphwkLmlHIGIHePbVJfaVM99M6dscGys1BMgnQHgH5ukNte
 6bWDT+/GmK5ASaCscy8VKgRHiGn7rsDFzgS8F1EOJLsBie6DTM5xhu8
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.23]
X-Authority-Analysis: v=2.4 cv=FNOOVOos c=1 sm=1 tr=0 ts=6ac4d64d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Vfs-8JXWiL0A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=GBg6YYfLpN6JDpVl6R8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfX8g9YMDGv/CKk
 Fb9ZWrkvGt56a735FTPPlb3dw4eyp7ml4nYkK1+n10+E9m0bhy75ZDa+229DX1aHwiQb6A/hDbI
 lYTeDVyhzAiuDPdZoYoWmEa7Y/W4oEI=
X-Proofpoint-ORIG-GUID: SMAsb3bSHQJhB02RJRtJZGS6NSGcyfl8
X-Proofpoint-GUID: SMAsb3bSHQJhB02RJRtJZGS6NSGcyfl8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfX2y+z0jt7A5KQ
 upjwH1C6Ow7LdOXKQMeVL6Ju4DjuHFJLYCEQRLu57JI0Aya4QG8m9bPC4pQhu9pQrtCVmZ/QcU9
 arlUVeCEemiNOBzXibKEzZoajuVhZmAJtyG7oECj3jhRsU3THWxhU3g5mHQmjCjfETWDXndYUb0
 gzB3Bz5wR+BsYCH45inqda01luCL6k0U/XY1a9avY6qaD3hyej4GgIrPIroiVVTbL9CKPb8oust
 mUE0cvIrE1gJtyrc/vohtrlaj7rxua2p4pFIQgKz6fNz49jBK5CnAnL+uMod4rJFxDiMr5pbkuZ
 IFanTSPk2JTaEJzSzcubrdfazD8VuZPcqjzOqJdGMYw1CDiLjz2MYv/s57PviUHu/jd2tD9NvzV
 sGgkOqm7GsXsmv1GLF+t17FyZ5i18rRg+5AmyP2pEbw1d4EA68e09KMLxgYDmcIKyxPj3BMetQ+
 KFyjGYBYxlNmv7s8dLA==
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

SOFT_RESET2 is not dependent on XE_TPU2, but on S7_TOP_INFRASTRUCTURE.

Since no released Rogue cores have that feature or register, remove any
writes to it.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_startstop.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index 98ca2692239d..34c757267a22 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -110,10 +110,12 @@ rogue_slc_init(struct pvr_device *pvr_dev)
 int
 pvr_fw_start(struct pvr_device *pvr_dev)
 {
-	bool has_reset2 = PVR_HAS_FEATURE(pvr_dev, xe_tpu2);
 	u64 soft_reset_mask;
 	int err;
 
+	/* No Rogue cores should have this feature which requires additional reset steps. */
+	WARN_ON_ONCE(PVR_HAS_FEATURE(pvr_dev, s7_top_infrastructure));
+
 	if (PVR_HAS_FEATURE(pvr_dev, pbe2_in_xe))
 		soft_reset_mask = ROGUE_CR_SOFT_RESET__PBE2_XE__MASKFULL;
 	else
@@ -133,32 +135,20 @@ pvr_fw_start(struct pvr_device *pvr_dev)
 
 	/* Set Rogue in soft-reset. */
 	pvr_cr_write64(pvr_dev, ROGUE_CR_SOFT_RESET, soft_reset_mask);
-	if (has_reset2)
-		pvr_cr_write64(pvr_dev, ROGUE_CR_SOFT_RESET2, ROGUE_CR_SOFT_RESET2_MASKFULL);
 
 	/* Read soft-reset to fence previous write in order to clear the SOCIF pipeline. */
 	(void)pvr_cr_read64(pvr_dev, ROGUE_CR_SOFT_RESET);
-	if (has_reset2)
-		(void)pvr_cr_read64(pvr_dev, ROGUE_CR_SOFT_RESET2);
 
 	/* Take Rascal and Dust out of reset. */
 	pvr_cr_write64(pvr_dev, ROGUE_CR_SOFT_RESET,
 		       soft_reset_mask ^ ROGUE_CR_SOFT_RESET_RASCALDUSTS_EN);
-	if (has_reset2)
-		pvr_cr_write64(pvr_dev, ROGUE_CR_SOFT_RESET2, 0);
 
 	(void)pvr_cr_read64(pvr_dev, ROGUE_CR_SOFT_RESET);
-	if (has_reset2)
-		(void)pvr_cr_read64(pvr_dev, ROGUE_CR_SOFT_RESET2);
 
 	/* Take everything out of reset but the FW processor. */
 	pvr_cr_write64(pvr_dev, ROGUE_CR_SOFT_RESET, ROGUE_CR_SOFT_RESET_GARTEN_EN);
-	if (has_reset2)
-		pvr_cr_write64(pvr_dev, ROGUE_CR_SOFT_RESET2, 0);
 
 	(void)pvr_cr_read64(pvr_dev, ROGUE_CR_SOFT_RESET);
-	if (has_reset2)
-		(void)pvr_cr_read64(pvr_dev, ROGUE_CR_SOFT_RESET2);
 
 	err = rogue_slc_init(pvr_dev);
 	if (err)

-- 
2.43.0

