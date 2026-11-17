Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qPjakPZV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C74410E515;
	Tue, 17 Nov 2026 07:04:47 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F38510E50F;
 Tue, 17 Nov 2026 07:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm2NHBO+vy/bnYsI/bsZS6DYA27AGmOQUCwwDRFGLBAO+AtOGgi7KEbENjxrM+GJkLszsEmAmLEULJPEHXW1nYID2JKwTHhIhNcyvSCBmDpQ9R9gpJWkkTlS6chJGrUejQv6+CWMYD+txQWg83/t48fZTQ+NwaTHVl8xnG+FrnEDTjBPYAmZ33iMBot1Ggno0dP6TCd+PhJzBidKOAJGgKsJZ+WQtuYz9TwnBMatWI+T98J968oHWa+tGSe/LP/qRDOwFOLKqC8AqeEyn8dahYWUNc0KhjPjNrFymSMDHwTEZ/+uOxCxGwtLsIO15rgQAslanUy40LQUtiw0zwGvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/wDtw+RiI2huSEAkJOnTTxeJOEqJKMJc3TBhKbImgA=;
 b=VhuOt/4m6VQSPq6t8dMXsKQe1TbqVjvfRJ930gIgyi/v0Cs2+HM/YipR2N8HI08gH/fFDjSwJ772goYxYmN7QtyuYKX9sRPxSYwfEVGBJviodMfteKzjkRgnW9vdRCrPMsyYmgPe/e8ewd5LqF1VJpE/JJRgGzVogLutyvQR3/UqWddi10g4Fapx8u/iEvkcc1mpglWQkC6CvSpFGbo+KB2tefPhY+jWE38rZ6uP0o84yCKdgQ9zb9adeSq6YUSdQ4mlPZda+pJX+TRa7znaF+VKJGPqVUdNaBoWUG6SFrJJoUhOe5+/oZx4+qmWKhh2Dx9vaJFteo+6Aj+417AlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/wDtw+RiI2huSEAkJOnTTxeJOEqJKMJc3TBhKbImgA=;
 b=qPjakPZVOIWoRbaeU25jL2tx3mduo/ZH+xQsfe7rxYFBTMCc2mkKoMi955aLZM0W0HBXGeuAfWdXpNzfJys1+dxPDZyeboBml1LST8lWNmKR+j6xNZxJCB+zvsYEjvhvV8Bg0WscVwl+6ROeEffHZ6lNmRhvn+9rI14Js6o0bPw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 07:04:35 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:04:35 +0000
Message-ID: <dbd71a1f-b9ac-4276-bb0d-eb6852ee63b9@amd.com>
Date: Tue, 17 Nov 2026 12:34:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] gpu/buddy: find range-biased blocks in the free
 trees
