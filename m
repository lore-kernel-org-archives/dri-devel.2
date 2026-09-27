Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B441BC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9D810E674;
	Sun, 27 Sep 2026 18:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RaEWhoQ7";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G3587KgM";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FB710E674
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:26:07 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R8qHcN3707378;
 Sun, 27 Sep 2026 13:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=dg8DtLXHvDQpJJr0G8Yvu35JsAsXg1SiOlpe3Gy/7
 Jc=; b=RaEWhoQ7K1EzVyU/zbI4+t3sjS0rPN1ATLUUEH1CeWHil6W6S75YXyEpl
 gk6+sBsWRgHHCuFR4zN1kTsdyblsIAtvu4gW3hb32f/35nGi5PnWvnMHRMrF/7UR
 YZ+6Jy8sqM4MHp238yHyHLHwcL7jJYPwQpOBd/PYwHGjQtsNeJnBpif1HnvQmP5u
 jdaNMgSovMdsTth1F57ybcVhEm0K0xG3n+hu+BW46UxOdha8CFkB1otiSu1zrtSz
 YKH5rhuB7T4QB37IiYbiLc5BjqG1vuNyHObTiG0Sea9mgMOiqbudK4OiavCSi2X9
 GrLSGj0k+IxQJ+YrvafHWY4/8/lkA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gy00n9hsn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:26:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXK6+yE3prKNqYeS1AXCDnUHwq+buDtEQ2VFz58P7wp2qCHR4cht+OT/FgmSn2O4GuHjkZMNa9gSIuD0SLR0IBMT0LP1LpKlFIPNd0ybEzpVI1eIIAfn9nMOHncDzBIXrWVXO+TIwo177dFPN7sV1dVHln9hF1jppFgxhOoruqryoIzhHIq2Dotox31T+aSGjFc0kcA7lNBAbiA6uPXJO1N7N9BOyJfR78rK5BJrHDZZSBSEOxze+r9jAlCefSpUdSULmqhsEMV5cURAUh1/VyuH/DaEW/0Ndbdd1tbMNFkhNh2AG0ab89bkhYOJdOVFGXVDdAlqopl6hq8Vw8Dfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg8DtLXHvDQpJJr0G8Yvu35JsAsXg1SiOlpe3Gy/7Jc=;
 b=JXdVFoIpxtNV9h4jAcM4MUptXhkVkySQME3pQWKZ9Ct+YS7fmBlCwpeaMhblRdzFXF5LLmB/HzviPOE/Ihof3vhMzSV6BI7utYYwdgZ7vcbdvMoQ1W5sjuCkrXZ1izEus0ZcqID89ETWqExyrjGRZSg+CisO7ekdTw4ECCl7AehYXKk5wM27Q/leqEdD74TLid0fTuvGxDspzyMhvCp4q1w0UyZs1XuV06/HxGF8bR8hG4niVqYJieGIOXjdw0QAr9t5DPDCCK9rQ1qFeRvkYbF08yvKRMs//QcuwuM1K5nc9tqgSWl6ZD2dN1TC+9OJTlsTbRZpTub1qFbcl2YowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg8DtLXHvDQpJJr0G8Yvu35JsAsXg1SiOlpe3Gy/7Jc=;
 b=G3587KgMp1gDqWU96QWsfRu4tjT8PLhI5yrltASjC8kIo20+TYSHM0bjof1Qe/zvjmZxHrEZUaGihI8T/3lKpQiauC4gjZmVPCc7WLKv+ewJykbfbPkEQhRhsltEwAMGTvEveEurSUuVFkAYiq9lWeso8Cng60f7J5VKrEd5llE=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Sun, 27 Sep
 2026 18:25:58 +0000
Received: from BN3PEPF00022BBF.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::8e) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:25:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF00022BBF.mail.protection.outlook.com (10.167.248.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:25:56 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:27 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:27 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPQwJ1629628;
 Sun, 27 Sep 2026 13:25:26 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 07/14] drm/solomon: ssd16xx: Add power management support
