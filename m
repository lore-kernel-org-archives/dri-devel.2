Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3622FEDA09
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A82910E037;
	Wed, 18 Mar 2026 01:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bHM0h4yb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9E210E037;
 Wed, 18 Mar 2026 01:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYMZ//rmXV8k2i3y0OOW7r9xiWWR0SYopl1KNHiiK/u8JFtm92egkzJ3Urs6VOpeWfNACEqe8b5dKLJB3ejfGnctqr1eIGnQ1eIaZF/KxF/Pdw7tVNlIVMKr6hV5N3nN7MyZWcOYA+q9BvkjdNmXAZfOL4CIS95JABCU29c5gbAqWeOfm68k7On9iJCgmHzy9DPEYphWC3s2SjaM3IzcjN+Pim1ciiay1pwYytYijiwPtp6ntd9FMofsI/RrRo9KAecbMNjOGDYeHlfgmp9sY/LydtfguRyA/swfImU1xeaGMPXGu7euZKWe5txhk0rw6qDbVNQLfxjHIJ1ltXfixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyvYjv1U5rYbFnsLajRKTCiOLzdos+gF00al1J9QygA=;
 b=JgHnR5PoMSVmIpvF+5pb2q1dw7wSMN1nmF+IutrreGMilzG4Mo02adp7F/iJvcGwhWsqLsskcOX41iwlGjySgyg99nvaMV9ftcjXcb1v/07KeNvGKRGVNuggHNjr5DWAJXDY3aJ4Sj3ds1T6p9C1KK7wsWghMBoksQlTKlD3K2pVdJxYpSe20pk6zmJ/tGyIG0ZZElXmXVRE6VXmCHDgllye9lJNSsFYlZjeqbSo9viklUwojnbgniTuwwPp+idjb4n3mT7hURAgKIBIo4nylIBV+B1m/i2ZSzwKmEgxHejvBsb1pEJBViqtMtfeOlF0JZ6Z44WrcbIumz+VVa9WlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyvYjv1U5rYbFnsLajRKTCiOLzdos+gF00al1J9QygA=;
 b=bHM0h4ybDxCEI1gvGC529ol/SzHLXweO7AGoywrV8TvDuomxH/yE/cbUJYgXgPY1zWpGMmIJBDxeKOy2o3StvVHXVpaa9QHi5rZegbxAOPLu48KdxD3hzye5Lzr0fe47mGlzPHLsdvxJqi5AWc0078Fp03orr2tYQDa/a5c3prZkpclGdiKFNU72Dw86QgfyFS3/afjC89ME9AduGCOPnJZ5poI9aUUVyeoeyzPDbhNg5Y+vg6JF9si56jQUHWWuODN2w35tpr9Y6meoA/bAd3hAzCfvTrUpOpuVCqkVkRzDcHuutl+zKWyn6CeCMTbJNZThYksnzB7u2ZypCbKLHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:52:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 01:52:44 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 10:52:40 +0900
Message-Id: <DH5J6LALR3LC.2PW5BLFABR0A@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>
Subject: Re: [PATCH 6/9] gpu: nova-core: generalize `flush_into_kvec` to
 `flush_into_vec`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-6-86648e4869f9@nvidia.com>
 <093ca23e-7081-42db-a202-0a42c51741a3@kernel.org>
 <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
 <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
 <DH47AVPEKN06.3BERUSJIB4M1R@kernel.org>
 <DH4OM17DJ47V.3NJG7G02O7P1L@nvidia.com>
 <DH4ZZD12V0R6.2G7IIL87QTK0S@kernel.org>
 <DH53MXEAVB0Q.2SXHCQTW8WG2Y@nvidia.com>
 <DH54AITP8HBY.PPSYM4FA2DZI@kernel.org>
