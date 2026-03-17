Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02605FB5EA5
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D9D10E207;
	Tue, 17 Mar 2026 01:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dFAv5pFQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E1010E207;
 Tue, 17 Mar 2026 01:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imAt5k0QEYK1PJrt+ihR2Nr0L3kcj2cRyvmlT4Q0GFSjtGrs/Q6JDFudJ0Y0f1CaaX3B0X8B5doY6Ab0noOzCKB72lmqrLp0DGfmpz2+ZUBuSJEr1m0pHWbkMo/kXU2FYmxLvsRNu6MTq/VAiMwbdD4Q3Vx17T1QuTLMyZ7S09jr45IlnzIfCAA0oZvT3sUBhJVUL8iMb5w2aXTDW5KDItguDARgmvodTL1aL9PB6SzWzwmHAOUG4pHPrcFUem4PR09f9gZBcnIG3GsckQlbPy9cVve4yzR8R1DelPknWo0p83JspSKWGIGPGNDYWCsOi4uFINGRg1bwYzy9i3LeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFPPgihVuLl+GK5j4Uo7cjG9EwX7oRttxbgsHPDIEi0=;
 b=aEGBKmoxzQvqpMwyrPtvLIEaU2tLKbiYqQWw0OidBz3dPuXBnmHP7yx/T+93AgnmvreHl7DbMX+ZYGI53/Zr7hZh9I9ZlJa12hiBLhekOTjgZWUoM7yIho5j2N0u4ruSK57ZPcB/dYd5PXyvOzDNbFuGKXzPgi9F48bzJiw+6vUOQ8DaTVAvQp3CxDwR1TC7beO2KnW84W/g3C7xKAhVn9r5WoDzpVMcGyUmGzEeoLntPRTKP7a2/JvOP1rKi1p0azONQhY+D/7JDg4zyvGghzyXN6l1uvwK8L/GQ+XkywhEaVyFvZFr4UFAiJ4epixynHazl61nmgp5MOSyCJkMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFPPgihVuLl+GK5j4Uo7cjG9EwX7oRttxbgsHPDIEi0=;
 b=dFAv5pFQdBjz0FuT94TgaF8Fneja5X1nu/VaGJbhuazAUz0NzREefGGhh/1YSX9XiAc3+aBJM3tHCl8rsGoi8D8EfYg+SOuwT7acYQYG/GHyCZoFhHpEJ1YR7r2W6ES7xoG/BIsmelGyn6n90+xkn4CiUGdJqzJJh/UQkcD9azBwNVqyxdru9YLlb6F0yita9y1Y1Mr5j5EvL2xYt7Jito+pT6oxHkpXhH8cClO2CEQOx1RyQprMSLXqmektC5/j0Oglu6YtwJQBPFE4VBQaRNOud/ta5Qg5USfU2ASyFDiwszn+ytaCFy53dXBCXquWe8aJJGPTiL9iNo1ZtwVuFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 01:55:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 01:55:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 10:55:16 +0900
Message-Id: <DH4OM17DJ47V.3NJG7G02O7P1L@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>
Subject: Re: [PATCH 6/9] gpu: nova-core: generalize `flush_into_kvec` to
 `flush_into_vec`
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-6-86648e4869f9@nvidia.com>
 <093ca23e-7081-42db-a202-0a42c51741a3@kernel.org>
 <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
 <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
 <DH47AVPEKN06.3BERUSJIB4M1R@kernel.org>
