Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FF5C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF52A10E48B;
	Wed, 23 Sep 2026 07:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hs1cuidE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6B710E28D;
 Wed, 23 Sep 2026 07:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGZb1UhVYmSgOaY/uVNwbjlebaout83wMdxFDeOCbkwpaAE+4beIZi9VxYUd4xa+UZIz0ELAicp4Bsbx9kcSosUJ+ituSZpugNLuW3/vD39IDQmjxctp49Tzts3DEtXfUNW/gL8p/15tpUuQcGE6//GOD84AtLr/1FIVWH9J595j10A9Dzq8l4XdQljuyptzSbxLWfBsU8ykkPht8VL2wGo6xKeLUCiIokSK+JxbOFMCme25S0+cs3PXiQtKYFLbSGg3UzMjjdPThJXBNRJ/ofrOhXJM/9mMCkbK0LfJBwWe/SnQ3eJaRKjlgMLmS7j3F9WcGAUmhA5dv4F/5CEFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQAj1IK29hoNVxHyI5L7t2bAeos1ycllaBoVZGyH8hM=;
 b=r2uWGkTfIxkurlbGBi9bExlE1AghGJBx+4QASY8IWYT7GOZ6VG0y6zt5zcMEl+IUsCIbZnAFlcoyl5zGmF9sGQVGdjURCjqX1wAR8Xi7P3RFlQ6QW6B8kFlkxGbeYpfUCLPMWPc74DIjcYE30jJ7CsytyXakbg+WONJTTHq0jAv1SSRIm4LcjTx9/fmpYDilhhr3iG2PD6CIvUyuSNXxHF59+afBLg+q/kk6/GLLANdDivvH8/4tMvRyIqHI80ryFC+1lU2QjFF++M8wP9bC/LHpPm6y+k61STWjt9qrThJPJPccBxRVEaJi3ra2jDF69f4Bxj4aeNMbYhNtiZ0P+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQAj1IK29hoNVxHyI5L7t2bAeos1ycllaBoVZGyH8hM=;
 b=Hs1cuidEYBqjptl90kOffjIF8mqq4VGsL9tEQKrVYeIIYNe+g+VVPPC3nZAGBHuHWHtRO2LlN+3KNmWM9LPUv4aUU2iiRFiAGniojoMIULNXrTYU4F6uVVuF383p5E+tdnW3fUF+w/6uEy5pLz3uIcJ5X1cprgwT2p8F49/cGUo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 07:35:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 07:35:11 +0000
Message-ID: <72e380d8-4b94-47d4-8721-a6f652dfd27b@amd.com>
Date: Wed, 23 Sep 2026 09:35:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-fence: deliver set_deadline callback even if fence
 is already signaled
