Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E5606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TwwMYAl5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9A310E8F0;
	Tue, 10 Nov 2026 04:18:11 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E434910E163;
 Tue, 10 Nov 2026 04:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mW12NP9TzOyvxwAp5ibSzkUGW6kdNfLUntd3/fq2Ezcdap/LyjOLJZ6JeoqesgQWoGuTLfR9jG9Vagm3zcPpDVxzvYzqvzCsyqistIQebNa9exJgl9FjduRu0Fk/Pl9JX4BsTLCc9BSv+oEsjI6OmX6CRqc1x3viSwWKrQfymSAhIhpves+89NJnUt6HqvgkOYvIPbIlUVFxNuNqD301zL8EmMt5rXb1IT9cfJ4LTysQbXufM0bS1WepPvKJdFXrT1N/kdCz388CsKgIGs++X939T/sTzaReClD7//00BTiF4iUxKcpZbT202SV0Kd9/GABXfaoCtflxaWIa+H1MUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6kYukEkSFLL4JlkRDsBQm2C2WyNDoKzdqXslAgHPGI=;
 b=sO6d+EZp5Gp/K2+NxG0fcbv6OjzFzmtJb9r7U7JKvZMbpyrmJr1t7tLiRT2VzIxAWQX/sw7UlbOTa4kDjuwJazFanNRNQfZ/enRS7ej5Vfo1IRPfWWwVzIEopBeuhKyQhFa2+DGg+Yk3k/Wxinqa5TRVRNNWADmcbCvBvC0OEUp3RQTc3r7GJiGZzP0+bup/2fmzZOgM+ZBfzrmK1eI47jeGH3G5De+Lb2nQxbQB6gpVfBQQnLqhQ7fAwBrNTtEjfgAEw1yk5GSqQ221VSX7JXPu5CCDBo3psp5aH7a6HdROe8A9f3wdOcu3D7vftVKefdiUswHz5JU/PY14E9j0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6kYukEkSFLL4JlkRDsBQm2C2WyNDoKzdqXslAgHPGI=;
 b=TwwMYAl5lq/k8mt1It1JPAt8qdkgKiDDM8qMML4QH22wmOTx8YrCNxYUMM5uf4d/ZFk+WdmWUHnJDxSRZMrUSXkhSK4jqHLtfmJq5/SPxI0K7wqnD39y2MAyp+wBXUNGCuk1dcIGy0/H1uZrCaQD7QElYPvQ938j+n3+aEGGjSA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by LV2PR12MB127395.namprd12.prod.outlook.com (2603:10b6:404:300::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 04:17:57 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 04:17:57 +0000
Message-ID: <e61742c6-1295-48ac-afb1-f047a8dc7b81@amd.com>
Date: Tue, 10 Nov 2026 09:47:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: matthew.auld@intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
 <bc02f8db-8d1f-41b5-b930-c5d46151db73@amd.com>
Content-Language: en-US
In-Reply-To: <bc02f8db-8d1f-41b5-b930-c5d46151db73@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::15) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|LV2PR12MB127395:EE_
X-MS-Office365-Filtering-Correlation-Id: e0da4c2c-f552-4209-68af-08df3ee19923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info: NWIeOhyiXbYgdayCSlPqRkTyvMkHKlNZggKU5CHAKdtcBZM2Gypp5R2gOxyW8AYiNhFRZI1gtdKDpRP+5hgAHO4F7Xa8dgzqd2k3E8Gy8hIMFok5fMdPRPxVl1pUQPUiCjjsekdlLTMG5htp4V0PvNJ2bAVM/YDZ5mbYoWTmJ0OIzusjCi5R7bnMLAsyMLQhQuXxtO7vfijfTdGTlMA+EQXa8bahEy8JXLacuG/n0ejZjFL7/f0/GiX8xyvkMzz7TMELPvtEQuoPPP6rZPfwG3WgolSo5a4vHdllmiX/YzCfuzgBcHWlRP828jly4R4dB5P3S0mZJQ/ej6d8rpW8Z7Vqsstq2i1e5Ow9pmXi/sfUT+lu2HM0UkMQYGwAwuxJ80bf8u5KY92aVDOGhtIVIssarLqLDXAS0PxelPdmTjgQCbbMXQicOzzqb4EVEAZjAJRCISNMudni3NTprPBmrsieJhHLt599H5n+idjAp6Rr2hYa0+g9QKIYAmb+cD1mZkc6YWfQ//8bZrxDvO+/cIG4ho8jnPTKgFTMlGQr9y1d4iWxGtW5iLaKNJ2FPRVdjJ8GEAmKW3V5NJQlORqaZwPc3yYE0M138ajDGlDmmhzzDWZduvj3k17QbYq+nuPJuV/4n50k8ExOHFv1qcBMWOiNtZnUg4uuJkAqanwAY0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnphZlJ4SWxpQVdDTmJrRUtCN0pscXRVN3JQT0s2WEU3Qm9IU1hGQkZZK21Q?=
 =?utf-8?B?MGc2QWkwM2tPakFjOE1xQzZKNnA5eW9IMHcxQ3RYdEVPY3pxZ0NtckFaQkVT?=
 =?utf-8?B?Z0NoTUNiV1pVTDZOa3RicTlWS0FpZ1IwUGprRlZ0QmZqTEkra1FDUEdoc0hL?=
 =?utf-8?B?dGVHeVJQdlVmc09oWjd0eWVoYXZnOUhieDRCNCsvQWl6Mis3QUgrdC95SDNR?=
 =?utf-8?B?WG9QMlNpWTBOR0NDTFFoRWQvYkoyZ2JUTENRYy9OQ2dSL1pvQVc3WVY2SG1D?=
 =?utf-8?B?dzhOWkVtYnBrb0pHMUU4TlhvcjhERGZoM2hhVXdPMms0anZnZGg5QWNVNlB2?=
 =?utf-8?B?dGFnWU5wZFpLazNjQXpkdUEzWDRlUkNSSSt3MXlvSjBKdmVHeXk0a0JNK1Nz?=
 =?utf-8?B?cHA1bFQvM1p2TEtpaWhlS2JjZHl3YUhldlQ5eTdGZnpNZTlpVFhqQnVHUlZq?=
 =?utf-8?B?R2xVVDcxZVdIR3RWUDcvYzFQWTdudTVBR2VoZzA1UVhScmlncWtjd3dzWjNh?=
 =?utf-8?B?WlhhaUxNellBWDZJczlYMzRDVFUxYi9tZFVsdlZ1NFFsN1Y3dmw0eHhkdFFP?=
 =?utf-8?B?QmtFc3hGc3Y4a3ZSczEvbGNFQjFxWXYrd25ZcnAzVUZYSkZraWFvbHExQnB1?=
 =?utf-8?B?djZEUW5qUFlpcE5abVlEZU84SGVmQ3pZWUhPSHh2cFFKNFBKYTlJbXZoRnRl?=
 =?utf-8?B?eG5YTHBDVEJ2ZkFRUStGdU9LNkpwSk92bUoydXdBaHYwMC9uUWNCOEU0d1pu?=
 =?utf-8?B?WFhLNXRqUFlwMlBpbGt2YkVWdE1rZkNETlV3Y2lWL1BpNGJub3BJajFsczY1?=
 =?utf-8?B?dmx3eWRjeTJ5ZmNGNzhYTWNmZXo2bzJSN3JoWEo4OXpQYTRxU2ZUOHhnMU5X?=
 =?utf-8?B?NFpoSGo5RmRiY29wTWFiU0NTYkxEUlVIT3lGSjlKZmJXaHl5VXR0U0xKbnhE?=
 =?utf-8?B?aTd3NzlvVEs5dmFURk85YUc0SDZXcjRTVnIzZkMyc1VyOE84LzBQbDJwei9j?=
 =?utf-8?B?Ty80bnFIZC95TWp5c3F2WXhKdENMa21hQlZORHFmV0tCUjJnN3BDSTRwWndj?=
 =?utf-8?B?d1hFVHNXUCtOVWMwL0w5YkdWdFl3RlIwZHN5NHFOa25YQkVzTy9NYjdXd1ds?=
 =?utf-8?B?dlNwZW4rWlpKU0g0MERzQk5ZeEJlN3VCVkhWQWpzcWtOWm1iWjQvbGw3bFlF?=
 =?utf-8?B?dHFobWtLdm9oU0FhcGcyOEZpMGtaQVVuTjF2b2JRaHBqY0hoQzk0am5vL3V0?=
 =?utf-8?B?SDloUkhtdkxFK2lvcExXb0RseEpISnB3amRSYXNwcjAxMy9WbGJJUy80Wjcx?=
 =?utf-8?B?dlRyRGo0d3Q1VXhBdlpNRmpFNWxRRFBPaUxsZjZVS1ZXZG5vbjBRSzZuakxl?=
 =?utf-8?B?T3JKb3pydDdpYmU1Z1VHRlM2M2RIdmxRT2R4aXdLU3VGSWo0aFR2YkhZT2Jv?=
 =?utf-8?B?YTFCaHRUN1N0TE9GUGFDZHdHSzZsd1RzdTRZSko3MEN4UEFSNytSVDZ2QW9Z?=
 =?utf-8?B?bXJEazliMUwrOFNOa1dmT1NqTlVJTTJZaFRseTNST29KK1gyYVppV3V4WEFQ?=
 =?utf-8?B?VkJ3eDlROFNtTHNqckw4MDE4WUNGcWJhTmlxRHBQanVFdTBpMVhjbVhqRzJJ?=
 =?utf-8?B?dzlRSG1oRDJTZytFcUJyYWRkMWFybjZXcWNjVjY1d1AyY2c4cklsekJqWkJm?=
 =?utf-8?B?SDJRLzhrRGJXRzU0YUtOTWJyNS9oZTJsK3lPbzRkcGp6ZHdhTTFPUW9ZM0I4?=
 =?utf-8?B?LzRlZHFZcGhpMHZrY3Yyc1YxdGZWeGFZZTJjUHZqMUtJOW1hZktvNktRT0F2?=
 =?utf-8?B?N1V1alp1MEtjNkZOR2dCTzEyZmYreUIrMjZicUxGSnlsV0dYSkdqVFhxSnVz?=
 =?utf-8?B?QnprZjNtS2ZGdEpreVpERmJRc29KQXVuSjBneDFMSXkzQW5ZRWh0dXQzcHBQ?=
 =?utf-8?B?RVJxL1M4RFJ6bVo5bFhSeUg5V29tVFVVUDZRZld3SzlJUjJSNGhXdEhZZlZL?=
 =?utf-8?B?TFJYWlBOVDVqbXBGTmoyWE4zRy9JUUZ6Y1VPNFRiU3ZIOGZOQ2NramRYbk1Z?=
 =?utf-8?B?Yk1LTVQreDlOeHBwdExSL3hwbmxxMU42YXIwNnNTZzJzdFVxOUQrbDVTcU5p?=
 =?utf-8?B?a3IvVloyZVFweTcxSmNFYTU1VndQM3BHa0FJUkEvcHRCUmxWVVJFRHVKNk96?=
 =?utf-8?B?TEV0V0pwOVVaNkZQaWJsMkRWcjRTZzZFS21Nb0ZJV1FJOEpZbVI4ZU9rdFNZ?=
 =?utf-8?B?d2Z5b2ttaHUrblo1TXp3dGdNNXE5OG9SM3hhSFdPbzZ5NDBKaDZ2S0g5VjBY?=
 =?utf-8?Q?tlcYVP28XbOjG/diIB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0da4c2c-f552-4209-68af-08df3ee19923
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 04:17:57.0694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/UEnQY0WepaylSZLYFrn0wH31hy5rAeRhwcMKXJK9p9EH3PZ0qA0bhOMhKHc/bj6L4iWqbRCI1WIT0G7rVvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB127395
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matthew,

