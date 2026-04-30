Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E2FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1326210F2C3;
	Thu, 30 Apr 2026 09:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LuTQvPGl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LuTQvPGl";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D237310E132
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:41:42 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LYrOteUUF3xKOZQYM2g3bihXvVUl/EvCiGo6V+HMdI/rVVpTXwEMgB6FkbzSKgI1hnUlGuiXy39LR7qMq5/ZOeyn4t0iVbrsDBqDYDUETcvDdaTgiRVA0646amEveag+BRnVO8DgDK5RShOc5BVwzGJDspnv7e2hQVRMKQXOCcUkHxGlcU8tamBFCiyFjR0IWjJFoLQ0RkOCa2+dPR4vi7o9GbetqtK/704tOkGWPhaJXc60O8BNcR5lPJY8Rt82uuVD33euCQV2NcaJvPdm0H5ZtQSOGG46MPFjvrBootZlVGFSF8GD50iXhFV40ObTs+gjjKlPztdkRDinWwWnXw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omZqrddiDzsRgfSEYVscjt+t/IghU0+dRTxpdr2InQU=;
 b=ut5uYcSgfoUPTSbmjBP5uiATyoSBoTmWSmq4QUIjHHTpYNBFiENdJYc/V/gscwI3k+XHYUfThJyiYndk9+rmgzkPnB8qx+ACeRNyqs7mZErhb/dh/DP8/bXyK+1Gm7m/62hUUSkh38QUis+E0pkterIqgnfUcAeWCDdGIUwTIYrBvjs7dAjASMtZCmCzPmDkzf6I2G3fvLkrYv0H7lA+ZteT4R4yN0KefmTJ7KGF3qCG5Exz45JtbcLDPXf8tMuSrEerRmBeN8+LznycYR8IfQEU8I50jtyTZZgD6nWRSdKUTiLnrmeJ9MFFIdPet47E/XRi3B6u+4LnrcbbQhO23A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omZqrddiDzsRgfSEYVscjt+t/IghU0+dRTxpdr2InQU=;
 b=LuTQvPGl5q+191IRmYY8IG+q95m7MWFVIF/7fRKRoTtpMoTtRL8O4iNJWhOmjxwlnC1oLhnmPpqkw2NQnT4WFkVhGeaG410NHT19No9pOxAgGhT39NMrgHiVBwGXIFfRAvLt1Ziya9ES6yIpY20geK25y4G5nVhjmX1qcOukTCo=
