Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C247ACA9ED0
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA0D10E1EC;
	Sun, 11 Oct 2026 17:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rQAFDupb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rQAFDupb";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA32910E33E
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IQi+39qcFlOOBPAd7IMjMz+q52BPtsGEvkvRJHFA54J0thj79uVXrBSEknIE6JAMr35/v3fgZgmOVPbkAuCKF8wtpLt/qaxrdc6xisnOhhYkMJkrWK3QEBwKNW0z2xK2srISgMSO+FNwluZP0ThyVF0uP+/XEjhvgrBkfilgDQh5I+593NDt9BQEVIcjWl7T+uwrQ4mu+R335KuCw0MX1TccoF6iJl/XzCOCnYvk3DQ5erVwJknUgAX4duDgpEPSlNVqt83LJRvqkt7aKTO601ntdXrLI8S4vaNX74lDLHv74HErvfjQesNqS4CxbtE2rTxJ+Qg0Y5mnfZN4uLCf9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDb3WBMM4PmSO/lwr4s1BpXl0kR13bv3BSu6voV8ypY=;
 b=nAx6PRYVc5xg5JzjBHRBHTdmGLxAK8N5Xfszg7+zftDV8YqChLHLCctQjBqknyljfVOFGnbgov/GS+Wwd+WOy8CUIvudeMYFqZq2AcWwEwmosugGPoJ3+66UcDkWFLTjVc93tmOEldNpcoo0PaoJhba7ckg3MYKnuUCjrYkkXYRT4K6ZsOJRo3b3tE+oV5WB5lAoSm3RDvq00KL2HNKFEfxaK2FgOgxoH3blXD77oxRdXY9adZvgzV6+HIxO0MzSJ0AEphXlmJlTtuCnbn2ephhg+4oXQCz+S3oj7eERpCdrsnF6G7+iJW+B5VgJ1o+ipV1O9sME4kVwpHzsV4tbdw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDb3WBMM4PmSO/lwr4s1BpXl0kR13bv3BSu6voV8ypY=;
 b=rQAFDupbFWtl1Jt1gUua5HizungjvabQ5hzqu6JCO5TPBkitBSBnY+/nYZzSXJTRh8XNsoPjjJXV0DeiHJfNxEiTEtUHamyYOxaRzu1Bny6Myt15Mgb1+GXFaXJI3p/ysOv0xcO1c3OdV4VblILSBHZRkp3lu/Lk/eBpRme8p7Q=
Received: from VIUP296CA0014.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:34f::17)
 by AS8PR08MB9041.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.7; Sun, 11 Oct
 2026 17:40:21 +0000
