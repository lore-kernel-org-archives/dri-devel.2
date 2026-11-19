Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05459606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iJiwT7hj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289D41122B3;
	Thu, 19 Nov 2026 11:19:17 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5034C1122B3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYElq3O99O1TjFDgvdnPg0ujQSrEcYh8Rkq/2lSGni89+//9iLCxLO7ZxtnzWUF0Y44ZA37v5TBUaVnd3LUIH52hg9MyXLLFuG6EGkHIJsB81EIcBVzfhN5dhqHuy6Fn036ELRMUOqVmKTG614FGT9JmDLebddyts180EiN5x6wZeBATD1jHbZgdx+isllciO9BZKKZQIl1JPfnq4GOuwIMBbNXadzOmFHJuqbyPXrjgG6sQqF6fiewv+2XMFmoi002nCY9RIFJXJB/ZvoykiEBwg7V+B1DlEC56wtPzqZ9qhbHnfimosiJYYfud+ol10TwaJ1dcBDv4+5hZo/SD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAEXMGrb6B4mrOdf7ZW1R2MM8DV5xeASyLEQ+kqIxjY=;
 b=f5szswHvsNfVT3pJVSfPjwTmQW9Mp726cLg8z2bSlDhLXxSegNujz1QJMbhW3kEDAqlUOXYLxWjXDcm9OMf4KRg+h/dmiUAmTQdYe6Xoe7vMxFQM9kR8Xbtu0887Ajj8Vedqt9h89i2DGQah2q53e32ybKNoxr1JUiDoqKDnBnskfJcb6PQRBEs8DOd5WV09EsZSEKzt9JLkHeE0nZbyA0wvkpk0ErmnmqzMYxb7AuzqxZkzNCVsMnBLw+4hZc4Es4mfHP98hRMz+OFqzIlECZ5dDjEL5gg864Ewj3bCoU3OKDftIaoy4IcnmoybYep3nd213bBkve012CL4G5YZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAEXMGrb6B4mrOdf7ZW1R2MM8DV5xeASyLEQ+kqIxjY=;
 b=iJiwT7hjlBW8VUgy0x68nCVMs2MZrTrg0HLYwpW1GbFTTgnOoerLpEaV34r5FLtGd+z++vJIOjoWg5TouSulWtVrIHF0hZqrCzh0iUxUyOO8VrIImeHEIOomjCD/vJTvIdySvXTxT7XO+SiWHj+MXsLaqjED9LdS9OY8UdqiOEw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:19:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 11:19:01 +0000
