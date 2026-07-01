Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3852AC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D053010EDF8;
	Wed,  1 Jul 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qeiHV/ph";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rH//uDuJ";
	dkim-atps=neutral
X-Greylist: delayed 1075 seconds by postgrey-1.36 at gabe;
 Wed, 01 Jul 2026 06:43:16 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7D010EDC1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:43:16 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6612uOgV2538133; Wed, 1 Jul 2026 01:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=q1OMlnLqhJ/nuYl7HOrfRPHTY5k1p1Y5aURnyZGWW
 Q4=; b=qeiHV/phV4GHzquhPti8KZG/K7h5KLH2g6YqTJc4OI+IEDa2bXNV2ZZ+o
 oOL7mbC16ANBuhMy8zm//lnO7UVW4c7lQTQZZtmK1dHjEtzOUJ3da3Fsrq8RQl1z
 nblpbYvo5OyQ5bO5AUcPm7PhpxKiATuLfFqfzOjydt1cZIgDqg7dG++phO7Zqq+1
 y398CcXFsY1wsX0z1VMKh5XYIpinNq0Z0HUtFkHQB8iM2iZraMTPX71GhkaMn5CS
 7RS27jLliXPzob74IG/02s2H7EhzPvlRC1VWUZ1iXYBubbw5BMIJnRkqHrnCbn27
 PFp70MzGgO+Vn9vakNAXN9JkGHQQQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4nva2ftq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 01:25:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/5XA1CV4fT+IHkoBCdZ5tszyRZkU19QaU4Jp0PEpWQcnz9B30DwkcVLsFEINQUjrY1btUeS4CRGo7WdomT2Kpa5HuxG24LantO+0q5zF3G34Ck0yL5Y7d6DAxTiPi4gj63LL5OrYOPgLqmYWIdj6e/IOO3joyJydzQgbObI1adzte2ZxfzDZ8XLfLG6SPFl+cCu3Zc4mABDJw3V04Hq2Iw/nLHBVPbAby/NNKweNzEmsXZFwD1QoQx1McYYEoUgR5dIGa0qX4BawW7hrdWUdjRfrIqjxBP5E9VJdVU6wOIvlLaIbYMpthV2WdkM7EmcAvY3Li9nYUvKzk2Z+MLKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1OMlnLqhJ/nuYl7HOrfRPHTY5k1p1Y5aURnyZGWWQ4=;
 b=MFY0ermx6ZQfU4/QPFHXvnPyfQF46kZJKXrcd4LBQWm8aeamFWE3Z+KLltBIURxrpD0Cnh0Z0UyQUVHpcbZhoZOgBMqEAcjPe29ekGH+mFrGcHduqrNLLY1ernP/smgmmcajKv7XaadU5gbF3L962MVjycuvM5RhbGXb+38XYe+JXjOf8ddFXrVRWVr1ly3V+VGDoPCfSQt6kSsOvPNFai483kjO1UAjJkdGXbjrpEiM1rQUMO49hCL1k/2HaCf0GWWtZvaje8ef0rFr9694Ttc+NJj04zN8IZ9nubvGlpxv/RVpdijiEY2NOvghzlWB+tITjUL2YeURHTz9XeMl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1OMlnLqhJ/nuYl7HOrfRPHTY5k1p1Y5aURnyZGWWQ4=;
 b=rH//uDuJzDVKBvTnWrQ7rK2jldFv8/E4gK61EwFzSnyDFWcWQDtPyBiZOS/B1mNTkb5GPYE2MveZCBqhGAB6GtTzgESWvEF/pJN5zZnKL7Z8p//+7wXrYc8kljhLY/WmUKQW1rMFt72fHd0UjMUhzUkP6JUh6Hn9EMQIYSpPp7I=
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by BLAPR10MB5042.namprd10.prod.outlook.com (2603:10b6:208:30c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:25:29 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::a5) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 06:25:27 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 01:25:26 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 01:25:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 01:25:26 -0500
Received: from a1257480.dhcp.ti.com (a1257480.dhcp.ti.com [172.24.231.175])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6616PA6N710280;
 Wed, 1 Jul 2026 01:25:23 -0500
