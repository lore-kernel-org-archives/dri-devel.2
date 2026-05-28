Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF08CD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1493510F340;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WjlSJAoq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WjlSJAoq";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FD810F320
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Q1o2Xam9BMGzf52EQxQ/CWaJPrwpY8Gi8FqTc4gjLe0NpZt9SVkRNP21aHOs+0OMy0xpZVCtYF0+UeY2H36EkKtVN+EDmoyZ0ikRuVOgjLBJFhNsZjJ5UFOHyaixXeuvYg65MUjOMAHN09D7JC5cr8ktwPJ8lYNXuFTPsNcocYB+7s/a+XKBVYYoLYQWtlIixW0FrIZW0VvsHVRglJ0fZ8uxNxQF0jJ5cIS02vs9rRbpX0VZ9S3IvVn+5UvG5HS6J7wXr30DH3V9P5vRuVnXCDFybgac+GCBOFUrmc/PI148Lg8M5vdyfdsesSlHHdOSAeCjxv3cGpGnO41mgk7EUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4w67VEEgS+Q2jYNrikMStPGpS8eupxXlUrIZ1Hn1E4=;
 b=CIFBRzRH2AloeSNWSTJVRGJbpoyGPUckdk800p0PIyMDAtGR2z6B7SrX+X/KmvPQ84Up5WGgOXsO4naK/EaP+A+lWjD79knsYBWgbeTHgSqk0RtCxgoTJbCeiufSFPZOM/zxpt6O7zevGCwNxzeZcCYR/hb37WK6tzlJByESIW4eshLsJVBLxqKyxIIzkecP3MKxDh0zoIzfVu/Qr1q4s5KFCOjVsQRysCfUZgZTnx/lpFjDByLnDaL/XyGcjWuMrXqV8ObVtJi2RnUSk3PSjAms5VObOAnZIbsY/RGx+NsDQ/xCdw6YCxRNrH7wqIbE5HZdyOMNpyCcblWKwaYbfQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4w67VEEgS+Q2jYNrikMStPGpS8eupxXlUrIZ1Hn1E4=;
 b=WjlSJAoqma5YQ/yn19lREbXd3rm6Ty4scaGBPonUaS9YjlClZFJbxM3JLvHDWZGcMLpJ/kF6Ngzu+wCsfkjEVauCznpjj+nitQ7b2TgOKffQPenyK+L+C1/Bypr2XiylBmdmpwO6I4eKaszwDKwRVq8GABsURHoEk0o1wUhVAJE=
Received: from DB8P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::33)
 by AS8PR08MB5878.eurprd08.prod.outlook.com (2603:10a6:20b:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:07:08 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::4e) by DB8P191CA0023.outlook.office365.com
 (2603:10a6:10:130::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Thu, 28 May 2026 15:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWZJF6c0n4Hp+6kOHZvR2nUGlLZY018s9F8m39jq7b5HWbnZVAjS4vBr/BAqMjwEUvCcRbA8sE0zjKD4MAtora0pg/IH9IrZV0t6eaoVVEhDOCasW+KaUniUft30VMmywvRNoTJtpT71jeyXOFa5RJuTxLklwDkeKN08ihwNXYGyQbsHdf1uRxZvJBfNAqSAx8FYOc5oDpvjXoTvCimOg9TiXIib62ijuL7TZq+hl2gXaLm3C0rK7eiK852TYiUz/n0uMqQqfFv5PJmrc42hYY/4ICC0h7YFlta/Y7a9aTsB+dbY1Rvb9/+AU8WDjgYd/gLGEcarhQZfhcv+opx3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4w67VEEgS+Q2jYNrikMStPGpS8eupxXlUrIZ1Hn1E4=;
 b=uylNQKJSyyT7XSqu6g7MY5MIDOapMzjQONGVcvn2ExYzojTPpF0sjq8m0S/HJs46iZ9VoBfAofG8BOAwUhaF94Jdn93LTZ3UBa8lElFXs2ONB1PJwUbfjI7YNaHz3k2W3kuPje7cnfx7T9SJcRwYGUZTbHUW57FITiiwVz2fYFaizFdw59NGid9pPFxA77B22CzYawVaDTIfDTYqCszBOLm1tn7dG3e47Ke/phvCOvZcgBapK1GrpMxx62nghvfN9wwWpod7mhAWaq/U2exUYQzK8qZH6FKgmaeGioKZ+QD4reDIoSXokVNmK6A6mmI0WvPUTZBvctKmZS+NtcuxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4w67VEEgS+Q2jYNrikMStPGpS8eupxXlUrIZ1Hn1E4=;
 b=WjlSJAoqma5YQ/yn19lREbXd3rm6Ty4scaGBPonUaS9YjlClZFJbxM3JLvHDWZGcMLpJ/kF6Ngzu+wCsfkjEVauCznpjj+nitQ7b2TgOKffQPenyK+L+C1/Bypr2XiylBmdmpwO6I4eKaszwDKwRVq8GABsURHoEk0o1wUhVAJE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:05 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:05 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/18] drm/panthor: Add basic AM_SYSTEM support
