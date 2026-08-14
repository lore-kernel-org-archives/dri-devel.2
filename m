Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E5AC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF5610E57B;
	Fri, 14 Aug 2026 14:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CjlA4E3o";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB4210E158;
 Fri, 14 Aug 2026 14:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sb0B5qBivyeNMC46WoChSwDM1PIRfRMxtWtkP+QLAPNm4OX2+sSkhgLycI/ygh+rx3PEmf/SgACrH6ldyy8XVO44Y8i+03WIUS/qhskAQqGiQNdY0ItTAGyR+mM97K+iabSS41tl6gICUqkA7xL69lCWHd/eN0IbnIhlfuq+y0LNRafULFjvNogG03Wt0VQ+esgGUg0r1ce+vQ4/ZGqQMEHwBx6Dg00JSVRlWHAxz4kWRT6h90XUxLDvKEG7XWAvMCibpHgreHDFfO4uu8PKG6ZdfB/+ZXc36TQ00ck65j33D1i60K6uw9nw2slty+TLJKT09siksGYLzHh2JKWdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+WHZqv3CxR+8AWW5/CwZzPooLpvguxTnSkvg4rG3SA=;
 b=nMlg5DyvtpM1gijdzMWgMw47E2tE4S2JaOzQAZJpY93YOkqQsSfN6oWng2ETAJ8tZUNKpwoJxgxCh3Trqqh0JKXcYn1uPjCFP7hcEBs8nzXlc/6onc4Tq6X3ovF2872WXWF6GiTUpyWEyvm8po2i5kpsVP0adJxUAvRz5i8Ee39sDfmFaQkYxpDy1fndTo7C/oqWMaA30z8H7uEYDwpgbc6EN7i9+r/YlEodC9C1tK3rQp39fH8ccQJ0zHDZxrrvGbI5UfbfmSEEhYgoZgsljlc8AFmAk74KgFnAatr4g+BylOHKPNnJI5S8nR+b47IpIf5LQTYJ7ph7yWruk1fkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+WHZqv3CxR+8AWW5/CwZzPooLpvguxTnSkvg4rG3SA=;
 b=CjlA4E3ohq88CWYB3zW0nAZdUTE9gQXc2c2zdMMR7IX48UzIGJ7XkkLIq9EN2s91aKfklt/To4T4GLWSrSMJq95DsKWxgJK8ZSNb2xqKIB7nBDmk7hGoV3GOFWhcQqp40hi94wReCv76JLAE+jbcziye8WHv49SuK2jQpmbpHlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:53:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 14:53:11 +0000