From: Jaspinder Budhal <j-budhal@ti.com>
To: <ogabbay@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <j-budhal@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 2/2] accel/npac: Add NPAC client driver
Date: Wed, 1 Jul 2026 11:55:05 +0530
Message-ID: <20260701062505.1091840-3-j-budhal@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701062505.1091840-1-j-budhal@ti.com>
References: <20260701062505.1091840-1-j-budhal@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|BLAPR10MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: ec02c275-8ff9-4534-f7c7-08ded7398afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|13003099007|18002099003|3023799007|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: HiZK1KgMNmd48bhwEDV2884bc7nxMzLDTu/6ok6ym/VNSOde8iQMNiBLOknH5oEUMAfuDuLto1as4vRQlpiMLQMKJNW/kTG+TOVoWB5+WoCNcxodgG7qdvNe3/B6M+0QQG09i6pUxnIN+TDibxLjiH/0JB+rjpRlLkToTcz2KPyKfM+P7vnBMd5iAHBhrZdSI3SqhE8FJf2r7Sus3fFH6i6f//wlMFW1hBd46t9s1qbY2YcU8KKHhjJbyJkSCQ7NXGgurJ1J+GKSNNNb1v8lmV6gd8riLp8YulRt9KWH1ENdpCSiv90IYUF8e0hpddfEl0zMcME3tgFkpVshD9EMTaEqlVm6FneUWhi2FXe7FGThEZ8yon+yY7zjxwgeDw0lng/rBAb0igwT5rpmCUABMcKvyoi69n8ygI3ouW7u+j6Aog5CB6SwcLKblrbAO7Kz07jkHOcwX6XitGOXeIwL0HMeWr+LDS4cmq0KsA81anssbbhqhVczjY8tzwM2JDi4pq8/7UD7MGUFgibG5eRu0Y2RZy82zxy2cROEp8UxS0c8D0t6EN7EQBJ2zwGRObkd0sRVyH7IfdCZQaknV0tQ1m9ZcHr8BXTDUGLORm0a4FmCaNdoAxc9YjN5kUsGwjiDttX33Ysd0qIE2IRdtFTgPQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(18002099003)(3023799007)(22082099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pTjUXHnVwCx2+CARFAeL0+7ljtiMYccs5uJibXQ46w4d3o3WDlnmcP2d5h68WK1fgKSfgetdBHLueahRP8MFUPu/30j4PygyLZ48i/VsxRUWPMTjCeZBl1JcxKIzHZs8WHt3jSU3GpaziutbAdwccGBTAQEviQufrxWLYB0AB16rMOkPZAuTBC9dyn2/2Eoh9mHHUfWdnuVcoSEdgfEDmv+z0CXxpuaec3qsE3u9aHreYHABvinYM33dnNS6YBIAyFuqQGy3A0UY9pQXzxxUTF+9NDwuwm7jby1YH8gT7DHy5fMZt7tO5do02VW2m74j4b71IzXYX2Snur9kKo+bXocrA8PIric7FwZE71ebc2aqwS7X/P5aetEUl6ajgKY3CLT4nLSCjsGNbHJszrxVokr6TBI8iJGgHCLcBQgMunsLkMVB86tReuNOsHLce23y
X-Exchange-RoutingPolicyChecked: ieAjJZvX3ItP/WVcY8x1phdWkWD40Q3xQPnXIYwwnZrI5vh10AnCm09AXNT36Y/+UeMDaoSlEDeCyBYYzhEi099AeCv0nL6Y1Nyorh+XBbFKFgHqaEiayeHJpRLLMTCPbMzxKI5W1Bkkkj0Pvmk35bHYBQawdBwwPGd1MmxN5I8YPhipXICMlxnHHhxc7ZvRz9XHenor2EJYB7Qli/LOrnaHbYH4ddvp6VDnvjPW5Rex15XSg76coBYei4SZpfFf1yM4TXYFzMpBMiMbMFCM4OFUeGAcMsAlxRWP4+A2ZEh2FahWswkz87mGTsMEKlwBsa/s3UR8vip0QGUUyWHRAA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:25:27.6941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec02c275-8ff9-4534-f7c7-08ded7398afc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-GUID: ZyT12Tfkugtjo7-0-0CJ5hrCOKuFY8UF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NCBTYWx0ZWRfX+zIV9mN6pCJr
 SR7gaQer603U6xIpNoJo34mizNyGeiDCfGiadnycSlpOzYzJdUWhBO0Wa936BnuiR/dr9ypdL8V
 r5D5LPlc9xL5cuhhK7MOztu/5mY3uadRjUTn+ru7fkVOanysjHdzcA1bplyhO/3J35ppIJNFF0q
 pZwEaLv3bpbI3Oupfl0ndZsUJ2Zs6MI0n19QeoWmL6ZqLFV0nx9WWHVHHhrPjXXVrRGPu3MLodI
 cduXm8YclvSEFYeFC31mv7a5Nr4iX2SRgfTdzXUtmj+tLCu7k/j8D6pPSG8VbbiReHZ8twAUwf0
 1VO/g0tPZYuDhYKTZuQ1w6tW64TkKAVrxMBD7Fd218ZmDn5rI9OK+z2RxKG5hmXSATB5yu2UPrT
 /Y1PDmY6UIVQYEgidD4ElRyMUITdsVfeBzwlWFcQa2VSFJpq/xlOWXT9E0QtDGOSJ9g+0m7BP4f
 AV4sLOM6PBX9PZ5iSlw==
