Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96997CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C596A10EF24;
	Thu, 11 Jun 2026 13:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4bIfRi0o";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F2010E791;
 Thu, 11 Jun 2026 13:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkfGVvK4lz5kAQg02EpA2/I3BpP7M1xuSJLGpB7ocyeGatQt42V8WfPvHRn79dTTI0tODMj2MmMQYaijhipm2dIPHe88xICIaCnzac1qmMHMZfp5oUnEWnpjxJmSw0esCk9dI1cTeopGrmIVyju12xUVQb+YF4y1ERQUr00rbkx+z8i92Ot3k3Wcxj3umtWuVJQnssPa01A4D8wJzCtQ2OOSkAMi9QQ7ELTI9rY0Yetv/ZV+zdbSeDGMrh+AS8i2BTfBJC4FLNmBNGoqsWhdxnVjW68v28LHzIRePB2Qz0yC15P1oP4okDr3FwPkh2O36HwcN6zV9uufwY53W7TYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QKpenixv6l6WC7YW5rlGevh8pOgVsg5vBO4iDxfdsQ=;
 b=HLpT8U2X+xGGPlsh27KzTKZomqiNzRsuKJYMpIUQ8T/y40lRkcbo4oKn9qf9gtgC7iehlBSuPK/uLpsrl+byvx8JEd42casc5kU3Oc56XzqgfCG16XfSZ4tBet1+hhwVtCEQC+GMt1Q+bGMKYyfCWftyug8Uw/3/yHgxPM7NbpVXCD51yNbijqJS6LmiwjJFcu8ujjFgV4kMT7jsaeq/8FVa8sTyseEUWZ3EDZk48OfPK24zzGrSXjvHCyJiuznBOZ/ASJ01CAiei58iHkSkBVcNdumvsai8k3tdMZuycGM045IS/N9alKpES8IUr/Hu0pivFJ6YSXqjDDl16T2x6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QKpenixv6l6WC7YW5rlGevh8pOgVsg5vBO4iDxfdsQ=;
 b=4bIfRi0oIEp6S/hrUgnrnb1xUi0FhT+GMrrQC6z1dVz6npoTieuGecTCMzVczLI3VtI6pbjnWs/eyhJFfgdzUZOzC1uzl4l4qSDwYvAnL4ULGjkrEtRM9/JZq9XoIbJYD4WrMK4P6Ad1G/WqnLDXkOERPNNS5iCCsNzrMPun6Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 13:27:18 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 13:27:18 +0000
