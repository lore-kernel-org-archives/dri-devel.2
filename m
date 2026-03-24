Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614BBF54ADB
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C293D8911F;
	Tue, 24 Mar 2026 17:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAVjWNbD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0B68911F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC8NkgFcaI+uatrvO7OoftAOtcO134inaNf1Tmy7NVitBuR3FDit3NK8i9UVSISxvxd+gLnNcCgH18Ht9zPQcwr/hyQqSKn4hcGBnlFZsTeCslscuEjKSEWODmRymFAv4bLFrNVK2Bcs4n4enhPkQDNQuj0IUxd60s3wUSJPERjzxoMqxT10tVUTNzkxaaC9VZKY2QUfDmDjjr9/6iBb5WeVQXV5E1M7VSi1Fpb2T9GkwZgvkWBtqlQzGZgS5Sz/Kp/jQD3IQgeF+1vELoifnnmkEX5wmUFHfEG2kXQbs1L00o6jNJXSI9MnY/MpFaZkmLbNK6m6i7xRy9w9Ssr4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4m2Ax77mnJBbNwXXtBmTVJGskjali8W/CCtrHRm1rw=;
 b=noEEh+8tFXgCmLPzWkiW8Dc1LDuCS0RRfEJmZM3pAEPY+HO2f/329b/fcZFli5dmLa9SyykF7B6QPbLN0pyncafJOUyJcsI8eXAwqJ/A2z8ZSuJHrqaFTKTO2S+BarqM6WFxyD7s65j3ronaJGenEjTTN2jEC+BgHxpyzq9l2uzhahoTZjsSaZIBbs9NmLLR+grbip7exMqhFFDOGSCBMFAFJ8e9zIQdrSTZ8QJ8B0jQ+I1YYCO8tQZyKiNpHEuTaYDUViUHmh1ov2BSrHEBs7T8/dBz0HPeNIak5+h0ns8W7mTelnGdeFa3Ha5EfI8964S5AFl/owzmqLsm7GdhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4m2Ax77mnJBbNwXXtBmTVJGskjali8W/CCtrHRm1rw=;
 b=HAVjWNbD3mLQjPCVvGSt8kC4ku9fBdh4kjyOj/49CI79F4CVh+fFIC+Mw4h5aJWT9FQtMx1xGuVdcsyibqmGVsS0JfzK1YoFxUY1CdQi1REHCs1VrTUq5Lh8AwcScnD3oxGU2WaE0/d9QkGZhxk0HQV1Fg3wG+O+rI6Ghsum8i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:01:40 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 17:01:39 +0000
