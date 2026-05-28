Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43192CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B1E10F324;
	Thu, 28 May 2026 15:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="BpRUi+5/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BpRUi+5/";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D672610F323
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:04 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NKGEjEDVHbof6jwWj2x29T40bt1CPNX9rz89lpxHLBeHka1BGmOx7H7pxxTMgOZ6/A8KFTOrccSSZTYnxl8ximo5qcgcz5LuHwG1WduYFb5HUrQh2DLs5cf6Mpzi1WWVx9aoZOsk6jERZHa/K79nbTDOM/F71Kn3dbEDsJZOM8PmaZUqWjmuReHKfsVInJmbATN5yznV/ICvOIc/v0WL2SVLlKxBLr10jtD5hgbMhzZWHV07eCeXzC4TVfda8rq0VDPpRK9dxaC2sjXa0/Ows6BlAvyYnOhn7gfNVdYKL0OmXyUiD+sA6TogKsiq23nnVfbSoQFGu0a2AM1lMr522w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQy3cUbsjEzhCQtBZ1k95Fjg9qxf9ovd5RzQZ3cCMlc=;
 b=d62WW8iTS11InbKX1b8yMFxUXCxTlUADnUqqK1bCyHseWxXiv+s9+qr9kKY5QpXYkOyedePAr8KtC15VZYr8ggzy5K7yM8AoWGbtOS9D1Xw3bHANHXEKMhYK+YH6aqkxC3h14dA6sWJTQvmX10MoX4PR97Ot2d6JNkoenCYymYkdfTgjFDkOj8oNuYhfHgzB96g20QiDAVmNhKxvk9zVwBy+kzXiMZoHtdqXRSQSbSt+qybu8xahzzTE0fCboLZSIXUCFwF5vVJ33BtynCusmYIgw+soWn9Re7ZoSreGI4CViiNCAR7Wbv4kEqLzz/IpjoOdmmISSrKLDDCwGulRuA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQy3cUbsjEzhCQtBZ1k95Fjg9qxf9ovd5RzQZ3cCMlc=;
 b=BpRUi+5/rP+41B/BImGuSse/KLxfjilw1DORmFULK9iiUZWnWgjrebEq3E6EhoLaE07MlJmirgLZnLHsSt6TnwKmNmfuxbLX8V20fK7dbljtDq5tuZKnTIq7MqlsP/YMO5WRwYES6Mxoq09DHKp8IQibB6nvED8on6RrYCw7ieA=
Received: from AS8P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::20)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:06:58 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:330:cafe::a9) by AS8P250CA0015.outlook.office365.com
 (2603:10a6:20b:330::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 15:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOZQudkgKAJBfP4eqAewGUqgECbn5uHr05RqbNR46SdKP/0I5xCvBM0cFEEfZCTm0iiHLbOoS5eAbVwY8z/WXLg/GrRZ4ydr4/2abCWNVkx5aghlzSSB+Abxbn4GSK072xnse+kFtQrenuotVNZhkhLJ/0JaK8oZiHHwtBupNwUh80un54TypS+CBgKQ8dft7pcyr2aJz4bIEyoBD+8/5LFSW++DlB2zWjHXdYLzyTDTueHh/u/Y4kIwGKfiPji2lh2jjwE0stAJUHhrc+25/uY2bOaM+BmP8/xo6USY+7unNFLrSxhkF52fenM/i0vwy61QKnPYv60Nisd92RcdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQy3cUbsjEzhCQtBZ1k95Fjg9qxf9ovd5RzQZ3cCMlc=;
 b=H/MnbrV3m3DwUqH6s9+BDYCF3p3haTPDx68Yx7W8jAjQeP0gs8Q6CrX8N0YAhAlnFF9N/+hCFXrFXeWUEgxWwFQO9/B6G3rS9Yy5pnGz4vIW5HjdsOF9EMTntTfI027/1m4VOncNrSJND18d5Wjz7IYew4jgDw6rMjxcDwhZNN5SfOR0zS+dntbHt2hgsvODsxbXjveCpq7sbFQaBKzKbSNW1m2BybImljWVAdDjsVb0dvpaYAvfHtDJ7F1Rxf+6O/nw9f+cE1piYzgfw3f8wCXrXSl4yyk89yavIz4YxyXuNCN3/rq2RpF+UDmMZksw1f7vDUbRGl9jpUsOYeA9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQy3cUbsjEzhCQtBZ1k95Fjg9qxf9ovd5RzQZ3cCMlc=;
 b=BpRUi+5/rP+41B/BImGuSse/KLxfjilw1DORmFULK9iiUZWnWgjrebEq3E6EhoLaE07MlJmirgLZnLHsSt6TnwKmNmfuxbLX8V20fK7dbljtDq5tuZKnTIq7MqlsP/YMO5WRwYES6Mxoq09DHKp8IQibB6nvED8on6RrYCw7ieA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by PA4PR08MB6109.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:05:53 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:05:53 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/18] drm/panthor: Add Mali v15 AM virtualization support
