Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19652EBFD03
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0610E327;
	Mon, 13 Apr 2026 06:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QB9AEWyF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCB810E329
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvySxG2De0i+xyC1YihMdxMD+wwtllvl3A7Nj5j9P8Ih25+Vef1uOlzsrlRzqIsNiEBRizX1UQHPjq+B+MWkMRz6+iSlsNf/b2AxbSvw2UNYXHNOI+oYPn//vtRaH10vDCT4z/xfBfg/tx/wiGxFOd7k4kD0MfD2MV4T2+vH/ANHQN3bQAI3B1yb5xCs/mOrnnQ3yRx4nB0dxPY0P3FAM3XhngFpBzRWCyFAOuydG6QVF1EmHNDfZvWLVN2hkoPOYQDlc4qBbbLhrX4FybUJjGIZriA4VBMuQZ/OEuEz67aA+qH0HvcJAc/af0RcACHcAJ2xr0H3prN998G+R+0tlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq9ivFJVIK9NV7J2Rzdw42G7qz9FFimow6a34CM/Rtc=;
 b=lpxqT0UmCvh/6mntrGYM+qxBPtKkqyDnlCAt91L+jKEmT6nTvj74sj2xEXWCQADdPm7qXwCB+RN3ZVe9roqmEtLIb/bV4L+YY6yGX8ju+nN8rNO1b1vHS50Hx/2roi3Gs1s5PwT7AURdLj6YfOff5PXegHDPxkY5Kxs0ZRJL4eaC/TS7XMt1FGGfCdcKFQkApL1nihN5tqmfsfLVhQT2rkuMiXqGwzUo/mG/0r7Hn7gdDqjzW4FXpOwoxy1Jp/6CHfS32ntVPo+5OtxXLLPTaN0mOxg1duDDFdV0RfosgLNUb3QFufLLGEwON8ecwFnz1WA16yEA4U8YXGgEUEYwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq9ivFJVIK9NV7J2Rzdw42G7qz9FFimow6a34CM/Rtc=;
 b=QB9AEWyFTiz1WKiRxf/N/NXOVTjfjxMnKv/oxk455b8KumkF4v4/lJ/OF2xPeCVwjfdSPjrzMdN35a9NzoNYDsiutlg9wBKub3eeFrd9xeXwvpqkW/CC1m5B7op4yD9/tAYLVRp2vJjPuQJWMF/Hby9qOLGS+uR3yzKSB3XKTio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.47; Mon, 13 Apr
 2026 06:52:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:52:25 +0000