Date: Thu, 28 May 2026 16:05:37 +0100
Message-ID: <20260528150546.3168527-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0281.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DB1PEPF000509E3:EE_|AS8PR08MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: e4298bcb-bcb3-47f2-41f7-08debccac97b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: Ac3W1940P16kozDHcF9f/vjhJ7NWSDGI18+PhCFAVwurNQJRBbBUWi7LHJLJZcM66pSa3R/9xOj7oVu2eaDQJ3H1VTNFVEGeE0oaKs2/sUcUiptewytlwAWh7nlTHDHyc9pWF5zo6myht1BjaM9f6G77ipTuq7kWvvS1pmuoF1KZ0oAFkbRyjmMoo0TyJpo2fkIDp51X2fEnY+n64HRcrrd6mbkomDmETX0hNFIwj4hAXglOisHchxMnZFgSECngpxy1zciB1G5PL8J9/L/Rn3SZnuXAjd0lTpT3Dju5r/5bdluMvq8iXv2whT3nDFofns6ZQ6ENzNSEhLJ3wDjdN7rAwxWRd7/zMMX0nZpR1rDLovzDpAKgzVmS90SvwwEjgqqGoHsJ/MUfP58xfQGdv/dSrp4V2mJA00XK3+2QvRlQqEtLHbysfACyPsMUX/1uwnubxyhGz1PwxqAVFXBnH7J3o81HWfXKHuiyyM2MkxQUSftv0ormiIuup5aBcPctOrfzUoF+nbpdC1zX685WOsQ8tgl4idcXHIiyI0Lz2TkunVDb2lhI6cuyvzyUkfxN93PBbPmKN0QwibUllFLMHFbTu+uAagGNdOBNx1Dwsk4v03OqjDTFnUBv1v3KXHYQxs2VqmsjROBFu+v/Euv0IEsqCbYa1zClnEcngQYNHDocwkSC1+zXSa2GQhcqBi3Q
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: R5NRchmi8BHRjQedhUqahIiIr06WJegcFvEXHtNTXKcelBfIAC11OLMT1saoywQrrrVtTvPPYI02tLED6jP1mH6Wzer5DMfFRG4SSICr50bYLrGFQfZCbR35zV8DmrQHp4e6POv9Qao59TmNKQAcutgSLZQJgIPrBXhCApNZ536/+2V1304UlTrbSms72OJaoXpngtLma24uCJ0vslNBbCHKGuVqERvPvECsuzqai9WECh9UGCDGqpnnIr1AbWDYZIayZmXGOag7WP1Wd2Js58lNwdD1dlj2EANcdEKfZOYRfShYMcGZjfyhXPh5zxEYcX+vxjmG0NwM+FY1YqRwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c1bdf968-ead4-48e5-888e-08debccaa415
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|376014|35042699022|82310400026|36860700016|22082099003|18002099003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: H4KfndtkeedbJaYMuqtHfxhtgWkCg3TjcrjeGUkrYeGGNqOil0ei77Ks+ExEzydd1BnIUQZ+MUaHGyAKDJleO9evZbsES/801Dq8oVl+YaAxTaLZbTnTBllMC5ZrAz5ZcQ1xCL4XJXLqNUwv6gcA4IZ0ytvgU4x1do4UjM8GFO87PhT/gSBusZNATNTvzVKtDiJPy3mEf8AFONl90WtY8WjgLWKYnVDEYVYsEiDlAzMTVtxXXdFCLtBHOsMKjB5QymxptPjaq4UYMRzmT/ZoAWl159HnJOhqB+fdxF3zMhT2TGaqVS1dQs6etmVWRb4/TDIc0WLedEuJ3UX31ll2A3T+ROh9pnKD6X0QUxMDQVyYWvi0FAMSMNil1enXBd7h/sJ9kEW2zJvhEc30l/EQsVakuB9WwokVXkLy3F1cZ1qmfhjW2PRE8l3JwgoUfO8I4senrQQ6YQQ+PLsE1CA5X7onXSUsi8ZnVchnq/pPd7hsrISBNL8gekqvBRBOzA8JhHyVraMonY0wxdNpibW49NZdYiC6SjPR2laf7ifQPx4Wik0q/MAFGqaeAyzCPR071yaxg8kC0A1uZzqhmA6qP9gY0089lj7WmFgSSt2Xjlyg3uyJdQNVLSqs4VtxiArTK66T/63sQjZf99z+s2n4mLyE5edBU/g4kItCNCJISFVKcHdnHyXHaFZz3MYs62q6fgG0ip5rWCkhIjba3CRvBs5ZqHfosRfyYwcOORagoxY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(376014)(35042699022)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(3023799007)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OYs2ol1ZQyzPAzKkCAMudrh+e1r+v7Zh4bfkw10DxyYp842F3+VUKsOvgApy71QuZlyN/zFBqRAe+cdf1SLjPO0r1hXrht9uVAcBZVD7uLcz6KAkuO7fjxvCDZphitA/SvPRBMoqCKar8o1A3yf7WIIzPr4oDe+MtR+AO30xBjt5AkCR6BfyNSfvJLAWaUhXN7XpvNkv6zZzoeIRrgXpqO+JkMjcDxIWU/247wtGP08ga7vq98DRLq49BKH5EQiZcA4W1KUWQuCMT19Fm9chN4jEQAVbKnlaunrIGdjWEVppgZndHS+3TfiZy7op+gVQm/T6r6e4DIWJAVQXUXFRL90yF0LM9sReuaDXJnMupjoaWa25uECGeF9y+eIyrN2wtEJBWjFcF22xbsIy3O/NVQeDJEhjaPfs1SYDSnZfZL6aZXS3+AI9e+pSaxYZjESi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:08.1800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4298bcb-bcb3-47f2-41f7-08debccac97b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5878
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

