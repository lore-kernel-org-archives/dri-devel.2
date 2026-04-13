Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE4FF531CE
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE4510E551;
	Mon, 13 Apr 2026 22:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nD1tTmds";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F9F10E551
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1h8LOIG96sWoEwO2iANUbUfOi6O5AYI3lz+kFLLZ68zwLvZyFcddBhWu6Po38wSb35c2QwdqNgWE9NkHV/RNpBZYfJ1x182fBLC0cgViXNC0142t6dPoPN0UuM1g37uC2CMBqmbkT0aJt2veE+eerWBV+FgVOCTXxlO1zr2jMudaO6k7iACdkfMrVeBCwuItYX7NaaBjRYdAF1g1mfTB6X/AdavleSCLZ9Jpl1NqHLQnyhOldYqOkm+IN+UjAn9Qw2hhxb8EQOkLbzYXCgXXUof3hxJwxcAS6R19FDrm0mK145VTzahfglFyr2DDqKqHxF52FdCXIwHbeRxaAKSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k14k9FG/bKWBiz5PeoJkoDXa33umcsVSII8AO6SSBY=;
 b=GOsxvH5LN3sT1SZ/+SAn1PAgjJKjQF53Hkd9afgP8m2s25wdEC3l42BjGWTYgXAAzazkC9kBDxFl63GLGZCIevZKPtsQzemReVG+vrySCiLAPYwlMSlAqZwZCZ2XBJYoTYBshIF0WCfG+R1AwxEPDy9MOB9SUy8DXDc7Ym7Flj+yrA+IvOLwIxx3S933soSu/xBjvb69WstxYWK8pnrNsiUqGL5z7XxKEAPofYkNDEG2NpzREGXpo8AZOeWdKAzYqgwi/3D9sjeNnJl6MwqzXnClPQjX/UjdHQ9IMFq4Wl6Zr1aBlOjotMfOEnO3gPsKmrTyhHH7kmJlzYRZy7okrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k14k9FG/bKWBiz5PeoJkoDXa33umcsVSII8AO6SSBY=;
 b=nD1tTmdsXTg3Ad/92snTDi1h7mhyJmvmFQs3AEPNq2gCghOJc5aVY87fFjxROGwgprDnMd+/9Xcusahy2kwSdk0i0H27Av6p1oWj8JLsX7xapirbvOGZ0BksQL0oNej1AVPv8mPjl5bZWNg4eciaTTGY4iL3tTECeBjGpgXpA8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 22:40:30 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Mon, 13 Apr 2026
 22:40:30 +0000
