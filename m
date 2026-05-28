Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF13CD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 086F310F352;
	Thu, 28 May 2026 15:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="reYIqc12";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="reYIqc12";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37F810F335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:31 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jiZpZ0OUbfLRl2B2IU5fy1Yss8vRdCA3RISkQFfPH/V7IxfoBPGkt87CbwNAN81ZXEgni36jnQK3FXm+Js2zpVSYAklM1X4wM2NL6ZJv0akgOUcMzjz8ID5ae1K1jalANnQtP48zQsq2C2BroJ8GBUsLj9+LmG2s1xzLU0/ecvBKmu982kkT1P07a7xuoRcHPno8+Fv9YvF53T/SmTtnIDltB8SETHIyYyQckGYxy5P8fV9pFEtIXm0+1h53WNt+uaeCzbie+PjMYgpiNERo0FFcGNh3BiM5CVLTODbE4CiOVS4KqqlnRuL7RwV6tW21V/s/tDAmPPqwnPfWFvUyLw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHO6gZg8CVx7MINayXVwxMkx3G31mn71D7xZPPWmgeU=;
 b=pFXUcOUJLo48ZwRymvkno1ESoUpDftl618PTeJwvYNrr34yqoM8UhjEyLbrItb9hjJW3cQ0zi8mDJMK5EnSq33iEjFri/M3aeXDk47uYOMPL6YZ5XBXSN200a2Zf3DyqU5GIHJYPRforCGcrUcW30vMm3C8VCbgzt28xO2xnBWDvZra6bZRSTqvb/m6/p8934Ez4qXUfdas9nZIXryXi0euo4V1y7PcPfcLCcZWurojW7ZVEMtX1O71Kvcx1peQYMbiBQwOulII6nWLknYr5D/YqaEGu8JA5+MkZ0azfzO9BvLm++EFUprG2gm1c6Km/JJVAqUOpsLoYrXKKeAivuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHO6gZg8CVx7MINayXVwxMkx3G31mn71D7xZPPWmgeU=;
 b=reYIqc12nnAgqsFVmya50WmH9/ipFk4s5zUxzL48xAyYLh0J4OSw+BsZ0q0sm5MwI9pSKH8CuHps07JFXqxNKgVAwfATYtVT3r+o52PKkpIGMpXbyCChtyHZrtUQUwjHG1A5kzUvdgmLqEgNqMXFotzzYieGQLLTDHEdS13bWkg=
