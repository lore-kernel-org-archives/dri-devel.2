Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA3606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WkIoDFV0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314FE10FA1F;
	Wed, 11 Nov 2026 09:35:40 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E7510FA1E;
 Wed, 11 Nov 2026 09:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m87pW9yBSfXUjkzRZbkNcM60lGl8AokpdkdW4vcLSNRB6Mk6rpKJEx3aQRJCkVEJc/ZENFSXGmfimdso3YYTWm3BgPJ13rcMmBgLCTaRI1NpCmuzA9om8BxZYR/wX+al6LIQg+x+KO/S+EEov+a8JyfNn7b2fqOI5PrDksUEhPDcsMIB/j+R517JuSDkxQkZRF0dnjPFBMmDAYje5G2fwW73dEe3I8vECI6Om84IZXpCxnLLsA/KbgGnextBf1XTVPUml4SQNavmKOUrE3dlRSsiUr2YEd59mtEiQrEjlGh2b5wsHQh+utv62xBqVaFgIjwSVCt7E5OTeNMFdnhqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYhYJ0Pn/kw47L2f7Bw5f7orCu8Df38zI6mVGbTsLA8=;
 b=EnzdlQ8VyRzGgY4koNCCP8y6i+A3gzZ5Aho/g55dKhfnGu3QAOKtxyTIDRZUaDmOhLFDPlroJe65tp3hRZC/Ncp4gn3vO453XgKc1qkqYReFEQM3ErIUWFpXdPLLV72+T9eGsK0fh9a9ogb52WBxzhiToRxqeFw9eKjOpJ2FntEi3RIKJaVkyYZBPYzvkbH+0rB5MEbCnF75ZShjNimpY8MoKVU/g/g1KeTLC/X7T4+mi6ibgiYMVvE70kV1HONHBjtDdhsECyeQDhhZ7SdbofNWK56sA9EY85WuLiCWnFaFgW9L8EKilUD819mdwlwgVdrv1drGcApYOVD3JteE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYhYJ0Pn/kw47L2f7Bw5f7orCu8Df38zI6mVGbTsLA8=;
 b=WkIoDFV0y6EoGxJcyHLHH4GW34KlcN5WGUuVN0TGqPGqWJB2uP7SX9zscWP/YkMNJpW8cCoULwazjUNDaA6FMShzvdQtxWR1T46iFvU9Qi/VuShzC38TjKDFlRM1gWyMBGKV++5JJy4udIUCc6eo7Sp+rYNtDh36ez1RdQ9Gc5c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by CH1PPF73CDB1C12.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::615) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:35:30 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:35:30 +0000
Message-ID: <30437e95-2104-4bce-9565-d672d3e97d8a@amd.com>
Date: Wed, 11 Nov 2026 17:35:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] drm/amd/display: Warn about an invalid ATIF
 backlight signal range
