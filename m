Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAF606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BhxS8omX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D78112CCF;
	Fri,  6 Nov 2026 11:06:47 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B179010E9E2;
 Fri,  6 Nov 2026 11:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moAbWYtlfO5ytdzUN3JmlTL0T7N5/L6oU6/iIbmECiFAFdYNO18ZhtE2vBNOB48NgtALcUWRQxOr/9o8P07zCXmRwfRoOsPNFAhLYXdmR7G0V1+RDx/AJQUUE5f8Zpxu6xFRJfS+XcJSgZ7QYhGuBvBNyEuO+AiGobwoaO3iqjej2rVBDLvAJkBOTxUbLUB7fsOrxmEWb64swf2h2DO74WhrqV2N/8A6sSvWRBw5Ksf0ZthYYS/HNvcB/DtU9MVuRrz6boms0wptwzWgEnQzpkkoeHn5mEj4EiqaYd4RP2jPEMvaNLo5FrRHH9Fos4qk9JVwwdmCRp/bsMxuGkQv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeEqfVBbNMru3ShM/nHdSCFaOD0WJMoh5N1Gth8iPls=;
 b=mKnSMc2tzeA5b5+1vVFfTNPY263uWdQyMU918hNnIFDTQZP28gjv8bHe9h06yLB9pTUpqT5zwjw1rgZcqlxFkNEQBrj5Ricq/dn7ziv0Z2c9sbqNfp2EoWQeFuAlXvJUTuzMDog8Ka8w87cBS9tCPK3a0MDl0YbGqxC4bREpsbh0ziEisyYy8K4ktVoLA4gMf7FCsMk67IvYV0ypclOavjPcnq4cTdhezzDLbliT7oR/UvIJSJQwHwAgMmE76LJhqmnwoeeB72taqv8nUwsxd1pLWmWDTbxJCntoj6OFIR1X3b5qVHoqh9xoW1DNOXk5HY8m9pZB2WdbPS7/u255gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeEqfVBbNMru3ShM/nHdSCFaOD0WJMoh5N1Gth8iPls=;
 b=BhxS8omXOtW6mTG983sLM02NpmCdHNJH2BoNUTqSk57rFxM3Up6sAAYCc2rQWvJAvUIs3B6ycwsxNWH6sZt5u9c7jfizrHGsXyAql2SScaMihsfShpK4GP18ZUUH17K/j9rKwvzZUnpZwp07aFDbbR61jkFP2WZXxTcT9gC9JiE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 6 Nov 2026
 11:06:31 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:06:31 +0000
