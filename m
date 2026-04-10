Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C767E99057
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BAB10E8EC;
	Fri, 10 Apr 2026 08:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EpW2Y2Ty";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E8010E8EC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLIfn7fDyWRbwTXJRN+tqX19OJt8/G4SrH8WKz4SskhUx9oyYIsPqiSRr94iHP/WcFPtmKHqcGKTTUEI6UQp9BPYmGWyvSjHNZkCkksnkLSkvnqTuqMhyBNx/GnTSr0+/RrHrH1wmiwY/Gpt2H7I42HFC39f9Y3QK1mGjbduCIVzSWoc/dgSv/TGGryPjvEY0hVN300jNjADAb6v4XWwV5EVCMSnsCDlvGxrLPTgdwIm81lIqWE1xPywS65nztbsyi70BOGXJ4i1UDXPfb/nkotV6OLkN/5ORboe+gBtu3A3rW9jEAxptiVTx+YTHiZjnNGDVigw/sJ9fatML0XgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loJHjcs+yav1Q3F2mCYd8L0qrTkskVbJWafqahwLW+A=;
 b=YEfIQtJwQilnNPgroVUWycvpDzHhGtG8IGQ7hEKM7u/2CRLW2V8JH3KLpw9Ih4ttBHuSKaXl/qbGDJKT93TK86DI0aKClyzld5hCNrfUmR4yUSWgyABOTKOXc6xBfcFTp4ruq6A7Fbfc77FEfYgABC80Ns7llhQdi9oNkOueoeMcn4gxIoLCc3690VL6jnx06CKK05yHoYvBLhb8fZ5o9LmcM4PQ0VGswcwlBtFejQh+/OfB5HUOW7wp/2ZGM5TqbqLALDnNXk3KOCA1LRbCWU7qkj5ZnzFePXsJ8C3lEsStXQXKTJaGjRrmBAZ6E9nrm2mLLY0Z7LY804c3gA+3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loJHjcs+yav1Q3F2mCYd8L0qrTkskVbJWafqahwLW+A=;
 b=EpW2Y2Tyhfx3Sz6zQSitb04AI5pl4U85D75XJU45kg0odqGmhCfPb6izHQB1/LtvmILL02qW20Pt016AXLqyAiHsIvHSBkTZh1xNLJVjweA5Ebpcwa1ERTzn4E1Q1181xHi2AEWFwytW8g8pgqmn1qTZMcL6UtH/3xA3qPCJ1J3j7WWw1kd2grPTckOOFeuaFXHs/JqX+N3u0zmdToNtVve0y48/qZrQpXwpCx2tQw4l+Tv++x29kcFxNTBUwEOd+YcVbn4x00apIYxYjrkxt+tQzHCnScITq6XoBqYYtrNI4onrhMUrZlHDCBsR0wnFX12WQNMixNZqy+LVeB95xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 08:39:12 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:39:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/5] gpu: nova-core: vbios: harden various array accesses
Date: Fri, 10 Apr 2026 17:38:49 +0900
Message-Id: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDWpkgZXEQvawVi00qGRiLsrl
 l/ey38BYyBkaLMLAkZi8i6hyDMwy+BmFGSTQUmlZSUbMdEp4kiehdW6xsaowqoS0n8LmMav1fW
 /+RhXNPsbgPt+ABpMClRtAAAA