Message-ID: <963b6bc7-f126-4681-977e-c6e04ec66010@amd.com>
Date: Mon, 13 Apr 2026 17:40:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix order of canceled mailbox messages
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260413181843.670796-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260413181843.670796-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::7) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5560965f-ba61-417b-910f-08de99adaa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: LUGjlqDX79d69K1nHcBdxjvnWcCFRhh6cAnuhc5BFjQ4OPDnKKOX6/KThv2kpdIQ01bNftUz8Z8fbZgUAv84CLubzj7+d/68XfEO6Mmh/HA5DW5j3ThEJQCprgGvvq/3NXter2cX1yAeqyn/+ear6OxMHORv8PdJEs6XAc5rktqWsFpykakajBaGW/iK2cAG4unMPqzHLS7nv/QMl1X1mhd+2d0bU5YmTaJbb464NEmIMoEnBzpSrpb0EKJauXWpcxuOaYJe3Dygvfi9s1OMTd16LIQILGA469dJ1F6Tf1GFwjDu0bmEXMxBk2f+lgRTyg2T7ucpX3TeRRDEZIz6ULDZANjk5r5xPhPWpw7Pe6dnqPKqGO+/N/JtXghYbxj3RnPUKpOBmNdFSteFXeRiP0Ffg1PukZyxvym0/aP9eS8xEml9AV75iXI6NOTYcER54wkXB0OUGGz+TJ41DMMMjl+yJf1jTUHPU3ElYWyQShKJZvLpivL1XZ78t4K0e9jgK6nw+9O0jLPIxyLXeQxF11wDO56kym4a25+BDC2wurWb15bz7WnKW0Lhjei3Y2LsGIe+xdvdYMr6wPdeRwMg08smI2BqXTPhjwc4J07ggsU+M9DUmzBPyNcNFcxa1p8HV3Yth3+/2+zWoClEvCG7rCTtP5f1P5nfNn/jRSlNoxJM7AUUVlCEDn2Ve7b3OgGL0Sr+JZ+gUO2FwqxiU/8cGQyNCCAgEtbIrBfJGrEJSn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellCaDNMek5ISHo5K0lvdFU5NmdnektTMXNXcG4wZGhyN0VhV0UxNk1JVHNG?=
 =?utf-8?B?Yk5yQkZEV1FnV2xWb2FqMGpHNE42T1NGSXg5ZWx1R2ZBdjArS2hBSkU4MzBU?=
 =?utf-8?B?TW9DbThGYUZvUlJ6d1hxbEpxcExGdzZrSzgxY0xvMGNOMTd3MjRNODhIaHhu?=
 =?utf-8?B?cFZQRS9GNHRGUnkxTlpQSldabXB3YXVWY05lMVRkRk1wWnBZSG95Y3pibFVY?=
 =?utf-8?B?VHRMa0F0V2xyQTFlUEVKOHZCZXdLdTByVzV4Qkh5bTZVbStOdkl5ekYrS2Z0?=
 =?utf-8?B?eThYakRndkFwTDQ1VEU1VW8zdTZDUDJWN3FITCtvR3FGbXEwQXRvTHBDa1Ny?=
 =?utf-8?B?d3ZFeWNTY240V3Z1bzc2YzdqbmtnR1VEdFk3WXdLczRrQXRKRUZrU1RQRktt?=
 =?utf-8?B?MXBsVHVZUy9ZdHlWUWZxM1dzTi83SVlhWktDNjVHN09MTnhNRUhCd0NSZ2k0?=
 =?utf-8?B?dVBPd3gvNVQzREJLcWw2dHVnYlE4NmtjYThDUGpORjdtR2MrSkdHcmQwekEw?=
 =?utf-8?B?WWZ2N25PWmhKWmJ5Wnc1YmN1cXJiSm8zd2t5ZEVVZWN3bmJpQ29LSUU4NkE0?=
 =?utf-8?B?VHUvL0F3QWJnYll5aURWNmpzM3ZjYmRrRE1WSkhjbGFhUE14KzFZdlMrRURx?=
 =?utf-8?B?ZWZ3b0JrZDdSUlRya3cycmxFQXFCeS9KaTRia0dtUEJ0bzJseURrTGh0N1dB?=
 =?utf-8?B?T3VWL2pzcHJDS0FIMnFLVlFyZFhhUEd2TTJwM0pGOGlRZUgyVGpBb0JCOGpn?=
 =?utf-8?B?Y2M2RHcyTzRWY1JhYmhkS2FwOWExNUF6RXBRS0VNSXhpaDRHV1QyZW5xWkV2?=
 =?utf-8?B?QWJpWDhySko3TkJSbzlaTjFIdURzS3I4ellZdjhqRzRBMEQraTJvZUVLUUww?=
 =?utf-8?B?aVVOK296Wi95bWhyVEVQZHF0by9oQmtvN29uUzFyQ1BDQi9VbHhpanRrZFdT?=
 =?utf-8?B?UjU1czZxNEJXL3BUNFdyN25Tajg5R29qQW82eDRNQ3p6TlV1TllnWVpLend6?=
 =?utf-8?B?OHdaVzF3cDAwYi8vUkJiUW9SZ0xRUEQ5dEZuVldycStxV0M1ek85dHJJalJl?=
 =?utf-8?B?RUU5Ty93UWcxVnNMVnNoZzN0YUtwQ1pSczJuRlZBa3k2N05NdWxoNDcxa1Vr?=
 =?utf-8?B?YVQ5bVo1dUVIb1pOaXlHZ2U0RkJoUXhnVXkyUWx3ZEpJWkxNNkorTG52cG5n?=
 =?utf-8?B?UnVsL2llSjZocll0OEUxM095Y09iVFZZRFV3SjRWSG9FeXd6azA5cmhTZEYx?=
 =?utf-8?B?MlM3TEpST3pzU2Evb0JyK2FVaDFmRklZd1grbTJhOGxDQkw0WVVHYUlHaFJE?=
 =?utf-8?B?Zi9DaUZURTNDNzFDT1VkQ1l6bjNRVmcrSWtxVEkzQ3pnR1QrakREcG53TzZW?=
 =?utf-8?B?L1JaMnFPeDFkZlJVaTc0a3FyTm9kRm5Qa0U0QmpFSHdrNzdaLytmTi80blht?=
 =?utf-8?B?WWdsNTRNekJZaXYycC95N21SRmRvcGkwUlcwa09ieHVOM3pCRzAxVWJKS3gw?=
 =?utf-8?B?LzNrNDlEeXBGVjlwSC9lQXpVOXBOREJFc2tXLzBqdjFGcS9JNTU3Y3NjYXJV?=
 =?utf-8?B?WmhsUTgxbDNmbVdWSG9GVWVyRFBwUWJJWitYTnZvczZLUUpNODVMb281ZVJH?=
 =?utf-8?B?Q1phditncDBXankvTEpLVWJLTjYrMEp0YU10eTV2a0s2QmtIUVI5U1JzSXhU?=
 =?utf-8?B?R3F2ZUc0Yi91V2FmNHp5U3N2MDVlZTJYL3QyWTRubm5SSUkvdFVCclhFcmhj?=
 =?utf-8?B?RjNEVktXQUEwM1B0MzE4RnBRZVMyOFdtaENtVVZYL01aN1J2MnNLU0szUFpN?=
 =?utf-8?B?WWlpMXA2NjJUdXBOdTZTVnQ1eW0wdEJja2JORjNUODhTcGtqTzY2Y05TV1BL?=
 =?utf-8?B?dzNzMlZ1czM1eFhLMTJXaVczRUJHVnF5cWNSUkhqaFEzdElrMmdLaTN1TmJy?=
 =?utf-8?B?MHJrZ0hGVzdIQnJDQ3BMMzRzZ3RpcEttVVNxS3FXd2dhc0o1Qkp1Y3Iyc0Zi?=
 =?utf-8?B?SkR3MVo3aFczcExYMWIrc0JsZjVjbXVFRGVWWVdWZi95bVk5NTBsWEhTcGRj?=
 =?utf-8?B?dldOdGJDRkJScnZTOEducVlCQ09ycDIxd1lSZkVZK0UxVm9uYnpkR2RGSUFF?=
 =?utf-8?B?WGxvQ3JmRXd4NVN4YnJrNW8xYXJGMHdXV3dKSU96V1Jsd0dYem54cjQ5ckxu?=
 =?utf-8?B?NFdIQkJFVWcyRHZCNTdBb0hpTXA5Z0xNVEFNdUdLcFFhWWUxOVMxbk9UYjB6?=
 =?utf-8?B?SFdCMlQrM09EeVROb2JRMXZ5L3RkMHBMUzliOHNBak12Y0MwWU9IdEtHZDV6?=
 =?utf-8?B?Y3FlR0Z3czZFS1F2Q0VXL2hJM1BPbUxaUTJHaVNsWGRyZ0locEZ0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560965f-ba61-417b-910f-08de99adaa93
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 22:40:30.7682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xII5hLJk/lYJb70+oHDECrBelbtCM/LsO9brlp6lmYJL1b7Bqw9ozh+peEvTam7HheVRR1REdfIu/pzFRiRq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
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



On 4/13/26 13:18, Lizhi Hou wrote:
> Mailbox message IDs are allocated cyclically. When destroying a mailbox
> channel, pending messages are canceled starting from message ID 0. This
> results in an incorrect cancellation order when the ID of the last posted
> message wraps around and is smaller than the ID of the first posted
> message.
> 
> Fix this by canceling pending messages starting from the next available
> message ID, ensuring the correct ordering across wraparound.
> 
> Fixes: a37d78470bcc ("accel/amdxdna: Replace idr api with xarray")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 84a7e92562ad..336e5e77f18a 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -549,7 +549,9 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
>   	drain_workqueue(mb_chann->work_q);
>   
>   	/* We can clean up and release resources */
> -	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
> +	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
> +		mailbox_release_msg(mb_chann, mb_msg);
> +	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
>   		mailbox_release_msg(mb_chann, mb_msg);
>   	xa_destroy(&mb_chann->chan_xa);
>   

