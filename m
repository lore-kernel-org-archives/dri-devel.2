Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BAECD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AEB10E7F7;
	Thu, 11 Jun 2026 16:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JmUqed/g";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JmUqed/g";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FD610E7F7
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:12:18 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cPbDCCFjutRq6eT7EKO01ArCO6M9HdSx+iC5H4bP8Xj7azqVXc3WDHVLsMeCJdIzmqB3056L61+Vr8tq7sMObSkhA20unsJhlwwTdzSI7DBNsC53IitN/F0u7QOLJuoO3qlmTsa3W1u2Rf0+G1XIuFAndxqbLmGUttc2AB2A8McvyQrngz5Gtk5+Ei9rvPw6jxs2AEKXxzE+cCwpHPQsTPAcCKocSx9o+D3brnQ9bq74XY9b7pkLohQH+iiM7MUEOYyLTrhp8JWKLNKktrsxMDI3g/0ok8SqL/StoStsy44ZVHSl+GJ302oIN9Dpvl84JHWaEpHythbSvVn3FqSR/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm2S5Qyo09uGfWBhPX447a8a+cb1mhBAAflSx+yXkoA=;
 b=jC3ww92suBl1qdPk7Wy9xYXGL+StUoTCoj4pGRYBtt/Yo28ZDf9ryoSTbQfoOtFQ0sEuH1LHIfG9u91xC2Ad2Yx0wV6Dylbr0TWk+OkDvaAYF4MUoAuTbgHmmn6cNq0edz+biuphYNtr4q5/f2MkxxidWtIdkP9sJYYxH4CxK4jclUIqTiAtQHJtevAdDtJ8ic+aebQHnKumeBqiWWabf7TKx9y95q46+WZXWJocA+TwYEBoSb0rg1j+2PqhfEc4XoS5WFq6DXki2+ZQnyQ2r8y2eTGCRbZl2G0L1E5NunqFxFaSg0sko2vhLREoICkpOCpt0J04CBk8JTHPJ6QibQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm2S5Qyo09uGfWBhPX447a8a+cb1mhBAAflSx+yXkoA=;
 b=JmUqed/g7csmnxLyFbp8DypOh1n7IUH78W2R/oVntZmDi6opX0rwT/qFo1+8oZgNXiZCmnw9XdP6uVfbQ3dAEynLO9Vn3BFxhVVmYo188RluNF3h8B8K0I0kldkyYnZTeTbPaC/udeK9X5eEswYbcExfkwPT4A8W5qMYOVaGazY=
