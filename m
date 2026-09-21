Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2D8C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FB810E3AF;
	Mon, 21 Sep 2026 11:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r8Yo1Ybz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECE110E39D
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+uuqm1MvB7pu+OVMpNmkkuC1tII4BxvzrchHrbAvJL3AiUbVxEHJcd+B7shpA7SFvlxUbu0OTjtbe//dx/rbdxOI63ua/T7Snhvj41hvmRBfwKPwXiNvMJrEio6CFafjsdcT7TK0Bxmyzz6wNrxZ/SsC074o+MJbZUq0jzMXQTbAvoU/lmA5GcxjrfUofh7nR5Zb6DhiF5wCMLtiW8ZBmm7gmGTa/PlMRWwyqfaf1dR3wFXiEtj+HavU+aaEDjd5UJ8FBtudmfozS909z9QdzYgOxmMfJMHPoeWPOI+2qLXD/U2KaXEtGI8d6j/Nw4oBJWQng7hKj9wFN+hIXK1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66KepX9Z5jUi04isJpreWsmSCcErhxqROKcwok9uAR8=;
 b=oT+pWlHfcr3OG166EyT4EyugacIMo1PCt1SaFqN5ewT+R4x0FO6mSu3gqkIzh4GmPffcxnKjxsxEiyAN3KRdMQXpfMFzXyXQrQANtBz98kSkKBBdTc8Ik3TF7kxY1LVUoTR/E/tPSSNOVBoXpozL9rka4gzixmBOLm2rHJzeGX3HybgBzf5TqXzhCn4IzNG2Q9oe0OLW7BJVQRubFKzLBzid6vk5XdJgKsE2TMSvfoFt5AdMgDwUZAT7axPDLgt12j+LGXV33fYXmIQJmg2oKZZHnW/KBqbNewrxXTPuxxm/9iffSqfJ7C5KSCIQVXn4oHZ2jX0mwHIOL0U4+XRzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66KepX9Z5jUi04isJpreWsmSCcErhxqROKcwok9uAR8=;
 b=r8Yo1YbzxW77a/Ks/JzS0BVMhNcoeSHDpa1u/usRBFKNRWXHdrU0JKC48R1vVsGjiwswS/VUNde5hlldMnjRf/xynHqYPvCaLLlMN9SxYHFHCsH4at+od48mQreutM1nnh0TqhgzJQ5fVuSoZD/z8OIfR+oeA2cxxyv3q10cB1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:39:26 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:39:26 +0000
Message-ID: <1bd9bcfc-4b4f-4235-8073-585197b29727@amd.com>
Date: Mon, 21 Sep 2026 13:39:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: don't WARN_ON_ONCE() on a failing
 dmabuf->ops->vmap()
