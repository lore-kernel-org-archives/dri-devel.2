Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4222C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C18510EA79;
	Tue, 22 Sep 2026 20:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="W5z5R46/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W5z5R46/";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57E710EA79
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WaGSIzACqFHJjqFeVl6BwEGPEkyA/sXGXqRKB/oeQxzu31cjqvTFuoPHDNMvqdzJV83avRg9NOay77NL6i8R3QdbI+EqQVXLyEMmfSpcbu0t/FER3juAYE/L4casslzOuqVStQwziFkQ+04GYibVokJ6r/qniIatUPkpp+yLTyXdGZsV5nriQ2tagRy5S0A2G9bTieii534EmQopUXSeVzrD5tVgiWpcyZLzFBKluzBr1YCJ5GSfgsBxHgYBxGmMs9FlUlfrry3XArXzimqmuGCGzRoVTJY0Wsp3brNKFWrm4EOeaGS+Ouci41CB0GUj06WaZEx0Ix3m3iSvmGb13g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eLeJJg4CeXfgb2e95N2WFwNr1JbhAb+8zrQb9E9KJQ=;
 b=HHhbylm+tRxKSLEqi9eCY2kBpuzo6O6BOLY+sBsUzVt0QRNBbVz3GLlJnZDxk+QSI2bKHKCpOAuX9Hrtcdn4rnw+uLcYLjR6E/eplwgLH80b1pe28ZQzNPfnLQvPqJfoUL5OXiQX1thGkfZMcO+3HqW+bJWMEJFOCL14mUPuGpozjSo6/61hVYyC2wsvzSyvKoKZ0ySIVvS0mGfJ2WF31EAg1icK2LjgAtoWkHIM3TshqbC/gEgn0xSIVDesqKRpivSqCmOsSodxMckrXtyJVemJOyTzj3JF2q6LLByNLXMn4EBXaQ2Gsvt3UsBUIbWlliZTzDK58yngQb7oYlq+Qg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eLeJJg4CeXfgb2e95N2WFwNr1JbhAb+8zrQb9E9KJQ=;
 b=W5z5R46/IxFSHli4Y5PnEUiGPGWD2VUWNNEuVN9CPo6ALm5Gllt+aUDHg/gb9ne/zUOdG1HEIFe8/rW0xQF/7RtE8+oWF0/0TtOAwcQfyoQCo1gzBdSpt5nZfLzj3W5Lizs4D5Lu8zVBZpPZ016u5RoSAulijG/JwTOUf6aZE9s=
