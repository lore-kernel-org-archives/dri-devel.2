Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF0CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A96110E7CC;
	Mon, 18 May 2026 11:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjjQFquA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A6610E7CC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP/8P3q24W3GJYRtB8WD5Ta9iXj7xMxEMFAVtO+YgiaVRe48d9Nn01MeO7a0qYDYHm0WZlpzkbgoW09rHgg3vtGrA9kzN/NW86DDK2czTGCyCAZBwlvenOj4UBpUDNIPKoEjJ2V1yCLzmhF9Q0XIHEQ0+xbz/uoW2vnh5FLv81oKWyLZoBwgFpA73UH6JgvzSsxkRS1KDJIT/s423OBcX+nQJdI43y573m/Wmqx6uh4D5K0yk+4Jw9Pp11+HwGT6/IgUVu3i2RJiyAqXookHgVmHlah/9seRBmovUuvpXPq+srdRJEfDu2sY8UB7ICwgYmZBGOroKj8zyV/nBuTbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR04V0wq3TsCiGypHugn2nAIWcU1YlsnpFbG+BY/azo=;
 b=a06O6oKEK6AmKJbtO8pkIr9Jwi7uIqxFmwSSd5IJHYFGZcUvkbRLCuQ9hXtqH0+VbVM6sH/dU1WRyz8rzt54YuN2iPzDIrW4MEFyySrDxiZYo3DCrc27q92If6PCCsX+YKKvKDGFp8cKzPaPhLX9HALGsrxRVNBXJJ6FXIEgdK/JaSozJ1YF6b4aXICmHhyG7jKu2jCbnb9TPir5zyl9ED0FRz01CyJZqqSbiQGwT7kXC7vFBvWCdKhoB4mkTJWn1sJhtzsBMutCmRdUybaSASRK3Ho9iCYX1puH1z2BLxlA/TqXBn+j7agyVoFLlTRi+UcJ95Yo9nniBK2UsYXmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR04V0wq3TsCiGypHugn2nAIWcU1YlsnpFbG+BY/azo=;
 b=MjjQFquAz4ztM0TXZgmngmbYCd8VbvVMSHrWX7FF/miw1xRpCBtX833y12b3/7jJi/wmGam/McOjEpoJP9zWLEYaBdDxFtzDro0MBy67GFjNswH3tknDCvzcBdRIZeMu/E2V9vv0Tcpg2RYBVYzgwRj0IgOyvzSy596LL8Wj6Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:30:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:30:56 +0000
