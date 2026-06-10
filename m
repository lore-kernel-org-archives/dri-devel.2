Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B0CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F234A10E82F;
	Wed, 10 Jun 2026 09:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBr8TtgQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20D710E82F;
 Wed, 10 Jun 2026 09:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odqy/eMGnAoNmJEJeNAHWAfNIl9r9g0HuLNXacbxZWmwvLzQfIf82olID+WieizfikThZpP/Qr5ocYqNp9KfVM6gCd3SdKqNxxlL47eQt4CXOCC5cnfycqQu6S5fBvqKl5oj88q1IznGnai8KXUpuvX8g3Fmkk4yyu+7813Ix30mCscxgRyjeGhodjWrsoZEj1bXfDHljl/k7MxSRi23WD70ERziY+Kgi0/bJ3EK8xkUY2/wM48HRy1UmI0oaDxYE2oyRn2A8i3Rq6ccRQPdYL4SNNU4mcV4JIt90GxY7v8JbLjvXu0UKF00/pvtyEc/DdMhSvDUh6/1+Q+XUzmwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlWrHUinfWyOsgh2U3AirqBlQMjF4JGd5UjNeM3VMtg=;
 b=h82EtVtOa7az4rBXpj5T6znrzCWjpk2aUkwcby/3nVzDDdkdhXf7EmBAV9gVKHQVSwR13J89sejm6lKoCMQ+UURhq2pNHt9gOmwSjJN7rDeFh1PA5tIR+DtoYakLs2p7G1+7n1gjSeFXhdSFj34SvGuKhJ3pvklX8CHc5Stp3Yqf86FkIfrQgNNjP2Vomd/cDwQS8RE27pxcl/2ts5IdTsz7dWD8VVZI0pBjX9mujKMiP1nwwJE6+42RjJgYcpgdo6ILNFgd57WsRGOilo3ZVnKdaUaDp9vw5wn+zGV1Nu4bNJZ3LO1fY9awuDmwaR/vtz8jOn0GXpudLGNabAuv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlWrHUinfWyOsgh2U3AirqBlQMjF4JGd5UjNeM3VMtg=;
 b=ZBr8TtgQ6fojGTDNLPgW37HQh6r5QG0MlwBpqVV2ukwKZZQAhOd92qWhYRyPIxqH4Nf31LRxCDpBzFtus39iLmzTV6GhFqktyjHE2IsLE84VSYg7okg7dn+AlfbEdOqQI4AqOis3BxbCqyke3fqKL1xyew1jssW8MSRJyz7by5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:12:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 09:12:54 +0000
