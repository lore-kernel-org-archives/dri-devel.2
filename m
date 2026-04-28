Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB48FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E970D10ECF1;
	Tue, 28 Apr 2026 13:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VyMsJSWT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFDF10ECC3;
 Tue, 28 Apr 2026 13:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXsmDxEDjQTLkU7ln2j2vCziBPCbhasjxKHKOOWUL0u85sjTIs/8sdkVFlyVDNTpat4DhI2NNbcf0xpGBVBQLH0AVczD4Bgu3+JSukePceoZ2ZVoZZlf0z4sLsDpTWMwArqizOblwgZ7iiJMZxwWGkVDJFWg/Gx68QW60EGsR/aOhMGemq4Gv+DNEM8StfgWcCJnGozbkRQILTLEVdODkRf3y4zeUjdFlCZsef/EFsYs4I26SMPzJ9xxsZ6wMc7I7yxCZNR9BwkyFJzfQeynu0NRYiEy/cIJuWk0TwEqOHTQXH1p+jT9nJ9K5zr+HzqXnlU4DGSFlpbZMkofARjnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB2tr5zBcYrup82OmXzHIwAYulvBIuRiFDrUVzKqJ7Y=;
 b=phLVN7o9uSw4rboSiavC9AwW9DtrmShiWwPSiMJc/joT1/LBpUnqJJe/7pwdVS0tOvO2HGLfB3aEVWMiYCOVg5zk+RT86N73DfazyxyXXHBLLzMPsmHKDF1+7S/RIhkl8OArGFec64DGcrAqXwBt83du1hNY7rtk0Zc+ZxXy70hIbWDuleXhSnuljYUzxwAU5gZDG+r+zRp4sCIluAimrNSZrqm8NiRzaCWLSpShSqEo74KKqh5Glqgl3zaqeicAYBW4uLLrx7ZuIhXxCTgDoQidgd+Ee/QNLatyfX/StyGUyXg12Eq4/Ubp7n9oLZdcF6vRtw/J04y/PPtN2LZtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB2tr5zBcYrup82OmXzHIwAYulvBIuRiFDrUVzKqJ7Y=;
 b=VyMsJSWTDpQrKl9RH8OfyIe57oNBlZZF5k4pU6tGRJfG75sc0DjZCk9ipz+m4wIikLdLBkBkBnxBz8mA0wp5boRyfcXLue54xIAVPrXyMpEe05jXKy19otz9lxJV1KcjvSju7rX0GJpdyBoHrilZhfIaFwCCpu8DpzzggBH/sgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 13:54:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 13:54:42 +0000
