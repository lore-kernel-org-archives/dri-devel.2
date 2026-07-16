Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC678C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E7910F3FB;
	Thu, 16 Jul 2026 21:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KdYDP9dd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A835D10E249;
 Thu, 16 Jul 2026 21:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ/zXFc73DT4t8cLsS9HfbcCjUf94y+t6YFxkq/4r1WvLMfNZFb6nuWB/ZWt5fdX4f24MDz40SrNziNOaLDAjQdCDGRdzjf9e6Cg4y7Q/kA5qIwdAbwQipkAGjjBt8NJtcUxtdkJkAOykFFOI9fGHaHxwZZIxjjgPJ7zovg/1XprOxSqTwUxbPiusLoNDZythrOD7qe+ypAMYoVMwKdzvurdeue9CQPgFGr2HHRAzHVA/axVlAfPn7JH4pz6E1iiNCjTlIX67YsH0ZhukRF/JLn8Q/fe97GKrmYngWeFYddFICcpySynkLGeFIF4Thvn1F+SPeodW5eEQHM+1eEamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKcUA3pAzY4FuFm95L+EdwOTIzC7LRillzP+bSIPZhU=;
 b=u7p68kkdfX3sjOqrDXAvQDtX6qrROKnWv7MgrTKFfiznRQazVEGQ8e/D/OkPcpVqwZS2p8ziW+m/OpRohkwWvgbp9uo8ruzTfFLIOfc64f9u/JXXHOeY4gLMV6L6GVnT8KLpT7zhxbKeaYkR9rIYN4AMTlLpHCheGVxEtLONkdBSpaC/fK9p/Bd7FwnOKCtjyxvq/KRZHI6MFCuZdnco9rdysKaFa0/oQFO2UDVCbPPmhWFf+99jjJCeXNnVXmayShxD9vD9yipcf/Ox/DlelgHZZpr/lSpkf7p6tJrybfFsT4nnPftZoltfcPpeCTLda+sRAgkgqazT7cmwSQzKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKcUA3pAzY4FuFm95L+EdwOTIzC7LRillzP+bSIPZhU=;
 b=KdYDP9ddjAsM9i+kyXijmJi26kNLRYyv7B+H33I+RIYzlQiC4RNKV2gAedozgbbAKKjYpC32Ac44xwJIRDVNkB1vtYr3P2IodETIKD0OIL5sZrwDu6NuBequ+5HtCWIuq4WXc5Fy6F3M96dvDvhLkhAloETTOr56Sb0fMwx5dmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 21:59:27 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:59:27 +0000