To: Janghyuck Kim <janghyuck.kim@samsung.com>, sumit.semwal@linaro.org,
 phasta@kernel.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <CGME20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d@epcas2p3.samsung.com>
 <20260921100946.353521-1-janghyuck.kim@samsung.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260921100946.353521-1-janghyuck.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 021ee676-e6cb-47b2-8ed6-08df17d4fd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: BPRQPzX9tbSI7G0QJuczFtgBzmV9Z1ESmbT0NiuvtPqGk2pvZkU/dRhcQ+TXpqFeZqfwimNoO2KCkKB+aJvCntVtAgJxT447gAmxtZZRHjzoWZCs5W8zCiWKI6SvEudJcNxDuBXluq2u7Oc5TxEI0lzFWbIDPH0/wHAzI+fSBDtg1dedKQBgSzzNvOOzjfPq+ovnazh6vz6gykQBTyt53zf1edHlSqqfpbLKsKJEE2THwXCVWcYqrfLPxOBcuEPwCqwbiPyju437Bm0YgTgPP5qVet08iDhvckS4IP488bCaAo3/3hAYRYZQzJ7p6iryf+RgXibqeYWG9A5Oa0jvDHV/EjaZ/7TDcWmst/dEReQxVDGhDCHGs7vhjTNLacA1b+PD9GVlBuJwv4GP5HRbUiMbHAo3Ghd5rxpBWqtzentvQKqhoBtBm9x/ts0AUN15POV6GaUDGRRgjFUAuTpk2Y02HXRE3wskHrFKHz0r9iQE6Ae2+E0YdUW1AIY6Xky52AiZM1xksoQfTcSQiDrSd7blT4I4ncBzRjRa1CX35f9PpvxLvoiRLrP3UdjPBY0un3ymKTbBHyBqoAr0cfUezrphGzdrAUHs/HopjR1+xqJIBA17KWzc1wbJx6z9i/aCxfd5d+BY0/YSjl0Xrs72+t31gB/DID6H5xa30Rd/BIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0Z4dUlGRUh0V2htL1RXYUUza1V1bDZ1M3M2UmxpaUZ0a05DZVV3M0VDYzVs?=
 =?utf-8?B?SjEwelR2MjMxZklvRDArcnlubm1yOW9NSUI4QWU4ektUQWNWbmdXOGN5Q3BI?=
 =?utf-8?B?ZWQ5VGZqZXNTOUlSaStjL1d1U3U4RlpBSlF2Y21CeWdWVFl3THl5YlF5UEtR?=
 =?utf-8?B?ZFlYa0tXR29Rd0FrVkczMzVjUXNMcUdXaEgybzd6dkJYS2gxNHhTa3JUdVVy?=
 =?utf-8?B?RVVDZHh3R2MvMmVyVTFHVVZLZzNYY3hBOHg2bk5EMmFkd01CcXJjcjgrNUoz?=
 =?utf-8?B?ZWxud0Iwc2pkTERiUXFMZytDVTh5Wk9sNU44WDg3UlhmekVIb1VJRzRwT2U5?=
 =?utf-8?B?Z2o2Z2twYmNLSG0rWXB6TEZGd1hxcWVXczdTbVJXZDd2bTA0MThiNXc0TW9y?=
 =?utf-8?B?bkpFUkFxeENkaHR1c1ZCa2RnQ1laQWRQM2NUNE9ka0hsZ014bldxQXhEVzNK?=
 =?utf-8?B?MGozVThIa253bFlBSm82aGw3Q09JOU9hNW04Y3BSVkd2UjNOaDRUdEFKelRk?=
 =?utf-8?B?VEhldnZlczlmZjhGdE52Um96U2QzRFRxYkFHUkRqL1JQeG9yZU9sUHBFUk93?=
 =?utf-8?B?bWtIMlVYd05DOUttMlFEalBDbXM0VU1UL1pmdUkxRDl0Rk5UL2VTa09kbXUz?=
 =?utf-8?B?cXo3dG5OdW9PaGNPemI4ODlxcnNlUlJYNEFrZFV6K2lTd0ZqSXV5WlFIYlFa?=
 =?utf-8?B?SEpkMTRvU05MeG9oci91RExMTGQvSUp0YWtrOVhoSkh2T1Rnbjg3MkxFcnVw?=
 =?utf-8?B?ZStkcXFuWEJreTdCa0xjbkFadUVMNTJLLzVPQzlRS0orRGtFVUhlWFNoMGhN?=
 =?utf-8?B?WUFadjRseVVEUUpTZU1waDlFcFNQM0c5SnZZSEhUYXBFYjc1Z1dDSDFwNmVk?=
 =?utf-8?B?Ny9XelJCcGJhQngzQkpTVVNTa1JjUTU3Z2w5Y0NBUlJqQWRHaktCN0NQcUsw?=
 =?utf-8?B?S1lpUWZEZVJ1aXBQM1owdk5EZStzMmF2eTErUHBJUm92azRFWDlCZnlJZWpT?=
 =?utf-8?B?Y3YrL0J4ZVM3eGpZbHF0OTUvYWNkMFlHRHoyYzl1TWR4dzJrTG01d2YrejAz?=
 =?utf-8?B?eHoyM1h4Vjg2aHNZbXAxRkcwNThPMFNNakgzc3AyZUlnQ25BUjE3elBaV29O?=
 =?utf-8?B?ZzNjbHBQaUpRVzR1UjZlVDlUeHBNWGo3M0RNUE1YbkMvdzNXRWtoT0Z3d0N5?=
 =?utf-8?B?anVyR0pLRlBiK09LV3Rxcm40RVphVnB1Sk1rdW5TT3M1UHF1VVIxU05XVFZP?=
 =?utf-8?B?eEk4TnFONnAzd3VIc1lQNThWSGpSWGRuaE5ZSmczZWludnRERHJqcngzemRQ?=
 =?utf-8?B?NExxZlB6NVgwN2pHTWgweDA1a2lKMWwzNU1zUktxajErTEFrQ09wNThaR243?=
 =?utf-8?B?SVpGT09KSGRMbm1rQnRZVnhOMWt5cTVjczRiQnA1RkxDbERGdFFwcDkxSkpu?=
 =?utf-8?B?S2lHS0FBY0pNM04yQ3crUTJRTlVnb0FYQzk3QkpNdXlUWVd5Mjk2MlpybHRu?=
 =?utf-8?B?cERxNHFraTNhTGJoQk84eE8zdzg1T1pFN0cwQTRRRlFyQmRzc0hEbGNBOXZ1?=
 =?utf-8?B?bXJRcXRXeXJCTEI3bGE1bUZmNU5iVlgrNU9iOTdvVWlKd2JuejlWelBaMzhp?=
 =?utf-8?B?cDlzdlM2SHhXbmZNMndnNHhRbzJBQVhqVm42aFdrWXdXdGNrUEtPZFRxd3RF?=
 =?utf-8?B?ZWlYZzNEVUVKTlhJYlNvVmMwTFVRUmdjS2plL3dUTFZsMjNCbVhJanJ5d3R2?=
 =?utf-8?B?SVBHUE03NWJJVmYwZHVZKzVxaWRMK3RmaDdOVFJpbnF2MEVjYVdJVkE1YXB1?=
 =?utf-8?B?MEwzRll3UXZMNEFyTTlUQUJsdmZnQWFTVlhmVzNPamlZRU8wS2ZHRzNXZ2Zl?=
 =?utf-8?B?TkV0RkwvS1l0eDBNbXlqNklJMFRQSG9rU2pMelZpMXEzWXhoL3RsTnZ4NXU0?=
 =?utf-8?B?bUt6NnlaL2RMM2MwYWtNTGJiRXZKWFpXZ0pEV2FuNXQ2MTMrV0FrRHhNQTRa?=
 =?utf-8?B?bVFEekhPOG1XZ0JQRDJ0Mk01ZGU1dWQyb3RwZ2RaR0E1QlIrOU5sOWpMVGlH?=
 =?utf-8?B?ZGc2UytzcWFxYzBzWlFLNTV5dVVyYndON1ZUSjRZNVVLcXVJc0lwRTIyR084?=
 =?utf-8?B?QlcvS1hOM1JkeSt0N0NQTyt3bGhCZDAwRVdHNFc4b0ZpK004SE5vWWJrc1Fz?=
 =?utf-8?B?NEZGU3p5Snc1MUVWUUJib0tEWlNlSjh1bVZHdlZxQy94eWFlN1p5TGdRdzho?=
 =?utf-8?B?L3A4aHlJTHY3T2pDN2s4U1lvVzJrejVzM2x3UHMxbGRCMjRLaU5ISDNQdUFn?=
 =?utf-8?Q?ZU9nMxUt+dENKYadOw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021ee676-e6cb-47b2-8ed6-08df17d4fd45
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:39:26.1323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY4LrVUeBMJMUD2o2APAP7Wbdwb7pQpzOUm2brO9QT9DCkBSvatHnEHnQK/FQNyx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
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