Date: Sun, 27 Sep 2026 23:53:22 +0530
Message-ID: <20260927182329.4193961-8-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBF:EE_|SA2PR10MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bac5d6-4ede-40bb-8971-08df1cc4c5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|921020|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 23+2qvapidDbL9v2ZpLmnP7AVTtBpkAUWH5BhJEkeRHMSsPx0MC2oHG0Hm0pt6f7c13wqoPTx6RtyAfFHwf0Q5k/QQFzkoM6w2udDb7JZVPu++4s5D9cAdUb7NRi2Xf0NybHSskACpCJYd017Lcme4aYBsxrv7KpYnFJJoyRcysYaMKHFBQJ2M4iy2PRiNruIaL2n5BdYp4YPfpLOCM2lYoxbSSCwoXUCI3smIeb3AeZpPrTG+jLobxtY83k6j4DBLnOppQoBgJLlMMmk4H9mCTpB0UBa7fRYVGsRjxlw8nCtDBmb0AsbofTI0KTW6bqkl1CLDtyUIFCix3GWjfTLk1it7HAWErkDSklECtUF10Gr3GrWF67jxbDf5IK6mATU11oMRHd/JJ8by4PPfgn+PbT6HK03wRRv8898WFH+VVSiOBJ1ji2ezpB1DwpDh+lyD0F/NsmmvY4Tt0M699xGEO7vwG67gRIb6sh9lAK9Iy2zMrNlYCma67BfXTGZadBBNAJnPhTFWFVzQrYKq+gzhoa3VC7Duwd9VWMlUlKIiUmmo5sMh7q0HsD4A59jWfMQkU0DxnK5jUf66O4qVmZVGe8PXOfZJ7Gw53zApwHRIQUgYazA9aAgtj49xcxIOHh5A3j8uVshMxmqsOeuGoOcWMN1Cqt3hTw5AOYCyoivTXwJ2VfSDaHagAmPjnQAHCCXWgIn1hJiukuaC9GsAR6hlYkRLtkGPyjXtwuLqi07ZwM1SmTChIU0E01XPV2/Gr/
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(921020)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CPulLVjX0PJ2hL+Ff6ZlOqRSAtIj8tsK88aG2rX1ITGCpX4JpKclALmMqgqtLQyVW2IYbCWNqWZAbb64aUNiUuBSjv5N0xUNuWsQufICoMkt0Wqi9xJDzVshehErFu5yE4O9kZJ3lKr8XuUSE6lNA9SHtBM3D002aHqDXfOMQGoJe4pGPo6dqQnDXhMLF50cveA+5zlKw0Z/O9EjyX0KcY6e6v0dqXVOKdqg2l9GGRHb01PUTgkZyncUnrGWursuttlS3V4vPF9fGbZsLHEM7TQgggS/LCRpUrGkScp+LIU6vsUXniQHDoZu9SubsmJVbEGgFBLpPyat4pcac7PMGtdSQy6mS/fFAN3g9Pw3M/ULPpMgsD6ncqpP2X/r011qGkKQ4A+rDiyEWEWqyWCxLpgQS5oqkLtoFE9liRj2VB+omd8B48hSJU2J6E4QTb9E
X-Exchange-RoutingPolicyChecked: t8NfF9ICdYpKLt6+NHvARv7cPQWc/fx8Wo+kUAwcr3OFGBldacG3fm9yys99gjHuma4QT17zTTJ+qA4nVxp+a8DiOV1wb6cIVdLGC00F9jtxNiGxXqh18XGrQSrX6roxRLwr19jLvzQSyDsaSK0lC1DnHjju+MA0aloxlTo/K6Vytm+eDAiVlU6dPRfVkjaK5/AXkD9kKXMzojGiHA74EJkIIl7bzWrJNPy6utRqZGXrIitVK11MpRBV2rhTrlBCQI7SIjeamHD0uuRyAdiB+ueWYSZl2qZcc+A24mA4LhiFxjOvoXGORwKC9V6PIsDfl29aGTsMQIsA7ESI3eDWHQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:56.6239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bac5d6-4ede-40bb-8971-08df1cc4c5c9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-GUID: gMh6Ae00mOupYBNPik8OMURIcrtzFnWt
X-Authority-Analysis: v=2.4 cv=fKysTpae c=1 sm=1 tr=0 ts=6ab95fba cx=c_pps
 a=uYXQfM3GD41LpGGBCGkGnQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=qtjW0_A5QSDpLcJLBZoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gMh6Ae00mOupYBNPik8OMURIcrtzFnWt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX6ZamKgH+EhjT
 ZeshNlMqzW8KS42M5GbWuP5DDWY1bMG29AKfiO5FpF6ixc78zYqxLNFfJhkkVDW0l1crKSbD73Y
 FU4zM0t2/29HJyLF1uPirdrrz/pnUIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX/VYVc2kmXJEp
 lUXIgXPqbb4deCHvFVpI1r13L5v2XvonO22ijXAV9yX4D+4mjW3g9ERHpLFT16eI+NDviYO5DRB
 QPp/lVx56Us3VjWEVedX9pcW0YP3OMXXhD6QvoNB8r3eJB54morGAZ9N1Amjq473NaW6zzf0a+y
 tsFZ8Wxvwa5qNBGoQXxs0APsDqcK/Ld6KKWXv78p89u049d8zoBKE91X7+ucPi3j67x236WCT5o
 HSgnhkPpJPzhsYvd4w8PAIhyFnvqFYYXL1VloH03rYc8jUXbpNHDHtTycGlb9CjvEnAZynSt7GU
 UOHi/DYJRW6GlzNLBI8X5dgB4I/2CLvbdpe+P5q/MxIL6ZITRpdW9vCTsHFPHKdiE8CNW+cyqnx
 RZTHr9c7v9bET/NVzJxbWVK5KEBEIUW9NZNXedeT+Q8pGHrAGbbBh8A5+pGEYOAZOLL3w12fSJh
 gSnkE832f9RnmSeqklQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270073
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

