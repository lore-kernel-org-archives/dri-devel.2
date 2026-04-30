Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B8FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F152610E429;
	Thu, 30 Apr 2026 11:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vGgQ9C0+";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022077.outbound.protection.outlook.com [52.101.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E496010E429;
 Thu, 30 Apr 2026 11:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+6ZtmEo/aFcBTSe5j2kvN46MmpV7rIIoLikGDwDnbOmT/5k5KgdwDX0lAbZ0byqI+foVDQAaPlz3c+XxBPQngiJ439aSLVFytmD9afQhBGOWWou2gcvjFg/zV06A6aWr2A+i1sCcq953PGnk4Cq0Mn0qLdUSCEot3CxkvgcU9BB6nd8PYGcsI9drr4Nb/hr/b0k6Yb/jsFbRgfmDk3AXOjlxLZk7DABGQMLLZEvFA1gfJtxYwD5I5ZcYnwzcqu+yXV0ujxWgMJVjhQvlMWt/2dEVf82k8AJ3819GqXYN8or7eCkbNA1LSEC9/bJ/1j0fBUHdUpIUnvPfvaGtir/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p7CHnyYewfGs2rCmgs3lupW6G/2UtHPejBZiDJGqqE=;
 b=qzFCC8yTjcxhKzwByE3UhLPlhSm2f7W5WIhiwP+VfnjhK25C76M0UgNWaFGyv6Fag7o9Te0RMBweEa1hEfuj7WM/OLDUA6JFXyZDbVULhftDRGl7IvvdZ7eiOK4U8zdf8cG5UsrlCx8cSclVPyJ9QvA3ngA8TCRs0dnjFfN0XwiUztGWl15Ervi7w9indegSmyVEfsw4nOXXYFgEMfuQwmSLyyAJKtKTPH1qENcjqFT/zXPuiOBBtXEyOYrSUsFXB2ltgiViTNaGUF7XlGAoAT0cDRdmPQ3oA80czYgCmyN5kvII9+YD1ypRFIaCp5uelGk3fajEquyQGMaUsX8HaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p7CHnyYewfGs2rCmgs3lupW6G/2UtHPejBZiDJGqqE=;
 b=vGgQ9C0+Z2no8bAuCCYtIzBPtclqFg3tcfBAk9re0PI74evviJXKiWvIlK3xRHWzBxBr+KdnLBJLKudRw0L8nNcMu8GJd1iVfMdqzTgX5PnO3fRisnqjWVJHHumZgjJDIiK2l2ccB523mQQZq9d1SZ21iX3uZAZLdrOw/ymiqB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7531.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:214::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 11:54:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 11:54:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 12:54:05 +0100
Message-Id: <DI6GWHHRIPDV.1R8KJL5AOUG5T@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
 <DI5LLN2V3XCS.34H4CG99N4MPA@nvidia.com>
 <DI5LRCUUKJJW.24ZCQBQYEPPVZ@garyguo.net>
 <DI6G9FSQHM1B.4KGHIQWPC94J@nvidia.com>
