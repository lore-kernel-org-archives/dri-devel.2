Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48856CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A5310ED2D;
	Wed, 13 May 2026 08:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G1C/qncw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B6910ED35;
 Wed, 13 May 2026 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX8HyfjyXwzA1536IOQT4Z7IApmV7+DzqZtTDFeRSTysbmoIYarON9srIlS3rxxwc4CRPYr0e5BmNoILxDOb85csxFj+rSJL4bYCcRiWYWFxU/YPUeN17xg6l+Jwgwzq2g+o+Mr3Sm2gqP7BuVAv29mmouciDkujGGJRs2k3Oeyu7MRLPqAgHWrjVO2I6IWpVjB8ero+n4BzlaWrjvCFGigWe17L8hXCYCapP/lOmjNCIouzUA94xPAFWR9n3kscHgKJv7/iU2u1YKbh0ifWpzH8PnlOxi7cz7N5K70Pff0z2WRJU7ukJyzCkj0dKenjtOu9XgVfFw1g4y7T1aCChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JthJwnVv6ii06PiqsV1U8L7+CmzYuE6yTcMoVlpQUYg=;
 b=uR+WoykW00H79MQbfDIt7prasqgpSSddubowhvm15rTtBV4vXknWamx0fvi3x/Vj4BBdNfbesj6szFQEaBKftX0hlB//aCIhSVmrVsJRYk95Ig6y3CAjhcbiH+YDVNpz30Ck/XvL3J6dRXqg3+hHX5UTRfZ9W0yYwjge3UDJdjlSUpQyxTYuIUKH8zAqCVp/Az7b1ODlOu+hHY1rvseXonbHxQFchUqtiZYrGCevoo4dZ9DtaJESWOyM2yg8R/5VpDLbpKvw8y/p7/HrzkRSFdystDw6tqj/ty/bzzVFzfLZX4PhWAtxFih351o5SA8qfYHxsZzqo6ZQ137vdRhqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JthJwnVv6ii06PiqsV1U8L7+CmzYuE6yTcMoVlpQUYg=;
 b=G1C/qncw1rff2bmsvDpFacMdT8J9PUHH1lt2n/S+yLY81wTlBcttSHwb+CcPcKw+zsVBY9epTj1ttGxHieBKvQ6BRyB0+V5hkmWHM/4PhdEO4x05FZH6Okuuvjj9DVpcDbSdXSltULEZiwN5AV47VBKatSsdiDgcq5GBqwm314E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:08:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 08:08:14 +0000
