Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB228C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4EF10E029;
	Mon,  3 Aug 2026 10:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="qCY7K8GC";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3181510E02E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 10:22:48 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673AElVI939482; Mon, 3 Aug 2026 11:22:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=l
 r6vxK9Er9zJWk/pJ9jCrxSZ5xPLTBfCWV4T8S+OTtU=; b=qCY7K8GChYU3hT96w
 RNatq2ZWSJEhNrHsez0mtwEjXnr9Cp5eSMx+Aj+AYbHq+mzJsUhtZEG9zSHcN9Pq
 shFFbxG4YMNXW5+Rz5loynkCKYpnCGpdlQCQu8WaTL7vS/czOjuYXUxrxtT2TR1I
 87zQXEND6AjdM2TzG5iiSgM9yYO3jeKG03Jy/nE4WDYRohoHNc7n9kmQjnnvAanL
 q05ng5SWGbSvrQVsli9Ge4W0nKbVjT6adk9SHah5Xg+tkcKMrC1CvMWFeUWTJDlB
 7dvOd0r0YddmVbSSecD/4v5eXzQxguZS85P1V97odgs1B11a1ZORla6foJl70EBh
 ZoaQw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72psc8b-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:22:41 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 11:22:41 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Mon, 3 Aug 2026 11:22:27 +0100
Subject: [PATCH 3/3] drm/imagination: Fix repeated typo in KCCB documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-staging-pvr-docs-fixes-v1-3-0d014c7b2671@imgtec.com>
References: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
In-Reply-To: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785752559; l=1636;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=Cu2H0Pp+OPcd5NMg6EO/+cfZgCFSP8BdTD8fmvDInmc=;
 b=TXJvjWgUkFQeXHoJD2AR6eIRQ2ngum+VnRLphTJXXnt0GoHm7m9MXqGW4MyllokWLBwbTWQ3F
 KYaSku6ZviGBejQ7wm4Yy3v8lAESrJMQq2s/wB6GDEgTWg/hmb7qFCM
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfXwot4kNq15Q0G
 ksG8Azf7//axWBaog2pcqLOAota1O17MV0vSkxmPj4HZ15YlCbAfvL/0gD5MhPRSnAtjCLfuBgJ
 OZ8+q7Sy+BZMmkUzt6+LuhMrQBusjBQ=
X-Proofpoint-ORIG-GUID: kvy7DpUUEJk4gBKZiUQrriygUH-xrYmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX+OLKAbwwtHYK
 ajh0dccffwaRBGIF3QCQsclmO4ATzm9E/HYFdytzq8/GinVolcr4bpfRAW0FkG79nbwYaLLFdwI
 cjwGxPGXJtrjz7wYdrRkjJDOGI8VG5UzIQ0bSAPQHa4Kdd0O/2bW8bjdlmZESY7t1nnAXA/HY+n
 hstraoTI9HRAvnEJt4JGS3GNDx61UExdpVpvJMty7q5Fw5g8TDWrHDL6747ywKCtr8xorHsUBLR
 7uaXEJT1KWVqT5HvHxRXZP6PynA36WXEAtWVyFWOmJTymF13+rSRylbAaltm1NCeJYZXSyVRcDo
 ufSXeXsN37sWM5Reeya4j99MZz2oQfW/YZzOsx7ma+TdcrWGx7dobU0sldax07riXspDUhH1XNR
 DBETwsmeDXvU4Qobspso8ATkTdrGYXukXR6+3euKVv9qxGgHb72bC6EzDZUUB63uPXYZygmUhr5
 vF7WJu9LRobppwFJYhA==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a706bf1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=8cxtoKZlyhhrrST14ZQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: kvy7DpUUEJk4gBKZiUQrriygUH-xrYmZ
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

Fix sent -> send in the documentation for all variants of
pvr_kccb_send_cmd*().

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_ccb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index 4accf18e2341..b702d122d791 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -255,7 +255,7 @@ pvr_kccb_used_slot_count_locked(struct pvr_device *pvr_dev)
  * pvr_kccb_send_cmd_reserved_powered() - Send command to the KCCB, with the PM ref
  * held and a slot pre-reserved
  * @pvr_dev: Device pointer.
- * @cmd: Command to sent.
+ * @cmd: Command to send.
  * @kccb_slot: Address to store the KCCB slot for this command. May be %NULL.
  */
 void
@@ -361,7 +361,7 @@ static int pvr_kccb_reserve_slot_sync(struct pvr_device *pvr_dev)
 /**
  * pvr_kccb_send_cmd_powered() - Send command to the KCCB, with a PM ref held
  * @pvr_dev: Device pointer.
- * @cmd: Command to sent.
+ * @cmd: Command to send.
  * @kccb_slot: Address to store the KCCB slot for this command. May be %NULL.
  *
  * Returns:
@@ -385,7 +385,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev, struct rogue_fwif_kccb_cmd
 /**
  * pvr_kccb_send_cmd() - Send command to the KCCB
  * @pvr_dev: Device pointer.
- * @cmd: Command to sent.
+ * @cmd: Command to send.
  * @kccb_slot: Address to store the KCCB slot for this command. May be %NULL.
  *
  * Returns:

-- 
2.43.0