Message-ID: <bc02f8db-8d1f-41b5-b930-c5d46151db73@amd.com>
Date: Fri, 6 Nov 2026 16:36:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: matthew.auld@intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::6) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9be644-40b1-41ff-103d-08df3bf6031f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|261102123227099003|18002099003|56012099006|261021123027099003|261022075727099003|261021121427099003|261022105027099003|11063799006|261026121527099003|5023799004|261009223027099003|261028144727099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: C7XXmGBdkZjom5G5BkknwxLLwJaVF9tqofyyIqz1UyJu52oqQe5tsIPyaNNDcGjl6avEz/PWgIGeYzuXzkva89KQ+KIdir2eSQxe3/y4oSjJLI0PWD8bgZkB5SET/400sTihyAfDdpgRUGe8kuCIs2U6o/4cWo55WheOMoUgV5qPbv0+KFwIiHWWeXPaHn/BVT57hB4kietdWQlveEXw585I9D3opUN2sZkAM4/414R0F58YRCNjBsOGp9geF7qaM6boDJDAOj9x+XEodHtzv1JAcSBKPjW1YKYrEUfw4BHr4G9LbV1QUT6t0Rq68zO7Gnlu08qRVA7T5p8A0SVSGf9VsDsOxHqLBTDP5efqe6AeKUT1LRXrqqbdPCDoZzG7zDXVGp2ldvrjY26kpQnRzS/UNog9GG8xJColomkx6d/55IvWye6dGufmdmlH8AHzzoYFMCw6q37GpVRSj6ADLmCNpml1DDpEPnbEVuUcVrYdhPgffPExPCbHlUVaSZLGWWLBC/+Z620FgKLk+RQi3h8YZ3vffU5gmAMbDXESn1rLLV+hOQKd5ZZQNw7n0r8SOdzd+v9eNVUTihADHgyZihfDwMBS+g7KduVcysHI1D3x/n0xKvdOgBb0r1IGUbs1EBGaQpbTqZ8O/QQkG3RIoqBFD3v+097Mw1WBuf3+zi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(261102123227099003)(18002099003)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(5023799004)(261009223027099003)(261028144727099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpQcEU2SnRIeWxmYUN4cE54MEdGZWtlM3E1eW56K1NiN3BYNElvZUhaNHJL?=
 =?utf-8?B?c3Rha0RSV1JDK011WW1VVFNyTWdyYmx6WXNwTjdDQ3BZTm9NUVVSWXcvTGJ0?=
 =?utf-8?B?TS9NS1RSVWVLclNmMmhEazBUUlJuSkdnMmFyN1FpTHFEQnc2UUk2YnpCVGdn?=
 =?utf-8?B?c2tOL2tyaVd4cVF0SGdac2VSblI2NjI4ODE1bCttMXkwRlFMSitONUo5eDN3?=
 =?utf-8?B?bndsL2lUSTg1aVpDUHFwYnF1OEsrcUR6TE1tdDdsS0M1MG16OGZBOTBKV216?=
 =?utf-8?B?YnJwMk02OEZRRzY2OGQ0L0ZNTm5CZzc5VTdrS0w5NjV2RG9JWlgrN2M1cmNF?=
 =?utf-8?B?ci84QXNpVFZNaDE4eURPWmdiQXMxU1pKVVZEZ2hLaDVDaVpab1kxc2tTcDRa?=
 =?utf-8?B?R05qVHlVOEk2K2JNUVVsRGhFMFpmbnRycFVRSGhRNzU5Wk4vZnppaXREaU54?=
 =?utf-8?B?VVB3RVg1dHJvcGVGMG5sSmxIZDZtalRkRXhaOW5ZdENhZXdGN3l4bjk4aGV2?=
 =?utf-8?B?Q01jYWtlYThFTDlpOHVvMDFpbEFBVStaZU02dW94YjBLOXAvZG1QOUtnTHVG?=
 =?utf-8?B?NXdaRHcvT3RQNkNVbDZ6UHZkVFgzdC94cE9kMFV6akxobk40ZWlIem1Wd2Ro?=
 =?utf-8?B?eUlhRWRLUG53ODhlRUx1ZmZ1aU10OTNlQ3FBdVV1UU1rd3BJZUJqM2tQb0dq?=
 =?utf-8?B?S0hhZXo2Y1dCTFF5Yy91UTl1OXE1Skw4VFh0SVFPMm9FV0dvYVZWM3kyNWhO?=
 =?utf-8?B?QUNaK3F5UDVqSi9JZ3BwZVJ3T2hrMlc1bGQxYWd6ejg1ZWNHQ3FKbmMzT3lV?=
 =?utf-8?B?cFIxTFlkQzhSS004M3ZSUVpqQ29pQUQ1SmkwcklpOHg0cXZxYTMwQk9EZHlF?=
 =?utf-8?B?SHc4OEo3TDR1anFqT1QzS3hwSjVacis3YzNBalExMGk5V1k4RlAzWTF0N1lU?=
 =?utf-8?B?MXB0d0NmM0d0cU5WL2FORzJoWGQ3cll3dkg0N2pBc3c2SDI2NXY3RU5RZUhx?=
 =?utf-8?B?QkJXNFAvQjZuUHFhcUVLQTN4VXpYa0QzS0pzcHRaajU5ZEJXODRtMlJqc3pG?=
 =?utf-8?B?cUJMT0IyQkJnZHdYT2ZDc01tSTlVT1RvbWZDR0ZmZlJlLzBmUDZkbTEvYnFW?=
 =?utf-8?B?dGJSTi9KS1VYVmo0TlYrVGZzWGswcVYraTV6YmE2VnpDbkVOUVJLanp1NG1m?=
 =?utf-8?B?WlNpcHFWa3lKVFlVK1lPZ2xJVTN0Q0xQZU1nTUhuVnkzK2d0T3FDcmYyQVV0?=
 =?utf-8?B?cGsrajg2eEJVbWJSQ0V0ZjVKcjhDVlY5UGI1QXBidlAyajZGOHhCNnhTNmpK?=
 =?utf-8?B?c3BrNDcxVDdvSk1ZZlpDT1QwZ05VcExDQXB2NTJ4RGEwVFBZWXFqZ21MdHFU?=
 =?utf-8?B?WkdRS3RXWGlzZkZtMUlsY1cwdEFnRW9La1FoYlJnZytLL0FmVU0wRlNMN2gv?=
 =?utf-8?B?ckNrZ2ZZRmppQmpwY3hTUkluc3Vsc3F0cGhHNkZKc2QxU2sybGJzS25LOU9Z?=
 =?utf-8?B?RDdwd3l2RGE5WUhyUFpoMGlXZEd1dnMyaUsyRkR3d0FlQ1czTjlqMDBZUnpB?=
 =?utf-8?B?aFlMTEJzWnBjT1Z2RHVnc012U2swWGdPLzRhd0RNZndGdHRPQnNZYnNtU20y?=
 =?utf-8?B?TFllVjZlWE1sVllhaCtRdjgxd1lhM2tUcGNTWi9uWlJodmZwN291YkNmUkJK?=
 =?utf-8?B?aktHTWs3bWozS2I5UUMrbjYxS1IvajRsaDJPTGpDSk55TldidHhmb20zZ3F6?=
 =?utf-8?B?TWZJbzlJL0NXU0QxZFh4N2dnLzlKdEZadWl0MG9QWnNwQjVTVGdhZWVQUFhm?=
 =?utf-8?B?dmk5OEJqY1c4VWdzdWFWb0J4dTRxU0VIU2dTRVpPUWRNblFzV1U3MitXNk9H?=
 =?utf-8?B?SHZCV2ZoZnRLVGJFRUpUM0UyMHlCNW5CdlJmbGZhVEc0UjJxcFJJWW0zRFFE?=
 =?utf-8?B?UjN2NmpNUzdGcy9qQzNvN2Z6bm0zWThnWTloODR5SjdjNnU5MlUvbFdhZThw?=
 =?utf-8?B?dVJMVmJwOE15TXZOb0puNHVmV2Ivd2p4Qmd6RGttR3gwbnphQzJMVm41cE5m?=
 =?utf-8?B?aklidjFXV01JM0xkZUh3MlJNVnFpR284aDIxZVVHUEUxKzh4QXIwR0dKUGt0?=
 =?utf-8?B?Sm5pcnRscVlDWDhhV2JuOVVzVTFEeHhGeUcvc21XQmNRRGJGNlArRVg0YU9Y?=
 =?utf-8?B?UjNNMnJvT2ZaTGltL2dQTWdRTTR5YjBhR2ZpdjdSZi9mbW5PVnZ5TU5uRXIz?=
 =?utf-8?B?SXdZSnlzVHhBVXltL2JNOHY0R2Yzek44VDBZYmdESElKY0o5SkZuMHpkUEtj?=
 =?utf-8?Q?B6MNVlg+tIh1+XlmdC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9be644-40b1-41ff-103d-08df3bf6031f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:06:31.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P32C9bTeR/5MDzZqsmxPwms9vRUmh/efw0rteQbdOf25yRYihsIrJH/d3ZMeJCKtJOTvx2veTt6MeJPFjKRlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6
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

Both Sashiko findings on v4 are intentional - no code change:

1. Strict pass skips straddling free blocks: This is intended. If the 
strict pass split a free block that crosses the range edge, part of it 
would fall outside the range and get rejected, leaving the split behind 
- and the strict pass has no way to merge it back. That was the v3 leak, 
so we now skip such blocks instead of splitting them.

The clear/dirty check ( block_incompatible() ) only looks at blocks that 
fit entirely inside the range, so it keeps clear and dirty apart 
correctly whenever such blocks exist. It is skipped in just one case: 
when the only option is a single big free block crossing the range edge. 
That happens when the area is still unused - nothing is allocated in it 
yet - so there are no existing clear or dirty allocations there that 
could get interleaved or broken up. The guard has nothing to protect in 
that case, so skipping it does no harm. At worst the fallback pass picks 
a block of the other class and it has to be cleared again - a re-clear 
cost, not fragmentation.

2. Dropped clear-child preference for mixed blocks: On purpose. Carrying 
that preference down through mixed blocks splits them to carve out a 
same-class leaf, which interleaves allocated clear and dirty blocks and 
regresses range allocations to  -ENOSPC . Taking the mixed child whole 
strands nothing, and the wholly-clear sibling stays free and usable, so 
the only cost is a possible re-clear.



Why we don't steer  has_clear  splits in mixed blocks:
Old dual-tree kept clear and dirty in separate pools (same-class-only 
merge), so every split came from a pure pool and never stranded the 
opposite class. The new design merges across classes into large MIXED 
blocks, so class-aware steering had to keep splitting those big blocks 
to carve out a same-class leaf - breaking contiguous space and leaving 
allocations of the two classes mixed together, so freed blocks can't 
reform a large run →  -ENOSPC . v4 drops steering: it still splits a 
mixed block that's larger than the request (for size only, spatially, no 
class bias) but takes the block whole once it reaches the requested 
order instead of splitting further to isolate a same-class leaf. Using 
only the block_incompatible  guard - which accepts or rejects a whole 
block by class and never traverses inside a mixed block to pick a 
clear/dirty child - it keeps large blocks intact and avoids the 
interleaving.

