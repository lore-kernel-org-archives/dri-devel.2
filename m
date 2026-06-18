Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFDACD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8A410ECD7;
	Thu, 18 Jun 2026 07:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4unl40M";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D67C10ECD7;
 Thu, 18 Jun 2026 07:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyPjlTPK0A5V4jsN6ZnuTtuXRZQ5oXTxSPpeSv4ZaPesvvF/pfwd4Lwk4G2dPhGvVd53CHPE425CZPYrkKa/Umq7+DjjAFH+I9gCnE826H96zEZUpU55eC9l5dONGsN9FQOR8uO1zMpCWD3bk5qdo0HBEnf2UpZEKbKQdYQbau9WgsTPfvi89wJ28XvS7jgjh0Z50oUFEyTDkit7YoeidX3gdEs6REdQoiLUkG1j7v5BbcWnevjd3WH0fPC7q66mGEtWBJ0/YTvEYjUlpJoZtR1u8KHUBxYXb2g3I3LiaTxbui/m75zf3ykeDtBuOOoUhed+9iX+tBazWcVxu5S5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7GkAcniiWnnje9BlJamod2PQgvJqQ5UULDCZeO14OM=;
 b=O7zcsYY/Ng18s5X9PtLGZFCJEgKfngkqGFyFPSyJd6YnM2CsBP0j23LyF1Fw4Lq2yc3mwe5k64qE/BX8GcRsL6uVM+wSNV3M3WsPhAP+e1HFj/s2qf1PCbaciAwKx77bs8AvOM5XA8WS3aGZRiNXgnzRxX20RcZIsf6TljEF0meeeU/p8ANifhOL4eBNWUxfxJq863bpe6DD2HAuoqyB2GHaWpql+07jMQT09/Znl7ArQ52ZbBqJxAWVkNoHhJmuP6HJXNDMEvoFhST7XNcoHNbkA70Q/NyPyGOsS9jMmP5eLvf83yXvNUT1AFJCk7BwUO0LO25KUZYm6XlqOPAKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7GkAcniiWnnje9BlJamod2PQgvJqQ5UULDCZeO14OM=;
 b=D4unl40MwvgTuQG4j47FeBdWJa6OBG5JqyR0n+PHdD4fiBgF4kYVU3JF9i1vKy+0Nz51nRT4046Mf16Ov5mRaypOCnjQKj/IgGG/18GLasAmELoHEi7KLxnta+YbHVIt7A4/UVy1kv1f3LXL5gXEuJrDwcxhBd5RxCFWRRxl5ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Thu, 18 Jun
 2026 07:37:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:37:20 +0000
