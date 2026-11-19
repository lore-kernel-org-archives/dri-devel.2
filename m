Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A5606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1iCc1Nx6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9553110E1A3;
	Thu, 19 Nov 2026 05:09:52 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC59010E1A3;
 Thu, 19 Nov 2026 05:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH6WJjalTfYDEH6zb97aycHIOXpmTjjB8hl3Ps0POBv65Ld2tH0rICKZORmhWfSAw+VZVT8smN0NGIbEFTEU5UAqAKXWQGd9NVCyqEpT9JVoF4qQTobASvP1ZtWkF7KW6Mo4jLULMpn0mo3Dbg4bm5dVgKr+J1Nt9vKcjJihSgXIpT4FFlsQBwqVMe69z8wo44ueDlCGpJ3FtpfLOeDt70sfySgQl3q5Eok8ykJflRxhPAJe/NdnhH4imb18C7JVTzuRXzknSbEtZbSr04rFXhET1bq/2Yt58s1OLTB7fRQ+QF0QlPU9IV6dziCeBO9yJykyD1Rwn24WvapnCoQUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzhyDZ59EQ9vox7qHpwNeXRlp1g87+hIZPq5FaeeViU=;
 b=l+URep73qdKw3Cg99gDZ550sPjWt/UPlP044lsVfqmYlPKd3gZ0KzU+uzeOF/H1PsPSp75NM8DtC3dfYNngT9PwowZI+d7/AlSCOOfC6CMDMnFLYcYwbvdpN23+6tTGDAMpNHvOlXeBzSWzeQ5YBwTs9Ptjsh0elvtKkpljQZHcXqATihKFfLA1ThX8m10wt2VjmxLuhFU/nV/TCHf4VMqUCQl/4JP6XfcrBH0XykUYJKu1suxbcYZFZFoWx/Jd7xQk/QvKgrHaiSKnSu+ZExOK89jis075L5S/m1a0hAx1VFMy7DCRIVchown2ttC57NRWvbjkZedaAiy+vFjJq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzhyDZ59EQ9vox7qHpwNeXRlp1g87+hIZPq5FaeeViU=;
 b=1iCc1Nx6PxrFRwltyIv9TsgfVrXJDhE6BBZUb275NwraJcgpE6tyzsjqMkrtfj04aPHVjMb6KR6jLzZANV4MJNzPa+Utb1wDvygOuYwNSnJ1cpswBrvRtQQ+CcPmROND6Gusr/SlYhCM5oB+zkxF6087qFu5WsOWWyN5F1pU99k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 05:09:42 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:09:42 +0000
