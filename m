Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15188CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B2310F3DE;
	Fri,  8 May 2026 08:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQMNGGad";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C3D10F3DE;
 Fri,  8 May 2026 08:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYwOpe3sAFGL3v2gHQ8yIQequfeoyx5YA3nu5nZ77IUgw/qv6viDXQd+ZyJcrXZWYSXUdZl8Ji+g7uv+rgACmDcPA2il0ozHbebDP0VaAyz+o9mulm691lf+U+1ZbWHIULizCHIJc32Zizk7npVzdCB2aFOoCh96aoNAxNX8yZSWOZJsZhAtjtsMnGAVnKbEEEqnOiZwXNuCjZ4X2q79dw8W9FUVIxqhCIXFXSA88YCFTAIcbdb0ZYUPJQEkOBacfy6Xrc/aJt+GPQoP/ZEOH7sfsPh5l1pZw9EI7DvZ761v3EBrIoT4XwZk8/ZRMn3ApZC9epdy7X4F9ZFMRL78hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/UDwidXjwOhNN3ywh/iHiYHh+OQMutAJhw0P5Me7Qw=;
 b=Wmp9jABQM4laF66CmspwT4EO7x28MlRdJ6swDbJbVEdd6EbKj/TgEPcPxcf+4j+fxHRMWDH2n0uWZ2dRixX2fHzAj4GxMpXTuktxuScuWQokE9r291P4IzjpPtzEcdchiBBhIiC4uf9KWcByLFjX2XLW6/09gpaAK+viaTnG4kCPzKvtq1I8/mU95fav/JF87xCB3XD2UJYOzUtf7W88uZNlv9MT7+2zt5gHvc7uTS3aIxXfArDblXJClZZbmuABANpZs63dvX/L7b0mt0kA2AIVl799CaKtu9ht0rEMZqu58BNXV8nzSC1AGfStIoRfdrnUFPx5Sj6leiL1Jumtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/UDwidXjwOhNN3ywh/iHiYHh+OQMutAJhw0P5Me7Qw=;
 b=AQMNGGadATaC/9DURt/40p1KXnCRvOSHmbve9ocRPbWk/FtGBsKLEpwHnCAlgCQqJM2fTTVHkzCCRdEpDfw0IaF8qDGXl2gDaKgs0IeyM/lnq04FYnHRAQqLS42dUSIo70keIb+IrlAb0nySIezrMHW+sb+oIK5uZdZj+NCjfEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 08:43:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 08:43:54 +0000
Message-ID: <dcc966e0-da1d-4589-ad04-02aeb1a8e06f@amd.com>
Date: Fri, 8 May 2026 10:43:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/amd/pm: Use guard(mutex) instead of manual
 lock+unlock
