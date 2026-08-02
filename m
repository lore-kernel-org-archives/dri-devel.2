Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E01C55175
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0325510E47A;
	Sun,  2 Aug 2026 22:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DSWqM7bD";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S9mCC7NG";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B150210E09F
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 15:43:26 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672EZ8AN1177425; Sun, 2 Aug 2026 10:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wdqgF5rNqKUjCPEvEn0dAHVAJeDGM00Q2pjqxzlMd
 UI=; b=DSWqM7bD+qipJKmeNa1yIbN2DImXpNqVpAEHj8D6X76EPZuT6bcg8XI7I
 FtJ0DctgEpc3bZKnzkA40HFKSTP2tdCFMSTTkTF1ZXbBC5Pk+jqxMgxWHdRWwydv
 Aq1hMeG7re+aJ3mginVvxC512WxqS0d0AhTR0NX45SK0avRQeqPQ8s6ktbo9a+qf
 wmhB90sKdRpTPHDGJowt3qUSMcP0MC3apUzFIj6EzfSf4sOZU4hxgnYFiN7oxg2f
 I/BrJAQHaf7EmZ8vK7X9fs/0C4Qs6tcXx2jApMu8+vBU4RPQhCdaE18L0dHB12cO
 JuQIpr925sLcpvIKMNEqcwAKDohjQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fsyxphbc1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 10:43:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+HqVPN+VLK75czsMJX0HSXtYtBmqdMmsCR8uddI4LN89bpaPpiSyzKW7NGrL7OZmaRB3ltXGaSWfK8+zKGJMBqd+ngbTQFXi/QXHgyIDBwsG70f3uENp8bFinWGTI/qE5BvpIBlZ5ij3dMnxc91i/Nn9TrHM/n0Lbvm9vZu4I6kDd9B4/+sP/V4at4LjfvL1KviUqbZKsHqZJ/faHjx/Cn0UxCr2MWROnKYtHDwOZO0UOQpJ0aBMQXt5rcAwN43a45Qf7638uQO0yOwaj4hl3gakkDz5WhxO7N4oCNx1Lrq7+z6G781rxyL32ufSgw1O6evAAmQZSd84/zMrwcvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdqgF5rNqKUjCPEvEn0dAHVAJeDGM00Q2pjqxzlMdUI=;
 b=DmVGeReIXSQCXsznBKFGynsPN6OPhMwvghouMO4XXy01ysdkSslsa+eTHlDeXuoB1R3ARQYnLjtcrUABq99JyUJOX+VpUlnWIq4fcGf199ppleysINDInY0u7GjokPOZUlWPbE0EcuuKX5Xp1yoNp7e2RqoK9TvaB5HA57G1e96w+bf9CdAxQ6f0UeAiShTqRhLg8p3FhL6wtt+QFCKxhXK4Iqofn2sNOstP9fUDVLbFTwBRVN3mKDqIs0b62xXP5Y8yrsNPfkAkdhg+YEb1DeC7HmakN4RiC8/hpel7wAYVwo+lKXyKqUgcntuv2K2Uxaxb70lSwpPfLEQeBwhWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdqgF5rNqKUjCPEvEn0dAHVAJeDGM00Q2pjqxzlMdUI=;
 b=S9mCC7NGObTdVEn6CT8AoIRS7dihr9KiQqcSYLpRCRiD9To+608pyG/H6+qRWWX53ngpGoaIgH2R5hIMGnOF00FYKZP4t+T7TDI2DQ8HSy4jg+AK/aHL6YJsTZrqVVDJTn90OEfGSgmEO/YyNDnHZT7fLXFYm4i/Pb9Pjpq21mo=
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 15:43:00 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::ad) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Sun, 2
 Aug 2026 15:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sun, 2 Aug 2026 15:42:58 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:42:57 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:42:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 2 Aug 2026 10:42:57 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 672FgZ15897228;
 Sun, 2 Aug 2026 10:42:51 -0500
From: Yashas D <y-d@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <tomi.valkeinen@ideasonboard.com>,
 <r-ravikumar@ti.com>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>
