Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09110606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LhcKb7ik
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB37110ECAA;
	Fri, 13 Nov 2026 20:29:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523FE10ECAA;
 Fri, 13 Nov 2026 20:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYs6IiKzsYtNQMp9ARO85llAArM3PhrQNA6ouYIOyVYSuLC5vTaZg/4aTmea5L6dQZZuBfJHwcESXbF0vnVniJgDZ5av9m1y7pX0fHUHB0+LnRnEQV6U7VvyV3LUWbtqKy/4/cH8VXck7etdjHp7/E9mARgkfhJXZ4+X4Ue19AisIFQkHY7r2i66Cff+qqnaPjIIyv4rkeL1veLG2O8QUgCMp79V8U12i5ecvpCE5Jb+vVIzLH2mbc2tMy3TT0DghvNaL3k0vT9f75iBDWesJxLM2Xy8eZayoNLiwogZJro3/xoaNigxEbYexdF9q/h7o8UfrUdSnMUU+lRwhy3ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJFiQ+uWfKl77IEh0PZvLD0XR1R5x8Ir1z3xZ3xLwXQ=;
 b=Cuz9C0HJmZTT2NdCIW0USl7EM/07zK00fzg+MoS5SlClz93l85Q1HZUaIdUVDDgr85GFwVlmnb51u+BQ56SwVqnQZFrUhdwgtFs7kCriKqu9PB3bajD18wegZlLGPCYR4JquVgh1cBZT5T2QLlZv74/BI/FSNSNkhSwVoU7WCHUbe8xkf5cIJOgOIsOLjFbz8aL9YqKecn7mjABffYXrq2iSsRhIuycvZn8GkBaWjk1BiQ7qrKj7NbWjez/t3bxqNuJgRw3kiCthgzA3JXSdOw+i58OkMKmg0onKqrSEFIZzW7CVk5enHHcviJjPTxBQ+rTaYnfEh2OB1eAYPwC0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJFiQ+uWfKl77IEh0PZvLD0XR1R5x8Ir1z3xZ3xLwXQ=;
 b=LhcKb7ikPRGmZsb1HDfo1ygomV8j5wHPeLk49EgAS7tFVido1P5YQLPHss8HS+IXwWzi/MUwCaK2Vh/kBYycKKMhb8nKO1UeDRXoIEXpwkpCZAWKAieanHG6nrjEaUm4XrFwQmAPjhBRjhCvgreCEpb8ZvD36mrwu8jm7L4ytYY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by DM3PR12MB9352.namprd12.prod.outlook.com
 (2603:10b6:0:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:29:35 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 20:29:35 +0000
Message-ID: <c0448b39-085f-4f98-a9ec-da6d6c36067f@amd.com>
Date: Fri, 13 Nov 2026 15:29:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/ttm: Add ttm_bo_access_locked()
To: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com,
 christian.koenig@amd.com, thomas.hellstrom@linux.intel.com,
 joonas.lahtinen@linux.intel.com, gustavo.sousa@intel.com,
 jan.maslak@intel.com, dominik.karol.piatkowski@intel.com,
 rodrigo.vivi@intel.com, andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-2-mika.kuoppala@linux.intel.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261109135549.4128280-2-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0299.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::14) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 747e231d-17a5-4b3f-0ef0-08df41c4d4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261009221227099003|261009223027099003|261026121527099003|261028144727099003|261102123227099003|261102130727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ubSFJNboX1QZFjRHBq/rzXX3oOgIDtiouf4VPfJmKsMxdx2E1gBUHVCLo+qGjrMXVPO13q39AET+wD5+fjd/huN/XtqRBOnCW7OwAU7zmBQQnwBvkwKzHUP9B+nQiYnN9PG4W3d9RJ36cZpX/EvSgvlVXh2WQ0DIVIVqNT8ScSc4umHWHTjAwHE6xcfvKVuH65eg0bSJuMQOGMjO4r30U8zHSzNsjOM3mt/ge9+hEBYCjgF8Lg3d32MlC/MLqnHFjMeUswl2rABfoYcKGtVDrETGpb3GsDl6IY2XFd/wb3oUQQwGjIJ/w3kEqtQOeL3KsKLPZJ3H4WQLTvgYRx6f1gtJoNqvOrDW4Q3B4UbZ5A/VdDN4T21Zwrm1fLGPK9/LMCY/zAyRz2j7dIZWmjYM4zjGuUb/DXr4jBkO5Jbu18TI+EdITpHhag+AIRWSsEasJsrgQ+3fCOw6RxkMmWCQMF5O3LVRl0ax2ByoIanbQg2g2hAC4ZL4nkN3oetRTTNeA7VoFT5NlowSlifSMtRqZrJiGhmDplu5748ma+ip+xDnv5ZnjXpazSXOAwyBw8wV3VTXrgVEHGhR2EZRhSu8v6YrVWJbHVj7EmyEvaiWq4S+HMUT4ZzRogFgaDq6rhYgwjzzqbCHxw3t6CXQ9caRoRLKeEaKTVyeIejLjxA/RBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261009221227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261102130727099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnIzSWVsS3UwUWVrZ2lnc0R5dVZZVmx6Q25QSEJBTDd3N3pVT0RoS29zNlUz?=
 =?utf-8?B?MU43RkNRSjVHdEhGOUdMVlU3cUFYMGQxZ3E1aGc3d3F6VW5WcXhleUF6Y1Fw?=
 =?utf-8?B?VG9nWEJlWW9tZUlhMSt5c2ZXYzhpUUtvdmxEYXpnRXpQcGlrbmR2TTdiY1J4?=
 =?utf-8?B?M3p1amo1Nzh0Vm9kYTB0MG5YWWV5cE4zWk14eTd0dnlpbUg0aEJjNU56a0d2?=
 =?utf-8?B?K2p5dTdVeCt6bTl0cnlna2kramFreDRWTWJ6dHV5eGF3QnNaQzlCWFhiNnlp?=
 =?utf-8?B?SjY0djdlS3ljdjg2QTQ3VkNERk9XbnVhaTRGMXBmY29qZFBPZFVueEYrTERu?=
 =?utf-8?B?UTV2aHJYeTVMLzRNclAxSjV1WGlWcHJJdTc5S0xkdmlpQXRodWQrbVNkUktX?=
 =?utf-8?B?S3dKcUM4T1QwanA5NFVSZnRNOTJtMlRPOTFmZDVzN1MrQWdVbkpoNXdOK2FQ?=
 =?utf-8?B?QS9qT2RUUGp2SzA0TTh2VDRLcnRUYlFyKzljSHErUldYZlJjYU1ySXc1TVB4?=
 =?utf-8?B?ZkdKZE9sV1hEOXRnQmxmZnVuMHR3SmYwQnZGREtWdkhTN0svM0RYdkhoZmM1?=
 =?utf-8?B?c2VtWE5TU2lpN3NZaEpwVFlmNlg2YW4yN0g0eXJCRnpSUHE3K3JHSlZ5SEt3?=
 =?utf-8?B?ckNXbEYrZUxMbnoxWFJuNXR1WmxDZmE1VnFqWkdtL2N2UktvWFZIQVBRTkIw?=
 =?utf-8?B?WWJQQ3Q0dkJNb0xrRVJNTktqMGJiQ21OMHpaMjJqbTZJWGtUenBSTUVNUlRM?=
 =?utf-8?B?V3U1cWlJRVkrbDdibS9LbjFYZ3c1eFJxMEdtQXBkR1R1NHJVSlAxNEJYVVpk?=
 =?utf-8?B?cFkzTnU4a3FpM2pNeUpmQkVYMkRrT2x0NkVBZFVYOWNPRFpJcFpjZzJQUjZw?=
 =?utf-8?B?cERTYzJyWHZQcTh4UXIyNVlFUXB5T1R2ZzJ1MEdCbG1OMmh5cWZVYzlRYmVD?=
 =?utf-8?B?KzdGRjRaOEZiMG5HeHAzNnUya3RSQTFxUjU2UHVFQlpNakt3RjdhTkxrN1ly?=
 =?utf-8?B?NXlLVGtOcnR4T1liQ2t1T21SelZ2QlFkanAwWnNUbkFZcWhJQVlOS0FHSDhC?=
 =?utf-8?B?SUNhMitMMnBZOHBYTm1KWkJzTlpwVEltRGRxRW5FNmpxbytTNEEzUUQrZkNn?=
 =?utf-8?B?OUhUeVVLNjhZc3JRNzNZUzhoWlo4N0xYVDNRckJIbTBIdWtZZGNiNWRIRUY0?=
 =?utf-8?B?WTJEYmh5WEtiRGZucnNRd1JrdnMwT2JWdWRnbGgrS2lzRzcwazM0OTNtOTJR?=
 =?utf-8?B?eVpzM0N1UlkxT1FFRjZPUytweDQ1dEs5eVZwTTdoSGdaek1GZ1FwaEJINjdZ?=
 =?utf-8?B?RlZWbWNNakIyQXhHNFJhdTJFQnhRY2c1UC96Ykw2eTcwQ1R1ck5VSlFPQTdm?=
 =?utf-8?B?SmRycW1FVy9nVloycW1CUWxZUzBEanpOdHpYK0R2dGZUS1FDdjhJcWN3UXp4?=
 =?utf-8?B?S3RWbDlFRm9sekdTNFEyRktqL0VUMG9RMFg0cVFzQnVVRFNEaWdzNHY4MHNh?=
 =?utf-8?B?OFdWSlpaK01BNXV1MTJRWDRkUmt6c1Q4amNNRjFBNzZTYXNBSG5nOTc1ZEhU?=
 =?utf-8?B?UFd2NWpmbG9JWjlGRUxiQko4RTZLSHVIaE83MC9ZODFlWG9oa1BFallJQnFh?=
 =?utf-8?B?VUEvNjd0YzhYNnM5R0NTOVhvR2hFTmRpbVZRK1dFaHEyc0dOYUVxYkNlUkIv?=
 =?utf-8?B?SzhCdjJqa01qQ3FOMEdMV1Z2R0JwYWpYbkdVZ2kzWm9JSlFIUWNYdDVUSW01?=
 =?utf-8?B?NmdCMW43SnVvY1c0RlpKakx1cnlqeXFoaHRxUUlrL1haR3MzaHliRGxaS1A1?=
 =?utf-8?B?cFNGa2tuMEFqTzIrcjZRS2c1TjJYcGg5eGkzWWVjY2xrdWV0OWNzVFRjNS82?=
 =?utf-8?B?NnhaOXhGWDZxdkFZWVVmSFZUOGROSkgrZi8xWDdyUnZzdHdZV0YyczYxOG40?=
 =?utf-8?B?a0JzcmQ3WUdMN3VEL3lYdFVHT2p3N3RwYWhKMFh2M2xKdmlwQ3RVTzluV3Ar?=
 =?utf-8?B?OVpkd2IwMWZtTmdPSWhyeDdRTkhKVVBqRmlkZXg2MzFIZFJ3L2hGYUREeTVZ?=
 =?utf-8?B?WWtDaFlhelNncTNnd2Fkd2pTNVhyVXY1aEVsS3dCd1N5dXA4MXVMdlFEOE5u?=
 =?utf-8?B?ZG56dmR4dGhXM0ZvOEV5TzZKUTZGY2VVcFdrSjNpNzUvMTFqUmlncXVHMFh3?=
 =?utf-8?B?d2VrMitoc2kyRVl1Z1JHNEdweXgxSFVMUzVXVGtmM2pUbjJsNVR0Y2xocy9t?=
 =?utf-8?B?bC9lOG9XWG9ZT0RJdVlvTGNSTXdqQzdTRmFGUDc3c2Y3eis1eW43dDZrT0p3?=
 =?utf-8?B?ZjdWTVpQdllBc3AxVTBSdnlWbEUxUGxHcXJMRGY4aFgwZ2kzQlloQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747e231d-17a5-4b3f-0ef0-08df41c4d4ba
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:29:35.2017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ca5LY6Idab3hel/pB8TPqfHgA4Mj85Sya9qlSnl/1KbX/XK68w8YFz1zReiZhuBykrc+VoGqcEfdY9v2+AzrQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-09 08:55, Mika Kuoppala wrote:
> ttm_bo_access() reserves the buffer object itself, so a caller that
> already holds the reservation cannot use it. Split the body out as
> ttm_bo_access_locked(), which asserts the reservation is held, and leave
> ttm_bo_access() as reserve, access, unreserve.
>
> The first user, eudebug vm access, has to wait for the move fences and
> access the object under one reservation.
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Michel Dänzer <michel.daenzer@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 61 +++++++++++++++++++++++----------
>   include/drm/ttm/ttm_bo.h        |  2 ++
>   2 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 872bf444b1f0..9a252bce9091 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -405,6 +405,47 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
>   	return len;
>   }
>   
> +/**
> + * ttm_bo_access_locked - Helper to access a reserved buffer object
> + *
> + * @bo: ttm buffer object, reserved by the caller
> + * @offset: access offset into buffer object
> + * @buf: pointer to caller memory to read into or write from
> + * @len: length of access
> + * @write: write access
> + *
> + * Same as ttm_bo_access(), for a caller that already holds the reservation,
> + * for instance to wait for fences before the access without the placement
> + * changing in between.
> + *
> + * Returns:
> + * @len if successful, negative error code on failure.
> + */
> +int ttm_bo_access_locked(struct ttm_buffer_object *bo, unsigned long offset,
> +			 void *buf, int len, int write)
> +{
> +	dma_resv_assert_held(bo->base.resv);
> +
> +	if (len < 1 || (offset + len) > bo->base.size)
> +		return -EIO;
> +
> +	if (!bo->resource)
> +		return -ENODATA;
> +
> +	switch (bo->resource->mem_type) {
> +	case TTM_PL_SYSTEM:
> +		fallthrough;
> +	case TTM_PL_TT:
> +		return ttm_bo_vm_access_kmap(bo, offset, buf, len, write);
> +	default:
> +		if (bo->bdev->funcs->access_memory)
> +			return bo->bdev->funcs->access_memory
> +				(bo, offset, buf, len, write);
> +		return -EIO;
> +	}
> +}
> +EXPORT_SYMBOL(ttm_bo_access_locked);
> +
>   /**
>    * ttm_bo_access - Helper to access a buffer object
>    *
> @@ -433,26 +474,8 @@ int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
>   	if (ret)
>   		return ret;
>   
> -	if (!bo->resource) {
> -		ret = -ENODATA;
> -		goto unlock;
> -	}
> -
> -	switch (bo->resource->mem_type) {
> -	case TTM_PL_SYSTEM:
> -		fallthrough;
> -	case TTM_PL_TT:
> -		ret = ttm_bo_vm_access_kmap(bo, offset, buf, len, write);
> -		break;
> -	default:
> -		if (bo->bdev->funcs->access_memory)
> -			ret = bo->bdev->funcs->access_memory
> -				(bo, offset, buf, len, write);
> -		else
> -			ret = -EIO;
> -	}
> +	ret = ttm_bo_access_locked(bo, offset, buf, len, write);
>   
> -unlock:
>   	ttm_bo_unreserve(bo);
>   
>   	return ret;
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 32791c4db2a9..3b08baa33ffd 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -441,6 +441,8 @@ s64 ttm_bo_evict_cgroup(struct ttm_device *bdev,
>   			struct dmem_cgroup_pool_state *limit_pool,
>   			s64 target_bytes,
>   			struct ttm_operation_ctx *ctx);
> +int ttm_bo_access_locked(struct ttm_buffer_object *bo, unsigned long offset,
> +			 void *buf, int len, int write);
>   int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
>   		  void *buf, int len, int write);
>   vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
