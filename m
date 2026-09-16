Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F53C982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470DF10E528;
	Wed, 16 Sep 2026 17:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHwk6kWe";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7D310E493;
 Wed, 16 Sep 2026 17:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uztt3z3DfLea2nlNNldwfA/5YP9IQAmYm7yvAFZxl8ATKO56N2Hs7qJ1IV/5EBoxcSMFg7MPk8iFxCFm/IHPCJb2Wp2PUdoz0WJG9AjaTJJyqap1Yh+agUrOtpEz+veS5RnQXQYLrjgNuUd9toi01hP8HrqVhnKIJJBvAt0bDib0w+6kKimI1n8L1ZukQT+PiEMawqWFzBj7GDWFZCTvzHvB150WDKbw14Y2cfD62HM3w33ZrWyAHByAQm7MruGZSzFDMG7xLCmDTeE9fbPWo5yW62qnf+YSTJzaol/wNjf+gaw+F3YnKr4Ko2QD5b1Ms1hrYndz6AZCZ/+rGCJmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlqPj8EPOIl8ZePBYSA1ZYhp0CrSa5Gej1WqWXtHbOk=;
 b=H7p3vphxOKIQzQsJnD9abanHaQL84GbfYQZeIfOV2lLwtq42KHD6MzI/CAZjElP5FTOkiScoyXjFkhB+EUMT0uEEtZ6Ymu5ElN0hWBXHD3NEcW0PEbGkgyqmrt8ko97VmIEc/gfkwC8KM5nBLZs1bS/6WRrSa4LCribTaPezu1CB9kl+Yyl/Z336ynxIe/+J5gy5msqrEF4HsGNVyzFcs0F2pbNJoN/iQfi02vKJ1Jk9aRKpmwK+YwJgcBcmLzQwqw4lgYvuQOYVXxVudMrPJ6cVRqaoiqwy6k0qQFwwpRjq0dY6nm4QkLyfS+RL9E+EQ46eiQv+R9ncsGsS3Vfb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlqPj8EPOIl8ZePBYSA1ZYhp0CrSa5Gej1WqWXtHbOk=;
 b=fHwk6kWeREI2nw1ggZuNsNk6B2T1TlmkhAMhtd7b4MwsUoGPMGsbi8HSf2Txyz92dhZZOmD2syUfzLYpsY8gHfHLikzDOcH5bZy7Q/o2MwBlZwoByg7LuvE68adKZ3GJp0NTKWs2fuNzXTi3Gn240hah4daLuSQ6HcxHY/KrKTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV2PR12MB5992.namprd12.prod.outlook.com
 (2603:10b6:408:14e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:41:31 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 17:41:31 +0000
Message-ID: <79d276fc-865f-4723-a9fb-93e4b1564535@amd.com>
Date: Wed, 16 Sep 2026 13:41:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drm/amdgpu: Initialize UALink handle uniqueness state
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260914054604.12850-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260914054604.12850-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: e290e37d-3f1a-4c77-9455-08df1419be8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4iQ5jVSqHFKv9c7TQCw3YikY4oU+KMOHhGCrEfnjV/cH409WMIBbVZY3VjNSLVFQNWX3o5WByfpmnFFpC74BAO0xbVpjJRpmDp5kkFh37UlM09KZILf0Y1ZMWYZr8Jd37+iykMm5dnTcbSthgadhFbcAQMbumvzQ5yBo+XZGY0M44QpfjVTP+9lCAzQgft6BfE8Bqaw1Nch/ta1hYMHqYWfeMjfawZBc6KwuCVXwrj0FjoI/+TatsCmeAnCYkW1M0StqixcAnNpXvmmuXMZ1ACGdB43KKl0UwTTJibSslmn8zer9HwWED63d1e9ln/98ZFykY/A3+NdLOLU9TWDnv4d0ZXpvY7n6IM80ZUyfBIPhb6N/1wUO021SU+30cTAo7x3NYaqBCH75TSHSvyKeZANs/TGCSwGFnHNoLOsc4baGmrB4I2nKkE4Nr/g3d7mY3RCE+I2Mswuc7HRAyFg0iQaUQo78Ugsp6HCvw7Kravs6h2fWzcUyyfTlcLf4Gheoqt+f7XWHGJ0betuuqek/BfQkZZDxVQUQ0HnWFrJbiV/GCiBvCpgcpE9Npn2qr1R0ozmuU6EARgF20KEPimKkT1j9C77dTNZW7VAYzKFbV09tu868GnIFbipk9hdtrs+j+2s9CnneNCiWUaGocg1PVBZ4t3ZJwjAwtYq3cBKap1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNZTXMrbVBkVGhVNmhZZjdyeW9JOUxqOGlqRTZFK091b0t6YTBPekE4aXcz?=
 =?utf-8?B?NVNtYkpKOTNMbkQ1WW5Ea1VsR3ZIS2sycVc2OWQvU0xqRmdQWTEwUzN0ZDZy?=
 =?utf-8?B?bzUyM3ZqZVZZMmNLVko4MXpITW5JdnZHVzU3d08yL2RGak1BRXVvMzdQWk5u?=
 =?utf-8?B?SWozam1zTjRGMXRFWkxuZVJ0S2xWSkZQUVMraGh5RjMreSs4cWlOWHFOWkF2?=
 =?utf-8?B?bTFZN0ZoWWhpWnlKSWM1emE4SUZrQWMyR1YxeDJYVmZZcDFHVEhxL21BQVFi?=
 =?utf-8?B?RTJKR2lxV3U5L2pmZFdScGdrei8vRFo4TU9DSTVoU0crUDlEcGdUcXlFdkhR?=
 =?utf-8?B?Z2UyWHpqTkpQTGtCSjhZcWhxN0h2d3htU1R2L25jYWo1T0tJKzZBVkpsL3dF?=
 =?utf-8?B?ZTRuaG5rRWNsTm40eVM3a1NuLzlIY1JJeFdyMDNUaXgzVHFwZlFpaFM2SU9Y?=
 =?utf-8?B?TDJXUzBMdjhtVWt2dVdtVXhZV1Y0b2MvbFdzSEYybXVmNGVzYnA5VnVFSE96?=
 =?utf-8?B?OHRIZ1J2SWdYcW1IY0lsUWdNdmZRM281M24wd3U3dkVsK0FmYllWUGlxd25W?=
 =?utf-8?B?bWVrUFpHTGxISS9hSkxudlR2eXJBZktrRnlhTTBZVk0zWlQxWXFPeHZnZ2hL?=
 =?utf-8?B?QVQzam1oNit0aTM0OEJWNlE1b0k0bFZKdjhSOGJDbUZ6d1NaYm5oMUxTTnBv?=
 =?utf-8?B?dHlFdXRmZ0cwVFBZcnZibnhGK1d1SjJmS2d6bmp1amlmMXZxZXEwWDBCa0xO?=
 =?utf-8?B?aE5USE8weDBhZzNHZ2Rrb2tOMkZpNWJXVDlHMkoyVkVGakRSUldudmlMUkpP?=
 =?utf-8?B?ZTlIREhsLzJ6LzlmMlpNN25xb2V2dkQ4cEFMc21Vc0gwVFB0ZDM3dUUrQzNU?=
 =?utf-8?B?cUNOd2NHMFZqRDFzbUJLSXdpM1k5WGZtemZEYWpSQ0l4WGduYXJYaUEvWVJZ?=
 =?utf-8?B?RTNlNkdUdVhpbjN3aHZGb0VHdmJzS2NHVENsME5qekFYTTJySHYydTc0SFVC?=
 =?utf-8?B?WmR4aThQVjAwNlJTRDZDbUY5TEFSWHcveldRMElRUFBNR3pvNlZFQjE4MkFP?=
 =?utf-8?B?TmUvYkRNb0hWRDhPV3pBdXhiL0Qxb3Q4aWJlK2Jtd2UrRFhrcmFDS3JGT2Rw?=
 =?utf-8?B?SUpPWUZOUkdmbUFsZFg1RmRIVXpZczVyZUplc3RLYzkxdlZOazVpc1ZUOFFh?=
 =?utf-8?B?dFlOS0RxY0pqcGpDcitwWlJWSDdKb0RtQm9UcVk5aEVYWXVtbnJ4YkxNNFNF?=
 =?utf-8?B?SFYvK2FqRGdQdk92L0dsSnk2cU5kNkl5ejlXeDZpdFlwMmVoWUhWN0lyaTcy?=
 =?utf-8?B?TTB5bklQTDdTL2RSSnBEYUJBS2pJUXdEMHRLRzJXSzVYL2RoL1RQckFSK0Nu?=
 =?utf-8?B?elp5bkRINmpmOHlXWEVmbktPTjVqcWVVa3FRTm5rSUEvZ3ZoRWwrQ3lGSnRo?=
 =?utf-8?B?NHRvVkJ5Rk52NXc5dWl1d2VKSkVRYThJK3VnSXhINDNkMk9IWjVGYlRsQ1p4?=
 =?utf-8?B?KytibWZXTExIVk0zR2ZXckpDOXJHS085YU1KdjRJT0w2cXJCaEVaVmhseVk3?=
 =?utf-8?B?QXBQalBVT041OXJvNThQYU1rU0h0U2RVOWliZkEyNjV0LzIzbmc4ZUYycmNQ?=
 =?utf-8?B?ZDc2QXpuRENBc1RGZldGY24wY0t5dDBZUXlrajZvNGJWN1RTWjUyOGxNT2tK?=
 =?utf-8?B?LzgrZHp2RlJZLzVNbE9vdk1JaERiTkRNLzVFem1xYXJPV2NqTk56WWJVdDBW?=
 =?utf-8?B?dXc4ZWg3SEVzYUVpd3BNNHpHUVpwSGw2bDJMTTJXNkk5eDJzeUtwUzRYditp?=
 =?utf-8?B?aTRiby9aeFlQZ1B0dWUzVU4xa1lld3hBd1VPQWhSVG5xR3VKRm9PMy9vZjhq?=
 =?utf-8?B?MzhTaWc3UDNKUUVWeksxbDVxRkF4Qmo5Y3hnSWxQSXQ2TDA4QmVDTzhtT3lH?=
 =?utf-8?B?c053YmFLRGhHT2U1THEvUVdpS2xmelRrY0xLUkY1TUdZY1EzazY3RERibmFi?=
 =?utf-8?B?VHZ0Q2Vtdzk5SmRhUFduVW9iNHpjWjhEdm5Vc2M0dUUrRStJMEVOdHRFcVJW?=
 =?utf-8?B?K0VISklqcjBkM1poS2F5SUl4RVNSVVFTTlM3cUg1cExzSGNKRjhJaVQwOFlQ?=
 =?utf-8?B?eUNwTmR3NHhoSzNocG5EQVlHdDd0c0tNN0JIOXBNRzNMTnV5dnkrdDlVMndB?=
 =?utf-8?B?OEQyOXhHL0ZOS0krL1hxWnVFZkRwbUV2QjMvcmxyMy9KRmQ5TTdabUxucnR6?=
 =?utf-8?B?WmpiTmJnaU56cE9vdkhFMEoyNzUrWDRTYytUeEhFa1MvaTNoNFJiTUh3VUJY?=
 =?utf-8?B?ZGdnTWhEMFp2NXZZUEc0NjdoUHpEL0xaNmZXL0hlandtVkRXODYvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e290e37d-3f1a-4c77-9455-08df1419be8d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:41:31.5350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdQ7xBDkw80JC8+f8T7v702tXb4QhcUK93qiA/SoB42gJu36mO2pmWi5czfQxD0YTTUh3Xtc+bZvValU1iyXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

On 2026-09-14 01:46, Karl Mehltretter wrote:
> amdgpu_generate_ualink_handle() continues when handle_lo is zero. For
> accelerator ID 0, the random value can become zero after the low 10 bits
> are cleared. This path reaches while (!unique) without assigning unique.
>
> Clang's -Wconditional-uninitialized reports the read. A reduced
> MemorySanitizer test reports use-of-uninitialized-value at the loop
> condition.
>
> If the uninitialized value ends the loop, handle 0 is inserted into
> exp_xa while robj->ualink_handle_lo still says that the BO has no handle.
> A later export can create another entry for the same BO.
>
> Initialize unique to false so the zero-handle path repeats the loop.
>
> Fixes: c67cb19811ec ("drm/amdgpu: Implement UALink handle export")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks for the catch. I'm applying the patch to amd-staging-drm-next.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Mukul is looking into the other pre-existing issues pointed out by Sashiko.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index ab56420..c6b7122 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -1819,7 +1819,7 @@ static void amdgpu_ualink_npa_mm_fini(struct amdgpu_device *adev)
>   static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
>   				   struct amdgpu_ualink_handle *handle)
>   {
> -	bool unique;
> +	bool unique = false;
>   
>   	do {
>   		handle->handle_lo = get_random_u64();
> base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