Received: from CWLP265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::17)
 by GVXPR08MB10688.eurprd08.prod.outlook.com (2603:10a6:150:153::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:07:21 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::1d) by CWLP265CA0414.outlook.office365.com
 (2603:10a6:400:1b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Thu, 28 May 2026 15:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpRcyjvKpd1kC/Grt3vZNT4zcg8xRvGWecrDBZKh6g00QBYczkgdwIYm7Fy4NtxMjjC1Q84bEhugGYRkrckhZVkS8EuV/Xy06hIBGZ0WLh/IamxpwZvyow816KuorUTqweGer547EuGMHuHP28hL3WL9U4syLLM8l2eOixkNF6crGO0cdFaDpz/4t2rQS5jZzVCih9JhqxSri6inS+QpBorE/BPKZCYoMcDEe5Zeujvp3rQbU/nNAwnIUACHAQdzY4caZt1RJ2/2pzqdu39TneB6TiGSkXKFnK0bLD/eqQlnbdDXoEjWENGKaQgV0sVefW/axPG0ZMUYoE51h7YNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHO6gZg8CVx7MINayXVwxMkx3G31mn71D7xZPPWmgeU=;
 b=qY63skG4ePcnCMWJ7oRnaGZB6Lk35bIk4LnIhUXaJazucaIZ6w6IfyusibbBkMwg8E6/aINarqgFTLxkPU8bowbkPsFzpB90/SKR2efvfYkO/NZQNtfEAdvMT+hBfTw592eXwMD0s+aHLM3WEye5N3zlrPXITtwoWV9fbg/PIu1UCiNOcIaBCV7Lc0tJL0A49Qumox3XisISC7De8PUMP4wHNZrpO4//3tLR2WN/v4D9mzCuTM5hQq2Pxkoc74+TNRfJ8qJXi6e2VdsU99I6yE+6t4+izesq69V6yTenEtWjYZF7Ho18enN1IA+5dlz25hMaEYD9dR/ZQW6fjH/57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHO6gZg8CVx7MINayXVwxMkx3G31mn71D7xZPPWmgeU=;
 b=reYIqc12nnAgqsFVmya50WmH9/ipFk4s5zUxzL48xAyYLh0J4OSw+BsZ0q0sm5MwI9pSKH8CuHps07JFXqxNKgVAwfATYtVT3r+o52PKkpIGMpXbyCChtyHZrtUQUwjHG1A5kzUvdgmLqEgNqMXFotzzYieGQLLTDHEdS13bWkg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by PR3PR08MB5754.eurprd08.prod.outlook.com
 (2603:10a6:102:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 28 May
 2026 15:06:18 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:18 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 18/18] drm/panthor: Tolerate access-window loss during HW
 waits
Date: Thu, 28 May 2026 16:05:46 +0100
Message-ID: <20260528150546.3168527-19-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0553.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::7) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|PR3PR08MB5754:EE_|AMS0EPF0000019C:EE_|GVXPR08MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: f1582b5e-54f3-47a8-1ab5-08debccad146
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099006|6133799003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: OE7W/K3kBsPYnkel28DDL7SdtyY+67Q1/ZX+FPIljL87RY9PacmTvVsdmEa3z7GO6sHuKOiSiwdqu8EtFn53X9/ffJHYh+vwfUftLtjP2+EqIUkKvKSKwT+BfLpI9HoebkCcd5BQktRk8MKwsvllfVDbgRdUtAkSyIdAH27A1O60LKUwbAlt8LGhU7FVVedeRpVCgCEan+SCpt10us/H9/8+GR71JotCp0JrfbqfmSKZ5xYb45Y9PlATh1oJFmXGy2lhaHJJtix4fRBBK9AT4nEKj8DWi5nJS3+8S4gyjONVE9BBTvWlpASaIa76sw5d80UuvoC7c3MdX3inq+x5VCt+BjQmlqtJWgM1uUtXHyRrJmt/o3jHYhx+VDptdg2emSVJL8ptV1/w+mxT0jWjSDMEFKIaE/JcIX+PD3A7WxbupuGowpR7u1OHcpzMA8T9qByZzYUgXn4FXvL05oE3056mPMoQqdhctIwd+TQ/eXM+0876zaCoXKQptb0f0I65LRw9AAN11Ytq4BsFWNUnhYkUhyN7/ZJXlFICJ/1gq3NUDHju/xMHRof+ApWeF5WDqsvNIEh0wp+K8ysMPrWbjWTSUnh44U7Xwe0D+1u0kphsifmlZP3S49eP2iBNupBQRyyCubJnppCeBaoV7oZij11TDrwrH6rqEzqdghjAkYBas2V+vJy5D1wBBv9r/EZD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: e1Mcw0BAsF8G3L23nd/cXRUIf6xZP9k2A2Y8OCestN9grD2BgyPrxX9q6Qto4GVn9ZpbP3/017qLNPVwPsd0WuWDXNpcmDeJAZmyCy05/bRPPgGgHYiF/TFtBxO4rrTUL6vOOSsv7VfWoobGzKom8W2iCA+6JwEbET/KRVeiY0FpW1AaKqzprPHzByaYisR/E4HTtwv2cM9ZZaNpGoKykhyKsvaD4h2wzqQa0+4mKOc/pNpBYDolvTNkhg/I4Nco9RgCI4NX+e3Q+w+Cu/ENHXd/JZ2/eUnNuNpUJdITbo4OxE07ceIQqAH8rJYvsrzFBF3AdxgLVymzyENIdMnNUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5754
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 25825e00-4e30-4812-84c9-08debccaab82
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|36860700016|35042699022|82310400026|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2M7582sSgSXIM7Lm3bxAmZLX3Rjm7GvP99OZkSaONe3S/7GSQGv6fU4QBHF8felOdy3sdQfuSJFWDU/rC84ZDxIUdzZlsBr+CnGMBY4H8fgd+uv8B4BGMxiJa15E+WpAILVLdlPvEANGG+VTDmGdJf193c+LEi+ccYyCWTE9x8URwgf7/T5qrC9IBv4aClZ/JkBtRv72SH1zhD2FDXOGSI6EyiuJx60EMoZjhvEeWkqrdJx2r/7kwhRJRL3dRlpT78I43hveCvTMY6n24W70MBi2OqDMMDY2nw6TM1azJgg5EuruZfx7IwmkUxpFXpfewtPQrteIkWUabQaCdTfEQVExd4XcK+SEAce6auu2KWP0hYAgWKGb21z5Ws9v4h7DHgEfx6bmxmOEK5YzSctAQFDd3NilYlIa/+ma4QYbJafssqroZeclFlkZzq4oAeBm9ZvYpPIeCleaq9soHI8EMHtYt9E1f1QeYXUuuZ9Q90E5maWGQifE3YD1KCxHeDfYFurgiUWBehde+Z+l3PMVZIbfqs4GGQJu2znk61Z48QBHEtkMmmPk42zyQZPjGrNa1jQ5RFUnokUr5AR1D5diRthw9xqjY7yiDZYfKCb4kNX/2X0p0gGyfwqK0Z8h2u6EbvPDDd4q3CzmQwKFnRP90vhind9y4XDJ+1QeRaMts5zv13yDFjfXYCFzlV5hf0+7maCVfx4O89wp3JNtlGsklOL0LgzWMWbCUsgsqTGLp38=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(36860700016)(35042699022)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8CthnJG6ikt3t/9JbuR1NK51yO9jEmX+EVCJwVdfYwGWeFnSA3NYZa0xmRY4FJWScCohpcxPW4iPDz2NVWQDGI0BkSdX74/Q00iyREZOO0nYSbjnb6bcaz8Bvweumq/vUR3lFnsJuOsu1L0+Z9py2QbEyTUPpWUX29Ir7FPawZY88XN2MyI9WeVJrDaILHNLwv02tjaftIC+f7YuQqe7FtnjiNHGy6eK6HTjufDDGOcOY4yDYbU4MpxYk5YjtOYyHr8SDhJd8M8I65S6bcjkpCq3mYSauKpoJ6rV2GUFy0HVb5AWEo2yfd/t2aNNGwfVKei6vI/HgsqCA8AyBc0Diw39VJWKyOv7/GTrl88XdCBOx80k+uw4kDS8bhIAG6bVkUCh2cKNOWHLjWQWV4ajekhcdnlZmWDzT2DdNF+ZBo1cXnPCBSantoQf36/SGQTQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:21.2575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1582b5e-54f3-47a8-1ab5-08debccad146
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10688
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