Message-ID: <3ca00db0-89e4-427a-a791-8ffa92a7416b@amd.com>
Date: Tue, 28 Apr 2026 09:54:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: simplify kgd_gfx_v9_get_cu_occupancy()
To: Yury Norov <ynorov@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260428022605.447901-1-ynorov@nvidia.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260428022605.447901-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: e07a0d65-c97e-4c38-f23f-08dea52db2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: myGRok4hCZnOCl9tLv87xYT4Bq/i2+E5Zgt3iCmlIfIRWjzLqBUXLHG8UIKULBbf1nNvilXvvm3xx804ywvxpQiofGDXLHkhif745k3339wjZqKWYuPnIV7C79Jk3sSUjMTQG3RE7fHU0rW2bZfTWY197jk7T2TFTzWZwnM4uCVZr21g8kLSu74ihAuMu4IbTP8czGc3N8JM1G+iHaPrQSRRn3uPsqpi/DM0d2wwozZELZ2N6iKkEZjeLLD1t9Y9R0PReGkENebwZmZQHzPIyxvbXdJXr1fHYpBflE5td3yTPRoKOomWlMm4lljRy5PRLgAbkV0+30X3T+RoRYVlY/dUHbqfbLUGbAVnTMG25bVhaFAEp8sNd6MDPBaX9dvNmzPQrIiz14yCTdxEGj072tgXoNGlLZ0VyizPe1UJbK3guGlNThF8CtTrlqa38/CQDL09mk08/7BhixZtrqGMFOnUA9HW3+Mm93bE9tqZKpS3pB6d546jCYBP9z1ZMM3HCoc2EznefaMZsWDF6PqEGVQBBA1hJp9i0qHKEcAXRo62LZQd5OIEU0oCDUbI6Jj5mJg9qjP2PnHmaWg4Ned00EmvuDPTt05Mmr4L4Wt0DTjTZftI8iToyyVlsxCwzjbIF/+p8sOf6fFCbyJQO9bW8NacO0sj7xNebqI5xbM7JaQw7JBrg0SGOBRgcIe3N8dGdqakdNanpAxNeMU/+/Z3474tPBtfWdb+/cUna+npAvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lrUjVORVJsTDI2REQ5VElJUFBjTmt3REgyNy8yakFCZVVMV21LbXJYZU42?=
 =?utf-8?B?MmFQREtMeWJuZUxMZzU2YkxxWXE4QW9VZmVkNjZkRDVoWUpaekt5bjZVcjZa?=
 =?utf-8?B?UmZTdEFrMXZDUlNVcmtoRFA1aExYQWpCT1VTd1hSdHNwZmlEM055SFlXWjNT?=
 =?utf-8?B?ZTFFM29NUUJIZ291c0lRRzJJQWNMYlhmclFJQkZXcU1GZjluUUQxT1pGUUdr?=
 =?utf-8?B?Zm1pMVNQQ3hSUnZaaDZQckdlQ0YzenpkeHh6WkczWE85eE1FZ25xcUIzMmFp?=
 =?utf-8?B?NWZySjdGYWpsR3V2eEI2bGZwOHp5QnBGUm42V3BoS2JwNkw0Z0doWUlOU1Jy?=
 =?utf-8?B?ZSt2YS84dldvdVpIOXRPWHhDcHFpU24zOVliME9LcFlDbUhJd0tVR0t1eHZ1?=
 =?utf-8?B?cWpsTlFYMmhxb3FINVh1MnZyMHVtTmN3cEtPMEVVdk9qUTAwUFJra0YzVmp4?=
 =?utf-8?B?TlpucnllYURZSWZnT2dadzZsMFpSdVhyUjd4ZW1ydFpEdWx0LzQvWkROR1pZ?=
 =?utf-8?B?aFhuS29SYTZ5SFNseFJkSHZ5M2VJTjVRekFnUFlHODl1QndUK0hRaW8rcjIv?=
 =?utf-8?B?cUo0MnhrRnFGa3ZpcERTaC91L29UemNmMFBVdWFMYTdpWjk4UjJ5M2FBaGxh?=
 =?utf-8?B?dHkxZkRvZXYvRHhaajVmQ1FIZm9IK2I2dHowcUk1bnNWVHFDOFR4aEFsa2Ni?=
 =?utf-8?B?ejA4YmVscUpKSDVjWFpUbzRlY2xRYkJrcFo0dDlDYXJpZEV1SXBwVXg3YWUr?=
 =?utf-8?B?WkpaUDRndm9kM1k4S1FEMlVJU1d3cktoUTdtdlc4andLYUN1OXZjMWw3MFdB?=
 =?utf-8?B?OS9PUEk2SHJRQ2l3Ym02MlRrYkhKUHQrVEt0cjBIVGJNR1ZMaGhrcUo4Nzcw?=
 =?utf-8?B?QjllNW1admdVbjRFQWZyRzJyZWdkVTA0elI1TWF6dHFQVUVZY0JHNlFHMTIz?=
 =?utf-8?B?U0ZOUEt6WDdhN0FNUW1mcWJ6ZnUwVnZQaThpSWFKY0JNaWJqaERYb1RqYkFM?=
 =?utf-8?B?OVNybWNrdWFDVkRpQitEbEVHWUJ2T2diQTQvS1RYSnE3WWpWcDEydkM0SVhW?=
 =?utf-8?B?Yks5dm84bUEzWHZkRGJrbWJHY0s1cW9PT1VxNk1WZ0ovRkRkRTk4dktkTERn?=
 =?utf-8?B?SGM0clQzK1kwdWhOazY0NzNhTmYwL3VUTGNOejVMd0dHL25jcHlTUVlRNnpW?=
 =?utf-8?B?bmRYb1d6TmNKOGljVkd1V0RYWCtQb29YM0sxQktwUUYrU0ZZRXE3Tjg4UWhO?=
 =?utf-8?B?RzZCUkxRVmpIaS9sSDNlRFh0clcweU9FWHRqaHE1dzYwNDJYOFRXcm5RZ2xx?=
 =?utf-8?B?aGI2SGQ4am1DVmVoQ2JhRUF4eHA2dFhDRlFSMjY4eFpsVmVkWWVtUzZrWXpC?=
 =?utf-8?B?bnhLK3FPRnB2L2U2eGZzMGtTQjExV3hvT1V6V2hKNXRjaUlFRmxKSmhneGVM?=
 =?utf-8?B?TW1haUNpbkFHMURsMkdnMG9acnFFWFJlZkdaZHFIMVFVbXFXWFFGbTNYYVB0?=
 =?utf-8?B?bCtxMndCV1dCOERRNUwvVnl6dyt1OHZjc0pLbERuVVZDaUd3bnhnZHVJTXpt?=
 =?utf-8?B?RVNaaHp0aWxNenFGVWdGdFNBZnNkQmx1dmhicEJnd1Mxc0Jyb1BaVTZPWlVS?=
 =?utf-8?B?cWVNNWk0L1lGU1dwd3lKMXFCZlV3UUxvQS9iQ1d6b21xK3Q5TWROMzJsWkZu?=
 =?utf-8?B?ajBnbWhYU2M5WTFtcHBDVkpyRlFTZHd2TXptTDBZT2JUY2N3aUVidG1LVXVP?=
 =?utf-8?B?YXQ0ZnQxYmphbWdMNjZsYXF6L2xMR3VOVHdTR3lGRUdPY2V6TERyYWlZS2s5?=
 =?utf-8?B?TWZQMThZcUE3L2NTM0pFemJPS0UzVFVDckVIQkFld1VWeWxQVkJVanRnZjJ2?=
 =?utf-8?B?azdrWXJMcWhhRWpaVXJSc1gwSUNjdGhteDY5anJHR1ZrMHZBcTJBeXgxRTVV?=
 =?utf-8?B?NktJZGdNZjFvYU5yaEw4b1hDYU5XaDY0RStadUliRlk1bWxuVUhrays5Sk5O?=
 =?utf-8?B?QzJYYWJDYjVSWVpIMEc1MHp1eUsxZjlWa210WnhpUVJKOUh6RHllUUdDdmxy?=
 =?utf-8?B?SjlzK0hyS1pUcEQyVmdwM0FwT1dQN0hVbnMveXFycnoyQ3N4RDBwY1FzQ0lt?=
 =?utf-8?B?Q2lJMG1MUFpZY3dscmowZldKUWJWUCtNVGVpaWlma2JtZTJTVHlUdldWOE1i?=
 =?utf-8?B?Vm1rUFZnazFOVHRnNU5od3dhWWFwcysreGFjblpUMG5KeDl1S2d2VGk2cmdG?=
 =?utf-8?B?OTFNWW0zMnN4Zlp6OFQxQzhQTTJBaVc2YkpMTGpoU3BhL0dOaUZRcUlWV0Js?=
 =?utf-8?B?elNMZDFCSERNMzZDNnhhOTh4bmFWdlZpNzJBMExNdHo0RXJaS1Zkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a0d65-c97e-4c38-f23f-08dea52db2ba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 13:54:42.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VszdlWwbf4L9OZw2bTnl+T7/AUOzx1DsSk1GloPhELgtHv+UBxG1GnlYwOGnYcSgqmvCawLZgg1GOrgfKR/zPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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


