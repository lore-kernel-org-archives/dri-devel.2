Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E780CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2D010EEE1;
	Wed, 17 Jun 2026 08:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0A9NyqKI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FB810E99C;
 Wed, 17 Jun 2026 08:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uawYp6m/sJY/+a78cNKrcwYRQfwleiKePyEljVSmsXIbLvPV02vTa9y68hwyA0wodJy8BaMqiVqc3qyQpmt81HPPyloIxkC//1yCR+1VVjR2Ia68GvkY7QUg3IHZTL3VwKhE3zWoVrXv2jYdMVa7PSqMu4dF1H5UM5nbTZesRGpj45pPnzKBbMqHBHflGqFlTl5+iYG/lpH1IHt0hqUCDSIvig6Twdfkrgn7vN6AxEZKO8SRJnZzY81i1oQhEpyhbwTmgIkL2iTAKUir63KknUHlo9t24mVXyBKoAUP+S4Vx2u3y0Pwe9Z+RbFYjSmwq5owGa7cwEQH0EMtJTJWzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBXOhAI3knsKgtcCzGlkg0KN0ygRn3VCGp72U3aMmR8=;
 b=iWIW2EHJWRJ0Zj05KW7yQMWXMnBtUPYc4vWs/L7NCtdyYd7wqtzfoZ7HwWmgjeBRHULIsMvsl1AGvUq32+WIhcca1X8Grgjyn4lQaqPz5tW7y7xZr5Jqho8FicWAJCA7N0s80epMLix6Hqimk+F30Tr9JLLNGjrIKHvpebyFL6lm4BEbnteF4r/Y553gjxHqSgeiMFcDzgOTJfARQijT+cRlpXEvTw9DTluOs0TLLCexRBwPWkn3DAkbP4PhQfeL1li+S2ipZDDOiOKm03/dPpArKhFRnF2qNEDRDRXVRTeUKt/A2PcMn2Ii15wdAQwwmAKxsyCqChYbvaip9T6cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBXOhAI3knsKgtcCzGlkg0KN0ygRn3VCGp72U3aMmR8=;
 b=0A9NyqKIVjkBiMUBmayBOyf0eTWTGvVzcy5e5cfLyqdWASiXV/1nsl70hE8uAKo+7HQHsO1DNBnePYM377TrLCzLZuFToyMQb+MI9kMPaNMitzCmsw9N6Oh0NIvuQRCJogQrSeNioERaKpTr5sEiQgZsOl0/2WA4Z4vHfrhIQbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:59:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 08:59:25 +0000