The arbiter can close the access window while the driver is waiting for
GPU, power, or firmware acknowledgements. In that case the pending MMIO
wait cannot complete, but it should not be treated as a hardware timeout
or trigger recovery.

Add a helper to report whether the access window still owns GPU access
and use it to suppress timeout handling once access has been revoked.
Also skip deferred scheduler FW event processing when the window is no
longer available.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_aw.c    |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_aw.h    |  2 ++
 drivers/gpu/drm/panthor/panthor_gpu.c   |  4 +++-
 drivers/gpu/drm/panthor/panthor_pwr.c   | 27 +++++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_sched.c |  9 ++++++---
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 7c7637a8a9f1..f23022e2b4cd 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -566,3 +566,11 @@ int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev)
 
 	return panthor_aw_resume(ptdev);
 }
+
+bool panthor_aw_has_gpu_access(struct panthor_device *ptdev)
+{
+	if (!ptdev->aw)
+		return true;
+
+	return (atomic_read(&ptdev->aw->state) == PANTHOR_AW_STATE_GPU_GRANTED);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index 7a46a1e18093..1da613fa330a 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -41,4 +41,6 @@ int panthor_aw_suspend(struct panthor_device *ptdev);
 
 int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
 
+bool panthor_aw_has_gpu_access(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 3c88a25287bf..129bb3779ebd 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -17,6 +17,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_device.h"
 #include "panthor_device_io.h"
 #include "panthor_gpu.h"
@@ -352,7 +353,8 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED) &&
+		    panthor_aw_has_gpu_access(ptdev))
 			ret = -ETIMEDOUT;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index b833e4559e45..0c3fa311c1af 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -10,6 +10,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_device.h"
 #include "panthor_device_io.h"
 #include "panthor_gpu_regs.h"
