Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2981DFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7261610F261;
	Thu, 30 Apr 2026 07:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4G9OfDcN";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F3310F25D;
 Thu, 30 Apr 2026 07:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gffvZPOY8FvfK6jxF9QHt91Dp2EV2upSEZ2cWII9dpqFIXfm9oWIPewnpbfnRg6AtjEtPjXuu42brN7hGwdczhuc4MvBixJyJLBtLy53yOf6jzHyANC6b/jm5Ejlp2P1v1Qw0Q3Jnk9rThVufDZGNjFX9bMMCfhJaM6gB7tomMtKgWmrtLJHRjWSTtUow5nd7DeiwBs1vx1Xy5M5v8HDEAbgCd0m7klXZATilXwD3UYpHtNu+JU0eRLfhKixzVhUlbfYVNACK5M3jKqwIl/7qHaAuggQZPXznhItJyOrlgPTVHZ/qvhJMhNibGVyyRYZx6sNiwRBAV1NzecMnCmtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1edhdSyItEy2+tv19PvPLGPKN0AN5FazrsyRMA5amSc=;
 b=kROzx1SCznPhyVUAde6PsDFTc6r63F//mGReilGM0An56PXgm3RZBndDDhnf4vn0E9Rb2JKgmTbUuYb8eO3WkegWL9Koxae6Q+bgjbKJK6ozSRPAsrRvFUM0FuZvmRIMcHLx1FA4WeVukx7YmnQGPBRtD3mdk2dDrf/44UAzM1YFlz3+7K8duxgbVhyUAeJKQC3Kj+UeglHqW8VJuInI5YB4S1yEK41NNejcGGugMKogWPOxcNxggXhOzhNqVHyq5S+ZGtK4imRvwdsUrpDhG0D1nYMR/d/jIHxK7jqfnySyWSpHkUbRJmSQISi9pkOZU2NdfmYuIGSpLjVe0+gQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1edhdSyItEy2+tv19PvPLGPKN0AN5FazrsyRMA5amSc=;
 b=4G9OfDcNGhmRWb5UDjGBW+IHCB0fMCJmJyRcFUcA/te+sjKlSNV9lr13X6R9r+02kr+/tuaGxndWVzvPCwhtY1erCTqF2IQT+t67irNQy5ZJq2llli1KjxBxenSkd6ha3odha40Pa5lszbqLyD32z0RlGqJCZKCvc7Eq4dHjDr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:40:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:40:01 +0000
