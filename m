Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C779ECA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 02:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D61210E3E4;
	Fri,  9 Oct 2026 02:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIAAxTrS";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A142F10E3E4;
 Fri,  9 Oct 2026 02:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa0x9m+FYwP8rRb/LVlsN3kM56sodfS2KaoNPUuOiN+mXzCLF4ypofSXG8lEIRUNHugQJN1h0c8397XAbDtnQ/5WAonCGAGzF1PCfzD5+HIwpNq4ORDj2FKEALDw4FKypoGXzIArNmvCesQy8xTUObJIjAmwG8dKtbV8otTyZg1+ImZqUcgX6PBWEVLxhNyEE29Ho/SyPmY81myERs7Zjed1XT0+ySp1RjWVLqjyzwGAg5mthfaFKsD9Cz/AG2a5QG7WOd/I1KvQYyLybkZtszTSyKt07z7ya3Bl+VRsiXAwRAf4J00jX0H7XxFs4b9UPlk6c0nlVoZrbtqJqlWk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnMKO/VxczDJ4kyc33S8NaO64A2Fif65U9J9P5aRO+Q=;
 b=TAmLo7qRb23HPWSdH4cXYpeHHTJKeJu7ZVXZcSdTPiqC9zR28wC20MAnxof3zCVFMqrOFcJdbW4vmsn9Cc6rXqOAaHcHqqX0lTZUrv3rBdJ9zm7Ov46+7ytWwCKPtjiRoL7lieWdDl11sGj0Pqj9jTQQuANvTSDlYGnmwlO3jUX5mlw4lE7h0hqrDdXVUQUkXff6QX0SOzj2UqC4aOL/PBr4be7BTJIFiNeIB2UHHzahQV1+Sgc38xyV0XbQcyXaq+ZoafyESNQ+hVMlODrtKfD4vnuwwjzyTH1JAK+XMHiqUdAqMOXMAZofl3dhW0zXgms6RYOCun6QmiFhUmZi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnMKO/VxczDJ4kyc33S8NaO64A2Fif65U9J9P5aRO+Q=;
 b=DIAAxTrSBQHO95inndSX3/EyGJ2ZzzxWWBmGbB9BwXVnlJpGuklfcdn69uf/QgxW8EwEbdfjGh9+n0SCqhQUFqPRrYvKJT+L8K8C9VYn2eckKFdPiPxHEEsz2UnsXR7kgUqXOGC36yiqTncQiv43Ib2elrm9aKrfmwLQ/MA4//AvDYbT/OT66eaqcBdUI2pCnZpLn8VOCRcfWDNvse0fXPKYPBHYPeftU1wALNt3DuKhqUPD88JnzCDMZiTlZSePbZKKqVYDR/RlzqB1xJlW20b5bFXdhsTk/dt69kiJ4FGmetWu2GzQrKkHwcLSnXUfXyQK6muNkOt+cU6FNBNviA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 02:19:39 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:19:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 11:19:36 +0900
Message-Id: <DLZY4W2CTZGL.3K38U20U8KLLF@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 7/9] gpu: nova-core: gsp: cmdq: move the RPC code
 into a sub-module
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-7-91613f06520b@nvidia.com>
 <DLT8T5HQDV6N.30T90TO3IDNKM@nvidia.com>