Message-ID: <c09d9dc1-43d1-4d7a-93ef-9707f282ad07@amd.com>
Date: Mon, 13 Apr 2026 08:52:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Move signalling tracepoint to before ops detach
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
 <20260331094944.772833c0@fedora>
 <918805b0-2cb9-454a-9048-84cc5bfc8798@igalia.com>
 <2fae926b-a25b-42bc-ab63-caf36505b33d@amd.com>
 <601a78ea-74e7-4b20-afeb-d822a362484a@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <601a78ea-74e7-4b20-afeb-d822a362484a@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: a55c013d-5c4d-4321-8c5a-08de9929380d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 2FzGcz3o4FW/qHbgkRIdQh9fWDy4EvSQWu2BWlSNm1ZGOvltNmS6yysDucgR/6Nf/Jd2EgSOHzw3MUmbfSYSfltK9zbf0kl7IY0wTxLY8JV3uD6dlcYuMAoHKyhtH/QShb9o7W76Vke6V6iOMm12OTqPpcj2n8nrPcELH6j+9Boonp5jgq2XtJiom/D8FB7lXJdkSueBuseU/uuBo2rBysHLmn+/zDtgY+DJWbsEQzEulhnuHObPrDMe5zJTqkD8ukbZ+oMVSL7aZPxIDR2J5DLDbNNFO0jfzEPjcgvWL0iIvTNah4QTGKfOcKVo54OqNSRmnhzO/61YrldufIdIwt5Y2rezid0cDyz785rheW6aL1WmxdqBKZ9uN9yohYVajzrGQbzkyoE6hatBQpKYNbZuG8son4INjwVGsdaVNckpzh6sR5sanRD1I/LmvXEGLSdDv0xc0PEvhg0K+Z4+Xg51UFuTDUfOZXL/xnJAs0Tw3TU3C1EVfdp/XDLnOxywknfh1AwWUxgGTow6aUfAu+711surrqko2O16ELRb2KxzeXU5KsuhTT3DQ4orSUZA+1c9kbjoyuBsd1EfyxEyMXlEKGd70sfOW0wrfU/t9JD9K7nCGJf0KbTGYAOpt8ALDPAZlfeyp2gC1wq4+1pA+nHMDIZnf6Rd1PcpeSHsVyPA4szxBJpVbJaYuSIwN7mhzuaJHnlj6QdvWsgEzJSRZ4oePJn05hDnLaoQcEdb3nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmwzQndCQTlXSmhxcHVmd1llUytDRmZDTVd2eUxtemU5VEN5SmFzSFdUblUr?=
 =?utf-8?B?RDFEUG9tNDJ2QXJ3Tk1BdHluRWlpd3F3c3hqc0tJaXVEUXBEUzgxMS9xOTVn?=
 =?utf-8?B?akNONWV5OUxDZFpma2hkd1h1SjNMT3BoMkRKVFF0dElMcGdaZTJUdFVYK0hs?=
 =?utf-8?B?OFQrNGQ2UW5vR1BDY0lYdHF0NjA3U1c5TFdBaE5MOEZaMnFLUmxOOGV2bHhu?=
 =?utf-8?B?aHNEWUg1UjJNSnBJSE11SU9FcmJhcTNSNjBRL2Q3V0hzdVh0eTY1bWR3U2Qr?=
 =?utf-8?B?OGhKVllhK3pqcFAzSXBqL0VGN3RNTGkvb2ZIK01lSGN4UE5PNE9walQwWjhh?=
 =?utf-8?B?cGZUNHpJQ2EvUGE2aUtnbkpUYUZmS0dlaXArWnB6MWZXOE04bDlReEFodFRB?=
 =?utf-8?B?UWZrUUpBYWE3aWJGUzZWdHVGT2dyblB5eUZKeXRkd2Jkd1UxM1JzUktHUU1B?=
 =?utf-8?B?WTBRZTIwTG02cjBuVnVablQremVrWkI5RzBlbUZPdDhmUzFTRGZEejJ2djdS?=
 =?utf-8?B?dWxweFlqUlBTaUwrb1VsVDBuYkR3RkRVMlRNSE1BTWVBNjNLaWlERmd0RzdL?=
 =?utf-8?B?TkQ5c2g2V0ZJYjlkSmsyaU1EYnBnLzM3TDhCSGJ0WE82RlpXOEk2OTJDa3py?=
 =?utf-8?B?Y2t6WkhBRFFGaStXQUlObGtKMTVRcW94SmsxdmxoN3dLam1lRGxDd2ZQMWZR?=
 =?utf-8?B?K2d3MVpBaWFSVTVsOXFRcCs1eVhnMVRJaHpzSHlBdWp4RyttSXpTTVZ5TTMv?=
 =?utf-8?B?RWV5TXc5bENWVkliQW95cVNQb28vbitXY3IxdVpEMXcxdFdIVlY2a2ZkZ3p5?=
 =?utf-8?B?TUc4TzVSZ1JVRVRpTE0zUGZLTytSdXlncXVlS2V4djdzUjU2MVdLdlJSZGM4?=
 =?utf-8?B?UGdqMnJ0bWtIRlpacndJaXpxZjNSUFlyaVEySVA2dkI4VkxOamtmVU1wYVNG?=
 =?utf-8?B?eWM4S1dYc2lERkg3R0tySjB5LzFXMlNDMlVRc0FpcnlBTGJhTGxlZmFoK1BJ?=
 =?utf-8?B?a0VCWWVqcWdRMHM3OW11L25hM3JnaWtqMWxsS3dHWEhxMXdWY2FWRjV2R3Bn?=
 =?utf-8?B?bW0ySGdHeHZma0FnV213VTQrTWJDVnFlZHlXb0xWZFROd1RtRjNTdUpDYkxU?=
 =?utf-8?B?b1pTYzNMUGpaMTZVTXpoN3VkTzVYNzRDZS9mR0VUTTBGUDJyTVJwQ3BmS3l6?=
 =?utf-8?B?SVQ4alc1T0Z0bDQxakdpeTFiNGpvRVNoM0NudG1BQXI5eWNXNjhiQWpwMFpT?=
 =?utf-8?B?NWovbDNzK3BMNXVJOHRxWHNzV1phK0tDMEZ0Z2dTdVdDK1g3K0RTcklJK3ZN?=
 =?utf-8?B?WVNyQWE2NldCMTQ0VWRtQngxdDVCQ3E2WTR3RzdWZ2FWWVFXK2E0R2VzWXBo?=
 =?utf-8?B?NXUrc3Bwamh3TVEwdnNsUEw3eTkzN2Vid3JNUmFBd1ZWWDhzNEgyenBjRDhH?=
 =?utf-8?B?RWhhWEhHa2VrSmZoMzFRMGlFWHVwZnVtalZqcnM5OHRLb1o2YVJqdFp6SVlK?=
 =?utf-8?B?ZXpKc3o2T3MyNDJ1cWsyZUZmdzRyTVlkNVF1QWRzd0RvdHpCQXhFbWN1RUdL?=
 =?utf-8?B?TGxTenQ3ZlQ3WkNuZHkyQk9IU2pxbHpPYjdWNGtMcGgvRUtqcDNKYXBFZUU3?=
 =?utf-8?B?b29sTVlLbVBqRklQY0gyRTJ4b2xxY3VQR0VVVUhsOGhuV3BPNU9xU21PdU1E?=
 =?utf-8?B?Z3FVL0tQN0w3NCtsa3ZtaHBiVTg4elJza0I0M1JqUzErdFJiVUdJYjVxVnpm?=
 =?utf-8?B?elMyYlBvb2ZiNkIyam05OXZ2Q0ZmTmRaOS9XbXJIWDZrTGlBQUdsdmM5UVpY?=
 =?utf-8?B?MHJ3TFE1NTZ4UDFFdkRGZXpkcFNHN3hPZFg3VXBWdndXbnBDTE5JbUpuSG8y?=
 =?utf-8?B?Vkl5ZGtTOTBzdWdDbmN6N2dLbUVvMFVzbENac2t1VzJhYS9GMUhYNGF6eU03?=
 =?utf-8?B?dDlkOUFYS2wyTUVtZGhqUllLRklLM21yRlFndUY5YnNhT2ViTENZSmZ2MXkw?=
 =?utf-8?B?a0ZmSURhS0xuWEdCUkxqaC9sMngzTklYa1gwb1c4bTk1V0EyUWxGMmFocG5l?=
 =?utf-8?B?VG4zQll4TG5TN2UxcXozSkdRNE9PZnZ4OTJSTUxqTjBaRk1MTHRGVjdLSFAr?=
 =?utf-8?B?UWc5MlNOa3dxU2VYR0pRZktKZjVOZ2sxNGxoV1h2SjNLRHdUOEVJYldHZVlE?=
 =?utf-8?B?NVhzWUNoZVE4K3BIN0xEQ3puY1Z4UHVEaVgvVGNZcStuM0xra1k0ZUcrcjUr?=
 =?utf-8?B?dzJEb2hxZ0xoWlEwREY5ODRnTDZmUEFCMnJSRENXV2NIMTRHd05UQTYzYWFp?=
 =?utf-8?Q?Tg0DdQWcBxW+yp5T6a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55c013d-5c4d-4321-8c5a-08de9929380d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:52:24.8910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCr+y7DK2GR35zpivyXzKqdUfkkydWhXA5bgHYZAuB0UY4KunV3vvE8Hcg4lsbdR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