Mali v15 AM systems expose an AM_SYSTEM block for GPU-wide control.

Add a small AM_SYSTEM platform driver, wire it into Kconfig and the
panthor build, and use it to manage the GPU clock and regulator
resources. The driver also performs the initial GPU reset sequence
during probe so the panthor GPU driver can subsequently bind to the
device.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/Kconfig               |   7 +
 drivers/gpu/drm/panthor/Makefile              |   1 +
 drivers/gpu/drm/panthor/system/Makefile       |  12 +
 .../gpu/drm/panthor/system/panthor_system.c   | 298 ++++++++++++++++++
 4 files changed, 318 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/system/Makefile
 create mode 100644 drivers/gpu/drm/panthor/system/panthor_system.c

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index 911e7f4810c3..da6b9bc1c67b 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -20,3 +20,10 @@ config DRM_PANTHOR
 
 	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
 	  be supported with the panfrost driver as they are not CSF GPUs.
+
+config DRM_PANTHOR_SYSTEM
+	tristate "GPU-wide configuration for Arm Mali 5th Gen AM GPUs"
+	depends on DRM_PANTHOR
+	depends on OF
+	help
+	  Driver for GPU-wide configuration of Arm Mali 5th Gen AM GPUs.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index dd15d52a88ba..488a5e03efbc 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -14,5 +14,6 @@ panthor-y := \
 	panthor_sched.o
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
+obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += system/
 
 CFLAGS_panthor_gpu.o := -I$(src)
