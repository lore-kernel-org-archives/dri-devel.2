Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F76EE99056
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0389410E8F3;
	Fri, 10 Apr 2026 08:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vi/v6jlh";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570EA10E8F3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPnU8RnGhjU0Avc195Xi74RIGiiVyUMiVbxID7Fm/5dxQfsXgm+O9w9444F/YD+lZKWMsUTzorVN5iI5wTr73teGz9CcUNjwrE6tCIyHVOGjpCd6Ug9Hkky/MNHwKnWabL/4dy+pVvyFQE9iDuQPDRX+D55eGvfq1VUjmhfJ/VksJy6NHr/49P3tCvmIymZZdgfOgDrOsRj4Puc04OAnwsf+wvAjju24aR9tJqIb0f+Hd7mnYKx1Q3MLByBHpI6SFr6YjU94dDDZPe/ujhuFl5xMEgRoeuA2ScmTo7smJzbuZSHDJfT7qp6JHVb0mzrgAHnhBXObuMOO76v9q53xsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILgRY5+Fz981rnHHgnY8pD7P4hJtorwPhDoWTapzONk=;
 b=wSed2XqVXB6aRf+IGxDEV1VsW7sjtn95MdRKZtXCyfp0Cr48E/1y8FxKe7pBjmSOhZTFMFHr+VZMvzXV/lbYABMgW6MmU7V3Gyw1mTKmaHawWAOjtAqOEdDjynqIo3NtfXxAizL8JZ0E8BGjMZ8uQdI4vej1r/0YoolfBCG+pqyFWi6aNRDnuS4oS6U+rHJ12RkRGZZbYC/8Xa9pRdL3m1Xto0yiT/oe4DT6vuw//5PIpIj7SV76QwuGfeZp6C/U+vnAGdlcu5jxcnrf6ZFXFXlKuAWwHXAsvj0VaoCP0ri/1eRs5erA3PU4uAzqj1VnBzrncSpd+2xG17nK4I+K0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILgRY5+Fz981rnHHgnY8pD7P4hJtorwPhDoWTapzONk=;
 b=Vi/v6jlhexjk+DA0jaDVS4pvqgXoO9QmbAWo/XhR0gw+Zy5hYBZwEHcpPluYzqfqubvosypTWo5Hi4YT3+iFViLPualb0ZQI4h+sL66EloU9L2roHj6AMlkXJ7nqLH1ldwCJb74D+zmFSzxuwGyU7j/mKXvtL3zGksJUXaw4jSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 08:58:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:58:52 +0000