Message-ID: <bca4ee19-a07d-44c1-b05b-ba0f8d550f77@amd.com>
Date: Wed, 10 Jun 2026 17:58:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix mem_type change detection for async
 flips
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Leo Li
 <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260604064424.3154796-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260604064424.3154796-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::26) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: acb671e4-a482-4564-76dc-08dec7bd28a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: pANrvBQ6w9lv73xcT6QVr/RYSo0+p//Oixya79V6lSSr9b2O0FOq4TqRWpXnUseh3vOzI5Fcw9Gj2GRrqw5ZXd9hsaNON3jc2MeCbOQmHPDF2I2zK4haC/aQaGxTblQf+aa7brgpXBCXdDjuV/57JgSTC7QkEbF1289WHolzrHSvG5WLgb6Iy1eahxdv+I2r1arzX2jjMnIvN7Bn8lLtcF+l0Nyo6wdJe2N9We+2y21dIDOaDpJQG1+E7rW4kM2EMGaL1KbyVM1Or9ykTyoIVyHwIjm2Q4mNy/X59a2KWT4uMUSp3S9btww96benp2eCJIAAT3x+WtW4ak5yZkOI1MUZqWFw+GcKhO/D7fUBvOH36m/8Dun4ug0fDhKvVgTPuJFq+DTqrh6khV/mMlqQk8BrGnv1sxPxoj9m5f0E64zUeLoWEYtCz6znlB6PB7i0AKGnNUWCAu5cWC3eOY5CltuL2wdGH3jGyRt8KtO1vDFVh7tktmVsZYoK8Aj5H9G/JEZINymJhM5HWXLtCy9ouQplp38xROzaaBeBIRZv9zeLyUijma6J7J4RKzX2UZfuol1SpmZWcNUwhY1YiPk1aAUzIQyWyHxFtyjYEiGlh8DXpgVxmFujNfLmDr42kJMLgCCevXNB6lp1vIM/Kt7no27JWzZPJyL1Fq9AxSiOLEKExHf+3iKzudhybGfBV6nX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFU4VXE5SUgvVFFjZEIva3g5Y2pPc3dqcDlQNExWZUFVaTlycWRZaXNQbDNq?=
 =?utf-8?B?VHVrdFo4MlhodWR0MVJ1Q1lNRmY5TWIwTzlwUWRYVWlKMzFHKzlxOE5ha3dR?=
 =?utf-8?B?ZXZqSEVCamVNRnBMRHVzVmtDNUxQdkdkV2xEait0UjZ2MStYdHExNGNGUGhi?=
 =?utf-8?B?Qyt6c2cwd1R2bWUwd2dPMi9FK0ZyQWRXQlhZQkZsN1RqR0ZXZTJaeEhzQ1Ru?=
 =?utf-8?B?eWhOMGZtZjJ4bUVkbmN6Z2VLSG9RWlBuV1dwTlNDQlZqblBXYjZIMEN0dVlR?=
 =?utf-8?B?enRlL1B1Tm50RkNzRFpvUWkrVHVSSmNtRWtxbG1sL2VjcFl3bmRwYnk2enMy?=
 =?utf-8?B?NTg0WFdMOEx3KzQ3SUdDYjd4L0ExMHM4aDdTZzR3dXFMWitDZnk2b3dpQzNx?=
 =?utf-8?B?N0dQVWRWMnNHNng4dHFSaGYxU0dyK2JqUlpLQXFDMXVyaGVycFpRaXIvd1Zt?=
 =?utf-8?B?MEJTL3l1Z3RuRkwvaWtUbHBJMnc4SWhsVHR0WEd3dUN6WUpIV2kzVGl5b3pN?=
 =?utf-8?B?Y0dLclVYL2treFN6bEZqQzRwZVBKaHg5eHNrUXNVZlFyMVNUaU05VE55YXBX?=
 =?utf-8?B?a21GQzFTNytWRHlPUXFYM0RGYldzZ21oVmd6TE5DdkoyTkRRazlaWGtqYlF1?=
 =?utf-8?B?QW1GangvYkgyYXoxRlZ1M1cxcVNEZFQ0L3RuQk8wUGZnYVVySjNaZWlQTjA2?=
 =?utf-8?B?dUdSUGttZURZNEdCd2RyUS96VUk3cSthNktDZ3NXU3RPcFUvckw2QlgxOXc3?=
 =?utf-8?B?QjU5cXVUT0dna0RxT0NTOUdRSnpUb2FpZkRFTXpqbkVjeHR2ZkNuUlk5NXAy?=
 =?utf-8?B?cXlGSVhIR2ZGN0VCZThXMUJSR2NENnhKMEhJdWhTVy9MRXRnZll6U2dLZ0tJ?=
 =?utf-8?B?NWtBdFE5anVTcktqYUpHOXBJbHlwNThYTjMzY24rTW9hQzRleGtJMGUxeFIv?=
 =?utf-8?B?bE1YSjhFM0hiNTZxWWgzMDNPYzA5b1IvWGxRdjc1SG1zYWZadWl5U1QvbVVy?=
 =?utf-8?B?ZzNlSzVGZkhsLzVNOUpXT25ZMXBXVmZQeUsveHpBRjBaeXFyQXUvVGlEZ1hL?=
 =?utf-8?B?OU04UThGQlNSNEgyN09tY0FGYlptRDRUYkljNnQvUUxsOHdSZjV1NVJ0Mm9Q?=
 =?utf-8?B?WmlNTzJPOEZOUnVWN2grK1A4WktWbm5KWFloR0Joc2RQcXBTaE9lU01jVEZS?=
 =?utf-8?B?MFVjR2ZQQ2dCeUhYSVBpNTY0TzJiaVhOOUdMa3hGbmVwZjJNc1RCbCt3R05o?=
 =?utf-8?B?ckxzYkxYLzh2S0J5ZXgvaWw5ZEhYSE9zREZTQWtGNTZKNlRsSGtIekFxdUM2?=
 =?utf-8?B?SHB3YnZwT0VCaWhwWFdsQ2F0d0ZpVnVIdHorNnJ0VE5rZGpnbVBYT3plenYv?=
 =?utf-8?B?TVNicEhKak9sQWRpLzRSa3RPQjgwTTRZRW45cjRPM05nZVJJNUs5TTdzK3JJ?=
 =?utf-8?B?cVpwSDQ3REd4cmtwVXZoL01FUTlLTitsaGdONjhXVW03QS8wNnNRbHFZcXdN?=
 =?utf-8?B?eldMUGpGS3RQZHYvclRRZ2pVR3VkQkVTVUtIa1Z4TmlWbVJZa1NEYnNJdkJG?=
 =?utf-8?B?aHhpSmZYRmROcXI2djhQNExFWTlYRTlMUC9RV2pHUGVtOFRpbTNEL2o4bWZn?=
 =?utf-8?B?ZmdFZUVNbXhBYkl0ZURPZjZXS0VYMUUxLzZUdnFrbGRJQWdBVzFMdzlOUHIy?=
 =?utf-8?B?Q0RHeDIrZDVqcUV4UTBsTXhiSFoyYmJhOXVmRXVuWVVPa250RkZLQk9OMnJT?=
 =?utf-8?B?REJTSU0yTFlkQ2hvRm16ZmQ2ZHRwZWhQbWExcjI3YWhkTEFzcm5BcFZ1Vkxt?=
 =?utf-8?B?NXRtUFIrS0plK2hqbWRpQS9mVWNYZW1PZjlpYWRGRlEyT1lkNHVmSFp5OEI4?=
 =?utf-8?B?UjVXTzBFV0dud2pIWVR1RHlBNVRPKzd5UkZHYUFScU1RQXBJWEp5SHR0UXVC?=
 =?utf-8?B?bUU0UzlEYk1KRkFBMW9qNGM3QkQ4NXp4VHdWbjVNNWRnYmc4aXAweU00dEdI?=
 =?utf-8?B?SEVZL0YrNnhtZzVEdUgvWDdmdHBDYXliYlI5WUNkT1AvOEtwOVIrUGhQSDVI?=
 =?utf-8?B?SDZCNDF4bHJZU09Ec3lsUTB2aE5ldGVYTzVWemZXbHVzZnR4WTRvNlBzMTFt?=
 =?utf-8?B?ZklnYVpLWDZlZC83cFlDcGRpMGZtLytacTJzRE93SXJ3SWNRR2dYRFJVUllC?=
 =?utf-8?B?SDFNMG4ySkFhUElycVdzbjdJQUdJZEVTZDBrS2syK1VYSWJ0U3FkenY4a3hw?=
 =?utf-8?B?R3lPU295RXozc2xSOUdDQmR2OEVkSWNKeTBtZENibUtLUG5BYlZZajlDTU00?=
 =?utf-8?B?QzBKQWJ3YkZteVJ3bVNaaTF0dlVaU2lmck81OFR3RmtnelRDVmVDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb671e4-a482-4564-76dc-08dec7bd28a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:27:17.9529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XQF24ePtA0DsU3uqxeiSYzNKPW9MeRpSEeJL/Aspgl02L5bkYieu2CC3CFjpHHwzC/pyDIclCNU54i3q+0Kow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

