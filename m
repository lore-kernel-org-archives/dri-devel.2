Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8886CD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 07:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C439D10E39A;
	Mon,  4 May 2026 07:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SY6eqvl";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D59D10E39A;
 Mon,  4 May 2026 07:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1f9l+gHI0v3Qomhf113SJEtsFzp0b6ona5cPDRRamDAf0hyhIXjnxZkhwbLvfXW3X2RL2WsRrM5Z8SyDCkHyK5fYu5Wa9jQBKBV0H6p8sRESO1mSnNMG7zIUuhlFA2GBDNQza/Q50SVPyXTwFt6olmr7XA0moUehaRlSvO3veDF2F9QUgRMUOxlPzdbwyXEBg+kNo6y1cGvF1ODDhzrR1OaH+3XMcbHvORuQL6CJlHu0a0WmJ/37VHd3jPMbZJdQHbztxgSwMuZ4gIfdGFxPZ1rOuniigPPmCpKLVj7zgHinndr+fpSD1Yk73UURpJJfz0OjP44CykaTj+bpcvomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8No78vsUV9iIrICB0aMv53KlzZVZaArOhy7hPVdkd+M=;
 b=MHzuwKFSAMRBskAl160lCM6GaeFtMtFbhFgnUawR2KB7v335zrsGVozJgczdqiic7ZRKeeMsaNa+sUu4GaeYgWoaoYaVudsYtLYLVeap4QN11Zp8Kk3rcHqSsK1L2o1olubMa+2JYXHY1+fgpNFx0Zy2eHMGCv/ZsjZ19P0H6ZP1UEgDnqRa00fCmGIj9YaJtaEa/9H1zKMqyP/5r/C6J876Eo6UVFtb9R+Bhw72l8n91nFZg6xKG0KhasUNPASKM9a9ii8rGSay6zC4tWhxsLnikCYW7QXPbEbbmF6c4n72qMfSDaVidDrZqIr/ByxVQ4ctZFDBwaD9HJxrwHs/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8No78vsUV9iIrICB0aMv53KlzZVZaArOhy7hPVdkd+M=;
 b=1SY6eqvliadUZH/+21x62qj4rheH7DnPvPqZ4w+w9pkuEbW/Fk1L4DvgAIzCR7slsLcNC9CWBbSANUqfBogkKV6CeXHy4+7ytlHKSA6jMin3bz1sgW7WrR8F9P6nWwZOwVcS9W1b6AZ5FNSLAidC6jsANrg7yF+dho2EdZ+CVus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:16:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:16:57 +0000
