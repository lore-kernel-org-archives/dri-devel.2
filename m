Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC80FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF3B10EBA3;
	Tue, 28 Apr 2026 14:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JEiZTou9";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A072210EBA3;
 Tue, 28 Apr 2026 14:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh0oLWW8sMzBsDnwI1oWXbkcNX05TNvNfIUR0V6wxDd+K56bmWpNgQ9B9t8lm+Is6cddtrnwbFaq1flRopFap4ajaMR3d9SrEufGUcLQE8eM8I8CluulxSCwCVCYN32i0edyGfCCqfBNgzwuzGmUg+cr6m1mPCpYoestMaQ+JMaZqIiJgHVvok18lkJi/RoaKt9GHUocH9TUmwmBJFZap1bpGGNRvyzci4nHfNlxutzS0oPDNsYzOE35NPqOQ3181SZsd6SX7vKFfuqm60Z2gUq5n6HKhFpeuOBFZ2BwJ+rUPddggxKAfrgGhOh+PhbIq8yMUgKgUp6JqYoFfHg/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P04oBqk6Ce0enh6pitoe+X3mmlweucCbvjXdKOyBeRg=;
 b=RrqeV1ElfA2qscyBCkGT/NNQxSCeYS2rdmjBMBh384VrjmqO85mhVnb0gL1sBuM28iHC8bEKoH6AN3nTwBTahGvWSayk6I2TE4c2qx3UU4E1pzbnzOQcaddkbrMP0KLElkMTbTFOvUuICSZF/iGPs5d6PtkUK7rR9Rhhb3SZjXBNElqn7ytV8Pb721Q93UTP8VxRHWGjvl69AH2oEmxGoMaah3PHYFGS0CLySDABbMIoxni5ujFTbCEUWRAv3jiwgGH/puqLCV1OV5QbjkdiimQZZ1oxnuheER2lvMPHGM6jNWFMAgJ6MGGiX+VJb9/xXSMSNESPMo1lfvHH8I7eJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P04oBqk6Ce0enh6pitoe+X3mmlweucCbvjXdKOyBeRg=;
 b=JEiZTou9m+BABKisXF8RUNrvhTQY+LQ8gTKiBUj+oGZ/f7kLS1YJD3Vp2s+JxjW71CQdXxHNqGN5U53CuHcO6sbEi0edbsv7cHnNOlGacWlcOJUMguqhUg3B5IjjgRaF4HgFarTFXUafuBU9iMERnWYxgPkt3Q7irlLi6dDkhAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 14:14:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 14:14:44 +0000
Message-ID: <f13572e4-c225-4ae0-980b-39675afe4b5e@amd.com>
Date: Tue, 28 Apr 2026 10:14:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use bitmap_clear() in
 amdgpu_amdkfd_device_init()