X-Change-ID: 20260409-fix-vbios-d668e9c21d23
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0175.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 93725cbd-a56f-4186-f7f2-08de96dca3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: kvyTBqf7KlqBvP9OXVYzamDKu9kfLfosZLnJbLKdNF4QyXnxb/HXd02BufwojVuSt57MV3dXWSMPBXVMXAdkKGO4CL6qjWTh+0kC8aJoIluuEufJ2N7WsSy7FgG/nHTBWRm7fGMgcsIXOFXH0U6VxEJAAVpTc4CI5yZXr9E2/NdVFSziNPggNLPlFd3bJ1j7pJjY8ob6f0NqUHNu4M53R22YH1MncDSLCgwxb/QvxupaorDKoI7BjR3tu9/8yIpyUZa9olUhhoWoIznjDgf7crzxw6Px9/4rBZR2VooTxBOejQ1oNMoI472+5OY+InOznERPjzPFTuflsdIz8J2RJ5PPpSV9m7CCo1wFdb1Tua5pohOLBWkGfhNKYcYSUAb1zKpz5GNOJ6kTFRu/GydcqyOe96Z4OAGbngKxbsu+hgbD+/M3e6x64DGT08d4BJGj0rGFse7PjCk+sBiULzIyMR/aemDqAn4hCL0qRr/iGKaC5/i8VLigxZT48ZYWxXjGlvbv6t8vYk3OOr1RMN66vW9fd4n+hNR5A3CtrhopK4RoAObd8z0C7UZpyz/Y8Ze6IfGOuFJ5AcSOVNVKDn847l81QEG02VwPRoldFG3+rNRyQtXmf8TxjUmNwbekTv1HTzvvXFPxWLpu0WAXjCyrkPPxCHuhd/y8nsLkgDbbGLHDKFD1bPKdGQnYfPxGoc5+0YrMIp8DVERtteZ1I06EBglx5Xrz75ZgHExUZ7gi6QM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVWYXU0UDd3c2puTWlUeTgzNThrMllIN05NZUREMEI3dG9haS9ZMWdZcFN6?=
 =?utf-8?B?WkxjNHhDRDBhbjFqVEtnZmY5eGRWME5IUGZjV29oakUvQm5haFVOVzJER3B0?=
 =?utf-8?B?YlovQzRSVFgyMDl0ak5EejNaVVBqcVZTcDNOSm5TK3NYZmlrQXF4UXpJcFVt?=
 =?utf-8?B?eWt1OGFqM0RDZG9pZlpGd25Tby85eml1VWUrckc0czJ2MHZKRnAvaVBPaHYw?=
 =?utf-8?B?Vkp0VW83amR3allIemFYSUFWd2dFcXd0N2ppVW1XUDMyVCthV2xRNVE3QXFa?=
 =?utf-8?B?bjRnUzFTMUpkTzVnR2x5cWpOU2ZHa3ZwdTdNVUJqQzFrb25pNnpNV2w3WDda?=
 =?utf-8?B?djdsUWtSNHd3V3BXZkRNRmdycUxIdkVCWmlNdHM0RFhQUjhZS25GaDlHWmI4?=
 =?utf-8?B?NCs0QjVuS04xbE1ZNGNyc2xoUnkwcGtGT0tMQklwc21UVERkR0VKYjdmZTZn?=
 =?utf-8?B?ckkrb3o1ck5ac0FwMUtCalJvTEF3R0tBc2NNakZDR2JDYVNPZXNvK3NtZnNG?=
 =?utf-8?B?YXRPbjRsUitjeXNSQU5WcEljUnRQK05yVEJHTTdDcnVkT1RvQWZ1enRTOElD?=
 =?utf-8?B?OGFGUFl1MnpxVlhjVGZBZE9xaGF5Z09ua0xpL0J0NDdqS1hxR3FFTnZEREZ6?=
 =?utf-8?B?K1kyaDN3YkZ1SGp3a1hhNy9DVWpPWmw3V3R6MXplTjVJa3VYZnQrLy9MZC9q?=
 =?utf-8?B?ZFE0eUx0MzF6QS9zK0R5ZXBINzVwT2R5cmdTNXovbW9XL0d1bTBVZEg3cUw2?=
 =?utf-8?B?d1ZjZkJmQThjV3ppckJNaXRacTJaT1V2bXdFQ0J6UHM0dVoxU0JGOEViUFY0?=
 =?utf-8?B?V3AzNGMraFFCOXJYK3ZsVWsyaDlQaGZNcUpvQTAxamczeG9yTTFGSS9SOExt?=
 =?utf-8?B?a2ppTFVuYmJaOThTRmo4T3JLbDBERm5Vd1cwaWhJZFJkOWxEaW9LbTBneEU5?=
 =?utf-8?B?S2ZJdzZGaUZtOHEyQlRMZ2JMemtiak5PZlJHRitWVlQ0NjdnWkxRT3Blb3Ez?=
 =?utf-8?B?ZGt3akNwdjNxQS9hYVJLY1M0UFM0S2JpdDY4MUtvTStKYWgvWndrdkVGS0E3?=
 =?utf-8?B?UisvNHpwODl2bEh1Yk1XMzRPRXJpR3MrbzNVY1ZLN3YrblpFNUhqRzNtTnNn?=
 =?utf-8?B?THd6MjhuR2J4SXJGcHgzTHJPbXo0bzBoNmRBR0RkT0MrWHJ3VjhKS1hYM0ll?=
 =?utf-8?B?Nk1qbzZzK2J4UzZ4MnhMNHdEVzhLdEl1QmNXN1JQQ3Fna05JZFliSjNjWnFV?=
 =?utf-8?B?L0V1SitTeDdmYnhteDBiNG55c01wa3RqZU0vd1lzRFlKdjM0U2FyaWRYWEhW?=
 =?utf-8?B?Ui8veWlYTlpTT2YyNXhBUm5YWk1JVU5GVFlQL291SzJHWk5aTGlrWTNSRkZj?=
 =?utf-8?B?eFRRaUI5dFV4b0lNL0FuVTUwQTNmZkVmOGtoelZTL05RMlRldU96cmhscU9v?=
 =?utf-8?B?WlhIblI0dlZyUFFnU0tWZ1FaOExpcm8xdkJiUDlmalpxUDNDK1QzRkxIK3gw?=
 =?utf-8?B?SmFFNEpGZHc4NmpJeWg5UkE1SzFBSzY5QVBrM3ZXZ0tiYzUxNGZmc2V5Nm45?=
 =?utf-8?B?UEtTN0RkNlp5ZExFRGdDQno4QkZjK1dTVnNYM2Z2YWFlUnFRazF2MUhmQk5o?=
 =?utf-8?B?RWxDLzZCYnRWUTRTY0t4c3BKYlBRRmgveTFpVURZTUdFM3pFSW9uOE0vREpY?=
 =?utf-8?B?WU5CZmRQQTA1Q0RMaERocnR6U1VycGpTZ1AzYUF5dnJMWWs0anUrQk1sTkNX?=
 =?utf-8?B?NHhqODV1MFg0RURTRmZRSWovamZJUG9oZFVnQVkzMzFGc0RCUmp0d2JuS1BS?=
 =?utf-8?B?WlM4RXdidmh6dDV6bzNHbGFkWWtZRlprb1p4UnVrU1BZcGdQdjErYTdTQ2JD?=
 =?utf-8?B?Mk5lUXNSenh6ME45UC9MbHNuWWhGbU43Vmp5OVZpMWJGekxPNVVxMHF3Zzd0?=
 =?utf-8?B?Mm5lbmRlOGFrZVpFYUVMb3hIWU85TytnRzBuaEZuZWtKZ1AwZGEzRVErYkRn?=
 =?utf-8?B?c2V2a0lrNkQ3eVl5c2RaRWFWRkFWaGFkZm5Jam4wb0g4aHd4VmxlMlVjVGMx?=
 =?utf-8?B?VmVrdURGQnhEZW1rL3ZoNmcreXdMYmhrT1NRdjA2WmxOb1RLQjFKTWxvdGlV?=
 =?utf-8?B?YmVERWgxNDU0cmJ6T3gzVW9Fa1prMy8rSS9pa3VMRFEzMGY1VXp5UjF4bGxv?=
 =?utf-8?B?Y29xUGNRTVdHSjFVb1dCdU5CKy9nU0dVRkUyTUl4OGhFRUJvSFJlSmNCczZl?=
 =?utf-8?B?VGt0TUxCMFRXbjluYmZscnVOUlkxWThMZFBSWHZQOHRMbXl6N2RMblI5Q0Fo?=
 =?utf-8?B?Q0hnMmYrajU5Sk4yZHRpNTR4bm9zSS9lSlp6eHUrdkJ2RjdITVZnZjZmZktq?=
 =?utf-8?Q?caHXmaZksOrOGeKfT86SpLXloUYU4tVcsZfRBYHWm/kLK?=
X-MS-Exchange-AntiSpam-MessageData-1: Z3zQUln3O186fw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93725cbd-a56f-4186-f7f2-08de96dca3ac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:39:11.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqIHBJpWHQ9enYPv6KOgQ3vT6A/n26V4IbhvGJ5VF7oT8cPj2BiaT2gxmr/E7z1omjhXu36yJNPh607F3Du/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

We have some code that accesses arrays based on values from firmware.
This patch series makes a bunch of those accesses more robust. This
series only touches accesses that are not guaranteed to be safe by local
invariants - some accesses are safe due to earlier checks and I haven't
modified those.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (5):
      gpu: nova-core: vbios: fix various cases of reading past `BIOS_MAX_SCAN_LEN`
      gpu: nova-core: vbios: limit `BitToken` entry reads
      gpu: nova-core: vbios: use checked accesses in `setup_falcon_data`
      gpu: nova-core: vbios: use checked access in `FwSecBiosImage::header`
      gpu: nova-core: vbios: use checked ops and accesses in `FwSecBiosImage::ucode`

 drivers/gpu/nova-core/vbios.rs | 99 +++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 49 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260409-fix-vbios-d668e9c21d23

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

