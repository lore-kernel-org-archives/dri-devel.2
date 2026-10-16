Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39ECCCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D2610E2F1;
	Fri, 16 Oct 2026 16:44:33 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B4910E2F1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNLuB3/vNFQDT2X823/ctyECCocWhUUDjHguvYioS1S70/YxDgR7F5euIoc1jIzBlpxhcgps6SK8bP2LtzfNx4b4QXYMiK6AP9Zn93Vkn2FOdgLADy8PB1ZUyE3wpneCXcFpijWyuYYKt2NmakBoMKAhv0Fnk3uSJYJYAisiD09GrbLNF2VJEsqN4KhQfvGR04csj6xXAYvTVejPb3FRjvnEgaKdUb+Kn2nuPH8k0C49V9WJR6pE+g3bBquWNkA+kq0EC0WISdhmGl47Dd+xtXaBBR9nbaQrdlHBc4TdJulYcxRyQNWAMbybwxdzAqEGBTjh+9WE39m/d47H3qsydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWp4TYVhv0PAlw/CyzwGlZRg1uyrTVXZqFLGS0VezYc=;
 b=BYkhJ2krCOYsgUOqsEPDGjOoyMiNLhceh/hwZqHuLMuS01J4UonI+gzgbelmd6LeVG9HI3YeZagrXcWioVU1ZOg+WXoeeMfo0+VpqOwz0M+aLotBgFSga1yA8azra59UtSFLkQ+0M4fRxELet5kI5kLrA74OibhB23f+5Zj2QD2XhboUbBF/omdvaIzQOEdtDcRss7ZkWWZqIbefiy8iroqjvkTnwKKHVAGkcIwiGQ0FxIvQdxDExyjxHgybJwPpCXnnBbKseDIPOoIEKHFP4PxliT7ZKL9aVQskLCVYSDCI7355EukHlSRpEAIZ7Bce+Hxm8CCuOss1mdSxBPnKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWp4TYVhv0PAlw/CyzwGlZRg1uyrTVXZqFLGS0VezYc=;
 b=wq3oUmEl6g0HS6franuFe62iQ8TJOXEoFYCRFYmLyPXOAhTwE+y8QMhQN7hyvyvqyQ/jHUfgen7HNJBgJ5Zbu7oWYdC7gb1AHMWtIroxKkbucu4GdwQ3lH9VyaBJhBMT1yQgEYocqflh43JeQAGcTrXLcLbapf3LyLFYK0izopc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) by
 IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:44:21 +0000
Received: from DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3]) by DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3%4]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 16:44:17 +0000
Message-ID: <d1c28128-118e-439f-83f4-2dd6e04fadc3@amd.com>
Date: Fri, 16 Oct 2026 09:44:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: wait uninterruptibly for jobs in the
 HMM invalidate callback
