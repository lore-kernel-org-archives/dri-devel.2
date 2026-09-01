Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1668EC624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131D510EC86;
	Tue,  1 Sep 2026 11:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="x7Ni6JUQ";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021127.outbound.protection.outlook.com [52.101.95.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAB910EC82;
 Tue,  1 Sep 2026 11:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTbaFDrWWznUUHD4+smt5grUes5dt7RZewqDkRp7VeFit3YYvL7mOAOmJsna+lqDz6ILQ9zYEbDNP8Sy1xEi/OmVm3IxGivELIZ9p+3zv3dM5pOMhmbFGW2i08wKV840eEOy+IgXTxKqPJPzTOJu143zVVBydugu3aawB4sAEbCs5gaj/Tq+QYgFyDOkUgMAktAHFBOHP7wvfb37uAo/+4Bd41w0m2D0FTNagBsuPsI4dh6QCpp2YKLce45/IuGydkGkxlMKvmUUxF8ahVWVS3yEdi6d6TttlqGYYFD/tuZwI4geUgphYjmveYGs2b6s+MIbYMpzGvBFbwzxGmcI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaKSf9Q4DqUd1LGU1SuYL6ztMMTRGVUZtO+0x1CGnQs=;
 b=OU2M6XeOkRdc+crPdW2ev/E4ygvG66S5DdNxKG7YXHukip2XpeTVtyQhO6qUITWHnLIlD/Wa2gxec9ENUAMAJm2PtT6wDjDC/mQNUnQ7qIWTQahGjshCqdMrbRKXGB4lfnSMyZiSlF3fuyV/XN1veWl4hZFdC1bIoFE6BGZkc04hOoL3iLtXU0VtP3fJXBjKZ/xPdJB15U1sf+iW4RbaxUY1ZNiyp2VEjwX2Gc06AllmqMc5+hSteBU90lZeXtWIFmgaJFcyDCehs4qG8z414ZTJBgh3UEscj1Mcl8/Oa0BG+ulOLupdbleAzxzgpqN8DKqKpBtFx8Fh31VJTHKcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaKSf9Q4DqUd1LGU1SuYL6ztMMTRGVUZtO+0x1CGnQs=;
 b=x7Ni6JUQAQjoT/lqmmy8Bwnb+RPfc2OCt6wIVosh5u+f8uCjB9FZketYfOCFG2MWH9ZqNXiQcecd3ey7cQ29JkXrJ8Q1y3/AMYEvATXgkUVWKPf5JMA0WokEp85uHGT+mDWt28Nk5WyNszRmAHgtzdr/L6/8TmxNeYW+CKE6bBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7769.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 11:43:18 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:43:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:43:17 +0100
Message-Id: <DL3YBS0UXYMC.1KJEZ9KWV52O8@garyguo.net>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
 <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
 <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
 <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
 <DKX7400TO0RK.1R05PZKS9Q33F@garyguo.net>
 <DKXLSOCZBYYX.1OE2DF4LYRMV5@nvidia.com>
 <DL3AYW5D121E.29D3XI699XMKN@garyguo.net>
 <DL3MXU3NQFLM.21AFT3KWNROVP@nvidia.com>
In-Reply-To: <DL3MXU3NQFLM.21AFT3KWNROVP@nvidia.com>
X-ClientProxiedBy: LO4P123CA0427.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: f06b6882-a0b4-4439-2f9b-08df081e377c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|6133799003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8SDPfb8WTsV3rT21QC4G2y0Ywop/dsxuXaBg1KrQPebltLnmG4zwaQex06b9pT3qJcYfnW7JAgdVEN8934Cklfk2fVTe+e5/4WdoR9HLk69DpJICMGq6NILGwZoElM8NCs5nmk8oOlDWIU6GrsOvvnPzJU+vYq1VpE/WtzNy4dyd7h6BvXc+i+ag4AAov7Vx11AnIAv7w4RRrfn0/LMVV8b9yqlt6w7nQD/hvo2oD2NzCZVqJ6MfspErApsx3bsZx7v2mhTiX7HVJN1OiV7ekecH4HCBf0crkRiP0Es9QM7j6V62Hx0t2tcWmOB7l/UoSsQaSzDp8AcFYRpYEDV6eyXBuSRjksAwbKeQKS2wDU5Grskgx8QObgSv+T1ICqDj+z8w/MM7DTAGjDHkv9wzd8NFRbUgJKwfjrP/J+Ba4o6nf45yxaDya9dJeZ6gyhGNRRrgjZodEQO/kxN72I9dUSwqU8uKc0pj5A6QH9JEXd3xGqn1zrT6DBxAVYARmSKx8Lyg8xDPuCgveUrNybnq/GTelD6e5I2Hx5XgKq10BMjWg6KkuQ+TUxsKjfuqsBQbd2NNctZIVLDaPAMi7rU/v51HLZ6bq8rcTH6X8prLue9ZB/AK9tOemZoHKhaFMamMIQgSxMXN2/8jrDGdjKPoQRjKPn5qiyh3skjMS4zrQRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhDV1pkb0lTU2Y0NjN2dmQvSVRZSnh6YVRTYlNlaFM2QlJYSi9WWXNLbmFB?=
 =?utf-8?B?KzBZbWpzdCtBVzcySU1PVk12OTcwVmFHTXBqQThXQUtZM2tZaTZicXpsN0JV?=
 =?utf-8?B?akpOanRaTlAwalRWYnByMmQxL2hacWNYNTYrdnJ4bXMvMzN6ODM5RUVxQWV3?=
 =?utf-8?B?MlVCaUVYK1BNVSt5SnBCS2Uwc0pFZE1iZUVJVEFhdUZHR1FmWWNNYTZBbTRY?=
 =?utf-8?B?cFdKR0I4VDhDY3JaOWlpZXYrbWEzdHcxMHNLNDBkQ1pzTEJFSUxIdmQ5YzBV?=
 =?utf-8?B?WmhLRS82SzVSQzB1Y01RbUZVeUxXd2hlcmdBZElpWlRXb3l5N01TcXV1eTIy?=
 =?utf-8?B?Y1dKeVYrZ3E2amwyandwVlAva1lYZDgxTjZpUTAyNjVHN3krdTJjdWtRbllr?=
 =?utf-8?B?UEkwNHdZNlo5Tk9vN1hTaTRhSmo2VWNoSThPV2htclpqRzUxTUhpdWFzeGpH?=
 =?utf-8?B?OW9sbFNYcWdGNEpOQ09sVS9Kb1FZWkNqQUsxNmRIYUJhdVpTeUdJajlocFIz?=
 =?utf-8?B?VEZhTlRPVG8rdlZZMHBQRWxMY3B1R0NKZStSNkorbzJXck52RHNkVlRXMGI0?=
 =?utf-8?B?a2Jtb1JzNGJIS1ZvcEV5MWliMEd6cDVWNXIrWW85NjJ0UTdPc2x2YnFKSHhw?=
 =?utf-8?B?eWpmMHVEbjV6Q241cmFtOTI1MmlCYlpjdEFHY3JaeEM3R3piK1hxMFVaemZV?=
 =?utf-8?B?TjBIUEhqcXpwZ3RmS2hyV3NXNGxCV3JEVGhWcHVHeHh0Y2R1ODE1UUpFQU1B?=
 =?utf-8?B?bVZVRnpENmZFSUZKQjVPVDh5SGJndVZqRnliSWVaVEo3Q2Fsb2cxZWk5TklK?=
 =?utf-8?B?TkZVaE9vUWN1aWtyWldwS0dxMjI2Tk5sY1Z4NDNwOG5kVTR4SjE5dklKeDkw?=
 =?utf-8?B?RnRyQmxMeW9oZVBzVUN3SnV2akFMTjR2RUttZzBjeVI0WjEwT1ZoditaRzJw?=
 =?utf-8?B?REpUWFlBOHgzRzR3eDhBWktXTFYrK1FyZVhpZkg5dVc0WWZtVmF1WFhoSGJM?=
 =?utf-8?B?RkxXMVpKUFBsR0RKRlU5S1I1YlVyUlFWV1ZlN1F5SU5EbkUyNVFJakZZMG5P?=
 =?utf-8?B?YWJwMUpEK042VTdwMVI2R212eWQ1WFZPeXAwR3Q0ZTFyTU5helhDTUVuVENM?=
 =?utf-8?B?T0twN0xnM2VZKzdTSnlHemhYODZKTW8rWWs4Y2ZXSTlaQW5iMUpQbjdFeHRp?=
 =?utf-8?B?MTNjWlRRYmxRelFtbE1DTGZYSEErYUkzSE1rbkVqN2RidWhZaGFKUGZtOUoz?=
 =?utf-8?B?NmozbE5ITXdGRTVsNDZSU3UzS2N3TTNxQmRkaktuamFNak84RUsweU5Sdnl1?=
 =?utf-8?B?WVFtSXY4OGlpMnhzenNEaVk5NWRYVGNvLzNwZWU1M2RXRUxGUExBZW5kNkVq?=
 =?utf-8?B?WkVlZU40aVB5M0RFSzlFdlhEWlV6ZXIrNXBldHNteU0raUJKMkRRWG11STB0?=
 =?utf-8?B?d2tIQWVRK3lEbUtWcHRNSy9LNE5ta3ZNazNuekFTeis1di9VQjdlaDhYcEtW?=
 =?utf-8?B?WCtHRmtmTFNpcjlYcXZZNFk2cVNsbSswS2k5WFVwTExlMEcrQlVvdnoweGRG?=
 =?utf-8?B?bnpUWlhYOXo0Um5IMjBJQmJUWC9zbHNOY2JSdE80QXpJWnZocVI0bnA3S0xK?=
 =?utf-8?B?OWhvZkhBUUlEQ1g3d2duWTJZNFp2TGRic2t4NmFYRjFlZVJjcDlVNmtENlhn?=
 =?utf-8?B?UXRrMDZReG5ORUJjVVpRMzFRUTJXMmdxb1BvUDB2cHlIclEvMS9ZcVByWE5P?=
 =?utf-8?B?dUwrbkcrajVUOXdjak1xdysydHA2T1JmRjN0aGFZSVQxaFZuNXl0eWh6NXdP?=
 =?utf-8?B?a1diRlRsbjBQT0NIcG9BRDYraUptZXQyRXV2ZWlGZjRZL0srQVFGclFNZzVl?=
 =?utf-8?B?YjV1YWZZZ1dSSnlRS2VSWG5LRTByS0JCeDY4V0Q0RSt0amt3eDRtQ2FsaXhn?=
 =?utf-8?B?UWs2YlJIeUs4RkZXdCtCV1p5ZHdNcVRBWEt4QVRqUzZjSEppMDZaVThPZ3pN?=
 =?utf-8?B?UUQybjViaGFmdmxoTXRKUEl5ZTFCbU5YYUgrcS8xWVFLRERKZ1NNY1YwRVU2?=
 =?utf-8?B?QkdCVnlDeitXblJMWW5Da3p6c2MwMmdhczhzc0FPYmZqR1JhS3B2T2EzQkVr?=
 =?utf-8?B?Z3N2VXV2VXI3WjlKeUZISFVOZmNON2NwV1dCV3EwNzFObjhBQmVwNnZwMlE1?=
 =?utf-8?B?aEN2TkwzQ2hHZS9oV0JWTmo4TzRGbWhlRzJwelUvZi92Mlp5Q3ZRdEJjLzdM?=
 =?utf-8?B?TEMwL3JEdmtnTUZPaFFodmxaa0V6RlpxTmFNY3ZHdWF4RlVmZm9MTWRyQkdk?=
 =?utf-8?B?dXBFQ1JaRkZ0cFNHQVd3SXgycVBMaEF5UVhNb3d0QmxSQ2pBdjNSZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f06b6882-a0b4-4439-2f9b-08df081e377c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:43:18.3712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FocDriy0S7c5gcpJyacuxxasGLc07wUutpBpkWcSxBjPKMs5sXUFvGCKQ5BKua5cHEcogL5/oR42c6FQa+TKzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7769
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

On Tue Sep 1, 2026 at 3:47 AM BST, Eliot Courtney wrote:
> On Tue Sep 1, 2026 at 2:25 AM JST, Gary Guo wrote:
>> On Tue Aug 25, 2026 at 1:38 AM BST, Eliot Courtney wrote:
>>> On Mon Aug 24, 2026 at 10:07 PM JST, Gary Guo wrote:
>>>> On Mon Aug 24, 2026 at 2:03 PM BST, Eliot Courtney wrote:
>>>>> On Mon Aug 24, 2026 at 9:56 PM JST, Gary Guo wrote:
>>>>>>>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0=
<'_>, command: M) -> Result
>>>>>>>>              dst.header.length(),
>>>>>>>>          );
>>>>>>>> =20
>>>>>>>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_w=
rite_ptr` write after data write.
>>>>>>>> +        dma_mb(Write);
>>>>>>>> +
>>>>>>>
>>>>>>> Is there a reason this can't go into `advance_cpu_write_ptr`?
>>>>>>
>>>>>> I think it's more clear to consider `advance_cpu_write_ptr` to just =
be the
>>>>>> pointer increment, and the ordering should be visible in code that p=
erforms both
>>>>>> memory ops.
>>>>>
>>>>> In the second patch, it looks like you're adding the memory barrier
>>>>> directly in `advance_cpu_read_ptr`. So we'd have one barrier directly=
 in
>>>>> the code advancing the pointer and one not, which seems asymmetric. I
>>>>> think it's less error prone to put the barrier in the function so it
>>>>> can't be misused (and we already have evidence the barriers are easy =
to
>>>>> get wrong, since this code was already broken).
>>>>
>>>> In the second one `message.header.length()` is read, so if I move the =
barrier to
>>>> before the advance it'll be incorrect.
>>>>
>>>> Best,
>>>> Gary
>>>
>>> Yerp I mean move the barrier into `advance_cpu_write_ptr` not move the
>>> barrier out of `advance_cpu_read_ptr` - I agree that'd be incorrect. On
>>> clearness, it feels very odd to me to have these two functions
>>> (advance_cpu_read_ptr, advance_cpu_write_ptr) where one controls the
>>> memory barrier and one doesn't, purely based off the structure of the
>>> callers. And I still think it's less error prone (for future changes) t=
o
>>> do it this way too.
>>
>> Frankly I don't like the asymmetry that the advancing code does the barr=
ier,
>> while the pointer reading code doesn't have the barrier. However, if we =
move the
>> barrier to the pointer read function, then the `driver_write_area_size` =
would
>> gain a unnecessary barrier. (Actually, `driver_read_area` code have a si=
milar
>> issue, a failed pool would execute an unnecessary barrier).
>>
>> As an alternative to move the barrier into the advancing code, alternati=
vely we
>> can pull the `message.header.length()` to a separate line instead.
>>
>> I think we should either always have barrier inside the pointer read/upd=
ate
>> code, or always on the user side. Given the former would mean unnecessar=
y
>> barriers, I am erring on the latter.
>>
>> Best,
>> Gary
>
> I see - so you're saying that one side of the maximally consistent
> position is to put the memory barriers in additionally `gsp_read_ptr`
> and `gsp_write_ptr`, but those don't always need a barrier e.g.
> driver_write_area_size because they are not necessarily followed by an
> access that needs ordering, and the alternative is to have callers of
> those functions handle that responsibility.
>
> I think the differrence is that `advance_cpu_read_ptr` and
> `advance_cpu_write_ptr` definitely need barriers, so why push up that
> one level? Having barriers in `advance_cpu_read_ptr`,
> `advance_cpu_write_ptr`, `driver_read_area`, and `driver_write_area` is
> sufficiently consistent since it's the deepest set of functions that
> can't avoid memory barriers.

To me conceptually it's best to place memory barriers in places in between =
two
operations so it's very clear that it provides ordering between two operati=
ons.
Hiding memory barrier inside a plain access can be confusing.

Alternatively, we can specifiy that the pointer updater have release semant=
ics
and the pointer reader have acquire semantics. This way it's also very clea=
r,
but does introduce unneeded barrier for the polling case as I mentioned. Th=
at
said, given that the polling interval is once a millisecond, extra barrier =
is
okay (full barrier is ~100ns). I do wish we have acquire/release barriers f=
or
these cases, which would be quite much cheaper!

So unless there's an objection, I'll take the second approach by moving bar=
rrier
to pointer accessors/updaters and mark these methods to have acq/rel semant=
ics.

Best,
Gary

>
> If we want to remove unnecessary memory barriers on polling
> `driver_read_area`, we could add an analogous `driver_read_area_size` or
> move the memory barrier for driver_read_area up one level. The poll is
> only once every millisecond though, so I doubt it makes a difference for
> performance. But if we were to change it imo `driver_read_area_size` is
> most consistent.