To: Yury Norov <ynorov@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260428023536.449877-1-ynorov@nvidia.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260428023536.449877-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 84904886-06cb-4d8e-8668-08dea5307f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: brjnUQ2ah5GeQI/8eEaQHKFqdcIkCP3VDagK/gehvPo+PQ/At0xHOUou3CbuEaecOeRXsIZskr/Lq7dw8CEp0weoG59tr0MxMVWUOXIgmXKWzCD0PYi4uaClhWYqc1cboEK7XYWGNEIGojXsPLv+yrr2NrQf/Web8nEvL82ku4DTKdwlP7OlvRrSIKnJ0fa9c17mJqnhbnz5aiakKR4xA5ul7fSRvaZ72QC4sM4cS4vptCsEEz3xMHCiEIPB/U8caaZutxJTZGSdHFUo95CXPUveqU/QNVgOlrOV6ZI0+ErRrHB4T7uY0eB7Bb0lfLUwYqbzidOdZmi86b01EpyqYwfaN5tzr9CJK7wNw0ZcmK+8LUwgBPdCreZ7H760YNInRALY+JUYH+ORqZ4syy9xzXncE+byWkojpWFXCuEZUZweo7Bm9X4MKAq+FTHviosVB1wNIhZSh07+EZhFp5+HANrlwnWjovkl14+nQbHoBD7N+fNnAgjbUqWzyIsQnPGMs1DGgeZqq7JTcfuZmEnPH3uac+2QNZWBpb+K6w4FXB11H9kn8ql9LU4L/giXunDBR1gD6WsrF6xIqkBSUAygph14JkAfLogjsyJdpgwOevobbLFuNwtOGsKRacvy9NcQwIUk+VDEt65jkJIzhvbyiLXFvRaMjYGDUs3x2+yicO15S61P6RvebPhIzFZ5okydL73SfXCH6ptgwaEb3jcDuMqLWc+aj/9AeFopAU/qKASs/gJKGJwcYVP7rKksnUfr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNReUREaTRNMkQxczYyZ1JON0prWG1RMHNWNDBjMFZOQU1Ua05BTHpaTE43?=
 =?utf-8?B?dHNMUWdQNGRoVU5CaVBXMjBYQVJwN281QjJHbDl6dTBOTVhXUlIvdmpGN3pM?=
 =?utf-8?B?VXk3YktKSmtsWHhCVlNld1hQZ3RaMDVZWVpUcXFCWGJNOUVKSzVOS2t6SzZW?=
 =?utf-8?B?OTZMVDhUL3FtSHkvL2puL1lHQjN5QVJKRVlmUWpWUGdhWURqSjFUbDRnSUdT?=
 =?utf-8?B?dk1jZ1ZVcmVKekROVm5mQ1dTQThHY1VITUxtc0U2WTdtSzhaV3pRelpReWV3?=
 =?utf-8?B?QlA3cm1DS1hNQWFhdWxVK2E1VHBvMmwzektTRnBmdnlubkI5YnBVMGhjMS9i?=
 =?utf-8?B?MFRvU0xyWSsxb1FzUklHOTNrcjBRYm83azlBTEpzSGhRTUFNMnMyVEw0VzUx?=
 =?utf-8?B?UFhkaGxiVmFBcVJpMkZzcGNWQkIyRzlDdC9ORC81eDVxYlEwRUZjaUp3R2Vw?=
 =?utf-8?B?OFBiMU04SFBsMmx0VU5CYWVNc2h1VVVtOE4rOGQyTWJvRVBuWEZXTzFNbmhv?=
 =?utf-8?B?WWJXczJkSWo3Y2ZyblZWR0s2b1BBZTlWUVNjaDdrOG91WEVMR2RPbFZhTFg0?=
 =?utf-8?B?dWYrRHpyenNxcVBZY1gvNmVWSmlFUkpxalBRZWFRNzBqakFhdFlLY1gzY3Zt?=
 =?utf-8?B?dkFvNkFUakVCN01ZQWR1cmg3UENDT29BeE9kcDBpK3FSRURxMXBIOVIzemdM?=
 =?utf-8?B?VnFKZjB5YzNkU1JsRkw1aDdQdkJFWCtkN3NlcnEyaUs3enVvREFjekxjNitp?=
 =?utf-8?B?cmJaR0J1Q281Y1JrVlo4MFBRc3dmTTM4UStmWUY0NUQ5djlIS3dRRit0Ynp1?=
 =?utf-8?B?L1liZmZlWlUzSUs2c2NlZ3pBU21BUE1HQjM2dFhpb3lCRFhjZ1JUVHJwcmJZ?=
 =?utf-8?B?aCs4am9oOGFYaHlhY3RKTWgzQ2lOSU5yd2hEc3psTTBsRTJQcTNJUHBKNzYx?=
 =?utf-8?B?dk5LRGRNbWNaeWllNjBTMm5Jb1M1Nkc5U25LTW91S2I5N3BHT2tJUXZqNnJq?=
 =?utf-8?B?TW1OL0N1SnU3SCtQV1BSYnRxYms1SXVlNGF4UDlXZlNLTFVyU3FGRzFrWU02?=
 =?utf-8?B?YVovdldYcXc0RFNqdGlSUHcyYWdISDAzRGZ6ZElEWVRheFU2cHlCTTl6ZFFt?=
 =?utf-8?B?NGczOEJmOWNmamE4djFYcDRmaHhLSUh6QTBPVG51elF0VHhxcjBrenZveTlj?=
 =?utf-8?B?Y1Jpdis1WnZvU01hYzZOV1BQeUtwWmVMc2Yrb3IxSmhBT291QU0zL3l6czk5?=
 =?utf-8?B?YmZQOHlMcVN0NGhka0VrVUxEVm1wS1BGQWZDVk9QZHMrZVp3OGtMY2lKeHlI?=
 =?utf-8?B?RjJyZExlNkJmWEhaYXlieWZTNUNEWmxINFJDN3FjZFRtTHFrMFpyak1Yd3pm?=
 =?utf-8?B?SnJHQ0k0cFJlUlg1SEZUMUluY2dPd2lYVGJIOUhwT1JKRkdUVTAxZjdZSTdK?=
 =?utf-8?B?QVYxQ2dRQmhHc3hPTFdTNjFBQTJ2TVJ3WHBlWi9ybmorMm00UitQT2Q0RnBq?=
 =?utf-8?B?Ykp6OWVRZGo1WnJVUzBpWk01S0tYeG9kOFUrNGNBVjZ2Nnk1VUo4MmdZM0hq?=
 =?utf-8?B?SDIvQ1lUMGtpQkxaNGZZNWtLQzZYbjVOSERtQTcrUTQydmtJM3NRc21DSlVH?=
 =?utf-8?B?UUxOYVFkb1Btb3dlSy95R1ZUS0FHVnVHWnVpZ2R3NzAvSEhwT3Jib25qRjhN?=
 =?utf-8?B?eUFoNVJUUjNNcmpTOXRwSEx2RGJ2eUNWemZEM1U5aDRBc3pqYmRMMUFwbXBH?=
 =?utf-8?B?djg0Nnh4Z2FYTEhUTkhGeFZaYXhCTUNxbGlRWEZVakFJcUh5UndhYlJUVUF5?=
 =?utf-8?B?WjdXeWNzSmVHRTVWUHM0UktNUGxXU0ZjYzMrQjNYQkVucWxDWCttZEljK2hV?=
 =?utf-8?B?YWdYQWZtUlJBQm82SmIwZVBQbjBFMlExMEIvNTVlRlY0NmFqV1hrWjhQY3BS?=
 =?utf-8?B?Sk9qM0lISG1EZU1PNjVLT3FMQ05WYldKSkhLSTlldFhObkhhRnhtOVNORVlY?=
 =?utf-8?B?K0kydmF3NU44TnQvUGNpR2FIOWt4M2tiOTA5ZFVpeElHK3lwVGJobjRwMm01?=
 =?utf-8?B?QkFHQmRZNXMwUm04dDBJWllWeGtlMWdMSjR5NGV1M09aY3hGQnFDTHl4cG1Z?=
 =?utf-8?B?VjdtTU5WcDVEOWE1T1cycXU1MFFUZzkvMHU0RWYrbHprR1ZIRmhHSXlVTGt0?=
 =?utf-8?B?NGhlOXBqcUlQUE10Szh3NjBSVnllMUUvMlVaVngvR2Y1RmNEM3B3Z1Ivak9u?=
 =?utf-8?B?WDkzTEdRak5iU25VRUVoR0VXd25VdXZLSHJVL0JVZzU2cElIcEM0ejJGQ1VE?=
 =?utf-8?B?bFBid3MwUmpVM00ycVFkVThvMzVGelZwKzJkU3duN0JaZlEwOE5Ndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84904886-06cb-4d8e-8668-08dea5307f3d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:14:44.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3+oEHB5nAiPlPRiMiue1LhjP5Q88EFX3rSBWJSdRbtRj/HU8IK8ExWavwGE/KjVduAN+hUlUPrni1ZAdW/UhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

