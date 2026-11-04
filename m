Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045E606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TBtAhmu1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1558410F9CF;
	Wed,  4 Nov 2026 06:55:33 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564C310E820;
 Wed,  4 Nov 2026 06:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY2iidq11vlOrbMVR08TUihf+Az3cJS6FIAiDRlTGlGqqBQAJNZgn1sIWW6kmsP+tQfQgyiO73idofTOrCf2H7+Nx0Eoz1JSGRFua0agcR2w1ittOXkDMaJl8VQZcLuG4Z87mC76LT8wug/6d8Qtb+UqYt/VJWLTE8Rn4GxwVDtFaJVPDd4j7L5DvjGoLa3hQEDquMHsRgTbGmLPaOo4Asz1851MCKhczpaVj6yW0RY6kUIyHU1DMgsbDhLWejIbqD7kgk6ZJ5Xg47wFD9L16X8qUntsU9yiU2MtNtypVvH3MyuK5M9kGO4L4kVQxmufkvrU/oqTN2RPXNr0VWkGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwDvH+nrQgB8eVk4lz3NLaP/cHK7CbtYi463N/X9Bs4=;
 b=P2bBiZke+p3Y6nYGpRGe0tAtDDkHvCHYZC4w6+D7qQCzojcBluNrWsZp/9dqGtdl4KJqYCBjfR9QFo9V9U/+8Fl7dRHE68naTSCfXgxG3tWLi88ELzB+F7aIlg+pxy40IJFFg9Mfr8B6ayRWqSGzvkx8qRITNQqJQL6Ax6PgXNpaB5JI1JkG5IuGPw9BnFtaEBQPPaW5KFblx5SFGx9QydlT9edEOtNOlBRsKNPywsuDy52RaHaRTVRMe/Y52PP94Tyvt0jqe7WFtumKW/5Qjc3RcECZ+Qs7HSmSZFnCKNV7FYjwTc9IwrxUiZtRHU7yaNAzUlQwFT8c8KhgtP45Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwDvH+nrQgB8eVk4lz3NLaP/cHK7CbtYi463N/X9Bs4=;
 b=TBtAhmu14FT8BhnF7vzn0QBkoogjkjtoQhnpEofyczgrvAUsRBRWwARvpBQwL47xKyUebfidF0nH/XMQxqN/a+kvlM8a9K37ptyplDqG94h7Fd1+nPA28yQi3eD+T7s0I/w6YMHtx+sicJFk7WCLOIaKCXPYZgayikFYst4ZO/g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 06:55:12 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 06:55:11 +0000
