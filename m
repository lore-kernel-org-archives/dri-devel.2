Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2167ECD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F76A10EECC;
	Wed, 13 May 2026 14:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QwjWmGho";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C847B10EEBA;
 Wed, 13 May 2026 14:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+SVWQy9JguGrvvTlhf44HuD+VvfW6KbdMJz4HlkBYAXm/vpbDLW1ngua2/47Mj+Q8ufP8L58oeyZUxgTTtz3GiKFEfkFWLFTsI1UF7TBolUDbtj+OAuzPgpaYTLvzk5+C80M4z1oYOBQDA51JLLGLz1IsbtEz3Uz3YRXguwBxZb4pb/iXwK+dfNZfz30ZmxDB+q/mzvfyAbp1zzaW9tUMtNlJmB6NjYQIC/lMu1uqXOjqBPprpjcQIE4uRV16xnscIZ0ote9YalM09JXx4cO5y8urQrxPgobNT+Poyfgl/XM55EVNx/XjaU8oi6w1D7fPyz96rgkB1Z87ufPelg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6Jqw87BIPB+lZdo6szYMQaIfoR/5cHpK5VpgbDH4Mg=;
 b=q8G43SziII/3GE7bGopiBZH3D56DnnayLJQlCRsTvOYGNgfN8jxmU+fHQqawFs1YpcDFA5xOU4E6ru6579tJdEHwbJ0XJ5gRL5boF7rs47e0s7FT02iLcrDhe9biVsxyVyV7gf8MjZo8onv7jMGkjhn5LSerqnWHF5Gfw0hLh5nbmGc9a4zJpd0yULLKyuFQmQejBon+x3jW/qeSNIXdBm0W7CEfrqU+dxg0Stu48F0NXZw81dO4J+tIiBEfnYHPt3nhh5ukB8S3RZc4WeGsEAE8Hzmo9rS69mUsKsHsox0iLIGxqOkIuagzwf7YKi880CQz1ZMrsvjAVeKoviSiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6Jqw87BIPB+lZdo6szYMQaIfoR/5cHpK5VpgbDH4Mg=;
 b=QwjWmGhofibxDGneMAtx6kiU5K7Tt1V8b/7KVAhfP6+Knjk/6jxSSU2QZIRp0win31REcFwbPXjR1VG4qUHt6HvrZtkyi2tAhTodZu71RYaKeUM6WZcfEJVQqskrx7WWNRIMrC72soAxFjf6ZUbgJiedSBrtL5WxymIYSBQTc6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:19:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 14:19:35 +0000