X-Authority-Analysis: v=2.4 cv=FqA1OWrq c=1 sm=1 tr=0 ts=6a44b2dc cx=c_pps
 a=QNQPV3WJHVGG3OZWPlqtww==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=SldqRqN-pHjL7LJduoQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NCBTYWx0ZWRfX9nLqwd9q3PvJ
 ZkCktrWxUB5oJSZbBi6VGVDYVkBfch4Y+hb8t+EEftIZP1OBeF3raweD2vo5y495RPBONDpfbWd
 ro+rO+GMGNC5/ETBc+4n6NetHoVsWNI=
X-Proofpoint-ORIG-GUID: ZyT12Tfkugtjo7-0-0CJ5hrCOKuFY8UF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010064
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

Add the Linux client driver for the Network Packet ACcelerator (NPAC).
The driver communicates with the NPAC host driver via RPMsg,
allowing offloading of ethernet-related packet processing tasks.

The driver provides the basic framework for receiving offload commands
via IOCTL and communicating with the NPAC hardware accelerator.

Signed-off-by: Jaspinder Budhal <j-budhal@ti.com>
---
 drivers/accel/Kconfig         |   1 +
 drivers/accel/Makefile        |   1 +
 drivers/accel/npac/Kconfig    |  13 ++
 drivers/accel/npac/Makefile   |   3 +
 drivers/accel/npac/npac_drv.c | 218 ++++++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 drivers/accel/npac/Kconfig
 create mode 100644 drivers/accel/npac/Makefile
 create mode 100644 drivers/accel/npac/npac_drv.c

diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index bdf48ccafcf2..a6d8c1ebfcf1 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -28,6 +28,7 @@ source "drivers/accel/amdxdna/Kconfig"
 source "drivers/accel/ethosu/Kconfig"
 source "drivers/accel/habanalabs/Kconfig"
 source "drivers/accel/ivpu/Kconfig"
+source "drivers/accel/npac/Kconfig"
 source "drivers/accel/qaic/Kconfig"
 source "drivers/accel/rocket/Kconfig"
 
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..0df7b9f2ae18 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_DRM_ACCEL_AMDXDNA)		+= amdxdna/
 obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
+obj-$(CONFIG_DRM_ACCEL_NPAC_CLIENT)	+= npac/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
 obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