Message-ID: <1e573513-b281-4ae3-9140-7a87ee9dab08@amd.com>
Date: Tue, 24 Mar 2026 12:01:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add per-process BO memory usage query
 support
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260324163159.2425461-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260324163159.2425461-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::34) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: ab383397-b0bf-4700-62c3-08de89c70419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: zwStEe4ExM1qKYipnNPARWzu+BiEwFXHOwr+GdG6euaFoAn3yM+2hwb/g54+vBuDVDsL/hFGUaMCsCky4tplEU6iwqIMgsEx+hI/5I1Qynh/tSnfeeYRCs4vWDXsT61VY9sWX5dhNpeNgU8RSyGq747NoQEM/s1jjOeMC8Gc9y3cHjhXu9Yp4yDL07hqMGHfEZBJ4YYJ4lRXHr0Scog8NxPsQsVZ0OdvaN8koC7bQ5jBls/pV6XGiAsBUTRPajuYZ1mu0dAnUccF1vVZfGAPKIZKgLn4gvv5v9zD9OBg/1lZe3LIj3BhL63dPhzPUnbgbCG4YAH/uunYA+f/ivLfAY+l8bq0LBSqp4pXA7eAKH33mrLpHb55byVhmvAmti8zXRRiryveAkMLRtH2KBkpEjMepYQV0weC5EzGobwTpaAflxCnwOnxWFRv75YVCK06U47A2xv3A6aO1eCX+qWWrhKDIiwbq2frbozVd+mwzPxvJrB2OHTaS/7SIE1L5lCgR3WJT+s8A1ZiSfq1Ij6GQ6d9tW1wOF4ljsZMxQu+2fOfnp9FAWwaxpryk60jhdrUbDTTC0sGo0Y3UExkVpukTWAr8SJ4hS2tVAILVRqXGpPtUaX8G6oQmpQyUlMVJ0OEyehryQg6O9ZNpWE0Ftal6WJGXUshRAhtcocc5jCr97q71FtgETFzMk2KPSFjvBhlK8CIhhgnAFp6akTbhsq/Wye3W74J1sbJIOvdVk4t91w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zlo1Z3BUb2x1cE5LSy9ORkVxNEVHMGI0R0NINUlEdW5adjJhSXFyNHBUZ3ZG?=
 =?utf-8?B?bDNlbFVoNTI4dXFuWk9WUVBBSVVLcVp0cThQRVlPOWNQeHQ0b0ZzcWVhaDdp?=
 =?utf-8?B?bmNxZVNDKzVta1V3anZMWGRrNjA0NTdRQkhMVWpER0dmdmhBbURVclRSaUVS?=
 =?utf-8?B?L0I4bXJvZGd0dkpZZWlqSW9Ed3hiMlQxbUtnQXdMYTVrMjlGTmw1VjcwNmVI?=
 =?utf-8?B?UmNmM1BLQzlCUEZjbE4zWmlwTnRpZ0pUa1lpVlp6Rkx2bE9VZ29Kb3Q2UXpG?=
 =?utf-8?B?L3lidnl0MmVCekVtUVQwKzhQOWdzaGcvTVhITjVKUWN0dmhtVTNuWnh4S3Zz?=
 =?utf-8?B?c1RncDF1a0JxejdQeGdkeUhUWWZKNUFRUDFjRE9LY0lkcjV0Y3dxYVYrNXhE?=
 =?utf-8?B?SjhSVWhCRVJLZWFBb3oyWDlVVkdNZGNSN3pPd0pXRHNXam9JditzaURPb3p2?=
 =?utf-8?B?dnhQanRYdE52OTF4YjNNTEovMUJzSEs2RlkydEI0RkgwQXdDc0tUUERuZ1lU?=
 =?utf-8?B?WE9leUp0RzFobURVZmk4ZVQ1bTY4bDFBRUdtUVBqVGM0ajdiZ2g0bldMYUl2?=
 =?utf-8?B?TG1LV0Fpc3Q2TCtvVTBYTjA0Y2dPT2lMNEdiMWoveUU1KzdyVVdKU2xSTXBh?=
 =?utf-8?B?TmNhdDExK2REeTZOY0hJMzNVZlBZdHR0bzRaY3Z3d2l3aXhHWlpFV2FXTHFu?=
 =?utf-8?B?eUMzQzAwR3ZydENFaDZNZFl3eHBTS0hIVEZUR0VldE9TRlZiR201WW9pMHQ1?=
 =?utf-8?B?WjhON3NGaFBFa1Jxc3pEcnpVSU1QaDN1bjFkSFJWOVBzWE96THVwa3dXL0Fy?=
 =?utf-8?B?NUlGOWk4ZE5aL2NOOXl4ZW5LVGhrc3NyUEVMZVl1aS8zYy93Q0c5cjRKNERs?=
 =?utf-8?B?dzl4eFVTamM4UnRWZ1kveCtMelNpL3g5MzQ3TjlIclNhRlNCZ2VyUktoSHhY?=
 =?utf-8?B?Qll6SG0wQjRFWEpBeCtLMmRZYk9CeUc0NmFXVE83MjNoV2ZNWGFxMEg0Y21D?=
 =?utf-8?B?dU9zY0NxVlpVTFNQVWU2MHJxZUlKaEpHenJEYjhlelAzUEErUC9hYWgxY0FE?=
 =?utf-8?B?SkQycVRnS05zVHhsaGJOZmhmQW0vd3BQQ1JHUWIvWnlOS2UzK29JZ2diU1JH?=
 =?utf-8?B?SS9memQ2aXZkNVY5eWVvZXNzcFlwMllDMjlwc3g0Q1owWUR2ajk1bEZRQ3h3?=
 =?utf-8?B?cG40cWdSSVZDSWRkWmpoYyt4TlFFZzloNFgzMkplTGU4QlNVaTl4UkMzVXJy?=
 =?utf-8?B?ZzB4M213a1ZtQS94SHN4b0xoTU5uYmJ3RndFbXNpaEE0ejlzOE5BdXRYS3Zu?=
 =?utf-8?B?b3BQandyblV2eXczeGpEZXRIUlplek0vSGs2TjlaWjRSdmwvbEkzQVN1OVNm?=
 =?utf-8?B?OXF5RWZYZVJJMmZHbmJuWWoxTUpKSUR6OVk0WXhhQlk4dkszeDlJVCtKVjNR?=
 =?utf-8?B?MGVzLzNTdWZFWFpPcU9vTmc5aEhjM2phWFVrUEd6SDJnZHNhWHFRSUtVckVy?=
 =?utf-8?B?ZS8xMmhCb1Z0T1FCanhMVUV6SEt6R3c5UnBJampFOFlrajQ4Rkd0ZjBJNEI0?=
 =?utf-8?B?ODA0a1NsRTdxUlRWZ2V6Qm9ZWUwyd2p3a1pNUG5iU1pFWW5LZXFMM2UxNVRi?=
 =?utf-8?B?WjJVNzRUS1Y0SFZnL0ozSkFoT3FWWjR0VHJ1Yk1wb1RZRVR4S0N1aWZkdjk2?=
 =?utf-8?B?ajZ0THZ6aUlOa0hGTjdrRXFKZ3AwdDJpdzYwU1pjaWIvQlpYZHorUjlRanN4?=
 =?utf-8?B?MnNVd08zYm14NmJ6eks3cEF1c3JOWFBvMnhyWGx4OVJIb1VyZCthOVRocTMx?=
 =?utf-8?B?UExVOXo0MzE3djNFU05MbDZNQldwVW5LQXRXMUdEWTRVRVFmQnU2Zkt3ZTlH?=
 =?utf-8?B?WUJ6NENkNjlLbjNTRFhNcjZaNTNCajUwUXl2VFEwQitqRGxySDRCR0ZIbGFK?=
 =?utf-8?B?YzNJVWZqK2tHbXdzajY1bmNXV29nMFFQa2pNY1VSVkxwVUE1c1JSWEV1ZXEr?=
 =?utf-8?B?L05GV0tVbmhEZFVrbXYrQ0F3UjVvd2xkU3RjZnRIcGtJK1ZVcytrUSt6UENB?=
 =?utf-8?B?enhEWDUyY2IzMW9VWC9VRW9DdWxxeG9iRFNOSnRkUnpUWnJ0OTdyVlM3NFlL?=
 =?utf-8?B?LzNHQXluRWlvOFZzZW0rMmlQdFdYaExhSW16UGZlckVlWldtblk2dU1pSHpV?=
 =?utf-8?B?aXA5UmtVNlpOdzNZeE1aVW5CRmZJd0pVVWdRbklYNzBCNm1UZEdlTGl2Uytl?=
 =?utf-8?B?SnMySDJjcWhkdEgxbDdjc3VQTXR2QkVwWVFCVG9lWVB2eGRvNXI0RjNOT2s4?=
 =?utf-8?Q?KK8cqtSI2FnANaEyQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab383397-b0bf-4700-62c3-08de89c70419
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:01:39.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIQIzglpFbjjKwDYXUcg1V2/dxqu52OoTiE1PmrywyrNF7M24HtadhhNJrh7YcwboaQLfcyVUs6saw02B9Z8ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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



