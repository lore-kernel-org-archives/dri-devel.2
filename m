Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0D606A325
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X4lNH/p3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B6610FE47;
	Wed, 21 Oct 2026 13:46:12 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFA810FE25;
 Wed, 21 Oct 2026 13:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDtTJy6HCiWv//abXMryjYXkqi/4zQkXmXf+1Lu6Yf1Cdmaky0iOtrP5qoPP1n34x8Q3Nwf3QBu5o/My9k3Og8MLRcl2ALTJW12HXLXGCv1jkxfE8o3h4AOm4LKbEG0jNJVsMPL1SETJN9tTxIZIBbqFM5zMwjjcVvSzH1HHXNq26BZNeI7PJYzYe8c/Y91yKdwpH9iOiG9Xy+xo1S7q2uv+IIMIFJllhhuVWb6U+gHI0X5MhaOjZpLcTF1uhS5pnQdWQzC36fZVMA8REIps6uPkFJOygyeM1ADV3F/td97wNM9/NXMk6Y2VLpnZf9RfhtKa/+dSIBs+BAb9/Z/9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U64NH/EqDaio/C/tlAAqANeCqnX9CYjy4QNsL9tI5I=;
 b=r4gDjDQA11K1anMBaj10BKM96yt7qBmU3+qFsBLQ53ksTpfZRPwakBafQ0gl2N+liaot6MY/k/crhD2aTdI3TGFtQ8yB3c65S9jdNcdUVi5s9qGpykzr+5aNfdSm/pdHe4F4vbPNRt05Zwo7Pl+LlUYNNKEzhcGY+NxHNRwSjFSYdm0+jMBT5WsB/uG+eMQtW1UCEDPoBPUI55nup+d3JQVQNBVxGluPpH86uqgr9ggkgJRXw9ob7Xvjbdyg+iOrqxUCKkpvuuPtcCTXepIeizs6+YXCgSYbcSMOX9S015CXDbmLz0mjkHWqy3jtqUarFbNMYQa/c7Za/QCYNVH5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U64NH/EqDaio/C/tlAAqANeCqnX9CYjy4QNsL9tI5I=;
 b=X4lNH/p3RTN8AR4+4gUWIzJgS3pPmguB6MngrjBrL1rm66H8ZLzXcr8JaD2BoaFFDYTWDZk+gqMlnNgGhSRzZZwFQNb7qESBRJ+2JJ2GftyplVbeq3tGsLs6hvyuCXXVSuRNJYmJoJY1Y//y47YR8Jw4FZ+g9yoi7XyUhmzN3lM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Wed, 21 Oct
 2026 13:45:10 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 13:45:09 +0000
