Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E9CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D9810E67C;
	Mon, 22 Jun 2026 12:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UgsCmNIg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FEE10E67C;
 Mon, 22 Jun 2026 12:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn38ywUSgsaReQfZhh4MMj0yNwxcK7PHjWr1TIBn6CHHmTW8w+yUIdqDjt0OguHJzwJTeDLC/U74XkC1T9g9L8SgmmCmHPWxM+RlD7sRtHgaRYJxI3EV0+oh3oUw5IrHrrBI5dFbB5X0dvKg1zu8O+Fv8Sx7le4U2CZYVpelIEJwjr4azYUddkFmGYTBS2CZH+ChnZx14Q+n5UCaynaa51hxruOV8cJkNuaXaiext/FiAtEt9H64XZ1PS9Ba2UozyAyWovqqsffxj+dc45DdfV8JEwqcBmmWwTOdQGcQcTSqic7XPWrq1jspS+M8YYPjmFVclQtZ9zg7m4U0eXWqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s63alkL3b/Z0n0Qjv8Jzo64hFJBkTGqSfZo2gtFCsw=;
 b=k+6PeaTN2PJHctyEYZCZTy9c6xlI10pbtGIFM+yrJksIcjTMKgYhvTchnybZLHnObJqnBjECcOtA7IRv5bG0Kz54VaJs5VD7YYtilqeZgSBVns+ntGHQCy/75FhyRms1cGpHp2mlolj0kR0+AA/zcXYRvqRXp16NsU9RS5c6MsvaJMkOTGCgtyDO627fZ4Ns2OHDrB868bl5RJNhut6biSHGvxM1IfcNPQbRq86ETS0ehXk/4Wvm0cns+HAiiWJhpp4pSD8sswV0ZiQR4hBcH2AD1udCKopsDvfm77f2PBzyTIR6GalqitaveusHCaBYcIbaIvgQo8qtep705dMbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s63alkL3b/Z0n0Qjv8Jzo64hFJBkTGqSfZo2gtFCsw=;
 b=UgsCmNIg99RzcXvlQCCNUGL2fAugbuI+soy89oWzDsPPMRqQsWI+CSGuSPRErU0L0XZ7IfoO2VGLoTKoeyMvdWcBoYEfrubxPkmdgXlrjkMjWAY05jiUKU2SN773tQMUSxEdDAdKuYwFwPKEBKGo1hAyiEVBcUE8nAgUjMpmUI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 22 Jun
 2026 12:17:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 12:17:35 +0000
