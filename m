Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C78CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5806810E782;
	Wed, 27 May 2026 12:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zlCBCeyT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BB110E782;
 Wed, 27 May 2026 12:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SabzoV131SeG/mrJftqxnFLYm1HE2TvcOs+lo7RruCRtQBS1lYkmMtSNgFHYJaDxuF5VlmczqLeEHvFEXgWz7MuocPFd3lvtCiERo4nd5SSEUJ5IYIJ8At1wmhQ4vyoqYSZln3M0XKyvTqpgMtvZDwCuvojDPVrKYvFwOlpnAvpEJSm+ApVXOuUIrfarOrJYmUkOU5Va9+yj1hVOeGnjj9tC2kSdWXpv4xXsK0tsY7eT6powquMdc71gDf5N+eplUFaNx7kxD3DpoX9nb4HB4ICkKcV3l6nOQw1pHDVgmSGbgKjeC98GbplD7VgdFrBbahncKC6C/Bm1Oa7V2DWPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2q9+29YR95sV3V+N3kIOKnlCutkeqIQocBcbDA2QYE=;
 b=awZnl5c0fdTaJE19dLMlQSLxp2yfRwTPPQTjU7QB3Fdg94h1EzAly2BAZmN8PRtlSAR9EZelqJNkhTZeZ1tSctJYFg2QpFkkf/qXEd7oTWWeh1NcjT+EGfKwQW76YLWmgQGRpB+GjbW8Ut+3CXIAQ4dnOKoonUEMA64TwLz9a/N+XScG9m0eXMqYJ3fmC/yoMFtPTu+LEGljs3GHgFKwWXe+TozzRkiXBAE7pIprFh73kBpgkZ7lMeVm2+m/1QfwkXSbvr7aXAqotC4sjUK/jWfoxwyPMAOYxUBzFrVgJf7fPnR/28KzLFiJ9lzQZuU50Om4LUjSxg41nifPnusCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2q9+29YR95sV3V+N3kIOKnlCutkeqIQocBcbDA2QYE=;
 b=zlCBCeyTmMXzU8RDbZi7PfrgdX6II+U3Jmf7aLmLsHKLhUKr2PQfJYJtExvo4/ry2YzBUilWlDjI2MM2m+8crsWqoj6DLOWlm27xyjZDdwaupqHomL0moBp0QiCMTA95NFrVNRmURsLWzsG/E7rX9rFsc9GB70SxoMAknmNZBaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11) by SA1PR12MB8144.namprd12.prod.outlook.com
 (2603:10b6:806:337::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:03:50 +0000
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8]) by EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8%4]) with mapi id 15.20.9891.021; Wed, 27 May 2026
 12:03:49 +0000
