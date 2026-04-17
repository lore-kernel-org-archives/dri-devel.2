Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADBEF8E497
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 01:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D608010E056;
	Fri, 17 Apr 2026 01:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HtmNk+YU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAEE10E056
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 01:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4dVHhK5+gY//e6fcUd3gtTCLwXzL328XkWzG7mLMClLpIrRCQDmZOlPu6/9AB7knQTdqFUf+HQd9l+2JMeYFhT5BTvmWwHV0NbKIUebs97ACN9gXzyg5sJrT7903rtQYS72sDx5h0q3xe4LpD+y4VjTFeoZFAHcZ1JQ9N7J8bwHPBtHeVnhhM64RCBME/X3q5Q6Fk5k7ldhdETxycNAUSS9CcqeZ6lYfAfFpaQrixx1/TRCmt8xS59LrjroM6xVX9xUTDiQmB0jmlImmnd6QQOwYqZF+IYnE9ZRPuaxSYDmxmb9hcYnZTU2dZLlG9sveW7toTt93dVXYrewlwID2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqp3ISfyw3CYy5J+px7UIQ7V4HR3IbtnkDlW5klihXs=;
 b=ATE3sIbr6FDLplyy8ywEU+WBOhgVCe97bu81zn1pvWZLiwKGxxSX2zYxQDTWJ9IigEY5e9Kg0IKCH2TO2cAYkEK/B8Dq9cLz32OdqX624cf5bseLUcIJwvQDzXoml7PDQVu5zq/hzVXy5ucHRLBbFmsjGB4SIFBFsN3mvQmtadd6JoUJ03xEoGGIZF5Mr97sU/cC4vGWd/2kvni7ZwTt2AHJqe5UOzU8VTaPx4BckbAukLQA8Cg/YuJbLo7Yp02kresRz5lCCwbXwvw2Hma49ypKaCZ4Mh4ZPGfYFZNOp1RSS9d8CJsB7oBQWrhF8CtbpPCijmoyNwzqYaPXqlFfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqp3ISfyw3CYy5J+px7UIQ7V4HR3IbtnkDlW5klihXs=;
 b=HtmNk+YU03tXV2W1DX2Pg9x3/N9EiqKvyxqHzGP32qk+Ui3/kplCsdce1ORmHKad1gCmSxObI/UZ32j5/R9sIOfcOQyTgp45B/NiyS44QCjwalRc0ZXo14qPbLFURECJjm7Ic9R1CNdmZetCPqgyWnGjvcZXroY9+tjubUiEfrK8b7kw+ujaWaGLU1WT5VEFo9vfUxeRf0xTR04jCHnArt08RmI8CfZCJwlhND7+MNvvdJMVAJ41YPe1OII17TEfHNhflV/meOIWdAIkYKOaBgrI40fR3QYq2QjGaUbsNKL+1oz8VAMoZ9dJnfD8t+m8kNRMeGy8kHHXM3wvnn4kwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 01:33:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 01:33:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 10:33:12 +0900
