Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC0CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF4610E8A9;
	Mon, 18 May 2026 14:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aJz4zn1Q";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E6610E8A9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwNlmoXPt2vFimryUG+7TmHTmzhQdDa8X/DP2uzOYpmvdqPtACsWrtThhiEyguzmMvm2aAY3PV9xAQcsE9PFhxcKY3nnbGbj2kSri2UP2kC4S2r/2NEs6FWWPHF2tSzdqtVaFx1GRzuUmEZJwSm8afw1MGtL8DE3V9liraaLUjVG5Vpr3yWB34FwwJVdQRUhnGJmQtUQrVJT0BhqYpro6a4ER/LSuO/uyGxUeCvdyrELrJUG1yjzDgRgArjxE0pBSM3Prpwzrlk7G5K0t3Viil6YIaWCw92Kw4Ky+k9QvKyFa+iWcpZ8FeZYBrw25DP5oQms2Z6nFLRiHxeWEYScbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcrQrf0j+PK9HGGTwzVzGunN0PF4Zt8tx1xVIJAtzrU=;
 b=SEJWeczV8Ni6/uyR6C3+BjpFpuS9Sdwi9t3SCjLmF+3gXiXieA5sM8iz2afJnj2FcUQ0s5DhKyHZtfL0EQ7feB5cMyaLfyUuYeRhents/xDPBYxTbsb8k5QhBODegf9VFSThyoGx6g2rE/XCoXhGv7HFjz4MBwEVeOAxm5O//P/N2gF8km5pmoRzdafrvnI9+Ki+XuYgzNIiZ2jDjJd3Av/ND7LGNenHRBScjUMCZQh9z6OmJcE02xFRpisNba7zPXA9vmWx34LlFlyyOt2f03KI9RaGmWRGQpz+RJoJEtVcBFai77fBWmu+bVXdkjW3V17eaOeXV2mu9NU6qHJAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcrQrf0j+PK9HGGTwzVzGunN0PF4Zt8tx1xVIJAtzrU=;
 b=aJz4zn1QBu8g1KTHb5C9ryPejluqfZYp9qqpuIR2HMxvD9Z6v6SyJW7FmFrYC+p8+dt3pZtP5TbKc4D23x1FFPViHNAOtjznRpA6VYdl3W8nTHc9B1gvKC+N7Ch6KTs3gqHWLx6x7UQSfm646yoPd9WVQwKX5ds37/PFuBVV+j0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 14:44:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:44:06 +0000
