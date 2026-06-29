Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02C3C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4AB10E8A3;
	Mon, 29 Jun 2026 12:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzp1UfU2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3748510E8A3;
 Mon, 29 Jun 2026 12:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovs/2jSqqiKwxvINqK6px/dBEvTBuEJa+z8JiNM5AsLyGDtz2LfKI9BPKx0qQdGvcfosqSlbGR0Di5Yh+BPsDauV43hUbcVrktOzhINcsA2G003S2ruG4hfksTGjYD3uo7agQxxVnZQyihsGMid6P6wSyQc5GBqVE/k0DWvFEwnXRtytnAsY+tVXIy4fK9tCzuoaactX1eE7lizA8YhjxuGuEZ0QRVuu5vH3XUwET9CMIgig3dkh8ryaqY/4weHv7C76Ure4ItiDgzIZsMs4bB8Jy0VSCpZcVSaiO9fbvuKw0zIKFPCBfM/xRIDiFTh0qHcUyb+7MXGOWuWbdkLpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcn7mfGw3lN7bYoFTLCnXZ3cNblsfFvvKGcePa7Cbhg=;
 b=uleh9VVQU3LQ7kAAGRtasB15TR1IoJ7IDpNZtixM3GNLwg1u9vyIiqfllS2SchpXNnFB14n4D0kcbdrjxqToJVnbJy0cMk8Zmke5OsG0W9iNx1NzR69CYxnu7jadb+g8R18W/7vC2z2V7h+2LUZHGZdThE0pB4u083IkCi5gKrKOPj6solOI6GOOfScPkYNQJ6htJSp0UOltXtHW16FWD8BZwfom/Q5kPozv4IJQpV3eP/RzWdeC9l1zbKcAKkIiLXw9AkqyqydinT6OTWnCmcTKRiATeRDBtoSEZbIuax/dHr16ukpacmc1bUkA/stRv5jny8YCvmjx8d6o9jA8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcn7mfGw3lN7bYoFTLCnXZ3cNblsfFvvKGcePa7Cbhg=;
 b=wzp1UfU28Ajva4Kmge9iHzz3oBrLZzxiXj/si9zNjKgLePUfhevl7wvlDGXx9QuJIuwaUYivJPNn5m+Dx18fRhwxajObvinWsAOV9nTJKds5UjvXSPGMaTBj21PCeg+/tLqOPebVVV0Ossl5qlDSvAJDcqaqmrYcISZyU69bpe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:33:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:33:42 +0000