Message-ID: <cee10e27-1bf9-47de-9d72-4f2c7ac606ef@amd.com>
Date: Thu, 18 Jun 2026 09:37:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: initialize ret before UMC error record loop
To: Ruoyu Wang <ruoyuw560@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20260617193335.1662613-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617193335.1662613-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 3940c4ca-0d4d-4c02-ebeb-08decd0c6e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: SaAGRypbMA2Z0g6PQ1+kNzNOKRqQ717b5A26mDO7uLBBMeZAbYeA84vBFArVkdQJq2CCRX2SoD8WenUqH+a5PfOAZbJX9rwAygfvGnBIau1KQTp7X+GQZBTqxyEhEbpX0yPiB15jMCLFammwgz7ujjgCuy0O41uSegxO9SuN1cVgodCHnVtv/9a47JNLtBKtSR2dWjF8M1F7aOpXbHucH0M/4Ysu2+o8ZqYYfLK27in97AXAKYz/4GliBcN0Hkle8Q90ag/RmXggXLQtBEPBObQLOxvRRWYsmzanerbQUt8Rua0UiOW6I1BRvSv58/V739pDuaZ82VxhQ+eWRzgB6sGwK/mfChzarDqAl+y3NZRbfZR7OrgxLNioDrlZrdS4mTCfIHc9IfsE9eHtfEtHXnie78zEurIDDhEwP2C3LJTlR8As5v+Nk7ZjJq/VuOODny1isf0e6v/rOOhz9qbH7Ei21nnko1nYMTpaJE8j8m3RqAdcHgkMkp2lrSln7vabS+gEh7Ut01NlxxcsGO5K18uDoPLThV8frcYg6IoQck6G9tznm1tD1SbM+0iDQbDXbR4DQJmF8Q+mt2ODRHk7U1GWw9TmuCNHejcLiFOdzUm2Nj3Yku8Pvppd5lBSSp86bV/9gjWqbcQ8wq58xRop1ozjZDWy5V+8htgYlxu1AKwo7YJETOps3vBb6MoZjYZGo6XYMrBOm0iQuHvYaD2Id1+fWWZZu8CJDCdJ1hBzfdt0QMXwPleUWuKlHJ/TO0ER
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckRGM0pxeW9NUGR1eWpSQTZQYklTUEV6YklkcVBYZ1NjNG5jOThhQWR3b055?=
 =?utf-8?B?eUxJUlRCck5yQjNNSW9aOHMvMExFaUY1RW5IeVhyMU5DUE9ZS3lyZ0ViTElV?=
 =?utf-8?B?Mmp4L0Vlak9vZno2K1Z1dlc0Wi9vK1oyMnJCQ0VOeFNTSDdKdDZkQVpBeUJi?=
 =?utf-8?B?N0pQcGtJNHNIR0Jka3kzdnI0MTIzWlJiSHQrbURkcEIxOGd1K2NqdXpYbDF2?=
 =?utf-8?B?Qk8ySkFoS2ZtYlFxZWZZc2RjNXFnZmxkVFg1UUw5NFVQaWJhZ1BTcWtPeFBx?=
 =?utf-8?B?RElsem1FRXNVNzBROE5RNjJqczhpNlJaUzRMZTlEbHhZNnNzWGhsK2pBSlBT?=
 =?utf-8?B?THlWT1pGZUtmQXQ3dllTUUN6aE9xY2d5RXdtWEEwb0dBRGtzcE0xRVdEaXlv?=
 =?utf-8?B?YktnYmRFQjVuS0dWbHFGSU5jUHA4cHo1aC9jSlhvWkRRY21FQkNNWG5DTW42?=
 =?utf-8?B?YVE0M3RSR1YxYnZGUzdDVG9HRnZVbHNuejVHOUMyU281Nk9kVS9GU29iWlhO?=
 =?utf-8?B?cUs0RDJlZHEyUURoUmVKQzE0OHNQVmpFc1dINU44OEwveFphaVNKUHJvRjJi?=
 =?utf-8?B?ZUpBZ1RVK1YySzdHVVNycFhBeWlXTnVEOU9WNGZPNlVtc1hNNkdHNHNvTGs3?=
 =?utf-8?B?UVVERE9Xa3R1Z1BlazdRcEwrRFpPa0VyeXlZV2Iva0hnTlVkWjk5cHRLY1RT?=
 =?utf-8?B?TDhpY3l6QnBPT1pKZDNpKzNSN1RxanFUQTF2bWNNY2lLZTIrZW9MV2RmVk5Y?=
 =?utf-8?B?TUtLR1FndDBTNGZ0clY3QXpCem14bEl4QXVBdmplbVA5ZHZyL3V0aTlMcVd3?=
 =?utf-8?B?SWYwT1B2Q2w1alpBM2wyRWFsOHdxZElBRnlXcEliU0JBM0F6VVZpWVRLSStE?=
 =?utf-8?B?Y0lhVHRHYlhTQ0E4a3dCbGQ2aUVXQmhPekRFQ2FsaXNkc0JHVEI5Q2k4Y2dk?=
 =?utf-8?B?TWptWUFQL0xUUktiQ09UQUJQT0hLTGtnL1A5OVpQY2h0T1EzVVQydEdSeU9u?=
 =?utf-8?B?ZDc1ak13VHE1VjZjcjNZRnFRcDZabmpzWFdERWhMKytJZmtqaUtIb0FyaTZ3?=
 =?utf-8?B?d1JnK3dxWExmT3FVclAyT2IyU0ZvR3A2MCs0a1lCaHEvSjVNeVZJRjNFdnpt?=
 =?utf-8?B?bmY4Zk9RKzJpUHlUVSswTU52TzAxN08yOFRWVmJ4eDhnQmNtWWo2VmF1RkhY?=
 =?utf-8?B?aXZFUGhaQVBJdzlCODk2cGVlcFUrdlQwRFVmSHNlYXhFNjFQM2ZGbWM2SkM5?=
 =?utf-8?B?YnRXL015T1ozeFFYRWp5RS9pb0U2dFp3VEpSckNZVW1vY01hOWljWGMvbVdl?=
 =?utf-8?B?dmRaSUZETythWWhlMU5KbmRqamt6RVBiRnQ4c1dFNFY2NlB2SWlTQk9RTkN6?=
 =?utf-8?B?RmhLUldkY2tKSWlCSGFSQS83cU8xTlNucmRsSkNDVmE0YVBvNlh0KzlsL1Ay?=
 =?utf-8?B?NGZDS1paMUFjRzVqb3FlaWk3b3QzNkpKdjJmclBpOS82OG5SblllY055TXly?=
 =?utf-8?B?TjdxS3VXVkQ4OFdsZUlrcmhXQ013OTlCOWpLemFObmNPbU9NUG5Vb1RjdWly?=
 =?utf-8?B?TWJXdUVyNXhqdzQxMTBzMmhrT2dpalB4WWlmQ2d1S3BkeXlkamo0NWQ5dXZj?=
 =?utf-8?B?NHRTYzduNXdXT09IWnozTkd2ZWxMUzRKMUdjM3dLVUpLa2VCWVE0dy9NSk42?=
 =?utf-8?B?OS9xLzFOaXVOTnVtWDlQbDJGeHVBQkE2d1o2bzlaVSthRjJDdDFzY1NDRG1V?=
 =?utf-8?B?Y3A3VVZqNWtsZENRMFVZNGVTb3laT3JlbWViMldDcFdVUHNkTVR3b1VoNjVI?=
 =?utf-8?B?ajVaTjVFZkZDeTlNVmxQV2J1bytVZFlyWksvbFhkRjJPMW5TL2NxdTBkWDkv?=
 =?utf-8?B?b2hiakF2bm9BRmlMczZwdjIvV1NXbTFiZ2hsbTFRMWdialRmUkxMSmdwVnUz?=
 =?utf-8?B?cFVUUEJEeFB4WGJvclJwY2djL0JySEwrZktmSTF2WnJRVExmd3Uzczl1cFd5?=
 =?utf-8?B?MXYxOHhhdklJNmg5aXM2M1RQS1FzeC83QmhtUlBoVHUyNyt2MUVJcjExdkI5?=
 =?utf-8?B?dlAvNmdhM0hrV3NnN3ZBNjRGeFE4RENPWDF6dmpzUE03Z01HNldlNGNsSXlY?=
 =?utf-8?B?c0o2T3lEczdZb2RNZE9oREU5UGRvaHpjSzZWcFoyeDIvR2NqZDBsekpsYjJL?=
 =?utf-8?B?SWxBZWhFeTcxMGh6cHZLNUdCcDB1YUdieENKQUNlRVdkbHoxM3lkc3RKUjVX?=
 =?utf-8?B?eW92Smhhc3Y4a3JpajNZUmF1b3BIc3FzR3lPZU05V3VXUTY2aVl6bCt6M2Rt?=
 =?utf-8?Q?UKMs/hqhf248Fch1kh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3940c4ca-0d4d-4c02-ebeb-08decd0c6e01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:37:20.6492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK/w593H3unprwSfR7kX4DM4g5sttIU3Fy9/v8ubts7nVAKSeJ94fFQzHnPsK03t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

On 6/17/26 21:33, Ruoyu Wang wrote:
> umc_v12_0_fill_error_record() returns ret after walking the pages
> reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
> return zero entries, leaving the loop skipped and ret uninitialized.
> 
> Set ret to 0 immediately before the loop so the zero-page path reports a
> deterministic status instead of returning stack data.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

Someone more familiar with ras should take a look as well, could be that returning -ENOENT is more appropriate here.

> ---
> v2:
> - Set ret immediately before the loop instead of initializing it in the
>   declaration, as suggested by Christian.
> - Avoid describing the zero-entry case as an allocation-failure fix.
> 
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 14092150336a5..4842340d9d65f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -690,6 +690,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
>         count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
>                                 ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
>                                 page_pfn, ARRAY_SIZE(page_pfn));
> +       ret = 0;
> 
>         for (i = 0; i < count; i++) {
>                 ret = amdgpu_umc_fill_error_record(err_data,
> --
> 2.51.0

