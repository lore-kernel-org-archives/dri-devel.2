Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4493AC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 04:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636A110E5FA;
	Mon, 10 Aug 2026 04:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="01aEjGZ/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3270210E5FA;
 Mon, 10 Aug 2026 04:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6LJNpKiu/zERCDb8tCr4BcqLy69hKQyjNJjW6P/0AX9+Zd9BTffmObDPnENwM0azGCJLuER1TlAjwnhk9WO/B2MYPpq86wtQYXPwfCN5re+63HUUgSU4ijMUrtlkslKBEc2HAGxQai4poKqf6pMYq2L9iUCO0p26JEd78h1U0f6tdUj5SavHI6c3kemZ/KikH/SA+pK/zng4kj6v0+FLLbzxCtbC6JKVoNDb+lSqD5m2QHDjxWx2DbJ1g+RARXxem4zZR5b1pnqM1d7PUTlAOcSqrdWH8ahDB17W6r8u2b+9s2yVzmBfy5RZDJBAOiSiSU/OIo6S3FJDBsMdyUZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CiD/XsZZ9CcYeVBdSbwrM8JM4ISMg/r0RBH3HLBhrI=;
 b=pwdvIVQzaYpZ151nKFlM2kwTUDW75q9oRaD+nyo+B0Tg87xnpfynKaJIwJnQVsFSPZJ587gktdrvTY0lFgmMpQJGkVDsys/7PM7DuOlqBdL4L/Y8/Rc0souayjeSi7qGD/AwQxfWrijkiLR2bA49a2ellxLaxL3prbpizVtlMhjjjlEnQjjH2RQszqb8qnfheoAXmzAXngljLqpNvdAU2o2noQTAKYscrCmd3w7KnLoGzPpIFm2eaGTl8A/kB7ixtAiaq/4CuwrDvMioha9rD8y2unaXgMou6MJHFqc7RVU5fK+nhOi1uPVx3naz5BbriIqDB0xGjeiQTC+kJvq2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CiD/XsZZ9CcYeVBdSbwrM8JM4ISMg/r0RBH3HLBhrI=;
 b=01aEjGZ/iNz5BImqlXwH2O1ZRgzJJgTLgFNM54luG/QUwiCCrsLwK8PoE8+X60Vb6dCxrrLR58Xj78q6secX7r4hLye4/xuUJNxG8fLn/WgZIYeJITZ7nMVz/3/MWszXPWXaqAGtcDU/byqe5YAz3HIkuVZTYlxhFvYRAoxUf84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 04:41:08 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 04:41:08 +0000