In-Reply-To: <DH54AITP8HBY.PPSYM4FA2DZI@kernel.org>
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e80bb5-e304-45ab-161e-08de84910bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FcB7Rh2OYekQ7n2mkAfZGEPXBTmntxybSiqLEFLA2WZmbllBYJ/i5bJH6IfQjz2FwwJXWUWJ4R/GBxR3g0zmG/J4wpIsSzjkgQ8o8mbzdMJUogMzZcQnu05Ci5SCviLn6tePZgQnPYQIWf9xMiXjGtOSUhz0BTxMQzhrsTjTa3FtB5LwPvLJh+7g3lxTVkhlAgrj28qXAK6P/XztHVZPo8lPsBSOsNqjWuAkPpquR3RxveBzqQd+mYJKj8uTXy4vF+JFc1ZDlhQIUtl7XlBGQOW9IxTkveCqzh621xveSy6euv0jqyTMJhHfwOAm+/yXk8sIgEiwjuoc/gyk8b5yu4JD/ZOKJuoOq5jNihkK2a7DAX8XoP4GLNZ57lBY2/Io/VZ3wGMDw3l+q5Li9JlH8kBf/fGgx3DGhEUpeUSdwDQJLE1GXgxth0CEGErhkVDqAiOOPgHFy30bOdpbDb9oJ+J49o6naaJOFskkTG6R+PrCbjb7qOqFoxBqQAPYkId2KAQu1Ly+cbqhD2cFEhqMr2JcYomzydol4JJ1RPf3QJ+F5BaymSAWctF+C7ymU4id8Tny4eF1EOloWxg2HBPRcylJyxvvXn7zB66n6quHrqcwfqYbD+epbWxVo4uenbqrxbUX5QtnMJbIeo/VNrfR+p0gYT8pD/QenUNiwmML1mt4exayz6IQ3OhZUv0wbEijf6OGN0w4/bbx8lmMs4f064zUnikp8pcQ4ma1c2DRMLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JoK3B4WFRHRDkxYXFjanhYd2VsdXJZVlkzSUNmdThZNFh5dThRRzdxU1dV?=
 =?utf-8?B?ZkRBeSs5VlBkVWtvekhINmpHU0tWV09XNjB6Q3lFc2N2aEFCU0JKRUdPbk1J?=
 =?utf-8?B?RkhZUkU5a3JtbWxsL3hmYVVJaVF2Rm5KOFZ5WGp6eUJ5UXZRSitmNHlHd1J2?=
 =?utf-8?B?YldJSStUNk5RK0tYbHhESHpzTVlPbkxWSU9WdnR0U2lGYmVncVErTzRoR2Fq?=
 =?utf-8?B?NE9aZ2FQcmc3b0t0UE1uNlNEOU0rQnRoNitnZjU2UjR2YWVzeng1aEpKdStQ?=
 =?utf-8?B?MGlwVThjVVlNenFZQlVEMzNHK3kvaGRZL3E0bGVlRUdXWDV2U1VMM05FYzVG?=
 =?utf-8?B?dXBELytlbmVwL0V2cmxwU2VwSVlUdUJ1RDZnMFZKeHZkQzRGNlE3a1ZOelZL?=
 =?utf-8?B?QjNxQWtKeW9JMHBzMXRKQkVZcjJZOWNkMkx0Y0FlaDc2cEF2S3FNWDFmWkV4?=
 =?utf-8?B?ZnhxVFpMb3MyNndXZERhYU5zS2JseS9vQzkvNVlBNGZuMThOb3Z0U0xzRmti?=
 =?utf-8?B?ZExTUGpHQ0h4c1NTbzhEdTg0MkREb0tCU0ZONHV5enVwMGNKUjZSSHRBSWpx?=
 =?utf-8?B?UlEySms1cmZLOHNBNEhZTVN6cmpMNUF4SFNZNU1BMWpGbW5tcDBrNy9tT2Q3?=
 =?utf-8?B?R05yenkxK3FJSndraXo3TzQ4RVhjaHFsTWlkOE5XczFSS1NyeUp6cVFnaGhF?=
 =?utf-8?B?NTRHNk5kZ0VXNE1FejBFdmtqVi9JNlIzMzBZTmxLV0hxQUVLdmpWUDhCSjRR?=
 =?utf-8?B?NldRTHFBa0hZN3NBOGJMTXRTYzJEZXZMcW8zOE16YStMMU9IUFB0Z1k3ekdH?=
 =?utf-8?B?cFZnMldmbStpd1RBVWU4bXhIOWhyKzQvSkhEYzRDWXBHSE1JSlJ6V29PcnVS?=
 =?utf-8?B?K2dMSnNyZVBXdFJ4RGxZcVVNUFhDcDBKM3pLWUlnZWpDekh1RDVSbE1RWDhm?=
 =?utf-8?B?QTR1Sk1LSGYzZWZrVTBORDlLTDRuZXJpQkN5QW1zQm5uR1ZNb0hMQmlpdmtR?=
 =?utf-8?B?eXFJOEVKY3AxdG9kSnhVQlFQSHJYNHUzTmw5bFFOQnlVazhQeGpUMWJZcFNQ?=
 =?utf-8?B?dXlSa0JZU3VyZnQrQWoyenByL2ZGZ3UvNTBpckJPZDFWOC8yWERNQnRoQjdB?=
 =?utf-8?B?N29panpCU2hBOERYM1RLZ2UrRUJyR1BOdjhBQm1IclBpcUw5R0grMDFoaFBz?=
 =?utf-8?B?ZnRKSE15a1dTNVZQYWpuSXduTncyc0UvL0k0b1lmN3lZV0d4c0JXWk5ETmpW?=
 =?utf-8?B?b1hrdXFXb3RBeVVxYkJhbEZPbk9PUXhjd3RBR0dkYS9HMWZFYkZEa1hwTTN4?=
 =?utf-8?B?aEN1eUU0REwxcWc1ZzRwWjlNdm16cmp4RjE5MFk3RXhvYWhmaDluVlBIYmtY?=
 =?utf-8?B?WVlCOTV1Qjl2RVJJNXdGdStlUnNncVVqMkcrSWxZYVJBTzE3dWhpR0Q2OWdK?=
 =?utf-8?B?bXlndys0b2Z3NURQdGs5Vko3OVZtdFFMRDFORlFzVTJyaXZVcXBQSTcwbUgy?=
 =?utf-8?B?d29aM3BTY3Zva1Y0aTRYSTlTcldybnVOTUt3SlZFUUxmTjNQcVF1S1l3ZWFP?=
 =?utf-8?B?UGhuOXRibnlGZy9OV09GK3NMOEdpcHNOZUN3RVYxY0RMK3FTUUtlWjdJM2da?=
 =?utf-8?B?QkZYaXJybEM3aGljTDd4MXJNeGxXTDJ6M1Y3L3ZYR1VCNElxa2pOWEwyb1RO?=
 =?utf-8?B?RURHaklWRnhLVnJWZFEzSDdjdkpIME9tOWhHN3JlcUpEU213dk9OQTNZT1VW?=
 =?utf-8?B?bVpHTDg4K1R2Y1pBbmt5UW9yTWU5RnpOemxTZVJOMU5XKzcxcElrSGJLM2lJ?=
 =?utf-8?B?Um9URklsZkNuc0xQS3JNSU80a2UzQ1dFMEpGbHJMUXVSQXZMTmxBWHBuUTFJ?=
 =?utf-8?B?aGxZc3hpc1l5aVZkQUFZRU1rcHJUcDE2TGFoakVBUjlBVDk2VlNOQVdzVmlv?=
 =?utf-8?B?MTJLZXBmeEhXOGcwZndQQkQzb2s1cjNFUGx3REY3SlBybDMrS3dZL0cwNmtw?=
 =?utf-8?B?czJid1Z5N3hrRXNhS2Q5bzJheldxTUVGc0V2YmFGaTVmakpFbjVoREt1eGFD?=
 =?utf-8?B?UWFhVFQ1ZGpUZmNoTnI3aFlyd2hUVjF2Z3Nka0VwVHZCRjFDTWQxUzVyUVdI?=
 =?utf-8?B?OUp1cTAvUjR4cXUzZENuUHhpcmllV1QwUU1YdUNTYmU5YzF4dnBGdVZ6N0N1?=
 =?utf-8?B?RzNJMlJVcFh6bVI2VHVPeFlXaWpLWFJJVUR1NjRSNU5RU1M1S3czQ3BMTDI4?=
 =?utf-8?B?MjlQOXZ0ZFF0dkUyV3JuRkpXeEZGV3JHVEhLVlpNYTNqUFY2VXlHTGNkZ3Qy?=
 =?utf-8?B?SGhmcGZvOCszMVlLcE1rWW52eDMzQVJnZ3lxc29hekhaamNSSEdHTWlXY0lt?=
 =?utf-8?Q?+jaq5FOdTx093UHEr3HUq7br5g5F4OBaSHYlCsGD8H0fN?=
