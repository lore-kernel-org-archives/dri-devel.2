Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E8BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 10:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCDC10E25B;
	Sat, 11 Jul 2026 10:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M9lYh8xa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B66CD10E25B;
 Sat, 11 Jul 2026 10:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGWQR9VbHwKw7mvhRTHEpM2vczS2r9egtLm2pFzeleHutFYb/W2YI8JzirWlFypVos17LpjJ5OgK0sPJH5NQVRst70KIuqGqM/5BNQnfN9tR7g5j3ICDbiNJAwUd1mm/GSZTvNF1sdEAjbT4eM19KnJ7PwubtcPKJiJMlC5LBo/aYPMc1r7pomF2DFgpzsZ9b03EynY8+5f2l3nUVZFZkoJWablki5W2FC9xfEEip8eb9uUJMzAgh5yUFmZlXXKsrZqJfZ0FmRGm7v7ZM6JmDxetwMapdSGy9UpJB+TVxvPSsdjdbf5NNtFFQp3YE1tMj73aEMhle7WdT7EqV3PYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFP889MK1ovxcODy6j1nw0VAfiMUwRQs7Vt/nhnD79A=;
 b=eW/uxusHcC3CLV91W2Z4LAYpM5jJdlofjsY670mrXIUY6rx/8N4e/9UnfSbCWsVSgJEm04dphcSRPp5YcA9vwDaDQRvczW5ljlsdg7NWl8tUeNkRg9AIduZGuxXrZ13p20lrkUsJNUL0Fd+fTtDmZ4DNJprlIcsr5AGt6fgmXAY0auQn3wDwcmdXLz3uTmbILqDzEl/r/zL4VwCl4FiHb39bS5PX5VP9gtG3Rd9DgEfNQc02BO8CEmNGAhRabVFwhBEYKbh0DYXxFWlXi+VQIg0BQ5qdZHf0jg+HIR7TgAcR8o23E05TXot1+UySCjoWsnCjTz5G9hyRXUBUYxjDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFP889MK1ovxcODy6j1nw0VAfiMUwRQs7Vt/nhnD79A=;
 b=M9lYh8xaWC9ZlldxDhM+2GskacU89hSAym8rnywKhUXGWl9lrJOiQNFkt2/2lRFEJTBrNNRi1E9Uw0N6UBqX8MYpJw8ffHfAy/KdG+so3PfZBZcTbBZGuV/mHglp5ym4aKytkh6l/y/WwWC4xsKxHYF3po+8SMrOaGVlShZJQKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999307.namprd12.prod.outlook.com (2603:10b6:8:41a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 10:39:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Sat, 11 Jul 2026
 10:39:43 +0000
Message-ID: <7e1a098e-927e-4dc5-85fc-c7081c0c10c9@amd.com>
Date: Sat, 11 Jul 2026 12:39:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/33] drm/ttm/pool: Add ttm_pool_page_order_nodma()
 helper
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-3-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260710215442.2444235-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999307:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e88e9a-de9b-4386-74fe-08dedf38b815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: F0Dkh4kbVbQ6/4rhkt4b+crO9qnEMWvCP4WBY8Y/6NcMuZU8+LaGKnAqoVvHmK5kjMcDKU1TOTaEDCsF+5XgArY+VaieqXCzBwN/W99M70lk2NjPpnR4QDiJ6rMNLd+gr/Je63h2jhem4tdFpMaMIfJBWuDLTnvb+3D683NFypK2zvPiOiK2n8xs4wXyevfcw93QVY+dPkVnp0+ZIDm/r9SdzqTwY2yMrEXxeoBw9X+32Sj7po5+DLHDU61cd9ogoDUOnKjKffociLbhdAfHwjEFFSHWf2yA+CzDZn+PBI4rriBjh9I+emg9Xi0IDuMteuq3vu3q2jjAntClG2ZZQuk7DBeIXGMhEyzotrwvYmBWCs2Y8XKvq0Anx2WN8frKqsLKyZZDGDvxjtNIasjDacHd17teqZeWWqKV9P/Njqo1k7OFjcB55bQOHwjHbXjb8q/OT0FC4bNW22Ghsbs80dDTIRGOTCNDelOsEBpwxwFrtOKRQhjwxCvQTH/H12lRAIKcQn+AkAhwKMEm/5pzXevFKxQhqIsukZIzPGxnQlP7H4ZnDVT1TPyiEUi2KlCqiJkr4xL66PB1MszLN2j933sM9NxFVNgtldCbhjjTkM/ixng/28ACbjOb7XRXqFvxg18d//30Zs0aMCxVTb6FG9IRg2MIBXyyfvJwfux1jng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hocENFaXNrTG9YY3BtR0w4WUxZbDRKbVU3ZW9SL2tRUndCTU9uNlgxMW02?=
 =?utf-8?B?emRBOEpOU3BWZy9IcHNkYzVLeFpzRmJaNllYY0VsRFZiQXRKbEZlRUxSZUhS?=
 =?utf-8?B?MERudW1OR3UzV3ZDamlwTzdjRjNsQlg4NlFvL2J4TUJ2OWhBbmtvc0Z0TGc5?=
 =?utf-8?B?ZEx6U0NueDBNSFBrdkd1SXR5dUlDQ01McHR3cGVxZlA5NEFOV2QzSVB5aklU?=
 =?utf-8?B?M3dwSDZLaGNFMHFTREFxZnZ4TjcrSWhra0tJVUxvTHMzTUE0LzNTWWhTQ2ZY?=
 =?utf-8?B?QUVBb3E3Q2FDTE1ISlM0VTBncHhWWmxIVFluRUk0RjE3WENaMnNXRzgyVHhS?=
 =?utf-8?B?M0k3TWNzM3AyKzhkVFh5Qmp2bVJPK0Y2K0lFdFFLbU96VkZ1MldndElRdFNM?=
 =?utf-8?B?R0RUVGpsM1A3RlhDZUlJMDBmdHdFNGRCWUxIb3NlRGVkaFFuN3Bwc3pFZXVp?=
 =?utf-8?B?aW0xckdjVGk2d1VaM1JCM0IxZ2lMZElaV3FndElWaE9UV2dVZUpRbEYza1Ns?=
 =?utf-8?B?VXpvU3ZOSkc1Ymt6MG1pREFaeEpLSjZOcFZ0TG5zdndPd05pb2kxRS96SlVq?=
 =?utf-8?B?Yjl6NFFsTDVyVmVnOVQ2NE9VRUlyclh3cTNMNnBBOHpWZVlTZTA5NWM0c2NJ?=
 =?utf-8?B?dXB2d2lITG9WV3haT245UEo3NVNXeGNsa3ZZZmNMZXlCNEc3NDB6K3ZnMGJl?=
 =?utf-8?B?dEJoQUkzMlpRUUprRzJNTU1adGtKdHpmNHppY1NZMkFDa3Y0T3RDNEVOdm9L?=
 =?utf-8?B?Wm9YeUxCUlErUld6eisrYXpNQ29KTEg2ZFV0cDZrSXRqUFdhTUhrYm0vd2dj?=
 =?utf-8?B?UUhCQmpZc0tVYVN0ekZUWVdBNGtlNExUS2RUWHZqbXdqTHJwNUlpeVpaalpE?=
 =?utf-8?B?Q1pWek1kK0ZZYmloTHhaYWo1ei8reG5lRFlGQXpraW9LTWNGdE9NRzBZVXJu?=
 =?utf-8?B?Q2g2YkFXaHpTSTZ2VDVvMCtlbTJ3STBBeUM0S0FxR25hcXBvUG1pRy9BcnJ6?=
 =?utf-8?B?cFM2MnR1WTJZblVTQW40eWZLZVlINXNGaWtwU3IvNXFPN0FsZnRRUzI4Q1pE?=
 =?utf-8?B?c0xtcGlGMFB4Qjl1Z3JJcUU5USt1UVF4WDl4WTVlUjU2M2EzR09NSlNsRmdQ?=
 =?utf-8?B?Z2o1bHkxWWZ2ODBNRFFMZTFaaHR6VnBDanByUnByczBXQzZNTEtEa0NjdjJT?=
 =?utf-8?B?L2NzM0hJMUVCbWw3SUsrNTlZQUxYU1c2emdCaXE5SGMxOWp4SkJ4WFRIT05i?=
 =?utf-8?B?UHVsT1ptRzFUdU1ZL0dJSk9aRjcxVnNZbm8wcFFXMzNybmllckp5THlobXJX?=
 =?utf-8?B?akJQK2VCYVd1Mk80RUNyTnc4N2lnVHRHOUFyTUZoNGwrSHFhSDNhckZXQ1oz?=
 =?utf-8?B?WGNxQ2JkOStYczdUNmZLZFNKSEk3V0N2V1ZzSVB6NnNCdjlaK0NLMU5NQUgv?=
 =?utf-8?B?SHNndytab0ZXbkJPOHdkd1lKN1pkQlRvMk50cEV5enFNUGszbmRlQUpmblZ0?=
 =?utf-8?B?dk4zZG9VdmJXc0d4MktGcjRqd0p1L3lOdU5mVThXcGlsQndpOUMvcWpVV1Z2?=
 =?utf-8?B?R3B6YUpoSnlITlhkSUtSSit3QzJuUVVoeVpPNUV3Z3NNUm1wcHVvODR4czFa?=
 =?utf-8?B?bUNSZWtUakM3Mm1VZXpwbjBaL0hYd2VyVG5UWkQyM3diZFFFZGE0Sm5FMEQy?=
 =?utf-8?B?R0Z5dDNVUmxRbTNncEMvaEExNWdVbWhmMXBDTWdtZjhqb25UZDNNekNYMkk1?=
 =?utf-8?B?RFcwOVF4MVptejd2LzREWDZIa3kxbTNGM0RHc0Zneko0TkVzbTJRY3RNcFhM?=
 =?utf-8?B?ZTNYQUtEV1FWVkUzU0J1Qm5laW9wNndmcVVKYk5wTXBUeEF3bWZGdTBqVGFF?=
 =?utf-8?B?MW9RUHQrb3hSTlZ3TjZzK21tYVdHdkNCc1gvMU56ZGI5VVVmMTdsWWNIZDYv?=
 =?utf-8?B?cktTNDBSNk5aamhMczhic3JoQzB5N3VNSXUxbGhVZVk3cnJZWjAydGo0R1pH?=
 =?utf-8?B?TllSbC9wcWRIbEN2bWRjRHRBc3luZERMZ0F3ek1nMmpZNWhrM2htSFRMR0dM?=
 =?utf-8?B?TFZwQjNzcjU0MTVUblhOVjZYWEdsRTZxVkdBRTM1Yk1BbnFTaTNLaFd0RmNp?=
 =?utf-8?B?czkvdjR0MUxQSVpocDkxeUx5a2pQc2x3dkRPbGhNZ3ZPSjMycWJHU3EvL3VF?=
 =?utf-8?B?THVpS1BMNTRYelZrbnowZWZxWnB2bmhBZzZMOVhTdDhGU1VFUGhKVHZiNkF4?=
 =?utf-8?B?UDIxVjQ1U1lKdWI5OFBuUkVrZ0NaL1IxbXdVM29PZXlTMFBBcVFrSEhGQ0px?=
 =?utf-8?Q?aC2spcDxgGZggoNiCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e88e9a-de9b-4386-74fe-08dedf38b815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 10:39:43.5637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdb40zVV1fL85abrAQM526hByqPmMgnD+2W3RAj8+qH35ImQT/IyRfhQtMnZmsym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999307
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