Message-ID: <14bb9b12-8224-4777-a6ec-873e54893c02@amd.com>
Date: Thu, 19 Nov 2026 10:39:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] gpu/buddy: drop subtree_max_free_order
To: William Palacek <William.Palacek@amd.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
References: <cover.1795032989.git.William.Palacek@amd.com>
 <ae3be752ad88e467bb05e5576af3e5ee4394041e.1795032989.git.William.Palacek@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <ae3be752ad88e467bb05e5576af3e5ee4394041e.1795032989.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0026.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::9) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 92721d64-bcd8-4151-2e6d-08df45fb51a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|5023799004|11063799006|56012099006|261102130727099003|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: wqhEMGy+IXPJGFTfrRgThW/HXPppNY5w3TRkx5PYTGr/YMUjb/WkakYB4quv707oAejsUuh8aDVNf/TBC96iuvQnDvmrtd2/BcRstg8d1NN4Tmx2Lx/i128TJPN+AKGXO1RChVHHOTUFRm8N/lO1Jv19PofTIffWD7ot3/kG6dHzPCb6ozvfRgsU0sQ1EuZBZCI7VAHONEbsQSvFy39/MmoB//SKC+6Dak8bZ/HijXVj+ezznIXBLFhmBAlj58rEjPoOuOQJ5llSNtjlRK/NS2Rt1O9F6E+T8jBAlL3QRkgdjTAlNhpmPIqgCJoDIsAZMh6/RKHMv9dc6uKvxJvY4x9y+7quHDt0ZFJRi7CSN7KjNIjffgETSlZospal5mPNqhxHhTTbKHWxS6KyNlyBdEjdw+PYymfQgYqK3lO/Jwyg/1Yp993TvFqV8zjtvPHa5+imliDkpwO5cjFotCJYEg0Pl0lIRIacwGI3TvEikIrwZ97FNL+I3hC9aU0/8n26qkQQKXr+NG2s7cHSuI1b5L30GdnvSUOSX1nUZsuQD/7ajA7/Xv1gPtioBCukBP5EzoAOAy4fMTlG03n8ZcBnTkWxRX62EqXXgbTkQ9d99o/lBRO5QvTKs58Zpcy7J7/dfAGWvwWwlH1dmsCHmd3degepbcAS8r8uDYrQjJE77YM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(261102130727099003)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2lubG1aK1dLOXFSSWJ1TS9nNHhVbXhyZHJOUW5ldmhBclU3RVdiakl4Y2hC?=
 =?utf-8?B?MnQ2LzVtRm5oblBNSlJIRVZVZHNqTnllbDJ0RTJYeWVvSlVuWVR4cFRPcGg3?=
 =?utf-8?B?bUtCZ0RsaWsrUFlOcDNKZk5VUmx0THhSU1czTlR2ZlkxVzVzTHV0ejNCakRM?=
 =?utf-8?B?UzVzUXY3bXhuczBmVndQRzlGS0xVME1BWkwwcXU3TDVlUlVwSGNmVklaam5i?=
 =?utf-8?B?VVhIUlErSHRhMndzNzRORWdNZTA1cVhJWmhNSlBESWMzR3Q0SUZId1Nsd2xK?=
 =?utf-8?B?YzBHb3UvRnkvZTRpVGsyM25VYVRyZkYzV0g1ekxXaUJvWkFPdEIyWUtGbUFY?=
 =?utf-8?B?c3VPcmUvTEhrVE1OL0lFN2JXbnZZcFpoNEF1YTZBMmdIVTFNUmNuTjczN1pM?=
 =?utf-8?B?WkR5bG9ETVk4WG40ZU0xV3llY3RlRzE1MytlaFBpTzhVMy9XTDcrTVJVU214?=
 =?utf-8?B?OHd2Z0tWUHNic1c1RUlvNEdWVTM0NkZmeEZOMHJ5K040N016RVp2OWVUVFZv?=
 =?utf-8?B?N3ZkR0pGRVUvWDB3WWgydEc4ZWhUUzJSQjdEVFJQNnd4WmRaeVJjSTB3cGkr?=
 =?utf-8?B?TTQ4Y3cxcVhFRlZ3N20yb0RFMmN2S3FhWUgxMHJlSWZudGsxdXNkNlVaM1hW?=
 =?utf-8?B?YUZtVDBGcDNET0NuWURzMnZuaVVyRHdJbTkvYWhLWFdsNXI4dXVVZlVNaFdj?=
 =?utf-8?B?SDhIZ1VtYVRsWFJsZmt5Q1F0cGUzWmNDTFR5WWlOWkJvWFJMRVQ2TzNjSjNP?=
 =?utf-8?B?SDJOSUU3cDN4WDNVQWlGWk1KS0RRbTFyY3NBSE1ieitKeENzc1h2ODE2cytt?=
 =?utf-8?B?ZDVLOFVuVDF6SUN6cnlTaElnK2lVaVoxUnFtRG96VTFTa1RuVE1XWmpMNytB?=
 =?utf-8?B?U3hlbVM0dllQWnpKaVBpMGZGL0FpR3Z2bjVYU25WZmVmWG5NZDY1QXZUeExB?=
 =?utf-8?B?WURNSzhERTVuVi9hRHcwWkFaYUQ5V1phK1lTTEp2KzcwaFVrajlBVmgxZVRy?=
 =?utf-8?B?V0RxZG80c0dMOFZ6SFhtRk42a3Y4ck9QZEQ5TWZVdGViNWJmdHpScmdsSjly?=
 =?utf-8?B?NnkxQ0lxQ3Rxdkw2d1VTL0NDZHBVZWtHWGt4NCtkZGdxb3Y1Mmp3Wm5aOFdw?=
 =?utf-8?B?Z1FQQVAzQmhYOFdGSGRQeTFOQlFEWlBrZ3hYeVRZTTE2eWk0dU4rcXNmSmtr?=
 =?utf-8?B?czQveUdrY0ZjTVlFYWNsbjF3aFczUlRmNjZTaDYzdDNrSEp4ME9WZHZnNTBj?=
 =?utf-8?B?Qis1ZXZsVXJhWkN3MjRZc01HK3c0T3pEL3RwUmhtQUF3dEpvdkpqYmJmODQx?=
 =?utf-8?B?akVDekltaVFWT0VVa0FQTGVQaXhOZTlsUFhvTGVlNUFCaWZXL0xhMDBKaWc5?=
 =?utf-8?B?WGJzcFpmRjNURXM2eTdoSjQyV1ZJeG1uaW5QWWRGTC9pQkRjK1BUOXY2UkFq?=
 =?utf-8?B?d2JFZE14a0piSmFFb3h2Zk9QdnR1QXhjSythUXZwZHNqRmVYZTEwcmFvMU1U?=
 =?utf-8?B?MVd5RHF6aUtCcnAxSzhxbFZKR0d3aDJrTDNPTElyK2hLQjU2YmVScHRtTnlk?=
 =?utf-8?B?TExNWUE5clZmZGZkNEo4YVRjS2N5eGF4UUZmMC9GRlBmWDJiSUV3WjY3WEFx?=
 =?utf-8?B?aHV5YVZsTmJxb21hUWJGT1Vzcjcvcnh6bGRNS1RzMHJRZVNqYVE5blF6UEh4?=
 =?utf-8?B?MlZHQmVQVmRFMmQ2UDF2SHZsRTY3Zmh2NmZzMGw4Nm16SXMwc1VmSWxxQVl4?=
 =?utf-8?B?ekdHQ25mc3lOL3g5UG9USFFhc2VNRVhiMEZXNVJIU2I5TjVXRTlrT2JzVkZC?=
 =?utf-8?B?ajRxcmJzdXJPY281bEF6M1NIZ1FzOUFwOXNSK3hObGk0QXcxdFIzaDBiSzg3?=
 =?utf-8?B?TE1UdlpieFh3SFFQcUFNVGRIeWxTNEM4WXl0OElhQThzdFdDV25Da2htS2lq?=
 =?utf-8?B?SURjTnMyQSt3YjQ4b1BicGk1S0lxblFmVWZxTExENXlIU3lCMmJCeGhZTXBI?=
 =?utf-8?B?ZjFaczBXTTIrU1g4TGFxem1pcTdFZ29XdGxGMG1hZXpuQTJzeFVpaHkvQjhZ?=
 =?utf-8?B?WUVWSWVvS1VLTzB4eHJZS2lrZnRSZXgxRCtnL2swUEEwNVpMVjZKd0plMEtx?=
 =?utf-8?B?U3VBRVBNRlBUcmxXTEhuZXJnWFM5azNsd3ByUUN0emtqdVM1eTA0SFhiemJY?=
 =?utf-8?B?bDIwZENOZWh6bFB5MVNGblR5NEljK1AxVUNyaGJIbHB2bjBZeHVtYVRpVFAw?=
 =?utf-8?B?cnRwZmJIZjVZKzRYWWNRWFJycXRhZmgrMTZ2Rm83bW1MbTNwT3Z6MXc4Zzlx?=
 =?utf-8?B?NlM2RE9BR1dxa2p5dyt3WE8vV3ZzVFA5WWtDSlcyQ2duV2xDa1FBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92721d64-bcd8-4151-2e6d-08df45fb51a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:09:42.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1g6SGp5OM7lpNISRghmrpjCCcwmXAd2pWHTghNfCXju1XGnKLDgzyk/9zocbw0gOABjVbZrXt0C1dGoz5zkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/2026 1:47 AM, William Palacek wrote:
> __alloc_range_bias() no longer walks the buddy tree, so nothing reads
> subtree_max_free_order. Stop maintaining it on every allocation and
> free, and restore the original order in gpu_buddy_block_trim(), where
> the block was detached early only to keep that field consistent.
>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>
> Notes:
>      v4:
>      - new patch
Please squash patches 1 and 2, so the new approach directly replaces the 
existing one within the same patch.

Regards,
Arun.
>
>   drivers/gpu/buddy.c       | 39 ++++-----------------------------------
>   include/linux/gpu_buddy.h |  7 -------
>   2 files changed, 4 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 26af5428ff76..95f98830b787 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -602,7 +602,6 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>   	block->header = offset;
>   	block->header |= order;
>   	block->parent = parent;
> -	block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>   
>   	RB_CLEAR_NODE(&block->rb);
>   
> @@ -783,27 +782,6 @@ static void rbtree_remove(struct gpu_buddy *mm,
>   	RB_CLEAR_NODE(&block->rb);
>   }
>   
> -static void update_subtree_max_free_order(struct gpu_buddy_block *block)
> -{
> -	while (block) {
> -		s8 max_free;
> -
> -		if (gpu_buddy_block_is_free(block))
> -			max_free = gpu_buddy_block_order(block);
> -		else if (gpu_buddy_block_is_split(block))
> -			max_free = max(block->left->subtree_max_free_order,
> -				       block->right->subtree_max_free_order);
> -		else
> -			max_free = GPU_BUDDY_NO_FREE_ORDER;
> -
> -		if (block->subtree_max_free_order == max_free)
> -			break;
> -
> -		block->subtree_max_free_order = max_free;
> -		block = block->parent;
> -	}
> -}
> -
>   static void mark_allocated(struct gpu_buddy *mm,
>   			   struct gpu_buddy_block *block)
>   {
> @@ -816,7 +794,6 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_remove(mm, block);
> -	update_subtree_max_free_order(block);
>   }
>   
>   static void __mark_free(struct gpu_buddy *mm,
> @@ -838,7 +815,6 @@ static void __mark_free(struct gpu_buddy *mm,
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_insert(mm, block);
> -	update_subtree_max_free_order(block);
>   }
>   
>   static void mark_free(struct gpu_buddy *mm,
> @@ -958,8 +934,6 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   
>   	size = round_down(size, chunk_size);
>   
> -	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
> -
>   	mm->size = size;
>   	mm->avail = size;
>   	mm->chunk_size = chunk_size;
> @@ -2025,17 +1999,13 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   					     gpu_buddy_block_offset(block),
>   					     gpu_buddy_block_size(mm, block));
>   
> -	/*
> -	 * Detach the block to prevent recursively freeing this node, and to
> -	 * keep free-order updates from propagating above it until the trim
> -	 * is done.
> -	 */
> -	parent = block->parent;
> -	block->parent = NULL;
> -
>   	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
>   	mm->avail += gpu_buddy_block_size(mm, block);
>   
> +	/* Prevent recursively freeing this node */
> +	parent = block->parent;
> +	block->parent = NULL;
> +
>   	list_add(&block->tmp_link, &dfs);
>   	err =  __alloc_range(mm, &dfs, new_start, new_size,
>   			     was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
> @@ -2054,7 +2024,6 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   	}
>   
>   	block->parent = parent;
> -	update_subtree_max_free_order(parent);
>   	return err;
>   }
>   EXPORT_SYMBOL(gpu_buddy_block_trim);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 8037f5a0feb1..ddc4eca84175 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -141,15 +141,8 @@ struct gpu_buddy_block {
>   	unsigned int subtree_max_alignment;
>   	struct list_head tmp_link;
>   	bool has_clear;
> -	/*
> -	 * Largest order of any FREE block in this block's buddy subtree, or
> -	 * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
> -	 */
> -	s8 subtree_max_free_order;
>   };
>   
> -#define GPU_BUDDY_NO_FREE_ORDER (-1)
> -
>   /* Order-zero must be at least SZ_4K */
>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>   