Message-ID: <1f22999f-a9e2-4d95-9a2a-5880b06bee46@amd.com>
Date: Mon, 18 May 2026 13:30:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, phasta@kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com
References: <20260419134943.54833-2-mcanal@igalia.com>
 <6389c57fd1453b545709c15c5fa74aa76a3d9afa.camel@mailbox.org>
 <d4267251-e113-42ae-b756-ea1ab63f9f7e@igalia.com>
 <3c616d25-381e-43a7-af71-73bf0b9ee063@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3c616d25-381e-43a7-af71-73bf0b9ee063@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: e4875be2-e5f2-4f39-7f17-08deb4d0ed90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: iUwxtE+oNtXWyuVwgY64211p5gCbh62WbpCGC4OdfoXtD6be9jlKmeuC7v7bKl+RmmW66B0i8BNOwrqLK9Zy5zyIJyPP0t8Nb295Qt5Gml6WSYcfeHR5ITgQe8JezOSDXJ+4NVY6NJY2FzWagnCjUBuZcekS4RJMDB9rpIUkq+IKwIJj6trYY45XID0aTVS7QKYqLL1C6U7glEgXfA0WjGfACvcXQA6RstclkbrMAvbgaTIjMIvxvIY2H2YK5E9bZpglPRdcHlQ5qT86emQEitnri8hk0yMXm0MxfxJlYNPXsaGCCXU/uCfPQRUdbjQCl/9lvDEvx1FzBaMHHQRTMXombR6CNzFptZ8fWg7eaSDMaTZJX+sWyAwlgsBqaqPyW4LS0x9XVcsHmzYpVjeZKw3j/B1Leb0SOwSaU/Ur+BvIpY+v98Lm7GTI/ndxjBlaAeXJf9oivX67AybaqNM+7+BIaqWdo4dh7RYlew3DvW30WrWOnoVcS61m90Ph08Vr9D7+hsyDNc/iCovt87XjTz1UEPAnOmOvZPoCAZuJzYvsS64n+4I3Ke10gNPtXIUylhmMi03v5/H9bihUpVFK9IRG5m668ydOc2LYqMigcMU7sB1WC93mzr+cI3/tYhWXIMvjRoBxJK+F4wbUFhhFgMv9kDkbg+IfSTcGRm+FQY4QTFZsAg+XD9roEr0hhyMcwrN9VWaGQ83v1vauu+1J4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRTZ0J3djJ5eXNJSVNwL0tTZVQzNnk3SmtFc0I5eERlVGVCQW9DWmRXdVZP?=
 =?utf-8?B?SkVwUTFUNWU0V2RRRGhhTTl1R1l0RTZoc1lvaG1IME9VSGM2VjFybXE2V0dR?=
 =?utf-8?B?SWVyMXRTdHNzVzU4emZoTzlDNmNZa2R1Ry9Ga3pRYjYvMXVCS0JyZGVmS21M?=
 =?utf-8?B?MU5uZVdPNlB5T296cUJkSUdhQ2ptSFRzWmtERFU4SmxobkZlVXR4dk9QUmd0?=
 =?utf-8?B?Z3lLUnBBK1pNT21PZElwYkhnZ2twSU1RMnF3T2tna09qT2lvQUI5NkUxZVVk?=
 =?utf-8?B?akFyc1NwbW5vTmJTcVp1UWNuMHR2L3BGdUExbzlOWEh6QzlVT0V4MlJEaTF4?=
 =?utf-8?B?NENrQ2N5NkJNc21DTko0Y3ZhaDFlYkpjMTR0cWVMQmtBOUVOdkRZL21ZcTNI?=
 =?utf-8?B?R1hzT0RpWmpNRzhvUFIzaWE2TmFrYmR3UnVkYndmR0FYZ2o4UThLWWlhajZi?=
 =?utf-8?B?d21aakJyRk5weDNlNmZyMWk1aCszQndyYUxta0NSajRqUGNKZzdkVURzV0Na?=
 =?utf-8?B?eTF0ZFJZVTJFdzcxbWFQQ1ljbXd0dDQ1VU5HRFRKaFREUVZrRTlvVEdOMFJk?=
 =?utf-8?B?WE4vUEs3ZUVSTmJnU0MxaEx3WDFYcitRY2JNNGlsN3dvZzl0eENXTHNvMnZk?=
 =?utf-8?B?QlF5YWlsck9ncTNJTlE0SkVCbGU1cHhQSDRCYXo2YTl4d05lSGNDcUhiU2JJ?=
 =?utf-8?B?NjFzNUdRdnJtTXdqMFdRMmNzTW1jRHlicy9lTlFvbTdERnBzOVNIRnBFZkdN?=
 =?utf-8?B?WEp4WHo3eWF2Qlg1aXl4REJiQVh6WHYwVGxPdjhPVkJ4QXpTSGVxU2VhTU5F?=
 =?utf-8?B?cXlmMnkwNHFaY2dIQVZKMUJrMTQ2emRXNlNzYUx0TytQNnZqYmxab1Bpd3hh?=
 =?utf-8?B?QWc5ZUx6RGxJVDZ6MmI0K1c2RkpRUTgwOUg2ODJNak9MOE5iNFRNL2tQdDdT?=
 =?utf-8?B?S29WZ2xpZnU4VWVKTG51WTJSdllXQis2NVo0OE44SmkrbVU2eDRvMTdpTVJL?=
 =?utf-8?B?OVVja3B4UVBjdHZjZkdyL08zbVlzZ2N5dzVkeGhWL2tsYUs5WVp2Z3ViOFhy?=
 =?utf-8?B?RHRRUzA4WG00RjhuSzl6Tk0zZVkzYkZUOHg3OGhvUTFxaGlRVDFNcmwwdVpt?=
 =?utf-8?B?VVVWVkpXRWJwcHcrZXRqZlRHSTVzUVgyNEltZTcyR0Z5VXBYNXlYOEVFTGd0?=
 =?utf-8?B?VkRKTUprRVdwOGwrdVFhV2laRG1pOXh3amdFNTR6OVhibWJwOVkxME9UTlow?=
 =?utf-8?B?VGkxYVd5THhtR1lZMEVEb0d4MGZyeU9Td0ZSelUxY2hwbEwwUCtwQXV2bnZo?=
 =?utf-8?B?Ym1VWU4wajI4MU5lbUZ6MEhJMFpmeUkrc2htUmlFR2ZNNGZCVHJSakxTTGhH?=
 =?utf-8?B?dDdoZ1U4TFJDbCtyZUJnY0FabTk1LytoamFjYmN1MUpaUEkxVkU2OTdqN3Y3?=
 =?utf-8?B?T1hvRFNoTjkvZkJ1MFZ6VVNvRElGU3FBYTJESDFxa0tXdldQU3B6RnJ5N2lD?=
 =?utf-8?B?emtLNHFvaGJ6bnpOSHhSa2FmNGIramFISkxiSFNGanpybWpXK0Z1MVU5eGpy?=
 =?utf-8?B?aDV0N29xMkg0dHJCVTNwVDB1bU16QUV0VWtlRmZkK2xjV2hHQm9Hanl5Smlw?=
 =?utf-8?B?T3JKL3RZWVBPUzluWk44TjF6cHFYWVV3QWRJQ3h5M1BldHJnSHJCdUJHK0E1?=
 =?utf-8?B?aVVabmRqWWdzVGxWbFVxeEY5b3gwUEx1UzcxK2xtTytsTTd1bEZ1Y2RjRVBj?=
 =?utf-8?B?TkZRRzZEK0xBS0FKczhuSFVoVzZzS2ZmaHVQeXZUT0tOai9LVlY1NnV2c3h2?=
 =?utf-8?B?TVlmOXVMTmd3UU5JRm5nMWM2cmd3cG9tWlZXV1ZZWkR6QVBzemp1YW9rWW05?=
 =?utf-8?B?TGR6cUk3b1VTN0tpRjFCWHVHcXJrYWlaZHE2Nkc4S1NQRUZueGlJeEo1djNk?=
 =?utf-8?B?VEQzRjZRVHl4dDFwanNPVjVrdHRiZkJnd2V0WHZkTHhGK3BoNzRkS2xacGNE?=
 =?utf-8?B?ajJZZFpjRzU1S0ZyWDlwZmViUjEvMmxna1NhWityMFd0bTZ3TW5PUTQ1YXZu?=
 =?utf-8?B?ejhwZG82SlRyZ0prNlYzRk9vdGVaRkVSK0ZzcHNwVkFzZWxLdituV2MyczEr?=
 =?utf-8?B?K0tXREsyWHZTV1padmI0UXlxY2lPMXpDZHVRR0RNVUlreis4OVFGYnIxSU5k?=
 =?utf-8?B?Y3hpb0dRKzNmQWlHd2VDNFVNWjdXTU9IbC9pUkIyY0l1ZFRVYU52aWFxL3JT?=
 =?utf-8?B?WHR3OGNPblhLbTNFQkxUVVJiWlpPZm1VU096ZUtUaTBtUTdVdXFxVUxlTFVX?=
 =?utf-8?Q?IvltiSe2fH9Yg3NtFN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4875be2-e5f2-4f39-7f17-08deb4d0ed90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:30:56.6401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XSd2htY8XnUh+MuWew5wC9Oaq1uDn+P5PqYTwFuTeMvFUxudz7yVNzBeTi9Jevo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
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