On 9/21/26 12:09, Janghyuck Kim wrote:
> dma_buf_vmap() escalates any non-zero return from dmabuf->ops->vmap()
> into a WARN_ON_ONCE(). But a failing vmap() is not, by itself,
> evidence of a violated invariant or a driver bug -- it's an ordinary
> runtime failure of a fallible operation, no different from any other
> allocation-shaped kernel API that can return an error. The dma-buf
> core has no visibility into what a given exporter's vmap()
> implementation considers a normal failure versus an internal bug;
> that distinction, if it matters at all, belongs to the exporter, not
> to this generic passthrough.

Well not quite, apart from some not so relevant HW workarounds the vmap callback is mostly used for fbdev emulation.

> -ENOMEM is a concrete, easily reproduced example of this. Page
> allocation on the vmap()/vmalloc() path can fail purely because the
> calling task has a fatal signal pending: should_reclaim_retry() in
> mm/page_alloc.c intentionally gives up reclaim and returns false
> once fatal_signal_pending(current) is true, so that a task that is
> already being killed (e.g. by a userspace low-memory killer) isn't
> stuck retrying reclaim on its way out. The resulting -ENOMEM from
> dmabuf->ops->vmap() is expected behaviour in that case, not a bug in
> the exporter -- and it is far from the only way ops->vmap() can
> legitimately fail (an exporter may just as well refuse to vmap a
> buffer for other, unrelated reasons of its own).
> 
> This is exactly the kind of condition Documentation/process/coding-style.rst
> warns against for WARN*():
> 
>     WARN*() must not be used for a condition that is expected to
>     trigger easily, for example, by user space actions.
> 
> A failing vmap() is reachable purely by driving the system into low
> memory and then issuing an ioctl that happens to map a dma-buf -- no
> driver misbehaviour required. Turning that into a WARN_ON_ONCE(),
> and on panic_on_warn kernels into an outright panic, doesn't help
> debugging; it just turns an otherwise-recoverable error into a fatal
> one.

WOW STOP! A driver allowing to vmap() through an IOCTL is a major no-go!

vmap() on a DMA-buf has very very limited use cases which should mostly only be trigger able as superuser.

At least on 32bit system you can otherwise trivially exhaust the vmap area of the kernel and that is even worse than a simple WARN_ON_ONCE().

Regards,
Christian.

> 
> Drop the WARN_ON_ONCE() and simply propagate the error, consistent
> with how other allocation-failure paths in the kernel are handled.
> The dma_buf_vmap_unlocked()/dma_buf_vmap() contract is unchanged:
> both still return the negative errno from dmabuf->ops->vmap() to the
> caller. Only the WARN_ON_ONCE() splat (and, transitively, the panic
> on panic_on_warn kernels) is removed.
> 
> Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
> ---
>  drivers/dma-buf/dma-buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 36cdc342627e..252495761a21 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1670,7 +1670,7 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
>         BUG_ON(iosys_map_is_set(&dmabuf->vmap_ptr));
> 
>         ret = dmabuf->ops->vmap(dmabuf, &ptr);
> -       if (WARN_ON_ONCE(ret))
> +       if (ret)
>                 return ret;
> 
>         dmabuf->vmap_ptr = ptr;
> --
> 2.34.1
> 

