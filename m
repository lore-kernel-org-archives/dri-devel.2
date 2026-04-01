Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905C4D35172
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C706E10EFD0;
	Wed,  1 Apr 2026 10:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G4xzGSJw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06D310EFCB;
 Wed,  1 Apr 2026 10:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJEif7UC5oG3PlQTQHhAPdfJBSK9+f0z1ygcj7QqPKIwO04Q+Q2qZ6OQ3STph9cNFCy18ak0/TvUa57YNN+EQc/hA2UuHBlua5BxxQOV0d919U65I8zKnVvhfCWiXiqy05DiXLCFw0npOv89pgwS8gR2U3DuefWhyq3vJaQRfMKQyk3QqaoMNgwzDI6w1LsZTx5ScCAIYhH/NAkcABHOs3DTeXDWAhTNva/LSGBMHtxePVISIcRgEjJ0RKzBlrBRL80BOfZ5cz4lR7PMIELM0sg/rsn7cGVqO2LKn6eCAGwj6yypSziwQ9pAaY0CQ6HZ5PpNZqJd2L8lpUbONpJbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjo62zJpLdKDblt4t4nKlbOG4m7aD5sDws+nixrP+M8=;
 b=Hw36R9ABD6LOhYlmtc4/cf+VGefkVGDq1d7mNjNTpo+BqKDfYCwEwwYeDgYd2E2p54tSRo9WdeqTiPj5vxYwNAVH22OVk/Z9SzyP6m2n/vFNTTaU+ghPeXVzxfaxH0BOO4BIciyZIYGSZWs78ZVap+C7NYmJjsGnByWtlL2guTd7KWcyZwrHgGMIv3j7qx0JsPwEiFGseMyA1Rx0hccUkzj7PsvoBekXDDoZu/FbzXP9OsXIzysVfIX8k57u39jdvhocU7oJCob0GV5TvnfRQ8WcbJ1sLcXaRZsEVwFqFI5PgNSLpfy87+DgSXAmm9echhrpyD3ZjeoJB8sglNuU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjo62zJpLdKDblt4t4nKlbOG4m7aD5sDws+nixrP+M8=;
 b=G4xzGSJwd3XIRqSO+lKqCq1DnbKFcZumEFVIhfc1iI4YJXvRAkeqowcvxZg96XvvX7BlYzWtr7K5MYXMFVI0dgkc9bxurJDM1VtGNL/hMDpS7k0sRDxXMO8L3IvIGwBCcGhVB16tzsoA16+vXBaDX9lKkTkOoOUIANdcecS5YNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:26:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 10:26:05 +0000
