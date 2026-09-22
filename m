Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEE1C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F7410E785;
	Tue, 22 Sep 2026 20:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="BPWEB+Br";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BPWEB+Br";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81A110E2E9
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:46:34 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ChRv0Wlg5UMROQVeS84IS+a3gyQzI8b4uILCfVtllTvKODo+e18POQsLz2CQmRV/2+u1GeWg8rg4yAXdAqMMDnwIDvM4UNqkabFV7h9MobbD3evWgsSEKpWDZ5tJ0vD654tReBHinyLLWZhUpqCuceXnbEqFTroKgj2YbK28IFEv0LZ3aKMLknNhgIcfzLSJWWtsHNzzIbP+2mxnsRpHDvQJLyheWd6u7Rpx6gg3pIu7je0ETEIFd/+9ko6BJmKZb+qj8nknjjdVf5pmxdvse14QDdp/o2T1qdqSQNOODTiEQTCLw4eS5QZSL6OlCFkGOkDcUL/SnQcFp+8Qqvrr6g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryRBXaiLrdhQRutgrp+g8qyc9i9PxFFGdrgnUtLYo1A=;
 b=CPXaUfUxKWmrMGXxtRAR4jRnTdeaLMAOoGtpQ59u/MJ0WI/l4aGOXqjrF2qJKmETj4QF35zrxp7FHjK1mouUzDSNFaK3TWEN2qEokWQoSOMJuZVPJi+dtlEzfH3dkd5lSw5vdmf3h/uYQ1GZpZgUnVzaxSfMW8G768UeWXzuCPmTqdv0MUfmeThHOnG0Ri4EsKuUQlVp+wQWDLfN2iXNdSrb/FCEqLppTIeVw0fbBrx06Uht401KRSVWH9r5z+lWespex9CZybaLyOSC0sk3ZnWED1tuIhOIme3af4oPcwot6KQD8d7rGDl4dZh5j0CMSbgJgy2MD4lGaQEoPZlBXw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryRBXaiLrdhQRutgrp+g8qyc9i9PxFFGdrgnUtLYo1A=;
 b=BPWEB+BrCpOhbdopJ/EPgcXK31glh3vcmaMF9Da5Ywh03+ZraU0r11aiBs/rNcuX62s1dF5O4kMPSIcZ1yCBdPOm6qwK7BEriUNEcQZ8yT5VRJGaQBHagTGRo+SuJQSkoSSzeWZNJ8bGnCfOSx87alrP1GiE6CCcm70IxDmHTT0=