In-Reply-To: <DLT8T5HQDV6N.30T90TO3IDNKM@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 295aa73a-d944-4f28-bd49-08df25abc588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|7416014|376014|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: KBtdUZPyftsnKfjsUs9SA0jyqpMZzLrX4bqvrSDwArenGO6HD8I+DRNBJ34bqRHo/1FtxWB5rt95IRSJpQPdeXQWmv1c/ahLyfYD6sr17mLXUVV7u47dZVc445Is+4y1hdYLpJ+aRkw2IJPRDtuEBTtmKj79thNopKOxZOF/304M/NmIcwRgqbHm67TK9kD6S6N2oxwudSBF/SLnoSdD4X/utHIBhUvpR9ShJhbiWIcvdev+I7A3zLAyrHQT7xR4cXJZT9usRx+vtdvo6ChGFCbW6TGaojRoZYqKUqcoJ6b5evzfMCfiV3I5N0G3QkTsvUg5j2FJagw07Rlfg6eS+/rhD2FG3PX3pU0NAS06rwrsjHl+0jEQf3uCIkqAtDHxj7pFhesswDCYRuQ2QzFH9q2EWaPD/OlFtNaZw8a0iYVHIswR3Ql3p7hW4wSS6afw74iVJdwmyJQZQMxKO3rSQ080cC3uVCyE05EmZkme4JeofKiiM5AiyYJ2DXnIoTdcwJwW03ZyyohCX7iK56NJa2wFeNTAn2rd8fdixFJj45MZf3erp7qFdHPoq1wFrOCyoC4JP8bZzd6h6VmlMs7ZTPlEaoZ8s5NbXhe1q2yAKQKc8sm6L7gmZ1Psf0I8AJ0Anv88xqJ2JrqS3YapITkcJTPb77vwYT1srXFx2JteBvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEgyaWhuV0hqbXJiU04rYllNNkRxSndlTkFaSlZlaFMwZVRhdHVOTTZVUTV4?=
 =?utf-8?B?Y0tkMk9Wd1lqMXpmbmpSY3NhWFZIUFZCMURpT3l4dlhieHNGNTJPZ1FHOFl2?=
 =?utf-8?B?UFVyS2FydWRXOGtoUTlLYkpUSkthWjgzMVhJTEsxMUpJZDg0K0xRSnNCY2FO?=
 =?utf-8?B?My95MnJzVG5uUUZFb3N2WnQwa2plMGo1YmNBb0xmUTFRa203MHBlU08zY2hZ?=
 =?utf-8?B?dFlqaWlScnRCYlhGNUh1ai9HTTFnT3k4RlNKZ1VnSzZGVkdaRTAyL1JYQm9o?=
 =?utf-8?B?QndzaXc5MEJSUjA4Z3ZhOVRwVHM1cUJBemUzUDFTMkhhRUNmNTJjVm1WTUth?=
 =?utf-8?B?Y0JSNjVzQURsMUZVd01ZbkhpOHNCL1NoRmc4cEJ5aFVEaitYWjFTSHVFTjlT?=
 =?utf-8?B?aGpRMHlNU3lLcElBUzdGRGNQQmlEeDFXbFU4ZVU0TXVTdnhjUE1kN0Nubmkv?=
 =?utf-8?B?dm9ZeVRpSkVub21ZSklVTjJETEtxKzhOOWVvUHNZZHpHSUlvYUwxNTFScHdN?=
 =?utf-8?B?aVAvSzZBdUVIZG5nNW9URWFjN2dSajg5Y05pdGFJT3MwTnNVZnRMS1NlK3dp?=
 =?utf-8?B?c014Tjd0Mk9qcDE5dTV6My93b0pGTzlXN2dId2V4VDNudlJkZlVQVE5iaGkx?=
 =?utf-8?B?NEJURTZXL1BtQnY1RnM0ZkpkMkhpQzlFUStnSmpOZjh4dG1uT1oxc0FNU0NC?=
 =?utf-8?B?Q1F0QWRFQmxRMHNKNXZsR1BhWUVTY3JJN1htRkZtOTRzVmc5SzZaUkFtSEFQ?=
 =?utf-8?B?V0hmWGh4Tk5oVG9FWkJRMGNQRTl2T2s5YVJ3SUEvZzc1dzVEaVBMK2FrNGVo?=
 =?utf-8?B?SFYrUmJGY21JdmdGVG5BWVRZVlVhQzNHT2QrQjA5dUtPZTUrUDFpREFTZHVX?=
 =?utf-8?B?Vkp5RVBFLzlid1VaM2ZzNFNsbit6QVlOcEhhOTVlRmVYcGpOQlkybTl2R3NL?=
 =?utf-8?B?WHdFaGtuQXhHRVE0dlJuNUNraC9YRkZOTGtGbTlLb0JnVThETUEybm9ZL0U2?=
 =?utf-8?B?L29pRzRma0NQd0JuNlllSGF3dGw2TDdKRXlBaFB0Ri9mRVRVTjU0akFnNDdu?=
 =?utf-8?B?V2cyZFpQZWJ6VU1wbk1rR3hpN1lxQU82TVZ3RXp3V0xnY01sNWpmMkNrMEpD?=
 =?utf-8?B?VGFoZ21VMmVBZmNXVHdHVTJ4ZEdXbUN4ZmtIM2Z6Nm95dnRjdHdrSnJFNVM1?=
 =?utf-8?B?aHhVU25xMFAxaWNsVHFaV1k0ZVQ0NU12NnJncWpKeXZZNXFKM1hVbkNVcTY0?=
 =?utf-8?B?Uzh0SC80Umdud09lN3VvSmg3Qm42NjJXUHkxL0t2djMvM0hBSU9PQ1ZCaFJH?=
 =?utf-8?B?WnhTZ2l2bWtWZ29uZDhEdjBuVUd3djdYUFBLOGI0RzJWeVhIUE5OU3UrRTFG?=
 =?utf-8?B?Zmovc0NaclhsTXV3aDBxdDFEQ2daT1hmZWt4a0M3SWNYRmE0MUUwbjlESEdK?=
 =?utf-8?B?c1pZM0NJUzNhdzdTNm4xbjFXR3NaYnJaTkljeW5zSVkrc0tibXJaeFZOZFln?=
 =?utf-8?B?Qkh1bktPT2hkczgyaFpnTkJnUlRrK1Nlc0lLdVh2cm9qRkRLRVJSRXBjWTIr?=
 =?utf-8?B?cWUyaWlEOHBKY3VNOWI3TzhuVjVrTlJReEZwenJ2bjVDQ01uNHd0UldsMzZt?=
 =?utf-8?B?eHFNM1RTdXlrYVdMRFRjMXlsem1PK1F5VXorYkl2R04wb3hiYUFpTmtITHYr?=
 =?utf-8?B?cUxoM0pSM3p3azA0U1BiNkJKamt6eWMyRDV2OGk1YS9EOXNQM3QyaXh0Y1Q3?=
 =?utf-8?B?amJ0MldObnExR0lleVdDT2F3Tk9CdmxWMUFtcXRkYjBrS1d5Mkk0K081Mzdo?=
 =?utf-8?B?K1pkVlBhUTB0ZW5rQjVNUXJkMHNYckcyd3FxVWJsOVg2dHpsZHdORjZBR2pw?=
 =?utf-8?B?SjBMajN3SW9hb1pPM2RvWVpWWm5iMFg5UloydWdqZTlXMUxzbnNQNktNL2RR?=
 =?utf-8?B?MXdwQ2xFbndTNSs5aERnQWUxYmxrelg5RDR0ZVpsNWcrYURDYmhrWFlKL2pp?=
 =?utf-8?B?dnYvY3l1enREYys3MmF0cTF1WGU2S3o3cktyWXBmd0QzUHk1azlMUWJMZVlp?=
 =?utf-8?B?R0pqd3laL3lPYjIzK0lQRHorMnNRcXdaU3JzeFd6a0RyNmd4VDhLcmh4NDcv?=
 =?utf-8?B?b0JlbXRWNHFmcWk5OGhhT25xWnZTclVhVEtuV3JJRDBRRDJZWkVMNmptaXkz?=
 =?utf-8?B?akpyR1BHQmY1TUx3Y2xLUWdqaXc1OFZ4S3Rsc0NRVEtEdUM1REc4MWxHVGgr?=
 =?utf-8?B?RGMyWXRRSDc3N0RqemVveFBiWVhLbjE1Zi9pSjdSWVVGNGdlUS9KN3lTKy9y?=
 =?utf-8?B?VFpHMlozaVQ2ZGdRR1REL2NXMW81WXlnNlhFeCtFRTlXMEptdU04TGpjUmNn?=
 =?utf-8?Q?QpW5ska6vfskvHR/RdI/1oTdIK4A95KuOzK6nAetOILZ8?=