On 4/10/26 17:37, Tvrtko Ursulin wrote:
> 
> On 10/04/2026 09:58, Christian König wrote:
>> On 4/9/26 15:58, Tvrtko Ursulin wrote:
>>>
>>> On 31/03/2026 08:49, Boris Brezillon wrote:
>>>> On Mon, 30 Mar 2026 14:36:23 +0100
>>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>>
>>>>> Move the signalling tracepoint to before fence->ops are reset otherwise
>>>>> tracepoint will dereference a null pointer.
>>>>
>>>> I suspect other trace points are impacted too
>>>> (trace_dma_fence_destroy() is, at the very least).
>>>
>>> Indeed. I wonder why that did not trigger for me, while the one I fix here was an insta-crash...
>>
>> You need to actually enable the trace points and at least for the destroy one nobody is usually interested in that.
> 
> Right, but I was pretty sure I was enabling perf record -e 'dma_fence:*' when I hit this. Anyway, it doesn't matter, I could be misremembering.
> 
>>>
>>> To fix trace_dma_fence_destroy I think we need a new tracepoint definition ie. move it away from the existing event class - make it just log the context and seqno.
>>>
>>> Anyone has a better idea?
>>
>> The idea of tracing without accessing fence->ops sounds valid to me.
>>
>> Alternatively we could call dma_fence_timeline_name() and dma_fence_driver_name() from the tracepoint as well, but that means the tracepoints now require a RCU read side lock.
> 
> We could possibly use the helpers. I am not sure if RCU annotation would have to be casted away to keep sparse happy, but more importantly, I think it would not be safe.
> 
>   thread A                    thread B
> 
>   dma_fence_signal_timestamp_locked        dma_fence_timeline_name
>     ..                        ops = rcu_dereference(fence->ops);
>                         if (!dma_fence_test_signaled_flag(fence))
>     test_and_set_bit
>     ..
>     RCU_INIT_POINTER(fence->ops, NULL);
>                             return (const char __rcu *)ops->get_driver_name(fence); // OOPS!
> 
> Apologies for long line length, it did not fit otherwise.
> 
> Looks like we missed this. Or it is me who is missing something?