Do you have any objections to this fix? I think we can push this first, 
as it fixes the range-allocation path issue introduced by the base 
patch, “gpu/buddy: replace dual-tree/force_merge with decoupled dirty 
tracker.”

The work William and Sanjay are doing to improve alloc_range_bias() can 
come separately. This fix is also needed for CI to complete its runs and 
allows us to move these patches forward, as clients are waiting for this 
version in the next release.

Thanks,
Arun.

On 11/6/2026 4:36 PM, Arunpravin Paneer Selvam wrote:
> Hi Matthew,
>
> Both Sashiko findings on v4 are intentional - no code change:
>
> 1. Strict pass skips straddling free blocks: This is intended. If the 
> strict pass split a free block that crosses the range edge, part of it 
> would fall outside the range and get rejected, leaving the split 
> behind - and the strict pass has no way to merge it back. That was the 
> v3 leak, so we now skip such blocks instead of splitting them.
>
> The clear/dirty check ( block_incompatible() ) only looks at blocks 
> that fit entirely inside the range, so it keeps clear and dirty apart 
> correctly whenever such blocks exist. It is skipped in just one case: 
> when the only option is a single big free block crossing the range 
> edge. That happens when the area is still unused - nothing is 
> allocated in it yet - so there are no existing clear or dirty 
> allocations there that could get interleaved or broken up. The guard 
> has nothing to protect in that case, so skipping it does no harm. At 
> worst the fallback pass picks a block of the other class and it has to 
> be cleared again - a re-clear cost, not fragmentation.
>
> 2. Dropped clear-child preference for mixed blocks: On purpose. 
> Carrying that preference down through mixed blocks splits them to 
> carve out a same-class leaf, which interleaves allocated clear and 
> dirty blocks and regresses range allocations to  -ENOSPC . Taking the 
> mixed child whole strands nothing, and the wholly-clear sibling stays 
> free and usable, so the only cost is a possible re-clear.
>
>
>
> Why we don't steer  has_clear  splits in mixed blocks:
> Old dual-tree kept clear and dirty in separate pools (same-class-only 
> merge), so every split came from a pure pool and never stranded the 
> opposite class. The new design merges across classes into large MIXED 
> blocks, so class-aware steering had to keep splitting those big blocks 
> to carve out a same-class leaf - breaking contiguous space and leaving 
> allocations of the two classes mixed together, so freed blocks can't 
> reform a large run →  -ENOSPC . v4 drops steering: it still splits a 
> mixed block that's larger than the request (for size only, spatially, 
> no class bias) but takes the block whole once it reaches the requested 
> order instead of splitting further to isolate a same-class leaf. Using 
> only the block_incompatible  guard - which accepts or rejects a whole 
> block by class and never traverses inside a mixed block to pick a 
> clear/dirty child - it keeps large blocks intact and avoids the 
> interleaving.
>
> Could you please check and review the v4.
>
> Thanks,
> Arun.
>
> On 11/4/2026 12:58 PM, Arunpravin Paneer Selvam wrote:
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
>> v3: igt@kms_plane@plane-panning-bottom-right failed on Radeon RX 9070 XT
>>      with -ENOSPC: the range allocator's strict pass split mixed 
>> blocks to
>>      look for a wholly-clear (or wholly-dirty) leaf, discarded the mixed
>>      leaves it found, and ran unsplit_block to merge the splits back, 
>> whose
>>      per-allocation cost and residual fragmentation starved the large
>>      pipe-A scanout. Fix: accept a mixed block at the requested order 
>> as-is
>>      (caller re-clears), so the first pass no longer splits and discards
>>      mixed blocks. This clear/dirty compatibility relaxation applies 
>> only
>>      to range-biased allocation, where keeping blocks intact reduces
>>      fragmentation and preserves large contiguous spaces. The 
>> now-unneeded
>>      unsplit_block helper is dropped.
>>
>> v4: a higher-order free mixed block straddling the range edge was 
>> split in
>>      the strict pass then abandoned, leaving both children free under 
>> a split
>>      parent that never coalesces, tripping gpu_buddy_fini()'s 
>> free-root assert
>>      and leaking the children (reported by Sashiko). Fix: in the 
>> strict pass
>>      don't split a free block that only partially overlaps the range; 
>> the
>>      fallback pass consumes it (either class accepted).
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>> Assisted-by: LLM
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/buddy.c                | 83 ++++++++++++++++-------------
>>   drivers/gpu/tests/gpu_buddy_test.c | 84 ++++++++++++++++++++++++++++++
>>   2 files changed, 130 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 28cff97d57dc..d9749cbaf05d 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1240,11 +1240,23 @@ static void __gpu_buddy_undo_splits(struct 
>> gpu_buddy *mm,
>>       }
>>   }
>>   +static bool block_incompatible(struct gpu_buddy_block *block, 
>> unsigned int flags)
>> +{
>> +    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>> +
>> +    if (!gpu_buddy_block_is_free(block))
>> +        return false;
>> +
>> +    return needs_clear ? !block->has_clear :
>> +                 gpu_buddy_block_is_clear(block);
>> +}
>> +
>>   static struct gpu_buddy_block *
>>   __alloc_range_bias(struct gpu_buddy *mm,
>>              u64 start, u64 end,
>>              unsigned int order,
>> -           unsigned long flags)
>> +           unsigned long flags,
>> +           bool fallback)
>>   {
>>       u64 req_size = mm->chunk_size << order;
>>       struct gpu_buddy_block *block;
>> @@ -1258,9 +1270,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>        * This range-constrained search hands back the highest/right-most
>>        * address that satisfies the request: the roots are seeded 
>> high-to-low
>>        * and the right (higher-address) child is descended first, making
>> -     * top-down the default placement here. A non-top-down clear 
>> request is
>> -     * the only exception, where the descent is biased towards clear or
>> -     * clear-containing subtrees to satisfy the clear preference.
>> +     * top-down the default placement here.
>>        */
>>       for (i = mm->n_roots - 1; i >= 0; --i)
>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>> @@ -1296,8 +1306,19 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>               if (round_down(adjusted_end + 1, req_size) <=
>>                   round_up(adjusted_start, req_size))
>>                   continue;
>> +
>> +            /*
>> +             * Strict pass: don't split a partially-overlapping free
>> +             * block; rejecting its child would strand the split. Let
>> +             * the fallback pass consume it (either class accepted).
>> +             */
>> +            if (!fallback && gpu_buddy_block_is_free(block))
>> +                continue;
>>           }
>>   +        if (!fallback && block_incompatible(block, flags))
>> +            continue;
>> +
>>           if (contains(start, end, block_start, block_end) &&
>>               order == gpu_buddy_block_order(block)) {
>>               /*
>> @@ -1315,38 +1336,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   goto err_undo;
>>           }
>>   -        /*
>> -         * Top-down is a strict address-placement policy, so when it is
>> -         * requested we ignore clear steering and simply descend the
>> -         * right (higher-address) child first. Only a non-top-down 
>> clear
>> -         * request biases the descent towards clear/has_clear subtrees.
>> -         */
>> -        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>> -            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>> -            struct gpu_buddy_block *prefer;
>> -
>> -            if (gpu_buddy_block_is_clear(block->right))
>> -                prefer = block->right;
>> -            else if (gpu_buddy_block_is_clear(block->left))
>> -                prefer = block->left;
>> -            else if (block->right->has_clear)
>> -                prefer = block->right;
>> -            else if (block->left->has_clear)
>> -                prefer = block->left;
>> -            else
>> -                prefer = block->right;
>> -
>> -            if (prefer == block->right) {
>> -                list_add(&block->left->tmp_link, &dfs);
>> -                list_add(&block->right->tmp_link, &dfs);
>> -            } else {
>> -                list_add(&block->right->tmp_link, &dfs);
>> -                list_add(&block->left->tmp_link, &dfs);
>> -            }
>> -        } else {
>> -            list_add(&block->left->tmp_link, &dfs);
>> -            list_add(&block->right->tmp_link, &dfs);
>> -        }
>> +        list_add(&block->left->tmp_link, &dfs);
>> +        list_add(&block->right->tmp_link, &dfs);
>>       } while (1);
>>         return ERR_PTR(-ENOSPC);
>> @@ -1361,6 +1352,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>       return ERR_PTR(err);
>>   }
>>   +static struct gpu_buddy_block *
>> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>> +                 u64 start, u64 end,
>> +                 unsigned int order,
>> +                 unsigned long flags)
>> +{
>> +    struct gpu_buddy_block *block;
>> +    bool fallback = false;
>> +
>> +    block = __alloc_range_bias(mm, start, end, order,
>> +                   flags, fallback);
>> +    if (IS_ERR(block))
>> +        return __alloc_range_bias(mm, start, end, order,
>> +                      flags, !fallback);
>> +
>> +    return block;
>> +}
>> +
>>   /* Return the highest-address free block of at least @order. */
>>   static struct gpu_buddy_block *
>>   get_maxblock(struct gpu_buddy *mm,
>> @@ -1924,7 +1933,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>         if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>>           /* Allocate traversing within the range */
>> -        block = __alloc_range_bias(mm, start, end, order, flags);
>> +        block = __gpu_buddy_alloc_range_bias(mm, start, end, order, 
>> flags);
>>           if (!IS_ERR(block) || !steered)
>>               return block;
>>   diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>> b/drivers/gpu/tests/gpu_buddy_test.c
>> index 2c6f1da1a6d1..9aaca2fc6a02 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1606,6 +1606,89 @@ static int gpu_buddy_suite_init(struct 
>> kunit_suite *suite)
>>       return 0;
>>   }
>>   +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit 
>> *test)
>> +{
>> +    const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
>> +    struct gpu_buddy_block *block;
>> +    LIST_HEAD(low_dirty);
>> +    LIST_HEAD(high_a);
>> +    LIST_HEAD(high_b);
>> +    LIST_HEAD(barrier);
>> +    LIST_HEAD(dirty_res);
>> +    LIST_HEAD(clear_res);
>> +    struct gpu_buddy mm;
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>> +                   "buddy_init failed\n");
>> +
>> +    /*
>> +     * Idea is to lay out a range allocation as a low dirty block, an
>> +     * allocated barrier, and a high naturally-aligned clear extent, 
>> then
>> +     * issue a dirty range allocation. It must take the low dirty 
>> block and
>> +     * leave the clear extent intact; if it instead cuts the clear 
>> extent,
>> +     * a following same-class clear allocation can no longer find a
>> +     * contiguous clear run and fails with -ENOSPC.
>> +     *
>> +     *   [0,  1M)   dirty free
>> +     *   [1M, 2M)   allocated  (barrier, keeps the halves un-mergeable)
>> +     *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
>> +     */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
>> +                              &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [0, 1M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, 
>> chunk, chunk,
>> +                              &barrier, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [1M, 2M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, 
>> chunk, chunk,
>> +                              &high_a, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [2M, 3M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, 
>> chunk, chunk,
>> +                              &high_b, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [3M, 4M) failed\n");
>> +
>> +    /* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) 
>> stays dirty. */
>> +    gpu_buddy_free_list(&mm, &low_dirty, 0);
>> +    gpu_buddy_free_list(&mm, &high_a, GPU_BUDDY_CLEARED);
>> +    gpu_buddy_free_list(&mm, &high_b, GPU_BUDDY_CLEARED);
>> +
>> +    /* Dirty 1 MiB range alloc: must land at [0, 1M), not cut the 
>> clear extent. */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, 
>> chunk,
>> +                              &dirty_res, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "dirty range alloc failed\n");
>> +    block = list_first_entry(&dirty_res, struct gpu_buddy_block, link);
>> +    KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
>> +                   "dirty range alloc cut the clear extent 
>> (offset=%llx)\n",
>> +                   gpu_buddy_block_offset(block));
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), 0ULL);
>> +
>> +    /*
>> +     * The 2 MiB clear extent must still be intact: a clear order-1 
>> range
>> +     * allocation has to succeed. Without the guard the extent was cut
>> +     * above and this returns -ENOSPC.
>> +     */
>> +    KUNIT_EXPECT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, 2 * 
>> chunk, 2 * chunk,
>> +                              &clear_res,
>> +                              GPU_BUDDY_RANGE_ALLOCATION |
>> +                              GPU_BUDDY_CLEAR_ALLOCATION),
>> +                   "clear 2M range alloc failed: clear extent was 
>> fragmented (-ENOSPC)\n");
>> +    if (!list_empty(&clear_res)) {
>> +        block = list_first_entry(&clear_res, struct gpu_buddy_block, 
>> link);
>> +        KUNIT_EXPECT_TRUE(test, gpu_buddy_block_is_clear(block));
>> +        KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)(2 
>> * chunk));
>> +    }
>> +
>> +    gpu_buddy_free_list(&mm, &clear_res, GPU_BUDDY_CLEARED);
>> +    gpu_buddy_free_list(&mm, &dirty_res, 0);
>> +    gpu_buddy_free_list(&mm, &barrier, 0);
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>>   static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_limit),
>>       KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
>> @@ -1615,6 +1698,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>>       KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>>       KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>>       KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>
>> base-commit: 49f40f15d20f5b4073d517da7efbcea079f1b9e3
>

