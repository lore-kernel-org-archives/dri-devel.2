Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9B4C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA35D10E9A5;
	Tue, 22 Sep 2026 20:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="I+q+R8Lo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I+q+R8Lo";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCB510E9A5
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:46:41 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SZ363JuRrlzdL19/08l/6fHtJpCHsoXE2eOJ9bgOmJXZwvFrLfhKbMuUoLQfpIee5AREJ0XP2CZDZASgZ+Ge4/3TTCUWAVQjHJVmIV3JUBxI5D2ezzSyVWULQyTd8JhCUHSQHO+lSJvq8U6OAVTvHvdIwYLOOZRLE339jQ1TjwPUyd7RNgAFK2TjclY6/Kt8zrdAQxSKVhfFCtD9RptQBEfas65BAi4Si0emRUS0/LCuGXSFCJDA4C+FFk/QjuFvRZH5s8AEblCdsmfw/5IoJyYuab+SGKW4j55eBR+gO1z8+gN+/Mj4MzPxqgy6Uc829xoSOFgmCefdB5451dUdPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftwjEK/bo3+C39+dI5Iw22BAIBI7ChOepG6xYbDEm68=;
 b=gHfAXC3cOb2YrBAnUiTk3VFO33/Qr1HeEeqzSwi3sOsCEC0YaIFts8+8uMhkzrQHPGBxfzeqe70sdkPKfg4A45bAHNFNsATuEOJwHOC9t+h5epjklc/k6mfU9ZwCBjrhBp1/+6eqkjARsg2a3zwOZ3MhpBMITPbRCt0ogh863zDxWosotgOSIKc4j7vxaEqZfObMVa/28EaDfmY1DOnXDWjaCwL2EDe0+9pn62JYuy0kpzPyUHRJbzQt+FsBWVvCCOsrzLflk1wwjYimpmCmvv85QvgvIOsJHWb4gHIdCIEPA/o4c3UEewttVSx0JeAZYZXjmsVfV/JJUQxfthMfgg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftwjEK/bo3+C39+dI5Iw22BAIBI7ChOepG6xYbDEm68=;
 b=I+q+R8Lo55UT3chDdK2Tnc+g8NOdfyMccUlAKl3q02cVRxFKoD7JplyuGRJKzjfgzcOC8HhdHsvKZnYwhhGOqoUTlR8eIxA/g2B83vF1/x0UtiI2AQH9rF5HzT3BgG+LrNpxkVSTWqccnTGxS32OVNM0pUv3/nj0NY7Qh99YQCE=
