Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C888EBFD37
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C1310E405;
	Mon, 13 Apr 2026 11:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dJYS73Dw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dJYS73Dw";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013015.outbound.protection.outlook.com
 [40.107.162.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7224510E405
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:33:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gcu9N/uFFCDXl9AE/dmab0guOynQa0aNoQv484voSpxheV3Z4DwN3l3uauU27UrGK87xewZT4fPFjK/QuIzLpEXns+OJSQ/uIAgcql5yk6TYPmNFXcUZQkBb3HQScWkvFDrFqFEpkMCzeHGoc6MPIAfuYzpE8TEaNktzMnO/PS7WmKx8tfD1rkHrdqrNUU83TUpT9B0hDu8odEy6dtsLbK80ewYbhKdBTReYsP5BaBwJ6M6OLpnrA60WXtE88d7smF6gk2voMqQj1C+hieyszTLx38VOsOWXOmP0nsbUWJ9frdtzmDiaKy8pGFf4oZSu2uET5MMqYY87cfCILB3NOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyAnuSlQ+jPlswLAxVhs7x0LE/Ndmg/HflA8guM7mcA=;
 b=ACkqC05eDNazkDW6aS7obLwVh1elRIYaaFlzjJzpB7hpnv2cPugbzVrQwYgrIQBwNzFmgVUARuXQsNq13yPuh/THm6A7Oq08ec7xxe3PTojTqOOP5qqBxnobDIt3GXb63Ik0Nd+kBvwhjb7c0PaQkIXsNr2L85oAAYS2rXsUxHVGz+tpvoX/gP13C1gXM80goNxRirz8Ao+cj8f90WqK2DAZvoM8wSwSb2tvd2DR/ByxfUZiczu6fxLi4zyvicjEp/HJOvS/zyI/3f5PFBFXWgmf7SQc17/GC9BO4QY8SddggwHezvW7NEy57QN5AIAQjCLASK1S/vfxdCXwZmkcJA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyAnuSlQ+jPlswLAxVhs7x0LE/Ndmg/HflA8guM7mcA=;
 b=dJYS73DwE3vWvA6E3SNuYyPYqNgM2afyOUE6NlT8v92IxjI3mcDldGRJvv3BAquvB508fXtxaLU3zEQwVzXkBQs7sBXgwzQ54zNzjpovTdraGQIIx6f0KL45HlgJdfugWXMLYOHjNnq4gEx3Od2yOFv++a//L5oC+VadQbn1M5Q=
Received: from AM6P191CA0102.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::43)
 by VI0PR08MB11566.eurprd08.prod.outlook.com (2603:10a6:800:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 11:33:00 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:209:8a:cafe::23) by AM6P191CA0102.outlook.office365.com
 (2603:10a6:209:8a::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 11:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Mon, 13 Apr 2026 11:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1KBatw8Ze38QSJ1g51bjNxKA6HbAefetE01xW8zLy8vGdKtlxmyaGeVv8R9rn5O4hzCyclx0M8KXV1nccgtxPw0y6RLVemZmEX/CYgn6s4lefRDjs7tuo6z+auSKqFpemh0QxCCDsNzJ93hiLhcvuX+o9CsOCppxgVQIHafHS8rKKsyJ5Tr0YJ3sW0HKZL9hJYM+3coLHYfFiUYKlGxx4UnWTzAeKg7/Jr7lAU5/rbYXnflMqKnXhA33lQwiZTcA0WFD0BxeeeAhhbzwumSQkAgmeeBKl5vgqQqep5/1qnybM4b/m3t4J6jD+bqLpm6rXii5vi9nos/btE7UtbOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyAnuSlQ+jPlswLAxVhs7x0LE/Ndmg/HflA8guM7mcA=;
 b=Rpw/ZuG7NMk/PPUavcgNd1jwq95RctlTFx1qgaGaG7uwugUOLdro8K7Mqmp/D4Mba6B72/2F2M30DePyhjFrsGH7u9TCZa+A1NnGnmXtj+H83qKtIR57SRUZwtZVpK0hulC2m/0dDjU5V7bjLqhDo4erN8qpKuWwxPT2y4p9eh9gsY2VFbEsaQU7gaKgFwOGjISpJkoG6+PVC1dbbHHhwAhn+WF3Zov6WsZlO8C44K+8/hvT4P0x3ARUoX7sJbfuf5E1oUy3NI85YsROTkJPTPUDDGaJbB38zRgBa6eJoIkGu+lQgwRx2wD4LXdsFm8vfOstlvv2VRucZWJ9DpXXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyAnuSlQ+jPlswLAxVhs7x0LE/Ndmg/HflA8guM7mcA=;
 b=dJYS73DwE3vWvA6E3SNuYyPYqNgM2afyOUE6NlT8v92IxjI3mcDldGRJvv3BAquvB508fXtxaLU3zEQwVzXkBQs7sBXgwzQ54zNzjpovTdraGQIIx6f0KL45HlgJdfugWXMLYOHjNnq4gEx3Od2yOFv++a//L5oC+VadQbn1M5Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB9611.eurprd08.prod.outlook.com
 (2603:10a6:10:461::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 11:31:57 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 11:31:56 +0000
Message-ID: <52b3d3e1-f2f4-4182-87ff-bd36e31080ad@arm.com>
Date: Mon, 13 Apr 2026 12:31:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/panthor: Store IRQ register base iomem pointer in
 panthor_irq
Content-Language: en-GB
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260410164637.549145-1-karunika.choo@arm.com>
 <20260410164637.549145-5-karunika.choo@arm.com> <adzG-HcqYPgBPfwF@e142607>
In-Reply-To: <adzG-HcqYPgBPfwF@e142607>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB9611:EE_|AMS1EPF0000004C:EE_|VI0PR08MB11566:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e88062-e789-47f7-ba20-08de99506a8a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: Mne18SaEMZslySrvQKiByh3PbVtihAnRSXLUBVhUvOFa8NbP0S5+yXzXvISdMM9SYG2KqiE0su92I1eUsTW7UsHE+4o1KbIcmlITwbE8Nz0vgOVJubMlsfBkwdhiKzl7ev65R6M7I3g6Z0cMdXTtIaAiAJRuE1nQTSld40FcP8Udfm0Nd7xkOhJK8dCQapOgmvlsPJoY/ZH6Oa2Q2ktvC8M+cU4rX2XcSF8GqyfRP+VCq/DLE3WxpuBUvESy8OmcNbVsr1oUmTEjl3UtINW5GxfzP+GZTzdOFb7evHfuvMMpilHaWgEaYCKKGmAMjkRk5AvaB0Nn4h7Teu97s6iEe0c09SXerC6zqHqzIMKKQd6FXp08cbkYJJvNMy06mg2VHryYlKc8SRrujOm0ArV7vgBgWypyX/ZeKWC9mdtS5UGv4XUa7uptjhNZ12WRACzdRvUnAJoFcYTRjPl8xJ50ezblaw8rcEoji24V/R4o0/1wbvI/O+1bynDQ6WdbzGKqgaQDZlusQdr7BzsfZ/MHcNsSJ5UroMS2hbtNRblI1rGYRj61qkJFoTvihvhL5dCrvQ4/es6wZq+948t+d/uj5l2apanYWhpLfgBQeIw8Tkxol4ObGWLxlBKJd+3oe4t4TN5C+Lpv/QTiDvCHyLaBtX+LILd293gS0UZl0aOb6asww9g2S4Xc/VWj+Go7E5U1LABfc/BjWgPqXmWuUus11njipsHxd9cNhA5BjxgoGw4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VkC24DCIqQkRMMkg0GvJ9PGztqCHjwxAPqMH4tMxMFvsHNWX9sqjBVWCQcaC6emcZba36X80AZWhmyr98SGUZlBXcZOvEfgJ49NtNbnR9jc7muDUEo7Q64jOP1XjW3J+n8mmzxv4sQLj6vGVvhaxvNd0TnfMMAKMFB5LOz7xInyhp3QEucEIGKRMPXBNGDyosp34uS7L9VQ8Lp8j/WEy6nDEOPvCzTsYKvb/pZje/GefUwuEHzHDXo7jrAWxP1tK6wsKz/AqS9hphJCuU/M9A0tRdiegWF8CtlTZFpZhNpJysx5iS6L1rtT5Eou7YgwmnvEER14xNFSflRjeJTYkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9611
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0d5f6ddd-4dfc-4257-e2fd-08de995044bb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|14060799003|35042699022|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zC0JDZU4nuZYu6Vgw1Qf7hBAgAI4FBtxtsu2DVuVjMMgmMvRswrEdNJDIeGahGhDUE6JKGdhZNPIjGLDdW6mr/b7rElSdVMxzktxU10f+4bK0ZXJGx7UHI5NgLUnvD3hx6TwJSQq2VfddoEYLm4f5mlzsID92J0v+Pg/73XQz9c4Icx0D1E1ujUM51t4PAcOlJwZS2u5/R8wZbpkatD8xMqoXQrH09CCwIirGcx0fjgWruDOeVMHebbMV4cqKWz08LDBAGb7MNoSl1omAUPWOBvNeCBGeLF6U3y8AOUOX0vP7i92FUiMWXh3upaNhhTyd8/fIctlRFu0nNNmJpw29gVBLq9rsV6Pxry1dLXR2RBkHnleAEQs1x/6t7/Zk45AecTWD+kOiJu9RO7d1fNhmiHOY6wyvkpDNnYl3odorfbJibf7trI61Zigd6f3gNAAAXRX62WC0/NYQPEhrfV/ZgVOewhx6LoUKEhHo3GM8UhUFIgB0GNaSd/tQlyvBaWJOQ3S2OKb7QIQI3nmNJikY7w7FxjxFjr6/T2vmNaJTLz4Wh50lwKKDIrXYHsudq4apZh75UID1Bslas1rb23NiPK8gVQc9Ri7wAANcLDNF2YD6vxKDEhSISB6A8Uabc4iDPfJ6thGEAHM9Ekw1tlJxfSrneNt3enQPnCeRpihqYsnsuS0F3zMXRK1/PEtWGxlBCMtPJhZ7cWBAHLsjKSnm6rJEGRgSqUGy1sKzEv5Tb7g3/qjoowPlzkVjmP+6BakAhJH53ZiqDhmMxeMxwsafQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(14060799003)(35042699022)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q6HpmXARFkBzXSN3bJc/XwrX+zl6Qoz4mrFgqD2NOKUh6K9c5UDObvi2PfzzoeR16OpoCivGoaINd457pelzZbwBdXZTeGnPcUEtqADHW4VHFDTvZaKWXPcvvfUw8L3/c0BvQQzDA0oYKFeda2szeaGLz8aO7SmPYi+Dj7XIYwi7IL3SA8ndAdOEuqSqzsr4tvpYiHIo4qjOw53TRocxWqcBOd0+qQXIWkOr65BlLdWlhj5xdYmEp77PTbvL5Wnq7NZiywu2mypZRBABACCeO08ll29hP3q4mwlDCxl4G2siksaeIhWUaK1nnyc1tDsP+FwCVLIPYMLy+a25yjcbIgMydw/hzupxVAuNDrKUqc/lpiYEH89nBAdi8EGlJ9WDR6FHZz/JkYiqeYsEXb1Zp7Nh/GqPwy1OwWAtTY+NIrsXu60L5apTVwJgkzUc1rTg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 11:32:59.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e88062-e789-47f7-ba20-08de99506a8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11566
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

On 13/04/2026 11:35, Liviu Dudau wrote:
> On Fri, Apr 10, 2026 at 05:46:33PM +0100, Karunika Choo wrote:
>> Update common IRQ handling code to work from an IRQ-local iomem base
>> instead of referencing block-specific interrupt register offsets.
>>
>> Store the interrupt base address iomem pointer in struct panthor_irq and
>> switch the shared IRQ helpers to use generic INT_* offsets from that
>> local base. This removes the need for each caller to expose absolute IRQ
>> register addresses while keeping the common IRQ flow unchanged.
>>
>> No functional change intended.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>> ---
>>  drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
>>  drivers/gpu/drm/panthor/panthor_fw.c       |  4 +--
>>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
>>  drivers/gpu/drm/panthor/panthor_gpu.c      |  5 ++--
>>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  1 +
>>  drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
>>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
>>  drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
>>  8 files changed, 38 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
>> index 285bf7e4439e..35a70df4a5da 100644
>> --- a/drivers/gpu/drm/panthor/panthor_device.h
>> +++ b/drivers/gpu/drm/panthor/panthor_device.h
>> @@ -82,6 +82,9 @@ struct panthor_irq {
>>  	/** @ptdev: Panthor device */
>>  	struct panthor_device *ptdev;
>>  
>> +	/** @iomem: CPU mapping of IRQ base address */
>> +	void __iomem *iomem;
>> +
>>  	/** @irq: IRQ number. */
>>  	int irq;
>>  
>> @@ -488,6 +491,11 @@ panthor_exception_is_fault(u32 exception_code)
>>  const char *panthor_exception_name(struct panthor_device *ptdev,
>>  				   u32 exception_code);
>>  
>> +#define INT_RAWSTAT 0x0
>> +#define INT_CLEAR   0x4
>> +#define INT_MASK    0x8
>> +#define INT_STAT    0xc
>> +
>>  /**
>>   * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
>>   * registration function.
>> @@ -498,14 +506,13 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
>>   *
>>   * void (*handler)(struct panthor_device *, u32 status);
>>   */
>> -#define PANTHOR_IRQ_HANDLER(__name, __reg_prefix, __handler)					\
>> +#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
>>  static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
>>  {												\
>>  	struct panthor_irq *pirq = data;							\
>> -	struct panthor_device *ptdev = pirq->ptdev;						\
>>  	enum panthor_irq_state old_state;							\
>>  												\
>> -	if (!gpu_read(ptdev->iomem, __reg_prefix ## _INT_STAT))					\
>> +	if (!gpu_read(pirq->iomem, INT_STAT))							\
>>  		return IRQ_NONE;								\
>>  												\
>>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
>> @@ -515,7 +522,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
>>  	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
>>  		return IRQ_NONE;								\
>>  												\
>> -	gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, 0);					\
>> +	gpu_write(pirq->iomem, INT_MASK, 0);							\
>>  	return IRQ_WAKE_THREAD;									\
>>  }												\
>>  												\
>> @@ -534,7 +541,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>>  		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
>>  		 * covered for.									\
>>  		 */										\
>> -		u32 status = gpu_read(ptdev->iomem, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
>> +		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
>>  												\
>>  		if (!status)									\
>>  			break;									\
>> @@ -550,7 +557,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>>  					   PANTHOR_IRQ_STATE_PROCESSING,			\
>>  					   PANTHOR_IRQ_STATE_ACTIVE);				\
>>  		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
>> -			gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
>> +			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
>>  	}											\
>>  												\
>>  	return ret;										\
>> @@ -560,7 +567,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
>>  {												\
>>  	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
>>  		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
>> -		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, 0);			\
>> +		gpu_write(pirq->iomem, INT_MASK, 0);						\
>>  	}											\
>>  	synchronize_irq(pirq->irq);								\
>>  	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
>> @@ -571,17 +578,18 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
>>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
>>  												\
>>  	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
>> -	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_CLEAR, pirq->mask);			\
>> -	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);			\
>> +	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
>> +	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
>>  }												\
>>  												\
>>  static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
>>  					      struct panthor_irq *pirq,				\
>> -					      int irq, u32 mask)				\
>> +					      int irq, u32 mask, u32 irq_baseaddr)		\
>>  {												\
>>  	pirq->ptdev = ptdev;									\
>>  	pirq->irq = irq;									\
>>  	pirq->mask = mask;									\
>> +	pirq->iomem = ptdev->iomem + irq_baseaddr;						\
>>  	spin_lock_init(&pirq->mask_lock);							\
>>  	panthor_ ## __name ## _irq_resume(pirq);						\
>>  												\
>> @@ -603,7 +611,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
>>  	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
>>  	 */											\
>>  	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
>> -		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
>> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>>  }												\
>>  												\
>>  static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
>> @@ -617,7 +625,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
>>  	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
>>  	 */											\
>>  	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
>> -		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
>> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>>  }
>>  
>>  extern struct workqueue_struct *panthor_cleanup_wq;
>> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
>> index 1c13a4884201..20747f42759f 100644
>> --- a/drivers/gpu/drm/panthor/panthor_fw.c
>> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
>> @@ -1088,7 +1088,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
>>  		trace_gpu_job_irq(ptdev->base.dev, status, duration);
>>  	}
>>  }
>> -PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
>> +PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
>>  
>>  static int panthor_fw_start(struct panthor_device *ptdev)
>>  {
>> @@ -1470,7 +1470,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>>  	if (irq <= 0)
>>  		return -ENODEV;
>>  
>> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
>> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0, JOB_INT_BASE);
>>  	if (ret) {
>>  		drm_err(&ptdev->base, "failed to request job irq");
>>  		return ret;
>> diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
>> index d523d41e18dd..eeb41aff249b 100644
>> --- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
>> +++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
>> @@ -15,6 +15,8 @@
>>  #define   MCU_STATUS_HALT				2
>>  #define   MCU_STATUS_FATAL				3
>>  
>> +#define JOB_INT_BASE					0x1000
>> +
>>  #define JOB_INT_RAWSTAT					0x1000
>>  #define JOB_INT_CLEAR					0x1004
>>  #define JOB_INT_MASK					0x1008
> 
> These definitions can be removed now.
> 

These are removed as part of the conversion to local iomem pointers in
PATCH 5/8 to 8/8

Kind regards,
Karunika Choo

>> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
>> index ef0aca2b7532..3ddce35ed8b5 100644
>> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
>> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
>> @@ -110,7 +110,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>>  	}
>>  	spin_unlock(&ptdev->gpu->reqs_lock);
>>  }
>> -PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
>> +PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
>>  
>>  /**
>>   * panthor_gpu_unplug() - Called when the GPU is unplugged.
>> @@ -162,7 +162,8 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>>  	if (irq < 0)
>>  		return irq;
>>  
>> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
>> +	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
>> +				      GPU_INTERRUPTS_MASK, GPU_INT_BASE);
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
>> index 7303b7f5ee18..d7cf5165e987 100644
>> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
>> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
>> @@ -19,6 +19,7 @@
>>  #define GPU_AS_PRESENT					0x18
>>  #define GPU_CSF_ID					0x1C
>>  
>> +#define GPU_INT_BASE					0x20
>>  #define GPU_INT_RAWSTAT					0x20
>>  #define GPU_INT_CLEAR					0x24
>>  #define GPU_INT_MASK					0x28
> 
> Same here and for all the MMU register names.
> 
> With that cleanup,
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 
>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>> index b9f6031e24a4..b8665e447d95 100644
>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>> @@ -584,7 +584,7 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
>>  
>>  /* Forward declaration to call helpers within as_enable/disable */
>>  static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
>> -PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
>> +PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
>>  
>>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>>  				 u64 transtab, u64 transcfg, u64 memattr)
>> @@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>>  		return -ENODEV;
>>  
>>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
>> -				      panthor_mmu_fault_mask(ptdev, ~0));
>> +				      panthor_mmu_fault_mask(ptdev, ~0),
>> +				      MMU_INT_BASE);
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
>> index cc9cf603cec6..de460042651d 100644
>> --- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
>> +++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
>> @@ -5,6 +5,9 @@
>>  #define __PANTHOR_MMU_REGS_H__
>>  
>>  /* MMU regs */
>> +
>> +#define MMU_INT_BASE					0x2000
>> +
>>  #define MMU_INT_RAWSTAT					0x2000
>>  #define MMU_INT_CLEAR					0x2004
>>  #define MMU_INT_MASK					0x2008
>> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
>> index aafb0c5c7d23..4f600a6688f9 100644
>> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
>> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
>> @@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>>  	}
>>  	spin_unlock(&ptdev->pwr->reqs_lock);
>>  }
>> -PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
>> +PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>>  
>>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>>  {
>> @@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>>  	if (irq < 0)
>>  		return irq;
>>  
>> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
>> +	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
>> +				      PWR_INTERRUPTS_MASK,
>> +				      GPU_CONTROL_BASE + PWR_CONTROL_BASE);
>>  	if (err)
>>  		return err;
>>  
>> -- 
>> 2.43.0
>>
> 

