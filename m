Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E6DCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD6010E313;
	Mon, 15 Jun 2026 09:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/2FFJv7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A114410E313
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rN/FwUD4ZDERyLIbkOc56FfrSsNB4CZ+vuIQG6zKz58lUpbh4ptULMqbvPwVFpZHQ2153Rq/GzvsCbLTbUxSvqlyzWrQA9uOTJ6GwCnNWXNXLi9CnaOCGOt5dRLCzzCheOLu1gX8+pYQ0asNYX93jn3xjTuRmbbJcQQ2Pa4Lx1MDSbKL//OMPwtD2iD3Mf7YDVQlbeU0YcX+w3y+HTTbrN2XMmS7u4aasIBFqcOxIXjDsu4gQvwariwRrosgvIqTw9FJLmOAneUixojxbewElvMpT8DI0zIe9BhPcJYY7cbd+LphHk7NEzDYJVe7iBlwlqYO52ckci1MfQEPbkTBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAORq1GiSqh0M7S/Iez0716mBB7R755xs3G5NdOgWVY=;
 b=gbQTX5AWazTgNlBOCh+tegXOrl6v+v6Bz+EilwcP+ght/6Ymd/W1r4MRois6wukqZd0f8Fb14GrzBgrR8O2Q75Tufa5rsCnwIpcpSDFlTrTyT0gHqMafWlZahw+M2ItHFsEBAZl7Y+8f05D0IqEI0eVztt/RYLuxI1AzxIMQV8yVKCPeIwuNyV0ZqaGdk4FtpHdBtxOkAUGY0epUHAzfS5NvE1oRTor86r8xAiuoQKzCJtRseEAb7rQHmbtU1H9hXjjQLo5O/p7cUdCn2f3sSbEVuD+KVf8Q0hBlepNkWglkKVVGCddP77hcU73MRvjVSMcLvG1Y60KMSRnh17LpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAORq1GiSqh0M7S/Iez0716mBB7R755xs3G5NdOgWVY=;
 b=h/2FFJv7S4ml3XsJ2ELGN+euxqA8QIcIKQpSD3ilWWW4PLEQdWaW5696Md+OEc4IodNwHnpNohfSA9795Hm5ZJlpR2gLN3rzwRPmdB97L2Uac+hgFixaaWGREsJ5CoNDK4Auq0yGCxrt7X7YdG+xetfpsSLqMDcKfqaiTxYOjHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 09:53:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 09:53:28 +0000