In-Reply-To: <DH47AVPEKN06.3BERUSJIB4M1R@kernel.org>
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a25909-6edb-42c4-52e0-08de83c83e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TmcHBU417yQUKbUNn2qTw19yhR57jcJBkyhz4r6YYkGlvn7Mey7FC1owQOg/H44qteucDaCgR3JO+F9R0TCxAbnDtDW1/YMounAKyIt0+0/9xNvTDFiADhuTheYP+4T1Eru6A74JjS9qt3vp9Sf72f2YeQ9ymH3FOHQ73NbK1t4Yy5op85pUyMwDShbLHxr41OP5cir91yQ47YTfhzRGQ01h7Ltg+rMRC2h5AgVj1Tloq1sRL9PXALz6cfcvDwQoqWAXUOXkCyHUusxT1S/02tTEa/OxYbW5SIspk7ikkrnaXnsXRqrGl0yk0lojGhQ6vDTLOhFaptkwzicqeinE4bvrtMPBIw8+BXX8u98jn8YFjAG8TeFMW4qLEVj+srULXo/t7HaEsP5pMHZHTGy44TMA5tt5xR5WXXIWBlF/W82Cnne4SCJVoNWyHhA9HHl4OP5XHPWj7H5+c0TV/1Gy1Dju65xGuoBktZiN/iYOxVW4rgPO4QPQ/TuYHiK6Z9IfZ1ogG5Z3Xl1pKMudc40RNd3NjtT1jEGrvyUbFln6tvAk1fNWRwwP2CBzZcmoJcmMiQTqTVBHkKSgtVw+Difzxbwxj8GiqY+eEN53RiwIljtjn/XISpHVvWirlTmE/Rvy8vJuNq/vJriimMxITf71Rfd8FFALGqtyyCz3BisfvS+gX/rFuL/SFfpKL7rw4nbvC9DRBlrVbJlmGxOS1ShqemkYhUjFzP3+BaCiIrdpSw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzU3T2g1RXB2WHg0dXhQdWluN3YrcTVHV2NacTFycWZ6VVhIdkxEaUdrWjFX?=
 =?utf-8?B?dTVCd0o0c2lSaWwybjVNY3RXWWpaWXNCR1B3dDRLN0hvenJLSm1Wc2ZFMEZL?=
 =?utf-8?B?LzhYdHR6NW9rL2NuRStqTmR6Q3NYRUxGdXZ3bkZtYm14bllUTjdFT0dleEx1?=
 =?utf-8?B?SlJjaHA1UHRVRHhLS2E0WWxsbHdsaFN5TmFtVUhMY3FmNVZLc0Q0WnZYNlBs?=
 =?utf-8?B?QXNIYi9tQzRUYU1XYW92NDNhVlVEeExhUmRsWWFiblltQlFteFhoclNOcWsz?=
 =?utf-8?B?Mm5iaGh2RWJUVUlLL1o2eGlFSVhhampOaGlGekorTjFRTEY1U3VrWUw3TXpJ?=
 =?utf-8?B?d1BEbzAyWmczT3JmY1lBNm1CN2piT3hwNExaL05oTXRtcDhac09XR293ZUpM?=
 =?utf-8?B?Qytjb2ozcGcrQml3WDN5YUpsUlRhMDhuMWIrbTRSTXF4TFU3WmVVWVo3OVdo?=
 =?utf-8?B?a2VROWhRbHlMa2hFTGJIcFNWVWIyYllTTDN5a0Uvc2lMU3VQYVFLZ3VrQ3BZ?=
 =?utf-8?B?UVFWVzBubmgvOFIyQ3dtSTc4cXVtcjg0QzlhL1BkTS9aV2RTdC9MblhNNmVQ?=
 =?utf-8?B?anJnNlZCOTVqbzVGRGhsYXlaVmFpSjIxemdZVk4xRllQeWVYVmZXWU1yWWF5?=
 =?utf-8?B?dk4yakI3ZkpjVFNxYTBZUGdWeDRZUVNIdk1IcjB5c21RaGE1SjdrV2QyV0xO?=
 =?utf-8?B?QnpQZm1ibDJndk5XZWRrQ3Z2aGFMbjhEaFVOMGpVMEoxY0R2ME0vSCtsd0Zj?=
 =?utf-8?B?RG1hRHF5WUx6bndLakVEeVVTR2R4eWlCZkUvbGRzVkFtazl6REpyY1BVT1JQ?=
 =?utf-8?B?Z3dpNGJXL3p5elZ0bVBYdDJHUmtmcng2eEVhNWgzTXpXNUlWVWN2ZEtwdTdJ?=
 =?utf-8?B?bEY5UVhBeDBqRlpMY2dtblVhNjJyeEE5MWV4YUhNRzJLS0ZaRzhySHZscVNy?=
 =?utf-8?B?Z3duYjNLSHMybDRCREcweXlLTkRwMHM2dTN6UUtKYzhXN2FEWTdEMUM2WmxQ?=
 =?utf-8?B?WVhuOWh4Ri9JQit5NktyTHlMUmxFQWFZN2ExU1dJV2NVQ0JRNE9UbFlHYmNP?=
 =?utf-8?B?WCtGZG9vNFZzaGc5eEMwT3RHUzVWSWsra1FiMzdnOEdoYUg2eGtTblpMd2Vi?=
 =?utf-8?B?Z3FoWkhzVHpKaVFwczNWMzIvaVdUVjg5U2xuenhDMW9oODEvTUFxb2NLN2Ji?=
 =?utf-8?B?RGlkdWcrSDY2Skp2cTB6ckRoOTlqOTFWSXhNcXdxUi9uYXNlNEJKUXdFMHNU?=
 =?utf-8?B?L25tQjUvMG0vdThSWGlxUzEvUmtsSVZ1R3NuVFZudWZMdXJodzVvdjR2M2hv?=
 =?utf-8?B?dHo5TE5PM1IxZmthQVB2RkNVT3FEakY5MmhWRFJZc2orZTNRZWt0T0JVWFhW?=
 =?utf-8?B?WUFTUlFnOGwySytjTk5zbldibS9EaExYYmdkdTVDSC90aHU4R0Voc2RzdzFG?=
 =?utf-8?B?enhDTjJlcFBTTmZQZytPSXZsVnFtbFdmMHZlSWVzd2M2S3Q0Y2RPRXN6WXJ2?=
 =?utf-8?B?M040WnBuWWNUTEpaMDNEcEx0Z3oxSVlPanJIazdGRXZPbHRITXBtWEd6RU9s?=
 =?utf-8?B?aDZ5Tmo2MndpanFFTXJjbkJoSnorVWEzQlF3c3JIU3pVSVIvTEkyQnkvcGtr?=
 =?utf-8?B?NUpWbUdlT253TzJSeHcrL0RsdVpaTllYNUFJMHBGWDJwTXQrajNoM21DWUhI?=
 =?utf-8?B?WkV3ZlI0Mmt3RHVJY2xLZkJJbGhwQlpQWnAzWUQzTFdYbWhMUjJsOG9PSjlD?=
 =?utf-8?B?MURmalJQOTd5b1lPZ3FhZC9qL001VXdscitkT1BhUGF3QW5QdHp2R1RGTkJO?=
 =?utf-8?B?bWxxZUorK2drNTIwSzBaTEZDc0dQMGZGd2xNZEVyeERjbkplU2llaDRXdXBL?=
 =?utf-8?B?aUJXZVN0Q1dVY2JFejc5d01JOWdLYnFmb3N0T1MraW5HU2tsVjlzL3JRaHRB?=
 =?utf-8?B?Z3Jlemd3OXVjYWFSM0ZIMi9hU1hoeU1PMFBDdlI3RnBYdXluU0hONGRDNG0v?=
 =?utf-8?B?WkZzMy9jM3dEYm11azZPczhXU1FiVWFRdXBaejNPcjd6bzFyemQzVS8zZWNs?=
 =?utf-8?B?U1ZSa0ozclpSc2M3blgxUVYxVm0zVEtqZlBJVVdSeW5vb2VoNk9Qd1ozeEVB?=
 =?utf-8?B?S0RLbVBybmFTVTliaXVqUFd6dHdvOFZyNEdVQTNSSi9waEk4eDZpTnlIczVZ?=
 =?utf-8?B?YUhLc1pmYjc1WVl3Qks0dXY3Vnl0SjR6VGUvcDB1SUlEeWU1K04vODg3SXJa?=
 =?utf-8?B?Qy9BSVJNbEh1a0ZmZnlGOUxBdjd0WXBvZEZzQkM1NTg4V1JQQmNVa2EvV0hK?=
 =?utf-8?B?akE3Q0tXS09xcmtndDNqTHNyVTRRdnRGQ1crTmRhNk9WckttT1FiWmFYNEgz?=
 =?utf-8?Q?oyUhBgrev9TF2cIWQhrO4MEwiyAtAxBnFQvL7AqDjwY4k?=
