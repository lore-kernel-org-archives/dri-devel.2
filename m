Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0136C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274C610E320;
	Mon,  3 Aug 2026 12:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="P4bnPB7r";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P4bnPB7r";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE87C10E3FC;
 Mon,  3 Aug 2026 12:09:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xyFQUdpghxE6z8vw7WTIExxoVxaL4hTbZRYSWdFiGwewOHNRUZiyhikZMsPtAz8jKsUu7xPfhTF6YLvgpSZXTGiz/nmSZuC6k7QgZo51nEpdGliFQVIINC2LESrPnAaw7oqBUbjF/9lSuQTvihx06eS/TGCY8nMT5sgy/GUvSo6Op2+gBjNpOk9z1nEo6/D2URork1+z2a97tDxptpvltCkULoKfdMjzwBwmPfvikdawWZM4KjMBXU0GImPJACs+VGG2rtaG7jtL96m97Z4AZs+RkhZhR9qzQshsCKWzKdQ/JTehlSj25VQkEvgZKUXxuI535giNvJl038hHVUQ2gQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/Ozc4f3YVybAl3Vo4+gMdf7fy0KjXpzjxraXVa+6cU=;
 b=cfv6je8ulQ4sv9ZchEhPTVpn0HCLCiErsGd1OWPlKdnjuy7+UDtYO5pA7DyDsrLWhl65hPkvOqQqY/GxMm6VV5JNylMOKvZcwuCk+001INJkh8viq2+d4SDOXGqxgGihgaAAgvav3qFFoL0Xvw34d31bSxgTccw1QAhpKrJlOgdseNGYiAA/uXoI4d8/N/FTpVwa1HQLLKKxDEj4byUBi8Al05gE8zDpGQGbtcylrIvcCcPGYDc0K0f1p1U8ODTwPdnAOwYLIFiZoA5zCHYwKLuYIbIGfKz9IelcH0zir/+D/8uBuqV6ofpYCK08bJQlERKWlCPzvEC2D66CNuwNuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=broadcom.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/Ozc4f3YVybAl3Vo4+gMdf7fy0KjXpzjxraXVa+6cU=;
 b=P4bnPB7rB5RD7Ihq9zTfieG6QR0uUWEcLUPr+w7Gy9O0XknlhTF+nVKnwT1/LbJYc+v8NHb0GyJvV7piLL2LlAWiu5V6IfBQQ6AF1Yo6Xd8hMlyEqcdy3tJHFBpH6otFPEyuqM6dCTsM4aOh5UAqsfldK8Zq01tKQRVRNR42O84=