Add runtime and system suspend/resume power management to the SSD16xx
e-paper display driver.

Runtime PM uses a two-level deep-sleep strategy:
  - Level 1 (runtime_suspend after 35s idle): light sleep with RAM
    retained (SSD1683 mode 0x01), allowing fast resume via SPI wakeup
  - Level 2 (system_suspend): maximum power savings (mode 0x03),
    requires full GPIO hardware reset to resume

An autosuspend delay of 35 seconds keeps the panel active across typical
userspace update bursts, avoiding unnecessary deep-sleep/wake cycles.

On resume from level-2 (system suspend), the driver must fully reset
the panel via HWRESET (the only exit from deep sleep since SPI is
inactive in mode 0x03), re-run hw_init, and redraw the last frame.

For SSD1677 where level1 == level2 (both 0x03), the system suspend
path skips the redundant "upgrade" since the panel is already in the
deepest sleep state from runtime suspend.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - Extracted power management features into dedicated patch for improved
    code organization

 drivers/gpu/drm/solomon/ssd16xx.c | 240 ++++++++++++++++++++++++++++--
 1 file changed, 225 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 93fa064cf589..6255f434248a 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
@@ -39,6 +40,7 @@
 
 /* SPI command codes (common) */
 #define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL		0x01
+#define SSD16XX_CMD_DEEP_SLEEP_MODE			0x10
 #define SSD16XX_CMD_BOOSTER_SOFT_START			0x0C
 #define SSD16XX_CMD_DATA_ENTRY_MODE			0x11
 #define SSD16XX_CMD_SW_RESET				0x12
@@ -52,6 +54,9 @@
 #define SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER		0x4E
 #define SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER		0x4F
 
+/* Runtime PM autosuspend delay (ms): keep display active across typical gaps */
+#define SSD16XX_PM_AUTOSUSPEND_DELAY_MS			35000
+
 /*
  * Data Entry Mode (command 0x11) AM/IDY/IDX bit encoding (common).
  *
@@ -245,11 +250,14 @@ struct ssd16xx_controller_config {
 
 	/*
 	 * Deep sleep mode byte values for command 0x10.
-	 *   deep_sleep_mode_level1: lower-power sleep, RAM content retained
-	 *     (MODE_1 on SSD1683/SSD1680; used for runtime idle / app-close).
-	 *   deep_sleep_mode_level2: maximum power savings, RAM may be lost
-	 *     (MODE_2 on SSD1683/SSD1680; used for system suspend).
-	 * Chips with a single sleep mode set both fields to the same value.
+	 *   deep_sleep_mode_level1: used for runtime idle (autosuspend).
+	 *     SSD1683/SSD1680: 0x01 — RAM retained, minimal wake latency.
+	 *     SSD1677: 0x03 — only one mode documented; RAM may be lost.
+	 *   deep_sleep_mode_level2: used for system suspend (max power savings).
+	 *     SSD1683/SSD1680: 0x03 — RAM lost, full re-init required on resume.
+	 *     SSD1677: 0x03 — same as level1 (single sleep mode).
+	 * When level1 == level2 the system-suspend "upgrade" path is skipped;
+	 * the device is already in the deepest available mode.
 	 */
 	u8 deep_sleep_mode_level1;
 	u8 deep_sleep_mode_level2;