Message-ID: <600885fc-7e07-4713-b5c2-a470637040c8@amd.com>
Date: Mon, 15 Jun 2026 11:53:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
To: Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260612104251.2264707-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612104251.2264707-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3c3999-3a19-4272-ab12-08decac3f324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: xCh8Im+iPy2fZYWk/Vss8Fh/9ebeUpFvUaOgF61n0Sq2nKrkKBPp1c6T8QcpQ+TF8YhH+2cYPuOtzRH6OWgnfgCTGLX/IfeizrbkEPYeNNznBzdNezMMJfdoaF7+jrY9oxa3JWNnZKn6IK+nCl40eJMhnWPN7mChPWr/to8B8uNOzkoPjWlcPWxcD15LNRjAdY41PYOc7UKUibbzr0LpQze00AO41/i/9t0yOyoAycA2W3PB61oZHNzi5qK8sgW5dodyv603UvIo+V9Je9xyJaAWyMfbxAAziKeW8jH9a5aZiI+yDwkr6vicjAJDteZ9WvNgM9tvqh9IoyDeUzI/4l+nDzCVUqxcgKMld7kPc78cl92sU1stBo5REQ4Op5I82mKr8cWVIu/fhhjGsbBq1eSlvzOSxyJX8K+2Vs2L+Fwzz7FVFrOv40ab6hOEyamVr4Gw7Sn6zvrRKAnwPOaXXAfWbAMoF4ZAEqIwNGtGlAn1Q1UEFVoWEisRztmWgQJhsp6pnb0gX179ssHG1lrG86bnhiDrPA3aCTx8doPUdp54c4Lnz3iAgMAP9jiMm9Z+d+3E29uZM7JHCKrGTce6w5jiHgFI3jLT7fXj83xQt5r813brF1es+2JbwByhEJBNnVd61zLng5o6bBnmEAmfoS7rj8rJcNJ8E6hMyFoeVG9X4VvMll1G5hN0vMYsEbs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNRYnZ4OTZtaE5rMStZc3J4WGJHdU1UOG1wNnNqaHBsY2ZlZlo1bkg3Ri9p?=
 =?utf-8?B?TVFTOGZPR0VlTXUvcFNDaXdmQmo2d3BYakQ0WWRacEI1encrc3J2UmJlb3lw?=
 =?utf-8?B?ekp4Z3pqeDlJU1p2dGdWckdUNHYwRFZRdnlhWUp1Y0x3WDZxNms3Mi8wMnNP?=
 =?utf-8?B?bElKeGRkeHVXMFEyT1ZjZ2hMOFlEeTdBd1hNeXA3YXRHWkpXajU1VnE3RzhV?=
 =?utf-8?B?OWlQaGc4eEs1Wmk1UnhaMW9Sa0Nud2dCZWR3UVd2QzV3VWZ6dnk4OUsxaDZu?=
 =?utf-8?B?L1NlOSsvS2pWQlB4aGY2TVAwbDVOQnFVQkxsTitUbENiSmZFdXJrQUFBTXJj?=
 =?utf-8?B?dzRFOHZ1dVQ1M3c0aGkzb2VBOENFZ09kYVN2c0hsV29aMFk3Wko1bjdvSm82?=
 =?utf-8?B?dTgxU1JvbjVFRzIzb1ZLUkZMRWVOZXJRMWN3Q2ltcWdraXg4dEtKeDllSDJl?=
 =?utf-8?B?N3AwTG5RK21JUC94WUdjRDRYUmFLZytneElCemRFUVNodmsxMUwvYXRZNGln?=
 =?utf-8?B?eEt2SWJnSnBXaTgrTGFWckdFUi9RSFlqeW9hQlZTb1YrWFpxRjB3Vm43TGJp?=
 =?utf-8?B?TmFJZVo3dW5HbkttS3Z0TzJJQUVmbzRVRUdmRFltczZOOWpJbXdmYlJYV2lw?=
 =?utf-8?B?cnB3WFZZT002UXJSbkhCNld1SHhUSytlMjhQRFNHR2RnYjZ0aks1bnZHSzg0?=
 =?utf-8?B?Zml5dEVOdUJZYmRMU25VUDY4eDNUMWJwYU9jcDRIVE0vaHBESmxBeVBDb2dk?=
 =?utf-8?B?Rm1XQ3FhbTRVam80WGZpSXN1dVp2ZDFFS29NWkVhUktLZnpHajV1UGFvNnh5?=
 =?utf-8?B?SnZvQmIzdDJQV3Q0N3hRV3U4T3NxWmQ2S204SGVaYnVjZ2Z2Y0RIdlZIMkVs?=
 =?utf-8?B?TkNzVElwVXlBRzF2aEV1WVFkRlg4bVlSbWNROGMxRkRqcFMrRzZ2UEFINXZ4?=
 =?utf-8?B?TVR6ZzZMbURINDJWOEZRQ2V0UlBUY2I3elBNSXpvMHJNTUdvWlZKMnNVTkFM?=
 =?utf-8?B?RU1ZdXlrUE92UE0wUlFVNXEzOVAyTmxwcnJtaTVDbWszS1ZxbjA2Z0RDS2t4?=
 =?utf-8?B?ZE4zQUpMb1QxTUs4bDU1dXIvd1NxdXIzcjdTWVFrK1VxZUlMVm8yK01rZitt?=
 =?utf-8?B?UExQcnZraFFWUzkzRkgyMU1CUE9PUE9YZGt3a3R4M3lqMldZVVBoajlvMG9R?=
 =?utf-8?B?L3NMZmIyV3p5NEV2MVpQb0ZxQjd3eW5HSUxnb3IzdVJWT2FWWlU5TitXZCth?=
 =?utf-8?B?SGRKUFRtWU9vQXBPazErNllNb1NBQURja2tWL1dYMzYxM29aaUg2dWU2K3pK?=
 =?utf-8?B?Rm5JYkQ0TXNlR1R6bHVtQmlheDBjakhPcUY3VzYxOGIzNjJTQlRScE5uTVFs?=
 =?utf-8?B?akVNYmpJakE5Y1BTbWpqZmYyU0k4ME5HQWlJQVdvNUM5Um1TZWZLSU1Eemlk?=
 =?utf-8?B?Vy82OWtLUnkzbXRFZlhoNDF0dzFHUG1zRHlxaHAyWE1ZL1d2b2xHVnpTcWln?=
 =?utf-8?B?VU0wM0hSa3ZldHpQR3pNRmJHdHNzRm8xOTFyOTg0ZThKMVBNVUtwRnFIVjhO?=
 =?utf-8?B?elVGQjJDRCsvNWFORUZiK21ocHZUODlBbmJUMkZhWXNpUEhKV3hOKzMvWW9h?=
 =?utf-8?B?S1JoWFlqTU40V21WaTlkSDIzRGIxMVRScFVhRDA5a2FTSDBtT3NFd0JzRzk1?=
 =?utf-8?B?MTdRaGJuQk5ncmU0UnRBaThkYzBUNXBxbHRiMEt0eUpOVU81MjRUa3ZvM2pU?=
 =?utf-8?B?UFdYTCtwR0RzT0dGZ3hQRzFvM0ZwSDk4NC81V1ZsaEhGUVBnUlhZaDhCT1k2?=
 =?utf-8?B?SmdLZlRPUWlaSW1VMk13Nk9YbkxLRUMreURyR0FweXNWWGJhcWQ5VEVRMzJl?=
 =?utf-8?B?T0VzMW1JNGw0MUt6a0FIM0VDOUM1OEJYZkhrbWliMkh5ZkJoNVFpSGNXejY5?=
 =?utf-8?B?M0M3bnA5R1dpU1lmc1I4RUlsMmw1d3BLWkQrQTRoU3A5ZGQzRWZFa2RITEFE?=
 =?utf-8?B?TTlVR2FOVDAzR1dPL09WUmM2U1NuamVQOEsyZjBSL3RWd1M3V3N4cmZ4blVL?=
 =?utf-8?B?NWlBL05vVmhZZElzMUtkK0x2eGZvcE5OamRhQ3hINllKN2N5NE94bHJ2NWx5?=
 =?utf-8?B?ZTdEd2kyRHFJeU01WEQ2MkFWeUNnWDdSWGI4a3dDRjhOQ3lMR0dkNWk2c3lY?=
 =?utf-8?B?YUM5MlZZMjgrMVAxcUhITzlMTDhOOUc3ZmRGL05rR1VONFRkSFNObWNZbmpE?=
 =?utf-8?B?YjNZRkhLU2NNVUVJdFE2UWtQNEpGblRxV2IyYWw3Qk5jUVJlbW9uZ2ZlRmFh?=
 =?utf-8?Q?JPSmKl8cGSZdmxqPOH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c3999-3a19-4272-ab12-08decac3f324
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:53:28.4128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZP/Y8mrzEyUG+Mm4PWmOPGRtNzkgk6omlFloWR9+uHIFdNa50J+DNlPWy9d36Zz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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