Message-ID: <63537951-2c16-4ce0-ab8a-067315833bac@amd.com>
Date: Mon, 29 Jun 2026 14:33:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <20260625135341.1159-1-alhouseenyousef@gmail.com>
 <CAMuQ4bWVb-vxCWMxF_JpJmBnKD=rVH2KZWf36jnzPbC35CdrmA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAMuQ4bWVb-vxCWMxF_JpJmBnKD=rVH2KZWf36jnzPbC35CdrmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:408:143::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: b889c708-521e-4d9d-25b6-08ded5daa79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B9zhc283HKD+M7z/+bWF96A8NEk8nQ9FX6sJziNAXeg+N3MPTxv5wKCL+LPF0RXK5CqDTDfpFyhZke7K4QCoXR7FA4NW+On8N+RNh6dRya6Sea1GirI3+oKri6Ra/7sYQ6GTR3TkV4CVDVlYaeFoNO5GWC5JNX9WvLYSDpY+Y4lt60YxdmpKqmQxtOvujNH7AjZK/TNkQkRxun1E4j3Qs7/QaNj9cyi4zFP4ZKamultBSDDpKiM8ML5aIzMrMOlTpJf47YrFU2TvF0MyIidpuRlJy6EkoPKv+lL0kRa5WXtrBkbQViQ6Zos4W5NiIZ2Jvx1RYS0KZD8M3wpP87LP/kRtcvyvw8ohBADy0WA/g/34UVkXX9b7GBKWcJyo8Ve2fNGTvBhglWXNNaszf8/EA8LXxiGGADq7kqru2iZ6mYGkq4/17PPo3ePRFqJeYzOvQ95zTT407TqAFlko7jtyVzFnto4qhfgLNjWZrhF1QdonmVjHbvlh4MQdfpD94CwAY4k7eZlDb4X2c4kUq5W1BFb+hGFNI3UhWdNfRiEj9x3QixD5cLnzqtD9fFLUHxbxCLsROYmsnLAu+x2FU7DGqX54P0s4HhFvWMp7ULDFA5tZKZHq3JDAy6j8QT6hOX/9ORmFbRvV/8e8XdyU5tP4hsV9T2qCHgG530tRgH9v/uY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi95Q25kRUtIMzVOaGk5V1NLOTE2aS9yNnhoY0lrZHY2NUVaQW9OUUQ1TThv?=
 =?utf-8?B?dXVzaGd2VjQ5ZG9PWE9SNytZMkF6YUdZRHBpNVFtblhwdXFieFhYSkZ6akh4?=
 =?utf-8?B?TklVLzJnQ3EyS2o5NE5BMi9obytKOHhHZVRnWnFVQUxXZEtibUVtNEJ1dzFJ?=
 =?utf-8?B?dGM5OWJtL3BIaEJOM2V4VVJCUXFRYU1xVXlXZ1F5cFNPMWRJOFQrTzlVWkI0?=
 =?utf-8?B?UmVBQTdJamtGNWJnb2FvcnM4RWN0VjFZc0MyQ1Rla0lnVnEvZDBRY1JidDdh?=
 =?utf-8?B?bXUwZ1JFSGNPYXBQUFA0TVM2RzhLc1ZIOVdpS0tuUzJDM2FhRlE1bnBRaHk5?=
 =?utf-8?B?Rm9ZOUR4MTBWWFhiZUhZZmE1V29RZldsdWFxWXdmSlVBSy9FbkFkVWh6b0xp?=
 =?utf-8?B?ZmNkZXBjdGl2ZlIvK2k3a1lyOTFlZm9lNk8wMHVsZndySUYwcVN5eHJOa3F3?=
 =?utf-8?B?NXpjcEtjTXR5dk5oanRvVjVmR0lqQzVZczl1aHNjWDVWM3hzOTQrZFlvc3JT?=
 =?utf-8?B?aGRDb1FXYzM1T3lDQlFKaEl6OEZKYUVKR0lCN2pvZG95YlZ3RGVzNTdyUEww?=
 =?utf-8?B?MmhxWHNKaW9wUDk4RHp2akkvT3NONnJRc09tbHkzTFFnd2ZWTGx3VWdlNG5x?=
 =?utf-8?B?bFU0WUk3NkVFNTZDU3NQbzA5KzBhSEtIczlib2pmVHIvbVZlQjBiekttb1JV?=
 =?utf-8?B?aWROaEdSUks2TzlGd0lZbHNLd0hJL1VVRUt0a1Y5a0h4SkFtZ241REVvZ1ZP?=
 =?utf-8?B?ZUlGQ2lxUUNEcno0YThZY2tTdjZqOUpRbGRPeVNhNFlEME1va0NzLzFyUFVB?=
 =?utf-8?B?Q2NTaE9Sc2JoZzlldFR5R3lDYy8rRWZsNnF6L04xc0hoRUU1VXJ4dlp1azgv?=
 =?utf-8?B?aFJRaEdUTWZoWGJBdHBmM0JOb1AwQm5OYTNiS3V2WU4xOGRXVnd0L3VSMDNz?=
 =?utf-8?B?UEV3andXc2FRdWNWVHg4dkVUdjh6dUI0Vm16S3V2M3VjWlV2bllIQ2d5QlVV?=
 =?utf-8?B?UEpNZWFTcW1VWlg0QmhicHBjNmtCMjQxdnI2ellmUHFEd2RZZ3hZWkVYNWZ6?=
 =?utf-8?B?b29JNUptSWxoM0JPWEptN2JMb0I1RGpSSWxYZXh2dTlUZlNNV3hwejVSbXhI?=
 =?utf-8?B?aUVoK3VVRWxKL044Sk0rK2hUSUxZVnhWclF4QVdUL0c4K0RMaEtZUVdJMFMw?=
 =?utf-8?B?dFUwM3pPOU5FNE16YVYvU2Q0MEVwT1gyWFd2dDh0ekNsdE43SWxHVGlzTTNX?=
 =?utf-8?B?bXRMbVdSUjZRUzhycEJIR3IwbDZrTk8zMTZDd1NFUUtCcmNPRXpoamwyZFJt?=
 =?utf-8?B?cndOWTNEOUNocW55TnJxVWQzczU4blRJNzhyTEhtSjdKM2E0YllRZ3pFcWVJ?=
 =?utf-8?B?WkJLR1lWR0FOYllqNHJ2NjVzVnVIL2xPM1NwTnpaQjBhYkVyUHJIS2dBRmw2?=
 =?utf-8?B?TkhhTVZwT2V1V0hVMDlxOGpXcnBKT3NKVk8zMFZIa3JjQmt5OWNJWFJlUzRs?=
 =?utf-8?B?WlVyaWVzSE5pU3RzWUF0Z0NXL3kwSDc4WHdyQUZWL1VCOVF4djRFaUJPT0xr?=
 =?utf-8?B?TzJua1F2UXBTVTRtOVlCamdlQUJUNkxwVytmMVBKaSt2aGtxOUpLR0NKMkg3?=
 =?utf-8?B?d2VwQklvYTdyNzNTNGl1SHBQNExtV1dPVVJGaWxXUFJsdlBLN0VOeTBTOXJU?=
 =?utf-8?B?Sm1odlZqSVVFZUhYK2xTT0YvOHVyM1dCWjRQaHdrU1FUMkx3dDAyVExjajNi?=
 =?utf-8?B?TytWTzZ3dFJtaWJEdnRjWFFIMnk2WngwMVdnTlpId2c1dHFaaG0wdUJTMGNL?=
 =?utf-8?B?OG52a0Q2NEJHd1Jwem1HMTRVZVIvOGtJZmkxM3NjdjlPUmUvRmRVQmlIbUI3?=
 =?utf-8?B?UFl0M3BxaEY2b3I5VktmeGFEMyt6R1R3ejdVUnZoRy9yWWRQRlZaK2JZbjIy?=
 =?utf-8?B?SlZvZE44ZDYzQmxjKzVuK0VnVHdPTVlFYzhlSTdtUVYxR3UyR05uaURKc0xY?=
 =?utf-8?B?NXg4WGpNZ2VvNUg2bDRmRWRNd3E4cVZYMEFqVTFFVGZSUjA5dlZZTnpCNlNl?=
 =?utf-8?B?VnRwZ1NlbUFSYU9WbC82QnVLQ0VaV1k0UTZ3aUFZZ3JmS3oyL0ViZnIzVGxy?=
 =?utf-8?B?QjBzeHRIeFRuV0dHaDVWcjEvQjlYbEx0OTcwL2l5eDNvcUZuNFMyU3FZU2dq?=
 =?utf-8?B?QjNmWUFkZGJrOHRyYUZ0THhxdVV2K2EvRGh1RFQ0Z0lnQUc3dENYUHBoSDJx?=
 =?utf-8?B?L2s2c1N2L3RaTlJaOW4xdWQ5QmxLYTJKamFQT3ZkUXJjMGlFVTVhWWY2dGFY?=
 =?utf-8?Q?C18ScE1hvTHuw80Eur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b889c708-521e-4d9d-25b6-08ded5daa79d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:33:42.6446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IvvT0vzPL3FH2/hXI08SUHfKM6AV7RYGWFZ8TaXchvG3kkzGThz95uhsR3q5qFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
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