X-MS-Exchange-AntiSpam-MessageData-1: pPQcr7yaiTSnLw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e80bb5-e304-45ab-161e-08de84910bef
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:52:44.2197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5X/EHMvYIbvkq7H/zqYFWYIFImHvwpRzCgZX4jciKNWDA+ZcjGmyIo/Emihtu+D7r8aukddcBzwyo/79TxzYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
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

On Tue Mar 17, 2026 at 11:12 PM JST, Danilo Krummrich wrote:
> On Tue Mar 17, 2026 at 2:41 PM CET, Alexandre Courbot wrote:
>> On Tue Mar 17, 2026 at 7:49 PM JST, Danilo Krummrich wrote:
>>> On Tue Mar 17, 2026 at 2:55 AM CET, Alexandre Courbot wrote:
>>>> We shouldn't be doing that - I think we are limited by the current
>>>> CoherentAllocation API though. But IIUC this is something that I/O
>>>> projections will allow us to handle properly?
>>>
>>> Why do we need projections to avoid UB here? driver_read_area() already=
 even
>>> peeks into the firmware abstraction layer, which is where MsgqData tech=
nically
>>> belongs into (despite being trivial).
>>>
>>> 	let gsp_mem =3D &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
>>> 	let data =3D &gsp_mem.gspq.msgq.data;
>>>
>>> Why do we need I/O projections to do raw pointer arithmetic where creat=
ing a
>>> reference is UB?
>>>
>>> (Eventually, we want to use IoView of course, as this is a textbook exa=
mple of
>>> what I proposed IoSlice for.)
>>
>> Limiting the amount of `unsafe`s, but I guess we can live with that as
>> this is going to be short-term anyway.
>
> Of course it is going to be better with IoSlice, but limiting the number =
of
> unsafe calls regardless is a bit pointless if the "safe" ones can cause
> undefined behavior. :)