Date: Thu, 28 May 2026 16:05:28 +0100
Message-ID: <20260528150546.3168527-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|PA4PR08MB6109:EE_|AMS0EPF000001B4:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cb6de9-805a-40d4-ba10-08debccac3c7
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 4NaOBz6BJ3HTAcBWrOejkPImyQoVjHkWxMNN1XXYj8ql8T/XAVurGXTQMj9fN0/Le4ntrh0+1MsCdULgjiYeB5eup4jnCqp1VzXP56SzUu4o3fKXLRYSByJ2pSS8bhfdY4gm6tgob2K10M+ZlvyI/0cWcDepXY92xLM8RF7UAPOWtxL4qXoDUsX858H6MUb3eDw7aLSL1dsUTdXoUGR4fkurh1bu3q7pH38WDXSzXlXOIn/gBTLfHzZhJSZdQXpghro/UhNpLPIwlPalzctt96qsEjgzvH8NR8e7c0D9tAJ4BaZz/XwUFZ7bj/Fepix5zP6DLPA6tl4UPuBYd7n2v4XCtF45+9mpjFdASlC+x2njc15aX+1CeElY9uRof20aeVktqdIvLRcZ37/+dxxHrOvhzc7sqHBRcikmzhZTIN60Dc0gZFsYOHZXj9yzGIl61wzMczY2knVP1mR/yh2gA0f7qhKOU7tldc+DAt7M6lTmUvI75fHVMvvUmeMS83R2AJIJAJP6jPqZ+OgQIJpQae+uc5D+mO5BbOzzIHbC7IoAixLNj6RlT4dsCi3bCIwpFII5P0hfoLPGElBwACJ8OKXFnMvIkOFMzKYJHoPGzlaefpE4TawkxpjrqT0Rx6gYOtA17DnDCk87FxHxuCYosjjJ0fGjU5Rk5Mjs3oMQ2Vij+0jLzh1jQTInopGIBpDV
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BGXJjIXxfQQmUjt/sCLwE/9o2YBWtJ830yGIagLeN2KzaoguBx16mQSV7QqPPdw5hQ1D0WBHZx0Hkk4hnFyJ7OHrgjPSq/x/7ExwssEmZ6FkWD4lJ9iddcquJtCxzY97sQ6jDGUVuiv37ZdhfyCWpOCu7f2cCv+4xGNQNfGYoTqjiv8z7mrQmZ9pooB5a7aax2PDgI98ZNUiZVxrab/eBx2UfP8n0JcuAsEVMgDD8HzVFLsIZKeEdQ6KV6cSUr0u2ZFxG3lUoyshTziveyi6LLAtN6fTuD/o8Dtk9glkleaZBTJukRnJmjIHinVppYK2r0Y6s5ipAuIvjNUcFmEYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6109
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e056e967-8c7d-4fc0-2e3c-08debcca9ced
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|376014|35042699022|1800799024|36860700016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xTcCXJNcq1f1XEapbPqlAzRRVHBdFL0465ixjuJoIUAH+hon7R/fIyu75cOZXvWl3hZ1wDnBkG0boSZPFTzqVqHioxoBpin+rgFshF/B63Gy+wllT32fBdbtTAIr6xLVTMAs2JbvMVj2bHYjwKO1sQXlckHJv1Ub+lBctCUjtnjHnkQqIVcqLJcDA5lJpX2omWz3EavAFjT6vNPj7W50lQHaQXTbYLnFYR89K2Wd6BMaVYFj2AJ4iaBOUTjckNtGpmvdL49ZD7VYaT9ej1/Yle6ZAiX2UOM8g6RYOrxN+zWtOXQ8RHkj0GdjEXYhss7seu/XL4IgTS+99KO+t+u/iuMTUmpW2K63MbN3rSgAX2Vd75yCYUdpkJJQaheaGbsjrhuOQ09hJRVNuu8I1zU1OXF4L/05/2InUZr7ZO6CXV8PLCRQsuIkehyDtyRSac7aMhdNaDbBrDjk5PohQhIUKecIzoeUzAvAQKux8NrHuOtMj1QKngra4unfyWaJyQLiqcw3//c2YdpVqKhPg/vjhjt7T6BeERPY6sZzQ8NjznTON5sHo3vWlJnXk3sFdhZmeC0DcI/bHmh6HVCwHdiADNIOfk48NnDL39+T1CT5QLXCzhExTP68tRpcWY4sJEN8lB34wtWI5l6I12SJ6TViTaV8I3HVeLC+8g0NVmfQbOP3KQUCPV7Hpmpbzkwq0KzaJZoHVUyFawzKx+XdDOaMMXmj2dJjUVYWyLOh4NooMBs=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(376014)(35042699022)(1800799024)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LPv17MbykC3YVgtwokFug2xTo6Frz4y/FQyKKjiheMzm6S2mhjiL/GWscs/Z8SqvYuhKNGbcX1HUmalk3p1GNcyqJ6bTe/AO63Veg6sGjNCjdG/JmhD/CI/4sQCH9ynG76LZAJ45agsQ2qvQ8uAnk3I3ZTwbQkW1OX68DGGJtifGIKcXsy/cQTdBbopvlC23aWJAd3L1QywsP21j0P7OrJA+IDRh51syTK/Q29qLSACCvprNXlx3NxVWTuPvaf38DKtidyBDjQgX0VxEtHJLz1FcOVQibt0I3g/OLcbmoJOqGieJd+iKpfxSXlRho8PaVQqqHo6jA4gmIseJfEVisPx53LmE/OEQemEUgt0rHp0QcDwAPfDK3Jx5TnyrX3y4u9N6PsequtTFSeJ5WL+7ciFa0xCo8J0iX9hl34XAxIB4ihue1JlLcWH4YnBCokGr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:06:58.6265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cb6de9-805a-40d4-ba10-08debccac3c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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