On 6/25/26 16:26, Yousef Alhouseen wrote:
> Hi Alex, Christian,
> 
> Please drop this v2 as well.
> 
> I rechecked the target tree and missed the existing !bo_va check in
> AMDGPU_GEM_OP_GET_MAPPING_INFO.

Am I blind? As far as I can see at least the code in drm-misc-next doesn't have such a check.

Regards,
Christian.


> The close-race case is already handled
> before the mapping list walks, so this patch only makes the later check
> unreachable and changes the errno.
> 
> Sorry for the churn.
> 
> Thanks,
> Yousef
> 
> On Thu, 25 Jun 2026 15:53:41 +0200, Yousef Alhouseen
> <alhouseenyousef@gmail.com> wrote:
>> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object from the file
>> handle and then locks the object and VM before resolving the BO-VA. The
>> GEM object reference keeps the BO alive, but it does not keep the
>> per-file handle open.
>>
>> If a racing close drops the last handle reference in that window,
>> amdgpu_gem_object_close() can remove the BO-VA before
>> amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
>> unconditionally.
>>
>> Return -EINVAL if the BO is no longer associated with this VM.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>> ---
>> Changes in v2:
>> - Describe the handle-close race instead of an initially unmapped BO.
>> - Return -EINVAL instead of -ENOENT.
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 212c14d99..6f5b6f4c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>> struct drm_amdgpu_gem_vm_entry *vm_entries;
>> struct amdgpu_bo_va_mapping *mapping;
>> int num_mappings = 0;
>> +
>> + if (!bo_va) {
>> + r = -EINVAL;
>> + goto out_exec;
>> + }
>> +
>> /*
>> * num_entries is set as an input to the size of the user-allocated array of
>> * drm_amdgpu_gem_vm_entry stored at args->value.
>> --
>> 2.54.0