Subject: [PATCH v6 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
Date: Sun, 2 Aug 2026 21:08:25 +0530
Message-ID: <20260802153825.1570435-3-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260802153825.1570435-1-y-d@ti.com>
References: <20260802153825.1570435-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CH0PR10MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcb8320-6c2d-4da6-d5f7-08def0acba62
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|921020|6133799003|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FJkrWAfsmQLgvbAhgzIoVjDcYJSAmU5ZAzDtG8VbF4Py/ComxsEq0b3XOA4ol2oaBCa5qX1ASBLPRFfp/As3K0xBdNOZReycvSGI8bmCorhGGbDEGdRvOXjjxxYwOEjGPXeL6wvenRPyKN6VoCmaQq221YODbPpH0UCWshBgcAxoK5eJnp+TNlP67nBqoxnddLYSvtHdj8ABDOs96LTgSNYidtg9xxus3p3kViwD+Y+OHkpSAWX2FMiE249emaSObQKtrG/mIpYRpghP5K7S599C+nJBeahjtlcKYzGDXKfqoaVU2HSqGatmcfblsNp/lNnBvmdFgvNb2nS0twU2AvllMYZmFlzIe4wmwZxrttFuINp34lpWQaodKVHAB3K7Gww6alSZQRtRT/60ThtLhS8zLtFPJukEJ0BKDqepfKLoMS/zvA3DE7Gp7rbKPPe0mBoPke2+AcMVRV30u7Hu4rwXoVOd+7OoaCna4w+cuQHECHgj9uR4Sy4gpQDmwcWT3qoWe0IN6uSBHwQC/OSHRoGJwRpFn3D+es0HnMHwsa8gVguUIQBaPv/zeYPkS6F/T3lQ7VjvEeUCjk11wm0ZFwDkzoC9+obNTXQnqlZ+tHvdTmdVHPny66JnVUD9lS/Mx1e2Y/u2kO0qozf3Yha+yBumZPxipN5y3mvcxkfpzPtKVdiXonM2kNwI7zA+FZLoFu9KRTM2yJS4wgmsrcgrBKzj6CQQwSw+t5GVpRF/rlx411zHr2ME3dfeLR15YD2S
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(921020)(6133799003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SBp54BdY9Ksu05vaV4JkJA0kfMi+RrICsrHwEeyB1Myu4Dv0qB3yePsi7mcdrOa6q+318+Bsh8tQJ8F65NaMNg2RYRzdEHOyhwmqgCYVBErVVr0DTvkhyWv2LTC662A8jmVtHZA86SMuMxOUGPaPPXyZTNzuwLlE7oRpT24xVugDPNc4bhY0nDkZg+eqcBrTdjbqUbFARuG4q2fN2SObdyjkJNX1vO0kObZk/01Wkd31I1SvgakhIBZgSnJwKXvJ8ri5D/5dWtduu45iLnUQvPVG4k0tnKO+HEAqWnOzZE5nLTUAPEHYNjLVwq/B8OEOd64q8lL0uH93u2KL2hEivg0wGX3G1p0l7Cu63KG+GgbM0/Vi8oZdC/PxVeOiiapbpHoSKOctQ+YpwQn4OvGLi+ufqubZUgTk2FtYAf2ZZVMDRfe3xH8usc67svY1GQFq
X-Exchange-RoutingPolicyChecked: MuvoXZjmWpJ0FpxY+htMn89Cg8kzIZtztL0tTVPCVHzIedbjg6SrroMqfEwFhhO1Jiw7HyiMZlaX7HneFPnwlew6RQkJ5ishxUHXBdyVoN6Hg50asszHHWT3euyK9ghqlEFKZcoqh4aLxHjZraUjtWCT1RZRgarm7DwnfXXnN1fjRLix74Aeqbqz48mJ6WbIvRvIg+DRMpH15QClTgSx88He9A53sbfjr/i5B/mX4oCYQipSVj6TLKvyBHtfK/oo3UyFhfW2KdfqRGAZ6W+Pqm2ZOYgmkvEZH6mFIYAsv02JH4UlFsB0RE2mdcMcmde6RJmyOizudJM5O5bRSvc+Sw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 15:42:58.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcb8320-6c2d-4da6-d5f7-08def0acba62
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE0MSBTYWx0ZWRfX7zoqfJ2quBVd
 b+u6dBIT4h/EopFieMYyNu1gBkHnEOVMa1TntEM4Nf4EkZe4Qg8imZyJ2ikcQJKnfnE1pjVFdgx
 Lk4YLFHWdX6DAx7SDreFqsRgpPpZVUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE0MSBTYWx0ZWRfX+ty0iqXUk91p
 iPpDF5j+VSQZjXyupjcLoXqNnY/+Jg/cIgNceM4wUePdp7UAJrC5scwTQ9uGZnXv0gFElxAGQDU
 i2pI/TTLcE6tcPDYfFHsjnvEHtbPP2dwhnaiSZDVoIR7nCoiqhyuk+Ad/OLMe0HUkQzxVO6UgTm
 iO3v6zv8jiJbPxPAaLoLq7LUS28XIrazjQpV8hAgrRSCtrxMXRUOF3UofpmksDIXyEicYDfN/CO
 wgMhXynWTBWrZ9CegayD7dyqKVs+XJMpNSjGjq4eXj12wpcWhCvrqw8UHkpp0e4YYsjZilkGmdP
 4ReyGX4RhChLgM4ZOQ0z1+PYJhsUNgYMSbXdWbnIXxFW/lhlECKS/EMdcSosrzf6CxM0PoOW0B2
 ZwDtkkfDbIcbM+DzL27+RvPJ9MnU3MhlaXKOr6avHtuym4UsaXjB5gQMmzfuOpW4PX5l93Zdr7e
 l6PZzdRq2tFuBFityQw==
X-Proofpoint-ORIG-GUID: k3PYeYnjffnGPmajk9E0Nbws6aEx00Ua
X-Proofpoint-GUID: k3PYeYnjffnGPmajk9E0Nbws6aEx00Ua
X-Authority-Analysis: v=2.4 cv=Pb3PQChd c=1 sm=1 tr=0 ts=6a6f6588 cx=c_pps
 a=0CigaX/e8+d28YZ4T1vruA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=8m6jy30CiBRjHBHqTgAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020141
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

From: Rahul T R <r-ravikumar@ti.com>

Add a 'no-hpd' boolean property to support boards where the HPD line
cannot be used for hotplug detection due to hardware limitations.

On TI J721S2 EVMs, the DP0 HPD resistor is not populated from factory
(DNI), so the HPD signal is not physically connected to SoC pin AA24
by default which makes HPD unavailable but AA24 must be in DP0_HPD
mux mode for the MHDP firmware to operate.

When this property is set, the driver uses auxiliary channel (AUX) DPCD
reads to detect monitor presence instead of hardware HPD signals. The
DRM framework polls the connection status via the .detect() callback,
providing hotplug detection without requiring the HPD pin.

Valid use cases:
- HPD pin not routed to connector on PCB
- HPD signal muxed with another function on SoC
- Hardware designs where HPD cannot reliably detect monitor presence

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 79 +++++++++++++++++--
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 504a3186ebb3..ae9bbec855f3 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -53,6 +53,8 @@
 #include "cdns-mhdp8546-hdcp.h"
 #include "cdns-mhdp8546-j721e.h"
 
+static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp);
+
 static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
@@ -698,7 +700,9 @@ static int cdns_mhdp_fw_activate(const struct firmware *fw,
 	 * MHDP_HW_STOPPED happens only due to driver removal when
 	 * bridge should already be detached.
 	 */
-	cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
+
+	if (!mhdp->no_hpd)
+		cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
 
 	spin_unlock(&mhdp->start_lock);
 
@@ -739,7 +743,13 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
 	spin_lock(&mhdp->start_lock);
 	bridge_attached = mhdp->bridge_attached;
 	spin_unlock(&mhdp->start_lock);
-	if (bridge_attached)
+
+	if (!bridge_attached)
+		return;
+
+	if (mhdp->no_hpd)
+		cdns_mhdp_update_link_status(mhdp);
+	else
 		drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
@@ -788,9 +798,14 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
 					  msg->buffer, msg->size);
 		if (ret) {
-			dev_dbg(mhdp->dev,
-				"Failed to read DPCD addr %u\n",
-				msg->address);
+			if (mhdp->no_hpd)
+				dev_dbg(mhdp->dev,
+					"Failed to read DPCD addr %u\n",
+					msg->address);
+			else
+				dev_err(mhdp->dev,
+					"Failed to read DPCD addr %u\n",
+					msg->address);
 
 			return ret;
 		}
@@ -1523,6 +1538,19 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 
 	spin_unlock(&mhdp->start_lock);
 
+	if (mhdp->no_hpd) {
+		/*
+		 * In no-hpd mode there are no HPD interrupts to trigger
+		 * detection. If firmware is already ready, do the initial
+		 * AUX poll immediately. Otherwise fw_cb() will call
+		 * cdns_mhdp_update_link_status() once firmware finishes
+		 * loading and sees bridge_attached is true.
+		 */
+		if (hw_ready)
+			cdns_mhdp_update_link_status(mhdp);
+		return 0;
+	}
+
 	/* Enable SW event interrupts */
 	if (hw_ready)
 		cdns_mhdp_bridge_hpd_enable(bridge);
@@ -2012,6 +2040,16 @@ static enum drm_connector_status
 cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	bool hw_ready;
+
+	if (mhdp->no_hpd) {
+		spin_lock(&mhdp->start_lock);
+		hw_ready = mhdp->hw_state == MHDP_HW_READY;
+		spin_unlock(&mhdp->start_lock);
+
+		if (hw_ready)
+			cdns_mhdp_update_link_status(mhdp);
+	}
 
 	return cdns_mhdp_detect(mhdp);
 }