In-Reply-To: <DI6G9FSQHM1B.4KGHIQWPC94J@nvidia.com>
X-ClientProxiedBy: LO4P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: f600b1a2-0c3f-4f49-4ab1-08dea6af2e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: RugDp7lQdPlJ6mZmiVQrpF1EAVtMEzhPgypFkWZ7GKXdu0uO1HcGQvAtw6mfISmZk8/0BZLSaxLsPzifWcHonJU6BrmS3J9FCQNjuUA39gRj1o15roJaNb6L+LJ4IoTuvkTt8W06ZFyl1HJYxeHm/cRwsWipGcMIkz671siB/I6w1eS7+DioHdcuGwFNIpozpKJj+g6DemXUUrQQQdI6VQiv3/mgjo2XGvAqmlUvONIpro9kSKfPVt8einH+oQcZgN9K0lCjaDHOqqFK+vj3txA7ieDFm20X9e5oiSLpZ7EHaIYK0H/ulX4bp1sg6nWslR1wUq6F4Z5SCxkoQimoyejB2rtOa2NN35vVsxE4QCWfoFVS7aPu5zUICBxOGajmKeTVzwIi/Np86bC5Qj5f7K1J8/Kq2RT6WZGruWWSmu3xVEUI9thffI94MvMbjXOhNOmceyPeMw0L4OH7XIMO5AR7AORAhzF+iqcig1Mm1po0vnLywHGcoP7WmTl6i9G9Erq4i4U3ya8uysiI1RlrVYNYyWEGFuya5Ytke6MGGyiBtaWHN54cSfoqahB7uRcNR0mmNyFPNlevOen1NykdbPpYOUAMiSYg6QVRbwO3GRc4cMpqpaKeUUHjTB384eolP8ChPBbgGTWsL8kXuI5TWnDJMZmux9Vi62V5GQUVlAi+GSvdtBz81xy8wwTcYiDaM2DzYvoxaIc3oEOv9NnnF4hiOoYRTBKTIq8adHY451Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5mOWQveERGb3NaNmxudDZJdnZ5QzkyanZJMUp6azl6R2tlYnFzOTVIZktl?=
 =?utf-8?B?aDduSjlQT0tlNXdhcVcwVzVQa05ZT2lqUEN6VThSdEhNNDdkdlZVM0pYanox?=
 =?utf-8?B?Q3A3RzJvdXdnUURxUUUyaU43U2JIV3Vsb0RveXhtNERka2dDQVBVUFAyd0tW?=
 =?utf-8?B?VnVuUjg0UTFUMlNMODlQM0ZMbXIwN2NtSC9pbm9mUCs0V2l1T1NDbDFLdE4r?=
 =?utf-8?B?NnRnaEY4MlFWdjVTbnRudlluckN3ZWtnd0IrNFNRZzE1SXZuaWVqNVByT0Fv?=
 =?utf-8?B?QXBGOVdtRkpkZDJKNmRUZ2VwemdlbXoyTGRrQ3hueW53Y0RNQU55ejlHYkxW?=
 =?utf-8?B?YlBKQ3hKT2h6cXZLUU1pNHRkY0lMa1JjM09WYnpGVU5vajZNS0dHOGw3OXl3?=
 =?utf-8?B?UUFQb0RuQVFGUmMrMFVGczdiYTZCeGY5cU5iRzlQSmZPa2FwZkM4aDNGVzQ0?=
 =?utf-8?B?UFZWajY4RUxaVkNhMjdUVjhBZ3RsN2NjNjYyUHZSa3hyNzJGNHFQQWxlb1V1?=
 =?utf-8?B?Mk0xNDg3WXhYbFJxQUFCMW9DNVJxTGJVNkxUQ3c4cGVNUUMySW1pc2hITzM0?=
 =?utf-8?B?RW8yVDdoUUdHeWFSWUJVQzZ4VXRUVDNXZCtaV3RRY0tNbGRxOGFlY1RnU3RY?=
 =?utf-8?B?QytOcmRzczJJNEsrV2pjblEvTGRmS0tQWFkxbkZKMTBTamNSNGJiandaMGtF?=
 =?utf-8?B?eWNZekk0ckdqTjA5OGh4a2RUQ3VQQU9sR3VTOE5la0hDNHI4UDg1VjJXL2Ev?=
 =?utf-8?B?QXBiWkF3c3AxTFZ3VTE0MzhoQ0tPNVVxejV1cGlTSTNKMTMvc1h0a0NrWW1m?=
 =?utf-8?B?bFJpMlZOSWMrQ1BBb1pBczRDUFlhVkVxbmY3UjFXS2I2YVNaeG5lUkdkczZL?=
 =?utf-8?B?NkU4SkRzUUpNcG5aRGVyL253eUxUSWhpbmJzUTYvN2hscTRjaVo2UGdTbFUw?=
 =?utf-8?B?R1VLTXp0M2dlQ1FoaS9XMnd5NlpwYjljVWEzTTJJcnpOMmhEZWNjWG5ab3FY?=
 =?utf-8?B?Y1l6WWg0SlJKQzBRUGhBT2NzdWZQT0tqUEg5OUNGSzV3eWhxazJHVzVGN2Za?=
 =?utf-8?B?MGFLMzA3bGUxWG5NUW1CVmZHd2JsdzNqY3FiRlVSNElBaTBkSlFTdlNZWUdH?=
 =?utf-8?B?R0JoZXlPUXVuaEwyOTgxaCtWV0ZsTXJYbCsvNndaUFZMZ2xRSUVsS3RWOTRM?=
 =?utf-8?B?Vm9aQ0Y4dTFJOWd0dlZZNEhzd2QvZXFYUHJEbHgycDg2NlRkb1orWTBEVXNL?=
 =?utf-8?B?NFR5V3Z0YmpCYitCaCt1anNOVGhUcTFzOEpiZC9LVGErMHVqM0gwR1VMak9F?=
 =?utf-8?B?dTM3ZnVGdGJwSDkrcVMyY01Qb0NaaG9ZT3NjQ3lTa1BpN1N0bzk1SmkwYjdH?=
 =?utf-8?B?bXlGZHJFYUw3TEorb3ZYRWNBRWdQOENQWmU5dHdFWFNMRGduYzdPV2hPWE9D?=
 =?utf-8?B?WVE5MDdRQnBGTHU5ZzF5SUs5WWI2UVBYbTRtcldMYXZ2eUxhRlBuMlZvMEVx?=
 =?utf-8?B?bkEwV1lSYlhnWWYwVTdyTzFNNE5nUXJhOEl6Skd5NHdjU1poNU5MQ3oxd2tS?=
 =?utf-8?B?aW0xU1oraTNSRFJkZUlLdHpORkdYUkFiTVhkZXhISkF6RS83MUZzU2syUWp0?=
 =?utf-8?B?d25XUFJXWjR1SHpvZjUxZDNwT2lzLzRaZDFYSkFvckduVnVraCtRTmIrVVJP?=
 =?utf-8?B?SE45NndKYW5RTmRZS2ErYjgzYVFGMHMzaE9VZDJLWkpZeFczaTZmMVdDZEpp?=
 =?utf-8?B?YldpUEs0WFNYcEdVTDJiUDFIRlNlTUFMSWRRaFBqc0xqZGVNRHRrdnQwSEtq?=
 =?utf-8?B?MEJZYXUwMFMwMWc0RUdBOXNtRDVDVTE1cWh6NWFXYVhSVGJxK0laTHFmV1la?=
 =?utf-8?B?UGc4K3pJUGV3ZDdCb0xwdEZoeHFrUi93NnZtaGoxYXlHWkdiRlRpMWRnazVn?=
 =?utf-8?B?Q0ZaeWN6Y01BMnJONURERmxmZ0JjWWl0MmY5UE12NE55VHd5eTdlUHVQbWV3?=
 =?utf-8?B?OU5SaXh4UnhHSU5zd1dPWGJHZ0IyOWdFTGtvWUxTanR3bE95NlR4RWhGNmpS?=
 =?utf-8?B?UXpNY2ttc0trVzZVcU1ETDFZTFBZZmk1WWhEL3NwNkVTcy9sU3pacjRTYnAy?=
 =?utf-8?B?Zll0a2habEdXekxzYzl0ZExkNXBWNUFwT0JUeHdDQ05uTXBDVjFoSG9xSUdi?=
 =?utf-8?B?aFVIdnFEdWIrOTR1RDFOb01xYnBjb3ZIVk9iV3RXVERJaGJBYW1WZTRmdFpv?=
 =?utf-8?B?TFIreVF1V3BibkNxd2pVWldBdUYzem1pRW1US1N4TFgxWEtQYk5YbXF1MmRt?=
 =?utf-8?B?d1FHWkY1VWwvK0dWZHcrUktTaHNudW13OElsa05tVldoMFRaOHlIUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f600b1a2-0c3f-4f49-4ab1-08dea6af2e2c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:54:05.9774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYYo0geCLOZ/YUqjBEmlcZdrz8VwpixLTXUXrhf0lCDzrYBVSfh7Q9nxWXH314y7QadHqh8Byv0T3po0xt6llA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7531
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