Message-ID: <e90d1c97-7aca-4bcf-95eb-bde07c3cdccd@amd.com>
Date: Thu, 16 Jul 2026 15:59:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] drm: writeback: Modify drm_writeback_get_out_fence
 helper
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
 <20260714042805.77934-6-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-6-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: b184d20b-787d-4b76-425e-08dee385813b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: GjxODccJjRpVmBWYNbwKb3qNyNpsFuXxiHLF9mT1KDSmos9LLRvwhZ17zOo8MeK9R+4hGfA+jU72LReG5SW99Kn8IgKmwJfHDaEZBfNknL7EdkmN0NE6mVmwEhqT5Idqs99QJihBj0Yr0pCHA5uZwCNhVnyvYyBuyI1Zz52E+pC3XZ/8PSLOTfmhQwC6W4k862gRCTm1C1lR+HF2HLKZPUdyW9rStPCRnjCBoF8Y06fZwjAIQuAU6zeM7c3cPCh0vf4453Pw7v9Q8ei/khhSNASQxiqNpnngOHLQgc1irWgP8779I1jOS3LXShlhgpQ4UZ1kRIl2Y3hrb7+VbW/l+3X4hM7TMnu7jqe5CnLIjRsCvT5O571sOpszCLBQZoTbEd4snPj0SPFaKa4Syp8j6ryTb2PHs7eXM2eKvWN3qf6tpz6SpBPP8NIWjx+8fLAZPg0vX7K7G2brb9sTVBPGD0glyyncAwpDTioxbg/4zz0eRmj4sQxbWczj4Ut4uTZcaiI6eHvep3rDku1tGQGEfiRExrwl/uVfamziSoTh6VS3SLjotjnehIkAQ6XMmNbtk0jo438cAf9lOq5BsBqW6psOtAL/nUvXWdODVhpPf/v0dAcknNRXZbbxNsn7J/2J1ICXASIl+Cnv7S4ZXqj7JLRTa54qltkdK2ZyuwjMkjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Fob3ZCM2FTMTlrSDZ1NGxuclF6R3lIaDdaaDUyUGx5ckgzbThmYnlQSVhs?=
 =?utf-8?B?eERUZEQ5V1FjSjBPNyt1eGF2RjJzRFBmVHB0UXhXSERUaVp5aEYrME9oYmdJ?=
 =?utf-8?B?SFhjNTlIMXNwekpjckFPSHBzT201K2VTbks2UlU5K3QvbmZPZzlPUU1DOHBk?=
 =?utf-8?B?UkFzU2I3eW1CWnd1WXYyYTlYeXZHQmI0Vmpscm11TzllbTVyd1B5aU1mYzIw?=
 =?utf-8?B?UmRPNXNkWi9QMm4yVVhvSU1XTU93RlB5eDFMRll0Mlcrc3l6UXFrcVE0amtL?=
 =?utf-8?B?SXpaMW4zRTlrL2VRQk40WkNza3BqdUUyU0hpeGpPeklzSkFJeHg2UStSOUxp?=
 =?utf-8?B?U2tSZmduQ1ZoQ213N1NZVWtzSkcvM3JPVUk1WDhtSzRoZmFZSTE5dXYwOGpn?=
 =?utf-8?B?QTZnRU9oSVZWL1VVZlRQekMvcG80dnZEL1hoT3RBNmlsdVU3MU5vTGJkQnNY?=
 =?utf-8?B?K295WmpWeDZCZGlSRHBvVmhHcTh2YkxjeFVHVU5kZFkzUjkwdEpiS1hoM3R6?=
 =?utf-8?B?V1BZTW9NckRYTHNOa0krZzJLM0xRUENKc1U4cGRWc0h6cGFnQVV2SURHRm5a?=
 =?utf-8?B?THBRWDdDbXlOQWJkbnExSFVmSkZOV05FYUhqbDdaSUx6Yjh1Qy9LcXc0NXRj?=
 =?utf-8?B?c0FaK0hVd0NIdEhWREd5WGd0NldoSnB6UlkzY0xCYkt3dEJlaFVDc1JFU0gw?=
 =?utf-8?B?ZTkrVEszZ3N4aTREZXlGbmh1S2FSWEl4MTk2cHBkWGI4R1NFZ1ZXcytEMXUy?=
 =?utf-8?B?aG9FWUkwU05wYzg1dDlGbE5pYTVyUXpsaUVnZklhZ2FFN1Z2MTExMEZrM2kw?=
 =?utf-8?B?Y3ZxNHAwWWQ3dGhkTlNDVjM3ZFNKdkpaaE9NVTgzQWJRbklid24veXZIWU9I?=
 =?utf-8?B?emNJOG1abGpCMG03OEI0ckMyeTNjSFVHL3Yrc1p5UlV5Ym5tQlNrS0RFb011?=
 =?utf-8?B?a2h3U213bU9UMkJ1ZlNnK1ppdFpMYXliZUltQW9tT1JBdTJOOVg3aXBLWnBN?=
 =?utf-8?B?d2pqUTdmRTJka2c1MG9BRUZ6SU1hN2lkaGNXU2lKdE5ZRGJXMmFlbmNFUUUv?=
 =?utf-8?B?OFVMUktvZUd0SGkvblM1YzFnYUxSMytCV05WT1R2TFZRQWlqVHVZSzRjZ2Er?=
 =?utf-8?B?UXZHN1BxVzNwTTVUbVNrTEdRaXpucW1CMXArSmpVM3FuRGZOcERodXlyUVp1?=
 =?utf-8?B?YjJIbm00WUw1Wk9WSm1tcHZrTWVJSkdRNVltOTc0WDBJQXV6dWJvOVRrQTRE?=
 =?utf-8?B?aUgvVlZGNVh6TUxrbEJXTHlJVmczc1VxSTMxV2xkcUVBWHNtdkpETEgzWUJs?=
 =?utf-8?B?amNPTGdzT1AxbndieFRTUjUyY1RrN2xNbkdpRWN4bjRobUpnOWNlYmRmSHdJ?=
 =?utf-8?B?dSsxSHZQNS9FN1dvNWZxUUNrNVlURXhjcDEvRkRNU21wUkRTTlJKNUx4b1Rx?=
 =?utf-8?B?UlhveHhXK0FDU2dvc0NYYVRjb1VIUHdvUUJGZkRBTG1RR29pK3V1TWZUK2tD?=
 =?utf-8?B?QXp2bWEydVVlV0UzcmVjVEYzWDhyMHNkKzhncmRnRzF5Ym1xRElBODkrWE4x?=
 =?utf-8?B?UStxc0ZjVUVzbHJqeVdzOE9vUHBpZUpLVFBLVXJUQ3MyRWs3blZGbDgycVZI?=
 =?utf-8?B?SjU3OTZ1VjMrOUswemswcmpNY1ZHWndEL29pOEkrYTFkRk1TNC9QY2lOc2lr?=
 =?utf-8?B?ams4LytucVJmTVZMcm5Ob3hoOHB1c0hmVUxTbjErb3NnU0FSNWxPYUV5RlQ1?=
 =?utf-8?B?ZkQxY3dDU0tndW95RVJscm5kSHdMYUM5MytnU1lzL05kU2VGTHhmajd3Z0NY?=
 =?utf-8?B?d1RDYVNXMjJOQmgvWjcrYUl4cVp4OTdTeUxYTk93TnZnL2ptL0tVdHZZcE1l?=
 =?utf-8?B?YVRrTS9xRStGVm40L0xGT091c1N1RENiaVNvSmVxeVpoY3U1RkpBZTJIMjlK?=
 =?utf-8?B?bUJhS3RkYWNPVzN2bXlFcFQzMVROOUFtdlBNZGxHVFp6SVhrVjNHVmNJR1dH?=
 =?utf-8?B?YnBRdDU3aGlQdFllSml6UU5Zd09KWlJzMCszcW8rQTMwOEZsT21SNjYzVjRZ?=
 =?utf-8?B?NklEeGpMaEF3SEZ1TzRxdjVnejlTRG1kUEMrdk9SRjV1N1BSdTBMOEh4M1Z5?=
 =?utf-8?B?cWQ5SkVXTUNsNG1MSTI4a2lzckxhRHZRa3JvLzNvU0g1Zys2NUk1VDluSkZL?=
 =?utf-8?B?OGhaaG9YSngva1JsQWRKU2dvQ2FOeXpydUx2N3RQTjBwL2F6SUR1M3pNQXAy?=
 =?utf-8?B?SDVHTmpMMHk3YkRJQWJORHl4dmp4bnVwZnoxVUxDMTdsdGYvdDcrZTFUTUVP?=
 =?utf-8?Q?eM015bxYJum7eWd0ej?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b184d20b-787d-4b76-425e-08dee385813b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:59:27.3444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DBwWcDHsC8caowLKQTo7LxmTt0x05/NMYehRXNIIckrnnebRTdfJpOEpbL2arx34Xtrt3OkJ3y9ywziEqs0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