@@ -367,8 +375,10 @@ struct ssd16xx_device {
 	bool init_refresh_pending; /* First frame after refresh_mode_init enable */
 	bool first_clear_done;  /* clear_on_init has already fired once */
 	bool display_cleared_on_deinit; /* Avoid redundant clear in atomic_disable/master_drop */
+	bool pm_force_suspended;  /* pm_runtime_force_suspend was called in pm_suspend */
 
-	int orientation; /* Display orientation in degrees: 0/90/180/270 */
+	int orientation;      /* Display orientation in degrees: 0/90/180/270 */
+	u8 deep_sleep_mode;   /* Deep sleep mode to use on next disable */
 	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
 	enum ssd16xx_color_mode color_mode;     /* Active color mode (BW or 3-color) */
 	bool fast_lut_pending; /* LUT pre-load needed before next fast refresh */
@@ -1425,11 +1435,16 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	struct drm_rect rect;
 	int ret;
 
-	drm_dbg(&device->drm, "plane_atomic_update: fb=%p, initialized=%d\n",
-		fb, device->initialized);
+	drm_dbg(&device->drm, "plane_atomic_update: fb=%p\n", fb);
+
+	if (!fb)
+		return;
 
-	if (!fb || !device->initialized)
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0) {
+		drm_err(&device->drm, "plane_atomic_update: failed to resume: %d\n", ret);
 		return;
+	}
 
 	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect)) {
 		rect.x1 = 0;
@@ -1488,6 +1503,9 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 		device->init_refresh_pending = false;
 		device->border_waveform_pending = true;
 	}
+
+	pm_runtime_mark_last_busy(device->drm.dev);
+	pm_runtime_put_autosuspend(device->drm.dev);
 }
 
 static const struct drm_plane_helper_funcs ssd16xx_plane_helper_funcs = {
@@ -1547,6 +1565,10 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (device->clear_on_disable < 0 || device->display_cleared_on_deinit)
 		goto out;
 
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0)
+		goto out;
+
 	drm_dbg(&device->drm, "clear_on_disable: running, mode=%d\n",
 		device->clear_on_disable);
 	ret = ssd16xx_clear_display(device,
@@ -1554,10 +1576,12 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 								  device->clear_on_disable));
 	if (ret) {
 		drm_err(&device->drm, "atomic_disable: clear failed: %d\n", ret);
+		pm_runtime_put_autosuspend(device->drm.dev);
 		goto out;
 	}
 
 	device->display_cleared_on_deinit = true;
+	pm_runtime_put_sync_suspend(device->drm.dev);
 out:
 	drm_dev_exit(idx);
 }
@@ -1574,12 +1598,27 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	drm_dbg(&device->drm, "atomic_enable: %dx%d orientation=%u°\n",
 		device->width, device->height, device->orientation);
 
-	ret = ssd16xx_hw_init(device);
-	if (ret) {
-		drm_err(&device->drm, "crtc_atomic_enable: HW init failed: %d\n", ret);
-		goto out;
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0) {
+		drm_err(&device->drm, "crtc_atomic_enable: failed to resume: %d\n", ret);
+		drm_dev_exit(idx);
+		return;
+	}
+
+	/*
+	 * If the device is not yet initialized (fresh from deep sleep),
+	 * pm_runtime_resume calls hw_init. The fallback below handles the case where
+	 * runtime PM is disabled and the resume callback never fires."
+	 *
+	 */
+	if (!device->initialized) {
+		ret = ssd16xx_hw_init(device);
+		if (ret) {
+			drm_err(&device->drm, "crtc_atomic_enable: HW init failed: %d\n", ret);
+			goto out;
+		}
+		device->initialized = true;
 	}
