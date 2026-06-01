Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFEACD6E4C
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EF8112F6E;
	Mon,  1 Jun 2026 08:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BpPWRV0a";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1605112F6E
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 08:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd4Gq29iMKdvsaUvWfFGVhG1QlSzPxD7SipxW4JyHBokJORTCzUlhQT+UAFHNA1NUaqUEE61gTjx1F/VQk5p0Z5EJmVVYKj3y74Gcd1UmXQNcLFgNxxYiubjLDGbRwwBj0YDl2hHcJ4rOwDZSnl4mXk1YNJBXNjVYPdXHv/vMEtdieeM8iMvzSOs8xSWItLl8M5CWalNg7eSDap5FAt04M6hKrF53dT+s5w2mdap1uFizL2nSt20Tzc/Ma3hlvuZ6qBBWkCrV2Key/lfMO23/apDPWueLeQ4Xu2+IjidkXOELHWFtu9wwOocfv2mqGTR6v/z/OVtpIWmJ0+84eUbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKQrcU8Mxi/rySN1zniWf8jMNIA5LVdj6emqu4N8TyI=;
 b=hIB+ZKb5afhrp7/X3apuDDcaAf0KysN0dIsV/+3vV0SI0yyqXPkG7L5pHod5eYxgC0dgM7hDV76o1defnIBDPY+HKmpkEO+FcV6z6Q9LJ5pptQtU/F/103MHZYpFUqTILcbYxm1WDiX3yj3tFEosq1vIMrlNr3NAOupBFMhFdAFqjRUqdcEiYWAmMMeEjHPbngq0jReXXQif4f26aU+SbtpCJefnWElqCFdz5Al0gi8SnDOZOmF28ThE2uJ3dg8wEQ5Vw8yvxtMFCdjZt6NnV/0wK6K1igqjuSotZcyfYVp/he22Aj0/lPXNmx+9N24OQGZ4EQQPMlR/dOBZZQXu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKQrcU8Mxi/rySN1zniWf8jMNIA5LVdj6emqu4N8TyI=;
 b=BpPWRV0a+8hFNNESL78PV1EzUo7yVjfdpBNltLB1GTTuf2SSSCmRQX2aG0+3uiJqgNYMolbjYaz35uNG4JO8JXw+khn1h07dOC3VhgCfypMhahj1sE9pqsPCBvDqqzxRX36mlwYEkTm0P0ii9wqw2INTrjgL7mVo6r7jDyRB/E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 08:24:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 08:24:35 +0000
