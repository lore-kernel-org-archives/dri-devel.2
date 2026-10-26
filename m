Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EF606A338
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xYRYERGs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF0310E0FA;
	Mon, 26 Oct 2026 18:31:26 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3455710E0FA;
 Mon, 26 Oct 2026 18:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIt4Wtn6Db1wF2WyqsK8VW2wd+1bZQ3G63M5U9+l9dl1qoHSPHRXoQz7enrZ03AFEEsPZzs+DLrpdcFE4b7tKPKMO0odVpEOXHvBZF6OlwwQp4PBZt3YhUT0l7yShLwm8MQr67dof5pVAumHWVL+V9rrwzh4ZT5FbyTZ39EGRbRIwmxcmSNpD4D4OnwMvL3zug8h6O1QMumxQKLmuLk5I5OyizPLdGvUE8LdKubINIo+hrsbn3MWkxiZpdLEVVoBjE/hwEmAcaCCtXkUz2Corf9QXVgbnH4AydZWsFNMTN6Wow0Kpo93Kk4eogGisQD1QviH41QyDjjUMRrgt7rI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmjOYDXOtcQdXu/OjdB9xSLSrZr64ecA41VbMTQc9oI=;
 b=DdSR7OEScOQsYfuf1t7TgsDOV29YMTE3DfUXFokfnV7sr24x2enkarZdiL05glzUffhSEjrf4LlDNVbbhelCK5BFIjUgmap6DGD+6pqmcGGX1x45pdOQe4qDwId8LSJ8K+rIsCbtDV4YqR9tYxIPidlFmWR8OR5ad7nkiU/WMtIqN5Ey9gppYvCZctzq6j9LV14q6R3Fr2bIe5BpNHyVgXUN/0TcVMqQfrWqJJ8k7RrS5Ov4LO8h5i++4iw610/oaJHxP98YznLh2CVtUbUh4U4kLMjdUiLeCESWXKKQkHhfvyYWmhF4IAuMwogUIMCbhRzAhk4i2R4kav8RbyTM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmjOYDXOtcQdXu/OjdB9xSLSrZr64ecA41VbMTQc9oI=;
 b=xYRYERGsALMU+i9cUndiUTz2VhgCWZUyQ3aOd5b1MZYIAMKNAemfgcQ5WdR5o9baAZNDlLo244Ji2cMFyVwt8vDz5FdPML9IJjsK72yAXe9Ii0gBKAo2zNG5Xgmc65nZ36vZYamluohoSK3F9VbftIvfEMUuI0MRCnuLC45o/LM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM6PR12MB4042.namprd12.prod.outlook.com
 (2603:10b6:5:215::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 18:31:15 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 18:31:15 +0000
Message-ID: <bcd63af3-d2ce-488c-ab96-2b11536cd50c@amd.com>
Date: Mon, 26 Oct 2026 14:31:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Harden against potential deadlock
To: Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20261026141541.469727-2-phasta@kernel.org>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261026141541.469727-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: fa23a9e1-8a17-4470-57f0-08df338f51ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|6133799003|261026121527099003|22082099003|56012099006|11063799006|10067099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 41yH2wqjuWX/XD297wUrIppGg0bO5gF8ruCsVSKTV8VpjKP7fthzw1hnUjic9fyES197GS7rAp/GtMmy0Ra13CtDPHOZLKcbH+epNMRvQp6P9JMl1CjO0BbhyEWCJMpihrlQFXIk96B37GDoeE8EzHNe/yeuypbk5LmPOYwt/1BepbniNMoEoHOMpyNQX/avzV8iluitDpZ570EtaA7sLI3+S6PgM38oa0hUOwdGSbpOwzuKOP7hVNd8E5iacvDSYNURRZLCeayiMpBrayNPvywZ/H20ji8JoFvaliA0dK24EaZPmu2BlBHia8gT20Rk4w97hPvuHdePNx88qxZqJt2n0t/8l/h1Sjbwuz2sNFR5aUsxk3nzc3o7HBg1KTro6ohnrdt+RGAepG6CKAgxiIqG3crzuOY5gV0r72C2J3fBOZ77pwsXgHhwaYNqrMY9IEPccA/oBCnY6Cg0IEGo4vE1DsgcSLVvF8Kte8QSWvkI4wZmLB/ZSCG9P1BMfd5kw8A22af4jMUypY2Iyufm1nvySofDhlOX4WXj+n7ryBAMg36dB2IjLedAAphQdkCJTskCpHvBIIGhl/QsPQ+pN2VUBy0VPwCBwA0rMNnt8YifUCvAf//37VTb9YEn85VZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(6133799003)(261026121527099003)(22082099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05uUzBTektlRGZMZFZJeExJVCt4RWs0dm1ia1EyYlZXWW5pS1N2cnlEeDhE?=
 =?utf-8?B?aHQ1cEN6R1RSSmxaMis0dmFLUUltS2E2TjRJSUovRnlwREZWRVlHMVh1NUlm?=
 =?utf-8?B?ZU96dnRWdGpDV2FiMWNCdDVlZ0Y5M1daUVdyY1pxaFphTWhWTEF6N293eUJq?=
 =?utf-8?B?MWlGUFRhSitnYnhhb2JJaGdGaGpud2R2b2ZwMzNNL2dydGRPSTBxOTRPL3ov?=
 =?utf-8?B?eWlua2Q3R0RlRnBBR3M0Z2pONWVGdWdoeVFkUldFcU4xbzNZZkcwb1FhKzk2?=
 =?utf-8?B?YXBnWHNpVGp4Q3pySGRuWW1PUDFYSGVrQlBrQTFKUlRiSUJZdGlVb2JiYlE3?=
 =?utf-8?B?SnJmcVUvYVBudFd0YytuQ3ZIc1pIcEpidGVQcU00K0c0U00vVThkVHNhbXBW?=
 =?utf-8?B?TWd6TXUxMlFvK3F3c1lNcGZVcnVsaXE3MVBlY3FSeXRyWlJGMWJFbDhCMkVi?=
 =?utf-8?B?TmFzaG41Z3BkZ0VSdDE1cU83NDFBKzdKZEkranVhd2k0TUwyYjlZc3p2ME9a?=
 =?utf-8?B?MUtWTHJ5ZEVheFJzd2xXZzkvbVRlU2c1VTBPaUNOUEV5eWZlVDNodnZFbnFh?=
 =?utf-8?B?YkYrR2s2dElSbEVITFEyYXJlcjNwT1VjVGNPNnNZU3RFMFRiNSs3Y3B5bjBO?=
 =?utf-8?B?WkdXWXJiaDBlNi94dC9QM1RJR3AxeFRHMkc4RE1oMDBUN21TcU5hM2dsWXYw?=
 =?utf-8?B?R3pWeVAzempOeGRCRkd4Qmt4UEE3cVBrUU5NNWlad01SREhJcnNHOHRKZHJ4?=
 =?utf-8?B?VEM2c3BoZjdjYWh2MUVLdnorMEZqK2lEbGVUd0dZL3hCOTBxL0srbGRmN1N2?=
 =?utf-8?B?aDhzMzZSdXpQZW4xY2pRbU5tNWRYT0FYVStYVEp4aTdWT1E3VVdnYTJjNHZK?=
 =?utf-8?B?SFdaSFBDY09WOXVwYkd4QXp5TEI0TGc2andHNStYZDB2elR0T0VWWkFoVlNN?=
 =?utf-8?B?bktLN1VRZWtTYkg5Zmk0ZFYxaE1VclFPclRGNklraXc1N2dPRjlGY3lvNjRN?=
 =?utf-8?B?SDh0RHFoTW51d1Vhb0w0czdrZUdERy9UZk16bzZPb25MQmhpdHhPeTNTMVRZ?=
 =?utf-8?B?aTJodVE2cjFra1ROV1BYa3NJTFpsdzFzZXVYMlZJSGpNZHRDTlR5cVNwKzJY?=
 =?utf-8?B?Wjl5N0JGa3d6NmU4RkkyNkFQeG5jZmc5M2hFdzh0RnBmSXlaQkFYbVoyT05R?=
 =?utf-8?B?Z2NFVlFrVjVuQjFUMDJobEhWRHgzaVFtdm1IZ29HbkptZml5Y0pkeUJJOUNP?=
 =?utf-8?B?d0k2UlpJUENBekRySElqMFNtNFowbm5TT000N2tLOUR1SEkvVi9qcUtLeStK?=
 =?utf-8?B?QUduN3hoc0cySXk4NDB4MTZXd0NvUWFxcjFnbXJHdUtGTHhtUW5MWmlzSTZu?=
 =?utf-8?B?dHhLbVY4dXFxY0FGMnJLTk5XYXVGRUgxaGlDR0hDQVU5SkZkWThhQ08wWWUr?=
 =?utf-8?B?ZTUreGJzaW5uZmo5RHR6VWR5STdtY2owdm5vdE5DOHlTM3ZVYmkwUitDVml5?=
 =?utf-8?B?RE9kTWhyMVVTSHBmVUlzM21abXRpMjJWZW9vck56ZHpSRlhTSytKNVpicFNu?=
 =?utf-8?B?QnBQZmNLQ0VDMkFnYWZlOGwwM1pBK1RJS0FCOUtWUEJ6dWJlUXVCeHFiNlA2?=
 =?utf-8?B?TDhobG12aElLRVJ1VkxLcDZ6VlgvakxuekxJZml3RGxRdElnb21LVjdzWWs2?=
 =?utf-8?B?UGZKVFB4RU1ML2JjZmlTN0d6ZExkQ2Z3anRHdktTQkxIRWRvemZad1RoaDlH?=
 =?utf-8?B?NmRFbk9aM2ZTeEVwcHluaE9heXVueGdhT3Q4Q0VWUUY3L1RWbG9EMjFEY0NM?=
 =?utf-8?B?anE2SjhlL0toeGNGN2JzWGw2K25uNVhLU1ZqNGhTS280UWtWTXdzZC9vL3p0?=
 =?utf-8?B?VnBCMGRoaUhSUGZyMWRZaXAvM1dGc0ZCeGR0dUFwaVZDbjMxNExKM0pISFNQ?=
 =?utf-8?B?N0pPTzZLTUkzZ2phSUhueUFJWHJURzRlNGgrdlhYNmRmUS9Da1BZbVFhVDBx?=
 =?utf-8?B?cWlHSDJOamIzcnZrZjdFd0hWMnI1Z2pseVJZMXFGWE5oM0w3L1RUMjVaNzBD?=
 =?utf-8?B?Rng0YnJZZ0RtMkhiT0FyWkwvWEVjZTBpbExPalBIVnptVE1JaEFiVXY5R1RZ?=
 =?utf-8?B?cWE1d0dSejl5N1hCNHBkRHFZejhpUDZ2VnZBWE5qL2taYnl2aDF2VlcvaFBq?=
 =?utf-8?B?NGZ6NmFhWkVvRms4Wm9vNlB3QkVGYlI4WG1zWmczVVd1WEhiYVhmNXFmdzQx?=
 =?utf-8?B?Kzh6OHI5K09jMmFoRmJDK005cUtEM0JyTENQend5bEsveXloSU5xRFVIMnRk?=
 =?utf-8?B?OHgxUVdtdHBYQnltK3BTVi9TdXRhSXlqcllIUm1nRzhmYi80OFFhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa23a9e1-8a17-4470-57f0-08df338f51ab
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 18:31:15.4734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inbC8KiPqHrsN1oYUOyXU66ABR8396R+JQAY5KPhoxJ8Hr9JCEqwkdfTGLc9KRKa4JuKYbQGT7L3bBXU+wGUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-26 10:15, Philipp Stanner wrote:
> amdgpu's KFD eviction fence's dma_fence ops->enable_signaling() contains
> a dma_fence_is_signaled() check.
>
> ops->enable_signaling() is currently consistently being called with the
> dma_fence lock held. dma_fence_is_signaled() might try to take this lock
> in its dma_fence_signal() call.
>
> This deadlock can currently not occur because the amdkfd_fence_ops do
> not implement ops->signaled. Should that ever be added, however,
> deadlocks might occur occasionally once the fastpath check in
> dma_fence_is_signaled() is skipped.
>
> Replace dma_fence_is_signaled() with dma_fence_is_signaled_locked().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> As detailed in my recent discussions with Christian [1], I also think
> that drivers should be very tightly constrained as to what they do in
> the fence_ops. I think at the very least they shouldn't use any
> dma_fence functions there.
>
> So we could also remove this check here completely;
> __dma_fence_enable_signaling() already checks the signaled-flag, after
> all, but I'm not sure whether that might break amdgpu.

Looking at the code, I think it should be safe to remove the check. 
There is another one in kgd2kfd_schedule_evict_and_restore_process, 
which is called from amdkfd_fence_enable_signaling, which is also redundant.

We don't implement ops->signaled, and we explicitly signal the fence 
from SW with dma_fence_signal or dma_fence_check_and_signal. So the 
signaled flag should be the only thing that needs to be checked. The 
flag is only set while holding the fence lock, and checked while holding 
the fence lock. So in theory, relying on the check in 
__dma_fence_enable_signaling should be safe.

Regards,
   Felix


>
>
> P.
>
> [1] https://lore.kernel.org/dri-devel/320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org/
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 9b10d015671c..61621eebb2b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -123,7 +123,8 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
>   	if (!fence)
>   		return false;
>   
> -	if (dma_fence_is_signaled(f))
> +	/* The enable_signaling() ops is called under lock protection. */
> +	if (dma_fence_is_signaled_locked(f))
>   		return true;
>   
>   	if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