Message-ID: <898c5657-3f5a-4fea-bd3e-4ac4de45dd2f@amd.com>
Date: Thu, 30 Apr 2026 09:39:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/ttm: Introduce ttm_bo_shrink_kswap_fragmented()
To: Matthew Brost <matthew.brost@intel.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-4-matthew.brost@intel.com>
 <afCGat6ADLrHYEIn@zenone.zhora.eu>
 <afL1VbG9HNDnA5Rq@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <afL1VbG9HNDnA5Rq@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd05efd-2cf2-4e7d-d423-08dea68baf88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: HGCg9ILVRgLkKuXCUgsBwaRENR+CfTaEgeZ3jiAk8oAPDdxykhuJ++TEHMO+Ou5Rrfj7pkjfBb8xDGoGJoqbL3JWXaCXXE8kYgg1n9CAOLpW+aG20qbSUzyT+YcCuf0iaxUkSbbE4HLRfTZOJ89j1z7DPvRBKw3uxuHcyCdVPrMPvUCt9Q3bWr9yWFD2N/f8L57q64wpj00UD0SCs7EtasDBsaZIgYXkrij+sd9AXXyMJ5ivUYhEW+PwNqB8AlYOor27MsdhI0RXvwXP5Pnf/cgp5r49+8T2bYgNB+BC72IC4IHCrmAzNDJ8k4Kv6DMj0NPyCBCiGNCpXA3DwJm5B4oyb0GWNRGe5VLyT0WUM8puzZlyQ2EKsF4TvC84hLgDGjrGXhCw9ILoHhWwAKvh9swMa6jUbzWmL7/LJS1UHWWcwch2X6BU4Q+QqFDFLRs4xN4dUlamVpeYBwAg9rEypcy/n5mLJZM5nhy2agiWc509DIaDp0B1XdHkQ966gsuwO2Vek81Nh60KusbWSN1uwjUb+wgJiQ7cmsZ1WB1DOFzIuLNVwWhYqJCZA0elTkpp4Enrs0jnmyYjdN2Whq3vrDQh4c06DhiWZN9HZSvXfzvK9ZqHWKoFGHBiW6Pm9CvTr1IKII0UyFd1P/9KdhKysNIBdrOP+w6Uji8KTxhmI5PGr7NL0z3LkjA/0/ms8pPF+Er6P4waz1Al1swS0Tqz8vN3c4aMrXH1rKR56WRDyj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek0zNW9ZUmx4d2c0UTJpWUtVQjNmZDV0MVF3YStlQ1doMHZxNDN0WHNNWTJ2?=
 =?utf-8?B?cSs4dUNZOEhzZWpuNndMT1ZOWUQyN09mYXZjUmlBR1dLeWxWWTRKOGZ3WmVH?=
 =?utf-8?B?MFo5N3I0R2Z6N0NGTk9hWHNWUVV2Q1phdzg3UU1BanJnN2IyVjJ2MzFqMHRY?=
 =?utf-8?B?RkNYbTdmOUxLSzBTZ3pXNHk3aWE3OFVwbTdvai9pVVErSkRWbytNUnZZMTR0?=
 =?utf-8?B?b3d2a0hwdHdmUE5QV3hVU0Y1Y1hKVXhzVVlzTmxoZGZtSWVhRkoyMmdPaERw?=
 =?utf-8?B?d044Rll5RU9zaHFTd0JBK0FJRXY5aVZVbDRwRTFYWlJ4R3RHYkdEWE9tZmFY?=
 =?utf-8?B?b09RcXFYL2IxL1crdHl3VkdkaDBoSVl3VGF5NEEzZ01OQVFHbEZ1bVdMKzM0?=
 =?utf-8?B?UHRqQWpZNDlOVmk4VStPbkRaU0l1akxzYmZqVHpVUVgwWFQvOXBZZlIyYTdr?=
 =?utf-8?B?ZmNmRC81SGs2NGxuaDE1VHgvMFpuVE42endlNld2OWJPeU44dnFlSWVZWXhM?=
 =?utf-8?B?UHd1ZHJhVTl1Q3RXWHRvNGhPTzlCcVJkOXBmZHlMWHhTNlpSSXdHRlBNbGpR?=
 =?utf-8?B?aGVGTjdMRmNHVDdoc1hhMTk3SVR5UTBqelVWVVBsUk1xYkxOOVp3TUFBK1My?=
 =?utf-8?B?Q21VMEdDU1BDc3RvOG1qN2JHZVdKeDMxRFlPUmxjeklxRU0vSXRqS3IvcW9l?=
 =?utf-8?B?VHM1NWJCUGpGVmQ0NkRDN21DWGdpOEZuQVlLaGNvR3ZFbWlGckVwcEpybUVa?=
 =?utf-8?B?RnlYaGUvVTdrWWFBMmJVNjBjcDR4WjlLSjh0eU1DVTc3MXpJSDZManlNS0NO?=
 =?utf-8?B?dlQ3S1ZqVGxwMU1MMk1mM0Z1WG5BQndzV1YzbTNBOS9LcFZUeXprRUtqdm40?=
 =?utf-8?B?NWhvM1lPZFFBaW4wWFJyemtzNGxsbVlPTUNkelgya3NhK2hITlBJcXJhZ2My?=
 =?utf-8?B?S0FMV0tTTFl1c2tIS1hMZXE3ZE4zWEhJUU9ud2tkYjVMZU9MQVR5ZmhCVUgw?=
 =?utf-8?B?TXBoeisyeUo4dVdpV2RWZTBwMUx0WVRHYVZPZHF3bzU0cTN2Rzk1bHdzQlpG?=
 =?utf-8?B?NEcrZ0d3RDdmd0UrYjY4Q0N6a0VvYkE0RFhybWJvd3dmV3o1aGE3bkY5bUJW?=
 =?utf-8?B?TmdqbXJST3FzRVJReWxhTmVyS21xc2EvcUdVRjh4RkV2QW5qOFRWdWNSZFl5?=
 =?utf-8?B?NzJiMjUwZ2JzVXByRWRISzEydnZydW04VDlpYTNwUkFSdzhMdmpLcWZhQXAy?=
 =?utf-8?B?OCs5UDhSZDJzOC9Bc2Q1bVlDZTI4Q1BFM2E3Mkk5TnMrbHJJckFXMkJLSHgz?=
 =?utf-8?B?cjlLTGdQQXBWdS9BblRDWXdFVm5rVXhKNlI3T0k0cWZlWE1Nb3VtYkZCY0tZ?=
 =?utf-8?B?dzBnL3hva2pwcDJtOVB5UkJtYndrVGtCT2djWVNUWWVFanlCQXZoa0s5SjhS?=
 =?utf-8?B?MFJXcDFOTUJ0VDB1amJUVyt1NC8yNUtyTUtYOXRhVUIwcENWbU1OejlteElJ?=
 =?utf-8?B?ZWJTU1k2Y1VJOGYySWRkVE44SndvY3NoZmJTd0NnTW9ZcEJGRURubHFpeE0r?=
 =?utf-8?B?NmtMOUpzVFNCd0Nsb2xPakUyNEdxSHpZL1NyWFc0K29oRjNJcVY2REVqYnBB?=
 =?utf-8?B?NmFRaFRFcjNMUmJJdHZWckNTaUFEWDVvRzRmMEkxR2tuZTN1OTVteEUrRGw0?=
 =?utf-8?B?aUN5ZWxMR2k0aVdFN3ppeFpja1hBZjBJTVArbitTTWdGN05YSFY0K1VYY2Uw?=
 =?utf-8?B?MmpYODdrR1BWWWNSZ3lvclpjWUIvc2J1L2JqRVlYNkZwdTkzRUs4SEVjM3Ev?=
 =?utf-8?B?Nm9XUWNRZElkbk53MEVBUDQ4OXMyeVZEQmdYR3JrYWpKMmhXQzZ0eWhHUWtn?=
 =?utf-8?B?YlV2ZUpxc2ZxMzRqd1JQeVZzeVJHeXdscHhCU0RsTTBteTFEK0RLTittaWFh?=
 =?utf-8?B?TmlvNTU0dlhhdHV4ODhidUcyWHBxM1FkNHEreG9ZRGxDZWlRSFZFZlM5RS8y?=
 =?utf-8?B?c0tWdWZadGVmcW9zOVR0S1NrbG9mdG9sYTNySWRpeXpHTXJmenAveCsvTkNM?=
 =?utf-8?B?cU1TR1o4cXBicTM0dWxKVldJTGtvVG5PcGxyQTkzVks1MG5HTjNsQ2N3cGV5?=
 =?utf-8?B?aWpGdVg0bExKSmFRY3E0QVlIVVh5WWk0WWh5dXpwUERRb0NoZ1RRdnl1Qzlh?=
 =?utf-8?B?UGNqb1RmNDlyQ2FaM0JNRDVFWjlhMnZWQjRXMHpCOWlmTGp6R1IraCtXRnpN?=
 =?utf-8?B?QzBVakMydFU2Y2NyOWhZU1d5ejB5WlQrdFFEQWZQMFplWENpOWduZDBhcEhO?=
 =?utf-8?Q?PwrsPqj345Zo2Oqt3V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd05efd-2cf2-4e7d-d423-08dea68baf88
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:40:01.1483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vRJe3lQfTaKNunIYt9rs6LmdQfKL5blNFViyzPhuVRAVwXF08OMAPxoTrrhshYl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
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

