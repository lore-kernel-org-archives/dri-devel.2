Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC35C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49CA10E11B;
	Tue, 25 Aug 2026 01:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmFK3RJg";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB12510E11B;
 Tue, 25 Aug 2026 01:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXmPo95yDSV9OaQ7iHEdzqLXY/i23up6/8L/3n5FTZXFNGfTHC+Hz41BpmIOaM36wCcTJE2rQbOsRGhmw/0fbPulebXB5l6cwuZM32Um9y/Eb8Fa/mAl8KouTFWQwC5tX+hAEBCAMX0zcok567nKQMT+mIBZd2aNykeOVSZqNr8HJSqLW3jt2lAhSscjDotxBBJNA+RebgxSOD41rRRzn/JQlbN5LNH4+XTVX1tSTVdlmWiQ9UAf7xXtahKP1VXNR+ZbJrfJdeKIqP29MTrXkzT0H1BViw/9Pbn0RGBPRKAVJcZlWz9Eud48nENX3Q32RKltrTrFcdWam+dE94O5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spi0pkUb3KmuYwLn3H/WqX2b72vc4/APcqRZ1othxUI=;
 b=nVU2ipi6viAh0ehSGzM1Uslx3iYks+3QkVPYd9/YzAc2Mpi2J9c10nNXHn8bTzoFMj9sIOSk6ziWq+BTgeJbthFM0Tbj6TdTZy6vxgplhK43etmd+Im61aLEM9ZvYCQkR1Vd0B0K1X3LNGpGEDSogVp+4IfYWJ/6KWWRF3nzqcUcHOPzjk41YrACfx5YfWUMPUn/0ucsYo0Da+5QPuPkoGWDMHSsuV9VoTuR5PZk3vU6LX7tZjbRjbldAN6G9d5hG4JfXDcqJunpx0KuIuut2b7fs34hIFKKXEGZcYV0cvr7Ch4p2kFpNMBM1VofrqL2z8E5xeAPYjAdDseeUOqK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spi0pkUb3KmuYwLn3H/WqX2b72vc4/APcqRZ1othxUI=;
 b=BmFK3RJgDFZLWQrnxCHwnWH7UcUnOv6+MZTE+h/b9hbUWB5fjJG4xHSas/zwC+zHnuGliLVGKrZNRv95FY/HPa4ZyX4jWVJnruwJ4JV5XiBmOved8CEE0zGoiU39Em8AMo6iJdBRv+LkEFGRjvk7N1Bwq/WYTFS981WQT7MG+TTcnOjLLHxWwdD6JQFCHfqtHM/F2GeaJOTMM4N1tubCqjrYUVXkeoE6c4q9hukvNssvmThsjEOWamXC+qtSoq6VHzbMv6L2LTIPf4N20xezgUdWOLeGjBl/u/6wnB0WTt8HIH45CZmvLapccQbFqFrSscMia4MpUPlQffzysGJ6BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Tue, 25 Aug 2026 01:52:40 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 01:52:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 10:52:36 +0900
Message-Id: <DKXNDP39VOFP.1W7GDGA2TXSW2@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
 <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