On Thu Apr 30, 2026 at 12:23 PM BST, Alexandre Courbot wrote:
> On Wed Apr 29, 2026 at 8:29 PM JST, Gary Guo wrote:
>> On Wed Apr 29, 2026 at 12:22 PM BST, Alexandre Courbot wrote:
>>> On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
>>>> There have been a few cases where the programmer knows that the indice=
s are
>>>> in bounds but compiler cannot deduce that. This is also
>>>> compiler-version-dependent, so using build indexing here can be
>>>> problematic. On the other hand, it is also not ideal to use the fallib=
le
>>>> variant, as it adds error handling path that is never hit.
>>>>
>>>> Add a new panicking index projection for this scenario. Like all panic=
king
>>>> operations, this should be used carefully only in cases where the user
>>>> knows the index is going to be in bounds, and panicking would indicate
>>>> something is catastrophically wrong.
>>>>
>>>> To signify this, require users to explicitly denote the type of index =
being
>>>> used. The existing two types of index projections also gain the keywor=
ded
>>>> version, which will be the recommended way going forward.
>>>>
>>>> The keyworded syntax also paves the way of perhaps adding more flavors=
 in
>>>> the future, e.g. `unsafe` index projection. However, unless the code i=
s
>>>> extremely performance sensitive and bounds checking cannot be tolerate=
d,
>>>> panicking variant is safer and should be preferred, so it will be left=
 to
