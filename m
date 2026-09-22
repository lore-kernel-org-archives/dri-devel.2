Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2AEC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D2B10EE54;
	Tue, 22 Sep 2026 20:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fJQM9l8M";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fJQM9l8M";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9479710EE54
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:47 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lRnyd2dSpW3N0fvv0nNaiHnwfpTMfqVywvaWxrJYn1XjXyjmi7eFSu4pdcDhbM3L0AXCzQpSX7/IjWO059sssFyNbrI82V0DTAe9mmciDooN+CthiABQyX417KX48Wi7F65szREzLxb8UAx8jJweYc87RnjmvhuAY0+ROKE6IHXRY9rJMmR/GVIYVkeO0wcbSrlCwEwBBvXy7akwGtT1mLSXsweFMVWwrLlNv23FkADt+KJ5IL+qAOKfQWpZvSmw+HBYFXyxzqcUEZju4mygu+XumjcCtiH8vwBfn43rI/qtuW9kaErn4bg8wfP1CFgOGhsHkfrT6ujYa+Gi/Bvl5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z17U7A9cgUYVBG1n+DJZXAVYu3i1qpjBiOXRFJO+EbU=;
 b=b8jn1PZWPo6bWiT+dV0a3F2/f8ZH2BIio+v+YR9z3bmXEYEp6dMWcaOLGQ2SkDUOlxkGMlZTjkpt+eP9Pi5hDEx2/9RYoTCf4Kp6ebQidNkusWm55wCPwmSaSQA7akP3Re8DiGw+wmkdOJ6gYyIV+kCYF+omlFH0mYvrS5MJSMzjMf9aAIsIknYBU8KP0q0D+vEwBPxw7Ze/DiCLZ8MagXzuULMezHUdfU4RElaxHaB7K2rQge68E4xTUfjbY69AVZqo+nCHT6f+W8B+mdjhcWzTOR78ccnbrHkllbCEB5Y3eBQsTn8B2fm/t3MetYv155rcuWdrb7xGzYk1OfWOiQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z17U7A9cgUYVBG1n+DJZXAVYu3i1qpjBiOXRFJO+EbU=;
 b=fJQM9l8MOhbHWJHftN84OTWOVJA+UaoOIzfLxhXvata9uhhLmFjS1kQzmyvmgpbDYZ9mVGGrYgo7D6H1kC/VwLDoNKRhj//ckchCycU8lvmVD/9Nc4xAQ2cRBQ55y4NV3qkAxI856AwykbhTAf//hv8nmhjCzcpw0tmO3t8812M=