In-Reply-To: <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
X-ClientProxiedBy: TYCP286CA0362.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b15384a-0546-48aa-dee6-08df024b8b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|10070799003|7416014|376014|56012099006|10067099003|6133799003|11063799006|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: QaQwYGIpT6wt0cxTLDmiB1+mHpW94+dspJYWHzwmf6Q0n7hIar5taCa7C3oJj0Lrj4FEdZUP7CN3ldmr1kUSbLeU2HOee/CpejSymj0wIeN25/gGg5eI/w+N6gLNF+awp9ssVgAsad+fGhQ7/zNwVzIiA1DmvMttHSFwItGpqLOKkHNKyKSceC0ylVt1G7u4ypYr0k+L7WrRdmujG3jRyGKHSvLexrjICDgsVBsOg52ZL/F0CgzbvL1nnniDYiU1HKjLm8N8jCrz6HDABEAIWFbpfV2PQFb4oaXpDFmyw4pd1isIpBlmnQ5bV7+qxL3dQYyM2epAivlI1fjvxeE0kUWTBZ8+GB9xCvbbirKeebsJ6MYaOobgs1KL+97y7r8/V0HURVWk8qry/Eg7MPQ0+lP2IQUlHaybNAjwpS1w6lswdlUkFpcWcmJQ2LxW1vvO0erL1Ib9sDN4WfPCUZA0qMU1zJt8mPSyvnf6KjQykbjfcb5HwwCQ8wU0RFPCxnF7ckUaUnqHKOzC5NM1FcRm37BkZQVPEBg4md6WDY+qgE5udpoe8fQfct8oOYJDDky4HBgl5X3Kcm2v7YeKdOU8G/9tJYMLZyLCoxgU8cx5+dikjiZGEIbyAnV4JmvtCAc5+kMhZ+YhSa4g/t1EyzeIID6Qzl6k+sk4RShpZdl3bog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(7416014)(376014)(56012099006)(10067099003)(6133799003)(11063799006)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFc0Z2s5Mmh2R25EaC8yaTB4RVpoQzBNM1ZFTXBnQjhYaXNyU0JWMTJkckFV?=
 =?utf-8?B?ZCtNTFFXRVFPejBCQ0M0aUtjbytMOFB0NlpOVXU1Z3MvL2MrSWZRRzVObVlR?=
 =?utf-8?B?RXVrWmZmbWVDSnArTmZZVHJ6YVQ4bGpqcGlwSnkwRi9PZVZMV2o4VmNMMUFl?=
 =?utf-8?B?eDlpVkVBK0ZSOVJTcmZDaHAxWXZPUTBNVGhYZy9YVmdncE5RS1VXY3dHbjRO?=
 =?utf-8?B?RHpqdWl3bDlKWVN6eHFONUdpbVB4NzBJdHBpc1ZQTjZKS21rOU5rUXZwTlJi?=
 =?utf-8?B?Q3ZlY3Zmd1B0UTJpLy9lVEtNZGJvMUZ2TkVQN2NuUU9hYnoxUm9GdE9oTmIy?=
 =?utf-8?B?UVJIdUFuS0pzSzBpWkRldVQrcGowcXZXY2RKTjFQRlUyQllUcVZJQzAzSkZi?=
 =?utf-8?B?TTJHbDlwY2d0WndLbllQZ0pJQXRZNTNEZHpSZzRHYVFKOGZCY0o3NjZ5aWc5?=
 =?utf-8?B?Q3c3ZVZHenA2ZG1vUEN0cnA4citqRjBKcFdsOFRJWlhKYXE1akRoaUpBZkg2?=
 =?utf-8?B?KzBiVFJzQUhXM0FWSlNNOTdxUm1xMnA4bE56bkloa29OWmJkdERxSXJYMHp0?=
 =?utf-8?B?YTAyby96Z2NyNE1JQ1c3ZWhMajBLTGhGSDk5ODV0Ry9qd1ZSRW5KWnFnNU9r?=
 =?utf-8?B?ZmppRFRUd1lEZytIazdLL09lbHRub0N5UE9paTZRUTFhb0lDeVh0T2RnQzl2?=
 =?utf-8?B?SkRPT3czT2czeFZlVEUwYlptM3pwUnpsd3hObE1YQ09pditWTlM4RWVOa0tx?=
 =?utf-8?B?aURFNk0vdVMwSkx4SXhLQlpRbWdTSnNmc1kvclR5ajB1Tnd6dUc4UUhqRVVJ?=
 =?utf-8?B?bGgyRXUvNXdUQ1MrTU02SkVDc3BFS1orL21SU3cyQmhqVG9SNGFJbTdyVFBv?=
 =?utf-8?B?YUhCcFBZZUh4S0V0TzFhYnNCNHFLMkw5eUJOanF2L3lTdFpZODBqd1JyVFQ4?=
 =?utf-8?B?NHBvRll2Vy9uK2Rod1B2RkV2YmkxSXpXNUo0bmw3NHFOMjFkTDl5S2NOdlFh?=
 =?utf-8?B?NkV1YVVDSCs4NFB2NHczcGJsV3FlSUMwdjJnZHhBY1d5SmZIbHpweGtLWkl6?=
 =?utf-8?B?ZHNzSWxtMkplc0NyaFJEWUtUMERqUWQ5aW5ucEdvVXErN3o3TE51TnFtVFJr?=
 =?utf-8?B?MnE3L0FuYzgwQlJkUHh3aEhvaWIrNjRFWGUreGZIbGhjTlY0YU9BQzQ0Mlp4?=
 =?utf-8?B?Q0s3YkFIdzd4RG5Qd2hpZUtHelI0SUJCMmQ3aUYyMFNOSDZyLzQ3V0tNMnR6?=
 =?utf-8?B?anZ2dlJDV1JBd3RtOFUxV0c0NHRhMENLK1ZIRHhlZzlKcGZlLzdpS2ZqeFFl?=
 =?utf-8?B?aFpwSFJVSDkxeE94NTFXYWFXeFQ2U3h6RFExU3lrUHBUeTBuZEhvckUrZER5?=
 =?utf-8?B?Um9wS3JrNUwwOVRKQU4vNzZabkpHZjBRckJMU3FKNlhNdTFmZjUwVVZ2Qmp1?=
 =?utf-8?B?UUZMSmI2Qk1NY0JvdDFVWExUY3JZV0N2QWhrR09haTJFVGM5VThRbVpBb3Yx?=
 =?utf-8?B?UWtIWi90VGs1aVNJQmZmZ0ZzUmptYTJoWW53cVFIU3l2Ukd2Y2E1Tm1TRFY0?=
 =?utf-8?B?Mm5oZzVJa1NzbHpsV1U3WGRJNWE4VnpQL05qSGgrbVU4L2VmY3BGV1g1ZEJH?=
 =?utf-8?B?Vzgrc3VVbDlhMXFTeFpjbldHdVRVKzVUODhUbUF1QUVqTElwTDJ2NHpoYklp?=
 =?utf-8?B?QVVKZEs4RDdTSmF5elNXOGxMWmlxc2lISmZjSWNGUEVWbngrMUpVM3FPMGVG?=
 =?utf-8?B?RUdualI3OVA3eHlXUEpDTDdPUDRuTDYxK2NoR3pzdFpBZUtMTlpvdlh5RGVi?=
 =?utf-8?B?SHFtVHF5R3FKTkVLOXp2emlBWWhydzM5V0c3Mk9JQ0lyYnczYmpIR3VIeTNC?=
 =?utf-8?B?Yk9XbWErRnRvcVRKdHZZSHdqU2wzN2pDdjdnQWJFbkJ1RmVNcExvRUFtcUZs?=
 =?utf-8?B?eHBiVHl4VnVZcjI3dzl2TVlPVm13eVNDd0hFS2VlazNTR1RrNmFYL3dZY2V2?=
 =?utf-8?B?d3g0MFp3RUNZU0UwUC9iaG1Pd2ZwZFh2bTNnMmZ5cXByckNabi94YzJHL3JE?=
 =?utf-8?B?U2VXdmlEamM3cHlCV1VWT0dWUHBoZU9vWnNpeDdFVmsyL0h0OXJNSGVSQ0VU?=
 =?utf-8?B?SFNPSHBEUkpYbU12T2RRTFZYUCt2bm5UL1dJMnRaT29zbGxxZ3Q2OGRhK21o?=
 =?utf-8?B?SEM3N3BhbXJHeXJYeWgwZGlmOUFmMUtmekl6RnZmd2tqQmRCOU5NOWQ1OWdE?=
 =?utf-8?B?cW9DbTRvUXRlY2NydHVnQUI2T3FNOEVrQnBOVGtTM1YwcFg0WmtvZEY4TVhI?=
 =?utf-8?B?bnRWVnNPdDVKRlpWN3BxM2VWaVF2b2FleCt1anJ3a3RveWRUZXg0c1JHWkVL?=
 =?utf-8?Q?Sdyk/pk+Ud1W25Ts3QCzC5MLOZKgc+XMGZa1K1RVDozZs?=