To: Jeffrey Boody <jeffrey.boody@oss.qualcomm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260922-dma-fence-set-deadline-v2-1-2338d6fac9aa@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260922-dma-fence-set-deadline-v2-1-2338d6fac9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 12661f44-c5c2-4cee-4418-08df19453335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|921020|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Dxa6jf5h24t3dprcannc/5YJqCpEEyybnIY6ue/VYbUR1byyEDmoRraYT6tfJqr/ixoUAt/dqiKrcz3XiVMGwd/Uak/XFOxSNETWTL/uHJC+GdChD2pz8AJBDZtO0iEYB4+Ag1JXbcs/A5B7Htv44ZflCBzvMhzXne6/tRcmFtScebNnz4JXCaJKkiu7+lePm8f72r4w7tsaME6gHt0OTAYeeLhL0vfH6IKWzdaaDrOg6B/spQGb+wEjIrt7bdnRSrnLtFonANt4LHA80t0k8KqW3YJm3o6ruI+z+lerx4Do1aWsfCQ5MTRFgq5/UTUzIOAx1rC4snNq04bUyGT0LvtjC9luU5sblRIXNt7jMYlJmm5VRMVtMVQmXhfbvb8SR4YzsDRCt01EcNUPXdshC57vHFhLZv6JAzvLWSjs9h/ZSsOwYrojQxXZ6DqH18m9W6VUCzhG9rQWk2Z3UZ6SP1EV/VEac9zIbwAkcF9ptFgzJ1enP6K787UR/sB+dQLA1Bat7YZW0nmSDd+bLTgAQtC5MqNbzScEU7t2Kx9dEEKXfitVrtUYC92slxydzbUzBPvo7LGTgjwN+eeCwxGRaIS/VbZr6HpZkoU63daZdGF2bent/Qe8eHnHJRWHcBhEQSOZ0YsfRw7F6L1fec6cAsW9j12lobD0p3JJTDpVk/np/UzU/g9ce9banIpWn6m1nidS6pHs41U1LawuIqaM7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndQbWEzU2pkdG9sYXo4cmh1T2hQUjN3VkdGZTZZL0p1Rk0rRUhLNXVSVG9C?=
 =?utf-8?B?OFcwUnNmZjdySUdDOHJRSmlHa29SMmpCWjBjbEhqUjJWYTVoQjVzbUNzcU9V?=
 =?utf-8?B?bmVnRkxveG5xdUNaRklZRjc3Q3VEQXRrWHVpL0pQSzJhVGdBNGlVWVR4c0N2?=
 =?utf-8?B?YXZkeEVMdlRLcFRHVVk1bERtei8rWVFiWEhHT1FycnBBV01iQlBucmpnbDFi?=
 =?utf-8?B?dDBXYWRHcEk5OUlDdDlFZzNWYlNVUTJBZlpZNkc4b01TVzA1TnR2dnNGSW82?=
 =?utf-8?B?aEwzOE8vR1E2TUpvYVRqT3JGL3MxMUVOM0pCQWd0d1M1aUFTby84K3I0a29U?=
 =?utf-8?B?Wm1OSm45bnFpcUdaZ0QwTVQ5ZzJXNEtqNlZpVElOSGg5MDRNN2R0ODJhb1Zw?=
 =?utf-8?B?dkpsZFBIMUoxMGhvY1lDQ0I4VEVkZG81dUJPem05UkdDRlB0dUpLOWhPTjhY?=
 =?utf-8?B?S3NVK0tlRjlqU2l2TnNMM2VwWkVJMnRqM0o3alFMSnBqUHk1V2htWm5ST2ZD?=
 =?utf-8?B?NzN0VGlIV3pTSWl0d2p2K3N5ZU9IbFdCNVF5K3M3TElzQ3VMWjc4RWdvNTZ3?=
 =?utf-8?B?SUVZL3JIRVIrNmxwUkppbUNPUFBqU2QrdlBGeXlQN1MxaGtjdFRLVllxWlpX?=
 =?utf-8?B?KzhPTUlzRlJHcThHSGRZd2YwVXM3c2xaa1dIcWRIVUF3NGZQOGNzVEZUemcr?=
 =?utf-8?B?YXRzTkh5RzZmekZmK28zc1ZyNktYeWlOMTR1QUpwWnBaUnVEVzZNT3dsN1BQ?=
 =?utf-8?B?SzVyYWVwZ1Nxb3RSOUtEdUhpUFRjZU9ydGpPRStZNU0wcnZkNytBUUxTNm5E?=
 =?utf-8?B?RTEzVWtMS2ZoWGJqdXhmczR4Y2pXdmhScGVEMGd3RXV2T3A3ZFdMVDVFaGQx?=
 =?utf-8?B?NGkrVWdwTmVrSVdKOGk4UXlqMkpnb3hPTFdvdUd4UVlmSHZBdnFWT29paWx6?=
 =?utf-8?B?VjBQNE0zTDlKRUFYd0JwMlRSTWd2UTBVNXRnYWYyR0p5Y3FlMnNoMXVSVTQv?=
 =?utf-8?B?TzZxRjN3T0R6TXl2WXE5a2Q3WTB1MnlEeGtBVlJibmowbEQwNGZLMnJ2OTAw?=
 =?utf-8?B?dXdDL3J0V3hpa3A3T3IrbkFtbWZpQ2NwUXhiTy9Wa29CMmpDM3VHWWFwK2t1?=
 =?utf-8?B?aUdvbk9JZ0RNSzNBRnB1VUQrZ3NFMjlzRjIzUC9OR3hLUGtxTW8yT1hMVkFr?=
 =?utf-8?B?RXl6TDZrRWE1U0d3VlJ1aTdyeXVlSDgrQm8xSXNDek9FN09meXBYd0pwbHc5?=
 =?utf-8?B?blVsTnpaWTBTdjduMzZ2bERpYlA4SnpBZmZIZHArUEhNQWUyNmppNllXWXlp?=
 =?utf-8?B?d2pDZFdwb3hkVFdPZ0g2cDdhdkk3bUF2dm5NSFQ1V080NFliYWtCTXh3ek04?=
 =?utf-8?B?QjVXSzFScjhCSFo0YkF0SXlWODF3c0J2N01jTklzTStZUjdINzUvOFRJWndV?=
 =?utf-8?B?RldOMUY2WTc2OVZHR1JzWGs3SHZqTDQ4dEo3N1BLUlJHc05FOWpsNTFSNkJV?=
 =?utf-8?B?NklpUmxwdDByb3NZNFVOY3RnTk5naGZPR1ZtSEgwMnF2V3F2Mm1QVE1MRStV?=
 =?utf-8?B?WTVXTkpYc3NWZjh0b1NRQkQwR09obVlCL0wxSDFVZVArTFEyRHkrNVJIWFJz?=
 =?utf-8?B?aWkvaGFvOTRxZ1N4cmxTcHZUT1ZMbVBFTXIwejNFNU5iVVdNWldmVk55Q1A4?=
 =?utf-8?B?WlV0YkRrR0FqdFZBdnM5Mm5sOHFrRUQ1UHpHNGg0MGh2NUVFT0EwOXJwcUs2?=
 =?utf-8?B?bGNSVHBFVlYrVGMvTGdGa2tuV3lNdUlkSHljYWlmU2xlZmorSFNBWGoybDd6?=
 =?utf-8?B?alhCemJFUEdTZGU5bkxwRHp3TVRZM3pBcnRGNGo3cVJiUTFQZWtudmxxT2pG?=
 =?utf-8?B?ZXNBQ2RuSW5wTTNnOWt6R1VvNUJWVVRLNVNnQk9oejBLOFZzMVhzUmZ1ajha?=
 =?utf-8?B?TTdrWG1CQ1VvMmlLS0NEOHBDbW1wN3ZSNHA0SXFsb21YSlI4elVRekZ0WHZU?=
 =?utf-8?B?cDBWejlLdE9GaDRHY3FON0xub1lPSXpPOTRuM09JSWRUb1BOSTcyK3Vrck51?=
 =?utf-8?B?dG5RcE4xV0RtYTNYMk9GZHVxd0x5OFlyUUtTQ2NUMjF4NzZzUGsxRStJTDN2?=
 =?utf-8?B?Rld2ZHpPQU5xWE1JY0FtajVwWDhQSEs1dXhjRlFUOFZaRVVaVGxFZmtTRDJ2?=
 =?utf-8?B?NG5ySHdKWGxZTk5UdHdwR0NkbDdxaTcrT3hsUmxFVjhHd2xEUElvUkV5TjJj?=
 =?utf-8?B?VGxlOWcxYVpNTGFFcjMzUEh5RE5ScGdLTDROWWNIeU1GOTF3UGtPYldTN1Nv?=
 =?utf-8?Q?hDC7W5DKapMZ+MVVGf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12661f44-c5c2-4cee-4418-08df19453335
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:35:11.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USeAJnDWNRFYPycx1CX+0Cnoga76yTRYG1EjRKOb8nMFg88bU/6ZO59RD9h90ayB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