On 2026-04-27 22:35, Yury Norov wrote:
> The bitmap_clear() works OK with both compile- and runtime nbits. But the
> comment says it doesn't work, and opencodes the call for nothing.
> Drop the misleading comment, and use bitmap_clear() as it should.

To be fair, that comment was added in 2017 by commit d0b63bb3385c. At 
the time, I believe it was referring to this comment in linux/bitmap.h 
(git show d0b63bb3385c:./include/linux/bitmap.h):

>  * Note that nbits should be always a compile time evaluable constant.
>  * Otherwise many inlines will generate horrible code.
This comment has since been updated to sound less dramatic 
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=41e7b1661ffbf562d3aa2b7ce4ad283db50b711a):

>  * The generated code is more efficient when nbits is known at
>  * compile-time and at most BITS_PER_LONG.
So maybe reword this commit message to something slightly more 
charitable. ;) How about this:

The recommendation not to use bitmap functions with nbits not being 
compile-time
constants has changed since this code was added. bitmap_clear is more 
efficient than
an open-coded loop with clear_bit.

Other than that, the change looks fine to me.

Regards,
   Felix

>
> As a side effect, the patch switches from a series of atomics to
> a single non-atomic operation, which is easier on caches.
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
> v2: don't declare 'i' in the new implementation.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d9e283f3b57d..500976d9087a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -167,7 +167,6 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
>   
>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   {
> -	int i;
>   	int last_valid_bit;
>   
>   	amdgpu_amdkfd_gpuvm_init_mem_limits();
> @@ -194,14 +193,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   				  adev->gfx.mec_bitmap[0].queue_bitmap,
>   				  AMDGPU_MAX_QUEUES);
>   
> -		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
> -		 * nbits is not compile time constant
> -		 */
>   		last_valid_bit = 1 /* only first MEC can have compute queues */
>   				* adev->gfx.mec.num_pipe_per_mec
>   				* adev->gfx.mec.num_queue_per_pipe;
> -		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
> -			clear_bit(i, gpu_resources.cp_queue_bitmap);
> +		bitmap_clear(gpu_resources.cp_queue_bitmap, last_valid_bit,
> +					AMDGPU_MAX_QUEUES - last_valid_bit);
>   
>   		amdgpu_doorbell_get_kfd_info(adev,
>   				&gpu_resources.doorbell_physical_address,