To: William Palacek <William.Palacek@amd.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
References: <cover.1794845083.git.William.Palacek@amd.com>
 <17f2a6366ba845edc799dbeb712c12f8d060afad.1794845083.git.William.Palacek@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <17f2a6366ba845edc799dbeb712c12f8d060afad.1794845083.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::15) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: eca3a0ee-5601-41f4-0f25-08df44790966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|261009223027099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: RNLpXgERSi6Roks9aXP53iyBHW1nCa7U4EynZV7c5vvPt4Tp2Icxb5tecruwa8VguKPBYzNhhhtNDC0LtF+ipeLmzHLQN0OfPux/HyHIkSkfmYyItk8CL+HoS69D57QNFb0I9/0yt2tv3fR30bxoGGIKnyus+GCKaIgRXqvNu3/Ns3HrSiTAvBaawDS8a7GEkeFFzHMiXmcTZuw2hEl2F1Fqt+fTnuiLq7MkycAQLwhIJ9NKEmoQ33T/p73lNjX2K6GFso8mTuTlhr1vAFVPs+8ttEs6oz+cze+UT3xw9HY8XETMjWj0ajaByD6Gycyw09zMB5swt8i0m7ECIpdAVW0VEE7O+e5WsG1hbesKrjaNDsqCWp1TcP8oblMTl3lhQiepFq3SsYCQCUB5kr2JRxxAPUPCYSrZ3fRcC/RShHntHIRfBRFtZxgw1rzq0G+LqJtq7Q6bRJjImN1/jsfrHnv1Qq14EGVOEFnCns2lP5yMHnFu3aZzAFaxuh8ngaWvxD1lMwNQb8VXs8vAYG2vAVINafh0ZlxZKWn3maOcGhttTbBsFFSCVKaL1914fqhFQbd59/usdoWXHPGUtI2AjCpx5WmoH0owpl3cSig0bi8px+1rDHmPifdtX8QpmFlhIhmIoahzjAd6zhjOa8FPm2L3jgdFoBhb1Ex0morQWjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXl0RnBWWkNQWUdhcC9xQ1hBK296RlE4Vi96M3ZlZ3duaEdZSkE0YzR1T0lY?=
 =?utf-8?B?TWVyTzJzRVVROTdXNVM5YXVOb1VmZCttN0JjUFJHMmU1bnJBM2ZMZ0dpdDlN?=
 =?utf-8?B?MjZRenlEZkF0Nk5vTmplcXJYaTViYmxCbzhUMTQyTDVKSGtQZE5lWW1DbjlM?=
 =?utf-8?B?UjNOTHlKM0EzenQyZkJwcE1ZTXgzMWN5WDNwSlVFOW05WGcvSDZJTFpRT1hD?=
 =?utf-8?B?QmxseWNuakV6Z1JkTHFJcGtBeTdEUlpBaXl1R0I0RGtwVkd4TjdwTThWYzN6?=
 =?utf-8?B?dk0zOFcwdnpBVHBIN0FHdUx5Z015WitBT013b2NKdVpyaExLaUFWMDZEUkdP?=
 =?utf-8?B?aDJEcUpFV2R4NDdCZEV1ald6Z2hHZU9qUnNmd1lVU0IzUDhrL3hKQU4wdnNq?=
 =?utf-8?B?RDlQU2JSakhIbWswOXhZekgxSmdoamV6Zy9YSTR2d3djSkNzRWNmMXFLTkNJ?=
 =?utf-8?B?cjdtNmhtMEtmWEhvZmJWR3RDclQ4MkM3dTVsMS9FU0RxSzJvZTNFMWRyUzZj?=
 =?utf-8?B?Z1oyeEdpbXVoZnY2ZlRqNFA4NmFQOXVEaVd4RjA0RGhvcGV5L3k4aHpxWDhn?=
 =?utf-8?B?VTRLaFJRYmpWS1BTdFU5REgyTm9SKzJSNFY3QXJYYnArS0hMWUlhaHhvTy8v?=
 =?utf-8?B?ZUFxYXpzY2ppMXg0eVo3SnFGSHlML3FBSEVsL0tFOW4wZG00SExaeHRmZk4y?=
 =?utf-8?B?elBFbERRZ1RrazA3UStFdXJqbGtYQ0g0QVB4QXNMR0diTzlkd1BnelFucWV6?=
 =?utf-8?B?ZjZTRFhmR1hMUEp6aUVRNFplUkF3L2k1Tk5qaHpzVG9SMVhMNVFYOWZ3TDRE?=
 =?utf-8?B?NGdKdE1VVENNeXJpcDUrRExjRjdlTkp3Y01FTHROaEJDaUR1dSt1VDA3N2lw?=
 =?utf-8?B?cHg1eGJFOTltZEExcUlLMk9abktJRDI1N1ZjbFkzdnVrT0huaHVmTC9qSnFo?=
 =?utf-8?B?QkF5STFZM0tTS29EeUFmeWpEYW1DUm9tZm5zYkJTNUtaalhEN3ZwR0VacDFs?=
 =?utf-8?B?MnJESWZ3Q0NLeTJlb2RRZ3hYN05JeUowUHoyVEtXbGxNU01RdHllUm0reGRL?=
 =?utf-8?B?YU80OFRmclByLzliMGgwRzZ4L083RmkwZU9xVDVuSTVMWnBobGp4Q0dCVGxV?=
 =?utf-8?B?M3BCSlVLSHNBUzJHb1ZiMDRLU1B1d1pKd3JQUUFFMXlRVEVxVzZYdWhXL21R?=
 =?utf-8?B?aDhwSy93NWxaM3JJYkJnU08wR1JuLzV4MXd5Nnc0bklINlVaWXZ5L3djV3ZJ?=
 =?utf-8?B?THVZbWpLWEhNK0daRzVSU2I2YzdzeE5LV0NOWkMzSDg4aVp3Tm1PMDM1alJ0?=
 =?utf-8?B?ZUl5NzJBN2hVMy8vSDZ2NnFleEw1L25pR0YzZ3ZWSUJTOUpJY1VISHo2cjAz?=
 =?utf-8?B?KzMzZTdCTHZ3YjRrTG1TTVY2WE4ycjd5QWRlMW9jNmdNQzRRbEZOT1J4eHZT?=
 =?utf-8?B?a3pWS08rdnA2RXpXRGZMSlVOQUoyeEUzb2dwWEJTaHFBbS9jbkllVFBMTUts?=
 =?utf-8?B?MVZqcmkrMDB4SVNQR0t1dnY4eWhBQzhaOVc1Z3g0QjFjZGVPck9Ndy96dEVr?=
 =?utf-8?B?ZXBhR00rME1Rd1lxSG1zc2ZpVVM0YUl2bkZXTUJhZ2IwTXRyWmdLRkVsTEpo?=
 =?utf-8?B?c0U2anJFZFFFbnd4THhiMitoVFdFYTVDZ1lwN0dIdHVMUXFvNTZndkVwbEY3?=
 =?utf-8?B?VCt5bWZrbHBIQ0hIMGk0RDdMaVJpZGJWZXhobmVHRUhLK1lFMUF4ZU9MTkRu?=
 =?utf-8?B?VkIvZU1hTU9tR2tXU2szUk1JekJxRUVZYzRQbElNb3J1YXczQTI5T1ovK29r?=
 =?utf-8?B?YzNBdGIvS3BrUjlsbzh4VFFtTmxKS2hOTkh3MEJnakhsSXhkT05aN3pWWmRj?=
 =?utf-8?B?ei9KY2pzQk0ydXRvWERuZnFEcXp2dnk0WE5zQnBvNE5jZkwyQ2NOOUdYRE05?=
 =?utf-8?B?UXgrREZFRVRVaVJaRzZ5cktNa2tuL2tpRWlRK2hVNXVicTFXUnZZZElQOWpn?=
 =?utf-8?B?QXVVUTVleU9xb3pCZlBmajg5ZVJVbkJPTGo2cXhoU3ZmZnVJdHdMVlRHM0h3?=
 =?utf-8?B?ZlR6M1NnZ3pUOUhkWHBjbVk0Ky9qUm0wMlRNOVEybENnNEh2MlU0MDEwUCs1?=
 =?utf-8?B?UXRQN0FpeTJiMTJwUlVIT3J4VGYwSmtkWkJUYm1ZY1lOZ2tUTXkxQStzWVNy?=
 =?utf-8?B?Vm5LWUFTeUpFK09UUEZJWEx1RkErMm83L3JoSkFuZFJGZDdQd2k4QjFEa2R4?=
 =?utf-8?B?TUFRTlZpN2l1MmVzRTlBaDhYWk5vcmhVVE0rSngxZGQ1QXJJUXRLWHRJYzFj?=
 =?utf-8?Q?Z+F7CBBdAVP43GMkUx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca3a0ee-5601-41f4-0f25-08df44790966
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:04:35.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e3QN4CfgV+dYaDAOe+qMInBt+hi5XKZjH+Ak7UpTwlcAO83352miOoCGHFgkAR7k7dcxa3h4b65gAorLL/IHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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



