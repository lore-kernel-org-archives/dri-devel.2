Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99B6CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4716010E5C9;
	Tue,  9 Jun 2026 18:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="oo75oP0G";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC5810E5C9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 18:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxs0v1NzPZlKgoI2EwsfZZNuAbwdtB9+iML7b+dCYFurlNOSI3Y0vgV+QdSqFZFifeeSlrBWm9Gh+Q3TD0cLkDFLTg08EvDT4K/314v62yoZ9obT5BO3N83MV5c+kV+XsPJIUFyvrBiZV+LA0XuXclHXP3d5eHtBaZVBI6DU5ywVTWehpkiDphNEnLQcCUYcv8QM4iP3xd5aG8YqXo6KXzKaa7D6l97dnba5VNz5LHsqcrvRgUGrlRHL6L2FNC2RDWBEHFt8CBp2mLaxqvLy39oQWLR7pNkSIRNhGSDJrhbGejPPrvDlJSnlqzjS7DBmkUV6kKF1FWvDqScAMJrABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2gYKZ8GWdsGTjtfLAtRtiXYRqSSVfBVhYeSRypP/Fs=;
 b=NCJ3Qye4SMpfgDQSYokouTbAYap8dXkptQbutE9oarIvfZYRi1GCy+05PQIP8aFi0EHBDUcqVWVGzcBpkxPSbtN8JFEqAM8zMcNjgXt6xOjomjZwpUoBrhHknOG2mB5Ymc6qJD50Ye9n5UencbxtMwsY7uNoRrvj5E0kTZ8C8HNOp8P3zjWX2URhuZDL3N34Hn/wrAnhVRwCdDMtDCknILMm0u+/PgTpyC+2VoQJWESURrhTWfp0I25bkHp8TINU8eY60gRKan+sH6x9PVIuQ4IbYWs2FheuS3UapTQi1BPZ/pb1pwzOGEV2ptQsVhuXJlzYDHKMlhbGSEWi5RXfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2gYKZ8GWdsGTjtfLAtRtiXYRqSSVfBVhYeSRypP/Fs=;
 b=oo75oP0G18yyqG7WPsTsWvx3X+8e3OIkIVi/tRLeCc4WTgBxikmXv7WF4FZ6ukb0BaHq4LtERcOr0BPScgT8KRA5hqtSqaicdd9s19NUYj8GKxFYybrwiIxcyA3li8yguaRfxbelMX6urdHSzUIckLjE8GFRMp23Y5trAXDBR+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2811.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 18:19:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:19:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 19:19:42 +0100
Message-Id: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Waiman
 Long" <longman@redhat.com>, "Tamir Duberstein" <tamird@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260609142637.373347-1-gary@kernel.org>
 <CANiq72miJLmc2EadxUa+yVZ5T72QuTES4Gz=YVUsNivYvR=wDQ@mail.gmail.com>