Message-ID: <3c675869-7c7b-470f-806a-4c2110c9de07@amd.com>
Date: Wed, 27 May 2026 17:33:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
To: Francois Dugast <francois.dugast@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260522092600.32818-1-francois.dugast@intel.com>
 <20260522092600.32818-6-francois.dugast@intel.com>
 <e3022ae8-d08d-4114-b6c0-c8f0890a2dae@amd.com>
 <38cc3449-b51a-4b54-bed8-8802e7b37299@intel.com>
 <394c16c1-2c3c-4a70-9d08-1e5ead02b424@amd.com>
 <ahXQbk22mSPUOXk6@fdugast-desk>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <ahXQbk22mSPUOXk6@fdugast-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::11) To EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB999132:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: c611bcdd-36ed-4e33-97fb-08debbe802c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: uRQF372lxu1ZQ9w2yfFi7/FotZIaNjV2Dlx2s3VyRrufjOa+oFqXJ2ChfV2wmHHb68CGqcKipVu0LwYtMg+M8PlaPifd0QC3dC9UspzrriScCMgabWkmWXhJzQ8+vpkxYgQinYVgrXWxrCPfqTfUdLgwnuamd1ImZZ4QPU+HvYg1nabF6vq5GFabml/DFLhWS4/HQKv+4+5hUrT3geR6a3UEwFEAddq91eNFJLW5zA/wF8TBFRQuSGuJaLbaqd3OoTf1ehOPGiyXTwjdIu0QZEV855vuszB7gP4S4u5dz/nO/Igsov5bEKlnfYqSrP+U4fFdBeKU574USe5vNO+0AjIIruZ85pDT4LEAYm4yJDdbrBRFmbZiqLA3aHpH2pEjSwiwTX2wQdCn0dSO40O8gM89vi+Uu6TopP+jRDXSRDfJ4ccaE6vjv/sNpIt697xgSIwyIlUJckXy92Z1ECvpW7/oCr2g49Ga6dzcSVZokBM8A5vT08jIyDM20WcY78/gbTs8+3k/dsz0uM+kGDIdg/Gqy2Pccz89EwjGqegkXiVJIMvY2om9NwRXN/DhOXII3cQKegpNGRIFhsUGfuLUzrRxOLpkKGba+j4PQk1uK20IEKYBau4GfU0B8ikXEIPaf81JF/XMHCxCqTWFbAmCmfsOy2HEtcE7ChYgtbWCagz9QxPtx+WvLQjN3oC2z6dd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJIRDg3Uzk3WjdmQlRVR3V3SXVudnIvc1pyOFNCSUhyWVRsdmpNMDJsaEd3?=
 =?utf-8?B?dkRoVHpsRFU0OFQyY3J4M21IenVIa2NCalArQ3ROdlBmWk5rRHM1TGtKbWFa?=
 =?utf-8?B?ZVc5QWRkODc2L1R0T3JzRENEbWVzZUFFbmZSU0Qzc25KOGZoYWZhNXhZYk1r?=
 =?utf-8?B?aU9RWlBjYVVpcFRJNExkNlVVRE42eks4R2JIY3BRV045OGh3dGtmQWEwYTM0?=
 =?utf-8?B?aUdoUWhmR2MzTzVnUXVTeVFtcm1jb0M4U0RDRnBjOTZsZ2U3bDB3WElMVHIr?=
 =?utf-8?B?U3J0VGNiT1pxY09jVG5Ca051eTNsOXJONWphc3ZmWVI1eHc3TzA0SUdSL0xE?=
 =?utf-8?B?ZnVCYnh4QVJ1TmtwYzlMQytTQU14MUVIK3krclBwSVRYU3d5SU5FMWNMbDQ2?=
 =?utf-8?B?K0hQUTZ2MElmeFZLRE5YelpJYUkwcTRsakFBaGg5L0UzR3k5YjR2VGpKMmcz?=
 =?utf-8?B?TThEMkZCYVhiVWRadG1TMytKcERTRHV1TU9hZThwK2d4TjVkSG1lMTJOQ29y?=
 =?utf-8?B?eTY3bkNnQm1RZFVnaW05YzlzbkpjdDIzUDNQbHVUVi9RT1M1NUNRekN5SlBV?=
 =?utf-8?B?MUZEQkNiK0hnOEtOOWZTSXJlZWFHUzFZZEoveTRSd1FaT29tS21GTldNWlFi?=
 =?utf-8?B?OUJlZ2F4U0NDRTA2MmRGdjJYaGVWM2RsYUtmUkoydVFLMG5FT0kyMjZIUnZW?=
 =?utf-8?B?TDRWNi9pTUJtbUJ2dzlRcnhjZ1dtYnFtTGNwcGtkQlBSMEtiWlRaWlhDV3Q5?=
 =?utf-8?B?R3NBbmpjejBWRDhEQlhKKzh5WjJqbGtKSjRHWlNWenJyT0ZEaUNVMitQV1FT?=
 =?utf-8?B?ZEVPNlpzZDZDMFBtSlZtQkdxMm03bUJ6QmRDWjRXdE5MeUJCWXpEZ2FueDVQ?=
 =?utf-8?B?TTJCV0F6UjZzK3dUWnhzNG1Yb3NGRGtZZ09GZkYxYm1aWUtRMTc1K1ZmOExY?=
 =?utf-8?B?azJpeThoVFkzVjRiWTYwMFdKbTJKM0hUa1JxTlRnTEVJQnpoZW5SR1RXeGRJ?=
 =?utf-8?B?czdZVi9vS0RsRERCdHk2NFYveGdYSnNSQy9hSVVtYTdEMEZUc2ZkVkowNGtW?=
 =?utf-8?B?TmVnR0hiVUltaHBidmxwaE1OdldQVlp5K2QxcHpPbkJRSHU4RTF5U1prWjh1?=
 =?utf-8?B?VzRFd0xWd0duZFNPdWhuYnVoWTIvVklRdVlBeWxNblZOOGxsdldJeWF6ZVA3?=
 =?utf-8?B?dk1QTWoxQjUwWnBuc0VWejlhY2plYUc1SkVVZ2ozVzZQYTNuT2dCK0Q4TU50?=
 =?utf-8?B?RWpQcmk5OEhoaWJNL1FaMjZudHRnYjdjOXFMcTYxL2RpbWI0c1U4ai9BQWxh?=
 =?utf-8?B?Mm1wYzI5WDVnU1l3eUU2M2FWd0U3MVlpcklRaHk5dUVNOTNTNytNczM1V2Zj?=
 =?utf-8?B?SW1ES1ZsT3RtaEFzNDUwVGdUNVpFbFZYU0xnRDc4cXFkVFBPVE9uK2Nncktw?=
 =?utf-8?B?bzNQbGUrdys0N2tTYVlMd09rSzVSMU1xNno4K3Zrd210K2thQU1nUksxRXMw?=
 =?utf-8?B?dFQyNkF2UWFYWC9Ib3ovTFVxRGZ1ZUpHMjducjBXY2dsa2FTblVWSkRPQUl2?=
 =?utf-8?B?aHordjJoYlNUYTFSK21BN1hMN1NTVUdDZDg1eGVkaUF1aDY5Q1hqU1NpdVV5?=
 =?utf-8?B?Ly9JVmdVOHc3MjMyRUtyNUlidjNnalRwZG9ITXNHZU5SVzgvTjEvMkNDQ0x0?=
 =?utf-8?B?cExmdFRaL2NJZU1YRk9mOCt1UUtnVHRKY2gvMzRZTTUrVzFPdjNoMFVMc3g5?=
 =?utf-8?B?MFNHYTU0OGxZUmJaWkZWZDNOK3hlVzFuQnpKYlJodzVaQVF5c1dXREUwdUtM?=
 =?utf-8?B?RkZTdnV6TFNMN01RQU1SWTlFR2dpNnFCVnI2cldZZDFsNFdSMFlpMUVSNXJ6?=
 =?utf-8?B?Q1FnbmJ2akJQSUowRyt1WTBIaW42dVJaUmtpZ2NJSmVoTWpCK3EzcG85RWI2?=
 =?utf-8?B?WnhQYzFDZ01GL3labkpiUFpZbFBXT29tcGhWa0tOWVNOWlgyV2g0di9tc21h?=
 =?utf-8?B?RVBvbnRsaTdsbTVkcTBxcDU0WG5rak4xS1YrMC9XelpPRE82bThlTXVTa09r?=
 =?utf-8?B?TjZ0RUNmNWFVRjQ1dVpmMEN4ZWFiMzFPTnVvK1pnQ3YxMDNIb2JxcnhvSFQ4?=
 =?utf-8?B?b3JUR1pNOFZqN2EvU1FOcmxkN1g2UklwNlZ5ZFU4NlJKT1FsOUdPZllxMElj?=
 =?utf-8?B?bjMreklYSHhtTm9GWTRubUxnVG1aUFF5SStFRUdzRGc0S0M5cGxoaXFvREph?=
 =?utf-8?B?VHJIeUdISjZUTmJSbVdUa2xvTk04WG8xNmEvRXdINmExdDAvMWEzNUE0bmR3?=
 =?utf-8?B?bGJUcHU1SHBTdUxtaHlEQmV2L3k1S2FieWJSRHMwanVKWWRCWW9lZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c611bcdd-36ed-4e33-97fb-08debbe802c1
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:03:49.6321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GtxttvdxWkE2rWSqv+w0SsjAtUHi2iSstm4hg0M1qTT5Ye0vnQG0qvzQkof1gY1aDI6kx9fe/cZ47Slnjs6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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