X-MS-Exchange-AntiSpam-MessageData-1: ZHE6pPVbmGAFfA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a25909-6edb-42c4-52e0-08de83c83e54
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:55:19.7715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkKREbT9syghqNR8Ya0oTpDyRo30huNyvd6JfJvTVKUfxkn6b35SzP0WTZnnLwYld9LDBmZT1YGlfVrAF1uQ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

On Mon Mar 16, 2026 at 9:21 PM JST, Danilo Krummrich wrote:
> (Cc: Gary)
>
> On Mon Mar 16, 2026 at 12:44 PM CET, Eliot Courtney wrote:
>> On Tue Mar 10, 2026 at 7:01 AM JST, Danilo Krummrich wrote:
>>> On Mon Mar 9, 2026 at 10:57 PM CET, Danilo Krummrich wrote:
>>>> On 2/27/2026 1:32 PM, Eliot Courtney wrote:
>>>>> Add general `flush_into_vec` function. Add `flush_into_kvvec`
>>>>> convenience wrapper alongside the existing `flush_into_kvec` function=
.
>>>>> This is generally useful but immediately used for e.g. holding RM
>>>>> control payloads, which can be large (~>=3D20 KiB).
>>>>
>>>> Why not just always use KVVec? It also seems that the KVec variant is =
not used?
>>>
>>> (Besides its single usage in GspSequence, which wouldn't hurt to be a K=
VVec.)
>>>
>>>> If there's no reason for having both, I'd also just call this into_vec=
().
>>
>> I think always using KVVec should be fine, thanks!
>>
>> For the naming, I think `read_to_vec` may be more conventional for this
>> -- `into_vec` implies consuming the object, but if we want to keep the
>> warning in `Cmdq::receive_msg` if not all the data is consumed we need
>> to take &mut self.
>
> I had another look at this and especially how the SBuffer you refer to is=
 used.