In-Reply-To: <CANiq72miJLmc2EadxUa+yVZ5T72QuTES4Gz=YVUsNivYvR=wDQ@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0252.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2811:EE_
X-MS-Office365-Filtering-Correlation-Id: da1e3b0c-814f-49a4-9944-08dec653ae98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: rKhIjfadBpCntIDyI1/1PRTQBmw3etHObGGkLum8sMnRayyngXUBabk9DpYulFh/lm7AmrCEGJrhRO/ZYRC65yQW5LhYFhNMl4iagpbURZXg7zO7st1YJKf5R9VEnw/wA/iqx6vcVKNsv4EzZhgVDAr1JpUwIO6gcfL2oFspLT9hEl1NaCJyoIl5WOUi/PNA6zTD0pkOOr8v5216xyGNyfQmJyIBzTsIKBOENDjEwRS9GcUy+VUdnabj/Fw0NgyJRfG/NWTd3zowex3xtCKi7hKmEFOUdgQ7AmrzNqW4mcCD+ojuCc2fKmhWvSv4P112TP6wk1Qq4kHSaakReoLUNxzsrHf1FETtbQH2ZV3ZX07YeZ33cGRchaavKKbPsJQCX/32kjEk4tyir++dsuh9EyDO+WK7mmU/prTh2sFEIsOZK8YSvvu+fxf7wKYWdtWh27w9ob2UgyOQIPY+ThPhVWLWgmO+dOA7M6jj29JA9epIX4zG1NkL6oVoONHunfw+1iNc6t/FAMv5wug3ywsxIvjfLQphamldOebykD+ZJx8YtQFF+KRRuMZKTI0+als6NioQqHUmS1TCSZOUPf9ZNHo2lvJjiEPC8cbZusn9tszkypgd2XimRy9f+8WZrGVFgo32mYkqupPHEiSxdnplEPOF+kfBitBbXMRc4caknDuiBIL6sVEvNOeqf6DTLLi3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lGNzd1WWozUG1Bd01lbERXcUFrK2g1bjNXeUU2MFM2Tm9BS0lwaENyWHB2?=
 =?utf-8?B?VTBpK0dYRnhmeU1LSDZCN2I1MVlKaUVZdmFidExRb3YzL2UydEJqYk9aQmNj?=
 =?utf-8?B?OXZMWVk2eExFanJwR2FMSm1tSWVxbGd4UHBjM0xTZ0FoMTRHS3UwZzg1czVm?=
 =?utf-8?B?T2JyNGtBT2x1blNjamxSNDhZZmhJVklLZVU0K3JKTFcxK0FQOG5mRWZQWlRB?=
 =?utf-8?B?REV0Y2dkRzZMaTJsbFl4UnNlODJMalNLbnFYZDNoV1ZPWjZ6SkZBOG9lSXlW?=
 =?utf-8?B?ZWJTbndIOHVaZkpraUZhb2JxQmtXcHFTSzRIYXllQWVnK05VL2ZyT3lZY2J5?=
 =?utf-8?B?ZWRHSUVNaTlCZEx5N2FnNlBTZmFrNXFLNTNsSkJaTGpzbWRZV2EzVmlNclho?=
 =?utf-8?B?cDZ0TzBBRElWZVlkT0didzM0T2owUW4yd0QvRUNISElRdXBBSENzNENxWVJp?=
 =?utf-8?B?REtsYkF0cFIyc1dmQ0VBUjVFbUF3a2x6RGhQdktjRThPZXZJc3dLVmRUbUto?=
 =?utf-8?B?RjRIWm9kd0R1empjaWxvM1hTSjMxVjZMYzlxdkVjLzFSWUxrOW02b0tBNy9w?=
 =?utf-8?B?dU9WUUxSTU5LVDNzYjM0N090QVRZaHFjMVNWQWc3SDYwMlRnK2t6NG1oWEFx?=
 =?utf-8?B?V0dUOHFhZFZCdU83VW5DVmQ4bnB2UUovNTdPczlxVlRUYjdnUkJkb0txSXR6?=
 =?utf-8?B?T2dmU0pGQjVSc3lwczBSbVFhUXJwNkNMYXdOcWhkb0UwVmVaMkp0U1p1TWVl?=
 =?utf-8?B?azVIbG9vS05hNmVZbnMvWlBJaFZvN01ycWRheGpKbTE1T0ZMZTkwMmNaZ2Q1?=
 =?utf-8?B?QmdpS2c3QzJnM2RZV3pOWXBUYjlSRGQwQnN6NkpIU0lKNzZwN3pDYzAzaUFx?=
 =?utf-8?B?QzlZRTBDVTN2Z293TDFlQWFEdHlMM0F2eVI3SFpvTGo0aHZQNVptQUtsN04z?=
 =?utf-8?B?ajRrRk8zMU1PbytWR1FHdW9vdmpwc1IvbTBPbWxjSWE4RW9hMmwrL2Zqams1?=
 =?utf-8?B?ZG9ncDhVV3NCYnFxbkZyNXh4OW9HNVFBTWVwUDZwZTF4ZjczbC9JQWloVzY4?=
 =?utf-8?B?ei9HUXNia0o5aHJ3aGNwWFlWSVFSc3AwMnhQNFJmWFgyRlhtQVJOeXFidFUz?=
 =?utf-8?B?bUl6RWFNSGt6enBKd2hBeU5CSUdKZ05JNHYvTmZxNDBzQ0YvNFBXa2swSktn?=
 =?utf-8?B?OWdaQkJxUzcxK1hiUzF1MTJMVU9MOXhIc3B2bGRDMlNqSzByNW1aY0k5amRv?=
 =?utf-8?B?Q3J6cGFWY0pPWHBBT0I5YmdVVDVwSDRmVW9vdkFLdkpDR1l0bmF3R25ZVy9w?=
 =?utf-8?B?ZVRLYUlYTUg3YXp5Tmg0YTFFRWtDdE9vTjQrc1pZdjBXc1hnUzd5bGVjTTlH?=
 =?utf-8?B?YisrdUN5dUt2OFc1TTFBUlNGYWM5VmdQUThCaHc1YVlVM0NTUHJZbnV5TXF2?=
 =?utf-8?B?b0Q2N0lUQzNiTUJEQzFlRkJsdGdqL2hHSWkxNmxuVGRFS3FBOFFlRTJxaVpG?=
 =?utf-8?B?dGZNVTBOU2xZMW4vUFF0bk5PUEFYYldZR2VrbUtGeXoySUJIUzd3SGtMdUJa?=
 =?utf-8?B?ck91Qm1TV0VJTWRaVk9CbjV1K25xMk1xWjBEVGtabHdkSFJoSG51ZGNFLzRw?=
 =?utf-8?B?NHBHR2NuMFptTytYNXNaQ28zOEJFMm9NOFl0NlgrUFlFbzdjU0w1N3NFK1Fi?=
 =?utf-8?B?aEJuUlprdlRRRDh4aEs3VXYwYmFMRG1NQ1o1dDhiT0tYcDR1a2lSTitBYUpS?=
 =?utf-8?B?SzNBZjREcGJNQTUxakpybkFzK1U4U21vQkxzMHBJNndGUmluOGNBL0xEazR0?=
 =?utf-8?B?MjVYaVhBNnBnNFlHeUtKdXdodG14bXEzQUZFNFQ3cmZzM0ZLbDh4SGE0azQ5?=
 =?utf-8?B?ZlVhWTdMN1Ewd1k2aUhpZnR6UDJNNkFJNTJnRXR0WVFQVmJ5YWVrT2IyVDA1?=
 =?utf-8?B?MFF4eDBTc21yS21ZOHpsbUE0Rk9zUFdOWm1rM3d0ZG4xSFUrems2UU5SS1JI?=
 =?utf-8?B?VTdiZDZPWklFK0RqRytwbi9FaEF4UU9wak4vNCtyR2R2RWhHWExPMFJtMWFQ?=
 =?utf-8?B?TFNScVltc2xyTGh0UFFTcEZlMjFYZWlhcmFNRmlWZ3ZXWkRHMENpVnBLc0ps?=
 =?utf-8?B?cWpsNnI5Q3phcFhsRlJXZnZDYUhlcDQrSGdWY2pXSGxVai9nV3EzSEFzcWIx?=
 =?utf-8?B?U1NIWjFkN003Q2ZUMUFyRkVoMlRhaWZZNzNaM3BsVUE3Ry9HM1MyK2xMTm9E?=
 =?utf-8?B?RW1kOExHaGZsODhodTFsb3hSTVcveEZVMWtLSFlvbzFIK1p4UHVFWVo4Zjhi?=
 =?utf-8?Q?BDJFF2sI2pq0jeV0jC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e3b0c-814f-49a4-9944-08dec653ae98
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:19:44.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqA2cKWpP78/+W1Pu5YS/HA8JnrMVXbM7xuaucXMISA12Lo5+sEQHvDPjfBK/wAv3PXnKE6gE/4epR1/fHIZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2811
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