Message-ID: <4a91b7cb-e395-4ecb-854f-3dbdc6ae0a42@amd.com>
Date: Wed, 13 May 2026 16:19:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Support 52-bit PAs in ttm_place
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20260513141253.20410-1-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513141253.20410-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a01b580-f65c-45aa-81f8-08deb0faa868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rtNs7ErKuQZKhyUbuAv3mRKckiQ+Kt67xkVKOO/Jd8WYzBczngCc9nNZVX5UxFsPohfU/zcaggx10KQMoLdXpyvjFKyVOEeS5mObpiE9Urp2texIFxAsss0be1YtU/R/fKSIxbysPTKUVrnz4Sz8qDGE1Pl/mwfM2yojOWflh2lgdMCyctkhAIlboy+ly3bZ4Y48e8f2uVoeUy0qDNucUn2YqqsjR7z1ubhvPzVZsAltjhrioZEWngEeTO5JsUVAs1EtssWXfNDqU7AeBBO8socPFfgJeoI8PgzIM+YBm1Y99DeYkS1Hqi14owECdK1TR+ES5a7CYl61STDksvHODZRnPEf5LRQ9o8GBkt7RwNJkRH4reec1Ka6nPEMRM8ryMIRToFKwQPLDXB1d4IBPHsasyjIKGK3FZEqNuueroVxHJoYwbQKvFOg6UYKp4fclt0Ni8Fl0IkhR1UOkTLtHKcwkSOnNyBrjZQmtQa+cUJt69fR94dlyl6v7ddhsq4Kp7lnGOsNCDn+//8xWbqQFhg7vpimzAYDo4paGbYuSmzlT1cY1u6GBXZqQ1XxPSySX74lROiZ5ouq+/k59k8RjASWQF+A/fiKHQItiygFj54XkmQcM61V90eBMKWlMd4GRUaEJ0fjT9QS3U8docJle1zBOKJqiNuqY2g3wpiuYvy7rLnHav/0IIIbV5rKR85Le
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFPL21FZm5jd1lLcS9yYkJTcWtiQ2M2QW5mMU55WDFZakJTRGNzbXQ0M0Zr?=
 =?utf-8?B?TndZOXpnc2hQMGJQcUdYK1NscDQrdlVLemtRUmRKSUFsRXlyYkFTYWVhTjAr?=
 =?utf-8?B?OEhyVlAvQ2NDdkMwWndwbHRuYjBkbGppL2VHVjJldDBVUncrRlN0ZkFpSlpr?=
 =?utf-8?B?Unh6aW5PVjdzTGZQUWF4UzdEZEw3VUxseTg3RXVJOUx5T2djVU93UndSZXlq?=
 =?utf-8?B?TFhVMm4yL0ZxbkhMdnFUWUlMMkVkeVN4cVdiL0ZJR3JIakVRcUVtdkgwSUJq?=
 =?utf-8?B?Z29ReUtHZkpqWnFWWDBNc3Fuc3FBczQwVDVUWGNWckFDNDRUc3o3d3U2UGFN?=
 =?utf-8?B?S2oyWm56SlhIRHNvVkFZZjZnTjZXT0VoTUZkaXVYcENkUTJvRDVXL0dFSnZ2?=
 =?utf-8?B?YmFOY3dTMHExb1F3cmgrSXBXb1RtL1U4RTRTNkorZzNwVENXQ1FoTGVtR0JF?=
 =?utf-8?B?L0dZdTFsaTZXSzNUejBua2NhZ1VRNmVKYzB4SWl2NmdWdmloQ2ZoOVFZVU1I?=
 =?utf-8?B?YkJ2bk5FSDY5SFQ0cmpZc2tNbGxBdXU4UXVQQmZHUFhRQ0RRTTJTajVUR2pa?=
 =?utf-8?B?RE9pZHpEVnc4bXU5NmZHSDVDMlloRDR0UWFJSlU1dGRDWEtWaWJpbzVqM3pU?=
 =?utf-8?B?M3Rkb2daVVpBSzhnQitrcVB2QzYxN2g3NmM1ZjNncWQydVcxdytUYmxmZXhk?=
 =?utf-8?B?bVcydHZpeitQZHhtV0M5Q1dnL1BnMTlnSlhZbmZKSTUyWFNLMmtDK2ZzTzJK?=
 =?utf-8?B?c042VmMvS2djOVM4U3ZQanY1SnorVkRxcm10eUJucmpJU25PNU5OSTBQeE0z?=
 =?utf-8?B?MzhOdGJRREhjbEFzdG9sajYxZ0dTY1BoSElzRmJmMmthZmdMQ3J0V0xENVVh?=
 =?utf-8?B?ZzZGQWJsRmdhRm1wS0RORFE4czNBRjFNSnR1anBmTlBhbDZxWHN3Q0twUmMr?=
 =?utf-8?B?cEZlRUlQYVdSRGY3N3pCM1B1OFhZVzNkdlUrdzA3L3J1Z0lSdjFxU1ZYcjRu?=
 =?utf-8?B?NGVNdXYxUitaWlBSazZVOTFmREhZYURMMFJwQklnSERnektFdnloVHBEaXIw?=
 =?utf-8?B?cFVYaDJ2OVBzTzIwTHpOcW02R3Y0Z1RxdlV0aDQ4Y1NYUTAzL29GblFwQnhk?=
 =?utf-8?B?N1pYK05oVC9DbzBmbDdHK0dodFIvaUlid0IyY01SZ1AzR05KSHhXTWY2MmNY?=
 =?utf-8?B?eUhkRFBNWHpyUlZDb3NWYktQNzZXNEs4WnZNQXZPY1FZc1l6cXluS3BIczBu?=
 =?utf-8?B?dmNMMUFlZ0xZcFJ0K0hZL1Fkc0FtQ1BvZWhuVkJXUTlSWTFCdVhwWHZQM0Vt?=
 =?utf-8?B?RVplQ0UySGF4eTZMaWUwVWhTQk1wZWFWczlBSGxDOERnL0FNYVlJRFZpbEFx?=
 =?utf-8?B?WldHNDAyNEZvMGNzY2FNZnNrY1RpR2gyRDMxVVdUQkdPQ25JVE02ZDVaRUZV?=
 =?utf-8?B?Um9iV1VlbnRxUm5lOUtIaFhYMzY3Z1lqM20vYmpPS05JTWZQZkVUZVpzSlNF?=
 =?utf-8?B?VFBwOTZBdHFiaDExWUlvME9sZDVReHRObWMwWmlnN29idFczeW9nMWRyajR4?=
 =?utf-8?B?aVVSbjJuZzFYcUpld1c0T2FxSkFkU21MQ0ZseE1RVE12dFQ1dWFUMTJjSVUz?=
 =?utf-8?B?d3pSYTdRM1hFYW5YMFJxZ1RBMmY5MmpxZk9XN1h5YUJFdmxwNVRlUnFzcGl3?=
 =?utf-8?B?UGRqRFdiQmxTQzNlN3hqcUFEbjRtOFIrTHhjU3dQMDFtQkRWRlpNZ1Bmayt4?=
 =?utf-8?B?SnVOOFBtQk0rTWZCZXU0cHVnRlVUVmlBTlYwaGQvL0tsaXRJaHVKS1IrSW1D?=
 =?utf-8?B?TWcvaVc3RzdOdk5na1VTMXlST2lBVnE0V1hmb2RucThDT1l4QUYvOFlRQXVL?=
 =?utf-8?B?YkU2SFNDSjd3eURqWDBoYU4yaTdqQ0tPUWYvV2U2dHRQc0JiSHVGN0pQd2I1?=
 =?utf-8?B?c2ZmK2Q5dDA5WHdpdUY2NitOVW1LRFZmdXcwRmZzTU5sTGF2c3E0RFhkRncv?=
 =?utf-8?B?RGdBOTluTlJMVWVXQmpWNDloOVZVNTBDVmZrV0dMNk44azZWOVp2aGZGVnht?=
 =?utf-8?B?TjNnZC9zN1ZPNnFpeHdIUURIRWhhYmI2YVYzM0R5R2p0L0NKUlIyQ2VjMW54?=
 =?utf-8?B?M0RaWGVRd09SdEpkZEZaVkllWVVBbVV2RjlSSEYydHZXT0VUaVZDc3MxTXBU?=
 =?utf-8?B?TjFteUpIWWJaUmVKeHMweENOSXdBMC9mVElZUTkvaThzZm0zY2IvOTJsQ3ky?=
 =?utf-8?B?aDhrdUlGSzlobUZvdGo5SDZOY2tTR09ZMFZldGxpNjNhWFZ1bXNESFNJSndm?=
 =?utf-8?Q?/DZdDUthOrbLtOnFsk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a01b580-f65c-45aa-81f8-08deb0faa868
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:19:35.0169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfX7xC/NgjVCwEAcsDL1TG2K6RtgTn6yo5piLcn0PCytSbQyrnOFJD5Gxs9T/60X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

On 5/13/26 16:12, Felix Kuehling wrote:
> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
> size this can support up to 44-bit physical addressing. Grow these to
> unsigned long to support larger physical addresses.
> 
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

@Arun can you pick that one up and push it to drm-misc-next?

Thanks,
Christian.

> ---
>  include/drm/ttm/ttm_placement.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
> index b510a4812609..ab2639e42c54 100644
> --- a/include/drm/ttm/ttm_placement.h
> +++ b/include/drm/ttm/ttm_placement.h
> @@ -81,8 +81,8 @@
>   * Structure indicating a possible place to put an object.
>   */
>  struct ttm_place {
> -	unsigned	fpfn;
> -	unsigned	lpfn;
> +	uint64_t	fpfn;
> +	uint64_t	lpfn;
>  	uint32_t	mem_type;
>  	uint32_t	flags;
>  };

