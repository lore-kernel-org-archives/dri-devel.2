Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65538F588C2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1A010E576;
	Mon, 20 Apr 2026 12:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UUhFROzL";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110AD10E576;
 Mon, 20 Apr 2026 12:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV0puPCiqp3rrvAuZiv4qVhQkD5b71T7iUzIWmHCBzuPQhXmfTDatUkEgBSokNaYtv/LLBDENhaFdGjQ258e/Kqb4kSqu6DRLXhD2gkKm8/fALpIjhsU5Z6gIuupTwdvh6oE8pZBV34kgXvoBw9O6y4CZiW2mt/Ms9DiTi5imB6thYO3Wdfrp48DwLDnxxm5UvVMH0yOukjsrlFOyPwxLqVTwoVdVD0/A5Zanxn9mAvq7FhNIcz2TV91z0PHFnXrX9yyGS4PenZJmdGPzIMQeiuE+jKoGW3dYkDKwe+k/iPZ0iZ+9tDj37/Ph1KFlsLCn3GZE/AW17bqKgJXcPv9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYtsaWSatMUpoVC0sLPpsYH8NP240sV5MvR4qHz2mnI=;
 b=Crr5SMmePx3HL/oOe0bWoA7z886PPxE6mulx737lNrAPgk3IBaFNaFPTdwUNghBCiZHnVLQfOWzf4HGZcMy16QzfL1k7fkCZD56q8twbjWIXOVKHDykhOat1SQztFXzar+nL2YkeApAHCRTFvumKwC4mXKcnKcMqqxuLBQiflm0/SyPJpnvX0vFNxJb4ML4pdym7Acgss71w2QdkzANwEYX3XoypkdYYB0cFJsGbQH3/uBZhhZhNIj9qnEL45/tqtuJkWOZjX+w0ZFS6F4fTl+JakdnXBOmoOWlrecEPgue8NkOUU6q7e/Ozuwfia9o1kFCqf8fqWaij3Dmo0nh7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYtsaWSatMUpoVC0sLPpsYH8NP240sV5MvR4qHz2mnI=;
 b=UUhFROzL7cwTwU4ni6bAsht3iXCZTcPfUMaRsyOj2vv/tJscHgAd71cDd9uziX1X0GGQSvcvmEV38Q2jX/DcRnJkNeK+To5+hxKqQCdTMLc3k6hC/sJ7H1sziTP2ErHzJD6apoqEbjRKbBE2hXJOLWrHl7t7EYQ3dIOkW2e4i3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:29:57 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:29:56 +0000
