Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FD4FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A3810E23D;
	Tue, 28 Apr 2026 12:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrTE7goI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8808A10E23D;
 Tue, 28 Apr 2026 12:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K15gqmitMw06XvBAWAgM7btCY5LyE/Gx22UrhUrd980BBdZN97A/JYCgYQtISSErDUbAwMXxRspOBApZSHPXwTecd+pHE4FiqUDqAEPD87bu2CZaFuOZmBqeGOuieHHtVKY+UpnfET/1bvzd7giFPha+k7uxKo0cZsNuxe3NnSIiqZ1DUp0+6ZGvmUQ3JfNjpA8X07jAFY5S6WtC4p5xgHj6t9VACnGsDmexWiwZr40b8U05ySBPbLUY/Mq8F3BlC0fhW0DPtQW2Bt3OMF8EewHpT4U1GUUwz31gXvqqXvCg0/uXIg5UApx3++Wj0LTnM3VATQdNGgBxsAUKCVfmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=948NTBtBS0VznoBAEQWvHRUDKMIqF211qUb3gq5o2RY=;
 b=C5VFGnemE6eQjdCVo/yel4RR/IVLKnDW2koFW8dehbLNCSDg/4FEHtCX1oZ8cwrM3VU1lC216t74LuRrP1phMAvaXYWmsv5Tisfb2A81QiZVUzMhPA4MtAxsQqfpDfKPkjQYBdaawnagXwy8kX1+uUUKz8AM4Cy5Gq/V8yt7kUTc7FX1pTYpLttEQ/ZfYNKFC6blv2jULFZpxWpG5traEYfAn9ULjPs2XUzi1iSPrFUDwSdQTo4DrFE/UDzb3kXZQJlzC09QMbc3+AhrR8Ahy5mLCceFlyqWahJ39pQ0Xg6UKXdQ8CafXkuAPg9V3VOhu+tF7llxcLoKYikE2BbFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=948NTBtBS0VznoBAEQWvHRUDKMIqF211qUb3gq5o2RY=;
 b=vrTE7goIgMo+Sna4mNyPCSdpEWfqU+vIvvKUeCO6je5+eN/Zt9mlMB5be/8NdscFE+53R4AuP+6fKnE5OmpDgsDrqoZD+6hQJpwWCzJsxQM6Pmm86lVKXnOpc77/Eu8laXWXf14lKWwMh5yu6g8GmR4K4nrol2wdxTbl/0WFt1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 12:10:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 12:10:58 +0000