Message-ID: <880a949b-2c9e-4b6a-bb2f-4dd90d5238f2@amd.com>
Date: Mon, 18 May 2026 16:44:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
To: phasta@kernel.org, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com
References: <20260419134943.54833-2-mcanal@igalia.com>
 <b202b9f4-9ef6-422a-be39-8050217590ad@amd.com>
 <64a784311f048a0fe4bbf8a89839522cd1e6144e.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <64a784311f048a0fe4bbf8a89839522cd1e6144e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: a06a19fe-904d-4329-ad15-08deb4ebe947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|4143699003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ouFhnSys2fsAeurWtQd1GQUGt0tKgbL2NqZuxoWmSjvsqYSHKShQoNXbyhKjw5VSAlsWhFATZi/iEpDcO1Y1QBk1mR5KqeodLsFm4iJ0P9GI0sQbKh0mr4m3FQnFNKnUYDWhfnl73KZykFff6UQh+2bVZtVRRLKQZxlcZfzBWU7IrHzlonKm+1RlPxR8hnM/hTxCZFJ0GQ/ctCh34ANPvmdTG50jiwuLaNEv/BprThRQuEVtN//ZUMTQeli/HbzqWdBEKCz09SPIhNSjz6JaL6Jc6dgGbMEVHi53ZgZqa0SRN1ies4GP2OIrADVLXn4ogNWy+TJ6MdXYyBsHAk5TdCKChU/9GVR7U3mamk/qsIG66sqsAx4XGww+0bl2Es6tg/t5Qg1viwlymkjccrI3PU2Z2WE3PLzrrxQgsjIShzsHJXIPb6P6D1VimHGM496SaKLSkPOd980qu/IOIVzAxyoCO8UmAfAeyx/eYbuNeFVyBPivrmdTxmOun/0d2VO0kx+JDmUB+16Ilx4Oo5MPQzMWQnL0Clh3c00CQ3ljVriH/zF2FQRMebMRwjqKpG/L4DaR749zz5f16wlO89rAL2J5uSIcGsF6K9MkgBURjpNEYrCthc5tzfZhdzNktfpbWg2vcFsTUYcfXbb64FpZbGzK9ktlbfbYhWCHhzO+UHAqwUtAuMd82wyi8ci/LiPquY3niaonTCkn6oKrTMMSlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(4143699003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWsyYkNEWFZqSDhiRVRSdzJtK01xTy9LVGQyMGpZWHJHVDVTbnZBNHVsaXJP?=
 =?utf-8?B?MFZKVmx2eEEzTFVOWkRlT2laUSs1L2FoNkJnU1VTamY4MkFsdGhGajQzNU9m?=
 =?utf-8?B?azRBb1Zvd3kyTHJGUjE5RUgvY2FPQStLeU42TmR1eVBnNzl6U2ZIZEJtY3Fn?=
 =?utf-8?B?M0NjVHhkZzcvaC9MbG5laW8xak5QZXhnUjR2U3BpekpQcHJPcU5xUEc5U2dK?=
 =?utf-8?B?VWtKNGNpTmptdUM5WXZMT0dVQ3hMeGtkU2wxV2NicmQxckZHSHRLaWxzWEE2?=
 =?utf-8?B?WHB1RXpjRHIxQllrTHpHWVNDMHpMTkVBb3RYTWxrR1I1UUdDZFUvYkhxZncv?=
 =?utf-8?B?eW1ldENzOTg2NzRielpWN2N2azFvbjdkc0xFeG9yVnN3MlgrQ1JoaDIzd2FE?=
 =?utf-8?B?M21GNmd3NS9WcllKUHM0VGFZRHFwdytvRTdiMzNUR21SM3dkYjdBam40V0t3?=
 =?utf-8?B?bmZUVjBnQ1IyamVKNDMzejZ6d0ZkSFlmVys4QmdsUFYvVEdpRXAwOHN4NXUr?=
 =?utf-8?B?ZVRhVXdFVkVZMWhQZzU1bFJGSHZmNVdNaUhFTXhjK2pHWUp0bGo1UDZHVXk3?=
 =?utf-8?B?MThtQVViTEd1OEMySjJzaE1aMjdjMFBpZnJFV0ZEZk1zRU9XaUR3WVlqbmJo?=
 =?utf-8?B?YTRvQmU1Q3VvWG85cjhGLzdLN1RjeGRZTEpPdHVEU2JCdWlKWlhzSzNRU0Fo?=
 =?utf-8?B?czFLWEp6L1Q4dnVUMmF0UXdhanhDK3prTnp0WnVvQmVmbDNpREQxNEZMZDNY?=
 =?utf-8?B?R0RHdXJ4a2pIbHQwZi94ZWFKcHBPbHZQY1g4ejdlVDYxaWovayswcHhuNXB4?=
 =?utf-8?B?QkN1WmY2MzFMTHFSQlRhSmxWdDA2bjhXZndFZjdnTlNBK1ZCeWpWT1ROUnQy?=
 =?utf-8?B?NTBpY0dDODlKOWd0dlQrUWk2YmZXMUxNMTN3OWsrMFhrTWVlYzJBQS9zaDNh?=
 =?utf-8?B?UUM1WUM4Z0tUWEtFeFU1TTZNUUZhTUJDdHpYN3FjR0lXRzY2YVVMYXh3bGoy?=
 =?utf-8?B?RTJ1dS9vejNRK05oRXV2enNseWhCeTIrbTBQTEZ5cWRjZmFSOEhCQ1FXdHJH?=
 =?utf-8?B?YmpsWGw3YUt4dy9HSlp5Vjk1VWVzbDBjSG5OWllUanIvMDNUZ3lOWStxVFdX?=
 =?utf-8?B?L1RpdVJCcnVoeU5GektobG1QRTRqeXpXNlY1ZFJvcWtXZS94UmNMUVVtVGth?=
 =?utf-8?B?UmljUDV2RUIrRGFLNys4ZitIVXJnOGg5TDJwUEI0ZnJSblovTEw1YkQ1YThr?=
 =?utf-8?B?eCs5SFNTdk5OL0tUSVVMalBaeUFSeGE4YThBNUczYWZ5MDZwM2hiS01VUGlu?=
 =?utf-8?B?QnRrc1ZmY0wyUWJJRXdkeEhXMytsVm9UVHZRYktzb3BqWDNHZkNUSzhLdjRU?=
 =?utf-8?B?TGxRNThyMnREK2xTQmpMYXM4elk5cjd1cHhpdVloYnBBK1FXSnhyUDhUdUFk?=
 =?utf-8?B?WmpjVDdlRDVTU2RnRHZKK2g4T1lyMldYZnJScTd0UGV3UzQzVExrU2dZWU5V?=
 =?utf-8?B?TnU0Q0xzN3VNai9iTmtBeU80czAvcWVkN3ZsbXppMEQ4aDBKckU4cTY3clpE?=
 =?utf-8?B?eXhtYys3MmIvZHlkNWgxcUREeG5hVE9PV1hXMElPbHh4dm5oUW5VaEtCQklv?=
 =?utf-8?B?TlRicjUrTThicFF2djRRRFNSelZlQlN6Zzd2YlcxWkVjZG5VTHNvUXc1YzR5?=
 =?utf-8?B?dzBnMEFVQkRBLzlJSDFoUXZsWHdiSm9JMUtRTGRtN292Y0RYcDlJcGJsNmlw?=
 =?utf-8?B?SXdDRlJ6ZU9yNFRiMlcva01LV2ZqYy9FQlkreFVRNW1XTE5WNXBxdTduRUZT?=
 =?utf-8?B?UVRScWJWM1k0dmlzcW04bXNra2lmbzY3eElVNE9MemNuNDZqak4xK1AvaWhI?=
 =?utf-8?B?MzBpQlAxZVR4enJ5b2lJeGNvbjQwOUMrQlREVGxLV1FQNU51SVlJYW9zRWRy?=
 =?utf-8?B?RjRaOXc2RGRqMlNVbTJHaVFxWnJjNEJZaTVlWmNSRmladUdjbm9pRzVyMzJp?=
 =?utf-8?B?ZW9QZGFiSVNNNGI5NWNaeE1BK3lMekpHNWZFRWlLNTZrYkF4c3VOa0hpZzZp?=
 =?utf-8?B?cjU5ZENhVlM4elRNYmVheGpkMVpoNHhjRGt6Z04vUERtaHJtLzdSQXR1bFAy?=
 =?utf-8?B?RTN1SGh3QmxUVVNpbDgzMmlyWmwva1E3ZERCMnBNbnk1VUdBTTNNSXloVUtP?=
 =?utf-8?B?SGZ5RUY1TWlhNVZzb0VURFg4Q3FXdEM1UmxuRlZKSjdEQTBOZDRPVFpsYXZq?=
 =?utf-8?B?R1RFSHBsVkNZNkJQVncwOFdjVWxhSFhDRzc3THd5Y2hVcTl0dlV6eXlkZGZv?=
 =?utf-8?Q?FplUaV/wGmEGTWQbQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06a19fe-904d-4329-ad15-08deb4ebe947
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:44:06.1079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4cPBF2rcaxcc77SbGilG3DuJJyBgcEOhjrviKlZhSKmzfLFjmDdgI+4vM2w8iS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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