On 7/13/26 22:28, Suraj Kandpal wrote:
> drm_writeback_get_out_fence() does not itself need the parent
> drm_connector object, but update it to take drm_connector for
> consistency across the writeback interface, which is being moved
> to use the top level drm_connector and traverse down to
> drm_writeback_connector rather than passing in the lower level
> object and traversing back up.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
> ---
> v5 -> v6:
> - Rebase over latest kernel
> 
> v3 -> v4:
> - Update subject line for consitency (John)
> - Update commit message across commits for consitency (John)
> 
>   drivers/gpu/drm/drm_atomic_uapi.c | 4 +---
>   drivers/gpu/drm/drm_writeback.c   | 4 ++--
>   include/drm/drm_writeback.h       | 2 +-
>   3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index a5c11832ff64..2271cd970985 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1492,7 +1492,6 @@ static int prepare_signaling(struct drm_device *dev,
>   	}
>   
>   	for_each_new_connector_in_state(state, conn, conn_state, i) {
> -		struct drm_writeback_connector *wb_conn;
>   		struct drm_out_fence_state *f;
>   		struct dma_fence *fence;
>   		s32 __user *fence_ptr;
> @@ -1514,8 +1513,7 @@ static int prepare_signaling(struct drm_device *dev,
>   		f[*num_fences].out_fence_ptr = fence_ptr;
>   		*fence_state = f;
>   
> -		wb_conn = &conn->writeback;
> -		fence = drm_writeback_get_out_fence(wb_conn);
> +		fence = drm_writeback_get_out_fence(conn);
>   		if (!fence)
>   			return -ENOMEM;
>   
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index df8484a7aa03..d2ccb4dcba0a 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -531,10 +531,10 @@ drm_writeback_signal_completion(struct drm_connector *connector,
>   EXPORT_SYMBOL(drm_writeback_signal_completion);
>   
>   struct dma_fence *
> -drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
> +drm_writeback_get_out_fence(struct drm_connector *connector)
>   {
>   	struct dma_fence *fence;
> -	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   
>   	if (WARN_ON(connector->connector_type !=
>   		    DRM_MODE_CONNECTOR_WRITEBACK))
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 5e8ab51c2da4..2afa48ea7c00 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -104,5 +104,5 @@ drm_writeback_signal_completion(struct drm_connector *connector,
>   				int status);
>   
>   struct dma_fence *
> -drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector);
> +drm_writeback_get_out_fence(struct drm_connector *connector);
>   #endif

