Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A6ECA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6C010F0F4;
	Tue, 29 Sep 2026 21:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNyWL6FD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB5210F0F1;
 Tue, 29 Sep 2026 21:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEznLyJZLOWWCV6EpDZKmYNjJAD1AHx5QL5gXfd2ysLlBEgmeFe8gQT+0VFyBcoQWpvl5YZgjgyfjBDgDlvnZdaRp53Q73FiNgnA1rnEztdbsSk6k7DJTFR0sCYs1X0tmG1LUblNZwrFe/NpD2wMNhWFnhyZ5nJNSwFhe8VJ66WoHx5mz+tNLAUtZTPbXEwXhbulKArh0bNZ9cgOwNMuWVf78jJM8y6EyNYelopghQdmr4Okh69uWG20Iv8h3afem4BZSiKZJFfqaXZH2ksT66a9oH9QGMMMf4xfgtc7toj3XyaEU939tGnYczfzntSEZS0+bKfY51Un1qfzciNBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHTMlUaOlxqR2xRRksanG+GbdWUIE+GncLK6zNx12+g=;
 b=HoxbUmA3AEUra0d5CNn/jBg9oeHrsbNMKL2jxPZG8YjHirD8kjx1W3SVdBUe0H5KLoeCxpde1ikkfdJKCZZU6jj1s+KyxsCKri6LYT+rP6ajYr2IXI1e6q9U1RiH9G7bDEDiANf8gqbk86ouldzeZzzgs53KTuchzhb/e8Iw/2iNJ+FpRGyGU9VjY/caF/YTB0KOTaltJ6pU7iAAFkz8dnO9D0YPMfqUH8KtTrz1DVSkby34ClqIWdAXbuhxqnmDyS/Pz1ZtCu+bVUnjIuQPZQfB4s1P3RG7iRQ0ysqKazyEYX6FjZ6Ay+M0Cc6xjD1h3S/fUvN+GcHBLTJT6pnNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHTMlUaOlxqR2xRRksanG+GbdWUIE+GncLK6zNx12+g=;
 b=CNyWL6FDlZxrsCe6dVPPCLdz01dgPd5LWS5C1UNiVjFDmQi1raSiCWoAqtYz8Z41LEwbHsJHhl5YKIL6uJv4BqBxG5wiMVBRbuyLiUBu8fXpUIzI0Qg7jDVF6uoH+icPjDb5A6hprLj9BEr0D97g493GY3OdCjX9K6cPABMTbWE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SA3PR12MB9089.namprd12.prod.outlook.com
 (2603:10b6:806:39f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 21:10:36 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 21:10:36 +0000
Message-ID: <2d3f2b27-c978-4ba9-9f51-a4666c4030bb@amd.com>
Date: Tue, 29 Sep 2026 17:10:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
To: David Carlier <devnexen@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260929193432.100694-1-devnexen@gmail.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260929193432.100694-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0375.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::10) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 393c77d1-91b9-4d67-18ee-08df1e6e1b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gshGno6WhMBRkx43j+ojTEJ7UIPoiELabI9329RlimezsaHibbCoecWo2zONpcpCR0he5QJ+7TRIq/LpdP4HqbfXsC/S9mwFh8og9Tgk8kmTTsN+53xJQmgHP9BSm1Sx45otp6tI41iA40z/BFEUinrAT0Ha/+i/PoVjUUYZWhAKkeXNLTpB5tE9J8iq2ev9cJJIDNlDfi7kWh1Eg11/WJ+EGTY3y4vUPTJ6WF31weeSJ/rbvhUJxtFtTd/x2QiMdbXuqO5dzHBXG6lQp/NzaagsVerJYFVPxlPy/pGw/zfKXJFPiex7dznk6RsKqQVRPreTpNL+sFv9PoUG3Z2y3uMS5Jrr0ng7UpbLbrBVuy/2GdrTXkZmuRBL2GTXqFpv3tPthiRxsAbtMbjKMfn+isZAAkh4dcmq/Mu67iLpFrcYuO5tJXae6qjBidq9nhsiBcUsMuzHsxRzxtC4P7hbFOOYUBIv99tt3qa4XTLfL85Kyg+GnAUl+GrpGlisdBLN9N0Ufi6/PCUDG7qByHQhbk63vfgjOWrYc0FnDsAe8zTB+xRYc7WKnclvCwtBmlkmfDE7IZOqNhxF2pddUGrwJ5CuPYJ6VSlZd6EvjJzJs6ibTDaKZrg2MQ/p2+EfqN9dHK4kSbtkHZBV5UIamiz8I9PXYXWxcxosPGcxd5XrKxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFI5UWtWYTNTZW5iRHdpV3lrc3Jpem9GQWYwTitsQWZ1NzhUZzBOelRqeUEy?=
 =?utf-8?B?bXIzbEtlbEd0eFdwejUrSjFKcnFJRjhxUWRJTGJZbkN1L25ja2xJMEJ6dVVt?=
 =?utf-8?B?Y3ZMaHhTMlcvUDUvY09YMncvTU5wZ1BpZHRXaVJRYStBNHlTMllDTS9nNWRq?=
 =?utf-8?B?WjlVK1hVUUpzQUdYU3dJUFRhOHhubzAraFZQR3JqSTBmUklrb3lpNExGRUxF?=
 =?utf-8?B?eDNOUU5LVldoOXhyN3FKYmVoVEIxL0JXVmpxMklCRnN0NzJMY2svZjEvejNJ?=
 =?utf-8?B?bm9CbVlqNVY5MU5XYXBKSkFvd0hhQlBkWFpSWEpINEZINkk0eG9ncUZLMkpy?=
 =?utf-8?B?a2ltUVhXY0lVQ0tNMUVkN0p2blhENXFocjJpakpadUU4ZkN3cXNGcmNjeld1?=
 =?utf-8?B?R0dQZTZQZ0xnaDJJazVlcmoxOVN1WmxHc3FzT3FBazNJM00xUmtvNE0yb3NC?=
 =?utf-8?B?cUNkU3Q1T0lHeDJHeTBXa2VRWnVtcGxMeDVkQ3FYNEpuZTl3UCtqOW4zNzFG?=
 =?utf-8?B?WjBDbDhsdmFSWndyRldETEhvc0dFT1Y3VWcydWMzdDlwNGhTZUVmdXlXdE5y?=
 =?utf-8?B?NkVRVGdnazEzMU1FSFZqMUVsczU5M2xyRFFGM2QxeElqcTRuZ0M3OEJIRXRT?=
 =?utf-8?B?TWkvMHRhd20va1FaaWZoMjNYaXFadVllTEFoREdYdXU4OUhMQW1LcjJZUGov?=
 =?utf-8?B?RVo4U2h6bUduWm9rcktuZEZCZHgrS0MzWVhWVC9NSGIweDRTb2FlYUdDNWZj?=
 =?utf-8?B?ZXFCQ2psN2Fsem9BcittczhCV2dNMndzSWYzdDJWc3JoQWdKMmJMUCtWQlhw?=
 =?utf-8?B?dnpjU2VLanF1ZXdDN3FmTlB2WVBDN0FoQ2VmOXdzb2hFV1VjcTdtYTQ2TTYw?=
 =?utf-8?B?RXczbXVWMXkzckswaUtvZVRFbUsrbUcydmhGN1RjMUNhRm12MnpOUXlGUFBq?=
 =?utf-8?B?Q0x0c0JiZDdETE50TXZxRVBqNEsvWnM3WkdCNEdLZC9ZZkVsVUNWK2RXaTJw?=
 =?utf-8?B?bFI0UlNIeVkyVHFaeVc0NlBXRDBVZElWTTB4UWExWmdoODBSZ3BqYnVaRFpu?=
 =?utf-8?B?MWk1WThjNGZqK2Yxb0JhKzNoWDBya21nYjZocFFlME5KWVQ5N05GUU9sVFJ2?=
 =?utf-8?B?TkFhaDNCRlorOEsyNEJzUy9oVzMvSk5QZTJtRHNJSUdJbjBMbzhaNFRCeCtV?=
 =?utf-8?B?QWFWMlhYL3lwVkFTQlZmcHA1Q2xoT0lNTkRCOFdGaDh6MUQ5WHA5dmt3aldN?=
 =?utf-8?B?LytYaHN1M25GVkZ1QlJQb2w0TzliNzdrNVBDZ2VXRmo1d1Z5d0hlUDl4bFlB?=
 =?utf-8?B?WnJYYkh5RVd2cFVnRVpZTWYwZW9YcUlWMW5wTDVUYXBvaXRtTXM5cm1wOUtx?=
 =?utf-8?B?ME1DbVU3VHd4UWFQa1crYTdpb3ZCYmNZV1M1cGF5UzFDQjZlaFNITUUxb0Nu?=
 =?utf-8?B?SE9qRlgycXp5cFlIQ0NFeGx4Szc0RzM4NmVwTVJuYWxaak0zOUhyZGRXMkxx?=
 =?utf-8?B?UEFmNkZDZm16LzI0eHB1emJkZnE4U1FKWG83c0FJbVRXcStKOEh4Ky9UUUV0?=
 =?utf-8?B?TEZaU1hQZTA5ZnZUbWdDS2hRd3RkbktkOTdQZ0padGQ5a0NsSlg4Wk9sVW1W?=
 =?utf-8?B?UTN0Y0dsa1hVb3B6emM0MnJpSnh0M3YvRDlTVzJaTXNTZkUrdTJrYURYWWZS?=
 =?utf-8?B?Z3BLNUx1OUJMQUxjbU9SMHErN1hDVzFNTm1rSnBLdVVHSFhXdVhqRnhSRk05?=
 =?utf-8?B?T2lka1NhaUV1a3ZQZGhJUXd6SUg5dURlQTQ1a1BNaFNWOTFiWncrOTFzMllN?=
 =?utf-8?B?NHdPdCtzNlpCdGlKcDFtS2hiRFNqS0JHT2ZIa2FJNVhYOWYyRHBmN3c3WnpW?=
 =?utf-8?B?bm5aYURYSnJUaExyaVp0QUw1YlpIZFRleUwzZkp5WWthTE5IN1JKM1dUNGdh?=
 =?utf-8?B?QVdLMFlpekhzcHRRYTJHblgvcXNuSmxYVEtvVUs3aU1wVVZ1WWIyWGwzdXoz?=
 =?utf-8?B?bXFSVVlpWGZmUStrV3gvTVVvVnB4QXd5anRMQzNYU3pZTDkzTUxvQ0IrQmgy?=
 =?utf-8?B?Q1RjVUFMblVsam9PbFpEbnBxWTFYK2hyQi8yd2lIcURLczhWWFI3M0FMNzhG?=
 =?utf-8?B?OGdvVGpld2JCaVpMdXQxWnMzbHQ0UXcrUHpBZmdWN00rN0dscFBHNHdTYW1G?=
 =?utf-8?B?bEt6cHFWa3JKK3lTNSs2anhRV1dRL2dhM0Q1YmVZU3dhMGp6S2toNGhPUDlN?=
 =?utf-8?B?R3dFVjY4dGoraUo2YW00TTlqbWxFZEtTT2pBL1hMYU0xYm9jaERpbFhyam53?=
 =?utf-8?B?RFQ1Q3l5d3NOUkpVWHFPTXlESDZnSHIrR1A0dTAwYldQZjJqNkdhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393c77d1-91b9-4d67-18ee-08df1e6e1b7b
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:10:36.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTGnpFgyV1h73hHgVvw12hMSUj0xKjGcVdpPsU592k5Eg2mEIg+TlaPIFfa3g/UxJOhOruiL3V8rtl5Qu8VoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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