On 4/30/26 08:23, Matthew Brost wrote:
> On Tue, Apr 28, 2026 at 12:07:07PM +0200, Andi Shyti wrote:
>> Hi Matt,
>>
>> ...
>>
>>> +/**
>>> + * ttm_bo_shrink_kswap_fragmented() - Whether in kswap and memory appears
>>> + * fragmented
>>> + * @nid: current node being shrunk
>>> + *
>>> + * Return: true if in kswap and memory appears fragmented, false is not.
>>> + */
>>> +bool ttm_bo_shrink_kswap_fragmented(int nid)
>>
>> This name is a bit to strong and misleading, in my opinion.
>>
> 
> s/ttm_bo_shrink_kswap_fragmented/ttm_bo_shrink_kswap_maybe_fragmented
> 

Maybe ttm_bo_partial_shrink_kswap() or something into that direction?

I don't really have any better idea either.

Regards,
Christian.

> ?
> 
>>> +{
>>> +	enum zone_type zone_type;
>>> +
>>> +	if (!current_is_kswapd())
>>> +		return false;
>>> +
>>> +	if (!numa_valid_node(nid))
>>> +		return false;
>>> +
>>> +#if IS_ENABLED(CONFIG_ZONE_DMA32)
>>> +	zone_type = ZONE_DMA32;
>>> +#else
>>> +	zone_type = ZONE_NORMAL;
>>> +#endif
>>> +
>>> +	for (; zone_type <= ZONE_NORMAL; ++zone_type) {
>>
>> just start with "for (zone_type = 0; ... )" and you don't need
>> the ifdefs above.
>>
> 
> I don't think that is correct. Zero could mean ZONE_DMA which is not
> relavent here.
> 
> For example on BMG + raptor lake system, it clear ZONE_DMA is used.
> 
> cat /proc/buddyinfo
> Node 0, zone      DMA      0      1      0      0      0      0      0      0      1      1      3
> Node 0, zone    DMA32     20     10     11     14     15     15     11     13     13      8    232
> Node 0, zone   Normal    876   1782      6      5      4      4      2      6      4      2   7107
> 
> Matt 
> 
>> Andi
>>
>>> +		struct zone *zone = &NODE_DATA(nid)->node_zones[zone_type];