Message-Id: <DHV1K1097C27.33XRWLMZM6QZA@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
In-Reply-To: <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c33401-ff87-4f8e-2062-08de9c214c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|10070799003|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3/LTOAW4MlPk972C9+YQd6L2yru096Y4FP8FVuR4gvfcy1RMgOAxHD86KhSD/sFv9bdsy8yy7zK0CbCCdQLj1H1MHfq0kxJj8StQ+158NSqj0PJ4AcesFvaQ0yOKDD1bHktX7i2Y64MLUPIIPq6KjhXSPXPtPLLttrfdklF2KEIaS4MIGE5D/OHtlf59no3bm2cMa20Dhe0X1BXneBao0Marzcucl4tIZOYLNtTqZZOUKBr3YfCVNXSpZw3pEGGW8OapgdjfWMQYZPuhMlZ25A2+B9pJF5G8reAYZkKrtp47hwNEaJDuJp7e44X1oORQ8V3TZdDCnnjrpHkYqj1+jhkXCOm3NuCU+D8R5wxuVrOC5j6XAIonn0OQZK1fN9lZl85zU5MH2xjR1WmCV/gmsVxqmugTlghaSrUJzqFRDss+6KgDPZioLcP23osWvdxJ2HjiBXZNkR+/Y6TuU+ux3UlYeXV+yyWlGVoL/evJotXD8SAJhINBj0VkXrppCWFMMNYlDt6VADAoGEXLpU+TMBSWjQIcWkA9iY7zlIcA/UN9Iy4znQ+teAtJzjV9oCa5HTFNEjgVFoEZaLmsJw0bsGb9inR/YEuIeCXl+3GuiYc/yaigWoWu0ggcQ6WIjWQNLlLr6LE6pMl2MP+lHdw/CcUl5WV182L2iUbGTuBZ1wOrqm8izrNpgy8LKgtXceOkeVdDBVDQEaLmI2OO7tyoVtG6nazR+tBa00DVp3LIuBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDV3cDFMd0NXcFhsbzVycW91UG9uVC8yWXpheW9ReG5VNEV5R1pKN1ZuOEkv?=
 =?utf-8?B?QXhIWmZFK2hwRnJVMGFxYzRqQ25OS2xDRlF3QUpYUExQMWJLaVRRTlRVeEhD?=
 =?utf-8?B?bDExZURscEQxV1ZyWkJqY3ZwUUxZTmxqSzJyMTJ3WWx5WkNueW5MMFUzS1g0?=
 =?utf-8?B?dUd5V25lMFBRRFU4aXlDQTExLy9GT3F0SXJoeHhoYncveDZqV09Ja0ZnTWVR?=
 =?utf-8?B?eUN5dVNLc1VFN0NEWWY5WEoxcktQbmd3WGdWS2hLSXR6aGI3UUZFTk5IZGZV?=
 =?utf-8?B?K3I5QlhRNWhtc04rcDNWVnpPUTI3dXlqNUU2aHl4aUY1clFoYjBkakFRQ3pF?=
 =?utf-8?B?c2FXaG5ER1NRc3pZWXg5d1hxU2pncGZnWTYzN1h0d3BKSlBZR1FsdzcxZ0dY?=
 =?utf-8?B?RUpZdDZQYlA2MTJ1aVlRT29VaEJGd1BkbktVQ3RnRVhnUEE1WThzNnFtWFpH?=
 =?utf-8?B?UWxYSGVBUUdocWExY0dkZzJyRmZ2eHpsZUFnQmpYZVpTVWNLdjVwYnVCU3E5?=
 =?utf-8?B?dy9YVEI1K1pvN1NpTVNHUXFUaGlFRXJKcVZkNGRaVnlqTUpBdjhPMGRNdlMy?=
 =?utf-8?B?Z2FuN1N5bHdnU2dWYy9rUUR0b3VTMlVMRkhRZTR3ZUhaVmdPUmtIKzEzWHo5?=
 =?utf-8?B?TFZHZ1RLMXd2ZVRqSEFjRHhrMlduYVNXa2lQVVZqcjBaVDJVUDh2Z1NUVmgy?=
 =?utf-8?B?TCtQWll4Ly9jM2lkbjB2TEJQMjgwZ2RYZmdLL2IxaFZKcXlKeVNTb3JtbG5K?=
 =?utf-8?B?SzRNejlWTGNlcXhoejFIaFV4d0VETGVra0UyejVnbEJxOXM4eHgrSld6akVJ?=
 =?utf-8?B?MzBaZEtrSXJSSWc3TEg0RGs5dmNOZThaN05YWE9MN0tKaTQyRnYyV2tLQ0Ru?=
 =?utf-8?B?b0lkVjQzalR1QzcyOWl2WnRhQVZpc0dPME55VHZWWHNvSDFTeGNRUlVTOU9u?=
 =?utf-8?B?bWVzaDU0cTZUc0NmMGlvYVlJZlh2L0xoZ0dBZVAyZVpPUk1QSU5hM3lLb3J0?=
 =?utf-8?B?cmEwNldYOXRWZGdjaGVrTlJFejRTUVVBa3kzRWRGTE1nL0oxMldmV3E4YVgx?=
 =?utf-8?B?dWkxUWxDUDdFQnRZaEYyZHVQMTdXU1Z6WU9udHpxQ1JjaDBRL0xoUTRlQmxh?=
 =?utf-8?B?T054NG1PbFQzYUZKOEZwNjAyTERpQkxJM0VDNlVSN01Ed0hkZXVUa09sYVhK?=
 =?utf-8?B?MDhoTmkwRXZ5bFRyK3VNcEVzV1luMWMvcnJiUnd3TjRqSTlRWElBQTdtWUI4?=
 =?utf-8?B?dWhZNEdiTjFHQk9hcktMT0RFUDhKa1l4OHlFUjVMY2JXanFNcVlGL1N2K01s?=
 =?utf-8?B?VWU3aWZyYlZMejJKbXVBWWZDYnFVaEhYcVdjL0I4eVdrQ1doYWJtUjl0WkYx?=
 =?utf-8?B?MVJtUE1PUUlRdUJ0SFFUblREdGJDcGV0VzZ0aUNKTk1aOVBGWUUwb21OdkxX?=
 =?utf-8?B?Vms0azI0V1FkTFJqQmVJTHNoYnk3YnVDbVhKQ3dOWlVFNjR4N3AreHhRaE1o?=
 =?utf-8?B?QUhCQVlaakZENXpOMExpd21XdHlsMUlENStMczJqQzRJZ3BNN09ZcHVxaENw?=
 =?utf-8?B?M2gwQmVwNml2cnNjVTVxU0ZpTjIzZWNrQlh5Y2lIRWNxUEVZcFBwdXJGbklF?=
 =?utf-8?B?dkwxeitSVU9aZnFBTTRYVUhiWXVFYTNCTmQ5Z3ZUM0ViN3o1MUhWYmhKU1Bt?=
 =?utf-8?B?dFp5TVlIQUhHN2hzMzdLWlB3NERESVBPYTNQK0VDVmJROGlIeTZidGdiYU03?=
 =?utf-8?B?cUhzbUhPcG9jY2NnMWxhb2NNUFlMblRVQ3oxcGJ5Y0hPTDIwZmlRc0xlYlIr?=
 =?utf-8?B?SSs5Qi8xTExGYUFTakRoMDFlQ0tyUTJuYTd2SGdpalN0OXliUVdHUFdKOGw0?=
 =?utf-8?B?ZXEvQlBWWmx6YVM2SWNMYzZDYjVXRlB4L3BWVEFwZlRuTmRvb3hLUXBkMEFX?=
 =?utf-8?B?cmZTNWhHVURaRmNwdVJxTVBlL0lRRDgwbmNBQkV2c0FZRlZ3eVNxZkJ2SzVx?=
 =?utf-8?B?eE5UM2x4dHlGZGtUcnA5N2IyblJWeHIwSWRTbFpaUnMwWDc2emZGVzdlVkl1?=
 =?utf-8?B?OWJ3NU5yTXlyQ3FoQjR2R1AwTmxHakNlQ0dEbGx0QlQ2Q0t4MUZHRDNBZFQy?=
 =?utf-8?B?Z1piOFRMSXZDWjhzcUhDWVdpcGlYb2ExVERISkJUQkNjeHBnclEvLzQrendK?=
 =?utf-8?B?cDYxakhydER5anVuYk5hWW1tQ01qNkpCR3E1VGIwaGdBYVpFU1RIMEw5Ylpx?=
 =?utf-8?B?NTUzelo3YWxzUFU1cnMvVzVpRjBBMW8vZWxGSGRxVTQrYXZtd1VXMzcxeXJD?=
 =?utf-8?B?aWlOMTBvNHEvSnN6M2x3MVpEc01FdVdHWlMvV0trN0hudUJmZnBUZXZwSlBx?=
 =?utf-8?Q?9QewKlKFEFjQ0VXrKBo1SwvYx0Cnt95axn6yFlOn+Tzqw?=