To: Andre Hirata <andrejhirata@usp.br>, kenneth.feng@amd.com,
 alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Gabriel Dimant <gabriel.dimant@usp.br>,
 Guilherme Gabriel <guilhermesangabriel@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260508024744.6523-1-andrejhirata@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508024744.6523-1-andrejhirata@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3c46b5-f8e0-40d3-5ea2-08deacddef6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: FfvuwFh72XWw/m23grNXyH1r7Y8bDLY11IxASTeY6HyWb9NtQy/4QPZzKh53xw0EsX5y6hfKOHVM8MZyvzziQA3Hnb2JSLVVLumXB45P/AR5nm/zU4wq2Py5yfs0raPLQrLi9r4kSfXZ0oe/JevryaCnsceih40y1iALue+G+UWoOOPYh3T9UmAFQ9gWMiqPuDrlG881T0rQV+BB2YhMm+KWqbmQ3Y65k6japEDerRtKv1x27UMnDe9Wv1IRApZUGoEU9SCIN3cfGsmaQMvwkUgKqD2QFjYNFaGxk/KJmA0MDQCiMqLzXOfpwHxDfNdBZQwU8BhzOVaotzkdZgGb1+QBM8u3oguBFgGUEeZOOpd35ioLne4qOl4nIGRV6BLdPophoPkC3ovNstUIGOVTv/eec/UnnwV23C5nww26D9s0CkixQxuSNHtZYo0O1ldxusuKNQgT8//RgyxhUbuWUiKA/RuJTQcVjimdkze4WfZJyr2c9bwkSwPdy7AH9N9wboBGrk5qzs27T361LwZsZkG1cASQk3ovKvbJ7Dpskr84lc0u9FgG27o5QvH55Szv1jguQ5yt6yJLmTqJtGNURawNsp7g0EGahoFU4dZ4PtcUamfbpPrw/HkxaQSLL/FqJ38j4Ao/XSOYcvPSwOfyOPXW/CEgQF1+sDUKxNXcidnM2W1DqiEFBa5W5PWuqtA5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhrREhZNlVLNWVzTVMrUWZuQnlEQXNNSXllTUJQazZoLzZHMUdwT2xsSnBZ?=
 =?utf-8?B?Mi9rMlVGRUJqYnVhejhGOEhvUDUrRVF4S0s4Ny9vRzNQeTU1QVdSSlRqMTVI?=
 =?utf-8?B?aUh1OW03cnBRMUh4SGVYZzM4UG9RN21hajVOQU1IeTRxcVUzUzBPRkF3VitD?=
 =?utf-8?B?K3c5ekVabWVCeStNMEpWaXJ0WnNQMXNwQUtzd1Z0MFZJdTg5SSs5MXFDSVdV?=
 =?utf-8?B?all1aWxZckN3N1YwUjNrbHU1WXVjdzEzUW83LzVRd1BmVmR1R205RzNnUUFo?=
 =?utf-8?B?MTVCNUFRK3BDY2xzNllWYmhyMlpVUDRUUjF6aEh1Tjd0RGdJNDVwQmYzeU9k?=
 =?utf-8?B?QTVVcnVyT2JNamFteUFUSHhPTVhkQzFpVHNtekZGYUk2dUhmWmZpVWRSQVRH?=
 =?utf-8?B?TWxrTDFYZ1NBQW1MSTd5bk1UdzV4eG5NQ2Z6NjdObHFlQnJiOUxaM1dhS2lI?=
 =?utf-8?B?aWIzeVo4b1dmZ21MRE1ES2tTbXBaK2o3Q3hLc2pRTFh2dnFpZkhoUGFNL2JQ?=
 =?utf-8?B?NTQ0SHhBakdndHcyRGdsYzlkMXJ5UDkvMXRodTlvSVJxTGI5Z3pWdTg2OU9j?=
 =?utf-8?B?YTBSckRvT0hYSDFXckQ2bmtRbTBnazJlVGxYbXpTMEN2MVZ0OWRCU0R5OEh2?=
 =?utf-8?B?NXFtaEdPOHArUGs3WmNrTTBvRzMxWFM3K0tQNmVvTDNyU01TUzRjMkZFUmVO?=
 =?utf-8?B?QnUwNkh6NHYyaVRhMkF3c3NCVkY5VHhDaTljQVBPTEEzM2dGVlk2Ymw5UDlr?=
 =?utf-8?B?UUo2Q1NTT0FlNUlWUzI2cGNXNkNsWlhjWjlsK25lU2VrSEQybkt4R1djc2NK?=
 =?utf-8?B?N2F3M21oemhtRDI1SkN5dzFlNTNpRkVDc1c3VzJNUElRdTR0NEp1RlN0cGhP?=
 =?utf-8?B?WEpkNlFOU1lnODdkZUVLUENIQWNHSWQ2ZE5ZSGNmcnlQNnZPTVlncFVtSFA1?=
 =?utf-8?B?OUhoc0o3elpscUhncnJvODRBYUl6TDRMQ3lqUTM1RXpra1pCbUtpL2ZDbTRp?=
 =?utf-8?B?UjRKRFpvSVNHN3pOQitHZjBtaGpBRmpaODFVaENGeUZWQ3lWU3hZSFB3cXl4?=
 =?utf-8?B?VFJPN3oySmpHVE9IaStHMjJOQ080ajBMYk83QWZ4YmdDdXJoT1dmV2I0VG9l?=
 =?utf-8?B?OFUrQTcyK3d2eDRHTzJ3NTB1dkxodXEvVXFldXp0UzR5VldkQmhXeDFoNk04?=
 =?utf-8?B?Y2FnUW9ZV0d3ZUtpczY5eHFzaVRGUUR6Q1JkeERFdHJMQkFHd3Z3MGlPMmlC?=
 =?utf-8?B?TnE4VTdIRzd5eWhnVUc3WlpwTGl6YWplTlJKWXZmQUlyS2VsT09JejlSNVRm?=
 =?utf-8?B?TUN0VllzSW5oMWYrV09NUnNNNWpWOEs0SUsvZmUzMURMWVBsUnI4dTVJeWxm?=
 =?utf-8?B?Z1BWOFFRb01pRDY0bFpQV280Tm9iNlZ3R0tndmc1T0d1WHREMDREeENyQWVu?=
 =?utf-8?B?M1RZSE10S0FjR2gzak5MNmV6NHFFV1JlTTZyNnFMRnlTSzZYNUxndkw1WVI4?=
 =?utf-8?B?U3pzZy9UenVHa2N6UDJvNjRhMmhHR1Q0djFwTHVJL29ZcjJNMUxZay9wSFJU?=
 =?utf-8?B?RHlJcTREMGNPMm5NeXRkUHVtbFl3RHdUWmNpdlRWTWdPSmU5QjVXVjg4NFlv?=
 =?utf-8?B?cGhlQitEUFlpV0FrNWJDaFZhc0RRTzIxMkFSWGpNZUlPVEpENm5Zc2JqOU9P?=
 =?utf-8?B?VUQ4UUJWN2szdkUxanRMVGlVVHJVSFlPTktGNjVubzV1WllEVDhyUVArYTlr?=
 =?utf-8?B?Ni8rS1hNM0ZTNzY2bWE3SlByZndkR25MU3p0cDJ5UUljbG90ZUVFMlB4NDAy?=
 =?utf-8?B?RzB4N1dsclRLeFI1MjNMNUJpbjJ3dURBci9FTVNrcG1ybU1UalRzSWRqdGtU?=
 =?utf-8?B?NHEwTSttRVN0YnpkTy8xY3c0aGdOVGdXVlp6eHNJdktWb3hkSnhIYjhVb0pn?=
 =?utf-8?B?ekdaTTlvSkhwcWI2MXNYS0lwMUtaN24zdUhOVnhxSG8zb3JmSytBSUdpZXF2?=
 =?utf-8?B?YkJnQURpeEhtVkwyaGtEVjZmR21qMEd6T0dvRFI0SzJUSXpmZjdFcUUxd3pu?=
 =?utf-8?B?YU1BOWhnalpiODBINmpyMG5DcDlQY3ZTSTZ4QjY0NFIwd3ViUS9JeDVvMU9C?=
 =?utf-8?B?TWRQVFBEU1M1bUVYd1pBN0xMbmp2dVNtYkFkUiszbGNRQkR4Y3Nwd05kOTAz?=
 =?utf-8?B?Y1R4ejhUZXNKWGtzMU9FUWtZSFYvbHBHc3dscW0xckVsRTRVTVVwbEpISDNH?=
 =?utf-8?B?dmlWSTBuM1NXTVQ4Z0lBaEFPOE80OTE4NC9DUWY1dmpaVllIdXFzUFJNNDFL?=
 =?utf-8?Q?MnelTlA+OBgVr2huV9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3c46b5-f8e0-40d3-5ea2-08deacddef6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 08:43:53.9793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1szSWjqdn2txFOLsXs3p1invMXsvaz860jAiCSGpAi+MtGsOy1g1H5MworEzlnVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