Received: from MI3PEPF00008495.eurprd03.prod.outlook.com
 (2603:10a6:800:34f:cafe::1a) by VIUP296CA0014.outlook.office365.com
 (2603:10a6:800:34f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 17:40:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008495.mail.protection.outlook.com (10.167.240.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CThTHG0N57iTWrCFvzzEh7efKK/EJ6TwJBcmdQKevElRauUk2txy78udYJsJR/UkA8suwW4uB+aTaipdOb3FILOeIU4F3mm3xfUbv14nwN2nvp0U838OJMghxgEIWRSz8hxTnV+uljqtV+H+Fo+CuPZRIYOMJ/S/I/o16XG51/NPvmZ9BJjISmW5TIgooXUnneN3MQO7mfQeExFOC2JUA9TcU9x58fcSlJgapGJgCgxh+3r0BUjEy+F1GP7nUZDkW6sn/yYmVNy5jqgt3w7FwGdu3Jp6pFKERcQ8I09FdOvtJQ9vHWQqLHBJESoD9muWgsBhVy09ozioA1O98SjaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDb3WBMM4PmSO/lwr4s1BpXl0kR13bv3BSu6voV8ypY=;
 b=LEBHQqxyTMYulxtRpdHmPEMxew3wEpNAS1niy6J0l3SLZSdO9KmuSd82hrIGEtvNyfUI17f0fWw6IGIKKslJ2SDuCzeMS6xZr/2Jmh0q016CRbc40ow21qUGuYEhKuW81Ual/UzqZqfBxD0Voq3u83zfQgTqNUGz/BSOjQlr/o2KLCyb8NqNtRaO2IL79kq/Pm66C59bfhWMLaZuRtpjz4qhD/+NtddvIIvyJpEArnPXTI3fWbbq2pF6ujaLM9OTiXIneFhKV2KXWTAJzTQnERQSw3e5T5OpgAK0SWxnB3aYTL5jESdf858bu5YtOzetzcKF1WFScFaqNOraMFDBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDb3WBMM4PmSO/lwr4s1BpXl0kR13bv3BSu6voV8ypY=;
 b=rQAFDupbFWtl1Jt1gUua5HizungjvabQ5hzqu6JCO5TPBkitBSBnY+/nYZzSXJTRh8XNsoPjjJXV0DeiHJfNxEiTEtUHamyYOxaRzu1Bny6Myt15Mgb1+GXFaXJI3p/ysOv0xcO1c3OdV4VblILSBHZRkp3lu/Lk/eBpRme8p7Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by DB9PR08MB7496.eurprd08.prod.outlook.com (2603:10a6:10:36b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:47 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:47 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:54 +0100
Subject: [PATCH v7 7/8] drm/panthor: Add suspend, resume and reset handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-7-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
In-Reply-To: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PA7P264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::9) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|DB9PR08MB7496:EE_|MI3PEPF00008495:EE_|AS8PR08MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: abd120b1-c408-4a1a-7edb-08df27beb8ee
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: t9GyTe6jcuYzwz8fNGptredISKyWYoZxErJXoOtQksRv45cxb88X0qRGSrJ9A63dHwkobPAX/73efpoeWX+ukuA6p+WPFOhGdu3BIADu0X85Gngl8ZvReVmLVszltEbr/4sBXWWeTIOEEVSZGpS6F8bs93bnM56YbpoyXmPU6MfvRwQ0PFSqBskDUNycJ+N+2hQKKXnCrrCvyvTkN6OULtw8Fje8bCifYAT/9+4miMH/9sGwUlQkoRCN9m2F9fW6U6lPQ75zsMbw2Fkzc6VAlliPH0ED5UUKz7j9Ux4PXYAfprcf16VPUtwtd/qz0iZ2m6JTpW34NuTwrrYYddI7SRVMu4k+jgXGXp+iiXJZJqmSYk3jh208sPDg7K/kMt1AJUMWwbx1NXz0VKISX2NNPcRSXiUVJQNwK85lUbRWxqhiaWsP3GB9LZdfFnGkAsEUw3BJrHNC93eaaKncNoQxGwy80FeWse2DQCCku6mDjQrqLSnLqaZI0VqvjFtmFHjdmV2zkaAk0HUaUld/5YsIjoVdS2UQ76A/ekxo9Xrt779PCum+NZ/nyoMhtazYEfi7oBv6LfKoGM5wXx/lovuCZyfqNLZY0yLlMXLtkBdWCxYqmQ2S+kVMHq9xqtobQvvrFys2uTfR+t85LK2EUu2HTFMLae7phGq+8T8U39etip6We/nouvTPdtxOcXudPzk9nJy9BDPbWFu3YIX2UM0Ekg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: wdmHxzA6DFgtghCpPXuGYx4aw9K684xYb76rGkotrV2fE6rjC++OyMbYh3pz6o5730LCdLF+B7GCD3dt7GhoXusO1prQdaw0UcY9/CVxNUJreR3snjqdYd58BxqBJ4PzpkNNLTAE64fCbMASmo5nvP3/kB6U1r7GNFTcqXiTu7GYrRzk9ZJueFnFpdMLc8wEp0+ypYxiVNI6iEaxfxjdmuluu6qduH3WMuVF21rrK+KZfAKqbcHsGxja/mKVuFZXTR+jdKnR7nviMJ6sEYbdGbeb2Uf/tw2LFTL6pbpUbksUI5H2x/CKu7shPbpV53ytoCYn+Jc8xNlleeqzNNmv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7496
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008495.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3050300e-b7a8-4f1c-4625-08df27bea4c8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|23010399003|1800799024|376014|7416014|35042699022|82310400026|261009223027099003|921020|56012099006|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: CJLa+Thu08bjMzHv2rQM8AcdZSbQs4YZJOGrzdzWixR04SmEqhSX+uQgvxBx8oXk06Viq3/uPwi61nDCPqa/4SZwxro1awxx5MUx4EK9LrblTSWIaxk8P/RjIPh6aRHEBnl2YURAfwu78ST7znGkN3bOXD6XCfG0+cQeGSMTF16FcloFY7GmYXACDCqwCG1r5spd76HDKwkabRZdo8pUT5tS1aZ0OGfah2PLCtoSbl48l0UIG55txfSH7zX7ci085P2cT9l7xeqGhA0Nj2qwQ4Epp0Pv7ynNCb16N2ngZz+yqn/fbsL5GKVJsZM/iJTPDvS2IvSqOP6naydCRQvinZa5dwxnnUAQaqlSvt+13fWeJHGP/ol/UOJ98RqEYUvE1KRYI1BzbEv3ndApCCdN54tTp7IuwAChoGkUDd/rTw44ZO+W64nFYB+X89+/XnM365i33CH99WSSKad3k1Q41wdY5r8pmh9CT0LxFtoou0lBeT0ai1xSM0ZC77lkeuo3z37N7rxehu3k1Vxmc5EOUHBPcG/YLYru1jtfO4OWGxZW/VRuvYGBmo6XELGeNEakan58QBmtbsFFr2+j5Z1exY9npwmRmtrSCsE26JSYV/+ku0Ml1umjWNi1ApYYICbdj+m5UMG4UmSiF9dDRU1c6JTfI1O5uOojzCJwACcvoEGmcEGsxPW+ynl8KxUDa67ELRK6S0nfnEWtgENQs1DzNDiNcOvwUXR+s5jR7UtBukQ=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(23010399003)(1800799024)(376014)(7416014)(35042699022)(82310400026)(261009223027099003)(921020)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kVVisDlAE+/UtDzEyMok5XJSmzreQUWMFbzfzofKAOi2urfSxCHAVUMoFhe3314K8Tl5oAPR8oYpz5tOwf3crx/oU+iAYMAzX65n+4aYHx3RZTaYVmkJq9kPKFAI5HNMJGKEKulwB+SOUKl3HvyHWGYr6CL6skTm/ODG34ngEzBy6nAGXc0lWZKZm/x2sftXfd8wpJE4omDRWqk+pwaSGOWzs5cWiqCd7jlKqa1MD700Fv4sg/ogsof4564WswaLUEJjNvot9VVnX0ESxiQJN7c9YYfX3PwK5WUnlJVDI/OcSRCMuUtEkumgKtMkFQeL3bAczsgD8W6IHpsUxNl9WKe1UauOUOO3tBN9tCJe0+KT/TfRWi0hPUmw9iwh+HHslYsyqMQhbmQdCe+BxaRqSzYz2Iq2nk/28V75Vk13PjPlz+INuO/uY2VGCKosUgm7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:20.7857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd120b1-c408-4a1a-7edb-08df27beb8ee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008495.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9041
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

The sampler must disable and re-enable counter sampling around
suspends, and must re-program the FW interface after a reset to
avoid losing data. Additionally, if a request was pending before the
reset and it was not acked, the reset will have cleared it, so we toggle
the flag and re-request a sample.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  8 ++-
 drivers/gpu/drm/panthor/panthor_perf.c   | 83 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   |  6 +++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 535383ef629f..c842480472ac 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -138,6 +138,7 @@ static void panthor_device_reset_work(struct work_struct *work)
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return;
 
+	panthor_perf_pre_reset(ptdev);
 	panthor_sched_pre_reset(ptdev);
 	panthor_fw_pre_reset(ptdev, true);
 	panthor_mmu_pre_reset(ptdev);
@@ -147,6 +148,8 @@ static void panthor_device_reset_work(struct work_struct *work)
 	ret = panthor_fw_post_reset(ptdev);
 	atomic_set(&ptdev->reset.pending, 0);
 	panthor_sched_post_reset(ptdev, ret != 0);
+	if (!ret)
+		panthor_perf_post_reset(ptdev);
 	drm_dev_exit(cookie);
 
 	if (ret) {
@@ -539,8 +542,10 @@ int panthor_device_resume(struct device *dev)
 			ret = panthor_device_resume_hw_components(ptdev);
 		}
 
-		if (!ret)
+		if (!ret) {
 			panthor_sched_resume(ptdev);
+			panthor_perf_resume(ptdev);
+		}
 
 		drm_dev_exit(cookie);
 
@@ -604,6 +609,7 @@ int panthor_device_suspend(struct device *dev)
 		/* We prepare everything as if we were resetting the GPU.
 		 * The end of the reset will happen in the resume path though.
 		 */
+		panthor_perf_suspend(ptdev);
 		panthor_sched_suspend(ptdev);
 		panthor_fw_suspend(ptdev);
 		panthor_mmu_suspend(ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index c66ad658a95d..28b02003f9f9 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -1798,6 +1798,57 @@ int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user
 	return err;
 }
 
+/**
+ * panthor_perf_suspend - Prepare the performance counter subsystem for system suspend.
+ * @ptdev: Panthor device.
+ *
+ * Indicate to the performance counters that the system is suspending.
+ *
+ * This function must not be used to handle MCU power state transitions: just before MCU goes
+ * from on to any inactive state, an automatic sample will be performed by the firmware, and
+ * the performance counter firmware state will be restored on warm boot.
+ *
+ */
+void panthor_perf_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	int ret;
+
+	if (!perf)
+		return;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = perf_disable(perf);
+
+	if (ret)
+		drm_warn(&ptdev->base, "Could not stop sampling before suspend, err = %d", ret);
+}
+
+/**
+ * panthor_perf_resume - Resume the performance counter subsystem after system resumption.
+ * @ptdev: Panthor device.
+ *
+ * Indicate to the performance counters that the system has resumed. This must not be used
+ * to handle MCU state transitions, for the same reasons as detailed in the kerneldoc for
+ * @panthor_perf_suspend.
+ */
+void panthor_perf_resume(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	int ret;
+
+	if (!perf)
+		return;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = perf_enable(perf);
+
+	if (ret)
+		drm_warn(&ptdev->base, "Could not resume sampling, err = %d", ret);
+}
+
 /**
  * panthor_perf_unplug - Terminate the performance counter subsystem.
  * @ptdev: Panthor device.
@@ -1868,3 +1919,35 @@ void panthor_perf_pool_destroy(struct panthor_file *pfile)
 
 	pfile->sessions = NULL;
 }
+
+void panthor_perf_pre_reset(struct panthor_device *ptdev)
+{
+	if (!ptdev->perf)
+		return;
+
+	guard(mutex)(&ptdev->perf->op_lock);
+
+	perf_disable(ptdev->perf);
+}
+
+void panthor_perf_post_reset(struct panthor_device *ptdev)
+{
+	bool rerequest = false;
+
+	if (!ptdev->perf)
+		return;
+
+	guard(mutex)(&ptdev->perf->op_lock);
+
+	perf_enable(ptdev->perf);
+
+	scoped_guard(spinlock_irqsave, &ptdev->perf->pend_lock) {
+		rerequest = ptdev->perf->fw_sample_requested;
+
+		if (rerequest)
+			ptdev->perf->fw_sample_requested = false;
+	}
+
+	if (rerequest)
+		perf_fw_request_sample(ptdev->perf);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index 0e1172dbae39..e4a323fe6f0d 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -18,6 +18,8 @@ int panthor_perf_pool_create(struct panthor_file *pfile);
 void panthor_perf_pool_destroy(struct panthor_file *pfile);
 
 int panthor_perf_init(struct panthor_device *ptdev);
+void panthor_perf_suspend(struct panthor_device *ptdev);
+void panthor_perf_resume(struct panthor_device *ptdev);
 void panthor_perf_unplug(struct panthor_device *ptdev);
 
 int panthor_perf_session_create(struct drm_file *file,
@@ -30,5 +32,9 @@ int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle,
 
 void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status);
 
+void panthor_perf_pre_reset(struct panthor_device *ptdev);
+
+void panthor_perf_post_reset(struct panthor_device *ptdev);
+
 #endif /* __PANTHOR_PERF_H__ */
 

-- 
2.43.0