Message-ID: <0c0fc620-ed55-4baa-aec8-09aea55e294d@amd.com>
Date: Wed, 21 Oct 2026 19:15:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261021121813.1820345-1-arunpravin.paneerselvam@amd.com>
 <78a6d58b-4fa2-4325-a4c3-3cd732c15288@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <78a6d58b-4fa2-4325-a4c3-3cd732c15288@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5707f749-9a54-47fe-92c0-08df2f798610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ccp4TP/y52JjF8jAWelMgrQR9PaT+K9BMj77gaFR1Wn4UIlqKpn+0e7EbWOcdWuXCUoGgYuxu4PN91Hp3aSiyKhpPSy/SOcdo0VYNU9313waT/4Bp+6BxIlO0v9f3PhrXucRR2yuPPt5ksuRMjGeewGKKblxwh7ajEf+gIFqTU04hAyEbcK/VaKG4jrCyeSA+AZdc4KhxZYBaOk+vkbxJ5YIEdJ00hEiyi0Dq7jbqnh71FEfMh/hqMPaxlVRJZCAfRxV/i2Qza19cJW/fCdAoUuHOO4bhJdSrD8RzfCKfNlizmJYudyg/AKFqIvnYATFbnQSxtiUWC9hv56DIglCyJCe46sGr1twpMaZlH271w46EhE7wXJjuFLO3Ufg0v6nFdd2u8wVBI+L9qOE3jQxStRYlPY0UkDoaNaA3iZVsjRhg+5KzRUQbbJ47vwq0TF4IdpBHYIQf+dlI+A31k4IP1i16H0Bj4XPZjnKyez9u7YvNF+Anj0LQWpdEyAlP9k84vlE7fnkH5+BbNjY+UM2ZUq24a9ErIZL2n3EstfLrQiOx0GkdIArKJcAzwOYz66XmZn2QC9i9/lL8PcaLW9gSQoeUJOGac7hBAbeyQc9JT1ksuP280eh1/lYNGUSAQNZ0Tho6Ox7RZZy9XtBHaJcU2wKR9lwSLoMyNSDYiXUzCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NzTDNLTk01OVF2S2RiSFBQS3FMNjUxQThKR29VVUhXSW1xKy9uNzMvbHRD?=
 =?utf-8?B?aTdFV3dBamE2NlBPZWVxaGh1REluMzcxaTV5SFpLaDBESzlOWUlVUDlSVm9m?=
 =?utf-8?B?cnpDdEs3YlBLRGttcTdlbFV6TGdLV2QvUkxxYklZR3NiUXlNQkhIUkFiMGxY?=
 =?utf-8?B?Z0JnL2tyME1Kb2JMMWtZL0hraWFra2FCTUpSdGp3MXBtbERrK25RZm9OT2dW?=
 =?utf-8?B?eWsyZHBralI2dnA2UzMyNHhIUk55VnR6WGc2aE8yTzFvWENpRFR2MXhkV1Ir?=
 =?utf-8?B?azBJOGRGSU1RdGZBK2tIRmxIdmJHRjhpL1lOME9kYmt4TUJUeTFGblJXYVcz?=
 =?utf-8?B?NXdJRVhQUmdGRG9WbU40NU1hRVBDUkxuUVV3WVlTeGZLRjlJOHNFUUgvWlNE?=
 =?utf-8?B?Wmp0RlJoTFVGUDFJSW83d0laZm5xTmxjZUJHRFdCRE9kc3NmRVZ2Q29MYXRp?=
 =?utf-8?B?UEthaHA1TCtsQlpSVE1nV1VtQ2dpT01hVEQwbFdDUFhuNGN3OHU1aVQ0TnE1?=
 =?utf-8?B?eENKYUlZZ292cktPbDl1cGNWMnVhZDlOUXgxbkoyajMvYjUvYTNZK293ZVht?=
 =?utf-8?B?SHFkVTFCbE9hYnVNbzVma2loTFMwMHpjZDY2QTJrZnpVeHFkbS84eEtWS05k?=
 =?utf-8?B?dzFJSCtBU01aZXBva2VWVU5lekhUb2Z5VHZNYTJWTzMwREJ4MjVHNmN3aHFt?=
 =?utf-8?B?OWVXNFF0L2JFTm9HV0lMaUdKTDBNVjYzYTdDN1Fma0ZrQTE2L2tGQlZBNzNY?=
 =?utf-8?B?MnRQMnFYRGZjOEsrMGNpdGpZdzdlOTkyRVRCcnZFZjlwWTBjWXRzakhpL3dy?=
 =?utf-8?B?cTV2R0kwaVh2VUFYZ3BuRytWSThoS1hDd2YwdW5SVnEvYkd0aEdveGovSW1i?=
 =?utf-8?B?c0R0dTh0NnlvSmEwTTJKMUNJL1Vkblp0ZCsyUTRyQmlsdTFQTGZXV1BPaExn?=
 =?utf-8?B?SzNuNC9VMUdHMDV4dWpnYmhDV2k2dEwwK0ZCc3pBMXlEWkRNL3lYVjg3TEdY?=
 =?utf-8?B?Yk5kVG00ZzBiV1E4Y0hwVWFnWmhOMUx2R2VNbTd0QzIrdW1SWGExZmV1R2pD?=
 =?utf-8?B?MjB3bUFUUVBucDFMK1A2WTF1OVNVaDErb29ZVjJ0TzVlUlZjL1c1MmFkamY0?=
 =?utf-8?B?ZHA5ZDQvNXpzdVRtbkpYMksvSWNXWXFRSW1hdWp3dXROeklySk1tNlBHUnM0?=
 =?utf-8?B?QXJ2MmRZcWJjaXdQeXQ5M1FrdVQxK2FjWUE5dEp3MEh6SkVwRjNtUTJFRkZG?=
 =?utf-8?B?T2V2OC9ITnFacmVGVHFaRm9Vc1FJWVIzekt5eml0RDFmZDc3U3RqaDNtcG1M?=
 =?utf-8?B?SlhBd1VzNXpPNnBXSUFCcnN0MlFzcXVNY0gvaGpaNHBOME5nNWlJa1NRSHV4?=
 =?utf-8?B?V3FFOVFmQ3hUVVZPRE9aWi9vZ1hqREZBSEI1ei9mK1JsS1lQOVNuL3VFdTQr?=
 =?utf-8?B?bmx0RUtJKzBYWGxlRkg2Ym1qa0plS0pMT2RsbUlndUFkL3ZYK1BEMFlVdVFq?=
 =?utf-8?B?NzVFOWFQRjQ3cUdteTJXOTIvNEpXdHV1UmxBWTdXL1JEOTdIbnhkMExhV2lT?=
 =?utf-8?B?YmgzTkRhS1pqZTNqU3FrUzczcG4vMEs5eEJ4MVNJaXo5UkV5TnhNKy9xeml1?=
 =?utf-8?B?MjJ3NXpZU1NGaWgySnByem1uNSsxeEpYbHV0d2Fzb3FyYk9lUGh6MUx0TXEv?=
 =?utf-8?B?R0RhaDNuVWJIb045bk5mcUQ3TnlFOCtVcjVIT3d5MkFMYUFNa0dTMXk3RUpt?=
 =?utf-8?B?TkpuYU1HQkJ0TzJFMWpsd2ltMlU5RVBmTWtObHlNOE5USFl2bmg2SFh1alhn?=
 =?utf-8?B?U0oxSXFxeXJqdUVLS0t2OEIvRlhEVEhuZkxmcDUwVVpxMFpkOEp0ZU1KNkFH?=
 =?utf-8?B?dkFUMDV5N0JXNjAvVU5FV0diK3lCWm54T0c4RnNzN3hORUN0ak44NU5LT1lP?=
 =?utf-8?B?TWZrQnZMMDZWOXhUVndDOUwxaGNIdGpLNGoyejJlN2FkYUVtN21GWllsQk1X?=
 =?utf-8?B?MENFUGdxQnJ2YlhjbXRtMlF0ZXRZVUZiN1ptVWdEY2crcTdhTXI5L0w1TGF0?=
 =?utf-8?B?Vi9GZkJHS0xXMXJtS1hMbGVpNmk3K3VzOEdLNW82ZWgrSFFadEt5b3kxWE1j?=
 =?utf-8?B?MUV4c3RIRm81YWdYeXE1NHoxbGhPNlFTK09tbU81TkE4NXVjVG5ZSTgxTSsy?=
 =?utf-8?B?YkE1Z1MyUjV0RFJjbzcyOUVPWW9MK3g3ZHlTQ1AwblNaN0tYdjdvNFVPbFpY?=
 =?utf-8?B?UGdKNk53bG50cW1wOUdMdGFjeDJvczlObVdnUyt1bGpMTW9uZS9QUjY0RTJ0?=
 =?utf-8?Q?sGAvuabwnlVtP8MTbV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707f749-9a54-47fe-92c0-08df2f798610
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:45:09.7881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9imlv2WaX+lJXHZiY34J8/sqpzOxz6a+Rt8teIoRhX1NaTdnGQdUv/9R7lm1CSirkpvOxW9ZQbySMpSCn9WOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/2026 6:19 PM, Matthew Auld wrote:
> On 21/10/2026 13:18, Arunpravin Paneer Selvam wrote:
>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> Range-restricted allocations (the visible-VRAM aperture) skip
>> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
>> eligibility guard, so a dirty allocation freely splits clear extents 
>> (and
>> vice versa), interleaving the two classes until no large same-class run
>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>> search instead: block_incompatible() rejects opposite-class blocks in 
>> the
>> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
>> request still succeeds when only opposite-class space remains. A KUnit
>> regression test covers the interleaving pattern and fails without the
>> guard.
>>
>> v2: the strict pass can split a block and then reject both children, so
>>      a split no longer implies a compatible block exists. Sashiko 
>> reported
>>      the resulting leaked splits; fix as suggested by Matthew:
>>   - Push the parent back on the DFS stack after each split and merge it
>>     back with unsplit_block() if both children are still free.
>>   - Make block_incompatible() judge free blocks only (split nodes keep a
>>     stale clear bit) and take the requested order, so mixed blocks that
>>     can hold a compatible block are descended instead of skipped.
>>   - Extend the KUnit test with a coalesced mixed block and a check that
>>     a rejected split is merged back.
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>> Assisted-by: LLM
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
> Are you just going to push this one by itself?
Yes, I am planning to push this one separately. Patch 2 can follow later 
after review.

Thanks,
Arun.