Just two notes, apart from that looks like a nice cleanup to me.

On 5/8/26 04:47, Andre Hirata wrote:
> @@ -46,10 +47,9 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
>         if (!pp_funcs->get_sclk)
>                 return 0;
> 
> -       mutex_lock(&adev->pm.mutex);
> +       guard(mutex)(&adev->pm.mutex);
>         ret = pp_funcs->get_sclk((adev)->powerplay.pp_handle,
>                                  low);
> -       mutex_unlock(&adev->pm.mutex);
> 
>         return ret;

In a lot of cases you can now turn the patter "ret = f(...); return ret;" into just return f(..); and potentially drop the ret variable.

>  }
> 
> @@ -291,9 +265,8 @@ bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
>         bool support_mode1_reset = false;
> 
>         if (is_support_sw_smu(adev)) {
> -               mutex_lock(&adev->pm.mutex);
> +               guard(mutex)(&adev->pm.mutex);
>                 support_mode1_reset = smu_mode1_reset_is_support(smu);
> -               mutex_unlock(&adev->pm.mutex);
>         }
> 
>         return support_mode1_reset;

For cases like this here the coding pattern to check the pre-requisites and abort early is usually better.

So this example here would become:

if (!is_support_sw_smu(adev))
	return false;

guard(mutex)(&adev->pm.mutex);
return smu_mode1_reset_is_support(smu);

Which as far as I can see is less code and much easier to read/understand.

But both suggestions could be a separate patch if you want to keep this one as it is.

Regards,
Christian.
