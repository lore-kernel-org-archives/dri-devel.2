Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295CDC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CA310E750;
	Mon, 28 Sep 2026 04:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBVKJqeb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411DB10E750;
 Mon, 28 Sep 2026 04:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXzbSZdb4KmIgBCuuL/k4W9Koxsfs5sN1b1cN8u1gACTcRzpH8iE2TKOIiTMynoSTpAo20EhDOrxYycPLH56tI0P3pCQpDK61nXrA9z8+Opczdf7RPDenVYokv3vNyBeAvnV20/erD3ZmM7IaASecqFBgfsypncEQAXZuEKV8hhrRLaxzS8+u91LyQL53O9mWXFfXCAsV8+QYpCNsJwBPRvfDK3D/oOwSt/sA7fatfCEd1rN3XjV94M8eQ5K57dGjrYHt8g8PA7u5ONqCre3XcuSzMYXz8DnD8AZ8974C3QGNCdAKUYCSatOPfhSf+UciRPGif01EKepYNmLElh/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSHrOH2ZM8vTnqZqeRiTYWRfgTeojEOONILLQYKviM4=;
 b=RtC/6x40re6LdJOGTykEqCEoocUr0KtYiRuA2slybx3/XXW1ysNCSS372kleP+hCYg6PdFIe0uvl33SeJSrRRUlbtIiawdoRjUurOj4Tfbojfnljq8FV3XzbqfM4NJjCJQAzK+utf1uWZ2FmWXK39Uijz+gB7tE3qZ8ECYAI95X6UUyxll6ihsVDsS6orX+l/gBSYT9aBQRd88OnPPCeFpNV8E9R9eX0csiEAc3dL0vPCF4PVr4STJmxvxkNE/Sv9eb/HOGFdsGVB6vFV0JAsuHVj8I23ubcFRhlgWOXYTpHMnIvw9ALtzbqkIux0A8/ZnT6dPNOPQ+7IS+Dqsx4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSHrOH2ZM8vTnqZqeRiTYWRfgTeojEOONILLQYKviM4=;
 b=TBVKJqebrEEGXoR67SCuI0Ve2aPzFzmuaNKQXlDqNs0XLwTdT9P1dTyprQ8u2tUVDAVqb+2ppR8sw+4hK4He2i5lFpQLexCJziroi4Sui9oP1wp7UMwQerR2DFRPLuRq4uKY0I0GI0QyLuQ59dodjJ4KUUb4kmPuE8awhZnhnm3qV5gesj1ZQr5ry1br9fI4mKsxxSOQ2JyTzDWTfxbI40gPnWlANIZ4qOd0CnwdQLlq1+Mzh2eUHTQsbIRHIob5O0+oBYoT1ZMqA1APFGJZW4xsGiNnjcpzvDJFyBpmAam+ZP5wB9Fclb1eKe0pn6T4HPybE8PVZLDV8jVpk6LJHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:17:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:17:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 13:17:13 +0900