On Tue Jun 9, 2026 at 6:19 PM BST, Miguel Ojeda wrote:
> On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>>
>> This is the remaining unapplied patch from
>> https://lore.kernel.org/rust-for-linux/20260319121653.2975748-1-gary@ker=
nel.org/.
>
> Thanks for rebasing! I had it as "Waiting for apply" in the
> spreadsheet, but this saved me a bit of work.
>
> Quick question below about the prelude...
>
>> +#[doc(no_inline)]
>> +pub use crate::build_assert::{
>> +    build_assert,
>> +    build_error,
>> +    const_assert,
>> +    static_assert, //
>> +};
>
> Did you split this for some reason? I moved the file to a single group
> per crate when I moved the file to the new formatting style, so I was
> wondering if we could keep it non-split. I mean, it may be nicer for
> macros since it allows us to group them, but I hope we don't end up
> with many `use`s again if we go down that road again...

I think I just kept it as is when rebasing. It's file to have them grouped =
in
the crate to.

>
> Or perhaps you did it for the attribute, i.e. it may behave
> differently, but I doubt that is the case? i.e. if `no_inline` somehow
> behaves differently this way.
>
>> rust/kernel/sync/atomic/predefine.rs
>
> In this one you used the prelude, but in the others not -- which is
> fine, we should be using the prelude more (though perhaps it is a
> separate change), but I wonder if there was a reason.

This one is using size_of, align_of, c_void which are all in prelude. Howev=
er it
looks like I forgot to actually remove these imports in the last version, a=
nd I
didn't change it during rebase.

Are you okay with fixing during applying, or do you want me to send a new v=
ersion?

Best,
Gary
