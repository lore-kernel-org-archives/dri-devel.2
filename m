Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44928CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BDB11AA3A;
	Fri,  5 Jun 2026 18:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0krijzzG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E1611AA39;
 Fri,  5 Jun 2026 18:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2DiFZllZjNQPf58TbzhEFA6DWtcTJZgjDf6lOrzCmNiFcc0eUL2VA1ZFczGw2+pwQ4A7Rx/1QCr1HWJ45L6taSj8cn18UmB4GizMfnrkl1W53zVaU1LYXhVKLc/UuFCr43G7sgGnqwyKrXH3Qda24goP7POl7hIA91a3+Y6Tj8ySup1zLL/fA5Bmsf4ZnbodA9am2I1gY83H7fcCNs1Grmo066u8KnUTvkDKc3K1qvAcl354WmnAGUOQvDYQy85sPdkYXjGtCIbTKAHRnJ0xmaPWBX1frcULsC4lnJMHSVT7N0PeIsb2J3hQIfx/d5Zmil8jN6zZpSge07Axu0xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OT1EmZvy7qvGquTAl9/F/MVPepMzIklWEmjmqHz6uU=;
 b=oEW+LTFRQObMLaV0DiRF+1vVUCuqfJDnpMZGHCfSUZ23aQbyC0/qZAUAqgvEIQSsyF2s1QTAgLsoiDBbLNKUT5CUHsPvamgD26tDscZyqBbobWGxvfR7FpP2kJ1AXNhGSLYcmljJRSwAqt573EJ89TWG79738awDPSIcOmRhxnbRQJ8RtRGs3US6m6pC6zL1FBdvu8603L3lkkTCmnomIKfkwPE+GkQxoTTM1EhC5szv/P7OHxpdtxGz89XBj+nlHiPgdDmwPyvGagOlxm8ZgUUtZsbF+mQzG/mDO9jRqi1KT0n0H0j7ptut/WPQ8/V7AZfevUFz2cHhSyURlg3vNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OT1EmZvy7qvGquTAl9/F/MVPepMzIklWEmjmqHz6uU=;
 b=0krijzzG+ztutYbg/rX5PLZ1Y7K38HYeYW67ixS5PKHwaX8xBsDfsQmcvqLawoTWB1mHZ4uk69BIBtlzVeGOrvGB1mSXVc4VDFiJikaURMqaBqqb7Ym+HbGfFhGLoj/auJjLDa8iYcEmBm+5vajPFekuJvwvEkl6WGvjBcK+3LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:18:07 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:18:06 +0000