To: Hugo Sales <hugo@hsal.es>, harry.wentland@amd.com, siqueira@igalia.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: mario.limonciello@amd.com, christian.koenig@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 simona@ffwll.ch, alex.hung@amd.com, airlied@gmail.com
References: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
 <20261104-backlight-curve-validate-v1-3-10c688880e85@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261104-backlight-curve-validate-v1-3-10c688880e85@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::6)
 To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: 36597511-c1de-46ab-4749-08df3fd72039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|4143699003|10067099003|11063799006|5023799004|261102123227099003|261021123027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: /Z4uRq4fpRHrYMKg9d8lUSfdPHNDmuJSHq4Joymq0s3fG1XCvXjtPcwb4caIAuwHOgTwaFMcMVoMAbXbJm9MBANJO7ur14suwbWlSzEkaT27BJvUGx+kVtgu4n5emTEsuaoWthz9b1k744UUxYKHCYD07+yfV/Yh+9PD9RwUEoQ/9XH3HTgOjn6hudFcak2tEAPBkkQeEcCIKizIkwZYtmBY6ZZC/mbwEEoWJUU7xFPXCAe6oFmEsIOu17+Q51acae4WzGhPEqvFHBSNFDphiEFoeZa5ea134fuovdtKnmTIMvM81dAUIgKKC4XwGVWuAxlDdF0ywQQvcK5r+xOWFoctc7F4LXgHLbFxFQgPcD4LuIaG/LMNlH8Q7FvbnlkLFkNvtHj1R7DDk4PWf/km5nP58Q+eLwH35vxjp1B9789nFiaM/Y/FfudZLvT2glpw2RDh8rvxabXrzrAvIGAzOGJ/heieUV0NqNBLToY3pDoozQYaMgXTCuCOZEbVrCT53zoeH8Uhm0s0ip1p026DBddNjwri1e5QtsowmxH+xtauu9K+Q7eGBaYl1oKvDtQP8OQ7ueSbYRn5CaPANaLVRA3vUbfeWbfFpNpBsbpwbroQLLx5LDbPQ7yOM7P/cu1OC9pdWjpfmJzWGNerEttPLr09V7yEFJzp1TysSlxyRkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(5023799004)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnByRUoxYWlFdDUvUTZKR1ZkYXV5SzVDamhUaGxScmJmWmN5R1BvalNXaXdI?=
 =?utf-8?B?L09Lc0lWSkhjQmpjSk1YcTFGRUNjRUZEeGxqcFN3SDNaeVlDcDN3R2lxTEZw?=
 =?utf-8?B?c0VjTkdCMytmSnBIdXdWY3ZFRmkrdHFwakQ5MXNCWHNYUHlVNGoyOW1PMml1?=
 =?utf-8?B?RlFTY3hVWDBoOXVSeFluY29La3oycktNMU9BY0ZrK1NBajBMZ1pMVk5nditl?=
 =?utf-8?B?dFNEenVycTErb3I4amh6T2NPUWg0aUEwTEJMMTJJd0lzQ0ZIRHlSYnFIWE1P?=
 =?utf-8?B?YjVDNE9BcTJUVnlUVEpXYW1WQlNMUytaMTZzeHJUQys2eS9ZVC9uQVZlUnJz?=
 =?utf-8?B?SFFURVpObk80RStNUU5scGFlckVTL0FMYVc0NWhnMTBQdDVLeE9OUVNnTVo2?=
 =?utf-8?B?NXJRK09Wakd5SVlKUzF6U045N1pSVWJWZXN4YnZGU3ZjOUswVTl4OFowZlRq?=
 =?utf-8?B?Ykp0ZmRVbjJmVjA1ZG1KTmx6QUk1T09INkxEdWZrUkJ0WXRBVTN4UmtDRG5v?=
 =?utf-8?B?K3puYzhuNFgwbEZreFZOWkNTdmxsWW9oUHgyeE8yQVhlZnlzLzRPVzlhWUUr?=
 =?utf-8?B?aG9JVnhDa1lucExRcVpGSVhBOFh5WnpDZldVWk5BSDQyWm0wNXJ2bjA0YlBr?=
 =?utf-8?B?Q0JGRld0Vkl1V2IzUEFtZzdqNVNpMnVqUWlCdXVXZGFxQUZqN2pIcTVYSW1k?=
 =?utf-8?B?ckNJUmU1TW5DaTdUM25YSVdLMUFTWGFEQXhLTURvcllKYWYyYWcvQW1pYldx?=
 =?utf-8?B?VzZMY0FXRDRUUkQ4T1Ztdk1YUS91ZE9xV3ZMRzFORTYrQkJpbE1wNWpZNXhV?=
 =?utf-8?B?TFR2bU1XbXBYeWxXV01wQWJKTSt0V0xHb2puelphbEpSNDQ0ME1lQ0VNcVJI?=
 =?utf-8?B?SXJZZnpsRUR4ZnlTN1BacnZodjMwOUlnQTB0NjFiYjcxdVlTSGtocS9xU0hD?=
 =?utf-8?B?dXRWLy9oSkpIWEtaUlozUFV5MXJCOXVYOEFPV0t2ZTcydFJYekRlRlJnS01p?=
 =?utf-8?B?c3pKWVB2RDU5dFozNERhMWF1ZXU1cWdSYU4wVHBXc0F0UGhlR2w1U0VlRHBa?=
 =?utf-8?B?QVpEemZJNEJJaDd0clVyN3JveHU0eUxJRlJlNGhLeU82Q1ZCaWR6dzhoVjNy?=
 =?utf-8?B?Z3ZWOWtCKy9tWXZnNjJJdyt3OXJycHh2UWx1SUliSVVyTnZlTFVYU3dRNWYy?=
 =?utf-8?B?TWVwQmFEQzIwVXQ2SkNYTzJScHFwcFZDa0JtRXl4akJzYktiNzMwY2pEQ2VJ?=
 =?utf-8?B?SkNPWkp0TXBIMWZYd3U3VTcxYzB4UzB6WnI3eHpxaU9WUS9ZTUxHK2ZTdlJC?=
 =?utf-8?B?ZTAzLzFuYzNlWW5Ua01OeUxaNms5QWViNnBVcFYya1NiNzB1SUN0T3hCTkhP?=
 =?utf-8?B?Tm9Wc25jK3JlSVZRMDZLRjBGdEhzb2x2VmpsWmR1a0I3RklZRHZmV05nam1y?=
 =?utf-8?B?R1UwL1FpQzNlV3NCV1pUYlE0RUlyL3ZLa1p2UjlNZHllbnlMUVIzZVlCc1Er?=
 =?utf-8?B?VC9XelIrWVZDT0tQMUZGTWY3T1lSMHRIL0pNQjUvak9wOEZXdDNvUG9iVjRW?=
 =?utf-8?B?UG1mK1g0VjZLQkJHdzRZT0tvaEZjdGdzNEJVOWNkMWd5c3RGSVVsQXNiUldr?=
 =?utf-8?B?QTNqTG9JMHlsVUhURG9kVkNRWmxKS0FhQ2h5V0FOb09OOHFaYk9HRUkzc3ZD?=
 =?utf-8?B?VmxoSHgrVjYreXJFS3NxdWc0TWRIcUtJTjBHSkh1N1I1WVdQaVkyVzRRMnJa?=
 =?utf-8?B?WUtvNTcwZjB6SkRUWkU1WWJHY1hreWMyUTdJS1puYWhqc1ZhekhIYVQ4bEs3?=
 =?utf-8?B?d2hHSHpmSCtyMkFlbjFFZkF3cURCZzNXR2lJTDRyY3B0RUsyQ2VUWnN0cHJy?=
 =?utf-8?B?UEdqSmlNR054dk53NnNyZzI1Qitsa1dpR0VzbDhGN0VSS0JNU1A2VDR2cjBI?=
 =?utf-8?B?K3JiUmZVV3d1aUlOYWNocFVzODdIeUdHR2U4MGxwd0FDWjBvMHJJbUozZzBx?=
 =?utf-8?B?emh2Q25xYkc4YlY2NVNVVVU0T2Y3T01LT0pQTUlIUkZ0OXRjTW1EYnp1MUhD?=
 =?utf-8?B?azg4OVNNM2JoQlVtdUdpRjhkdVpkUC9oOE5Eb05MYWx1alQzVklnUExKYjhU?=
 =?utf-8?B?bmZ2K0VmU0tMYWtjWDdlTWlFQVJHWGVVajBqTW9HR0F5NGtKU1dYSkM2bW1w?=
 =?utf-8?B?cU9CTnlQbFg1Mmo0aWdtVlN1L1g4K0wvR1JJbE9oTm1LUW1DZ3ZCVlRwZy94?=
 =?utf-8?B?aUJveGxWQUJZZEk0S3NDTk9XT0VOTmEvWWJITUJ6R2ZsTUU2aGhZQmRnNzB5?=
 =?utf-8?B?d0QxdlNOL3lFYm54SzZCaWk4RDhLR29EYnpzV0lkWEZuNTEvVlJUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36597511-c1de-46ab-4749-08df3fd72039
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:35:30.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIE7QJdJwRCmo5p4Dbj/Wl5UgUOMJOkCIzZsEh9JCPTouR+yMaMTp8lZVFKsM0r6WUstnKoXp+R0FeBsx6RmWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Ray Wu <ray.wu@amd.com>

On 11/4/2026 6:31 PM, Hugo Sales wrote:
> When the ATIF signal range is out of bounds or narrower than
> AMDGPU_DM_MIN_SPREAD, amdgpu_dm_validate_backlight_caps() drops the
> firmware caps and the driver falls back to a range of 12-255. It only
> says so with drm_dbg_kms(), so a user whose brightness range changed
> finds nothing in dmesg to report
>
> Make it a drm_warn() with FW_BUG, like the custom curve warnings
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 3a27fb956627a..68b34654fca02 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -104,8 +104,10 @@ void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl
>   	    caps->min_input_signal < 0 ||
>   	    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>   	    spread < AMDGPU_DM_MIN_SPREAD) {
> -		drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
> -			    caps->min_input_signal, caps->max_input_signal);
> +		drm_warn(adev_to_drm(dm->adev), FW_BUG
> +			 "ATIF: backlight signal range %d to %d is invalid, using %d to %d\n",
> +			 caps->min_input_signal, caps->max_input_signal,
> +			 AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
>   		caps->caps_valid = false;
>   	}
>   
>