Message-ID: <a5bbcbeb-b2a2-442c-b2df-7dbfef8bf442@amd.com>
Date: Tue, 28 Apr 2026 17:40:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_xcp_cfg_sysfs_init()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Ce Sun <cesun102@amd.com>,
 Kees Cook <kees@kernel.org>, Meng Li <li.meng@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260428114521.364863-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260428114521.364863-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::27) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: b90cd0bc-0351-49ea-a12b-08dea51f34a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: n/taYRHK6Y1X+qudLFwzB7asNeiaVUm/bMmHp6e1GGoikZDpAqVhS13vQyHUKww5IpD57AC42+awv00dD9NQVk1qISMtQSHYMFw4LKWt7wlcU/aALyX6P6Ij6AEl6WLWE9lsEs5ErqfFwhKldWbpaQsoTKLSdtPbZb1I6bETxQWb4Q6rb7pEA5wGGGfiMjQym4JBM8BgGk/SaAHnlGTru/tn1VgRqMxL1rN4vsefrfFwTrTFUz+TFOHq1ox63lddrgxolFxG316W4VrI0N2Dk7TKXW02Y8RwD2Y1dBVkXytxRUKdjov0KoTnJOTshH6+rg38BdeOsIT9888oab+iV5gpUwAeFTvECPRLAXwcOs/lZdSAAOHk8lVxWYTrubemchgbY4A4Mz/oczpQDsxG6Evva/5iSTFmKnF8WBJ5lyC9iw5DbvastaWEqcxUQ3tflc/P9XiVU31+MR2XD490/nKyYY6M9CGqTNrqJ0Kw1uDVDgHt/djTLT9wFLVeRRsKGmuyfccAsQ37RZ1BtUXJhuowxIv5NG4tChNsiETDsaGBzZIQ7csY4vnVaX8ulxTgLufkyjJIs1GGh44Js9AxBmpHuR7D2pgZRAldlXFE+COYCY2tVu7p5B04rSWc+af/5fnPjZ78BVOhRsKSSb41nGv1Xe56KBO3jf0c0BQULoU4rKA/NZcCj83FOvRkbGKqO0nQCRhnTHvi7hDxB0s21SogXc8hak9WZdgwBNtGpAEX6wGxJng9Nn+z1HcIHDJLVtQAYuurN6UBKTAt/bDjmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUg1aHdwaUdMaEF6K1Jzb3d3aUJDTGRPdzBRYmJYVUgrVlJaWldaeDhRQVRn?=
 =?utf-8?B?Z1U0bmx6OURtbTl0SHpTSXFFbHVoUEl0VXM1bkMwOW5jTWw0eEFpYXRuTzdo?=
 =?utf-8?B?VnErbkxJZUE4UTR2ZDZyT1BmZTh2cmdoWkhMZk8zQlIzbzVSMU9iZHBNdmRl?=
 =?utf-8?B?NXhuNnpmRHgxSytmVDVDOUh5ZnVlbDg0M1UxNFczMjBDa0xVT3dkcFczSVJP?=
 =?utf-8?B?TEIzaUljOE1PeEFtMklMeEt4OGV3QkJqcTlrMk1idStLU1U3SkxLbFZZSng2?=
 =?utf-8?B?UEFpb0VLWWgrWGFCNUpnc2VOdWVtZllMOENFdVVSdmw0SUhCcU1WOUlwTkoz?=
 =?utf-8?B?L2g0bUYwT3U5NTNPUkx4TEN5MWNTZlpSOXlZdDZaVGFqanRVWlBVNGtZSU1h?=
 =?utf-8?B?a2tmbkV1MlZuMytTOTVta0c2aTNZK2duVFFqUTJZd2VVSGRDQzBTUXhRV21l?=
 =?utf-8?B?RjVyZFpoL2hFTU1Gc1BXamlvRE5YajM1RGdaQzcxaERxNUhZMC9oMWJqZEhB?=
 =?utf-8?B?alRhUkFhYm8vZGMwR2VldGw3ejlQUHVtUVBoQzVpY0w0MG1PSDF1WjJ3eTY4?=
 =?utf-8?B?RHdpcnpoclNFa3ZNZDNqTy9Rd0xpSE9FTHdaSEMxaU9lYm0wYTJaUGlHQmFY?=
 =?utf-8?B?YmQwWHhsT0RIbHBKOVRUNUdPUk1JbGNkZDM3djhPM3NiRGlHVUpHQndQMUh6?=
 =?utf-8?B?c0t1b3RCNCtsTzBSblJISHRibmdqMUpiL1ZWRFJCSWN2RlZ1QjJKZ3IwdWRp?=
 =?utf-8?B?MVM5NTJrUnBxOHZ0Y1hKZnRrZVNBRHBoMjBxZnVreW1ENWpkQ01oNmlaNVRE?=
 =?utf-8?B?czQ4OEhSc2F3OTJGaHg2Y1djajJGcHJiUWkxZEZLZ2N2andMbkIyRm5taXJo?=
 =?utf-8?B?czVzMXRwRE5NWTBEaERQd3g0dXVZaDV3MXlub3UyQXlDV1J3SjFERTdJSy9F?=
 =?utf-8?B?clRMbjFBeFRjeWpzWlpqWVVNOXdUM2NucGpSMTUzNFFyUWJ3MThYdWxHNWFl?=
 =?utf-8?B?SEJaM0d1Y3JDWGpKYjIrdk5rb1BFY3I4ZVkzQW1UYUtuNHRSNXJ2STZ1Rzcy?=
 =?utf-8?B?ZTcvZGZJY3l0V0RMNHA4aHhrQ3h4QmJ5N09vZGtXdVNQUG1LdWN4QXpnazlp?=
 =?utf-8?B?ejlLektiOTlkL3NlYlNoYVFBWmhCcjNVMkwyamlOZENuV2tRWjZzeWJPWElk?=
 =?utf-8?B?WlpkRjMzbkNuRVhiTTRBYUJia3oxbENLUnl5Y3BLT2IwWWs2Siszdk1tNEgz?=
 =?utf-8?B?ZVZsZmp4VzZkbk9FVnpSa1J4UWMwbm5rNThadVJtM1JDUTVSY2krdjBURXZG?=
 =?utf-8?B?MWtSYUNqbC94OVkybzlrWGlxZ2tTRHVWZkFiVFFTTExRYXFTNUJudURpL3VX?=
 =?utf-8?B?c2c0SGxLVWFPRlNDeWcxd2EvMkxVVjByWXl0M3BLSTBSdUJjNjdEUWxTVEV6?=
 =?utf-8?B?NjlwWUhBUEd4dDNmbUZCRDhBdkNEL3QvcEhwSWxHSzRpSC9UYXl2N3RiRGxE?=
 =?utf-8?B?a1dQOHFrV0R5RzJJR2VpQ3RDWC9mc1pLQ01mOEpzTUhzbzkrRnhsVDcrNnhx?=
 =?utf-8?B?Uk41NTR2RmVWNjk4Y1RNVUliSzR5WW1ESmtRN3NXZ1lkSXBlekVucWVpUFpU?=
 =?utf-8?B?OXFON0RNZFBVSkJoMGNycmhxdzNIeGdqeGJBMHMwUm8rczZ1U1FDQ1N4M01L?=
 =?utf-8?B?WUV2eDI3N0ZkSWFhTDExcGhUYTlPYkV6eEUyWno2ZlBxMmZkMDdVRmRGRVd1?=
 =?utf-8?B?RTBOUmFFdXVJeUxLdTBVVGVjcWg4RXR1akpxN3lLdTZtQXVDSlErMWRnRG9S?=
 =?utf-8?B?bDVJZ3VRcXhpaU4wT0VxU1ZlTWdyN0F0bHNxcE52c21TZEhpcm02eTdsakhG?=
 =?utf-8?B?c1NxUUdBRkdTZmtZeVRXVXhkQnZRMnBrVUtBTmJoeWVFVERiM1lEQ09lTHNU?=
 =?utf-8?B?VXF1djFjTlJ0QUVySVhGZjdKNmg3OXBpaW1VY3dtWUVHa2FGV1hVV3gyNkw3?=
 =?utf-8?B?SDlxQVhPZ3gyTjk2N052UkJXdFFpVEk0VnpHQjVSc2dOdnhmbUlGSjV4cmtM?=
 =?utf-8?B?LzdSN0dDdjB4bFArZHhGZnVxbDR5WnRCUU8zWS9sc0V1V2VRNkJ4UFlNbzVp?=
 =?utf-8?B?azY2dW1vTlNBK3pPVWlFeW1NQ0p2elhnNzVvRDh2WXhIVFo4S3hWL1VITTJQ?=
 =?utf-8?B?WUlVa1FLRitCMmIvMVV6c3UrdWJSSVJMM2NOOS92c1FwaUJnOXUremdETFdw?=
 =?utf-8?B?ck81UmJSMzBadVMwL1M2c2VlOUtOQThXenBVNHhNU2NQaTA5bEpLaGhPMTZ0?=
 =?utf-8?B?T0p1S3VWQTJzNnFtQkpER2RjM2lScmtES1gzVWlDZCtqdGNsbkZmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90cd0bc-0351-49ea-a12b-08dea51f34a6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:10:58.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H999rCgcmXGfz7z/jcQhAjdytOFla42ECZ1mtLejoNXLMH9xclh7Xtp3/SNRbQn9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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