Received: from AS9PR05CA0065.eurprd05.prod.outlook.com (2603:10a6:20b:499::9)
 by FRZPR08MB11000.eurprd08.prod.outlook.com (2603:10a6:d10:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 09:41:39 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:499:cafe::8c) by AS9PR05CA0065.outlook.office365.com
 (2603:10a6:20b:499::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 09:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNhf/3/54th7ODUY34IpsbLct1spCCoxnPQPvjrVU+71OTvwxh1ZoPSBNww5ennJJhNilpUJ19HsCX5CXsJAMVxnqpAZKtCq3fdsSXtmxx3YCxK8FGO108KB1c2Rxd3XZGpECLjgccBuOAn8MvatWuQfaz2eNVY+rksPV9Zf9Z5Ujh0A+1JlkzH95Jgr3N2gMnkNev+JdlO8HcUdmppBpbmPf4nuPdgqGPhKI2V64GWPcnpHMFzlTAxGxwWrHoDLPYbvZPSOI2uakXrWmKR1zw0Ia4p+wbUVwtsl2b3QogtnHFJ76BdHC5FduRPk+6HUD0w4wZ4y6468LIrZWN/PgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omZqrddiDzsRgfSEYVscjt+t/IghU0+dRTxpdr2InQU=;
 b=jq9uPNmnphbKmQZRibYVRu+PWoyhGuPzd+9mbCjZu2/El/azuq5X6SM9Ed9aZqxScg9zl0Vi2e2npLAsaktgwHB9gwajT7Ts8H/XZWYu6rfpbkhe6amTj3hTliO1kf4x4E/z3dhfi7+V6kcmIMdlsJM6lQ3J1eQpw2VAopD7eoaeJ4z2me3yqBea434bLu1TZEOInePl23SmmpfaSDoDT6vfnuH1mPLd8i1Z5vcBEnCjxgL2l+JJv1aDo5vEpkY+yCwJgBitVwZWabZzyZDaYinMTkZ7r23T8WcMoJ2E20lAzfolRqYwa9Es0NrN8Y57z+T0hjCCPEWM8NjsWrDVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omZqrddiDzsRgfSEYVscjt+t/IghU0+dRTxpdr2InQU=;
 b=LuTQvPGl5q+191IRmYY8IG+q95m7MWFVIF/7fRKRoTtpMoTtRL8O4iNJWhOmjxwlnC1oLhnmPpqkw2NQnT4WFkVhGeaG410NHT19No9pOxAgGhT39NMrgHiVBwGXIFfRAvLt1Ziya9ES6yIpY20geK25y4G5nVhjmX1qcOukTCo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by PAWPR08MB9032.eurprd08.prod.outlook.com
 (2603:10a6:102:335::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:40:34 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 09:40:34 +0000
Message-ID: <5d6f4531-7359-4d58-9c00-4d6bbc4b739a@arm.com>
Date: Thu, 30 Apr 2026 10:40:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-3-4b92ae4142d2@collabora.com>
From: Karunika Choo <karunika.choo@arm.com>
In-Reply-To: <20260429-panthor-signal-from-irq-v1-3-4b92ae4142d2@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::20) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|PAWPR08MB9032:EE_|AMS0EPF000001AF:EE_|FRZPR08MB11000:EE_
X-MS-Office365-Filtering-Correlation-Id: c6740911-dc11-48ae-3fa9-08dea69cad76
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: qIUxl/5WrEBXa4T9YR4C/vU54WkDe4TYJNYuldeJcZj4FCovGdp0SODp4a3KMJa1EByQuk/V070p+RSJ5bD7NuCp6q7xJWEqXEYBmlxiM9t2tfVgdCIsY8SPVDuoawj7+tXyli3lAPGpAgFPqO122zdAFLjv0+XhBfIJUBDwGAMABUqwS0cGtYNCCQHidN1vRQz2mizKsr2SeAs6NUdJ0/zcaMkju+rPKkeqQ6AqNB2CSHNbJZpcR9A+M/VmaD46TYICnDvS6mE1lQLKBCVwXMxHTaCMPKJ62ZzqdmaloheNQ3uiW5ugl+Dd755PV8tohxlLv3Z+i+zmDAXMbEnnmEoF+cD8vCMF74y5d4B7hHlRpwH0UK5OQiy3VZbS8dOoc+HsZFoGlj7BHq4RhBEy9FCt5WYTg1JZSrhI1coFFEmqemdlikxajElXNZcnCU38GGSuDLX7wQdMKk0Uf+98NOBArgLQM5NTaVyDMqP09XIotTO5C+R4q4Db+2fdT8mfxL4LDM/Z+zqwW94pZZa8fX3R61/y3Plza86Fw2xGF0y/XGlR492OxEm2BQcxt5CVDLtRrF1tijtBv7kJ/dz5Qdc36mICc8CFxdOVpK3xU4xiIwelgUIUjeUTsgzhYyaeT7/74DmK+CUIvLCsvlVgQXMb9VDyRlipswIkkWhmeQ/0tJieRfBTp6OpnjNZsKZYop0wVjwEhaKBI5+9+UyYk9DWo4BGdP1Uj2SPJvvXrYg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: mWLQmBgoIBTsMT6rYWw2rDFVca5VaCr4TTLwjpgyc3CJtBMQXKaH8Sbwme7LaVnYQ7nMDQZHHMb7fq71PJDAS0zTaydKL7NljWT7HnmNWI33/P8usWUVjiBKUIlLjWpDqLPxqn6hmYCywUcw42W2YVqpZ9mkf9In7rNA95lH5Vfb70YHLlVCWM+aDptwJfUE1rzLQG2fws/ap01xbKtkqwhHMblsOgmsFAorwwKRXNJX9UeBleQqp2of5VWz0WsJ3guRLgwwmTUj3s1wQQMQEjsOmxk1Chmd0LInu0O4pz2yANh+L8B7s6zfd7Sy5ML8Eq75VsRFuhcQHUPb8WUBFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9032
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c7abffe4-a212-47e3-a3af-08dea69c86bf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gVNYI0DaDC7N7d2x40RyFC6mGb96rbk4nqlOjMgn3M4DDXvJXNEOetj3L4llAlyn8/JiBtGLEeRRTC8Eq1k/PlxquTDolGHKvr+JmWf/fR03YceEsRcx2Ey54HQ7dseMJgJL+3PXsttIHTHf5W9ECUBTteS4CNnZyWaMqaaGGyzgwsl6erZhtsxmHOQWkY0QjzOguQ2mVyAFuuX0trfM9JCZ9p3rGZJcBNZjJ9y1BYMuhU1Qhwr6RNgUwX+mo1HO5E+XWp1aX3wcJrRR3OL98k6LYGC2Y5M0ZVBT3qqoOQVmIAX0uzkbXpFfl1fze4FTy7jNgN/sF0R8VInjoYqFCuwRJU+mmTADO1+/x7vmVv9Gidr2egjkGNcqZ2MNhzrbBLUVvg/qMnx0K3wmwUMxfpqfEiv5cOMKHDLExsnFXtxjkHgFR5CvD3sDwfTqkZXTPb2lAxZeBKpvlJbFs6TUpLE3Bbhdeo650FYztL0MWp+RI2HcU3b3781h5uTFrJqJdl58ttJc4wT3ED4m3f8cqOqmEpMYXqz8Kcp7/ZRu3gnJmZ9EBcj3qU+zd3GqBs3U5gXBhaYTk4W/86KoXWDfRgQP2RZ52L9xRwSKdnNVinh3npeZ0G2xlubA2PwEGMMsaw1f1l+vEtl1wFbI7u+nofqVM8HtHGt7CewkLNlsKUm58pZ1VilbMWq4Nvq6QJAnfTF89KQdVz89RpPmlIb4dY7wQFEGZ5clN3bckdBbcY/dU8UbCNVGilcNqvIxkUOr1uaIfI4hvke2oojAmI2yhw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dvWqBiXT/ZFFMWRT86g80AaF3QpvdncK0cPTPTuywkT60XJQRqvgVKgD1o08LD3THWcEqJRuwPJjv2+pzTCNRnzAdHAwBu6XUAa26001ZMoxxbJY65h8LUmwT6g88jBgMPNpl6hYOKGAt8/yyMO9hZ8s09MK5DK+0oMu771q20SK2qYtfUrGsfMniMOBgVzujoCGEz7ZETTX5WOFiEfj/DMnmtM241iuF2LuWbnVPdItXoqrxtDdLm8hX2AmdH+B3QYSxE6XAjI1HtvsYl+1afTtcjZDbRwI0r4ZBqzwh8dMrP/arKv62SBj0r8kWxNJmCWGh5qTUneccwd0Z1Dz3g2dj2gcNgGVwghqtHcRwJqBm1LQK5C/TugirYGLlb6NZiq9k06MTmAUdOSE5INYHxy8iQzGaNXEDQMP5CMm6B5uxr8kFy5TDPUgNYRui6dd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:41:38.7506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6740911-dc11-48ae-3fa9-08dea69cad76
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11000
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

On 29/04/2026 10:38, Boris Brezillon wrote:
> Now that panthor_irq contains the iomem region, there's no real need
> for the macro-based panthor_irq helper generation logic. We can just
> provide inline helpers that do the same and let the compiler optimize
> indirect function calls. The only extra annoyance is the fact we have
> to open-code the panthor_xxx_irq_threaded_handler() implementation, but
> those are single-line functions, so it's acceptable.
> 
> While at it, we changed the prototype of the IRQ handlers to take
> a panthor_irq instead of panthor_device, since that's the thing
> that's passed around when it comes to panthor_irq, and the
> panthor_device can be directly extracted from there.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 245 +++++++++++++++----------------
>  drivers/gpu/drm/panthor/panthor_fw.c     |  22 ++-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  26 ++--
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  37 ++---
>  drivers/gpu/drm/panthor/panthor_pwr.c    |  20 ++-
>  5 files changed, 183 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 768fc1992368..afa202546316 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -571,131 +571,126 @@ static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
>  #define INT_MASK    0x8
>  #define INT_STAT    0xc
>  
> -/**
> - * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
> - * registration function.
> - *
> - * The boiler-plate to gracefully deal with shared interrupts is
> - * auto-generated. All you have to do is call PANTHOR_IRQ_HANDLER()
> - * just after the actual handler. The handler prototype is:
> - *
> - * void (*handler)(struct panthor_device *, u32 status);
> - */
> -#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
> -static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
> -{												\
> -	struct panthor_irq *pirq = data;							\
> -												\
> -	if (!gpu_read(pirq->iomem, INT_STAT))							\
> -		return IRQ_NONE;								\
> -												\
> -	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> -	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)						\
> -		return IRQ_NONE;								\
> -												\
> -	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;						\
> -	gpu_write(pirq->iomem, INT_MASK, 0);							\
> -	return IRQ_WAKE_THREAD;									\
> -}												\
> -												\
> -static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *data)		\
> -{												\
> -	struct panthor_irq *pirq = data;							\
> -	struct panthor_device *ptdev = pirq->ptdev;						\
> -	irqreturn_t ret = IRQ_NONE;								\
> -												\
> -	while (true) {										\
> -		/* It's safe to access pirq->mask without the lock held here. If a new		\
> -		 * event gets added to the mask and the corresponding IRQ is pending,		\
> -		 * we'll process it right away instead of adding an extra raw -> threaded	\
> -		 * round trip. If an event is removed and the status bit is set, it will	\
> -		 * be ignored, just like it would have been if the mask had been adjusted	\
> -		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
> -		 * covered for.									\
> -		 */										\
> -		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
> -												\
> -		if (!status)									\
> -			break;									\
> -												\
> -		__handler(ptdev, status);							\
> -		ret = IRQ_HANDLED;								\
> -	}											\
> -												\
> -	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
> -		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {				\
> -			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;					\
> -			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
> -		}										\
> -	}											\
> -												\
> -	return ret;										\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
> -{												\
> -	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
> -		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;					\
> -		gpu_write(pirq->iomem, INT_MASK, 0);						\
> -	}											\
> -	synchronize_irq(pirq->irq);								\
> -	scoped_guard(spinlock_irqsave, &pirq->mask_lock)					\
> -		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;					\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)			\
> -{												\
> -	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> -												\
> -	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;							\
> -	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
> -	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
> -}												\
> -												\
> -static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
> -					      struct panthor_irq *pirq,				\
> -					      int irq, u32 mask, void __iomem *iomem)		\
> -{												\
> -	pirq->ptdev = ptdev;									\
> -	pirq->irq = irq;									\
> -	pirq->mask = mask;									\
> -	pirq->iomem = iomem;									\
> -	spin_lock_init(&pirq->mask_lock);							\
> -	panthor_ ## __name ## _irq_resume(pirq);						\
> -												\
> -	return devm_request_threaded_irq(ptdev->base.dev, irq,					\
> -					 panthor_ ## __name ## _irq_raw_handler,		\
> -					 panthor_ ## __name ## _irq_threaded_handler,		\
> -					 IRQF_SHARED, KBUILD_MODNAME "-" # __name,		\
> -					 pirq);							\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *pirq, u32 mask)	\
> -{												\
> -	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> -	pirq->mask |= mask;									\
> -												\
> -	/* The only situation where we need to write the new mask is if the IRQ is active.	\
> -	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()	\
> -	 * on the PROCESSING -> ACTIVE transition.						\
> -	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
> -	 */											\
> -	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
> -		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
> -{												\
> -	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> -	pirq->mask &= ~mask;									\
> -												\
> -	/* The only situation where we need to write the new mask is if the IRQ is active.	\
> -	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()	\
> -	 * on the PROCESSING -> ACTIVE transition.						\
> -	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
> -	 */											\
> -	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
> -		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
> +static inline irqreturn_t panthor_irq_default_raw_handler(int irq, void *data)
> +{
> +	struct panthor_irq *pirq = data;
> +
> +	if (!gpu_read(pirq->iomem, INT_STAT))
> +		return IRQ_NONE;
> +
> +	guard(spinlock_irqsave)(&pirq->mask_lock);
> +	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
> +		return IRQ_NONE;
> +
> +	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
> +	gpu_write(pirq->iomem, INT_MASK, 0);
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static inline irqreturn_t
> +panthor_irq_default_threaded_handler(void *data,
> +				     void (*slow_handler)(struct panthor_irq *, u32))
> +{
> +	struct panthor_irq *pirq = data;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	while (true) {
> +		/* It's safe to access pirq->mask without the lock held here. If a new
> +		 * event gets added to the mask and the corresponding IRQ is pending,
> +		 * we'll process it right away instead of adding an extra raw -> threaded
> +		 * round trip. If an event is removed and the status bit is set, it will
> +		 * be ignored, just like it would have been if the mask had been adjusted
> +		 * right before the HW event kicks in. TLDR; it's all expected races we're
> +		 * covered for.
> +		 */
> +		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;
> +
> +		if (!status)
> +			break;
> +
> +		slow_handler(pirq, status);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {
> +			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +			gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void panthor_irq_suspend(struct panthor_irq *pirq)
> +{
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;
> +		gpu_write(pirq->iomem, INT_MASK, 0);
> +	}
> +	synchronize_irq(pirq->irq);
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock)
> +		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;
> +}
> +
> +static inline void panthor_irq_resume(struct panthor_irq *pirq)
> +{
> +	guard(spinlock_irqsave)(&pirq->mask_lock);
> +	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);
> +	gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +}
> +
> +static inline void panthor_irq_enable_events(struct panthor_irq *pirq, u32 mask)
> +{
> +	guard(spinlock_irqsave)(&pirq->mask_lock);
> +	pirq->mask |= mask;
> +
> +	/* The only situation where we need to write the new mask is if the IRQ is active.
> +	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()
> +	 * on the PROCESSING -> ACTIVE transition.
> +	 * If the IRQ is suspended/suspending, the mask is restored at resume time.
> +	 */
> +	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)
> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +}
> +
> +static inline void panthor_irq_disable_events(struct panthor_irq *pirq, u32 mask)
> +{
> +	guard(spinlock_irqsave)(&pirq->mask_lock);
> +	pirq->mask &= ~mask;
> +
> +	/* The only situation where we need to write the new mask is if the IRQ is active.
> +	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()
> +	 * on the PROCESSING -> ACTIVE transition.
> +	 * If the IRQ is suspended/suspending, the mask is restored at resume time.
> +	 */
> +	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)
> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +}
> +
> +static inline int
> +panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
> +		    int irq, u32 mask, void __iomem *iomem, const char *name,
> +		    irqreturn_t (*threaded_handler)(int, void *data))
> +{
> +	const char *full_name;
> +
> +	pirq->ptdev = ptdev;
> +	pirq->irq = irq;
> +	pirq->mask = mask;
> +	pirq->iomem = iomem;
> +	spin_lock_init(&pirq->mask_lock);
> +	panthor_irq_resume(pirq);
> +
> +	full_name = devm_kasprintf(ptdev->base.dev, GFP_KERNEL, KBUILD_MODNAME "-%s", name);
> +	if (!full_name)
> +		return -ENOMEM;
> +
> +	return devm_request_threaded_irq(ptdev->base.dev, irq,
> +					 panthor_irq_default_raw_handler,
> +					 threaded_handler,
> +					 IRQF_SHARED, full_name, pirq);
>  }
>  
>  extern struct workqueue_struct *panthor_cleanup_wq;
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..eaf599b0a887 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1064,8 +1064,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  			 msecs_to_jiffies(PING_INTERVAL_MS));
>  }
>  
> -static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	u32 duration;
>  	u64 start = 0;
>  
> @@ -1091,7 +1092,11 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
>  		trace_gpu_job_irq(ptdev->base.dev, status, duration);
>  	}
>  }
> -PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
> +
> +static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
> +}
>  