Message-ID: <a8b6f088-9c02-47b7-91b7-5f66c098c078@amd.com>
Date: Thu, 19 Nov 2026 12:18:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Remove dma_fence_later()
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261118145026.1755441-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118145026.1755441-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:52f::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3d53cb-17b0-410f-0059-08df462ee99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261102130727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2qeNCf6r1j1/CBYWxP1aSo4v615B8S1+tgc8GJPm8JUoARygbu3lgSM5VBhHq5tmoepZLdPFarYou1K3Wcz722oft83XcKBNNlfn9pCPJwj5gJAFCKjwlUbOswV0FvskZ7UbvQd+/YJ7b/k9PJawp/zzgVyw3zLR9lOOgk1gxVKoPioxjkFkB+GX7cMDA3mUv3MrkFmBI8PaYZ7GwRRv6pWRyrJf91hTnUIzPF6rVn0JJDpQ/PoZUooCbar+/rldZ1fUmy1R+NKZTf27lO4PSi3sekS8Tq8falOswx622RXAmzL71J3D4JLWDsisN1bYf8wuDgzxGvopkjzs1SpyfvfBVGC5FoVQJArhnq6d7ib1CS9XodwgFkZK/cjZ+ovmp/LnXiDc6e/l8zqma7WOHdoTo36VId6k4r8gZ6usA6yidWX2rjtWKlq+t73Mk7pag9xx5ryxqf4idtlIYxPiTzIxex2leF3I/2344RCAfGbgbMlsb5PpJFp6/5vgxKCQpCa1PNupQDy+m7UzgVzt41rUvyhtWu1qgx6ZJbePjSpxSO47Nj7sVhuQmw+s2ozTfLZua6Di7HWDbz1A+N4YUnGddZ9ASLQdzyo5URXOUeDV8WPNP/j/sNzPjj2DjUuGJ5qJkZ/yFSDp0Xzi5YVTBlfpVlbV02gTI9SCP6XOK4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjlKejhSRkkwaVUyd3VKdmtyWGt0cGZjNk1haUo5ZDZjVWxxUnJtNnpHMUxv?=
 =?utf-8?B?a0pUMnZhYW41MVhabmJ1T3pYdWZmZS9CRlQxc2d0cFVicGdBZjg0NWU3ais0?=
 =?utf-8?B?UW8xVHUwOCtWN0l0WmM0aUwyV0w5MHl5Y2lONUNEWVl1OXVGMmN1MytTYTZF?=
 =?utf-8?B?TzFEVEl5aWtBaDdNTW5EZnNSdmtBaitCdFdPcHBLa0dUUit1Smg4QXgxcGlv?=
 =?utf-8?B?MnZ5K01yZ0RZZ1hPSm82MDE1WHpsNU42RmU5RmlXV1NUR3ZkTkFISEhYQ2dn?=
 =?utf-8?B?aEU0OHhqb0NMa0x6R0IxZ2JjWDVGd0Fob0ZtTzlmZ1IwQ091U1ZrUHF4STNU?=
 =?utf-8?B?VmNMWVJDcHA2STJrWW51TktxV3RSOXRZcExadnpyRHVaczgyRmJCdjNOVVZ2?=
 =?utf-8?B?SFB5ajRCRE1HYjUzcFg2UFNlWjF3Z1R3S0ladmhZdE01SW1oRlV1WGZBRjc2?=
 =?utf-8?B?YzRJSUplazVBWGt0T1E5SmxDVFJaQno1MWs5dllqcUVhZlVtZ2NTZ0ptWTFZ?=
 =?utf-8?B?YVAwOUMxS1ZIRWhTVTNVVnI4dFc3dGQ0eHBnbWp2MTNvSkJtbG94MVNuTG03?=
 =?utf-8?B?MSt0TWdCSEIzWkp5Zmx3b0VXb1N5YmJYcS9Vd1NSM3FGcWI5clY0aDFQWU1O?=
 =?utf-8?B?c2t3Z2JQTmF6Uk54V0dtdzRNdEhJdjc2bi9WUkt5R1UvOGRqdElCcUNZNElx?=
 =?utf-8?B?RlYxd3NaM3k4SWdXbWg4MU5XNnlyNHphcWdSMUwwa3FZT3crTEEzK25CczVN?=
 =?utf-8?B?Z2dlZW1SYzFPMXBXWkJRTTJ5aGM5MzhaS2FBMXlmWVFoVlBvWGFNMVl2NjFs?=
 =?utf-8?B?QVdWaFIzNThlOHFtcHlaL0ZPMlc4QWNPWnh5VU41WHF4WDhwcmZIWmVjQjhT?=
 =?utf-8?B?anhrc0NLTGo0bUdzL1ppM1MzT0srdjN3N3RJSlU1QUhGUE5ITndnMlVlMTN2?=
 =?utf-8?B?WTZwQXJjMm9xSzhzQ1BBVTBBSzhTdjE4Q2M2c0xzNHBSQmorcmJhVGU1YVpC?=
 =?utf-8?B?TVVrUVAxRVUzRkwwWXFTV05EbjFxVlF6TjhvUGlJV1A0cGtOK1R0bUVWdkdC?=
 =?utf-8?B?WDUxSTFHckJiMlBkYXV5K0lZeDJESDZ6T25EMlRwN2RPUHEwdkJxTnhPNUFx?=
 =?utf-8?B?Ukd6K3VzaDhRWmVxT1ByZVNCa1JUNnJnVFVveEFZTUZRVFg0WTUrelRyTWNx?=
 =?utf-8?B?OHVqQlg4eGNBRytLZlNiU1B5ZGRQVUVQQk9mMUlTdHlDbGxSamswVjA0VEZ0?=
 =?utf-8?B?bll5VmF1SFpwc3Z5eVZ4SDIvWXJnRWMzV1hZU25rLzJaY0wxQmJNaGYrTVJM?=
 =?utf-8?B?YmxqSzFJamR1dnRMYXV3ZkZ2VG9iblZ2bUUrSE9WTUF6WHFrc2J0TFVLOUVZ?=
 =?utf-8?B?Wnh2NzlkRklBU0xmb3lEMXk0VjAzTGVwMXNEaTVyWURSOGpIVVExUlE3Tlpm?=
 =?utf-8?B?UE9QM2NjRHI0V0pGWHpXSGhmSFowdFMxWHpsb2p1bEY4eDI2TUZ3RXJlWEpZ?=
 =?utf-8?B?Z2NXbVdGVFlWTVUyMXZGaUhveG9sUVYzb3hLWDcxSXJGc3JrMXUvVGhmZ0FL?=
 =?utf-8?B?WUo1ODZHWHE3MmJUMTBjQUVjZ1IyU2NyK2srM01ncHZDeVpYWmE5Mk5iMDRj?=
 =?utf-8?B?VDZXdGh1eE9YYWJoTmpuUDBiaC90eCs3VEFSMHN0d0t4cTJ5OEpjZWVuSzZz?=
 =?utf-8?B?N2pOZWZpTmJtYnRTTWpGTzVRU3ZXYkR2VjI0Um5DcEh6WUt0WWJaUmcrcUJN?=
 =?utf-8?B?UkhnNjdndU9ZeFRlUmMxOS9xSXdITmJjNFBsRG00MjhSbUg0TDRweWpnYmVG?=
 =?utf-8?B?M21Pb3N1S3NIbkJjVUVMZWJLdXpyNmNiNXo1MnMrMFgxV202NnQrYWdRQklR?=
 =?utf-8?B?RTZrYTR5UDQyaG9tU1QxVmRxUWEzRDBNT3JRL2V2Z0VLYjdEOXQrRHJOYU1j?=
 =?utf-8?B?SFFCMDRVVUI4dHU4MkU1OHIvcHdSa2Noc0VMcDJZclEzNVZlK2xiTCtCUy9n?=
 =?utf-8?B?N2txcWpTMWw5ZkZCZSt4ZEdYMWdUNk9FU1I0aHZlM1d6UHNISlBudWRwWUJF?=
 =?utf-8?B?YmxhZE45c1FNQXc2eFJpRnh1WTQrbnBEVFlWQUsrcTdpVURleVZ5YXlNNEFh?=
 =?utf-8?B?WWJxN0xtT3NJT3hxNHkrNW5teHVhdUVVWjI2bmVTWjNVdkJXdk9USGQzVGJG?=
 =?utf-8?B?SVliZ1kwaW5YWG1WU1QxbC9XQTlGd1VPU1d0QTVxQ0ZiQ2l2T25QZ2Rsckxq?=
 =?utf-8?B?NllZL3B3cGd1V0hLTk5YNk5lbWRsNHF4blBqTWlsKzhYQ1d6UGdOVWpWZVNQ?=
 =?utf-8?Q?zFoizs+trwlhfOLob5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3d53cb-17b0-410f-0059-08df462ee99a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:19:01.4313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecpQkmopikWYXEFngLukH19CUvfmqpuKiJxNOxjabxPUH2Qj05+u8/qmpL/jzIgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 15:50, Philipp Stanner wrote:
