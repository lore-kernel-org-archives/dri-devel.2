Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83C4F94CA7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293AC10E15A;
	Tue, 21 Apr 2026 21:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUiZpN67";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52C710E15A;
 Tue, 21 Apr 2026 21:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfaVEzgJokCEbxQ1GnUGxsH2IJcm57rkg64Ql8RE2P6u17gM25Zs3jmkVRXcL2BzgEvuFyfYpyxzLXrmZDUyEawVufC+ZGyozs3c1rAXs9wb6UpXKTWiLFY3IiVXmiq7HCTFIYZstE6+IKq9i1mmziGTssJwlLU7q4GGrolAeVWi1SNzmNtObfFXKj+e1sXV5Vyfo0mxUqHkkpKrbJXUBXOUDNx231kA2tPX/DRl7udRHJiRTyMHXomXWCIWdLIXL9n7gC21awL2xPjlwb6rGid9pFmmmSWqs35fT5BK1pnpc0oSW4g8Slj2UI8QzpyHzEBapUEJJutaZMWI4S8DRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKfTZoCpYBkdIRBjEVgLdxu7OhBN0Qqs27O4J5/ZNgU=;
 b=MpBOWoIT/x++LJFOq1UVZotjDuYF1nFbUbFMgge8tGS//QbKm4wZ7O8P7T5FJ4MzlZ62Z8i+KG1PxvYNuW0kR5oXisY819K+i1PajTwLFge3VucqhcS4o3FaEeWa8hSsuOdKD29numMzjbubCQuSSetFSI1ZPaD9K+A9spOjPrGrWjwFY+omrHQte4IMum5pWQW6OEYU3nSz0hHekLhuSxIfWYBhXR8Ny5HD3ySmNNTm2KPgPWgUqY/WTlPjsU6x+t1bdbqnVkhvurlRML/1IEeczCegXB5qkFASMEUhqCFvB4AvgwSnO/LXo0LZpPQzV5RWjQN2QUad29p9KtWWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKfTZoCpYBkdIRBjEVgLdxu7OhBN0Qqs27O4J5/ZNgU=;
 b=XUiZpN67UoMeFjjFCNhjMcXsqSiHHD7u8M1hgxRKn3tO867qKuZ1P4e7o5ITS12ing4SRxC6LLfV3exa3BhV8sIB4wnTdLLUPlzOyqbtc4O/SxLBlUMUv+fXig3i7Hqp2lEZCCBX3JJK6nSq1RkfByqd3JiYKwVnPgZyiKiJ2dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:24:00 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:24:00 +0000