On 3/24/26 11:31, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Add support for querying per-process buffer object (BO) memory
> usage through the amdxdna GET_ARRAY UAPI.
> 
> Introduce a new query type, DRM_AMDXDNA_BO_USAGE, along with
> struct amdxdna_drm_bo_usage to report BO memory usage statistics,
> including heap, total, and internal usage.
> 
> Track BO memory usage on a per-client basis by maintaining counters
> in GEM open/close and heap allocation/free paths. This ensures the
> reported statistics reflect the current memory footprint of each
> process.
> 
> Wire the new query into the GET_ARRAY implementation to expose
> the usage information to userspace.
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
I'm assuming you also have userspace side ready for this too right?
If you have a link handy can you please include it when committing.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/accel/amdxdna/aie2_pci.c        |   4 +
>   drivers/accel/amdxdna/amdxdna_gem.c     | 134 ++++++++++++++++++++++--
>   drivers/accel/amdxdna/amdxdna_gem.h     |   7 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   6 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +
>   include/uapi/drm/amdxdna_accel.h        |  35 +++++++
>   6 files changed, 177 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 9e39bfe75971..f1ac4e00bd9f 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -865,6 +865,7 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
>   	tmp->command_submissions = hwctx->priv->seq;
>   	tmp->command_completions = hwctx->priv->completed;
>   	tmp->pasid = hwctx->client->pasid;
> +	tmp->heap_usage = hwctx->client->heap_usage;
>   	tmp->priority = hwctx->qos.priority;
>   	tmp->gops = hwctx->qos.gops;
>   	tmp->fps = hwctx->qos.fps;
> @@ -1148,6 +1149,9 @@ static int aie2_get_array(struct amdxdna_client *client,
>   	case DRM_AMDXDNA_HW_LAST_ASYNC_ERR:
>   		ret = aie2_get_array_async_error(xdna->dev_handle, args);
>   		break;
> +	case DRM_AMDXDNA_BO_USAGE:
> +		ret = amdxdna_drm_get_bo_usage(&xdna->ddev, args);
> +		break;
>   	default:
>   		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>   		ret = -EOPNOTSUPP;
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 27712704e42d..238ee244d4a6 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -63,6 +63,8 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>   		goto unlock_out;
>   	}
>   
> +	client->heap_usage += mem->size;
> +
>   	drm_gem_object_get(to_gobj(heap));
>   
>   unlock_out:
> @@ -74,16 +76,17 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
>   static void
>   amdxdna_gem_heap_free(struct amdxdna_gem_obj *abo)
>   {
> +	struct amdxdna_client *client = abo->client;
>   	struct amdxdna_gem_obj *heap;
>   
> -	mutex_lock(&abo->client->mm_lock);
> +	mutex_lock(&client->mm_lock);
>   
>   	drm_mm_remove_node(&abo->mm_node);
> -
> -	heap = abo->client->dev_heap;
> +	client->heap_usage -= abo->mem.size;
> +	heap = client->dev_heap;
>   	drm_gem_object_put(to_gobj(heap));
>   
> -	mutex_unlock(&abo->client->mm_lock);
> +	mutex_unlock(&client->mm_lock);
>   }
>   
>   static struct amdxdna_gem_obj *
> @@ -102,6 +105,8 @@ amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
>   	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
>   	abo->mem.uva = AMDXDNA_INVALID_ADDR;
>   	abo->mem.size = size;
> +	abo->open_ref = 0;
> +	abo->internal = false;
>   	INIT_LIST_HEAD(&abo->mem.umap_list);
>   
>   	return abo;
> @@ -508,13 +513,55 @@ static void amdxdna_imported_obj_free(struct amdxdna_gem_obj *abo)
>   	kfree(abo);
>   }
>   
> +static inline bool
> +amdxdna_gem_skip_bo_usage(struct amdxdna_gem_obj *abo)
> +{
> +	/* Do not count imported BOs since the buffer is not allocated by us. */
> +	if (is_import_bo(abo))
> +		return true;
> +
> +	/* Already counted as part of HEAP BO */
> +	if (abo->type == AMDXDNA_BO_DEV)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void
> +amdxdna_gem_add_bo_usage(struct amdxdna_gem_obj *abo)
> +{
> +	struct amdxdna_client *client = abo->client;
> +
> +	if (amdxdna_gem_skip_bo_usage(abo))
> +		return;
> +
> +	guard(mutex)(&client->mm_lock);
> +
> +	client->total_bo_usage += abo->mem.size;
> +	if (abo->internal)
> +		client->total_int_bo_usage += abo->mem.size;
> +}
> +
> +static void
> +amdxdna_gem_del_bo_usage(struct amdxdna_gem_obj *abo)
> +{
> +	struct amdxdna_client *client = abo->client;
> +
> +	if (amdxdna_gem_skip_bo_usage(abo))
> +		return;
> +
> +	guard(mutex)(&client->mm_lock);
> +
> +	client->total_bo_usage -= abo->mem.size;
> +	if (abo->internal)
> +		client->total_int_bo_usage -= abo->mem.size;
> +}
> +
>   static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>   
> -	XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, amdxdna_gem_dev_addr(abo));
> -
>   	amdxdna_hmm_unregister(abo, NULL);
>   	flush_workqueue(xdna->notifier_wq);
>   
> @@ -543,9 +590,13 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
>   	int ret;
>   
>   	guard(mutex)(&abo->lock);
> +	abo->open_ref++;
>   
> -	if (!abo->client)
> +	if (abo->open_ref == 1) {
> +		/* Attached to the client when first opened by it. */
>   		abo->client = filp->driver_priv;
> +		amdxdna_gem_add_bo_usage(abo);
> +	}
>   	if (amdxdna_iova_on(xdna)) {
>   		ret = amdxdna_iommu_map_bo(xdna, abo);
>   		if (ret)
> @@ -555,6 +606,20 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
>   	return 0;
>   }
>   
> +static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
> +
> +	guard(mutex)(&abo->lock);
> +	abo->open_ref--;
> +
> +	if (abo->open_ref == 0) {
> +		amdxdna_gem_del_bo_usage(abo);
> +		/* Detach from the client when last closed by it. */
> +		abo->client = NULL;
> +	}
> +}
> +
>   static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>   {
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> @@ -575,6 +640,7 @@ static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
>   static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>   	.free = amdxdna_gem_obj_free,
>   	.open = amdxdna_gem_obj_open,
> +	.close = amdxdna_gem_obj_close,
>   	.print_info = drm_gem_shmem_object_print_info,
>   	.pin = drm_gem_shmem_object_pin,
>   	.unpin = drm_gem_shmem_object_unpin,
> @@ -708,10 +774,13 @@ amdxdna_drm_create_share_bo(struct drm_device *dev,
>   	if (IS_ERR(abo))
>   		return ERR_CAST(abo);
>   
> -	if (args->type == AMDXDNA_BO_DEV_HEAP)
> +	if (args->type == AMDXDNA_BO_DEV_HEAP) {
>   		abo->type = AMDXDNA_BO_DEV_HEAP;
> -	else
> +		abo->internal = true;
> +	} else {
>   		abo->type = AMDXDNA_BO_SHARE;
> +		abo->internal = args->type == AMDXDNA_BO_CMD;
> +	}
>   
>   	return abo;
>   }
> @@ -783,6 +852,11 @@ amdxdna_drm_create_dev_bo(struct drm_device *dev,
>   	gobj = to_gobj(abo);
>   	gobj->funcs = &amdxdna_gem_dev_obj_funcs;
>   	abo->type = AMDXDNA_BO_DEV;
> +	abo->internal = true;
> +	/*
> +	 * DEV BOs cannot be alive when client is gone, it's OK to
> +	 * always establish the connection.
> +	 */
>   	abo->client = client;
>   
>   	ret = amdxdna_gem_heap_alloc(abo);
> @@ -826,7 +900,7 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_f
>   	if (IS_ERR(abo))
>   		return PTR_ERR(abo);
>   
> -	/* ready to publish object to userspace */
> +	/* Ready to publish object to userspace and count for BO usage. */
>   	ret = drm_gem_handle_create(filp, to_gobj(abo), &args->handle);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Create handle failed");
> @@ -986,3 +1060,43 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   	drm_gem_object_put(gobj);
>   	return ret;
>   }
> +
> +int amdxdna_drm_get_bo_usage(struct drm_device *dev, struct amdxdna_drm_get_array *args)
> +{
> +	size_t min_sz = min(args->element_size, sizeof(struct amdxdna_drm_bo_usage));
> +	char __user *buf = u64_to_user_ptr(args->buffer);
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> +	struct amdxdna_client *tmp_client;
> +	struct amdxdna_drm_bo_usage tmp;
> +
> +	drm_WARN_ON(dev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	if (args->num_element != 1)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&tmp, buf, min_sz))
> +		return -EFAULT;
> +
> +	if (!tmp.pid)
> +		return -EINVAL;
> +
> +	tmp.total_usage = 0;
> +	tmp.internal_usage = 0;
> +	tmp.heap_usage = 0;
> +
> +	list_for_each_entry(tmp_client, &xdna->client_list, node) {
> +		if (tmp.pid != tmp_client->pid)
> +			continue;
> +
> +		mutex_lock(&tmp_client->mm_lock);
> +		tmp.total_usage += tmp_client->total_bo_usage;
> +		tmp.internal_usage += tmp_client->total_int_bo_usage;
> +		tmp.heap_usage += tmp_client->heap_usage;
> +		mutex_unlock(&tmp_client->mm_lock);
> +	}
> +
> +	if (copy_to_user(buf, &tmp, min_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index a77d9344f8a4..4fc48a1189d2 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -41,8 +41,9 @@ struct amdxdna_gem_obj {
>   	struct amdxdna_client		*client;
>   	u8				type;
>   	bool				pinned;
> -	struct mutex			lock; /* Protects: pinned, mem.kva */
> +	struct mutex			lock; /* Protects: pinned, mem.kva, open_ref */
>   	struct amdxdna_mem		mem;
> +	int				open_ref;
>   
>   	/* Below members are initialized when needed */
>   	struct drm_mm			mm; /* For AMDXDNA_BO_DEV_HEAP */
> @@ -50,6 +51,9 @@ struct amdxdna_gem_obj {
>   	u32				assigned_hwctx;
>   	struct dma_buf			*dma_buf;
>   	struct dma_buf_attachment	*attach;
> +
> +	/* True, if BO is managed by XRT, not application */
> +	bool				internal;
>   };
>   
>   #define to_gobj(obj)    (&(obj)->base.base)
> @@ -98,5 +102,6 @@ void amdxdna_gem_unpin(struct amdxdna_gem_obj *abo);
>   int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +int amdxdna_drm_get_bo_usage(struct drm_device *dev, struct amdxdna_drm_get_array *args);
>   
>   #endif /* _AMDXDNA_GEM_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index d83be00daf2b..b50a7d1f8a11 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -36,9 +36,10 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
>    * 0.5: Support getting telemetry data
>    * 0.6: Support preemption
>    * 0.7: Support getting power and utilization data
> + * 0.8: Support BO usage query
>    */
>   #define AMDXDNA_DRIVER_MAJOR		0
> -#define AMDXDNA_DRIVER_MINOR		7
> +#define AMDXDNA_DRIVER_MINOR		8
>   
>   /*
>    * Bind the driver base on (vendor_id, device_id) pair and later use the
> @@ -120,11 +121,12 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
>   	amdxdna_hwctx_remove_all(client);
>   	xa_destroy(&client->hwctx_xa);
>   	cleanup_srcu_struct(&client->hwctx_srcu);
> -	mutex_destroy(&client->mm_lock);
>   
>   	if (client->dev_heap)
>   		drm_gem_object_put(to_gobj(client->dev_heap));
>   
> +	mutex_destroy(&client->mm_lock);
> +
>   	if (!IS_ERR_OR_NULL(client->sva))
>   		iommu_sva_unbind_device(client->sva);
>   	mmdrop(client->mm);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index e91d14ae5190..0661749917d6 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -138,6 +138,10 @@ struct amdxdna_client {
>   	struct iommu_sva		*sva;
>   	int				pasid;
>   	struct mm_struct		*mm;
> +
> +	size_t				heap_usage;
> +	size_t				total_bo_usage;
> +	size_t				total_int_bo_usage;
>   };
>   
>   #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index bddaaaf945cf..61d3686fa3b1 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -591,8 +591,37 @@ struct amdxdna_async_error {
>   	__u64 ex_err_code;
>   };
>   
> +/**
> + * struct amdxdna_drm_bo_usage - all types of BO usage
> + * BOs managed by XRT/SHIM/driver is counted as internal.
> + * Others are counted as external which are managed by applications.
> + *
> + * Among all types of BOs:
> + *   AMDXDNA_BO_DEV_HEAP - is counted for internal.
> + *   AMDXDNA_BO_SHARE    - is counted for external.
> + *   AMDXDNA_BO_CMD      - is counted for internal.
> + *   AMDXDNA_BO_DEV      - is counted by heap_usage only, not internal
> + *                         or external. It does not add to the total memory
> + *                         footprint since its mem comes from heap which is
> + *                         already counted as internal.
> + */
> +struct amdxdna_drm_bo_usage {
> +	/** @pid: The ID of the process to query from. */
> +	__s64 pid;
> +	/** @total_usage: Total BO size used by process. */
> +	__u64 total_usage;
> +	/** @internal_usage: Total internal BO size used by process. */
> +	__u64 internal_usage;
> +	/** @heap_usage: Total device BO size used by process. */
> +	__u64 heap_usage;
> +};
> +
> +/*
> + * Supported params in struct amdxdna_drm_get_array
> + */
>   #define DRM_AMDXDNA_HW_CONTEXT_ALL	0
>   #define DRM_AMDXDNA_HW_LAST_ASYNC_ERR	2
> +#define DRM_AMDXDNA_BO_USAGE		6
>   
>   /**
>    * struct amdxdna_drm_get_array - Get information array.
> @@ -605,6 +634,12 @@ struct amdxdna_drm_get_array {
>   	 *
>   	 * %DRM_AMDXDNA_HW_CONTEXT_ALL:
>   	 * Returns all created hardware contexts.
> +	 *
> +	 * %DRM_AMDXDNA_HW_LAST_ASYNC_ERR:
> +	 * Returns last async error.
> +	 *
> +	 * %DRM_AMDXDNA_BO_USAGE:
> +	 * Returns usage of heap/internal/external BOs.
>   	 */
>   	__u32 param;
>   	/**

