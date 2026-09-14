Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B5C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5C310EE27;
	Mon, 14 Sep 2026 13:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="eBI5kn/2";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021117.outbound.protection.outlook.com [52.101.95.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A4210EE27
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngE3QemPJ1zHAgxXFKNwu3kBcMk3MyrL092erhBV23/+Sw+EAvQi+3MGMgmsg+mCHcJD8fn+m3x9Lioa9b4Ur/0xUeGyITYLqpFSoBWHVdAF2nd77raZH9xmDfk1N+taIGi7QL5X10BZ1AoEftPQ3uR9IwWtyDaOWYeXmdk+3hisILfSWIzrBO+918BjS46FtULl8iJVStFxj67IwJUvUD5GTI/OFMT88DzwGA8+51C23MVB3OW3aRaxbUGIlp4U6hd7HIDGXbWFJoaDIHj7EP5H7BrfCIK6cJS88+oHalN/2ran5hp3J5cvcLhfcu0doo4hBNHCqNeKIaaayzaGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B6zwW0pDoAX2j+1ACWzrALCOmcASKRedeCtGZyG7tc=;
 b=ynotGlBX3ycf07+JJhOXPE/poMVBFKXeBTNcL3pPYPLzVJSYa6tnIyMIyLL/TR/86GyZR4mmyZioM9AuiFmuiUzeQ8fF0UPcnQaVO5RNHk3uryWGQvF2BI8QFRaW21QywVNTiT9XOkjAGDvTnY+IGyYn38UwuFjQReEHanVoFVF0RVwcMOEkvNnvPSkmCJeov8er76bYqGGe4O2Ojq1Rsj8bfNLdsgggkfS84PFwZ8JcM9CsYPDuOlH96dQI8CKO/i23srJZNWXyK/pi0aTdb5PoCCsa1AD3+lEgaJkdMN/kOK4BLeXC7SRVFARKRy9wFWSD0NWoda/C3FSuRlww0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B6zwW0pDoAX2j+1ACWzrALCOmcASKRedeCtGZyG7tc=;
 b=eBI5kn/2l7X3OvrKQwScjLY3LTYvOj9evLFzG7HI15s7jQIdDjBhAEhdg5Y1VTMEqTBic63cdvlRP3kQu72BGMOpyaJnN/VD1Uuruckfa0ZzXO5ViwRgR7WVxB7QhPxney50oKbSFR504XsX7Ah0MnFcIpZdzadY5tSv0p7/BIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB3712.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:17:05 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:17:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 14:17:04 +0100
Message-Id: <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Gary Guo" <gary@garyguo.net>
To: "Robin Murphy" <robin.murphy@arm.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Matteo Kloiber" <kernel@matt3o12.de>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
In-Reply-To: <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
X-ClientProxiedBy: LO3P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ce9a61-4756-41fb-7af5-08df12627884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 0xzLNacJkbs2Oh5UcuzSaU+SsjBYGXHlXteto+O38V1QQC1q5pU/MYwOYZT1db1km8ndFSEb27H5gCG2z5z7NWOSa+Pfmry174wAUvRjB5avPx7nS7rHAhlhTXnb9G1C3nED06xT3Rt0T5dA8WoPYupLCdkPKYWyH+FUPDMgxDgrRd5xoraDdOQJ0lPgioZjief/gU6n2c8eRywHrO72KNbbncLHUyAqZQ9fPpbj9VUofy+uRzqzdkUgNlqjN3MO0o3HIbypcyKd3M16nu3LBbvLvm8VsVlCz2VKOip5GCL3Hik+1eWjQqB/fhAe7r0h6ozJg6hXVJfQn3JVvpNOhrgJsjgRKOKpiTmTvHK9Dyr4LwlZHk5oEtbklBZq4Ud+OzuQ91Kbl0PAKmMSKpsW1QH15awfWSy9SZcUT2ncuLLCkcKdBoKFZ1u1l9XrtatqgZz7NAK87k4Kb/vgDm5xt69fJ5DSWd5/+ddO+j/hiyGS3g3HzUbFu7zQ473AMc6TH8b//O2EBoQzoBUDGjAbdRp9iYaAJ68H06JVFXDvQijXfU+LUOGgrL9um74a8chsgmeZ6mzOmgUV8QSPBNQBK3Ep17On84c1n6M4oGqiN1RcURjLsj3Z7EQF6jVVgSWv9R6jHjcu9k47SRLHrUhX9P/1BK8LddMbR/xXr0rNi4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhlM1ZER0haTHNiQlI2MEdjeEZJTDhZSjh3ZDlEZ0NvYmxUVmlyS1pxb0NG?=
 =?utf-8?B?RzlxZXlaUnlnNm5kVE52S0NHVU1OZTRnYnJuTkRXV0hMMXI0emJzUnJNVGpa?=
 =?utf-8?B?UmJ5N08yOUdsWHltdlFmQTJnVzNPYU1wVklqLzh0bUEvTUtONThOMDNXNEtm?=
 =?utf-8?B?Z3RSTE1JcHVjSzFRYnZyUkpqeDBLUUFRdVQ5ZkJYU3laM0ZYRjNZV2hHcGxx?=
 =?utf-8?B?eXBYdWRIa3lqSlpXZnFFTklKQWE3ejZ3QkhKZExES2lkMUZVT0pTRWtFa0cv?=
 =?utf-8?B?NGhPM3hVUm9DR2RrL2x2enJsUGlpUy9adWtYRnY2a1pDRHpYdFhaZlF5ZGd4?=
 =?utf-8?B?YVljNlM3UHBFQkVjOTZyRURpRUV0QTMzUnlFbXhUUHpQNk9SQUh6MmxPaGN5?=
 =?utf-8?B?eUs0dTEvcFJBaDI3aFpjekQvMVlYdmpXYmFmWE1tUTFGL2VVdkR6RlIvcXhr?=
 =?utf-8?B?YmFjZk11UjdlV1FkeldkTWNDUTRvdW1sRTlISGp2Ny9XcU5GQVJMQXVMRndB?=
 =?utf-8?B?OXBRNnRqR1RCTVlSbVlvcE8vaGJPQmtJU0FCTFNZeW1OUVZNaGhGaVMzbnBW?=
 =?utf-8?B?Wkg5ZGFYL21RVXRCZi9HWUdkbGtOcTNaNmxMUDdULzF4M3FidzVBMDNsdzNi?=
 =?utf-8?B?RjRtOVJUUnVVdTBCNk12aXI3Wkg0bU9NMHM3bEtTdzFpS2JmazducEJwV1Iz?=
 =?utf-8?B?L1RVSy93YmtrMzBwdWp1cEVBcnBHbTJWd3JrUm0zYmdTUDZnOVF2TmI1Q01h?=
 =?utf-8?B?dHV6ZnIyckJXeFdxOTJteGJiWm0wRmJTenlvaFBaNk01MTNwa3pVOVJCOHJH?=
 =?utf-8?B?QmNjcklkUnoxMVcwNzhhZHdibGNtYzdrZkhoSWY5QTJhZHFVNkRCdHMxK1py?=
 =?utf-8?B?OXdQbDdhWTgvc1M3L0V1VDc5bGZBb0hrUjZacUdveUtUUEVnZWxjYmdmQjRj?=
 =?utf-8?B?THJHOFRXMmNrZFVabVUxRXdRd2dkdmFjUC8yV3F0b01hSEhMNWttU1N1RGlW?=
 =?utf-8?B?Y282ckRJaFVRdlZNbllyWk1HWkZlNUtDN1JIbTRJVDhzaGxKelJVTTVqMzRL?=
 =?utf-8?B?SXNJeFUvTVZjcHFSeUh6alkwZkFrRVJPK1hUN0JiNUJCbGxnSUJkVXZZNWR1?=
 =?utf-8?B?YjBtQXl2c21EajVMSEZYWkRGcUtaN3Z3ZDdONGJsV2ZCWkNMTlZLMk9laWNY?=
 =?utf-8?B?ZUhuWEErdlFXdXliQUtlaG9wcldaT0xrMjliSE9ldjVJRHJma0phQmJLd3lB?=
 =?utf-8?B?bkVNM0VYSXJnckNtQklpclhpMXErcGloVTExRDlocWhoZkNhMDc0NmorRG9k?=
 =?utf-8?B?a0sxK013bjd6Wm9hNmx2TGJWckw0TitWeUdCL1pXZ1daUnhsNUkyUHEyR3d5?=
 =?utf-8?B?eHB3eVJCQSs0OU4zYXJiMEJIdHFBVmMxSUxISFlOQmxxRitaRk4vVFVtTE05?=
 =?utf-8?B?bFQxNXU1ODhqUmJQUkFTeEF6VFRNNlJjVWRmN2h2d2h2MGdEZzR1TFlFTFNp?=
 =?utf-8?B?Mml6dTBlNkUvalFpaG4zL1QvYmx2ci94YXRiMW5FRXpCT2hoc0hLSGEyQ0hy?=
 =?utf-8?B?ZWw5ZU9kRTIwbFFHb0FwSW93VjJWZHp5ZGVaS1YxWjg3RGY4WEFyTExOSUFw?=
 =?utf-8?B?K0Z2OGx5T1hzMU1xNWREZXBLRHNpQjFFZ1QzQkNNVHRISjBHNjB3ajc4MC81?=
 =?utf-8?B?SW9odW5BdStCOEltZHEybTVPalhCWmc3TXl0U1lnSVgyemFKMEtYUElwY2Yx?=
 =?utf-8?B?dFZZaFI2NzJCcDB0UkFpMHJLdFJsRzFRVjdUcDV2eFp3azJ2cW5La244ZEdk?=
 =?utf-8?B?emRjbXd3RDFVUkh5amZienY4SHpVdFNJNHdWL1k5VWlMVmtYQTZpV2dERFp4?=
 =?utf-8?B?NjlIeWhESlczdWxRTmUxYmR5WFJlRW1oay95dWpjTmYwS1VtNm93YUNLYzFB?=
 =?utf-8?B?MG1mZ2NUYjJFSVZYdFlLZ3EzM251bkJCRXhrUW9uM0dDVGtjc1JYcnJFMkJ3?=
 =?utf-8?B?aWVTU0oxZjJBajRvQkIvd0FYYnh4QzJ0T2ZJNk1WT1RRZ2ZHL3VPM2sySEpB?=
 =?utf-8?B?ZjJSV0htUGlpMUtYZ2xHend6WkRTMUliN2NnNC96NlJ1UjdMTHM0V1o0YWk4?=
 =?utf-8?B?RnpjUU4rNmU4TWM1N3FuRXNMaTRsTzBOQXdlakJ6OWJ6aVJPQlBoamVGMTRn?=
 =?utf-8?B?bEZYdzR3UGdmMnBmUDg1MzUzdXI1RUh1bFV3cTgrcXNaWUNCOHlDV2trTWtG?=
 =?utf-8?B?eis0RkVVcGZwUHBTV054R0FIM3V2TlBYUlphemZLVE43UmVMYmNrS0FIc2VY?=
 =?utf-8?B?R2RwU0pxSlZpSmlXb0dPMGF0ZXlVOW52V0pCWFZqZ01YcmtaVDV1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce9a61-4756-41fb-7af5-08df12627884
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:17:04.9353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naYlezvMFkp+IN7C4s1DvpOz/1P6HGal/BaqmR1u09oIRVZI99OhjVKR07MBmIZVG2vXZ6fR7gujz+xBuOGIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3712
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

On Mon Sep 14, 2026 at 1:17 PM BST, Robin Murphy wrote:
> On 14/09/2026 11:22 am, Gary Guo wrote:
>> On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
>>> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>>>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>>>> It also means that without patch 1, nova-core would split the firmwa=
re
>>>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>>>> something we want to avoid. The correct fix is to make sure that
>>>>>> `dma_set_max_seg_size` is called by the driver, and while we are at =
it
>>>>>> we also want every driver to call `dma_set_mask_and_coherent`. Ideal=
ly
>>>>>> we would use the type system to make sure that both functions are ca=
lled
>>>>>> before any DMA operation can take place (using a safe interface), bu=
t
>>>>>> I'm not quite sure yet how we can do this.
>>>>>
>>>>> This sounds sensible indeed. Should I open a thread regarding that on=
 Zulip?
>>>>
>>>> Probably not necessary, the mailing-list has a larger audience and is
>>>> the right place for this. I expect people will jump in here with their
>>>> thoughts.
>>>
>>> The problem with those is not that they must strictly be called before
>>> allocating DMA memory, but they must not be called concurrently with ot=
her DMA
>>> operations, such as allocating DMA memory, as it would technically be a=
 data
>>> race.
>>=20
>> Do they really have to be called *before* allocating DMA memory, not do =
they
>> just need not be called *concurrent* to DMA memory allocation?
>
> Similar to DMA masks, the segment parameters should be set appropriately=
=20
> before any dma_map_sg() operation. Plus since they likely influence=20
> scatterlist geometry, that means typically they're also going to need to=
=20
> be set before building the scatterlist to be mapped in the first place.

Right, in that case I think we have the following options:

1.  Have setters these being unsafe, with precondition that they must be do=
ne
    before creation of DMA mappings.

2.  Have a `dma_info()` method like Danilo mentioned. However, we cannot ex=
pose
    `&Device<Core<'_>>` inside such callbacks, because otherwise driver wou=
ld be
    able create DMA mappings. This however is too restrictive to be the onl=
y way
    of setting DMA masks, because Nova needs to access the bar before setti=
ng the
    DMA masks.

3.  Use wrapper type instead of generics for typestate. Then, we can expres=
s the
    pattern of typestate transformation (generics cannot do this because we
    always place it behind a reference).

    For example, we can have `Device` to mean `Device<Normal>`, and then ha=
ve
    `Bound<Device>` to mean `Device<Bound>` (both of which are behind a sha=
red
    reference, like today, and `Bound<D>` can deref to `&D`).

    Then, for `Core` typestate, we can instead have

        struct Core<'a, D>(&'a Bound<Device>);

    where it's passed by value. We can then define the DMA setters methods =
