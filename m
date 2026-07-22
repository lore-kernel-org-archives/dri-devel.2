Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAE5C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE32010EFBD;
	Thu, 23 Jul 2026 07:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="X+JQwMyn";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14AD10ECB7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdT4IHGD8dBIBgVBa+u6YBuJxi5XIn70nOmCEnfI1dnrZSK0pyrm4LQnZi7QPszx41QKMtM7+JvHb36B6PZ+y6DTQcvmJ3aL+erjdYzoVGxUcmZdBTvKvdHwBfWwwS7wvvBHRvskNmizYH1l8qFNcKo+eGuQ1TDuAADiRCtNQsY6o0vObpOYCd06OgQDA7tXPP27zGGioMLD+qibNd1tvbjrgyXR57cKNoWVdxL15aBt0+ZleYFJk0HPVdvH6S24fnvGoaDK5k4nxwkMJrqo9IZwRtBCWoKMAaBcPKRuhnSqdAn4hcWfFYrptO54KoGB2m8YidbrFenbc6scJKIWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0sL6d+owm7UCADur1L+TPX89skmLLCPQay4ZUrau8k=;
 b=NbER2UbjQfUa8jsgdiddG/JJuuqv+74CmG9W0KMNqbbMJqZErucBnEBk+MlQtp920RRZmVPuQT2ALHEvmbhgNQJ5ulw71YYfwtwJVDvEtXkl6bfH2Xb2OgQsClyOmAvtjiKsRaRU9BbnXNOgxYdGvm12VRs5nd/ZZ0+9BVrqH1lKd8g/l3efrhcLoTyWITVw91gcxVhy0dB4CaG8XmqflBFT6ginOYt7HURfVi5M9pqlnXvvDyzhZKpIlzVB+nQv0v8BXL9jihfe/cSjI3Enn00fJ4dJhKhJPo3fTfmQ8d/XuYQOn9/fxL21YVjaPCPmjqWVQHhAQ+27lUvHpJN2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0sL6d+owm7UCADur1L+TPX89skmLLCPQay4ZUrau8k=;
 b=X+JQwMynN9v4gaaff4XmQgnI8uIrp20AC8kl7vN3HqC8E11vylfjLYzVVU3JM8IpFyvGr1k8NR4tdpwOuD88Y1h/rK6H5/3y5uKPSXbHY/mRpb7BsR2zxGElmJPXYURQ9UBIoPoPwD8pkC63vjV+UjQ7O5nMkAQjN3R0NmMpPuEOBEdbXlHI6QVELd1JOWC61N0nezNOWT8KJ0So9JBBbNKA3feTOAlkwu3G5U8KQowNFzQTSNXdyGHkSaP1HIKS1zSwf/zJS9G2InBmrq3+lLSj+3KMXbXlK7TpIXJzIwa9JVhSOILG5QIvtTKsrOqRVQXxm+lzutM1fxkED9eaZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8492.apcprd06.prod.outlook.com (2603:1096:4:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:20 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:20 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>, Kees Cook <kees@kernel.org>,
 Pan Chuang <panchuang@vivo.com>,
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/7] fbdev: mmp: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:41 +0800
Message-Id: <20260722075803.570532-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722075803.570532-1-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfc7bb3-24c7-4686-22e8-08dee7c6ff10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|52116014|366016|38350700014|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: HxgFNZwqs45KQHTOOIC/Zq4tAH78M2zCP5/ffIpUedhtuX0RQjlYbxQG623TJasc7QyOvGmuMNrR0KztNdbISUIHOkTV1NUjpn8L+dDka9gP0pqzhPVQ2n5zC/ZVHHqwSaDklW8f145DL21h9WEanHHO2uwGBDGMjuNdSZxB1ZZnZJW20hxYChCGhMZrtHnF6xXUrYi9l6NOeNkSDsVxHeUb7Pc9a374vo7OBtltBDWMyPwjvhsTzSy0iJYJ2CI87pRVXLCp7qwU/VOODE2zuqHjmil0DB+/Mjnp49sKVLGLFexvoJtbf6GGHoK79mCmysw9uZVB2aBjrI8vknfxWvVi4jgS9FEN3aVT5ce9iT/EqMEzAWzmGoCT31VSpF+MLi3qtv1BjV9jMcsSqbbQQlY015wj7fUu7wQmziyk1OmSeP+47+wPCyd8yeHiR+W06yhPUOjMjW/R+Yd8/eNrKdHIL1NPVK/N7jsuvnBD0QcxB+C7Ea5LbZmx21ROtWHxjg+C5NXOswCZpXUhDysw+Dcoe1tBClX1nO2NpOm3Pqf9cftPFQwMbyPIZEHtBwjH63ocYotDOhStk68t60Cp1HCiVcIkRSn8GX67Cz7erocT7FRT+OijXoz1RhB4lwITJMgHXe68+Z2V/ZMvbVWiVcExEQXN6BEOV0Tr15yTI4JPAoGw3QXYOrt2yU6j18lvu8FLbgc5EjLBdDW9JRiU2szPl84+greA/sITBFoXabs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7l7Pka9IAabPjo3RYpYPWoZ0K86nDcQcjDmMV5vnUq6qT/rSqlcDLB7Nu5F?=
 =?us-ascii?Q?EBpOJo2mOHeikENgpsiDJK7ja1D6r1wuxxL4lfn7sGi4BTVri6B5cNm77dDY?=
 =?us-ascii?Q?vY56cbL7mekwBehEIlSf8KiKF1g2i1/0g1qQNZ+i5PeVAWX0Zi4sfcy4ZOUj?=
 =?us-ascii?Q?oAuEaAoJK3Aav13MvmkR5iPr/zEWpEqCjeMSIEaPYqZifP+6jV2aB9o7qWF9?=
 =?us-ascii?Q?8LI5UXDuo8/a1epB6F+mzRkROqIEC25lLwyVAzeKy6EnLLuo1GnAbi8g9rWD?=
 =?us-ascii?Q?YXyrCAeA+gTXj0YRZe9SWNQ7DfK+3/O3Hhi22MCaCAvwEpMEyPjLwsr7GFVA?=
 =?us-ascii?Q?6sWABv2VEmhbDDkruPsw4/c78OZR+xtKmTcY68bVONsjXoGL58K/ELzteCso?=
 =?us-ascii?Q?ODF2Vodhdjc/tjX0qThF5o5zW04Ps0D6WADXugipuiJ6irfj40uhXQwHKudd?=
 =?us-ascii?Q?keXw47hFiARC9OU+hMT/EjqAINcKp5m+T9BfmPr4oAG8uJbcD58jY65JVI1R?=
 =?us-ascii?Q?krX+v5fU8A6ae1+RmxHzYrOlBOs0e6LP3lvyc2/nx1yqthajH+g/rh/tVyqF?=
 =?us-ascii?Q?zis087Yp+eQY0a1KmBYZDeC1iDYjr5xF9UE04ocMvN14mQVjxtDuJjFwxCPR?=
 =?us-ascii?Q?f4TcCDfKUEyDnpobygW3rV3dvqdjK9hgDFe64NWt/xNJhL3yeu5U+52s6HKy?=
 =?us-ascii?Q?zu1X5mRVOy91jCoSOKE3KpJze2dugV9B1Ij+56ZJmbi23YEgjdCBBqxDKX4G?=
 =?us-ascii?Q?HQVVOYWiIXhKgv00b4TuN+3Sc3/zZDusFQLPOX/9UuSztNe2h/FTUKqa/48C?=
 =?us-ascii?Q?qx87wMvU5BUfDN4pBl6oC8NMGfNMzAd6mxuC/ahCmJD5kGCiit8VJc6x/ZaG?=
 =?us-ascii?Q?tjX4VvYEXtQdUbpR+9NnC5OVQR1wR8/UcahbgF0HRfuh52fWeYxhxU1WUQL/?=
 =?us-ascii?Q?+eUtz4ZJ6iFocRyyYHlNEXP5Z1/NZFBOy8fweW1/+u01Rsjq5OR1wDYzqwZ/?=
 =?us-ascii?Q?N6xu6NNMVMyVriYtJeeueeudGAt1/apqDHgwUQPt50Idx/2dbs6n6fUVk2f9?=
 =?us-ascii?Q?h1hydS4KMMn+wVF6Bwwe0gRzcN4iq13YAnGoDJ9Q/vfdRTdDG6PF9Yu9ojtL?=
 =?us-ascii?Q?uraFq9u9ySsQsbZjivokrUp4mFHe1g98GFJa9cnBOxGRBdu4uSs3MgooJ5/6?=
 =?us-ascii?Q?HVACeyqt7gZKTn5Dv6uvTcItGr57tVBQPllgv5tTPiAyHJ36FgT0apF9XbCS?=
 =?us-ascii?Q?aR0w5oicMA+8N5eRVRSDbaI42hdYUc9ar4T07rDZIDxvk9PJv4rTAekXkWKs?=
 =?us-ascii?Q?dl9fNZSRATkLmJJSFn6sS5L8W6xLFuFHoD/sr9GdZR2b1OLX3jqFd6++erub?=
 =?us-ascii?Q?IynnIUlLQ05Fh8tB4EUPsLg/220mBdIbt6mParD0gsz3ZIiJnvJge3RNdU2j?=
 =?us-ascii?Q?ZTE0iKX+ZMy2PgI+WYGjtXVWFsHSEyd+9CoTRgQ6tCAgdn/hiHHo2VqrFtmv?=
 =?us-ascii?Q?DOiVPyQz1siePjmnogxsBbDaZlYf6/zwQprHRAQJkyC+yJSDKd1ZWYZvEVAz?=
 =?us-ascii?Q?njXuZCmfOR8BOnDDgV+75jq/ltd/R3rHx27KgN4/bhgsT20k5+E1UxVC2D3K?=
 =?us-ascii?Q?m+PvYMMx/pJV2Co3UuuxLPIMMqPwvBi8V2FbOA35iaN70FPhPFtODPdSv8LL?=
 =?us-ascii?Q?HPMxgQBXjL7Tg6ug7/PK+427fKbWJs6bjX87UZNKAMVwEbiKcD45ffVU69Rj?=
 =?us-ascii?Q?+ShWuDOb4g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfc7bb3-24c7-4686-22e8-08dee7c6ff10
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:20.3924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXc6Fui1IXXZIGCxURoIe3X463Gn2bsuQfpZzVmsGWxLvdg/6HKOqeuZukXCghYyX0NOsAQ6Jv6sBxc2FIu3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8492
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 75bbdc0b4aa6..2c457da67a9f 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -505,8 +505,6 @@ static int mmphw_probe(struct platform_device *pdev)
 	ret = devm_request_irq(ctrl->dev, ctrl->irq, ctrl_handle_irq,
 		IRQF_SHARED, "lcd_controller", ctrl);
 	if (ret < 0) {
-		dev_err(ctrl->dev, "%s unable to request IRQ %d\n",
-				__func__, ctrl->irq);
 		ret = -ENXIO;
 		goto failed;
 	}
-- 
2.34.1