Message-ID: <79a86d15-280b-4573-afb7-b97ccefabefe@amd.com>
Date: Fri, 14 Aug 2026 16:53:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Represent LRU bulk moves as nested sublists
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org
References: <20260814133231.3193-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260814133231.3193-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7619af-4bfe-44eb-0355-08defa13c281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|11063799006|56012099006|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: WlghR4bLcuEYnyfTAU5HYHkwuEtb9ov6hu0V2l24eCK8UWJ5fIAltsFOXqB6p7QYJhIBH8Q93jCqlhq2wkgD5AVmVe4NfGRWotz+XTF/Biv+bn1ocwnagc72qoLffis+0ZAPjBqR2a0PoqeVpZKhAr1LAzIxTjKnEJ0geE1dAWCqZpE2387NtraxYvLWe7jtLbXsxJeP5esYoeaE3chFrX/vkIz1j39xpo7jiqsL72nzPzIP/BQ0yQwmKp9maieqvkwgibQF2mN8LzwBJuSR0E3duv3ktmfKQNJRHa7pEkAeKLrCQeLF6TaB1vbrdK5Sr0cXrkf+HBRzPP3YLqwbrQeWlRqmofYapVE3YjFV1i6l2mGdIUHfujIs3Z8eNL9iJD7D7eRul2TOAXX5ZwMSHLVqT4nDN2fjFUxTyjVr/jlXimaiD+62Ifz7S+4L4PPTYA6JAXdBazITB8EBYoW6xc25uaDRUuLWCKdtVYg6Bijqn+pWwNmj6/o5/Pv47eYsfrMyPpUuP8DaBeqFWsIcljSVeFENqlKIBH1U8nadodAwN9V7U8etNOr1PGnyU23orvTbqVue99x8uD3TMdvp7i8mTNI3pSKg3SAzCCPvGh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JjQzFWd2RuRTJSWFlnR2Q5dVRpVzRMZ2cxTWZsbkc1NkhYSVkvb0RHa082?=
 =?utf-8?B?VTFxOVlJZFlzaCtjbDJLb3E3VWYxbUozSlhwd1EyazRyc0xHUGxLbzdYemtT?=
 =?utf-8?B?MHpHSUFjS3VtMzg2NmVFUHFKUUhiMnhuR0ZkdEdvb2RWaVk4OW01TUhoZTFk?=
 =?utf-8?B?Q0FTZFpJSEVrUGtQQWthZGNDMENEWEcrRGM1UjB6WG14UWV4UTVETUJnak04?=
 =?utf-8?B?RUdjZko0aW5KWndrcWhDaXE4NkRzZGNrT2M3KzNBdUVZaGNKUFg5d2Z4KzBm?=
 =?utf-8?B?NUI1TGtCemxKMndsR2ZycmVsN3VtZWM5R3BLT2Rod1Nid3F5TFB5cHBrdzVl?=
 =?utf-8?B?WHpibmY2RUJEY0RxN1JXU0FURGVOUGluVndJNWZNbHY5NmJnS0VmSTBmcUZD?=
 =?utf-8?B?c0w0M1YvRUE3bkFNL3EwS2tyUlBUUFJBUnRvRHpoSjJ4LzU1YmVYVGdnL2lr?=
 =?utf-8?B?SUlMSWdGVE9GOXY3amxpeWNNU29SSm8weEY5RWJwZmQ1NldjWEJ3VWxmSzFR?=
 =?utf-8?B?M1h2YkFHdlkzakNLYURrQlNEYk45b0djL2JWZEVwZ0NMUTNYYjZEZ1ZRVEFz?=
 =?utf-8?B?ckpCVTZqNEdSN3FFLzNTOFpiUlpzNStBVmlSNHpNUnJyRHBBbDNhRmN6YnU1?=
 =?utf-8?B?VE4za1NxcmxiV3FiR2NyYzg5MFJTK2ppRjM0VjBhOTNFbk00WUYwL3JtTERS?=
 =?utf-8?B?Y2tMQVFWODBiVnVnNzR6UWw5UVRNNXp5U0piMlIvN3E0OFQramFDNlVCRmlx?=
 =?utf-8?B?NTl2UWJLTDBZWlV5UE5FcG9OYUNkbm1VdUNkQXpnQ2oraUI4ZEpIcTFNeXV0?=
 =?utf-8?B?WDlNOTFmakdqWFVsZE53T21qeXU2QTZ2L01uWVlvZndpYzZHcGpobFcweHFY?=
 =?utf-8?B?Zzg5NWZueENrbDVUMW5DTnYyY1JKcUdRbGJRSzBaNWdFMnhDYUdJeFAxZDhX?=
 =?utf-8?B?US9oSFY0WG4zMTdIYzVEQ2VseUkwNHhsN0lZSzFTSEdnWUJNUUUxbG40Zi93?=
 =?utf-8?B?NkVrV01SNCs4Y2o4TjBJbzVuaFh0Y2N6T2QyYUJqdXZNOWwwbTQwQldCa3Jo?=
 =?utf-8?B?aHlaY2xMZ0t6VXJGTWI4SWRzU21Xa1RrRmVKQ294QmcyNzdmcmpoaldrMnFR?=
 =?utf-8?B?WWFlMzFQNk1wOTQ0Nm9yRE1oUWRmQzN3SkU5R1M1TzRINTF3UFp5V0FPeWdK?=
 =?utf-8?B?MEtmbnlJTitGc1djUjJibFJUb1h5emdHbHFnMG1YNUhWdU91eEJVaEY4eWNO?=
 =?utf-8?B?MTB5MHZJaUJXQU1KaExhdHQrM3kwSUdpRGtoNlNiMStzSk5PRE1pZlc4NXFM?=
 =?utf-8?B?RTVjaFEyTVRFaXNCRjFTcWU3QW9uNDZ2WVIzQXNFVVkyV04yMiswTHA3ZTE5?=
 =?utf-8?B?NWZUWXJieXYyVmRpeVROUk5jL25LbXJvOHhWekI0OVVaS243MW53SVA2MG5r?=
 =?utf-8?B?MFdPakFkMlVEOGpKNERxeUZ0TW1id0VyQVNDd1UyVmtDSEJMRnVYZm1Gb2hL?=
 =?utf-8?B?R2ttWWtFbzlMOVdkck53eTcxd2xLa05ya2dVdlVUOW1aNUVHM3JZQmFTRHVJ?=
 =?utf-8?B?ZVJ3Y1AzclFMbEYxMkVGUkhxOFd4MEJYT1l4RlJMQS9BSHJzdHFuNFNEeENy?=
 =?utf-8?B?UGhaa1J6WUt2bElCMTNscXFKZ1BFYnV5YVU5MERSRjFCVUdoVjVyNXUzako1?=
 =?utf-8?B?UTRRNWllbzkrZUtyVEU1QVdpVi9Bb0xKY0x1MVROYVpQUG91UnM4VlVmRVB0?=
 =?utf-8?B?TnU5TkM5SnU0VkgwVzFrOG5JNGQ2UzNBNjdLRHVSYk9JWHRlRG9SaktyWHR2?=
 =?utf-8?B?SHVRNGdxV0pHWkx2ZjN3SFFWR2tDZGpEeUZ0TkpiSi9TZE5pRGRHVGU3dWFl?=
 =?utf-8?B?cFJCSi9rQzJkT0dZWFhPNG1xeFRtY2hlbGZFVHg3MVZqMVNESWFTYTcvb2ho?=
 =?utf-8?B?MDFlUXlHVFhlSEkvZms0ejBIOXV2ME10RjhTR2RWN0Zxem5hQXFSSE0rNXFs?=
 =?utf-8?B?bTJ6ZUNjaitJeHZpYW9zdmdXUlN4Q1lBb2pHRjFHbk8zR1daR28vNjRiZGVt?=
 =?utf-8?B?SHF6dnlRaFhrcUt3NG1UNjJuc3N6LzQvNnJQbGpuOWxNQlNOMHNDNHFCZXlZ?=
 =?utf-8?B?Smh6YnJvdFNoM3c4MU8xR3B6d0hkQmdUaVU0d2FkR0I2M3AyS0tmV3B5QlJG?=
 =?utf-8?B?MS9scFRpeWVRVzlmeVZhTEU3N204TDVOWEJyUnRzV29pQ05nLzBhdWkwN1Vs?=
 =?utf-8?B?Rm5PVUxHYWx0WDlHcjhQL3hrb1ZyRUlqTVBTSGhhWFRrODRqZitMUXcybU1L?=
 =?utf-8?Q?CDOsvTWxFrUr7HCeIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7619af-4bfe-44eb-0355-08defa13c281
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:53:11.4691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMle28q1wFGdpaz5EOzVYifP10UF0fW0gZuf6Bq/860Q4VNREfuEb6iqfY11w9EI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580
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