X-MS-Exchange-AntiSpam-MessageData-1: P9LgIZECSB8XFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b15384a-0546-48aa-dee6-08df024b8b52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 01:52:39.7662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz/xZqei4ey8u//PCcmdq0PNaYMzhsafmw8G1jgAYDtOqsgU+HE3T6yGmQuQSGRXZsKg7fz6qDvJSjkXxl03jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

On Wed Aug 19, 2026 at 8:23 PM JST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
>> +    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags)=
 -> Result<(), E>
>> +    where
>> +        E: From<AllocError>,
>
> This signature rejects impl Init<T, Infallible>, which is the reason why =
we have
> e.g. Box::init() and Box::try_init() with different fallible signatures.
>
> So, if we follow InPlaceInit, it'd be
>
> 	pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) -> R=
esult<(), Error>
> 	where
> 	    Error: From<E>;
>
> and
>
> 	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> 	where
> 	    E: From<AllocError>;
>
> In theory we could also simplify it to
>
> 	pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<=
(), AllocError>
>
> and
>
> 	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> 	where
> 	    E: From<AllocError>,
>
> However, InPlaceInit actually achieves more with the init() and try_init(=
)
> distinction:
>
>   What init() accepts, but try_init() does not accept:
>     - impl Init<T, Infallible>
>     - impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>
>
>   What try_init() accepts, but init() does not accept:
>     - impl Init<T, E> where E: From<AllocError> but NOT Error: From<E>
>
> So, with the simplification we'd technically lose out on the
>
> 	impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>
>
> case.
>
> In any case, init() and try_init() seem a bit mixed up on their purpose
> regarding fallibility and error type strategy, but in order to really cov=
er all
> cases I think it is necessary.