On 28-Apr-26 5:15 PM, Guangshuo Li wrote:
> [You don't often get email from lgs201920130244@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Once kobject_init_and_add() fails for an XCP resource kobject, we
> should call kobject_put() to decrement the reference count for cleanup.
> Otherwise, it could cause a memory leak.
> 
> The error handling loop also uses xcp_res[i] instead of xcp_res[j],
> so it fails to put the previously added resource kobjects and may put
> the failed kobject more than once.
> 
> Fix this by putting the failed resource kobject before jumping to the
> error path, and by using the correct loop index when putting the
> previously added resource kobjects.
> 
> Found by code review.
> 
> Fixes: 4ae86dc87850 ("drm/amdgpu: Add sysfs nodes to get xcp details")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index cc5f4e01e38f..315e33a9d7c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -948,15 +948,17 @@ static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>                                           &xcp_cfg_res_sysfs_ktype,
>                                           &xcp_cfg->kobj, "%s",
>                                           xcp_res_names[rid]);
> -               if (r)
> +               if (r) {
> +                       kobject_put(&xcp_res->kobj);
>                          goto err;
> +               }
>          }
> 
>          adev->xcp_mgr->xcp_cfg = xcp_cfg;
>          return;
>   err:
>          for (j = 0; j < i; j++) {
> -               xcp_res = &xcp_cfg->xcp_res[i];
> +               xcp_res = &xcp_cfg->xcp_res[j];

Good catch. What about just keeping it j <= i? Seeing only one path to 
get to this error handling.

Thanks,
Lijo

>                  kobject_put(&xcp_res->kobj);
>          }
> 
> --
> 2.43.0
> 

