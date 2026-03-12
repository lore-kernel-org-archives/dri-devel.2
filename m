Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1053106ACE4
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EC810EA8D;
	Thu, 12 Mar 2026 20:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wib3a9qC";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F35610E2BD;
 Thu, 12 Mar 2026 20:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AojHAProD7B00FIl2GT0495S5oSiU5dx7uIjeUQ0ZMMDTvdKGczl/p9Sj8fNujrEOYp/LFdyI1X2/wb3HoPez+IrRcHaaEk/Xe3B9nyUJ2vThk55XW+xslSwUMVqLApr7V8f5YbpOWqEXJdeNMm5V9Ki0N6Q+gddzUxWO6sESOYBgZQR+GyY8Vtpayo+LA02k0O4YFm64D0817g1Y0SmgnW68yitWquisDzDqgBSJ0v1KBFdvTRiF8k4dGa8shy01PfvMLt2Bk/7n63d0Ud8RgL08XfrreZh1/KdieA8fEc3LhxwntEk3b0OqHrQ1Ks8B0aRC9MpYYc+NrvPi4onzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LFWaTWjB5PfBa/vbLvQUNEQPuXDCiSbqNSd8pvbFJY=;
 b=RZZ2X5wt9qSiGmYuhjkkNrGtB5D9azSWrNdty+D8UjeMzZZmGI78NR3G9sV5wMJ4NwoD1RTyyoKYp6mJ3a9T+IEZLXwyB+7lnX2wojxSj14cauSShVK/jAHSma1p5lEkHN9PCMwkB+Mq6Rz706ceQsllwSNkFAx1Za4eOqTUHsj+C4jSft7USzBeAn4a60Gm4nM8P/OljRqKT7rYLpV8JeFhcUeuMbX1RsnrYqKh2xwN79gdZMPNv7adhi9wnWDr/Ua6v9h6WuGND19iZRJVPImTvkppgpNxLP0zCE9DfKP5sv7RElSAp40o+8SGkSjN5g8rnY0Xq12diKWtOtU+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LFWaTWjB5PfBa/vbLvQUNEQPuXDCiSbqNSd8pvbFJY=;
 b=Wib3a9qCNnhdfLPZCTN9Z6sITmaGs3Okq49V1WvNx3Pz22JneM1fSTEGkkIwmzmjegNWk19tBoFAqKCWnG+bijZ0yAdoaNjJ8MBOXDvODKq+TzflaqsUmmdE3hgDTS7bAS37CiFbHDesuKbxnFYEqR2lt8oYy0QYSmlOt2uRKCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:31:23 +0000