Message-ID: <27e74975-a6f1-4ef5-8f9c-0f834a580030@amd.com>
Date: Mon, 1 Jun 2026 10:24:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com
References: <20260531125115.1136036-1-mcanal@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260531125115.1136036-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0a2dbe-96c4-4c8c-12f6-08debfb7369d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: veWTy/rD8+oR0Mrnenbi4BP0RHGjVj1Lqwr4kqS2Kz7KPxyEq387Xg5Rk/IxpH0o7k95ye6fQU0im6XOQ3rxC6QAAbF9vwaUcx5WYU6TUd3ireN0hB1BEFykCV0Swnl/OjuEvKCQj6iswlvRBxePWrvdrxMDmXMkOrzIn3FOCjB82uUzgo1RUzXTGK8iDXcF7cygsa7nJ0tIEbBGBDAq5HLlE0WMUAW8p2fLRHN7LhObr8LUpdI81jpciB9dIDkAUjX6b4xmyJyYlouTVJBKXkK4TmCM04WDXWivnr/EINkct2jDwG519XIgJINt26S1oOR99DrIkIz6nPZ4VUxAph4pBSyglhz4RImgr5js3DGcX/qAHkd+nEHdbRBQJakuYY76XsYLk4n2cZ0eCkzqCg1UYK8dqdKdxSRzs3Qwhl6AHiQ1PRlX+p/oub+UeBdKFkrcVwFV2+8btKEumdQ7vw1eqbzHnYXZ1eW1pYYyQjieoBXhK/9iDu/va8jBu6a3PM9YFTnpNZU6bjYX+UZk9fnHizlS82SWkkxSS+TFOptKXdGXh0K4rtWBDx4Akg2jSRVLV9VVTce1Pek0RnyisACYJrncNX/cTQvGrIu3OlsUKt4HvDypt/MXo3xro3jGdyxEIMBheLwmjOMVLGMiNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZZSnR1c3NxYy95aHlnb2VIbElxMmRTWnppQTlJTDVLVTdYOWNCak5oSkE0?=
 =?utf-8?B?eG4wMXZReG5mTVlIeGdleEtuSG8yKyt5QTlmWEFoWHo0SHU0elByMW5DeE9P?=
 =?utf-8?B?UGdCTms0aWdxOWo0anVmSDlPRlBxRUswN2kxaVkxNllvbjVHZk1adTJyL0JW?=
 =?utf-8?B?SWdia0hRcmIreFFiMXVFNjQ5dzdNRXdwYmlZRjFUaUNXaWJENDUrQ3pmaGVW?=
 =?utf-8?B?RzZHcmRRTDA2ZVQzQ2dFd2Uxd3ZQbUZFaiszOTBOOGVwWUkrZ2Fhb2FNWS9y?=
 =?utf-8?B?cENiUU44a1N6UWRWNSt0MHdFcm5pYWNFMU1UVU1HZXlMZldleWpnV0hHN3lm?=
 =?utf-8?B?MG5uWVlHbCtyYnlxejB0RWZSOTI2SVBqR2FPejd1cENwY3ZLZW5XZ3FPejFQ?=
 =?utf-8?B?WDVIWkhsZE4ybUttZkVwZlF0RHd4NkxEcEh3L3VTM2RVbEJLTDRJNXBpdzMv?=
 =?utf-8?B?ekVVbVdqd1lWVVQrNHY3WGtIQzMxOWVPYmttMUtJOXpaWlZjY3ZwRkNKVUMz?=
 =?utf-8?B?ZTlZREZ1TnY1OFIvUWQ1Y0xFd1BUVTdCMVAxRTJpUjg4QU93Z1VtQlpBUC9V?=
 =?utf-8?B?OTNrWHNNaDB0Tit4d0hDZytsRFJseWd4c3lhbVVCMnNBejI5NkhnZG1aQkZr?=
 =?utf-8?B?V0ljOGxwVnlQMmdEQ3dxR21vRzhKY0hIM21LNHVZbXBxbmYzclNFR0lVUU41?=
 =?utf-8?B?RVM2TG5JT2RWT0NTYzloZWFpaDR3d2RwMVNrMkpvSU5LeUdsd2RWRWNDdGFG?=
 =?utf-8?B?dlZuN0ttT0NKWUphM3R2Y3laUEdaUUFnbEZPSm52MTJ0MzIzcWVFMFFQTnhX?=
 =?utf-8?B?cFhBWm9QdHg0UUxFZ1A1SjZFQ3RyaHhoZHZMeEJKSHlhdFhBOEdSYVd2dFlx?=
 =?utf-8?B?UmxCKy9pdmU1K0hvaXp5bWJxcWgwVm0xZUFlMjVxT2hZR2JFakFRRFZYRjJ6?=
 =?utf-8?B?ZXdRdTRtRkpMemptM1Bwb0VwRndXR3laL2toWGRWYmpOeXZTaWNNZjhSendR?=
 =?utf-8?B?TGFxYmg5QURIc3VHVnpOSHcyb1pXcW1RNzNuSFo3eTFwVzNKVnJ6SHAwRExK?=
 =?utf-8?B?eGYvdEt3dFZTVlZ2dzhLQVJtVUFqN2pvT2d4T250ejZkNEpxQmcyYUtPenNU?=
 =?utf-8?B?WGxFRFhvWDNFTmFSWGVEeW5KcWhnZWVYNGx6ZmlMUlJuWkZzQWJiTlVxZDRJ?=
 =?utf-8?B?SVUxUStBUzQxblcwQVJkU1RXY1JUTHJTaUtQT2I0dDBzUS9jUGVNVlhucWg5?=
 =?utf-8?B?Y1JaOTZPc25MODlmbzh2YUk1dURTelB0cGxwMGgvcnBrVGFaYUNxdDN5eWZQ?=
 =?utf-8?B?ejc4aWsxOXhCUzFqL0J3bzJNc3lubEMyWTRnTy9DM1h2L2VFZFZwYVdBV1J2?=
 =?utf-8?B?U3I0N2xpUnJ4T1prS3J1R0ppZmkwWUJhRFNiaDRVWFU4RnNSU1YwY1Y5Rnh4?=
 =?utf-8?B?b0N2S2RoUkV1VmxFVXhkUUlJQnZQYjYzMG5pTWp4ajdNMzVETnA1UzBzdjJM?=
 =?utf-8?B?WEJnV3NsTEVQWFIzUUdMY2RZcjFvZysyaVI2eWpuOVlSYm5Cd1NzRmxjUStl?=
 =?utf-8?B?NGI1OVk1UnBOMi8vUzZ4TDRwVHA3dE8yOUNudm8zVERLK3R5eTVXUHdCamsx?=
 =?utf-8?B?RHBjS01JRVhuZS9NMHFmdWJkaWJuM0JUY2Frak5pckRNdTBCcndQQWNOZFZT?=
 =?utf-8?B?Nk52elczRG1tUjhwNE1ZcFpOOXdCQS9zbUhvNk8ybCtValJHc0p3MW9rN3dI?=
 =?utf-8?B?d2svNHJpdTl4eTRIT3JuN1RUbDJPZUFCQnBISUVSVVMvVnM4dDhMcVhGMjlK?=
 =?utf-8?B?eStieGZidHM0QmVkc0pQMXNXQ2EvRmZwRzU1d3hGSXlIR1MyWUIxWTFPMnZ2?=
 =?utf-8?B?UjhjcndISE9qNE4zOTc3a0tsSlEvV3RCQXQ5S0J4VUJXbFpBRENITDIxK2Zw?=
 =?utf-8?B?SFc0Umx5SUZwZ3BjL2ZSWFdtVjY3QnRUUG5qQWIyWkk4bllMdi85cGVXbzlV?=
 =?utf-8?B?VWY1NHZZS3VBMklUUldLMVcwbjFKOGcyM0IzVko1aFJsV1lFdTluYlZvMWtp?=
 =?utf-8?B?Sk9RamxaejNnRFE0U1BtU2FORXVJZzB4VlJzZVd2YVltMEpiOVpXc01RSDE4?=
 =?utf-8?B?d0twdS9pYnYyU3E3b0JLSkZrRVJsSGZBYjFOYXVGdUFXZkRSSlRrRzFqaDM1?=
 =?utf-8?B?S1JKakJMdG1vL3lNeTYwL2xyWlM0cWtTYVE2d3VVTmdzSUIrS0ZiTlpyOFZ0?=
 =?utf-8?B?WGUvTUxmdytUUTBtenYxQWcrTEovRS8yUTdXWDh2MkMwSVNxNC8xRnA5OGky?=
 =?utf-8?Q?zaRPEeePVmbCK2mCJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0a2dbe-96c4-4c8c-12f6-08debfb7369d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:24:35.0865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lplwT7Nx8wEjGpaK7LEc0yVEExW2U3cXoveu1idWrYSpd1M/gGPRWLABT+KYcFVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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