-	device->initialized = true;
 
 	/* Clear display on first app launch if configured */
 	ret = ssd16xx_clear_display_on_init(device);
@@ -1599,6 +1638,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	}
 
 out:
+	pm_runtime_mark_last_busy(device->drm.dev);
+	pm_runtime_put_autosuspend(device->drm.dev);
 	drm_dev_exit(idx);
 }
 
@@ -1620,6 +1661,13 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
 	if (!drm_dev_enter(&device->drm, &idx))
 		return;
 
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0) {
+		drm_err(&device->drm, "atomic_flush: failed to resume: %d\n", ret);
+		drm_dev_exit(idx);
+		return;
+	}
+
 	drm_dbg(&device->drm, "atomic_flush: reinit, orientation=%u°\n",
 		device->orientation);
 
@@ -1652,6 +1700,8 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 
 out:
+	pm_runtime_mark_last_busy(device->drm.dev);
+	pm_runtime_put_autosuspend(device->drm.dev);
 	drm_dev_exit(idx);
 }
 
@@ -1752,11 +1802,19 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	ret = pm_runtime_resume_and_get(drm->dev);
+	if (ret < 0) {
+		drm_dev_exit(idx);
+		return;
+	}
+
 	ret = ssd16xx_clear_display_on_exit(device);
 	if (ret)
 		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
 
 	device->display_cleared_on_deinit = true;
+	/* sync suspend — bypass autosuspend, sleep immediately after clear */
+	pm_runtime_put_sync_suspend(drm->dev);
 	drm_dev_exit(idx);
 }
 
@@ -2017,9 +2075,26 @@ static int ssd16xx_probe(struct spi_device *spi)
 
 	drm_mode_config_reset(drm);
 
+	/*
+	 * Mark the device active before enabling runtime PM. The SPI device
+	 * persists across module reload cycles; pm_runtime_enable() alone
+	 * does not clear a stale dev->power.runtime_error left by a previous
+	 * failed hw_init, which would cause pm_runtime_resume_and_get() to
+	 * return -EINVAL on every subsequent call.
+	 */
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, SSD16XX_PM_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	ret = drm_dev_register(drm, 0);
-	if (ret)
+	if (ret) {
+		pm_runtime_disable(dev);
 		return ret;
+	}
+
+	/* Default to runtime sleep mode (RAM retained if supported) */
+	device->deep_sleep_mode = device->controller_cfg->deep_sleep_mode_level1;
 
 	drm_dbg(drm, "SSD16xx e-paper display initialized (%dx%d, %d° rotation)\n",
 		device->width, device->height, device->orientation);
@@ -2035,6 +2110,8 @@ static void ssd16xx_remove(struct spi_device *spi)
 
 	drm_dev_unplug(&device->drm);
 	drm_atomic_helper_shutdown(&device->drm);
+	pm_runtime_dont_use_autosuspend(&spi->dev);
+	pm_runtime_disable(&spi->dev);
 }
 
 static void ssd16xx_shutdown(struct spi_device *spi)
@@ -2042,8 +2119,140 @@ static void ssd16xx_shutdown(struct spi_device *spi)
 	struct ssd16xx_device *device = spi_get_drvdata(spi);
 
 	drm_atomic_helper_shutdown(&device->drm);
+	pm_runtime_dont_use_autosuspend(&spi->dev);
+	pm_runtime_disable(&spi->dev);
 }
 