Received: from AS9PR05CA0131.eurprd05.prod.outlook.com (2603:10a6:20b:497::8)
 by DU5PR08MB10468.eurprd08.prod.outlook.com (2603:10a6:10:527::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:46:53 +0000
Received: from AM2PEPF00070CF9.eurprd02.prod.outlook.com
 (2603:10a6:20b:497:cafe::c) by AS9PR05CA0131.outlook.office365.com
 (2603:10a6:20b:497::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 20:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF9.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfU9xfaAi8oxX1j4/rjHhAvfRdxk36Su9NaebK2EKHzynA2LjLzjzk2C/wqfo7rfv0CcnkJYCAJGN34pUvRWCGW+QqLjF+5RQ7aPmOhWHatE9k6IfuhFzz2BdtB2REhALMg7tv1bzPM7+3aHi1AfGbsz2yAyy5RvMzHxcOgyADCpcNkbBVUalWO8lXqpRt3X0VcitUWjUD1c+w6NUH88ISvMRmwS1gj+k04OJ6aA5A6U9TO81P9tHP8QLD7LJv1YvpzkU7+0CH8EowoTTfGjRV6/umgdE2s2bXhDBUAd+k7HqikSqN8IY12wQhx02aE5uFqmurj/WZSq32G2SMtDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eLeJJg4CeXfgb2e95N2WFwNr1JbhAb+8zrQb9E9KJQ=;
 b=mdJSMyxphdSirAxR+HOk5ewQN4rcyDcy3i4MGYbcXVN8nzOE3DyGCLcwXrgl7Xo76LLT1gfJH9iabMDvW/OVJxv7vw35ZgKWevcSN5e9SWA8RbNa18jOacqQm5eIpqD0LpUcTpS4LX5UbVLa/Q/p6/+nUjWOCnCgdYevoinExwKVirKPBtDyNsqKQbU13z2BmFRoFYDjJjDJlV4X7RpBYspC732/9HlSrz/POfYQdfhNiwTnRJ/gn/T0k7hjugTKFNHEM/6oQZKSxufiDJl4GMzNJfGIX32rVejWmpnrd/YijrUQDjupcmD0oTVs3VQxe2e/P6/VE2mUmQ9BNMgZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eLeJJg4CeXfgb2e95N2WFwNr1JbhAb+8zrQb9E9KJQ=;
 b=W5z5R46/IxFSHli4Y5PnEUiGPGWD2VUWNNEuVN9CPo6ALm5Gllt+aUDHg/gb9ne/zUOdG1HEIFe8/rW0xQF/7RtE8+oWF0/0TtOAwcQfyoQCo1gzBdSpt5nZfLzj3W5Lizs4D5Lu8zVBZpPZ016u5RoSAulijG/JwTOUf6aZE9s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:20 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:20 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 05/27] drm/panthor: Move register base offsets to the HW
 description
Date: Tue, 22 Sep 2026 21:44:59 +0100
Message-ID: <20260922204535.2850094-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::11) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|AM2PEPF00070CF9:EE_|DU5PR08MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 497ab323-617a-4235-ffa1-08df18eaa1d5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: rGosrqcqf6CO6BN7jOiUhw3+xPQiFTGKu0fsPDDyggZ0S5uapy3VtS+eLvYtUY4f0sJz1yitZy31XvkwZnM9wlKK3cLm/qaM0uBtCwnPu2N4vatHbVgaSkGBwJnFrGoqcHrL8KLgKGjI+Xm+a45dY/B++fb1USf2vcx67xlAmMuKouxLdL9Z9v7WObj7pn9mRe8N30DVq30uHsbS5vAimzSI53ROkq843pJBKBV0nZGehkc5CWCLOG/6xxv7g3zUhy/qQLBVLwyOtVF1MJjEXzfDNDAnFx3N0XvZAFdC6mt2YeuwGWDnAgU9WRNxtl3j8Om1i1lkGzSvcEr54mUaXbGiPanHL1la79tt1TxhNppuUAa02rii0GwtEzYsSRvemp/D7S01/ExlFTY4e0iX/U2gxHrBf4YARXwFi9JBurHUkGTF/YGMJNaurH8ZIk2kZxzWCoT2xT91lWpPfEoH1nyLmL9zm+weF59ZlfIHGidAUmzr1drbuwSyFQpi9cuVxkiHCN6FkfzqLqSRQLKwtarIaDqV3HV8UO+KqZNbA42F03ZLBJUoV3NJVsJwES29pynkcIPwdLNoTNY0pOpko4JTBIXSXmQW/0cejGc1fdiknMs0cXaw3LGtQeZX4BBpMWF3gCsTrHBpfmq8xWzvEC9l1e9mthBZCfAz7oI2nY0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 3pohUpyCJ9vGxsbew9AjWr4c5ka10XPSh41JcNlobvVtSfylPWbMUhn139J/P4h8IQBk+vjIkyNNb3GEu2AiYSFURWh1NAU3FoKrzbJxeVrxAzI5VEIqOGyjrKnhi9Ji3e3X/8c2Gs/tYACh+ok6PAG934zbUc/5DKc/dVC/gZ1WmvF3PeCI3ZUpUC5IjMhFVuu3PoTHvdhHRWJVZwJoJ/xCNzYenebEO27/LUBw18nynIN2PSVsbvrluxD7s1aFcrbbDf/sW9T9v6X5754e+JBM2a3+Y0gjT6Dt8X8pBh6qWLA6jRhOT03hmaaDnrbZv3b2YpXwozbiX8ZKsHW8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF00070CF9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67c6b184-8bd4-4a4a-134f-08df18ea8e9e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|14060799003|36860700016|1800799024|376014|35042699022|10067099003|6133799003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: BXZk1j9dbjSMNQiByUsC+yGsnh0g+5mNPPHq/Sf4h0/C76nzItL3PSBGPXrV2fDEXIoaD4UTDTV1V9vx4g3KS2NiKIV2VwKaGplYip8d58Ihim/s+S7MIMZD4NJhZh4mAr2OIuDfYEkIUg1y2Xw+354AkKAoEoMLHkdd6OdgJM8lYPj7echiW2QSafCUAnrPdusJdjFsDuVZ2wGxh4YxWwFwhluZkVjwS3m/wI5f8R84jKny4DWlf/OulnoYROfZz/2dPmX1ANuGyKvhU6/X2NsYb0oUsYykvr5EWW2POqz2hml2m63xd2C/HqQ9d6gNw+k4Pfsva9B/KLosFjlZqGjOC+IlC4FoYpcxDpPi7+fLTqYbndpJCuElm457herLTQwfFyQzgNPhoVJ/9Frrl2aAR+ClDMasX1ErVwlN2tWPnSSoNdz2v3XqYwvUR5KdkE9/3Ns3+SBT3uw+AaTPQjFQ4lpBfEL87mzt5/Rnh+z7CaOF5DBpVHhs4Z+9ylZO5pgyetlza0xtxYVu6auHbFMwZLInckBf0wiks1GVw15uN3ME43LPbrk2HewsUbjyl5AAm96RxlJPIUnvZgA1SZ+2SkJy8+xBQHEa62ylrMBP7qRGNxVh4qtO5rYv/hSZiLTNRipP6jPce5nQoNDa758SUSR8i6axY7w1jJ7E+xoz+762xjzLE8JezMQPSrAbFPrjPjDzVp8dlxOT8E8zlw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(14060799003)(36860700016)(1800799024)(376014)(35042699022)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vBKy49VNrudgZd5/pLLUXIQhy6RklUDTWu7HP5RnHKPzlR+bA8Z5wkWrNPLNh0ckP0YcHdk5UjfMgh/1CESwv4La+uZxylaPpvtUdcY/Yp6YFF76CM6ziR0KXI8IOOx7p7f4mBxXSvUB7UsDOJaCct3DHQzcvFJIviXYhIG5m/yZNneg/WdkiqAAcv/Di4QLe5fDj5M8NJFh9nCJT9+mntB0E8Srqp2FsrORczBD9SLOFjaPK4S17t7RG1aUaDNx6DG8h4rvYalvUOXf3XkaETUBeuUNCadjDB9T/qZYXxaKAQaenRynI5NuPM3/EHbo61Pfx0kdJ5HwfO/QAjP/PDSw9QATQo7rKKyIEAWyOwRTO3ctOrZKlyFfb7YiGX4nhtjIvAVWekDmjWtFRuR6qF6CQmYSwA+Hib52hucIpbvDicBh298Mv1YVDXCMizQB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:52.5523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ab323-617a-4235-ffa1-08df18eaa1d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10468
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

