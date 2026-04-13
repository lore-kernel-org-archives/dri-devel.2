Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7910EF3ED79
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36EA10E0D7;
	Mon, 13 Apr 2026 11:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7HJA8/L";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F49A10E0D7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpSjLD0V/8GnRH6HBMLtSWBeuKXrobS+j3VJqn+G1oYp6gTGdSUdDqZCwuXLzKgY7wHX9wtEBfWTi0HcIN9XHdgEUCFfsPd82aAA832cdNjIlUblC/uu4GyYsQsh6JhF2wGzs452tb8EoaPBnXCByu3sjm3guLu8Y39WtZ33t32RM6uvvGzhFDQVSC1Ny/WkFfw87DGogEwk3qgZczgt0+2lhOnWYb9Ct6R8fY3qezJKK67cVetLoHDwhqeZJXriXdxHHyT0du7RklBJ2gLPO/A7DnxWKO34o4aSaHd4vhCTIIBApw7MAvFNkJfOF8OCQqH1CKyE731bLFUGC9xOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvJr9g1J2T/adJC3ASFCePzpM4bIfVtLnkBeBvR5dw8=;
 b=WpqjoLoCe1Z9cd8OiiQCkYD7Hw81T1CwM4/3/bccNI76nIeHjRsy2IjHzsJ7oFgqALacs1kSU0NkYR62DUeADwXZec2kOsslQtNJb7p2E6gnBcoI8xOAph+ZjVVyzyAfaXdZWJstEgZTSRo8sV4K9XtNPd4iINo4LKrGzfeinXvKBkbJ/OzK1/VF5R+WU7HV0CVUbKbp7ReAZw/i20FxTdfmRJ8Br70fGMI6eOXQV1R160DmhIpL/dB3+01OA44e9HIXUDUV55Gn4f7YLz5tG0hCvtsobIBytstOEPOAUu5qbRXq5rQjphZ9yJLU+tml7QocyCh4NLI/eItiyG3k7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvJr9g1J2T/adJC3ASFCePzpM4bIfVtLnkBeBvR5dw8=;
 b=R7HJA8/L3huXqgf1sK4gxxLOBpqFv1qDNkpIeCnkDPkLQM6lDR7jB+kKCbNFRi64dNGMjWXOK+JDaaTX4hsCc4Ff0lq6NnokZwWP6yGqfJVOXfeNfZNQ5XsTWM9tpPW/bhqg4loYKdaaovKpEY9DHlMR06HhCAAHSm9OKIezPxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 11:32:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 11:32:26 +0000