Received: from GV3PEPF0001DDA3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ca) by PA4PR08MB5983.eurprd08.prod.outlook.com
 (2603:10a6:102:e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:34 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com (2603:10a6:1d8::167)
 by GV3PEPF0001DDA3.outlook.office365.com (2603:10a6:158:401::6ca)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.11 via Frontend Transport; Tue, 22 Sep 2026 20:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8fpHlFRjgjYrY3P5L+bmrIv0zQbNyqQtfMSLO6+UheS/qft0lOfGYbqTCF1TrRRoQUjjmzig+jepMyHS+G2ba1uEIVW11XlF8X3ILv8WYOxxGagU/kTLI2duW1MrLEgWzuIvccj+uvkvxQCgE19A1Ek0PGpiKYlDr0x+ZB+oBgZ5sk8zv9hNQimZnmC65k4GK595o6PzAwuv9sV4qFxpCvxGw4VxtM83vHdvjqv+/nX/LuNqviGL6GZdw+KhGR/zAE4rsBInnfvoPvv6jgmMigBUw8PIJ77kXCBBp6YszB5rRD/PfN4aU6SRWE0efccRCP55xGYpny/1ikD7zg/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftwjEK/bo3+C39+dI5Iw22BAIBI7ChOepG6xYbDEm68=;
 b=qWbxNFk3BXN9jIe84YPaC2QL2oWEaag5WaN9WCjKcHMR+5PjNMvGO1PMQSMh15IdPVIj9eEfv5f8HR0/T56O9ARt3JzT4REwRGhZ7mR2ojNzoIR85IBj0hGPm9VGmIXlxs7CmunFn3Jm1rh0XOQyJBDhXhLg1p7F1LW7ClDZZez99bpNcANyZZrRehnQK5Ez3RQq8y816n/WDlVuCWvnqMKb9vDpoUVicG/kYvMhUJnpmdV7QLs8h2kDOOvsvKkx6JiVxcYyuCRl/pGLVaR5uUoG9pzqWFga8qPyY4iu4ehAU01ibOLt/W2IlzA5J87Ok8ZzuTmxs/TyT0lczRnRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftwjEK/bo3+C39+dI5Iw22BAIBI7ChOepG6xYbDEm68=;
 b=I+q+R8Lo55UT3chDdK2Tnc+g8NOdfyMccUlAKl3q02cVRxFKoD7JplyuGRJKzjfgzcOC8HhdHsvKZnYwhhGOqoUTlR8eIxA/g2B83vF1/x0UtiI2AQH9rF5HzT3BgG+LrNpxkVSTWqccnTGxS32OVNM0pUv3/nj0NY7Qh99YQCE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:01 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:01 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v1 01/27] drm/panthor: Ignore -EOPNOTSUPP for shader-present
 nvmem lookup
