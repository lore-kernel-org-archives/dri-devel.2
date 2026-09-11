Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918D7C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB0910E3D8;
	Fri, 11 Sep 2026 15:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="G9pAcBob";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B040910E3D8
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0WCDtNE7cCAyuBMzy7zDA1BVfDy1kgujmELJIiBdLlGtzXYibLH1xQmo0UV3+Q6Vc/gftCAkn0kiM/6vTAby3GBswDk7vbEV0NdYLSfbdez0MfblIH90Lv6hpn57g6axKuXHdT6TAb63GErpClqs/phsATWdMicxwRaBdpq/2iEze3wqZlfpShV6Lp0btHwxCsptbHKanoDkvtcMuVDhIq6+4RxRRcDLjXZpEM/BbgOSnWUxM1hmm0z3xTbk8IBkMuKofa7eFD6RpVnZnEMBd0y9Q/HBgyY+GYbWZM0gKkxVzJNwNgRvaEFo9/p/9EokkJorTP8et+f8bty5TbfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVbV30+e28v447iFKZX4NFRBVk44MF8Nfclu6vYQGVs=;
 b=Cdr3JdIJdvGbgbWX0y6DDIqjKS+W/JF8Me1+fyS4YjaJnB9OUT7DFY/wzVWEcAs1iINChUex5grxCQ7fOe79gwkUL07WrI9qW6HwiA04kt0BfRIttjHf8qurAl1EHSdpufFB2YbtUxlK+wmviUKosq394qBgTK1hEbwLbuOSwmTXDoq2lB23eNiBjaN7UnQVWi/TG/wu+Qx7GK4r8gROiCHROowjARrHe37qtN7Og8ucd2GBds3qiEsAkJ7rhgFNEcwhvR5JsJF2JOltRM1RHwDYlnP/s/IE5+3hIkU5Ai+ExmKKmBWj0fZwzIJyEVbXNoMv8/lBhFGTr1Z35LsCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVbV30+e28v447iFKZX4NFRBVk44MF8Nfclu6vYQGVs=;
 b=G9pAcBobNofJhQfAIdw4GSWRBXvNaY5AnMkjPH4Mm88NI6xMbMGlwBg4YzxZykJAtbDSs10TSVsU6Gi6F7ATkr1sbn4W35w1y+7atCd/Y5d7Bnrf2dTA0O3R5txoZoyJ2dqUpkOer1dCmLLs3f+Blex7WAV/GN6/Z2AfOMnzGvnu2yVxSvx/h+Psow08s/sRGdDt4UAgNytB0reumbjajXO94kO13FTG4hIIjzHweIKeZMiBqIRWbhoEu0ycDN/iJeJyR1jkCnNafANsfyE63N3BmdGsqxaRxffJyHhAGgdGVWvdHUf9UTn5+AcGq5tjGR4NwDHXAny1QdSfwBLKbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA6PR12MB999200.namprd12.prod.outlook.com (2603:10b6:806:450::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 15:15:31 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:15:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
Subject: Re: [PATCH 00/16] gpu: nova-core: GPU page table, vmm,
 and bar1 mapping
Message-Id: <178913895393.546199.5198646441881705312.b4-ty@b4>
Date: Sat, 12 Sep 2026 00:02:33 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA6PR12MB999200:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9fe14a-323d-4bf1-49f0-08df101784c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JQrfhKVcO4tRi9PsLVq9e+J7WaEVLEyV/iULkaaS7kZNVRHTVmy/pSl83M3QvbQizeb7Rh1EQORFNHduOeE5+OhhPN9/Y7YBbgNXNyh7x2jsg1N8vXyNflm8c7PNyRr9uv87ZghoRQTJjZA9+sd8rceCCUCqmelWbiko0/inJwhzQUUfxiAcelBI9t+QlYeDPrMb4SUm3rSp/I+lGfyIuW8PTanMGLJQV4Ot0GaG7/UVFSe4c3/7QosjECtQBOq7dOgZOnqNZK2hhvY41ddlBZEaGfcfP0VsHZ0Yy9RJDTulqnpXKAuL7BOmYFF9e/ZSxsbvd0whJUZSYRJpLtYLxKaxSH+OKvBYVFvBa+sij6L5Y4ED+DqwHKro5QpmnoBIynJY3RUhKCeiy/FFZs7jwPTmVazREJPk6Cg5O5zpaX9rKiB6IkiKy2dPDMldgQPxuRQBt5DW8cgqCOm4R7FT6VpY7S3ZDbk6LfqTNCNU9Y8SM+mKiVtCrMJHOqhp6s5O1xrjjy6qQMjcW9bpKJdRqmmRtti8lAtIrmf2UoJg2dF0We09j1VWbvzbLKvRMuS6DiI1/US6ctfpixrEM6LUJ5Wcs8VWA4fsJ1K1/NJbSt1SZZj4Nac8qXk6n2LpOV6pZG4lvX4cQyZq+J55/3R1ncSfLzPwzkhTsMR/DzHLhcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3U1eFZrTVVkaWpsMnJBL3RPWVlkRmJ3SkQ4VFVwR2VqL3E3d1VIeTlnK2JI?=
 =?utf-8?B?aGRjeFNHakxRd24zb2IwODdEMEM5R3ROREdSZHcrZkpXSDZ5Z1hreEY5aVNW?=
 =?utf-8?B?TnVrZzJRNWNleXE0Ukk5ZkhpSUd0LzQ4Yktid0hDNDE4MmtsdGVqOWZ2OXBO?=
 =?utf-8?B?bGJUOVg1UUhlYkpNWlpIRGZXN3BVZ25YWmxoNTFkb2x2bFRwVzFzWlg4RWth?=
 =?utf-8?B?b294R0hJMDk5WE04T0lyd2xsS2ZFNUQ4bWpzaWNWcTc1Nld2d1BxUWo0UXZ0?=
 =?utf-8?B?V3k0SEhrOVY5a3FWMlBDbkkxamdyVzdvSE1CdDN3Y0xlSjg5QjdzOXVZNHQv?=
 =?utf-8?B?U0puMWlKOW92bTJabC8vUXFxUkdEUFVwOW1VODJlVmtlU0QraHVGdVBkR0c2?=
 =?utf-8?B?OXo0NVNKZlQ0YXpjenB4K2prby91UDZkcEp4a2lSM3JVMCtwcXoyeWRqYXdj?=
 =?utf-8?B?Y2NwemIvOHk5ejNBMmFsNmExdk9lSmR4bXhHUzBvQnozV2w2QVZoakFrSlk4?=
 =?utf-8?B?dE95MTBMdFJHUXRiN0R3NW9Xa2lpdEs4VSt3ZDE0RmpBZzA1WnFiNVRUUEVP?=
 =?utf-8?B?ZU5iaFVRanRyRVFoTWNOZ00zZmRQOFFLQzZ6MXhVTXkzM1lOYmdBVEhhUUFk?=
 =?utf-8?B?RWo3b0tsNzZHRWd3VFN1SXhTVlA3T1FwbWZkQ2xYMHBkc2NHRkE3b3VwRDhG?=
 =?utf-8?B?anlrekh2eDMxZDF2THkyRW55Z0dqZkhHVHVNVGI2amFPcXR0M096dCsvbzl4?=
 =?utf-8?B?ai9GYXQ1VnlnbjJUL2VsUGQrQmhOWmZXVDFJUWJwNW9PL25jMWNOUjJyYlZ4?=
 =?utf-8?B?QTlIVGo0Z1orcndNRWl4eTh6UHkyNEFxbkE4M2tONXVsbkRWM1RjTFlUQldF?=
 =?utf-8?B?bFBtVmRnS3Vlck12aGlkdlJQUC9NTjhJQVZ5c2RBWWl2MGtyd21EV095N1do?=
 =?utf-8?B?ZW85SnRzSUExMGlQWVh0VXJIM3pCQVQyeTZVSTF6SEVxQzdIMTlkRHFCZERx?=
 =?utf-8?B?amF6V0Z6NG51RWRyR3V6WHNMKy84RU5GcS9SUEJoR0dJZEVCRGJJWWdJb3ZL?=
 =?utf-8?B?NXp0T01raE5LMEFPUmtGa1Znam5NQ2k1bnFhNmJZb1BSSkw4LzB2czIxRUdK?=
 =?utf-8?B?UHRyUUhHNFgrVndyQmVXZE9ROUpZYkJ4VHhjM1ZuWjBDSEY2Q2Z2RGlMSy9q?=
 =?utf-8?B?THRSb1hLT0FJR1J4OHppUmNmamxBcHg2aC80MjVoN1RTZGtNaWZMRzNkVkJJ?=
 =?utf-8?B?aThqOStnMmliOUpPcjBMWE1sSTJTTGFvS3R3cjRDQVJNOWFUYTV2MXZUcndO?=
 =?utf-8?B?YUZ6T09ERXhxTHVzZEpBRjROdXJqcWptcHhTWmJrOUFLcnFJYUhMYW9zVkoz?=
 =?utf-8?B?ZzdzSEwvRmdaOTQ0czNkdmludUFzeXZ2a0dOQjVOWXRKYStYOVgwb3NRTm9h?=
 =?utf-8?B?Vk9XYnN4Uk9KYjE2N3dYNUZ2ZXpDc090MC9LRWtoQlByNC9LcHRwODIwRDVh?=
 =?utf-8?B?VzFSeDFYQlQwVDF1Z0o5YnUzRDQ2aTFXY2pQZVBlaWNOUTl3NGR5ODRJUlBX?=
 =?utf-8?B?MmlrQ0F6WCszQS9sOE5vL2RFK3JiUk5LNHN0M2VFaW1mN1ViZXVYY3RaTVRT?=
 =?utf-8?B?NG91dUZGNklCcDRNRTQ1T3lmR2FMWGJxUkV6WGVOWURDeWZFL1FuOXQweHl6?=
 =?utf-8?B?Q3lVcTE1UjFxaWtRSUZndGtiNFRQK25TcVlqMjZlMHUyRUVQUDVHUlhKS1FS?=
 =?utf-8?B?aUlyYjNaMDV3S3FxeDVnelNFd1A0WlhpU3hFV25nc240UnB6MC9sMTVkZ3Zx?=
 =?utf-8?B?MkJmN0JyQ0hHVnpKL1JtNGJxM3hNTTdZVUNycDNTcTk5Vm11WG92SWo4RjUr?=
 =?utf-8?B?bmp3NjdKak00RThOSFVsUCt2VkdyOThTeGQ2UEhvR1Zlc290eEMyK0R1a1RN?=
 =?utf-8?B?RzE5eU9BRDFhaFB6OU5EQlNwSllrbnpCUllQVmRhM2hiWmhKSDdzMW9nRUlH?=
 =?utf-8?B?bVh0eGY4SVBPdklFYVpjZVlmMFFzV3NXNDVJWENLYWwyTGFNSVFHSytVdzBt?=
 =?utf-8?B?VVE0OGRsV280RjUyZVRMYklSSUlNNHdoWGE0WmNRNkVLOHBTcnVVVnpVUG9T?=
 =?utf-8?B?bkJpbTI3dWxIUmJvWURoRTBmcWNPeHJRaU43UDZnamh4M2xXVEFmdTdJR3lW?=
 =?utf-8?B?S3BHdlBmK1VIa2dGMDVPMWVVTzFwd09FemV0WFdpR0dveFd3MmRVZW1WUXFk?=
 =?utf-8?B?MHgvYnQzSHJkblNHaDkzSWtYbW9RRTdEMVdMcFNESGZTZS9rUXJyNmtSRTRt?=
 =?utf-8?B?WGIyNmlNdlJVeExrWTBPUGVTWm9IcHlWU254dEtFVFJiV2lTcXNUZjR6R1J3?=
 =?utf-8?Q?yqJZFrR1zbppbQr6fheI4ds2Rn5VwNX1m+zVsrfu16Wd+?=
X-MS-Exchange-AntiSpam-MessageData-1: FUJ+NDYwnEowBA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9fe14a-323d-4bf1-49f0-08df101784c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:15:31.0191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nqww97Aqmlu2RAr6d42T/HbIBYqU/sbfxo9um23TOYwBTElJp6mvlIQOijZsW1QX3I7JN3+9DAyvhcw+3nh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999200
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

On Wed, 09 Sep 2026 12:59:38 +0900, Eliot Courtney wrote:
> I am reposting Joel Fernandes's original series [1]. The rebase adapts
> the patches to recent changes in the rust infra, like HRT lifetimes. It
> also adapts to the changes I posted in [2]. It keeps Joel's design and
> patch split.
> 
> From Joel's original cover letter:
> 
> [...]

Applied to drm-rust-next, thanks!

... a bit hesitantly like Danilo, but we are in a state where the issues are
easier to address through follow-ups than by reworking this base. This is also
not used yet outside of self-tests, so we have some runway to fix it before it
goes live.

Thanks Eliot for driving this series all the way to merge.

[01/16] gpu: nova-core: mm: Add common types for virtual memory management
[acourbot: drop repeated "memory" in commit message.]
        commit: b8ca2d0b7fcf5b8ff0ec174b092f732a9d3d27a3
[02/16] gpu: nova-core: mm: Add buddy allocator and TLB to GpuMm
        commit: 33be8f687bd8204965c137a5600822a1959033b8
[03/16] gpu: nova-core: mm: Add common types for all page table formats
        commit: a5dfe5955c6beff8403ce966efde6822700a6634
[04/16] gpu: nova-core: mm: pagetable: Add PteOps trait
[acourbot: use vertical import style.]
        commit: 239bb057a81dca1623857102cfd963e1305aadc1
[05/16] gpu: nova-core: mm: pagetable: Add PdeOps trait
        commit: 85a7542510cdff8bbeef9fb016e98a2f8bcd1171
[06/16] gpu: nova-core: mm: pagetable: Add DualPdeOps trait
        commit: 71e99998a6559d71e5d6eff85afcc0f7f99ece25
[07/16] gpu: nova-core: mm: Add MMU v2 page table types
[acourbot: use vertical import style.]
        commit: 98b7273f5de149b2c6ff0d98bc2b3fa55b749b74
[08/16] gpu: nova-core: mm: Add MMU v3 page table types
[acourbot: use vertical import style.]
        commit: 103fb3a4b2b85ebf30f11a433df17df708f85689
[09/16] gpu: nova-core: mm: pagetable: Add MmuConfig trait
        commit: a9eabe320b60e5af72ff10551be1b2d67ca614af
[10/16] gpu: nova-core: mm: Add page table walker for MMU v2/v3
        commit: 1123774f3610c45a7acf055b8c9841883ed4bf75
[11/16] gpu: nova-core: mm: Add Virtual Memory Manager
[acourbot: use vertical import style.]
        commit: 3c7561e194d573a3926702d1e051a8c8fbc187ea
[12/16] gpu: nova-core: mm: Add virtual address range tracking to VMM
[acourbot: use vertical import style.]
        commit: 16f573374fd6ff8ff4ab54abceb5d093869de9d2
[13/16] gpu: nova-core: mm: Add multi-page mapping API to VMM
[acourbot: use vertical import style.]
        commit: 4e4182282d4e8d81bfe62ed8ff634526fdd5e238
[14/16] gpu: nova-core: Add BAR1 aperture type and size constant
        commit: 75ad43886a20e17aa5fad9ae71ebb413cadd8d64
[15/16] gpu: nova-core: mm: Add BAR1 user interface
        commit: 159427b213524a90853ef24d0a0c2ed1aec1dbf9
[16/16] gpu: nova-core: mm: Add BAR1 memory management self-tests
[acourbot: use vertical import style.]
        commit: d669686f8170c234edf12212fac9180ea18b1448