@@ -2100,7 +2138,29 @@ static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp)
 
 	mutex_lock(&mhdp->link_mutex);
 
-	mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	if (mhdp->no_hpd) {
+		u8 rev;
+
+		/*
+		 * Use a side-effect-free capability register for presence
+		 * detection. A successful AUX read means a sink is present;
+		 * we do not need link training status registers here.
+		 */
+		ret = drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, &rev, 1);
+		mhdp->plugged = (ret == 1);
+		ret = mhdp->plugged ? 0 : -EIO;
+		hpd_pulse = false;
+
+		/*
+		 * If the monitor is still connected and the link is already
+		 * up, there is nothing to do. Avoid falling through to
+		 * cdns_mhdp_sst_enable() on every poll cycle.
+		 */
+		if (mhdp->plugged && old_plugged && mhdp->link_up)
+			goto out;
+	} else {
+		mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	}
 
 	if (!mhdp->plugged) {
 		cdns_mhdp_link_down(mhdp);
@@ -2288,6 +2348,8 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->aux.dev = dev;
 	mhdp->aux.transfer = cdns_mhdp_transfer;
 
+	mhdp->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
+
 	mhdp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mhdp->regs)) {
 		dev_err(dev, "Failed to get memory resource\n");
@@ -2360,8 +2422,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->display_fmt.bpc = 8;
 
 	mhdp->bridge.of_node = pdev->dev.of_node;
-	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
-			   DRM_BRIDGE_OP_HPD;
+	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	if (!mhdp->no_hpd)
+		mhdp->bridge.ops |= DRM_BRIDGE_OP_HPD;
 	mhdp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
 	ret = phy_init(mhdp->phy);
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index b53335b0d22c..24ffb732a207 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -388,6 +388,7 @@ struct cdns_mhdp_device {
 
 	bool link_up;
 	bool plugged;
+	bool no_hpd;
 
 	/*
 	 * "start_lock" protects the access to bridge_attached and
-- 
2.34.1