Message-ID: <cf9f4a62-ed02-46d6-9560-481ceda2d1a3@amd.com>
Date: Mon, 22 Jun 2026 14:17:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
To: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
 <DJEU27KUZRNN.3R1F8AL6UL30S@kernel.org>
 <d3e27b911dd1c0261c2c4d7d65d12d6c1aef58ff.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d3e27b911dd1c0261c2c4d7d65d12d6c1aef58ff.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0259.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5495bcfe-2e99-4d0d-9bcd-08ded0583df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|23010399003|366016|376014|18002099003|11063799006|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: I+sGt8pwDmdvWA8xwd0CP6K1/wBhfCcO9KO4oE74laK/qoQV/f25euNpATpsrM2HEDkgm3c2qktml8JDoYMnTN/KpT/6lNGaUIPNyq2raGGt+ySH+uCZM8NasI5uda9wzdJBaRo6ef+8x86k8t/cAPKmwoRnp0d7RazyXwwsa6O1nSOu1hBf7qLLPoVtBG5ZKHLc2IdXWBTsEoLi0GbQONGkRiEWUNxoD0dfEOIAkvIXVWsR2ua4UMv9ee7csDhq2xTW3Yc7J3eVBUbYFP9tzq7tqO9r+uyK1Vh2WbNDKHsos2d8B2gO9j9L3Qz0L/BBZLRuYHIjhaDRaaAbfOQtsi/yOBJlMLQpoHP7SzwAwg8ek1EjfEe1wJc5XI0YsO69NWwQRmi+YjAK+qvBuLOyDAPFRHkpNvRlNLvq2Cz3PI83/3i7Xr8q/LvgQ96UglYaZSi5L2pJ8vN3/CdVyLSMAFRlFanPtum3IMHqTZ3CY3BoDA263OPp0EpNy4gGDNd2ez3aIkRrsaLGgrg+WmvQ1SzidB6FOQ9HIxCYunoJs/FpPYVAnkErXylkzv63A2TXyz9FPbrZKzzompcOeQOSKVPDuFB1z8fBwAFy41QhlGT0sZokHLs7FsMrq5KvqUS3z6mMxV2aG9exvtBpP6TIbeM/F7wDRDYgv2VisWlCTzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(18002099003)(11063799006)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slo4S0M4cDd2bXZsVXplWG1Xc045QVQ1WHJCUTFWS21CRnVpUFRmSVFIZWlz?=
 =?utf-8?B?RUdwMlVRWjZKMUxSRVhVVmlSZjkySEJIUzhYUExZdGtHa0lkUnh6WmRZQk1y?=
 =?utf-8?B?WVFsVytFRUVwU1JEWFJXQ2tYZmpCMzBwWERsVDRXYkd2VWVjWEdkVUJaNm9Z?=
 =?utf-8?B?ZjlBZWxBRXRjdys2cFAxTEN3MUd0cUNONWNwTkF2THRKa25jaDltMHJ2Nk00?=
 =?utf-8?B?V0ExZkROQko0OW00RXFsUk9OMGljczhSeGdYZ2djWEtYWWxUZGtWS29BbzF0?=
 =?utf-8?B?aHRVVzd4ejV0cWtiQVYxUWhOSitjMW1zWEFEeVVsenBYSERJeHRYL3NYYW9x?=
 =?utf-8?B?ak9neWw4cWZNcXBJTlZvMkNMUm5hdThESGEwUDhxT0VRRmIyOU5pU2dTeVUw?=
 =?utf-8?B?NkRFM3gzY0s1VTVkakxoeEhGM3l0aEd2UGxtYlZOeURsajZwTmk2SVlwL3E0?=
 =?utf-8?B?U3MrV05RMUV6ZHRwd3VFL3ZYbllRUW5HSnJRUFVUczhmdWZnbVJqUllMSnZj?=
 =?utf-8?B?Z1lhZUx4YkYxSTlKN3RiaXRLSkVxZ1lvb1owK0x1REs2elRONW56dkNIUzcv?=
 =?utf-8?B?SnpCRURVR0dpcTd1Z0lhL3R0L2NPV1EvaXQzOXNHYlZDbm9FbEpDcVBUZnlM?=
 =?utf-8?B?TWRWZDg1eVFTdGQ5eWNCY1pGZy9DV2dLaWQ4WXRXa1NieWduU1FCNml5cGx5?=
 =?utf-8?B?TUxjNTFFT2F3bFZQc2J4OUw3eDdVVVdoUkt5RE52SUE5dXZ2dW9nVVdrb0gz?=
 =?utf-8?B?YmIxUWE1Y2xsNkp3UG56cUNKMWJLbmZwZzdhRnBIL3JOSEdIWHUrV3RxMFpx?=
 =?utf-8?B?dzIzM2dlaWtsdlJsNVJxRlNmNDJxKzRuZ0V6dzd0UDd0czE1aUp5NEoxak9U?=
 =?utf-8?B?NlRrYjBsT2tQYzJPbHlkVksxbDVoL2ZhLzgwYi9jVWV0TjhXbm5Bd2EzMlN4?=
 =?utf-8?B?dFFqYVJFS000L3ZBZWkxNEF1UWNnYnVOc21mcW45b2xmN0IrQk1PdTVhUk12?=
 =?utf-8?B?MlNsU1dvM0xvSHRDdUVJUkIyU245NDF5c2QvOElvSFg1ZmpJamtYNSs3Ylph?=
 =?utf-8?B?aGF1WThOWWJrMDl5WGpZdGo0cjlMYWJQV3JJQjEyQTllQjlyRHgwVzJhcjBp?=
 =?utf-8?B?elJEK3Nsdm8zcWxCRWdhMjRjVVR5dDluWk8wSVVOMG5OeTgyT0c0Z3RHUlk2?=
 =?utf-8?B?TTdiNFFWQUpvZ0p6alpWb0hUK3RhZXk3Zk5mWUt6MWFmbzFVSURSTEpRemU0?=
 =?utf-8?B?QzFVKyswejZibVpZVXFlT3g3dDRZOHg4bjh1V0pMRHFVazEwRy9tUHZ3SnRm?=
 =?utf-8?B?STUzZWUvU1pPYjRPQ2ZaOWV0aGdxb3hlN1A1VUl5MHdxYlI3L1BSeDAzcjBX?=
 =?utf-8?B?L0lvMWtTZDM3VFRMN2EyNEJoUGlkNVJubnYva1RXZUpKRlc2L2Vra2ZwZVlU?=
 =?utf-8?B?bXBXRnByWVBGRXNWb2grcVF3TEF5OGc5MUJsbVN2SXVIWXdzZklsR1dYWEpC?=
 =?utf-8?B?VFFud0hyUVduelhkUE1OMklDT2hHZjZBUDJaOUNYZXFWN3AwL3Q2UkowSXor?=
 =?utf-8?B?OEo0OGRLWTJ3dUVKS2JmYTNUQjFFbnJlWFpTbWNVUDR0dFZmeXBldWVYU2s5?=
 =?utf-8?B?ZWduYmNCTGpybU1naDI2TExxNEQxakg1L0xNKzl1eTk2b0pGcXNDUHJYdXZQ?=
 =?utf-8?B?SGZUL3VzbGxDdEpjendPZHpyL1I3ZmFnRHZtc1FTOHNsUGFUQ0xTTi90WDRV?=
 =?utf-8?B?NmdnUVBIVUs1cWlZdGdKNTBFRkZiUnhndkNkWW9KVU1kUnRvNEJFWlZxdlZZ?=
 =?utf-8?B?RDlpUHFWQUtCaWtEWDRreEF1ZURSbzltWkRkQkFSRVJVb01yUHFsbktCajQ4?=
 =?utf-8?B?bTcyNmptMnh1NzJ3d1JJdWpvdGtvUW1Jd3plbVNPZzdzYnlzdDlxQ2QxV3Zu?=
 =?utf-8?B?cm52MG02U1gyN0NLU3dXZkhHaU02UUdza0EwbTMzZmFWSnc0VnNhbzFybjRH?=
 =?utf-8?B?U1VVR1NVNU05V2J2UVdEdjNHOWRyL1lRSjRDSGVSNXpJWWNsYzhPbEovRDRz?=
 =?utf-8?B?K3AzUThXYVJUdElJVStzRW5KVkJoU3JOL0gzOHB4Q2J1bElYVjVGeGRPQXN1?=
 =?utf-8?B?UnFFdWZGVzhLMWtUUXAvT0RzZklBSld1VTNuSkhvZHdlRXROZnkzSEZxN2g4?=
 =?utf-8?B?c3liUU5WNkdYQ0piN2ZtTTR3QmJmOHZLMHNvaVQ1SE5pVUxvbGdJRFdGK1dO?=
 =?utf-8?B?TndFeU8wZDRlMWFwU29GekZWSDFueGVMcWNpVEwzZDc2MnJ3aGdOaE52Y0dr?=
 =?utf-8?Q?lYD+Mx7iX5E79h2Up3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5495bcfe-2e99-4d0d-9bcd-08ded0583df5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:17:35.1109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUZD1O+eIJNZldOmmH8GprHVqzkCU30szYC1kJ/VWbbCnwdiAdTHPV6N26+LFatC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

