Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC68C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C9010F22F;
	Fri, 28 Aug 2026 03:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pZIXT7I5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0E410F22F;
 Fri, 28 Aug 2026 03:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU0Y9kjuOZTABDmNSG5A9oIZYQIuRY896q6+RmF0g0QxivGL+jeG6L2+np36bMRPTZBg4wvZ+sUxACzQwVXpMVdAOBYy4BgViWdvQM+uioMBOsZ/vsAGcphFkRtr7fuvTUFl+t28Z85j8L7dF2O9nCFqiJAwTwASCMo34dMexvyHi3Pp+Yk9PCnxZdQN6JkVcl7/BQuTPhb8gl1yCB/Ximn53aLkyew6gOoXMp5RyhyM/Cz5qAxjfd6u1VH6ePuJ6Rs47Dw/IsV8Wone/tCLrA3qfaRnSoJOwrEe/XxT/Es4E7Foi4ZwPzqJHdReya+Z782qtrJQ0Stp4FltGSGSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hxLlvlxT7bBKuQVO3PRsnnbSKYGSngbOO1ALJPJiP8=;
 b=sPpHsViEBmLbjNcrhLqPjYE83d6W8qH1fmLehuT7pEDhBYZAjl/G+LAqb1bG7cktkfVcF2vlm9FpqMFjo0Zcf7FVTYpI9Y3hlXZAZgA5IWPXmi33SrhEHlOv8RxJtCS2DtJPchRjreGkyxRwW+AYln2JfdmKBK9PZ8g5T5y+OJe2FGccZK8eKtZ8z335xJmDS+Q+HkHxN4yhELQkUcQ2clcs4LIdvoMkMKLZEAOk8k3GW8eO1F5ap3ATrqTGg0WtLqZrPuu250t7dPPwIJe8FVM6+AKeGNtLLbgcUOmT2BsbtM0w4abKuxkKTfO6JDyAkRU2xqlTrLgOpAkJJvK14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hxLlvlxT7bBKuQVO3PRsnnbSKYGSngbOO1ALJPJiP8=;
 b=pZIXT7I503Q4gw+O58Xn6GG6dJLJ2s3l/kmTAUkl+cBi9pyuom3gx1p0C+I/nkb4wuuWOx9aBHL8+vkeWQ8IzKai3SCpN1v0SzkoDURjWj4VZV3IWJPimdPMVOABqgDZCZb+bGSmNobqmt6uuWtoRq7iTsf5BrZS/sDuGJ+YUJp0N2THl5ejIz4sltUmf/NAuxxJdf+riRmpqOjtWBSl7mP2MJBLk9Q5lrEnEW8jZ+qnU+elUh17lkSZJgbpWZcp+NdXG3c6xv9R2EXuQ4blQYFqBj9wl2YJ+y8KW8ZzSLY5Dxkzjbn+b/L3nw+lCSRS9hl3Se5W7xLE73p97glraw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 03:40:16 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 03:40:16 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 12:40:13 +0900
Message-Id: <DL09JQ5CRJLA.4Q6OTGU4CMWN@nvidia.com>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>,
 "Burak Emir" <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
 <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
 <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
 <CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com>
 <DL051FB1HOBY.2UC911T3M9AIS@nvidia.com>