Message-ID: <ca9a094b-65d5-4f01-90d0-fc9e4fcb0c6f@amd.com>
Date: Tue, 21 Apr 2026 15:23:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 9/9] drm/amd/display: Set color_space to plane_infos
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-10-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-10-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a22967-ed81-4315-3553-08de9fec4db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: pIksqnBxQTKSLO6ZD1KHKtNUYyFZtBuJIKZ9PTHUE9hGr9k+suwKlh4sgTBx8c5LLWIqjFaXvgbopfrMIW8fa2QHA6Wc8dOITFaLor7d+Cz6VmlCGCuW5xkmI64+ecF4HHJYVgLr42+PkSSI9n5Ay2O1T/6wyG3gFOGje/D9bAVUc3c3b0/UxXUXakKqsPlyWh/fnB72ZSxQUSsPjdv6ZUZMGzwpahYbmkJzxTIlc/ER6gOP1xLQ9k073tXIyYB3QZmJo8NsBwr6yzYrRjDtp9lFLLBmO1nRgkuk0B2FTaBA+iXrFUYvLkUq+/pUsFY2LCqhs7Z+rAt3RtQ8nXsydqC97pmdoiFfnqiAjiI4c2GaMa8etwiRtdfoIJV2DTDBO7Nuwlv6XbsaHkJbH2lyPBc4u0cQzof/eLokSMrjEngFK/vl4/pM6fgHeKYNEqq+c4k3i9DeqPb7kE4P60Zue5THkcmriLK35x0+fzqwefga76VLa+/UosNR0rMa4ALfIbDIVrCKY43TsposGu9bxoJLYxOx4HE6gCGPKYHta2u+ajg0yXDJMhB7O27ZJ+9uCeKyhlAQ89uJZpjQlxbNUzxThSKAUMZDI4J6j+l4yv95L9YhKeGNLzyLBHVXyKS1iZmmWRhad6P+/Hat4cWuJWEGSbiyHRLncE0M92YUWruFBwaRj1Pq8jPa59Rf8GoINNeeMydb92S3ckyQDHvtgOeQtdtbvdggbVUkZpTb6ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3R3bW81N0hwelZaY3VTQjlrK2s0RTNLalN2aEpZeHNwZHNndGV0aGpLbjdG?=
 =?utf-8?B?ZDM1MTNidFZmbmpHQWJxREp6TG4xWEtERjNnYUpPWTdoQ1I0eThvV3F1VEt6?=
 =?utf-8?B?d0dvRm5weitOcGhhK2ZTUFJOQ1hvT0RnN1Y1TXB1eUJsK2ZoYWZiNGMxL2Zx?=
 =?utf-8?B?NEdENEtoYWd4a3p1bzhOUk53d0t5bFVPR21SNXI2OXNVeURSeWdHbnptSlI4?=
 =?utf-8?B?WDlKZ2ljNUhUaURrOXFuY2VsTlhSQUJWSlV2MGIwVkRyeHgxdU5SWEQzMFdV?=
 =?utf-8?B?Q1BLMjgrRTdqaWphcWdPcnpwWm5hRERKcnUrekkwQjl6VUd4dWx5UGFZTDNp?=
 =?utf-8?B?U1hIeWp2S3JwYWFUODlmcGpsSkJZVTNjeklxOFBYWmpMcmVRcWpZc1VJaFBj?=
 =?utf-8?B?dXBXY3FURm4zOC84T3E0US9JYWxzbEVkamJKdEt5MzFDWlI2aXRuOHFiUDU5?=
 =?utf-8?B?bFd0SFZPQklFU0ZBb1d0TzZOa3JFSjNsaWNxTUF4bEMwZEo0aEVVSzN5Vysx?=
 =?utf-8?B?b3hEZ2U5eUVSaGNiS2FtVC9YTk1wY21CNFNWYmE3RWhQV201V2FjNytPSGZx?=
 =?utf-8?B?bzBqaGowaUVjZXdjK295WVViREVyOG1mUlFZemRUb2pNaVIzOTQ4NUtqcmx3?=
 =?utf-8?B?L2xyRm5YOTMwVjU2L1NpUXF1UktuSVVrTVZzN1ZLUkZmMVI1L1hoMGtFSVFU?=
 =?utf-8?B?d1dkd2h2NTdmcktWa3d5T2pWblZTWVlHeWRHZVFUSFhqTzJCc3RhZVhkdzFV?=
 =?utf-8?B?Si9nNS9jazJVT3ZOYnluUEpRVm9zYlg5b0F4NmttWGVtV1ZQa3NpWHZQNHEx?=
 =?utf-8?B?TmtWdjI1QXBaVlpJY2N0MTBBbFh0UWZ1Y2lyMnhiVVVHT3F5NDhCd1MzMjJP?=
 =?utf-8?B?MU1xOEV3Z0JVcWw0ODhSNVZxUCtFQ01SNVBJS2RSYUVhWDg1MDYyTitFdTVq?=
 =?utf-8?B?c0ErSEx6TU5LRW9VUGZtVjhiRm5pc3hTV0QveEJsLzRKVjI3K3V0bkh6SVpU?=
 =?utf-8?B?ZmtTSG5PS3ZNRzIvU3F6cVVXZXU2b0x5TklXdWZqM2NDNGhXQXJaTXhCN011?=
 =?utf-8?B?azkydGVYdjJyaFlLc1VVanUvS3hHQjN3YVZyRjBiTnY0VjllRmw0cHpBa1Zq?=
 =?utf-8?B?Y2JrdzVYaEFHeXROUFBBZm1FRTlBWVdFMVVpOFQvSUZDeHIxeGRLazRLekJw?=
 =?utf-8?B?UkxwS09sR29XRG93dEpxQmZIVEVWbGlaaWdhRUdDb1h1b3RSaUlwNHBnektM?=
 =?utf-8?B?Z1cxS0ZxVmhKYU9zWi8vOURMSW1INXhhdVRJMHhYRGMrKzJMSDNGYXpSMkpK?=
 =?utf-8?B?Z2Fhd1B0RGJpM2FWcmtKUDdsL1hBLythQlFqejBkUnNZVG1jR3EvR3ZBZnps?=
 =?utf-8?B?MDAvMGxhK0ZreTExK0NRckhjSDQxMVpmQm9ZWUdGaFlCNEp2RnF6anBTaHlM?=
 =?utf-8?B?ZlJHSUJxNUY3NCtsdEt6YjNlRlFxTTI2cHJXRGxudWg2UzRxS3NCd3JCNkpV?=
 =?utf-8?B?eG5vc1k0cnVoeCtjUDRLMmduVUc5c2dERXhaZEpLa0tPTy9ZWXhiczE3Q1h4?=
 =?utf-8?B?V0RIcms5RG90VHNaWHNPWHQ4bmJCaElrNlFRNmh2RGRCQm05cWNKb0FnWGlq?=
 =?utf-8?B?eDhDTDh0SUJveC9WaldZRi9EbVpISWJ4Y1FTQ0NpbUtoYUJHaitoeEh0Z2dL?=
 =?utf-8?B?Vk9rU1FlMkpiSmwzZy9IY0dwQ0xHYkFmN05wSVRFYXp0VGsrS25CemVRUnBG?=
 =?utf-8?B?cUJONzkvM3BMM3Jua1dTU0dTNzQ4NXcrMVNadW00VkdsZG9ibDNSa3BZcUVp?=
 =?utf-8?B?WVhydHRCcWppSTNWR0Z0OFUvZzFzQjE1bllFN2l6WHRTUHZsc24vUzFuTXdn?=
 =?utf-8?B?eVNaQU4rOVFhVVBOYzBXai90cnc2WlZ3emhoQkpMQTF2Z3JtRCtjTjR4Ukov?=
 =?utf-8?B?am9iNTg2Uk1BRXhzelBFYjJWWWZsbGxIdldnQ3pwWTZWRE11MmExeWZuMmY5?=
 =?utf-8?B?Smgwc1RnODZPMVovTndRUkcrMFVraTdIRFlaaU1mejNsMWhaMlZtd0hiQXdo?=
 =?utf-8?B?UjVlcDRtRFdtMk1kZHp6Yk5tUlFadkErU1FuZ1VpeEFEdllmdmo0bld5emRi?=
 =?utf-8?B?VXdGOWRtSnZGNURXa0gyOTdaQTZPYURrcEN1SFJ6bGp5S2pXbVFHcWZGSjc0?=
 =?utf-8?B?Z04vUXJ0bFIyUzBMeUo3ZjNpNXBGaUFFeFB2Wk1oMFBiK2ZPNzBtTDNoOFFS?=
 =?utf-8?B?TW9mMjMzeDJDTFFkak4wYm9HNjREajEwTlFDUmNWTXZhUTBEVE9ELzMyNnRL?=
 =?utf-8?B?ZlF2SEZrc3BUUEZEc0tVQjBKdG1KcHlYRFhpUTRpUCtWNmJCUFNXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a22967-ed81-4315-3553-08de9fec4db8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:23:59.9826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcjJp1m3LIKOvJqW/0u+Z7Dpb7n1JnQcBkUk304hrQSlp0VXTGjp9zPR4iuNI3r0CU5Y0Nqc1ayw4mwF4mApNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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



On 3/30/26 09:34, Harry Wentland wrote:
> DC looks at plane_info structs.
> 
> For legacy drm_plane COLOR_ENCODING and COLOR_RANGE this was
> done in fill_dc_plane_info_and_addr's call to
> fill_plane_color_attributes.
> 
> Co-developed by Claude Sonnet 4.5.
To be replaced by "Assisted-by Claude:claude-Sonnet-4.5"

Reviewed-by: Alex Hung <alex.hung@amd.com>

> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c3c6211d15cd..43bed6b37e35 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9992,6 +9992,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			&bundle->flip_addrs[planes_count].address,
>   			afb->tmz_surface);
>   
> +		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
> +
>   		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
>   				 new_plane_state->plane->index,
>   				 bundle->plane_infos[planes_count].dcc.enable);