On 5/15/26 00:39, Maíra Canal wrote:
> +cc Christian's AMD e-mail
> 
> On 5/4/26 11:47, Maíra Canal wrote:
>> Hi Christian,
>>
>> When possible, could you take a look at this patch? If you are okay with
>> it, I can apply it to drm-misc-next.
> 
> Gentle ping.

Sorry for the delay, please always CC my AMD email address as well.

Regards,
Christian.

> 
> Best regards,
> - Maíra
> 
>>
>> Best regards,
>> - Maíra
>>
>> On 20/04/26 06:18, Philipp Stanner wrote:
>>> On Sun, 2026-04-19 at 10:48 -0300, Maíra Canal wrote:
>>>> The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
>>>> the legacy reason to pass an external lock as a need to prevent multiple
>>>> fences "from signaling out of order". However, this wording is a bit
>>>> misleading: a shared spinlock does not (and cannot) prevent the signaler
>>>> from signaling out of order. Signaling order is the driver's responsibility
>>>> regardless of whether the lock is shared or per-fence.
>>>>
>>>> What a shared lock actually provides is serialization of signaling and
>>>> observation across fences in a given context, so that observers never
>>>> see a later fence signaled while an earlier one is not.
>>>>
>>>> Reword both comments to describe this more accurately.
>>>>
>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>
>>> Reviewed-by: Philipp Stanner <phasta@kernel.org>
>>>
>>>>
>>>> ---
>>>>
>>>> v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4- mcanal@igalia.com/
>>>>
>>>> - Be more explicit about not allowing new users to use an external lock.
>>>> - De-duplicate the explanation in dma_fence_init64() by pointing to the
>>>>    dma_fence_init() documentation.
>>>> ---
>>>>   drivers/dma-buf/dma-fence.c | 13 +++++++------
>>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>>> index 1c1eaecaf1b0..63b349ba9a34 100644
>>>> --- a/drivers/dma-buf/dma-fence.c
>>>> +++ b/drivers/dma-buf/dma-fence.c
>>>> @@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>>    * context and seqno are used for easy comparison between fences, allowing
>>>>    * to check which fence is later by simply using dma_fence_later().
>>>>    *
>>>> - * It is strongly discouraged to provide an external lock because this couples
>>>> - * lock and fence life time. This is only allowed for legacy use cases when
>>>> - * multiple fences need to be prevented from signaling out of order.
>>>> + * External locks are a relic from legacy use cases that needed a shared lock
>>>> + * to serialize signaling and observation of fences within a context, so that
>>>> + * observers never see a later fence signaled while an earlier one isn't. New
>>>> + * users MUST NOT use external locks, as they force the issuer to outlive all
>>>> + * fences that reference the lock.
>>>>    */
>>>>   void
>>>>   dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>> @@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
>>>>    * Context and seqno are used for easy comparison between fences, allowing
>>>>    * to check which fence is later by simply using dma_fence_later().
>>>>    *
>>>> - * It is strongly discouraged to provide an external lock because this couples
>>>> - * lock and fence life time. This is only allowed for legacy use cases when
>>>> - * multiple fences need to be prevented from signaling out of order.
>>>> + * New users MUST NOT use external locks. Check the documentation in
>>>> + * dma_fence_init() to understand the motives behind the legacy use cases.
>>>>    */
>>>>   void
>>>>   dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>
>>
> 