Message-ID: <d6f260a3-3364-4e2b-811d-881564d133d8@amd.com>
Date: Wed, 17 Jun 2026 10:59:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm/pool: Try harder for beneficial orders
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260617022248.1165101-1-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617022248.1165101-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: dafd5678-f834-4a17-fe8c-08decc4ebb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: dIDz1yFhy6blA9CGEQE/aD4zI7ZbwYtxivIhcNvKvl5oN6oAEfUN9w/aSsLvKb0DGrk+EV08cHdaCHFcQaZUDorCzSE9d3IUP+4A7RcWUUNmB3tIP0lI9pLPG3hHWqp793KbeMttXKgItgqmF29sKqPGwZ+odn61UlJKgdQfrjfAYNWMhsJKnLIwq7hruFuUvh8qNM2wui/uQcOQlsx1PUXPD/nvLPuQgCIqG9hTDMIlZ0zmMC2Ut2xcoFQiMp541Uw+tKQnAO/lkAtGsGlHWtvtMxq9yJ6AQcoFSJ3jROvdhnL9I/1THpI+DlABYjyQKppOOFd4db6vQD0ZJcwDbrjygyT8o657mS9JYmmzN457+5ATsjSGmvpeivWe+lwFLNkoE5RrnUJGZoYev+T2z1mveoKbgD2rDKgdgIYypZR6Gx3WPCNCLtvnNIR95ININUOtfUWNORACbLKXbYwKHztdnvUviLECLeB2HD6KnQ31YVke8D/y/W8MJ1Vvt0ebcnF/fDorLSIRzQwC6wbr66CYKFGBBncGC1fknLy4fWlUDKWpbCD8Gsc1qwgjr1XDml6WKQbtJP3ZLyEXftknhSm05NHbERf+rFYmrAcZZLc4DoBtBdLDAQ902PyukGphH3tNmTfznWWxb/GM501bk+j431ZUBGA+6PVKxBaQiYD0pxnKrghqIMqXrmBq2nEm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUk3MXU3cG5uT2x0Y2tGR0o2RXFTQmJFdEZweFNCcnhWZ0dxSnRlbnFxZzI4?=
 =?utf-8?B?UzEyelp0K0U2VVBxMGhHaWRHc3I3L2JMRURsTUdWbWJkMzhBQUpqMjJlVVlD?=
 =?utf-8?B?eWFtamZWcjlUQS95V1FKY0NNNFRCK0lUSXhJVHlTN2NrWVlyMU1Ha05Zb2ky?=
 =?utf-8?B?OUJzaFAzK054aGp6UXZvL2tsRjBmUy84T1h3SmVuNXJrTmRsRHZSaFpMQnpm?=
 =?utf-8?B?QVRVbkM1NU5YLzlXQkg1ZGlPT0RtOWJXc0c4WVZDcU5mc1hEYmxRQk5yNVpx?=
 =?utf-8?B?NlhTb0puTEYvckRMRUNOaEw4cEpQckxEWEFDd1RTTkl2by9PdmZuY2RZU1NE?=
 =?utf-8?B?cmFyYStPMGd5eE9UaFdVTHZSRDROZFlsRXdkbTQ0LzFEMWcxNlpxallObGdh?=
 =?utf-8?B?RUdsdnZpc2FyMXU4dkFxSHlDSWcvWWtOcmlnRzBEck5sMnpnYzZJakxDMUs0?=
 =?utf-8?B?bHhWTWJLUFMyUUh2NkJUMGM5dnU1RnFxT0N6T3ZKUUcyV25EV0Eyd213M3Qz?=
 =?utf-8?B?S1FHelF1cnVTQTBRT0lTVllKbjI5SWZ5akJPUmNnOEh4cFBtNU9hb21kdVpu?=
 =?utf-8?B?NmNELzJubWxWbExrbXRwb3pSVm1pSmpWYWNYYWtYc0x2QS9ZeUhxdjc5MFNQ?=
 =?utf-8?B?eElGZzZXY2MwRHlVKzYzUS9YUGxVM0QzY3RQeVFPN1h1NnpYN2tkd0t1VmtH?=
 =?utf-8?B?VlNiUmxIYWJUY3FidGZ6c3padXE2d2tCcFc4dTRNaU9mUVRzVlAvK3BMYXVr?=
 =?utf-8?B?UEl6VTJhRmd4b0N4QllNZlRENUYwbzV2OURoZWZGK3dCL2NBczJhOElESEZv?=
 =?utf-8?B?Zk9xeTNEbjFNYXFRb0ZrMUsyVHlyRE1YUWxzcEUxYmtsRTJjdGxwdEJBRTYy?=
 =?utf-8?B?R3VRK21ieTFrUGl1UHJYTUFHcFRrRTlvbGdMeWhPeXhXVHljUlNVRWo0RExS?=
 =?utf-8?B?czdJamFESVBUdWF0dm9yMnFnN2FQNTJleTNIaWZLN0NvL2IwTlN4aGZNWWhE?=
 =?utf-8?B?NmJhNlA2TmU0Z2g5QkdNZE9ZZVZyMWVNQnNTTnV2MllFcFM1NGd0a1lkVkhW?=
 =?utf-8?B?enF1SFEvMVdHOTV5MHVieXFGSXZIc1V0czZCU1RYL3lxL1FaUnpjbUZCcUFJ?=
 =?utf-8?B?U2Q2ZHVZcUVzcEdqZkpidjMwVjRCUVJDSGxOZkRmQXFOQkFtcFdScEJ1djFs?=
 =?utf-8?B?azNHL0RBbmNHUmtCMkx5WVVWZU1aWG1vVURoZFVkcFJLRGtUZEZOU1gvYm9G?=
 =?utf-8?B?Q3d3MStwTXhNL3pxblBhRFcxUDE1RFhPMDhoN3Z4TndSdTNRbXFFNXFyNzNl?=
 =?utf-8?B?R1BzWU5MdWFZQWtSd2hHcDE5dTR0bmJSVkNQNktiQ0ZtamZ3OStlWW1QSkpi?=
 =?utf-8?B?MVBuSEZJRmluMDJlQXZIcm0xb2FJekxDWGNrbnpKbmx1SHZOTmpUN3EvMmVy?=
 =?utf-8?B?WW85S0dvSVNrRkpmY0ZtOGpoeHNnUGlKZnloaWdZTU1TV1puaGYxWVUxaVhN?=
 =?utf-8?B?a1pSN1ZiSkZtaVkrcm5kUDBHNFE5MThWdkIvdlFpbU9qblBHSS9ZYWNJQ1Ft?=
 =?utf-8?B?NENuYTN0NGVqOVk1R1hOVy9hTGZCVURYRC9DWndmWDNyd3BINlNwcTZWcUg0?=
 =?utf-8?B?c0liQ25Zd1VGMUo2RUxKMnNjUTRNbDhad3ZqS3VwU3poTTl1ZVRKVllFMElG?=
 =?utf-8?B?QzFlWVlnU2JKUDNHVG9HUFJHR3BSWFdBTTBuV053OTRrVE5aU04zS1pFZndV?=
 =?utf-8?B?Ny9zWVpwY3pZYm45YkRhc292Nlh3RTNKQzFOUVEwV1FRa1NnTEFEUWhKcEJa?=
 =?utf-8?B?QVlLWW56MFVuL3dFUjVzaDc4UGsxTE01aGp0K2wwV2ZIR3NWSG8vK0VaTDlz?=
 =?utf-8?B?RldyQ0VBWGhDS2ttQzUyWi8rakVoS2RhU3JFYko2RDJBdG94N1NWTHNwZUpY?=
 =?utf-8?B?NjdLdEZibzNkTG1Nd2l4QXUrN1I0TnNUSklnKytQeFh1TkYvbkU3NlZHMEFj?=
 =?utf-8?B?R2pLM054R0Y4b1NDb2g0djFzdTF3UHI1eWNaWlhhbU1VNzZqR0xwSnVSOWE1?=
 =?utf-8?B?SUkxWEk3TGFraWJmTWJvcldDWU05TThQYWgxTVd3NGhxTmxPMDRNcy95U2pH?=
 =?utf-8?B?VFJPT0N0RlAzNnZ2aE1teWNPSXA2TFRWYTNTUlUvOW1HMUFGd3QwWUlwejhZ?=
 =?utf-8?B?RkZOMDF5QVkzTjcrajJwSUdRVC9SL0RMYUZDMDBhU2dlVEZ4Yk41Nk4vMkdK?=
 =?utf-8?B?dHhpZnovSllHNnNUTGt4dGVDd0NRdDRxMjlrTFpGakV0bVJRZGNQWVlvYmts?=
 =?utf-8?Q?oyQBdmDo7AaWHap0Nw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafd5678-f834-4a17-fe8c-08decc4ebb24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:59:25.5249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0DeAmAsMdZ9hTaNfwgABZhFD9Kj3wL51KyzVdA5H0tUtMkdTcw9qGlk9CENphGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

