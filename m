Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF55CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750A210F343;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bQFjpbSs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bQFjpbSs";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2481210F335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uL3t3obvrpoE5yVD3FTsKBEhu47J+2EeLZqqoPvb0AXx4ak6PM9SglHo3k3fPR2G6qJaCQWhdyLMt0YtSSaWSqKHVQArd73aeW5+Bubxv7JVYRfLAP+xI94WVvNtqHp11JHXnLL/B2YHuEaO7WQ0uYr6ClDaLp2qbJNE5YDCQyHQ5pUXRnJFqvkBsSwTA/b8FSW2t8NhyjIMyRpHKf0hZOpCtfIpUUpolt8ruhyHbujKeseMqAhmFN5wFxL3jxbYbpW1Oun4+A6LI5Q//QCnLnZN6kUO4Mj8XNgrh/GOjqEt/MhZAqPP3eY2+90sYtDUDs0+szIpEvZHWyOhF0g71w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csmd7x8DWA1r/TXv52SWxvm1IWd7JTks7dUJ/LaJN5c=;
 b=fcZ/JbctwLHx67tLv5IZmHslu3AmVb9nmIBrYsAYNfPC1vF/0uo7B9ghFAJEnd+H1GKpupFhBvjR1IlIiCtklOwWFvBjY1wn049PtmNyZDVUzCKhtM++WZwzTcXVqX7j6xZiyAsY8IbUT4mNwp0ywoW7xWVL68cmjJM/2Mu8WBBqJLoTaDjIpqbG6qLfkwa1HIUMn6Tr3/vyivjoNm9tyhSwNq16VOvq/lTXqI5BIibHSTKNlQjuxwP0bc5QT0gn8Eo4DQBvzYO3gkPQJLEuBhzResv/mODNEeiPhTho+Tneu3A2NoZ5TFcxFPZgXG6dME5OZo7hnjGlTaXLUjbANQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csmd7x8DWA1r/TXv52SWxvm1IWd7JTks7dUJ/LaJN5c=;
 b=bQFjpbSsHZbrVcYZf+7GqX4RjWIx7Ii46Xwq0H6b0c/CIAn9yAR0tF/z1exvTC+nacDbdgDO7O02a/mXufiSYpWgzupRYY3dyEJmk3X0exE86QeveP7hy8FKQj5flJeQNTaAlkhHRETh2sHTHHbuvF2f2/mEk+ohfYWO8xa43AI=
Received: from DUZPR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::14) by DU0PR08MB9727.eurprd08.prod.outlook.com
 (2603:10a6:10:445::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 15:07:18 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::45) by DUZPR01CA0012.outlook.office365.com
 (2603:10a6:10:3c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Thu, 28 May 2026 15:07:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td9O06qXNmaTA3U9DmXnr213YPqfUxTDjqCUGSe5gdPgg44Jjmh+Vu3X/x6hyQwC/hy1O2ovPWJoxDuTd4B0E2+smu7PWSOyWxXp0A4Oacj4FgxzQOUhwl+nhab5KmFRkBxQ/KRnbjz/qX92Ak5T172E59zSRIG7BPUqZbRM3Wk3R7Zb6DVmVnNx5w5RcfrCTaQvfZ4nl67/cAfcLcayAwAAfSNXd4TZpzJZLCbyrCpwsZBSJ/YODKPmlVeON4/5E0rIj3RTWR8CgAJkVvFbk1jdRLdiRLVt3qzkYn6xNbRl0orXw4e37WOFJJsMbi1k7ZumZVw8j5/BToSn7ne+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csmd7x8DWA1r/TXv52SWxvm1IWd7JTks7dUJ/LaJN5c=;
 b=q+NT7hXa2Jc+erqTFoe3kMz4I9mzNe8B6vdzDxf3TTSw9uGVFtSaYVda5SFZFGGBvYT4wipiepuoiOUThUrN0r8wK+VM60f1Bmadcqu3YVTIuMUZ13PL20Xuult/8BBHDu/FjDp0rwLJZP4xVrPG7BgX6e9Aths7YDFOvd9zR6XsyJsaGGcRDtALDGrPv9PRR058/0t6JnNDhXL4OejDmwPXvQGsU40A1ZQnxhjw4/yXTwHLwXzx4vOUJ062z+tHPL2FvPe25YSYjMeH+u/Pqrmj4u+DQoboO3c9p/3lf6pCPhZQkKhDDUVb+GcVBM1hVcbPLaKukwvMs8gj64Ka3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csmd7x8DWA1r/TXv52SWxvm1IWd7JTks7dUJ/LaJN5c=;
 b=bQFjpbSsHZbrVcYZf+7GqX4RjWIx7Ii46Xwq0H6b0c/CIAn9yAR0tF/z1exvTC+nacDbdgDO7O02a/mXufiSYpWgzupRYY3dyEJmk3X0exE86QeveP7hy8FKQj5flJeQNTaAlkhHRETh2sHTHHbuvF2f2/mEk+ohfYWO8xa43AI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:15 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:15 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/18] drm/panthor: Synchronize HW component PM transitions