On 2026-04-27 22:26, Yury Norov wrote:
> Switch inner loop in kgd_gfx_v9_get_cu_occupancy() to the dedicated
> for_each(), and drop most of housekeeping code.
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 32 +++++++------------
>   1 file changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 2e116c06d5be..08f4c4bf20c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1026,9 +1026,8 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
>   	int qidx;
>   	int se_idx;
>   	int se_cnt;
> -	int queue_map;
> -	int max_queue_cnt;
> -	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
> +	DECLARE_BITMAP(queue_map, 32);
> +	int max_queue_cnt, queue_reg;
>   
>   	lock_spi_csq_mutexes(adev);
>   	soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));
> @@ -1037,35 +1036,26 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
>   	 * Iterate through the shader engines and arrays of the device
>   	 * to get number of waves in flight
>   	 */
> -	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
> -			  AMDGPU_MAX_QUEUES);
>   	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
>   			adev->gfx.mec.num_queue_per_pipe;
>   	se_cnt = adev->gfx.config.max_shader_engines;
>   	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
>   		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
> -		queue_map = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
> +		queue_reg = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
> +		bitmap_from_arr32(queue_map, &queue_reg, 32);
>   
>   		/*
>   		 * Assumption: queue map encodes following schema: four
>   		 * pipes per each micro-engine, with each pipe mapping
>   		 * eight queues. This schema is true for GFX9 devices
> -		 * and must be verified for newer device families
> +		 * and must be verified for newer device families.
> +		 *
> +		 * Get number of waves in flight and aggregate them, and skip
> +		 * queues that are not associated with compute functions.
>   		 */
> -		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
> -			/* Skip qeueus that are not associated with
> -			 * compute functions
> -			 */
> -			if (!test_bit(qidx, cp_queue_bitmap))
> -				continue;
> -
> -			if (!(queue_map & (1 << qidx)))
> -				continue;
> -
> -			/* Get number of waves in flight and aggregate them */
> -			get_wave_count(adev, qidx, &cu_occupancy[qidx],
> -					inst);
> -		}
> +		for_each_andnot_bit(qidx, adev->gfx.mec_bitmap[0].queue_bitmap,
> +					queue_map, max_queue_cnt)

If I'm reading the old code correctly, get_wave_count is only executed 
if the corresponding bit in cp_queue_bitmap is set and the corresponding 
bit in queue_map is also set. That means, for_each_and_bit should be 
used to replace the open-coded tests. Am I missing something?

Regards,
   Felix


> +			get_wave_count(adev, qidx, &cu_occupancy[qidx], inst);
>   	}
>   
>   	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
