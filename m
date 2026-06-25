Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E22CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0652210F1B6;
	Thu, 25 Jun 2026 08:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cbXacHwE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E7810F1B5;
 Thu, 25 Jun 2026 08:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt8KkRfsKq4VKcMDtEwzGGxalnO8IYz7TSNpYf/5UxEfEjlBUBqJyfKRye9otxJ6slWGzEdGKWUCDLlE46wPwA6eBByMUvxB84Cfdz+DqwrXvplpyFSpnZjjVObnJFW8LC2RVbjFR6BA9R3s4Mgi3ZrBAYG3q89VJ5EDeutzA7d8wbtzk3p5BMu98WQm2fqAMOXFxqYStFLvFVQcH76Z5JWRgMsXtTUeGmNWwIeigriSPd6Qsu9IrWIr6gUEsJXs8oIrbuZqbQmcOfaOB+BIuB92GgunyXZoS3vA07Zyo7mRKihYJa0syiyR2ID3jlCd89yXWomRqqdev5lDHz1HbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zmIh9gOPAkEu0PGa+pPl8ZQcZGO0UPNpdgRxjtsOXw=;
 b=h7oOt/RgEO4k6isqlWcqDAa2b+OTcEairMHpRZZwaH2LgBttUfKieTijim2bOXOGfREPyptxzZthMCBGgAAxOblLwdpZXCf0bdXgMq+CZG3Hvhw7rQOAF6SBAVNSltpq08Ann0Oq5cYDcUIQIFOGpAUSAX6fdKuRmLKO3AjYcio94bt/bhg3bLMzuARQFJmpVgiktNFICcRpxDLggrfMQVdAXlfayE/Y9Rav8WEHdfzUTkQ3DsRK1N0KmHQp/cGViNrdNfexmgT/b2HBp1hVlwyHWObelgp0/oktevfYQG1jJGs5/fcPclsWLeZIu8Wg5XgC2XGkBMSGSITv67BXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zmIh9gOPAkEu0PGa+pPl8ZQcZGO0UPNpdgRxjtsOXw=;
 b=cbXacHwESTZip3XFfnPzYGsgN94TkmwxxBoE/LR7qNLL2n2noUfGYiO+SUQswJX0xG64MUp0enX6USUNRt66bM/vq8IYQqDetmfa9dodmU8cNCueqTHca3us11X4N2/9fLu7OI7cFcW33Sxf/t0QFOUPzjSH0zyvDIqMRKdFDyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 08:46:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 08:46:28 +0000