Date: Thu, 28 May 2026 16:05:44 +0100
Message-ID: <20260528150546.3168527-17-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DB5PEPF00014B89:EE_|DU0PR08MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 71506bdc-fcb4-4ae5-5c24-08debccacf67
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: g+bon8hC6YlTgMmt6iCWigP7QxsE6mW9I+ZucB40+fuoL54VRPpDbApgAHcyiV3vmCqT6skxkMXcTrlgycOQLNjot9H5ZvgFSjy+yHnvUo6jn9t78Y6Dl2Mf57F0CgM30HcaDV2D0g0ak1HZAAuDVNrxCd/VQqmZRgIgLbmcQKaUXAczpGhvq9vlQciK1EYCU5lK5kQFbu9jMe0WQY+I7N7lzbaLstpr6tBEitpNzromKpJQNXsc7NmpGW3rtT9mf2vEw2sWYjnUZqKrqj8e2ewc6ZgAW0fnd147cPOH6i1iHs5bGvYdW8S8BfRqwEDzM3aRqyxNGcER69PxcZCXLGNh/jJwVZpUZQtwyuEZZE7Opm8flXysxqDaRZtTWWS6hT9Utd9kM5KppEsfe433Z2+Jy+loTuvwRL+moMJsVALF6aR2BsTJn0p0pCze/vbz6NDmxnifkubhs9sHqcjBLdbLhNS719aAHJ7U01xpZw34EOVzrm3sa8wMJGHLqXB8dNjifwS02WEczYMEkA9UF2zcqK+mdbqswNd0SJXodN+FeYtSn/DX+eDi2BBWQBhyYmdD+SYJZmHy5DI5yxfzhpUDjj6S8aEZLI10qq+k3PdDnn/bsmWbVpEAsRfat28pAxuYJv/eRBpWNCRQFjv9Kq8iwCmibGx7F1DtyymbqCRomJtJLkHpou4dR2E8nKK5
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Z6HkrkPFszYJPLv25v7SlpsrUg+m9mPg6+tnA4k8ZKBD3F/A1al1yxCK9L7hc+lOLGz7dHeOGyN4SBIqXtvFJYSbRqxupvv0oj1l/5iTF3qySQavFidWEdqnfMm4xU1TbbTRx6B5tVh24LXvNg+cAgcO+u2DnvfH1jEIlRLPx8t5M/0BKDMJimtYu4rxxaXjcVif4+xdgClmjbMngZb86qv3Z2N38VE63/+vMHoJiVs4v8n0+qZu1/OcrQA7JzLmYSZZ6NhSdZbO7iQUdtt/dIHIpWUA90XdpaBiVZQPC8Wxb/Osrj9DOK6O4BtzdhjXmowknEK9EPjZIOO6q5ting==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d1a4648e-7967-4d82-e58a-08debccaa9ed
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|35042699022|1800799024|36860700016|82310400026|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: bkSukHIEaUZ4pN7v6jL4Kg4seFn+98ohe8cfhd5G/Nz8Xsxor4xwP8HUZxR3fKZ/2b609xEqYTW6eK9WhYrOAmuvIjmrlAgPNH8K6pKpenQ9ih6hTNtqUC8iLPd9+wKyQacbjgnyWKKGVp817NHJ0uToOo1rZ73CFrERQ0p0VAPuuUYfAONxOC7f8X9JYH/UWYDtNinp2sdyr7oZBW0XO0CbZPVlyrjiyNmIps53ds4qTLYXSEdDDJ/sb71RO/xoAdv5s195CkMFyxPF2OzMI34IYUvqEpqzwWwueG4Izu6EF/ahyx7q1l/Me+YahOJrIY49uOoEA+sCSjNDVKtHlyluN01TB2dnzwVPNsMau1ooROGOaOxGyAJb4t0HibB1UpdaqMu3fIFd+mZHWKpNe3sJU/6RAt6WkjCgErGLMpjzcIQE2L4cg6wjRi5PZvbqXNLx7LuDsq/UzRaRdUFPhkBVe4dXcFpdB0IW1ZHc2TtVsmWH25rRGLzUESzADv4DdSwAv0PoZH6VcIs5YlcvsuXsQ/WRVjMc6KJZSXgwQZhbsa5jwNuGzFxlIH0m1tHLXy5OVEpoHO/R5BvmPYn862DSR98/4VKqn+WQAT2l7mSL1p0NAthtOiHxqJ+FDxbi3w26YdeYtGBos6+J9XJM/GiWtkW5B7u9z457aDFSGjcz85+0ZCjPZopvsttLDFHsSOrTCJnpO/FPwP2tJqMcVND5Nx8jlJSTOKetqQ+tq+8=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(35042699022)(1800799024)(36860700016)(82310400026)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mu4pYI2RS1NzqO105+GaO7CSRyJbuZY8fi+h+BP1VxrqVkEVVPyhB2QsrJqz19eWI6PajTzoCBksLBx6BsnO6gzAtWfMo5Z6QYlhRGK6KJhDgp0XguIXxTKfaPuXagFrbBFTl96qc7xp0T/nVqJQOMJDff7GfxFRa8P8lxLOII3uZufWL+P7KbzxJMcwwRJv8evtcEl4jUnJmAK/JAt+QIeeTFPnnnC8dqAgdGeiMMUYJY7JmiXbRQS6Ydp6VIJ27UdslHl9teTcIarHcBVrIIGteeBjhscNhIZrEva/dxupx9tUZRCcTjtUkOv9rglzVse1HuoolQ91vjMzNYL6+sRzSSM+xuJoe6XrXaugiZhqyJ2d2ITOLGEwwL2pte8YD37KSMjeETYFq/EO2Y9ZLordbbWT0xdl6IbVS7fxRAZt6qW5GoemCtPL8tZxFFAo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:18.1295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71506bdc-fcb4-4ae5-5c24-08debccacf67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9727
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