On 6/22/26 10:57, Philipp Stanner wrote:
> On Sun, 2026-06-21 at 17:30 +0200, Danilo Krummrich wrote:
>> (Cc: Alice, Boris, Christian, Dave, Gary)
>>
>> On Mon Jun 15, 2026 at 11:26 AM CEST, Tvrtko Ursulin wrote:
>>> @@ -176,9 +160,25 @@ nouveau_cli_work(struct work_struct *w)
>>>  	struct nouveau_cli_work *work, *wtmp;
>>>  	mutex_lock(&cli->lock);
>>>  	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
>>> -		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
>>> +		struct dma_fence *fence = work->fence;
>>> +
>>> +		if (!fence || dma_fence_is_signaled(fence)) {
>>> +			if (fence) {
> 
> btw I don't think that these two lines read more beautifully than the
> removed nouveau_cli_work_ready().
> 
>>> +				unsigned long flags;
>>> +
>>> +				/*
>>> +				 * Because fence can still be in the process of
>>> +				 * processing the callback list, and the
>>> +				 * callback references the work we are about to
>>> +				 * free, we need to sync with the callback
>>> +				 * processing before freeing the work.
>>> +				 */
>>> +				dma_fence_lock_irqsave(fence, flags);
>>> +				dma_fence_unlock_irqrestore(fence, flags);
>>
>> This does not ensure that there are no more dma_fence_ops callbacks into the
>> driver. For instance, a concurrent dma_fence_is_signaled() might read the
>> signaled flag as false before we do this lock dance and then still enter
>> ops->signaled().
> 
> The issue Dave addressed was a UAF within Nouveau itself, where the
> driver put() its own fence while its own callbacks were still
> executing.

Yeah that's exactly the reason why I have been rejecting the idea that drivers install callbacks on their own fences.

Maybe an idea how to generally tackle this for all drivers: Never let the dma-fence framework call dma_fence_signal(), that should only the driver do by itself.

This way we don't run into the issue in the first place that the driver needs to install some callbacks *and* the driver also knows when the installed callbacks are finished because that is when dma_fence_signal() returns.

Does that sound valid to you guys? If yes I will be sending out patches to do this.

Regards,
Christian.


> 
> Tvrtko's patch does not address the RCU issues you mention, nor does it
> address any other fence related issue except for adding the comment
> that should have been added back then with the fix in
> nouveau_cli_work_ready().
> 
> It's literally the same. Take the lock manually to work around the fact
> that the bit is protected inconsistently, setting is locked, reading
> just randomly races around.
> 
>>
>> Luckily, for this specific code here in nouveau it should be enough to ensure
>> that all dma_fence_cb callbacks are finished, which this hack does achieve.
>>
>> The reason I call it hack is that it fundamentally relies on dma_fence
>> implementation details and not a specified API contract.
>>
>> The closest thing to an API contract for this is the RCU protection that was
>> recently added. So, the proper approach would be to run this work with
>> queue_rcu_work() and then call flush_rcu_work().
>>
>> In this context it is worth noting that in this case it is even more
>> complicated. Since the work struct is shared per CLI the single RCU barrier in
>> flush_rcu_work() is not enough, i.e. there is no per fence callback grace period
>> guarantee.
>>
>> To me this still seems to be a bit of a footgun (although we could probably
>> improve the nouveau code to make it a bit simpler).
>>
>> That said, the patch does make things a bit clearer, so I picked it up --
>> thanks!
> 
> I disagree that this is an improvement and am unhappy with you merging
> it. It merely moves Dave's fix from one place to another and causes
> unnecessary churn in the git log.
> 
> Adding the comment into Dave's fix until someone can address the
> (literally) fundemantal problem in dma_fence would have been my
> preferred approach.
> 
> 
> P.