Hello,

Maybe we can consider embedding the slow_handler into struct panthor_irq?
You can then always use a default threaded IRQ handler here and call
pirq->slow_handler when needed.

Kind regards,
Karunika


>  static int panthor_fw_start(struct panthor_device *ptdev)
>  {
> @@ -1099,8 +1104,8 @@ static int panthor_fw_start(struct panthor_device *ptdev)
>  	bool timedout = false;
>  
>  	ptdev->fw->booted = false;
> -	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
> -	panthor_job_irq_resume(&ptdev->fw->irq);
> +	panthor_irq_enable_events(&ptdev->fw->irq, ~0);
> +	panthor_irq_resume(&ptdev->fw->irq);
>  	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
>  
>  	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
> @@ -1210,7 +1215,7 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
>  			ptdev->reset.fast = true;
>  	}
>  
> -	panthor_job_irq_suspend(&ptdev->fw->irq);
> +	panthor_irq_suspend(&ptdev->fw->irq);
>  	panthor_fw_stop(ptdev);
>  }
>  
> @@ -1280,7 +1285,7 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
>  		/* Make sure the IRQ handler cannot be called after that point. */
>  		if (ptdev->fw->irq.irq)
> -			panthor_job_irq_suspend(&ptdev->fw->irq);
> +			panthor_irq_suspend(&ptdev->fw->irq);
>  
>  		panthor_fw_stop(ptdev);
>  	}
> @@ -1476,8 +1481,9 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
> -				      ptdev->iomem + JOB_INT_BASE);
> +	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
> +				  ptdev->iomem + JOB_INT_BASE, "job",
> +				  panthor_job_irq_threaded_handler);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index e52c5675981f..ce208e384762 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -86,8 +86,9 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
>  }
>  
> -static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_gpu *gpu = ptdev->gpu;
>  
>  	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
> @@ -116,7 +117,11 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->gpu->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
> +
> +static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handler);
> +}
>  
>  /**
>   * panthor_gpu_unplug() - Called when the GPU is unplugged.
> @@ -128,7 +133,7 @@ void panthor_gpu_unplug(struct panthor_device *ptdev)
>  
>  	/* Make sure the IRQ handler is not running after that point. */
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_gpu_irq_suspend(&ptdev->gpu->irq);
> +		panthor_irq_suspend(&ptdev->gpu->irq);
>  
>  	/* Wake-up all waiters. */
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> @@ -169,9 +174,10 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
> -				      GPU_INTERRUPTS_MASK,
> -				      ptdev->iomem + GPU_INT_BASE);
> +	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
> +				  GPU_INTERRUPTS_MASK,
> +				  ptdev->iomem + GPU_INT_BASE, "gpu",
> +				  panthor_gpu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
>  
> @@ -182,7 +188,7 @@ int panthor_gpu_power_changed_on(struct panthor_device *ptdev)
>  {
>  	guard(pm_runtime_active)(ptdev->base.dev);
>  
> -	panthor_gpu_irq_enable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
> +	panthor_irq_enable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
>  
>  	return 0;
>  }
> @@ -191,7 +197,7 @@ void panthor_gpu_power_changed_off(struct panthor_device *ptdev)
>  {
>  	guard(pm_runtime_active)(ptdev->base.dev);
>  
> -	panthor_gpu_irq_disable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
> +	panthor_irq_disable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
>  }
>  
>  /**
> @@ -424,7 +430,7 @@ void panthor_gpu_suspend(struct panthor_device *ptdev)
>  	else
>  		panthor_hw_l2_power_off(ptdev);
>  
> -	panthor_gpu_irq_suspend(&ptdev->gpu->irq);
> +	panthor_irq_suspend(&ptdev->gpu->irq);
>  }
>  
>  /**
> @@ -436,7 +442,7 @@ void panthor_gpu_suspend(struct panthor_device *ptdev)
>   */
>  void panthor_gpu_resume(struct panthor_device *ptdev)
>  {
> -	panthor_gpu_irq_resume(&ptdev->gpu->irq);
> +	panthor_irq_resume(&ptdev->gpu->irq);
>  	panthor_hw_l2_power_on(ptdev);
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index a7ee14986849..a0d0a9b2926f 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -586,17 +586,13 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
>  	return BIT(as);
>  }
>  
> -/* Forward declaration to call helpers within as_enable/disable */
> -static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
> -PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
> -
>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  				 u64 transtab, u64 transcfg, u64 memattr)
>  {
>  	struct panthor_mmu *mmu = ptdev->mmu;
>  
> -	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
> -				      panthor_mmu_as_fault_mask(ptdev, as_nr));
> +	panthor_irq_enable_events(&ptdev->mmu->irq,
> +				  panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
>  	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
>  	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
> @@ -614,8 +610,8 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  
>  	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_disable_events(&ptdev->mmu->irq,
> -				       panthor_mmu_as_fault_mask(ptdev, as_nr));
> +	panthor_irq_disable_events(&ptdev->mmu->irq,
> +				   panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
>  	/* Flush+invalidate RW caches, invalidate RO ones. */
>  	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> @@ -1785,8 +1781,9 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  }
>  
> -static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_mmu *mmu = ptdev->mmu;
>  	bool has_unhandled_faults = false;
>  
> @@ -1849,6 +1846,11 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  		panthor_sched_report_mmu_fault(ptdev);
>  }
>  
> +static irqreturn_t panthor_mmu_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_mmu_irq_handler);
> +}
> +
>  /**
>   * panthor_mmu_suspend() - Suspend the MMU logic
>   * @ptdev: Device.
> @@ -1873,7 +1875,7 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_suspend(&ptdev->mmu->irq);
> +	panthor_irq_suspend(&ptdev->mmu->irq);
>  }
>  
>  /**
> @@ -1892,7 +1894,7 @@ void panthor_mmu_resume(struct panthor_device *ptdev)
>  	ptdev->mmu->as.faulty_mask = 0;
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_resume(&ptdev->mmu->irq);
> +	panthor_irq_resume(&ptdev->mmu->irq);
>  }
>  
>  /**
> @@ -1909,7 +1911,7 @@ void panthor_mmu_pre_reset(struct panthor_device *ptdev)
>  {
>  	struct panthor_vm *vm;
>  
> -	panthor_mmu_irq_suspend(&ptdev->mmu->irq);
> +	panthor_irq_suspend(&ptdev->mmu->irq);
>  
>  	mutex_lock(&ptdev->mmu->vm.lock);
>  	ptdev->mmu->vm.reset_in_progress = true;
> @@ -1946,7 +1948,7 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
>  
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_resume(&ptdev->mmu->irq);
> +	panthor_irq_resume(&ptdev->mmu->irq);
>  
>  	/* Restart the VM_BIND queues. */
>  	mutex_lock(&ptdev->mmu->vm.lock);
> @@ -3201,7 +3203,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  void panthor_mmu_unplug(struct panthor_device *ptdev)
>  {
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_mmu_irq_suspend(&ptdev->mmu->irq);
> +		panthor_irq_suspend(&ptdev->mmu->irq);
>  
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
> @@ -3255,9 +3257,10 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
> -				      panthor_mmu_fault_mask(ptdev, ~0),
> -				      ptdev->iomem + MMU_INT_BASE);
> +	ret = panthor_irq_request(ptdev, &mmu->irq, irq,
> +				  panthor_mmu_fault_mask(ptdev, ~0),
> +				  ptdev->iomem + MMU_INT_BASE, "mmu",
> +				  panthor_mmu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 7c7f424a1436..80cf78007896 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -56,8 +56,9 @@ struct panthor_pwr {
>  	wait_queue_head_t reqs_acked;
>  };
>  
> -static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_pwr_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_pwr *pwr = ptdev->pwr;
>  
>  	spin_lock(&ptdev->pwr->reqs_lock);
> @@ -75,7 +76,11 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->pwr->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
> +
> +static irqreturn_t panthor_pwr_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_pwr_irq_handler);
> +}
>  
>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>  {
> @@ -453,7 +458,7 @@ void panthor_pwr_unplug(struct panthor_device *ptdev)
>  		return;
>  
>  	/* Make sure the IRQ handler is not running after that point. */
> -	panthor_pwr_irq_suspend(&ptdev->pwr->irq);
> +	panthor_irq_suspend(&ptdev->pwr->irq);
>  
>  	/* Wake-up all waiters. */
>  	spin_lock_irqsave(&ptdev->pwr->reqs_lock, flags);
> @@ -483,9 +488,10 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	err = panthor_request_pwr_irq(
> +	err = panthor_irq_request(
>  		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
> -		pwr->iomem + PWR_INT_BASE);
> +		pwr->iomem + PWR_INT_BASE, "pwr",
> +		panthor_pwr_irq_threaded_handler);
>  	if (err)
>  		return err;
>  
> @@ -564,7 +570,7 @@ void panthor_pwr_suspend(struct panthor_device *ptdev)
>  	if (!ptdev->pwr)
>  		return;
>  
> -	panthor_pwr_irq_suspend(&ptdev->pwr->irq);
> +	panthor_irq_suspend(&ptdev->pwr->irq);
>  }
>  
>  void panthor_pwr_resume(struct panthor_device *ptdev)
> @@ -572,5 +578,5 @@ void panthor_pwr_resume(struct panthor_device *ptdev)
>  	if (!ptdev->pwr)
>  		return;
>  
> -	panthor_pwr_irq_resume(&ptdev->pwr->irq);
> +	panthor_irq_resume(&ptdev->pwr->irq);
>  }
> 