On 5/26/2026 10:25 PM, Francois Dugast wrote:
> On Mon, May 25, 2026 at 02:40:59PM +0530, Arunpravin Paneer Selvam wrote:
>>
>> On 5/22/2026 4:26 PM, Matthew Auld wrote:
>>> On 22/05/2026 11:25, Arunpravin Paneer Selvam wrote:
>>>>
>>>> On 5/22/2026 2:55 PM, Francois Dugast wrote:
>>>>> Extend the scoreboard approach from the previous commit to used blocks,
>>>>> so drm_buddy_print() can report per-order allocation pressure in O(1).
>>>>>
>>>>> Unlike free blocks, an allocated block can leave the allocated state
>>>>> through mark_free() (normal free and gpu_buddy_block_trim()) or be
>>>>> consumed directly by gpu_block_free() during coalescing. Both sites are
>>>>> guarded by gpu_buddy_block_is_allocated() and paired with the increment
>>>>> in mark_allocated().
>>>>>
>>>>> v3:
>>>>> - Assert scoreboard is empty at fini(), as sanity check (Matthew Auld)
>>>>>
>>>>> v2:
>>>>> - Update after fix for use-after-free in split_block() call sites
>>>>> - Change goto label to out_free_used_scoreboard for clarity
>>>>> - Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
>>>>>     free
>>>>>
>>>>> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
>>>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>>>> ---
>>>>>    drivers/gpu/buddy.c         | 42
>>>>> ++++++++++++++++++++++++++++---------
>>>>>    drivers/gpu/drm/drm_buddy.c | 18 ++++++++++------
>>>>>    include/linux/gpu_buddy.h   |  8 +++++++
>>>>>    3 files changed, 52 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>>>> index de18b63fef0a..dc81fe0301ce 100644
>>>>> --- a/drivers/gpu/buddy.c
>>>>> +++ b/drivers/gpu/buddy.c
>>>>> @@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>>>        block->header |= GPU_BUDDY_ALLOCATED;
>>>>>        mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>>>>> +    mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>>> The main consumer of free_scoreboard and used_scoreboard is
>>>> gpu_buddy_print(), which is a debug/diagnostic path - it only gets
>>>> called during debugfs reads or error state dumps, not during regular
>>>> operation.
>>>> However, the cost of maintaining these scoreboards is paid on every
>>>> alloc and free, which is the hot path of the allocator. Even though
>>>> each individual update is small, do we really need to add extra work
>>>> to the
>>>> hot path for something that only benefits a rarely-called debug
>>>> function?
>>>> Am I missing a use case that justifies the hot-path overhead?
>>> The usecase I originally saw involved sampling this frequently during a
>>> running workload to help collect some running stats. For example to
>>> generate a graph of the "page usage" over time. So is there lots of
>>> smaller order usage (bad), or do we get mostly larger page orders
>>> (good), do we see spikes we all of sudden we start getting smaller and
>>> smaller orders, perhaps due to fragmentation? In general we just wanted
>>> some more visibility to get a better sense of the "page usage" at
>>> runtime. At the moment we don't have much visibility into what page
>>> sizes we are actually getting from the allocator, over time.
>>>
>>> We originally had this at this at the driver level, but it's not quite
>>> as nice implementation wise, plus having it in the allocator could then
>>> be beneficial to other drivers? Also the added cost did not seem too
>>> bad, it's just incrementing/decrementing a counter. What do you think
>>> here?
>> Yes, that should be fine and useful for capturing runtime workload
>> statistics.
>>
>> Regards,
>> Arun.
> Thank you for the review!
>
> Arun, any objection to merge this? If so, should it go throug drm-misc?
No objections, yes it should go through drm-misc-next.

Regards,
Arun.
>
> Thanks,
> Francois