Message-ID: <77e1ef2b-24ab-4492-bc91-08c01f012a46@amd.com>
Date: Mon, 10 Aug 2026 10:11:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: silence uninitialized variable warnings
To: Dan Carpenter <error27@gmail.com>, Asad Kamal <asad.kamal@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yang Wang <kevinyang.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aneGaKJUl_Jyu05n@stanley.mountain>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aneGaKJUl_Jyu05n@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daf5508-280b-4595-59dd-08def6999853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8IwwrQvWqi5NUXBWs1Dtb1x00zHLj4BH+LjM6AvgPG17ld2aAsNdtzMX7uf9u2JJt5v4kVesUYsUbcPH9Ynpu5rI4JR1pzLrdZ4pPOUSubv5qx8tFeKZE+gUvIoRQdSpAeA7tKexM3c5+rzMbmbBKQL8g99A6QA40dxorX66OL5TrURtIAVhHMdLb1FeECAPJoMVXF3iwpehrS/LnYqFvw316N2Hk67wKQdiPScjKmwmu3wUqzhjSvxI5xpYtpmXUnIOtVsUdCuZj+e7KGYbN4jOgFKfPIrVqEC4TEZNuijiHfw+dadC8cr2/hnDkMZ+aF1jnZ5Ywl4xsFect81/INmzmzuqirz1ibZPOwxXmiY2t75WJS3O9HGZH89L7rH3JRG4ELjM3NCKKNrOBWEcs+IedXMJOTwzVXjR0/Q+Wh67jWEZcb008CRfHxCSzJF2PjnpAoxw9VjrN1mKE8HUJuHDNzKQ76rqRzjT1Nlc4vLzDsCcCIrwYfi6dgv2xZdOntkFF1+eSqrk5ysnBhbY/Qpb5qiaSoNREdUieJ/9xUSeYia/DCQdbYklq8KgNPJ7JLFVhAYs4A9OoNaEoAPzxtHyiGDFIwjyToFcgQ2WAOsUOspbw3xjbd9lZTa9mEfvf9g2efHl8e16Q35wHuctd2Z57TEmW4xJc989E15wgzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlwUkRhc290MTB6VmZDRkdhcXNpRHlwS0pRNzdSTE8zOWpKa01pR2pPQzZC?=
 =?utf-8?B?Q3FkM2YxRkwzcUhyc3ViK0Q3Wi95WStWV3V6NjJsN1pyR1YybFI2T3BFbWhE?=
 =?utf-8?B?QmVuR2djL25BbC9UbEJsWkxDZnlMSUtLUmVwTXNOandSdms0eGFPcHNYbHNO?=
 =?utf-8?B?M1VyRzM4TjJrbUxlMm5vajhubGlWRzlwd1RiTGwvNTdwRkRqL1VWcXFYQ3Jp?=
 =?utf-8?B?ZG9rS2lOMHhCeUQwTDIrZFBsSjNWU0xPOE1jNVY3bzdRdDFjd01Ea3pJOU5y?=
 =?utf-8?B?R1djVUtmdG4vUGRhcWtmU1VqdEYyYXl0M2JSZWxUR0pZS2tPUzA5RlRRdHRK?=
 =?utf-8?B?a3c5WXhMYy9mRld6NTJzSnpMWG1VaFJGenNUMklmZFZKbEFqcU1SVWxlcU1h?=
 =?utf-8?B?U2dTWXRpMVdwK0NEcVFvKzlVdU00Z0VyMDJ5eHRBNHk0ZEI3cWVlRys2ODdB?=
 =?utf-8?B?MzBwZWRsdE5qcHBxVUdISW5aUXk4YUVtNytuRDhWMHMxQ3cydzVwczVwZzFM?=
 =?utf-8?B?M3d0eWhUSjNUTjJCSXM3bklWamMvTEduM2Zid0k1TW5BNk5EcjhoVHlzVjNL?=
 =?utf-8?B?NEQ3WGdKT2dXQUppS2NyY1F1Si9HQm56TW51cmdEWER2OEp1K0lSY245YVJu?=
 =?utf-8?B?SFpLNWJIdXdSVEhEY1ZLWkUwekZhV1J5Njk5YW5wNGlROGlpdXpSYjJaWjMv?=
 =?utf-8?B?aWhQeGFCR2t1YTBrb00zRVAwV0dmeGpEZURRTzZCQ1BQWEpQZ1N4YWx4WkdH?=
 =?utf-8?B?Y1B6b2I1OTJPaVVRTnJJMk8vSUc2N0FDQnIyYld4MWl1TGp2cUhtZElMdjFY?=
 =?utf-8?B?K01yaGVkRllaSzVTd25oZXRiLzRUZFJrNWp3cjBjS1lIT1VCanRYTHQ3YjEz?=
 =?utf-8?B?MFF6UEllODh0N094Qytud2xseEJreXVud2tZMFNUS0Frd0F3dVlyVEVMaTNL?=
 =?utf-8?B?a1dCNVp5Mm1TK0FxSEpNSnZzQ1BhMVlaWE1nSEIxamVpQ0Q2cWtERFlrN0JI?=
 =?utf-8?B?OEdPMG55Qzdsem1jNjREQmdRNytQc2F2VlFkMzlXVWtrMzRGeGd4VjVXTEor?=
 =?utf-8?B?bjloeHd0UUQrMlhFV2U5QlR2V25YaWxjOWxkSkZXZ0dLZGxhQjlYMG52NTVw?=
 =?utf-8?B?b2dMeUw0dVlzZjVLYmliVWIrQis0ZUE5UFNnYUgrNTAyOW1McTd5NEhLNzFE?=
 =?utf-8?B?dVBJUU5wOFRqWXJlbmlGb24zb28rV0tqckRNc3M4SzVzSnFjbW1EMkJsTzN6?=
 =?utf-8?B?dExGV0hDSFpCUlZBVndkYkVyMmF5MzJpcVdML3pJYm1KMDZ4VWc5NC9SeVdy?=
 =?utf-8?B?MWpHY2I0eVhqUGtEOGlSYWtNVStzK2wwZUd2VmdFd3FjL0s0VHhZeHlvNjVD?=
 =?utf-8?B?MFdVZENXWUZXTFdDUmk5SGpkVnpSV1doZ1NYeFdGblhkcU1YN1ZhcVZvMHVM?=
 =?utf-8?B?TUhlOEQ3OU5sd1hVTUtIcWI5L3JEYlBtekUxaTE1b2FPRU56RnA2cUNVTG5B?=
 =?utf-8?B?YjhxM1Q3UnFVb2JGb0NOK2ozU0xXTjl5dmRtaWEyRGRocDBzY3ZMZGpTcXc2?=
 =?utf-8?B?RGkyeFhpSDh3dzVJc1hmb0VxSk5KSmQ0T2txMUZLNEE1d2hQaklGUm5YT0dG?=
 =?utf-8?B?dzNSdWVVbmZBaVdySm1KaWw3NzZzU1BYZjN4Ujk4SFhLbEthTW5PUUcwcjBt?=
 =?utf-8?B?Vy9qTkxPVlhVZFIvOFpsUDd6ZDliV1ZYcFM0WFozSjJ1UzY0Q0VUNWJHZ0tl?=
 =?utf-8?B?ZWxmUkIxcHR1NTNZcW4wM0t2Y0t1QnY1M1JNQ21xYUdqSGhXRWNYOCttemxG?=
 =?utf-8?B?UlR3TERiTFVMeXBkTW55eGV4YXQ4S016b3BYSEx1NE50VG1tcEJtOVE5WFIx?=
 =?utf-8?B?dGRuMTVOVlZSOGJpZkxIME0rdHY2dW9uVllFdlViMEdVSkxlaTlGZmxUZ24x?=
 =?utf-8?B?MUVVdWNCYzVKYldKVFZjaVNtaSs2cnk3UjdqbFdLa21na0ZtL3dZTnVqMUxO?=
 =?utf-8?B?SGkrRHFLUkJpcGxzV3l3amg2eGFQditWVU1VSzRZeWNXdExtdmJRNmJjS1V6?=
 =?utf-8?B?cDE5T1k4M0xndlZNZUh2amtnRFJMeFA2V1lVUlAwNFhQRnZYMDVQNjA2ZTNX?=
 =?utf-8?B?bjA1R2lhVUZtcHhSZWVVRU44aE9HUGc5ZnpwU01NUFArTlVjVGVKSkxTcjMx?=
 =?utf-8?B?NTBDWFptMEtyc1VENzBkVEVZZGUwb3BXeFZPZWs3UTJUSG1meUR5bTFLODg2?=
 =?utf-8?B?Znk2dG5Gd0J5VG5MRzJDNVdzY0tBUmRnVk0rVmY4TmgzNXpPdStBODVlNzNz?=
 =?utf-8?Q?i3n95+uJ2DbNNecDqD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daf5508-280b-4595-59dd-08def6999853
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 04:41:08.3248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlIr4QtWLs3MPkXoksNGus/VOQQ6MtsueoszltSQHy5vqZZluql8FSmRuBfkhYR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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



On 09-Aug-26 1:11 AM, Dan Carpenter wrote:
> Smatch complains that:
> 
>      drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0_8_ppt.c:1964
>      smu_v15_0_8_set_performance_level() error: uninitialized symbol 'ret'.
> 
> In this line there is an "if (ret)" condition where "ret" is either
> zero or uninitialized.  Initialize "ret" at the start of the function to
> avoid a potential uninitialized variable bug.  But also delete the
> condition since it is never true.
> 
> Fixes: 422b399b09c7 ("drm/amd/pm: Add od_edit_dpm_table support")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 59fdd2319b66..c78e611d2a25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -1920,7 +1920,7 @@ static int smu_v15_0_8_set_performance_level(struct smu_context *smu,
>   	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
>   	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
>   	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
> -	int ret;
> +	int ret = 0;
>   
>   	switch (level) {
>   	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
> @@ -1961,9 +1961,6 @@ static int smu_v15_0_8_set_performance_level(struct smu_context *smu,
>   				SMU_DPM_TABLE_MAX(uclk_table);
>   		}
>   
> -		if (ret)
> -			goto out;
> -
>   		smu_cmn_reset_custom_level(smu);
>   
>   		break;