Message-ID: <f83320d7-5c86-4b60-8bcf-788f12593e79@amd.com>
Date: Mon, 4 May 2026 09:16:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/ttm: Issue direct reclaim at beneficial_order
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>,
 Andi Shyti <andi.shyti@linux.intel.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
 <20260430191809.2142544-4-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260430191809.2142544-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cf4938-ed30-431c-2e2e-08dea9ad205f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CwzeeLsc8rjvih6zAu1x0bup4cDgopr7H8XLqHiEzd2/e8RrJNudtb2Da6oOMfq7KV8E55eCFuQrE7KwtmLNcTKmdyNHILFDfL6Ypz6jYnwILFMl++kR13IEhLhKv4DmFL3wvfYHwkTYOk8/9XvZvNpQ5rgMe6Yis/ftyUeHSDMkjICZVT6SUwrl0IM+IgkVm/RFV2BB/ASvn5YEV6arxfOyn7lo+4WMU/UgS9MYPHAncUyXpdVK1U/qZudt/o+ngY7d+RasTKiUCBDNILab+IEweB29VOvqaj6yy6UZOZ0WhCf24w2qShKQDSLssonQXg/BfmWSEWN3j8t+FW7Y5P3e1f31iIbRMPVP1ZU76w1R1hREm1REpSJROOfLr17FLtL6nYPLf9MQun+z8SMo/1DISHM64gxXzBlsdehr/FtOLnq63C9eH29FI5pNNfH/9TNzCOxI22g65CvC5imIMXxdqAwv7Opk6XF+TTblFae6DciibUavsHvBrt63zPwbvHXUhVBAWqkObXrCuqka1hXr51hpQ40+sKPVnqmDuSO7VXQ4WAiWgx7im85jkfD5K6LbwfUjpgTXEueDNO1WeFXaGKrhEw8493dH3sNe/xF5mxYjE4Y/oQiKxZJWTrA13bnWJ4LSK8y+41/pCsE3riq6fwMhuG3ZpTLj0dGSfchCPDK/5JnIXS6MKgRx+x8+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhIU09uTWpTMlFxMUZpN1hpQjRmNUZRMEJncXYvVm13bHg1NHdRMDB2bTFn?=
 =?utf-8?B?aGVjcXRNcE9qWFE3bCtJK0xmaHNWeVVWSXlyb3dMNUpFMHVvd2FweFZBKzNv?=
 =?utf-8?B?M2tuNVgwWUxtOEs4SjJJYXpNLzB1OWxjdGdYTlpza3dVN3o4cW1LRnYxaW5y?=
 =?utf-8?B?VnpLRC9NKzJtVlhDdi9YTFdZazRIby9RMzRVOUhsSDE1WFJzdi9Bb3l5Zk1B?=
 =?utf-8?B?ZkJSWUJLTGMveXV1Uks4LzdnblFrZUxzQ1RVMWdiem1ZZ0djNXVhdVdsMVpw?=
 =?utf-8?B?cW5oc3pEY3NHNEYxSi81RktDaUVKV0tHaGNXd08yeEJXSmcrdEUzWDFzR0JF?=
 =?utf-8?B?MG93UjdqcTZ6RkdYV1RKbnQ3WnhVckhKcEQxNENoeTRvQWp0L3JvblZ2OGNo?=
 =?utf-8?B?YU5Uc2pRNndKSVlFTjFiN2tiM3EyTkZWWWI3Q3hVczBWWC90Y0cwdVZyejZ2?=
 =?utf-8?B?bTRwT0R2OFE4OGZRbFhBcFdiQmxNQzVVdWVURUdTdmFhMExPa1NHblo0SjYw?=
 =?utf-8?B?R1d6dVp6cStqeUphalkzMWVYSVVTc0xaZHliRGxqZStWQ1lRRjQ5MWc0UWht?=
 =?utf-8?B?QWlVQ1V6eENjeEtPbDVZaktFUUlSVTE4VnNuMWd3dEZNcVVyUVFObzNpTXFn?=
 =?utf-8?B?dTI3NHpKRWxiZzBVNmNDbVdiYkpBRXp2VjZxcXNDaDdOMU1iS3VyazYxWnpY?=
 =?utf-8?B?R1E0NXVuZktWanJ3eFVKZHRvR0ZEQkY1Sk1COU1XMmwrWWFycy9Jc1hoS2VI?=
 =?utf-8?B?cWd0Z1BrMmUwZHBmdHVuWlBuRUlTQmo3MVZjKzZIRVR6d1BGV2JnQXZNUG56?=
 =?utf-8?B?V3U5MnVtOHgza3FvWlllT0dZT0ZLd0NzVW5UZ1VCbXBaaFJvZzBUWTU0M2xN?=
 =?utf-8?B?QWhJbGpSZ3UraEpoSGthNzdqazExYWJZZkM2TlI3bG1BUFVvMjNjaG9GL0RL?=
 =?utf-8?B?YUlCbHBoM3JmYXQwbTk2REhwazB2V1oyOXI5NFYvSkZ0L2dDOFpnZFhocGtQ?=
 =?utf-8?B?OURLakxwUy9vTDJ2OVdUS3hCd0l4dEJzb0xVNk1jcU80Wmp6QnBTU2tQSHFO?=
 =?utf-8?B?ZlYxSHVNZnBkamI3REx5RmFhQTAvSkpHOGZ4a0duNlBjUmlra3F4WjJDRlhx?=
 =?utf-8?B?OHkwNDN5TEl5SUVaNVkyRGEvSVIwR2Q4STU5WVJ4bzNwdWFrREQ1bjJxNjZk?=
 =?utf-8?B?VksvdDdCcXBGUmswUjBxNzFTZjhMVURkZ0tNVlBIb1pQdzRyWGZvY2RwbDJt?=
 =?utf-8?B?WDlYcmZ0SUllYjFqZHM0LzlEWm1RRDN3b056Q1JwWlJBOTQ1T1Zkd2I0TlVv?=
 =?utf-8?B?QmtvOVE1UTZVOHh3dis0OElIdkNSeFd2QVg4cGhlL2h5cU5lTHZGK05neFFL?=
 =?utf-8?B?VGdwZDlKTHdIajhPeUFOZERXa2NpNngzU213cllNdm9aTlhGVVQyZ1VHbTJn?=
 =?utf-8?B?cjN1WERiNGxLWkdGRHVjY0t5U3lJcTliYzZjUXhFd1F4TmdudGNoYzNtdm1u?=
 =?utf-8?B?Njc5cXFQc1E3S2xHV2UzdkFiRE55clVjQ1RHeFJzZ2JXVnhqK3V4cVRxTnQ5?=
 =?utf-8?B?WWFkYXpORzdWLzlUZGxLNk96NUJKNnliOG0rK1RMaWZmMExCNHZIVHhIU2RV?=
 =?utf-8?B?TzdjMW5mTHJNcjg1b1Z4dWVqRnBscUc4RFo2VEJjOUVwNHNYV2kweXpPdEtx?=
 =?utf-8?B?b3M5UjNOU0x5cjhlMENTMDlHZTJmNzZGZTJTNzF4RWRkT25KRnhhZnUrY3Uw?=
 =?utf-8?B?RE1XVUgvUEJINWRtenFQYlVabnVHZEF3ZWx5bWE1NEEyN2JFVDAvZkxPOEVK?=
 =?utf-8?B?MHgzbzEvZ0RLcGdaS0VWM0VsaUR4T0ZQNlF1RjlRYnBGaEdINENYQXM4MnZL?=
 =?utf-8?B?L29TNDFKNGU1a29nUllvdzZvRlBDc0NSNTdsYXN3aE1mS3lpbnlyWkFWdkxn?=
 =?utf-8?B?UElBejdrSE1iSW1IN0hrWkk3YUZnenZwR3RzclRTNWdMcVVxc1hMUlduNTFi?=
 =?utf-8?B?ckw2L0c4MzVVTkFhSFBIUlJJejZuVVoxRGNxdmt4WUFhZ0pUTTM4NzdlZUFs?=
 =?utf-8?B?Qm1aUEZEUE83OUllZkpwdmMya05xQVlNK21UUkY1Tm1TdU9PQ1NXSG5SUks0?=
 =?utf-8?B?Z1ljVERMdWxrSU1Ic3ZZQjFXN0kybU9KNmZ4WWRydG9tUldraFJDSFFET1o1?=
 =?utf-8?B?R1phcTJMcWpCSDBBdk9LU2ZnOVhyampNa0VYWU9jeWtSTXljcXdCV2Q2T1pt?=
 =?utf-8?B?a2xnNXl1dnByait5QXU2VVppazVidmFvYmpmVFhkbkgwTmZiLzlvTVhSOWJx?=
 =?utf-8?Q?/BA/vKED+VrVIiuXhK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cf4938-ed30-431c-2e2e-08dea9ad205f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:16:57.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIi+9BKtzgmDhDVWNCJXmvT7vOFm2jJpDu9KpYoOhn1ea0HozOoOk4ppXBXFuR8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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