X-MS-Exchange-AntiSpam-MessageData-1: TryIUx1k6nMdHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c33401-ff87-4f8e-2062-08de9c214c52
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 01:33:16.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoLTzKPxHpap4iXAHC1y1GnFcgQGA0nuoKdPqAogYiLoTC8vd29ZG4wQAwMwMVomtFetkWxnZE8kE/4NKzNHzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

On Fri Apr 17, 2026 at 7:18 AM JST, Danilo Krummrich wrote:
> On Thu Apr 16, 2026 at 1:22 AM CEST, John Hubbard wrote:
>> Can we please put this into your drm-rust-next-staging ASAP? I don't
>> think we have any comments that would really need to hold that up.
>
> I would like to see the first patch being split up and we also need to ag=
ree the
> merge strategy for this series and obtain the corresponding ACKs first.
>
> That said, I'm not a huge fan of the drm-rust-next-staging thing. It star=
ted out
> as part of Alex' (private) process of staging patches he's about to pick =
up
> (which is fine of course).

Yeah, if we added this patch it would then become a mix of "things to
push when drm-rust-next" reopens, and "things NVIDIA depends on but are
not ready yet". For the record I was a bit slow to reply but would have
suggested carrying this patch outside of `drm-rust-next-staging` to not
mix things up.

>
> But now it seems to develop into some semi-official "shadow infrastructur=
e" for
> when the drm-rust tree is closed after -rc6 and during the merge window, =
and
> it's not part of the official drm-rust workflow and other maintainers don=
't have
> oversight of it.
>
> So, in order to not motivate workarounds, starting from the next cycle, t=
he
> drm-rust-next branch will be open for new features at all times.
>
> Consequently, all patches applied to drm-rust-next after -rc6 do not targ=
et the
> upcoming merge window, but the next one.

If that doesn't add any burden to you and Alice, then I think that's a
definitely an improvement to our process.

>
> Fixes for code that is within drm-rust-next and was merged before -rc6 ha=
ve to
> go into drm-rust-next-fixes.
>
> drm-rust-fixes will continue to be the target for fixes for the current -=
rc.
>
> I will update all corresponding documentation in the next days and send a=
nother
> announcement mail, so it is not only this one buried in a thread where no=
 one
> expects it. :)

Appreciate it! Thanks for doing this.