On 7/10/26 23:54, Matthew Brost wrote:
> TTM records the allocation order of a multi-order page in page->private at
> allocation time. For pools that do not use dma_alloc the order is stored
> directly, while dma_alloc pools store a struct ttm_pool_dma pointer there
> instead. Drivers that do their own DMA mapping (e.g. Xe) need the per-page
> order to walk a populated ttm_tt one chunk at a time, but cannot rely on
> folio_order(): TTM allocates high-order pages with alloc_pages_node()
> without __GFP_COMP, so they are not compound and folio_order() always
> returns 0.

Well what is the justification of XE doing the DMA mapping themselves?

Regards,
Christian.

> 
> Expose ttm_pool_page_order_nodma(), a thin wrapper that returns the order
> recorded in page->private. It is only valid for pages from a pool that does
> not use dma_alloc; whether a TTM device uses dma_alloc is fixed at ttm
> device init time, so callers know from their device configuration that this
> helper applies. Use it from the existing internal ttm_pool_page_order() to
> keep a single source of truth.
> 
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Ryan Neph <ryanneph@google.com>
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
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 25 ++++++++++++++++++++++++-
>  include/drm/ttm/ttm_pool.h     |  2 ++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index dbe977412a81..d34592d4dbc7 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -461,6 +461,29 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
>  	return num_pages;
>  }
>  
> +/**
> + * ttm_pool_page_order_nodma() - Allocation order of a non-dma_alloc TTM page
> + * @p: The page to query.
> + *
> + * Return the allocation order that the TTM pool allocator recorded in
> + * @p->private at allocation time. This only works for pages that were
> + * allocated from a pool which does *not* use dma_alloc (i.e. pages backed by
> + * alloc_pages_node()), where TTM stores the order directly in page->private.
> + *
> + * For dma_alloc pools, page->private instead holds a struct ttm_pool_dma
> + * pointer and this helper must not be used. Whether a TTM device uses
> + * dma_alloc is fixed at ttm device init time, so callers are expected to know
> + * from their TTM device configuration that their pages are not dma_alloc
> + * backed before using this helper.
> + *
> + * Return: The allocation order of the page.
> + */
> +unsigned int ttm_pool_page_order_nodma(struct page *p)
> +{
> +	return p->private;
> +}
> +EXPORT_SYMBOL(ttm_pool_page_order_nodma);
> +
>  /* Return the allocation order based for a page */
>  static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
>  {
> @@ -470,7 +493,7 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
>  		return dma->vaddr & ~PAGE_MASK;
>  	}
>  
> -	return p->private;
> +	return ttm_pool_page_order_nodma(p);
>  }
>  
>  /*
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..753203980e2c 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -94,6 +94,8 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
>  int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  			       const struct ttm_operation_ctx *ctx);
>  
> +unsigned int ttm_pool_page_order_nodma(struct page *p);
> +
>  int ttm_pool_mgr_init(unsigned long num_pages);
>  void ttm_pool_mgr_fini(void);
>  

