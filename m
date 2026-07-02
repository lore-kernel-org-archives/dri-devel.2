Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025FCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5718B10F1EF;
	Thu,  2 Jul 2026 07:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iNGCXSZ7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C8610F1EF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4w195GVhF29mNw9VPOMIlfcMgG/JpwPUz7niJSVARLT5QYsshM1u2MO/hqKLbeOSfVvMj0NY1nKdvPz8W6Rt0sbU2PIRVGcbiciF0uXTYJxc2DLnvv5xwELwT0EBwuop5o8nhN2ymBgVl9a74VCgtAhj9LPvFuLau3rfkaEpCcSXo6OEewUFwApd6PYZ6YDKPHrMA3sYOowyc7b6gsQ2XWOVe7zG0AQVOCjmAWj6ulWoIZrGxXguA3xQ1eyibRI9AapOxSmHuEtLXCXSZraot80mEi1o5BfZZJnraok6AVsarFG+nS4zCAeaZYSflPLtsJa5VZ4zxed3uSh3EpJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcgOfkTJvw45AW2GuVqX2L35+umQ8pNSOU+SJ3strXY=;
 b=VIhp0G9gAUMiFpXPY74z+yGNDuinVHQLZn32xtLS/lg5gRC7ilYj3mWohaAFL7euvsfUo2NRUtpEJiMBUog1c0sa+SJjzy3/R7YVcjrsK1WXSMSvitvcFsWL+see8GlSuXfqo1Gdkd2YhIxsQ5TPCFjszcKEvfWKMxiifD1aVLV9063MT5LOYNEy/G45BA7w4Po+3clw3AS8Mk9wnfX9vYYfNFBAZ9uHD+9YfD9i3hMAMV7J8Jn/Z8VMQo2nXAnpXW1JT/qmGNyY5t6czM7bZp8OcWnqHpym5HPxzSbLlXfOh9j4fLPzufcznEmTXpWtiItDAVhifBdiZh04ubZsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcgOfkTJvw45AW2GuVqX2L35+umQ8pNSOU+SJ3strXY=;
 b=iNGCXSZ7Y9NeS94VwiIWJmC34eYXOivBhGnRGsZyhcGRzjByFXReOs3eXeNau1+Xl+vhuZSn/E7wCxxZypbC6Sj7FyWg3nYAtXsEcR4AOspYm/DPhc0JnmMAE4LniAoH39sZWAOgflBhuRinQ0IGb8A+etIuZSNqOWGtDV8x0e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:56:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:56:10 +0000