On 9/22/26 18:57, Jeffrey Boody wrote:
> The set_deadline callback is currently skipped if the fence has already
> been signaled. This prevents GPU drivers from performing power
> management adjustments when the deadline hint arrives after fence
> completion.
> 
> In triple-buffered rendering, a staged frame may be completed well
> ahead of the vblank deadline. When a display driver delivers the
> deadline hint, the fence has already been signaled and the callback is
> silently dropped. This leaves the GPU driver unable to evaluate the
> headroom between the fence signal time and the vblank deadline, and
> therefore unable to reduce GPU frequency when the target headroom is
> exceeded.
> 
> Remove the dma_fence_is_signaled() guard from dma_fence_set_deadline()
> so that the callback is invoked unconditionally when ops->set_deadline
> is present. Implementations of set_deadline must already tolerate
> concurrent and repeated calls; handling a post-signal invocation
> requires no additional locking. The fence signaler can compare the fence
> signal time against the supplied deadline to determine whether frequency
> scaling is warranted.

Sorry but I have to clearly reject that patch.

No callback whatsoever is allowed to be used after the fence has signaled or otherwise we break module unloading for the originator of the fence.

So that approach you want to have here simply doesn't work at all.

Regards,
Christian.

> 
> Signed-off-by: Jeffrey Boody <jeffrey.boody@oss.qualcomm.com>
> ---
> Signed-off-by: Jeff Boody <jeffrey.boody@oss.qualcomm.com>
> ---
>  drivers/dma-buf/dma-fence.c     | 22 ++++++++++++++++++++--
>  drivers/gpu/drm/msm/msm_fence.c |  3 +++
>  include/linux/dma-fence.h       | 11 ++++++++++-
>  3 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..ebc7c5ca6f69 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -999,8 +999,19 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>   * Multiple deadlines may be set on a given fence, even in parallel.  See the
>   * documentation for &dma_fence_ops.set_deadline.
>   *
> + * The deadline hint may also be delivered *after* the fence has already been
> + * signaled.  This is intentional and supports the case where a fence signaler
> + * aware of a periodic deadline (e.g. vblank) and the fence's signal time can
> + * evaluate the headroom between the two.  In triple-buffered rendering, for
> + * example, a staged frame that is completed well ahead of the vblank deadline
> + * represents excess headroom; delivering the deadline hint post-signal allows
> + * the fence signaler to consider reducing frequency for subsequent workloads,
> + * rather than holding an unnecessarily high frequency.  Implementations
> + * of &dma_fence_ops.set_deadline must therefore tolerate invocation on
> + * already-signaled fences.
> + *
>   * The deadline hint is just that, a hint.  The driver that created the fence
> - * may react by increasing frequency, making different scheduling choices, etc.
> + * may react by changing frequency, making different scheduling choices, etc.
>   * Or doing nothing at all.
>   */
> 
> @@ -1016,6 +1027,13 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>   * to aid in power management decisions, such as boosting GPU frequency
>   * if a periodic vblank deadline is approaching but the fence is not
>   * yet signaled..
> + *
> + * This function may also be called after the fence has already been
> + * signaled.  In that case the fence signaler can compare the fence's signal
> + * time against the deadline to determine the available headroom.  If the
> + * fence was signaled significantly ahead of the deadline, the fence
> + * signaler may choose to reduce frequency for subsequent workloads to
> + * avoid unnecessarily high power consumption.
>   */
>  void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>  {
> @@ -1023,7 +1041,7 @@ void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> 
>         rcu_read_lock();
>         ops = rcu_dereference(fence->ops);
> -       if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
> +       if (ops && ops->set_deadline)
>                 ops->set_deadline(fence, deadline);
>         rcu_read_unlock();
>  }
> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
> index 3dca8e09c192..3c5de96d4092 100644
> --- a/drivers/gpu/drm/msm/msm_fence.c
> +++ b/drivers/gpu/drm/msm/msm_fence.c
> @@ -136,6 +136,9 @@ static void msm_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>         unsigned long flags;
>         ktime_t now;
> 
> +       if (dma_fence_is_signaled(fence))
> +               return;
> +
>         spin_lock_irqsave(&fctx->spinlock, flags);
>         now = ktime_get();
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index ffa99b930843..839ef2e5dad9 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -264,7 +264,16 @@ struct dma_fence_ops {
>          * an upcoming deadline, such as vblank, by which point the waiter
>          * would prefer the fence to be signaled by.  This is intended to
>          * give feedback to the fence signaler to aid in power management
> -        * decisions, such as boosting GPU frequency.
> +        * decisions, such as boosting GPU frequency if the deadline has
> +        * not yet been met, or reducing GPU frequency if the fence was
> +        * signaled significantly ahead of the deadline.
> +        *
> +        * This callback may be invoked even after the fence has been
> +        * signaled.  In this case, the signaler may use the deadline and
> +        * the fence's signal time to evaluate whether the GPU frequency
> +        * should be adjusted for future workloads.  Implementations must
> +        * therefore be prepared to handle calls on already-signaled fences
> +        * without error.
>          *
>          * This is called without &dma_fence.lock held, it can be called
>          * multiple times and from any context.  Locking is up to the callee
> 
> ---
> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> change-id: 20260917-dma-fence-set-deadline-a778746e9abd
> 
> Best regards,
> --
> Jeff Boody <jeffrey.boody@oss.qualcomm.com>
> 