Message-ID: <db5342f2-c098-4b27-9522-8b1f78fdc43a@amd.com>
Date: Mon, 13 Apr 2026 13:32:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-fence: Fix potential tracepoint null pointer
 dereferences
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Philipp Stanner <phasta@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260413100526.15729-1-tvrtko.ursulin@igalia.com>
 <20260413100526.15729-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413100526.15729-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0368.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee53bd8-5e18-440f-9eea-08de99505672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 06aum62GeSzHWuNavjYUjFyXJBtWS5i9RDCqpgdzlmx57sRBUxyDb/uj4QIrCK21xTaxL8tS7pAwRdVT27AxrjNrNZW2SwM7zoOjbQmy9/y0OZIct5crvItWVZQLL83phG455AuQ/5nWDJ6vSfaa3r6lcGeglvaZWIIB0pJEi4FEySESiNVSl8yyzNLh8LKdWJnY47jExt/zS6qprFPNC0Tfw3qt3inF+bVcQgNUAQpC8VnI1ZSTrS0UiQEQbdHFYHDugxYdHxGqJ5TFjqaDdA75joDHuKfEi3JP2aJOXTTm1w1kJNUH7eFTFPrvuSmnEVhSAju2jpM+Y8NwAFGPcJo8F35bTpErlRHSvXKrBWl9e14bFIL3FsF6l0XsrFdJJx2XwL93jdpl24k3JVDIPR20TDkixKzpygvcWT4k+ITs5BcVzOzJFc4mJFGxKW0B70uclqzUjjJhv8lKHyJKxRx5OE17Z0gu1Di1CtM8cbQ9vKy57JbJKPK3e6dot74G5/wHr7uXsWAfzGyROOXpPiS+mAqYe5SOJ7JMuKobtQHV0kwHCq337u0JapIBh1eQQL3MMIeWs08VrCRDka2aP16koUsCGYO+w+VKmXeUSBSxBP0HBDzsXuYzIzYve7KgfjUPgwZgSOizo2SOnfXvk/juqLLMeI7ZynmChZoQvs9vIONQysRSYPIJ4uALmyn2Gzkn2YQUw5j/7F7AEEeBvQ+4TzO5WIfh2x9oQxK7jO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxlaEtYbDV6VkdFeHZ5WXp1dkNIMzIwVjlPcnNuRGRQY1h1b01tc3NBdXg5?=
 =?utf-8?B?dGQ0QXNaK0s5YWErZENqZ3owRHhEKzhoMldEd2EvL0hNQWVhZlJCQ3VVeE14?=
 =?utf-8?B?R2xqVHQ0Qm5EMTI4cnlYbGs1RmxCU05RNWZCR0h0TC9GckZwTGV2UjBUVTNk?=
 =?utf-8?B?d3pCdFVmRWphM3llam9sYkJWMlg2TDdQWDZHL1hRVm5vY3ZMVVlKVEhRVjZ4?=
 =?utf-8?B?MUZnQ0g3WEU3OW1wRU5Xa0tpTm9aZmR2RmZYR0lBaGJwdEp3SVRmQ0VxZXJr?=
 =?utf-8?B?VnZWVnJtUTRFR3VDbm5yYXBKNTFyU3VRdlpXcmM1aWdRRGZGYmdyTG8yakcz?=
 =?utf-8?B?dTFhYVF3c2djaWs1UGx2TnVtQ2VoVjc0blZsMHRnbXQ0TzlDUW5xTmtOeW9q?=
 =?utf-8?B?Nk1jbVFKby9MQUc4a3NTckVrd3EycDdhVWJNZS9qVTBRUnkxVTQ2a2xTdXl2?=
 =?utf-8?B?MERrVkQvNDdsMnA1bDlxK1VjM1dJM2xvMGRUVVhjSDl0c3hqMU1ad1REck9X?=
 =?utf-8?B?NzIxbEJ6aVNYUndVQW5aTENKbGhMNlZpaGQ0UXJzYUI3ZVdKOFJhRS8yQlox?=
 =?utf-8?B?WUlON0V0QjZzQkkzN1c4eVV1OFZWR3VwZE1CdVJ6eStZQUxtV0VLcXNLK0hJ?=
 =?utf-8?B?Wnp4RzdXU28zZ21CeEJGTGs1b05BTWI1ZlE3Vk5lNkk2cXpldlZCOGlQWXpl?=
 =?utf-8?B?Tit0L2g0VTRkbGVpb3lqWkFTRW5CdnFLZDlJTjZqRTZHa0c5a2lRQXAvZmJO?=
 =?utf-8?B?Y2NxbnlzTHFha2NDUHI4SnNZczVLNFZxdUo2R09hVDlxaW4wbk9qRkZZTnYw?=
 =?utf-8?B?YkI5MEFwblBYN2gzYVlDYnlvQ0NoWTZRRDZnSm40OHU5c2FuQnNvOTJxYlNG?=
 =?utf-8?B?bjl4V01abGdlekh1anFYZklJcDZPY3U4eXRJSThYa0lPaStncFFLUUtZRkpJ?=
 =?utf-8?B?ZUZLaFV0dUtmQVhwL1VNRVZDNVR1MjRYckFmdEVJTm4wSUNtQ2NYRy9haFV3?=
 =?utf-8?B?SGdDVDZBd1BvTXpqUXRMYk5hQTNwRTdqd21KbVZkZWU3MU9YL21wMEZGM3Ay?=
 =?utf-8?B?OG9mcFU2Q0sreERzUmo4VTQ0N3JpUEw3T3ZCelRGVTZxK05FMk53TzhZT1Zr?=
 =?utf-8?B?ZFd1ZEhtYkw2dE41VE9NVncxMXVCSE84TXVuUGd6aGJuU1JKQi9XeW5Vdjkw?=
 =?utf-8?B?SWJsaWwzaEowL3FUOC9sOEtMRUlHcHhoTlhnRFpxNzhveS92eTdlN0FxUW1l?=
 =?utf-8?B?eXIrVUtXREZKZjkxZDRkWUxwbmc2U3U4dytLYUlZWHJGZ3FOQmhmQ2ZuT2dV?=
 =?utf-8?B?OTBueDlUSTVRUVZrUEV3TEx5MU0vMmw0ZTBsOU5xamFEcVFRTzYwRWZzeWU4?=
 =?utf-8?B?OXQzWEFEZmZjcEtYLy9nWVVuNUl3VGJwWFRwSG9rcHlJRHlqblByejRNY25u?=
 =?utf-8?B?UjZjR0xvMHZObytJd3NxNEtNL2VtdWJvTWtuMkpCSVRxODV4R0x4QjNEZEpv?=
 =?utf-8?B?cHdNeXlxY1F6UTR5akxrOG1jSG9YQ3dWU1g0YTZ3RytjdXdsVkZaNmppV3Ex?=
 =?utf-8?B?UjV2d3ZVWnFjWFFpUDNXMWxERkFDYzFCVWgzN2JzTmpaV1p2UDhRTE1JbUFy?=
 =?utf-8?B?TnRPb3JNc1BTZlc4OGZnRjVqSVZEZWJsdU1BS1dhenRNSFhLaXo0U0J5eVVu?=
 =?utf-8?B?UGYyNmJHWWNrdWU0VmZnM3VrbUZvK21UVEp3cXc4UWpURmYzQldOVTB2UzMr?=
 =?utf-8?B?N2NWV0U1RGoxQnlUNVJ0dzF5SUZOMThidFFlMU1RYVlJc3FGdW9GYWhKY0Ev?=
 =?utf-8?B?VzRXMEJWN3FpaHk1T1hyN3BubVV3NUo4OVdwTzdjZnI0b0lKMGNwRi9nUjJj?=
 =?utf-8?B?V2EvVjA4QTJxRFl5RWJQSWlKTTZKcHIySURTZC9OZGRtY005clJKVFlIcEFj?=
 =?utf-8?B?YXk4bFE3VXVKZ2I0VW9iUmMxUkZueHZLK0szK3JCT3pLQisrZ0FPcHZTOWhS?=
 =?utf-8?B?eXYyeWJNUmNuVGRGcUcxazZGU3FKbXZCcUdaVEtxVllGL0w3UDdjb3FZZXFq?=
 =?utf-8?B?WTcySEdSMlZPa2NhTHBKOFhib092T0ZWT0w2UkJkM3QrZjZ6TEp1cmNGZURq?=
 =?utf-8?B?emkzdTZOeTBrVTdEYUp0OGhiTm9iVDR3WE5VSnQwUmx2akUyZlc5Rm90bXIw?=
 =?utf-8?B?c2ZaTEx5OEkweWlsaE1XSWJHdW5RbmwzZmtndHVXRlpHMVdUU1pPTloyVVBv?=
 =?utf-8?B?OGpBbUpNemZqY2U5VUVyM1h0eUREdWhmWU40NUlEUTd6Qm9RdXo2aHMzMHov?=
 =?utf-8?B?UmtNVDQrU01IbllKUk1PMFNPMlVBM2MwOUR1YU1scGxCMW1VcEw2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee53bd8-5e18-440f-9eea-08de99505672
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 11:32:26.1548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7NEBZkPXeX1Kk1mOpy5oBhMEAtfs5l+bYTus+2u2qiu86790siqs7kRVz2vWDdJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
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