Message-ID: <6d7bf1b5-171c-4768-a680-5fb7bfe4f1ec@amd.com>
Date: Thu, 2 Jul 2026 09:56:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/exec: Use kvmalloc_objs for exec->objects
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, robdclark@chromium.org
References: <20260701172458.1416930-1-jonathan.cavitt@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701172458.1416930-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: a62a053a-1800-465f-e8cd-08ded80f613f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KkXxGxtJZagi6B2BhoE3oVuqU+Vz3yAPucbPMCtp+Quycc6bCh8wj3+4HAL9yekUy/0LGxG1v6BJSLf1/y1Hipjv/cTfYIGm5B+o3vkiJS5+xPR/hkiG1MdDTYkCYhZbXjdfHzcsoGKgMbV3EAr+fP5+4GvMdli+BZ/mZtpx01X0YEEY2Hq3+mz664XhDAS1Fjvwd2TdNaMWQK4M/Ptm/2BEBTjWo4zNVmA0EQ/dvORgPDuV3C24USzwlsIAc0+ayI7Oe0GfbSDk6BGifAlSHiiR2jEgQ6Wjgwf9rFrGm6J558PT/Jy/U+TCIvQnuTs44oIpAte54I6kF8CUdqYa5VGy7ZYhnTIOpY/2w8LtD5XeSXbyrbidAgV8/mwqsjIRP8oYSfPhQPbbMnqZaXgGfsdqJ62k/gpwU6KCHAhI4kUdmsIhcXraRE2DCj3ZCxMbDLCGKe+1EjY0eklYlJgmrjPzAOEBFg+rvfUnDlK1TYo3QKTN29jDELuUpWj2GTZLLarEo6eWDxuIenrEpoRaZKktByaOBo6QwvSWeczROnyqO7nfR7dQDyQvY9UfT7GYnLhz7+QH1s5rpqxICNHThjoLA/He6GJt5zFtAmfq8ZeVDDi9UezEL08qtLTJr1XoqslVy9fKEKk+qbLBY8+iY4feqa+C6SI3znbDaRk/DGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUN2ZDUydXFVNU1NUXNxVlJCOURaK2tQNmFjQ2NrL0hHbEswbkd4TDl6NFBo?=
 =?utf-8?B?RWdyR3NZVUoxU0l6M0RZc05tQ3NObGZtU3h3ekZxRTRRS3NkaktsNWpVOG93?=
 =?utf-8?B?d0hkMFBodFc1V0NjM3FNSmRHSTVYTEpEakdNMTFYQ1JtNFhIYUZHb2ErRTNQ?=
 =?utf-8?B?N3BRWFU5ZngyRHpSTzEzdTZ3eVo1dVRsNGpucmJtSW9UWnorb0NGd05sNEdO?=
 =?utf-8?B?R2h2bGYzWXcwSHp5aE9hNWJhcHQ3WkllQ0lIaHBETytIdUNYSFIvQ29OcWZ1?=
 =?utf-8?B?TGR2djBSaS96NVVTaVVBRGZJemdicVgzU2I3WDBoL3ZiZ3FWekFoRXgvcW5l?=
 =?utf-8?B?Q0tFM2NDd3ZVU3htUFV3cFB3T2EzQXUvN2s0RTlkQ3FZZlFWYU03SDFaN2ZT?=
 =?utf-8?B?VGgrZWh3Y1E3RkFKOFFTUVhDOHpQRklGNlZDc1FUdDdvRThGRVhPZEo4Uzg4?=
 =?utf-8?B?cHZMWE0zelRORkJZYlZ6ZmFCNEdiL1YxM0hMZnhuZDI2K0lITTRqWUk0Sm1O?=
 =?utf-8?B?M2owN2V0dHdYQURaVWZ0RFRxUmlzZ0hWTDFndG1BODhmcWZwbDQ2UEVLeXhv?=
 =?utf-8?B?SFl6MktSL2Ixa0hjSlREdFZLaWtEYXVVREF3RzY3Vm1pYlRBMnZnZFo5bUFW?=
 =?utf-8?B?emNraGtoK0JrMk9RaG1BOGk0cEVNVTgyZ216SjduZ0o4VGRadStweENucEFj?=
 =?utf-8?B?NUphUFN0TXlFK2JoNU1POElvTHdKUTZHVlV4bU9PVWo5RXBSOHh6cDVDM3ZI?=
 =?utf-8?B?UE5USThQUENaRUFpZXNRaFRYcnFNUzZjVGRrNzd4TVBCcmpOL3BXdkc5eFQr?=
 =?utf-8?B?T3ViS3VkSXpkTzNKZ1NYMkpIK0tqYUhLZ3JIZElaQ0xWdkZ5QXdjekNGRkFD?=
 =?utf-8?B?cGtIaE1maDErei8xOHVqSmxCYm1lYTdNbHBnMWVNZTEyNFYvWE01MmM4Zm1w?=
 =?utf-8?B?R0F5ODhXVzVMeUlqZnByb29IU2RLUkY5UlVKcUUva0NnR1NpUlJJWjlQdVFV?=
 =?utf-8?B?UlNxT1kwdElGdm5QeW1EZ2xGQWVMQU1LY3pBd2s1RzRSdU1QOW9YL3pPdmpi?=
 =?utf-8?B?cHk2M0dVd3M5cHRQbU1qcnVweEMzQ3VDbW1FVG9TcnM4aFo5WFVLU1R5YUty?=
 =?utf-8?B?T202cXpiaUVJODcrejZhLzlENENSYUFoSWNYYld3cFFGWmZCYTlpOExZTDM1?=
 =?utf-8?B?MTluWkwweG5mdzQzdnhPc2RZTWFWczdVc3I4Z2RGUWNaU3RWKzl0b1pFek4w?=
 =?utf-8?B?U29LeEFNWG9wTEtGUEhqUFBpY0Z4WUFnMklIN3pPUmYySWZqbzRleGpiblVw?=
 =?utf-8?B?Z21na2wwdWFJK3ZxU1lkek9FSHNzWCtnSldrZnZHb2lhaFF6ZjB0dk5ZVGpB?=
 =?utf-8?B?aUJ3d1pxNWN3ZlA1YW14QnVMNTlQMGkydUVnTHE5ajBQdFJyMFhrd1BnR05t?=
 =?utf-8?B?ZEVDcVgrektxaUd5dWt3TS9WKzdmOXBDdDMvTEJkVWRYOGFKRk5jc1k0RHhG?=
 =?utf-8?B?bXQwdUZGLzNkQlVDY1p5MmcxNFEwa1B4aGQyNS9wK2RLNVhtbjF2Qk56UzBO?=
 =?utf-8?B?R0FQNG5IVUk5SllqL3V4L011OFMvdDZ0S1dGQkZZODRzOXFacTRqMTB3KzdD?=
 =?utf-8?B?a2kxRDBaZWphYWtoOUFkZ0RBZ0VpZk51bDdZOXZpMW03b3Aybkp1ajJyQVRz?=
 =?utf-8?B?NnRrbVE3bms2OStUekordnFheTg4RGhJaTMzOTlSK3NMUlpISFdlNDNWQ01y?=
 =?utf-8?B?cEdLOXhFbktnNFpXQnNBcERlcHRFVlZHNlZqR01OZTc4U3ozMnNRQk1GSWpX?=
 =?utf-8?B?UjdvZmhBbmpuQVRUekU4clI2Z0xxK3ZhN1ZkVk82RGZwVXExdHRZaWUyMklz?=
 =?utf-8?B?VWx3ekdMakdEc09IdEYzRkRYd1lpTWZvdzN3NkI2YytpdGlWMkhmTVh1aEgy?=
 =?utf-8?B?a05rK1M2QzdZcExpdzdrVUt6WUFQOWp5Rjg4Y2pESWpiYmJPdDR6VTRWZFpQ?=
 =?utf-8?B?ZGZwdlpxcmJXcjdIL2dKb09zWXFDR2VEOFlYNHh0OStoMzFIZ0hDRkZ2ZmJz?=
 =?utf-8?B?M0kyL2FMRmVBQkt2a2F0d0hHakltZTdNS0pFSzRYY0k4cXFVSDczS2p0YmJU?=
 =?utf-8?B?TThTM0FlQ1A3T3BGM2hieXpOTEZYNzdPMFFNTWNJZUpOQWtyTERyQ1kwVG51?=
 =?utf-8?B?OXdqN3RMby85NjV3ZUVXWE5aWWdXNE1iMDlZNktwODVucHRzeGd3UnhPejZW?=
 =?utf-8?B?VUNZRFRPeDBRNGZrNm1DVURFQlRhYmx4clNCOWxtS1VORFhaaVVRcDRVeGFN?=
 =?utf-8?Q?TfhuYIqE5A5N51MoBA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62a053a-1800-465f-e8cd-08ded80f613f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:56:10.4517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS9Z8NgmfRbtjMA/v+6O0YNeqmtm2mIRmtC7FplSdK3X7A7eTbuOd1subbb8CGDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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

On 7/1/26 19:24, Jonathan Cavitt wrote:
> Use kvmalloc_objs instead of kvmalloc_array when initializing
> exec->objects in drm_exec_init.
> 
> Concern caught by static analysis.
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/drm_exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index 7988f5e7d56a..fa923852fae4 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -79,7 +79,7 @@ void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr)
>  		nr = PAGE_SIZE / sizeof(void *);
>  
>  	exec->flags = flags;
> -	exec->objects = kvmalloc_array(nr, sizeof(void *), GFP_KERNEL);
> +	exec->objects = kvmalloc_objs(*exec->objects, nr, GFP_KERNEL);
>  
>  	/* If allocation here fails, just delay that till the first use */
>  	exec->max_objects = exec->objects ? nr : 0;