On 8/14/26 15:32, Thomas Hellström wrote:
> The LRU bulk move mechanism tracked each (domain, priority) group as a
> {first, last} range of resources threaded directly on the manager LRU
> list. Group membership was implicit, derived from per-buffer-object
> back-pointers, and moving a group required first evacuating every cursor
> that pointed into the range. This range representation was fragile: the
> first/last endpoints could get out of sync with the actual list contents,
> for example on an empty range, or when a member was pinned, swapped out
> and later repopulated. That corrupted the manager LRU lists and caused
> crashes, notably during hibernation.
> 
> Represent each bulk move group as a real nested sublist instead. Each
> (domain, priority) group owns a persistent anchor node, a new
> TTM_LRU_BULK item, linked on the manager LRU list, plus a sublist holding
> its member resources. Adding, removing and reordering members become
> unconditional list_move_tail()/list_del_init() operations that cannot
> leave stale endpoints behind, and moving a whole group is a single
> list_move_tail() of the anchor. The LRU walk descends into a group's
> sublist when it reaches the anchor and resumes the manager list
> afterwards.
> 
> The cursor carries two hitches. The main hitch stays parked on the
> manager LRU list while the cursor descends, so that a concurrent bulk
> move of the anchor cannot make the walk skip entries, and a second hitch
> walks the sublist. Re-encountering a moved anchor simply re-walks its
> sublist, which is harmless.
> 
> This removes the per-object back-pointer dereference during traversal and
> simplifies the cursor tracking and adjustment machinery, eliminating the
> class of range-corruption bugs by construction.
> 
> v2: Detach descended cursors on bulk LRU bump.
> - Keep cursor detach on bulk finalize as a separate helper function.
> - Documentation update.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Assisted-by: GitHub_Copilot:claude-sonnet-5
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: dri-devel@lists.freedesktop.org
I'm on vacation next week and won't have time to take a closer look at this before.