Wow this is quite confusing hey. `push_init` meaning unify all the
errors to Error ("we don't care so much about the exact error type"),
`try_push_init` meaning unify all the errors to Init's E ("we care about
the error from our Init")?

We haven't considered the case where we actually care about both errors,
in which case we'd want to define an enum. Like PushInitError<I, E>
{AllocError(I), InitError(E)}. We can conditionally impl the conversion
to Error. Then we only need push_init(I: Init<T, E>)->PushInitError<I,
E>.

Compared to Gary's unify! proposal which chooses one unified type per
unordered pair (extensible to N types, but the operation isn't
guaranteed to be associative so needs some care) of types, this means we
need to define the error type manually. But it also means callers can do
different things based on the underlying error types and also get the
initializer back if they want.

On a more general note has there been any discussion on error handling
in general? It looks like we often just use Error and collapse things to
errno values. In userspace, per call errors are kinda solved, by e.g.
`thiserror` and `anyhow`. The distinction here feels a bit similar to me
- let callers of kernel APIs (like Vec) get a sum type error
(thiserror-like) and let them decide what to do which is usually
collapse to Error (anyhow-like).

I think it's worth changing push() to take an Init<T> as well. That's a
third signature push(Init<T>)->AllocError? that isn't representable
using push_init(Init<T,E>)->Error? or try_push_init(Init<T,E>)->E?. I
think we'd then just have try_push(I: Init<T, E>)->PushInitError<I, E>
then (ArrayVec can also have this push / try_push pair). I feel this
distinction is a bit easier to understand than push, push_init,
try_push_init.

So concretely, what about just:
- push(&mut self, init: impl Init<T>, flags: Flags) ->
    Result<(), AllocError>
- try_push<I: Init<T, E>, E>(&mut self, init: I, flags: Flags) ->
    Result<(), PushInitError<I, E>>