+static int ssd16xx_pm_suspend(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	struct drm_device *drm = &device->drm;
+	int ret;
+
+	/*
+	 * Select maximum-savings sleep mode for system suspend.
+	 * On SSD1683/SSD1680: level2 = 0x03 (RAM lost) gives deeper savings
+	 *   than the runtime-idle level1 = 0x01 (RAM retained).
+	 * On SSD1677: only one deep sleep mode exists; level1 == level2 == 0x03.
+	 */
+	device->deep_sleep_mode = device->controller_cfg->deep_sleep_mode_level2;
+	dev_dbg(dev, "system suspend: entering deep sleep mode 0x%02x\n",
+		device->deep_sleep_mode);
+
+	ret = drm_mode_config_helper_suspend(drm);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the autosuspend timer already fired the device is RPM_SUSPENDED
+	 * at level1.  pm_runtime_force_suspend() would skip its callback, so
+	 * level2 would never reach the hardware.
+	 *
+	 * SPI is unresponsive in deep sleep; HWRESET is the only exit.
+	 * After the reset, level2 can be sent directly without a full hw_init.
+	 *
+	 * Skip this for controllers where level1 == level2 (e.g. SSD1677 which
+	 * has only one deep sleep mode): the device is already in the deepest
+	 * available state and no upgrade is needed.
+	 */
+	if (pm_runtime_status_suspended(dev)) {
+		int err = 0;
+
+		if (device->controller_cfg->deep_sleep_mode_level1 !=
+		    device->controller_cfg->deep_sleep_mode_level2) {
+			dev_dbg(dev, "system suspend: upgrading level1->level2 via HWRESET\n");
+			ssd16xx_hw_reset(device);
+			ssd16xx_wait_for_device(device, &err);
+			ssd16xx_send_cmd(device, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
+			ssd16xx_send_data(device,
+					  device->controller_cfg->deep_sleep_mode_level2,
+					  &err);
+		} else {
+			dev_dbg(dev, "system suspend: already at deepest sleep mode\n");
+		}
+		device->initialized = false;
+		device->pm_force_suspended = false;  /* Skip force_resume on resume */
+		return err;
+	}
+
+	/* Force runtime-suspended state for clean resume. */
+	pm_runtime_force_suspend(dev);
+	device->pm_force_suspended = true;  /* Resume must call force_resume */
+
+	return 0;
+}
+
+static int ssd16xx_pm_resume(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	struct drm_device *drm = &device->drm;
+
+	dev_dbg(dev, "system resume: restoring state\n");
+
+	/*
+	 * Only call force_resume if we actually called force_suspend during
+	 * system suspend. The MODE_1->MODE_2 upgrade path skips force_suspend
+	 * since the device is already RPM_SUSPENDED.
+	 */
+	if (device->pm_force_suspended) {
+		pm_runtime_force_resume(dev);
+		device->pm_force_suspended = false;
+	}
+
+	/* Restore Mode 1 (RAM retained) for subsequent runtime PM cycles. */
+	device->deep_sleep_mode = device->controller_cfg->deep_sleep_mode_level1;
+
+	/* Hardware must be re-initialized after waking from system sleep */
+	device->initialized = false;
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static int ssd16xx_pm_runtime_suspend(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	int err = 0;
+
+	dev_dbg(dev, "runtime suspend: entering deep sleep mode 0x%02x\n",
+		device->deep_sleep_mode);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
+	ssd16xx_send_data(device, device->deep_sleep_mode, &err);
+	device->initialized = false;
+
+	return err;
+}
+
+static int ssd16xx_pm_runtime_resume(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "runtime resume: initialized=%d%s\n",
+		device->initialized,
+		!device->initialized ? " (running hw_init)" : "");
+
+	/*
+	 * pm_runtime_suspend clears initialized after sending the deep sleep
+	 * command.  If a new app opens before the suspend fires (the put was
+	 * cancelled), initialized is still true and hw_init is unnecessary.
+	 */
+	if (!device->initialized) {
+		ret = ssd16xx_hw_init(device);
+		if (ret)
+			return ret;
+
+		device->initialized = true;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops ssd16xx_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(ssd16xx_pm_suspend, ssd16xx_pm_resume)
+	RUNTIME_PM_OPS(ssd16xx_pm_runtime_suspend, ssd16xx_pm_runtime_resume, NULL)
+};
+
 static const struct of_device_id ssd16xx_of_match[] = {
 	{ .compatible = "gooddisplay,gdey042t81", .data = (void *)GDEY042T81 },
 	{ }
@@ -2060,6 +2269,7 @@ static struct spi_driver ssd16xx_spi_driver = {
 	.driver = {
 		.name = "ssd16xx",
 		.of_match_table = ssd16xx_of_match,
+		.pm = pm_ptr(&ssd16xx_pm_ops),
 	},
 	.probe = ssd16xx_probe,
 	.remove = ssd16xx_remove,
-- 
2.39.1