Received: from DU2PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:10:234::23)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 16:12:09 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::75) by DU2PR04CA0048.outlook.office365.com
 (2603:10a6:10:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 16:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Thu, 11 Jun 2026 16:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY3LVPX2elyaatMDdpY+W3NubAIpPdXmRcsP9fdPgNX4MJCJ2xG770rSHaNEOIcBafGqyUqtanMBkBFEqBTz53fzoL2a41VrpCdgTJlurRpS6GR7HSbsXdeM1413QSIjqrkjjm7ANp8ILVNdt/Lr+gl7XTU+tPWy1yAJXoXbUEmMB+2JB9heZ0cRQyZMxBh8f9V2jBR3AIT6WiZWzCoIEulYSh7u0PkIfWGxbR7JlImwsMfkJBbqfGdY+HjzJozfdepsyJPTyfdXrKPPAZ0uwN0Lycbrp4/KCiHY/Rfj82tOubMJptz2YaSTfUoFU1YBeXgEH/DzbyRn5YRjTw9Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm2S5Qyo09uGfWBhPX447a8a+cb1mhBAAflSx+yXkoA=;
 b=Sak0/WrQB22qCyz9s1fCalWPoTJtp1zvoZUJBO6Y/FdksKFsOZ4LtyRezN62x5eJPlx935+Stv8ufS4aaL8BXa7EVVHLTaOgJzwwwVsTGsiC9+L+MO5M0L2UndeLjOxzKwSIx5X6TK9pnRz8lVPNkxlu9MnHDxPAdqumutDAJiCYYGG+GXh71sYmPZqBVjJq9qwKob7D4+b4QhaMwy7hMUIKgNf19Ycw8F3nKFwamIAy8mKmwY0ORnFVsq02KxjZBImsTgAfnUxzGKWbD3pP7lHVloXG2wfPk8rZNbGCRseaA5H//NVWEvfPkroiHf7rH7iGqCqfdDBCgfw/rOPs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm2S5Qyo09uGfWBhPX447a8a+cb1mhBAAflSx+yXkoA=;
 b=JmUqed/g7csmnxLyFbp8DypOh1n7IUH78W2R/oVntZmDi6opX0rwT/qFo1+8oZgNXiZCmnw9XdP6uVfbQ3dAEynLO9Vn3BFxhVVmYo188RluNF3h8B8K0I0kldkyYnZTeTbPaC/udeK9X5eEswYbcExfkwPT4A8W5qMYOVaGazY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11183.eurprd08.prod.outlook.com
 (2603:10a6:150:1fc::16) by AS8PR08MB9885.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:11:06 +0000
Received: from GVXPR08MB11183.eurprd08.prod.outlook.com
 ([fe80::5576:8db3:22e8:135c]) by GVXPR08MB11183.eurprd08.prod.outlook.com
 ([fe80::5576:8db3:22e8:135c%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 16:11:06 +0000
Message-ID: <6462b21f-a624-4505-b0aa-b2d96d7a8564@arm.com>
Date: Thu, 11 Jun 2026 17:11:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/18] drm/panthor: Derive MMU AS register addresses
 from base and stride
Content-Language: en-GB
To: Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-7-karunika.choo@arm.com>
 <ca983479-efcf-4b8d-825d-69b5ab54d92e@arm.com>
In-Reply-To: <ca983479-efcf-4b8d-825d-69b5ab54d92e@arm.com>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::13) To GVXPR08MB11183.eurprd08.prod.outlook.com
 (2603:10a6:150:1fc::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11183:EE_|AS8PR08MB9885:EE_|DU2PEPF00028CFF:EE_|AM7PR08MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: f12f35e4-7c69-4a14-e500-08dec7d4309e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 8I/XSvaWE5fh5JrnxiO7yze1zJc24z9AALhlKjTtWWJdl7UfAhb0gslYduI/s4+oOGvOeTfNhbpCbrAhgNbomLn3aHQQCvZy3h1y0GrQC0wNwI8ik38suJjMVF+RpNv/a5cHW6R35KEMxpFGST/nu5QK3LIIq6ig2rnv32ys6T/+UuB6CyBPP6fbWmfbSKT5K9tFP3J/S4BQMIzR/6Ubfa1qW7ceFZ3AQFLAMIrvrlsTiFHwxJV+1LE2CG3a6I0b/e7H71QjJ8IxrBbEWBrbC0ler3krU0jfDblMnB4pCbDFrTU1701U9rNyQNHYRjucPX+1ZdLh61LCeKXiCN5LmOdDUG5ZMcf9ysIkpvQn3mm4PHIkSuvaE8vjmaBbAwecPf8akyzH/b7M+DisRCYNrkCcBbJ1GCK/IVF3uQqjRGmdu4ZFh6IC5obAvXc/bNRCmKpr7GLbvx7Elw8SXZTjG0Lx4To1vRVoLu1fxirfbHDLXCO+eL2OHBSjihWJ5lf7bL96BmNbnO23hh2324+nUjlo8TAq1Gq9tIQGm+l2HjGtRaySwadkxNieWTD9uv6veYBDxSrk3dXsF4jeg5XrqNzBChKZkX0XeyNk/llsvb+Twn9l6355by28obYR/hNqvIa5rotok+j5EBnXWOT7feL7s4bns0zifGeqHZKS48/keSmvIgJ8WZLwawcSt9ZO
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11183.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ePAJalTkq9wc16L2EeVo/kaA5UGontg4wfR62hPxzzlL+ECBpiQYvnLG07QFBOS/thtw3tGSu/gDKoZs/UYxxzYGnZQmrshIN4qgSQOIlN4rYpNEjkTsvFMuYuQIaopbhyS49pE34xUIIuSdd1An/Cd/M3n50dAfGnaQJJV2dEt2KR4j4PqMTYJVVudTrFRHNKAtWSvPRJ4FJvHsFld96+Zc+Fpkhwqhx7BQoBwBFSxAfyJjKvfAOy8aaBEBaDM5fkAo3Q2uj/ZiSvQEL5TqIDCsKOZMOesWVvSDqsB32qE09b60zQIG7NTFr6B8XorpunPnSX31f8a3C2p8XKzpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9885
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9487463b-8452-4f9e-c1d4-08dec7d40a99
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|23010399003|82310400026|1800799024|376014|14060799003|36860700016|22082099003|18002099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: uwQPuGwWjy/6uYRPB3nhWVS0hsRc8t4ElypZjkeEATS81dgwewz12UGTmAKSeKKzZgDmRXObnalQGT64jZwpP01IJEhQ4Cszvs0kHw4HBt64dhBtM1RMsN6w1f/r+Hg/GW+AFQjlXBv5reF//aYghTyDjPDmxlISwoa0+8bYOXbpeVp/20LroS0P+8a+KAHAy+VgrBTIadFwCOSR7g9cxUEt5m3SrIpf8zYH5UtjTH7vXs/iuwqRk3pm9Eg7k+ON5VoxGVehQC8sSjrOyyATp1fVDslrTVzo5lXOWlILmZ92TNXx93x4FvUFQ6/JAYv75gyR+n9vB5M4vtnBLsn/KoFMcUFMIz2FPnpSD9S04qiSQoNsl6MHZcCkasuzEDwqW7a7ENzJ26oYQC7XXSaeWbdfxmzZoIX0aYHqpjdbFA5KqwCQOLk2ib1WNnBK86bI66/nXz8axovOM7bwaikc4AzRDgpkRjPe+eTTQfGGsJT5Ygy7CzBQiFIV7Ph0UxaDzrF+T6BoB+ig3nInzG7hx43G4DvuaoTtyH3IyUvc/T90PxktACzDeR+4Cs1T+6SYQ57D6HEby/NJdN4cNWBVFte+Jz4Iq8wqXdvJ52IPtzyx6OmLNlS07h2pIqAywqCCnwSaSrUJbeG1C1KfsFaKX5IUAnG4nCOhWTAk9vnQq/Q53b9SjSJIhuUybnugkupfTOveQNn1wDTQZt8qp3zraIJP+MjGq+VcJdDUI5N52oU=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(23010399003)(82310400026)(1800799024)(376014)(14060799003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SV0QcTbmvpMEhZzWlOCOFAm4141g00bXNXhCnceIj0k2IHkCUaGd1hvgKnv/jloz8+eLfm7k4da8OCBCCTlPBebF03MnoqHjvXk5DTCqOTZ8PojmaHpqRcEVVqNaaGBEAfzqfgc5CExa5rR7NI2z+zkDxi33Y3ztVSnbVa1baXT5xaOgK0qPWfqK1eGyJNEzJZul89OKFhX1D7XOZU8w9yWfPcslf546Wvw8vJXU8kqBswbNhvihYYyZoile831tgYP2sUfLebKm4AvCHUTgm5rNce7syA9unxyYRcwe638VRFKjcp6NI9ZICq6Lz1h94Mz4c/Ymr/Y2dwn3OnqKrUWAF9gFRl+atU4fe4vqBwvuC16cBh+F9CpoUXJWO4kh5nJEZB15uN70v3MBquuZILhpEcoEp4Fj9y9tIS/lvtw2fCypWLMCclK//DW0QBv+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:12:09.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12f35e4-7c69-4a14-e500-08dec7d4309e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
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

On 11/06/2026 15:45, Steven Price wrote:
> On 28/05/2026 16:05, Karunika Choo wrote:
>> Move the MMU address-space register layout into the hardware description
>> by storing the MMU_AS base offset and per-AS stride in the Panthor HW
>> map.
>>
>> Use those values to compute the iomem pointer for each AS slot and make
>> the MMU AS register definitions relative to the per-slot register window
>> instead of hard-coding the slot offset in every register macro.
>>
>> This prepares the MMU code for GPUs where the MMU AS register region is
>> not at a fixed offset while keeping the existing register accesses
>> scoped to a single AS window.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>> ---
>>  drivers/gpu/drm/panthor/panthor_hw.c       |  8 +++++
>>  drivers/gpu/drm/panthor/panthor_hw.h       |  8 +++++
>>  drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
>>  drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 ++++++--------
>>  4 files changed, 47 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
>> index 1f7fab4caf4d..e677f1a8f488 100644
>> --- a/drivers/gpu/drm/panthor/panthor_hw.c
>> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
>> @@ -41,6 +41,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
>>  	.map = {
>>  		.gpu_control_base = 0x0,
>>  		.mcu_control_base = 0x700,
>> +		.mmu_as = {
>> +			.base = 0x2400,
>> +			.stride = 0x40,
>> +		},
>>  	},
>>  };
>>  
>> @@ -54,6 +58,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>>  		.gpu_control_base = 0x0,
>>  		.pwr_control_base = 0x800,
>>  		.mcu_control_base = 0x700,
>> +		.mmu_as = {
>> +			.base = 0x2400,
>> +			.stride = 0x40,
>> +		},
>>  	},
>>  };
>>  
>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
>> index 58673a427bc9..0ae11b78c77e 100644
>> --- a/drivers/gpu/drm/panthor/panthor_hw.h
>> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
>> @@ -38,6 +38,14 @@ struct panthor_hw_regmap {
>>  
>>  	/** @mcu_control_base: MCU_CONTROL base address */
>>  	u32 mcu_control_base;
>> +
>> +	struct {
>> +		/** @mmu_as.base: MMU_AS base address */
>> +		u32 base;
>> +
>> +		/** @mmu_as.stride: Stride between subsequent MMU_AS register blocks */
>> +		u32 stride;
>> +	} mmu_as;
>>  };
>>  
>>  /**
>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>> index 48127313332f..9a64f977d28c 100644
>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>> @@ -36,6 +36,7 @@
>>  #include "panthor_gpu.h"
>>  #include "panthor_gpu_regs.h"
>>  #include "panthor_heap.h"
>> +#include "panthor_hw.h"
>>  #include "panthor_mmu.h"
>>  #include "panthor_mmu_regs.h"
>>  #include "panthor_sched.h"
>> @@ -57,7 +58,7 @@ struct panthor_as_slot {
>>   */
>>  struct panthor_mmu {
>>  	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
>> -	void __iomem *iomem;
>> +	void __iomem *iomem[MAX_AS_SLOTS];
> 
> I'm not convinced that having a iomem pointer per AS is worth it. It 
> seems excessive.
> 
> Boris's suggestion of moving it to panthor_as_slot at least avoids the 
> array indexing, but I did wonder about just having a helper function. AI 
> cooked up the below diff (untested, applies on top) which demonstrates
> the idea.
> 
> I think the AI was a bit over the top with the as_present check in the
> helper, although that would clearly indicate a serious bug if it
> triggered.
> 
> What do you think?
> 
> Thanks,
> Steve

TBF, with Boris's suggestion, I included a new as_iomem() helper
anyways, this isn't that far off as an option. Perhaps maybe
rename `iomem` to `as_iomem` to clarify that this isn't the
MMU_CONTROL iomem. 

I don't really mind either way, this option has the ambiguity
of where the iomem belongs to, while Boris' solution adds a
little more baggage to the struct but ownership is clear.

Kind regards,
Karunika

> 
> ----8<-----
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 53c5744609fa..6127df893476 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -58,7 +58,7 @@ struct panthor_as_slot {
>   */
>  struct panthor_mmu {
>  	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
> -	void __iomem *iomem[MAX_AS_SLOTS];
> +	void __iomem *iomem;
>  
>  	/** @irq: The MMU irq. */
>  	struct panthor_irq irq;
> @@ -112,6 +112,20 @@ struct panthor_mmu {
>  	} vm;
>  };
>  
> +static void __iomem *
> +panthor_mmu_as_iomem(struct panthor_device *ptdev, u32 as_nr)
> +{
> +	struct panthor_mmu *mmu = ptdev->mmu;
> +
> +	if (drm_WARN_ON(&ptdev->base, as_nr >= MAX_AS_SLOTS))
> +		return mmu->iomem;
> +
> +	if (drm_WARN_ON(&ptdev->base, !(ptdev->gpu_info.as_present & BIT(as_nr))))
> +		return mmu->iomem;
> +
> +	return mmu->iomem + (ptdev->hw->map.mmu_as.stride * as_nr);
> +}
> +
>  /**
>   * struct panthor_vm_pool - VM pool object
>   */
> @@ -522,14 +536,14 @@ static void free_pt(void *cookie, void *data, size_t size)
>  
>  static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  {
> -	struct panthor_mmu *mmu = ptdev->mmu;
> +	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
>  	int ret;
>  	u32 val;
>  
>  	/* Wait for the MMU status to indicate there is no active command, in
>  	 * case one is pending.
>  	 */
> -	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem[as_nr], AS_STATUS, val,
> +	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem, AS_STATUS, val,
>  						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
>  
>  	if (ret) {
> @@ -542,12 +556,13 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  
>  static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
>  {
> +	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
>  	int status;
>  
>  	/* write AS_COMMAND when MMU is ready to accept another command */
>  	status = wait_ready(ptdev, as_nr);
>  	if (!status) {
> -		gpu_write(ptdev->mmu->iomem[as_nr], AS_COMMAND, cmd);
> +		gpu_write(as_iomem, AS_COMMAND, cmd);
>  		status = wait_ready(ptdev, as_nr);
>  	}
>  
> @@ -595,14 +610,14 @@ PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  				 u64 transtab, u64 transcfg, u64 memattr)
>  {
> -	struct panthor_mmu *mmu = ptdev->mmu;
> +	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
>  
>  	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
>  				      panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
> -	gpu_write64(mmu->iomem[as_nr], AS_TRANSTAB, transtab);
> -	gpu_write64(mmu->iomem[as_nr], AS_MEMATTR, memattr);
> -	gpu_write64(mmu->iomem[as_nr], AS_TRANSCFG, transcfg);
> +	gpu_write64(as_iomem, AS_TRANSTAB, transtab);
> +	gpu_write64(as_iomem, AS_MEMATTR, memattr);
> +	gpu_write64(as_iomem, AS_TRANSCFG, transcfg);
>  
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -610,8 +625,8 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  				  bool recycle_slot)
>  {
> -	struct panthor_mmu *mmu = ptdev->mmu;
>  	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
> +	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
>  	int ret;
>  
>  	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
> @@ -638,9 +653,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  	if (recycle_slot)
>  		return 0;
>  
> -	gpu_write64(mmu->iomem[as_nr], AS_TRANSTAB, 0);
> -	gpu_write64(mmu->iomem[as_nr], AS_MEMATTR, 0);
> -	gpu_write64(mmu->iomem[as_nr], AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
> +	gpu_write64(as_iomem, AS_TRANSTAB, 0);
> +	gpu_write64(as_iomem, AS_MEMATTR, 0);
> +	gpu_write64(as_iomem, AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
>  
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -1740,7 +1755,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> -		gpu_write64(ptdev->mmu->iomem[vm->as.id], AS_LOCKADDR,
> +		gpu_write64(panthor_mmu_as_iomem(ptdev, vm->as.id), AS_LOCKADDR,
>  			    pack_region_range(ptdev, &start, &size));
>  
>  		/* If the lock succeeded, update the locked_region info. */
> @@ -1789,21 +1804,21 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
>  
>  static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
> -	struct panthor_mmu *mmu = ptdev->mmu;
>  	bool has_unhandled_faults = false;
>  
>  	status = panthor_mmu_fault_mask(ptdev, status);
>  	while (status) {
>  		u32 as = ffs(status | (status >> 16)) - 1;
>  		u32 mask = panthor_mmu_as_fault_mask(ptdev, as);
> +		void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as);
>  		u64 addr;
>  		u32 fault_status;
>  		u32 exception_type;
>  		u32 access_type;
>  		u32 source_id;
>  
> -		fault_status = gpu_read(mmu->iomem[as], AS_FAULTSTATUS);
> -		addr = gpu_read64(mmu->iomem[as], AS_FAULTADDRESS);
> +		fault_status = gpu_read(as_iomem, AS_FAULTSTATUS);
> +		addr = gpu_read64(as_iomem, AS_FAULTADDRESS);
>  
>  		/* decode the fault status */
>  		exception_type = fault_status & 0xFF;
> @@ -1834,7 +1849,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  		 * Note that COMPLETED irqs are never cleared, but this is fine
>  		 * because they are always masked.
>  		 */
> -		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
> +		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, mask);
>  
>  		if (ptdev->mmu->as.slots[as].vm)
>  			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
> @@ -3239,11 +3254,8 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
>  int panthor_mmu_init(struct panthor_device *ptdev)
>  {
>  	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
> -	unsigned long as_present_mask = ptdev->gpu_info.as_present;
> -	struct panthor_hw_regmap *regmap = &ptdev->hw->map;
>  	struct panthor_mmu *mmu;
>  	int ret, irq;
> -	u32 as_id;
>  
>  	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
>  	if (!mmu)
> @@ -3260,12 +3272,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
> -		u64 offset = regmap->mmu_as.base + (regmap->mmu_as.stride * as_id);
> -
> -		mmu->iomem[as_id] = ptdev->iomem + offset;
> -	}
> -
> +	mmu->iomem = ptdev->iomem + ptdev->hw->map.mmu_as.base;
>  	ptdev->mmu = mmu;
>  
>  	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
> 