Message-ID: <c113ce66-5712-4fc6-bbf2-45239a97f773@amd.com>
Date: Wed, 13 May 2026 10:08:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Support 52-bit PAs in ttm_place
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260512223154.18089-1-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512223154.18089-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: fe914d88-dd3e-477a-20b3-08deb0c6c80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 77x31dZL9rEtGgTqsvebY8KnWiyBu9EbTbUCueJkBBF3XHxAHKJ/wbTr9iDfj8OiUysb53T9xZ4ZNXcPIeQjErXMzZ0r4vhLQnNSigJlsJ1CFzOS9X5M2UJQPetOrbMhZoEF5M5KEUtiJH0si/ELHP8p3u3XDki2neq4sNUwgl8sLxaE2hTSoie82O5vZoobfWYiGQ7TBejxTSfTcBJSArHL0NVaT34AcSHF7agNSqiYHgfqsJqbYLCEHrbUDftT29TReT3eLTwS8NUlfXFk7iupkBnDnMgURIVpNzkzF6iLhsx0acTk62+31F1TToZnmDPHGwCQm64aZRqbmq6X7PlJwLzlhOtmtzDkNyam4Y0+6KMkxdLYzI1lfMuDNulk/2soGeyz8ROB48LQVt1wxBhE9iPCZVuEOf0X8QS9yLr3BRUImZuR3pfoayNXvoe4X2NGWOpgXM0z+4IqoyDYOVqUb+/0/ohWI2M9qN3M0VN+HYXo/ToXLDNch/imYV+xPl0pKLkvaxe/eAKDOR/hKvuGnxRM0WW99fqsVW9t77pG4QjWyzVIum2VjTnGS+VBP06ArGDU6Xk8seZsv8LsfRqetgtka9SbQ1xPFFn7m2PFEK35j9YaTla5+3XshTqaCu9rXThfOsF+knjjEOtXFNbrcE5PNmjla0+yLjNEinY1EGU8jLh3x9igbV2wjgay
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdjTWhOc1ViT0dONzdFTGlyTEhXVkZxeXNUZTJxeDRqcFBNMGRzK2dnWFdE?=
 =?utf-8?B?d1d6WEFiV3czUDZxblN1S2U5WHRLSDdLOUo4MG5qRmxldWovdnlsTWdGTmhR?=
 =?utf-8?B?b3gyWVZDSk9iTkd6eFl1MEx1ZUJYdlNIWHRzd1hNUG91UmFUYks3YU0wUjg3?=
 =?utf-8?B?M3d4eEg2eVhoZ3JmeFVnN3dsZW9sakIyOFgweFdHZXRVdFk1KzBVMWkxREFY?=
 =?utf-8?B?czV1dVh0OUdBTkJPZGF4bFB4ajdRekExaCtYTjVuWkdaemJzZHlDTUgzeGxU?=
 =?utf-8?B?TzY4UVh0cUIrLzJpNEJUN2l0YmtOSGRXcGpoM0lJVzRtYWxMbGIrQ1hrTGYr?=
 =?utf-8?B?bENkNG5DbWlGcWMxbktPeTBiMVRrM09lWXEyRThLcDZXVkVQQ2tIT3EwZ0RN?=
 =?utf-8?B?TkFWOHNtbkJHOTNGLzZJNWZHbXpMU1R4Z2xVNTc0ekROdGlZdlQzdktFMi91?=
 =?utf-8?B?WDZCaHhYMWkzL21PVS9HNE9GbHdNQVpNemhwd2dCaGtpZllqT3MyN1gxQkxw?=
 =?utf-8?B?dzlTOHNycVBEbXA5eHdhTlc4TisxOFZrMzJGR2FaZXU0dmsvc0RUYXdLQnRQ?=
 =?utf-8?B?L2M3S1JGRHd4WWlTdmwvcUZBT0tQTDJEK3BxTnc2T1BpazFETWRKN3RDVUto?=
 =?utf-8?B?eGYwWDU4WHkvK1RVRURlTkxHNlRKMXR3a3pyOFJhdVd6bWNoMHliM0tnN2pM?=
 =?utf-8?B?cEdQUUNXKzFaS3NhalFIdjVpOU5NdENFSlhKbzh1bXF2Z0xvQjE4bDJEeE15?=
 =?utf-8?B?SDFqZXYzU2pxUU41MmhsZXRmZ2FjQitKSFg3ak5tSlRCdEVUOVRtYlNFVW8r?=
 =?utf-8?B?TzZBbHFKVHhtbVoxTWJCUGlGMzQwOTRtMm9Bd3dWTTNxVWdwK3pGQjQ0b2Nk?=
 =?utf-8?B?NnBZbEV3ZjdYYmFBRG1YR2JpYWZreHdscWhRZ0MrVXJFYkhwNXNoQUEvNUpQ?=
 =?utf-8?B?bnJOblltTGlaa3BNSmxjbGh2RzV5b0pGZ25yV0tZZzk3Ykp6ZmltMEE1L1Zx?=
 =?utf-8?B?UWh6MnhuOERTRDVBc3RYK2p2K1kvMXI3TTRYS1NINks4SkZBMFFxZXI0VHFr?=
 =?utf-8?B?K0FhUmpaV3k4M1RqeVJHV0lGTHNRcDNmRXNkWDl5cTd6UTROU1lMT3ZOUit0?=
 =?utf-8?B?OWVNL0xmbXdQWUdOOENIOXdLcUc2dUpGd25ZUlhVMlB5T01OMEhFKytxeVNh?=
 =?utf-8?B?V1lFV2pmdXZPYWx1RWthcnRoTHRJRk5MaFpYNlBSZFZROXF3SmlDS1RYaVV0?=
 =?utf-8?B?V3NhQXAxd0grL1BrRkxWVENWdzRycmZkajVTNUMwUW1HUmplS1Q3YjJHYTVn?=
 =?utf-8?B?NnpYNGhOYUhZQVUwSFZGSGhrdllqS2sxVGFVdGdlY3NleW0rMU9QL3dDWi9C?=
 =?utf-8?B?Y2ZhSUxEdmEwR3ZZQndRNHpBc1VyNXZXbDVSQXJiVXorbU5FQ3hpUndMLzRP?=
 =?utf-8?B?a1JsVGRhV1NkUHBzRTdBMTNra0Iwd1RWVVRETjVibkpETjdsYkpWTS9VQ01Z?=
 =?utf-8?B?UlhyK3dPNlhQV0dwTElPaDZVWldxTWlaMjU5dGNzWFM0RTJrbTBMc0hMdTBY?=
 =?utf-8?B?TGdTT1VqRExzdXJTUjBTbHVONlMvQ2xZWEZaS3IvYkxrOGR5cDBJVVBNZ3lT?=
 =?utf-8?B?WlhOM2xUM21YOWFLZC9VaXdsVllpVURPeUl4YmpuaUZ2aE9nV0tHSTRHbUJs?=
 =?utf-8?B?L3I1a3A2cnRNTWNDQkZTLzBtWCs2Yk1UeEhvNS9SbGVyL2JJU1lQcTVsdmVG?=
 =?utf-8?B?WEZxNENrcWgrMzAxMXZaRkVYTzd3QUxVRERBd0doZWVTc09ZR2Fxb0cwb3Rh?=
 =?utf-8?B?eVI2S0xva2N0Q0RHenZ6b3N3OUdRSHlTRXdYa0lsYSsrTW9zWjV0aVhkOHpy?=
 =?utf-8?B?a1JzYTd2NVovNjFOd09IRHpYUVVhdGNFU3ZyKzNnUExuYlNOeFZZYUpYeG9p?=
 =?utf-8?B?dkQwS3dRbWluVVp2blg0bE54bmdkUmp6KyszbXJwRmkrSEhYaVVmMUlLZXJT?=
 =?utf-8?B?NXhXYnBwUUx6YVZLQzBlN3lOY1UzYkVSRXNtbThmMklqdTZwZVNaMTJza1dW?=
 =?utf-8?B?cThvMGdUcGp3RThBQStnY0VaNDJhWTNSUmZpdE5TRE5iNHp4TjhaN0dISWF6?=
 =?utf-8?B?STEwTDd2Y0o1WnRtT2tFdFRKSk1sZGJqR2Jua3hEaTdKWjE5Z1NIWlcvb0h1?=
 =?utf-8?B?ejJlMlBKNVUwVi94aGZuM2xndDdtaTQrc3pEbk1UQUUvYjM1QmF2ZEtFY2l3?=
 =?utf-8?B?N3lMMlovS0wyRFQyVTIwRkVoUGR5cmoxRU9jM0YxK2J5SG9xemVCZ3VrZ2dT?=
 =?utf-8?Q?3rdMUmcBfm43xlOjde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe914d88-dd3e-477a-20b3-08deb0c6c80b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:08:14.0821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb/SCP2c0S9HxhtwVEh+HKZcvACTbiAHgG9Tiz5igxT3BXJyvrp8c/iVa6EQjXRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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



On 5/13/26 00:31, Felix Kuehling wrote:
> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
> size this can support up to 44-bit physical addressing. Grow these to
> unsigned long to support larger physical addresses.
> 
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  include/drm/ttm/ttm_placement.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
> index b510a4812609..3e88869c0f58 100644
> --- a/include/drm/ttm/ttm_placement.h
> +++ b/include/drm/ttm/ttm_placement.h
> @@ -81,8 +81,8 @@
>   * Structure indicating a possible place to put an object.
>   */
>  struct ttm_place {
> -	unsigned	fpfn;
> -	unsigned	lpfn;
> +	unsigned long	fpfn;
> +	unsigned long	lpfn;

That should be uint64_t instead, long is CPU architecture dependent and we clearly don't want that in TTM.

But apart from that looks reasonable to me.

Regards,
Christian.

>  	uint32_t	mem_type;
>  	uint32_t	flags;
>  };