In-Reply-To: <DL051FB1HOBY.2UC911T3M9AIS@nvidia.com>
X-ClientProxiedBy: OSTP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3082b9-3450-44e8-a3a6-08df04b61317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jUYmjuCGD6Wwi4xkkpPI8VBb/EBLVLksRWPM+lEfoTKGXUUbF17EYcSmLZJZftgw71SZzbc6gBR/qUBXBylJwAR28rCpln6lXmYq3AOQxeE4xiV3qrG/n/pThT3J2ViebKmAOHtSravbJPHljcVHJm2qgsKojtEpnh35WTdZZ5rzzYsQtCUJtqpqGKOUunaKdFwfWM7wdLYY6+pL2ufpLEIkyOeQEQhT8jZdPgtsQeKzq2etAb+O7e6LDkWY4VYp+Gx6XAxb8v4JWFaScGPEGmrkAWnwB6HpWu+v3M+oZSNCBm4NyHh27hlSYdggNnIDkEXaef2yBny2h+lDQ/CS/s1PohKr5G6SBlFpHceHxOeOppae9OruKyPUbrw4KgAXIK8KBVQTdR49gHCtim8ZsHv9vrdFH2Ftnw2oETyqpWEzCmJl2ABpg04ah9w8t3Tz47oYDm824Eg0S4nD86o8gyOsU7AiCG9a3CbHXE8ArzqSwZvCyur+NhgJsHGeMBuf8qjSFi/VPJe7+je8wHtuYBGOJiOgZW/JX8h/Mtb2uLGvIVPAh1LWoex0AcLdRkZQo0I68XRSzYZUenSCuQ61Sb+v7U5gVM+unOPRp4totZwjD6PABQAFMbC5HOzVucMG3TL9DsFvCvMAZqYdpJq07AX1OvpPHTTGGcTV7q86kPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNEZXpRY04zZ29XLy9XNnFpUVZ0T1JKZldhTXI1SUlsdlozRTd0eHM2VmhY?=
 =?utf-8?B?VXRNaGpSSXNXZENvVUNpanh0V0VudjY1Zlg0QXZpQTM0VVlhR0czZFl5VTFi?=
 =?utf-8?B?UHJEbmd1K3lqUDlkejFiQ2pyZTNVajR4WWlZaHVVVFBOTGlRK1pPelNFaFZr?=
 =?utf-8?B?YXo3alpVNEs2U1FEcnhmRWlSTzBUNW84VEE1VmR5YTI0SFNmWFBZUjFOT3Ir?=
 =?utf-8?B?V2E5TmdxSnlBcDBxcW1iSmJhUldJdjdPV1JlSDArSWpaaFFITFcyL2VxMnpo?=
 =?utf-8?B?SUZkVnRDOHd1ZDNRLzg0eWQvREtRb1F5cUNFeHUwSCtqUEJrODdNSk5zZjdn?=
 =?utf-8?B?MVYwQVA2VWM1TEpJN3JXbW5wUlF2cFBqNjgxQ3EzNzBTMTZJSVR1TG5lWkRo?=
 =?utf-8?B?UXVuWEdUOVBaZUorNWJaV0xuL200VGhRam5HMU4vL21ZdmIyeUZSc3FobWxh?=
 =?utf-8?B?bjNzV0JVRmt0MXRiTnB6YnVjOWs2QlVyM05hRW9KWFpuTUl5SklRSTgwTnNv?=
 =?utf-8?B?ckk4VGQ1b05MMXpXeUNkVlZnRUxlMTh2cm5HNVJaOTNnbzN5RmZsNFU3VnRn?=
 =?utf-8?B?Z1ZGRitXSnZpWG9aK0VNVVRKbUltUGFUOEF2OE1BbXFJRkpiQkN6Q01zSFhS?=
 =?utf-8?B?Mk1QSVhOY1ZnNXRQN3lobm5GREttNFBkQVRPS20ybGpEZytqRnBBSGQ2SHU0?=
 =?utf-8?B?bURoTHBYVW9JN2xHMHhVd0ttVVdXZHhIOVdiY2t5ZDBTZFphaGw1U1o1dDk0?=
 =?utf-8?B?YlQ0NUd2NExQWUVRTWNhZGFJWExnS2F5NTcyTDczaXRMeXEvMkw2NFFOampY?=
 =?utf-8?B?YWZRbmRHczY3ODB0dnNNYzVuRDRiRVRrTWFHS2NuUHNrYSt2TERwVGZTSjBF?=
 =?utf-8?B?SGo2WHdwUkJDVWdUNGp3NGFDTFpadTJqQmYyWlhQL05vL2xjZzRaYU1zN1Rx?=
 =?utf-8?B?RmRQZGZFc1AvVVhPMU5kZXp6RFVIZXdDTjM0Z0lSNDVIZ3hWSzFnTzdWQklC?=
 =?utf-8?B?dzFpN3pXaklYbzhNbXg5bTNhS3lTQkpmWlVJZnozc1owemExN29LbHVTWExC?=
 =?utf-8?B?eGJUU01kUGVWanN5YTNab2dId3A4UGpYbkprYkZFSjJjSzgrZExHb2hFM0I4?=
 =?utf-8?B?ZVZ5Zi9teUp3MG5pS3pqMWxFRVQzSzNLSGc0OEFxZDJ4dHo4VHBtQ000SFQ0?=
 =?utf-8?B?YkdjTnY2WnlHdWdITm52Q3RJc2Z3b2Z4MjduMFI3MVpPWHU0d1dYd1BpcWlj?=
 =?utf-8?B?VG1oZ1QxZU5oTC9Mb29PWXhCRGJrZmc2c2FPRU9TS1R6aE1OWCtjczRtN2dy?=
 =?utf-8?B?LzNXOVBFOXJkRVRrTXg2MmI1ZWMvVlhyNDlZUUdpV1pWbmlsc21obEtFc09H?=
 =?utf-8?B?bVJUUVhFeVB1S1hnLy9ibmtBMUJGMU9JbjFnM3FZdEM1Zi8zcnp2eXBTdjVh?=
 =?utf-8?B?K3dXcDV5dUE2QjRXeW5wd3ZDNGxieWxMc21aNWVxSVIrZ0dMWHpzNDhqamZH?=
 =?utf-8?B?Z2J0ekcxYVExWnNENGswQmhHMmtqOXBERUthUytUNllwNkhWSnZyVW80MHB2?=
 =?utf-8?B?aHpRZm02RWtzbEduell0dnE1ZEJDVlNmbmg3a0VzSUNiSllCK0xmak41S1Bu?=
 =?utf-8?B?cGZkYnBhTkF0dmp2T3hRNW1PRWdmcVBNRklrZW8rZGtxMDBKRllDMnZlbnJs?=
 =?utf-8?B?T3BHL3AwamM4VVZ0c1Q4M1NmM256Rytwc1plZ2YwKzZzVnp1T1RGSVFpUTQ5?=
 =?utf-8?B?REtnQVdXNTVtcStFdUdsVXp2SmtXZzJ2SHE5U2RnS05KRmJPZE1oVi9rQll6?=
 =?utf-8?B?TW9uS1JjeXBHcVlVTGhkNzlzYzJBVVo3VWZsR1lMdVF5Z1ZiaHM2MjIwUjZw?=
 =?utf-8?B?REUwWmNiMzdSNzJDMXAvbFV3YVgybk9lSS81QTlwRjRnNExJK3FpbGRha2hp?=
 =?utf-8?B?VTFHOWV0dVR3eFFNMXplWUMwcnM0THo4TFN0TmhydUZKYk5rSEVHOEYyQVJz?=
 =?utf-8?B?L3RQL0I3R3h5TlpNR1F2NmdZN2pHWVYySFJqTExId0JkR05URnlhUWRDbEhJ?=
 =?utf-8?B?OXJZdlowZXRISEI3SGFpblNlK2pQOHB2U2ZwMjhpK0sxSlhFSW9aZDkxb2Jv?=
 =?utf-8?B?bVdTaDl0aUhPUmlLRnB2Y2ZNcWdCamVRY2tJMXJWei9uemhUSldUbWhTOFZL?=
 =?utf-8?B?bWN1NEowNDB4NVRYQmVGM09qVVVnNE9DUFZabGlyU2krRXVyRXdsWWh6OTZo?=
 =?utf-8?B?VFJYMFFpaFk0OFRtdzE1WEJlclVRT0hQVkYxdHUrVllTNU8vVXhwUlNKZjhZ?=
 =?utf-8?B?ZWZNQ01zbGFiRzM5R0lDcFdWcXRpVW55dTZXVCtLNG5WYUZKNUVVVUwySVJW?=
 =?utf-8?Q?4UQvvbVFi8ZUixbPMJ7K//ytoYoUR2SpA/pFPB+bBTQIn?=