Received: from BN9PR12MB5130.namprd12.prod.outlook.com
 ([fe80::e7a:4396:5bcb:2b5a]) by BN9PR12MB5130.namprd12.prod.outlook.com
 ([fe80::e7a:4396:5bcb:2b5a%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 20:31:22 +0000
Message-ID: <e52de864-d6f3-4124-8d4f-3180bfbbbc05@amd.com>
Date: Thu, 12 Mar 2026 16:31:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix uninitialized variable use which
 breaks full LTO
To: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Charlene Liu <charlene.liu@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>,
 Alex Hung <alex.hung@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Christian Koenig <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, llvm@lists.linux.dev
References: <ef7266eb7802ce6d68ebd9356477e9671f0c94e0.1773116305.git.calvin@wbinvd.org>
 <abL0PlD1FDnfrX4o@mozart.vkv.me>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <abL0PlD1FDnfrX4o@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::26) To BN9PR12MB5130.namprd12.prod.outlook.com
 (2603:10b6:408:137::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9501644e-4558-4bf7-3257-08de8076535a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zGPN1XSJiUq5OMwcySt+AvMknlpdiYgLfR/Nsj1rNpWgEM44Ca3iMWC3eM7At1mv6LHqqUfmpUdXPc5pbxG5Dvu5wGl1o5TNoB9x4yv1VYShVvjiLWyzqsHIKGFLZ+L9N3uXypS+t9tURnceRQ7gSQl/JGla7zKFit2aMRyp5NhARjwbaVoflzRHvO5lQ6kmHqS844roUOACtcDfb7aYph8cnmVVoZ14VOkPQ29rUpY0/EruaW+lfpXwEv3hAiHRveKqc4tVPKYforlZffz0MdzGHPM/aLgc8tFMUm3XJKsUAR1s78jk2ih7udXMyagcBsuhygj/V9s4vByCEJ3it5FxacnA1sVK7wEYd9ofI9M30y4CxD07sH8lqD3hAG/7BK97aVhiiiPG+6fW6tSPQZYSOIu86fTxyrEwz3wcPr/7kr0/MvoaxH8n2gWTtB68w4unPg0KDWBkMOfyRlxNwpTx9V8lvzrjuSTvFaa5AH+wjsU/6NiYzIWBCAnARohmvdTtTAM4UAe77M3AFMmSxQbWPXfblCl1ATiJzMWZGl1IO6VA8Pd0NN8iOYSlJcMVhahXzr1pMc95Zh8NWVGouIybj/p0koIRhggqPoyxlK8MZeIgTqogpfL79os42xlhd7Q5bR69IbMOVjlDE4dD+AQ7wciNkJmg3RANgMR1okwzDYfAnaWxJ7JmGex0calki85Na8J1ihvd1D7QDoHO2Xb1er6dDSUYhZKEiJk57X4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5130.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnd3NkFCaVVvbW1vOGpVYTR4RGNLSEgxdmswdWhONkYvTXdVSHBGYnN2bmx3?=
 =?utf-8?B?Y1NsVncybVVuUGtFQlVVK1huK2kzWFUrTGVZb1N6QkZ2RTVGUU1uQ1piTTNR?=
 =?utf-8?B?bEdPZjBWa0NZT2UyNEtYQmhEVFZxcFVoT012OHJrVGxONlJ6N0UxN1h2dUxr?=
 =?utf-8?B?Q2lwV2krSFhCTGdERU55TFBPalRYTFUzbzhpSll5VEpqQ2l0N2FwVFhYMlND?=
 =?utf-8?B?a1hQRGNJZitoM3F1STF1K2xWNHN1QUhhK214aU1yZkhsQWhBODdua2dTMXVl?=
 =?utf-8?B?SGlhd0ZWVDhJc1hHdFlmSE05QlJGQmVRcTk2RXNlbXNiZzh5d3gyVStxRG5x?=
 =?utf-8?B?alBiQ1BaS1JNbnJHaHd5VHZjYTg3QXJBQXJTbmgxbnFGUU1SalJTMWxlNUdT?=
 =?utf-8?B?YldrNDZWWjRyWW5kOXpYOGNoWnFFS3IvQzlhZFlwMU1hcmtWM3dQem9ZYkpT?=
 =?utf-8?B?dVYwbk83akNRc01ub2puQmtkbWVBVmx2K3FNTjRXd1RMSXl5OVhNOFJvUEk2?=
 =?utf-8?B?RWM3UDRvR2EwWC9hZm96elJXUy8rTXk4L0ExVUdPRS9TSXpWTDl4OUtsUEwx?=
 =?utf-8?B?Vkt5RE5HTVlyNjdJVm9hR0dmMWl3MDZjLzM3c3FzMlBITmNHeEVHYWpPOEk3?=
 =?utf-8?B?Q1liVGNNZDVaQmpVMUF2bUR6RnMzUCtqaGQ5K0hla0ZGZVp0TXpJTndIMTJ1?=
 =?utf-8?B?b0MxcURwcTNGR3Q5YXBlYTd5ZHo4MlNDb1dTMFU4cmtwNklQZXowYnlteXFW?=
 =?utf-8?B?d3FrMUkweGZENnY1YXlJL05vcFVhV1lyRy82WXJ3dmtFcS9WS3lycUdIMHFQ?=
 =?utf-8?B?MkUrRGxSU3ZpbDB2WkFqVmVmQUw0UGlhTVlBNm5tWDFGNjhzV0tRL3FiT3do?=
 =?utf-8?B?L0dlZnlSR0luWkxDU3F6b1VnRUVFaVJ2YzhsQmM0WXZmWGhPeTUyeU50Qm1s?=
 =?utf-8?B?TDZzcVNZYmVLRkNMWnlUSHZXOWwxQWJrcFU2U1FHQ1JwckxQcWdzQTk3YURS?=
 =?utf-8?B?c01GV0ROOFNHak1JdmUrS2xrMjNOVFkyQVg5Nk5kRzVOR0ozeHk4OTFZbmIv?=
 =?utf-8?B?ekJLeXBFeEVpcDRybzJ5Z2k5dXltb01YR2JjRXFxWGl1LysvWkxyT1JEclFa?=
 =?utf-8?B?SUZKWXlYRzVNNXpRM3duVDVFWHAwYktka3RyaFo3RFpaVGh0b1dLcHEzRHdz?=
 =?utf-8?B?ZFhhSUwvVk83SG81VFp1NlpiTXBIQ2phdFlycnFVQzBiM1lUSURmak51UENa?=
 =?utf-8?B?emFsOTBqSy9HdThnUXNvb1JSWWRxeWVEcW9CdjEwdHlqcU4zaXlUZm5uVm4z?=
 =?utf-8?B?NkFEU2lzMmZuUTcxNjN5L3BhVEtUSmVPSlg0T3FsQStuZTl1WGtCTFVlSTBr?=
 =?utf-8?B?cmFsQWJ6aDlQWkJzK3dwUkhIUXJrNTZablVRWDlJcGhiZHdPb1VTVWV1NjQx?=
 =?utf-8?B?MVBPSURTWUxVVVJwWW01Y1MwZjJJLzl0S1N4STZXN1NNbW1GUVR4SzIreFpq?=
 =?utf-8?B?dzVZYTBjQ21jMFlyUndlcTB2SkFXc3JETFdnTytoOWxPTGg5bGJWTEhCUzFV?=
 =?utf-8?B?aDlPR0tka2UxemhDb3BBVWI4dEY5WjllYWhNWUlINk53cFdNejZFc3hQd1Rr?=
 =?utf-8?B?Unk3VUFmSEQ3R3Z2UnhRQWlwUGtpb1Voa1NVZlRCM0hJVEVGcmdiY29NWEpJ?=
 =?utf-8?B?UjF5aG9SVnozSy93UnVGeU1Tczdxa0dHNEtTdVhQUFJIOFBuUDFZcjI5dWtt?=
 =?utf-8?B?RUgrNDR3M1l6eFUvd3h5aWhHZmFNUEpnbmdKby8rTDM3VkFBM1pkTEtVYVl0?=
 =?utf-8?B?S2lYR1BYYmJKUzQrM0FaanBjU2JnYjNkWUtlUTVVU0p3RnJkYVg4MDJSZ0lj?=
 =?utf-8?B?WWlYVkxBelJiRW5uZE9GVDJHckdxRmlzUDhsYk5Dc3NNTjVFZDY4YWFVM3Ur?=
 =?utf-8?B?TDVnTnczQ05oRzYyT3hRSFBuV2Z3YjBtUCtoLzEyYkpMbjB1cFN0S1QyN3NT?=
 =?utf-8?B?aVhyS2FlM3o0b054RXNjemhCT3UrWU9SWlowVzg3NE5zVjJ4Y0I5d0JKVlQ0?=
 =?utf-8?B?aU9BTVVTaC9mV0I0UGg2MzhtZ3ZYUnNvRmZ0eStHUTA0Q2t5SS9GTXRmT0sx?=
 =?utf-8?B?anBkQ0pvdUxpeEhvdUt0UTRhN1Fma3NVbFdjQjc3KzZ2MlZZb3phYk9Nd2Zy?=
 =?utf-8?B?dGVuWXdTbjM0WjVucXl5NTZXOXBTM1JBdm5vcGcyTjYrKzRuTnVKc3RncWtz?=
 =?utf-8?B?T1ZBc3NsRHZqMEM2eldUYkttRWtrWjZsRHQ0ajFac1VTaUtQNmR1aXNiQjRZ?=
 =?utf-8?B?UmxWU1BDRm4vdEJNNlduYUltZysvR3NlZTVLV0QwZHhYdGtSZC9WZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9501644e-4558-4bf7-3257-08de8076535a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:31:22.8264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10m2Dr8z+Cz42LkJpM69gPDIXB6fW9/StiyPrDzSj1zMvBFHbUIah7plnGbaca0V0ruaJ1Pk4RYg5lj6zfIPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
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



On 2026-03-12 13:13, Calvin Owens wrote:
> Commit e1b385726f7f ("drm/amd/display: Add additional checks for PSP
> footer size") introduced a use of an uninitialized stack variable
> in dm_dmub_sw_init() (region_params.bss_data_size).
> 
> Interestingly, this seems to cause no issue on normal kernels. But when
> full LTO is enabled, it causes the compiler to "optimize" out huge
> swaths of amdgpu initialization code, and the driver is unusable:
> 
>     amdgpu 0000:03:00.0: [drm] Loading DMUB firmware via PSP: version=0x07002F00
>     amdgpu 0000:03:00.0: sw_init of IP block <dm> failed 5
>     amdgpu 0000:03:00.0: amdgpu_device_ip_init failed
>     amdgpu 0000:03:00.0: Fatal error during GPU init
> 
> It surprises me that neither gcc nor clang emit a warning about this: I
> only found it by bisecting the LTO breakage.
> 
> Fix by using the bss_data_size field from fw_meta_info_params, as was
> presumably intended.
> 
> Fixes: e1b385726f7f ("drm/amd/display: Add additional checks for PSP footer size")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> Changes in v2:
> * Use fw_meta_info_params.bss_data_size instead of repeating the load
>   from the payload header field [Nathan]
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3d6f2cd8ab6..0d1c772ef713 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2553,9 +2553,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>  	fw_meta_info_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
>  	fw_meta_info_params.fw_inst_const = adev->dm.dmub_fw->data +
>  					    le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
>  					    PSP_HEADER_BYTES_256;
> -	fw_meta_info_params.fw_bss_data = region_params.bss_data_size ? adev->dm.dmub_fw->data +
> +	fw_meta_info_params.fw_bss_data = fw_meta_info_params.bss_data_size ? adev->dm.dmub_fw->data +
>  					  le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
>  					  le32_to_cpu(hdr->inst_const_bytes) : NULL;
>  	fw_meta_info_params.custom_psp_footer_size = 0;
>  