to
    operate on `Core` like we did today, but safely. Instead of providing a
    `Deref` impl that turns `&Core<'_, D>` to `&Bound<D>`, we only implemen=
t
    forwarding functions for APIs that can work without DMA configured (e.g=
. PCI
    bar).

    Then, provide a `into_bound()` method which *consumes* `Core<'a, D>` an=
d
    give out `&'a Bound<Device>` (this is why typestate generics cannot wor=
k,
    because `&'a Device<Core<'_>>` is Copy and we cannot represent the owne=
rship
    consumption).

>
> I don't think there's any expectation that they would ever change=20
> *between* different mappings - especially given the underlying hardware=20
> properties they represent - so while that might technically be possible=20
> in the C API if the caller can enforce sufficient ordering, it should be=
=20
> fine to rule it out in the Rust abstraction if that makes things easier=20
> to reason about.
>
> Thanks,
> Robin.
>
>> If it's the former, we can require these to require mutable reference in=
stead,

Correction: this should say "latter".

Best,
Gary

>> so the probe takes `Pin<&'bound mut Device<Core<'_>>>` which still deref=
s to
>> `&'bound Device<Bound>`, but Rust will require the shared reference to n=
ot
>> co-exist with the mutable reference.
>>=20
>> Best,
>> Gary
>>=20