> dma_fence_later() does not have any in-tree users anymore.
> dma_fence_is_later() is available as an alternative.
> 
> Remove the surplus function.

Ah, yes please :)

> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> No idea why we have two such functions.
> 
> dma_fence_later() seems to be older, coming from a big-bang commit in
> 2014. Yet Christian added dma_fence_is_later() in 2015.
> 
> *shrug*

Because we had multiple occasions with dma_fence_later() where people were surprised that they got NULL in return resulting in NULL pointer dereference.

I wanted to phase out the old function over time but didn't noticed that this is actually finished.

Thanks,
Christian.

> ---
>  drivers/dma-buf/dma-fence.c |  6 ------
>  include/linux/dma-fence.h   | 26 --------------------------
>  2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..2f805b788f8f 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1099,9 +1099,6 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * refcount after committing with this fence, but it will need to hold a
>   * refcount again if &dma_fence_ops.enable_signaling gets called.
>   *
> - * context and seqno are used for easy comparison between fences, allowing
> - * to check which fence is later by simply using dma_fence_later().
> - *
>   * External locks are a relic of legacy use cases that needed a shared lock
>   * to serialize signaling when no out-of-order signaling was possible through
>   * &dma_fence_ops.signaled. Drivers have abandoned this concept since the
> @@ -1129,9 +1126,6 @@ EXPORT_SYMBOL(dma_fence_init);
>   * refcount after committing with this fence, but it will need to hold a
>   * refcount again if &dma_fence_ops.enable_signaling gets called.
>   *
> - * Context and seqno are used for easy comparison between fences, allowing
> - * to check which fence is later by simply using dma_fence_later().
> - *
>   * New users MUST NOT use external locks. Check the documentation in
>   * dma_fence_init() to understand the motives behind the legacy use cases.
>   */
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index a3fa1341765e..e11e65b916f1 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -633,32 +633,6 @@ static inline bool dma_fence_is_later_or_same(struct dma_fence *f1,
>  	return f1 == f2 || dma_fence_is_later(f1, f2);
>  }
>  
> -/**
> - * dma_fence_later - return the chronologically later fence
> - * @f1:	the first fence from the same context
> - * @f2:	the second fence from the same context
> - *
> - * Returns NULL if both fences are signaled, otherwise the fence that would be
> - * signaled last. Both fences must be from the same context, since a seqno is
> - * not re-used across contexts.
> - */
> -static inline struct dma_fence *dma_fence_later(struct dma_fence *f1,
> -						struct dma_fence *f2)
> -{
> -	if (WARN_ON(f1->context != f2->context))
> -		return NULL;
> -
> -	/*
> -	 * Can't check just DMA_FENCE_FLAG_SIGNALED_BIT here, it may never
> -	 * have been set if enable_signaling wasn't called, and enabling that
> -	 * here is overkill.
> -	 */
> -	if (dma_fence_is_later(f1, f2))
> -		return dma_fence_is_signaled(f1) ? NULL : f1;
> -	else
> -		return dma_fence_is_signaled(f2) ? NULL : f2;
> -}
> -
>  /**
>   * dma_fence_get_status_locked - returns the status upon completion
>   * @fence: the dma_fence to query