Received: from OS6P279CA0121.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3b::19)
 by VI3PR08MB984667.eurprd08.prod.outlook.com (2603:10a6:800:374::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:46:29 +0000
Received: from CPH1EPF00000527.eurprd05.prod.outlook.com
 (2603:10a6:e10:3b:cafe::79) by OS6P279CA0121.outlook.office365.com
 (2603:10a6:e10:3b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000527.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+IUohA8CF4Hpxgt1v0gmG2yb379xp7DcIA7S4ycSObOniIkAVnRr8fAbGoE3vKtK3Gu0H2nzEE4oj0Czoq23RLNDVlJ42SWCiuDIzWyo3hWJ+zlU7COnb2j0JyayQdQ0fj3d6BHbuvEQH0f6tGYwm0FSUx+S7qVMDSwxuk+oUGT718wbPGxyTipmXadKVoZeFU2E16+GEqfxBvk2hUi/ELKl12foOYavZ1wlXnR21iACZ/E8UyOzhGTZyqeVneQ/rnnKbLxS14nLQmxoBZBaNMXBpuIeTbMPkJCsu7MHwv9BgLSI+mdx2DzZRMKygn1fesvIAMlijIKiKLxR1QJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryRBXaiLrdhQRutgrp+g8qyc9i9PxFFGdrgnUtLYo1A=;
 b=FJv3Fy7CjZsW4G30ZP13F3vNRLsrIZu3PqLwR1YWpUogXnHjtXfWBvsl2oXZLjujTYRESK3vwYn12N1eXcjo50BaaE5YONaMA66q6P9hHEYDZAshwMeofjobCc9ztOQ7k0FJWUUbXg7W4uAxyICgnU0RrA5G40Xmlf+b5roHt/m246yNCZi1tAILCQmq0TW4/ooJXWkU1j6ZkS2miEgXSSzsyIGDrWMrAnXKMbP0E9or3huj0cxpShC8ERTyJD969Q5h+ArBrar83GrvfuKA53wwmU4fHbe9R0bB7RoxuHdUVIvjGci1qMrLsGG1iCsq03wxNlbQUjd1+EGyAmT5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryRBXaiLrdhQRutgrp+g8qyc9i9PxFFGdrgnUtLYo1A=;
 b=BPWEB+BrCpOhbdopJ/EPgcXK31glh3vcmaMF9Da5Ywh03+ZraU0r11aiBs/rNcuX62s1dF5O4kMPSIcZ1yCBdPOm6qwK7BEriUNEcQZ8yT5VRJGaQBHagTGRo+SuJQSkoSSzeWZNJ8bGnCfOSx87alrP1GiE6CCcm70IxDmHTT0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:45:55 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:45:55 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/27] drm/panthor: Add Mali v15 virtualization support
Date: Tue, 22 Sep 2026 21:44:54 +0100
Message-ID: <20260922204535.2850094-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0061.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|CPH1EPF00000527:EE_|VI3PR08MB984667:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe78540-3985-49ca-afe3-08df18ea9372
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: saisVqiYCqd/vIVLsyjmXHfnfg1h5URCnBl/vvmSlZKez2wGvHmPERpwj/17aJPbdlQV85Uvwm36JPfX3ZmZt5x0A83Lc8X7B3x2DcjEzGvwmWbuXV7xmns3hTrvzy4ArA4mabQUvKWDhDWHzCrkdmNkToh8UluIjHL9dADZFRiILDviQ+kBLOk6vGy0yZa6S7UGsnyUxn1lJdVsSh/MfGhOY9tIhwikEKw6BKwcfONFI3l7wSxOa/RNK8FNemDspci3ru4RiqD08+Wfv6UnMfT4JsoGPA2LcFNt1KW6BAYLa/zndekjBj/pcXPAZGBCxQn5SThSSYPR+rCu4y4fYAnhJgwFnP5OndKNcMdbhrWZWRkFajoP/OPnHun/q3KZ9JMG2gNbELtZ3kuAcSyUBeBgBK/hWODuuAukPQwr/DfJQAe9pXeYwYhnuOMJridQE/tyR7rBD3wKw+2o15hWThya+u92LrAAkkkCwIOzekrXdamTeZSkVy3yyD1KXlgUa+cXMBAH1RQsxerQNm9dj56tc5Hzbm0aZqTvhx5aNCNfBS0khTP3xylFsQxE+x34w5XozGCKbZQmdfozUjr47a1+zOgqImL1+1xrDH5GE475ISvExGdcboGJEX+EFzhIvobYjCAuFQImjzM/IceW4Hz1vI7v+PNh7SdPEN11dHc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: LYE2GRjsPgkWPSYtu23CJLWgAOZaMbQNEmX3rJ2mArUA/LySwT1MzjTdEL1kNjX12nqEGczdom9q7YTwijE+7kvknUTYMNEfhhrr9nvxZvt/AOf8mm++VCiws4zBxxIOGpQY8UIXW8fB6Mh3MZ+TjEfqBWj16vdEr+0XnKdEdLLqtp2edzMsno4US0eaourLxXByICEkzriD+d4I1gHAxrb25uTkIjaMNe1RF+YV8HwGwJMVIVh8Y4aOOuE9Pia59RFeXEkzdj2HvzD4biUQghI8nacyVVSVPSCwCK3Pm3Xu7CVcmvy9UQ6V311TX+JH+ZBpPU4IWfkdv2ZtCfJGbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000527.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9544c009-cded-4c73-399c-08df18ea7f6e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|1800799024|36860700016|35042699022|376014|23010399003|10067099003|11063799006|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: WSiOHUfZA8X+fVf4bkD/AoF9KMbDW2lLux1yGNXoBGI14RwaCCahNqT4aYAQfAhdydWaV1fVCOGRRQDHlnBWbTyK6R7iE0FvX/9AAnsQMHOXCvuqPvb3A6oJ1zrGDI5ZGSvtsF1mcxqSygcwBMGJNpYoJmooidKdZxXRk/eAAVS5vb9kngR6UL4a2QjT9m5aTnA+VoooMZpfRSeFiLfDpo9FpQBzqb2AjWAzy9f9nSnMznbQV2RnURURHMHx/0QYEaw8MdaE6h/mjyxmL/oiuSdjhdsyzlrJDAYUFQ0fTJh4jz6ilaDKfMkuk0DMxBV1jX77hcm75zkPN4M6gpThtrhQzaxdGOLkJFSUHZpv73qvsBEyEWK1IWh3YaZNEUDdS7vhMg/yULuj07f2zCyLR07H4x9ol0x+WH9y8xf6O6YPxiJkxgQeSGgC/FlXBjq32zzxvMOTiTJ13IZ2Awoc+Bx8lNr3C1ShxCHVVBE4XY+fAUcxzHJBTX4g6aGGVjAyi4qGjrMLcJJVtOvthcwG5vwipVm2kSTlgtAaNN2S18/4RYxWGGhoKFw1cspH9LQNWnC6Jlyyru6SgMX3kWX0mKSomeYaecJtGKyN+DAdMSxXqxh8u6OgqtLhhObKR3B+RcePh9Ejga0EKv1MoKWp+RkU48fa873vkFeqA27xkIrVNFjF/g6hgcJVeLYPGLsLZK1hXRz1CfUGwyy8JBoh3w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(1800799024)(36860700016)(35042699022)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ev7X5/tb61tf7XdxPTjLd1+gS5H+jc7Q93AuTQw+fj8aQSp509xmrsTuLRujln+pRFTC0ViopSZPI7tb+XhhLEZiOH3QcRAnxoqTHzvv7leVdtEuYRXM5kp9DtpNlHuOgGo5FOLCPrphWqHsGYY8mnTP7Sb9hv7tO1hqEFQcQV4Z4XOWuUfjcfG493p3P4AQxNqGKGnN42z51h/O7+MjZd31JRGCX5OoZQrCSJ5JfrWjyqZpGrfvHtz15KJ9zsp5SWQHlhUckQjODXlUwcC2eXgBm1AGGdKKr+slnUWcsQv6If3S4U8SbaoM5mzFw9SVVLIRs4sP9uvqhDLWj2ShD+IR2qgO9Ob7luG95nXcnnlQje/vyyD7vdLMSYUvgD3vMwk1CsauVv0IyIAjyQIY88VNUQNbSODiM7EP43TCSvMSciZ5auHKchHVX06TvvL+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:28.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe78540-3985-49ca-afe3-08df18ea9372
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000527.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB984667
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

This series adds HW-assisted para-virtualization support for Mali v15
GPUs. v15 GPUs provide 16 register sets for job submission known as
access windows (AWs). The GPU hardware itself is then time-sliced across
each requesting access window.

Patches 1-6 make panthor less dependent on fixed register layouts by
caching decoded GPU_ID fields and moving register offsets into the HW
description.

Patches 7-9 update dt-bindings and add basic support for v15 GPUs.

Patches 10-11 introduce the GPU-wide configuration driver.

Patches 12-21 implement the time-slicing driver with a simple
interrupt-driven round robin scheduler.

Patches 22-27 update panthor to be time-slice aware as well as
being resilient against the GPU being yielded at any time.

v1:
- Rebased on drm-misc-next.
- Added device-tree bindings for the GPU and virtualization components.
- Improved GPU identification and register handling.
- Updated AM messaging to protocol v2.
- Improved GPU scheduling and recovery from timeouts and failed
  commands.
- Added access-window assignments through device tree and earlier GPU
  release when another window is waiting.
- Improved power management, driver setup and cleanup.
- Fixed races involving GPU resets, loss of access and late grants.
- Kept frequency reporting available without devfreq and documented
  scheduler timeout settings.
- Link to RFC: https://lore.kernel.org/all/20260528150546.3168527-1-karunika.choo@arm.com/

Kind regards,
Karunika Choo

Karunika Choo (27):
  drm/panthor: Ignore -EOPNOTSUPP for shader-present nvmem lookup
  drm/panthor: Move register access helpers out of panthor_device.h
  drm/panthor: Parse and store GPU_ID fields
  drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
  drm/panthor: Move register base offsets to the HW description
  drm/panthor: Derive MMU AS register addresses from base and stride
  dt-bindings: gpu: mali-valhall-csf: Add Mali Gen5 AM compatible
  drm/panthor: Add Mali v15 hardware support
  drm/panthor: Skip devfreq when no OPP table is present
  dt-bindings: gpu: panthor: Document panthor-system bindings
  drm/panthor: Add AM_SYSTEM platform driver
  dt-bindings: gpu: panthor: Document panthor-arbitration bindings
  drm/panthor: Add AM_PARTITION_CONTROL support
  drm/panthor: Add AM message helpers
  drm/panthor: Add AM_RESOURCE_GROUP support
  drm/panthor: Add arbitration scheduler
  drm/panthor: Route arbitration events
  dt-bindings: gpu: panthor: Document AW assignment DT property
  drm/panthor: Add AW assignment tracking
  drm/panthor: Handle partition control INVALID_COMMAND interrupt
  drm/panthor: Request AW to yield GPU access on idle
  drm/panthor: Add access-window support
  drm/panthor: Synchronize HW component PM transitions
  drm/panthor: Route HW component PM through access windows
  drm/panthor: Tolerate access-window loss during HW waits
  drm/panthor: Prevent missed post-yield cleanup due to reset
  drm/panthor: Release GPU access immediately for out-of-band grants

 .../testing/sysfs-driver-panthor-arbitration  |  18 +
 .../gpu/arm,mali-gen5-am-arbitration.yaml     | 135 ++++
 .../bindings/gpu/arm,mali-gen5-am-system.yaml |  76 ++
 .../bindings/gpu/arm,mali-valhall-csf.yaml    |  26 +-
 MAINTAINERS                                   |   2 +
 drivers/gpu/drm/panthor/Kconfig               |  20 +
 drivers/gpu/drm/panthor/Makefile              |   3 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |  15 +
 .../panthor/arbitration/panthor_arbitration.h |  81 ++
 .../arbitration/panthor_arbitration_drv.c     | 451 +++++++++++
 .../arbitration/panthor_arbitration_sched.c   | 755 ++++++++++++++++++
 .../arbitration/panthor_arbitration_sched.h   |  46 ++
 .../arbitration/panthor_partition_control.c   | 428 ++++++++++
 .../arbitration/panthor_partition_control.h   |  29 +
 .../arbitration/panthor_resource_group.c      | 323 ++++++++
 .../arbitration/panthor_resource_group.h      |  22 +
 drivers/gpu/drm/panthor/panthor_am_msg.h      | 159 ++++
 drivers/gpu/drm/panthor/panthor_aw.c          | 628 +++++++++++++++
 drivers/gpu/drm/panthor/panthor_aw.h          |  53 ++
 drivers/gpu/drm/panthor/panthor_devfreq.c     |  31 +-
 drivers/gpu/drm/panthor/panthor_device.c      |  82 +-
 drivers/gpu/drm/panthor/panthor_device.h      | 131 ++-
 drivers/gpu/drm/panthor/panthor_device_io.h   |  83 ++
 drivers/gpu/drm/panthor/panthor_drv.c         |   1 +
 drivers/gpu/drm/panthor/panthor_fw.c          |  12 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
 drivers/gpu/drm/panthor/panthor_gpu.c         |  13 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  44 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   3 +-
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 193 ++++-
 drivers/gpu/drm/panthor/panthor_hw.h          |  56 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  45 +-
 drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
 drivers/gpu/drm/panthor/panthor_pwr.c         |  29 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   2 -
 drivers/gpu/drm/panthor/panthor_sched.c       |   5 +
 drivers/gpu/drm/panthor/system/Makefile       |  13 +
 .../drm/panthor/system/panthor_system_drv.c   | 304 +++++++
 include/uapi/drm/panthor_drm.h                |  23 +-
 40 files changed, 4193 insertions(+), 175 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-panthor-arbitration
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
 create mode 100644 drivers/gpu/drm/panthor/arbitration/Makefile
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_am_msg.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
 create mode 100644 drivers/gpu/drm/panthor/system/Makefile
 create mode 100644 drivers/gpu/drm/panthor/system/panthor_system_drv.c

--
2.43.0