Message-ID: <f7ba4ef3-e397-449a-af92-0c27b4b6dd4e@amd.com>
Date: Wed, 1 Apr 2026 12:25:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use IRQ-safe xarray API for PASID management
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260401073632.101796-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260401073632.101796-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cded1c-59fb-45e7-e989-08de8fd91407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: JKK2l3OUuZ5l0u+U7tGq7u9e8zMe6mB5467uZB1+yLgvdSRRR/bPPy6V5EsNncoptXFawWRfJrHTEy/FW6w3RwdTrAAFLQ0UuR1TwoDg+v4ZPmGwQyBH5l/94I3qWKjup21xpMqtn4KBgHvkj3ABc+VVHs/wvR+UeQSL6ZfoOSEHetwCm4VaTV8IvkhGVaqe+5EEBLmwLeNbp8uKGes42inhz8QUXdTrBEh2lqsbh99p71/vkn0R43Ga/zEn7u5JkQtheahrV3g8GreELOE7LvEB3KGL5b+Bm+ddvGRGbuBIPcPkj7VPvMeWyA5U60yTgmhStbcvHvomqfcqMd7AE+WfM7R9HhtX15xTnGiL/7YGcMcQVx6JwNW88M99AAslGSaLF99vWlWZ4t19AzhRvYthAdSKMUKJ49a/hGIgxCORDNeQyU1Z/iKkyKWZaRrHnhZ9Wv0bHOpuuVV1ZrWfvMo4TJdS49cATGNb07PS3eO3q0wNG96qvCksQcoUjaGkZKXs5MOyEGZE1kupoOrbvenfk2H7gDMJwnULWT9TRRmFVx911E9sFtrscOspfRNd2/vB5d35jAVPBa9fDtpXfHbU0dUDK7bu9b+qoe+gjn8yO+PkyyOffyPv2vyoInf10En/y18XX/Ej6PA8gCF2VMGMLp/xWCdaduicYTG3yXtZccL1O92FCnkoDI+HDF+Gm76INFS1smaThtaADGrfVIZNhlmOufzQCinnqMkkCjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhtdDF4UDNuR29tS1lkZmNiL1lsaVh3bm9OeTZTNEQvR0NXUW1Jc0tZTnF1?=
 =?utf-8?B?NTB1QlZsZUFHRDZHamlxcXVWK042RUFIbUFkVktwR1VGWnFnK2h1VHpoYjgy?=
 =?utf-8?B?bGpZMW91M2tLS1hjS0Eva1lEcnQ5emhIT1ZqWkFZcGgyZ2pMM1lpSmQwWUJC?=
 =?utf-8?B?K2RJTFA0SEFnZW5tY2w2RHFzbXJzU3lYd1o5R3k4YnRYbXpTKy9MdnN3NldC?=
 =?utf-8?B?VU03NXVlYmJWUlNRMmxJVzhUWVhGNitROVZaRzJacHdOSGU4VHVCR2pFMDYx?=
 =?utf-8?B?YmQrNE9vaWxNMEhFT2ErdVAyckx0Mk9NQ0ZXcWViVFlZbXora080ZmRpYkxV?=
 =?utf-8?B?ZjVqYVIrTFo4OU0vSFQ5d0ZHeVJPSzRNcUREQXM0UHJFeDNSeVNlank2Y3pI?=
 =?utf-8?B?STgxZ1ljWGlQVjhSR0JudG4yc2xMQitLNXVGVTN0Tnl4bTBYb3o1NUR0ZEhJ?=
 =?utf-8?B?U1lRaFdCTVdyOHpQK3V5WkRRWjZPR05UVnJHcDZ2aUZTUXZZaDNHL1l1ek5y?=
 =?utf-8?B?SWlEUEx3eE4yS2RJQitzV0NjVHlBVzVmSVlnRnlGZGZEU3UzMXBiVEhvQ0JD?=
 =?utf-8?B?UU9aWjY2K0x3TEM2b0h4M1RNQ3l5a2xtOGRNNVIxNEU5SC9vbC8vSVY0T2N2?=
 =?utf-8?B?dWJTK01LZDhoeVM5cHVETjlueVhEWVFyN21BalpUWWU4bm91NGVTVTgyYzZ6?=
 =?utf-8?B?K0VpN3MyY3JsMFFiSUg2SWZWcVplYmpMQmZqeGMrd3VTTlgzQ3pnaXhkYmlF?=
 =?utf-8?B?Zk1QNVR5SXF0akVpdlhHWERwdk56aUxpQS8vck5MdUdLNHRtY3FZbVVqL0Ro?=
 =?utf-8?B?WmJSdGlYdUFKQWNUQ3FNOWFSSnV5Vmo5WUF2dWtWamoxa1I1WmZCeUFmL2Vt?=
 =?utf-8?B?Q25qZUsrKzhvOHFlallvbmJHMnVJaTZtR3JVQnh2S29RVExIQnFJdkNHcW1E?=
 =?utf-8?B?UTVvdTUvKzNRbFZmWERET0EvYUkwcEtvRktJaXpXMXU2Y2RQRTlhbEtjZWZX?=
 =?utf-8?B?RGl4MmhQYVVZV2c5bzdrMG4rNUwyS3pqOVlTYzY4YTV3dnRqdnIrUEp0eTdG?=
 =?utf-8?B?QWxmSjBWTmpicHNzeDZzbXMzUnFqZElKOTR1UUhIUXc1VzlQRDkxcUorSEx2?=
 =?utf-8?B?d2hSQ21yQWJjUGtPcm5OSFdhNlF0UUFjRFU0VEV1WUdyRjFTdHgxVG5MaDdm?=
 =?utf-8?B?UWFPMUhxLzdmajdsaS9PR0NxaWRTenFGd1JaU0R3RDVCMitFRlJzN3E4VGk2?=
 =?utf-8?B?OUI1MEswT3hrQS9VVlA3dDg1bmUyTzJUSXg0QWJUUHM4SThnend2Z2pqaVpY?=
 =?utf-8?B?eFFWOGNTUCtZZ0JZdG1OcEI3Y0RRRm5IV0kwaTI1TXRmUWJqc244WVcvOGZT?=
 =?utf-8?B?Nys1aDhLWVpTUmMxRjVFRDFtbkw4OUFMeU9jdE5tM2F3NTVsdzJTZDZoUUpO?=
 =?utf-8?B?RGoxQUNOdDFOWHdJeUg2STM3TTlVQlk2bWxrQ0pXalVGbEh1THNDbGw3SDU2?=
 =?utf-8?B?c1gwVGtHZitJdThWNmNtQjJMbk5PNk5rQ1lGRUg3a05tcGg0K09pWGFFVTJT?=
 =?utf-8?B?eE10ZSszeTR6ZHkwSjFqOUZtZXo4UVpCQk9lNDBOc21vWWF6cEVjdWRoWHJM?=
 =?utf-8?B?ZEhjOTdIQ1QrY2dTT25VR0FVMTU3cnUvK2I5VWJqbjBQRUtuMEpYdkVzcUdJ?=
 =?utf-8?B?Y0NuNldualNlOU9wOFIyM2NnWTZnVmJPeGk0NXBYRitTVmNvUWxzbUswNVUw?=
 =?utf-8?B?WkJOUWhIUWgzNkRUb0hVcndxZVF4N2NnSU1NbElQYitpUHJTTTBYNmRYK3FT?=
 =?utf-8?B?ODlyMHhDMUcrU21jK1g0Wlg2UlUraStZQXMydXZ5Q0NtcG1CekRSRDV6UDV5?=
 =?utf-8?B?Yjkvb21KYis4ckxHNGR3QWp4anBEQmNSb3lXdHBkV0s2UEFodmlZV1lHbFNH?=
 =?utf-8?B?bW1MTjFib3RaMW90VFRndTY2SDlMcmsva2pyNmtZVWR1V2ZmQVFGRWlIWk4w?=
 =?utf-8?B?Z0JTNTBnV214YXlvZE5RQ3ZuWDRDZERVV1h1elZyM1AxaWxzdlhKODF3enkx?=
 =?utf-8?B?dU5vV3Q1N2dWWVNrTWFKSUtaNlZNemJhT0NBYzlGUExPb3hqUjFtbGs5UXlH?=
 =?utf-8?B?VEdGWVZkSDd3YUxJUVVCbVU0elhuY0dtTFk5MWFHSVFJN29YVjdiMnJUcWc4?=
 =?utf-8?B?Z005elFadnpzZlR3SDJGcWxWMDYwTmxlQytuT1RUVlNwOFhuMnJ6SU1HcVNF?=
 =?utf-8?B?T3QwcGZNTTl0cWVLT3hITHNqK2ZRbU9zRHhha3I0b3RBMGxza0NPaUpBblFl?=
 =?utf-8?Q?vs3eApbeOCXmocYl8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cded1c-59fb-45e7-e989-08de8fd91407
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:26:05.2989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/hAGZ5ci88WdxXQHjPZs7Ida4txYg4XxYmfaoJydH4GfIUnlBonaxw9NTEgzsAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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



On 4/1/26 09:36, Mikhail Gavrilov wrote:
> xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
> regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
> annotations, not runtime locking.
> 
> Switch to xa_alloc_cyclic_irq() and xa_erase_irq() which use
> xa_lock_irq/xa_unlock_irq internally, fixing the IRQ safety issue
> for amdgpu_pasid_free() called from hardirq via fence callbacks.
> 
> Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index a6ac3b4ce0df..64d0da28441f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
>  			    XA_LIMIT(1, (1U << bits) - 1),
>  			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>  	if (r < 0)
> @@ -85,7 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
> -	xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_erase_irq(&amdgpu_pasid_xa, pasid);

This one needs to use:

xa_lock_irqsave(xa, flags);
__xa_eras(...);
xa_unlock_irqrestore(xa, flags);

Since it is actually used in IRQ context and not process context.

Apart from that looks good to me.

Regards,
Christian.


>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,