See function dma_fence_driver_name() and dma_fence_timeline_name():

ops = rcu_dereference(fence->ops);
if (!dma_fence_test_signaled_flag(fence))
	return (const char __rcu *)ops->get_driver_name(fence);

We first grab the ops pointer and then check if the fence is signaled or not. Since we first set the signaled flag and then NULL the ops pointer in the other thread we should be save here.

Could only be that test_bit() is not a memory barrier, but set_bit() is so that would be a bit surprising.

Alternatively I would be fine to switching testing ops for NULL instead of calling dma_fence_test_signaled_flag().

Regards,
Christian.

> Regards,
> 
> Tvrtko
> 
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>>>> Cc: linux-media@vger.kernel.org
>>>>> Cc: linaro-mm-sig@lists.linaro.org
>>>>> ---
>>>>>    drivers/dma-buf/dma-fence.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>>>> index 1826ba73094c..1c1eaecaf1b0 100644
>>>>> --- a/drivers/dma-buf/dma-fence.c
>>>>> +++ b/drivers/dma-buf/dma-fence.c
>>>>> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>>>                          &fence->flags)))
>>>>>            return;
>>>>>    +    trace_dma_fence_signaled(fence);
>>>>> +
>>>>>        /*
>>>>>         * When neither a release nor a wait operation is specified set the ops
>>>>>         * pointer to NULL to allow the fence structure to become independent
>>>>> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>>>          fence->timestamp = timestamp;
>>>>>        set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>>>>> -    trace_dma_fence_signaled(fence);
>>>>>          list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>>>>>            INIT_LIST_HEAD(&cur->node);
>>>>
>>>
>>
> 