On 6/17/26 04:22, Matthew Brost wrote:
> When a driver specifies a beneficial order, TTM should make a reasonable
> effort to allocate pages at that order.
> 
> Use __GFP_RETRY_MAYFAIL instead of __GFP_NORETRY when allocating at the
> beneficial order. This allows reclaim to try harder before falling back to
> smaller orders, at the cost of longer allocation setup time.
> 
> That tradeoff is acceptable for beneficial-order allocations: higher-order
> backing pages can improve TLB hit rates and reduce the number of TLB
> invalidations needed when moving memory.
> 
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> 
> Together with other Xe/core shrinker changes currently under development,
> this change significantly improved performance under memory fragmentation
> on PTL. In 3DMark Wild Life Extreme, performance improved by up to 120%
> compared to the baseline fragmented-memory case. GravityMark also showed
> approximately a 20% improvement under similar conditions.
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 9f0ab99eb289..682ae4f40424 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -168,6 +168,11 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  	if (order && beneficial_order && order != beneficial_order)
>  		gfp_flags &= ~__GFP_RECLAIM;
>  
> +	if (beneficial_order && order == beneficial_order) {
> +		gfp_flags &= ~__GFP_NORETRY;
> +		gfp_flags |= __GFP_RETRY_MAYFAIL;
> +	}
> +
>  	if (!ttm_pool_uses_dma_alloc(pool)) {
>  		p = alloc_pages_node(pool->nid, gfp_flags, order);
>  		if (p) {