> Unfortunately, the underlying code is broken.
>
> driver_read_area() creates a reference to the whole DMA object, including=
 the
> area the GSP might concurrently write to. This is undefined behavior. See=
 also
> commit commit 0073a17b4666 ("gpu: nova-core: gsp: fix UB in DmaGspMem poi=
nter
> accessors"), where I fixed something similar.

We shouldn't be doing that - I think we are limited by the current
CoherentAllocation API though. But IIUC this is something that I/O
projections will allow us to handle properly?

>
> Additionally, even if it would only create a reference to the part of the=
 buffer
> that can be considerd untouched by the GSP and hence suits for creating a
> reference, driver_read_area() and all subsequent callers would still need=
 to be
> unsafe as they would need to promise to not keep the reference alive beyo=
nd GSP
> accessing that memory region again.

This is guaranteed by the inability to update the CPU read pointer for
as long as the slices exists.

To expand a bit: `driver_read_area` returns a slice to the area of the
DMA object that the GSP is guaranteed *not* to write into until the
driver updates the CPU read pointer.

This area is between the CPU read pointer (which signals the next bytes
the CPU has to read, and which the GSP won't cross) and the GSP write
pointer (i.e. the next page to be written by the GSP).

Everything in this zone is data that the GSP has already written but the
driver hasn't read yet at the time of the call.

The CPU read pointer cannot be updated for as long as the returned
slices exist - the slices hold a reference to the `DmaGspMem`, and
updating the read pointer requires a mutable reference to the same
`DmaGspMem`.

Meanwhile, the GSP can keep writing data while the slice exists but that
data will be past the area of the slice, and the GSP will never write
past the CPU read pointer.

So the data in the returned slices is guaranteed to be there at the time
of the call, and immutable for as long as the slices exist. Thus, they
can be provided by a safe method.

Unless we decide to not trust the GSP, but that would be opening a whole
new can of worms.

> I don't want to merge any code that builds on top of this before we have =
sorted
> this out.

If what I have written above is correct, then the fix should simply be
to use I/O projections to create properly-bounded references. Any more
immediate fix would need to be much more intrusive and require a
refactoring that is imho more risky than carrying on for a bit with the
current behavior.