On 9/29/2026 3:34 PM, David Carlier wrote:
> The exporter records an importer when it answers NPA-REQ, so it can send
> NPA-REVOKE as soon as the BO is freed, before the importer has finished
> building the dma-buf for that handle. The revoke handler assumes a fully
> imported node: it dereferences imp_xa_node->dmabuf, which is still NULL
> until the import completes, and drops the xarray reference the importing
> thread still relies on. The importer then links the node and marks it
> READY regardless, so the node can be freed while still on the per-remote
> list.
>
> Only tear down a node that is READY. A PENDING node is still being
> imported and nothing has been handed to user-space yet, so only mark it
> for teardown and send NPA-RELEASE. The importer checks for teardown under
> the xarray lock before linking the node and marking it READY, and unwinds
> otherwise. As NPA-REVOKE always follows NPA-RSP, a revoke that finds the
> node NOT_READY is stale, and one that finds it in teardown hits a node
> that is already being released, so both are ignored.
>
> Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
> Assisted-by: LLM
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

I will get this tested first internally before pushing this.

Thanks,

Mukul

> ---
> Changes in v3:
> - Handle the node state with a switch: tear down READY nodes, mark
>   PENDING ones for teardown, ignore the rest (Mukul).
> - Drop the npa_done completion on a NOT_READY node: the exporter only
>   records the importer after sending NPA-RSP, so such a revoke is stale
>   (Mukul).
> - No longer send NPA-RELEASE for a node already in teardown (Mukul).
> - Use dev_dbg() for the revoked-during-import message (Mukul).
>
> Changes in v2:
> - Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
>   in teardown neither dereferences a NULL dmabuf nor drops the node
>   reference twice (Sashiko).
> - Complete npa_done when a revoke arrives before NPA-RSP, so the importer
>   fails right away instead of timing out into a connection reset (Sashiko).
> - Use the current Assisted-by format.
>
> Found by code analysis and compile-tested with W=1. Not tested on hardware,
> as it needs two UALink-connected accelerators in a vPod.
>
> v2: https://lore.kernel.org/all/20260926174406.346253-1-devnexen@gmail.com/
> v1: https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 51 +++++++++++++++++-----
>  1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8411ea17172f..ea18e7f2e0a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3288,16 +3288,35 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>  		return;
>  	}
>  
> -	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> -	list_del_init(&imp_xa_node->list);
> -	xa_unlock(&adev->ualink.imp_xa);
> +	switch (READ_ONCE(imp_xa_node->node_state)) {
> +	case AMDGPU_UALINK_NODE_READY:
> +		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> +		list_del_init(&imp_xa_node->list);
> +		xa_unlock(&adev->ualink.imp_xa);
>  
> -	/* Invalidate the GPUVM mappings */
> -	bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
> -	amdgpu_ualink_invalidate_import_mappings(bo);
> +		/* Invalidate the GPUVM mappings */
> +		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
> +		amdgpu_ualink_invalidate_import_mappings(bo);
>  
> -	/* Drop the refcount for the node */
> -	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
> +		/* Drop the refcount for the node */
> +		amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
> +		break;
> +	case AMDGPU_UALINK_NODE_PENDING:
> +		/* The import is still building the dma-buf and nothing has
> +		 * been handed to user-space yet. The importing thread sees
> +		 * the teardown state and unwinds.
> +		 */
> +		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> +		xa_unlock(&adev->ualink.imp_xa);
> +		break;
> +	default:
> +		/* NPA-REVOKE always follows NPA-RSP, so a NOT_READY node means
> +		 * a stale revoke, and a node in teardown is already being
> +		 * released by whoever moved it there.
> +		 */
> +		xa_unlock(&adev->ualink.imp_xa);
> +		return;
> +	}
>  
>  	r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
>  	if (r)
> @@ -3760,9 +3779,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>  		return r;
>  	}
>  
> -	/* Add this node to the imported handles list for the remote GPU */
> +	/* Add this node to the imported handles list for the remote GPU,
> +	 * unless the exporter revoked the handle while the import was in
> +	 * flight. The dmabuf is released with the last node reference.
> +	 */
>  	xa_lock(&adev->ualink.imp_xa);
> +	if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
> +		xa_unlock(&adev->ualink.imp_xa);
> +		dev_dbg(adev->dev,
> +			"IMPORT: handle:%llx:%llx revoked during import\n",
> +			handle.handle_hi, handle.handle_lo);
> +		return -EINVAL;
> +	}
>  	list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
> +	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
>  	xa_unlock(&adev->ualink.imp_xa);
>  
>  	return 0;
> @@ -3938,9 +3968,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>  					"IMPORT: XA import failed for handle:%llx:%llx\n",
>  					handle.handle_hi, handle.handle_lo);
>  			goto cleanup;
> -		} else {
> -			WRITE_ONCE(imp_xa_node->node_state,
> -				   AMDGPU_UALINK_NODE_READY);
>  		}
>  	}
>  
