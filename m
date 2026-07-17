Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E430C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB82A10F5F5;
	Fri, 17 Jul 2026 20:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JQXdXVHC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E81810F5F5;
 Fri, 17 Jul 2026 20:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5w5P3Im5/5X6QiRCgJFTeYwIt5ZknOY368CxwvI/O3RRwcDTGpFAOlIMehePeW371Vgbt9ibir+P4v6f+VEbv/rLLvOur3i9ZLcsqqnu227AKjkCOBotPRrQGF46RT2EZ4pYF/ExYAboQGZaCfuRQC9E5S2+yUlaaBCiJ3m0cUQtrkYWRZwmiTDUOphxx3ZdZ/c0DiW9d9RrlvYsRhsyscwaEoU7TmFl8d70RgCywlMFK8cNjXBGGINGzhHTI5z1mK0USlGSV4zgJbVWAvvYYG3QQZFB5iDLJ2IRojFuSGXVQTZlxjdEtwUh0otBREQM+hgoZ+kHlfsNBj92GS5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMWcQnMsVwzimzbX8bts7kwKNGgOTdDEHyKJXkH4CzE=;
 b=NYncMcivzWa+Yi3C4LwZEtf9nGErs2Vim4fxCA9fFXBchvbLB9rEZq+eqQ1wTmE7rUuJDsIrV5RAOHPUQzUKEbhtNVjF0+eeEL0dU3lyJ1VgYWeM1/8FgnRIvqBhyl2WaAE6At8jyEm/SGNbGQ36mYjhtVZmwwL7UVDjSz2bE00MXCk5aVPzfQE+JyMgpvKQE+j5su+dwB3+J3KYYeB8DRO4P3eeimk41TG/mk10POXDxwG9jk1jaW1Bl8WQOLxJoHFTC1Si6y0RGnuljr8FhqnlvZWQfBR40wr88tV1glwv5I4gSzNsFuAxxFHuGB4ZopN8BVzm7CYPSC7k78fXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMWcQnMsVwzimzbX8bts7kwKNGgOTdDEHyKJXkH4CzE=;
 b=JQXdXVHCW1rqL/mwVByAr8Xt5D+f3U0PXRxpvgLQMJ9JbDs6ifLdSm3uTz67gOlyuOykB4nRn7e6LyYv/VgGHFKMbT81fkNi59a/gItxS0jedRqTbZ6Ma6lB0+6NvRQfivdN0utzXQ1JtbBgNX/XNe2Y1arDnJngiPUt75hD1AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DSWPR12MB999152.namprd12.prod.outlook.com (2603:10b6:8:36e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 20:56:33 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0181.019; Fri, 17 Jul 2026
 20:56:33 +0000
Message-ID: <a1f9fbee-1a77-4c66-811e-5f906a84df85@amd.com>
Date: Fri, 17 Jul 2026 16:56:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Pack nested ucode_info struct
To: Alex Hung <alex.hung@amd.com>, Felix.Kuehling@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, YiPeng.Chai@amd.com, Hawking.Zhang@amd.com,
 yunru.pan@amd.com, lijo.lazar@amd.com, chongli2@amd.com, xiang.liu@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>
References: <20260709223312.475563-1-alex.hung@amd.com>
 <20260709223312.475563-2-alex.hung@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260709223312.475563-2-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0222.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::8) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DSWPR12MB999152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da897cd-9d38-47f9-0f85-08dee445e1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info: IjzIa6NdAdD5ii2lPPOlhzcSY/t5IElbmu3U1W4lu31BFkds8wxxeiwreTbHpjMA0H+MQ6yhJmoYgrJzeWrOLPxqxyBiF8l0umzJgmoqsXLJABw2g47+dMyHX+1uV+ZqA0EETJIZ3dUG/1LGTajC5iKMUMaQSl44s7Vkc3o6Rl6okcbPG/D1Xv16l64W1ICFB/xHhYuaIWLtTEsYlcssDWo4KbK/Sa+B0oX1GHtlhOVY/PXBZVhR0Gd8tFFuwasFh0WiqrsuZ8h8a7v3Msr7WAfZk+xkRkOGsJP1UKVptKkOxgJdNAi6OGSzSnsJ7s7eTx+b4Kt/DKyPbTYUyOpgVplCKOP1gHK2cy58H/tgEPdQIwR2BmWDXTXNpJWVEE34hGrRl1psIcQFW2FOymDZUjaObMqSE5IFV1HWwvq8hOBzkhhGBSLAPRss7rMyH2DoGQfaAXImM9jaj2ZahjWND1hlmyUZWkxy5T1eAYsT0O7ZsHwtGxCmToEtaHosSP4O7NSSLc6Lb48XQ7SCeZHhagglgbPfMyvmQv9+REFvn/2CFEfiuN1m2SEX86Z+aEfEmQW11l9ssce6cxM2nADmALClDtqCZ5TcjsFDmaJyXux6ZsYJv+pcjar3zSl2+MUAw3Te1G4Sg1X5vGlDcFYLfCpJlcFNlLVJPO6CnxAMbrH7G4bFlekeyG6o3MBD8EWC1w47ZX8xsJjQeQerKoL9Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006)(921020)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVJUWNvNmE5eHVjV2hmMEtSVkhrc0FvQWlWYnVVQzhDaGtkaW1uWEpWSW1S?=
 =?utf-8?B?VzUvUUI2amlva3FJR2x3S2M3TnNDcm1nQXhBbVFXZjNHelNuUEJkSkVUVTZY?=
 =?utf-8?B?anVyWjdlMk94Vk1GKzlUalRROFlKY2g5SngwNGxCZTRQbGJ1N0RIT0FZUWFi?=
 =?utf-8?B?KzFPcVZqRDVPWk1NY29VeFVkSGVPa0xSRUJnMWlaS0VHMS8xcmRXcEVLWVlX?=
 =?utf-8?B?WkVETUZZNm1kMUdmbkdNeGtWUnlEVkhtN1ZqWHJIM2N5NzRtbGc2NEVwUjR6?=
 =?utf-8?B?ZmxNTjhxT2ZnRnAvaGRnaFpCYWRuZjFlUXl5WGtSUEwwQlo0UVFHcFBkdWtv?=
 =?utf-8?B?MU9zKzVnNmczVmFDOVFtbTlUVnhhTGxCaE9QNkxXM05vMkhTTy9Bb1p5NGlx?=
 =?utf-8?B?cWpTNlF1VDE3bzBNb1QwK3NHRnpkVVVScUVJZi96ck1jQ202SDNnZDFkT0Jo?=
 =?utf-8?B?YWM5WUVwQjVjOFZ6Rkkza0l1aTlLMTVWNUtGdXU3Q1VaT0MzVWRZMkI2aDNr?=
 =?utf-8?B?QTRMSkd3MDZRZkVmZlFEdGhESzRrbENST01hSjRBeGFxQ2FCV05yeThac3ln?=
 =?utf-8?B?c3B6emcxVngvVlpHbmVvWER0MW5WdzlCY1BXNWhTdEFhd0NybnliU1FkVVlY?=
 =?utf-8?B?OHMxY0ZyKzkvaFlCdkRCbTdtQWRMWTVEd3RJak5uZHgzN3VlRGhoV1BWZ01i?=
 =?utf-8?B?TzBKS2IvaE1HWlpmSU9Vcm9UNjhReTY1cm5ULzk2K1ZiWTJ3dk9CV3RxMHpv?=
 =?utf-8?B?d0k1SnlhNnN6bmJNS0xTZ0F4cWt3SFkwOE42SDNzYUVTWFp5Zld2QjFrdHVC?=
 =?utf-8?B?aWYwNGdiYUxuLzlsZVI1SW5tKzl4OUtKcE82ZmY0dy9VQ1RkbmtoR3FLaVR1?=
 =?utf-8?B?VEZpSmJRUm9CU2wzajRKMmNhVEZYMDUweWJHODBGQkwxUnlRbVR5clVVRERl?=
 =?utf-8?B?cDE2N1VVdE5zSFJWWE1meWhsSUJpVEh1Q002QVJ3YXBzYkZabWNWUFRlRHJH?=
 =?utf-8?B?dXRpMmJzL3Z5UDhTTmJ2TW5RQmg5TXh2dWgzSTFsaEJGTk1tTUw4TExMS2Y5?=
 =?utf-8?B?MkhZVjlkbjdsUHdBajhOekd1ZXkvdXVvZlh0b2NrWkVMS1lkM2d1ZjE1NTg4?=
 =?utf-8?B?N0dGOU5uQkErTFQ4ZmdKbkFxQkVqYkQxTDNMdTFKUE1tZHhPbjdnTWtVdVNF?=
 =?utf-8?B?RmJmeFd6bm1SRnc1OWh5QzhSWGR0RnpXYW8xaEtlOG9KczNIUG1BU2hQdXY4?=
 =?utf-8?B?S1FtTnZXRHhXYjdZcnI1NmVEcEdxbGxwZmFlRXBsd2JRalcvVE4xTEtUTmpp?=
 =?utf-8?B?SmE2U3FTNnRJcHdyTGhOTVhNdm5BMDNWWFErRDl0T2NSdDdoUzgxUnBFNG9D?=
 =?utf-8?B?NGdZRFFia2ZkR0ZMYm54YW14WDN2SU5QUG13cnZyakpZbm5NOHlMN0ZOSmk1?=
 =?utf-8?B?ZlllRlNwY0g3ZUhLOS9HK3dmZXB6c056MDRQOUVDSUdIUjN6U0lTVnJEOUJN?=
 =?utf-8?B?VjZGbGFoNHN1d25hazhqdXNqQmRJZXY2elBDckphcHNkN1l4eDlQRzN2VVpj?=
 =?utf-8?B?akdKOGlJdVRWNUtPOGV6cEU4WTY0N1ZxQ1dwaXEvYVhTWjNHVTVMNWtrMHBQ?=
 =?utf-8?B?RGFGc1VmWjhlUmgxN1NHQmdGWUZ0OEphbU1IVkIxa2QybXQ0YVg4YmJwdXFX?=
 =?utf-8?B?R3ZOUlRYeTdKQnVnOUh1Nm93SXRCOXBNU1RvbzB5dXZOYnF4TlVFazUzNEls?=
 =?utf-8?B?SHJMVjhhdWJySHp1MWh5ZUVLQ1RXT0VIZ0NNVkM0cmc4RlBoeVZRb2ZObEpE?=
 =?utf-8?B?WXBETWxVbGE3NUJzanFEenpld1Yxdkh2V1p4YXBOZkNZU09VL001bE9OWlFU?=
 =?utf-8?B?UzgrVXNBbDlsS3JzRklLdElkQVoyT2ZwQXJ2a2NQZjVldDJvVWlSQ25iWmIw?=
 =?utf-8?B?Y0haL2RpNlA2N1dlOENpK1ZEQjV5emtVOHgrWm5YVW51VGhXQ3BaSmxadWVY?=
 =?utf-8?B?d2RKeFRBNHdDbU91bFY3RktKM004SFN0YXRsdU9JN1dLR1NRelQwMko0NE9V?=
 =?utf-8?B?ZHNvcFgydCsxUjVRWlBldmxucEFrT2lDd29WUjFHeSt1RVdUbkw1RHZ6cUhn?=
 =?utf-8?B?UTFnNHpuRTZsYkVMenM5M1NxNDNCc2Z1VUJaNzZ6RHA4UHhMeEx5MmtxSUVT?=
 =?utf-8?B?d1lsaDFJRWEvc3VONGNyZ01Ja1l2dmt4dWd2VFM4c25DMG50eWVMVkZ6Tkg4?=
 =?utf-8?B?UGt3RFIwM09BNVRsQ3hNaEJIdXdrcm55aUlJNU4zMit4Y3I5THR5L1kxTWc2?=
 =?utf-8?B?OGRLR3F2dHQvWnJxRGw4MVpNbGdvT1JieXhZcGtOdkpldFZlRDZJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da897cd-9d38-47f9-0f85-08dee445e1e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 20:56:32.9143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1P+caQ8AOHwBSd2XpSx9U+b+06lS/sODd4Tj+XBnTeEsUAqz672yYZIJSiAe5UhYHaRF2F6KJrwbtEzljYt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999152
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