On 2026-06-04 02:44, Matthew Schwartz wrote:
> [Why]
> amdgpu_dm_crtc_mem_type_changed() fetches the "old" and "new" plane state
> with two drm_atomic_get_plane_state() calls, which both return the new
> state. It compares a state against itself, so it never detects a mem_type
> change and never rejects the async flip.
> 
> On DCN 3.0.1, this shows up as intermittent corruption when a single DCC
> plane is scanned out with immediate flips under gamescope and its buffer
> moves between the VRAM carveout and GTT.
> 
> [How]
> Use drm_atomic_get_old_plane_state() and drm_atomic_get_new_plane_state()
> to compare the actual old and new states. These return NULL rather than
> an error pointer for a plane that is not part of the commit, so the
> IS_ERR() check becomes a NULL check that skips those planes, such as an
> unmodified cursor still in the CRTC's plane_mask.
> 
> Fixes: 4caacd1671b7a ("drm/amd/display: Do not elevate mem_type change to full update")

nit: use 12-char sha instead of 13

> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6c1e7e13f0399..711640739179e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12934,13 +12934,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
>  	struct drm_plane_state *new_plane_state, *old_plane_state;
>  
>  	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
> -		new_plane_state = drm_atomic_get_plane_state(state, plane);
> -		old_plane_state = drm_atomic_get_plane_state(state, plane);
> +		new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +		old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>  
> -		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
> -			drm_err(dev, "Failed to get plane state for plane %s\n", plane->name);
> -			return false;
> -		}
> +		if (!old_plane_state || !new_plane_state)
> +			continue;
>  
>  		if (old_plane_state->fb && new_plane_state->fb &&
>  		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))

