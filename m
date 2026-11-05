Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684D606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=xBl5HM9m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79B41123B5;
	Thu,  5 Nov 2026 12:26:12 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3A71123B5;
 Thu,  5 Nov 2026 12:26:06 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5CPOPO791876; Thu, 5 Nov 2026 12:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=MKageUirTMJG0iigDptE0/1
 U7HQmcEEiqpUyfGdxDzI=; b=xBl5HM9mA6+P1lybCxdC/SWF8a9EudznjOSTsnN
 LlPwglKINwVkKskbvf/37HxGG1EkvJ3zcpZ5BB9Yo7ywIwJJlmld3mXlDZqhofnC
 KJG4ZakmDTUUGZxhmeGvBnKi2kOpalNr2pJ8alEGV1dnBdv0u+MHVyORE4CRkCUv
 2DMFqJNxKE9SoJKQeLKoBI5EWFS4dgu53J3iceVSTLdZCcQmXmZx2SY/b6ggQ1xY
 IOy1ud0E6M474tYuCCqlqI29Xmf2pCyRz0oifkl0vkjgNXW/RcoHKXOLhdTzzcIJ
 xfk7Ty5WZ026gsZ1BbHO4ToVAnbSncFCZeh6+qNbkG8yzcQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hr3j6rw3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 12:25:56 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 12:25:55 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Thu, 5 Nov 2026 12:25:37 +0000
Subject: [PATCH] drm/imagination: use appropriate poll function for non-iomem
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAMB17GoC/yWMQQqDQAxFryJZN2AGcdGrSBfjTLQRHCVpqyDev
 bFdPv5/7wBjFTa4Vwcof8RkKQ50qyA9YxkZJTtDqENLVDc4yI62RjVflpln3KIWKSMGIkrEbe4
 5g+ursn9/6e7xZ3v3E6fX1YPz/AK9GNS0fAAAAA==
X-Change-ID: 20261104-fix-sparse-iomem-warning-2111c1e6dbed
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <frank.binns@imgtec.com>, <brajesh.gupta@imgtec.com>, kernel test robot
 <lkp@intel.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793881555; l=1969;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=V5i9tOW1sjv2SO2onaXrXPslHqcp/oeOlEjsXztMbHM=;
 b=uDOqNBv5qx+eg04gI1mHWmzuN5WHTmkJZYL9Q0KFsc2WIcjg/IGN154xEoILJd3EnjfMY5kv0
 2k4gLGc61bxBPwxpa+FwPFtIA8JPOPHvCrC01IVKgrbwHGFipmPP0Mk
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-GUID: g0bPr4xxCqIDQL4qUhBotHn-DyD1DncA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0OSBTYWx0ZWRfX/dSeRNFYjYg0
 VSfHBaujxV7/XeUz6TJB0AOzmRyQTYa0shtFt7O2zOVychCbn5P2rkbUSV/QxCZQX15TOKzYkO9
 UL5X793cQeewccEoYBXGYZKWat2qpb4=
X-Proofpoint-ORIG-GUID: g0bPr4xxCqIDQL4qUhBotHn-DyD1DncA
X-Authority-Analysis: v=2.4 cv=DtnDa2/+ c=1 sm=1 tr=0 ts=6aec75d4 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=r_1tXGB3AAAA:8 a=3oOJLAxtiLN628aBsBcA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0OSBTYWx0ZWRfX9jpkcREeyEVD
 xce0weoSvU6dkIcjI+KMPJp65g2nzzdRdZIGcZbqA9Vpus0msxnUrsXTT+L77+qoS9uJilH08TB
 zTtv51Pdl+Olu7NUPnUQSqZkCTbsqVCyfpG92yqIQxqxmQ6BLDnl9FCscyJ4z55K27YQPNHP7Du
 083zSNzPMgJDI5nBWj1xVNC1y5VVv5jcMecgHfIyjOEWkv/tn1VKaD9i/9yf9AEXvYDJKjOmagk
 H9dVZ73ZdGH7gs15fXuZmwoN0iC17D2HG0cpgkcjRq0m+8IoypNIve/2zbfxFZFKib7v0O9aU/z
 ShHUrCoiTO0BYgqIglTORnZh5cAuWGfSmPKPqlwTrKtbftvX03zNmBCseAtXpjbDzITfn3TtYK5
 DOKbCAgRBRCpUyJXM9bENcNIoKA071O7CB5dyjK+V3ed3HLcnFriKeMmPmeyjX+r/P2Lt/kpdO8
 Pw4QJeo/Sq7O6DE91ow==
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_power_send_command() checks the contents of some memory on the CPU
that's written to by the firmware. readl_poll_timeout() expects the address
to read from to be qualified with __iomem, that is generally used for
registers or memory that is accessed through a bus and other than regular
system memory.

For PowerVR in particular, __iomem is not accurate as the memory pointed to
by can strictly be system memory only.

Fix this by lifting one level of abstraction in the macro expansion chain
and explicitly provide what routine should be used for reading.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610302136.3nli2ijx-lkp@intel.com/
Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
Use a different routine when polling for reading from system memory, in
particular one that doesn't expect it to be qualified with __iomem and
at the same time try not to change the timing.
---
 drivers/gpu/drm/imagination/pvr_power.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..c7c160913d7c 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -59,7 +59,8 @@ pvr_power_send_command(struct pvr_device *pvr_dev, struct rogue_fwif_kccb_cmd *p
 		return err;
 
 	/* Wait for FW to acknowledge. */
-	return readl_poll_timeout(pvr_dev->fw_dev.power_sync, value, value != 0, 100,
+	return readx_poll_timeout(READ_ONCE,
+				  *pvr_dev->fw_dev.power_sync, value, value != 0, 100,
 				  POWER_SYNC_TIMEOUT_US);
 }
 

---
base-commit: c347fef5f8f8927985bd67835331ce4cf7ff43a4
change-id: 20261104-fix-sparse-iomem-warning-2111c1e6dbed

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