This series adds initial support for Mali v15 AM GPUs and the
HW-assisted virtualization blocks around them.

The first patches make the core panthor code less dependent on fixed
register layouts by caching decoded GPU_ID fields and moving register
base offsets into the HW description. Mali v15 support is then added on
top, including 64-bit GPU_ID decoding and optional devfreq handling for
systems where frequency control is owned by AM_GOVERNOR.

The rest of the series introduces the AM_SYSTEM, AM_PARTITION_CONTROL,
AM_RESOURCE_GROUP, arbitration scheduler and access-window pieces needed
to coordinate GPU ownership between the arbiter and VM-side panthor
instances. Finally, HW component PM is routed through access windows and
waits are taught to tolerate loss of the access window.

This series has a soft dependency on firmware scheduling support that
will be added later to handle YIELD_NOW interrupts.

The resulting support is intentionally minimal, but provides the
driver-side plumbing needed for Mali v15 AM systems.

Kind regards,
Karunika Choo

Karunika Choo (18):
  drm/panthor: Ignore -EOPNOTSUPP for shader-present nvmem lookup
  drm/panthor: Move register access helpers out of panthor_device.h
  drm/panthor: Parse and store GPU_ID fields
  drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
  drm/panthor: Move register base offsets to the HW description
  drm/panthor: Derive MMU AS register addresses from base and stride
  drm/panthor: Add Mali v15 hardware support
  drm/panthor: Skip devfreq when no OPP table is present
  drm/panthor: Add basic AM_SYSTEM support
  drm/panthor: Add AM_PARTITION_CONTROL support
  drm/panthor: Add AM message helpers
  drm/panthor: Add AM_RESOURCE_GROUP support
  drm/panthor: Add arbitration scheduler
  drm/panthor: Route arbitration events
  drm/panthor: Add access-window support
  drm/panthor: Synchronize HW component PM transitions
  drm/panthor: Route HW component PM through access windows
  drm/panthor: Tolerate access-window loss during HW waits

 drivers/gpu/drm/panthor/Kconfig               |  14 +
 drivers/gpu/drm/panthor/Makefile              |   3 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |  17 +
 .../panthor/arbitration/panthor_arbitration.h |  45 ++
 .../arbitration/panthor_arbitration_drv.c     | 199 +++++
 .../arbitration/panthor_arbitration_sched.c   | 692 ++++++++++++++++++
 .../arbitration/panthor_arbitration_sched.h   |  25 +
 .../arbitration/panthor_partition_control.c   | 390 ++++++++++
 .../arbitration/panthor_partition_control.h   |  27 +
 .../arbitration/panthor_resource_group.c      | 288 ++++++++
 .../arbitration/panthor_resource_group.h      |  20 +
 drivers/gpu/drm/panthor/panthor_am_msg.h      | 157 ++++
 drivers/gpu/drm/panthor/panthor_aw.c          | 576 +++++++++++++++
 drivers/gpu/drm/panthor/panthor_aw.h          |  46 ++
 drivers/gpu/drm/panthor/panthor_devfreq.c     |  13 +-
 drivers/gpu/drm/panthor/panthor_device.c      |  69 +-
 drivers/gpu/drm/panthor/panthor_device.h      | 134 ++--
 drivers/gpu/drm/panthor/panthor_device_io.h   |  81 ++
 drivers/gpu/drm/panthor/panthor_drv.c         |   1 +
 drivers/gpu/drm/panthor/panthor_fw.c          |   8 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
 drivers/gpu/drm/panthor/panthor_gpu.c         |  14 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 ++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   2 -
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 163 ++++-
 drivers/gpu/drm/panthor/panthor_hw.h          |  45 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  36 +-
 drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
 drivers/gpu/drm/panthor/panthor_pwr.c         |  32 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   3 -
 drivers/gpu/drm/panthor/panthor_sched.c       |   9 +-
 drivers/gpu/drm/panthor/system/Makefile       |  12 +
 .../gpu/drm/panthor/system/panthor_system.c   | 298 ++++++++
 include/uapi/drm/panthor_drm.h                |  20 +-
 35 files changed, 3338 insertions(+), 171 deletions(-)
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
 create mode 100644 drivers/gpu/drm/panthor/system/panthor_system.c

--
2.43.0