Message-ID: <2fae926b-a25b-42bc-ab63-caf36505b33d@amd.com>
Date: Fri, 10 Apr 2026 10:58:47 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <918805b0-2cb9-454a-9048-84cc5bfc8798@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0154d8-80ca-440c-5fa0-08de96df6334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: QV6tsxaMjOzyk8KxTfN1ppGr5LpgJFgQ7GYltu/2TyxVYBHpsL5SMPTR+6YvdP+kGY7lmOI6uFIRgg4fMoWzHtH2gRPJXbKa4GnXS4l/MgoZry0dj81PA99erv1oYSnTi8EZyYX1kNmY+Dpov2OnB6+SuoyRkNib4tHbvhBX4dSJg+mk6xeyDakT3h6QAC62r2obzNqp2RA082DkXnpq+e4vgezU4/q8086JtzRmwbEeiAXBC1Sv3odGX9MnIz9hd1Yd0x2CqLJzqgySkWRuhl8V/oQlA14kO5UDszKle5qBgAk6WHkcYh85E8oGOfNuWNOaRPRWktaA2zL65nHYXmukUQIeCLe7P4EBguSDVNVaAo4+asS8aHYyZCiewANNHOktrd/9d1ug5r5PAuPADgb7HmxFcp+Sog6hwNzf/5MrC8BSMmHtDsofkeQbzHgeoB/AdOn18WaVkGKEppD9UI4Ftf+UYCeEWxcEEVDT9ohC1RvHcAyQ94dAGMQeexx89wmPW5xBc/mTsWDBs6+GswjaxcJuPu2U6MkrRsHwlw5pFXnEJ/I8gZH3z3aSZWAvtuCPJv4zdPfZF4MN248epxh4+slCS04lxwlBKbLexa4TtHhKmc0klezrCeqrNu8U0naVZTBOQAjEEC3ZtPFr3uipGIVE3TegR+UW8WkbLiHjtthB1yL8lWPimKycs4WMyiiSVhy4UXFw4hDTTpC7R3QJsKTsll28fFhcmJP31vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFrdFBiNVFxVWFVRWh1RjdmNXlWQzVkNFRwV2JVb2hHM2M0SzJ0VE1yN3p0?=
 =?utf-8?B?VVBuSTJGUzEwRC9oeTFibkovT1NSRVhBUEMvUXVRa2orNGNOclNFc1E1dllK?=
 =?utf-8?B?cUtLcm1VOUJ4cFF4R3RHOE56SDJQUC82aFl4Y3dYVXVJZ1RuMS85bnRFOWM5?=
 =?utf-8?B?Y2RKQnJkNjRwL2dOVHowbWpHRDM4Ny9oVHBTeTNQbHVWQ2lwQktQSm9kM0gz?=
 =?utf-8?B?bTd1TUhnaXdqVlRLR1U3Vjl5YlpSRUFOSUc5S3dvbDF1MURXb1MvQjE0dlRL?=
 =?utf-8?B?aHQzYzNmREtaM2o1Wi8vVUEzb29lcEhhZ29wR0ZXVjE0WXlnZjBSaEFBWXpX?=
 =?utf-8?B?cjcvcG5FdGs4cXdJK0EyYzRtOS9BcUhZQmM5bEpISU1iQ0JXQU5ybW9lMm5h?=
 =?utf-8?B?WGJOcGR4M1NyRXZ2TUZ2T2xiUk9XWnBNSzdTZTg3ekl5OGxYVzN4WWtuL3VC?=
 =?utf-8?B?Z25pZytKbkNRZUZTbXV3WjRtWkFzTHFBSGk2RkdseVNNZHpOTTdZTUg3MTEw?=
 =?utf-8?B?cndZajkxdlV1QmM1d2czcVdXWmpaSXM5aVlNQThLL2ZEcGNzaGhPYXdnK2hn?=
 =?utf-8?B?QXdoUVZJUmQ1WHBtUUp6cnRRNExFTk4yckQwSElsa0NEMTlCZGJETGw5bElr?=
 =?utf-8?B?U1JTZHZONHdJeVlxRkRaL2hJcGVvOVU1Snp4aHBwOWZCellqVmlCaHB5dUlo?=
 =?utf-8?B?UkdmSzJmY2JYRHhrRmpuV2hjK1ZWci9CNldlUWZEVWxFRjRuZEJSYUNiU3hj?=
 =?utf-8?B?Z01LazFkK0tCQWVhWCtsN2R4aDhYaWJXZytuekZUMHRlM2JKdDdMbmEyTG9B?=
 =?utf-8?B?dXJITDJvK2N4ZThvZit3NGVqa0pBWUpVM0JydWczbDlwc2Z2NWVET0lFYW1F?=
 =?utf-8?B?NytlWE9YNytKdTZlN3dpbGgzODRScXZrQld2cnRESG1NcUFFTWg2OVA3dGlI?=
 =?utf-8?B?THhhejNlZU1RN1JCSEhKTTBWczN3T3hNU1FISWhwbWlzY3B6bzM5TkRzZ1E3?=
 =?utf-8?B?ejlJZ05GZEdnZXFTTG5ZL0dMay9mRFRONERycFVEbXhOTjV1TmZlMTFWYU1i?=
 =?utf-8?B?OVJBV1lhNGpRZXBTVXVsb1pZVHhMTDFRYU5hUFlFcVp0bGNIQXdMWklTS1dB?=
 =?utf-8?B?TzZ3TVhramZTQnNLRGpVdk1CbWlXYTYxd0Ivck5zSk9uRUdINnk4MnRVTDhr?=
 =?utf-8?B?dVhqeFl3bTcxSjM1UlExTW9qVzhqVW5pVm5ISXdBVmd5aGUxQnBqK2VXRTFP?=
 =?utf-8?B?eFVWWXJmREo3Vnl0dVlOTEM4UGczZ3ludVZuWmVYdGVRZTJYcXVnakg0akRh?=
 =?utf-8?B?K1B1SXVlOEM0dExsYkgwcm8xSmJlWE5jOHd2YWpjVVRWNno4ZGFqMHV2NzJt?=
 =?utf-8?B?VW44cTZ3ZGJtdS9Xc2hDU0ZTL3ZxQzNSdnFwdS9sb3ZRTUpNTWpJaFgrcGpu?=
 =?utf-8?B?VDA4NXd5VjREYXFpakxLc2ZyWjhHb2ZKRjlFLzFITUxYN2diem9KeDNScEF5?=
 =?utf-8?B?L0pjVDhIMWFoUzkzd0IvY01uUmN2bHpsRWFPT1BLS3ZVMU5OMnR2OWZ1SGJG?=
 =?utf-8?B?TDcrc1l3WDd4UTBmejc3UjRSakhOS2IyOU9qeW91cGNtaTdqNHdOcWxveUtQ?=
 =?utf-8?B?L3pqaE0wSkRwN01wY3dvazBwZVhGRjdETlVwY09mc0duUjdjMDhqdlBpYmhn?=
 =?utf-8?B?TVpMS3BjRDZaaWVELzBhSmFEZm0ycDVQb0xVTFZpdGFrSnBHYjRwZjJZMEw0?=
 =?utf-8?B?NHB3cWFsMVVONDNlQ0M2ZFJGb2ZRendsZkd6OFp3M3B2UWFjaVBHQUJUV0tB?=
 =?utf-8?B?VkkxYUxaOHVFU21ZZE1ZSWtuU3dLSW5rZ2loQkIzNEhVeVNMeTRQMzE0U2tP?=
 =?utf-8?B?RmJQOFhnZzZIckxHNHNNandxb2RzL1JYZU5BNFNzNitqKy9PUWFRbE5nSXlN?=
 =?utf-8?B?UjNuOUhkdWtKMjNWbDJyVHFBYmZBWlZ6L3J3N09SekgvVWZFMUNBTXZRcWVx?=
 =?utf-8?B?TG02eEhoRGhDYVc5Rm1PK280VXNyajhzNnN3Y0RUWVZTUjJjTWtvTmt1b1o4?=
 =?utf-8?B?MFV0NWZoMWJvNDZrYlVEUjZ2L3lJNWVkajREYVQ3Z1R5OVNXQzhWVEJkc0Fq?=
 =?utf-8?B?OWdxOEQ4VG4vS1U2OSs0REtVN2Y2S0wxVmdCMWFuNG5obVhpYXQxUnd0Tm5S?=
 =?utf-8?B?MlVaYUJTS0xLYmRybmlvUFQzczR4Q1M3ZjRYQXkyTGNFNzR6QkhaR3hNdnNL?=
 =?utf-8?B?clY2bUdlbHNHTnlXbm1BS3JpWjgrdGNHd3o5VGxTM1NodTB4TWVJL296NjVu?=
 =?utf-8?Q?cY/zpHlXm6477JIj62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0154d8-80ca-440c-5fa0-08de96df6334
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:58:52.0869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8amLVDQOszLaKY3VEyMlG8QqdUav34AXH9oNvZhikvT4SkFvuzazboO2/IIWao1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
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