If that fixes the bug then feel free to add Acked-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>  drivers/gpu/drm/ttm/tests/ttm_bo_test.c |  26 +-
>  drivers/gpu/drm/ttm/ttm_bo.c            |   9 +-
>  drivers/gpu/drm/ttm/ttm_resource.c      | 335 ++++++++++++++----------
>  include/drm/ttm/ttm_resource.h          |  57 ++--
>  4 files changed, 244 insertions(+), 183 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> index f3103307b5df..b40d93632491 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> @@ -30,6 +30,19 @@ struct ttm_bo_test_case {
>  	bool no_wait;
>  };
>  
> +/* Return the last resource in a bulk move sublist, or NULL if empty. */
> +static struct ttm_resource *
> +ttm_bo_test_pos_last_res(struct ttm_lru_bulk_move_pos *pos)
> +{
> +	struct ttm_lru_item *lru;
> +
> +	list_for_each_entry_reverse(lru, &pos->sublist, link)
> +		if (ttm_lru_item_is_res(lru))
> +			return ttm_lru_item_to_res(lru);
> +
> +	return NULL;
> +}
> +
>  static const struct ttm_bo_test_case ttm_bo_reserved_cases[] = {
>  	{
>  		.description = "Cannot be interrupted and sleeps",
> @@ -371,7 +384,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
>  	ttm_bo_unreserve(bo1);
>  
>  	pos = &lru_bulk_move.pos[mem_type][bo_priority];
> -	KUNIT_ASSERT_PTR_EQ(test, res1, pos->last);
> +	KUNIT_ASSERT_PTR_EQ(test, res1, ttm_bo_test_pos_last_res(pos));
>  
>  	ttm_resource_free(bo1, &res1);
>  	ttm_resource_free(bo2, &res2);
> @@ -530,14 +543,13 @@ static void ttm_bo_pin_unpin_resource(struct kunit *test)
>  	pos = &lru_bulk_move.pos[mem_type][bo_priority];
>  
>  	KUNIT_ASSERT_EQ(test, bo->pin_count, 1);
> -	KUNIT_ASSERT_NULL(test, pos->first);
> -	KUNIT_ASSERT_NULL(test, pos->last);
> +	KUNIT_ASSERT_NULL(test, ttm_lru_first_res_or_null(&pos->sublist));
>  
>  	dma_resv_lock(bo->base.resv, NULL);
>  	ttm_bo_unpin(bo);
>  	dma_resv_unlock(bo->base.resv);
>  
> -	KUNIT_ASSERT_PTR_EQ(test, res, pos->last);
> +	KUNIT_ASSERT_PTR_EQ(test, res, ttm_bo_test_pos_last_res(pos));
>  	KUNIT_ASSERT_EQ(test, bo->pin_count, 0);
>  
>  	ttm_resource_free(bo, &res);
> @@ -585,16 +597,14 @@ static void ttm_bo_multiple_pin_one_unpin(struct kunit *test)
>  	pos = &lru_bulk_move.pos[mem_type][bo_priority];
>  
>  	KUNIT_ASSERT_EQ(test, bo->pin_count, 2);
> -	KUNIT_ASSERT_NULL(test, pos->first);
> -	KUNIT_ASSERT_NULL(test, pos->last);
> +	KUNIT_ASSERT_NULL(test, ttm_lru_first_res_or_null(&pos->sublist));
>  
>  	dma_resv_lock(bo->base.resv, NULL);
>  	ttm_bo_unpin(bo);
>  	dma_resv_unlock(bo->base.resv);
>  
>  	KUNIT_ASSERT_EQ(test, bo->pin_count, 1);
> -	KUNIT_ASSERT_NULL(test, pos->first);
> -	KUNIT_ASSERT_NULL(test, pos->last);
> +	KUNIT_ASSERT_NULL(test, ttm_lru_first_res_or_null(&pos->sublist));
>  
>  	dma_resv_lock(bo->base.resv, NULL);
>  	ttm_bo_unpin(bo);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index ef56c18ded1b..c24f957a5fae 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -109,11 +109,14 @@ void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
>  		return;
>  
>  	spin_lock(&bo->bdev->lru_lock);
> -	if (bo->resource)
> +	if (bo->resource) {
>  		ttm_resource_del_bulk_move(bo->resource, bo);
> -	bo->bulk_move = bulk;
> -	if (bo->resource)
> +		bo->bulk_move = bulk;
>  		ttm_resource_add_bulk_move(bo->resource, bo);
> +		ttm_resource_move_to_lru_tail(bo->resource);
> +	} else {
> +		bo->bulk_move = bulk;
> +	}
>  	spin_unlock(&bo->bdev->lru_lock);
>  }
>  EXPORT_SYMBOL(ttm_bo_set_bulk_move);
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 4e6d3d658d85..195f960b2d73 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -37,53 +37,6 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_util.h>
>  
> -/* Detach the cursor from the bulk move list */
> -static void
> -ttm_resource_cursor_clear_bulk(struct ttm_resource_cursor *cursor)
> -{
> -	lockdep_assert_held(&cursor->man->bdev->lru_lock);
> -
> -	cursor->bulk = NULL;
> -	list_del_init(&cursor->bulk_link);
> -}
> -
> -/* Move the cursor to the end of the bulk move list it's in */
> -static void ttm_resource_cursor_move_bulk_tail(struct ttm_lru_bulk_move *bulk,
> -					       struct ttm_resource_cursor *cursor)
> -{
> -	struct ttm_lru_bulk_move_pos *pos;
> -
> -	lockdep_assert_held(&cursor->man->bdev->lru_lock);
> -
> -	if (WARN_ON_ONCE(bulk != cursor->bulk)) {
> -		list_del_init(&cursor->bulk_link);
> -		return;
> -	}
> -
> -	pos = &bulk->pos[cursor->mem_type][cursor->priority];
> -	if (pos->last)
> -		list_move(&cursor->hitch.link, &pos->last->lru.link);
> -	ttm_resource_cursor_clear_bulk(cursor);
> -}
> -
> -/* Move all cursors attached to a bulk move to its end */
> -static void ttm_bulk_move_adjust_cursors(struct ttm_lru_bulk_move *bulk)
> -{
> -	struct ttm_resource_cursor *cursor, *next;
> -
> -	list_for_each_entry_safe(cursor, next, &bulk->cursor_list, bulk_link)
> -		ttm_resource_cursor_move_bulk_tail(bulk, cursor);
> -}
> -
> -/* Remove a cursor from an empty bulk move list */
> -static void ttm_bulk_move_drop_cursors(struct ttm_lru_bulk_move *bulk)
> -{
> -	struct ttm_resource_cursor *cursor, *next;
> -
> -	list_for_each_entry_safe(cursor, next, &bulk->cursor_list, bulk_link)
> -		ttm_resource_cursor_clear_bulk(cursor);
> -}
> -
>  /**
>   * ttm_resource_cursor_init() - Initialize a struct ttm_resource_cursor
>   * @cursor: The cursor to initialize.
> @@ -96,9 +49,11 @@ void ttm_resource_cursor_init(struct ttm_resource_cursor *cursor,
>  {
>  	cursor->priority = 0;
>  	cursor->man = man;
> +	cursor->cur_list = NULL;
>  	ttm_lru_item_init(&cursor->hitch, TTM_LRU_HITCH);
> -	INIT_LIST_HEAD(&cursor->bulk_link);
> +	ttm_lru_item_init(&cursor->sublist_hitch, TTM_LRU_HITCH);
>  	INIT_LIST_HEAD(&cursor->hitch.link);
> +	INIT_LIST_HEAD(&cursor->sublist_hitch.link);
>  }
>  
>  /**
> @@ -113,39 +68,127 @@ void ttm_resource_cursor_fini(struct ttm_resource_cursor *cursor)
>  {
>  	lockdep_assert_held(&cursor->man->bdev->lru_lock);
>  	list_del_init(&cursor->hitch.link);
> -	ttm_resource_cursor_clear_bulk(cursor);
> +	list_del_init(&cursor->sublist_hitch.link);
> +	cursor->cur_list = NULL;
>  }
>  
>  /**
>   * ttm_lru_bulk_move_init - initialize a bulk move structure
>   * @bulk: the structure to init
>   *
> - * For now just memset the structure to zero.
> + * Initialize the resource sublists and their LRU anchors.
>   */
>  void ttm_lru_bulk_move_init(struct ttm_lru_bulk_move *bulk)
>  {
> +	unsigned int i, j;
> +
>  	memset(bulk, 0, sizeof(*bulk));
> -	INIT_LIST_HEAD(&bulk->cursor_list);
> +	for (i = 0; i < TTM_NUM_MEM_TYPES; ++i) {
> +		for (j = 0; j < TTM_MAX_BO_PRIORITY; ++j) {
> +			struct ttm_lru_bulk_move_pos *pos = &bulk->pos[i][j];
> +
> +			ttm_lru_item_init(&pos->marker, TTM_LRU_BULK);
> +			INIT_LIST_HEAD(&pos->sublist);
> +		}
> +	}
>  }
>  EXPORT_SYMBOL(ttm_lru_bulk_move_init);
>  
> +/*
> + * Detach the bulk move from the manager LRU lists so that it can be
> + * freed. Any cursor still traversing a sublist is repointed at the
> + * manager LRU list, and it is verified that the bulk move holds no
> + * resources.
> + */
> +static void ttm_bulk_move_drop_cursors(struct ttm_device *bdev,
> +					struct ttm_lru_bulk_move *bulk)
> +{
> +	unsigned int i, j;
> +
> +	for (i = 0; i < TTM_NUM_MEM_TYPES; ++i) {
> +		struct ttm_resource_manager *man = ttm_manager_type(bdev, i);
> +
> +		for (j = 0; j < TTM_MAX_BO_PRIORITY; ++j) {
> +			struct ttm_lru_bulk_move_pos *pos = &bulk->pos[i][j];
> +			struct ttm_lru_item *lru, *next;
> +
> +			list_for_each_entry_safe(lru, next, &pos->sublist, link) {
> +				struct ttm_resource_cursor *cursor;
> +
> +				if (ttm_lru_item_is_res(lru)) {
> +					WARN_ON_ONCE(1);
> +					continue;
> +				}
> +				/*
> +				 * This cursor descended here; its main hitch
> +				 * already sits on the manager list, so just
> +				 * detach it from this sublist.
> +				 */
> +				cursor = container_of(lru, typeof(*cursor),
> +						      sublist_hitch);
> +				cursor->cur_list = &man->lru[j];
> +				list_del_init(&lru->link);
> +			}
> +			list_splice_tail_init(&pos->sublist, &man->lru[j]);
> +			list_del_init(&pos->marker.link);
> +		}
> +	}
> +}
> +
>  /**
>   * ttm_lru_bulk_move_fini - finalize a bulk move structure
>   * @bdev: The struct ttm_device
>   * @bulk: the structure to finalize
>   *
> - * Sanity checks that bulk moves don't have any
> - * resources left and hence no cursors attached.
> + * Detaches the bulk move from the manager LRU lists so that it can be
> + * freed. Any cursor still traversing the bulk move is repointed at the
> + * manager LRU list, and it is verified that the bulk move holds no
> + * resources.
>   */
>  void ttm_lru_bulk_move_fini(struct ttm_device *bdev,
>  			    struct ttm_lru_bulk_move *bulk)
>  {
>  	spin_lock(&bdev->lru_lock);
> -	ttm_bulk_move_drop_cursors(bulk);
> +	ttm_bulk_move_drop_cursors(bdev, bulk);
>  	spin_unlock(&bdev->lru_lock);
>  }
>  EXPORT_SYMBOL(ttm_lru_bulk_move_fini);
>  
> +/*
> + * Detach any cursor that has descended into pos's sublist so it
> + * resumes walking the manager LRU list, without walking the
> + * (potentially large) sublist itself, which would defeat the point of
> + * a bulk tail move. It suffices to look at the run of cursor hitches
> + * parked immediately after pos's anchor in the manager list, since
> + * that's exactly where a descended cursor's main hitch sits (see
> + * ttm_resource_manager_next()). A hitch whose cursor has since exited
> + * the sublist on its own is skipped rather than ending the run; only
> + * one still parked in a different, still-live sublist marks the
> + * actual end.
> + */
> +static void ttm_lru_bulk_move_pos_adjust_cursors(struct ttm_resource_manager *man,
> +						 struct ttm_lru_bulk_move_pos *pos,
> +						 unsigned int priority)
> +{
> +	struct ttm_lru_item *lru = &pos->marker;
> +
> +	list_for_each_entry_continue(lru, &man->lru[priority], link) {
> +		struct ttm_resource_cursor *cursor;
> +
> +		if (lru->type != TTM_LRU_HITCH)
> +			break;
> +
> +		cursor = container_of(lru, typeof(*cursor), hitch);
> +		if (cursor->cur_list == &man->lru[priority])
> +			continue;
> +		if (cursor->cur_list != &pos->sublist)
> +			break;
> +
> +		list_del_init(&cursor->sublist_hitch.link);
> +		cursor->cur_list = &man->lru[priority];
> +	}
> +}
> +
>  /**
>   * ttm_lru_bulk_move_tail - bulk move range of resources to the LRU tail.
>   *
> @@ -156,24 +199,24 @@ EXPORT_SYMBOL(ttm_lru_bulk_move_fini);
>   */
>  void ttm_lru_bulk_move_tail(struct ttm_lru_bulk_move *bulk)
>  {
> -	unsigned i, j;
> +	unsigned int i, j;
>  
> -	ttm_bulk_move_adjust_cursors(bulk);
>  	for (i = 0; i < TTM_NUM_MEM_TYPES; ++i) {
>  		for (j = 0; j < TTM_MAX_BO_PRIORITY; ++j) {
>  			struct ttm_lru_bulk_move_pos *pos = &bulk->pos[i][j];
>  			struct ttm_resource_manager *man;
> +			struct ttm_resource *first;
>  
> -			if (!pos->first)
> +			first = ttm_lru_first_res_or_null(&pos->sublist);
> +			if (!first)
>  				continue;
>  
> -			lockdep_assert_held(&pos->first->bo->bdev->lru_lock);
> -			dma_resv_assert_held(pos->first->bo->base.resv);
> -			dma_resv_assert_held(pos->last->bo->base.resv);
> +			lockdep_assert_held(&first->bo->bdev->lru_lock);
> +			dma_resv_assert_held(first->bo->base.resv);
>  
> -			man = ttm_manager_type(pos->first->bo->bdev, i);
> -			list_bulk_move_tail(&man->lru[j], &pos->first->lru.link,
> -					    &pos->last->lru.link);
> +			man = ttm_manager_type(first->bo->bdev, i);
> +			ttm_lru_bulk_move_pos_adjust_cursors(man, pos, j);
> +			list_move_tail(&pos->marker.link, &man->lru[j]);
>  		}
>  	}
>  }
> @@ -186,74 +229,59 @@ ttm_lru_bulk_move_pos(struct ttm_lru_bulk_move *bulk, struct ttm_resource *res)
>  	return &bulk->pos[res->mem_type][res->bo->priority];
>  }
>  
> -/* Return the previous resource on the list (skip over non-resource list items) */
> -static struct ttm_resource *ttm_lru_prev_res(struct ttm_resource *cur)
> +/* Make sure the bulk move anchor is linked into the manager LRU list */
> +static void ttm_lru_bulk_move_link_marker(struct ttm_lru_bulk_move_pos *pos,
> +					  struct ttm_resource *res)
>  {
> -	struct ttm_lru_item *lru = &cur->lru;
> -
> -	do {
> -		lru = list_prev_entry(lru, link);
> -	} while (!ttm_lru_item_is_res(lru));
> -
> -	return ttm_lru_item_to_res(lru);
> -}
> -
> -/* Return the next resource on the list (skip over non-resource list items) */
> -static struct ttm_resource *ttm_lru_next_res(struct ttm_resource *cur)
> -{
> -	struct ttm_lru_item *lru = &cur->lru;
> -
> -	do {
> -		lru = list_next_entry(lru, link);
> -	} while (!ttm_lru_item_is_res(lru));
> -
> -	return ttm_lru_item_to_res(lru);
> -}
> +	struct ttm_buffer_object *bo = res->bo;
> +	struct ttm_resource_manager *man =
> +		ttm_manager_type(bo->bdev, res->mem_type);
>  
> -/* Move the resource to the tail of the bulk move range */
> -static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
> -				       struct ttm_resource *res)
> -{
> -	if (pos->last != res) {
> -		if (pos->first == res)
> -			pos->first = ttm_lru_next_res(res);
> -		list_move(&res->lru.link, &pos->last->lru.link);
> -		pos->last = res;
> -	}
> +	if (list_empty(&pos->marker.link))
> +		list_add_tail(&pos->marker.link, &man->lru[bo->priority]);
>  }
>  
> -/* Add the resource to a bulk_move cursor */
> +/* Add the resource to a bulk_move sublist */
>  static void ttm_lru_bulk_move_add(struct ttm_lru_bulk_move *bulk,
>  				  struct ttm_resource *res)
>  {
>  	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
> +	struct ttm_resource *first = ttm_lru_first_res_or_null(&pos->sublist);
> +	struct ttm_buffer_object *bo = res->bo;
> +	struct ttm_resource_manager *man =
> +		ttm_manager_type(bo->bdev, res->mem_type);
>  
> -	if (!pos->first) {
> -		pos->first = res;
> -		pos->last = res;
> +	if (first) {
> +		WARN_ON(first->bo->base.resv != res->bo->base.resv);
>  	} else {
> -		WARN_ON(pos->first->bo->base.resv != res->bo->base.resv);
> -		ttm_lru_bulk_move_pos_tail(pos, res);
> +		/*
> +		 * Group empty (first activation, or all members were pinned
> +		 * or swapped out); re-seed the anchor at the tail so it
> +		 * counts as recently used.
> +		 */
> +		list_move_tail(&pos->marker.link, &man->lru[bo->priority]);
>  	}
> +	/*
> +	 * The resource may still be on another list (manager LRU or
> +	 * bdev->unevictable); move it unconditionally to keep group
> +	 * membership consistent.
> +	 */
> +	list_move_tail(&res->lru.link, &pos->sublist);
>  }
>  
> -/* Remove the resource from a bulk_move range */
> +/* Remove the resource from its bulk_move sublist */
>  static void ttm_lru_bulk_move_del(struct ttm_lru_bulk_move *bulk,
>  				  struct ttm_resource *res)
>  {
> -	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
> +	list_del_init(&res->lru.link);
> +}
>  
> -	if (unlikely(WARN_ON(!pos->first || !pos->last) ||
> -		     (pos->first == res && pos->last == res))) {
> -		pos->first = NULL;
> -		pos->last = NULL;
> -	} else if (pos->first == res) {
> -		pos->first = ttm_lru_next_res(res);
> -	} else if (pos->last == res) {
> -		pos->last = ttm_lru_prev_res(res);
> -	} else {
> -		list_move(&res->lru.link, &pos->last->lru.link);
> -	}
> +/* Move the resource to the tail of its bulk_move sublist */
> +static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
> +				       struct ttm_resource *res)
> +{
> +	ttm_lru_bulk_move_link_marker(pos, res);
> +	list_move_tail(&res->lru.link, &pos->sublist);
>  }
>  
>  static bool ttm_resource_is_swapped(struct ttm_resource *res, struct ttm_buffer_object *bo)
> @@ -652,28 +680,6 @@ void ttm_resource_manager_debug(struct ttm_resource_manager *man,
>  }
>  EXPORT_SYMBOL(ttm_resource_manager_debug);
>  
> -static void
> -ttm_resource_cursor_check_bulk(struct ttm_resource_cursor *cursor,
> -			       struct ttm_lru_item *next_lru)
> -{
> -	struct ttm_resource *next = ttm_lru_item_to_res(next_lru);
> -	struct ttm_lru_bulk_move *bulk;
> -
> -	lockdep_assert_held(&cursor->man->bdev->lru_lock);
> -
> -	bulk = next->bo->bulk_move;
> -
> -	if (cursor->bulk != bulk) {
> -		if (bulk) {
> -			list_move_tail(&cursor->bulk_link, &bulk->cursor_list);
> -			cursor->mem_type = next->mem_type;
> -		} else {
> -			list_del_init(&cursor->bulk_link);
> -		}
> -		cursor->bulk = bulk;
> -	}
> -}
> -
>  /**
>   * ttm_resource_manager_first() - Start iterating over the resources
>   * of a resource manager
> @@ -694,7 +700,9 @@ ttm_resource_manager_first(struct ttm_resource_cursor *cursor)
>  
>  	lockdep_assert_held(&man->bdev->lru_lock);
>  
> -	list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
> +	cursor->priority = 0;
> +	cursor->cur_list = &man->lru[cursor->priority];
> +	list_move(&cursor->hitch.link, cursor->cur_list);
>  	return ttm_resource_manager_next(cursor);
>  }
>  
> @@ -714,20 +722,50 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
>  	lockdep_assert_held(&man->bdev->lru_lock);
>  
>  	for (;;) {
> -		lru = &cursor->hitch;
> -		list_for_each_entry_continue(lru, &man->lru[cursor->priority], link) {
> +		struct list_head *list = cursor->cur_list;
> +		struct ttm_lru_item *hitch;
> +		bool in_sublist;
> +
> +		/* The main hitch stays on the manager list while descended. */
> +		in_sublist = list != &man->lru[cursor->priority];
> +		hitch = in_sublist ? &cursor->sublist_hitch : &cursor->hitch;
> +
> +		lru = hitch;
> +		list_for_each_entry_continue(lru, list, link) {
>  			if (ttm_lru_item_is_res(lru)) {
> -				ttm_resource_cursor_check_bulk(cursor, lru);
> -				list_move(&cursor->hitch.link, &lru->link);
> +				list_move(&hitch->link, &lru->link);
>  				return ttm_lru_item_to_res(lru);
>  			}
> +			if (lru->type == TTM_LRU_BULK) {
> +				struct ttm_lru_bulk_move_pos *pos =
> +					container_of(lru, typeof(*pos), marker);
> +
> +				/*
> +				 * Keep the main hitch parked right after the
> +				 * anchor so a concurrent bulk move of the
> +				 * anchor cannot make the walk skip entries.
> +				 */
> +				list_move(&cursor->hitch.link, &lru->link);
> +				list_add(&cursor->sublist_hitch.link,
> +					 &pos->sublist);
> +				cursor->cur_list = &pos->sublist;
> +				goto next_list;
> +			}
> +		}
> +
> +		if (in_sublist) {
> +			list_del_init(&cursor->sublist_hitch.link);
> +			cursor->cur_list = &man->lru[cursor->priority];
> +			continue;
>  		}
>  
>  		if (++cursor->priority >= TTM_MAX_BO_PRIORITY)
>  			break;
>  
> -		list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
> -		ttm_resource_cursor_clear_bulk(cursor);
> +		cursor->cur_list = &man->lru[cursor->priority];
> +		list_move(&cursor->hitch.link, cursor->cur_list);
> +next_list:
> +		;
>  	}
>  
>  	return NULL;
> @@ -737,6 +775,8 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
>   * ttm_lru_first_res_or_null() - Return the first resource on an lru list
>   * @head: The list head of the lru list.
>   *
> + * Resources that are members of a bulk move on the list are also considered.
> + *
>   * Return: Pointer to the first resource on the lru list or NULL if
>   * there is none.
>   */
> @@ -747,6 +787,15 @@ struct ttm_resource *ttm_lru_first_res_or_null(struct list_head *head)
>  	list_for_each_entry(lru, head, link) {
>  		if (ttm_lru_item_is_res(lru))
>  			return ttm_lru_item_to_res(lru);
> +		if (lru->type == TTM_LRU_BULK) {
> +			struct ttm_lru_bulk_move_pos *pos =
> +				container_of(lru, typeof(*pos), marker);
> +			struct ttm_resource *res =
> +				ttm_lru_first_res_or_null(&pos->sublist);
> +
> +			if (res)
> +				return res;
> +		}
>  	}
>  
>  	return NULL;
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 3f2812743a7e..7c7fc94b2d39 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -68,7 +68,9 @@ enum ttm_lru_item_type {
>  	/** @TTM_LRU_RESOURCE: The resource subclass */
>  	TTM_LRU_RESOURCE,
>  	/** @TTM_LRU_HITCH: The iterator hitch subclass */
> -	TTM_LRU_HITCH
> +	TTM_LRU_HITCH,
> +	/** @TTM_LRU_BULK: The bulk move sublist anchor subclass */
> +	TTM_LRU_BULK
>  };
>  
>  /**
> @@ -290,23 +292,23 @@ ttm_lru_item_to_res(struct ttm_lru_item *item)
>  }
>  
>  /**
> - * struct ttm_lru_bulk_move_pos
> + * struct ttm_lru_bulk_move_pos - bulk move sublist for a domain/priority
>   *
> - * @first: first res in the bulk move range
> - * @last: last res in the bulk move range
> - *
> - * Range of resources for a lru bulk move.
> + * @marker: LRU list node linked into the manager's LRU list for the
> + * domain/priority of this range. Acts as an anchor from which the LRU
> + * traversal descends into @sublist.
> + * @sublist: List of resources belonging to this bulk move for the
> + * domain/priority. Resources are threaded here via &ttm_resource.lru,
> + * instead of directly on the manager LRU list.
>   */
>  struct ttm_lru_bulk_move_pos {
> -	struct ttm_resource *first;
> -	struct ttm_resource *last;
> +	struct ttm_lru_item marker;
> +	struct list_head sublist;
>  };
>  
>  /**
> - * struct ttm_lru_bulk_move
> - * @pos: first/last lru entry for resources in the each domain/priority
> - * @cursor_list: The list of cursors currently traversing any of
> - * the sublists of @pos. Protected by the ttm device's lru_lock.
> + * struct ttm_lru_bulk_move - bulk move state for a set of resources
> + * @pos: sublist anchor and resources for each domain/priority
>   *
>   * Container for the current bulk move state. Should be used with
>   * ttm_lru_bulk_move_init() and ttm_bo_set_bulk_move().
> @@ -316,32 +318,29 @@ struct ttm_lru_bulk_move_pos {
>   */
>  struct ttm_lru_bulk_move {
>  	struct ttm_lru_bulk_move_pos pos[TTM_NUM_MEM_TYPES][TTM_MAX_BO_PRIORITY];
> -	struct list_head cursor_list;
>  };
>  
>  /**
> - * struct ttm_resource_cursor
> + * struct ttm_resource_cursor - iterator over a resource manager's resources
>   * @man: The resource manager currently being iterated over
> - * @hitch: A hitch list node inserted before the next resource
> - * to iterate over.
> - * @bulk_link: A list link for the list of cursors traversing the
> - * bulk sublist of @bulk. Protected by the ttm device's lru_lock.
> - * @bulk: Pointer to struct ttm_lru_bulk_move whose subrange @hitch is
> - * inserted to. NULL if none. Never dereference this pointer since
> - * the struct ttm_lru_bulk_move object pointed to might have been
> - * freed. The pointer is only for comparison.
> - * @mem_type: The memory type of the LRU list being traversed.
> - * This field is valid iff @bulk != NULL.
> + * @hitch: A hitch list node marking the position in the manager's LRU
> + * list for @priority. While the cursor has descended into a bulk move
> + * sublist, this node stays parked right after the bulk move anchor so
> + * that traversal of the manager LRU list resumes from the correct place
> + * even if the anchor is concurrently moved by a bulk move.
> + * @sublist_hitch: A hitch list node marking the position within a bulk
> + * move sublist that the cursor has descended into. Only threaded into a
> + * list while @cur_list points at a sublist.
> + * @cur_list: The list currently being traversed. Either the manager's
> + * LRU list for @priority, or a bulk move sublist that the cursor has
> + * descended into.
>   * @priority: the current priority
> - *
> - * Cursor to iterate over the resources in a manager.
>   */
>  struct ttm_resource_cursor {
>  	struct ttm_resource_manager *man;
>  	struct ttm_lru_item hitch;
> -	struct list_head bulk_link;
> -	struct ttm_lru_bulk_move *bulk;
> -	unsigned int mem_type;
> +	struct ttm_lru_item sublist_hitch;
> +	struct list_head *cur_list;
>  	unsigned int priority;
>  };
>  