Message-ID: <72aa8cb3-2b48-4b08-ab17-788c3dd18fe6@amd.com>
Date: Thu, 25 Jun 2026 10:46:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260624172029.2508-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1dd9b2-37b8-4145-cb5f-08ded2963f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kTlN7O5hH+7x/naXs/gQmUjuivg5/jZ8oGdEsBQeiGEAipy8/n0190H6toWVGaGRb5JRczP8Ed9jt4/fAeaJUM88yDXmtstWu4xJej8xnEBlv0l07U2IyvyAbIeBkLPRx/Ka/CWV5pXQnTQys/SZFqdolcPKkbuRRCwQrhsG9Dzbkv3LKQhAEEos805hC/Hvq+iGMg9euWlT8icnf46ynfRItCr9JJgb00q/SZbqhLybXBZTkQX76wtZANUSZ/TZC8GMdY+lkSi9SKZZHtSFmPl5SAXeoSnnVXcEs/cfXHwgM2qLtFIVX3F/sOttC31kk6N3c+Pukn/DCLVk+rNmGXqB6FZrjjAs7ds1adRBAA2WJV0zfDrOZcuciQgCY0cp6/jOd6YQ5Xy0u2+fJfz2DkSCbo5lNqdBuhwMbFOoyphcApikl03PEi1c8AMwBU95ETgQVjn43xpU6ubKhfw+osWvAlVLSLZnsshGZNpUyo5R5eTAgelAGE3CQkHuk3exAwPRwu6VQKqEbTDbe/voJi1fLOjRbQofBvXOskoW1NsZmFt/sVkF1h3yrgLsGGrUiWFAmiZk4vOTWSR2VBp4hKWOa1kuZjvevW5fBa0l9/O+MdTJ5YisH/UTX/yZQgVJk7OBv+k/uD/UTuQE4+TJznG0W8U4OP2RpJsrRLYm/To=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZNdnR0M2NoazhxZjlxckg2TXZDUmtnWklxTnp2dmdxeUNFUUJuNWxkSEdG?=
 =?utf-8?B?T0xmZ1N2Y3Q0YmNtSWFDUnRDcHpQMTQxSmwyRW9aZlMvcDZ3S0NNTm5TNWt0?=
 =?utf-8?B?dHBrczV2Y0daMHNHRmRIeTNXQThDekIwQzNnM3pmSHRzTUtzdWovd293d0Z6?=
 =?utf-8?B?djA3YURld2llMkhQbFNqdEhXa01TQlBYeHRjY0c5N1FaYld5VXBLYW5kN3Rj?=
 =?utf-8?B?Y3Z3SEtER0kzdk00MlR6QW5SQjNFeGJaV3ljMG9mblNMWHhENVloOEdIa0hq?=
 =?utf-8?B?SmU2bWNzeHZzZmJKZlRIWVBxbzV3M3VmeUtldmNKQnQyVXh5aXFneWtYd0RT?=
 =?utf-8?B?UEtGWjg0akhzTTNMQ2tTYVI0OXhZUWt1cUFXSjhPKytJdkc4TlRkeTRGOU80?=
 =?utf-8?B?c2x6Q3pibHlvUllkLzR2NUMySmxGeTJ3ckJFUkhsUGpqL1J3Q2lZdTMwM3Jl?=
 =?utf-8?B?K0hOMVo4RmpnaFMvNFZGRHovUEd5NmpZMHRKU0x5ZVNyWUhwZTFkQXBLN0hm?=
 =?utf-8?B?V0pqMUtLM3FrY3lmUHE5VjZMaWxrVTNDeHByclAyVEFBaDd2VXl5Y0lpWXBT?=
 =?utf-8?B?ZkQ4alBtVFkyQy9aT2oxdW82Z0pOdWdwbUl6MUpkVG1MeU5YL1VqcjhBUnpG?=
 =?utf-8?B?VmMxZHgza2F3MzNON0tqSk52ckNQSkhmZWlzVXRiUnlLK1dJd2JzaENlVXY4?=
 =?utf-8?B?a2lpWnNhUW02emJNcnRaUXNZRWdQYmk5YTNwM0FrN3F0T244TTE5SFFDUlI0?=
 =?utf-8?B?VC92L3JCSit1RHZoTjhTcjNlbTZxNUZIb3NWWllJczhJZ2NzdmwvNjU5NXlZ?=
 =?utf-8?B?aUJ4UlhaV2cvdG1nS2JsSDFmOThPUzhMZlVYNEtFeTRzTjAzNVU3eFdPaHF4?=
 =?utf-8?B?a0hzZW8reThHOFBncE4rbU9ObFJWTmg1TFBTWXFsa25KZDREZFB6bExWUDNw?=
 =?utf-8?B?b2pIZ1lUOEZibXYvK2M0bUlzeW5RelJyTzhWWWVPRXhWUnJ5a0M0T2hFUUZa?=
 =?utf-8?B?K1lqSEZYYmxlalZ2bTFZWmR0TGJLZkN1bVBmRE12MTlUU0NjSXF4RW03bXpZ?=
 =?utf-8?B?bUxuZCtjN3lTWlFYWm9pSnFzdGxjL0ZIcktZNW0xbXVLU1ljM3lkQnFwcmkx?=
 =?utf-8?B?WVY1eHhjVlZrVFVoZkVyd050QVVTUTFVcCtvNUhFeGhRRjEySXJhVlFqODFQ?=
 =?utf-8?B?Z1dLaVc3VFdRdFJISFBxYk5qcWY3NTVuUHpnQ3NhTFkzNnE5SnBadTU1UGhC?=
 =?utf-8?B?VXROb0pHVC91WjBncDh1cVB6SHVSNHFndytmb2ozUWluQXB6UXdNQ3dNclMr?=
 =?utf-8?B?UnUxZ0NkZTFLdXhlNU9uNFE3MERmaTA1d1BnWXZHV0NBTjY0Z2l4SGZiQklm?=
 =?utf-8?B?L3BIbXBLN29ZZExQTHY5QVYyVUZBQURaMGo2a2R1ZWFWckVoMjhNNm5JblVY?=
 =?utf-8?B?ZFFiUFJuVFc4MSt2aXpOUDN1MzI5MDN0dGtsWVE4VVZPRjZFM3dSdnhOcmRM?=
 =?utf-8?B?QVB3SjlPdjFVK3JzZzVXdjVTckJyYjMyOXlybHNiT3ZXdWlVaDJNTVlvaThB?=
 =?utf-8?B?MzVYbXd4OG5BK2N5SUQ4UnZDNXM3d3RBcERZWWIvbmNHZkIwVVlhU0lPRHJ6?=
 =?utf-8?B?cW9UcWIrSGVvckIyY2IyV0Q1TDhYL1lkNlJGTklXWXl0UHhtSHhzaWJvOFkx?=
 =?utf-8?B?RmZnQWhtaFM4d1llR2pERlF1VVFSRDB5bVIxanYrb3BYN093cGNuTzRPeVhs?=
 =?utf-8?B?OUs3clRiaE40OWRCSUFLYktYYXBrUzhGWlhiaG5CcHVUTmREQ0dleGZPTXJa?=
 =?utf-8?B?d0VqSWR3dm42U0NkR2xUTTl6aEV5OXA0OFA2RU9ISkNwVE5PUkg5Si9GbDY5?=
 =?utf-8?B?VVdwSEhwdkdrTVdLcUNBVkQrcVJMTzJZa0ZOcjc3MWJsOU9KTy9HZVB5Rm4y?=
 =?utf-8?B?S1pVejJRTmhqM092Q3gyWVRMQUtTV0hMMGRPUGg0b2hIRjEzZEViZExBakRq?=
 =?utf-8?B?WUlIVUQ0L2ZtNzM3VUErVzI4MFdyUElHS0N2clVpbkc2VTlweUxlYTNyQzN4?=
 =?utf-8?B?YXQxU3JXYlNOd3JkVm1mNUF2b3FIdkxvTzB0L0xCWUhvTFVpd0dVdzFDWTZu?=
 =?utf-8?B?dzNJUjlwc29DWXJubTMybDJNbUNmMitIbk1QYWtKemJmL2U5QjlqRXg5NXdV?=
 =?utf-8?B?aGlxMzVXanhJelgxakh5RXhtd2JEK2VCNC84cno0SVNNbUIwR3MrOVVramR3?=
 =?utf-8?B?MmVXRTVLbGNvblZCVWVFcHFlWkpva0VCZjc5cHI3NXRMemE5QWRJM2xGTnpU?=
 =?utf-8?Q?ekkTsmWs1v0rFPHdaK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1dd9b2-37b8-4145-cb5f-08ded2963f7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:46:28.7791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ba+DbkQVGCXso6IZUm3r8GdtzCucxYF6Vrfvjlet+y58Awh5ZfzdrGlA8vzWs5F5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
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

On 6/24/26 19:20, Yousef Alhouseen wrote:
> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
> iterates the valid and invalid mapping lists unconditionally. A GEM BO can
> be queried before it has been mapped into the file VM, in which case
> amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.

Mhm, that is not correct at all.

The bo_va is created when the handle is opened inside the filp and not when the first mapping is created.

Do you have a test case to reproduce the issue?

Thanks,
Christian.

> 
> Return -ENOENT for an unmapped BO, matching the VA operation path that
> already rejects missing BO-VA state before touching the mapping lists.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 212c14d99..4b2699931 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>                 struct drm_amdgpu_gem_vm_entry *vm_entries;
>                 struct amdgpu_bo_va_mapping *mapping;
>                 int num_mappings = 0;
> +
> +               if (!bo_va) {
> +                       r = -ENOENT;
> +                       goto out_exec;
> +               }
> +
>                 /*
>                  * num_entries is set as an input to the size of the user-allocated array of
>                  * drm_amdgpu_gem_vm_entry stored at args->value.
> --
> 2.54.0
> 