On 11/16/2026 9:41 PM, William Palacek wrote:
> __alloc_range_bias() walks the block tree from the roots and visits
> every split block overlapping [start, end) until it finds a suitable
> free block, so a range-restricted allocation costs time linear in the
> number of live allocations in the range. When both clear and dirty
> space exist, a request that the strict pass cannot serve walks the
> range twice.
>
> amdgpu pays this on every VRAM allocation when memory is partitioned
> (NPS2/NPS4): each BO, including the page-table BOs created when memory
> is mapped, is restricted to its partition's range, and KFD requests
> cleared VRAM. On MI300X in CPX/NPS4 the compute partitions that share a
> memory partition also share the VRAM manager lock, so the walk is
> serialised across processes. hipMalloc latency grows linearly with the
> number of live allocations, and vLLM piecewise graph capture slows down
> with every captured graph.
>
> The free trees are sorted by offset, so find the block there instead.
> For each order from the requested one up, look up the highest free
> block that can hold the request, then split the highest of them down to
> the requested order. The strict pass only takes blocks wholly inside
> the range whose class suits the request: subtree_block_state lets a
> clear request skip subtrees without a clear or mixed block, and a new
> subtree_has_dirty augment lets a dirty request skip subtrees that hold
> only clear blocks. The fallback pass takes the highest block of either
> class and may split one that straddles the range edge. Each lookup is
> O(log n) and the walk is gone.
>
> Placement is unchanged. A seeded random workload of 42218 allocations
> mixing range, clear and top-down requests and cleared and dirty frees
> places every block at the same offset, order and clear state as the
> walk.
>
> Filling 1 GiB of a 4 GiB manager with 64 KiB range-biased allocations
> that request cleared memory takes 1103 ms before, 2 ms after (KUnit,
> UML). With 8192 free cleared 64 KiB blocks interleaved with allocated
> ones in the range, 4096 dirty range allocations take 541 to 567 ms
> before and 0 ms after, and 4096 cleared ones 106 to 110 ms before and
> 0 ms after.
>
> On MI300X in CPX/NPS4, with 8000 live 2 MiB hipMalloc allocations on
> one partition, the median latency of the last 800 over the first 800 is
> 1.56x and 7.97x before and 0.52x and 1.06x after (two runs each; the
> first run after loading the driver starts slow). vLLM piecewise graph
> capture with tensor parallelism over all 64 partitions stays at 4 to 6 s
> per graph for all 51 graphs.
>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>
> Notes:
>      v3:
>      - rebased onto the merged clear/dirty guard (cb0a63f0c96e) (Arun)
>      - take Arun's free-tree lookup and drop the walk instead of narrowing it
>        (Arun)
>      - strict pass O(log n) for both classes: subtree_block_state for clear
>        requests, new subtree_has_dirty augment for dirty ones
>      - placement now matches the walk exactly, including the guard
>      
>      v2:
>      - rebased onto drm-misc-next (single free tree) (Arun)
>      - take the highest contained block, keeping top-down placement (Arun)
>
>   drivers/gpu/buddy.c       | 214 +++++++++++++++++++++++++-------------
>   include/linux/gpu_buddy.h |   1 +
>   2 files changed, 145 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index e7d2212bcec9..baf17700ffba 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -62,6 +62,8 @@ static struct kmem_cache *slab_extents;
>    *     of any block in the subtree, maintained as a max augment. A value of
>    *     >= MIXED means a clear-or-mixed block exists; == CLEAR means a
>    *     fully-clear block exists.
> + *   - subtree_has_dirty: some block in the subtree is not fully clear,
> + *     so range allocations can skip all-clear subtrees for dirty requests.
>    *
>    * Block classes
>    * -------------
> @@ -510,9 +512,11 @@ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
>   	struct gpu_buddy_block *right;
>   	struct gpu_buddy_block *left;
>   	unsigned int max_align;
> +	bool has_dirty;
>   
>   	max_align = gpu_buddy_block_offset_alignment(block);
>   	block_state = gpu_block_cached_state(block);
> +	has_dirty = block_state != GPU_BLOCK_CLEAR;
>   
>   	left = rb_entry_safe(block->rb.rb_left, struct gpu_buddy_block, rb);
>   	if (left) {
> @@ -520,6 +524,7 @@ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
>   			max_align = left->subtree_max_alignment;
>   
>   		block_state = max(block_state, left->subtree_block_state);
> +		has_dirty |= left->subtree_has_dirty;
>   	}
>   
>   	right = rb_entry_safe(block->rb.rb_right, struct gpu_buddy_block, rb);
> @@ -528,10 +533,12 @@ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
>   			max_align = right->subtree_max_alignment;
>   
>   		block_state = max(block_state, right->subtree_block_state);
> +		has_dirty |= right->subtree_has_dirty;
>   	}
>   
>   	block->subtree_max_alignment = max_align;
>   	block->subtree_block_state = block_state;
> +	block->subtree_has_dirty = has_dirty;
>   }
>   
>   static void gpu_buddy_augment_propagate(struct rb_node *rb, struct rb_node *stop)
> @@ -540,14 +547,17 @@ static void gpu_buddy_augment_propagate(struct rb_node *rb, struct rb_node *stop
>   		struct gpu_buddy_block *block;
>   		unsigned int old_align;
>   		enum gpu_block_state old_block_state;
> +		bool old_has_dirty;
>   
>   		block = rb_entry(rb, struct gpu_buddy_block, rb);
>   		old_align = block->subtree_max_alignment;
>   		old_block_state = block->subtree_block_state;
> +		old_has_dirty = block->subtree_has_dirty;
>   
>   		gpu_buddy_augment_compute(block);
>   		if (block->subtree_max_alignment == old_align &&
> -		    block->subtree_block_state == old_block_state)
> +		    block->subtree_block_state == old_block_state &&
> +		    block->subtree_has_dirty == old_has_dirty)
>   			break;
>   
>   		rb = rb_parent(&block->rb);
> @@ -564,6 +574,7 @@ static void gpu_buddy_augment_copy(struct rb_node *rb_old, struct rb_node *rb_ne
>   
>   	new->subtree_max_alignment = old->subtree_max_alignment;
>   	new->subtree_block_state = old->subtree_block_state;
> +	new->subtree_has_dirty = old->subtree_has_dirty;
>   }
>   
>   static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct rb_node *rb_new)
> @@ -576,6 +587,7 @@ static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct rb_node *rb_
>   
>   	new->subtree_max_alignment = old->subtree_max_alignment;
>   	new->subtree_block_state = old->subtree_block_state;
> +	new->subtree_has_dirty = old->subtree_has_dirty;
>   
>   	gpu_buddy_augment_compute(old);
>   }
> @@ -695,6 +707,8 @@ static void rbtree_insert(struct gpu_buddy *mm,
>   			node->subtree_max_alignment = block_alignment;
>   		if (node->subtree_block_state < block_state)
>   			node->subtree_block_state = block_state;
> +		if (block_state != GPU_BLOCK_CLEAR)
> +			node->subtree_has_dirty = true;
>   
>   		if (gpu_buddy_block_offset(block) < gpu_buddy_block_offset(node))
>   			link = &parent->rb_left;
> @@ -704,6 +718,7 @@ static void rbtree_insert(struct gpu_buddy *mm,
>   
>   	block->subtree_max_alignment = block_alignment;
>   	block->subtree_block_state = block_state;
> +	block->subtree_has_dirty = block_state != GPU_BLOCK_CLEAR;
>   	rb_link_node(&block->rb, parent, link);
>   	rb_insert_augmented(&block->rb, root, &gpu_buddy_augment_cb);
>   }
> @@ -1247,96 +1262,155 @@ static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags
>   			     gpu_buddy_block_is_clear(block);
>   }
>   
> -static struct gpu_buddy_block *
> -__alloc_range_bias(struct gpu_buddy *mm,
> -		   u64 start, u64 end,
> -		   unsigned int order,
> -		   unsigned long flags,
> -		   bool fallback)
> +/* Does the subtree at @node hold a block the strict pass may take? */
> +static bool range_subtree_ok(struct rb_node *node, unsigned long flags)
>   {
> -	u64 req_size = mm->chunk_size << order;
> -	struct gpu_buddy_block *block;
> -	LIST_HEAD(dfs);
> -	int err;
> -	int i;
> +	struct gpu_buddy_block *block = rbtree_get_free_block(node);
>   
> -	end = end - 1;
> +	if (!block)
> +		return false;
> +	if (flags & GPU_BUDDY_CLEAR_ALLOCATION)
> +		return block->subtree_block_state >= GPU_BLOCK_MIXED;
> +	return block->subtree_has_dirty;
> +}
>   
> -	/*
> -	 * This range-constrained search hands back the highest/right-most
> -	 * address that satisfies the request: the roots are seeded high-to-low
> -	 * and the right (higher-address) child is descended first, making
> -	 * top-down the default placement here.
> -	 */
> -	for (i = mm->n_roots - 1; i >= 0; --i)
> -		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> +/*
> + * Highest-offset free block in @root with offset < @limit that the strict
> + * pass may take (any block when @fallback). Subtrees without such a block
> + * are skipped through the augments, so this is O(log n) per call.
> + */
> +static struct gpu_buddy_block *
> +rbtree_last_range_block(struct rb_root *root, u64 limit,
> +			unsigned long flags, bool fallback)
> +{
> +	struct rb_node *node = root->rb_node;
> +	struct rb_node *prev = NULL;
>   
> -	do {
> -		u64 block_start;
> -		u64 block_end;
> +	while (node) {
> +		if (gpu_buddy_block_offset(rbtree_get_free_block(node)) < limit) {
> +			prev = node;
> +			node = node->rb_right;
> +		} else {
> +			node = node->rb_left;
> +		}
> +	}
>   
> -		block = list_first_entry_or_null(&dfs,
> -						 struct gpu_buddy_block,
> -						 tmp_link);
> -		if (!block)
> -			break;
> +	for (node = prev; node; node = rb_parent(node)) {
> +		if (fallback ||
> +		    !block_incompatible(rbtree_get_free_block(node), flags))
> +			return rbtree_get_free_block(node);
>   
> -		list_del(&block->tmp_link);
> +		if (range_subtree_ok(node->rb_left, flags)) {
> +			/* The left subtree holds one: take its highest. */
> +			node = node->rb_left;
> +			while (node) {
> +				struct gpu_buddy_block *block = rbtree_get_free_block(node);
>   
> -		if (gpu_buddy_block_order(block) < order)
> -			continue;
> +				if (range_subtree_ok(node->rb_right, flags)) {
> +					node = node->rb_right;
> +					continue;
> +				}
> +				if (!block_incompatible(block, flags))
> +					return block;
> +				node = node->rb_left;
> +			}
> +			return NULL;
> +		}
>   
> -		block_start = gpu_buddy_block_offset(block);
> -		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
> +		/* Climb to the next lower ancestor. */
> +		while (rb_parent(node) && node == rb_parent(node)->rb_left)
> +			node = rb_parent(node);
> +	}
>   
> -		if (!overlaps(start, end, block_start, block_end))
> -			continue;
> +	return NULL;
> +}
>   
> -		if (gpu_buddy_block_is_allocated(block))
> -			continue;
> +/*
> + * Return the order-@order block at the highest @req_size-aligned offset in
> + * [@start, @end) that lies inside a free block, splitting as needed. The
> + * strict pass only takes free blocks wholly inside the range whose class
> + * suits @flags; splitting a block that straddles the range edge is left to
> + * the fallback pass, which takes either class.
> + */
> +static struct gpu_buddy_block *
> +__alloc_range_bias(struct gpu_buddy *mm,
> +		   u64 start, u64 end,
> +		   unsigned int order,
> +		   unsigned long flags,
> +		   bool fallback)
> +{
> +	u64 req_size = mm->chunk_size << order;
> +	struct gpu_buddy_block *block = NULL;
> +	u64 best = 0;
> +	unsigned int i;
> +	int err;
>   
> -		if (block_start < start || block_end > end) {
> -			u64 adjusted_start = max(block_start, start);
> -			u64 adjusted_end = min(block_end, end);
> +	for (i = order; i <= mm->max_order; i++) {
> +		struct rb_root *root = &mm->free_tree[i];
> +		u64 size = mm->chunk_size << i;
> +		struct gpu_buddy_block *found;
> +		u64 offset = 0;
>   
> -			if (round_down(adjusted_end + 1, req_size) <=
> -			    round_up(adjusted_start, req_size))
> -				continue;
> +		if (!fallback) {
> +			if (end - start < size)
> +				break;
>   
> -			/*
> -			 * Strict pass: don't split a partially-overlapping free
> -			 * block; rejecting its child would strand the split. Let
> -			 * the fallback pass consume it (either class accepted).
> -			 */
> -			if (!fallback && gpu_buddy_block_is_free(block))
> +			found = rbtree_last_range_block(root, end - size + 1,
> +							flags, false);
> +			if (!found || gpu_buddy_block_offset(found) < start)
>   				continue;
> -		}
> -
> -		if (!fallback && block_incompatible(block, flags))
> -			continue;
>   
> -		if (contains(start, end, block_start, block_end) &&
> -		    order == gpu_buddy_block_order(block)) {
> -			/*
> -			 * Find the free block within the range.
> -			 */
> -			if (gpu_buddy_block_is_free(block))
> -				return block;
> +			offset = gpu_buddy_block_offset(found) + size - req_size;
> +		} else {
> +			/* At most the blocks straddling @end and @start miss. */
> +			for (found = rbtree_last_range_block(root, end, flags, true);
> +			     found;
> +			     found = rbtree_get_free_block(rb_prev(&found->rb))) {
> +				u64 lo = max(gpu_buddy_block_offset(found), start);
> +				u64 hi = min(gpu_buddy_block_offset(found) + size, end);
> +
> +				if (hi <= start) {
> +					found = NULL;
> +					break;
> +				}
>   
> -			continue;
> +				if (hi >= lo + req_size) {
> +					offset = round_down(hi - req_size, req_size);
> +					if (offset >= lo)
> +						break;
> +				}
> +			}
> +			if (!found)
> +				continue;
>   		}
>   
> -		if (!gpu_buddy_block_is_split(block)) {
> -			err = split_block(mm, block);
> -			if (unlikely(err))
> -				goto err_undo;
> +		if (!block || offset > best) {
> +			block = found;
> +			best = offset;
>   		}
> +	}
>   
> -		list_add(&block->left->tmp_link, &dfs);
> -		list_add(&block->right->tmp_link, &dfs);
> -	} while (1);
> +	if (!block)
> +		return ERR_PTR(-ENOSPC);
> +
> +	while (gpu_buddy_block_order(block) > order) {
> +		err = split_block(mm, block);
> +		if (unlikely(err))
> +			goto err_undo;
>   
> -	return ERR_PTR(-ENOSPC);
> +		/*
> +		 * Fallback: the child holding @best. Strict: the higher child
> +		 * unless its class does not suit, as the old walk did.
> +		 */
> +		if (fallback)
> +			block = best >= gpu_buddy_block_offset(block->right) ?
> +				block->right : block->left;
> +		else
> +			block = block_incompatible(block->right, flags) ?
> +				block->left : block->right;
> +	}
> +
> +	return block;
>   
>   err_undo:
>   	/*
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index ddc4eca84175..6abc66125935 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -141,6 +141,7 @@ struct gpu_buddy_block {
>   	unsigned int subtree_max_alignment;
>   	struct list_head tmp_link;
>   	bool has_clear;
> +	bool subtree_has_dirty;
Please drop this additional augmentation. We tried a similar 
augmentation earlier and observed performance regressions in some 
workloads due to the additional maintenance overhead.
Also, keep the existing guard policies unchanged, as they are already 
tuned for fragmentation.

Regards,
Arun.

>   };
>   
>   /* Order-zero must be at least SZ_4K */