On 5/18/26 15:00, Philipp Stanner wrote:
> On Mon, 2026-05-18 at 13:30 +0200, Christian König wrote:
>> On 4/19/26 15:48, Maíra Canal wrote:
>>> The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
>>> the legacy reason to pass an external lock as a need to prevent multiple
>>> fences "from signaling out of order". However, this wording is a bit
>>> misleading: a shared spinlock does not (and cannot) prevent the signaler
>>> from signaling out of order. Signaling order is the driver's responsibility
>>> regardless of whether the lock is shared or per-fence.
>>>
>>> What a shared lock actually provides is serialization of signaling and
>>> observation across fences in a given context, so that observers never
>>> see a later fence signaled while an earlier one is not.
>>>
>>> Reword both comments to describe this more accurately.
>>>
>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>
>>> ---
>>>
>>> v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mcanal@igalia.com/
>>>
>>> - Be more explicit about not allowing new users to use an external lock.
>>> - De-duplicate the explanation in dma_fence_init64() by pointing to the
>>>   dma_fence_init() documentation.
>>> ---
>>>  drivers/dma-buf/dma-fence.c | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>> index 1c1eaecaf1b0..63b349ba9a34 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>> @@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>   * context and seqno are used for easy comparison between fences, allowing
>>>   * to check which fence is later by simply using dma_fence_later().
>>>   *
>>> - * It is strongly discouraged to provide an external lock because this couples
>>> - * lock and fence life time. This is only allowed for legacy use cases when
>>> - * multiple fences need to be prevented from signaling out of order.
>>> + * External locks are a relic from legacy use cases that needed a shared lock
>>> + * to serialize signaling and observation of fences within a context, so that
>>> + * observers never see a later fence signaled while an earlier one isn't. New
>>> + * users MUST NOT use external locks, as they force the issuer to outlive all
>>> + * fences that reference the lock.
>>
>> No that's not correct. The use of the external lock was indeed to prevent signaling out of order.
>>
>> It is perfectly possible to observe the fence as signaled even without taking the lock because of the unlocked test_bit() operation we use, so the new wording is clearly misleading and not explaining properly what is going on here.
>>
> 
> I think the point Maíra / we tried to make with that statement is that
> an external lock is effectively useless for ensuring correct signaling
> order.