On 2026-07-09 18:33, Alex Hung wrote:
> Building for ARCH=um with W=1 C=1 makes the "amd_sriov_msg_vf2pf_info
> must be 1 KB" static assertion in amdgv_sriovmsg.h fail under sparse,
> exposed after UML builds were enabled.
> 
> Sparse does not honor #pragma pack(push, 1) for the nested ucode_info
> struct, so it sizes each element as 8 bytes instead of 5 and computes
> the surrounding structure as larger than 1 KB. The compilers get this
> right via the enclosing pragma, but the annotation should be explicit.
> 
> Fixes: af3f2f5db265 ("drm/amdgpu: Remove UML build exclusion from Kconfig")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607091659.SHEscT0c-lkp@intel.com/
> Cc: Harry Wentland <harry.wentland@amd.com>
> Assisted-by: Copilot:Claude-Opus-4.8
> Signed-off-by: Alex Hung <alex.hung@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index d80f01c0e754..b02561f41b58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -379,7 +379,7 @@ struct amd_sriov_msg_vf2pf_info {
>  	struct {
>  		uint8_t id;
>  		uint32_t version;
> -	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
> +	} __packed ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
>  	uint64_t dummy_page_addr;
>  	/* FB allocated for guest MES to record UQ info */
>  	uint64_t mes_info_addr;