On 5/31/26 14:49, Maíra Canal wrote:
> The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
> the legacy reason to pass an external lock as a need to prevent multiple
> fences "from signaling out of order". However, this wording is a bit
> misleading: a shared spinlock does not (and cannot) prevent the signaler
> from signaling out of order. Signaling order is the driver's responsibility
> regardless of whether the lock is shared or per-fence.
> 
> Reword both comments to better describe the legacy use cases where a
> shared lock was needed.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

I'm going to push this to drm-misc-next.

Thanks,
Christian.

> 
> ---
> 
> v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mcanal@igalia.com/
> 
> - Be more explicit about not allowing new users to use an external lock.
> - De-duplicate the explanation in dma_fence_init64() by pointing to the
>   dma_fence_init() documentation.
> 
> v2 -> v3: https://lore.kernel.org/dri-devel/20260419134943.54833-2-mcanal@igalia.com/T/
> 
> - Apply Christian's suggestion with small readability improvements.
> 
> ---
>  drivers/dma-buf/dma-fence.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index b3bfa6943a8e..c7ea1e75d38a 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1102,9 +1102,12 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * context and seqno are used for easy comparison between fences, allowing
>   * to check which fence is later by simply using dma_fence_later().
>   *
> - * It is strongly discouraged to provide an external lock because this couples
> - * lock and fence life time. This is only allowed for legacy use cases when
> - * multiple fences need to be prevented from signaling out of order.
> + * External locks are a relic of legacy use cases that needed a shared lock
> + * to serialize signaling when no out-of-order signaling was possible through
> + * &dma_fence_ops.signaled. Drivers have abandoned this concept since the
> + * introduction of the callback, but the external lock is still around. New
> + * users MUST NOT use external locks, as they force the issuer to outlive all
> + * fences that reference the lock.
>   */
>  void
>  dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> @@ -1129,9 +1132,8 @@ EXPORT_SYMBOL(dma_fence_init);
>   * Context and seqno are used for easy comparison between fences, allowing
>   * to check which fence is later by simply using dma_fence_later().
>   *
> - * It is strongly discouraged to provide an external lock because this couples
> - * lock and fence life time. This is only allowed for legacy use cases when
> - * multiple fences need to be prevented from signaling out of order.
> + * New users MUST NOT use external locks. Check the documentation in
> + * dma_fence_init() to understand the motives behind the legacy use cases.
>   */
>  void
>  dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,