X-MS-Exchange-AntiSpam-MessageData-1: bNJs6HmXUzBYMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3082b9-3450-44e8-a3a6-08df04b61317
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:40:16.2281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lJQN7+Pwtj/uoAp+6KI4ITTqQ91d7WhFB5ZxicBotJtEAGd6uO/CPLEQ/URDleMghPhAvLsxVKKalzNJxKvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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

On Fri Aug 28, 2026 at 9:08 AM JST, Eliot Courtney wrote:
> On Thu Aug 27, 2026 at 11:55 PM JST, Alice Ryhl wrote:
>> On Thu, Aug 27, 2026 at 4:37=E2=80=AFPM Gary Guo <gary@garyguo.net> wrot=
e:
>>>
>>> On Thu Aug 27, 2026 at 3:29 PM BST, Alexandre Courbot wrote:
>>> > On Thu Aug 27, 2026 at 10:48 PM JST, Eliot Courtney wrote:
>>> >> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
>>> >>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>>> >>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>>> >>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>> >>>>>> Currently, using NonZero/Bounded constants is quite verbose. It'=
s
>>> >>>>>> unfortunate because it disincentivizes using it in interface bou=
ndaries.
>>> >>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for =
constant
>>> >>>>>> value) takes a const integer expression and widens it to i128 (a=
t build
>>> >>>>>> time only) before passing it as a const generic value to a new t=
rait
>>> >>>>>> function `FromConst::from_const`. The trait is implemented by No=
nZero,
>>> >>>>>> Bounded, and Alignment and lets values of each be constructed fr=
om
>>> >>>>>> constants without a verbose turbofish syntax. For example,
>>> >>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>> >>>>>>
>>> >>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>> >>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> >>>>>
>>> >>>>> This doesn't work in const context, so I don't think this is a gr=
eat
>>> >>>>> strategy.
>>> >>>>>
>>> >>>>> I would want to use it for cases like this:
>>> >>>>>
>>> >>>>> drivers/android/binder/netlink.rs
>>> >>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_=
REPORT as u8;
>>> >>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_ERROR as c_int;
>>> >>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_CONTEXT as c_int;
>>> >>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::B=
INDER_A_REPORT_FROM_PID as c_int;
>>> >>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::B=
INDER_A_REPORT_FROM_TID as c_int;
>>> >>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_TO_PID as c_int;
>>> >>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_TO_TID as c_int;
>>> >>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::B=
INDER_A_REPORT_IS_REPLY as c_int;
>>> >>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_FLAGS as c_int;
>>> >>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_CODE as c_int;
>>> >>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::=
BINDER_A_REPORT_DATA_SIZE as c_int;
>>> >>>>
>>> >>>> `const_as!` [1] should do the trick for this, provided you don't n=
eed to
>>> >>>> create a const `NonZero`.
>>> >>>>
>>> >>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe=
2@nvidia.com/
>>> >>>
>>> >>> ... but I agree it would be nice to be able to use this in const
>>> >>> context. And there is an overlap with `const_as!` that becomes more
>>> >>> obvious the more I look at it.
>>> >>>
>>> >>> In for a penny, in for a pound of macro code as they say. Since we
>>> >>> agreed on using macros, how about unifying both under the same `cv!=
`
>>> >>> macro, with as many branches as we have types we want to initialize=
 from