Message-ID: <2dae17fa-e679-43b8-9bc9-324359870cc6@amd.com>
Date: Mon, 20 Apr 2026 14:29:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix root reservation in
 amdgpu_vm_handle_fault
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260420121438.1612-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121438.1612-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::23) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 326b2562-e487-4ca0-d6e7-08de9ed887e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wnD0Xp7b4kooJDT45z+rY7YHGnET7gJdOMp6lOQPQfw5CrLQvsusUBXFILtvRT56wUeOjpVJId0fIqduiyN/QKTbL6va6e/T4zeb4TUDY5KRr4fe3kQgEKg0lYfRaY4vzWQnB8QAs30lr9mEmR8m+1Rn5HizZY75BjGJq/9nuodUytcPSO+MuKlz+lmC02g0taEhwC5PyThWiwiOiwyVhNaqa61h2GbRpj2QWP+apmvznqgFchB//qw8uWeVwSPtBUBWudo8yv9133U8I7l3GGxPW20kOTYFBVdSFPE/8Z/gLhXzEX5ZsuZ7kIkcyo6d0cYPNVtCjRUcJU6SsfIjwDZpuFKPNfXW0npcrDvj/kT32G4Z0oVkTtzs00sbNBCkgWXH7esJnkhtiT5D4e62dVU1y/SbILRteyhTwxOpdtBK5KPj8CDBN17AqJu0yGOwdPukg355tPD+yA4VhAeBB9gL5rITC/rooj6ua4w2F+DEfrfzQEvn/MLiv3HAn3WogNwhYp2oPZF8niOgsrsGrLiWjbXRl22FS6ITRiK6b35g/XFreSWmXfmu/ltEoBjE+e4HW/axGhYd5LZdglprb0xwUN49wDzPc1apY7DThf14impZcHYyCivKfhZWgml+KJcNBfhoXMa0waUi1AUzwok6llYsJLiGqpbYH1lU35XUf2FDA6Wbvy+zQ2+DVzntvr56EmNcrMSmfuId8Hk11USse5iDQdFBktcGP2NvnO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFo3OUFFaFBEZ1BUcWtKOVZnUFlIblpWTVBwakNvang5YTZFb25BT211Y1Vw?=
 =?utf-8?B?ZTZFR0hGTnBadEljMUZMR2xML2VuS3NsV0J4ZFR4UHF1aUdiTWFXdUlrMXpH?=
 =?utf-8?B?eWJSalQwUHIwUkJ3UEdFbHRDcG1xZ0xla091bytiN2xVMnBFN3hEU0tndFJW?=
 =?utf-8?B?QzQ1emEwLzhZUURCcnYwanpKbVJhTHJROER2eGlWd3dQZDRvTzlLK3BQdE5q?=
 =?utf-8?B?YU5DK2UwQnorRk1TS3ZmMGN4dXlhZDlpYnVZOC9LNTNxMDY0MVFHMFpyNjBJ?=
 =?utf-8?B?a3pMdk9CaGdvQ2N1NGRBSU5VRkpiaVM4S1J4WUhnck1jaHZSS3AvTlh3VC9M?=
 =?utf-8?B?YVd5NUl1YWNyNlRySEpKM2tuYWFyV0NSYm5MNzFxSm5CU0JaUGZXUU5obDg2?=
 =?utf-8?B?QU04d0VLTlpacTlFT1h2aC9kL3QrWXFGVGhhcmY2dlVoNWJwUjhRRzlvUjZq?=
 =?utf-8?B?cjNoMDJTcnorazJpdXRaS2UwRndNL2t4VFM5M2llVU92MFJBZndEcnNEbVBq?=
 =?utf-8?B?VTdOcTAwYm9DVWV1cngyQUlWcjJnUkl4TU1PZnNNeEFiOE1acXZDOXM0aWx0?=
 =?utf-8?B?bWRWalVTQ3BTY1FDVHhCZmdON25NNXJmNTVnZkl4ak5SYjVQRUthOGRvcG0r?=
 =?utf-8?B?Q1ZvK2tIQ3dpYXprUUFQOVdMSjdqM1FoU3U4L01BcWJLSHVadWpGYVQ1Q3hU?=
 =?utf-8?B?THBJYUtmaFJwYjJkS0hSNFBtU3ZNQnBjZng1TTJQMUhjMW84eFgwTEY1eE00?=
 =?utf-8?B?UUJXRWtteUlhQnRNcFA4ZDkxNlFGVWEvUDZuMFA5T0lkbmdiaThUUElDMksy?=
 =?utf-8?B?eURxRk8vc1Eyc01KbFQ1WkhhbEJ5a09Zc2pWMVc1b0Zsd1FxUitndGxsL3V5?=
 =?utf-8?B?cE5McjRCODRFN0pqdFQ0ZldzZVFZTFN5QUp5bXBCNmtTVHF2emxsNVpSWHV6?=
 =?utf-8?B?a05BY1RTWUV5a2t3UHljRDNYczladFc2Nm5jVG82cW9HeHVXaVgxU0Q4UXd2?=
 =?utf-8?B?d0pQdUxHZ0pFRFVxRS90cWd0SEJGNGc5WWEzNERNYXNBeGxGbldQakhLVHVr?=
 =?utf-8?B?ZVhrOW81TVNUZmRSUmV1V29qcWJCTWhtY09NeGtLZklGWngveXJoNHVQajgx?=
 =?utf-8?B?dFRhcTFnVHpYbXBsNGUvbDFuRWR6M3ZFSkJtTXJUellRbkVydHBtR2hzb0pW?=
 =?utf-8?B?SGd6NzB0NHk1V1BjSHhTbG4yTDhxSWdQZWlYY1Z3NWdvZkpEQ3d4ak9tUFZW?=
 =?utf-8?B?RllSNE1VQzFvZTVZa3BRZU1hVlZPVDBENXdERnEvT3Mrakt2MXNVcDE0NkxM?=
 =?utf-8?B?MnpmVHNhYmJkZ09GbFJMYzZNdTA3RFh1VHllNVhLdjZQR0R1YWkzSGZiemFB?=
 =?utf-8?B?Q0ZpVGxqK0Q5T0tPanVieGtMZlJhd2M2QUxMSGhWeGVmbnFYajFYeVdabEU0?=
 =?utf-8?B?SlVGMWIxdDhCL0pCVFRaY1ZLQnN5WTBlR3krMWFWUGREWXRzUThodlBXOGR0?=
 =?utf-8?B?dDNDT0dYa1RDZEg3WmJyZk8zRzFkK09kTFNQMVpJdmJHdVB2OTdLTkk1dUxv?=
 =?utf-8?B?ZTVBR3JEbDU2dDZ1OEllTlh4aDhaSGFQeEZ1Y29CSTFuK0ZxMXhrMGxuQlIy?=
 =?utf-8?B?VmRPdDdMYWxuMmZZcjYyQ1NodXowY2paTW1saTRjZFdpRUxXQzZtQTZsQnB3?=
 =?utf-8?B?ZU5Od0pSV0dNVHRESTNwNnY4Qk1pd0hwSUVIRXJjZEE2NlhEUlJTS25mb3Nz?=
 =?utf-8?B?aE9NdW92dFhYTUdLRE83QmNmM1daSkZRVmdqeFFhdXZPMTBQL1VKcVc1WCtl?=
 =?utf-8?B?L1gzdGlJbVdYMkp3ZmNvYTFicnhyVGRFM3ByTDlyRnI3N1dZTThnbnBBR05x?=
 =?utf-8?B?ZnBFbHJicTA2dFA4eHlRM1gyV0ZDV2lRS2RLMjU5U1VaU3FvRUlTZytmV25o?=
 =?utf-8?B?WWhTc1d2UEwvVk9Fb0IyZXFNRXppTEZXQW1Bd2hjWThNV0FObU1PUWs4MTBL?=
 =?utf-8?B?WkloSzU5ckx5RVNjVFEvV2MraytSMXAvVERuek4wa3RvM2ZXWHZEQThjZUl1?=
 =?utf-8?B?SWR3ZEpOcENhNEpVWWFnMnRrUUtGbEY1bUZJMnpGaWw1ZFZSZ2wrbkpxT043?=
 =?utf-8?B?NFlLWWxWaUVwYVA4SmRNUWFvcVZocHBSbk8rQ1pDTEF3eVhvSEhLMmlzT3F3?=
 =?utf-8?B?S04xK2VwWGhKbmVUR2dodGI5U085aG9SMkhDR0Z2cTFGc3FkU2UrMVNEWUNi?=
 =?utf-8?B?MmRUMzVmSEpheTZJUjlZak1kUEN3M0dTMnh1a1dZY3hyUkRJekFUWUt4YTEr?=
 =?utf-8?Q?6KM+UYYAZ+0tc5JxOm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326b2562-e487-4ca0-d6e7-08de9ed887e7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:29:56.4676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjP18LY2G9Z2Yto/bR1Hk6qIUmTtd15AU7NMR+ZaZTEtTyUg2K8u7GmK2/KYRNcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
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

On 4/20/26 14:14, Pierre-Eric Pelloux-Prayer wrote:
> svm_range_restore_pages might reserve the root bo so it must
> be called after unreserving it.
> 
> ---
> v2:
>   - don't modify amdgpu_vm_lock_by_pasid
>   - add a TODO
> ---
> 
> Fixes: 32b486e8541c ("drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fault")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..799a1803d941 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3026,11 +3026,22 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  
>  	is_compute_context = vm->is_compute_context;
>  
> -	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
> -	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
> +	if (is_compute_context) {
> +		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
> +		/* TODO: rework svm_range_restore_pages so that this isn't necessary. */
>  		amdgpu_bo_unreserve(root);
> +
> +		if (!svm_range_restore_pages(adev, pasid, vmid,
> +					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
> +			amdgpu_bo_unref(&root);
> +			return true;
> +		}
>  		amdgpu_bo_unref(&root);
> -		return true;
> +
> +		/* Double check that the VM still exists. */

Probably better to write "Re-acquire the VM lock, could be that the VM was freed in between.".

With that done Reviewed-by: Christian König <christian.koenig@amd.com>.

> +		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
> +		if (!vm)
> +			return false;
>  	}
>  
>  	addr /= AMDGPU_GPU_PAGE_SIZE;