Message-Id: <DLQNQYDDVGRN.2QNXJTRVBNJ8@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <gary@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927144417.1280385-1-dakr@kernel.org>
In-Reply-To: <20260927144417.1280385-1-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:372::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc87565-0f1a-4e33-8416-08df1d1761d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10070799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3VtTZHzkOkvu+07+tmvz3YqnYFzTAHYy8CC3ZaYFWjVbTAEZ9l1ZVm2B7vBBxzwecXwlUzgyKZFgUNEJinweZffh87xZ93tVFICk9P/7axBIPJ9aj8xy5PEDr1fQOfH5gdtsKwZOMaXrbdRA+u4XnNDTqtGDlhix14zdPoH391QehlXDAgcAIveJJ0P77ccSllPCOHcDLkbZVARIQi5V2PZ+WxvV9eyzHUF19+sqTUWakZGCCo7L7o5/on3JPT1kUzdSp/NnS1qx3bxdxQii+Iky/UQHdRFFzp4ydqyqL1jDEsKCBcR4tAnRySlqzrX5iK1QrNgtZw06KOQzh/s5o0b9a39naSFQbuoVZAZpcUX/3n4nQy9A8g+xg5uxTJOk8fqkY9EFOk3emmDqmLOuEXenIKt7vv35psQ8tYRCVgtl0CoBHjidWQs9P/12S1HvMGdWiM/hbZsSpjE8uZZDBI9Ts2SCqfvPmjAEubS+4h59tpGiEp6FuQhsJm+s9A2vtdb/PXxRLJreo5kH/EgAJhbBUpNd3QlmnFqVsbtuQVUyGyoxhwDsu/Ysslj1bjrZy96cXUjjMjq/5NAmd6fFN6IXaRdzyoyOd7Cfmj9DNIfw3w+ABR2tm0un0pobJdRcm5eIVGOirhroBQkz9lzQmvAAo7oX7yjBfKhn64OT5EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFJZ2c3YWdvUmxZd2ZUc21yb1hQSVIwLzZsQnBWRVJzcTZTdStPdGViMVNZ?=
 =?utf-8?B?MER1WmEwN0p4UEVUUFY3cFc4VlczNm54Nnptc2NiVGFCS0VhYlFXUHAzOGcr?=
 =?utf-8?B?ZTVLODhnMDJ6dkplQUVzSGYyeE9aeEFYdXkzajZBZkVsR2t6Vjg2Vkx4aGxP?=
 =?utf-8?B?eHh6QWUwWEI4Q21kOFVWTlgyREFDazltSExKOEJZM0FMaENhVGNpd1lad2t3?=
 =?utf-8?B?aGFmWGticmhZWW80MjZoUmh2dTl1emRBclFQVmdjRHd2V0d3dkZNQ0tadjIz?=
 =?utf-8?B?djJTdE5aNGlXOEdyMUZyNHVXOWloUTZXSEFsRkp0aXlrWFBIbHB2YWE1Mjd4?=
 =?utf-8?B?bnNGcGxmaXFWZ2cxRFM5ZU9LdjFZcU5VdWxiUVI4ODFhMGNxWjNmYVA2ZTFF?=
 =?utf-8?B?YmRwQTY2NTE2dHFVMmowQm81eHFreHRaczUwOVdVenVuR2h5VTIwb1ZXcFZp?=
 =?utf-8?B?V3BxNlhqRnYwMWptR2UxR3M1WitNbVdybGVadFlQQTJNMC8wSWd2Qlhpd3NB?=
 =?utf-8?B?c1dzc0ErSVhMOUpjSHQyeWMyZStLOHRzQXVocEZ3TUFsV1R0bFRQL1FQdUJC?=
 =?utf-8?B?bzdtMWFLLzVtZ1hockppTForNVliSDd4MGdjbXFyeEZuT2V3OGo1RmpMUVZL?=
 =?utf-8?B?NVM5MzRZdDJ0UEp3T2U2b3FtZnNBYmtVMjVFUXlXeHJjRG9GbjFXWnFCbFE5?=
 =?utf-8?B?Q3hOOVUyVFJRZTlrUkVaRHEzdmFjOUZGTmJXZ0ErV0FuWFJTeUJrWUtwVzJo?=
 =?utf-8?B?bHBTWUdYMlQ0R0hXU2hSRGtwdEFYbWJPS3NDT0NyUC9ZS3ZTbTkyaXl0YjRw?=
 =?utf-8?B?V3lEaVdab3lDRTJvTkNuNUJxK2p4TllpdE5OUkJJSEkzV3FrNGdEN2Y4emcz?=
 =?utf-8?B?bHhSUjByL09JNEVXRnJaOFp0MVFRSytIQ1dnMU95L3RWcVNId3piQ3VHdHZG?=
 =?utf-8?B?S253b3JGK0UxSUtNVzdWQTJhaDdUZzM4R3JiSEhianhBeXJ5akFLUnp0VWUr?=
 =?utf-8?B?VHdHRWFod21XdlhHL0cvM29BSitBckNNNHZ3cERocGM1M1Q4TEp0QklmUkFu?=
 =?utf-8?B?ZDdJZEVmbkxvVW5xeEZ0aTNSWk5pRG1WaXhpd0pJL3dPZU9Hc2l3ZnQ2b3h1?=
 =?utf-8?B?TkFSMGFQbERFTmVueEwveGtKc2VQb0kvUFRCa0dtV1I3Z3BZQmt6L1JQWUpK?=
 =?utf-8?B?QWJQU3JmWUJiUktOMUU5R0k2Z2dnY0dHSUsrelRuZzR5MVN4b2kxYjBLVUds?=
 =?utf-8?B?b1hNT0pmUE85NmN0SzRLOTJwOTJtMTU3ZWkwT3BTWHcyUXoxYmZiOUM2a3JK?=
 =?utf-8?B?aGt0aFlMMWlHNXAwc3N0VG5rUHZXWXBZQlV3NVcvNnhMNnJibHI4YU5WRzRZ?=
 =?utf-8?B?aVl0RitQVHhwVCtOenVzM1pQNUhNSnVtbjIySGswT29iQ1o3UG5rbEMrcENV?=
 =?utf-8?B?UHh4L3VxczA3V3c5V1V1ZGxlU3pJd2k4YXhBUkJYWlFBdktIY2NvcHlOc2Z5?=
 =?utf-8?B?Q2Zkd1FDTi9sQmYrd0lyUHZHNy90c1FTNzF3MnNvallUSWI2UitLNFNuSmVK?=
 =?utf-8?B?anhNQTNnZjJjY3Jpc3gzbDVDOHdXbldhakJaYk43TkVHTksxSjFCdHhodEh2?=
 =?utf-8?B?QTAyY2RORjJxYS9wYzZTbStKRGljTkN5eXhzbGRoK0Q3MVJ3dUY1TmttK3NU?=
 =?utf-8?B?dWN5S0F4M0V1ZWM5YnZYWDR0akVzVHNwWlZBa3NHQjNtTE40SFRlbWh5UGFt?=
 =?utf-8?B?NlJJLzlDV0lhWHF3dnBRWlFuL2laWmJJZGlzbWVGRGZ2NlVtdWVmeUdVUnpF?=
 =?utf-8?B?dEp6SG9sOGZEbUE3QlN1VmJCMC9nMUhLajQ2cGVrUmFsNDB5OFkwaFdkdWd1?=
 =?utf-8?B?UVFFQ3FtMERPWHNmMTZ1RG16YkJXOTQxS1huNGc2MFA3b051ZkliUWhmMUtB?=
 =?utf-8?B?ak90bFA2c2VGRnZjRzUya2J4Y1cwNnF1OCsxUXJyWit4N1VQZU1Xc2hDckZC?=
 =?utf-8?B?MTJ5d0NjdUZ5SndLMTZuZTRRM0J5TjVmV0lpZnl1ZWd4aEVZckxyWlExdlZS?=
 =?utf-8?B?ZmEzdThTNXlFMmZwZ0VRWkF0ejJDaFJNSFhoRjc2ZGhOVkFrbnpRdWpWU1Uv?=
 =?utf-8?B?Q0xRTTl3UmZTSHlsYm5tMFlDY0E3d2pCV0JqMFV5WW1XemQzaDc1T3VwSTVl?=
 =?utf-8?B?WHhZZjU5cUtyU3EzRS8reG5OTmU1RVJUa1o2MWo5eU4vVHFFbXJJNTU2RDE0?=
 =?utf-8?B?bkg1VGtTT214eUxOVFpGZkNHMUswS1g3eWdmVkFOa3A0Q0ZVeHpiMnN0RTlz?=
 =?utf-8?B?dTFtTFZyZ2t6VWZTVzRDSDJRMXFVbzVhb3JWbEpHRWhWK0N2cWhjL3V5c2FL?=
 =?utf-8?Q?KVB2KZfdhoxpJiCzZhnDVzATviSCzrb6Ap4FrVjqEOHLQ?=
X-MS-Exchange-AntiSpam-MessageData-1: gXjKPA0rAKqVWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc87565-0f1a-4e33-8416-08df1d1761d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:17:17.3917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHcemkXcxNAjA1AFLm61hQ0JmNJkLbwW66puLn56D0c4LTUDHNY73A+J6qv3LSU05UygCYGXSZoGJAOcIT7k3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

On Sun Sep 27, 2026 at 11:44 PM JST, Danilo Krummrich wrote:
> Just like in Gpu::new() a single try_pin_init!() block makes the code
> more readable.
>
> Besides that, it prepares the code for a proper PCI device enable guard
> that we will get soon.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