On 4/9/26 15:58, Tvrtko Ursulin wrote:
> 
> On 31/03/2026 08:49, Boris Brezillon wrote:
>> On Mon, 30 Mar 2026 14:36:23 +0100
>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>
>>> Move the signalling tracepoint to before fence->ops are reset otherwise
>>> tracepoint will dereference a null pointer.
>>
>> I suspect other trace points are impacted too
>> (trace_dma_fence_destroy() is, at the very least).
> 
> Indeed. I wonder why that did not trigger for me, while the one I fix here was an insta-crash...

You need to actually enable the trace points and at least for the destroy one nobody is usually interested in that.

> 
> To fix trace_dma_fence_destroy I think we need a new tracepoint definition ie. move it away from the existing event class - make it just log the context and seqno.
> 
> Anyone has a better idea?

The idea of tracing without accessing fence->ops sounds valid to me.

Alternatively we could call dma_fence_timeline_name() and dma_fence_driver_name() from the tracepoint as well, but that means the tracepoints now require a RCU read side lock.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Philipp Stanner <phasta@kernel.org>
>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>> Cc: linux-media@vger.kernel.org
>>> Cc: linaro-mm-sig@lists.linaro.org
>>> ---
>>>   drivers/dma-buf/dma-fence.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>> index 1826ba73094c..1c1eaecaf1b0 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>                         &fence->flags)))
>>>           return;
>>>   +    trace_dma_fence_signaled(fence);
>>> +
>>>       /*
>>>        * When neither a release nor a wait operation is specified set the ops
>>>        * pointer to NULL to allow the fence structure to become independent
>>> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>         fence->timestamp = timestamp;
>>>       set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>>> -    trace_dma_fence_signaled(fence);
>>>         list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>>>           INIT_LIST_HEAD(&cur->node);
>>
> 