Received: from DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) by AS4PR08MB8165.eurprd08.prod.outlook.com
 (2603:10a6:20b:58c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:09:00 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::46) by DB9PR01CA0029.outlook.office365.com
 (2603:10a6:10:1d8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 12:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Mon, 3 Aug 2026 12:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbBCiUsBf4xy8Rt3clixtQXjZb1GR8dgot9zaIbaEGkJbJGiTEDW/b+YzKosB3kWNENLbZ2Iqhnzx8euqCj9QAhHlq6r1GjRHNZYVlBfB8znhyx655c3qXKRxPu775725Xu8+9pnvdu30/ZEKYQXxp4vXvl3eXFNsBJ+NtutLKXjAPblsoAKmSqAoMOMNYCjtCeNbe9IQrPL7QBMUfHIU/JAkgqqGPd4+Xpxnt3/so1Dv6Y3YUB5ATLQe4R1JP8OH8zlwOdJ62Nk5qX9hpzkBjXjMlTXrXSDqfRzvCB60zytVfg2t23uFJGQmFoBap1rgnS+VU93wuPxo4hhVhQTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/Ozc4f3YVybAl3Vo4+gMdf7fy0KjXpzjxraXVa+6cU=;
 b=jPnID/UIrBIrRhhMaucHo7/x8iaZp3xFdpZY73lEq/3KYzdwnCcsXROlRaAIz5gxhioKs5xqlD/+1KzzZ24NxoKKnPhh35vblMsDOg8s2SJiTjUwv9tu6Z6WnDeiVHc3ndXNvkJlAPj0sYcHlyAI1CI0ATLe+or4ZzNYM4glogOzTlQNMKjfh83+jDqJOf38Zfd407wc+ycTxilWd71JLIjV6+PISVhEfYpm7kjszj8O2TMY7L/2vU/x10iJGFhHgEEUrzf6CAqA245XAFUn+6I5PjHOLDueB0wK0i3mgjHk3Ug7HNm4FGpAYpcY2MmVZppxyLDRIs/e6uCyLVM2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/Ozc4f3YVybAl3Vo4+gMdf7fy0KjXpzjxraXVa+6cU=;
 b=P4bnPB7rB5RD7Ihq9zTfieG6QR0uUWEcLUPr+w7Gy9O0XknlhTF+nVKnwT1/LbJYc+v8NHb0GyJvV7piLL2LlAWiu5V6IfBQQ6AF1Yo6Xd8hMlyEqcdy3tJHFBpH6otFPEyuqM6dCTsM4aOh5UAqsfldK8Zq01tKQRVRNR42O84=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by AM0PR08MB11281.eurprd08.prod.outlook.com
 (2603:10a6:20b:701::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:08:27 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:08:27 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Mon, 03 Aug 2026 14:08:14 +0200
Subject: [PATCH resend v5] drm: uapi: Add macro for chipset specific event
 ID region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-drm-uapi-vnd-v5-1-1a715a6842c1@arm.com>
X-B4-Tracking: v=1; b=H4sIAK2EcGoC/52NQQ7CIBREr2JYS0Oh0saV9zAufuHXEgM0/Eo0T
 e8u5QjuZiZ5bzZGmBwSu542ljA7cjGUcjmfmJkhPJE7WzqTQmrRiYHb5PkbFsdzsNyqCYceezk
 pYAVZEk7uU3X3oiMMlj3KPgIhHxMEMx8yD7RiOoDZ0RrTt97ntmL1Sbe6Vd0gZKNVyZpLPmIw2
 BiKL6AbJN+Y6Ks8d39w+77/ABPmqWz8AAAA
X-Change-ID: 20260408-drm-uapi-vnd-d3fe87e72f3a
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Peter Griffin <peter.griffin@linaro.org>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 nouveau@lists.freedesktop.org, 
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
 Daniel Kiss <Daniel.Kiss@arm.com>, Bence Csokas <bence.csokas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P123CA0209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::16) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|AM0PR08MB11281:EE_|DB5PEPF00014B95:EE_|AS4PR08MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cf5d99-5fde-4568-2a9e-08def15800b3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info-Original: u6VS+Mn6BgTbcSNLmfcDqINMZQ8AlEGdKfnVvss9AjFMYxb091wyAh1n0eeecQddC8VxDpSMQRcZR3G9sqEbJQOilZr/LmQk3zo5rYaY5OqXloIR7NrnDOacWaMuAMclF+1APLY5G70anZo8wAtD4UAQNj5HOyoj84LlOQPbKlxVoOib+SFx9YflklOAm1CMpePJ4mGW5QgTUkQ7SG+0HJXfpT7rxAu6cdyZKcwa9Yhij1MpXiI6c3lDMJnfjWvL2/svsRl1U8Cyhf6iPchvR+RzWQvq/rrIgwdXJCcw/4Mv5clpKClDBIQo2zew8weAv+H9+Hro34Krty5PoGWnugWMcTJU4MhabwLKEmmMfAl7eBy9kKTml3w79GvDQIYQn6hw6sV+G2qQBzSOG+h9K6N9NcrZVMIUFe7aVDBtxaFYUCnqd4Uk05iCSo2MI1+9ReEDcyQxcH1pxA2Ok55SATtzQqrdIXt7fAIN/R1GzYoHqAxp304f38+YN8kjU2dx42l4TfYu7zFZp6t5FlafjAo9Y1L/fFkhBSEC2pseIoiJBHdCI/fdeJsYq2TWDEwQWuuekyp+xU+eYCTxwpIJgqq4E9dzfrHkKNpE8X5pY1UKpf2IcTF0uEH31nic7D+8RwBHgwRZ9eh7jcegJa7DvMkPvS4Uhc9CtIeRlDDFgFk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: L0d33xTxmeo7j1WHvQbuQllmN3VRaeKU5SX4vku53UPovZ/e5JOliN3Eo2W04Jrv0xSqQ4Of5NMqpEo9XUYAwGIWX/AwwDq4ESBRUspyzhfWSp2WtUF99ctQw5IEw6jP2EwUjQaWypOxwkTgg3FgA5CDeH2qpKUzCyiBJRU3NcGAkpsb6UD07fWxfK5zC1wSj1c989SVaFLPNxj8L+XMEzvmmvR4Bn7sGhctTGRje3NzoaO+p6ZAYUrUKtqRZxQYe8avG0Rk4G7lW+PFbzs5sLhnmAUzFlSLyuaIowoR/0EwUa9UNOhy51v3rgIYheTSi/b6QiCpnzx/MEMLZza3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11281
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 68b788ec-f6a5-4bed-da59-08def157ece5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|35042699022|36860700016|23010399003|1800799024|7416014|376014|56012099006|10067099003|11063799006|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info: RjlyU5sK7gqU/arzt5GUq7CFHkjmwX2258zCGsQOMDaqmrZXg0K7LEXhTpymMMeGY9gsYp8hrCOO1Pezng5DhjjoONg9WmAvf5c8rbZ8sXVXxHY+ho944MyWVw3NDdmNDnG0g4bNIJmC8RtmEUeXQmt+Izhbjp/S+4cI+9TxYKFaXtMeWmexBE5q5s7nreDMuQuK/03vpdwsTAQMM31+5lnU+8c4uon21sW0Lsw0pwhNl881XbTzXVvn0B04eSQKNg4oTNyceHnaN4pPZKoRIBMOCbb8bEGQahyB3fyX39vRs+FSaoAlZbhimXIiHaaj3gEyQDeLcC9VmATulVcT0DBtujb8vXFvNyWyhSZH1TgLjH1scJMkBVSOMjC+WITswnb8V09o8FWwlEPJ/a2dpMn20qtNdfLen877Tk559AAUeAfrP6T3+bUqdS9MJ9xTSmZ+/U267F79RiTSWBnsf2L7HUtmQYi60LfkMwrg6yaLngX8M2ljKaWjiGQwtegRli7uZ9fLplBTlW/v//OczVx+E0HzXArzqr/Skp2PQOS3PfqSAGv8QCglL7GEsH+FluuuEsCHcbBZ4H/aCrgoK1wJsROXgaoW78dc5oGgFrYjreiQgiajKFCznbDPllrJBF5r2jFANvm3st0R9DVkp3B/mLxWyXE2gUp3r7+UwXDPE+vxH802DS8gn+SbiBoLBsExaklYyr0/dJatE+Bmtw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(35042699022)(36860700016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZFJ9bA8EVuDOXwcPiRQRmtVCGOjXW7USlVJt+fhu8j+58OkuEtrmLf1nU3guuY0CxC2M7PRhR2gNM390oFlvtWJuL0sLpqfPQ8N3yKzuJWGrrChNFbJxdbbGCJ/wiGUKKJS5GLXXdSDVpf8uDFZQ8KzEoJ748kZowlkMG75hz1iOBs0uAmie9NfUne7OHp38rFG1bA04DEEQf0Yx1mJe7BjhFZaNRWZEidnxAgGTgI2HROHp3ks3SL9IHOMOUNkm0dgNcNOHeWgQrE2QZja7Dm4X5kGMOVOV8KazxBcIf282WvUJkamQps2lx/wS+K1R7rNtvq9FbM74a+GpiP0oCDSSIbQDKJfmP5jWV1XQGmSXNKED1j48YByM+cfKr//t3BN1brozYy/87TOKmPNyQTLDmoZEUwXNAQn7uMxyJNDb9aLC9Lkh5jQB6wtfTz6n
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:09:00.3263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cf5d99-5fde-4568-2a9e-08def15800b3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8165
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

uapi/drm/drm.h states:

    Event types 0 - 0x7fffffff are generic DRM events, 0x80000000 and
    up are chipset specific.

However, this distinction was not put in the code. To elevate the contract
between the generic DRM framework and the driver from the comment to code,
put this in a macro for clarity and convenience.

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Link: https://lore.kernel.org/lkml/d37a738d-f316-42cf-8dbc-99a732a33240@broadcom.com/
Cc: Daniel Kiss <Daniel.Kiss@arm.com>
Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v5:
- Rebase to master
- Collect Maaz's tag
- Link to v4: https://patch.msgid.link/20260616134802.636166-2-bence.csokas@arm.com

Changes in v4:
- Document `_v` parameter
- Also convert DRM_NOUVEAU_EVENT_NVIF

Changes in v2, v3:
- Rebase to master
- Link to v1: https://lore.kernel.org/lkml/20260408163608.361826-2-bence.csokas@arm.com/T/#u
---
 include/uapi/drm/drm.h         | 9 +++++++++
 include/uapi/drm/exynos_drm.h  | 4 ++--
 include/uapi/drm/nouveau_drm.h | 2 +-
 include/uapi/drm/virtgpu_drm.h | 2 +-
 include/uapi/drm/vmwgfx_drm.h  | 2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..c703e106d750 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1408,6 +1408,15 @@ struct drm_event {
  * The event payload is a struct drm_event_crtc_sequence.
  */
 #define DRM_EVENT_CRTC_SEQUENCE	0x03
+/**
+ * DRM_EVENT_VENDOR_SPECIFIC - vendor/chipset specific event
+ * @_v: vendor-specific ID
+ *
+ * These event IDs are reserved for chipset and driver specific events.
+ *
+ * Refer to the chipset driver's header for details and payload struct.
+ */
+#define DRM_EVENT_VENDOR_SPECIFIC(_v) ((_v) | 0x80000000)
 
 struct drm_event_vblank {
 	struct drm_event base;
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index a51aa1c618c1..8d3156fb129c 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -395,8 +395,8 @@ struct drm_exynos_ioctl_ipp_commit {
 		DRM_EXYNOS_IPP_COMMIT, struct drm_exynos_ioctl_ipp_commit)
 
 /* Exynos specific events */
-#define DRM_EXYNOS_G2D_EVENT		0x80000000
-#define DRM_EXYNOS_IPP_EVENT		0x80000002
+#define DRM_EXYNOS_G2D_EVENT		DRM_EVENT_VENDOR_SPECIFIC(0x0)
+#define DRM_EXYNOS_IPP_EVENT		DRM_EVENT_VENDOR_SPECIFIC(0x2)
 
 struct drm_exynos_g2d_event {
 	struct drm_event	base;
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 1fa82fa6af38..6d9d7ed52d28 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -25,7 +25,7 @@
 #ifndef __NOUVEAU_DRM_H__
 #define __NOUVEAU_DRM_H__
 
-#define DRM_NOUVEAU_EVENT_NVIF                                       0x80000000
+#define DRM_NOUVEAU_EVENT_NVIF DRM_EVENT_VENDOR_SPECIFIC(0x0)
 
 #include "drm.h"
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12aed5..4a2f8b1e9225 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -229,7 +229,7 @@ struct drm_virtgpu_context_init {
  * effect.  The event size is sizeof(drm_event), since there is no additional
  * payload.
  */
-#define VIRTGPU_EVENT_FENCE_SIGNALED 0x90000000
+#define VIRTGPU_EVENT_FENCE_SIGNALED DRM_EVENT_VENDOR_SPECIFIC(0x10000000)
 
 #define DRM_IOCTL_VIRTGPU_MAP \
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
diff --git a/include/uapi/drm/vmwgfx_drm.h b/include/uapi/drm/vmwgfx_drm.h
index 7d786a0cc835..5e5878384e60 100644
--- a/include/uapi/drm/vmwgfx_drm.h
+++ b/include/uapi/drm/vmwgfx_drm.h
@@ -715,7 +715,7 @@ struct drm_vmw_fence_arg {
 /*
  * The event type
  */
-#define DRM_VMW_EVENT_FENCE_SIGNALED 0x80000000
+#define DRM_VMW_EVENT_FENCE_SIGNALED DRM_EVENT_VENDOR_SPECIFIC(0x0)
 
 struct drm_vmw_event_fence {
 	struct drm_event base;

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260408-drm-uapi-vnd-d3fe87e72f3a

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