@@ -118,7 +119,8 @@ static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
 		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);
 
-		if (reset_pending(ptdev) && !reset_irq_raised(ptdev)) {
+		if (reset_pending(ptdev) && !reset_irq_raised(ptdev) &&
+		    panthor_aw_has_gpu_access(ptdev)) {
 			drm_err(&ptdev->base, "RESET timed out (0x%x)", reset_cmd);
 			return -ETIMEDOUT;
 		}
@@ -262,9 +264,14 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 
 	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val,
+				      ((mask & val) == expected_val ||
+				       !panthor_aw_has_gpu_access(ptdev)),
 				      100, timeout_us);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base,
 			"timeout waiting on %s power domain transition, cmd(0x%x), arg(0x%llx)",
 			get_domain_name(domain), pwr_cmd, mask);
@@ -326,9 +333,13 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	 * allow-flag will be set with delegated-flag being cleared.
 	 */
 	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
-				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
-				      PWR_TRANSITION_TIMEOUT_US);
+				      (((delegated_mask | allow_mask) & val) == allow_mask ||
+				       !panthor_aw_has_gpu_access(ptdev)),
+				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base, "Retracting %s domain timeout, cmd(0x%x)",
 			get_domain_name(domain), pwr_cmd);
 		return ret;
@@ -383,9 +394,13 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 	 * allow-flag will be cleared with delegated-flag being set.
 	 */
 	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
-				      ((delegated_mask | allow_mask) & val) == delegated_mask,
+				      (((delegated_mask | allow_mask) & val) == delegated_mask ||
+				       !panthor_aw_has_gpu_access(ptdev)),
 				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base, "Delegating %s domain timeout, cmd(0x%x)",
 			get_domain_name(domain), pwr_cmd);
 		return ret;
@@ -512,7 +527,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 
 	/* Abort if L2 power off constraints are not satisfied */
-	if (!(pwr_status & l2_allow_mask)) {
+	if (!(pwr_status & l2_allow_mask) && panthor_aw_has_gpu_access(ptdev)) {
 		drm_warn(&ptdev->base, "Power off L2 domain not allowed");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..f4bfb8fab0dd 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1875,7 +1875,10 @@ static void process_fw_events_work(struct work_struct *work)
 	u32 events = atomic_xchg(&sched->fw_events, 0);
 	struct panthor_device *ptdev = sched->ptdev;
 
-	mutex_lock(&sched->lock);
+	guard(mutex)(&sched->lock);
+
+	if (!panthor_aw_has_gpu_access(ptdev))
+		return;
 
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
@@ -1888,8 +1891,6 @@ static void process_fw_events_work(struct work_struct *work)
 		sched_process_csg_irq_locked(ptdev, csg_id);
 		events &= ~BIT(csg_id);
 	}
-
-	mutex_unlock(&sched->lock);
 }
 
 /**
@@ -1983,6 +1984,8 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 
 		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
+		if (ret && !panthor_aw_has_gpu_access(ptdev))
+			ret = 0;
 
 		if (acked & CSG_ENDPOINT_CONFIG)
 			csg_slot_sync_priority_locked(ptdev, csg_id);
-- 
2.43.0