On 6/12/26 12:42, Philipp Stanner wrote:
> dma_fence_is_signaled() returns whether a fence has been signaled
> already. That function contains a fast path opportunistic check which is
> not guarded by the lock and, according to Christian, cannot be guarded
> by the lock without causing a massive performance regression.
> 
> This now means that dma_fence_is_signaled() can return true WHILE the
> fence callbacks are still being executed. This is razy and has lead to
> at least one bug solved in:
> 
> commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> 
> Make this race impossible, by simply setting the bit only once the
> callbacks are actually completed.

Groundhog day, that has been suggested before and it simply doesn't work.

The flag is intentional set before calling the callbacks because the state needs to be visible.

Just see dma_fence_default_wait() for an example why that approach doesn't work.

Regards,
Christian.

> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/dma-buf/dma-fence.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..2416cc86ce93 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  
>  	dma_fence_assert_held(fence);
>  
> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -				      &fence->flags)))
> +	/*
> +	 * First test the bit, so we don't signal an already signaled fence again.
> +	 * The lock protects against multiple parties setting the bit. The bit
> +	 * is then set at the end of the function.
> +	 *
> +	 * The background is that there is a fast path check in
> +	 * dma_fence_is_signaled() which does not use lock protection and can
> +	 * return true *while* the fence callbacks are still executing.
> +	 *
> +	 * This fast path check supposedly cannot be guarded by the lock because
> +	 * of significant performance regressions.
> +	 */
> +	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>  		return;
>  
>  	trace_dma_fence_signaled(fence);
> @@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  		INIT_LIST_HEAD(&cur->node);
>  		cur->func(fence, cur);
>  	}
> +
> +	// TODO: we need some barrier here, don't we?
> +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
>  