No arguing. :)

>
>>> Another option in the meantime would be / have been to use dma_read!() =
and
>>> extract (copy) the data right away in driver_read_area(), which I'd pro=
bably
>>> prefer over raw pointer arithmetic.
>>
>> I'd personally like to keep the current "no-copy" approach as it
>> implements the right reference discipline (i.e. you need a mutable
>> reference to update the read pointer, which cannot be done if the buffer
>> is read by the driver) and moving to copy semantics would open a window
>> of opportunity to mess with that balance further (on top of requiring
>> bigger code changes that will be temporary).
>
> I don't even know if we want them to be temporary, i.e. we can copy right=
 away
> and IoSlice would still be an improvement in order to make the copy in th=
e first
> place.
>
> Also, you say "no-copy", but that's not true, we do copy eventually. In f=
act,
> the whole point of this patch is to copy this buffer into a KVVec.
>
> So, why not copy it right away with dma_read!() (later replaced with an I=
oSlice
> copy) and then process it further?

So as you said we are already making one copy: `receive_msg` for
instance does not return any reference to the command buffer, but an
object created from the slices returned by `driver_read_area`. What you
are suggesting would introduce another copy in the command queue
internals, for no tangible benefit as it would not allow us to
advance the read pointer sooner anyway.

Because even if we did that extra copy using `dma_read`, we would still
need to make sure the read pointer doesn't move as we are doing it, lest
we return corrupted messages - so the situation would be more or less
the same, and the `&mut self` required to advance the read pointer would
still be needed to shield us from doing it inadvertently.

In addition, we need space to hold that additional copy. It doesn't have
a fixed size, and can cover several memory pages. Does that mean we
would need to allocate a KVec or KVVec for every message received, and
drop it even before `receive_msg` returns?

The additional code to do that allocation would likely be larger than
the fix I proposed below, and we know it is very temporary and will be
replaced by mostly safe code soon. I would understand the trade-off of
an extra copy if this resulted in simpler code, but I don't think that
would be the case here.

>
> I am also very sceptical of the "holding on to the reference prevents the=
 read
> pointer update" argument. Once we have a copy, there is no need not to up=
date
> the read pointer anymore in the first place, no?

Correct, and that's exactly what `receive_msg` does - as soon as it has
created the object to return from the slices, it advances the read
pointer. So the read pointer is already updated when `receive_msg`
returns, and that "holding on to the reference" thing is purely for
internal safety.

Introducing another copy won't allow us to update it sooner - copying
the bytes into a KVec is not faster than processing the slices' data
into the final returned value. Actually it may even be slower if that
involves a dynamic allocation.