Date: Tue, 22 Sep 2026 21:44:55 +0100
Message-ID: <20260922204535.2850094-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|WA1PEPF000099CF:EE_|PA4PR08MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c089014-a216-4143-488c-08df18ea9697
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: FzmemGj10povINCyyu/sInusoJuNfIbfX8mjnwu/RpEIapfJyDcRX8irvEcWmt3CbCJO218QNQYzkTdgI74/ZYT4fpw0z4keoeGj2z3Mmpvm8qHlSJHRdFHeTjiEktwOPnmiVD3pkl13tahnlvKmlFg8iOiCLf/Tw2RZnFfs6LBUGFuaES3DyZIzbPAoqP5IdbcQh2zPRYNx7iZVGqkr/o/toxvdDDkofOtF1waotW4QbY3zSGbJgxkx6MIzxKJMJcjEn74h+HrDYYeESMjo69Pd01ep8mRmrtWJT0T+yaZWe/l84HOsMCAJ65cmGBq1PFdDZV/fI7Ln83pSYAyzK6Ef778J99k/OIhibc+DWpd4wUd5LGgIK5rVRmM8PAdtkaX4QG+yP5kvYKk7l6WDPmvuHbsMzOyom7Zxm7JdjTRVYFO+hrYuWd0/XdBRHjdaa/azmp3QULVjNSdDPmL1AAgvorktMpWxsS6edH55+KvY8rf5bViA0wEdE1KHCefFzijVKifGHrdaX6WVQG8SSzaoNvdpVoloJgSPypttFWJsDXb/PdQNjsqZMIDxnw3fXYl8u2OVFWLFVy2aKPKx/4/+hoZwxi2LmswnbNl4s1Bw4IhxrIf7N5mfO8UpF2qDBI02USwGSn3bnJIsnW6giEGk6BtIeEKgtQMFOLyOOpA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dwiaeYufSp9Nq7qNoY1yOSbUxAihK2x58ZdqvdArclOy5MshMSfOBKyAcAjXUYn0TOA4YQGGwtpwiwRYcWnitSQp03iuCjmBAalR1jZPOzVNMql4WzE/fboLEKTRK7UoKlyy3kp+oqGfRB6953X0tEkMCnQbgLnaouEnzgPa58ezPaHJlH6ktldhLwP3LD5GEuChGxFfKsAhjY8WYKxcGO7vP7AKUzm06xKam92i0GfowBf1OUhf++lnOvLIN2e4fiwdG9B16QpmQ/73h1srPkNyR+sUI9i/1HZBDZ0HIdBVc3pRYULl1cORqd7jmVZg7XPlSI803WznHiPBN8a45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2144ce4f-b7f2-418a-5a2b-08df18ea8308
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|35042699022|14060799003|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NOnr0p26S5UOSl8uhvtE71/Z4U/Ym+1XgffPtFzeij4xUT9X/Z28NOC9flyBbNKRAXsl+WsaGgG1eHqMd5XClSOdNJ/wGwoHp1ebztOe8hCl0l1044jolCmCXmJ5NVogv3F/lP/tawVXsVqOkhzTKq71bK9gPjl106N3Ybl32kaSqFL0VMaCVOgP1ycapLRr8l2KLy7Y6ojVeZIHGckUoHtgrffYOQM39UrrA9y1c23A5K+rS+IieZ1JOnj7DuxvWNwsXgpv6OCvCsrTv+v0U4H+ovp3DBojOTJOrM0KZ32PIPMrTlCA2O08jWGiynjbgRWb7vVWQ+pEGOfWZJL8jb97Mr2KGfcf9dCDFgRJnImaBIgbd9QWoHC65IzHJw8av35HZU6cyTnJ0qa1OTSVfuYLN9VYsajucexRdLkt1DtI+QIoaF0lh0Cq9NX2yM82H/CeWtCUHxhXSPulF7UP1gqGBvY0ugc/23ErvT3R4FZ5QOhjXLuACFW+lOuhZloIgsSm8lJ2Yt/tzJp7s0DeV8U9x7AexmEijLiOL7TNQOHvOpM2/n9S0WrDxRmQ8A6jmZwVO6nwiVQhCgdB9aKTkuxLrjVvUZJx2VfvtFvPfofgLI781DXhbY8SC1Auq+T1Gg7ZkOTW8z3hvzcjMn4wlqYYjzeyJPEBcputlDr00QnLC1GdLdItlfl6B1+EdMPYOa/kKyWd4Rs/iO6bIH98JA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(35042699022)(14060799003)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0913UxGSlP8YqsUb3A1IKCwYRWz/Z41XhgUPBGMs8cWJWxeVN/Wpx35p/TTPEC8/WCSEg5YM8MzAQtfPS4EUG1dc3uZ4WEG6abz7CXUBxFWaKiru4tadHbV4SOgvuymxESq0LvJDuhHwcYS5lU4Ip/nfaFWTBt2jdTv9VzuYuM2+26KuDANdjo7WYMJbNmYnrLUFu9imxrgiRvcq7yy1UrSCNF6pCd8CAEsKL9Z40s/Fod1JPC51TVYQUGEkU70xhVm2Ry4tnNW0lf6xqRA6ZfB0K/GFBA5i380Un17W0SurnOX1Iovlq5HSHDaOPNgTkX8Hio4PUyNiUkIndilaFwPu8BWMOqWeHWTF/yaLMlsgn3OqIdqLmll/8w6VB6F/u9wD+Frjfq6AHYS3EPEyv/rdeSGZsKe2NU+8xerZHIyGC/Ucaw53ZzD8ZWLYRrYo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:33.6024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c089014-a216-4143-488c-08df18ea9697
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5983
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

When CONFIG_NVMEM is disabled, reading the optional "shader-present"
nvmem cell can return -EOPNOTSUPP.

Treat this the same as the cell being absent so panthor can continue
probing on platforms that do not provide shader-present fuses through
nvmem.

Fixes: c40b50c3cfbe ("drm/panthor: Implement reading shader_present from nvmem")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Picked up R-bs from Boris and Steve
- Added Fixes tag

 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 7e315708ca7ca..4c96573b649a1 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 					      &contents);
 	if (!ret)
 		ptdev->gpu_info.shader_present = contents;
-	else if (ret == -ENOENT)
+	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
 		return 0;
 	else
 		return dev_err_probe(ptdev->base.dev, ret,
--
2.43.0