Mali v15 reorders several register regions, including GPU_CONTROL,
MCU_CONTROL and PWR_CONTROL, so the driver can no longer assume a single
fixed base layout across all supported GPUs.

Add per-GPU register base offsets to the panthor hardware description
and switch the GPU, FW and PWR local iomem setup to use those stored
values. With the base addresses now owned by the hardware description,
drop the corresponding fixed base-offset definitions from the register
headers.

This prepares the driver for GPUs with different register layouts
without changing the existing behaviour on currently supported parts.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- rebased on drm-misc-next
- use a generic panthor_hw_regbank structure for all register offsets.

 drivers/gpu/drm/panthor/panthor_fw.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 --
 drivers/gpu/drm/panthor/panthor_gpu.c      |  4 +--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 23 +++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h       | 29 ++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_pwr.c      |  2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  2 --
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 13efed3a2ea72..679ea1d233d53 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1500,7 +1500,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
-	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
+	fw->iomem = ptdev->iomem + ptdev->hw->regs.mcu_control.offset;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index b2e59cfc22b00..a3492f7f913f9 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL_BASE				0x700
-
 #define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index ade2646e2caf6..d6534fabc682e 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -158,7 +158,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	gpu->iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -175,7 +175,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 		return irq;
 
 	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
-				  ptdev->iomem + GPU_INT_BASE, "gpu",
+				  gpu->iomem + GPU_INT_BASE, "gpu",
 				  panthor_gpu_irq_threaded_handler);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 4c5b953796e4f..753df87009901 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
-#define GPU_CONTROL_BASE				0x0
-
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 40012ba7e23ca..2ca5a334f5817 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -37,6 +37,14 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.power_changed_off = panthor_gpu_power_changed_off,
 		.power_changed_on = panthor_gpu_power_changed_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+	},
 };
 
 static struct panthor_hw panthor_hw_arch_v14 = {
@@ -45,6 +53,17 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.l2_power_off = panthor_pwr_l2_power_off,
 		.l2_power_on = panthor_pwr_l2_power_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+		.pwr_control = {
+			.offset = 0x800,
+		},
+	},
 };
 
 static struct panthor_hw_entry panthor_hw_match[] = {
@@ -196,7 +215,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 
 	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
 	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
@@ -222,7 +241,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
-		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 
 		/* Introduced in arch 14.x */
 		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index bdda3b10e660a..9231c18af94d1 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -26,14 +26,39 @@ struct panthor_hw_ops {
 	void (*power_changed_off)(struct panthor_device *ptdev);
 };
 
+/** struct panthor_hw_regbank - Register offset and instance stride information */
+struct panthor_hw_regbank {
+	/** @offset: Register offset relative to &struct panthor_device.iomem */
+	u32 offset;
+
+	/**
+	 * @stride: Register offset between instances, or 0 for non-instanced
+	 * registers
+	 */
+	u32 stride;
+};
+
+/** struct panthor_hw_regs_layout - Hardware register bank layout */
+struct panthor_hw_regs_layout {
+	/** @gpu_control: GPU_CONTROL register bank layout */
+	struct panthor_hw_regbank gpu_control;
+
+	/** @pwr_control: PWR_CONTROL register bank layout */
+	struct panthor_hw_regbank pwr_control;
+
+	/** @mcu_control: MCU_CONTROL register bank layout */
+	struct panthor_hw_regbank mcu_control;
+};
+
 /**
  * struct panthor_hw - GPU specific register mapping and functions
  */
 struct panthor_hw {
-	/** @features: Bitmap containing panthor_hw_feature */
-
 	/** @ops: Panthor HW specific operations */
 	struct panthor_hw_ops ops;
+
+	/** @regs: Hardware register bank layout */
+	struct panthor_hw_regs_layout regs;
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index dd7b6ef8ea209..cc2e01595f23b 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -480,7 +480,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
-	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
+	pwr->iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index 9cf7a715066f8..05f5b48e6a39a 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_PWR_REGS_H__
 #define __PANTHOR_PWR_REGS_H__
 
-#define PWR_CONTROL_BASE				0x800
-
 #define PWR_INT_BASE					0x0
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
-- 
2.43.0