Received: from OL1P279CA0072.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::23)
 by DU4PR08MB10982.eurprd08.prod.outlook.com (2603:10a6:10:576::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:39 +0000
Received: from CPH1EPF00000519.eurprd04.prod.outlook.com
 (2603:10a6:e10:15:cafe::ac) by OL1P279CA0072.outlook.office365.com
 (2603:10a6:e10:15::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000519.mail.protection.outlook.com (10.167.241.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv/g2YL7TydSIPvj8SjmjssNOWUiT/KoKRSmyCtGqYxSZK/IyBmptakIragTOEzx2D/eGgz7OJcL+//80XFFnNFBcxedfCuD/QVssusC3dbVqwAJgxrVj3hOwi2QlYfqImqs9/rkLYuyb7AMUY/8lR32IwfZ9sBHjTC5IG5D/jbQ0mjYX0VyTPAtA3U7yxm9Ch/nd3sIP4Nb9eH3rhJxOCeyPEleev6GI6aFKe7ips/HS5EHv0FMAxqSE5MPKQplk+nUi+ExE909o6deVKklNVGcwVPw6u7lqE1fpMs3qwU/rO/SF3ebav2D3QHxd0+Ne/ADeReddIRopczqt7bMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z17U7A9cgUYVBG1n+DJZXAVYu3i1qpjBiOXRFJO+EbU=;
 b=p80M87j3rkNRA+ULWAxjtWBt5dVQFYiUOsC+PXVwL+IPoLFQ14vpopIcZHJAFXMQrLSvFqUbAPLb2wE0WEC5BMLutE23WS1H7SYxmUgjGJs93FFQd89DAgHpRbBJAKim03Pbm7BrK7q6/SyeZBv6HXQYWOz7YSKN6fsfauf094ub3UW0JlzCvgYzoat12oai7dWruAYzbzOuwqVi2e/DYokxuiiMuFfQAPY+PysJF/YXVvcP9Xoj4aTEujxhWH0u0D6KTS4j9W3Q4cQSG9eWplgVR2mUt2lC2RefXEWZx7tkDJO49mPShMNhopjd1prudK0POVj5MQUTrWowDPHXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z17U7A9cgUYVBG1n+DJZXAVYu3i1qpjBiOXRFJO+EbU=;
 b=fJQM9l8MOhbHWJHftN84OTWOVJA+UaoOIzfLxhXvata9uhhLmFjS1kQzmyvmgpbDYZ9mVGGrYgo7D6H1kC/VwLDoNKRhj//ckchCycU8lvmVD/9Nc4xAQ2cRBQ55y4NV3qkAxI856AwykbhTAf//hv8nmhjCzcpw0tmO3t8812M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:01 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:00 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 15/27] drm/panthor: Add AM_RESOURCE_GROUP support
Date: Tue, 22 Sep 2026 21:45:09 +0100
Message-ID: <20260922204535.2850094-16-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0441.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|CPH1EPF00000519:EE_|DU4PR08MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2059c7-d04f-4b39-afbb-08df18eabd18
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: v8FVNAyCma1JHj0UlC9V6u9vvJZOrYrrDlG0nFUs3x5ZWpR37Got+VTk+aw9Uur2pztwieKYMdMzPb6GgxmfaMFn+YfLyY/LbV83TW/j1zRSgUeV13g9BvyQINYXKyKz9Vzp5I8M8ag/RD0r8rq3aWic4bR5Ji2mkSr4UEChtRM3H6pULk7uI9+o+GOWol7/UmmVxrWPfnzbLwyuoYNluNRFPSA3K0qH2BIImoce6gXnDxutdqZ+iSiw4YzMO116vVPgZttikR4AJOdeBqDQN4hVYRIocnD22tit5QK2r3jcxizxKARXP8AuwRHnSxBpBg6bej9OpEeyHjg2PO90MVt+Zgs/RtuE5TW95orveoy9qCuyrjmhKPqUP8rb/UKYPwlalsiTykI4LdUU9idaNRttULUgmCgGOdy8+Erjx5pYMlBLyrFZEg/4eYpc0zM0YBdsYmwcL84EsHWB9KPq2mZuKd2gyvoC8/NUvxxYFevQ2u8ZRObBA1le1MqRrgADsOQY6SOLVQvZNYO+XYJWZkc2jAf+NCjous/NhYwrgf2jjsoJFycuOp59XW48Lh3+O5Ze40n2gL6ESJ8tFjYcIhmgpl/1Kq3XL6rQF0U5ppr1rFeMHEQ/PUzoyhDjbJGEsNzFDgIGcesVEMjsUDhyp6AECCbccT2ZN5DfB/06tjc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: KOO0eUjwW6EYySOuigkIhxLsHt0116HZOKdYe4xMbXfun9pjJq5AXZnzM5mZOXI+kZWrV96BcY68UZTedwzLHHqfUW00hR7t4pbsEy6vnzE2b3R/NmQcYqss8gcmSFTKskeCSTDB8zt3wJodfqhvP7hsEWXYzr5ONzCT25SN4rAXse5OOVxSQ7PtixDjtKrCqXALb+ZtkXEBnnMwMb6OWVSHTYfw457HCV9/xkIJxBxo3+qzpAspf+Uo1oC4dyvX2gy58Eg4DY3oyyr0eTreviOxm7m3mptwn57j3pMb4d8gf5xiyNv7h/sN5YxhS/W4Dq70wEZ168ZPaIiBd/mTzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000519.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8a2a8011-2842-44c7-2556-08df18eaa69f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|14060799003|82310400026|23010399003|35042699022|56012099006|3023799007|6133799003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fk9GV2f0+05sIxkSRX7G7s01h/1XDuJmaBONhFF/6JdeIwOSnyYeYSwyzTKfdO7HIMD6UJcY4GYQChFrlm52E6rhyp92wn3fGolZSmpP+Z/btZFc2SzX6ew//wFZ6t/y4qpQRjOVfxg2FAWev3rST5Yece2hVoZds59mzhxJUVrwqil60BmpsoUW+b4Q4adCLErk9B/H6xM8DJyxxK+raqo8QqRoocZd7Egb+7kdhAqF6mht4C0v58t+sO+eyPK2KJ14IC7DQ/ThagWUCGC3NCIXuHMn/kEtvnGEcbzxXXPKZJq8wcD5rnG6TpNpbgxv/1LFKOCuEOXBvCVaBK1XzDRquVV4XxcfpoxWmIeocn8bLs20I5PqFzd1RKoaoWBXzdTwF9LvXsHbk4uuVScZ6hUQMuv0v/ua6Y79Rm0WuGdUSGjzzQ4Dxz5NRzEZnFWRpLk6vD0T7snHdb2eXSQWUomkLmhGAMFcX7ScsvJ3hhcIHEWPOVzUBNcE4Q7GEjcVYZ7v7FjnpBGwEvgPulyHmLbk6PkZEw79nPrxyEweYWUrQd7jMWTM8MklvO8oKBmd7swfosggbkPJieaFiowA1W6LeiEEQe2JUcQ6pLJzmAltLpinwJD+DrjgVJTwrk9Ch565KBZOOtuFwbCB8cJvR0vtgmfcW9BobzDOeh6CW3Ae6cm4KPULYRlYZhveEFEbZKpOIh3DRN0ZPc/wPrCD3g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(14060799003)(82310400026)(23010399003)(35042699022)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p223kVvAKARObi5brA1i+7ikMCmV33HIwRG1JEdPzZ0n2V4WSDh3qoK9MabhF5PEJcoNZDKTY+OOuWZoq9PlF4LORct3RM/lShmOdPZq8g0/s/AQggzbJjOSbbnIUdLMbFLigdo1/S9Qx1RvAO51J4OaZUfNtNJQEOShhEJ7kFNEJDEzwiTnW7kvrFidGIfjbjVPK2dazeMx4YU8yfOEgKQg/XzH4uORHEEcZVgUByspHvvF3rS93EtOiKFzfggcwRh1WRFXPzO+5c+lgRZlhQ5YG8JxzzDBqYwhHIn4HpFHlmqvSyABzaYpp2XTMWUohKhdQUZFvWGpz8Ugb5QkUOUXdtPAXk6YZHI8+xI3mBj7y3U+C4jQZ5EJ3F9iPfHY2xYGRQVnp4kOsUcGFQHTtPgFr2brNQQ/xcHW3TuQ2pYX/HkY23mBPkmqFghc2Jt6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:38.2092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2059c7-d04f-4b39-afbb-08df18eabd18
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000519.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10982
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

Add resource-group probing for the arbitration device, including MMIO
resources, IRQ handling, per-AW AM message helpers, handshake
negotiation, and retry work for deferred outgoing messages.

Hook resource groups into arbitration init, teardown, and runtime PM.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Updated DT structure and accompanying parsing to handle child nodes
  instead of named platform resources.
- Hold runtime PM reference during message retries.
- Fix suspend resume ordering.

 drivers/gpu/drm/panthor/arbitration/Makefile  |   3 +-
 .../panthor/arbitration/panthor_arbitration.h |   5 +
 .../arbitration/panthor_arbitration_drv.c     |  19 +-
 .../arbitration/panthor_resource_group.c      | 323 ++++++++++++++++++
 .../arbitration/panthor_resource_group.h      |  22 ++
 5 files changed, 370 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h

diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
index b0b6b2e3edf8d..2d2684321d978 100644
--- a/drivers/gpu/drm/panthor/arbitration/Makefile
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -4,7 +4,8 @@
 obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
 panthor_arbitration-y := \
 	panthor_arbitration_drv.o \
-	panthor_partition_control.o
+	panthor_partition_control.o \
+	panthor_resource_group.o
 
 INCLUDES = \
 	-I$(src)/..
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 26950e47852dd..dfeab1b078d06 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -9,8 +9,10 @@
 
 struct device;
 struct panthor_partition_control;
+struct panthor_resource_group;
 
 #define AM_ARB_MAX_PC_COUNT			1
+#define AM_ARB_MAX_RG_COUNT			1
 #define AM_ARB_MAX_AW_COUNT			16
 
 /** struct panthor_arbitration_resource - Arbitration resource */
@@ -31,6 +33,9 @@ struct panthor_arbitration {
 
 	/** @pc: Pointer array to partition control data */
 	struct panthor_partition_control *pc[AM_ARB_MAX_PC_COUNT];
+
+	/** @rg: Pointer array to resource group data */
+	struct panthor_resource_group *rg[AM_ARB_MAX_RG_COUNT];
 };
 
 int panthor_arbitration_parse_resource(struct device *dev,
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 09342245a47d1..a1068a2c78f1a 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -12,6 +12,7 @@
 
 #include "panthor_arbitration.h"
 #include "panthor_partition_control.h"
+#include "panthor_resource_group.h"
 
 #define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
 
@@ -55,6 +56,10 @@ static int panthor_arbitration_runtime_suspend(struct device *dev)
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = panthor_resource_group_suspend(adev);
+	if (ret)
+		return ret;
+
 	ret = panthor_partition_control_suspend(adev);
 	if (ret)
 		return ret;
@@ -71,6 +76,10 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = panthor_resource_group_resume(adev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -103,6 +112,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_term_pc;
 
+	ret = panthor_resource_group_init(adev);
+	if (ret)
+		goto err_term_rg;
+
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
 		goto err_depopulate;
@@ -116,7 +129,9 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 
 err_depopulate:
 	of_platform_depopulate(dev);
-
+err_term_rg:
+	panthor_resource_group_cancel_work(adev);
+	panthor_resource_group_term(adev);
 err_term_pc:
 	panthor_partition_control_term(adev);
 	pm_runtime_put_noidle(dev);
@@ -136,8 +151,10 @@ static void panthor_arbitration_remove(struct platform_device *pdev)
 		dev_warn(adev->dev, "failed to resume during remove: %d", ret);
 
 	of_platform_depopulate(adev->dev);
+	panthor_resource_group_cancel_work(adev);
 
 	if (ret >= 0) {
+		panthor_resource_group_term(adev);
 		panthor_partition_control_term(adev);
 		pm_runtime_put_noidle(adev->dev);
 	}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
new file mode 100644
index 0000000000000..9bdd0876dd457
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/workqueue.h>
+
+#include "panthor_am_msg.h"
+#include "panthor_arbitration.h"
+#include "panthor_device_io.h"
+#include "panthor_resource_group.h"
+
+#define AM_RG_IRQ_RAWSTAT			0x80
+#define AM_RG_IRQ_CLEAR				0x84
+#define AM_RG_IRQ_MASK				0x88
+#define AM_RG_IRQ_STATUS			0x8C
+#define   AM_RG_MESSAGE_MASK			GENMASK(15, 0)
+
+#define AM_RG_AW_MESSAGE(n)			(0x100 + (n) * 0x20)
+
+struct rg_aw_data {
+	/** @msg: Messaging data */
+	struct panthor_am_msg msg;
+};
+
+struct panthor_resource_group {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @name: Resource name */
+	char *name;
+
+	/** @iomem: CPU mapping of the partition control IOMEM region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ number */
+	int irq;
+
+	/** @aw_data: Data for each access window */
+	struct rg_aw_data aw_data[AM_ARB_MAX_AW_COUNT];
+
+	/** @wq: Resource group workqueue */
+	struct workqueue_struct *wq;
+
+	/** @msg_retry_work: Work to retry sending pending messages */
+	struct work_struct msg_retry_work;
+};
+
+static void rg_retry_messages(struct work_struct *work)
+{
+	struct panthor_resource_group *rg = container_of(
+		work, struct panthor_resource_group, msg_retry_work);
+	bool retry = false;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(rg->dev);
+	if (ret) {
+		dev_warn(rg->dev, "Failed to resume to retry messages");
+		return;
+	}
+
+	for (u8 aw_id = 0; aw_id < AM_ARB_MAX_AW_COUNT; aw_id++) {
+		struct panthor_am_msg *msg = &rg->aw_data[aw_id].msg;
+		int ret;
+
+		ret = panthor_am_msg_retry(msg);
+		if (ret == -EBUSY || ret == -EAGAIN)
+			retry = true;
+
+		if (ret == -EINVAL)
+			dev_warn(rg->dev, "AW%u send FIFO unexpectedly empty", aw_id);
+	}
+
+	if (retry)
+		queue_work(rg->wq, &rg->msg_retry_work);
+
+	pm_runtime_put_autosuspend(rg->dev);
+}
+
+static void rg_send_msg(struct panthor_resource_group *rg, u8 aw_id,
+			u64 message)
+{
+	int ret;
+
+	ret = panthor_am_msg_send(&rg->aw_data[aw_id].msg, message);
+	if (ret == -ENOSPC)
+		dev_err(rg->dev, "AW%u send FIFO is full", aw_id);
+
+	if (ret == -EBUSY) {
+		dev_dbg(rg->dev, "AW%u has pending messages, scheduling retry work", aw_id);
+		queue_work(rg->wq, &rg->msg_retry_work);
+	}
+}
+
+static void rg_send_init_msg(struct panthor_resource_group *rg, u8 aw_id,
+			     u8 ack, u8 version)
+{
+	u64 message = ARB_VM_INIT_MAKE(ack, version);
+
+	rg_send_msg(rg, aw_id, message);
+}
+
+static void rg_respond_to_handshake(struct panthor_resource_group *rg,
+				    u8 aw_id, u64 message)
+{
+	struct rg_aw_data *aw_data = &rg->aw_data[aw_id];
+	bool acked = AM_MSG_ACK_GET(message);
+	u8 version = AM_MSG_VERSION_GET(message);
+	int ret;
+
+	ret = panthor_am_msg_version_validate(&aw_data->msg, version);
+	if (ret == -EOPNOTSUPP)
+		dev_warn(rg->dev,
+			 "AW%u protocol version less than minimum supported (%u < %u)",
+			 aw_id, version, AM_MSG_MIN_SUPPORTED_VERSION);
+
+	/* AW initiated the handshake, reply with supported version */
+	if (!acked)
+		rg_send_init_msg(rg, aw_id, 1, aw_data->msg.version);
+}
+
+static void rg_handshake_init(struct panthor_resource_group *rg)
+{
+	for (u8 aw_id = 0; aw_id < AM_ARB_MAX_AW_COUNT; aw_id++)
+		rg_send_init_msg(rg, aw_id, 0, AM_MSG_CURRENT_VERSION);
+}
+
+static void rg_handle_message(struct panthor_resource_group *rg, u8 aw_id,
+			      u64 message)
+{
+	u8 msg_id = AM_MSG_ID_GET(message);
+	if (!msg_id)
+		return;
+
+	switch (msg_id) {
+	case VM_ARB_INIT:
+		rg_respond_to_handshake(rg, aw_id, message);
+		break;
+	case VM_ARB_GPU_REQUEST:
+		/* TODO: on_request */
+		break;
+	case VM_ARB_GPU_STOPPED:
+		/* TODO: on_idle */
+		break;
+	default:
+		dev_warn(rg->dev, "Invalid message (0x%llx)", message);
+		break;
+	}
+}
+
+static irqreturn_t rg_irq_raw_handler(int irq, void *data)
+{
+	struct panthor_resource_group *rg = data;
+	unsigned long message_mask;
+	u32 status;
+	u8 aw_id;
+
+	status = gpu_read(rg->iomem, AM_RG_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	message_mask = status;
+	for_each_set_bit(aw_id, &message_mask, AM_ARB_MAX_AW_COUNT) {
+		u64 message = panthor_am_msg_read(&rg->aw_data[aw_id].msg);
+
+		rg_handle_message(rg, aw_id, message);
+	}
+
+	gpu_write(rg->iomem, AM_RG_IRQ_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void rg_irq_suspend(struct panthor_resource_group *rg)
+{
+	gpu_write(rg->iomem, AM_RG_IRQ_MASK, 0);
+}
+
+static void rg_irq_resume(struct panthor_resource_group *rg)
+{
+	gpu_write(rg->iomem, AM_RG_IRQ_MASK, AM_RG_MESSAGE_MASK);
+}
+
+int panthor_resource_group_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_suspend(rg);
+	}
+
+	return 0;
+}
+
+int panthor_resource_group_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_resume(rg);
+	}
+
+	return 0;
+}
+
+void panthor_resource_group_cancel_work(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		disable_work_sync(&rg->msg_retry_work);
+	}
+}
+
+void panthor_resource_group_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_suspend(rg);
+	}
+}
+
+static int resource_group_init(struct panthor_arbitration *adev,
+			       const struct fwnode_handle *child)
+{
+	struct panthor_arbitration_resource res;
+	struct panthor_resource_group *rg;
+	struct device *dev = adev->dev;
+	struct irq_data *irqdata;
+	void __iomem *iomem;
+	u32 irq_flags = 0;
+	char *name;
+	int irq;
+	int ret;
+
+	ret = panthor_arbitration_parse_resource(dev, child, &res);
+	if (ret)
+		return ret;
+
+	if (res.id >= AM_ARB_MAX_RG_COUNT)
+		return -ENODEV;
+
+	if (adev->rg[res.id])
+		return dev_warn_probe(dev, -ENODEV, "resource-group@%llx: id (%u) already present",
+				      res.res.start, res.id);
+
+	rg = devm_kzalloc(dev, sizeof(*rg), GFP_KERNEL);
+	if (!rg)
+		return -ENOMEM;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "rg%d", res.id);
+
+	iomem = devm_ioremap_resource(dev, &res.res);
+	if (IS_ERR(iomem))
+		return dev_err_probe(dev, PTR_ERR(iomem), "%s: Failed to ioremap", name);
+
+	rg->name = name;
+	rg->dev = dev;
+	rg->iomem = iomem;
+
+	rg->wq = devm_alloc_ordered_workqueue(dev, "panthor-%s-wq", 0, name);
+	if (!rg->wq)
+		return -ENOMEM;
+
+	INIT_WORK(&rg->msg_retry_work, rg_retry_messages);
+
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++)
+		panthor_am_msg_init(&rg->aw_data[i].msg,
+				    rg->iomem + AM_RG_AW_MESSAGE(i));
+
+	irq = fwnode_irq_get(child, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "%s: Failed to get IRQ", name);
+
+	irqdata = irq_get_irq_data(irq);
+	if (irqdata)
+		irq_flags = irqd_get_trigger_type(irqdata);
+
+	ret = devm_request_irq(
+		dev, irq, rg_irq_raw_handler, irq_flags | IRQF_SHARED,
+		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), rg);
+	if (ret)
+		return ret;
+
+	adev->rg[res.id] = rg;
+
+	rg_irq_resume(rg);
+
+	rg_handshake_init(rg);
+
+	return 0;
+}
+
+int panthor_resource_group_init(struct panthor_arbitration *adev)
+{
+	device_for_each_named_child_node_scoped(adev->dev, child, "resource-group") {
+		int ret = resource_group_init(adev, child);
+
+		if (ret == -ENODEV)
+			continue;
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
new file mode 100644
index 0000000000000..ad85cd171c4a3
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_RESOURCE_GROUP_H__
+#define __PANTHOR_RESOURCE_GROUP_H__
+
+#include <linux/types.h>
+
+struct device;
+struct panthor_arbitration;
+
+int panthor_resource_group_init(struct panthor_arbitration *adev);
+
+void panthor_resource_group_term(struct panthor_arbitration *adev);
+
+int panthor_resource_group_suspend(struct panthor_arbitration *adev);
+
+int panthor_resource_group_resume(struct panthor_arbitration *adev);
+
+void panthor_resource_group_cancel_work(struct panthor_arbitration *adev);
+
+#endif
-- 
2.43.0