Could you please check and review the v4.

Thanks,
Arun.

On 11/4/2026 12:58 PM, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Range-restricted allocations (the visible-VRAM aperture) skip
> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
> eligibility guard, so a dirty allocation freely splits clear extents (and
> vice versa), interleaving the two classes until no large same-class run
> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
> search instead: block_incompatible() rejects opposite-class blocks in the
> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
> request still succeeds when only opposite-class space remains. A KUnit
> regression test covers the interleaving pattern and fails without the
> guard.
>
> v2: the strict pass can split a block and then reject both children, so
>      a split no longer implies a compatible block exists. Sashiko reported
>      the resulting leaked splits; fix as suggested by Matthew:
>   - Push the parent back on the DFS stack after each split and merge it
>     back with unsplit_block() if both children are still free.
>   - Make block_incompatible() judge free blocks only (split nodes keep a
>     stale clear bit) and take the requested order, so mixed blocks that
>     can hold a compatible block are descended instead of skipped.
>   - Extend the KUnit test with a coalesced mixed block and a check that
>     a rejected split is merged back.
>
> v3: igt@kms_plane@plane-panning-bottom-right failed on Radeon RX 9070 XT
>      with -ENOSPC: the range allocator's strict pass split mixed blocks to
>      look for a wholly-clear (or wholly-dirty) leaf, discarded the mixed
>      leaves it found, and ran unsplit_block to merge the splits back, whose
>      per-allocation cost and residual fragmentation starved the large
>      pipe-A scanout. Fix: accept a mixed block at the requested order as-is
>      (caller re-clears), so the first pass no longer splits and discards
>      mixed blocks. This clear/dirty compatibility relaxation applies only
>      to range-biased allocation, where keeping blocks intact reduces
>      fragmentation and preserves large contiguous spaces. The now-unneeded
>      unsplit_block helper is dropped.
>
> v4: a higher-order free mixed block straddling the range edge was split in
>      the strict pass then abandoned, leaving both children free under a split
>      parent that never coalesces, tripping gpu_buddy_fini()'s free-root assert
>      and leaking the children (reported by Sashiko). Fix: in the strict pass
>      don't split a free block that only partially overlaps the range; the
>      fallback pass consumes it (either class accepted).
>
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
> Assisted-by: LLM
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c                | 83 ++++++++++++++++-------------
>   drivers/gpu/tests/gpu_buddy_test.c | 84 ++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 28cff97d57dc..d9749cbaf05d 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1240,11 +1240,23 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
>   	}
>   }
>   
> +static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags)
> +{
> +	bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +	if (!gpu_buddy_block_is_free(block))
> +		return false;
> +
> +	return needs_clear ? !block->has_clear :
> +			     gpu_buddy_block_is_clear(block);
> +}
> +
>   static struct gpu_buddy_block *
>   __alloc_range_bias(struct gpu_buddy *mm,
>   		   u64 start, u64 end,
>   		   unsigned int order,
> -		   unsigned long flags)
> +		   unsigned long flags,
> +		   bool fallback)
>   {
>   	u64 req_size = mm->chunk_size << order;
>   	struct gpu_buddy_block *block;
> @@ -1258,9 +1270,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	 * This range-constrained search hands back the highest/right-most
>   	 * address that satisfies the request: the roots are seeded high-to-low
>   	 * and the right (higher-address) child is descended first, making
> -	 * top-down the default placement here. A non-top-down clear request is
> -	 * the only exception, where the descent is biased towards clear or
> -	 * clear-containing subtrees to satisfy the clear preference.
> +	 * top-down the default placement here.
>   	 */
>   	for (i = mm->n_roots - 1; i >= 0; --i)
>   		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> @@ -1296,8 +1306,19 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   			if (round_down(adjusted_end + 1, req_size) <=
>   			    round_up(adjusted_start, req_size))
>   				continue;
> +
> +			/*
> +			 * Strict pass: don't split a partially-overlapping free
> +			 * block; rejecting its child would strand the split. Let
> +			 * the fallback pass consume it (either class accepted).
> +			 */
> +			if (!fallback && gpu_buddy_block_is_free(block))
> +				continue;
>   		}
>   
> +		if (!fallback && block_incompatible(block, flags))
> +			continue;
> +
>   		if (contains(start, end, block_start, block_end) &&
>   		    order == gpu_buddy_block_order(block)) {
>   			/*
> @@ -1315,38 +1336,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   				goto err_undo;
>   		}
>   
> -		/*
> -		 * Top-down is a strict address-placement policy, so when it is
> -		 * requested we ignore clear steering and simply descend the
> -		 * right (higher-address) child first. Only a non-top-down clear
> -		 * request biases the descent towards clear/has_clear subtrees.
> -		 */
> -		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
> -		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
> -			struct gpu_buddy_block *prefer;
> -
> -			if (gpu_buddy_block_is_clear(block->right))
> -				prefer = block->right;
> -			else if (gpu_buddy_block_is_clear(block->left))
> -				prefer = block->left;
> -			else if (block->right->has_clear)
> -				prefer = block->right;
> -			else if (block->left->has_clear)
> -				prefer = block->left;
> -			else
> -				prefer = block->right;
> -
> -			if (prefer == block->right) {
> -				list_add(&block->left->tmp_link, &dfs);
> -				list_add(&block->right->tmp_link, &dfs);
> -			} else {
> -				list_add(&block->right->tmp_link, &dfs);
> -				list_add(&block->left->tmp_link, &dfs);
> -			}
> -		} else {
> -			list_add(&block->left->tmp_link, &dfs);
> -			list_add(&block->right->tmp_link, &dfs);
> -		}
> +		list_add(&block->left->tmp_link, &dfs);
> +		list_add(&block->right->tmp_link, &dfs);
>   	} while (1);
>   
>   	return ERR_PTR(-ENOSPC);
> @@ -1361,6 +1352,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	return ERR_PTR(err);
>   }
>   
> +static struct gpu_buddy_block *
> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
> +			     u64 start, u64 end,
> +			     unsigned int order,
> +			     unsigned long flags)
> +{
> +	struct gpu_buddy_block *block;
> +	bool fallback = false;
> +
> +	block = __alloc_range_bias(mm, start, end, order,
> +				   flags, fallback);
> +	if (IS_ERR(block))
> +		return __alloc_range_bias(mm, start, end, order,
> +					  flags, !fallback);
> +
> +	return block;
> +}
> +
>   /* Return the highest-address free block of at least @order. */
>   static struct gpu_buddy_block *
>   get_maxblock(struct gpu_buddy *mm,
> @@ -1924,7 +1933,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   
>   	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>   		/* Allocate traversing within the range */
> -		block = __alloc_range_bias(mm, start, end, order, flags);
> +		block = __gpu_buddy_alloc_range_bias(mm, start, end, order, flags);
>   		if (!IS_ERR(block) || !steered)
>   			return block;
>   
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index 2c6f1da1a6d1..9aaca2fc6a02 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1606,6 +1606,89 @@ static int gpu_buddy_suite_init(struct kunit_suite *suite)
>   	return 0;
>   }
>   
> +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
> +{
> +	const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
> +	struct gpu_buddy_block *block;
> +	LIST_HEAD(low_dirty);
> +	LIST_HEAD(high_a);
> +	LIST_HEAD(high_b);
> +	LIST_HEAD(barrier);
> +	LIST_HEAD(dirty_res);
> +	LIST_HEAD(clear_res);
> +	struct gpu_buddy mm;
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
> +			       "buddy_init failed\n");
> +
> +	/*
> +	 * Idea is to lay out a range allocation as a low dirty block, an
> +	 * allocated barrier, and a high naturally-aligned clear extent, then
> +	 * issue a dirty range allocation. It must take the low dirty block and
> +	 * leave the clear extent intact; if it instead cuts the clear extent,
> +	 * a following same-class clear allocation can no longer find a
> +	 * contiguous clear run and fails with -ENOSPC.
> +	 *
> +	 *   [0,  1M)   dirty free
> +	 *   [1M, 2M)   allocated  (barrier, keeps the halves un-mergeable)
> +	 *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
> +						      &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [0, 1M) failed\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, chunk, chunk,
> +						      &barrier, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [1M, 2M) failed\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, chunk, chunk,
> +						      &high_a, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [2M, 3M) failed\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, chunk, chunk,
> +						      &high_b, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [3M, 4M) failed\n");
> +
> +	/* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) stays dirty. */
> +	gpu_buddy_free_list(&mm, &low_dirty, 0);
> +	gpu_buddy_free_list(&mm, &high_a, GPU_BUDDY_CLEARED);
> +	gpu_buddy_free_list(&mm, &high_b, GPU_BUDDY_CLEARED);
> +
> +	/* Dirty 1 MiB range alloc: must land at [0, 1M), not cut the clear extent. */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
> +						      &dirty_res, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "dirty range alloc failed\n");
> +	block = list_first_entry(&dirty_res, struct gpu_buddy_block, link);
> +	KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
> +			       "dirty range alloc cut the clear extent (offset=%llx)\n",
> +			       gpu_buddy_block_offset(block));
> +	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), 0ULL);
> +
> +	/*
> +	 * The 2 MiB clear extent must still be intact: a clear order-1 range
> +	 * allocation has to succeed. Without the guard the extent was cut
> +	 * above and this returns -ENOSPC.
> +	 */
> +	KUNIT_EXPECT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, 2 * chunk, 2 * chunk,
> +						      &clear_res,
> +						      GPU_BUDDY_RANGE_ALLOCATION |
> +						      GPU_BUDDY_CLEAR_ALLOCATION),
> +			       "clear 2M range alloc failed: clear extent was fragmented (-ENOSPC)\n");
> +	if (!list_empty(&clear_res)) {
> +		block = list_first_entry(&clear_res, struct gpu_buddy_block, link);
> +		KUNIT_EXPECT_TRUE(test, gpu_buddy_block_is_clear(block));
> +		KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)(2 * chunk));
> +	}
> +
> +	gpu_buddy_free_list(&mm, &clear_res, GPU_BUDDY_CLEARED);
> +	gpu_buddy_free_list(&mm, &dirty_res, 0);
> +	gpu_buddy_free_list(&mm, &barrier, 0);
> +	gpu_buddy_fini(&mm);
> +}
> +
>   static struct kunit_case gpu_buddy_tests[] = {
>   	KUNIT_CASE(gpu_test_buddy_alloc_limit),
>   	KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
> @@ -1615,6 +1698,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>   	KUNIT_CASE(gpu_test_buddy_alloc_clear),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
> +	KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>   	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>   	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>   	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>
> base-commit: 49f40f15d20f5b4073d517da7efbcea079f1b9e3