>>>> future when demand arises.
>>>
>>> Review nit (no need to respin for this): this patch would probably be
>>> easier to review if the renaming of `index` to `build_index` was split
>>> into its own patch. It would reduce the diff, while also removing the
>>> burden of having to keep in mind that `index` means a different thing
>>> depending on whether the line is removed or added. I've found it a bit
>>> difficult to keep track of this.
>>
>> This'll need a respin anyway (to merge with the IO view series) for patc=
h
>> logistics reason, so I'll make that change.
>>
>>>
>>>>
>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>> ---
>>>>  rust/kernel/dma.rs            |  3 ++
>>>>  rust/kernel/ptr/projection.rs | 98 ++++++++++++++++++++++++++++++++++=
+--------
>>>>  2 files changed, 84 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>>>> index 4995ee5dc689..3e4d44749aaf 100644
>>>> --- a/rust/kernel/dma.rs
>>>> +++ b/rust/kernel/dma.rs
>>>> @@ -1207,6 +1207,9 @@ macro_rules! dma_write {
>>>>      (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D=
> {
>>>>          $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest=
)*])
>>>>      };
>>>> +    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] =
$($rest:tt)*]) =3D> {
>>>> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]=
] [$($rest)*])
>>>> +    };
>>>>      (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*])=
 =3D> {
>>>>          $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($re=
st)*])
>>>>      };
>>>> diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projectio=
n.rs
>>>> index 140ea8e21617..845811795393 100644
>>>> --- a/rust/kernel/ptr/projection.rs
>>>> +++ b/rust/kernel/ptr/projection.rs
>>>> @@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
>>>>  ///
>>>>  /// # Safety
>>>>  ///
>>>> -/// The implementation of `index` and `get` (if [`Some`] is returned)=
 must ensure that, if provided
>>>> -/// input pointer `slice` and returned pointer `output`, then:
>>>> +/// The implementation of `index`, `build_index` and `get` (if [`Some=
`] is returned) must ensure
>>>> +/// that, if provided input pointer `slice` and returned pointer `out=
put`, then:
>>>>  /// - `output` has the same provenance as `slice`;
>>>>  /// - `output.byte_offset_from(slice)` is between 0 to
>>>>  ///   `KnownSize::size(slice) - KnownSize::size(output)`.
>>>>  ///
>>>> -/// This means that if the input pointer is valid, then pointer retur=
ned by `get` or `index` is
>>>> -/// also valid.
>>>> +/// This means that if the input pointer is valid, then pointer retur=
ned by `get`, `index` or
>>>> +/// `build_index` is also valid.
>>>>  #[diagnostic::on_unimplemented(message =3D "`{Self}` cannot be used t=
o index `{T}`")]
>>>>  #[doc(hidden)]
>>>>  pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>>>> @@ -42,9 +42,12 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>>>>      /// Returns an index-projected pointer, if in bounds.
>>>>      fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
>>>> =20
>>>> +    /// Returns an index-projected pointer; panic if out of bounds.
>>>> +    fn index(self, slice: *mut T) -> *mut Self::Output;
>>>
>>> This looks like this could have a default implementation:
>>>
>>>     fn index(self, slice: *mut T) -> *mut Self::Output {
>>>         Self::get(self, slice).unwrap()
>>>     }
>>>
>>> I'm sure there is a good reason for now having this though, so at least
>>> for my education: why not? :)
>>
>> It could, but the implementation is going to be dead code.
>
> Would the generated code from this default implementation be worse than
> the specialized ones you wrote? I'd have expected the compiler to
> optimize things in such a way that they would be equivalent, only with
> less code. Haven't looked at it though.

Panic in bounds checking have the index being included in the part of messa=
ge.
They're also size-optimized by having the panic path outlined. The speciali=
zed
ones can always re-use these outlined code paths. Of course, unwrap also ha=
ve
this optimization, but the message is just a generic "called `Option::unwra=
p()`
on a `None` value").

For the case of built-in indexing (not subslicing), it also has its own MIR
primitive (TerminatorKind::Assert) so the MIR generated is small and more e=
asily
analyzable/optimizable by MIR passes.

Best,
Gary