>>> >>> a constant value? For instance:
>>> >>>
>>> >>>     // Does what `const_as!` currently does under the hood.
>>> >>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BIND=
ER_CMD_REPORT));
>>> >>>     // Calls `NonZero::new().unwrap()` under the hood.
>>> >>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::ua=
pi::NONZERO_VALUE));
>>> >>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>>> >>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel=
::uapi::SMALL_VALUE));
>>> >>>
>>> >>> I.e. we would have one extra matching arm in `cv!` per type it hand=
les
>>> >>> instead of implementing a trait. The syntax of the macro would look=
 more
>>> >>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have=
 the
>>> >>> limitations of such a semantic dispatch.
>>> >>>
>>> >>> Even the name `const_as!` wasn't really accurate to begin with: wha=
t it
>>> >>> really emulates is a const `try_from`, and we even discussed
>>> >>> implementing it in these terms in the future.
>>> >>>
>>> >>> I'm sure the idea needs more polishing but I think there's somethin=
g to
>>> >>> explore here.
>>> >>
>>> >> Yeah I agree that const_as! is similar and if we had const traits we
>>> >> could fully merge them and have it always work in a const context fo=
r
>>> >> both duties (which are really a const tryfrom as you said).
>>> >>
>>> >> I am not sure about the suggested syntax (e.g.
>>> >> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
>>> >> verbose.
>>> >
>>> > A bit, but what I like is that it looks very close to what you would
>>> > naturally write if you had const traits (minus the unwraps), so you
>>> > don't have to learn a new syntax. As long as it's not *more* verbose
>>> > than natural Rust, I think it's fine.
>>> >
>>> > It also has the benefit of relying less on type inference, i.e. `cv!(=
5)`
>>> > requires the caller to specify the type even with a `let` statement,
>>> > whereas you could do `let v =3D cv!(NonZero::new(5));` and it would w=
ork
>>> > as expected.
>>>
>>> Even with const try_from we'd still want `cv!()` to avoid having to wri=
te
>>>
>>>     const { Type::try_from(...).unwrap() }
>>>
>>> I think having `=3D>` syntax is great because it is a good place to *op=
tionally*
>>> require type annotation.
>>>
>>> For enum repr for example, I think it'd be great that
>>>
>>>     const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT=
);
>>>
>>> would work directly. It might need some tricks, which I have hard time =
coming up
>>> as I'm not feeling very well today, but I'll give it a shot over the we=
ekend...
>>
>> One could potentially define a trait with a MIN and MAX value
>> constant, and then implement cv! like this:
>>
>> 1. Verify that the value lies between MIN and MAX.
>> 2. Cast the value to uNN of the same size as the target type.
>> 3. Transmute the uNN to the target type.
>>
>> Since the trait has no methods, this works in const eval.
>>
>> Alice
>
> Using an associated const by itself appears to work - I tried this which
> is very similar to Alice's suggested approach above:
>
> ```
> macro_rules! const_assert {
>     ($condition:expr $(,$arg:literal)?) =3D> {
>         const { ::core::assert!($condition $(,$arg)?) };
>     };
> }

Any reason this cannot use the `const_assert` already in the kernel
crate?

>
> trait FromConst<const V: i128>: Sized {
>     const VALUE: Self;
> }
>
> macro_rules! cv {
>     (@widen $v:expr) =3D> {{
>         #[allow(unused_comparisons, unused_assignments)]
>         {
>             let v =3D $v;
>             let r =3D v as i128;
>             let mut back =3D v;
>             back =3D r as _;
>
>             ::core::assert!(
>                 back =3D=3D v && (v < 0) =3D=3D (r < 0),
>                 "value cannot be losslessly widened to `i128`"
>             );
>
>             r
>         }
>     }};
>     ($v:expr =3D> $t:ty) =3D> {
>         <$t as FromConst<{ cv!(@widen $v) }>>::VALUE

nit for the actual posting: make sure to fully qualify `cv` when calling
it recursively (and make sure all symbols are fully qualified).

>     };
>     ($v:expr) =3D> {
>         <_ as FromConst<{ cv!(@widen $v) }>>::VALUE
>     };
> }
>
> macro_rules! impl_from_const_int {
>     ($($t:ty)*) =3D> {$(
>         impl<const V: i128> FromConst<V> for $t {
>             const VALUE: Self =3D {
>                 const_assert!(
>                     V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128,
>                     "Constant cannot be represented by the target type."
>                 );
>                 V as $t
>             };
>         }
>
>         impl<const V: i128> FromConst<V> for NonZero<$t> {
>             const VALUE: Self =3D {
>                 const_assert!(
>                     V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128,
>                     "Constant cannot be represented by the underlying typ=
e."
>                 );

Let's also have a `const_assert!(V !=3D 0, ...)` to provide a better
error message than "unwrap on None" if users call this with 0.

>                 NonZero::new(V as $t).unwrap()
>             };
>         }
>     )*};
> }
> impl_from_const_int!(u8 u16 u32 u64 usize i8 i16 i32 i64 isize);
>
> impl<const V: i128> FromConst<V> for Alignment {
>     const VALUE: Self =3D {
>         const_assert!(V > 0 && V <=3D usize::MAX as i128);
>         // The unwrap fails the build if `V` is not a power of two.
>         Alignment::new_checked(V as usize).unwrap()
>     };
> }
>
> const A: u8 =3D cv!(200u32);
> const B: NonZero<u8> =3D cv!(5);
> const C: Alignment =3D cv!(4096);
> const D: u8 =3D cv!(200u32 =3D> u8);
> ```

That looks like it could work! IIUC it even supports something like
`cv!(x =3D> NonZero<u8>)`. The only limitation is see is that this cannot
take expressions using generic parameters, but we can probably work
around that.

I guess you'll want to split this out into its own series so it doesn't
remain hidden within the ranges/bitmap work. Basically as a replacement
for the `const_as` I was driving [1]. I'll recycle the `const_as` series
to just switch to the kernel converters, and will follow-up with using
`cv!` once it lands.

Since this is going to be a multi-cycle effort we should probably keep
the legacy `*_into_*` functions around for now and remove them in
another patch once all users are converted.

[1] https://lore.kernel.org/20260825-const_as-v1-0-1ce712225fe2@nvidia.com