Message-ID: <0b2d96b0-59c5-4ca7-9404-90f313725ba9@amd.com>
Date: Wed, 10 Jun 2026 11:12:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Document weird looking bugfix
To: Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20260610082602.1292853-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610082602.1292853-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d1786a-4fed-4ed0-dbcc-08dec6d07443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Jgjf8QkzcrWjivmk6NRhcq7jdWQonDfgRnOKX6A/w4rTPJ8Go2LM6O3bCwoS6bymOWy6JEAu0SJ6JIF3lulrqKByLhiEPH/fm+j3lEheNR0x0c1Kvp2NSaUzaM2H2gZdtPD4GoO9pYkGlmFoVXpP5atV92VghMzVZ4YtO3Nw2do3O3Lp3/d2ifZZIbqJzj3TEU9UPnZw9GeKpxE6H+wTZsI7xJCY1Rk6LhXsFRrqReMtFBPgPyTvPgr7pjvaYtdDEXJUGC0HA6BdS9FkyOSXAuPu5/NdLvNQoH8k5NSDDt4sieq/elIPquStzeHhiEi/dMoTH2F0EbAQg69fj/vT7r2C3f1vbq44RqkqEJ2nvabWZlpdvtLgA+kk1f+SDvlmKPE2gt27E6qeXesKmr8OQbZQ4mQ5aCWPsBa4XyIZMJQHH8Se21rSvnWcuk90N2AfRI6awANwVkbcAxIrgUTuZkRaSiL7deSAo1q/OQo/4g4DlxsCn9BEWlshNPG30ZpoCs6Sz/+GJrQZX7iO+ZzGCgftH5KaF1oW3zEnRdxXxEkuQPG0YfScOCvt01bb4PnWfmFku43JSLBCjGyxZUU3SCw28H6+sNsKTwWifVh3/U2Mn//Ayoy22wO02XIn623XJ53PVp2D9n4HMQND94+9WlwLwQWIIpYektMZDZGpgdug5h6UVAuoOqk03toOEXB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRoVVFVWC92RDdjUExuT1Vhek1ZWGpKb2ZqYW1wL1dJNDNEQVFCN0pyZ24w?=
 =?utf-8?B?Q2ZVVUpqdEhML0FZeXBCeWhGSXJBa3JJNGtHZkc5YWxrMXpMbzRKS1lzMFRP?=
 =?utf-8?B?dytwSlR5Z1lDOFd1K0FiekhIZmZFckJUNXV3ekpiTTRQK0RtTzZNRityaW1O?=
 =?utf-8?B?aFdibm9zYk9ZdnNwREFma2I1eFJadkpvRERLU0E4cWJ4UjVPQXNOalNzWHFO?=
 =?utf-8?B?a3dFREVPQ0hHaVZVTGg2MWFGajJkRzEvQWREZjlNbkRZQmpSYnltU0FqREZI?=
 =?utf-8?B?bU1sd2pOZXh1MkpPOWp0Z1EyY3hjZDhzOEJrZUphR1ZNSjlZKzh1ZmFDcCtv?=
 =?utf-8?B?TnBCSHVNcnBRSXEwZGltSkx3SlR2Qm1qa3RhWml1SGR1Y1RFVlpqM2g3RlNv?=
 =?utf-8?B?UmlQL0JEY21BeWJkVDY2YlIzdk1lZm4vVGphYTVJeEFpOE12NDBmYm1tdG9m?=
 =?utf-8?B?aWxYbEdCM05QakhFSXBvT0ZyUi9RenpHTkJ2RmR0RjJHaEdZTlhPOC9IZkdU?=
 =?utf-8?B?NytpNENxK21RZkN0MHJuK01KRFJ4aTVObTNEVERDNEJlUzZnZmVyUGhxYUN4?=
 =?utf-8?B?NUlpKzdXdXhONlZBVlBGdGh4Q3IyMEpZbTFFNklwY1hrREs0UkRiVVBPSXpt?=
 =?utf-8?B?QnY4cGdvVnIySXJGVEdhMWsrUWFlSjVHTys1Lyt4OXd1Y0FMMVozd3FLQnhx?=
 =?utf-8?B?UHNZbW1idUc1eSt5SFpxYTFITGlHQVoyUFBaTS80SEN6bFdsSlVZVUgyMkE3?=
 =?utf-8?B?MWlkVkNIZ0UvYmZxaXlITVZIUStrSDNNWkllcHVIMUtrS2RmZ3V3OW4zTW0x?=
 =?utf-8?B?SjYzZEZFVmg1SG1xTkVCdmVJWDg3L0ZjMEV5bWc0REM4a2hVdGdjbzlENktL?=
 =?utf-8?B?RitabVdQQ2dFcU9yZFFhSDBUTjg2WXZ2WGNaa25vZFFWWmNpOXJvRDZZV01z?=
 =?utf-8?B?RHpaZUVnazF1c2RPL0E2QUs3emxYaFRwRmFGWUxQazl3ZldyWmppSE5xYWRO?=
 =?utf-8?B?SndTUS9sME9jKzBsQmZ2NFdSdXRCOTN4RTI0WTFrTVJUQjNpb0xnaHl1clQr?=
 =?utf-8?B?RlZWMWlNbzBmQ0pxOFdqTXBydk54VDBuTnFGSHFoYVZObC8raDNicW00K1lK?=
 =?utf-8?B?NytSQ0szSGZiMnZzRHN2Z1lEbnpCMHJzeVZmVnJQdDh4QnIxUk1PdDMyWDU1?=
 =?utf-8?B?VmlWcFhxUHNwcTkyZk9zYWZacW9YOHJBMXdVcGRoUHR5YURUMm9zcmxjdnRN?=
 =?utf-8?B?VW9ZZGpKakNrL0hlV1NjUlgwa1I1YUcrVURwOHFJcEpWanJRRm5iYWM0cU5z?=
 =?utf-8?B?VzJON0NxTFVvODdseXM1bTY5a3M0UGRvbmpabW5RcnVTSTlhR3dLd3pHT25S?=
 =?utf-8?B?c0FCaVA0ZTlwS0pwT1pobGhvN0hYbkR6Z2FFOUFtSGM5UktzTW5RdFZnQUF5?=
 =?utf-8?B?U0VPSjV6NjlIYjlMNktCWkh3Z3dFRFVsSVY1Z2hYc3Evam1CUWI0OTIxYXFS?=
 =?utf-8?B?QzFwQmZrMThVR3JTSnE0NFg3cENWaFAzRUxxcTB5djR4bU9HS0VPVVk3U0Rp?=
 =?utf-8?B?WjZEUWdBbVc0K3hFbUtFREJXVEh4SnQ2dVdhSVVLZDY4RnBqUWhVeWdTbEZP?=
 =?utf-8?B?QU9Hc3VwZFJ5VERhVHZrU0JBUDBXV25GdTNRSXNJOTBzbDk1OWk2d0Z5QVBO?=
 =?utf-8?B?N0NyNHNpWExwR25MZUhPUG41Si9qeFR5R3UySmp1OTZsTUxnL3RiSVhZZXB1?=
 =?utf-8?B?aWRaVlNGN013enhmcnd5Mk5DYzhFYW1RRFBKbWJVaGZKUXQ3TFRGSSs2RVJw?=
 =?utf-8?B?M3Vjd3hxUHB1b3BkVjZvOUpCckhhYnI3UlE4VmZxdEJ5aDNyUUtVSjhXSHlS?=
 =?utf-8?B?R3RXeFhWdUN1Wm1iZVFIWjlhU2M1UDRMZjFNK3F0MklvZTh6b0RWa1NGQVhX?=
 =?utf-8?B?YzZpbERPSk1wZXVGaXRtekN0QmFVa29EWFNDa0pvU1VJTTFnMmtMazcwNW5w?=
 =?utf-8?B?bU9SN09wNC9oVk5ZQVN1eEVFalV3VmpDK2x4bHlDQVhHZGQ1aGl3M0JPZE1t?=
 =?utf-8?B?dkpKSzFKKzJCV2NwYm1XVU93Q0w0TTNXVE9oa2JZMUliUkpUMFYxdkhPNEZG?=
 =?utf-8?B?ZExXTXFPRVdrdWE2S0dweEVzZzJ6UFFJZ3ltb2VybzROY1ZHcGphdXdaNkU5?=
 =?utf-8?B?Q0ZqeE5PVUd1YlVXUXhpQ0RZVVZBTGRPa1dnSWFXamFkZzJSSnRIeVhtZjFv?=
 =?utf-8?B?WC82K1B0VXRUWjVZQ252UVdQM2h1L21xWDJtWVozd2dJejFtZXg0NVpMVlZw?=
 =?utf-8?Q?rcpLlWm0TTze5YRD2n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d1786a-4fed-4ed0-dbcc-08dec6d07443
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:12:54.0430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEfDSzadS1ivWowybTIp/JDxofPcqUST45nGDo+/icm8Ei9WIEVs9+++C0nVUgnq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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

On 6/10/26 10:26, Philipp Stanner wrote:
> commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> fixed a race. To do so, it replaced the automatically locking
> dma_fence_is_signaled() with manual locks plus
> dma_fence_is_signaled_locked().
> 
> For someone browsing through the code, this reads very much like a
> cleanup or rework leftover. Future contributors and / or new maintainers
> not familiar with the history might be tempted to remove that bugfix.
> 
> Document the bugfix.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> (I did not test this)
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 42a81166f3a9..519a0c164a72 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -159,6 +159,13 @@ nouveau_cli_work_ready(struct dma_fence *fence)
>  	unsigned long flags;
>  	bool ret = true;
>  
> +	/*
> +	 * This is not a cleanup / rework leftover, but a bugfix to prevent a
> +	 * race with someone signalling the fence. The locked
> +	 * dma_fence_is_signaled() cannot be used. The dma_fence implementation
> +	 * is not fully synchronized with locks, but also uses atomic bits,
> +	 * which can cause the dma_fence_put() below to be executed too soon.
> +	 */
>  	dma_fence_lock_irqsave(fence, flags);
>  	if (!dma_fence_is_signaled_locked(fence))
>  		ret = false;