diff --git a/drivers/accel/npac/Kconfig b/drivers/accel/npac/Kconfig
new file mode 100644
index 000000000000..a9543ac2c7aa
--- /dev/null
+++ b/drivers/accel/npac/Kconfig
@@ -0,0 +1,13 @@
+config DRM_ACCEL_NPAC_CLIENT
+	tristate "NPAC Client Driver"
+	depends on DRM_ACCEL
+	depends on RPMSG
+	help
+	  This driver is the NPAC (Network Packet ACcelerator) client,
+	  communicating with the NPAC host driver running on a remote
+	  processor over RPMsg. The driver registers with the DRM accelerator
+	  framework and exposes /dev/accel/accel* as the userspace interface
+	  for ACL rule offload operations.
+	  If you have a device with NPAC and wish to use it with this
+	  driver, say M to compile this driver as a module, or Y to
+	  compile it into the kernel.
diff --git a/drivers/accel/npac/Makefile b/drivers/accel/npac/Makefile
new file mode 100644
index 000000000000..89f4773d7041
--- /dev/null
+++ b/drivers/accel/npac/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_ACCEL_NPAC_CLIENT) += npac_drv.o
diff --git a/drivers/accel/npac/npac_drv.c b/drivers/accel/npac/npac_drv.c
new file mode 100644
index 000000000000..7516382ba74b
--- /dev/null
+++ b/drivers/accel/npac/npac_drv.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <drm/drm_accel.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_ioctl.h>
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rpmsg.h>
+
+#define NPAC_RPMSG_SERVICE_NAME	"ti.npac"
+#define NPAC_ACK_TIMEOUT_MS	1000
+
+/**
+ * enum npac_acl_cmd - IOCTL command numbers for NPAC ACL operations.
+ */
+enum npac_acl_cmd {
+	/** @NPAC_ACL_ADD_RULE: Add an ACL rule. */
+	NPAC_ACL_ADD_RULE,
+
+	/** @NPAC_ACL_DELETE_RULE: Delete an ACL rule. */
+	NPAC_ACL_DELETE_RULE,
+};
+
+/**
+ * enum npac_acl_match_type - Match field selector for an ACL rule.
+ */
+enum npac_acl_match_type {
+	/** @NPAC_ACL_MATCH_SRC_IPV4: Match on source IPv4 address. */
+	NPAC_ACL_MATCH_SRC_IPV4 = 1,
+
+	/** @NPAC_ACL_MATCH_DST_IPV4: Match on destination IPv4 address. */
+	NPAC_ACL_MATCH_DST_IPV4,
+
+	/** @NPAC_ACL_MATCH_SRC_MAC: Match on source MAC address. */
+	NPAC_ACL_MATCH_SRC_MAC,
+
+	/** @NPAC_ACL_MATCH_DST_MAC: Match on destination MAC address. */
+	NPAC_ACL_MATCH_DST_MAC,
+};
+
+/**
+ * enum npac_acl_verdict - Action to apply when an ACL rule matches.
+ */
+enum npac_acl_verdict {
+	/** @NPAC_ACL_VERDICT_ALLOW: Accept the matched packet. */
+	NPAC_ACL_VERDICT_ALLOW = 1,
+
+	/** @NPAC_ACL_VERDICT_DROP: Drop the matched packet. */
+	NPAC_ACL_VERDICT_DROP,
+};
+
+/* Sized for the largest match field: a 6-byte MAC address. */
+#define NPAC_ACL_MATCH_VALUE_MAX	6
+
+struct npac_acl_offload_rule {
+	__u32 match_type;
+	__u32 verdict;
+	__u8  match_value[NPAC_ACL_MATCH_VALUE_MAX];
+};
+
+#define DRM_IOCTL_NPAC_ACL_ADD_RULE \
+	DRM_IOWR(DRM_COMMAND_BASE + NPAC_ACL_ADD_RULE, struct npac_acl_offload_rule)
+
+#define DRM_IOCTL_NPAC_ACL_DELETE_RULE \
+	DRM_IOWR(DRM_COMMAND_BASE + NPAC_ACL_DELETE_RULE, struct npac_acl_offload_rule)
+
+struct npac_device {
+	struct drm_device drm;
+	struct rpmsg_device *rpdev;
+	struct mutex req_lock; /* lock for request */
+	struct completion ack;
+};
+
+static inline struct npac_device *drm_to_npac_device(struct drm_device *dev)
+{
+	return container_of(dev, struct npac_device, drm);
+}
+
+static int npac_add_rule_ioctl(struct drm_device *dev, void *data,
+			       struct drm_file *file)
+{
+	struct npac_device *npac = drm_to_npac_device(dev);
+	struct npac_acl_offload_rule *rule = data;
+	int ret;
+
+	dev_dbg(dev->dev, "add rule ioctl received\n");
+
+	mutex_lock(&npac->req_lock);
+	reinit_completion(&npac->ack);
+	ret = rpmsg_send(npac->rpdev->ept, rule, sizeof(*rule));
+	if (ret) {
+		dev_err(dev->dev, "rpmsg_send failed: %d\n", ret);
+		mutex_unlock(&npac->req_lock);
+		return ret;
+	}
+	if (!wait_for_completion_timeout(&npac->ack,
+					 msecs_to_jiffies(NPAC_ACK_TIMEOUT_MS))) {
+		dev_err(dev->dev, "ack timed out\n");
+		mutex_unlock(&npac->req_lock);
+		return -ETIMEDOUT;
+	}
+	mutex_unlock(&npac->req_lock);
+	return 0;
+}
+
+static int npac_delete_rule_ioctl(struct drm_device *dev, void *data,
+				  struct drm_file *file)
+{
+	struct npac_device *npac = drm_to_npac_device(dev);
+	struct npac_acl_offload_rule *rule = data;
+	int ret;
+
+	dev_dbg(dev->dev, "delete rule ioctl received\n");
+
+	mutex_lock(&npac->req_lock);
+	reinit_completion(&npac->ack);
+	ret = rpmsg_send(npac->rpdev->ept, rule, sizeof(*rule));
+	if (ret) {
+		dev_err(dev->dev, "rpmsg_send failed: %d\n", ret);
+		mutex_unlock(&npac->req_lock);
+		return ret;
+	}
+	if (!wait_for_completion_timeout(&npac->ack,
+					 msecs_to_jiffies(NPAC_ACK_TIMEOUT_MS))) {
+		dev_err(dev->dev, "ack timed out\n");
+		mutex_unlock(&npac->req_lock);
+		return -ETIMEDOUT;
+	}
+	mutex_unlock(&npac->req_lock);
+	return 0;
+}
+
+static const struct drm_ioctl_desc npac_drm_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(NPAC_ACL_ADD_RULE,    npac_add_rule_ioctl,    DRM_ROOT_ONLY),
+	DRM_IOCTL_DEF_DRV(NPAC_ACL_DELETE_RULE, npac_delete_rule_ioctl, DRM_ROOT_ONLY),
+};
+
+DEFINE_DRM_ACCEL_FOPS(npac_fops);
+
+static const struct drm_driver npac_drm_driver = {
+	.driver_features	= DRIVER_COMPUTE_ACCEL,
+	.ioctls			= npac_drm_ioctls,
+	.num_ioctls		= ARRAY_SIZE(npac_drm_ioctls),
+	.fops			= &npac_fops,
+	.name			= "npac",
+	.desc			= "NPAC Client Driver",
+};
+
+static int npac_cb(struct rpmsg_device *rpdev, void *data, int len,
+		   void *priv, u32 src)
+{
+	struct npac_device *npac = dev_get_drvdata(&rpdev->dev);
+
+	dev_dbg(&rpdev->dev, "ack received\n");
+	complete(&npac->ack);
+	return 0;
+}
+
+static int npac_probe(struct rpmsg_device *rpdev)
+{
+	struct npac_device *npac;
+	int ret;
+
+	npac = devm_drm_dev_alloc(&rpdev->dev, &npac_drm_driver,
+				  struct npac_device, drm);
+	if (IS_ERR(npac))
+		return PTR_ERR(npac);
+
+	npac->rpdev = rpdev;
+	mutex_init(&npac->req_lock);
+	init_completion(&npac->ack);
+	dev_set_drvdata(&rpdev->dev, npac);
+
+	ret = drm_dev_register(&npac->drm, 0);
+	if (ret) {
+		dev_err(&rpdev->dev, "Failed to register DRM accel device: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(&rpdev->dev, "NPAC Client driver probed\n");
+	return 0;
+}
+
+static void npac_remove(struct rpmsg_device *rpdev)
+{
+	struct npac_device *npac = dev_get_drvdata(&rpdev->dev);
+
+	drm_dev_unplug(&npac->drm);
+
+	dev_info(&rpdev->dev, "NPAC Client Driver removed\n");
+}
+
+static struct rpmsg_device_id npac_id_table[] = {
+	{ .name = NPAC_RPMSG_SERVICE_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(rpmsg, npac_id_table);
+
+static struct rpmsg_driver npac_driver = {
+	.drv.name	= KBUILD_MODNAME,
+	.id_table	= npac_id_table,
+	.probe		= npac_probe,
+	.callback	= npac_cb,
+	.remove		= npac_remove,
+};
+
+module_rpmsg_driver(npac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NPAC Client Driver");
+MODULE_AUTHOR("Jaspinder Budhal <j-budhal@ti.com>");
-- 
2.34.1