On 4/13/26 12:05, Tvrtko Ursulin wrote:
> Trace_dma_fence_signaled, trace_dma_fence_wait_end and
> trace_dma_fence_destroy can all dereference a null fence->ops pointer
> after it has been reset on fence signalling.
> 
> Lets use the safe string getters for most tracepoints to a void this.
> 
> But for the signalling tracepoint, we move it to before the fence->ops
> is reset and special case its definition in order to avoid losing the
> driver and timeline information.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> ---
>  drivers/dma-buf/dma-fence.c      |  3 ++-
>  include/trace/events/dma_fence.h | 29 +++++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index a2aa82f4eedd..b3bfa6943a8e 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  				      &fence->flags)))
>  		return;
>  
> +	trace_dma_fence_signaled(fence);
> +
>  	/*
>  	 * When neither a release nor a wait operation is specified set the ops
>  	 * pointer to NULL to allow the fence structure to become independent
> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  
>  	fence->timestamp = timestamp;
>  	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
> -	trace_dma_fence_signaled(fence);
>  
>  	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>  		INIT_LIST_HEAD(&cur->node);
> diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
> index 3abba45c0601..220bf71446e8 100644
> --- a/include/trace/events/dma_fence.h
> +++ b/include/trace/events/dma_fence.h
> @@ -9,12 +9,37 @@
>  
>  struct dma_fence;
>  
> +DECLARE_EVENT_CLASS(dma_fence,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence),
> +
> +	TP_STRUCT__entry(
> +		__string(driver, dma_fence_driver_name(fence))
> +		__string(timeline, dma_fence_timeline_name(fence))


That requires that we hold the RCU read side lock while doing the trace.

Not sure if that can be done inside the DECLARE_EVENT_CLASS() macro.

> +		__field(unsigned int, context)
> +		__field(unsigned int, seqno)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(driver);
> +		__assign_str(timeline);
> +		__entry->context = fence->context;
> +		__entry->seqno = fence->seqno;
> +	),
> +
> +	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
> +		  __get_str(driver), __get_str(timeline), __entry->context,
> +		  __entry->seqno)
> +);
> +
>  /*
>   * Safe only for call sites which are guaranteed to not race with fence
>   * signaling,holding the fence->lock and having checked for not signaled, or the
>   * signaling path itself.
>   */
> -DECLARE_EVENT_CLASS(dma_fence,
> +DECLARE_EVENT_CLASS(dma_fence_ops,
>  
>  	TP_PROTO(struct dma_fence *fence),
>  
> @@ -67,7 +92,7 @@ DEFINE_EVENT(dma_fence, dma_fence_enable_signal,
>  	TP_ARGS(fence)
>  );
>  
> -DEFINE_EVENT(dma_fence, dma_fence_signaled,
> +DEFINE_EVENT(dma_fence_ops, dma_fence_signaled,

The signal trace event is actually unproblematic. The question is more what to do with the release event.

Regards,
Christian.

>  
>  	TP_PROTO(struct dma_fence *fence),
>  