On 4/30/26 21:18, Matthew Brost wrote:
> Triggering kswap at an order higher than beneficial_order makes little
> sense, as the driver has already indicated the optimal order at which
> reclaim is effective. Similarly, issuing direct reclaim or triggering
> kswap at a lower order than beneficial_order is ineffective, since the
> driver does not benefit from reclaiming lower-order pages.
> 
> As a result, direct reclaim should only be issued with __GFP_NORETRY at
> exactly beneficial_order, or as a fallback, direct reclaim without
> __GFP_NORETRY at order 0 when failure is not an option.
> 
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> CC: dri-devel@lists.freedesktop.org
> Cc: Daniel Colascione <dancol@dancol.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Christian Koenig <christian.koenig@amd.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 26a3689e5fd9..8425dbcc6c68 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  	 * Do not add latency to the allocation path for allocations orders
>  	 * device tolds us do not bring them additional performance gains.
>  	 */
> -	if (beneficial_order && order > beneficial_order)
> -		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +	if (order && beneficial_order && order != beneficial_order)
> +		gfp_flags &= ~__GFP_RECLAIM;

Just one additional nit: The subject line says "direct reclaim" but we disable both direct as well as kswapd based reclaim.

Potentially just update the subject line.

Regards,
Christian.

>  
>  	if (!ttm_pool_uses_dma_alloc(pool)) {
>  		p = alloc_pages_node(pool->nid, gfp_flags, order);