X-MS-Exchange-AntiSpam-MessageData-1: hgFQ/OZG0+QwRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295aa73a-d944-4f28-bd49-08df25abc588
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:19:39.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yWyN2xdOFYSoSfKlsb4/ZVzvBoMWmFRXzV1PVwbJOgKEiTY3zYLCBpdU92skRb5O88c70dh4ck01v3e1C571w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

On Thu Oct 1, 2026 at 2:12 PM JST, Eliot Courtney wrote:
> On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
>> Move the types and code related to sending and receiving RPC commands
>> and messages into the `rpc` sub-module. The methods are still declared
>> as members of `CmdqInner` and `Cmdq`; only they are now in their own
>> sub-module.
>>
>> This is a pure move commit, with no functional change intended.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs                  | 343 +-------------=
-----
>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 380 ++++++++++++++=
+++++++
>>  .../nova-core/gsp/cmdq/{ =3D> rpc}/continuation.rs   |   0
>>  drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
>>  drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
>>  5 files changed, 388 insertions(+), 345 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 07036972dbec..06386d1ab192 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION &=
 AFFILIATES. All rights reserved.
>> =20
>> -mod continuation;
>> +pub(crate) mod rpc;
>
> Should this be pub(super)?

This cannot be unfortunately, as commands (which are in a sibling module
of `cmdq`) are protocol-dependent and need to view `CommandToGsp` and
`MessageFromGsp`.