diff --git a/drivers/gpu/drm/panthor/system/Makefile b/drivers/gpu/drm/panthor/system/Makefile
new file mode 100644
index 000000000000..cafa509148cc
--- /dev/null
+++ b/drivers/gpu/drm/panthor/system/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0 OR MIT
+# Copyright 2026 ARM Limited. All rights reserved.
+
+obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += panthor_system.o
+
+INCLUDES = \
+	-I$(src)/..
+
+ccflags-y += $(INCLUDES)
+subdir-ccflags-y += $(INCLUDES)
+
+
diff --git a/drivers/gpu/drm/panthor/system/panthor_system.c b/drivers/gpu/drm/panthor/system/panthor_system.c
new file mode 100644
index 000000000000..985a1ecc5d2f
--- /dev/null
+++ b/drivers/gpu/drm/panthor/system/panthor_system.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include "panthor_device_io.h"
+
+#define AM_SYS_IRQ_RAWSTAT			0x40
+#define AM_SYS_IRQ_CLEAR			0x4C
+#define AM_SYS_IRQ_MASK				0x58
+#define AM_SYS_IRQ_STATUS			0x70
+#define   AM_SYS_IRQ_RESET_COMPLETED		BIT(1)
+#define   AM_SYS_IRQ_INVALID_COMMAND		BIT(2)
+#define   AM_SYS_IRQ_INVALID_ACCESS_MASK	GENMASK(31, 16)
+#define   AM_SYS_IRQ_INVALID_ACCESS(x)		FIELD_GET(AM_IRQ_INVALID_ACCESS_MASK, x)
+
+#define AM_SYS_STATUS				0xC0
+#define AM_SYS_COMMAND				0xC4
+#define   AM_SYS_CMD_INDEX(x)			FIELD_PREP(GENMASK(11, 8), x)
+#define   AM_SYS_CMD_SOFT_RESET			0x10
+#define   AM_SYS_CMD_HARD_RESET			0x11
+#define   AM_SYS_CMD_AW_RESET			0x12
+
+#define AM_SYS_RESET_SLEEP_US			10
+#define AM_RESET_TIMEOUT_US			(20 * USEC_PER_MSEC)
+
+/**
+ * struct panthor_system - System device
+ */
+struct panthor_system {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @iomem: CPU mapping of the AM_SYSTEM IOMEM region */
+	void __iomem *iomem;
+
+	/** @regulator: Pointer to device regulator */
+	struct regulator *regulator;
+
+	/** @clk: Pointer to device clk */
+	struct clk *clk;
+};
+
+static int panthor_system_regulator_init(struct panthor_system *sdev)
+{
+	struct device_node *np = sdev->dev->of_node;
+	struct regulator *regulator = NULL;
+	const char *regulator_name = NULL;
+	int ret, cnt;
+
+	cnt = of_property_count_strings(np, "clock-names");
+	/* No clock-names defined. Exit */
+	if (!cnt || (cnt == -EINVAL))
+		return 0;
+	else if (cnt < 0)
+		return dev_err_probe(sdev->dev, cnt,
+				     "Failed to count clock-names");
+
+	ret = of_property_read_string_index(np, "clock-names", 0,
+					    &regulator_name);
+	if (ret)
+		return dev_err_probe(sdev->dev, ret,
+				     "Failed to get string from clock-names");
+
+	regulator = devm_regulator_get_optional(sdev->dev, regulator_name);
+	if (IS_ERR(regulator)) {
+		ret = PTR_ERR(regulator);
+
+		/* Regulator not found. Exit */
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(sdev->dev, ret, "Failed to get %s-supply",
+				     regulator_name);
+	}
+
+	sdev->regulator = regulator;
+
+	return 0;
+}
+
+static int panthor_system_regulator_resume(struct panthor_system *sdev)
+{
+	int ret;
+
+	if (!sdev->regulator)
+		return 0;
+
+	ret = regulator_enable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to enable regulator");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_system_regulator_suspend(struct panthor_system *sdev)
+{
+	int ret;
+
+	if (!sdev->regulator)
+		return 0;
+
+	ret = regulator_disable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to disable regulator");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_system_clk_init(struct panthor_system *sdev)
+{
+	struct clk *clk = NULL;
+
+	clk = devm_clk_get(sdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(sdev->dev, PTR_ERR(clk),
+				     "Failed to get clk");
+
+	sdev->clk = clk;
+
+	return 0;
+}
+
+static int panthor_system_clk_resume(struct panthor_system *sdev)
+{
+	int ret;
+
+	ret = clk_prepare_enable(sdev->clk);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to enable clk: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void panthor_system_clk_suspend(struct panthor_system *sdev)
+{
+	clk_disable_unprepare(sdev->clk);
+}
+
+static int __panthor_system_reset(struct panthor_system *sdev, u32 cmd)
+{
+	u64 val;
+
+	gpu_write(sdev->iomem, AM_SYS_COMMAND, cmd);
+
+	return read_poll_timeout(gpu_read64, val,
+				 (val & AM_SYS_IRQ_RESET_COMPLETED),
+				 AM_SYS_RESET_SLEEP_US, AM_RESET_TIMEOUT_US, false,
+				 sdev->iomem, AM_SYS_IRQ_RAWSTAT);
+}
+
+static int panthor_system_reset(struct panthor_system *sdev)
+{
+	int ret;
+
+	ret = __panthor_system_reset(sdev, AM_SYS_CMD_SOFT_RESET);
+	if (ret) {
+		dev_err(sdev->dev, "SOFT_RESET failed, attempting HARD_RESET");
+
+		ret = __panthor_system_reset(sdev, AM_SYS_CMD_HARD_RESET);
+		if (ret) {
+			dev_err(sdev->dev, "HARD_RESET failed");
+			return -EIO;
+		}
+	}
+
+	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);
+
+	return 0;
+}
+
+static int panthor_system_suspend(struct device *dev)
+{
+	struct panthor_system *sdev = dev_get_drvdata(dev);
+
+	panthor_system_clk_suspend(sdev);
+	return panthor_system_regulator_suspend(sdev);
+}
+
+static int panthor_system_resume(struct device *dev)
+{
+	struct panthor_system *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = panthor_system_regulator_resume(sdev);
+	if (ret)
+		return ret;
+
+	ret = panthor_system_clk_resume(sdev);
+	if (ret)
+		goto err_regulator_suspend;
+
+	return 0;
+
+err_regulator_suspend:
+	panthor_system_regulator_suspend(sdev);
+
+	return ret;
+}
+
+static int panthor_system_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct panthor_system *sdev;
+	void __iomem *iomem;
+	int ret;
+
+	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	iomem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(iomem)) {
+		dev_err(dev, "Failed to ioremap");
+		return PTR_ERR(iomem);
+	}
+
+	sdev->dev = dev;
+	sdev->iomem = iomem;
+
+	ret = panthor_system_regulator_init(sdev);
+	if (ret)
+		return ret;
+
+	ret = panthor_system_clk_init(sdev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, sdev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to resume device");
+
+	ret = panthor_system_reset(sdev);
+	if (ret) {
+		dev_err(dev, "Failed to reset GPU");
+		goto err_exit;
+	}
+
+	/* TODO: IRQs */
+
+err_exit:
+	pm_runtime_put_sync_suspend(dev);
+
+	return ret;
+}
+
+static void panthor_system_remove(struct platform_device *pdev)
+{
+}
+
+static const struct dev_pm_ops panthor_system_pm_ops = {
+	.suspend = pm_runtime_force_suspend,
+	.resume = pm_runtime_force_resume,
+	.runtime_suspend = panthor_system_suspend,
+	.runtime_resume = panthor_system_resume,
+};
+
+static const struct of_device_id panthor_system_dt_match[] = {
+	{ .compatible = "arm,mali-gen5-am-system" },
+	{}
+};
+
+static struct platform_driver panthor_system_driver = {
+	.probe = panthor_system_probe,
+	.remove = panthor_system_remove,
+	.driver = {
+		.name = "panthor_system",
+		.pm = pm_ptr(&panthor_system_pm_ops),
+		.of_match_table = panthor_system_dt_match,
+	},
+};
+
+module_platform_driver(panthor_system_driver);
+
+MODULE_AUTHOR("ARM Ltd.");
+MODULE_DESCRIPTION("GPU system driver for AM GPUs");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