Well yeah it's just historically.

The point is *if* you use one lock for all your fences *and not* have an is_signaled callback then all fences signal in order.

It's just that as far as I know all drivers sooner or later implemented the is_signaled callback because of the performance benefits and so abandoned the signaling order approach.

So we could in theory fix all drivers to not use the external lock, but that's tons of extra work which nobody wants to do for a radeon, nouveau or QXL driver.

> Afair you agree with that in general.
> 
> Do you have a suggestion for a better formulation?

Yeah I really liked the "relic" and "MUST NOT" wording, that is pretty much exactly what we need here.

Maybe something like that here:

* External locks are a relic from legacy use cases that needed a shared lock
* to serialize signaling when no out of order signaling through the is_signaled
* callback was possible. We have long abandoned that concept, but the external
* lock is still around. New users MUST NOT use external locks, as they force the
* issuer to outlive all fences that reference the lock.

Regards,
Christian.

> 
> Regards
> P.
> 
>> Regards,
>> Christian.
>>
>>
>>>   */
>>>  void
>>>  dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>> @@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
>>>   * Context and seqno are used for easy comparison between fences, allowing
>>>   * to check which fence is later by simply using dma_fence_later().
>>>   *
>>> - * It is strongly discouraged to provide an external lock because this couples
>>> - * lock and fence life time. This is only allowed for legacy use cases when
>>> - * multiple fences need to be prevented from signaling out of order.
>>> + * New users MUST NOT use external locks. Check the documentation in
>>> + * dma_fence_init() to understand the motives behind the legacy use cases.
>>>   */
>>>  void
>>>  dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>
> 