Message-ID: <c0b4a12a-cef9-4913-87fc-878490c8d582@amd.com>
Date: Wed, 4 Nov 2026 12:25:05 +0530
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
 <b32ccb67-0e02-467a-8c29-2ac4c815390d@amd.com>
 <428f8c9f-5cf8-46f9-8611-52e6aa71a24b@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <428f8c9f-5cf8-46f9-8611-52e6aa71a24b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::6) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cb8303-03ec-4cf4-ed8a-08df3a409208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|4143699003|261022105027099003|56012099006|5023799004|11063799006|261022113327099003|261021121427099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: RyV59iPU75JY8cs3iAR74xrOcROHk798ps73Gu+0HPL9l880GP20YwXx4uGM9Lok7kv+CTkC8jzQS85qAej5wY3WqyjclkwxwSOKahScUL1ZytrPNKD4reEV/TdR26SGgZX88N1cw85k6l1t+Of0sFOWPtc6vezefxtKkK6VCEzJ8Km3rAMvJvhkP4TcoLShC7aTxvxgb+qstHsC1ekyT9qnFrjwDndZxSS8WPIb5nc/2x0BV25WYEn+uqRVRJr4AJF/AblFyMBD9m7NXKYsqNLjrtM6NA6rD19bm9/DX6W1zIljnoHqIBc8Chu9KtL7lp8PxI9v0hFvBl1hEEgGSFtP+VL78lrLMqev/SKRGD2Qy6jL0R3hi+W6zZ8xzL75ihMQB4wn0wdDJuH2aqlIU0c1CFyLEdihC6dCj6x1SGujTWUcLvGRkzTnDpEZQa7Ou5fd/IerY0x+LjHcwLyMn01ym4jFcTNbdFF7c+4Sxg/ORMq6l1g5gm7r3WJunyNucdz74hXcC/tT+0PBauaEPrs/ZJ1bJ3fZWKyYdfhS/Ox9mCXmKVh5FC5e+BV4KyxSnpSE+cxcPr1C6GKGCD4eL+bY3y5uoB63WFFRCY+M6lg0v7SzgKTWArWGfJf/kXhnBVO9Gr5Q/Na+JstfDR09aLxGi6tBZ5oIDvccz41o37k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(261022105027099003)(56012099006)(5023799004)(11063799006)(261022113327099003)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0lmdWhHZ21hY29kNmFyaGxtcCtKSUZwUEdtVTdmeUErWlhjNVc5Q3hFdDdZ?=
 =?utf-8?B?N1E3TERldGl5V0VmTE56dGttMk5jNEt3QnJkVWtZeEVKUGVWaWRQZDdnNUdq?=
 =?utf-8?B?cWVYaTZrbHFSdjVCZEFWRTJwbGhxMHcrV090UlVpdEt5QkJteVZnTmlpNGF3?=
 =?utf-8?B?aXl3Zi85STR3T051dVZBVzdNR3RuSEc4eXFhalZBamZXU0tkRnZRTHErZUth?=
 =?utf-8?B?WGpDQUlLZWoxYXpRQVdxMFo2VnJlY0ZwdXZHWlR2ZW1qSHpDZnJCUjhTLzRH?=
 =?utf-8?B?bWlaeGNXYkhFMy9CMTlCY3RkYlpNV2dWd0JOS1ZrcGlqVkxpRVFlaTRxdzJj?=
 =?utf-8?B?TG5aOFc3R2pyU2o1MzQ1M1BBKzJYei8vN1MrKzZ5WDg1QS92cVpVTkt1MGxL?=
 =?utf-8?B?Wlh4VXRqMkRPd29HUmszdk1YVEFhU1V5M0IzNHhxOUwyRzg2MGtKN3ordXJw?=
 =?utf-8?B?emx5bldRRlZsZnJ5ZTFud01QVG9FRUZmdVRCbnFEVlZteU9ZV3VEdlpzMDkv?=
 =?utf-8?B?UlRCeEZobjdBeXVPOXhYZGFUM3p1M3NCMUxsa3ROQm1paERpMFkzTE9TMmJX?=
 =?utf-8?B?UEExQ29MNFJHUlltenI2blZqT1lSOE9mdmI1OHNvWG1YcWRTS3cvckFMYVJ0?=
 =?utf-8?B?TnlnMFh2VU1CRG9JalEyOEtiM00yN0J0anc0RkZ1a2Y5WSt2NXZEMGFYM0ln?=
 =?utf-8?B?NURjaWRnVURZd1ZEZnpvb0JWQklocm5rLzV2SlAzRXVzeWpwcWtmTE5ER0hM?=
 =?utf-8?B?VlMzdTZFWXhvMEpWNGNLZ2ZHLzhXVy9MQ0xCNFdQdjhOeEcwWDFyL2dHNTBt?=
 =?utf-8?B?OC9Fb0FYVHRPSkF3V1diRnJBcE1ldklOVW1WK2RYendkeVJSRjUya21KRFZu?=
 =?utf-8?B?V0svZHdrTnkrb1lORWJHdk1NT24wNWlkeEhvNmNsRkY3NW5WU0xKWTQ0K05Q?=
 =?utf-8?B?VFE1UW5NOU5RQ1BLb2gvR3g2MzUyUHRaM2xsSWN6emlCS3FWRjk4MEFYQW9u?=
 =?utf-8?B?REppTGFYbUo2VzgxTVlRSzBtZmYxQkVEN2dzalAwREk1UTRLa091MEE0d3I2?=
 =?utf-8?B?M3I1TUM3cEl2OHM3MSs4dVAxN1doZEEzeU1RZ0RSMUdnR29XY3gxaDIvZXcv?=
 =?utf-8?B?c2J1WmRiUEFtRmFMSVdnRTR6Nys0alVEUnBDMGRLUlVrMm9DajNJK1ZTTHFF?=
 =?utf-8?B?dlRicGUvQ2ZtZjBDUTdqNm9MT3d5SURZaCtCcDZONmtMTmlSSlVTY3RSMUZD?=
 =?utf-8?B?bkZtMlV6SWdUWlBxdG9ZMGtHZ2UxcXFCSG4yODBNK2ovUDQ4aU5OKzkvRXBU?=
 =?utf-8?B?d3hjRXFsS1NIdjNBd3BkejQwS29KczltQyt2ZEd2alk4VEhjYUh5K1lTakZB?=
 =?utf-8?B?SlhVZ2QzbFdWQlUzY1BqdTZRVE9nbFBnZkFkMGpOVnlLL1pyZzYvU1F5L3Nm?=
 =?utf-8?B?bGJsRVNISGVkT2I1WXV6OTBQS0VJZDZnay85M2xRU0lIY2NWNDJubDh0U2px?=
 =?utf-8?B?UFFkODh5anAxTnBXY3RMWTJTYk9JUDdtUnFKdEZEYmRJNjVFcjVCNGVkVVh4?=
 =?utf-8?B?RVF6d3NrNSt3MjltOU55Z0Vzck5LckdtRHpiN0JLdVNrcmZ6TXVDZjY0ZW9K?=
 =?utf-8?B?anloVllUdEN3QW1XWUtpMHlJSUk3NzFsVFlrRkppMUVHY0NUdDNKUXl6NGwv?=
 =?utf-8?B?M1l0dFU1SGNJcTRPOUh2TjY3R1NDTkozNkdoL24yblRmcHB0RVllYk5aeXdk?=
 =?utf-8?B?S1d2SnkzWXhmYTBwdmZ0Ti9qK3k2aU1WSUtvZjhHU3ljbDZSaUpQV2VPVEk3?=
 =?utf-8?B?QkhobERDdnpvSzhoMTNJTlRsQWVjWUVlUUlRN2gvYmVCaXcvRGc4eUNvdjBB?=
 =?utf-8?B?OUZiVGRwSlAvM3ZDUElLd2ExMkg4Vm9EcWRFRDdqcEpRSm91bDNMMGdRcnd5?=
 =?utf-8?B?dWNESHFuVXJYUDc3OWRwbE1jaXUyV21GZ2RBTk1NQlE2S0dZM0UyYThTOW12?=
 =?utf-8?B?Z2dpUWdHQ3Rtam5tajdSdE4vMzBSN0RYMzl0VkxFWjZTZVhwTWd6MS9pV3Nw?=
 =?utf-8?B?aS9jNnVidWhCcEREMG1EVys4NmhkNVJHSkVDdVljbWgyd0ErR0ZxVGxzTk05?=
 =?utf-8?B?NlFSTGRBc3VEb0NMWjZRSGdlc0xhOVFaL3FPNXlzRWdIVlhqd0cvN0FseFR1?=
 =?utf-8?B?NGRXdFRXcWZybHJPY2ZWMFFUOXdVdThpa1gzM243djhYVkJYSk83OHBVQlJR?=
 =?utf-8?B?N2ZucXJDMC9ZVkI4QXJ3czB3MFFOTXZnaVhGdStiZ1dHcndVSDYxYzNBQWlT?=
 =?utf-8?Q?k+P0Vief9zLqbI44zh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cb8303-03ec-4cf4-ed8a-08df3a409208
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 06:55:11.5922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9RuV9pU0PIKqfgEI5FqOAp7HNbNszVMRQezMe/dbQHD+KTKRXTUxIR/FuZ1yw7hIyOsPA/oFZY7pICmaDR1tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 7:39 PM, Matthew Auld wrote:
> On 03/11/2026 13:23, Arunpravin Paneer Selvam wrote:
>> Hi Matthew,
>>
>> On 10/21/2026 6:19 PM, Matthew Auld wrote:
>>> On 21/10/2026 13:18, Arunpravin Paneer Selvam wrote:
>>>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>>
>>>> Range-restricted allocations (the visible-VRAM aperture) skip
>>>> dirty_steer_window() and reach __alloc_range_bias() with no 
>>>> clear/dirty
>>>> eligibility guard, so a dirty allocation freely splits clear 
>>>> extents (and
>>>> vice versa), interleaving the two classes until no large same-class 
>>>> run
>>>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>>>> search instead: block_incompatible() rejects opposite-class blocks 
>>>> in the
>>>> strict pass and relaxes only when the strict pass returns -ENOSPC, 
>>>> so a
>>>> request still succeeds when only opposite-class space remains. A KUnit
>>>> regression test covers the interleaving pattern and fails without the
>>>> guard.
>>>>
>>>> v2: the strict pass can split a block and then reject both 
>>>> children, so
>>>>      a split no longer implies a compatible block exists. Sashiko 
>>>> reported
>>>>      the resulting leaked splits; fix as suggested by Matthew:
>>>>   - Push the parent back on the DFS stack after each split and 
>>>> merge it
>>>>     back with unsplit_block() if both children are still free.
>>>>   - Make block_incompatible() judge free blocks only (split nodes 
>>>> keep a
>>>>     stale clear bit) and take the requested order, so mixed blocks 
>>>> that
>>>>     can hold a compatible block are descended instead of skipped.
>>>>   - Extend the KUnit test with a coalesced mixed block and a check 
>>>> that
>>>>     a rejected split is merged back.
>>>>
>>>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>>>> decoupled dirty tracker")
>>>> Assisted-by: LLM
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>
>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>> This version brought back a DAL CI failure. when the range allocator 
>> wanted a clear (or dirty) block, it would split a mixed block to look 
>> for a pure one, throw away the mixed halves, and then use 
>> unsplit_block to join them again.
>> Doing this on every allocation was costly: even though the merge 
>> cascades back up through all levels, repeating this split-and-unsplit 
>> on every allocation added enough overhead on the display hot path 
>> that a large scanout buffer
>> eventually failed with -ENOSPC 
>> (igt@kms_plane@plane-panning-bottom-right on Radeon RX 9070 XT).
>>
>> This change relaxes the rule for range allocations only: we just take 
>> a mixed block as it is (the caller clears it if needed), so the first 
>> pass never splits and never has to undo a split. Large same-class 
>> blocks stay whole,
>> so contiguous space is preserved and fragmentation goes down. The 
>> behaviour is still correct, unsplit_block is no longer needed, and a 
>> KUnit test reproduces the problem (it fails without the fix and 
>> passes with it).
>>
>> Could you please just review v3 of this patch?. It is a bit urgent as 
>> we need it to land the base dirty-tracker patch on our internal branch.
>
> I think sashiko is now complaining about the same thing from before?
Yes - this is the same stranded-split leak Sashiko flagged back before 
and in v4 I have addressed the comment Sashiko raised on v3.

In v3 I dropped  unsplit_block() , assuming "accept a mixed block as-is" 
covered it, but that only handles a mixed block that's already at the 
requested order and fully inside the range. A higher-order mixed block 
straddling the range edge is still split, and when its in-range half is 
the opposite class (the matching half falling out of range) the split is 
left with both children free - that is the leak.

v4 fixes it a different way: instead of splitting that block and then 
cleaning up, the strict pass simply never splits a block that only 
partially overlaps the range — so the stray split is never created in 
the first place. The fallback pass still handles that block and actually 
consumes the child it splits down to, so nothing is left stranded.  
unsplit_block()  stays unnecessary, and the leak can't occur.

Regards,
Arun.

>
>>
>> Thanks,
>> Arun.
>>>
>>> Are you just going to push this one by itself?
>>
>

