Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AFBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EF610E84E;
	Mon, 29 Jun 2026 12:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mA2Wo8sZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mA2Wo8sZ";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013026.outbound.protection.outlook.com
 [40.107.162.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E05310E84E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:12:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OZz9uFYl+cJuyV9RsUA9KcxfFeJXGPV4OF940U0wpCUrVUlDPrsoFu+EkYf3wnT86w1bQeP8DB2Nzyg4agA+PCj0oHXNXXy6bOOJWAhJjWPTY1fu5fg1YzDrbOe8uLrf6UxHYR3plc74N4kVNb9nBfe2gy4c8faViCH7WCQXL2UFM2fKdFSiBVAS5NLxVfsvmn71L7ekUGxa3kAqN1yyk+QFW4KSiXfuwSZY1r/epRY9cbFCfLaj7nrLVnZe37+C5E2aEQ54nEfYXHW4vqhK2Xn0+eT3sR1bO2fYW30iSzdvuKk1bojyGPbUWCq5s6jTe+KvZSk2O9RJCwj8rSWQZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzxE30qLu4vnr4a58bHXW89AwRVdttJCxTGkal0w0oA=;
 b=nlShtg7kh2XHnrlKpQL1S2aHk3SDT6Y13nfc8Bj5Lf7WY0Ord9psPLlobe+Y0tljtm7R1exZoIgiAhhdE28cGNCacP9TqJxuk5YOwNIua2K8YvVDAxGBpEsXiacwlRWYQYDN0YhHgvB+iBjYIJbm++EtxroG25UFmklOr2O6omTkNv3qyiy9k67AWngcFAmsg5oaRsBVA570diSl8hBGCLlNs8h74au4sKe8JkgrR3EMxuRMqlPV+W6DNRranC2qw96hJ1ZH5LKZ7GooAw32SnLLUS70TSSmSheEoggvOS9vFZpTVU4hfQ1ANgFEBTeHe3vJm9QceLPszmBtmeOq2g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzxE30qLu4vnr4a58bHXW89AwRVdttJCxTGkal0w0oA=;
 b=mA2Wo8sZ29RsdHsnaXorB6wyGjTRPQr7gsvH0i24uQWjzYco+ZCP1NeRczdhxmRY0DGfZHEdiagjn8O/6iWwxSmALcWGDW+VORrImc1RA6pubsE6+H9mpFqZttSTdjSLWWQrvDVJplDkXtlO4NxS2pKGtr+DhYRI5Pf1wy6iZHQ=
Received: from DU2PR04CA0310.eurprd04.prod.outlook.com (2603:10a6:10:2b5::15)
 by DU0PR08MB9607.eurprd08.prod.outlook.com (2603:10a6:10:449::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:12:01 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::4e) by DU2PR04CA0310.outlook.office365.com
 (2603:10a6:10:2b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 12:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via
 Frontend Transport; Mon, 29 Jun 2026 12:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWdBFCQu/q2aRRWPg1bJ2DsEaPU13SpZkBI0JzwxsKeSq6lSc/ICyjPBp+mxGLSqZKITIAuy+aKq5ZfHOQdWI9Pz4h0tIE7HqjEUOQ6AyOx6lURtgq/1s+VC6j+JJuGYgT5N1yoCnkJ7Uh6KuHbFSTLAZ7GpCBxQbV+N3PJmu+Pl6jRwYKCM78llVnCOjZ+07EgNHDl55wYO5KEvLJdfnGxHrUlOoSN4SalqXIXlT2kFejt5lIILsH71Aap6CF7K6uLY9H4If/KjWVjV6u+Ov7tsYiLHAHjP5jsgR67pabv8l69xPSnkWKlYC+HgE/rkRusykTgCSKQ3EUXM75jBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzxE30qLu4vnr4a58bHXW89AwRVdttJCxTGkal0w0oA=;
 b=UxCwi+lLS7ppUd4tqVy4WOuyzWoYuCBjpnTCPR5Kf0WNshLyn5QL9JuAkf5qj3Ossl3ZKZkoSgHhN0QczsO/lUWQDFahexSEIJpsmGLc+Pzeg2Ojo4Herl6GsKnqzRTXD34QWY1CXaf1Z8wWZwDF1giYMg1vwyseAIxrbXmb0VmMvIS0+e8hWKfDqV74+uIpzYB7C1t25hhK4DFaSN3GXZ+ajeW6R8jarwEWCiBx1180A6+RoX4emdhbjzk0a9MlvswdlvKC02+n3vFUPnqYDW/XPN4PmMEHGPXcwLw2f2SnaDJlsnKCrqnT8SBcBqfv2ltIG6kcTMRyyIaYXRzoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzxE30qLu4vnr4a58bHXW89AwRVdttJCxTGkal0w0oA=;
 b=mA2Wo8sZ29RsdHsnaXorB6wyGjTRPQr7gsvH0i24uQWjzYco+ZCP1NeRczdhxmRY0DGfZHEdiagjn8O/6iWwxSmALcWGDW+VORrImc1RA6pubsE6+H9mpFqZttSTdjSLWWQrvDVJplDkXtlO4NxS2pKGtr+DhYRI5Pf1wy6iZHQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB10272.eurprd08.prod.outlook.com
 (2603:10a6:20b:62b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:10:58 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:10:57 +0000
Message-ID: <1817a05b-0647-4549-ae9d-d9190df3e9cc@arm.com>
Date: Mon, 29 Jun 2026 13:10:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/panthor: Don't overrule pending immediate ticks
 in sched_resume_tick()
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB10272:EE_|DU6PEPF00009526:EE_|DU0PR08MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed626fa-e749-41e4-0a1a-08ded5d79fed
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: h62JXSUbLqSaZOAKC65PYAJ525m6CWB0L0HPV5yPjXpTi3dQgWCUlafh4iC9qKdL9Vf8ccUdiQwRynEnTnoxnBI4Hng40qJRKgDLzT1zCSx9Z5YO92noLUjxxr9bU0LLZZnEDW8JQBtvlXW+/Goks/d92NLw83O2r/dIGnqpFaa65WIkd4ajiqLWOrzZHGssN3xd4YMKnLq4f3xeB17+xjLRrfOH3AVrNuBhRa82U7B+Gmlk+RzSucyJq3RzY8A9VW3L+BPeHLQmdJQ0fcLynRPwzwIFwwO1ll61BQEWpGRKnvQjiSKO3Txbjl2E80qvd2GtYe2QsWVk54l9d1OPhiL3uNLnGmTi7VgShX3wBU6O0wvv6dngbvJrUebzBPxe94y0s8pKrvloxYRj0p3yZkAt62Nh7LrJoeZbJ2/L9Q9flF8xp/MfBL6GykPvtXZeEtjpAIalcMeoEqGmJ0aVRLscMEBqkiScyfUFW+lxabXXNNlCufHVqMTn8zGtblNgWZi5+wcZjYNCWGe1+ZEZXNVPv8/otZsYfa1cmVShuwR5F2F/Q/laEkcY8slJt8CAOsWXgQsix/nqneIYyVcKvuIOom1uIrlPVX0+zkc5AOg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: P88N3ou8mrdgCQ7VoQMHBfsrl4vS8rGu6MHwMCkdwPA/AQyxUrJMi8thJQpzGytsRtex+ii9x5ZANG6UCTPRAlZsWc/iStOpoiuHWdGGht215U4PvA76F9702a6PO6tK6yb//YQezHJME+HxEJdMOjvsGeGN96RXdi1BVsfWyh2CO9AIN7BulTGEgDf5kuUG1rtCGZSlADACm5yMUj7A7/nvIK4Hkj/DyfB+vw+Af+gAW/YrRLnNQ11CJarHy3gEzCJRVyPNEokBLImUohnxrgwOQH/vCbN9TVa0e1P/qr6b0xsWnv2/DC886D2crA/VRdZnwDmbZyfB6d0y+gIUNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10272
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d4391a9-922e-472d-67bb-08ded5d779f6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|14060799003|376014|35042699022|82310400026|36860700016|1800799024|23010399003|4143699003|22082099003|11063799006|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: fxETuP4nb4Cru2XAqdRb4Wrz4l1lR4SvhJuKxaVju2d+mZ+XeUbqJTGO6YQbp9VLRvG5J7s/M0mlwxO74PekgUQATFg5V373bkuwTgMRrmrZzn3cPc80qVSkJzM9rAYg/OnzJ+N7Wc7qyUoSDQreB2Tql6Cl8LgMv5s+atny2K9l7jN06RL9y1UcU0VwGkwplqW4sx4qYtieHgOL6KMNaHuUiH/yOLsjITLoOiU/Q7J4JHcVj/pujPqJMGTpfNtnTlluXZVbEIYw6weJXRNYaIzQCZGO3RJ+5fo84+z00JqKwoAiiZ0k/xObXq1uZRMibUdTs1RezIWA0gthJxPSKRcbVaHEp3itXzs0ovF7cnBsfA2eN96E0THsPCOxOMrRNAlMFLNUU7vrfsmsE6YV56uzanjq8YUg83OfHnAz+JxvH+dz0DJDtRX6u6oZIRjRvT8HPEhRj+NA+9xYrUU7utUYLN9dLubCQOM0sl4BnWs85Xi2OoU850ScDVPg9xYE+pEataaxJpJIKhUHVnJf1+dk3y15mjLchGxEVIcCqeESaCfgE0EwERwa8nSoQvcEmxFDGwPgecJYvF/oaO0XHkK+P0qAZCJFiGmKu8Zfu+1soC/tWOXnkbeMeGti6ZoiuSRUQegi+uvKHLKKlH+EtQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(14060799003)(376014)(35042699022)(82310400026)(36860700016)(1800799024)(23010399003)(4143699003)(22082099003)(11063799006)(56012099006)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oh7ssCpo3DsII7ULSHJFnKqteMaRjdSE0MHJtCaXthhauFnMPMP/lT3ON0DQv6F2LURwGiwPmEg2OF/9odWDHtDzOTZlAPCR+2K2nWdtP3UfW050YAFiureJyigIcn2+Ik81qpEnIpcIcNlKbCeRkLQ8i3HgUkMBvTnEdQTvzG1xmUmWvaFDoklaBJlv1GOfXObUwtbYG4UQ8XST1xd3HfWxb/wHuyVs0sGKsEM6wVMj4+qVubdwrpxNK4/qQHP1HEgsE+dKf/fDjRwOmAiEbwsAw6Vl/jV3Ub0K5VOcInvK8WOomxCYrnx9UPgVKsS0gZZGa8VAK2GOk0+UUXxME+sX65pxkKYDYI6GuUWOwppmqv67dP/j7cSlk+s0hhszsrHuXghSqXrA0w69X26U64keY19ISDXVDFyJRQ8HEZCQgKIvQBoQMTNL+rdXP9Eq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:12:00.9960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed626fa-e749-41e4-0a1a-08ded5d79fed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9607
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

On 25/06/2026 13:40, Boris Brezillon wrote:
> We schedule immediate ticks when we need to process events on CSGs,
> but those immediate ticks don't change the resched_target because we
> want the other groups to stay scheduled for the remaining of the GPU
> timeslot they were given. Make sure these immediate ticks don't get
> overruled by a sched_queue_delayed_work() that would delay the tick
> execution.
> 
> Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jobs are submitted")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=9
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 8fd4d97b062e..ab3e13e44a26 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2667,7 +2667,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
>  	else
>  		delay_jiffies = 0;
>  
> -	sched_queue_delayed_work(sched, tick, delay_jiffies);
> +	/* We schedule immediate ticks when we need to process events on CSGs,
> +	 * but those don't change the resched_target because we want the other
> +	 * groups to stay scheduled for the remaining of the GPU timeslot they
> +	 * were given. Make sure those immediate ticks don't get overruled by
> +	 * a sched_queue_delayed_work() that would delay the tick execution.
> +	 */
> +	if (!delayed_work_pending(&sched->tick_work))
> +		sched_queue_delayed_work(sched, tick, delay_jiffies);
>  }
>  
>  static void group_schedule_locked(struct panthor_group *group, u32 queue_mask)
> 

Reviewed-by: Karunika Choo <karunika.choo@arm.com>

Kind regards,
Karunika 