Message-ID: <75799329-876b-49e7-a142-629d54b130ab@amd.com>
Date: Fri, 5 Jun 2026 12:18:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Shorten hdmi_frl_status_polling_workqueue
To: Nathan Chancellor <nathan@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c0af4c-dc8e-4b21-f774-08dec32eca37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MW3h726nMPs0ft5l1SFTmQlcMqieTgbHChsLO/T8C98Bp0R3/9bkY3ZAmrVQUia5NoOhCRePla2rSjpHBcURJmb9Tj3nVuZEnxq0e3AKFBjQnQUaL4A3ewRzuHfD8KkAxhSoWzd9FY9pfPbEPALzKO3YaVHk20sCkTd8zroTgBhobk7Pk4W3sUTws+htv/GmoEkNCXarxEJQqv2r9xfwjvikVZxv9kohzw/JJJruwrcX+FMmUBqX95S8IX+BJ0/4vuqgb4nV7e+d99v/wuCNRzX9drBvMObd5j2mqp2M4pHMpvfofgBfRT0x40m0teGMx3m6KifWU/k2kevvuP0Ye5jkN64tpbDP5vQZrGoDYfCX179hjeVzdz9BdUzowvXpVKbM80/SNnWd6vMtuVWVBjTIcxuaUbvKgMcH5xrHbJkZIz9qqAHT0Vlh3E3CuMkfpVtccTHS2aKXm9xRx9p49G6B0HxedLQNA5dSnS5s6k87YhX0qQ0w+1oPmZ4Cm5UfJxPF35aK53e1MBJh/FY/tzk3TMh6vSRkazXfzyWmfcu8J1o/hbJkUcL+Dc+Q1LoxFNGxCfAgnvahH3pX0Pc1e9oALfd3Tg8W3xrv9cruFUgPcRqoIZ711PHMF7DZ0vP5GVZwWQpbF4ZyTCcU4k3ULlmU/NLF6mBTSr9dmickZmvi3+xJOsxcbf+JNcfQGNyW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXQrZGk1OGd6NDBwZkdSd0xCSnI0NWZ4U09ObjZjVFNvemduTnZRTGhDWTdG?=
 =?utf-8?B?Ri94WkVRc2p5RjJoRm1mczlzYVJiNk5UMTYrOXk1ZFlwOUNVN29WU1J5eHZL?=
 =?utf-8?B?S0FoM0JxRkxUMFlXYXJoVEt6b2RLQ1ZrRisyWURwQy9mcUEzQkFWKzNUcTlx?=
 =?utf-8?B?ajRVRHFQNldDbG5mMFNyQnFYZmFFS3Y1TE5uSGpLcHZQVW1OU1d0VjAyR0Q5?=
 =?utf-8?B?aFI0RVJMMmE2ZVFZZ0NXTExPb0F0SWZiMTU5Qldkd1ZEdEMwd1ZESDhFNW9H?=
 =?utf-8?B?NEI2OFJLVnhrdHlkUWYveUVqdlF5NWxLenRlSU4vRWlrMUpralFhblJNaHNq?=
 =?utf-8?B?S0owZjd5WVg5NVZrbktzWFkzNnJVaUYybDFYMWF3YUJYdk9rejNWVEtSOTZz?=
 =?utf-8?B?MDZwaG51eDcwYzhnYkdvbnZ4U0NsVkxNTTRtdE1QUG92NnVaQjdMMmtnYUJn?=
 =?utf-8?B?a1lKNUdQQStDQUNiTVZlWFd1ZjBkYXJxQ3hMRWsvTlQyOVkwUlJwWnBHdmpu?=
 =?utf-8?B?Y25wNzk0dDBDam14aDJnYU8rRG9WK01SQVpxZjl5dEZ3TGVGeXZPaHpJdWk4?=
 =?utf-8?B?WGFIbE45MlN5OTA1Z2xmckJSY0N1RVBpemh2UkZBMyttZjVGdStiZTVoWkxR?=
 =?utf-8?B?dWpEajNFOUhySktvcWdHOWZHNjJOZmErb1NjNWpYVjJKWnhwLzgrdVhNeEdo?=
 =?utf-8?B?NnhHQkdXOWx2VGwrUjU2dmpZc3dpeTI4eHZCU0xsQjV2YjJibDhTU3B5UzY0?=
 =?utf-8?B?SE4xdS9MQzBodEV5VitFOEdIV0xHYzJhOUhkeHpYU25TNDJFRmxBTXg1U0lj?=
 =?utf-8?B?dHZFUXZLT3BpaWgrb1BSQ053bWVEVnB2djQveW04ektwOGFlZDVJcmFoTTJP?=
 =?utf-8?B?TVhDakx5TTJUU1lLbFMwVTZRR1ZwY1pPL3VYdFhtbjFieCs2aWd0U0dldkpq?=
 =?utf-8?B?RlkyZkRwY1dSTjZBMjgzWUNnZkh5ejBqMFdtbkhUM3NnY3B1ZGo0ckxQVGRj?=
 =?utf-8?B?WWFuYU9LL3BEQitwQzZpZEwzYi9iSktqOXpYTWFsQnNZZFZ2ajR1b0pzS2V5?=
 =?utf-8?B?L21DbDlZOXI2UEQyM25zSWdOOUlqQVFSbWVFMmwzTGpvWEo5UUw5UVJueWNN?=
 =?utf-8?B?bWNwQTN1R29oOWZ0OW9yL3FDcmJsVDNqTFBKNmorNXAwTkhURU1aT0xnWW9l?=
 =?utf-8?B?bVBEbVprdTdleDFEcXYrZGVWbWw4N2tVaXZiNkZZcUZRVWtGTnM3ZnJHVzFO?=
 =?utf-8?B?aUs3UFFyOTlkRDhCMTNIa0RtL3ZxMEpJZ0JqeFhZb3FZTURvOGcraVNxMTdO?=
 =?utf-8?B?VWFqWFF2bXlSN0cvSWh0VnVQUHJneElIVmh0cFBZcE4xM0s0UmdKUzVIMlVP?=
 =?utf-8?B?c1BUOCtEMVhyUmQyaHFrQmV3aGFXUzFOTkZMZHFkSlVmSmF6anVXQ2FuSXll?=
 =?utf-8?B?cjJHOGdGaU9DZEdPM0dtbythM1JQWS9RUmw1Q3JXV0dBWVpVZjFDNGdiSGZ5?=
 =?utf-8?B?QnNTNzFFOEYyV0FnNHFkeXl3U09oR2NkRWkyZDVnVVJ1cS9XVGs4QndFcEhD?=
 =?utf-8?B?bTc0ZnZFZ2tGY0ZYRHdQYlA0TE1ZUE5sMlU4TjVZZll6V1pKaVNIZnEyb0hP?=
 =?utf-8?B?SCs3bGZKMDYwaHg3aHF6UlhIekpJLzF5NmcxQVI0L3RBWVlNSEpWWXQxUk80?=
 =?utf-8?B?U3pPZGo2UUd0em1nN3NEOCtscllNSU9rKzFVRXVWK09HTXdwa1ZTS3VFL0tF?=
 =?utf-8?B?anhoS2Rja2hqVTM1MVJCNVFTc3dCVzFNdGVUMENZaUxTaVc3MHFTRDFSMXNk?=
 =?utf-8?B?NFNIby85c1FHcWRTK2pPRVRYK2ZlekdDR29VVHFSQ2prTWlodFA0MkF1ZXYy?=
 =?utf-8?B?Sk94aFkyb0xjTmxlaUU5dHRGKzdQRy9KVHNZck9BSC83OVMzNnFiU3c5SFJ3?=
 =?utf-8?B?YmNCSE4wV1AyUjBWSytvT1E0Zk5PT2NRM1BiWXg1RUtidjNDT2VWMThIZXpH?=
 =?utf-8?B?UGEzSXk4UXJzdnAwZ2ovYk4wOEJyVHk1bjNhSFltWTdyeHB4MlVUb1IwekVr?=
 =?utf-8?B?ZTVwaHRaSlN2cWE0TXV0UzNwL3pmTUlkUWxuUlJ6NWlFc09leS9YVjZLY3VN?=
 =?utf-8?B?bFpvSEtSRXVYZHlkSFlRbU1RbW15ODFtTTRGdjVOR3lMeU9McU9iZnAreGUz?=
 =?utf-8?B?Y2MrV1dWV1VuVkdxZ3M1c3c5dG42S2xCV2Nkb21RRWZ2eG0wSndGN2tiSWRF?=
 =?utf-8?B?SDV4NkY4ZzUvOVBXUWxlaWdZS0NBUVNpVUttSXUyTEhjcGtUaGxCME0wTHNa?=
 =?utf-8?Q?7nFJea/oFvOT6isFrn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c0af4c-dc8e-4b21-f774-08dec32eca37
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:18:06.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y15L2wjymDJEitxnvYAxeP2v6jHiMs4kNpzSUnV+S6tidiGXxXvApSZcdGWfrw5QutHCV7hXcz4tmEoFq8v2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 6/4/26 19:13, Nathan Chancellor wrote:
> There is a warning when creating the hdmi_frl_status_polling_wq
> workqueue because "hdmi_frl_status_polling_workqueue" excceds
> WQ_NAME_LEN:
> 
>    workqueue: name exceeds WQ_NAME_LEN. Truncating to: hdmi_frl_status_polling_workque
> 
> Shorten the workqueue name to "hdmi_frl_status_polling_wq" like the
> structure member to avoid the warning.
> 
> Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1ed697a3a453..f120f75827d9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2262,9 +2262,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	}
>   	if (adev->dm.dc->caps.max_links > 0) {
>   		adev->dm.hdmi_frl_status_polling_wq =
> -			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
> +			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>   		if (!adev->dm.hdmi_frl_status_polling_wq)
> -			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
> +			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_wq\n");
>   		adev->dm.hdmi_frl_status_polling_delay_ms = 200;
>   		INIT_DELAYED_WORK(&adev->dm.hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
>   	}
> 
> ---
> base-commit: 56ae73c92e200e630c2bdf1e98c88b86c8483b37
> change-id: 20260604-amdgpu-fix-wq_name_len-warning-63c8012e0c2b
> 
> Best regards,
> --
> Cheers,
> Nathan
> 