To: dri-devel@lists.freedesktop.org
References: <20261015183248.3414119-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <20261015183248.3414119-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To DS0PR12MB9059.namprd12.prod.outlook.com
 (2603:10b6:8:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9059:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd20b8e-6a30-493a-3bad-08df2ba4b823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0duMK01nY6+EYGn9+b9ZQ1uKZoHaxgZg5izaEd2FMj7NPWKY3zZCHF9pVpu8MjBKld1B3opKlEQE8CG0pWh/FsQ2UDfyGMiiXkriZ10XQW6xlYm3p5nuwGZCBFqQdFa8HGMfDXVQ1MfPXXzlmkDl1C8Kr/KEMW2uwzcCAMXwSL4ZaETZxcVfbDl1fhZ38X16hJEaZSq5RygBur38ycCenxhpu8/SNmMWjz0uH//N/LDvnBhxtedOwGzco8J8qo6UuTOKtFSUY8RsPV0oOyrvEd68PEZzsutATs8I0GcvYJxbajmMCmerWsWkFRMa5dALnIL16a3yXkPvbXWokH728O1BmNeiWFd/w4/EmNHAHWYc0yzbFyfmIBdRyP1UsNBoGcCAYP+ZPQ7mNY1P4if+W7bqw2CgLBgCQYLDG1vrUEytjgSx1mgczIMCA3A/Vh9PMuArOLMpElRt9dohg+xHzdl6/yRpsfSLFaIQrfd2PUmzzyRXrqvSUqbxh6iCgvy3jRuU4VvZmjF+pcnI92dgjMYnFk/0Cl+gAeApFDpnF2wlhUt+geNE0sqaKNaI94V7ebK31YJI4Fc9a90Qm2RNJss7JmAaMc8MOvwKGkA5caybdxrd350ZQN1JbJTjSR5A4UIgXtGedeMge/Knj/zk07AI+VyGlEMHUMJYhvLjnPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB9059.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU01UG5pRkRxdHcvNVR3SkhoczZNUFBzeWJIdUg1MGVLcTdCVnZxMTJYSm1T?=
 =?utf-8?B?czFQTHpabjZaZVE2ZldjcENST1VkMW9XUjBYM3JvZmdFbkpRc28yN0h2Qzda?=
 =?utf-8?B?WkYyY1l5WmJ0TnFYcHNvYWl0L3JhMlJ2UW85ZE84RjczV2sxV2xjNlFYK0JL?=
 =?utf-8?B?VVdQNXR6b2s3eGtBNTZEZUNCWVJVdlZ1SlNyYkVxdFJlNk80UHh5OWhJRWt1?=
 =?utf-8?B?VFhDY1M1MFpiTExLNk5VNy96aS9BaTA3V2tsREJFR1A0SWRucXBOWkZKZEdR?=
 =?utf-8?B?Z002SEUwNFlyMTQ2ZDAwTWJ4T2x3bENlZEpNSHRjN0pCdjJVMy84TXVXZVU0?=
 =?utf-8?B?Sy9lYmVWQzJkcndod2t6Z1FZUVR6UzZ2OTJXYWhrYldQK3VKU2hKWnNFa2FW?=
 =?utf-8?B?WnpYbURyZWVRY0puN2RWQ28rOVl5ZlpmMzdZSlVYTXhlUEM0ckZXNzYwVnlx?=
 =?utf-8?B?czdVV3o1LzA1ekszaUtBaWVrZFFTY09qUEpiU05rNm9ZbXoweUJ4RHhtbkxq?=
 =?utf-8?B?bGlYc1AyeVBEdU1HT0tuU25NdnlXY2hYcVdpSjNzTlg1Z21NQ0ZBeFhTN2Fu?=
 =?utf-8?B?T255N0pqcFlJYVJQRXl1UFBINTBJOXhmei9taGNsYmwvZ2lDKzlFOG02Uk5r?=
 =?utf-8?B?VHJyNmdMVzZLaGkrdEFoNjJUZjZrMW5zMGFhdWRNUGhEQktuZ24vQ09YWjFi?=
 =?utf-8?B?MDY3YWpBK1gvSFJudXEyTWZEWDBqQ08ybEJwUjd4T1k2RGkwR0lOVmlNV2dS?=
 =?utf-8?B?bkV1TmpkVzJHVlJrdFNvdjFqa1JDd2xENnlGcitjd25tdk8xMjR6QnJmQ3p5?=
 =?utf-8?B?KzV6Q29zL3h0eDBUT2ZFRUkxZG80bmkzS1hLS2d6bHdvakVTNS9WeUxSNEg0?=
 =?utf-8?B?OG1JOXhsWDZJakVETDhrWk1WeEFTM3Y4MTM0cms0TW80SXBwbmVrN0pXOGg1?=
 =?utf-8?B?N1BOemYwVXJjRG1IZGQ2dUdEVm5WU0xGb3lpUURWMFFpUnFUL1h4bldZdmRV?=
 =?utf-8?B?dU1BUjY4K2dFdHp5TktxaHZGWEYzb1NwN1hPZ0U1Y3FmVEwvMkl5bXZ2Tllv?=
 =?utf-8?B?SG1sMTFieFBrQVdrU1dHdmRKRFQ4bjkwbWVIb0FabzZ1cUhyU0RDK013VjBD?=
 =?utf-8?B?R2NxYVZ3NkhOK2c4Vk56UHRHTWhZRGxuRGNDTFJlOGhwSUx0MW0xbnBxeTU5?=
 =?utf-8?B?Sm51NGZrRU1BdXlTeUJiWlJtVFQ1RXY0U2RKbnJGY1dNQVVjUGt5YUF1eGRU?=
 =?utf-8?B?YlpxMzJRejFibjYybS9zRXc3c2dDaERZbzZvbHZBVmE2bU5YL0FVODYxaDd5?=
 =?utf-8?B?dzJCQlJpcFF2M3NmL3AvYmMwbVJHb0duSUhrNmVoQ2ppam9OSnpTb0FEdi9p?=
 =?utf-8?B?S2x4TVppalIvcm1XN2xNTzU3c1pKZm44VFFVMUR3azh2QkZab3BUTXp1dnJL?=
 =?utf-8?B?aGtyV0RNNnJXRnVwT2VtQXN4VWxHM0lkd0p3ZWFUczYyN3JMRXJDMWE3NUJY?=
 =?utf-8?B?MEswMStrMHF4WGRnTnc2UXBSeW8rZDhtcWh0MmU1dVE3NHVqZTU2LzVSNWlp?=
 =?utf-8?B?N3ZuaHI1djVYQ2xGdU16a0NvRExmYmZBazdRUVhlRmNzbm84NkFiZEtWUEFK?=
 =?utf-8?B?NEtwaS8zWlJsOFd4Sk9qc2l5b1pnZ255U2cyZ1czZllHQ2VCZzE0d3NPVFRO?=
 =?utf-8?B?NVpic2NyNkpkNjJ3RlVkdi94aFFFV3IvOEF3RGIvOHE1YlhKKzNsM1UzTmV6?=
 =?utf-8?B?ZHJwRkxDaEJXTGlqb0IrUHFUOFJMeWcwRFIzNlpoWTF0b1JLdm13RDI5ZFUv?=
 =?utf-8?B?MVppN2FseTUxWTNFTkdZR043L1R6cmxjUEFhWUFNYW00OHJkLzl0SmNSWUM4?=
 =?utf-8?B?REN4bDRFakVKYzF0K3dHZm0vM291QlBMQng0VGI0anNUdGQ3SGZmYlNmM3pj?=
 =?utf-8?B?bHd5KzhGOUtRMWlOZ3M1SkFBa21oeXZvRytUOW1uenJBM0dHY1ZGK1EySlEz?=
 =?utf-8?B?UUhreENNMlNpQUVKaHJwUWNhWURHOXJyUXFPV2xtSFNmQzdZT0ZmVVRxVXNZ?=
 =?utf-8?B?Z242T3pIeVAvOVJGZ1hPTUlsN1VxaGlkZmVTRDVCa0NqcGNFOEtYZUhjYTVK?=
 =?utf-8?B?RXhDeUhOQUhSeGltcEk0enRuZVliUEcxV0RoM3VsdUJXT2pGbVF5bTBVdHho?=
 =?utf-8?B?aVFROStZdElTT2FoclNXdDg2blU3YXJuamxQcmZ5RDhZNlpLd1pTUTI1R2Yx?=
 =?utf-8?B?TnFIRm1tNW1Zc204aHNWQU5RS0tMek1sNHYwOU9kanRTeks4VjR6OUR4S3E2?=
 =?utf-8?B?U3dQU2FteW13b0xOQjBpT3BlRGZQbGpvcUNNZkZIQ29NVWVJc1VIdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd20b8e-6a30-493a-3bad-08df2ba4b823
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:44:17.6636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSJouTTrx2PfZh4hkrnexnVGBGXqkGApmEDnTA8hDkkNZHXmNhPl0eALSUwzP8Mf+qYuUOnZkAuIIEKaZHCiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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


On 10/15/2026 11:32 AM, Lizhi Hou wrote:
> From: Matthew Brost <matthew.brost@intel.com>
>
> aie2_hmm_invalidate() waits for the jobs using a BO before the CPU pages
> behind it are released, but does so interruptibly. When the task
> triggering the invalidation has a signal pending the wait returns
> -ERESTARTSYS immediately, the notifier completes and the pages can be
> freed or migrated while the device is still accessing them through the
> PASID.
>
> An MMU notifier cannot fail a blockable invalidation, so wait
> uninterruptibly. With MAX_SCHEDULE_TIMEOUT an uninterruptible wait
> cannot time out either, so drop the now dead error handling.
>
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 9c6b7353cbe9..84ab8a55b7ab 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1286,16 +1286,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
>   			 unsigned long cur_seq)
>   {
> -	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> -	struct drm_gem_object *gobj = to_gobj(abo);
> -	long ret;
> -
> -	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
> -				    true, MAX_SCHEDULE_TIMEOUT);
> -	if (!ret)
> -		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
> -	else if (ret == -ERESTARTSYS)
> -		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
> +	/*
> +	 * The pages must not be released while the device may still access
> +	 * them, so this wait must be neither interruptible nor time limited.
> +	 */
> +	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> +			      false, MAX_SCHEDULE_TIMEOUT);
Reviewed-by: David Zhang <yidong.zhang@amd.com>
>   }
>   
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