Split hardware component suspend/resume from the top-level device PM
path and protect those transitions with a dedicated mutex and state
flag.

This lets access-window arbitration suspend or resume GPU components
while runtime PM state remains controlled by the outer PM path.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_aw.c     |  1 -
 drivers/gpu/drm/panthor/panthor_device.c | 50 +++++++++++++++++++++---
 drivers/gpu/drm/panthor/panthor_device.h |  9 +++++
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 00a52175f3a3..146907a3098d 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -192,7 +192,6 @@ static void panthor_aw_handle_message(struct panthor_aw *aw)
 		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
 }
 
-
 static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 {
 	struct panthor_irq *pirq = data;
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 7248e2aa9da2..a8aedbee7c97 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -179,6 +179,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.hw_component_lock);
+	if (ret)
+		return ret;
+
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.mmio_lock);
 	if (ret)
 		return ret;
@@ -289,6 +293,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_mmu;
 
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_ACTIVE);
+
 	ret = panthor_sched_init(ptdev);
 	if (ret)
 		goto err_unplug_fw;
@@ -477,21 +484,55 @@ int panthor_device_mmap_io(struct panthor_device *ptdev, struct vm_area_struct *
 	return 0;
 }
 
-static int panthor_device_resume_hw_components(struct panthor_device *ptdev)
+int panthor_device_suspend_hw_components(struct panthor_device *ptdev)
+{
+	guard(mutex)(&ptdev->pm.hw_component_lock);
+
+	if (atomic_read(&ptdev->pm.hw_component_state) ==
+	    PANTHOR_DEVICE_PM_STATE_SUSPENDED)
+		return 0;
+
+	if (!pm_runtime_suspended(ptdev->base.dev)) {
+		panthor_fw_suspend(ptdev);
+		panthor_mmu_suspend(ptdev);
+		panthor_gpu_suspend(ptdev);
+		panthor_pwr_suspend(ptdev);
+	}
+
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
+	return 0;
+}
+
+int panthor_device_resume_hw_components(struct panthor_device *ptdev)
 {
 	int ret;
 
+	guard(mutex)(&ptdev->pm.hw_component_lock);
+
+	if (atomic_read(&ptdev->pm.hw_component_state) ==
+	    PANTHOR_DEVICE_PM_STATE_ACTIVE)
+		return 0;
+
 	panthor_pwr_resume(ptdev);
 	panthor_gpu_resume(ptdev);
 	panthor_mmu_resume(ptdev);
 
 	ret = panthor_fw_resume(ptdev);
-	if (!ret)
+	if (!ret) {
+		atomic_set(&ptdev->pm.hw_component_state,
+			   PANTHOR_DEVICE_PM_STATE_ACTIVE);
 		return 0;
+	}
 
 	panthor_mmu_suspend(ptdev);
 	panthor_gpu_suspend(ptdev);
 	panthor_pwr_suspend(ptdev);
+
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
 	return ret;
 }
 
@@ -602,10 +643,7 @@ int panthor_device_suspend(struct device *dev)
 		 * The end of the reset will happen in the resume path though.
 		 */
 		panthor_sched_suspend(ptdev);
-		panthor_fw_suspend(ptdev);
-		panthor_mmu_suspend(ptdev);
-		panthor_gpu_suspend(ptdev);
-		panthor_pwr_suspend(ptdev);
+		panthor_device_suspend_hw_components(ptdev);
 		drm_dev_exit(cookie);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index a1092d02a1fe..d7beb7165577 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -350,6 +350,12 @@ struct panthor_device {
 
 		/** @recovery_needed: True when a resume attempt failed. */
 		atomic_t recovery_needed;
+
+		/** @hw_component_lock: Lock protects HW component PM state transitions */
+		struct mutex hw_component_lock;
+
+		/** @hw_component_state: HW component PM state */
+		atomic_t hw_component_state;
 	} pm;
 
 	/** @profile_mask: User-set profiling flags for job accounting. */
@@ -439,6 +445,9 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
 int panthor_device_resume(struct device *dev);
 int panthor_device_suspend(struct device *dev);
 
+int panthor_device_suspend_hw_components(struct panthor_device *ptdev);
+int panthor_device_resume_hw_components(struct panthor_device *ptdev);
+
 static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 {
 	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
-- 
2.43.0

